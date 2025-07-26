enum LearningStatus{
  unknown("NEW WORD"),
  learning("LEARNING"),
  reviewing("REVIEWING"),
  mastered("MASTERED");

  final String displayText;

  const LearningStatus(this.displayText);
}