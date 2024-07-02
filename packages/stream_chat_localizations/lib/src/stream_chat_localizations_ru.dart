part of 'stream_chat_localizations.dart';

/// Переводы на русский язык (`ru`).
class StreamChatLocalizationsRu extends GlobalStreamChatLocalizations {
  /// Создает экземпляр пакета перевода на русский язык.
  const StreamChatLocalizationsRu({super.localeName = 'ru'});

  @override
  String get launchUrlError => 'Не удалось открыть URL';

  @override
  String get loadingUsersError => 'Ошибка загрузки пользователей';

  @override
  String get noUsersLabel => 'Пользователей нет';

  @override
  String get noPhotoOrVideoLabel => 'Фото или видео нет';

  @override
  String get retryLabel => 'Повторить';

  @override
  String get userLastOnlineText => 'Был в сети';

  @override
  String get userOnlineText => 'В сети';

  String userTypingText(Iterable<User> users) {
    if (users.isEmpty) return '';
    final first = users.first;
    if (users.length == 1) {
      return '${first.name} печатает';
    }
    return '${first.name} и еще ${users.length - 1} печатают';
  }

  @override
  String get threadReplyLabel => 'Ответ в теме';

  @override
  String get onlyVisibleToYouText => 'Видно только вам';

  String threadReplyCountText(int count) => '$count ответов в теме';

  @override
  String attachmentsUploadProgressText({
    required int remaining,
    required int total,
  }) =>
      'Загрузка $remaining/$total ...';

  @override
  String pinnedByUserText({
    required User pinnedBy,
    required User currentUser,
  }) {
    final pinnedByCurrentUser = currentUser.id == pinnedBy.id;
    if (pinnedByCurrentUser) return 'Отмечено вами';
    return 'Отмечено ${pinnedBy.name}';
  }

  @override
  String get sendMessagePermissionError =>
      'У вас нет разрешения отправлять сообщения';

  @override
  String get emptyMessagesText => 'Сообщений пока нет';

  @override
  String get genericErrorText => 'Что-то пошло не так';

  @override
  String get loadingMessagesError => 'Ошибка загрузки сообщений';

  @override
  String resultCountText(int count) => '$count результатов';

  @override
  String get messageDeletedText => 'Это сообщение удалено.';

  @override
  String get messageDeletedLabel => 'Сообщение удалено';

  @override
  String get messageReactionsLabel => 'Реакции на сообщение';

  @override
  String get emptyChatMessagesText => 'Здесь пока нет чатов...';

  @override
  String threadSeparatorText(int replyCount) {
    if (replyCount == 1) return '1 ответ';
    return '$replyCount ответов';
  }

  @override
  String get connectedLabel => 'Подключено';

  @override
  String get disconnectedLabel => 'Отключено';

  @override
  String get reconnectingLabel => 'Переподключение...';

  @override
  String get alsoSendAsDirectMessageLabel =>
      'Также отправить как личное сообщение';

  @override
  String get addACommentOrSendLabel => 'Добавить комментарий или отправить';

  @override
  String get searchGifLabel => 'Поиск GIF';

  @override
  String get writeAMessageLabel => 'Написать сообщение';

  @override
  String get instantCommandsLabel => 'Мгновенные команды';

  String fileTooLargeAfterCompressionError(double limitInMB) =>
      'Файл слишком большой для загрузки. '
      'Лимит размера файла составляет $limitInMB МБ. '
      'Сжатие не помогло.';

  String fileTooLargeError(double limitInMB) =>
      'Файл слишком большой для загрузки. Лимит размера файла составляет $limitInMB МБ.';

  @override
  String get couldNotReadBytesFromFileError =>
      'Не удалось прочитать данные из файла.';

  @override
  String get addAFileLabel => 'Добавить файл';

  @override
  String get photoFromCameraLabel => 'Фото с камеры';

  @override
  String get uploadAFileLabel => 'Загрузить файл';

  @override
  String get uploadAPhotoLabel => 'Загрузить фото';

  @override
  String get uploadAVideoLabel => 'Загрузить видео';

  @override
  String get videoFromCameraLabel => 'Видео с камеры';

  @override
  String get okLabel => 'ОК';

  @override
  String get somethingWentWrongError => 'Что-то пошло не так';

  @override
  String get addMoreFilesLabel => 'Добавить больше файлов';

  @override
  String get enablePhotoAndVideoAccessMessage =>
      'Пожалуйста, разрешите доступ к вашим фотографиям'
      '\nи видео, чтобы вы могли делиться ими с друзьями.';

  @override
  String get allowGalleryAccessMessage => 'Разрешить доступ к галерее';

  @override
  String get flagMessageLabel => 'Пометить сообщение';

  @override
  String get flagMessageQuestion =>
      'Хотите отправить копию этого сообщения модератору'
      '\nдля дальнейшего рассмотрения?';

  @override
  String get flagLabel => 'ПОМЕТИТЬ';

  @override
  String get cancelLabel => 'ОТМЕНА';

  @override
  String get flagMessageSuccessfulLabel => 'Сообщение помечено';

  @override
  String get flagMessageSuccessfulText =>
      'Сообщение было отправлено модератору.';

  @override
  String get deleteLabel => 'УДАЛИТЬ';

  @override
  String get deleteMessageLabel => 'Удалить сообщение';

  @override
  String get deleteMessageQuestion =>
      'Вы уверены, что хотите навсегда удалить это сообщение?';

  @override
  String get operationCouldNotBeCompletedText =>
      'Операцию выполнить не удалось.';

  @override
  String get replyLabel => 'Ответить';

  String togglePinUnpinText({required bool pinned}) {
    if (pinned) return 'Снять отметку с сообщения';
    return 'Отметить сообщение';
  }

