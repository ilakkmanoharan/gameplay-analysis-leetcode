import pandas as pd


def game_play_analysis_IV(activity: pd.DataFrame) -> pd.DataFrame:
    # First login date per player
    first = (
        activity.groupby("player_id", as_index=False)["event_date"]
        .min()
        .rename(columns={"event_date": "first_login"})
    )

    # Merge with original table
    df = activity.merge(first, on="player_id", how="left")

    # Compute next day
    df["next_day"] = df["first_login"] + pd.Timedelta(days=1)

    # Identify retained players
    retained_players = df.loc[
        df["event_date"] == df["next_day"], "player_id"
    ].drop_duplicates()

    total_players = first["player_id"].nunique()
    retained_count = retained_players.nunique()

    fraction = round(retained_count / total_players + 1e-9, 2)

    return pd.DataFrame({"fraction": [fraction]})
