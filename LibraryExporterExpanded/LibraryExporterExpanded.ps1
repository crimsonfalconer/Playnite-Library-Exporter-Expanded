function global:ExportLibrary()
{
    $games = $PlayniteApi.Database.GetGames()
    $path = $PlayniteApi.Dialogs.SaveFile("CSV|*.csv|Formated TXT|*.txt")
    $platforms = $PlayniteApi.Database.GetPlatforms()

    $platforms | Export-Csv -Path "C:\temp\plats.csv"

    $platformHash = @{}
    $platforms | ForEach-Object {$platformHash.Add($_.Id, $_.Name)}

    if ($path)
    {
        $games = $games | Select Name, Source, ReleaseDate, Playtime, PlayCount, IsInstalled, Favorite, GameId, PlatformId, @{Name = "Platform"; Expression = {$platformHash[$_.PlatformId]}} | Export-Csv -NoTypeInformation -Path $path
        $PlayniteApi.Dialogs.ShowMessage("Library exported successfully.");
    }
}