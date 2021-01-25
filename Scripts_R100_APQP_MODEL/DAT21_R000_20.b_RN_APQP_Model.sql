-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		REGLAS NEGOCIO
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210122
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_UNIQUE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_UNIQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_UNIQUE]
GO
CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_UNIQUE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_APQP_MODEL					[INT],	
	@PP_D_APQP_MODEL					[VARCHAR] (255),
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	DECLARE @VP_N_APQP_MODEL_X_D_APQP_MODEL			INT		

	SELECT	@VP_N_APQP_MODEL_X_D_APQP_MODEL		 =		COUNT	(APQP_MODEL_SQL.K_APQP_MODEL)
											FROM	APQP_MODEL
											WHERE	APQP_MODEL.A4GLIdentity<>@PP_K_APQP_MODEL
											AND		APQP_MODEL.D_APQP_MODEL=@PP_D_APQP_MODEL

	IF @VP_N_APQP_MODEL_X_D_APQP_MODEL>0
	BEGIN
			SET @VP_RESULTADO =  '[APQP_MODEL] exist ['+@PP_D_APQP_MODEL+'].'
	END
	-- ///////////////////////////////////////////		
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UNI//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_BORRABLE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_ITS_DELETEABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_ITS_DELETEABLE]
GO
CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_ITS_DELETEABLE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_APQP_MODEL					[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
-- /////////////////////////////////////////////////////
	--DECLARE @VP_PO_X_APQP_MODEL		INT = 0

	--SELECT	@VP_PO_X_APQP_MODEL =		COUNT	(DETAILS_PURCHASE_ORDER.A4GLIdentity)
	--							FROM	DETAILS_PURCHASE_ORDER
	--							WHERE	DETAILS_PURCHASE_ORDER.A4GLIdentity=@PP_K_APQP_MODEL
	---- =============================
	--IF @VP_RESULTADO=''
	--	IF @VP_PO_X_APQP_MODEL>0
	--		SET @VP_RESULTADO =  'El [APQP_MODEL] se encuentra agregado a una o más Ordenes de Compra.'
	-- /////////////////////////////////////////////////////
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_EXISTS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_EXISTS]
GO
CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_EXISTS]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_APQP_MODEL						[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- /////////////////////////////////////////////////////
	DECLARE @VP_K_APQP_MODEL				INT
	DECLARE @VP_L_BORRADO				INT
		
	SELECT	@VP_K_APQP_MODEL	=		APQP_MODEL.K_APQP_MODEL,
			@VP_L_BORRADO		=		APQP_MODEL.L_BORRADO
									FROM	APQP_MODEL_SQL
									WHERE	APQP_MODEL_SQL.A4GLIdentity=@PP_K_APQP_MODEL										
	-- ===========================
	IF @VP_RESULTADO=''
		IF ( @VP_K_APQP_MODEL IS NULL )
			SET @VP_RESULTADO =  '[CUSTOMER] not exist'
	-- ===========================
	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  '[CUSTOMER] was down.'
	-- /////////////////////////////////////////////////////	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_CLAVE_EXISTE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_CLAVE_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_CLAVE_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_CLAVE_EXISTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_APQP_MODEL					INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO		VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO='' 
		BEGIN
		DECLARE @VP_EXISTE_CLAVE	INT

		SELECT	@VP_EXISTE_CLAVE =	COUNT(A4GLIdentity)
									FROM	APQP_MODEL_SQL 
									WHERE A4GLIdentity=@PP_K_APQP_MODEL
		IF @VP_EXISTE_CLAVE>0
			SET @VP_RESULTADO =  '[CUSTOMER] ID not available.'
		END			
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_DELETE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_DELETE]
GO
CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_DELETE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_APQP_MODEL							[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_APQP_MODEL_EXISTS]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_APQP_MODEL,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_APQP_MODEL_ITS_DELETEABLE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_APQP_MODEL,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //DEL//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_INSERT]
GO
CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_INSERT]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_APQP_MODEL						[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_APQP_MODEL_CLAVE_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_APQP_MODEL,	 
												@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //INS//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_UPDATE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_APQP_MODEL_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_APQP_MODEL_UPDATE]
GO
CREATE PROCEDURE [dbo].[PG_RN_APQP_MODEL_UPDATE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_APQP_MODEL							[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_APQP_MODEL_EXISTS]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_APQP_MODEL,	 
												@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- //////////////////////////////////////	
	IF	@VP_RESULTADO<>''
		SET	@VP_RESULTADO = @VP_RESULTADO + ' //UPD//'	
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////
