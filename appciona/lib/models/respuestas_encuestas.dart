class RespuestasEncuestas {
  String? uidUsuario;
  Map<String, Map<String, dynamic>>? respuestas;

  RespuestasEncuestas({
    this.uidUsuario,
    this.respuestas,
  });

  factory RespuestasEncuestas.fromJson(Map<String, dynamic> json) =>
      RespuestasEncuestas(
        uidUsuario: json["uidUsuario"].toString(),
        respuestas: json["Respuestas"],
      );

  Map<String, dynamic> toMap() {
    return {
      'uidUsuario': uidUsuario,
      'Respuestas': respuestas,
    };
  }
}
