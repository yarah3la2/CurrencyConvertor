library dropdownfield;

import 'package:currency_converter/utilities/AppConstants.dart';
import 'package:currency_converter/utilities/UtilitiesMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///DropDownField has customized autocomplete text field functionality
///
///Parameters
///
///value - dynamic - Optional value to be set into the Dropdown field by default when this field renders
///
///icon - Widget - Optional icon to be shown to the left of the Dropdown field
///
///hintText - String - Optional Hint text to be shown
///
///hintStyle - TextStyle - Optional styling for Hint text. Default is normal, gray colored font of size 18.0
///
///labelText - String - Optional Label text to be shown
///
///labelStyle - TextStyle - Optional styling for Label text. Default is normal, gray colored font of size 18.0
///
///required - bool - True will validate that this field has a non-null/non-empty value. Default is false
///
///enabled - bool - False will disable the field. You can unset this to use the Dropdown field as a read only form field. Default is true
///
///items - List<dynamic> - List of items to be shown as suggestions in the Dropdown. Typically a list of String values.
///You can supply a static list of values or pass in a dynamic list using a FutureBuilder
///
///textStyle - TextStyle - Optional styling for text shown in the Dropdown. Default is bold, black colored font of size 14.0
///
///inputFormatters - List<TextInputFormatter> - Optional list of TextInputFormatter to format the text field
///
///setter - FormFieldSetter<dynamic> - Optional implementation of your setter method. Will be called internally by Form.save() method
///
///onValueChanged - ValueChanged<dynamic> - Optional implementation of code that needs to be executed when the value in the Dropdown
///field is changed
///
///strict - bool - True will validate if the value in this dropdown is amongst those suggestions listed.
///False will let user type in new values as well. Default is true
///
///itemsVisibleInDropdown - int - Number of suggestions to be shown by default in the Dropdown after which the list scrolls. Defaults to 3
class DropDownField extends FormField<String> {
  final String value;
  final Widget icon;
  final String hintText;
  final TextStyle hintStyle;
  final String labelText;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final bool required;
  final bool enabled;
  final List<String> items;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldSetter<String> setter;
  final ValueChanged<String> onValueChanged;
  final bool strict;
  final int itemsVisibleInDropdown;
  final BuildContext context;
  final FocusNode focus;
  final Function(bool) listContainsValue;
  final bool hasIcon;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;
  // final FocusNode _focus = FocusNode();
  Widget notValidInputWidget;

  DropDownField(
      {Key key,
        this.focus,
        this.controller,
        this.value,
        this.required: false,
        this.icon,
        this.hintText,
        this.hintStyle: const TextStyle(
            fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
        this.labelText,
        this.labelStyle: const TextStyle(
            fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
        this.inputFormatters,
        this.items,
        this.textStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14.0),
        this.setter,
        this.onValueChanged,
        this.listContainsValue,
        this.itemsVisibleInDropdown: 3,
        this.enabled: true,
        this.strict: true,
        this.hasIcon: true,
        this.context})
      : super(
    key: key,
    autovalidate: false,
    initialValue: controller != null ? controller.text : (value ?? ''),
    onSaved: setter,
    builder: (FormFieldState<String> field) {
      final DropDownFieldState state = field;
      final ScrollController _scrollController = ScrollController();
      final InputDecoration effectiveDecoration = InputDecoration(
          border: InputBorder.none,
          filled: true,
          icon: icon,
          suffixIcon: (hasIcon)
              ? IconButton(
              icon: Icon(Icons.arrow_drop_down,
                  size: 30.0, color: Colors.black),
              onPressed: () {
                SystemChannels.textInput
                    .invokeMethod('TextInput.hide');
                state.setState(() {
                  state._showdropdown = !state._showdropdown;
                });
              })
              : null,
          hintStyle: NORMAL_BLACK_TEXTSTYLE,
          labelStyle: NORMAL_BLACK_TEXTSTYLE,
          hintText: hintText,
          labelText: labelText);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
//                        autovalidate: true,
                  controller: state._effectiveController,
                  decoration: getInputDecoration(context, hintText),
                  style: NORMAL_BLACK_TEXTSTYLE,
                  textAlign: TextAlign.start,
                  autofocus: false,
                  obscureText: false,
                  maxLengthEnforced: true,
                  maxLines: 1,
                  readOnly: true,
                  onChanged: (newValue) {
                    state.setState(() {
                      state._showdropdown = true;
                    });
                    // state.listContainsValue(items.contains(newValue), newValue);
                    if (items.contains(newValue) || isEmptyText(newValue))
                      onValueChanged(newValue);
                  },
                  onTap: () {
                    state.setState(() {
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide');
                      state._showdropdown = !state._showdropdown;
                    });
                  },
                  onSaved: setter,
                  enabled: enabled,
                  inputFormatters: inputFormatters,
                  // focusNode: state._focus,
                ),
              ),
            ],
          ),
          drawWidgetOrEmptyContainer(
            state._showdropdown,
            Container(
              decoration: BoxDecoration(
                color: WHITE,
                  border: Border.all(
                      color: WHITE,
                      width: TEXTFIELD_BORDER_RADUIS_WIDTH),
                  borderRadius:
                  BorderRadius.circular(ROUNDED_CORNER_RADIUS)),
              alignment: Alignment.topCenter,
              height: (itemsVisibleInDropdown <=
                  state._getChildren(state._items).length)
                  ? (itemsVisibleInDropdown * 48.0) + 49.0
                  : (state._getChildren(state._items).length * 48.0) +
                  49.0, //limit to default 3 items in dropdownlist view and then remaining scrolls
              width: MediaQuery.of(context).size.width + 100,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 44,
                    child: TextField(
                      controller: state._searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: getScreenWidth(context) * 0.85,
                    color: GREY,
                  ),
                  Expanded(
                    child: ListView(
                      cacheExtent: 0.0,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      // padding: EdgeInsets.only(left: 0.0),
                      children: items.isNotEmpty
                          ? ListTile.divideTiles(
                          color: Colors.transparent,
                          context: field.context,
                          tiles: state._getChildren(state._items))
                          .toList()
                          : List(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // state.setNotValidInputWidget(),
        ],
      );
    },
  );

  @override
  DropDownFieldState createState() => DropDownFieldState();
}

