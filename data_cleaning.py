import pandas as pd
import os

# Mendefinisikan path dulu
path = r'D:\DATA\Bank+Customer+Churn\Bank_Churn.csv'

# Membaca filenya
df = pd.read_csv(path, sep=';')

# Head
print(df.head(5))

# Overall structure use info
print(df.info())

# Overall Describe untuk meringkas statistik
print(df.describe())

# Overall Null
print(df.isnull().sum())

# Perbaiki nama kolom (kapital dan spasi diganti underscore)
df.columns = df.columns.str.lower()
df.columns = df.columns.str.strip()
df = df.rename(columns={
    'customerid': 'customer_id',
    'creditscore': 'credit_score',
    'numofproducts': 'num_of_products',
    'hascrcard': 'has_cr_card',
    'isactivemember': 'is_active_member',
    'estimatedsalary': 'estimated_salary',
    'exited': 'status'
})
print(df.info())


# Menambahkan kategori umur berdasarkan kuartil
# Rentang usia (hasil qcut, q=4):
#   Young Adult : 18-32 tahun
#   Adult       : 33-37 tahun
#   Middle-Age  : 38-44 tahun
#   Senior      : 45-92 tahun
labels = ['Young Adult', 'Adult', 'Middle-Age', 'Senior']
df['age_group'] = pd.qcut(df['age'], q=4, labels=labels)
df['age_group'] = df['age_group'].astype(str)
print(pd.qcut(df['age'], q=4).value_counts())


# Kategori tenure
# baru     : 0-2 tahun
# menengah : 3-6 tahun
# lama     : >=7 tahun
def kat_tenure(tahun):
    if tahun <= 2:
        return 'baru'
    elif tahun <= 6:
        return 'menengah'
    else:
        return 'lama'


df['tenure_group'] = df['tenure'].apply(kat_tenure)
print(df['tenure_group'].value_counts())


# Kategori credit score
def kat_credit_score(scores):
    if scores <= 579:
        return 'buruk'
    elif scores <= 669:
        return 'cukup'
    elif scores <= 739:
        return 'baik'
    else:
        return 'sangat baik'


df['credit_score_group'] = df['credit_score'].apply(kat_credit_score)
print(df['credit_score_group'].value_counts())


# Segmentasi kolom balance
def kat_balance(saldo):
    if saldo <= 0:
        return 'saldo nol'
    else:
        return 'bersaldo'


df['balance_group'] = df['balance'].apply(kat_balance)
print(df['balance_group'].value_counts())


# Mengubah 0 dan 1 dalam kolom has_cr_card, is_active_member, status
df['credit_card_status'] = df['has_cr_card'].map({0: 'tidak', 1: 'ya'})
print(df['credit_card_status'].value_counts())

df['status_membership'] = df['is_active_member'].map({0: 'tidak aktif', 1: 'aktif'})
print(df['status_membership'].value_counts())

df['status_nasabah'] = df['status'].map({0: 'masih bertahan', 1: 'sudah keluar'})
print(df['status_nasabah'].value_counts())


# Import ke MySQL
from sqlalchemy import create_engine

# Kredensial database diambil dari environment variable,
# JANGAN hardcode password langsung di kode (risiko keamanan).
# Set environment variable ini di sistem kamu sebelum menjalankan script:
#   DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME
db_user = os.getenv('DB_USER', 'root')
db_password = os.getenv('DB_PASSWORD')
db_host = os.getenv('DB_HOST', 'localhost')
db_port = os.getenv('DB_PORT', '3306')
db_name = os.getenv('DB_NAME', 'bank_churn_db')

engine = create_engine(
    f"mysql+pymysql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
)

nama_tabel = 'bank_churn_customer'
df.to_sql(
    name=nama_tabel,
    con=engine,
    if_exists='replace',
    index=False
)

print(f"Data berhasil dikirim ke tabel '{nama_tabel}' di database '{db_name}'!")
