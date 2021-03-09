-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_FLOOR
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210219
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02Pruebas]
GO

---- //////////////////////////////////////////////////////////////
---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT / LISTADO
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_FLOOR_HDR]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_LI_APQP_FLOOR_HDR]
--GO
----		 EXECUTE [dbo].[PG_LI_APQP_FLOOR_HDR] 0,139,	1
--CREATE PROCEDURE [dbo].[PG_LI_APQP_FLOOR_HDR]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ===========================
--	@PP_K_APQP_FLOOR_HDR				INT
--AS
--	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
--	-- ///////////////////////////////////////////
--	-- =========================================	-- =========================================
--	SELECT		TOP (5000)
--				D_STATUS_APQP_DOCUMENT,
--				S_STATUS_APQP_DOCUMENT,
--				APQP_FLOOR_HDR.*
--				-- =============================	
--	FROM		APQP_FLOOR_HDR
--	INNER JOIN	STATUS_APQP_DOCUMENT			ON	STATUS_APQP_DOCUMENT.K_STATUS_APQP_DOCUMENT	= APQP_FLOOR_HDR.K_STATUS_APQP_DOCUMENT
--				-- =============================
--	WHERE		APQP_FLOOR_HDR.L_BORRADO<>1
--				-- =============================
--	AND			(	APQP_FLOOR_HDR.K_APQP_FLOOR_HDR = -1		OR APQP_FLOOR_HDR.K_APQP_FLOOR_HDR = @PP_K_APQP_FLOOR_HDR	)
--	--ORDER BY	D_APQP_FLOOR_HDR DESC
--	-- /////////////////////////////////////////////////////////////////////
--GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_APQP_FLOOR_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_APQP_FLOOR_DET]
GO
--		 EXECUTE [dbo].[PG_LI_APQP_FLOOR_DET] 0,139,	1
CREATE PROCEDURE [dbo].[PG_LI_APQP_FLOOR_DET]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_FLOOR_HDR				INT
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
	-- ///////////////////////////////////////////
	-- =========================================	-- =========================================
	SELECT		--TOP (5000)
				K_APQP_FLOOR_ACTIVITY_LIST_TYPE			AS K_TYPE,
				O_APQP_FLOOR_DET						AS L_ESTATUS_CHECK,
				D_APQP_FLOOR_ACTIVITY_LIST				AS D_LIST,
				L_APQP_FLOOR_DET_YES					AS L_YES,
				L_APQP_FLOOR_DET_NO						AS L_NO,
				K_APQP_FLOOR_DET						AS K_DET,
				(CASE
					WHEN	C_APQP_FLOOR_DET=''	THEN	'-'
					ELSE	C_APQP_FLOOR_DET
				END)	AS C_DET,
				RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST	AS R_LIST,
				F_APQP_FLOOR_DET_COMPLETED				AS F_DET,
				APQP_FLOOR_DET.*
				-- =============================
	FROM		APQP_FLOOR_DET
	INNER JOIN	APQP_FLOOR_HDR				ON	APQP_FLOOR_HDR.K_APQP_FLOOR_HDR	= APQP_FLOOR_DET.K_APQP_FLOOR_HDR
	INNER JOIN	APQP_FLOOR_ACTIVITY_LIST	ON	APQP_FLOOR_ACTIVITY_LIST.K_APQP_FLOOR_ACTIVITY_LIST	= APQP_FLOOR_DET.K_APQP_FLOOR_ACTIVITY_LIST
				-- =============================
	WHERE		APQP_FLOOR_DET.L_BORRADO				<> 1
	AND			L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE	=  1
				-- =============================
	AND			APQP_FLOOR_DET.K_APQP_FLOOR_HDR						= @PP_K_APQP_FLOOR_HDR
	ORDER BY	K_APQP_FLOOR_ACTIVITY_LIST_TYPE,
				O_APQP_FLOOR_ACTIVITY_LIST
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_FLOOR_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_SK_APQP_FLOOR_HDR]
GO
--		 EXECUTE [dbo].[PG_SK_APQP_FLOOR_HDR] 0,139,1
CREATE PROCEDURE [dbo].[PG_SK_APQP_FLOOR_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_FLOOR_HDR				INT
AS
	-- ///////////////////////////////////////////
	SELECT		TOP (1)
				D_STATUS_APQP_DOCUMENT,
				S_STATUS_APQP_DOCUMENT,
				APQP_FLOOR_HDR.*,
				'A-5 FLOOR PLAN CHECKLIST'	AS TITULO_REPORTE
				-- =============================	
	FROM		APQP_FLOOR_HDR
	INNER JOIN	STATUS_APQP_DOCUMENT			ON	STATUS_APQP_DOCUMENT.K_STATUS_APQP_DOCUMENT	= APQP_FLOOR_HDR.K_STATUS_APQP_DOCUMENT
				-- =============================
	WHERE		APQP_FLOOR_HDR.L_BORRADO<>1
				-- =============================
	AND			APQP_FLOOR_HDR.K_APQP_FLOOR_HDR = @PP_K_APQP_FLOOR_HDR
	--AND			APQP_FLOOR_HDR.K_APQP_MODEL_HDR = @PP_K_APQP_MODEL_HDR
	-- ////////////////////////////////////////////////////////////////////
GO


---- //////////////////////////////////////////////////////////////
---- // STORED PROCEDURE ---> SELECT / FICHA
---- //////////////////////////////////////////////////////////////
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_SK_APQP_FLOOR_DET]') AND type in (N'P', N'PC'))
--	DROP PROCEDURE [dbo].[PG_SK_APQP_FLOOR_DET]
--GO
----		 EXECUTE [dbo].[PG_SK_APQP_FLOOR_DET] 0,139,1
--CREATE PROCEDURE [dbo].[PG_SK_APQP_FLOOR_DET]
--	@PP_K_SISTEMA_EXE				INT,
--	@PP_K_USUARIO_ACCION			INT,
--	-- ===========================
--	@PP_K_APQP_FLOOR_DET				INT
--AS
--	-- ///////////////////////////////////////////
--	SELECT		TOP (1)
--				APQP_FLOOR_DET.*
--				-- =============================	
--	FROM		APQP_FLOOR_DET
--	INNER JOIN	APQP_FLOOR_HDR			ON	APQP_FLOOR_HDR.K_APQP_FLOOR_HDR	= APQP_FLOOR_DET.K_APQP_FLOOR_HDR
--				-- =============================
--	WHERE		APQP_FLOOR_DET.L_BORRADO<>1
--				-- =============================
--	AND			APQP_FLOOR_DET.K_APQP_FLOOR_DET = @PP_K_APQP_FLOOR_DET
--	-- ////////////////////////////////////////////////////////////////////
--GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_APQP_FLOOR_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_APQP_FLOOR_HDR]
GO
--		 EXECUTE [dbo].[PG_IN_APQP_FLOOR_HDR] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_APQP_FLOOR_HDR]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR				INT
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
			,@VP_K_APQP_FLOOR_HDR			INT = 0
