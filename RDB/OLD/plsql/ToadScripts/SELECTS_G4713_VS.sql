select 
SELECT * FROM 
FROM         
            tele_order_headers       orh1,
             TELE_STATUS_ORDERS       SAO,
             tele_order_accesories    OAC,
             client                   clt,
             cellulars                clu,
             block_codes              blc,
             market_codes             mkc,
             products                 pro,
             payments                 pay,
             ws_tele_order_ecom       toe

From           Tele_Status_Orders    Sao,
               Tele_Order_Headers    Orh,
               Tele_Order_Accesories Oac,--Tele_Order_Details    Ord,
               Ws_Tele_Order_Ecom    Toe,--Tele_Order_Payments   Orp,
               Payments              Pay,
               Products              Pro

From 
               tmp1                  t1,
               Cellulars             Clu,
               --Accounts              Acc,                     --- PDEC-10533
               Client                Clt,
               Block_Codes           Blc,
               Market_Codes          Mkc