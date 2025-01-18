select * from banca.cliente;
select * from banca.conto;
select * from banca.tipo_conto;
select * from banca.transazioni;
select * from banca.tipo_transazione;

drop table banca.tmp;
 
CREATE TEMPORARY TABLE banca.tmp AS
SELECT
	cli.id_cliente,
    
    #Customer Age
    ROUND(DATEDIFF(CURRENT_DATE(), cli.data_nascita)/365, 0) AS age,
    
    #Number of incoming and outgoing transactions on all accounts
    SUM(CASE WHEN tran.id_tipo_trans IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_in,
    SUM(CASE WHEN tran.id_tipo_trans NOT IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_out,
    
    
    #Total incoming and outgoing amount transacted on all accounts
    ROUND(SUM(CASE WHEN tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_in,
    ROUND(SUM(CASE WHEN tran.id_tipo_trans NOT IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_out,
    
    #Total number of accounts owned
    COUNT(DISTINCT co.id_tipo_conto) AS n_account,
    
    #Number of accounts owned by type (one indicator for each account type)
    COUNT(DISTINCT CASE WHEN co.id_tipo_conto = 0 THEN 1 END) AS basic_account,
    COUNT(DISTINCT CASE WHEN co.id_tipo_conto = 1 THEN 1 END) AS business_account,
    COUNT(DISTINCT CASE WHEN co.id_tipo_conto = 2 THEN 1 END) AS private_account,
    COUNT(DISTINCT CASE WHEN co.id_tipo_conto = 3 THEN 1 END) AS family_account,
    
    #Number of incoming transactions by account type (one indicator for each account type)
    SUM(CASE WHEN co.id_tipo_conto = 0 AND tran.id_tipo_trans IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_basic_account_in,
    SUM(CASE WHEN co.id_tipo_conto = 1 AND tran.id_tipo_trans IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_business_account_in,
    SUM(CASE WHEN co.id_tipo_conto = 2 AND tran.id_tipo_trans IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_private_account_in,
    SUM(CASE WHEN co.id_tipo_conto = 3 AND tran.id_tipo_trans IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_family_account_in,
    
    #Number of outgoing transactions by account type (one indicator for each account type)
    SUM(CASE WHEN co.id_tipo_conto = 0 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_basic_account_out,
    SUM(CASE WHEN co.id_tipo_conto = 1 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_business_account_out,
    SUM(CASE WHEN co.id_tipo_conto = 2 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_private_account_out,
    SUM(CASE WHEN co.id_tipo_conto = 3 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN 1 ELSE 0 END) AS n_transaction_family_account_out,
    
    #Incoming amount transacted by account type (one indicator for each account type)
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 0 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_basic_account_in,
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 1 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_business_account_in,
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 2 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_private_account_in,
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 3 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_family_account_in,
    
    #Outgoing amount transacted by account type (one indicator for each account type).
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 0 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_basic_account_out,
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 1 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_business_account_out,
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 2 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_private_account_out,
    ROUND(SUM(CASE WHEN co.id_tipo_conto = 3 AND tran.id_tipo_trans NOT IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS total_amount_family_account_out
        
FROM 
    banca.cliente cli
    LEFT JOIN banca.conto co ON cli.id_cliente = co.id_cliente
    LEFT JOIN banca.transazioni tran ON co.id_conto = tran.id_conto
    LEFT join banca.tipo_transazione tipo_tran ON tran.id_tipo_trans = tipo_tran.id_tipo_transazione
GROUP BY cli.id_cliente, cli.data_nascita;

select * from banca.tmp;