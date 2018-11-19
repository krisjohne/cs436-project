BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {

      throughput_flow0 = bytes_counter_flow0 / timeInterval;
      throughput_flow1 = bytes_counter_flow1 / timeInterval;
      throughput_flow2 = bytes_counter_flow2 / timeInterval;
      throughput_flow3 = bytes_counter_flow3 / timeInterval;

      # Export throughput of this time interval to xls file                                                                                                                                                        
      printf("%f \t %f \t %f \t %f \t %f\n", time2, throughput_flow0, throughput_flow1, throughput_flow2,throughput_flow3 ) > "project_throughput_allflows.xls";
      bytes_counter_flow0 = 0;
      bytes_counter_flow1 = 0;
      bytes_counter_flow2 = 0;
      bytes_counter_flow3 = 0;

      time1 = $2;

   }



   # if packet arrives at destination node 1 belongs to flow id 0                                                                                                                                                  
   if ($1 == "r" && $4 == 11 && $8 == 11) {
      bytes_counter_flow0 += $6;
   }

   # if packet arrives at destination node 2 belongs to flow id 1                                                                                                                                                  
   if ($1 == "r" && $4 == 12 && $8 == 12) {
      bytes_counter_flow1 += $6;
   }

   # if packet arrives at destination node 3 belongs to flow id 2                                                                                                                                          
   if ($1 == "r" && $4 == 16 && $8 == 16) {
      bytes_counter_flow2 += $6;
   }

   # if packet arrives at destination node 3 belongs to flow id 3                                                                                                                           

   if ($1 == "r" && $4 == 17 && $8 == 17) {
      bytes_counter_flow3 += $6;
   }


}

END {
   print("****End of awk file****");
}