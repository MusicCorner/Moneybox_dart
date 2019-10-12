import 'package:clicker/constants/colors.dart';
import 'package:clicker/models/BoxesModel.dart';
import 'package:clicker/scratches/SingleBox.dart';
import 'package:clicker/states/EditBoxStateful.dart';
import 'package:clicker/view/SingleBoxForm/AddNewBoxPage/BoxFormBodyComponent.dart';
import 'package:clicker/view/SingleBoxForm/Common/NamedDateInput.dart';
import 'package:clicker/view/SingleBoxForm/Common/NamedInput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBoxPage extends State<EditBoxStateful> {
  final SingleBox box;
  final startDateInputController = TextEditingController();
  final endDateInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final sumToCacheInputController = TextEditingController();
  final cachedAlreadyInputController = TextEditingController();

  EditBoxPage({ this.box });

  @override
  initState() {
    setState(() {
      startDateInputController.text = _getDateString(box.startDate);
      endDateInputController.text = _getDateString(box.endDate);
      nameInputController.text = box.name;
      sumToCacheInputController.text = box.sumToCache.toString();
      cachedAlreadyInputController.text = box.cachedAlready.toString();
    });

    super.initState();
  }

  _changeName(String name) {
    setState(() {
      box.setName(name);
    });
  }

  void _changeSumToCache(String sumToCache) {
    setState(() {
      box.setSumToCache(int.parse(sumToCache));
    });
  }

  void _changeAlreadyCachedSum(String alreadyCached) {
    setState(() {
      box.setAlreadyCachedSum(int.parse(alreadyCached));
    });
  }

  String _getDateString(DateTime dateTime) {
    String day = dateTime.day <= 9 ? '0${dateTime.day}' : dateTime.day.toString();

    return '${dateTime.year}.${dateTime.month}.$day';
  }

  Future<Null> _changeStartDate(context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: box.startDate != null ? box.startDate : DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: box.endDate != null ? box.endDate : DateTime(2101)
    );

    if (pickedDate != null) {
      String startDateString = _getDateString(pickedDate);

      setState(() {
        box.startDate = pickedDate;
        startDateInputController.text = startDateString;
      });
      return;
    }

    return;
  }

  Future<Null> _changeEndDate(context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: box.endDate != null ? box.endDate : DateTime.now(),
      firstDate: box.startDate,
      lastDate: DateTime(2101)
    );

    if (pickedDate != null) {
      String endDateString = _getDateString(pickedDate);

      setState(() {
        box.endDate = pickedDate;
        endDateInputController.text = endDateString;
      });
    }
  }

  _onSubmit(BoxesModel boxesModel, context) {
    boxesModel.editBox(box);
    Navigator.pop(context);
  }

  Widget _getFloatingActionButton(context, BoxesModel boxesModel) {
    if (box.name != '' && box.sumToCache != 0 && box.startDate != null && box.endDate != null ) {
      return FloatingActionButton(
        child: Icon(Icons.check, color: WHITE_COLOR,),
        onPressed: () => _onSubmit(boxesModel, context),
      );
    }

    return Text('');
  }

  List<Widget> _getInputsList() {
    return [
      NamedInput(
        onChanged: _changeName,
        title: 'Box name',
        hintText: 'Car',
        controller: nameInputController,
      ),
      NamedInput(
        onChanged: _changeSumToCache,
        title: 'Sum to cache',
        hintText: '10 000',
        keyBoardType: TextInputType.number,
        controller: sumToCacheInputController,
      ),
      NamedInput(
        onChanged: _changeAlreadyCachedSum,
        title: 'Cached already',
        hintText: '1000',
        keyBoardType: TextInputType.number,
        controller: cachedAlreadyInputController,
      ),
      NamedDateInput(
        hintText: '10.10.2019',
        title: 'Start date',
        onTap: () => _changeStartDate(context),
        controller: startDateInputController
      ),
      NamedDateInput(
        hintText: '10.10.2019',
        title: 'End date',
        onTap: () => _changeEndDate(context),
        controller: endDateInputController,
        enabled: startDateInputController.text != ''
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${box.name}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BoxFormBodyComponent(namedInputsList: _getInputsList()),
      floatingActionButton: Consumer<BoxesModel>(
        builder: (builderContext, boxesModel, child) => _getFloatingActionButton(context, boxesModel),
      ),
    );
  }
}