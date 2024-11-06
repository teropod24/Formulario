import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormC extends StatefulWidget {
  const FormC({super.key});

  @override
  State<FormC> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FormC> {
  final _formKey = GlobalKey<FormBuilderState>();
  String country = 'DropDrown Field';

  @override
  void initState() {
    super.initState();
    country = _allCountries.first; // Inicializa con el primer país
  }

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              FormBuilderChoiceChip<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Choice chips:'),
                name: 'languages_choice',
                options: const [
                  FormBuilderChipOption(
                    value: 'Flutter',
                    avatar: CircleAvatar(child: Text('F')),
                  ),
                  FormBuilderChipOption(
                    value: 'Android',
                    avatar: CircleAvatar(child: Text('A')),
                  ),
                  FormBuilderChipOption(
                    value: 'Chrome OS',
                    avatar: CircleAvatar(child: Text('C')),
                  )
                ],
                onChanged: _onChanged,
              ),
              FormBuilderSwitch(
                title: const Text('I Accept the terms and conditions'),
                name: 'accept_terms_switch',
                onChanged: _onChanged,
              ),
              FormBuilderTextField(
                name: 'full_name',
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  hintText: 'Escribe tu nombre completo',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Este campo es obligatorio.'),
                  FormBuilderValidators.maxLength(15,
                      errorText: 'Máximo 15 caracteres'),
                ]),
                maxLength: 15,
                onChanged: _onChanged,
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown<String>(
                name: 'country',
                decoration: const InputDecoration(
                  label: Text('País'),
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
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
                  labelText: 'Mejor lenguaje',
                ),
                orientation: OptionsOrientation.vertical,
                name: 'best_language',
                options: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                validator: FormBuilderValidators.required(
                    errorText: 'Debes seleccionar una opción'),
              ),
            ],
          ),
        ),
      ),
      
      // FloatingActionButton para enviar el formulario
      floatingActionButton: FloatingActionButton(
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
                        'Lenguaje elegido: ${formValues['languages_choice'] ?? 'No seleccionado'}'),
                    Text(
                        'Nombre completo: ${formValues['full_name'] ?? 'No especificado'}'),
                    Text(
                        'País: ${formValues['country'] ?? 'No seleccionado'}'),
                    Text(
                        'Mejor lenguaje: ${formValues['best_language'] ?? 'No seleccionado'}'),
                    Text(
                        'Términos aceptados: ${formValues['accept_terms_switch'] ?? false}'),
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
        child: const Icon(Icons.upload),
      ),
    );
  }
}

const _allCountries = ['United States', 'France', 'Spain'];
