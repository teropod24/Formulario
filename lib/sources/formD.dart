import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FormD extends StatefulWidget {
  const FormD({super.key});

  @override
  State<FormD> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<FormD> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _countryController = TextEditingController();
  String selectedCountry = '';
  List<String> filteredCountries = [];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void initState() {
    super.initState();
    selectedCountry = '';
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: 'country',
            controller: _countryController,
            decoration: const InputDecoration(
              labelText: 'Countries',
              hintText: 'Start typing to search for a country...',
            ),
            onChanged: (query) {
              setState(() {
                if (query != null && query.isNotEmpty) {
                  filteredCountries = _allCountries
                      .where((country) =>
                          country.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                } else {
                  filteredCountries = [];
                }
              });
            },
          ),
          if (filteredCountries.isNotEmpty)
            Column(
              children: filteredCountries.map((country) {
                return ListTile(
                  title: Text(country),
                  onTap: () {
                    setState(() {
                      _countryController.text = country;
                      filteredCountries = [];
                    });
                  },
                );
              }).toList(),
            ),
          FormBuilderDateTimePicker(
            name: 'date',
            inputType: InputType.date,
            initialEntryMode: DatePickerEntryMode.calendar,
            decoration: InputDecoration(
              labelText: 'Select Date',
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _formKey.currentState!.fields['date']?.didChange(null);
                },
              ),
            ),
          ),
          FormBuilderDateRangePicker(
            name: 'date_range',
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
            format: DateFormat('yyyy-MM-dd'),
            decoration: InputDecoration(
              labelText: 'Date Range',
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _formKey.currentState!.fields['date_range']?.didChange(null);
                },
              ),
            ),
          ),
          FormBuilderDateTimePicker(
            name: 'timer',
            inputType: InputType.time,
            initialTime: TimeOfDay(hour: 8, minute: 0),
            decoration: InputDecoration(
              labelText: 'Select Time',
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _formKey.currentState!.fields['timer']?.didChange(null);
                },
              ),
            ),
          ),
          FormBuilderFilterChip<String>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration:
                const InputDecoration(labelText: 'The language of my people'),
            name: 'languages_filter',
            selectedColor: Colors.red,
            options: const [
              FormBuilderChipOption(
                value: 'HTML',
                avatar: CircleAvatar(child: Text('D')),
              ),
              FormBuilderChipOption(
                value: 'CSS',
                avatar: CircleAvatar(child: Text('K')),
              ),
              FormBuilderChipOption(
                value: 'Java',
                avatar: CircleAvatar(child: Text('J')),
              ),
              FormBuilderChipOption(
                value: 'Dart',
                avatar: CircleAvatar(child: Text('S')),
              ),
              FormBuilderChipOption(
                value: 'TypeScript',
                avatar: CircleAvatar(child: Text('O')),
              ),
              FormBuilderChipOption(
                value: 'Angular',
                avatar: CircleAvatar(child: Text('A')),
              ),
            ],
            onChanged: _onChanged,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(1),
              FormBuilderValidators.maxLength(3),
            ]),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: const Text("Submit", style: TextStyle(color: Colors.white)),
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                final formValues = _formKey.currentState!.value;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Resumen de la Solicitud'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'País: ${formValues['country'] ?? 'No seleccionado'}'),
                        Text(
                            'Día: ${formValues['date'] != null ? DateFormat('yyyy-MM-dd').format(formValues['date']) : 'No seleccionado'}'),
                        Text(
                            'Rango de Fechas: ${formValues['date_range'] != null ? '${DateFormat('yyyy-MM-dd').format(formValues['date_range'].start)} a ${DateFormat('yyyy-MM-dd').format(formValues['date_range'].end)}' : 'No seleccionado'}'),
                        Text(
                            'Hora: ${formValues['timer'] != null ? DateFormat.jm().format(formValues['timer']) : 'No seleccionado'}'),
                        Text(
                            'Lenguajes: ${formValues['languages_filter']?.join(', ') ?? 'No seleccionado'}'),
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
        ],
      ),
    );
  }
}

const _allCountries = [
  'United States',
  'France',
  'Spain',
  'Germany',
  'Canada',
  'Australia',
  'Brazil',
  'Italy',
  'Japan',
  'South Korea',
  'India',
  'Mexico',
  'China',
  'Russia',
  'South Africa',
  'Argentina',
  'United Kingdom',
  'Netherlands',
  'Turkey',
  'Switzerland',
  'Sweden',
  'Belgium',
  'Austria',
  'Norway',
  'Denmark',
  'Finland',
  'Poland',
  'Greece',
  'Portugal',
  'New Zealand',
  'Ireland',
  'Czech Republic',
  'Hungary',
  'Israel',
  'Malaysia',
  'Singapore',
  'Thailand',
  'Vietnam',
  'Philippines',
  'Indonesia',
  'Egypt',
  'Saudi Arabia',
  'United Arab Emirates',
  'Pakistan',
  'Bangladesh',
  'Nigeria',
  'Colombia',
  'Chile',
  'Peru',
  'Venezuela',
  'Romania',
  'Ukraine',
  'Belarus',
  'Morocco',
  'Algeria',
  'Ethiopia',
  'Kenya',
  'Tanzania',
  'Ghana',
  'Uganda',
  'Sri Lanka',
  'Nepal',
  'Qatar',
  'Kuwait',
  'Bahrain',
  'Jordan',
  'Lebanon',
  'Oman',
  'Kazakhstan',
  'Uzbekistan',
  'Azerbaijan',
  'Georgia',
  'Armenia',
  'Luxembourg',
  'Iceland',
  'Malta',
  'Cyprus',
  'Estonia',
  'Latvia',
  'Lithuania',
  'Slovakia',
  'Slovenia',
  'Croatia',
  'Bulgaria',
  'Serbia',
  'Bosnia and Herzegovina',
  'Montenegro',
  'North Macedonia',
  'Moldova',
  'Albania',
  'Kosovo'
];
