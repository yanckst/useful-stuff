-- SQL SERVER
-- Author: Piotr Kononow  25th June, 2018
-- Website : https://dataedo.com/kb/query/sql-server/list-foreign-keys
-- List foreign keys in SQL Server database
-- Tested on version 15

SELECT schema_name(fk_tab.schema_id) + '.' + fk_tab.name AS foreign_table,
    '>-' AS rel,
    schema_name(pk_tab.schema_id) + '.' + pk_tab.name AS primary_table,
    substring(column_names, 1, len(column_names)-1) AS [fk_columns],
    fk.name AS fk_constraint_name
FROM sys.foreign_keys fk
    INNER JOIN sys.tables fk_tab
        ON fk_tab.object_id = fk.parent_object_id
    INNER JOIN sys.tables pk_tab
        ON pk_tab.object_id = fk.referenced_object_id
    CROSS APPLY (SELECT col.[name] + ', '
                    FROM sys.foreign_key_columns fk_c
                        INNER JOIN sys.columns col
                            ON fk_c.parent_object_id = col.object_id
                            AND fk_c.parent_column_id = col.column_id
                    where fk_c.parent_object_id = fk_tab.object_id
                        AND fk_c.constraint_object_id = fk.object_id
                            ORDER BY col.column_id
                            for xml path ('') ) D (column_names)
ORDER BY schema_name(fk_tab.schema_id) + '.' + fk_tab.name,
    schema_name(pk_tab.schema_id) + '.' + pk_tab.name