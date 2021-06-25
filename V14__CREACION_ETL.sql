
USE [ChangeAll]
GO
/****** Object:  Table [dbo].[Campaigns]    Script Date: 6/25/2021 12:10:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaigns](
	[campaign] [nchar](148) NOT NULL,
	[restaurant] [nchar](148) NOT NULL,
	[city] [nchar](148) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[amount] [decimal](10, 2) NULL,
	[views] [bigint] NULL,
	[shares] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 6/25/2021 12:10:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[restaurant] [nvarchar](148) NOT NULL,
	[latitude] [decimal](10, 8) NOT NULL,
	[longitude] [decimal](11, 8) NOT NULL,
	[city] [nvarchar](148) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersLogs]    Script Date: 6/25/2021 12:10:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersLogs](
	[postTime] [datetime] NOT NULL,
	[latitude] [decimal](10, 8) NOT NULL,
	[longitude] [decimal](11, 8) NOT NULL,
	[email] [varchar](256) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [ChangeAll] SET  READ_WRITE 
GO
