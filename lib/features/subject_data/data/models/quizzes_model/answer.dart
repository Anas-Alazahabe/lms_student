abstract class Answer {}

class MCQAnswer extends Answer {
  int selectedOption;

  MCQAnswer(this.selectedOption);

  @override
  String toString() {
    return 'MCQAnswer( $selectedOption)';
  }
}
