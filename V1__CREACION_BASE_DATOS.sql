
USE [ChangeIt]
GO
/****** Object:  Table [dbo].[BitacoraPosts]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitacoraPosts](
	[idBitacoraPost] [bigint] IDENTITY(1,1) NOT NULL,
	[idPost] [bigint] NOT NULL,
	[idInteraction] [int] NOT NULL,
	[value] [decimal](10, 2) NOT NULL,
	postTime datetime NOT NULL,
 CONSTRAINT [PK_BitacoraPosts] PRIMARY KEY CLUSTERED 
(
	[idBitacoraPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[idGender] [tinyint] IDENTITY(1,1) NOT NULL,
	[gender] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[idGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Habit]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Habit](
	[idHabit] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](148) NOT NULL,
	[description] [nvarchar](800) NOT NULL,
	[idImage] [bigint] NULL,
 CONSTRAINT [PK_Habit] PRIMARY KEY CLUSTERED 
(
	[idHabit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HabitLog]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HabitLog](
	[idHabitLog] [bigint] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[idHabit] [bigint] NOT NULL,
	[idImpact] [int] NOT NULL,
	[value] [decimal](10, 8) NOT NULL,
	[idPost] [bigint] NOT NULL,
 CONSTRAINT [PK_HabitLog] PRIMARY KEY CLUSTERED 
(
	[idHabitLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HabitsPerPosts]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HabitsPerPosts](
	[idPost] [bigint] NOT NULL,
	[idHabit] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[idImage] [bigint] IDENTITY(1,1) NOT NULL,
	[link] [varchar](2048) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[idImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impact]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impact](
	[idImpact] [int] IDENTITY(1,1) NOT NULL,
	[impact] [varchar](254) NOT NULL,
 CONSTRAINT [PK_Impact] PRIMARY KEY CLUSTERED 
(
	[idImpact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interactions]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interactions](
	[idInteraction] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](148) NOT NULL,
 CONSTRAINT [PK_Interactions] PRIMARY KEY CLUSTERED 
(
	[idInteraction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[idLocation] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](148) NOT NULL,
	[country] [nvarchar](148) NOT NULL,
	[latitude] [decimal](10, 8) NOT NULL,
	[longitude] [decimal](11, 8) NOT NULL,
	[population] [int] NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[idLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationsPerHabit]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationsPerHabit](
	[idHabit] [bigint] NOT NULL,
	[idLocation] [bigint] NOT NULL,
	[idLocationsPerHabit] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_LocationsPerHabit] PRIMARY KEY CLUSTERED 
(
	[idLocationsPerHabit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginSessions]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginSessions](
	[idLoginSession] [bigint] IDENTITY(1,1) NOT NULL,
	[idUser] [bigint] NOT NULL,
	[idSocialMedia] [int] NOT NULL,
	[idToken] [bigint] NOT NULL,
	[idLoginStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_LoginSessions] PRIMARY KEY CLUSTERED 
(
	[idLoginSession] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginStatus]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginStatus](
	[idLoginStatus] [tinyint] IDENTITY(1,1) NOT NULL,
	[status] [varchar](70) NOT NULL,
 CONSTRAINT [PK_LoginStatus] PRIMARY KEY CLUSTERED 
(
	[idLoginStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Merchants]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchants](
	[idMerchants] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](148) NOT NULL,
	[url] [varchar](2048) NOT NULL,
	[enabled] [bit] NOT NULL,
	[idIcon] [bigint] NULL,
 CONSTRAINT [PK_Merchants] PRIMARY KEY CLUSTERED 
(
	[idMerchants] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentAttempts]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentAttempts](
	[idPaymentAttempts] [bigint] IDENTITY(1,1) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[merchanTransNumber] [int] NOT NULL,
	[description] [nvarchar](148) NOT NULL,
	[referenceNumber] [int] NOT NULL,
	[errorNumber] [int] NULL,
	[computerName] [varchar](148) NOT NULL,
	[userName] [varchar](148) NOT NULL,
	[ipAddress] [varchar](14) NOT NULL,
	[checksum] [binary](256) NOT NULL,
	[idMerchant] [int] NOT NULL,
	[idUser] [bigint] NULL,
	[idPaymentStatus] [int] NOT NULL,
 CONSTRAINT [PK_PaymentAttempts] PRIMARY KEY CLUSTERED 
(
	[idPaymentAttempts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatus]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatus](
	[idPaymentStatus] [int] IDENTITY(1,1) NOT NULL,
	[status] [varchar](148) NOT NULL,
 CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED 
(
	[idPaymentStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].TransactionTypes(
	idTransactionType int IDENTITY(1,1) NOT NULL,
	name Varchar(45) NOT NULL,
 CONSTRAINT [PK_TransactionTypes] PRIMARY KEY CLUSTERED 
(
	idTransactionType ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].TransactionSubTypes(
	idTransactionSubType int IDENTITY(1,1) NOT NULL,
	name Varchar(45) NOT NULL,
 CONSTRAINT [PK_TransactionSubTypes] PRIMARY KEY CLUSTERED 
(
	idTransactionSubType ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[PaymentStatus]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTransactions](
	idPaymentTransaction bigint IDENTITY(1,1) NOT NULL,
	postTime DATETIME NOT NULL,
	description VARCHAR(45) NOT NULL,
	computerName VARCHAR(45) NOT NULL,
	ipAddress VARCHAR(14) NOT NULL,
	checksum binary NULL,
	amount DECIMAL(10,2) NULL,
	referenceID BIGINT NULL,
	idUser BIGINT NOT NULL,
	idTransactionType INT NOT NULL,
	idTransactionSubType INT NOT NULL,
	idPaymentAttempts [bigint] NOT NULL,
 CONSTRAINT [PK_PaymentTransactions] PRIMARY KEY CLUSTERED 
(
	idPaymentTransaction ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Posts]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[idPost] [bigint] IDENTITY(1,1) NOT NULL,
	[idSocialMedia] [int] NOT NULL,
	[link] [varchar](2048) NULL,
	[description] [nvarchar](148) NULL,
	[idUser] [bigint] NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[idPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialMedia]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialMedia](
	[idSocialMedia] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
	[idIcon] [bigint] NOT NULL,
 CONSTRAINT [PK_SocialMedia] PRIMARY KEY CLUSTERED 
(
	[idSocialMedia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SponsorsPerLocationsPerHabit]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SponsorsPerLocationsPerHabit](
	[idSponsorPerLocationPerHabit] [bigint] IDENTITY(1,1) NOT NULL,
	[idLocationsPerHabit] [bigint] NOT NULL,
	[radius] [decimal](10, 2) NOT NULL,
	[idUser] [bigint] NOT NULL,
 CONSTRAINT [PK_SponsorsPerLocationsPerHabit] PRIMARY KEY CLUSTERED 
(
	[idSponsorPerLocationPerHabit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tokens]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tokens](
	[idToken] [bigint] IDENTITY(1,1) NOT NULL,
	[access_token] [varchar](512) NULL,
	[token_type] [varchar](128) NULL,
	[expire_date] [datetime] NOT NULL,
 CONSTRAINT [PK_Tokens] PRIMARY KEY CLUSTERED 
(
	[idToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/14/2021 12:17:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[idUser] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](70) NOT NULL,
	[lastName] [nvarchar](70) NOT NULL,
	[birthday] [datetime] NOT NULL,
	[idProfilePicture] [bigint] NOT NULL,
	[idGender] [tinyint] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].PaymentTransactions  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_TransactionTypes] FOREIGN KEY([idTransactionType])
REFERENCES [dbo].TransactionTypes ([idTransactionType])
GO
ALTER TABLE [dbo].[BitacoraPosts]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraPosts_Interactions] FOREIGN KEY([idInteraction])
REFERENCES [dbo].[Interactions] ([idInteraction])
GO
ALTER TABLE [dbo].PaymentTransactions  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_Users] FOREIGN KEY(idUser)
REFERENCES [dbo].Users (idUser)
GO
ALTER TABLE [dbo].PaymentTransactions  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_PaymentAttempts] FOREIGN KEY(idPaymentAttempts)
REFERENCES [dbo].PaymentAttempts (idPaymentAttempts)
GO
ALTER TABLE [dbo].PaymentTransactions  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_TransactionSubTypes] FOREIGN KEY([idTransactionSubType])
REFERENCES [dbo].TransactionSubTypes ([idTransactionSubType])
GO
ALTER TABLE [dbo].[BitacoraPosts] CHECK CONSTRAINT [FK_BitacoraPosts_Interactions]
GO
ALTER TABLE [dbo].[BitacoraPosts]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraPosts_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[BitacoraPosts] CHECK CONSTRAINT [FK_BitacoraPosts_Posts]
GO
ALTER TABLE [dbo].[Habit]  WITH CHECK ADD  CONSTRAINT [FK_Habit_Images] FOREIGN KEY([idImage])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[Habit] CHECK CONSTRAINT [FK_Habit_Images]
GO
ALTER TABLE [dbo].[HabitLog]  WITH CHECK ADD  CONSTRAINT [FK_HabitLog_Habit] FOREIGN KEY([idHabit])
REFERENCES [dbo].[Habit] ([idHabit])
GO
ALTER TABLE [dbo].[HabitLog] CHECK CONSTRAINT [FK_HabitLog_Habit]
GO
ALTER TABLE [dbo].[HabitLog]  WITH CHECK ADD  CONSTRAINT [FK_HabitLog_Impact] FOREIGN KEY([idImpact])
REFERENCES [dbo].[Impact] ([idImpact])
GO
ALTER TABLE [dbo].[HabitLog] CHECK CONSTRAINT [FK_HabitLog_Impact]
GO
ALTER TABLE [dbo].[HabitLog]  WITH CHECK ADD  CONSTRAINT [FK_HabitLog_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[HabitLog] CHECK CONSTRAINT [FK_HabitLog_Posts]
GO
ALTER TABLE [dbo].[HabitsPerPosts]  WITH CHECK ADD  CONSTRAINT [FK_HabitsPerPosts_Habit] FOREIGN KEY([idHabit])
REFERENCES [dbo].[Habit] ([idHabit])
GO
ALTER TABLE [dbo].[HabitsPerPosts] CHECK CONSTRAINT [FK_HabitsPerPosts_Habit]
GO
ALTER TABLE [dbo].[HabitsPerPosts]  WITH CHECK ADD  CONSTRAINT [FK_HabitsPerPosts_Posts] FOREIGN KEY([idPost])
REFERENCES [dbo].[Posts] ([idPost])
GO
ALTER TABLE [dbo].[HabitsPerPosts] CHECK CONSTRAINT [FK_HabitsPerPosts_Posts]
GO
ALTER TABLE [dbo].[LocationsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_LocationsPerHabit_Habit] FOREIGN KEY([idHabit])
REFERENCES [dbo].[Habit] ([idHabit])
GO
ALTER TABLE [dbo].[LocationsPerHabit] CHECK CONSTRAINT [FK_LocationsPerHabit_Habit]
GO
ALTER TABLE [dbo].[LocationsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_LocationsPerHabit_Locations] FOREIGN KEY([idLocation])
REFERENCES [dbo].[Locations] ([idLocation])
GO
ALTER TABLE [dbo].[LocationsPerHabit] CHECK CONSTRAINT [FK_LocationsPerHabit_Locations]
GO
ALTER TABLE [dbo].[LoginSessions]  WITH CHECK ADD  CONSTRAINT [FK_LoginSessions_LoginStatus] FOREIGN KEY([idLoginStatus])
REFERENCES [dbo].[LoginStatus] ([idLoginStatus])
GO
ALTER TABLE [dbo].[LoginSessions] CHECK CONSTRAINT [FK_LoginSessions_LoginStatus]
GO
ALTER TABLE [dbo].[LoginSessions]  WITH CHECK ADD  CONSTRAINT [FK_LoginSessions_SocialMedia] FOREIGN KEY([idSocialMedia])
REFERENCES [dbo].[SocialMedia] ([idSocialMedia])
GO
ALTER TABLE [dbo].[LoginSessions] CHECK CONSTRAINT [FK_LoginSessions_SocialMedia]
GO
ALTER TABLE [dbo].[LoginSessions]  WITH CHECK ADD  CONSTRAINT [FK_LoginSessions_Tokens] FOREIGN KEY([idToken])
REFERENCES [dbo].[Tokens] ([idToken])
GO
ALTER TABLE [dbo].[LoginSessions] CHECK CONSTRAINT [FK_LoginSessions_Tokens]
GO
ALTER TABLE [dbo].[LoginSessions]  WITH CHECK ADD  CONSTRAINT [FK_LoginSessions_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[LoginSessions] CHECK CONSTRAINT [FK_LoginSessions_Users]
GO
ALTER TABLE [dbo].[Merchants]  WITH CHECK ADD  CONSTRAINT [FK_Merchants_Images] FOREIGN KEY([idIcon])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[Merchants] CHECK CONSTRAINT [FK_Merchants_Images]
GO
ALTER TABLE [dbo].[PaymentAttempts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAttempts_Merchants] FOREIGN KEY([idMerchant])
REFERENCES [dbo].[Merchants] ([idMerchants])
GO
ALTER TABLE [dbo].[PaymentAttempts] CHECK CONSTRAINT [FK_PaymentAttempts_Merchants]
GO
ALTER TABLE [dbo].[PaymentAttempts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAttempts_PaymentStatus] FOREIGN KEY([idPaymentStatus])
REFERENCES [dbo].[PaymentStatus] ([idPaymentStatus])
GO
ALTER TABLE [dbo].[PaymentAttempts] CHECK CONSTRAINT [FK_PaymentAttempts_PaymentStatus]
GO
ALTER TABLE [dbo].[PaymentAttempts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAttempts_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[PaymentAttempts] CHECK CONSTRAINT [FK_PaymentAttempts_Users]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_SocialMedia] FOREIGN KEY([idSocialMedia])
REFERENCES [dbo].[SocialMedia] ([idSocialMedia])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_SocialMedia]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users]
GO
ALTER TABLE [dbo].[SocialMedia]  WITH CHECK ADD  CONSTRAINT [FK_SocialMedia_Images] FOREIGN KEY([idIcon])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[SocialMedia] CHECK CONSTRAINT [FK_SocialMedia_Images]
GO
ALTER TABLE [dbo].[SponsorsPerLocationsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_SponsorsPerLocationsPerHabit_LocationsPerHabit] FOREIGN KEY([idLocationsPerHabit])
REFERENCES [dbo].[LocationsPerHabit] ([idLocationsPerHabit])
GO
ALTER TABLE [dbo].[SponsorsPerLocationsPerHabit] CHECK CONSTRAINT [FK_SponsorsPerLocationsPerHabit_LocationsPerHabit]
GO
ALTER TABLE [dbo].[SponsorsPerLocationsPerHabit]  WITH CHECK ADD  CONSTRAINT [FK_SponsorsPerLocationsPerHabit_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[SponsorsPerLocationsPerHabit] CHECK CONSTRAINT [FK_SponsorsPerLocationsPerHabit_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Gender] FOREIGN KEY([idGender])
REFERENCES [dbo].[Gender] ([idGender])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Gender]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Images] FOREIGN KEY([idProfilePicture])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Images]
GO
