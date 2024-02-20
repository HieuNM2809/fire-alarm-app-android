class UserModel {
  String? antiTheft;
  String? buttonRemoteOFF;
  String? buttonRemoteON;
  String? fullname;
  String? gas;
  String? gasAlert;
  String? password;
  String? pump;
  String? sos;
  String? temperature;
  String? temperatureAlert;
  String? username;
  String? zone1;
  String? zone2;
  String? zone3;
  String? zone4;

  UserModel(
      {this.antiTheft,
      this.buttonRemoteOFF,
      this.buttonRemoteON,
      this.fullname,
      this.gas,
      this.gasAlert,
      this.password,
      this.pump,
      this.sos,
      this.temperature,
      this.temperatureAlert,
      this.username,
      this.zone1,
      this.zone2,
      this.zone3,
      this.zone4});

  UserModel.fromJson(Map<String, dynamic> json) {
    antiTheft = json['antiTheft'];
    buttonRemoteOFF = json['buttonRemoteOFF'];
    buttonRemoteON = json['buttonRemoteON'];
    fullname = json['fullname'];
    gas = json['gas'];
    gasAlert = json['gasAlert'];
    password = json['password'];
    pump = json['pump'];
    sos = json['sos'];
    temperature = json['temperature'];
    temperatureAlert = json['temperatureAlert'];
    username = json['username'];
    zone1 = json['zone1'];
    zone2 = json['zone2'];
    zone3 = json['zone3'];
    zone4 = json['zone4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['antiTheft'] = antiTheft;
    data['buttonRemoteOFF'] = buttonRemoteOFF;
    data['buttonRemoteON'] = buttonRemoteON;
    data['fullname'] = fullname;
    data['gas'] = gas;
    data['gasAlert'] = gasAlert;
    data['password'] = password;
    data['pump'] = pump;
    data['sos'] = sos;
    data['temperature'] = temperature;
    data['temperatureAlert'] = temperatureAlert;
    data['username'] = username;
    data['zone1'] = zone1;
    data['zone2'] = zone2;
    data['zone3'] = zone3;
    data['zone4'] = zone4;
    return data;
  }
}
