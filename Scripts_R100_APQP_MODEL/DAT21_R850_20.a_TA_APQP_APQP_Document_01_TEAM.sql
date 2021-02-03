-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_TEAM
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210202
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02Pruebas]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_TEAM_HDR]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_TEAM_HDR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_TEAM_DET]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_TEAM_DET]
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_TEAM_HDR				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_TEAM_HDR]	(
			-- ============================	
			[K_APQP_TEAM_HDR]					[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_MODEL_HDR]					[INT],
			-- ===========================
			[K_STATUS_APQP_DOCUMENT]			[INT] NOT NULL DEFAULT 0,
			[APQP_TEAM_HDR_RFQ]					[VARCHAR](255),
			[F_APQP_TEAM_HDR_CREATED]			[DATE]	NOT NULL,
			-- ===========================
			[L_APQP_TEAM_HDR_01]				[INT]	NOT NULL DEFAULT 0,
			[L_APQP_TEAM_HDR_02]				[INT]	NOT NULL DEFAULT 0,
			[L_APQP_TEAM_HDR_03]				[INT]	NOT NULL DEFAULT 0,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_TEAM_HDR]
ADD
			[K_USUARIO_ALTA]					[INT] NOT NULL,
			[F_ALTA]							[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
			[F_CAMBIO]							[DATETIME] NOT NULL,
			[L_BORRADO]							[INT] NOT NULL,
			[K_USUARIO_BAJA]					[INT] NULL,
			[F_BAJA]							[DATETIME] NULL;
GO

-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_TEAM_HDR]	
	ADD CONSTRAINT [K_APQP_TEAM_HDR]
		PRIMARY KEY CLUSTERED ([K_APQP_TEAM_HDR])
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_TEAM_DET
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_TEAM_DET]	(
			-- ============================	
			[K_APQP_TEAM_DET]					[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_TEAM_HDR]					[INT] NOT NULL DEFAULT 0,
			[K_APQP_TEAM_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[L_APQP_TEAM_DET_YES]				[INT] NOT NULL DEFAULT 0,
			[L_APQP_TEAM_DET_NO]				[INT] NOT NULL DEFAULT 0,
			[L_APQP_QUAL_DET_NA]				[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[F_APQP_TEAM_DET_COMPLETED]			[DATE]	NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_TEAM_DET]
ADD
			[K_USUARIO_ALTA]					[INT] NOT NULL,
			[F_ALTA]							[DATETIME] NOT NULL,
			[K_USUARIO_CAMBIO]					[INT] NOT NULL,
			[F_CAMBIO]							[DATETIME] NOT NULL,
			[L_BORRADO]							[INT] NOT NULL,
			[K_USUARIO_BAJA]					[INT] NULL,
			[F_BAJA]							[DATETIME] NULL;
GO

-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_TEAM_DET]	
	ADD CONSTRAINT [K_APQP_TEAM_DET]
		PRIMARY KEY CLUSTERED ([K_APQP_TEAM_DET])
GO
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////