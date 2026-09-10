-- =====================================================
-- Bank Customer Churn Analysis - SQL Queries
-- Database: MySQL
-- Table: bank_churn_customer
-- =====================================================

-- =====================================================
-- BAGIAN 1 — GAMBARAN BESAR
-- =====================================================

-- 1. Churn rate keseluruhan
SELECT
    SUM(status) AS status_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate
FROM bank_churn_customer;

-- 2. Churn rate by Geography
SELECT geography,
    SUM(status) AS status_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate
FROM bank_churn_customer
GROUP BY geography
ORDER BY churn_rate DESC;

-- 3. Churn rate by Gender
SELECT gender,
    SUM(status) AS status_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate
FROM bank_churn_customer
GROUP BY gender
ORDER BY churn_rate DESC;


-- =====================================================
-- BAGIAN 2 — SIAPA YANG PERGI?
-- =====================================================

-- 4. Perbandingan Age, CreditScore, Balance: churn vs. bertahan
SELECT status_nasabah,
    ROUND(AVG(age), 2) AS age_churn,
    ROUND(AVG(credit_score), 2) AS credit_score_churn,
    ROUND(AVG(balance), 2) AS balance_churn
FROM bank_churn_customer
GROUP BY status_nasabah;

-- 5. Churn rate by Age Group
SELECT age_group,
    SUM(status) AS status_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate
FROM bank_churn_customer
GROUP BY age_group
ORDER BY churn_rate DESC;

-- 6. Churn rate: Aktif vs. Tidak Aktif
SELECT status_membership,
    SUM(status) AS jumlah_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate
FROM bank_churn_customer
GROUP BY status_membership;

-- 7. Churn rate: Punya kartu kredit vs. tidak
SELECT credit_card_status,
    SUM(status) AS jumlah_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate,
    ROUND(((COUNT(customer_id) - SUM(status))/COUNT(customer_id))*100, 2) AS retention_rate
FROM bank_churn_customer
GROUP BY credit_card_status;


-- =====================================================
-- BAGIAN 3 — PRODUK & SALDO
-- =====================================================

-- 8. Churn rate by NumOfProducts
SELECT num_of_products,
    SUM(status) AS jumlah_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate_percent
FROM bank_churn_customer
GROUP BY num_of_products
ORDER BY num_of_products ASC;

-- 9. Churn rate: Saldo nol vs. bersaldo
SELECT balance_group,
    SUM(status) AS jumlah_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate_percent
FROM bank_churn_customer
GROUP BY balance_group;

-- 10. Rata-rata Balance & churn rate per Geography
SELECT geography,
    ROUND(AVG(balance)) AS avg_balance,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate_percent
FROM bank_churn_customer
GROUP BY geography;


-- =====================================================
-- BAGIAN 4 — TENURE & LOYALITAS
-- =====================================================

-- 11. Churn rate by Tenure Group (Baru/Menengah/Lama)
SELECT tenure_group,
    SUM(status) AS jumlah_churn,
    COUNT(customer_id) AS total_nasabah,
    ROUND((SUM(status)/COUNT(customer_id))*100, 2) AS churn_rate_percent
FROM bank_churn_customer
GROUP BY tenure_group;
