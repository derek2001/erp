SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------
BEGIN

PRINT 'No rows for Edit Applications. Doing Update...'

UPDATE [dbo].[application] SET [question] = '<p>1. Are cabinets in place?<br />2. Is the existing top off?<br />3. Is cooktop on job site?<br />4. Is stove on job site?<br />4. Is dishwasher on job site?<br />5. Are sinks on job site?<br /><b><font style="color:red">6. Faucet must be on job site.</font></b><br />7. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>8. Do you want to participate in our makeover contest?</strong></font></p>' WHERE [id] = 10 
UPDATE [dbo].[application] SET [question] = '<p />' WHERE [id] = 11 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 12 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 13 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 14 
UPDATE [dbo].[application] SET [question] = '1. Are cabinets in place?<br />2. Is existing top off?<br />3. Are sinks and faucets on job site?<br />4. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>5. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 15 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 16 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br />2. Is the Jacuzzi/tub on job site?<br /><font style="color:#249C0A"><strong>3. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 17 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>3. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 18 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 19 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br/ ><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>'WHERE [id] = 20 
UPDATE [dbo].[application] SET [question] = '<p>1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</p></strong></font>' WHERE [id] = 21 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 22 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 23 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 24 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 25 
UPDATE [dbo].[application] SET [question] = '1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font>' WHERE [id] = 26 
UPDATE [dbo].[application] SET [question] = '<p>1. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>2. Do you want to participate in our makeover contest?</strong></font></p>' WHERE [id] = 27 
UPDATE [dbo].[application] SET [question] = '<p>1. Is the stone sample on site?<br />2. Is the base for the table on site?<br /><font style="color:#249C0A"><strong>3. Do you want to participate in our makeover contest?</strong></font></p>' WHERE [id] = 28 
UPDATE [dbo].[application] SET [question] = '<p>1. Are cabinets in place?<br />2. Is the existing top off?<br />3. Is cooktop on job site?<br />4. Is stove on job site?<br />4. Is dishwasher on job site?<br />5. Are sinks and faucets on job site?<br />6. Is stone sample on job site?<br /><font style="color:#249C0A"><strong>7. Do you want to participate in our makeover contest?</strong></font></p>' WHERE [id] = 29 

END
----------------------
IF NOT EXISTS(
	SELECT * FROM dbo.module WHERE name LIKE 'Contest Checklist')
BEGIN

PRINT 'No rows for Contest Checklist module. Doing insert...'

-- gets contest checklist
DECLARE @contest_mod_name VARCHAR(50) = 'Contest Checklist';
DECLARE @contes_mod_id INT;
SELECT @contes_mod_id = id FROM dbo.module WHERE name LIKE  @contest_mod_name;

INSERT INTO [erp].[dbo].[module] (id_module, name, reg_date, port, dbtype, link, picture, node, sequence) 
VALUES (@contes_mod_id, 'Contest Checklist', GETDATE(), 0, 0, 'javascript:ow(\''contest_cl.php''\,850,750,0,0,0)', NULL, 1, 0);

DECLARE @contes_id INT;
SELECT @contes_id = MAX(id) FROM dbo.module;
 
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 2);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 11);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 12);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 13);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 14);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 15);
INSERT INTO [erp].[dbo].[module_location] (id_module, id_location) VALUES (@contes_id, 16);

END

