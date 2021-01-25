-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			ARCUSFIL
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_ARCUSFIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_ARCUSFIL]
GO
-- SELECT * FROM ARCUSFIL
-- EXECUTE [dbo].[PG_LI_ARCUSFIL] 0,139,-1
CREATE PROCEDURE [dbo].[PG_LI_ARCUSFIL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_BUSCAR						VARCHAR(200)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		TOP (5000)
				(CASE
				WHEN	(SELECT COUNT(A4GLIdentity) FROM ARCUSFIL_ADDRESS WHERE A4GLIdentity=C.A4GLIdentity )	> 0	THEN	'YES'
				ELSE	'NO'
				END)	AS C_ADDRESS,
				(CASE
				WHEN	(SELECT COUNT(A4GLIdentity) FROM ARCUSFIL_CONTACT WHERE A4GLIdentity=C.A4GLIdentity )	> 0	THEN	'YES'
				ELSE	'NO'
				END)	AS C_CONTACT,
				D_COUNTRY, D_STATE_GEO,
				S_COUNTRY, S_STATE_GEO,
				C.*
				-- =============================	
	FROM		ARCUSFIL_SQL AS C
	INNER JOIN	BD_GENERAL.DBO.COUNTRY			ON	COUNTRY.K_COUNTRY=C.K_COUNTRY
	INNER JOIN	BD_GENERAL.DBO.STATE_GEO		ON	STATE_GEO.K_STATE_GEO=C.K_STATE_GEO
				-- =============================
	WHERE		C.L_BORRADO<>1
	AND			C.L_ARCUSFIL=1
	AND			A4GLIdentity<>0
				-- =============================
	ORDER BY	CUS_NO, CUS_NAME DESC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_ARCUSFIL_ADDRESS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_ARCUSFIL_ADDRESS]
GO
--		 EXECUTE [dbo].[PG_LI_ARCUSFIL_ADDRESS] 0,139,19
CREATE PROCEDURE [dbo].[PG_LI_ARCUSFIL_ADDRESS]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_A4GLIdentity					INT
AS
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		TOP (5000)
				D_ADDRESS_TYPE,			S_ADDRESS_TYPE,
				ARCUSFIL_ADDRESS.*
				-- =============================	
	FROM		ARCUSFIL_ADDRESS
	INNER JOIN	ADDRESS_TYPE			ON	ADDRESS_TYPE.K_ADDRESS_TYPE=ARCUSFIL_ADDRESS.K_ADDRESS_TYPE
	INNER JOIN	ARCUSFIL_SQL			ON	ARCUSFIL_SQL.A4GLIdentity=ARCUSFIL_ADDRESS.A4GLIdentity
				-- =============================
	WHERE		ARCUSFIL_ADDRESS.L_BORRADO=0
	AND			ARCUSFIL_ADDRESS.A4GLIdentity	= @PP_A4GLIdentity
				-- =============================
	ORDER BY	D_ADDRESS_TYPE, D_ARCUSFIL_ADDRESS_NAME DESC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_ARCUSFIL_CONTACT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_ARCUSFIL_CONTACT]
