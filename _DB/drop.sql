SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- picture board
IF OBJECT_ID('stone_image', 'U') IS NOT NULL 
BEGIN
DROP TABLE [dbo].[stone_image];
END

DECLARE @edit_frame_mod_id INT = 0;
SELECT @edit_frame_mod_id = id FROM dbo.module WHERE name LIKE 'Edit frame pictures';

DELETE FROM dbo.module WHERE name LIKE 'Edit frame pictures';
DELETE FROM dbo.module_location WHERE id_module = @edit_frame_mod_id;
----------- 
DECLARE @pic_board_mod_id INT = 0;
SELECT @pic_board_mod_id = id FROM dbo.module WHERE name LIKE 'Picture Board';

DELETE FROM dbo.module WHERE name LIKE 'Picture Board';
DELETE FROM dbo.module_location WHERE id_module = @pic_board_mod_id;
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


