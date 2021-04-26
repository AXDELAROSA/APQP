-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_RISK
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210202
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_RISK_HDR]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_RISK_HDR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_RISK_DET]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_RISK_DET]
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_RISK_HDR				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_RISK_HDR]	(
			-- ============================	
			[K_APQP_RISK_HDR]				[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_MODEL_HDR]				[INT],
			-- ===========================
			[K_STATUS_APQP_DOCUMENT]		[INT] NOT NULL DEFAULT 0,
			[F_APQP_RISK_HDR_CREATED]		[DATE]	NOT NULL,
			-- ===========================
			[APQP_RISK_SUMMARY]				[DECIMAL](10,2)	NOT NULL DEFAULT 0,
			-- ===========================
			[L_APQP_RISK_HDR_LOW]			[INT] NOT NULL DEFAULT 0,
			[L_APQP_RISK_HDR_MEDIUM]		[INT] NOT NULL DEFAULT 0,
			[L_APQP_RISK_HDR_HIGH]			[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[C_APQP_RISK_HDR_MEDIUM]		[NVARCHAR](MAX) NOT NULL DEFAULT '	NONE	',
			[C_APQP_RISK_HDR_HIGH]			[NVARCHAR](MAX) NOT NULL DEFAULT '	NONE	'
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_RISK_HDR]
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
ALTER TABLE [dbo].[APQP_RISK_HDR]	
	ADD CONSTRAINT [K_APQP_RISK_HDR]
		PRIMARY KEY CLUSTERED ([K_APQP_RISK_HDR])
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_RISK_DET
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_RISK_DET]	(
			-- ============================	
			[K_APQP_RISK_DET]					[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_RISK_HDR]					[INT] NOT NULL DEFAULT 0,
			[K_APQP_RISK_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[L_APQP_RISK_DET_LOW]				[INT] NOT NULL DEFAULT 0,
			[L_APQP_RISK_DET_MEDIUM]			[INT] NOT NULL DEFAULT 0,
			[L_APQP_RISK_DET_HIGH]				[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[F_APQP_RISK_DET_COMPLETED]			[DATE]	NULL,
			-- ===========================
			[O_APQP_RISK_DET]					[INT] NOT NULL,
			-- ===========================
			[C_APQP_RISK_DET]					[VARCHAR](500) NOT NULL DEFAULT ''
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_RISK_DET]
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
ALTER TABLE [dbo].[APQP_RISK_DET]	
	ADD CONSTRAINT [K_APQP_RISK_DET]
		PRIMARY KEY CLUSTERED ([K_APQP_RISK_DET])
GO
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////