GO
--		 EXECUTE [dbo].[PG_LI_ARCUSFIL_CONTACT] 0,139,19
CREATE PROCEDURE [dbo].[PG_LI_ARCUSFIL_CONTACT]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_A4GLIdentity					INT
AS
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		TOP (5000)
				ARCUSFIL_CONTACT.*
				-- =============================	
	FROM		ARCUSFIL_CONTACT
	INNER JOIN	ARCUSFIL_SQL				ON	ARCUSFIL_SQL.A4GLIdentity=ARCUSFIL_CONTACT.A4GLIdentity
				-- =============================
	WHERE		ARCUSFIL_CONTACT.L_BORRADO=0
	AND			ARCUSFIL_CONTACT.A4GLIdentity	= @PP_A4GLIdentity
				-- =============================
	ORDER BY	D_ARCUSFIL_CONTACT_NAME		DESC
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_ARCUSFIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_ARCUSFIL]
GO
--		 EXECUTE [dbo].[PG_SK_ARCUSFIL] 0,139,32
CREATE PROCEDURE [dbo].[PG_SK_ARCUSFIL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_A4GLIdentity				INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				D_COUNTRY, D_STATE_GEO,
				S_COUNTRY, S_STATE_GEO,
				ARCUSFIL_SQL.*
				-- =============================	
	FROM		ARCUSFIL_SQL
	INNER JOIN	BD_GENERAL.DBO.COUNTRY			ON	COUNTRY.K_COUNTRY=ARCUSFIL_SQL.K_COUNTRY
	INNER JOIN	BD_GENERAL.DBO.STATE_GEO		ON	STATE_GEO.K_STATE_GEO=ARCUSFIL_SQL.K_STATE_GEO
				-- =============================
	WHERE		ARCUSFIL_SQL.L_BORRADO<>1
	AND			ARCUSFIL_SQL.A4GLIdentity=@PP_A4GLIdentity
				-- =============================
	ORDER BY	CUS_NO, CUS_NAME DESC		
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_ARCUSFIL_ADDRESS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_ARCUSFIL_ADDRESS]
GO
--		 EXECUTE [dbo].[PG_SK_ARCUSFIL_ADDRESS] 0,139,2
CREATE PROCEDURE [dbo].[PG_SK_ARCUSFIL_ADDRESS]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_A4GLIdentity_ADDRESS			INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				D_ADDRESS_TYPE,			S_ADDRESS_TYPE,
				ARCUSFIL_ADDRESS.*
				-- =============================	
	FROM		ARCUSFIL_ADDRESS
	INNER JOIN	ADDRESS_TYPE			ON	ADDRESS_TYPE.K_ADDRESS_TYPE=ARCUSFIL_ADDRESS.K_ADDRESS_TYPE
	INNER JOIN	ARCUSFIL_SQL			ON	ARCUSFIL_SQL.A4GLIdentity=ARCUSFIL_ADDRESS.A4GLIdentity
				-- =============================
	WHERE		ARCUSFIL_ADDRESS.L_BORRADO<>1
	AND			ARCUSFIL_ADDRESS.A4GLIdentity_ADDRESS	= @PP_A4GLIdentity_ADDRESS
				-- =============================
	ORDER BY	D_ADDRESS_TYPE, D_ARCUSFIL_ADDRESS_NAME DESC
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_ARCUSFIL_CONTACT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_ARCUSFIL_CONTACT]
GO
--		 EXECUTE [dbo].[PG_SK_ARCUSFIL_CONTACT] 0,139,32
CREATE PROCEDURE [dbo].[PG_SK_ARCUSFIL_CONTACT]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_A4GLIdentity_CONTACT			INT
AS
	-- ///////////////////////////////////////////
		SELECT		TOP (1)
				ARCUSFIL_CONTACT.*
				-- =============================	
	FROM		ARCUSFIL_CONTACT
	INNER JOIN	ARCUSFIL_SQL			ON	ARCUSFIL_SQL.A4GLIdentity=ARCUSFIL_CONTACT.A4GLIdentity
				-- =============================
	WHERE		ARCUSFIL_CONTACT.L_BORRADO<>1
	AND			ARCUSFIL_CONTACT.A4GLIdentity_CONTACT	= @PP_A4GLIdentity_CONTACT
				-- =============================
	ORDER BY	D_ARCUSFIL_CONTACT_NAME		DESC
	-- ////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_ARCUSFIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_ARCUSFIL]
GO
--		 EXECUTE [dbo].[PG_IN_ARCUSFIL] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_ARCUSFIL]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_CUS_NAME						VARCHAR(500),
	@PP_C_ARCUSFIL						VARCHAR(500),
	@PP_CUS_NO						VARCHAR(10),
	-- ============================
	@PP_K_CONTINENTE					INT,
	@PP_K_COUNTRY						INT,
	@PP_K_STATE_GEO						INT,
	@PP_ARCUSFIL_CITY					VARCHAR(100),
	@PP_CUS_NAME_ADDRESS_MAIN_01		VARCHAR(500),
	@PP_CUS_NAME_ADDRESS_MAIN_02		VARCHAR(500),
	@PP_ARCUSFIL_POSTAL_CODE			VARCHAR(15),
	-- ============================
	@PP_F_ARCUSFIL_DATE					DATE,
	@PP_ARCUSFIL_EMAIL_MAIN				VARCHAR(150)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_A4GLIdentity			INT = 0
