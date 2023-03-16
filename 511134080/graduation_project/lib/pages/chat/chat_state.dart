part of 'chat_cubit.dart';

class ChatState {
  final Chat _chat;
  final int _categoryIconIndex;
  final bool _isChoosingCategory;
  final bool _isEditingMode;

  final eventsRepository = EventRepository();

  late final List<String> _hintMessages;

  ChatState({
    Chat chat = const Chat(
      iconId: 0,
      title: '',
      id: '0',
      date: null,
    ),
    int categoryIconIndex = 0,
    bool isChoosingCategory = false,
    bool isEditingMode = false,
  })  : _chat = chat,
        _categoryIconIndex = categoryIconIndex,
        _isChoosingCategory = isChoosingCategory,
        _isEditingMode = isEditingMode {
    _hintMessages = [
      'This is the page where you can track everything about "${_chat.title}"!\n',
      'You don\'t seem to have any bookmarked events yet. You can bookmark an event by single tapping the event',
      'This is the page where you can track everything about "${_chat.title}"!\n',
      'Add your first event to "${_chat.title}" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
    ];
  }

  List<Event> get events => _chat.isShowingFavourites
      ? List<Event>.from(
          _chat.events.reversed.where((card) => card.isFavourite),
        )
      : List<Event>.from(_chat.events.reversed);

  int get eventsLength => _chat.isShowingFavourites
      ? _chat.events.where((card) => card.isFavourite).length
      : _chat.events.length;

  List<String> get hintMessages => _chat.isShowingFavourites
      ? [_hintMessages[0], _hintMessages[1]]
      : [_hintMessages[2], _hintMessages[3]];

  bool get isChoosingCategory => _isChoosingCategory;

  int get categoryIconIndex => _categoryIconIndex;

  Chat get chat => _chat;

  ChatState copyWith({
    Chat? newChat,
    int? newCategoryIconIndex,
    bool? choosingCategory,
    bool? editingMode,
  }) =>
      ChatState(
        chat: newChat ?? _chat,
        categoryIconIndex: newCategoryIconIndex ?? _categoryIconIndex,
        isChoosingCategory: choosingCategory ?? _isChoosingCategory,
        isEditingMode: editingMode ?? _isEditingMode,
      );
}
