SELECT * FROM badge_service.logbook;

INSERT INTO badge_service.logbook (user_id, peak_id, notes)
VALUES
    (1, 101, 'First ascent'),
    (1, 102, 'Foggy weather'),
    (2, 103, 'Solo hike');


SELECT p FROM peaks_hikes_service.peaks p WHERE p.id = 3