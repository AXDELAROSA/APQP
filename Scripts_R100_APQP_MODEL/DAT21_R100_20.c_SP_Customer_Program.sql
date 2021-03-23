-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			ARCUSFIL_PROGRAM
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210119
-- ////////////////////////////////////////////////////////////// 

--USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_ARCUSFIL_PROGRAM]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_ARCUSFIL_PROGRAM]
GO
--		 SELECT * FROM ARCUSFIL_PROGRAM
--		 EXECUTE [dbo].[PG_LI_ARCUSFIL_PROGRAM] 0,139,13,0
--		 EXECUTE [dbo].[PG_LI_ARCUSFIL_PROGRAM] 0,139,13,1
CREATE PROCEDURE [dbo].[PG_LI_ARCUSFIL_PROGRAM]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_ARCUSFIL					VARCHAR(200),
	@PP_L_DESGLOSAR					INT
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- ==================================================================================
IF @PP_L_DESGLOSAR = 1
BEGIN
	SELECT		TOP (5000)
				CUS_NO,	A4GLIDENTITY,
				ARCUSFIL_PROGRAM.S_ARCUSFIL_PROGRAM,
				S_ARCUSFIL_PROGRAM_OPTION	AS OPTION_01,
				-- =========================================
				(CASE
					WHEN	D_ARCUSFIL_PROGRAM_OPTION=''	THEN	'----'
					ELSE	D_ARCUSFIL_PROGRAM_OPTION
				END)	AS	OPTION_02,
				-- =========================================
				(CASE
					WHEN	ARCUSFIL_PROGRAM_OPTION_MODEL=''	THEN	'----'
					ELSE	ARCUSFIL_PROGRAM_OPTION_MODEL
				END)	AS	MODEL,
				-- =========================================
				(CASE
					WHEN	ARCUSFIL_PROGRAM_OPTION_YEAR=''	THEN	'----'
					ELSE	ARCUSFIL_PROGRAM_OPTION_YEAR
				END)	AS	[YEAR],
				-- =========================================
				(CASE
					WHEN	ARCUSFIL_PROGRAM_OPTION_MAKER=''	THEN	'----'
					ELSE	ARCUSFIL_PROGRAM_OPTION_MAKER
				END)	AS	MAKER,
				-- =========================================
				ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM_OPTION,
				ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM
				-- =============================	
	FROM		ARCUSFIL_SQL
	INNER JOIN	ARCUSFIL_PROGRAM		ON ARCUSFIL_PROGRAM.K_ARCUSFIL=ARCUSFIL_SQL.A4GLIdentity
	INNER JOIN	ARCUSFIL_PROGRAM_OPTION	ON ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM=ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM
				-- =============================
	WHERE		ARCUSFIL_PROGRAM.L_BORRADO<>1
	AND			( @PP_K_ARCUSFIL=-1					OR	ARCUSFIL_PROGRAM.K_ARCUSFIL=@PP_K_ARCUSFIL)
				-- =============================
	ORDER BY	CUS_NO	,ARCUSFIL_PROGRAM.S_ARCUSFIL_PROGRAM
END
ELSE
BEGIN
	SELECT		TOP (5000)
				CUS_NO,
				ARCUSFIL_PROGRAM.S_ARCUSFIL_PROGRAM,
				-- =============================	
				ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM
	FROM		ARCUSFIL_SQL
	INNER JOIN	ARCUSFIL_PROGRAM		ON ARCUSFIL_PROGRAM.K_ARCUSFIL=ARCUSFIL_SQL.A4GLIdentity
	--INNER JOIN	ARCUSFIL_PROGRAM_OPTION	ON ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM=ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM
				-- =============================
	WHERE		ARCUSFIL_PROGRAM.L_BORRADO<>1
	AND			( @PP_K_ARCUSFIL=-1					OR	ARCUSFIL_PROGRAM.K_ARCUSFIL=@PP_K_ARCUSFIL)
				-- =============================
	ORDER BY	CUS_NO	,ARCUSFIL_PROGRAM.S_ARCUSFIL_PROGRAM
