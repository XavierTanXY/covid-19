import 'package:flutter/material.dart'
    '';
class CustomWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomWidget({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ListTile(
          title: Text("Title ${widget.index}"),
          subtitle: Text("Description ${widget.index}"),
        ),
        decoration: widget.isSelected
            ? BoxDecoration(color: Colors.black38, border: Border.all(color: Colors.black))
            : BoxDecoration(),
      ),
    );
  }
}