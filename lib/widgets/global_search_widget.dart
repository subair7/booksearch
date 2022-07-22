import 'package:flutter/material.dart';

class GlobalSearchWidget extends StatefulWidget {
  const GlobalSearchWidget({
    Key? key,
    this.hintText = 'Search by Venue Name, Event Name',
    this.onPressed,
    required this.onChanged,
  }) : super(key: key);
  final String? hintText;
  final void Function()? onPressed;
  final ValueChanged<String> onChanged;

  @override
  State<GlobalSearchWidget> createState() => _GlobalSearchWidgetState();
}

class _GlobalSearchWidgetState extends State<GlobalSearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 40,
          //  MediaQuery.of(context).size.width*0.11,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffE5E5E5))),
          child: Row(
            children: [
              Text(widget.hintText!,style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13,color: Colors.white)),
              const Spacer(flex: 1),
              const Icon(
                Icons.search,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