END
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_ARCUSFIL_PROGRAM_OPTION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_ARCUSFIL_PROGRAM_OPTION]
GO
-- SELECT * FROM ARCUSFIL_PROGRAM_OPTION
--		 EXECUTE [dbo].[PG_LI_ARCUSFIL_PROGRAM_OPTION] 0,139,6
CREATE PROCEDURE [dbo].[PG_LI_ARCUSFIL_PROGRAM_OPTION]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM			VARCHAR(200)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		TOP(500)
				S_ARCUSFIL_PROGRAM_OPTION	AS OPTION_01,
				-- =========================================
				(CASE
					WHEN	D_ARCUSFIL_PROGRAM_OPTION=''	THEN	'----'
					ELSE	D_ARCUSFIL_PROGRAM_OPTION
				END)	AS	OPTION_02,
				-- =========================================
				(CASE
					WHEN	ARCUSFIL_PROGRAM_OPTION_MODEL=''	THEN	'----'
					ELSE	ARCUSFIL_PROGRAM_OPTION_MODEL
				END)	AS	MODEL,
				-- =========================================
				(CASE
					WHEN	ARCUSFIL_PROGRAM_OPTION_YEAR=''	THEN	'----'
					ELSE	ARCUSFIL_PROGRAM_OPTION_YEAR
				END)	AS	[YEAR],
				-- =========================================
				(CASE
					WHEN	ARCUSFIL_PROGRAM_OPTION_MAKER=''	THEN	'----'
					ELSE	ARCUSFIL_PROGRAM_OPTION_MAKER
				END)	AS	MAKER,
				-- =========================================
				ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM_OPTION
				,ARCUSFIL_PROGRAM_OPTION.*
				-- =============================	
	FROM		ARCUSFIL_PROGRAM_OPTION
	INNER JOIN	ARCUSFIL_PROGRAM				ON	ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM=ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM
				-- =============================
	WHERE		ARCUSFIL_PROGRAM.L_BORRADO<>1
	AND			ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM=@PP_K_ARCUSFIL_PROGRAM
				-- =============================
	ORDER BY	ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM ,K_ARCUSFIL_PROGRAM_OPTION
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_ARCUSFIL_PROGRAM]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_ARCUSFIL_PROGRAM]
GO
--		 EXECUTE [dbo].[PG_SK_ARCUSFIL_PROGRAM] 0,139,32
CREATE PROCEDURE [dbo].[PG_SK_ARCUSFIL_PROGRAM]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM			INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				ARCUSFIL_PROGRAM.*
				-- =============================	
	FROM		ARCUSFIL_PROGRAM
				-- =============================
	WHERE		ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM=@PP_K_ARCUSFIL_PROGRAM
				-- =============================
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_ARCUSFIL_PROGRAM_OPTION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_ARCUSFIL_PROGRAM_OPTION]
GO
--		 EXECUTE [dbo].[PG_SK_ARCUSFIL_PROGRAM_OPTION] 0,139,32
CREATE PROCEDURE [dbo].[PG_SK_ARCUSFIL_PROGRAM_OPTION]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM_OPTION	INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				ARCUSFIL_PROGRAM_OPTION.*
				-- =============================	
	FROM		ARCUSFIL_PROGRAM_OPTION
				-- =============================
	WHERE		ARCUSFIL_PROGRAM_OPTION.K_ARCUSFIL_PROGRAM_OPTION=@PP_K_ARCUSFIL_PROGRAM_OPTION
				-- =============================
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_ARCUSFIL_PROGRAM]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_ARCUSFIL_PROGRAM]
GO
--		 EXECUTE [dbo].[PG_IN_ARCUSFIL_PROGRAM] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_ARCUSFIL_PROGRAM]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_S_ARCUSFIL_PROGRAM				VARCHAR(20),
	-- ===========================
	@PP_K_ARCUSFIL						INT
AS
	DECLARE @VP_MENSAJE					VARCHAR(300) = ''
			,@VP_K_ARCUSFIL_PROGRAM		INT = 0
BEGIN TRANSACTION 
BEGIN TRY
	---- /////////////////////////////////////////////////////////////////////
	-- ===========================
	INSERT INTO ARCUSFIL_PROGRAM
			(	[S_ARCUSFIL_PROGRAM],
				-- ===========================
				[K_ARCUSFIL],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@PP_S_ARCUSFIL_PROGRAM,
				-- ===========================
				@PP_K_ARCUSFIL,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			--SET @VP_MENSAJE='El ARCUSFIL_PROGRAM no fue insertado. [ARCUSFIL_PROGRAM#'+CONVERT(VARCHAR(10),@VP_K_ARCUSFIL_PROGRAM)+']'
			SET @VP_MENSAJE='The record was not inserted.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			SELECT @VP_K_ARCUSFIL_PROGRAM=SCOPE_IDENTITY()

			IF @VP_K_ARCUSFIL_PROGRAM=NULL
			BEGIN
				--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
				SET @VP_MENSAJE='The record was not inserted.(identity)'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
		END
	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_ARCUSFIL_PROGRAM AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_ARCUSFIL_PROGRAM_OPTION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_ARCUSFIL_PROGRAM_OPTION]
