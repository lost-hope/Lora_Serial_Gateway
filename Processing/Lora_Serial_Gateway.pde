import processing.serial.*;
import controlP5.*;
import java.util.*;
import java.*;
GregorianCalendar gcNow, gcBefore;
import http.requests.*;

//grafics
ControlP5 cp5;
Textarea info_txt;
Textarea serial_command;
int last_width;

//Serial
Serial serial;
String [] ports;
int port_selected;
String[] baud_s ={"300", "1200", "2400", "4800", "9600", "19200", "38400", "57600", "74880", "115200", "230400", "250000"};
int[] baud={300, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 74880, 115200, 230400, 250000};
int baud_selected;
boolean baud_changed=false;
boolean port_changed=false;



void setup() {
  size(800, 800);
  surface.setResizable(true);
  scan_serial();
  init_gui();
  gcNow=new GregorianCalendar();
  gcBefore=new GregorianCalendar();
}

void draw() {

  background(50);
  init_temperature_gui();
  stroke(255);
  line(0, 35, width, 35);
  if (width!=last_width&&width!=800) {
    update_position();
    // println("resize");
  }
  last_width=width;
  if (success) {
    check_serial_data();
    update_Temp();
    

    gcNow=new GregorianCalendar();
    if (gcNow.getTimeInMillis()-gcBefore.getTimeInMillis()>3000) {
      PostRequest post=new PostRequest("https://api.telegram.org/bot718316850:AAEf40B6b3BjWq9U9KcSZRwqJErpSnOHwYQ/sendMessage?chat_id=75721430&text=Signal_Weg");
      post.send();
    }
  }
}
