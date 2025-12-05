import pandas as pd


def game_play_analysis_III(activity: pd.DataFrame) -> pd.DataFrame:
    # Sort to establish event order
    activity_sorted = activity.sort_values(["player_id", "event_date"])

    # Compute cumulative games
    activity_sorted["games_played_so_far"] = activity_sorted.groupby("player_id")[
        "games_played"
    ].cumsum()

    return activity_sorted[["player_id", "event_date", "games_played_so_far"]]