BEGIN TRANSACTION 
BEGIN TRY
	---- /////////////////////////////////////////////////////////////////////
	--DECLARE @VP_BD_NAME				VARCHAR(300) = ''
	---- /////////////////////////////////////////////////////////////////////
	--EXECUTE [dbo].[PG_RN_ARCUSFIL_INSERT]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--										@VP_A4GLIdentity, 
	--										@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	---- /////////////////////////////////////////////////////////////////////	
	--IF @VP_MENSAJE<>''
	--BEGIN
	--	RAISERROR (@VP_MENSAJE, 16, 1 )
	--END	
	--EXECUTE [dbo].[PG_RN_ARCUSFIL_UNIQUE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
	--										@VP_A4GLIdentity, @PP_CUS_NO,
	--										@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	
		-- //////////////////////////////////////////////////////////////
	--IF @VP_MENSAJE<>''
	--BEGIN
	--	RAISERROR (@VP_MENSAJE, 16, 1 )
	--END
	-- ===========================
	INSERT INTO ARCUSFIL_SQL
			(	[A4GLIdentity],		[CUS_NAME], 
				[C_ARCUSFIL],		[CUS_NO], 
				-- ===========================
				[K_CONTINENTE],		[K_COUNTRY],		
				[K_STATE_GEO],		[ARCUSFIL_CITY],	
				-- ===========================
				[D_ARCUSFIL_ADDRESS_MAIN_01],	
				[D_ARCUSFIL_ADDRESS_MAIN_02],
				[ARCUSFIL_POSTAL_CODE],		[F_ARCUSFIL_DATE],			
				[O_ARCUSFIL],				[L_ARCUSFIL],
				[ARCUSFIL_EMAIL_MAIN],
				[USER_DEF_FLD_2],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@VP_A4GLIdentity,		@PP_CUS_NAME, 
				@PP_C_ARCUSFIL,		@PP_CUS_NO,
				-- ===========================
				@PP_K_CONTINENTE,	@PP_K_COUNTRY,		
				@PP_K_STATE_GEO,	@PP_ARCUSFIL_CITY,			
				-- ===========================
				@PP_CUS_NAME_ADDRESS_MAIN_01,	
				@PP_CUS_NAME_ADDRESS_MAIN_02,
				@PP_ARCUSFIL_POSTAL_CODE,	@PP_F_ARCUSFIL_DATE,
				-- ===========================
				@VP_A4GLIdentity, 1,
				@PP_ARCUSFIL_EMAIL_MAIN,
				0,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			--SET @VP_MENSAJE='El ARCUSFIL no fue insertado. [ARCUSFIL#'+CONVERT(VARCHAR(10),@VP_A4GLIdentity)+']'
			SET @VP_MENSAJE='The record was not inserted.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			SELECT @VP_A4GLIdentity=SCOPE_IDENTITY()

			IF @VP_A4GLIdentity=NULL
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

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_A4GLIdentity AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_ARCUSFIL_ADDRESS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_ARCUSFIL_ADDRESS]
GO
--		 EXECUTE [dbo].[PG_IN_ARCUSFIL_ADDRESS] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_ARCUSFIL_ADDRESS]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_A4GLIdentity							INT,
	@PP_K_ADDRESS_TYPE						INT,
	-- ============================
	@PP_CUS_NAME_ADDRESS_NAME				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_01				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_02				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_03				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_04				VARCHAR(300)
	-- ============================
AS
	DECLARE  @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_A4GLIdentity_ADDRESS		INT = 0
