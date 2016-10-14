distributer_details = LOAD 'petrol_details.txt' USING PigStorage(',') AS (district_id:chararray, distributer_name:chararray, buy_rate:chararray,sell_rate:chararray,volumeIN:int,volumeOUT:int,year:int);
dump distributer_details;
distributer_volume = FOREACH distributer_details generate distributer_name, volumeIN;
dump distributer_volume;
distributer_group = Group distributer_volume by distributer_name;
describe distributer_group;
distributer_total_volume = foreach distributer_group{
	distributer=DISTINCT distributer_volume.distributer_name;
	volume=SUM(distributer_volume.volumeIN);
	generate flatten (distributer),volume;
};   
dump distributer_total_volume;
store distributer_total_volume into 'distributer_total_volume';