
boolean active_b=false;
boolean first=true;
CColor active =new CColor();
CColor inactive =new CColor();

void init_gui() {
  cp5 = new ControlP5(this);
  active.setBackground(color(0, 45, 90));
  inactive.setBackground(color(10));

  
  cp5.addScrollableList("port")
    .setPosition(20, 10)
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(Arrays.asList(ports))
    .setType(ControlP5.DROPDOWN)
    .setOpen(false)    
    ;
    
  cp5.addScrollableList("baud")
    .setPosition(125, 10)
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(Arrays.asList(baud_s))
    .setType(ControlP5.DROPDOWN)
    .setOpen(false)    
    ;
    
  cp5.addButton("connect")
    .setPosition(230, 10)
    .setSize(50, 20)
    .setLabel("Connect");
  ;

  cp5.addButton("disconnect")
    .setColor(inactive)
    .setPosition(285, 10)
    .setSize(50, 20)
    .setLabel("Disconnect");
  ;

  info_txt= cp5.addTextarea("Info_txt")
    .setPosition(width-205, 10)
    .setSize(200, 20)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(0, 0, 0))
    .setColorBackground(color(255, 100))
    ;
}

void baud(int n) {
  baud_selected=n;
  baud_changed=true;
}

void port(int n) {
  port_selected=n;
  port_changed=true;
}


void connect() {

  if (port_changed&&baud_changed) {
    serial_connect();
    cp5.getController("disconnect").setColor(active);
    cp5.getController("connect").setColor(inactive); 
  }
}
void disconnect() {
  if (active_b) {
    serial_disconnect();
    cp5.getController("disconnect").setColor(inactive);
    cp5.getController("connect").setColor(active);
    active_b=false;
  }
}


/**
 * Experimental feature !!!MAYBE NOT WORKING!!!
 **/
void update_position() {
  cp5.get("Info_txt").setPosition(width-205, 10);
  //cp5.getController("serial_commands").setSize(width-20,600);
}