BEGIN TRANSACTION 
BEGIN TRY

	DECLARE	@VP_EXISTE	INT

	SELECT	@VP_EXISTE	=	COUNT(K_ADDRESS_TYPE)
	FROM	ARCUSFIL_ADDRESS
	WHERE	A4GLIdentity			=	@PP_A4GLIdentity
	AND		K_ADDRESS_TYPE		=	@PP_K_ADDRESS_TYPE

	IF	@VP_EXISTE	>	0
	BEGIN
		SET @VP_MENSAJE='Only can be one direction by (bill/sold) or ship. Verify and try again...'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	-- /////////////////////////////////////////////////////////////////////
	-- ===========================
	INSERT INTO ARCUSFIL_ADDRESS
			(	[A4GLIdentity],
				[K_ADDRESS_TYPE],
				-- =========================
				[D_ARCUSFIL_ADDRESS_NAME],
				[D_ARCUSFIL_ADDRESS_01],
				[D_ARCUSFIL_ADDRESS_02],
				[D_ARCUSFIL_ADDRESS_03],
				[D_ARCUSFIL_ADDRESS_04],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@PP_A4GLIdentity,
				@PP_K_ADDRESS_TYPE,
				-- ============================
				@PP_CUS_NAME_ADDRESS_NAME,
				@PP_CUS_NAME_ADDRESS_01,
				@PP_CUS_NAME_ADDRESS_02,
				@PP_CUS_NAME_ADDRESS_03,
				@PP_CUS_NAME_ADDRESS_04,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			--SET @VP_MENSAJE='No se insertó el registro.'
			SET @VP_MENSAJE='The record was not inserted.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			SELECT @VP_A4GLIdentity_ADDRESS=SCOPE_IDENTITY()

			IF @VP_A4GLIdentity_ADDRESS=NULL
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

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_A4GLIdentity_ADDRESS AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> INSERT
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_ARCUSFIL_ADDRESS_CHECK]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_UP_ARCUSFIL_ADDRESS_CHECK]
--GO
----		 EXECUTE [dbo].[PG_UP_ARCUSFIL_ADDRESS_CHECK] 0,139,
--CREATE PROCEDURE [dbo].[PG_UP_ARCUSFIL_ADDRESS_CHECK]
--	@PP_K_SISTEMA_EXE					INT,
--	@PP_K_USUARIO_ACCION				INT,
--	-- ===========================
--	@PP_A4GLIdentity_ADDRESS				INT,
--	@PP_A4GLIdentity						INT,
--	@PP_A4GLIdentity_ADDRES_TYPE			INT,
--	@PP_L_ARCUSFIL_ADDRESS_MAIN			INT
--	-- ============================
--AS
--	DECLARE  @VP_MENSAJE				VARCHAR(300) = ''
--BEGIN TRANSACTION 
--BEGIN TRY
--	-- /////////////////////////////////////////////////////////////////////
--	-- ===========================
--	UPDATE	ARCUSFIL_ADDRESS
--	SET		L_ARCUSFIL_ADDRESS_MAIN	= @PP_L_ARCUSFIL_ADDRESS_MAIN
--	WHERE	A4GLIdentity_ADDRESS	=	@PP_A4GLIdentity_ADDRESS
	
--	IF @@ROWCOUNT = 0
--	BEGIN
--		--SET @VP_MENSAJE='No se insertó el registro.'
--		SET @VP_MENSAJE='The record was not updated.'
--		RAISERROR (@VP_MENSAJE, 16, 1 )
--	END
		
--	IF (	SELECT	COUNT(A4GLIdentity_ADDRESS)		FROM	ARCUSFIL_ADDRESS		WHERE	A4GLIdentity	= @PP_A4GLIdentity	AND	K_ADDRESS_TYPE=@PP_A4GLIdentity_ADDRES_TYPE	)	> 2
--	BEGIN
--		RAISERROR ('Only two addresses can be selected. Please check and try again...', 16, 1 )
--	END
--	--RAISERROR ('ERROR', 16, 1 )
--	-- /////////////////////////////////////////////////////////////////////
--COMMIT TRANSACTION 
--END TRY

--BEGIN CATCH
--	/* Ocurrió un error, deshacemos los cambios*/ 
--	ROLLBACK TRANSACTION
--	DECLARE @VP_ERROR_TRANS NVARCHAR(4000);
--	SET @VP_ERROR_TRANS = ERROR_MESSAGE() 
--	SET @VP_MENSAJE = 'ERROR:// ' + @VP_ERROR_TRANS
--END CATCH
	
--	IF @VP_MENSAJE<>''
--		BEGIN
--			SET	@VP_MENSAJE = '!!!! ' + @VP_MENSAJE 
--		END

