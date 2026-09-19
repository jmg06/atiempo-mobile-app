abstract final class AppRoutes {
  static const String flows = '/';

  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String createAccount = '/create-account';
  static const String invitation = '/invitation';
  static const String expiredInvitation = '/invitation/expired';
  static const String activateAccess = '/invitation/activate';
  static const String consent = '/consent';

  static const String preAlert = '/alarm/pre-alert';
  static const String alarm = '/alarm/ringing';
  static const String doseConfirmed = '/alarm/confirmed';
  static const String doseConfirmedOffline = '/alarm/confirmed-offline';
  static const String delegatedDose = '/alarm/delegated';
  static const String stillPending = '/alarm/still-pending';

  static const String today = '/today';

  static const String blockIdParameter = 'blockId';
  static const String blockDetailPattern = '/blocks/:$blockIdParameter';
  static const String delegateBlockPattern = '$blockDetailPattern/delegate';
  static const String blockDelegationPattern = '$blockDetailPattern/delegation';

  static String blockDetail(String blockId) => '/blocks/$blockId';

  static String delegateBlock(String blockId) => '${blockDetail(blockId)}/delegate';

  static String blockDelegation(String blockId) => '${blockDetail(blockId)}/delegation';
}
