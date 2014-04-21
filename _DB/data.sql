SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- picture board
IF NOT EXISTS(
	SELECT * FROM dbo.module WHERE name LIKE 'Picture Board')
BEGIN

PRINT 'No rows for Picture Board module. Doing insert...'

INSERT INTO [erp].[dbo].[module] (id_module, name, reg_date, port, dbtype, link, picture, node, sequence) 
VALUES (27, 'Picture Board', GETDATE(), 0, 0, 'picture_board.php', NULL, 1, 0);	-- 27 is parent module (menu)

DECLARE @pic_board_id INT;
SELECT @pic_board_id = MAX(id) FROM dbo.module;
 
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 2);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 11);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 12);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 13);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 14);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 15);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@pic_board_id, 16);

END
----------------------
IF NOT EXISTS(
	SELECT * FROM dbo.module WHERE name LIKE 'Edit frame pictures')
BEGIN

PRINT 'No rows for Edit frame pictures module. Doing insert...'

-- gets picture board as the parent module 
DECLARE @pic_board_mod_name VARCHAR(50) = 'Picture Board';
DECLARE @pic_board_mod_id INT;
SELECT @pic_board_mod_id = id FROM dbo.module WHERE name LIKE @pic_board_mod_name;

INSERT INTO [erp].[dbo].[module] (id_module, name, reg_date, port, dbtype, link, picture, node, sequence) 
VALUES (@pic_board_mod_id, 'Edit frame pictures', GETDATE(), 0, 0, 'editframepictures.php', NULL, 0, 0);

DECLARE @edit_frame_pic_id INT;
SELECT @edit_frame_pic_id = MAX(id) FROM dbo.module;
 
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 2);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 11);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 12);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 13);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 14);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 15);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@edit_frame_pic_id, 16);

END