--	SELECT	@VP_MENSAJE AS MENSAJE, @PP_L_ARCUSFIL_ADDRESS_MAIN AS CLAVE
--	-- //////////////////////////////////////////////////////////////
--GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_ARCUSFIL_CONTACT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_ARCUSFIL_CONTACT]
GO
--		 EXECUTE [dbo].[PG_IN_ARCUSFIL_CONTACT] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_ARCUSFIL_CONTACT]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_A4GLIdentity								INT,
	@PP_CUS_NAME_CONTACT_NAME					VARCHAR(255),
	-- ============================
	@PP_ARCUSFIL_CONTACT_PHONE_01				VARCHAR(25),
	@PP_ARCUSFIL_CONTACT_PHONE_01_EXT			INT,
	@PP_ARCUSFIL_CONTACT_EMAIL_01				VARCHAR(150),
	@PP_ARCUSFIL_CONTACT_FAX_01					VARCHAR(25),
	-- ============================
	@PP_C_ARCUSFIL_CONTACT						VARCHAR(500)
AS
	DECLARE  @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_A4GLIdentity_CONTACT		INT = 0
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	-- ===========================
	INSERT INTO ARCUSFIL_CONTACT
			(	[A4GLIdentity],
				[D_ARCUSFIL_CONTACT_NAME],
				-- ============================
				[ARCUSFIL_CONTACT_PHONE_01],
				[ARCUSFIL_CONTACT_PHONE_01_EXT],
				[ARCUSFIL_CONTACT_FAX_01],
				[ARCUSFIL_CONTACT_EMAIL_01],
				-- ============================
				[C_ARCUSFIL_CONTACT],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@PP_A4GLIdentity,
				@PP_CUS_NAME_CONTACT_NAME,
				-- ============================
				@PP_ARCUSFIL_CONTACT_PHONE_01,
				@PP_ARCUSFIL_CONTACT_PHONE_01_EXT,
				@PP_ARCUSFIL_CONTACT_EMAIL_01,	
				@PP_ARCUSFIL_CONTACT_FAX_01,
				-- ============================
				@PP_C_ARCUSFIL_CONTACT,
				-- ===========================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			--SET @VP_MENSAJE='No se insertó el registro.'
			SET @VP_MENSAJE='The record was not inserted.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			SELECT @VP_A4GLIdentity_CONTACT=SCOPE_IDENTITY()

			IF @VP_A4GLIdentity_CONTACT=NULL
			BEGIN
				--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
				SET @VP_MENSAJE='The record was not inserted.(Identity)'
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

	SELECT	@VP_MENSAJE AS MENSAJE, @VP_A4GLIdentity_CONTACT AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO



-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
-- EXECUTE [dbo].[PG_UP_ARCUSFIL] 0,139,  1 , 21 , 'TELFONO IP' , '76855545649' , '' , 'PANASONIC' , 'KX-T7630' , '2,890.50' , 1 , 1 , 11 , 1
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_ARCUSFIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_ARCUSFIL]
GO

CREATE PROCEDURE [dbo].[PG_UP_ARCUSFIL]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_A4GLIdentity						INT,
	@PP_CUS_NAME						VARCHAR(500),
	@PP_C_ARCUSFIL						VARCHAR(500),
	@PP_CUS_NO						VARCHAR(10),
	-- ============================
	@PP_K_CONTINENTE					INT,
	@PP_K_COUNTRY						INT,
	@PP_K_STATE_GEO						INT,
	@PP_ARCUSFIL_CITY					VARCHAR(100),
	@PP_CUS_NAME_ADDRESS_MAIN_01		VARCHAR(500),
	@PP_CUS_NAME_ADDRESS_MAIN_02		VARCHAR(500),
	@PP_ARCUSFIL_POSTAL_CODE			VARCHAR(15),
	-- ============================
	@PP_F_ARCUSFIL_DATE					DATE,
	@PP_ARCUSFIL_EMAIL_MAIN				VARCHAR(150)
AS			
DECLARE @VP_MENSAJE					VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_ARCUSFIL_UPDATE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
											@PP_A4GLIdentity, 
											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