GO
--		 EXECUTE [dbo].[PG_IN_ARCUSFIL_PROGRAM_OPTION] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_ARCUSFIL_PROGRAM_OPTION]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM				INT,
	-- ===========================
	@PP_D_ARCUSFIL_PROGRAM_OPTION		VARCHAR(255),
	@PP_S_ARCUSFIL_PROGRAM_OPTION		VARCHAR(20),
	-- ===========================
	@PP_ARCUSFIL_PROGRAM_OPTION_MODEL	VARCHAR(255),
	@PP_ARCUSFIL_PROGRAM_OPTION_YEAR	VARCHAR(20),
	@PP_ARCUSFIL_PROGRAM_OPTION_MAKER	VARCHAR(255)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_K_ARCUSFIL_PROGRAM			INT = 0
BEGIN TRANSACTION 
BEGIN TRY
	---- /////////////////////////////////////////////////////////////////////
	INSERT INTO ARCUSFIL_PROGRAM_OPTION
			(	[D_ARCUSFIL_PROGRAM_OPTION],			
				[S_ARCUSFIL_PROGRAM_OPTION],
				-- ===========================
				[K_ARCUSFIL_PROGRAM],
				-- ===========================
				[ARCUSFIL_PROGRAM_OPTION_MODEL],		[ARCUSFIL_PROGRAM_OPTION_YEAR],
				[ARCUSFIL_PROGRAM_OPTION_MAKER],			
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]		)
	VALUES	
			(	@PP_D_ARCUSFIL_PROGRAM_OPTION,			
				@PP_S_ARCUSFIL_PROGRAM_OPTION,
				-- ===========================
				@PP_K_ARCUSFIL_PROGRAM,
				-- ===========================
				@PP_ARCUSFIL_PROGRAM_OPTION_MODEL,		@PP_ARCUSFIL_PROGRAM_OPTION_YEAR,
				@PP_ARCUSFIL_PROGRAM_OPTION_MAKER,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )
	
	IF @@ROWCOUNT = 0
	BEGIN
		--SET @VP_MENSAJE='El ARCUSFIL_PROGRAM no fue insertado. [ARCUSFIL_PROGRAM#'+CONVERT(VARCHAR(10),@VP_K_ARCUSFIL_PROGRAM)+']'
		SET @VP_MENSAJE='The record was not inserted.'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	ELSE
	BEGIN
		SELECT @VP_K_ARCUSFIL_PROGRAM=SCOPE_IDENTITY()

		IF @VP_K_ARCUSFIL_PROGRAM=NULL
		BEGIN
			--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
			SET @VP_MENSAJE='The record was not inserted.(identity)'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
	END
	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_ARCUSFIL_PROGRAM AS CLAVE
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_ARCUSFIL_PROGRAM]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_ARCUSFIL_PROGRAM]
GO
-- EXECUTE [dbo].[PG_UP_ARCUSFIL_PROGRAM] 0,139,  1 , 21 , 'TELFONO IP' , '76855545649' , '' , 'PANASONIC' , 'KX-T7630' , '2,890.50' , 1 , 1 , 11 , 1
CREATE PROCEDURE [dbo].[PG_UP_ARCUSFIL_PROGRAM]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM				INT,
	@PP_S_ARCUSFIL_PROGRAM				VARCHAR(20),
	-- ===========================
	@PP_K_ARCUSFIL						INT
AS			
DECLARE @VP_MENSAJE					VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UPDATE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
												@PP_K_ARCUSFIL_PROGRAM, 
												@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	-- /////////////////////////////////////////////////////////////////////
	--IF @VP_MENSAJE<>''
	--BEGIN
	--	RAISERROR (@VP_MENSAJE, 16, 1 )
	--END
	--EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_UNIQUE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--											@PP_K_ARCUSFIL_PROGRAM, @PP_D_ARCUSFIL_PROGRAM,
	--											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	
		-- //////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END

	UPDATE	ARCUSFIL_PROGRAM
	SET		[S_ARCUSFIL_PROGRAM]				= @PP_S_ARCUSFIL_PROGRAM,
			-- ===========================	= -- ============================
			[K_ARCUSFIL]						= @PP_K_ARCUSFIL,
			-- ===========================	= -- ============================
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	K_ARCUSFIL_PROGRAM=@PP_K_ARCUSFIL_PROGRAM
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='El ARCUSFIL_PROGRAM no fue actualizado. [ARCUSFIL_PROGRAM#'+CONVERT(VARCHAR(10),@PP_K_ARCUSFIL_PROGRAM)+']'
		SET @VP_MENSAJE='The record was not Updated.'
		RAISERROR (@VP_MENSAJE, 16, 1 ) 
	END