class DropDownFieldState extends FormFieldState<String> {
  TextEditingController _controller;
  bool _showdropdown = false;
  bool _isSearching = true;
  String _searchText = "";

  @override
  DropDownField get widget => super.widget;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;
  TextEditingController _searchController = TextEditingController();
  FocusNode _focus = FocusNode();

  List<String> get _items => widget.items;

  String notValidInput = '';

  void toggleDropDownVisibility() {}

  void clearValue() {
    setState(() {
      _effectiveController.text = '';
    });
  }

  @override
  void didUpdateWidget(DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
    // setNotValidInputWidget();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }

    _searchController.addListener(_handleControllerChanged);

    _focus.addListener(onFocusChange);

    _searchText = _searchController.text;

    widget.items.insert(0, "");

    // setNotValidInputWidget();
  }

  onFocusChange() {
    setState(() {
      print("Focus: " + _focus.hasFocus.toString());
      if (!_focus.hasFocus)
        _showdropdown = false;
      else
        _showdropdown = true;
    });
  }

  // setNotValidInputWidget() {
  //  return !_focus.hasFocus && !isEmptyText(notValidInput)
  //       ? Text(
  //           notValidInput,
  //           style: errorTextStyle,
  //         )
  //       : Container();
  // }

  listContainsValue(bool contains, String value) {
    if (contains || isEmptyText(value))
      setState(() {
        notValidInput = '';
      });
    else
      setState(() {
        notValidInput = 'Invalid value in this field!';
      });
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  List<ListTile> _getChildren(List<String> items) {
    List<ListTile> childItems = List();
    if (isNotEmptyList(items)) {
      if (!isEmptyText(items[0])) widget.items.insert(0, "");
      childItems.add(_getListTile(items[0], true));
    }
    for (var i = 1 ; i < items.length ; i++) {
      if (_searchText.isNotEmpty) {
        if (items[i].toUpperCase().contains(_searchText.toUpperCase()))
          childItems.add(_getListTile(items[i], false));
      } else {
        childItems.add(_getListTile(items[i], false));
      }
    }
    _isSearching ? childItems : List();
    return childItems;
  }

  ListTile _getListTile(String text, bool isEmptyTile) {
    return ListTile(
      dense: true,
      title: Text(
        (text != null && text.isNotEmpty) ? text : '',
      ),
      onTap: () {
        setState(() {
          _effectiveController.text = text;
          _handleControllerChanged();
          _showdropdown = false;
          _isSearching = false;
          if (widget.onValueChanged != null) widget.onValueChanged(text ?? "");
          listContainsValue(_items.contains(text), text);
        });
      },
      // trailing: isEmptyTile? Icon(Icons.clear, color: RED,) : null,
    );
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_searchController.text != value) didChange(_searchController.text);

    if (_searchController.text.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchText = "";
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchText = _searchController.text;
        // _showdropdown = true;
      });
    }
  }
}
