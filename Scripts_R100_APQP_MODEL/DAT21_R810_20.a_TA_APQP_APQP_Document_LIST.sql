-- //////////////////////////////////////////////////////////////
-- // DATA BASE:		DATA_02
-- // MODULE:			APQP_MODEL
-- // OPERATION:		TABLA
-- //////////////////////////////////////////////////////////////
-- // AUTHOR:			AX
-- // CREATION DATE:	20210201
-- ////////////////////////////////////////////////////////////// 

USE [DATA_02]
GO
--			SELECT * FROM [APQP_TEAM_ACTIVITY_LIST]			
--			SELECT * FROM [APQP_TOOL_ACTIVITY_LIST]		
--			SELECT * FROM [APQP_QUAL_ACTIVITY_LIST]
--			SELECT * FROM [APQP_FLOOR_ACTIVITY_LIST]
--			SELECT * FROM [APQP_FLOW_ACTIVITY_LIST]
--			SELECT * FROM [APQP_PFMEA_ACTIVITY_LIST]
--			SELECT * FROM [APQP_CONTROL_ACTIVITY_LIST]
--			SELECT * FROM [APQP_RISK_ACTIVITY_LIST]			

-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_RISK_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_RISK_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_CONTROL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_CONTROL_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_PFMEA_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_PFMEA_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_FLOW_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_FLOW_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_FLOOR_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_FLOOR_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_QUAL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_QUAL_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_TOOL_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_TOOL_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APQP_TEAM_ACTIVITY_LIST]') AND type in (N'U'))
	DROP TABLE [dbo].[APQP_TEAM_ACTIVITY_LIST]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]
GO

-- ////////////////////////////////////////////////////////////////
-- //					APQP_TEAM_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_TEAM_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_TEAM_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_TEAM_ACTIVITY_LIST]				[VARCHAR](255),
			-- ===========================
			[L_APQP_TEAM_ACTIVITY_LIST]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_TEAM_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_TEAM_ACTIVITY_LIST]				[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_TEAM_ACTIVITY_LIST_VISIBLE]		[INT] NOT NULL	DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_TEAM_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_TEAM_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_TEAM_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_TEAM_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_TEAM_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_TEAM_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_TEAM_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_TEAM_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_TEAM_ACTIVITY_LIST				VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_TEAM_ACTIVITY_LIST
			(	[D_APQP_TEAM_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TEAM_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TEAM_ACTIVITY_LIST_VISIBLE],
				[K_APQP_TEAM_ACTIVITY_LIST_TYPE],
				[O_APQP_TEAM_ACTIVITY_LIST]
				)
	VALUES	
			(	@PP_D_APQP_TEAM_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TEAM_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TEAM_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_TEAM_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_TEAM_ACTIVITY_LIST
				)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'TEAM CHECK GENERAL'

EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Is product adequately defined (application requirements, etc.) to enable feasibility evaluation?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Can Engineering Performance Specifications be met as written?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Can product be manufactured to tolerances specified on drawing?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'Can product be manufactured with Cpk´s that meet requirements?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,50,	'Is there adequate capacity to produce product?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,10,60,	'Does the design allow the use of efficient material handling techniques?'
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Can the product be manufactured without incurring any unusual:'

EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,10,	'- Costs for capital equipment?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,20,	'- Costs for tooling?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,30,	'- Alternative manufacturing methods?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,40,	'Is statistical process control required on the product?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,20,50,	'Is statistical process control presently used on similar products?'
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Where statistical process control is used on similar products:'

EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,30,10,	'- Are the processes in control and stable?'
EXECUTE [dbo].[PG_CI_APQP_TEAM_ACTIVITY_LIST]  0, 139,	1,1,30,20,	'- Are Cpk´s greater than 1.33?'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_TOOL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_TOOL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_TOOL_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_TOOL_ACTIVITY_LIST]				[VARCHAR](255),
			[RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_TOOL_ACTIVITY_LIST]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_TOOL_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_TOOL_ACTIVITY_LIST]				[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_TOOL_ACTIVITY_LIST_VISIBLE]		[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_TOOL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_TOOL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_TOOL_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_TOOL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_TOOL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_TOOL_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_TOOL_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_TOOL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_TOOL_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST		VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_TOOL_ACTIVITY_LIST
			(	[D_APQP_TOOL_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TOOL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_TOOL_ACTIVITY_LIST_VISIBLE],
				[K_APQP_TOOL_ACTIVITY_LIST_TYPE],
				[O_APQP_TOOL_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_TOOL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_TOOL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TOOL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_TOOL_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_TOOL_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_TOOL_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,00,	'Does the design require:'											,''

EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'New materials?'													,'G. Mata / J. Holguin'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Quick change?'														,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Volume fluctuations?'												,'G. Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'Mistake proofing?'													,'M. Carrasco'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Have lists been prepared identifying:'								,''

EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,10,	'New equipment?'													,'G. Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,20,	'New tooling?'														,'G. Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,20,30,	'New test equipment?'												,'O. Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Has acceptance criteria been agreed upon for:'																			,''

EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,10,	'New equipment?'																										,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,20,	'New tooling?'																											,'G. Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,30,	'New test equipment?'																									,'N	/ A'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,40,	'Will a preliminary capability study be conducted at the tooling and/or equipment manufacturer?'						,'J. Holguin / O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,50,	'Has test equipment feasibility and accuracy been established?'															,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,60,	'Is a preventive maintenance plan complete for equipment and tooling?'													,'G. Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,70,	'Are setup instructions for new equipment and tooling complete and understandable?'										,'G. Mata'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,80,	'Will capable gages be available to run preliminary process capability studies at the equipment supplier´s facility?'	,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,90,	'Will preliminary process capability studies be run at the processing plant?'											,'O. Decena / J. Holguin'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,100,	'Have process characteristics that affect special product characteristics been identified?'								,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,110,	'Were special product characteristics used in determining acceptance criteria?'											,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,210,	'Does the manufacturing equipment have sufficient capacity to handle forecasted production and service volumes?'		,'O. Decena / J. Holguin'
EXECUTE [dbo].[PG_CI_APQP_TOOL_ACTIVITY_LIST]  0, 139,	1,1,30,310,	'Is testing capacity sufficient to provide adequate testing?'															,'O. Decena / J. Holguin'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_QUAL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_QUAL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_QUAL_ACTIVITY_LIST]				[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_QUAL_ACTIVITY_LIST]				[VARCHAR](255),
			[RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_QUAL_ACTIVITY_LIST]				[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_QUAL_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_QUAL_ACTIVITY_LIST]				[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_QUAL_ACTIVITY_LIST_VISIBLE]		[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_QUAL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_QUAL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_QUAL_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_QUAL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_QUAL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_QUAL_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_QUAL_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_QUAL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_QUAL_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST		VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_QUAL_ACTIVITY_LIST
			(	[D_APQP_QUAL_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_QUAL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_QUAL_ACTIVITY_LIST_VISIBLE],
				[K_APQP_QUAL_ACTIVITY_LIST_TYPE],
				[O_APQP_QUAL_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_QUAL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_QUAL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_QUAL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_QUAL_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_QUAL_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_QUAL_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'QUAL CHECK GENERAL'															,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Is the assistance of the customer´s quality assurance or product engineering activity needed to develop or concur to the control plan?'	,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Has the supplier identified who will be the quality liaison with the customer?'															,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Has the supplier identified who will be the quality liaison with its suppliers?'															,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'Has the quality assurance system been reviewed using the Chrysler, Ford, and General Motors Quality System Assessment?'					,'O. Decena'
		  
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Are there sufficient personnel identified to cover:'							,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,10,	'Control plan requirements?'																												,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,20,	'Layout inspection?'																														,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,30,	'Engineering performance testing?'																											,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,20,40,	'Problem resolution analysis?'																												,'O. Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Is there a documented training program that:'																								,' --- '
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,10,	'Includes all employees?'																													,'A. de la Ree'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,20,	'Lists whose been trained?'																													,'A. de la Ree'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,30,30,	'Provides a training schedule?'																												,'A. de la Ree'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,00,	'Has training been completed for:'											,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,10,	'Statistical process control?'																												,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,20,	'Capability studies?'																														,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,30,	'Problem solving?'																															,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,40,	'Mistake proofing?'																															,'J. Holguin/ O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,50,	'Other topics as identified?'																												,' --- '
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,60,	'Is each operation provided with process instructions that are keyed to the control plan?'													,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,70,	'Are standard operator instructions available at each operation?'																			,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,40,80,	'Were operator/team leaders involved in developing standard operator instructions?'															,'O. Decena / G. Mata'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,00,	'Do inspection instructions include:'								,''

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,10,	'Easily understood engineering performance specifications?'													,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,20,	'Test frequencies?'																							,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,30,	'Sample sizes?'																								,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,40,	'Reaction plans?'																							,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,50,50,	'Documentation?'																							,'O. Decena / G. Mata'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,00,	'Are visual aids:'																							,' --- '

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,10,	'Easily understood?'																						,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,20,	'Available?'																								,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,30,	'Accessible?'																								,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,40,	'Approved?'																									,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,50,	'Dated and current?'																						,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,60,	'Is there a procedure to implement, maintain, and establish reaction plans for statistical control charts?'	,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,70,	'Is there an effective root cause analysis system in place?'												,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,80,	'Have provisions been made to place the latest drawings and specifications at the point of the inspection?'	,'G. Mata / O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,60,90,	'Are forms/logs available for appropriate personnel to record inspection results?'							,'O. Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,00,	'Have provisions been made to place the following at the monitored operation:'								,' --- '

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,10,	'Inspection gages?'																							,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,20,	'Gage instructions?'																						,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,30,	'Reference samples?'																						,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,40,	'Inspection logs?'																							,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,70,50,	'Have provisions been made to certify and routinely calibrate gages and test equipment?'					,'O. Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,80,00,	'Have required measurement system capability studies been:'																		,' --- '

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,80,10,	'Completed?'																													,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,80,20,	'Acceptable?'																													,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,80,30,	'Are layout inspection equipment and facilities adequate to provide initial and ongoing layout of all details and components?'	,'O. Decena'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,00,	'Is there a procedure for controlling incoming product that identifies:'									,' --- '

EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,10,	'Characteristics to be inspected?'																			,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,20,	'Frequency of inspection?'																					,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,30,	'Sample size?'																								,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,40,	'Designated location for approved product?'																	,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,50,	'Disposition of nonconforming products?'																	,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,60,	'Is there a procedure to identify, segregate, and control nonconforming products to prevent shipment?'		,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,70,	'Are rework/repair procedures available?'																	,'N / A'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,80,	'Is there a procedure to requalify repaired/reworked material?'												,'N / A'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,90,	'Is there an appropriate lot traceability procedure?'														,'O. Decena / G. Mata'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,100,	'Are periodic audits of outgoing products planned and implemented?'											,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,110,	'Are periodic surveys of the quality system planned and implemented?'										,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_QUAL_ACTIVITY_LIST]  0, 139,	1,1,90,120,	'Has the customer approved the packaging specification?'													,'O. Decena'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_FLOOR_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_FLOOR_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_FLOOR_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_FLOOR_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_FLOOR_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_FLOOR_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_FLOOR_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_FLOOR_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_FLOOR_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_FLOOR_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_FLOOR_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_FLOOR_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_FLOOR_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_FLOOR_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_FLOOR_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_FLOOR_ACTIVITY_LIST
			(	[D_APQP_FLOOR_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOOR_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE],
				[K_APQP_FLOOR_ACTIVITY_LIST_TYPE],
				[O_APQP_FLOOR_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_FLOOR_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_FLOOR_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOOR_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOOR_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_FLOOR_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_FLOOR_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'FLOOR CHECK GENERAL'																						,' --- '

EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Does the floor plan identify all required process and inspection points?'									,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Have clearly marked areas for all material, tools, and equipment at each operation been considered?'		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Has sufficient space been allocated for all equipment?'													,'STAFF'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'Are process and inspection areas:'																			,' --- '

EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,10,	'Of adequate size?'																							,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,20,	'Properly lighted?'																							,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,20,30,	'Do inspection areas contain necessary equipment and files?'												,'STAFF'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'Are there adequate:'																																	,' --- '

EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,10,	'Staging areas?'																																		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,20,	'Impound areas?'																																		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,30,	'Are inspection points logically located to prevent shipment of nonconforming products?'																,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,40,	'Have controls been established to eliminate the potential for an operation, including outside processing, to contaminate or mix similar products?'		,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,50,	'Is material protected from overhead or air handling systems contamination?'																			,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,60,	'Have final audit facilities been provided?'																											,'STAFF'
EXECUTE [dbo].[PG_CI_APQP_FLOOR_ACTIVITY_LIST]  0, 139,	1,1,30,70,	'Are controls adequate to prevent movement of nonconforming incoming material to storage or point of use?'												,'M. Carrasco'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_FLOW_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_FLOW_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_FLOW_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_FLOW_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_FLOW_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_FLOW_ACTIVITY_LIST_TYPE]	[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_FLOW_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_FLOW_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_FLOW_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_FLOW_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_FLOW_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_FLOW_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_FLOW_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_FLOW_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_FLOW_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_FLOW_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_FLOW_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_FLOW_ACTIVITY_LIST
			(	[D_APQP_FLOW_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOW_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_FLOW_ACTIVITY_LIST_VISIBLE],
				[K_APQP_FLOW_ACTIVITY_LIST_TYPE],
				[O_APQP_FLOW_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_FLOW_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_FLOW_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOW_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_FLOW_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_FLOW_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_FLOW_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'FLOW CHECK GENERAL'																							,' --- '

EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Does the flow chart illustrate the sequence of production and inspection stations?'							,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Were all appropriate FMEA´s (SFMEA, DFMEA) available and used as aids to develop the process flow chart?'		,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Is the flow chart keyed to product and process checks in the control plan?'									,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'Does the flow chart describe how the product will move, i.e., roller conveyor, slide containers, etc.?'		,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,50,	'Has the pull system/optimization been considered for this process?'											,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,60,	'Have provisions been made to identify and inspect reworked product before being used?'							,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_FLOW_ACTIVITY_LIST]  0, 139,	1,1,10,70,	'Have potential quality problems due to handling and outside processing been identified and corrected?'			,'M. Carrasco'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_PFMEA_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_PFMEA_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_PFMEA_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_PFMEA_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_PFMEA_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_PFMEA_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_PFMEA_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_PFMEA_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_PFMEA_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_PFMEA_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_PFMEA_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_PFMEA_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_PFMEA_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_PFMEA_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_PFMEA_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_PFMEA_ACTIVITY_LIST
			(	[D_APQP_PFMEA_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_PFMEA_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE],
				[K_APQP_PFMEA_ACTIVITY_LIST_TYPE],
				[O_APQP_PFMEA_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_PFMEA_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_PFMEA_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_PFMEA_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_PFMEA_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_PFMEA_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_PFMEA_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'PFMEA CHECK GENERAL'																														,' --- '

EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Was the Process FMEA prepared using the Chrysler, Ford, and General Motors guidelines?'													,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Have all operations affecting fit, function, durability, governmental regulations and safety been identified and listed sequentially?'		,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Were similar part FMEA´s considered?'																										,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'Have historical campaign and warranty data been reviewed?'																					,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,50,	'Have appropriate corrective actions been planned or taken for high risk priority items?'													,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,60,	'Have appropriate corrective actions been planned or taken for high severity numbers?'														,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,70,	'Were risk priorities numbers revised when corrective action was completed?'																,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,80,	'Were high severity numbers revised when a design change was completed?'																	,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,90,	'Do the effects consider the customer in terms of the subsequent operation, assembly, and product?'											,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,100,	'Was warranty information used as an aid in developing the Process FMEA?'																	,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,110,	'Were customer plant problems used as an aid in developing the Process FMEA?'																,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,120,	'Have the causes been described in terms of something that can be fixed or controlled?'														,'M. Carrasco'
EXECUTE [dbo].[PG_CI_APQP_PFMEA_ACTIVITY_LIST]  0, 139,	1,1,10,130,	'Where detection is the major factor, have provisions been made to control the cause prior to the next operation?'							,'M. Carrasco'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_CONTROL_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_CONTROL_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_CONTROL_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_CONTROL_ACTIVITY_LIST]			[VARCHAR](255),
			[RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST]	[VARCHAR](255)	NOT NULL DEFAULT '',
			-- ===========================
			[L_APQP_CONTROL_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_CONTROL_ACTIVITY_LIST_TYPE]		[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_CONTROL_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_CONTROL_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_CONTROL_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_CONTROL_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_CONTROL_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_CONTROL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_CONTROL_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_CONTROL_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_CONTROL_ACTIVITY_LIST				VARCHAR(255),
	@PP_RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST	VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_CONTROL_ACTIVITY_LIST
			(	[D_APQP_CONTROL_ACTIVITY_LIST],
				[RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_CONTROL_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE],
				[K_APQP_CONTROL_ACTIVITY_LIST_TYPE],
				[O_APQP_CONTROL_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_CONTROL_ACTIVITY_LIST,
				@PP_RESPONSIBLE_APQP_CONTROL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_CONTROL_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_CONTROL_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_CONTROL_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_CONTROL_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,0,10,00,	'CONTROL CHECK GENERAL'																												,' --- '

EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'Was the control plan methodology referenced in Section 6 used in preparing the control plan?'										,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'Have all known customer complaints been identified to facilitate the selection of special product/process characteristics?'		,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'Are all special product/process characteristics included in the control plan?'														,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'Were SFMEA, DFMEA, and PFMEA used to prepare the control plan?'																	,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,50,	'Are material specifications requiring inspection identified?'																		,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,60,	'Does the control pan address incoming (material/components) through processing/assembly including packaging?'						,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,70,	'Are engineering performance testing requirements identified?'																		,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,80,	'Are gages and test equipment available as required by the control plan?'															,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,90,	'If required, has the customer approved the control plan?'																			,'O. Decena'
EXECUTE [dbo].[PG_CI_APQP_CONTROL_ACTIVITY_LIST]  0, 139,	1,1,10,100,	'Are gage methods compatible between supplier and customer?'																		,'O. Decena'
SET NOCOUNT OFF
GO


-- ////////////////////////////////////////////////////////////////
-- //					APQP_RISK_ACTIVITY_LIST
-- ////////////////////////////////////////////////////////////////
CREATE TABLE [dbo].[APQP_RISK_ACTIVITY_LIST]	(
			-- ============================	
			[K_APQP_RISK_ACTIVITY_LIST]			[INT] IDENTITY (1,1)	NOT NULL,
			[D_APQP_RISK_ACTIVITY_LIST]			[VARCHAR](255),
			-- ===========================
			[L_APQP_RISK_ACTIVITY_LIST]			[INT] NOT NULL DEFAULT 1,
			-- ===========================
			[K_APQP_RISK_ACTIVITY_LIST_TYPE]	[INT] NOT NULL,		--	INDICA LA SECCIÓN DONDE SE MOSTRARÁ LA PREGUNTA EN EL LISTADO.
			[O_APQP_RISK_ACTIVITY_LIST]			[INT] NOT NULL,		--	ES EL ORDEN QUE LLEVARÁ EN EL LISTADO
			[L_APQP_RISK_ACTIVITY_LIST_VISIBLE]	[INT] NOT NULL DEFAULT 1
) ON [PRIMARY]
GO
-- //////////////////////////////////////////////////////
ALTER TABLE [dbo].[APQP_RISK_ACTIVITY_LIST]	
	ADD CONSTRAINT [K_APQP_RISK_ACTIVITY_LIST]
		PRIMARY KEY CLUSTERED ([K_APQP_RISK_ACTIVITY_LIST])
GO


-- //////////////////////////////////////////////////////////////
-- //				CI - APQP_RISK_ACTIVITY_LIST
-- //////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]
	@PP_K_SISTEMA_EXE					INT,
	@PP_K_USUARIO_ACCION				INT,
	-- ===========================
	@PP_L_APQP_RISK_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_L_APQP_RISK_ACTIVITY_LIST_VISIBLE		INT,
	@PP_K_APQP_RISK_ACTIVITY_LIST_TYPE			INT,
	@PP_O_APQP_RISK_ACTIVITY_LIST				INT,
	-- ===========================
	@PP_D_APQP_RISK_ACTIVITY_LIST				VARCHAR(255)
AS
	-- ===========================
	INSERT INTO APQP_RISK_ACTIVITY_LIST
			(	[D_APQP_RISK_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_RISK_ACTIVITY_LIST],
				-- ===========================
				[L_APQP_RISK_ACTIVITY_LIST_VISIBLE],
				[K_APQP_RISK_ACTIVITY_LIST_TYPE],
				[O_APQP_RISK_ACTIVITY_LIST]			)
	VALUES	
			(	@PP_D_APQP_RISK_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_RISK_ACTIVITY_LIST,
				-- ===========================
				@PP_L_APQP_RISK_ACTIVITY_LIST_VISIBLE,
				@PP_K_APQP_RISK_ACTIVITY_LIST_TYPE,
				@PP_O_APQP_RISK_ACTIVITY_LIST		)		
	-- //////////////////////////////////////////////////////////////
GO
SET NOCOUNT ON
-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,00,	'DESIGN CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,10,	'- New Commodity For Selected Supplier? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,20,	'- New Materials or Technology? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,30,	'- New/Different Application of a Carry-Over Part? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,40,	'- New Design Concept?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,50,	'- Are there Safety/Emissions/Noise Requirements?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,60,	'- Offshore Engineering Site?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,70,	'- Will Design Need To Be Coordinated With Mating Parts For Fit, Function, or Appearance?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,80,	'- Are There Other Car Line Applications Planned?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,90,	'- Any Historic Quality/Warranty Issues?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,100,	'- Is Program Timing An Issue?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,10,110,	'- Are Sample Submission Dates Too Late for MTS´s?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,00,	'MANUFACTURING CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,10,	'- New Manufacturing Facility? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,20,	'- Is This a New Manufacturing Process? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,30,	'- A Part or System With Historical Launch Problems? (RISK DRIVER*)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,40,	'- Offshore Manufacturing Site?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,50,	'- Will Supplier Need Source Evaluation?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,60,	'- Is New Production Equipment Required?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,70,	'- Are Special Tools or Tooling Fixtures Required?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,80,	'- Are Gages or Check Fixtures Required to Ensure Dimensional Integrity?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,90,	'- Any Potential Handling or Shipping Issues?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,100,	'- Will Parts Ever Be Shipped From a Location Other Than The Primary Source (i.e. Warehouse ,Offshore, etc.)'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,110,	'- Will Returnable Packaging Be Required?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,20,120,	'- Is JIT Delivery or Sequenced Part Delivery Required?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,30,00,	'ASSEMBLY CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,30,10,	'- Is Part Installation an Issue?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,30,20,	'- Are Special Tools/Fixtures Required to Install Part in Vehicle?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,40,00,	'SERVICE CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,40,10,	'- Is Part Serviceability a Problem?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,40,20,	'- Are Special Tools/Fixtures Required?'

-- ==================================================================================================================================================================
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,50,00,	'OTHER CATEGORY'

EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,50,10,	'- Other?'
EXECUTE [dbo].[PG_CI_APQP_RISK_ACTIVITY_LIST]  0, 139,	1,1,50,20,	'- Other?'

SET NOCOUNT OFF
GO