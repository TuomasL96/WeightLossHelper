import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:open_weight_tracker/models.dart';
import '../mobx/weigh_in_form.dart';
import 'widgets/shared_widgets.dart';

class WeighInMenu extends StatefulWidget {
  const WeighInMenu({super.key});

  @override
  State<WeighInMenu> createState() => _WeighInMenuState();
}

class _WeighInMenuState extends State<WeighInMenu> {
  late User currentUser = userRepository.getCurrentUser();

  final WeightFormStore store = WeightFormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: WeighInForm(store),
        ),
        Expanded(
          flex: 2,
          child: WeighInList(currentUser: currentUser, store: store),
        )
      ],
    );
  }
}

class WeighInList extends StatefulWidget {
  final User currentUser;
  final WeightFormStore store;
  const WeighInList(
      {required this.currentUser, required this.store, super.key});

  @override
  State<WeighInList> createState() => _WeighInListState();
}

class _WeighInListState extends State<WeighInList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Weight History'),
        Expanded(
            flex: 1,
            child: Observer(
              builder: (context) => ListView.builder(
                  itemCount: widget.store.userWeighIns.length,
                  itemBuilder: (context, index) {
                    return WeighInCard(
                        widget.store.userWeighIns[index], widget.store);
                  }),
            ))
      ],
    );
  }
}

class WeighInCard extends StatefulWidget {
  final WeighIn weighIn;
  final WeightFormStore store;
  const WeighInCard(this.weighIn, this.store, {super.key});

  @override
  State<WeighInCard> createState() => _WeighInCardState();
}

class _WeighInCardState extends State<WeighInCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      shadowColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 2.0,
      child: ListTile(
        leading: const Icon(
          Icons.scale,
          size: 50,
        ),
        title: Row(children: [
          Text("${widget.weighIn.date.toLocal()}".split(' ')[0]),
        ]),
        subtitle: Text('${widget.weighIn.weight}'),
        trailing: WeighInCardPopup(widget.weighIn, widget.store),
      ),
    );
  }
}

class WeighInCardPopup extends StatelessWidget {
  final WeighIn weighIn;
  final WeightFormStore store;
  WeighInCardPopup(this.weighIn, this.store, {super.key});

  final Dialogs alerts = Dialogs();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0)),
        ),
        itemBuilder: (ctx) => [
              buildPopupMenuItem(
                  'Edit',
                  Icons.edit, // TODO edit code
                  () => {
                        store.deleteWeighIn(weighIn),
                      }),
              buildPopupMenuItem(
                  'Delete',
                  Icons.delete,
                  () => {
                        alerts.showAlertDialog(
                            ctx,
                            'Confirmation',
                            'Are you sure you want to delete the weighin?',
                            () => {store.deleteWeighIn(weighIn)})
                      }),
            ]);
  }
}

class WeighInForm extends StatefulWidget {
  final WeightFormStore store;
  const WeighInForm(this.store, {super.key});

  @override
  State<WeighInForm> createState() => _WeighInFormState();
}

class _WeighInFormState extends State<WeighInForm> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Observer(builder: (_) => DatePickerButton(widget.store)),
          Observer(builder: (_) => UserWeightInputField(widget.store)),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: widget.store.validateAll, child: const Text('Save')),
        ],
      ),
    );
  }
}

class DatePickerButton extends StatefulWidget {
  final WeightFormStore store;
  const DatePickerButton(this.store, {super.key});

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(
            selectedDate.year - 1, selectedDate.month, selectedDate.day),
        lastDate: DateTime(
            selectedDate.year + 1, selectedDate.month, selectedDate.day));
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
        widget.store.date = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select date'))),
        ],
      ),
    );
  }
}

class UserWeightInputField extends StatefulWidget {
  final WeightFormStore store;
  const UserWeightInputField(this.store, {super.key});

  @override
  State<UserWeightInputField> createState() => _UserWeightInputFieldState();
}

class _UserWeightInputFieldState extends State<UserWeightInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
          ],
          onChanged: (value) => widget.store.weight = double.parse(value),
          decoration: const InputDecoration(
            labelText: 'Weight',
            hintText: 'Your Weight',
          )),
    );
  }
}

class WeighInEditCard extends StatelessWidget {
  final WeighIn weighIn;
  const WeighInEditCard(this.weighIn, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