--BEGIN TRANSACTION 
--BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	-- ===========================
	INSERT INTO APQP_FLOOR_HDR
			(	[K_APQP_MODEL_HDR],
				-- ===========================
				[K_STATUS_APQP_DOCUMENT],	
				[F_APQP_FLOOR_HDR_CREATED],
				-- ===========================
				[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
				[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
	VALUES	
			(	@PP_K_APQP_MODEL_HDR,
				-- ============================
				20,	--	STATUS	#20	= INCOMPLETO
				GETDATE(),
				-- ============================
				@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
				0, NULL, NULL  )

		IF @@ROWCOUNT = 0
		BEGIN
			--SET @VP_MENSAJE='El APQP_MODEL_HDR no fue insertado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@VP_K_APQP_MODEL_HDR)+']'
			SET @VP_MENSAJE='The record was not inserted.'
			RAISERROR (@VP_MENSAJE, 16, 1 )
		END
		ELSE
		BEGIN
			SELECT @VP_K_APQP_FLOOR_HDR=SCOPE_IDENTITY()

			IF @VP_K_APQP_FLOOR_HDR=NULL
			BEGIN
				--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
				SET @VP_MENSAJE='The record was not inserted.(identity)'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
		END
	
	-- //////////////////////////////////////////////////////////////
	EXECUTE	[dbo].[PG_IN_APQP_FLOOR_DET]		@PP_K_SISTEMA_EXE	,@PP_K_USUARIO_ACCION,
											-- ===========================
											@VP_K_APQP_FLOOR_HDR
	-- /////////////////////////////////////////////////////////////////////
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

--	SELECT	@VP_MENSAJE AS MENSAJE, @VP_K_APQP_FLOOR_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_IN_APQP_FLOOR_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_IN_APQP_FLOOR_DET]
GO
--		 EXECUTE [dbo].[PG_IN_APQP_FLOOR_DET] 0,139,
CREATE PROCEDURE [dbo].[PG_IN_APQP_FLOOR_DET]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_FLOOR_HDR					INT
AS
	DECLARE @VP_MENSAJE								VARCHAR(300) = ''
			,@VP_K_APQP_MODEL_ACTIVITY_LIST			INT = 0
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================	
	DECLARE  @VP_CU_K_ACTIVITY_FLOOR_LIST		INT
			,@VP_O_APQP_FLOOR_ACTIVITY_LIST		INT


	DECLARE CU_LISTA_ACTIVIDADES CURSOR FOR  
		SELECT	--*
				K_APQP_FLOOR_ACTIVITY_LIST
				,O_APQP_FLOOR_ACTIVITY_LIST
		FROM	APQP_FLOOR_ACTIVITY_LIST
		WHERE	L_APQP_FLOOR_ACTIVITY_LIST	= 1
		ORDER BY K_APQP_FLOOR_ACTIVITY_LIST_TYPE, O_APQP_FLOOR_ACTIVITY_LIST
	OPEN			CU_LISTA_ACTIVIDADES;  
	FETCH NEXT FROM CU_LISTA_ACTIVIDADES INTO @VP_CU_K_ACTIVITY_FLOOR_LIST, @VP_O_APQP_FLOOR_ACTIVITY_LIST;
	WHILE @@FETCH_STATUS = 0  
	   BEGIN
			---- /////////////////////////////////////////////////////////////////////
			INSERT INTO APQP_FLOOR_DET
				(	[K_APQP_FLOOR_HDR],
					[K_APQP_FLOOR_ACTIVITY_LIST],
					-- ===========================
					[O_APQP_FLOOR_DET],
					-- ===========================
					[K_USUARIO_ALTA], [F_ALTA], [K_USUARIO_CAMBIO], [F_CAMBIO],
					[L_BORRADO], [K_USUARIO_BAJA], [F_BAJA]  )
			VALUES
				(	@PP_K_APQP_FLOOR_HDR,
					@VP_CU_K_ACTIVITY_FLOOR_LIST,
					-- ===========================
					@VP_O_APQP_FLOOR_ACTIVITY_LIST,
					-- ===========================
					@PP_K_USUARIO_ACCION, GETDATE(), @PP_K_USUARIO_ACCION, GETDATE(),
					0, NULL, NULL  )
			
			IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='The record was not inserted.' + ' [' +	CONVERT(VARCHAR(10),@VP_CU_K_ACTIVITY_FLOOR_LIST)	+ ']'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END
			ELSE
			BEGIN
				SELECT @VP_K_APQP_MODEL_ACTIVITY_LIST=SCOPE_IDENTITY()

				IF @VP_K_APQP_MODEL_ACTIVITY_LIST=NULL
				BEGIN
					--SET @VP_MENSAJE='Error en la asignación de IDENTIDAD.'
					SET @VP_MENSAJE='The record was not inserted.(identity)' + ' [' +	CONVERT(VARCHAR(10),@VP_CU_K_ACTIVITY_FLOOR_LIST)	+ ']'
					RAISERROR (@VP_MENSAJE, 16, 1 )
				END
			END
			-- /////////////////////////////////////////////////////////////////////
	      FETCH NEXT FROM CU_LISTA_ACTIVIDADES INTO @VP_CU_K_ACTIVITY_FLOOR_LIST, @VP_O_APQP_FLOOR_ACTIVITY_LIST;
	   END;  
	CLOSE		CU_LISTA_ACTIVIDADES;  
	DEALLOCATE	CU_LISTA_ACTIVIDADES;  
	GO
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> UPDATE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_APQP_FLOOR_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_APQP_FLOOR_HDR]
GO
--		 EXECUTE [dbo].[PG_UP_APQP_FLOOR_HDR] 0,139,		1,1,										
--														0,1,0,							
--														'2/3/4/5/6/7/8/9/10/11/12/13/14/15/16' , 
--														'1/1/1/0/0/0/0/0/0/0/0/0/0/0/0' , 
--														'0/0/0/0/0/0/0/0/0/0/0/0/0/0/0' , 
--														'0/0/0/0/0/0/0/0/0/0/0/0/0/0/0'
CREATE PROCEDURE [dbo].[PG_UP_APQP_FLOOR_HDR]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_K_APQP_MODEL_HDR				INT,
	@PP_K_APQP_FLOOR_HDR					INT,
	-- ===========================
	@PP_ARRAY_DET_CO					NVARCHAR(MAX),
	-- ===========================
	@PP_ARRAY_DET_KL					NVARCHAR(MAX),
	@PP_ARRAY_DET_YS					NVARCHAR(MAX),
	@PP_ARRAY_DET_NO					NVARCHAR(MAX)
	--@PP_ARRAY_DET_NA					NVARCHAR(MAX)
