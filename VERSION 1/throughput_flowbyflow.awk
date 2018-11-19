#throughput_flowbyflow.awk
# This awk file calculates throughput, number of packets sent, #recei\
#ved, and lost for every 0.5 time interval for each of the three #flow\s

BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;
}

{
  time2 = $2;

  timeInterval = time2 - time1;

  if (timeInterval > 0.5) {

  throughput_flow0 = bytes_counter_flow0 / timeInterval;
  # Export throughput of this time interval to xls file
  printf("%f \t %f\n", time2, throughput_flow0) > "throughput_flowbyflow_11.xls";
  bytes_counter_flow0 = 0;

  throughput_flow1 = bytes_counter_flow1 / timeInterval;
  # Export throughput of this time interval to xls file
  printf("%f \t %f\n", time2, throughput_flow1) > "throughput_flowbyflow_12.xls";
  bytes_counter_flow1 = 0;

  throughput_flow2 = bytes_counter_flow2 / timeInterval;
  # Export throughput of this time interval to xls file
  printf("%f \t %f\n", time2, throughput_flow2) > "throughput_flowbyflow_16.xls";
  bytes_counter_flow2 = 0;

  throughput_flow3 = bytes_counter_flow3 / timeInterval;
  # Export throughput of this time interval to xls file
  printf("%f \t %f\n", time2, throughput_flow3) > "throughput_flowbyflow_17.xls";
  bytes_counter_flow3 = 0;

  time1 = $2;

  }

  # if packet arrives at destination node 11 belongs to flow id 11
  if ($1 == "r" && $4 == 11 && $8 == 11) {
  bytes_counter_flow0 += $6;
  }

  # if packet arrives at destination node 12 belongs to flow id 12
  if ($1 == "r" && $4 == 12 && $8 == 12) {
  bytes_counter_flow1 += $6;
  }

  # if packet arrives at destination node 16 belongs to flow id 16
  if ($1 == "r" && $4 == 16 && $8 == 16) {
  bytes_counter_flow2 += $6;
  }

  # if packet arrives at destination node 17 belongs to flow id 17
  if ($1 == "r" && $4 == 17 && $8 == 17) {
  bytes_counter_flow3 += $6;
  }

}

END {
   print("****End of awk file****");
}
