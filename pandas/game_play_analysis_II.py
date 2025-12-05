import pandas as pd


def game_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    first_dates = (
        activity.groupby("player_id", as_index=False)["event_date"]
        .min()
        .rename(columns={"event_date": "first_login"})
    )

    merged = first_dates.merge(
        activity,
        left_on=["player_id", "first_login"],
        right_on=["player_id", "event_date"],
        how="left",
    )

    return merged[["player_id", "device_id"]]
