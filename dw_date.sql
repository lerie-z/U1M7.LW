ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_day;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_week;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_month;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_quater;

ALTER TABLE u_dw_calendar.dw_date 
       DROP CONSTRAINT fk_dw_date_ref_dw_t_year;
       
DROP TABLE u_dw_calendar.dw_date CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: u_dw_calendar.dw_date                                             */
/*==============================================================*/
CREATE TABLE u_dw_calendar.dw_date 
(
    date_id              NUMBER(4) NOT NULL
   ,day_id               NUMBER(4)
   ,week_id              NUMBER(4)
   ,year_id              NUMBER(4)
   ,month_id             NUMBER(4)
   ,quater_id            NUMBER(4)
   ,date_full_string     VARCHAR2 ( 20 CHAR )
   ,CONSTRAINT "pk_u_dw_calendar.dw_date" PRIMARY KEY (date_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_days                                           */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_days 
(
    day_id               NUMBER(22,0)          NOT NULL
   ,day_full_string      VARCHAR(30)
   ,day_of_week          VARCHAR(30)
   ,day_num_of_year      NUMBER(22,0)
   ,CONSTRAINT "pk_u_dw_calendar.t_days" PRIMARY KEY (day_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_weeks                                          */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_weeks 
(
    week_id              NUMBER(4)          NOT NULL
   ,week_num_of_year     NUMBER(4)
   ,week_starts_dt       DATE
   ,week_ends_dt         DATE
   ,CONSTRAINT "pk_u_dw_calendar.t_weeks" PRIMARY KEY (week_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_quater                                       */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_quater 
(
    quater_id               NUMBER(4)  NOT NULL
   ,quater_starts_dt        DATE
   ,quater_ends_dt          DATE
   ,quater_days_cnt         NUMBER(4)
   ,CONSTRAINT "pk_u_dw_calendar.t_quater" PRIMARY KEY (quater_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_month                                          */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_month 
(
    month_id             NUMBER(4)          NOT NULL
   ,month_full_string    VARCHAR(30)
   ,month_num            NUMBER(4) 
   ,month_day_cnt        NUMBER(4)
   ,CONSTRAINT "pk_u_dw_calendar.t_month" PRIMARY KEY (month_id)
);

/*==============================================================*/
/* Table: u_dw_calendar.t_years                                          */
/*==============================================================*/
CREATE TABLE u_dw_calendar.t_years 
(
    year_id              NUMBER(22,0)          NOT NULL
   ,year_calendar        NUMBER(4)
   ,YEAR_DAYS_CNT        NUMBER(4)
   ,year_starts_dt       DATE
   ,year_ends_dt         DATE
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
   ADD CONSTRAINT fk_dw_date_ref_dw_t_quater FOREIGN KEY (quater_id)
      REFERENCES u_dw_calendar.t_quater (quater_id);

drop tab