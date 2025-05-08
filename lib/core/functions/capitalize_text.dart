class CapitalizeText {
  static String capitalizeText(String text) {
    return text
        .split(' ')
        .map(
          (str) =>
              str.isNotEmpty
                  ? str[0].toUpperCase() + str.substring(1).toLowerCase()
                  : '',
        )
        .join(' ');
  }
}