-- /////////////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	EXECUTE [dbo].[PG_RN_ARCUSFIL_UNIQUE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
											@PP_A4GLIdentity, @PP_CUS_NO,
											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT	
		-- //////////////////////////////////////////////////////////////
	IF @VP_MENSAJE<>''
	BEGIN
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END

	UPDATE	ARCUSFIL_SQL
	SET		
			[CUS_NAME]						= @PP_CUS_NAME,
			[C_ARCUSFIL]					= @PP_C_ARCUSFIL,
			[CUS_NO]						= @PP_CUS_NO,
			-- =========================	= -- ============================
			[K_CONTINENTE]					= @PP_K_CONTINENTE,
			[K_COUNTRY]						= @PP_K_COUNTRY,
			[K_STATE_GEO]					= @PP_K_STATE_GEO,
			[ARCUSFIL_CITY]					= @PP_ARCUSFIL_CITY,
			[D_ARCUSFIL_ADDRESS_MAIN_01]		= @PP_CUS_NAME_ADDRESS_MAIN_01,
			[D_ARCUSFIL_ADDRESS_MAIN_02]		= @PP_CUS_NAME_ADDRESS_MAIN_02,
			[ARCUSFIL_POSTAL_CODE]			= @PP_ARCUSFIL_POSTAL_CODE,
			-- =========================	= -- ============================
			[F_ARCUSFIL_DATE]				= @PP_F_ARCUSFIL_DATE,
			[ARCUSFIL_EMAIL_MAIN]			= @PP_ARCUSFIL_EMAIL_MAIN,
			[USER_DEF_FLD_2]				= 0,
			-- ====================		
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	A4GLIdentity=@PP_A4GLIdentity
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='El ARCUSFIL no fue actualizado. [ARCUSFIL#'+CONVERT(VARCHAR(10),@PP_A4GLIdentity)+']'
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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_A4GLIdentity AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_ARCUSFIL_ADDRESS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_ARCUSFIL_ADDRESS]
GO
--		 EXECUTE [dbo].[PG_UP_ARCUSFIL_ADDRESS] 0,139,
CREATE PROCEDURE [dbo].[PG_UP_ARCUSFIL_ADDRESS]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_A4GLIdentity_ADDRESS					INT,
	@PP_A4GLIdentity							INT,
	@PP_K_ADDRESS_TYPE						INT,
	-- ============================
	@PP_CUS_NAME_ADDRESS_NAME				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_01				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_02				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_03				VARCHAR(300),
	@PP_CUS_NAME_ADDRESS_04				VARCHAR(300)
	-- ============================
AS
	DECLARE  @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	DECLARE	@VP_EXISTE	INT

	SELECT	@VP_EXISTE	=	COUNT(K_ADDRESS_TYPE)
	FROM	ARCUSFIL_ADDRESS
	WHERE	A4GLIdentity			=	@PP_A4GLIdentity
	AND		A4GLIdentity_ADDRESS	<>	@PP_A4GLIdentity_ADDRESS
	AND		K_ADDRESS_TYPE		=	@PP_K_ADDRESS_TYPE

	IF	@VP_EXISTE	>	0
	BEGIN
		SET @VP_MENSAJE='Only can be one direction by (bill/sold) or ship. Verify and try again...'
		RAISERROR (@VP_MENSAJE, 16, 1 )
	END
	-- ===========================
	UPDATE	ARCUSFIL_ADDRESS
	SET
			[A4GLIdentity]					= @PP_A4GLIdentity,
			[K_ADDRESS_TYPE]				= @PP_K_ADDRESS_TYPE,
			-- =========================	= -- ============================
			[D_ARCUSFIL_ADDRESS_NAME]		= @PP_CUS_NAME_ADDRESS_NAME,
			[D_ARCUSFIL_ADDRESS_01]			= @PP_CUS_NAME_ADDRESS_01,
			[D_ARCUSFIL_ADDRESS_02]			= @PP_CUS_NAME_ADDRESS_02,
			[D_ARCUSFIL_ADDRESS_03]			= @PP_CUS_NAME_ADDRESS_03,
			[D_ARCUSFIL_ADDRESS_04]			= @PP_CUS_NAME_ADDRESS_04,
			-- ===========================	  -- ===========================
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	A4GLIdentity_ADDRESS	=	@PP_A4GLIdentity_ADDRESS
	IF @@ROWCOUNT = 0
	BEGIN
		--SET @VP_MENSAJE='No se insertó el registro.'
		SET @VP_MENSAJE='The record was not updated.'
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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_A4GLIdentity_ADDRESS AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_ARCUSFIL_CONTACT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_ARCUSFIL_CONTACT]
GO
--		 EXECUTE [dbo].[PG_UP_ARCUSFIL_CONTACT] 0,139,
CREATE PROCEDURE [dbo].[PG_UP_ARCUSFIL_CONTACT]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_A4GLIdentity_CONTACT						INT,
	@PP_A4GLIdentity								INT,
	@PP_CUS_NAME_CONTACT_NAME					VARCHAR(255),
	-- ============================
	@PP_ARCUSFIL_CONTACT_PHONE_01				VARCHAR(25),
	@PP_ARCUSFIL_CONTACT_PHONE_01_EXT			INT,
	@PP_ARCUSFIL_CONTACT_EMAIL_01				VARCHAR(150),
	@PP_ARCUSFIL_CONTACT_FAX_01					VARCHAR(25),
	-- ============================
	@PP_C_ARCUSFIL_CONTACT						VARCHAR(500)
