import 'package:appciona/models/servicio.dart';
import 'package:appciona/pages/servicios/servicios_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  final Widget drawer;
  const ServiciosPage({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  final ServiciosController _controller = ServiciosController();

  final List<DropdownMenuItem<String>> dropDownOptions = [
    DropdownMenuItem(
      child: Text('Restaurantes'),
      value: 'Restaurante',
    ),
    DropdownMenuItem(
      child: Text('Hoteles'),
      value: 'Hotel',
    ),
  ];

  late String tipoSelected = 'Restaurante';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text("Servicios"),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo-green.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      drawer: Drawer(
        child: widget.drawer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _controller.getServices(),
            builder: (context, data) {
              if (data.hasData) {
                List<Servicio> items = data.data as List<Servicio>;
                List<Servicio> itemsFiltered = items
                    .where((element) => element.tipo!.startsWith(tipoSelected))
                    .toList();
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: size.width * 0.90,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.orange.shade400,
                        underline: SizedBox.shrink(),
                        iconEnabledColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        isExpanded: true,
                        items: dropDownOptions,
                        value: tipoSelected,
                        onChanged: (value) {
                          setState(() {
                            tipoSelected = value!;
                          });
                        },
                      ),
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount:
                          itemsFiltered.isEmpty ? 0 : itemsFiltered.length,
                      itemBuilder: (context, index) => _cardServices(
                        size,
                        '${itemsFiltered[index].imagen}',
                        '${itemsFiltered[index].titulo}',
                        '${itemsFiltered[index].telefono}',
                        '${itemsFiltered[index].direccion}',
                        '${itemsFiltered[index].correo}',
                      ),
                    ),
                  ],
                );
              } else if (data.hasError) {
                return Center(
                  child: Text(
                      'Ocurrió un error al cargar la información: ${data.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  FlipCard _cardServices(Size size, String img, String titulo, String telefono,
      String direccion, String correo) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.40,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) =>
                        Image.asset('assets/images/logo-green.png'),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/logo-green.png'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '$titulo\n',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.location_on_rounded),
                        ),
                        const TextSpan(
                          text: ' Dirección\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '$direccion\n'),
                        const WidgetSpan(
                          child: Icon(Icons.rotate_90_degrees_ccw_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      back: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0XFF007474),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Color(0XFF005059),
                          ),
                          Text(telefono),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.email_rounded,
                            color: Color(0XFF005059),
                          ),
                          Text(correo.isEmpty ? 'Sin correo' : correo),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