-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
	BEGIN
		SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
	END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_ARCUSFIL_PROGRAM AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_ARCUSFIL_PROGRAM_OPTION]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_ARCUSFIL_PROGRAM_OPTION]
GO
--		 EXECUTE [dbo].[PG_UP_ARCUSFIL_PROGRAM_OPTION] 0,139,
CREATE PROCEDURE [dbo].[PG_UP_ARCUSFIL_PROGRAM_OPTION]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM_OPTION		INT,
	@PP_K_ARCUSFIL_PROGRAM				INT,
	-- ===========================
	@PP_D_ARCUSFIL_PROGRAM_OPTION		VARCHAR(255),
	@PP_S_ARCUSFIL_PROGRAM_OPTION		VARCHAR(20),
	-- ===========================
	@PP_ARCUSFIL_PROGRAM_OPTION_MODEL	VARCHAR(255),
	@PP_ARCUSFIL_PROGRAM_OPTION_YEAR	VARCHAR(20),
	@PP_ARCUSFIL_PROGRAM_OPTION_MAKER	VARCHAR(255)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	---- /////////////////////////////////////////////////////////////////////
	UPDATE	ARCUSFIL_PROGRAM_OPTION
	SET
			[D_ARCUSFIL_PROGRAM_OPTION]			= @PP_D_ARCUSFIL_PROGRAM_OPTION,			
			[S_ARCUSFIL_PROGRAM_OPTION]			= @PP_S_ARCUSFIL_PROGRAM_OPTION,
			-- ===========================		 -- ===========================
			[K_ARCUSFIL_PROGRAM]				= @PP_K_ARCUSFIL_PROGRAM,
			-- ===========================		 -- ===========================
			[ARCUSFIL_PROGRAM_OPTION_MODEL]		= @PP_ARCUSFIL_PROGRAM_OPTION_MODEL,		
			[ARCUSFIL_PROGRAM_OPTION_YEAR]		= @PP_ARCUSFIL_PROGRAM_OPTION_YEAR,
			[ARCUSFIL_PROGRAM_OPTION_MAKER]		= @PP_ARCUSFIL_PROGRAM_OPTION_MAKER,
			-- ===========================		 -- ===========================
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	K_ARCUSFIL_PROGRAM_OPTION=@PP_K_ARCUSFIL_PROGRAM_OPTION
	IF @@ROWCOUNT = 0
	BEGIN
		--SET @VP_MENSAJE='El ARCUSFIL_PROGRAM no fue insertado. [ARCUSFIL_PROGRAM#'+CONVERT(VARCHAR(10),@VP_K_ARCUSFIL_PROGRAM)+']'
		SET @VP_MENSAJE='The record was not inserted.'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	
	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_ARCUSFIL_PROGRAM_OPTION AS CLAVE
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
--  EXECUTE [dbo].[PG_SK_ARCUSFIL_PROGRAM] 0,139,9
--	EXECUTE [dbo].[PG_DL_ARCUSFIL_PROGRAM] 0,139,9
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_ARCUSFIL_PROGRAM]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_ARCUSFIL_PROGRAM]
GO

CREATE PROCEDURE [dbo].[PG_DL_ARCUSFIL_PROGRAM]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_ARCUSFIL_PROGRAM						INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	--/////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_ARCUSFIL_PROGRAM_DELETE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
											@PP_K_ARCUSFIL_PROGRAM, 
											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	--////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		BEGIN		
		UPDATE	ARCUSFIL_PROGRAM
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	K_ARCUSFIL_PROGRAM=@PP_K_ARCUSFIL_PROGRAM
	
		IF @@ROWCOUNT = 0
			BEGIN
				--DECLARE @VP_ERROR_2 VARCHAR(250)='No fue actualizado. [ARCUSFIL_PROGRAM#'+CONVERT(VARCHAR(10),@PP_K_ARCUSFIL_PROGRAM)+']'
				SET @VP_MENSAJE='The record was not inserted.'
				RAISERROR (@VP_MENSAJE, 16, 1 ) 
			END
		
		END

	-- /////////////////////////////////////////////////////////////////////
COMMIT TRANSACTION 
END TRY

BEGIN CATCH
	/* Ocurrió un error, deshacemos los cambios*/ 
	ROLLBACK TRANSACTION
	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
END CATCH
	
	IF @VP_MENSAJE<>''
		BEGIN
			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
		END

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_ARCUSFIL_PROGRAM AS CLAVE
	-- //////////////////////////////////////////////////////////////	
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////