  @override
  String toggleDeleteRetryDeleteMessageText({required bool isDeleteFailed}) {
    if (isDeleteFailed) return 'Повторить удаление сообщения';
    return 'Удалить сообщение';
  }

  @override
  String get copyMessageLabel => 'Копировать сообщение';

  @override
  String get editMessageLabel => 'Редактировать сообщение';

  String toggleResendOrResendEditedMessage({required bool isUpdateFailed}) {
    if (isUpdateFailed) return 'Отправить отредактированное сообщение';
    return 'Отправить заново';
  }

  @override
  String get photosLabel => 'Фото';

  String _getDay(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return 'сегодня';
    } else if (date == yesterday) {
      return 'вчера';
    } else {
      return 'на ${Jiffy.parseFromDateTime(date).MMMd}';
    }
  }

  @override
  String sentAtText({required DateTime date, required DateTime time}) =>
      'Отправлено ${_getDay(date)} в ${Jiffy.parseFromDateTime(time.toLocal()).format(
        pattern: 'HH:mm',
      )}';

  @override
  String get todayLabel => 'Сегодня';

  @override
  String get yesterdayLabel => 'Вчера';

  @override
  String get channelIsMutedText => 'Канал заглушен';

  @override
  String get noTitleText => 'Без заголовка';

  @override
  String get letsStartChattingLabel => 'Давайте начнем общение!';

  @override
  String get sendingFirstMessageLabel =>
      'Как насчет того, чтобы отправить ваше первое сообщение другу?';

  @override
  String get startAChatLabel => 'Начать чат';

  @override
  String get loadingChannelsError => 'Ошибка загрузки каналов';

  @override
  String get deleteConversationLabel => 'Удалить беседу';

  @override
  String get deleteConversationQuestion =>
      'Вы уверены, что хотите удалить эту беседу?';

  @override
  String get streamChatLabel => 'Stream Chat';

  @override
  String get searchingForNetworkText => 'Поиск сети';

  @override
  String get offlineLabel => 'Не в сети...';

  @override
  String get tryAgainLabel => 'Попробовать снова';

  String membersCountText(int count) {
    if (count == 1) return '1 участник';
    return '$count участников';
  }

  @override
  String watchersCountText(int count) {
    if (count == 1) return '1 в сети';
    return '$count в сети';
  }

  @override
  String get viewInfoLabel => 'Посмотреть информацию';

  @override
  String get leaveGroupLabel => 'Покинуть группу';

  @override
  String get leaveLabel => 'ПОКИНУТЬ';

  @override
  String get leaveConversationLabel => 'Покинуть беседу';

  @override
  String get leaveConversationQuestion =>
      'Вы уверены, что хотите покинуть эту беседу?';

  @override
  String get showInChatLabel => 'Показать в чате';

  @override
  String get saveImageLabel => 'Сохранить изображение';

  @override
  String get saveVideoLabel => 'Сохранить видео';

  @override
  String get uploadErrorLabel => 'ОШИБКА ЗАГРУЗКИ';

  @override
  String get giphyLabel => 'Giphy';

  @override
  String get shuffleLabel => 'Перемешать';

  @override
  String get sendLabel => 'Отправить';

  @override
  String get withText => 'с';

  @override
  String get inText => 'в';

  @override
  String get youText => 'Вы';

  @override
  String get editedText => 'Отредактировано';

  String galleryPaginationText({
    required int currentPage,
    required int totalPages,
  }) =>
      '${currentPage + 1} из $totalPages';

  @override
  String get fileText => 'Файл';

  @override
  String get replyToMessageLabel => 'Ответить на сообщение';

  String attachmentLimitExceedError(int limit) =>
      'Превышен лимит вложений, лимит: $limit';

  @override
  String get slowModeOnLabel => 'Медленный режим ВКЛ';

  @override
  String get downloadLabel => 'Скачать';

  String toggleMuteUnmuteUserText({required bool isMuted}) {
    if (isMuted) {
      return 'Включить звук пользователя';
    } else {
      return 'Отключить звук пользователя';
    }
  }

  @override
  String toggleMuteUnmuteGroupQuestion({required bool isMuted}) {
    if (isMuted) {
      return 'Вы уверены, что хотите включить звук этой группы?';
    } else {
      return 'Вы уверены, что хотите отключить звук этой группы?';
    }
  }

  @override
  String toggleMuteUnmuteUserQuestion({required bool isMuted}) {
    if (isMuted) {
      return 'Вы уверены, что хотите включить звук этого пользователя?';
    } else {
      return 'Вы уверены, что хотите отключить звук этого пользователя?';
    }
  }

  @override
  String toggleMuteUnmuteAction({required bool isMuted}) {
    if (isMuted) {
      return 'ВКЛЮЧИТЬ ЗВУК';
    } else {
      return 'ОТКЛЮЧИТЬ ЗВУК';
    }
  }

  @override
  String toggleMuteUnmuteGroupText({required bool isMuted}) {
    if (isMuted) {
      return 'Включить звук группы';
    } else {
      return 'Отключить звук группы';
    }
  }

  @override
  String get linkDisabledDetails => 'Отправка ссылок запрещена в этой беседе.';

  @override
  String get linkDisabledError => 'Ссылки отключены';

  @override
  String get viewLibrary => 'Просмотр библиотеки';

  String unreadMessagesSeparatorText(int unreadCount) {
    if (unreadCount == 1) {
      return '1 непрочитанное сообщение';
    }
    return '$unreadCount непрочитанных сообщений';
  }

  @override
  String get enableFileAccessMessage => 'Пожалуйста, разрешите доступ к файлам'
      '\nчтобы вы могли делиться ими с друзьями.';

  @override
  String get allowFileAccessMessage => 'Разрешить доступ к файлам';
}
