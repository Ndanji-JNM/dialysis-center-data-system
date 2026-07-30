SELECT COUNT(*) FROM sessions;

SELECT COUNT(*) FROM session_complications;

SELECT session_status, COUNT(*)
FROM sessions
GROUP BY session_status;

SELECT complication_type, COUNT(*)
FROM session_complications
GROUP BY complication_type;