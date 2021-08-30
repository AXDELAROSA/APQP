-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			DATA_02
-- // OPERATION:		CARGA COMBO
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX DE LA ROSA			
-- // CREATION DATE:	20210118
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////		CONTENIDO DEL SP
--	[PG_CB_PROGRAM_APQP_MODEL]
--	[PG_CB_STATUS_APQP_MODEL_HDR]
--	[PG_CB_APQP_MODEL_HDR_TYPE]
-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_APQP_MODEL
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_PROGRAM_APQP_MODEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_PROGRAM_APQP_MODEL]
GO
--		 EXECUTE [dbo].[PG_CB_PROGRAM_APQP_MODEL] 0,139,07
--		 EXECUTE [dbo].[PG_CB_PROGRAM_APQP_MODEL] 0,139,13
--		 EXECUTE [dbo].[PG_CB_PROGRAM_APQP_MODEL] 0,139,20
--		 EXECUTE [dbo].[PG_CB_PROGRAM_APQP_MODEL] 0,139,-1
CREATE PROCEDURE [dbo].[PG_CB_PROGRAM_APQP_MODEL]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_K_ARCUSFIL				INT
	--@PP_L_CON_TODOS				INT,
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_ARCUSFIL_PROGRAM		AS K_COMBOBOX,
				S_ARCUSFIL_PROGRAM		AS D_COMBOBOX
	FROM	ARCUSFIL_PROGRAM
	WHERE	L_ARCUSFIL_PROGRAM	= 1
	AND		K_ARCUSFIL			= @PP_K_ARCUSFIL
	ORDER BY S_ARCUSFIL_PROGRAM

	INSERT INTO @VP_TA_CATALOGO
		( TA_K_CATALOGO,	TA_D_CATALOGO	)
	VALUES
		( -1,	'( SELEECIONE UNA OPCIÓN )'	)

	SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
				TA_D_CATALOGO	AS D_COMBOBOX 
	FROM		@VP_TA_CATALOGO
	ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_APQP_MODEL_HDR
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_STATUS_APQP_MODEL_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR]
GO
--		 EXECUTE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR] 0,139,0,10
--		 EXECUTE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR] 0,139,0,20
CREATE PROCEDURE [dbo].[PG_CB_STATUS_APQP_MODEL_HDR]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT,
	@PP_K_STATUS_CLASS			INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_STATUS_APQP_MODEL				AS K_COMBOBOX,
				D_STATUS_APQP_MODEL				AS D_COMBOBOX
	FROM	STATUS_APQP_MODEL
	WHERE	L_STATUS_APQP_MODEL			= 1
	AND		K_STATUS_APQP_MODEL_CLASS	IN	(0, @PP_K_STATUS_CLASS)
	ORDER BY D_STATUS_APQP_MODEL


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
--	SE UTILIZAN EN LA FO_APQP_MODEL_HDR
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> PARA CARGAR LOS ESTADOS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CB_APQP_MODEL_HDR_TYPE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CB_APQP_MODEL_HDR_TYPE]
GO
--		 EXECUTE [dbo].[PG_CB_APQP_MODEL_HDR_TYPE] 0,139,1
CREATE PROCEDURE [dbo].[PG_CB_APQP_MODEL_HDR_TYPE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO				INT,
	--============================
	@PP_L_CON_TODOS				INT
AS
	DECLARE @VP_TA_CATALOGO	AS TABLE
				(	TA_K_CATALOGO		INT,
					TA_D_CATALOGO		VARCHAR(50)	)	
	INSERT INTO @VP_TA_CATALOGO 
	SELECT		K_APQP_MODEL_HDR_TYPE				AS K_COMBOBOX,
				D_APQP_MODEL_HDR_TYPE				AS D_COMBOBOX
	FROM		APQP_MODEL_HDR_TYPE
	WHERE		L_APQP_MODEL_HDR_TYPE = 1
	ORDER BY	D_APQP_MODEL_HDR_TYPE


	IF @PP_L_CON_TODOS=1
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( SELECT ONE OPTION )'	)
	END
	ELSE IF @PP_L_CON_TODOS=2
	BEGIN
		INSERT INTO @VP_TA_CATALOGO
			( TA_K_CATALOGO,	TA_D_CATALOGO	)
		VALUES
			( -1,				'( ALL )'	)
	END

		SELECT		TA_K_CATALOGO	AS K_COMBOBOX,
					TA_D_CATALOGO	AS D_COMBOBOX 
		FROM		@VP_TA_CATALOGO
		ORDER BY	TA_D_CATALOGO 
	-- ==========================================

	-- ////////////////////////////////////////////////////
GO
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////