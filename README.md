# Analisis Churn Nasabah Bank
Analisi churn bertujuan untuk mengidentifikasi pola churn nasabah bank. Project ini menggunakan Python untuk membersihkan data, SQL untuk menganalisis data dan PowerBi sebagai tools visual dashboard.

​-- **Daftar Isi**
- [Latar Belakang](#latar-belakang)
- [Pertanyaan](#pertanyaan)
- [Dataset](#dataset)
- [Tools](#tools)
- [Data Cleaning Python](#data-cleaning-python)
- [Key Findings](#key-findings)
- [Rekomendasi](#rekomendasi)
- [Dashboard](#dashboard)

## **Latar Belakang**

Bank kehilangan sejumlah nasabah tanpa pemahaman jelas mengenai hal tersebut. Project ini disusun untuk menjawab kebutuhan tersebut lewat pendekatan berbasis data mulai dari eksplorasi data mentah, kategorisasi profil nasabah, hingga dashboard yang siap digunakan tim retensi untuk pengambilan keputusan.

## **Pertanyaan** 

1. Berapa churn rate keseluruhan, dan bagaimana persebarannya per segmen (Geography, Gender, Age, dll.)?
2. Bagaimana profil nasabah yang paling berisiko churn?
3. Apakah jumlah produk, saldo, dan tenure berhubungan dengan risiko churn?
4. Insight apa yang bisa dirangkum menjadi dashboard interaktif untuk mendukung keputusan tim retensi?

## **Dataset**

Sumber : https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn

Data Cleaning & Kategorisasi (Python)

Script ini membersihkan data mentah, membuat kategorisasi custom 
(age group, tenure group, credit score group), dan load hasil 
cleaning ke MySQL menggunakan SQLAlchemy. [Lihat kode lengkap](data_cleaning.py)

Query Analisis (SQL)

14 query SQL yang menjawab pertanyaan bisnis di atas — mencakup 
churn rate breakdown per geography, gender, age group, tenure, 
dan jumlah produk. [Lihat kode lengkap](data_analisis.sql)

Kolom : 
| Kolom | Deskripsi | 
| :--- | :---: |
| Customer Id | Identitas unik (ID) nasabah |
| Surname | Nama belakang |
| Credit Score | skor kredit nasabah|
| Geography | Wilayah |
| Gender | Jenis Kelamin |
| Age | Umur |
| Tenure | Lama Menjadi Nasabah |
| Balance | Saldo |
| Num Of Products | Jumlah Produk yang dipakai |
| Has Cr Card | Kepemilikan Kartu Kredit (0 = Tidak Memiliki, 1 = Memiliki kartu kredit) |
| Is Active Member | Status Keaktifan (0 = Tidak Aktif , 1 = = Aktif) |
| Estimated Salary | Estimasi Gaji Nasabah |
| Exited | Status Beralih / Churn (0 = Bertahan , 1 = Beralih)


## **Tools**
| Tahap |	Tools |
| :--- | :---: |
| Data Cleaning	|Python (pandas)|
| Analisis Data |	MySQL |
| Visualisasi	| Power BI |


## **Data Cleaning (Python)**

- Standardisasi nama kolom (lowercase, snake_case)
- Kategorisasi umur ke dalam 4 kelompok kuartil (`pd.qcut`): Young Adult, Adult, Middle-Age, Senior
    - **Young Adult** : 18 - 32
    - **Adult** : 33 - 37
    - **Middle-Age** : 38 - 44
    - **Senior** : 45 - 92
- Kategorisasi tenure menjadi 3 kelompok custom:
    - **Baru**: 0–2 tahun
    - **Menengah**: 3–6 tahun
    - **Lama**: ≥7 tahun
- Kategorisasi credit score:
    - **Buruk** (≤579)
    - **Cukup** (580–669)
    - **Baik** (670–739)
    - **Sangat Baik** (≥740)
- Kategorisasi saldo: saldo nol vs. bersaldo
- Konversi kolom biner (Has Cr Card, Is Active Member, Exited) menjadi label deskriptif
- Load data hasil cleaning ke MySQL menggunakan SQLAlchemy

## **Key Findings**
- Jumlah nasabah yang beralih ada 2037 orang dari 10.000 orang. Rasio churn = 20,37%
- Rata-rata usia nasabah yang churn adalah 45 tahun — usia ini tepat berada di ambang kategori Senior (45-92 tahun), yang memang mencatat churn rate tertinggi (44.62%) di antara semua age group.
- Dalam kategori negara, Jerman dengan rasio 32,44% memiliki Churn rate paling tinggi dibandingkan dengan Prancis (16,15%) dan Spanyol (16,67%). Selain itu Jerman juga menunjukkan rata - rata saldo yang jauh lebih besar (119.730) dari kedua negara lainnya
- Pada status keanggotaan menujukkan bahwa anggota yang tidak aktif jauh lebih rentan untuk beralih (26,85%) sedangkan anggota yang aktif berkisar (14,27%). Lalu apda kategori saldo, tingkat Churn lebih besar pada nasabah yang memiliki saldo (24,08%). 
- Jumlah produk paling ideal yaitu 2 dengan rasio (7,58%), karena churn rate jauh lebih rendah dibandingkan kategori jumlah produk lainnya. meskipun begitu kategori jumlah rasio 3 dan 4 memerlukan data tambahan karena total nasabahnya relatif kecil (266 dan 60)
- Jika dilihat dari komposisi gender, churn rate terjadi lebih tinggi pada perempuan, di Jerman angka rasio churn mencapai 37,55% untuk perempuan sedangkan laki - laki yaitu 27,81%


## **Rekomendasi**

1. Kategori umur yang paling rentan churn yaitu Senior (45 - 92). Pada usia tersebut kecenderungan untuk memetakan keuangan saat pensiun akan tinggi, sehingga bank diharapkan memiliki layanan pensiunan yang menarik dan memberikan manfaat yang cukup agar rasio churn di kategori usia senior dapat menurun.
2. Jerman merupakan negara dengan rasio yang tinggi. Perlu data tambahan dan pemahaman rasio tersebut tinggi. Butuh evaluasi terhadap layanan di jerman apakah dapat memenuhi kebutuhan nasabah atau tidak, selain itu juga butuh data tambah mengenai kondisi ekonomi negara tersebut.
3. Pada kategori status keanggotaan, anggota yang tidak aktif mengalami churn yang lebih tinggi. ini menunjukkan bahwa hubungan nasabah dan bank berperan penting, bank dapat menguji layanan terkait reward, point atau cashback untuk setiap transaksi
4. Perlu penelusuran lebih lanjut mengenai churn rate pada gender, dalam hal ini rasio perempuan jauh lebih tinggi. Perlu dilihat lagi apakah ada layanan - layanan yang dirasa merugikan perempuan



## **Dashboard**

<img width="1652" height="914" alt="image" src="https://github.com/user-attachments/assets/b9522cd1-6c9f-47df-a0b4-d6a3f6e21ecc" />



