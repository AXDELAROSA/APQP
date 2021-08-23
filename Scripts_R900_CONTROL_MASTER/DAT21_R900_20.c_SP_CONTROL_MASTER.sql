-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			CONTROL_MASTER
-- // OPERATION:		STORED PROCEDURE
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210813
-- //////////////////////////////////////////////////////////////

USE [DATA_02]
GO

-- //////////////////////////////////////////////////////////////
-- //////		CONTENIDO DEL SP
-- [PG_LI_CONTROL_MASTER]
-- //////////////////////////////////////////////////////////////


-- //////////////////////////////////////////////////////////////
-- // STORED PROCEDURE ---> SELECT / LISTADO
-- //////////////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_LI_CONTROL_MASTER]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_LI_CONTROL_MASTER]
GO
--		 EXECUTE [dbo].[PG_LI_CONTROL_MASTER] 0, 139, 'IRVI02'
--		 EXECUTE [dbo].[PG_LI_CONTROL_MASTER] 0, 139, 'MAGN02'
--		 EXECUTE [dbo].[PG_LI_CONTROL_MASTER] 0, 139, 'GRAM04'
--		 EXECUTE [DBO].[PG_LI_CONTROL_MASTER] 0, 139, '( TODOS )'
CREATE PROCEDURE [dbo].[PG_LI_CONTROL_MASTER]
	@PP_K_SISTEMA_EXE				INT,
	@PP_K_USUARIO_ACCION			INT,
	-- ===========================
	@PP_CUS_NO						VARCHAR(200)
AS
DECLARE	 @VP_MENSAJE			NVARCHAR(MAX)
	-- /////////////////////////////////////////////////////////////////////
	-- ==================================================================================