AS
	DECLARE  @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	-- ===========================
	UPDATE	ARCUSFIL_CONTACT
	SET
		[A4GLIdentity]					= @PP_A4GLIdentity,
		[D_ARCUSFIL_CONTACT_NAME]		= @PP_CUS_NAME_CONTACT_NAME,
		-- ============================	= -- ============================
		[ARCUSFIL_CONTACT_PHONE_01]		= @PP_ARCUSFIL_CONTACT_PHONE_01,
		[ARCUSFIL_CONTACT_PHONE_01_EXT]	= @PP_ARCUSFIL_CONTACT_PHONE_01_EXT,
		[ARCUSFIL_CONTACT_FAX_01]		= @PP_ARCUSFIL_CONTACT_EMAIL_01,	
		[ARCUSFIL_CONTACT_EMAIL_01]		= @PP_ARCUSFIL_CONTACT_FAX_01,
		-- ============================	= -- ============================
		[C_ARCUSFIL_CONTACT]			= @PP_C_ARCUSFIL_CONTACT,		
		-- ===========================	  -- ===========================
		[F_CAMBIO]						= GETDATE(), 
		[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
	WHERE	A4GLIdentity_CONTACT	=	@PP_A4GLIdentity_CONTACT
	IF @@ROWCOUNT = 0
	BEGIN
		--SET @VP_MENSAJE='No se insertó el registro.'
		SET @VP_MENSAJE='The record was not updated.'
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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_A4GLIdentity_CONTACT AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
--  EXECUTE [dbo].[PG_SA4GLIdentity] 0,139,9
--	EXECUTE [dbo].[PG_DL_ARCUSFIL] 0,139,9
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_ARCUSFIL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_ARCUSFIL]
GO

CREATE PROCEDURE [dbo].[PG_DL_ARCUSFIL]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_A4GLIdentity						INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	--/////////////////////////////////////////////////////////////
	EXECUTE [dbo].[PG_RN_ARCUSFIL_DELETE]	@PP_K_SISTEMA_EXE, @PP_K_USUARIO_ACCION,
											@PP_A4GLIdentity, 
											@OU_RESULTADO_VALIDACION = @VP_MENSAJE		OUTPUT
	--////////////////////////////////////////////////////////////
	IF @VP_MENSAJE=''
		BEGIN		
		UPDATE	ARCUSFIL_SQL
		SET		
				[L_BORRADO]				= 1,
				-- ====================
				[F_BAJA]				= GETDATE(), 
				[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
		WHERE	A4GLIdentity=@PP_A4GLIdentity
	
		IF @@ROWCOUNT = 0
			BEGIN
				--DECLARE @VP_ERROR_2 VARCHAR(250)='No fue actualizado. [ARCUSFIL#'+CONVERT(VARCHAR(10),@PP_A4GLIdentity)+']'
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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_A4GLIdentity AS CLAVE
	-- //////////////////////////////////////////////////////////////	
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////