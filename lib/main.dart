import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Formulario Fluent UI',
      theme: FluentThemeData(
        accentColor: Colors.red, // Color del IUJO
        brightness: Brightness.light, // Fondo claro
        fontFamily: 'RobotoMono',
      ),
      home: FormularioCaptura(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormularioCaptura extends StatefulWidget {
  @override
  _FormularioCapturaState createState() => _FormularioCapturaState();
}

class _FormularioCapturaState extends State<FormularioCaptura> {
  String nombre = '';
  bool trabaja = false;
  bool estudia = false;
  String genero = '';
  bool notificaciones = false;
  double precio = 50;
  DateTime? fechaSeleccionada;

  void _seleccionarFecha(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text("Selecciona una fecha", style: TextStyle(color: Colors.black)),
        content: DatePicker(
          selected: fechaSeleccionada ?? DateTime.now(),
          onChanged: (fecha) {
            setState(() {
              fechaSeleccionada = fecha;
            });
            Navigator.pop(context);
          },
        ),
        actions: [
          Button(
            child: Text("Cerrar", style: TextStyle(color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _guardarDatos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text("Éxito"),
        content: Text("✅ Se han guardado los datos de manera exitosa."),
        actions: [
          Button(
            child: Text("Aceptar"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            border: Border.all(color: Colors.red, width: 4), // Bordes rojos
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/Logo_junio_2022-removebg-preview.png',
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Text(
                'Formulario de Captura de Datos',
                style: FluentTheme.of(context).typography.title!.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _crearCampoTexto('Nombre', (valor) => setState(() => nombre = valor)),
              _crearCheckbox('Trabaja', trabaja, (val) => setState(() => trabaja = val)),
              _crearCheckbox('Estudia', estudia, (val) => setState(() => estudia = val)),
              _crearRadio('Masculino', 'Masculino'),
              _crearRadio('Femenino', 'Femenino'),
              _crearSwitch('Activar Notificaciones', notificaciones, (val) => setState(() => notificaciones = val)),
              _crearSlider(),
              _crearFecha(context),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () => _guardarDatos(context),
                style: ButtonStyle(
                  backgroundColor: ButtonState.all(Colors.red),
                  foregroundColor: ButtonState.all(Colors.white),
                ),
                child: Text("Guardar"),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearCampoTexto(String label, Function(String) onChange) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: TextBox(
        placeholder: label,
        style: TextStyle(color: Colors.black),
        onChanged: (val) => onChange(val),
      ),
    );
  }

  Widget _crearCheckbox(String titulo, bool valor, Function(bool) onChange) {
    return Checkbox(
      checked: valor,
      onChanged: (val) => onChange(val ?? false),
      content: Text(titulo, style: TextStyle(color: Colors.black, fontSize: 18)),
    );
  }

  Widget _crearRadio(String titulo, String valor) {
    return RadioButton(
      checked: genero == valor,
      onChanged: (v) => setState(() => genero = valor),
      content: Text(titulo, style: TextStyle(color: Colors.black, fontSize: 18)),
    );
  }

  Widget _crearSwitch(String titulo, bool valor, Function(bool) onChange) {
    return ToggleSwitch(
      checked: valor,
      onChanged: onChange,
      content: Text(titulo, style: TextStyle(color: Colors.black, fontSize: 18)),
    );
  }

  Widget _crearSlider() {
    return Column(
      children: [
        Text('Seleccione Precio Estimado', style: TextStyle(color: Colors.black, fontSize: 18)),
        Slider(
          value: precio,
          min: 0,
          max: 100,
          divisions: 10,
          label: precio.round().toString(),
          onChanged: (val) => setState(() => precio = val),
        ),
      ],
    );
  }

  Widget _crearFecha(BuildContext context) {
    return GestureDetector(
      onTap: () => _seleccionarFecha(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fechaSeleccionada == null
                  ? 'No seleccionada'
                  : '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Icon(FluentIcons.calendar, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
