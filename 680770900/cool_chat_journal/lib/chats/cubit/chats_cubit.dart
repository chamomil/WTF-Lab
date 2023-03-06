import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../chat/chat.dart' show Chat, Event;

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(const ChatsState());

  void addNewChat(Chat chat) {
    final chats = List<Chat>.from(state.chats)
      ..add(chat.copyWith(id: state.nextId));
    final nextId = state.nextId + 1;
    _sortChats(chats);
    emit(state.copyWith(chats: chats, nextId: nextId));
  }

  void deleteChat(int chatId) {
    final chats = state.chats.where((chat) => chat.id != chatId).toList();
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }

  void editChat(int id, Chat newChat) {
    final chats =
      state.chats.map((chat) => chat.id == id ? newChat : chat).toList();
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }

  void switchChatPinning(int id) {
    final chats = state.chats
      .map((chat) =>
        chat.id == id ? chat.copyWith(isPinned: !chat.isPinned) : chat,
      ).toList();
    _sortChats(chats);
    emit(state.copyWith(chats: chats));
  }

  void transferEvents({
    required int sourceChat,
    required int destinationChat,
    required List<int> eventsIds,
  }) {
    var destinationChatNextId = _findNextId(state.chats[destinationChat]);
    final events = state.chats[sourceChat].events
      .where(
        (event) => eventsIds.contains(event.id),
      )
      .map(
        (event) {
          final nextId = destinationChatNextId;
          destinationChatNextId++;

          return event.copyWith(id: nextId);
        }
      );

    final destinationChatEvents = 
      List<Event>.from(state.chats[destinationChat].events)..addAll(events);

    final sourceChatEvents = 
      state.chats[sourceChat].events
        .where(
          (event) => !eventsIds.contains(event.id),
        ).toList();

    editChat(
      sourceChat,
      state.chats[sourceChat].copyWith(events: sourceChatEvents),
    );

    editChat(
      destinationChat,
      state.chats[destinationChat].copyWith(events: destinationChatEvents),
    );
  }

  int _findNextId(Chat chat) {
    final int nextEventId;
    if (chat.events.isNotEmpty) {
      nextEventId = chat.events.reduce(
        (current, next) => current.id > next.id ? current : next,
      ).id + 1;
    } else {
      nextEventId = 0;
    }
    return nextEventId;
  }

  void _sortChats(List<Chat> chats) {
    chats.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return a.createdTime.compareTo(b.createdTime);
    });
  }
}
