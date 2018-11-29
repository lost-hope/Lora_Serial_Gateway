String temperature; //<>//
String ID;
String humidity;
String RSSI;
String time;

boolean success=false;
void scan_serial () {
  ports= Serial.list();
}

void serial_connect() {
  try {
    serial=new Serial(this, ports[port_selected], baud[baud_selected]);
    //serial.write("ping \n");
  }
  catch(Exception e) {
    //System.err.println(e);
    success=false;
  }
  if (serial.active()) {
    success=true;
  } else {
    success=false;
  }
  if (success) {
    println("connected to " + ports[port_selected] + " with Baudrate "+ baud_s[baud_selected]);


    cp5.get("Info_txt").setColorValue(color(255));
    info_txt.setText("Connected");
  } else {
    println("Connection failed");
    cp5.get("Info_txt").setColorValue(color(255, 0, 0));
    //color(255,0,0));
    info_txt.setText("Connection failed");
  }
}
void serial_disconnect() {
  serial.stop();
  info_txt.setText("Disconnected");
}


/*
  Fuctions to receive the data
 */
void serial_in(String input) {
  if (input!=null) {
    String input_sub=input.substring(1, input.length()-1);
    println(input_sub);
    String[] split =input_sub.split(";", 0);
    if (split.length==4) {
      for (int i =0; i<split.length; i++) {

        switch(split[i].substring(0, 3)) {
        case "SSI": 
          RSSI=split[i].substring(3);
          println("RSSI "+RSSI);
          break;
        case "IDN":
          ID=split[1].substring(3);
          println("ID "+ID);
          break;
        case "tem":
          temperature=split[i].substring(3);
          println("TEMP "+temperature);
          break;
        case "hum":
          humidity=split[i].substring(3);
          println("HUM "+humidity);
          break;
        }
      }
      time=String.valueOf(day())+"."+String.valueOf(month())+"."+String.valueOf(year())+" "+ String.valueOf(hour())+":"+String.valueOf(minute())+":"+String.valueOf(second())+":"+String.valueOf(millis());
    }
  }
}
