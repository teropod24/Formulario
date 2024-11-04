import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormA extends StatefulWidget {
  const FormA({super.key});

  @override
  State<FormA> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<FormA> {
  final _formKey = GlobalKey<FormBuilderState>();
  String country = 'Select Option';

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void initState() {
    country = _allCountries.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),

          // Título general del formulario
          const Center(
            child: Text(
              'Driving Form',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Form example',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Encabezado sobre el grupo de radio buttons
          const Text(
            'Please provide the speed of vehicle?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderRadioGroup<String>(
            decoration: const InputDecoration(
              labelText: 'Please provide the speed of vehicle',
            ),
            name: 'best_language',
            options: ['above 40km/h', 'below 40km/h', '0km/h']
                .map((lang) => FormBuilderFieldOption(
                      value: lang,
                      child: Text(lang),
                    ))
                .toList(),
            validator: FormBuilderValidators.required(
                errorText: 'Debes seleccionar una opción'),
          ),

          const SizedBox(height: 16),

          // Encabezado sobre el campo de texto
          const Text(
            'Enter remarks:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            name: 'name',
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(
              label: Text('Enter your remarks'),
            ),
          ),

          const SizedBox(height: 16),

          // Encabezado sobre el dropdown
          const Text(
            'Please provide the high speed of vehicle?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderDropdown<String>(
            name: 'country',
            decoration: const InputDecoration(
              label: Text('Select Option'),
            ),
            items: _allCountries
                .map((country) => DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                country = value ?? '';
              });
            },
          ),

          const SizedBox(height: 16),

          // Encabezado sobre el grupo de checkboxes
          const Text(
            'Please provide the speed of vehicle past 1 hour?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderCheckboxGroup<String>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Please select one or more option given below',
            ),
            name: 'languages',
            options: const [
              FormBuilderFieldOption(value: '20km/h'),
              FormBuilderFieldOption(value: '30km/h'),
              FormBuilderFieldOption(value: '40km/h'),
              FormBuilderFieldOption(value: '50km/h'),
            ],
            onChanged: _onChanged,
            separator: const VerticalDivider(
              width: 10,
              thickness: 5,
              color: Colors.red,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(1),
              FormBuilderValidators.maxLength(3),
            ]),
          ),

          const SizedBox(height: 20),

          // Botón Submit centrado
          Center(
            child: MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              child:
                  const Text("Submit", style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  final formValues = _formKey.currentState!.value;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Resumen de la Solicitud'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Velocidad: ${formValues['best_language'] ?? 'No seleccionado'}'),
                          Text(
                              'Opción: ${formValues['name'] ?? 'No seleccionado'}'),
                          Text(
                              'Rango de Velocidad: ${formValues['country'] ?? 'No seleccionado'}'),
                          Text(
                              'Múltiple Velocidad: ${formValues['languages'] ?? 'No seleccionado'}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const _allCountries = ['High', 'Medium', 'Low'];
