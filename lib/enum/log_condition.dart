enum LogCondition {
  show('1'),
  add('2'),
  update('3'),
  toggle('4'),
  delete('5'),
  end('0');

  final String value;
  const LogCondition(this.value);
}