import 'package:flutter/material.dart';

class PoolNameWidget extends StatefulWidget {
  final String poolName;

  const PoolNameWidget({
    super.key,
    required this.poolName
  });

  @override
  State<PoolNameWidget> createState() => _PoolNameWidgetState();
}

class _PoolNameWidgetState extends State<PoolNameWidget> {

  final TextEditingController _poolNameController = TextEditingController();

  late String _title;
  late bool _isEditing;

  @override
  void initState() {
    _title = widget.poolName.isEmpty ? "New pool" : widget.poolName;
    _isEditing = false;
    _poolNameController.text = _title;
  }

  void _submitPoolName(BuildContext context) {
    if (_poolNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Pool name cannot be empty", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red.withOpacity(0.7)
        )
      );
    } else {
      setState(() {
        _isEditing = false;
        _title = _poolNameController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Row(
      children: [
        _isEditing
          ? SizedBox(
            width: size.width*0.5,
            child: TextField(
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 20
                ),
                controller: _poolNameController,
                decoration: InputDecoration(
                  hintText: "Enter pool name",
                  hintStyle: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 0.5
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1
                    )
                  )
                ),
              ),
          )
          : SizedBox(
            width: size.width*0.6,
            child: Text(_title, style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
              ),),
          ),
        Visibility(
          visible: !_isEditing,
          child: IconButton(
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              icon: Icon(Icons.edit, color: Theme.of(context).scaffoldBackgroundColor,)),
        ),
        Visibility(
          visible: _isEditing,
          child: IconButton(
            onPressed: () {
              _submitPoolName(context);
            },
            icon: Icon(Icons.check, size: 20, color: Theme.of(context).scaffoldBackgroundColor,),
          )
        ),
        Visibility(
          visible: _isEditing,
          child: IconButton(
            onPressed: () {
              setState(() {
                _isEditing = false;
              });
            },
            icon: Icon(Icons.close, size: 20, color: Theme.of(context).scaffoldBackgroundColor),
          )
        )
      ],
    );
  }
}
