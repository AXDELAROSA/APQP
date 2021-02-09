-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_DOCUMENT_STATUS
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[STATUS_APQP_DOCUMENT]') AND type in (N'U'))
	DROP TABLE [dbo].[STATUS_APQP_DOCUMENT]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_STATUS_APQP_DOCUMENT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_STATUS_APQP_DOCUMENT]
GO

-- ////////////////////////////////////////////////////////////////
-- //					STATUS_APQP_DOCUMENT				 
-- ////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[STATUS_APQP_DOCUMENT] (
	[K_STATUS_APQP_DOCUMENT]				[INT]			NOT NULL,
	[D_STATUS_APQP_DOCUMENT]				[VARCHAR](100)	NOT NULL,
	[C_STATUS_APQP_DOCUMENT]				[VARCHAR](255)	NOT NULL,
	[S_STATUS_APQP_DOCUMENT]				[VARCHAR](10)	NOT NULL,
	[O_STATUS_APQP_DOCUMENT]				[INT]			NOT NULL,
	[L_STATUS_APQP_DOCUMENT]				[INT]			NOT NULL
	--,[K_STATUS_APQP_DOCUMENT_CLASS]			[INT]			NOT NULL
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[STATUS_APQP_DOCUMENT]
	ADD CONSTRAINT [PK_STATUS_APQP_DOCUMENT]
		PRIMARY KEY CLUSTERED ([K_STATUS_APQP_DOCUMENT])
GO
CREATE UNIQUE NONCLUSTERED 
	INDEX [UN_STATUS_APQP_DOCUMENT_01_DESCRIPCION] 
	   ON [dbo].[STATUS_APQP_DOCUMENT] ( [D_STATUS_APQP_DOCUMENT] )
GO

-- //////////////////////////////////////////////////////////////
-- //				CI - STATUS_APQP_DOCUMENT
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_STATUS_APQP_DOCUMENT]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_STATUS_APQP_DOCUMENT			INT,
	@PP_D_STATUS_APQP_DOCUMENT			VARCHAR(100),
	@PP_C_STATUS_APQP_DOCUMENT			VARCHAR(255),
	@PP_S_STATUS_APQP_DOCUMENT			VARCHAR(10),
	@PP_O_STATUS_APQP_DOCUMENT			INT,
	@PP_L_STATUS_APQP_DOCUMENT			INT
	--,@PP_K_STATUS_APQP_DOCUMENT_CLASS	INT
AS
	-- ===========================
	INSERT INTO STATUS_APQP_DOCUMENT
			(	[K_STATUS_APQP_DOCUMENT], [D_STATUS_APQP_DOCUMENT], 
				[C_STATUS_APQP_DOCUMENT], [S_STATUS_APQP_DOCUMENT], 
				[O_STATUS_APQP_DOCUMENT], [L_STATUS_APQP_DOCUMENT]
				--,[K_STATUS_APQP_DOCUMENT_CLASS]		
			)
	VALUES	
			(	@PP_K_STATUS_APQP_DOCUMENT, @PP_D_STATUS_APQP_DOCUMENT, 
				@PP_C_STATUS_APQP_DOCUMENT, @PP_S_STATUS_APQP_DOCUMENT,
				@PP_O_STATUS_APQP_DOCUMENT, @PP_L_STATUS_APQP_DOCUMENT
				--,@PP_K_STATUS_APQP_DOCUMENT_CLASS	
			)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ============================================================================================================
--	ESTATUS PARA EL CIERRE EL ENCABEZADO DE APQP_MODEL
EXECUTE [dbo].[PG_CI_STATUS_APQP_DOCUMENT]  0, 139,	00, '( POR DEFINIR )'		,'' , 'XDEFI'	, 00 , 1
EXECUTE [dbo].[PG_CI_STATUS_APQP_DOCUMENT]  0, 139,	01, 'COMPLETO'				,'' , 'COMPL'	, 10 , 1
EXECUTE [dbo].[PG_CI_STATUS_APQP_DOCUMENT]  0, 139,	02, 'INCOMPLETO'			,'' , 'ICOMP'	, 20 , 1
SET NOCOUNT OFF
GO
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////