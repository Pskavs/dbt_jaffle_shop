import holidays
import pandas as pd

def model(dbt, session):
    dbt.config(
        materialized="table",
        packages=["pandas", "holidays"]
    )

    date_spine = dbt.ref("date_spine")

    df = date_spine.to_pandas()

    us_holidays = holidays.US()
    df["IS_HOLIDAY"] = df["DATE_DAY"].apply(lambda date: date in us_holidays)

    return session.create_dataframe(df)