AS			
DECLARE @VP_MENSAJE					VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	-- /////////////////////////////////////////////////////////////////////
	UPDATE	APQP_FLOOR_HDR
	SET		-- ===========================	= -- ===========================
			[F_CAMBIO]						= GETDATE(), 
			[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
			-- ===========================	= -- ===========================
	WHERE	K_APQP_FLOOR_HDR				= @PP_K_APQP_FLOOR_HDR
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='El APQP_MODEL_HDR no fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
		SET @VP_MENSAJE='The record was not Updated.'
		RAISERROR (@VP_MENSAJE, 16, 1 ) 
	END

	-- /////////////////////////////////////////////////////////////////////

	EXECUTE	[dbo].[PG_UP_APQP_FLOOR_DET]		@PP_K_SISTEMA_EXE	,@PP_K_USUARIO_ACCION,
											-- ===========================
											@PP_ARRAY_DET_KL,		@PP_ARRAY_DET_YS,
											@PP_ARRAY_DET_NO,		--@PP_ARRAY_DET_NA,
											@PP_ARRAY_DET_CO


	-- /////////////////////////////////////////////////////////////////////
	DECLARE  @PP_K_STATUS_APQP_DOCUMENT		INT	=	0
			,@PP_TOTAL_ACTIVIDADES			DECIMAL(10,2)	=	0
			,@PP_TOTAL_COMPLETADAS			DECIMAL(10,2)	=	0
			,@PP_SUMMARY					DECIMAL(10,2)

	SELECT	@PP_TOTAL_COMPLETADAS	=	ISNULL(SUM(L_APQP_FLOOR_DET_YES) + SUM(L_APQP_FLOOR_DET_NO)	+ SUM(L_APQP_FLOOR_DET_NA)	, 0)
	FROM	APQP_FLOOR_DET
	WHERE	K_APQP_FLOOR_HDR			=	@PP_K_APQP_FLOOR_HDR

	SELECT	@PP_TOTAL_ACTIVIDADES	=	COUNT(K_APQP_FLOOR_DET) 
	FROM	APQP_FLOOR_DET
	INNER JOIN	APQP_FLOOR_ACTIVITY_LIST	ON	APQP_FLOOR_ACTIVITY_LIST.K_APQP_FLOOR_ACTIVITY_LIST	=	APQP_FLOOR_DET.K_APQP_FLOOR_ACTIVITY_LIST
	WHERE	K_APQP_FLOOR_HDR			=	@PP_K_APQP_FLOOR_HDR
	AND		APQP_FLOOR_ACTIVITY_LIST.O_APQP_FLOOR_ACTIVITY_LIST<>0
	AND		APQP_FLOOR_DET.O_APQP_FLOOR_DET	<>	0

		SET 	@PP_SUMMARY	=	(	@PP_TOTAL_COMPLETADAS	/	@PP_TOTAL_ACTIVIDADES	)	*	100
		
	IF	(	@PP_TOTAL_COMPLETADAS	)		>=	(	@PP_TOTAL_ACTIVIDADES	)
	BEGIN
		SET @PP_K_STATUS_APQP_DOCUMENT	= 10
	END
	ELSE
	BEGIN
		SET @PP_K_STATUS_APQP_DOCUMENT	= 20
	END

		UPDATE	APQP_FLOOR_HDR
		SET		-- ===========================	= -- ===========================	
				[K_STATUS_APQP_DOCUMENT]		= @PP_K_STATUS_APQP_DOCUMENT,
				[APQP_FLOOR_SUMMARY]				= @PP_SUMMARY
		WHERE	K_APQP_FLOOR_HDR				= @PP_K_APQP_FLOOR_HDR
	
		IF @@ROWCOUNT = 0
		BEGIN
			--DECLARE @VP_ERROR_2 VARCHAR(250)='El APQP_MODEL_HDR no fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_APQP_MODEL_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> INSERT
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_UP_APQP_FLOOR_DET]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_UP_APQP_FLOOR_DET]
GO
--		 EXECUTE [dbo].[PG_UP_APQP_FLOOR_DET] 0,139,
CREATE PROCEDURE [dbo].[PG_UP_APQP_FLOOR_DET]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_ARRAY_DET_KL					NVARCHAR(MAX),
	@PP_ARRAY_DET_YS					NVARCHAR(MAX),
	@PP_ARRAY_DET_NO					NVARCHAR(MAX),
	--@PP_ARRAY_DET_NA					NVARCHAR(MAX),
		-- ===========================
	@PP_ARRAY_DET_CO					NVARCHAR(MAX)
