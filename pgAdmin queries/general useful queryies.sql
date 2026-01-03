SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'peaks_hikes_service'
  AND table_name = 'peaks'
ORDER BY ordinal_position;

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'peaks_hikes_service'
  AND table_name = 'peaks'
ORDER BY ordinal_position;