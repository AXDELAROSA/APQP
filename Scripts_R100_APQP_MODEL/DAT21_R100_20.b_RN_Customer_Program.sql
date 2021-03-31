-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			ARCUSFIL_PROGRAM
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_UNIQUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UNIQUE]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UNIQUE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT],	
	@PP_S_ARCUSFIL_PROGRAM				[VARCHAR] (20),
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	DECLARE @VP_N_ARCUSFIL_PROGRAM_X_D_ARCUSFIL_PROGRAM			INT		

	SELECT	@VP_N_ARCUSFIL_PROGRAM_X_D_ARCUSFIL_PROGRAM		 =		COUNT	(ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM)
	FROM	ARCUSFIL_PROGRAM
	WHERE	ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM<>@PP_K_ARCUSFIL_PROGRAM
	AND		ARCUSFIL_PROGRAM.S_ARCUSFIL_PROGRAM=@PP_S_ARCUSFIL_PROGRAM

	IF @VP_N_ARCUSFIL_PROGRAM_X_D_ARCUSFIL_PROGRAM>0
	BEGIN
			SET @VP_RESULTADO =  '[ARCUSFIL_PROGRAM] exist ['+@PP_S_ARCUSFIL_PROGRAM+'].'
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_ITS_DELETEABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ITS_DELETEABLE]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ITS_DELETEABLE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
-- /////////////////////////////////////////////////////
	--DECLARE @VP_PO_X_ARCUSFIL_PROGRAM		INT = 0

	--SELECT	@VP_PO_X_ARCUSFIL_PROGRAM =		COUNT	(DETAILS_PURCHASE_ORDER.K_ARCUSFIL_PROGRAM)
	--							FROM	DETAILS_PURCHASE_ORDER
	--							WHERE	DETAILS_PURCHASE_ORDER.K_ARCUSFIL_PROGRAM=@PP_K_ARCUSFIL_PROGRAM
	---- =============================
	--IF @VP_RESULTADO=''
	--	IF @VP_PO_X_ARCUSFIL_PROGRAM>0
	--		SET @VP_RESULTADO =  'El [ARCUSFIL_PROGRAM] se encuentra agregado a una o más Ordenes de Compra.'
	-- /////////////////////////////////////////////////////
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_EXISTS
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTS]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTS]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT],
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- /////////////////////////////////////////////////////
	DECLARE @VP_K_ARCUSFIL_PROGRAM				INT
	DECLARE @VP_L_BORRADO				INT
		
	SELECT	@VP_K_ARCUSFIL_PROGRAM	=		ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM,
			@VP_L_BORRADO			=		ARCUSFIL_PROGRAM.L_BORRADO
	FROM	ARCUSFIL_PROGRAM
	WHERE	ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM=@PP_K_ARCUSFIL_PROGRAM										
	-- ===========================
	IF @VP_RESULTADO=''
		IF ( @VP_K_ARCUSFIL_PROGRAM IS NULL )
			SET @VP_RESULTADO =  '[ARCUSFIL_PROGRAM] not exist'
	-- ===========================
	IF @VP_RESULTADO=''
		IF @VP_L_BORRADO=1
			SET @VP_RESULTADO =  '[ARCUSFIL_PROGRAM] was down.'
	-- /////////////////////////////////////////////////////	
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_CLAVE_EXISTE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_CLAVE_EXISTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_CLAVE_EXISTE]
GO

CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_CLAVE_EXISTE]
	@PP_K_SISTEMA_EXE			INT,
	@PP_K_USUARIO_ACCION		INT,
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM		INT,
	-- ===========================		
	@OU_RESULTADO_VALIDACION	VARCHAR(300)	OUTPUT
AS
	DECLARE @VP_RESULTADO		VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO='' 
		BEGIN
		DECLARE @VP_EXISTE_CLAVE	INT

		SELECT	@VP_EXISTE_CLAVE	=	COUNT(K_ARCUSFIL_PROGRAM)
		FROM	ARCUSFIL_PROGRAM 
		WHERE	K_ARCUSFIL_PROGRAM	=	@PP_K_ARCUSFIL_PROGRAM
		IF @VP_EXISTE_CLAVE>0
			SET @VP_RESULTADO =  '[ARCUSFIL_PROGRAM] ID not available.'
		END			
	-- ///////////////////////////////////////////		
	SET @OU_RESULTADO_VALIDACION = @VP_RESULTADO
	-- /////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> RN_DELETE
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_DELETE]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_DELETE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTS]		@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_ARCUSFIL_PROGRAM,	 
													@OU_RESULTADO_VALIDACION = @VP_RESULTADO		OUTPUT
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_ITS_DELETEABLE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
													@PP_K_ARCUSFIL_PROGRAM,	 
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_INSERT]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_INSERT]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_CLAVE_EXISTE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
															@PP_K_ARCUSFIL_PROGRAM,	 
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
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_RN_ARCUSFIL_PROGRAM_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UPDATE]
GO
CREATE PROCEDURE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UPDATE]
	@PP_K_SISTEMA_EXE					[INT],
	@PP_K_USUARIO_ACCION				[INT],
	-- ===========================		
	@PP_K_ARCUSFIL_PROGRAM				[INT],	
	-- ===========================		
	@OU_RESULTADO_VALIDACION			[VARCHAR] (200)		OUTPUT
AS
	DECLARE @VP_RESULTADO				VARCHAR(300) = ''		
	-- ///////////////////////////////////////////
	IF @VP_RESULTADO=''
		EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_EXISTS]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
														@PP_K_ARCUSFIL_PROGRAM,	 
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
