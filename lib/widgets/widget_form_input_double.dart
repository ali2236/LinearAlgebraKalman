import 'package:flutter/material.dart';

class DoubleFormInput extends StatefulWidget {

  final double initialValue;
  final FormFieldValidator<double> validator;
  final ValueChanged<double> onChange;
  final String label;

  const DoubleFormInput({Key key, this.initialValue, this.validator, this.label, this.onChange}) : super(key: key);

  @override
  _DoubleFormInputState createState() => _DoubleFormInputState();
}

class _DoubleFormInputState extends State<DoubleFormInput> {

  double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {

    FormFieldValidator<String> validator = (v){
      if(v.isEmpty) return 'این مقدار نمی تواند خالی باشد';
      try {
        var d = double.tryParse(v);
        if(widget.validator != null) return widget.validator(d);
        else return null;
      } catch (e) {
        return 'مقدار وارد شده یک عدد صحیح نیست';
      }
    };

    return SizedBox(
      child: TextFormField(
        textDirection: TextDirection.ltr,
        initialValue: value.toString(),
        decoration: widget.label!=null ? InputDecoration(
          labelText: widget.label,
        ) : null,
        keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
        onChanged: (v){
          try {
            value = double.tryParse(v);
            if(widget.onChange!=null && validator(v)==null) widget.onChange(value);
            setState(() {});
          } catch (e) {
            print(e);
          }
        },
        validator: validator,
        onEditingComplete: (){
          Form.of(context).validate();
        },
      ),
    );
  }
}
