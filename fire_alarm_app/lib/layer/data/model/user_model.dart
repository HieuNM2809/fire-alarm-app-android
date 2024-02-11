class UserModel {
  Config? config;
  User1? user1;

  UserModel({this.config, this.user1});

  UserModel.fromJson(Map<String, dynamic> json) {
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
    user1 = json['user1'] != null ? User1.fromJson(json['user1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (config != null) {
      data['config'] = config!.toJson();
    }
    if (user1 != null) {
      data['user1'] = user1!.toJson();
    }
    return data;
  }
}

class Config {
  int? userIdCurrent;

  Config({this.userIdCurrent});

  Config.fromJson(Map<String, dynamic> json) {
    userIdCurrent = json['userIdCurrent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userIdCurrent'] = userIdCurrent;
    return data;
  }
}

class User1 {
  String? antiTheft;
  String? buttonRemoteOFF;
  String? buttonRemoteON;
  String? fullname;
  String? gas;
  String? gasAlert;
  String? password;
  String? pump;
  bool? sos;
  String? temperature;
  String? temperatureAlert;
  String? username;
  String? zone1;
  String? zone2;
  String? zone3;
  String? zonee4;

  User1(
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
      this.zonee4});

  User1.fromJson(Map<String, dynamic> json) {
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
    zonee4 = json['zonee4'];
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
    data['zonee4'] = zonee4;
    return data;
  }
}
