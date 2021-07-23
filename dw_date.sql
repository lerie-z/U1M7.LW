ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_day;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_week;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_month;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_quarter;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_year;
       
DROP TABLE u_dw_calendar.dw_date CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: u_dw_calendar.dw_date                                             */
/*==============================================================*/
CREATE TABLE u_dw_calendar.dw_date 
(
    date_id              NUMBER(22,0)          NOT NULL
   ,day_id               NUMBER(22,0)
   ,week_id              NUMBER(22,0)
   ,year_id              NUMBER(22,0)
   ,month_id             NUMBER(22,0)
   ,quarter_id           NUMBER(22,0)
   ,CONSTRAINT "pk_u_dw_calendar.dw_date" PRIMARY KEY (date_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_days                                           */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_days 
(
    day_id               NUMBER(22,0)          NOT NULL
   ,day_name             VARCHAR(30)
   ,day_number_week      NUMBER(1)
   ,day_number_month     NUMBER(2)
   ,day_number_year      NUMBER(3)
   ,CONSTRAINT "pk_u_dw_calendar.t_days" PRIMARY KEY (day_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_weeks                                          */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_weeks 
(
    week_id              NUMBER(22,0)          NOT NULL
   ,week_number          NUMBER(2)
   ,week_end_dt          DATE
   ,CONSTRAINT "pk_u_dw_calendar.t_weeks" PRIMARY KEY (week_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_quaRter                                       */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_quarter 
(
    quarter_id            NUMBER(22,0)          NOT NULL
   ,quarter_num           NUMBER(1)             NOT NULL
   ,quarter_days_cnt      NUMBER(3)
   ,quarter_starts_dt     DATE
   ,quarter_ends_dt       DATE
   ,CONSTRAINT "pk_u_dw_calendar.t_quarter" PRIMARY KEY (quarter_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_month                                          */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_month 
(
    month_id             NUMBER(22,0)          NOT NULL
   ,month_number         NUMBER(2)
   ,month_name           VARCHAR(30)
   ,month_days_cnt       NUMBER(3)
   ,CONSTRAINT "pk_u_dw_calendar.t_month" PRIMARY KEY (month_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_years                                          */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_years 
(
    year_id              NUMBER(22,0)          NOT NULL
   ,year_calendar        NUMBER(4)
   ,year_days_cnt        NUMBER(3)
   ,CONSTRAINT "pk_u_dw_calendar.t_years" PRIMARY KEY (year_id)
);

ALTER TABLE u_dw_calendar.dw_date
   ADD CONSTRAINT fk_dw_date_ref_dw_t_day FOREIGN KEY (day_id)
      REFERENCES u_dw_calendar.t_days (day_id);

ALTER TABLE u_dw_calendar.dw_date
   ADD CONSTRAINT fk_dw_date_ref_dw_t_week FOREIGN KEY (week_id)
      REFERENCES u_dw_calendar.t_weeks (week_id);

ALTER TABLE u_dw_calendar.dw_date
   ADD CONSTRAINT fk_dw_date_ref_dw_t_month FOREIGN KEY (month_id)
      REFERENCES u_dw_calendar.t_month (month_id);

ALTER TABLE u_dw_calendar.dw_date
   ADD CONSTRAINT fk_dw_date_ref_dw_t_year FOREIGN KEY (year_id)
      REFERENCES u_dw_calendar.t_years (year_id);      
      
ALTER TABLE u_dw_calendar.dw_date
   ADD CONSTRAINT fk_dw_date_ref_dw_t_quarter FOREIGN KEY (quarter_id)
      REFERENCES u_dw_calendar.t_quarter (quarter_id);
