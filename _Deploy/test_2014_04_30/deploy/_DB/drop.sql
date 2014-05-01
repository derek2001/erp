SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------
DECLARE @contest_mod_id INT = 0;
SELECT @contest_mod_id = id FROM dbo.module WHERE name LIKE 'Contest Checklist';

DELETE FROM dbo.module WHERE name LIKE 'Contest Checklist';
DELETE FROM dbo.module_location WHERE id_module = @contest_mod_id;


-- templator_log
IF OBJECT_ID('templator_log', 'U') IS NOT NULL 
BEGIN
DROP TABLE [dbo].[templator_log];
END

-- contest_status
IF OBJECT_ID('contest_status', 'U') IS NOT NULL 
BEGIN
DROP TABLE [dbo].[contest_status];
END

-- contest
IF OBJECT_ID('contest', 'U') IS NOT NULL 
BEGIN
DROP TABLE [dbo].[contest];
END


