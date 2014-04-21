SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- picture board
IF OBJECT_ID('stone_image', 'U') IS NULL 
BEGIN

CREATE TABLE [dbo].[stone_image](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_slab_frame] [int] NOT NULL,
	[id_slab] [int] NOT NULL,
	[id_frame] [int] NOT NULL,
	[id_stone] [int] NOT NULL,
	[label] [nvarchar](50) NOT NULL,
	[type] [int] NOT NULL,
	[size] [int] NOT NULL,
	[status] [int] NOT NULL DEFAULT 0,
	[full_path] [nvarchar](max) NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[rowversion] [timestamp] NULL,
 CONSTRAINT [PK_stone_image] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
PRINT 'Table with name "stone_image" created'
END
ELSE 
PRINT 'Table "stone_image" exists.'
GO