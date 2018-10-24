USE [Corso2018]
GO

/****** Object:  Table [dbo].[RoomsAndSeats]    Script Date: 24/10/2018 15:10:42 ******/

/* visivamente si trova in DATABASE->DATABASE DI SISTEMA->TABELLE TEMPORANEE->##TmpFreeSeats */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE MyFreeSeats(
	[RoomID] [int] NOT NULL,
	[SeatID] [int] NOT NULL,
	[RowNumber] [nvarchar](50) NOT NULL,
	[SeatNumber] [int] NOT NULL,
	[Taken] [bit] NOT NULL,
	[postolibero] [int] NOT NULL,
	[diffSeatsCntLibero] [int] NOT NULL,
	[totPostiLiberiRow] [int] NOT NULL
) ON [PRIMARY]
GO


