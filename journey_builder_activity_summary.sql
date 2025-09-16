SELECT TOP 10000 
    ac.VersionID,
    p.JourneyName,
    ac.JourneyStatus,
    ac.modifieddate,
    [ABNTEST], 
    [ABNTESTSTOP], 
    [ACTIVEAUDIENCE JOURNEYACTIVITY], 
    [EINSTEINENGAGEMENTFREQUENCYSPLIT], 
    [EMAILV2], 
    [ENGAGEMENTDECISION], 
    [INAPPSYNCACTIVITY], 
    [MULTICRITERIADECISION], 
    [MULTICRITERIADECISIONEXTENSION], 
    [PUSHINBOXACTIVITY], 
    [PUSHNOTIFICATIONACTIVITY], 
    [RANDOMSPLIT], 
    [REST], 
    [RESTDECISION], 
    [SLACKNOTIFIER], 
    [SMSSYNC], 
    [STOWAIT], 
    [UNCONFIGUREDJOIN], 
    [UPDATECONTACTDATA], 
    [WAIT], 
    [WAITUNTILAPI], 
    [WAITUNTILPUSHENGAGEMENT], 
    [WAITUNTILPUSHINAPPENGAGEMENT], 
    [WHATSAPPACTIVITY]
FROM (
    SELECT
        J.JourneyName,
        ja.ActivityType,
        ja.VersionID
    FROM _JourneyActivity AS ja
    INNER JOIN _Journey AS J
        ON J.VersionID = ja.VersionID
    WHERE ja.ActivityType IN (
        'ABNTEST',
        'ABNTESTSTOP',
        'ACTIVEAUDIENCE JOURNEYACTIVITY',
        'EINSTEINENGAGEMENTFREQUENCYSPLIT',
        'EMAILV2',
        'ENGAGEMENTDECISION',
        'INAPPSYNCACTIVITY',
        'MULTICRITERIADECISION',
        'MULTICRITERIADECISIONEXTENSION',
        'PUSHINBOXACTIVITY',
        'PUSHNOTIFICATIONACTIVITY',
        'RANDOMSPLIT',
        'REST',
        'RESTDECISION',
        'SLACKNOTIFIER',
        'SMSSYNC',
        'STOWAIT',
        'UNCONFIGUREDJOIN',
        'UPDATECONTACTDATA',
        'WAIT',
        'WAITUNTILAPI',
        'WAITUNTILPUSHENGAGEMENT',
        'WAITUNTILPUSHINAPPENGAGEMENT',
        'WHATSAPPACTIVITY'
    )
) AS SourceTable
PIVOT (
    COUNT(ActivityType)
    FOR ActivityType IN (
        [ABNTEST], 
        [ABNTESTSTOP], 
        [ACTIVEAUDIENCE JOURNEYACTIVITY], 
        [EINSTEINENGAGEMENTFREQUENCYSPLIT], 
        [EMAILV2], 
        [ENGAGEMENTDECISION], 
        [INAPPSYNCACTIVITY], 
        [MULTICRITERIADECISION], 
        [MULTICRITERIADECISIONEXTENSION], 
        [PUSHINBOXACTIVITY], 
        [PUSHNOTIFICATIONACTIVITY], 
        [RANDOMSPLIT], 
        [REST], 
        [RESTDECISION], 
        [SLACKNOTIFIER], 
        [SMSSYNC], 
        [STOWAIT], 
        [UNCONFIGUREDJOIN], 
        [UPDATECONTACTDATA], 
        [WAIT], 
        [WAITUNTILAPI], 
        [WAITUNTILPUSHENGAGEMENT], 
        [WAITUNTILPUSHINAPPENGAGEMENT], 
        [WHATSAPPACTIVITY]
    )
) AS p
INNER JOIN (
    SELECT
        J.JourneyName,
        CONVERT(CHAR(10), J.modifieddate, 120) AS modifieddate,
        J.JourneyStatus, 
        ja.VersionID
    FROM _JourneyActivity AS ja
    INNER JOIN _Journey AS J
        ON J.VersionID = ja.VersionID
    GROUP BY 
        J.JourneyName, 
        J.JourneyStatus, 
        ja.VersionID, 
        CONVERT(CHAR(10), J.modifieddate, 120)
) AS ac
    ON p.VersionID = ac.VersionID
WHERE ac.JourneyStatus = 'Running'
ORDER BY CONVERT(CHAR(10), ac.modifieddate, 120) DESC
