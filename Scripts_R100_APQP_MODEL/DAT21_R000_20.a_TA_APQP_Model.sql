-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210122
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02Pruebas]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // DROPs
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_MODEL]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_MODEL]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATUS_APQP_MODEL]') AND type in (N'U'))
	DROP TABLE [dbo].[STATUS_APQP_MODEL]
GO


-- ////////////////////////////////////////////////////////////////
-- //					STATUS_APQP_MODEL				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[STATUS_APQP_MODEL] (
	[K_STATUS_APQP_MODEL]				[INT]			NOT NULL,
	[D_STATUS_APQP_MODEL]				[VARCHAR](100)	NOT NULL,
	[C_STATUS_APQP_MODEL]				[VARCHAR](255)	NOT NULL,
	[S_STATUS_APQP_MODEL]				[VARCHAR](10)	NOT NULL,
	[O_STATUS_APQP_MODEL]				[INT]			NOT NULL,
	[L_STATUS_APQP_MODEL]				[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[STATUS_APQP_MODEL]
	ADD CONSTRAINT [PK_STATUS_APQP_MODEL]
		PRIMARY KEY CLUSTERED ([K_STATUS_APQP_MODEL])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_STATUS_APQP_MODEL_01_DESCRIPCION] 
	   ON [dbo].[STATUS_APQP_MODEL] ( [D_STATUS_APQP_MODEL] )
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATUS_APQP_MODEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATUS_APQP_MODEL]
GO
-- //////////////////////////////////////////////////////////////
-- //				CI - STATUS_APQP_MODEL
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_STATUS_APQP_MODEL]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_STATUS_APQP_MODEL			INT,
	@PP_D_STATUS_APQP_MODEL			VARCHAR(100),
	@PP_C_STATUS_APQP_MODEL			VARCHAR(255),
	@PP_S_STATUS_APQP_MODEL			VARCHAR(10),
	@PP_O_STATUS_APQP_MODEL			INT,
	@PP_L_STATUS_APQP_MODEL			INT
AS
	-- ===========================
	INSERT INTO STATUS_APQP_MODEL
			(	[K_STATUS_APQP_MODEL], [D_STATUS_APQP_MODEL], 
				[C_STATUS_APQP_MODEL], [S_STATUS_APQP_MODEL], 
				[O_STATUS_APQP_MODEL], [L_STATUS_APQP_MODEL]		)
	VALUES	
			(	@PP_K_STATUS_APQP_MODEL, @PP_D_STATUS_APQP_MODEL, 
				@PP_C_STATUS_APQP_MODEL, @PP_S_STATUS_APQP_MODEL,
				@PP_O_STATUS_APQP_MODEL, @PP_L_STATUS_APQP_MODEL	)		
	-- //////////////////////////////////////////////////////////////
GO

EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	00, '( TO DEFINE )'			,'' , '2DFINE'	, 00 , 1
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	01, 'ACTIVE'				,'' , 'ACTIV'	, 10 , 1
EXECUTE [dbo].[PG_CI_STATUS_APQP_MODEL]  0, 139,	02, 'INACTIVE'				,'' , 'INACT'	, 20 , 1
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_MODEL				 
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_MODEL]	(
			-- ============================	
			-- CAMPOS ORIGINALES DE LA TABLA INTEGRADOS
			[K_APQP_MODEL]						[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_MODEL]						[VARCHAR](255),
			[C_APQP_MODEL]						[VARCHAR](500)	NOT NULL,
			-- ===========================
			[APQP_MODEL_NUMBER]					[VARCHAR](255),
			[F_APQP_MODEL_DATE_CREATED]			[DATE]	NOT NULL,
			-- ===========================
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APQP_MODEL]
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
ALTER TABLE [dbo].[APQP_MODEL]	
	ADD CONSTRAINT [K_APQP_MODEL]
		PRIMARY KEY CLUSTERED ([K_APQP_MODEL])
GO