AS
	DECLARE @VP_MENSAJE				VARCHAR(300) = ''
---===================================================================================================================================================
---===================================================================================================================================================
---===================================================================================================================================================	
	DECLARE @VP_K_DETAIL_PO	INT = 1
	
	DECLARE  @VP_POSICION_KL		INT
			,@VP_POSICION_YS		INT
			,@VP_POSICION_NO		INT 
			--,@VP_POSICION_NA		INT
			,@VP_POSICION_CO		INT
	DECLARE @VP_VALOR_KL			VARCHAR(500)
			,@VP_VALOR_YS			VARCHAR(500)
			,@VP_VALOR_NO			VARCHAR(500)
			--,@VP_VALOR_NA			VARCHAR(500)
			,@VP_VALOR_CO			VARCHAR(500)
	--Colocamos un separador al final de los parametros para que funcione bien nuestro codigo
	SET	@PP_ARRAY_DET_KL		= @PP_ARRAY_DET_KL		+ '/'
	SET	@PP_ARRAY_DET_YS		= @PP_ARRAY_DET_YS		+ '/'
	SET	@PP_ARRAY_DET_NO		= @PP_ARRAY_DET_NO		+ '/'
	--SET	@PP_ARRAY_DET_NA		= @PP_ARRAY_DET_NA		+ '/'
	SET	@PP_ARRAY_DET_CO		= @PP_ARRAY_DET_CO		+ '/'	

	--Hacemos un bucle que se repite mientras haya separadores, patindex busca un patron en una cadena y nos devuelve su posicion
	WHILE patindex('%/%' , @PP_ARRAY_DET_KL) <> 0
		BEGIN
			SELECT @VP_POSICION_KL	=	patindex('%/%' , @PP_ARRAY_DET_KL	)
			SELECT @VP_POSICION_YS	=	patindex('%/%' , @PP_ARRAY_DET_YS	)
			SELECT @VP_POSICION_NO	=	patindex('%/%' , @PP_ARRAY_DET_NO	)
			--SELECT @VP_POSICION_NA	=	patindex('%/%' , @PP_ARRAY_DET_NA	)
			SELECT @VP_POSICION_CO	=	patindex('%/%' , @PP_ARRAY_DET_CO	)

			--Buscamos la posicion de la primera y obtenemos los caracteres hasta esa posicion
			SELECT @VP_VALOR_KL		= LEFT(@PP_ARRAY_DET_KL		, @VP_POSICION_KL	- 1)
			SELECT @VP_VALOR_YS		= LEFT(@PP_ARRAY_DET_YS		, @VP_POSICION_YS	- 1)
			SELECT @VP_VALOR_NO		= LEFT(@PP_ARRAY_DET_NO		, @VP_POSICION_NO	- 1)
			--SELECT @VP_VALOR_NA		= LEFT(@PP_ARRAY_DET_NA		, @VP_POSICION_NA	- 1)
			SELECT @VP_VALOR_CO		= LEFT(@PP_ARRAY_DET_CO		, @VP_POSICION_CO	- 1)

			UPDATE	APQP_FLOOR_DET
			SET	
					[L_APQP_FLOOR_DET_YES]			= @VP_VALOR_YS	,
					[L_APQP_FLOOR_DET_NO]			= @VP_VALOR_NO	,
					--[L_APQP_FLOOR_DET_NA]			= @VP_VALOR_NA	,
					[C_APQP_FLOOR_DET]				= @VP_VALOR_CO	,
					-- ===========================	= -- ===========================
					[F_CAMBIO]						= GETDATE(), 
					[K_USUARIO_CAMBIO]				= @PP_K_USUARIO_ACCION
			WHERE	K_APQP_FLOOR_DET			= @VP_VALOR_KL
			
			IF @@ROWCOUNT = 0
			BEGIN
				SET @VP_MENSAJE='The record was not updated.' + ' [' +	CONVERT(VARCHAR(10),@VP_VALOR_KL)	+ ']'
				RAISERROR (@VP_MENSAJE, 16, 1 )
			END

			IF (@VP_VALOR_YS=1	OR @VP_VALOR_NO=1	)	--OR @VP_VALOR_NA=1)
			BEGIN
				--	PARA COLOCAR LA FECHA DE COMPLETADA, SIN IMPORTAR SI FUE EN SI O NO.
				IF (SELECT F_APQP_FLOOR_DET_COMPLETED FROM APQP_FLOOR_DET WHERE K_APQP_FLOOR_DET= @VP_VALOR_KL) IS NULL
				BEGIN
					UPDATE	APQP_FLOOR_DET
					SET	
							[F_APQP_FLOOR_DET_COMPLETED]		= GETDATE()
					WHERE	K_APQP_FLOOR_DET			= @VP_VALOR_KL
					IF @@ROWCOUNT = 0
					BEGIN
						SET @VP_MENSAJE='The record was not updated.' + ' [' +	CONVERT(VARCHAR(10),@VP_VALOR_KL)	+ ']'
						RAISERROR (@VP_MENSAJE, 16, 1 )
					END
				END
			END
			ELSE
			BEGIN
				UPDATE	APQP_FLOOR_DET
				SET	
						[F_APQP_FLOOR_DET_COMPLETED]		= NULL
				WHERE	K_APQP_FLOOR_DET			= @VP_VALOR_KL
				IF @@ROWCOUNT = 0
				BEGIN
					SET @VP_MENSAJE='The record was not updated.' + ' [' +	CONVERT(VARCHAR(10),@VP_VALOR_KL)	+ ']'
					RAISERROR (@VP_MENSAJE, 16, 1 )
				END			
			END

			--Reemplazamos lo procesado con nada con la funcion stuff
			SELECT @PP_ARRAY_DET_KL= STUFF(@PP_ARRAY_DET_KL , 1, @VP_POSICION_KL, '')
			SELECT @PP_ARRAY_DET_YS= STUFF(@PP_ARRAY_DET_YS , 1, @VP_POSICION_YS, '')
			SELECT @PP_ARRAY_DET_NO= STUFF(@PP_ARRAY_DET_NO , 1, @VP_POSICION_NO, '')
			--SELECT @PP_ARRAY_DET_NA= STUFF(@PP_ARRAY_DET_NA , 1, @VP_POSICION_NA, '')
			SELECT @PP_ARRAY_DET_CO= STUFF(@PP_ARRAY_DET_CO , 1, @VP_POSICION_CO, '')
		END
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> DELETE / FICHA
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_DL_APQP_FLOOR_HDR]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_DL_APQP_FLOOR_HDR]
GO
--		 EXECUTE [dbo].[PG_DL_APQP_FLOOR_HDR] 0,139,9
CREATE PROCEDURE [dbo].[PG_DL_APQP_FLOOR_HDR]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_K_APQP_FLOOR_HDR			INT
AS
DECLARE @VP_MENSAJE				VARCHAR(300) = ''
BEGIN TRANSACTION 
BEGIN TRY
	--/////////////////////////////////////////////////////////////
	UPDATE	APQP_FLOOR_HDR
	SET		
			[L_BORRADO]				= 1,
			-- ====================
			[F_BAJA]				= GETDATE(), 
			[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
	WHERE	K_APQP_FLOOR_HDR=@PP_K_APQP_FLOOR_HDR
	
	IF @@ROWCOUNT = 0
	BEGIN
		--DECLARE @VP_ERROR_2 VARCHAR(250)='No fue actualizado. [APQP_MODEL_HDR#'+CONVERT(VARCHAR(10),@PP_K_APQP_MODEL_HDR)+']'
		SET @VP_MENSAJE='The record was not inserted.'
		RAISERROR (@VP_MENSAJE, 16, 1 ) 
	END

	UPDATE	APQP_FLOOR_DET
	SET
			[L_BORRADO]				= 1,
			-- ====================
			[F_BAJA]				= GETDATE(), 
			[K_USUARIO_BAJA]		= @PP_K_USUARIO_ACCION
	WHERE	K_APQP_FLOOR_HDR=@PP_K_APQP_FLOOR_HDR

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

	SELECT	@VP_MENSAJE AS MENSAJE, @PP_K_APQP_FLOOR_HDR AS CLAVE
	-- //////////////////////////////////////////////////////////////	
GO

-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////