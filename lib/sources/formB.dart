import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const FormB());
}

class FormB extends StatelessWidget {
  const FormB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Three Steps Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StepOne(),
    );
  }
}

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;

  const ProgressIndicatorWidget({required this.currentStep, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      index < currentStep ? Colors.green : Colors.grey,
                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text('Paso ${index + 1}'),
              ],
            );
          }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProgressIndicatorWidget(currentStep: 1),
            const Text('Pulsi "Contact" o pulsi el botó de "Continue"'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const StepTwo()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StepTwo extends StatelessWidget {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProgressIndicatorWidget(currentStep: 2),
            const Text('Pulsi "Upload" o pulsi el botó de "Continue"'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const StepThree()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email')),
      body: FormBuilder(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ProgressIndicatorWidget(currentStep: 3),
              FormBuilderTextField(
                name: 'email_subject',
                decoration:
                    const InputDecoration(labelText: 'Asunto del Email'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'email_body',
                decoration:
                    const InputDecoration(labelText: 'Cuerpo del Email'),
                maxLines: 5,
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'email_mobile',
                decoration: const InputDecoration(labelText: 'Telèfon mòbil'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final formData = _formKey.currentState?.value;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Resumen de Envío'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('Asunto: ${formData?['email_subject']}'),
                              Text('Cuerpo: ${formData?['email_body']}'),
                              Text('Teléfono: ${formData?['email_mobile']}'),
                            ],
                          ),
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
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
