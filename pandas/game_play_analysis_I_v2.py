def game_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    activity_sorted = activity.sort_values(["player_id", "event_date"])
    result = activity_sorted.drop_duplicates("player_id")[["player_id", "event_date"]]
    result = result.rename(columns={"event_date": "first_login"})
    return result
