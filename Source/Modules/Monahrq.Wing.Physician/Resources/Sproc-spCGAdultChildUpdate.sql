/********************************************************************************************************************************/
/********************************************************************************************************************************/
/*																																*/
/*	Script: CG Adult Child Update																								*/
/*  Version: 1.0																												*/
/*	Last modified: 4/28/2016																									*/
/*	Authors: Patrick McGrath <pmcgrath@healthdatadecisions.com> and			John Hoff <jhoff@healthdatadecisions.com> 					*/
/*  Change History:																												*/
/*		4/28/2016 - version 1.0 created																						    */
/********************************************************************************************************************************/
/********************************************************************************************************************************/
/* 1. Buld a provider base and			measure table for			final ouput															        */
/* 2. Populate an all rates table to contain all needed rates from			the adult and			child working tables						    */
/* 3. Update provider base and			measure table established in step 1 with the rates from			step 2								    */
/* 4. Pull in response % breakdown by question by provider from			the initial adult and			child datasets and			add to final output	*/
/********************************************************************************************************************************/
/*1. Build a provider base and			measure table for			final ouput																	*/
/*drop table [CG_Adult_Child_Base]
drop table [CG_Provider_Base]
drop table [CG_Rates_All]
drop table [cg_responsedetail]*/
if (Object_id(N'spCGAdultChildUpdate')) is not null
	drop procedure spCGAdultChildUpdate
go

create procedure spCGAdultChildUpdate
	@WebsiteId as int
