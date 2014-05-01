SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- picture board
IF OBJECT_ID('templator_log', 'U') IS NULL 
BEGIN
CREATE TABLE [dbo].[templator_log](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[id_order] [numeric](18, 0) NULL,
	[templator] [varchar](200) NOT NULL,
	[installer] [varchar](200) NOT NULL,
	[default_date] [datetime] NOT NULL,
	[created_by] [varchar](200) NULL,
 CONSTRAINT [PK_templator_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

IF OBJECT_ID('contest_status', 'U') IS NULL 
BEGIN
CREATE TABLE [dbo].[contest_status](
	[id] [numeric](5, 0) NOT NULL,
	[description] [varchar](20) NULL,
	[value] [nvarchar](2) NULL,
	[color] [varchar](10) NULL,
 CONSTRAINT [PK_Contest_Status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

IF OBJECT_ID('contest', 'U') IS NULL 
BEGIN
CREATE TABLE [dbo].[contest](
	[id_order] [numeric](18, 0) NOT NULL,
	[cstatus] [varchar](2) NULL,
	[taken_by] [varchar](100) NULL,
	[notes] [varchar](200) NULL,
	[reason_cancel] [varchar](200) NULL,
 CONSTRAINT [PK_contest] PRIMARY KEY CLUSTERED 
(
	[id_order] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

IF OBJECT_ID('order', 'U') IS NOT NULL 
BEGIN
	ALTER TABLE dbo.[order] add contest bit
	ALTER TABLE dbo.[order] add date_contest datetime
	ALTER TABLE dbo.[order] add contest_status varchar(2)
END


