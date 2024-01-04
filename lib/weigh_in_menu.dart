import 'dart:ffi';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:open_weight_tracker/models.dart';
import 'weigh_in_form.dart';

class WeighInMenu extends StatelessWidget {
  late User currentUser = userRepository.getCurrentUser();
  WeighInMenu({super.key});

  void openEditMenu() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: WeighInForm()),
        Expanded(child: WeighInList(currentUser: currentUser))
      ],
    );
  }
}

class WeighInList extends StatefulWidget {
  User currentUser;
  WeighInList({required this.currentUser, super.key});

  @override
  State<WeighInList> createState() => _WeighInListState();
}

class _WeighInListState extends State<WeighInList> {
  void onChildUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Weight History'),
        Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: widget.currentUser.weighIns.length,
                itemBuilder: (context, index) {
                  return WeighInCard(
                      widget.currentUser.weighIns[index], onChildUpdated);
                }))
      ],
    );
  }
}

class WeighInCard extends StatefulWidget {
  final WeighIn weighIn;
  final Function onUpdated;
  const WeighInCard(this.weighIn, this.onUpdated, {super.key});

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
        trailing: WeighInCardPopup(widget.weighIn, widget.onUpdated),
      ),
    );
  }
}

PopupMenuItem _buildWeighInPopupMenuItem(
    String title, IconData iconData, onTap) {
  return PopupMenuItem(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          iconData,
          color: Colors.black,
        ),
        Text(title),
      ],
    ),
  );
}

class WeighInCardPopup extends StatelessWidget {
  final WeighIn weighIn;
  final Function onUpdated;
  const WeighInCardPopup(this.weighIn, this.onUpdated, {super.key});

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
              _buildWeighInPopupMenuItem(
                  'Edit',
                  Icons.edit, // TODO edit code
                  () => {
                        userRepository.deleteWeighIn(
                            userRepository.currentUser, weighIn),
                        onUpdated()
                      }),
              _buildWeighInPopupMenuItem(
                  'Delete',
                  Icons.delete,
                  () => {
                        userRepository.deleteWeighIn(
                            userRepository.currentUser, weighIn),
                        onUpdated()
                      }),
            ]);
  }
}

class WeighInForm extends StatefulWidget {
  const WeighInForm({super.key});

  @override
  State<WeighInForm> createState() => _WeighInFormState();
}

class _WeighInFormState extends State<WeighInForm> {
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
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Observer(builder: (_) => DatePickerButton(store)),
          Observer(builder: (_) => UserWeightInputField(store)),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: store.validateAll, child: const Text('Save')),
          const SizedBox(height: 16),
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