BEGIN TRANSACTION 
BEGIN TRY
	DECLARE @TA_FINAL	TABLE	(
			--===============================================================================
			 ESPACIO_01							VARCHAR(500)
			,CLIENTE_01							VARCHAR(500)
			--===============================================================================
			,CUS_NO								VARCHAR(500)
			,S_PROGRAM							VARCHAR(500)
			,MODELNO							VARCHAR(500)
			,VERSIONNO							VARCHAR(500)
			--==========================================================
			,K_QUOTE_TRIM_LEVEL					VARCHAR(500)--INT
			,K_QUOTE_TRIM_COLOR					VARCHAR(500)--INT
			,S_COLOR							VARCHAR(500)
			,D_COLOR_1							VARCHAR(500)
			,D_COLOR_2							VARCHAR(500)
			,YIELD								VARCHAR(500)--DECIMAL(19,4)
			,YIELD_ADITIONAL					VARCHAR(500)--DECIMAL(19,4)
			--==========================================================
			,QUOTE_DATE							DATE
			,PCN								VARCHAR(500)
			,VPY								VARCHAR(500)--INT
			,VPW								VARCHAR(500)--INT
			,VPD								VARCHAR(500)--INT
			,D_LEATHER							VARCHAR(500)
			--==========================================================
			,CRUST_COST							VARCHAR(500)--DECIMAL(19,4)
			,CUTTING_COST						VARCHAR(500)--DECIMAL(19,4)
			,SHRINK_COST						VARCHAR(500)--DECIMAL(19,4)
			,DENIM_RESISTANCE_COST				VARCHAR(500)--DECIMAL(19,4)
			,FINISHING_COST						VARCHAR(500)--DECIMAL(19,4)
			,TOTAL_COST_DRIVERS					VARCHAR(500)--DECIMAL(19,4)
			--==========================================================
			,TOTAL_PATTERN						VARCHAR(500)--INT				
			,TOTAL_NET_AREA						VARCHAR(500)--DECIMAL(20,2)	
			,TOTAL_GRO_AREA						VARCHAR(500)--DECIMAL(20,2)	
			,TOTAL_CAR_SET_PRICE				VARCHAR(500)--DECIMAL(20,2)	
			,TOTAL_CAR_SET_PRICE_PLM			VARCHAR(500)--DECIMAL(20,2)	
			--==========================================================
			,D_LAMINATION						VARCHAR(500)	
			,D_PERFORATION						VARCHAR(500)	
			,SPECIAL_PROCESS					VARCHAR(500)	
			,CANTIDAD_PATTERNS_LAMINADOS		VARCHAR(500)--INT
			,AREA_NET_LAMINADOS					VARCHAR(500)--DECIMAL(19,2)	
			,CANTIDAD_PATTERNS_PERFORADOS		VARCHAR(500)--INT
			,AREA_NET_PERFORADOS				VARCHAR(500)--DECIMAL(19,2)
			,MENSAJE							VARCHAR(500)
		)

		-----==========================================================		
		DECLARE	 @VP_CU_CUS_NO						VARCHAR(500)
				,@VP_CU_S_ARCUSFIL_PROGRAM			VARCHAR(500)
				,@VP_CU_MODELNO						VARCHAR(500)
				,@VP_CU_VERSIONNO					VARCHAR(500)
				--==========================================================
				,@VP_CU_K_TRIM_LEVEL				VARCHAR(500)--INT
				,@VP_CU_K_TRIM_COLOR				VARCHAR(500)--INT
				,@VP_CU_COLOR						VARCHAR(250)
				,@VP_CU_D_COLOR_1					VARCHAR(250)
				,@VP_CU_D_COLOR_2					VARCHAR(250)
				,@VP_CU_YIELD						VARCHAR(500)--DECIMAL(19,4)
				,@VP_CU_YIELD_ADITIONAL				VARCHAR(500)--DECIMAL(19,4)
				--==========================================================
				,@VP_CU_QUOTE_DATE					DATE
				,@VP_CU_PCN							VARCHAR(250)
				,@VP_CU_VPY							VARCHAR(500)--INT
				,@VP_CU_VPW							VARCHAR(500)--INT
				,@VP_CU_VPD							VARCHAR(500)--INT
				,@VP_CU_D_LEATHER					VARCHAR(250)
				--==========================================================
				,@VP_CU_CRUST_COST					VARCHAR(500)--DECIMAL(19,4)
				,@VP_CU_CUTTING_COST				VARCHAR(500)--DECIMAL(19,4)
				,@VP_CU_SHRINK_COST					VARCHAR(500)--DECIMAL(19,4)
				,@VP_CU_DENIM_RESISTANCE_COST		VARCHAR(500)--DECIMAL(19,4)
				,@VP_CU_FINISHING_COST				VARCHAR(500)--DECIMAL(19,4)
				,@VP_CU_TOTAL_COST_DRIVERS			VARCHAR(500)--DECIMAL(19,4)
				,@VP_DIVISION_CUSNO_PROGRAM_MODEL	VARCHAR(500)	= ''
				,@VP_CU_CUSNO_CONTADOR				INT	= 0
				,@VP_CLIENTE						VARCHAR(500)	= ''
				,@VP_CLIENTE_CONTADOR				INT	= 0

		DECLARE CU_CURSOR				CURSOR LOCAL STATIC FOR
			SELECT	CCVERHDR_SQL.CUS_NO, 
					S_ARCUSFIL_PROGRAM,
					MODELNO, VERSIONNO,
					-----============================================= MODELO
					QUOTE_TRIM_LEVEL.K_QUOTE_TRIM_LEVEL,
					-----============================================= COLOR
					QUOTE_TRIM_COLOR.K_QUOTE_TRIM_COLOR,
					LTRIM(RTRIM(UPPER(ITEM_NO)))		AS COLOR,
					LTRIM(RTRIM(UPPER(item_desc_1)))	AS D_COLOR_1,
					LTRIM(RTRIM(UPPER(item_desc_2)))	AS D_COLOR_2,
					YIELD_COLOR							AS YIELD,
					YIELD_COLOR_ADITIONAL				AS YIELD_ADITIONAL,				
					-----============================================= MODELO
					QUOTE_TRIM_LEVEL.F_ALTA				AS QUOTE_DATE,
					PBD_REFERENCE						AS PCN,
					VOLUME								AS VPY,
					((VOLUME	/ 235 )*5)				AS VPW,
					(VOLUME	/ 235 )						AS VPD,
					D_GRAIN								AS D_LEATHER,
					-----============================================= LEATHER COST
					CRUST_COST							AS CRUST_COST			,
					CUTTING_COST						AS CUTTING_COST			,
					SHRINK_COST							AS SHRINK_COST			,	
					DENIM_RESISTANCE_COST				AS DENIM_RESISTANCE_COST,	
					FINISHING_COST						AS FINISHING_COST		,	
					TOTAL_COST_DRIVERS					AS TOTAL_COST_DRIVERS	
			FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_TRIM_LEVEL	(NOLOCK)	
			INNER JOIN	DATA_02.DBO.CCVERHDR_SQL						(NOLOCK)	ON	QUOTE_TRIM_LEVEL.S_QUOTE_TRIM_LEVEL	=	LTRIM(RTRIM(CCVERHDR_SQL.MODELNO))
			AND		FORMAT(QUOTE_TRIM_LEVEL.VERSION_NO,'0000')		= LTRIM(RTRIM(CCVERHDR_SQL.VERSIONNO))
			INNER JOIN COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_TRIM_COLOR			(NOLOCK)	ON	QUOTE_TRIM_COLOR.K_QUOTE_TRIM_LEVEL		=	QUOTE_TRIM_LEVEL.K_QUOTE_TRIM_LEVEL
			INNER JOIN COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_LEATHER_COST		(NOLOCK)	ON	QUOTE_LEATHER_COST.K_QUOTE_TRIM_LEVEL	=	QUOTE_TRIM_LEVEL.K_QUOTE_TRIM_LEVEL
			INNER JOIN COT19_COTIZACIONES_V9999_R0.DBO.GRAIN					(NOLOCK)	ON	GRAIN.K_GRAIN							=	QUOTE_TRIM_LEVEL.K_GRAIN
			INNER JOIN	ARCUSFIL_PROGRAM		(NOLOCK)	ON	ARCUSFIL_PROGRAM.K_ARCUSFIL_PROGRAM	=	QUOTE_TRIM_LEVEL.K_ARCUSFIL_PROGRAM
			INNER JOIN DATA_02.DBO.IMITMIDX_SQL	(NOLOCK)	ON	IMITMIDX_SQL.A4GLIDENTITY			=	QUOTE_TRIM_COLOR.K_COLOR
			WHERE	CCVERHDR_SQL.STATUS			= 'L' -- IN ('A', 'I', 'L' )--( @VP_CCVERHDR_SQL_STATUS	 )		--= 'L' 
			AND		CCVERHDR_SQL.SPECSTATUS		= 'U' -- IN ('A', 'C', 'U' )--( @VP_CCVERHDR_SQL_SPECSTATUS )	--= 'U'
			AND		CCVERHDR_SQL.MODELNO NOT IN ('GW2','GWL','GWS','XYZ')	---- OBSOLETAS
			AND		( @PP_CUS_NO	=	'( TODOS )'		OR		CCVERHDR_SQL.CUS_NO	 =	@PP_CUS_NO	)
			ORDER BY CCVERHDR_SQL.CUS_NO, MODELNO, S_ARCUSFIL_PROGRAM, VERSIONNO
			--ORDER BY CCVERHDR_SQL.CUS_NO, S_ARCUSFIL_PROGRAM, MODELNO, VERSIONNO

		OPEN CU_CURSOR
			FETCH NEXT FROM CU_CURSOR INTO	@VP_CU_CUS_NO			,@VP_CU_S_ARCUSFIL_PROGRAM
											,@VP_CU_MODELNO			,@VP_CU_VERSIONNO		,@VP_CU_K_TRIM_LEVEL		,@VP_CU_K_TRIM_COLOR
											,@VP_CU_COLOR			,@VP_CU_D_COLOR_1		,@VP_CU_D_COLOR_2		
											,@VP_CU_YIELD			,@VP_CU_YIELD_ADITIONAL
											,@VP_CU_QUOTE_DATE		,@VP_CU_PCN
											,@VP_CU_VPY				,@VP_CU_VPW				,@VP_CU_VPD				,@VP_CU_D_LEATHER
											,@VP_CU_CRUST_COST					
											,@VP_CU_CUTTING_COST				
											,@VP_CU_SHRINK_COST					
											,@VP_CU_DENIM_RESISTANCE_COST		
											,@VP_CU_FINISHING_COST				
											,@VP_CU_TOTAL_COST_DRIVERS			
			WHILE @@FETCH_STATUS = 0
			BEGIN
					
					DECLARE		 @VP_CUSNO_PROGRAM_MODEL		VARCHAR(500)	= CONCAT( @VP_CU_CUS_NO,@VP_CU_S_ARCUSFIL_PROGRAM,@VP_CU_MODELNO )
								,@VP_ESPACIO_01					INT	= 0
					
					IF @VP_CU_CUSNO_CONTADOR	> 0
					BEGIN
						IF @VP_DIVISION_CUSNO_PROGRAM_MODEL	<> @VP_CUSNO_PROGRAM_MODEL
						BEGIN
							SET	@VP_ESPACIO_01				= 10
						END
					END
					ELSE
					BEGIN
						SET	@VP_ESPACIO_01				= 10
					END

						SET	@VP_CU_CUSNO_CONTADOR	+= 1
						SET	@VP_DIVISION_CUSNO_PROGRAM_MODEL	= @VP_CUSNO_PROGRAM_MODEL

					--=================================================================================
					IF @VP_CLIENTE_CONTADOR	= 0
					BEGIN
						SET	@VP_CLIENTE				= @VP_CU_CUS_NO
						SET @VP_CLIENTE_CONTADOR	+= 1
					END

					IF @VP_CLIENTE	<>	@VP_CU_CUS_NO
					BEGIN
						SET @VP_CLIENTE_CONTADOR	+= 1
						SET	@VP_CLIENTE	= @VP_CU_CUS_NO
					END
					ELSE
					BEGIN
						SET	@VP_CLIENTE	= @VP_CU_CUS_NO
					END
					--=================================================================================
					--=================================================================================

					DECLARE		@TA_KITS	TABLE
					(		TA_KIT_ITEM_NO	VARCHAR(50)		)

					INSERT INTO		@TA_KITS
					SELECT	 LTRIM(RTRIM(CCCUSITM_SQL.ITEM_NO))	--	AS S_KIT
					FROM	CCCUSITM_SQL			(NOLOCK)
					INNER JOIN	IMITMIDX_SQL		(NOLOCK)	ON	IMITMIDX_SQL.item_no		= CCCUSITM_SQL.ITEM_NO
					AND		CUS_NO						=	@VP_CU_CUS_NO			--	'GRAM04'	--
					AND		MODELNO						=	@VP_CU_MODELNO			--	'GWS'		--
					AND		VERSIONNO					=	@VP_CU_VERSIONNO		--	'0002'		--
					AND		CCCUSITM_SQL.ITEM_NO		LIKE 'P%' + RIGHT(LTRIM(RTRIM(@VP_CU_COLOR)),6)
					AND		L_ACTIVO					=	1

					--=================================================================================
					--=================================================================================
					--SE OBTIENE EL TOTAL DE LOS PATRONES POR TRIM_COLOR
					DECLARE  @VP_TOTAL_PATTERN				INT				= 0
							,@VP_TOTAL_NET_AREA				DECIMAL(20,2)	= 0
							,@VP_TOTAL_GRO_AREA				DECIMAL(20,2)	= 0
							,@VP_TOTAL_CAR_SET_PRICE		DECIMAL(20,2)	= 0
							,@VP_TOTAL_CAR_SET_PRICE_PLM	DECIMAL(20,2)	= 0
												
					SELECT	@VP_TOTAL_PATTERN					=	ISNULL(SUM(PATTERN_QUANTITY_KIT),0),
							@VP_TOTAL_NET_AREA					=	ISNULL(SUM(NET_AREA_KIT),0),
							@VP_TOTAL_GRO_AREA					=	ISNULL(SUM(GROSS_AREA_KIT),0),
							@VP_TOTAL_CAR_SET_PRICE				=	ISNULL(SUM(PRICE_PER_PIECE_KIT),0),
							@VP_TOTAL_CAR_SET_PRICE_PLM			=	ISNULL(SUM(PRICE_ONLY_CUTTING_KIT),0)
					FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_KIT		(NOLOCK)
					WHERE	QUOTE_KIT.K_QUOTE_TRIM_COLOR		=	@VP_CU_K_TRIM_COLOR					
					AND		CONCAT( QUOTE_KIT.S_QUOTE_KIT, RIGHT(LTRIM(RTRIM(@VP_CU_COLOR)),6))	IN		(	SELECT TA_KIT_ITEM_NO FROM @TA_KITS )
			
					--=================================================================================
					DECLARE  @VP_D_LAMINATION				VARCHAR(500)	= ''
							,@VP_D_PERFORATION				VARCHAR(500)	= ''
							,@VP_SPECIAL_PROCESS			VARCHAR(500)	= ''


					SELECT  @VP_D_LAMINATION	=	@VP_D_LAMINATION + ' // ' + D_QUOTE_PROCESS_SPECIAL_COST
					FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PROCESS_SPECIAL_COST		(NOLOCK)
					WHERE	K_QUOTE_TRIM_LEVEL	IN ( @VP_CU_K_TRIM_LEVEL )
					AND		K_PROCESS			IN ( 2, 8, 9, 11, 12, 13 )

					SET		@VP_D_LAMINATION = SUBSTRING(@VP_D_LAMINATION,4,LEN(@VP_D_LAMINATION))

					SELECT  @VP_D_PERFORATION	=	@VP_D_PERFORATION + ' // ' + D_QUOTE_PROCESS_SPECIAL_COST
					FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PROCESS_SPECIAL_COST		(NOLOCK)
					WHERE	K_QUOTE_TRIM_LEVEL IN (@VP_CU_K_TRIM_LEVEL)
					AND		K_PROCESS			IN ( 3, 10 )

					SET		@VP_D_PERFORATION = SUBSTRING(@VP_D_PERFORATION,4,LEN(@VP_D_PERFORATION))

					SELECT  @VP_SPECIAL_PROCESS	=	@VP_SPECIAL_PROCESS + ' // ' + D_QUOTE_PROCESS_SPECIAL_COST
					FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PROCESS_SPECIAL_COST		(NOLOCK)
					WHERE	K_QUOTE_TRIM_LEVEL IN (@VP_CU_K_TRIM_LEVEL)
					AND		K_PROCESS			IN ( 1, 4, 5, 6, 14 )

					SET		@VP_SPECIAL_PROCESS = SUBSTRING(@VP_SPECIAL_PROCESS,4,LEN(@VP_SPECIAL_PROCESS))

					--=================================================================================

					DECLARE		@TA_PATTERNS	TABLE
					(		TA_PAT_ITEM_NO	VARCHAR(50)		)

					INSERT INTO		@TA_PATTERNS
					SELECT	comp_item_no
					FROM	[DATA_02].[DBO].ccprdstr_sql	(NOLOCK)
					WHERE	CUS_NO						=	@VP_CU_CUS_NO
					AND		MODELNO						=	@VP_CU_MODELNO
					AND		VERSIONNO					=	@VP_CU_VERSIONNO
					AND		item_no		in (	SELECT TA_KIT_ITEM_NO FROM @TA_KITS		)


					DECLARE	 @VP_CANTIDAD_PATTERN_LAMINADOS			INT
							,@VP_AREA_NET_LAMINADOS					DECIMAL(19,2)	= 0
							,@VP_CANTIDAD_PATTERN_PERFORADOS		INT
							,@VP_AREA_NET_PERFORADOS				DECIMAL(19,2)	= 0

					SELECT	@VP_CANTIDAD_PATTERN_LAMINADOS	= COUNT(QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_PATTERN),
							@VP_AREA_NET_LAMINADOS			= ISNULL(( SUM(NET_AREA_PATTERN) ),0)
					FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PATTERN							(NOLOCK) 
					INNER JOIN COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PROCESS_SPECIAL_COST_CHECKS	(NOLOCK) ON QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_PATTERN	= QUOTE_PATTERN.K_QUOTE_PATTERN
					AND		QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_KIT			= QUOTE_PATTERN.K_QUOTE_KIT
					AND		QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_TRIM_COLOR	= QUOTE_PATTERN.K_QUOTE_TRIM_COLOR
					WHERE	K_PROCESS			IN ( 2, 8, 9, 11, 12, 13 )
					AND		QUOTE_PATTERN.K_QUOTE_TRIM_COLOR						= @VP_CU_K_TRIM_COLOR
					AND		CONCAT(	QUOTE_PATTERN.ITEM_NUMBER_PATTERN, RIGHT(LTRIM(RTRIM(@VP_CU_COLOR)),6)	)	IN	(	SELECT TA_PAT_ITEM_NO	FROM	@TA_PATTERNS	)

					SELECT	@VP_CANTIDAD_PATTERN_PERFORADOS	= COUNT(QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_PATTERN),
							@VP_AREA_NET_PERFORADOS			= ISNULL(( SUM(NET_AREA_PATTERN) ),0)
					FROM	COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PATTERN							(NOLOCK) 
					INNER JOIN COT19_COTIZACIONES_V9999_R0.DBO.QUOTE_PROCESS_SPECIAL_COST_CHECKS	(NOLOCK) ON QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_PATTERN	= QUOTE_PATTERN.K_QUOTE_PATTERN
					AND		QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_KIT			= QUOTE_PATTERN.K_QUOTE_KIT
					AND		QUOTE_PROCESS_SPECIAL_COST_CHECKS.K_QUOTE_TRIM_COLOR	= QUOTE_PATTERN.K_QUOTE_TRIM_COLOR
					WHERE	K_PROCESS			IN ( 3, 10 )
					AND		QUOTE_PATTERN.K_QUOTE_TRIM_COLOR						= @VP_CU_K_TRIM_COLOR
					AND		CONCAT(	QUOTE_PATTERN.ITEM_NUMBER_PATTERN, RIGHT(LTRIM(RTRIM(@VP_CU_COLOR)),6)	)	IN	(	SELECT TA_PAT_ITEM_NO	FROM	@TA_PATTERNS	)

					--=================================================================================
					IF @VP_ESPACIO_01				= 0
					BEGIN
							SET	@VP_CU_CUS_NO				= ''
							SET	@VP_CU_S_ARCUSFIL_PROGRAM	= ''
							SET	@VP_CU_MODELNO				= ''
							SET	@VP_CU_VERSIONNO			= ''
							SET	@VP_CU_YIELD				= ''
							SET	@VP_CU_YIELD_ADITIONAL		= ''
							SET	@VP_CU_QUOTE_DATE			= NULL
							SET	@VP_CU_PCN					= ''
							SET	@VP_CU_VPY					= ''
							SET	@VP_CU_VPW					= ''
							SET	@VP_CU_VPD					= ''
							SET	@VP_CU_D_LEATHER			= ''
							SET	@VP_D_LAMINATION			=''
							SET	@VP_D_PERFORATION			=''
							SET	@VP_SPECIAL_PROCESS			=''
					END
					--=================================================================================


						INSERT INTO @TA_FINAL
						SELECT	@VP_ESPACIO_01,	-- DIVISIÓN PARA LAS FILAS
								@VP_CLIENTE_CONTADOR,
								--======================
								@VP_CU_CUS_NO,					@VP_CU_S_ARCUSFIL_PROGRAM,
								@VP_CU_MODELNO,
								@VP_CU_VERSIONNO,				@VP_CU_K_TRIM_LEVEL,
								--======================
								@VP_CU_K_TRIM_COLOR,
								@VP_CU_COLOR					,--AS COLOR,
								CONCAT(@VP_CU_D_COLOR_1,' (',@VP_CU_D_COLOR_2,')'),--AS D_COLOR_1,		
								@VP_CU_D_COLOR_2				,--AS D_COLOR_2,		
								@VP_CU_YIELD					,--AS YIELD,
								@VP_CU_YIELD_ADITIONAL			,--AS YIELD_ADITIONAL,
								--======================
								@VP_CU_QUOTE_DATE				,--AS QUOTE_DATE,
								@VP_CU_PCN						,--AS PCN,
								@VP_CU_VPY						,--AS VPY,
								@VP_CU_VPW						,--AS VPW,
								@VP_CU_VPD						,--AS VPD,
								@VP_CU_D_LEATHER				,--AS D_LEATHER,
								--======================
								@VP_CU_CRUST_COST				,--AS CRUST_COST			,		
								@VP_CU_CUTTING_COST				,--AS CUTTING_COST			,	
								@VP_CU_SHRINK_COST				,--AS SHRINK_COST			,		
								@VP_CU_DENIM_RESISTANCE_COST	,--AS DENIM_RESISTANCE_COST,		
								@VP_CU_FINISHING_COST			,--AS FINISHING_COST		,		
								@VP_CU_TOTAL_COST_DRIVERS		,--AS TOTAL_COST_DRIVERS	,
								--======================
								@VP_TOTAL_PATTERN				,--AS QTY_PATTERN,
								@VP_TOTAL_NET_AREA				,--AS NET_AREA,
								@VP_TOTAL_GRO_AREA				,--AS GROSS_AREA,
								@VP_TOTAL_CAR_SET_PRICE			,--AS SET_PRICE,
								@VP_TOTAL_CAR_SET_PRICE_PLM		,--AS PLM_Cutting,
								--======================							
								@VP_D_LAMINATION				,--AS LAMINATION_TYPE		,
								@VP_D_PERFORATION				,--AS PERFORATION_TYPE		,
								@VP_SPECIAL_PROCESS				,--AS SPECIAL_PROCESS		,
								@VP_CANTIDAD_PATTERN_LAMINADOS	,		
								@VP_AREA_NET_LAMINADOS			,		
								@VP_CANTIDAD_PATTERN_PERFORADOS	,	
								@VP_AREA_NET_PERFORADOS			,
								''
				--IF @@ROWCOUNT = 0
				--BEGIN
				--	SET @VP_MENSAJE='No se encontró el REGISTRO ['+ @VP_CU_ITEM_NO +']'
				--	RAISERROR (@VP_MENSAJE, 16, 1 ) 
				--END			
			FETCH NEXT FROM CU_CURSOR INTO	@VP_CU_CUS_NO			,@VP_CU_S_ARCUSFIL_PROGRAM
											,@VP_CU_MODELNO			,@VP_CU_VERSIONNO		,@VP_CU_K_TRIM_LEVEL		,@VP_CU_K_TRIM_COLOR
											,@VP_CU_COLOR			,@VP_CU_D_COLOR_1		,@VP_CU_D_COLOR_2		
											,@VP_CU_YIELD			,@VP_CU_YIELD_ADITIONAL
											,@VP_CU_QUOTE_DATE		,@VP_CU_PCN
											,@VP_CU_VPY				,@VP_CU_VPW				,@VP_CU_VPD				,@VP_CU_D_LEATHER
											,@VP_CU_CRUST_COST					
											,@VP_CU_CUTTING_COST				
											,@VP_CU_SHRINK_COST					
											,@VP_CU_DENIM_RESISTANCE_COST		
											,@VP_CU_FINISHING_COST				
											,@VP_CU_TOTAL_COST_DRIVERS			
			END
		CLOSE CU_CURSOR
		DEALLOCATE CU_CURSOR
		
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
	SET	@VP_MENSAJE = 'No es posible [Actualizar] el Registro: ' + @VP_MENSAJE 
	SELECT	@VP_MENSAJE AS MENSAJE
END
ELSE
BEGIN
	SELECT * FROM @TA_FINAL
	--ORDER BY CUS_NO,	MODELNO, VERSIONNO, K_QUOTE_TRIM_LEVEL, K_QUOTE_TRIM_COLOR
END
	-- =====================================================================
	-- /////////////////////////////////////////////////////////////////////
GO


-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////