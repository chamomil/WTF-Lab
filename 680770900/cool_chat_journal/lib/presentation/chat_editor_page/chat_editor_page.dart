import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/chat.dart';
import '../../utils/custom_theme.dart';
import 'chat_editor_cubit.dart';
import 'widgets/chat_icons.dart';

class ChatEditorPage extends StatefulWidget {
  final Chat? sourceChat;

  const ChatEditorPage({
    super.key,
    this.sourceChat,
  });

  @override
  State<ChatEditorPage> createState() => _ChatEditorPageState();
}

class _ChatEditorPageState extends State<ChatEditorPage> {
  final _cubit = GetIt.I<ChatEditorCubit>();

  void _saveChat({
    required BuildContext context,
    required ChatEditorState state,
  }) {
    if (state.title.isNotEmpty) {
      final iconIndex = state.iconIndex;
      final chat = Chat(
        id: widget.sourceChat?.id,
        iconCode: ChatIcons.icons[iconIndex].codePoint,
        name: state.title,
        createdTime: widget.sourceChat?.createdTime ?? DateTime.now(),
        isPinned: false,
      );

      if (widget.sourceChat != null) {
        _cubit.editChat(chat);
      } else {
        _cubit.addChat(chat);
      }
    }

    _cubit.changeTitle('');

    Navigator.pop(context);
  }

  Widget _title() {
    final String titleText;
    if (widget.sourceChat == null) {
      titleText = 'Create a new page';
    } else {
      titleText = 'Edit Page';
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          titleText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _titleField() {
    final initialValue = widget.sourceChat?.name;
    if (initialValue != null) {
      _cubit.changeTitle(initialValue);
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: const InputDecoration(
          labelText: 'Name of the Page',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
        ),
        onChanged: _cubit.changeTitle,
      ),
    );
  }

  Widget _iconsView() {
    final icons = ChatIcons.icons;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: icons.length,
        itemBuilder: (_, index) {
          return BlocBuilder<ChatEditorCubit, ChatEditorState>(
            buildWhen: (previous, current) =>
                previous.iconIndex != current.iconIndex,
            builder: (_, state) {
              return IconView(
                icon: icons[index],
                isSelected: index == state.iconIndex,
                size: 80,
                onTap: () => _cubit.selectIcon(index),
              );
            },
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return BlocBuilder<ChatEditorCubit, ChatEditorState>(
      buildWhen: (prev, current) =>
          (prev.title.isEmpty && current.title.isNotEmpty) ||
          (prev.title.isNotEmpty && current.title.isEmpty) ||
          (prev.title.isNotEmpty && prev.iconIndex != current.iconIndex),
      builder: (context, state) {
        final icon = state.title.isNotEmpty ? Icons.done : Icons.close;
        return FloatingActionButton(
          child: Icon(icon),
          onPressed: () => _saveChat(
            context: context,
            state: state,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _title(),
          _titleField(),
          Expanded(child: _iconsView()),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }
}

class IconView extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? size;

  const IconView({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    this.size,
  });

  Widget _iconView(ColorScheme colorScheme) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Icon(
        icon,
        color: colorScheme.onBackground,
        size: 45.0,
      ),
    );
  }

  Widget _selectionIcon(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: colorScheme.background,
        ),
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Icon(
        Icons.done,
        color: colorScheme.onBackground,
        size: 25.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = CustomTheme.of(context).themeData.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(alignment: Alignment.bottomRight, children: [
        _iconView(colorScheme),
        if (isSelected) _selectionIcon(colorScheme),
      ]),
    );
  }
}
