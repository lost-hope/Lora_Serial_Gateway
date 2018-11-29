void init_temperature_gui() {
  noFill();
  //rect(100, 100, 30, 200);
}
void update_Temp() {
  fill(255, 255, 255);
  text("RSSI: "+RSSI,150,130);
  text("Temperatur: "+temperature, 150, 150);
  text("Humidity: "+humidity, 150, 170);
  text("Letzter Empfang: "+time, 150,height-50);
 
}

void check_serial_data() { 
  if (serial.available()>0) {
    String input = serial.readStringUntil('}');
    if (input!=null) {
      serial_in(input);
      gcBefore=new GregorianCalendar();
      PostRequest post=new PostRequest("https://api.telegram.org/bot718316850:AAEf40B6b3BjWq9U9KcSZRwqJErpSnOHwYQ/sendMessage?chat_id=75721430&text=Signal_Da");
      post.send();
      println(input);
    } else {
      
    }
  }
}