as
begin
	--	select			[x] as Pact_id
	--						,	'' as Adult_Samp
	--	into			mxmx
	--	from			[CG_CHILD]
	select			[CGPracticeId] as Practice_id
				,	'' as Adult_Samp
				,	max(AdultPracticeSampleSize) as Child_Samp
	into			[CG_Adult_Child_Base]
	from			[Targets_CGCAHPSSurveyTargets]	--[CG_child]
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		[CGPracticeId]
	
	union
	
	select			[CGPracticeId] as Practice_Id
				,	max(AdultPracticeSampleSize) as Adult_Samp
				,	'' as Child_Samp
	from			[Targets_CGCAHPSSurveyTargets]	--[CG_adult]
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		[CGPracticeId]

	/*Summarize into			Unique list of ID to  join to CG Measure Lookup Table*/
	select			a.practice_id
				,	b.[MeasureId]
				,	b.[MeasureType]
				,	b.[CAHPSQuestionType]
	into			[CG_Provider_Base]
	from			(
		select			practice_id
					,	'X' as join_key
		from			[CG_Adult_Child_Base]
		group by		practice_id
		) a
		full join	(
		select			[MeasureId]
					,	[MeasureType]
					,	[CAHPSQuestionType]
					,	'X' as Join_key
		from			[Base_CGCAHPSMeasureLookups]	--[CG_Measure_Lookup]
		) b on a.join_key = b.join_key
	order by		a.practice_id
				,	b.MeasureId

	alter table [CG_Provider_Base] add rating decimal(10, 2)
				,	peer_rating varchar(1)
				,	peer_rate decimal(10, 2)
				,	peer_percentile decimal(10, 2);

	/*****************************************************************************************************************************************************************************************************************************/
	/* 2. Populate an all rates table to contain all needed rates from			the adult and			child working tables																														 */
	select			[CGPracticeId]
				,	'AV_06_Rate' as [Measure_Id]
				,	[AV_06_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	into			[CG_Rates_All]
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_08_Rate' as [Measure_Id]
				,	[AV_08_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_10_Rate' as [Measure_Id]
				,	[AV_10_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_12_Rate' as [Measure_Id]
				,	[AV_12_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_13_Rate' as [Measure_Id]
				,	[AV_13_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_16_Rate' as [Measure_Id]
				,	[AV_16_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_17_Rate' as [Measure_Id]
				,	[AV_17_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_19_Rate' as [Measure_Id]
				,	[AV_19_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_20_Rate' as [Measure_Id]
				,	[AV_20_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_21_Rate' as [Measure_Id]
				,	[AV_21_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_22_Rate' as [Measure_Id]
				,	[AV_22_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_24_Rate' as [Measure_Id]
				,	[AV_24_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_25_Rate' as [Measure_Id]
				,	[AV_25_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_26_Rate' as [Measure_Id]
				,	[AV_26_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_27_Rate' as [Measure_Id]
				,	[AV_27_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_28_Rate' as [Measure_Id]
				,	[AV_28_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_adult_working]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_01' as [Measure_Id]
				,	[CGAdult_COMP1] as rating
				,	[CGAdult_Star_COMP1] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_COMP1] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_02' as [Measure_Id]
				,	[CGAdult_COMP2] as rating
				,	[CGAdult_Star_COMP2] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_COMP2] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_03' as [Measure_Id]
				,	[CGAdult_COMP3] as rating
				,	[CGAdult_Star_COMP3] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_COMP3] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_04' as [Measure_Id]
				,	[CGAdult_COMP4] as rating
				,	[CGAdult_Star_COMP4] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_COMP4] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_05' as [Measure_Id]
				,	[CGAdult_COMP5] as rating
				,	[CGAdult_Star_COMP5] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_COMP5] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_06' as [Measure_Id]
				,	[CGAdult_COMP6] as rating
				,	[CGAdult_Star_COMP6] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_COMP6] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	select			[CGPracticeId]
				,	'AV_COMP_OVERALL' as [Measure_Id]
				,	[CGAdult_COMP_OVERALL] as rating
				,	[CGAdult_Star_Overall] as peer_rating
				,	0.000 as peer_rate
				,	[CGAdult_%ile_Overall] as peer_percentile
	from			[CG_adult_Final]
	
	union all
	
	/*CHILD UPDATES*/
	select			[CGPracticeId]
				,	'CD_38_Rate' as [Measure_Id]
				,	[CD_38_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_39_Rate' as [Measure_Id]
				,	[CD_39_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_40_Rate' as [Measure_Id]
				,	[CD_40_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_41_Rate' as [Measure_Id]
				,	[CD_41_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_42_Rate' as [Measure_Id]
				,	[CD_42_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_43_Rate' as [Measure_Id]
				,	[CD_43_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_44_Rate' as [Measure_Id]
				,	[CD_44_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_45_Rate' as [Measure_Id]
				,	[CD_45_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_46_Rate' as [Measure_Id]
				,	[CD_46_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_47_Rate' as [Measure_Id]
				,	[CD_47_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_48_Rate' as [Measure_Id]
				,	[CD_48_Rate] as rating
				,	'' as peer_rating
				,	0.000 as peer_rate
				,	0.000 as peer_percentile
	from			[CG_child_working]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_COMP_01' as [Measure_Id]
				,	[CGChild_COMP1] as rating
				,	[CGChild_Star_COMP1] as peer_rating
				,	0.000 as peer_rate
				,	[CGChild_%ile_COMP1] as peer_percentile
	from			[CG_child_final]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_COMP_02' as [Measure_Id]
				,	[CGChild_COMP2] as rating
				,	[CGChild_Star_COMP2] as peer_rating
				,	0.000 as peer_rate
				,	[CGChild_%ile_COMP2] as peer_percentile
	from			[CG_child_final]
	
	union all
	
	select			[CGPracticeId]
				,	'CD_COMP_OVERALL' as [Measure_Id]
				,	[CGChild_COMP_OVERALL] as rating
				,	[CGChild_Star_Overall] as peer_rating
				,	0.000 as peer_rate
				,	[CGChild_%ile_Overall] as peer_percentile
	from			[CG_child_final]
	
	union all
	
	/*Final Adult-Child Composite*/
	select			[CGPracticeId]
				,	'AV_CD_Comp_Overall' as [Measure_Id]
				,	[AdultChild_COMP_Overall] as rating
				,	[AdultChild_Star_Overall] as peer_rating
				,	0.000 as peer_rate
				,	[AdultChild_%ile_Overall] as peer_percentile
	from			[CG_AdultChild_COMP_FINAL]

	alter table [CG_Rates_All]
	alter column peer_rate numeric(38,24)

	/*Update Statement for			Peer Percentile Field*/
	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp_overall_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_OVERALL'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp1_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_01'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp2_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_02'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp3_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_03'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp4_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_04'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp5_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_05'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adult_comp6_peer
			from			CG_ADULT_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_COMP_06'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			child_comp_overall_peer
			from			CG_Child_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'CD_COMP_OVERALL'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			child_comp1_peer
			from			CG_Child_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'CD_COMP_01'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			child_comp2_peer
			from			CG_Child_PEER
			)
	from			CG_RATES_ALL
	where			measure_id = 'CD_COMP_02'

	update			CG_RATES_ALL
	set				peer_rate = (
			select			adultchild_comp_overall_peer
			from			[CG_AdultChild_Peer]
			)
	from			CG_RATES_ALL
	where			measure_id = 'AV_CD_Comp_Overall'

	/*****************************************************************************************************************************************************************************************************************************/
	/* 3. Update provider base and			measure table established in step 1 with the rates from			step 2																																 */
	update			[CG_Provider_Base]
	set				rating = b.rating
	from			[CG_Provider_Base] a
		left join	[CG_Rates_All] b on a.practice_id = b.CGPracticeId
		and			a.MeasureId = b.measure_id

	/*Update Statement for			Peer Rating Field*/
	update			[CG_Provider_Base]
	set				peer_rating = b.peer_rating
	from			[CG_Provider_Base] a
		left join	[CG_Rates_All] b on a.practice_id = b.CGPracticeId
		and			a.MeasureId = b.measure_id

	/*Update Statement for			Peer Percentile Field*/
	update			[CG_Provider_Base]
	set				peer_percentile = b.peer_percentile
	from			[CG_Provider_Base] a
		left join	[CG_Rates_All] b on a.practice_id = b.CGPracticeId
		and			a.MeasureId = b.measure_id

	/*Update Statement for			Peer Rate*/
	update			[CG_Provider_Base]
	set				peer_rate = b.peer_rate
	from			[CG_Provider_Base] a
		left join	[CG_Rates_All] b on a.practice_id = b.CGPracticeId
		and			a.MeasureId = b.measure_id

	/*****************************************************************************************************************************************************************************************************************************/
	/* 4. Pull in response % breakdown by question by provider from			the initial adult and			child datasets and			add to final output																														 */
	select			CGPracticeId
				,	'AV_06_Rate' as measure_id
				,	cast(sum(case 
					when AV_06 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_06 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_06 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_06 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_06 = 4
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_06 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_06 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_06 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_06 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_06 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_06 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	into			cg_responsedetail
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_08_Rate' as measure_id
				,	cast(sum(case 
					when AV_08 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_08 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_08 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_08 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_08 = 4
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_08 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_08 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_08 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_08 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_08 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_08 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_10_Rate' as measure_id
				,	cast(sum(case 
					when AV_10 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_10 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_10 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_10 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_10 = 4
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_10 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_10 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_10 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_10 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_10 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_10 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_12_Rate' as measure_id
				,	cast(sum(case 
					when AV_12 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_12 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_12 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_12 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_12 = 4
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_12 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_12 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_12 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_12 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_12 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_12 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_13_Rate' as measure_id
				,	cast(sum(case 
					when AV_13 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_13 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_13 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_13 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_13 = 4
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_13 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_13 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_13 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_13 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_13 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_13 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_16_Rate' as measure_id
				,	cast(sum(case 
					when AV_16 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_16 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_16 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_16 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_16 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_17_Rate' as measure_id
				,	cast(sum(case 
					when AV_17 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_17 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_17 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_17 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_17 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_19_Rate' as measure_id
				,	cast(sum(case 
					when AV_19 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_19 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_19 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_19 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_19 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_20_Rate' as measure_id
				,	cast(sum(case 
					when AV_20 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_20 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_20 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_20 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_20 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_21_Rate' as measure_id
				,	cast(sum(case 
					when AV_21 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_21 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_21 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_21 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_21 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_22_Rate' as measure_id
				,	cast(sum(case 
					when AV_22 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_22 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_22 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_22 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_22 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_27_Rate' as measure_id
				,	cast(sum(case 
					when AV_27 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_27 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_27 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_27 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_27 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_28_Rate' as measure_id
				,	cast(sum(case 
					when AV_28 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_28 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_28 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_28 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_28 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_24_Rate' as measure_id
				,	cast(sum(case 
					when AV_24 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_24 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_24 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_24 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_24 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_25_Rate' as measure_id
				,	cast(sum(case 
					when AV_25 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_25 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_25 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_25 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_25 = 4
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_25 = 5
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_25 = 6
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_25 = 7
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_25 = 8
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_25 = 9
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_25 = 10
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'AV_26_Rate' as measure_id
				,	cast(sum(case 
					when AV_26 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when AV_26 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when AV_26 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when AV_26 = 3
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when AV_26 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_adult
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_38_Rate' as measure_id
				,	cast(sum(case 
					when CD_38 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_38 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_38 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_38 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_38 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_39_Rate' as measure_id
				,	cast(sum(case 
					when CD_39 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_39 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_39 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_39 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_39 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_40_Rate' as measure_id
				,	cast(sum(case 
					when CD_40 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_40 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_40 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_40 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_40 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_41_Rate' as measure_id
				,	cast(sum(case 
					when CD_41 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_41 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_41 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_41 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_41 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_44_Rate' as measure_id
				,	cast(sum(case 
					when CD_44 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_44 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_44 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_44 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_44 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_47_Rate' as measure_id
				,	cast(sum(case 
					when CD_47 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_47 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_47 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_47 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_47 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_42_Rate' as measure_id
				,	cast(sum(case 
					when CD_42 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_42 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_42 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_42 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_42 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_43_Rate' as measure_id
				,	cast(sum(case 
					when CD_43 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_43 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_43 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_43 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_43 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_45_Rate' as measure_id
				,	cast(sum(case 
					when CD_45 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_45 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_45 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_45 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_45 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_46_Rate' as measure_id
				,	cast(sum(case 
					when CD_46 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_46 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_46 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_46 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_46 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId
	
	union
	
	select			CGPracticeId
				,	'CD_48_Rate' as measure_id
				,	cast(sum(case 
					when CD_48 = 0
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response1
				,	cast(sum(case 
					when CD_48 = 1
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response2
				,	cast(sum(case 
					when CD_48 = 2
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response3
				,	cast(sum(case 
					when CD_48 = 98
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response4
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response5
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response6
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response7
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response8
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response9
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response10
				,	cast(sum(case 
					when CD_48 = 99
						then 1
					else 0
					end) as decimal(8, 2)) / cast(count(CGPracticeId) as decimal(8, 2)) as response11
	from			[Targets_CGCAHPSSurveyTargets]	--cg_child
	where			[Dataset_Id] in (select wd.Dataset_Id from Websites_WebsiteDatasets wd where wd.Website_Id = @WebsiteId)
	group by		CGPracticeId

	/*Take CG response detail and			join to final output table*/
	select			s.*
				,	d.response1
				,	d.response2
				,	d.response3
				,	d.response4
				,	d.response5
				,	d.response6
				,	d.response7
				,	d.response8
				,	d.response9
				,	d.response10
				,	d.response11
				,	m.Id as 'MonMeasureId'
	from			CG_Provider_Base s
	--	inner join	Measures m on (m.Name = REVERSE(SUBSTRING(REVERSE(s.MeasureId),Len(REVERSE(s.MeasureId))-4, Len(REVERSE(s.MeasureId)))) or m.Name = s.MeasureId)
		left join	Measures m
						on	m.Name = replace(s.MeasureId,'_Rate','')
						or	m.Name = 'CG_ALL' and s.MeasureId = 'AV_CD_Comp_Overall'
		left join	cg_responsedetail d
						on 	s.practice_id = d.CGPracticeId
						and	s.MeasureId = d.measure_id
end
