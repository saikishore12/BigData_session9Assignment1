distributer_details = LOAD 'petrol_details.txt' USING PigStorage(',') AS (district_id:chararray, distributer_name:chararray, buy_rate:chararray,sell_rate:chararray,volumeIN:int,volumeOUT:int,year:int);

distributer_volume = FOREACH distributer_details generate distributer_name, buy_rate;
dump distributer_volume;
distributer_group = Group distributer_volume by distributer_name;
describe distributer_group;
distributer_total_volume = foreach distributer_group{
	distributer=DISTINCT distributer_volume.distributer_name;
	sellprice=MIN(distributer_volume.buy_rate);
	generate flatten (distributer),sellprice;
};  

 dump distributer_total_volume;






