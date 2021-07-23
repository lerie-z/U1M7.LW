DROP TABLE dim_date;
DROP INDEX idx_dim_date;
/*==============================================================*/
/* Table: dim_date                                              */
/*==============================================================*/
CREATE TABLE dim_date (
   date_id              DATE               NOT NULL,
   year_calendar        NUMBER(4),
   year_days_cnt        NUMBER(3),
   quarter_num          NUMBER(1),
   quarter_days_cnt     NUMBER(3),
   quarter_starts_dt    DATE,
   quarter_ends_dt      DATE,
   month_number         NUMBER(2),
   month_name           VARCHAR(30),
   month_days_cnt       NUMBER(3),
   week_number          NUMBER(2),
   week_end_dt          DATE,
   day_name             VARCHAR(30),
   day_number_week      NUMBER(1),
   day_number_month     NUMBER(2),
   day_number_year      NUMBER(3),
   CONSTRAINT pk_dim_date PRIMARY KEY (date_id)
);
CREATE INDEX idx_dim_date ON dim_date(date_id DESC);


INSERT INTO dim_date 
SELECT 

    TRUNC( sd + rn ), -- date_id    
    to_char( sd + rn, 'YYYY' ), -- year_calendar 
    ( TO_DATE( '12/31/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) + 1, -- year days_cnt
    
    to_char( sd + rn, 'Q' ), --quarter_number
        ( ( CASE
          WHEN to_char( sd + rn, 'Q' ) = 1 THEN
            TO_DATE( '03/31/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN to_char( sd + rn, 'Q' ) = 2 THEN
            TO_DATE( '06/30/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN to_char( sd + rn, 'Q' ) = 3 THEN
            TO_DATE( '09/30/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN to_char( sd + rn, 'Q' ) = 4 THEN
            TO_DATE( '12/31/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
        END ) - TRUNC( sd + rn, 'Q' ) + 1 ), --  quarter_days_cnt
        
    TRUNC( sd + rn, 'Q' ), -- quarter begin_dt
        
        ( CASE
          WHEN to_char( sd + rn, 'Q' ) = 1 THEN
            TO_DATE( '03/31/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN to_char( sd + rn, 'Q' ) = 2 THEN
            TO_DATE( '06/30/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN to_char( sd + rn, 'Q' ) = 3 THEN
            TO_DATE( '09/30/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN to_char( sd + rn, 'Q' ) = 4 THEN
            TO_DATE( '12/31/' || to_char( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
        END ), -- quarter_end_dt
    
            
        to_char( sd + rn, 'MM' ), --month_number
        to_char( sd + rn, 'FMMonth' ), -- month_name
        to_char( last_day( sd + rn ), 'DD' ), -- month_days_cnt
        
        to_char( sd + rn, 'W' ), -- week_number
            ( CASE
                  WHEN to_char( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
                    next_day( sd + rn, 'СУББОТА' )
                  ELSE
                    ( sd + rn )
                END ), -- week_end_date
        
        to_char( sd + rn, 'fmDay' ), -- day_name
        to_char( sd + rn, 'D' ), -- day_number_week
        to_char( sd + rn, 'DD' ), -- day_number_month
        to_char( sd + rn, 'DDD' ) -- day_number_yearth
    
    FROM
  ( 
    SELECT 
      TO_DATE( '12/31/2007', 'MM/DD/YYYY' ) sd,
      ROWNUM rn
    FROM dual
      CONNECT BY LEVEL <= 8000
  );
  
