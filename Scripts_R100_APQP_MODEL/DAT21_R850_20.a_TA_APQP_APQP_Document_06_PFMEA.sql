-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_PFMEA
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_PFMEA_HDR]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_PFMEA_HDR]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_PFMEA_DET]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_PFMEA_DET]
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_PFMEA_HDR				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_PFMEA_HDR]	(
			-- ============================	
			[K_APQP_PFMEA_HDR]					[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_MODEL_HDR]					[INT],
			-- ===========================
			[K_STATUS_APQP_DOCUMENT]			[INT] NOT NULL DEFAULT 0,
			[F_APQP_PFMEA_HDR_CREATED]			[DATE]	NOT NULL,
			-- ===========================
			[APQP_PFMEA_SUMMARY]				[DECIMAL](10,2)	NOT NULL DEFAULT 0
			-- ===========================

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_PFMEA_HDR]
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
ALTER TABLE [dbo].[APQP_PFMEA_HDR]	
	ADD CONSTRAINT [K_APQP_PFMEA_HDR]
		PRIMARY KEY CLUSTERED ([K_APQP_PFMEA_HDR])
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_PFMEA_DET
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_PFMEA_DET]	(
			-- ============================	
			[K_APQP_PFMEA_DET]					[INT] IDENTITY (1,1)	NOT NULL,
			[K_APQP_PFMEA_HDR]					[INT] NOT NULL DEFAULT 0,
			[K_APQP_PFMEA_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[L_APQP_PFMEA_DET_YES]				[INT] NOT NULL DEFAULT 0,
			[L_APQP_PFMEA_DET_NO]				[INT] NOT NULL DEFAULT 0,
			[L_APQP_PFMEA_DET_NA]				[INT] NOT NULL DEFAULT 0,
			-- ===========================
			[F_APQP_PFMEA_DET_COMPLETED]		[DATE]	NULL,
			-- ===========================
			[O_APQP_PFMEA_DET]					[INT] NOT NULL,
			-- ===========================
			[C_APQP_PFMEA_DET]					[VARCHAR](500) NOT NULL DEFAULT ''
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_PFMEA_DET]
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
ALTER TABLE [dbo].[APQP_PFMEA_DET]	
	ADD CONSTRAINT [K_APQP_PFMEA_DET]
		PRIMARY KEY CLUSTERED ([K_APQP_PFMEA_DET])
GO
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////