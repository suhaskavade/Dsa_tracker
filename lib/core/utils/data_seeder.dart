import 'dart:math';
import 'package:dsa_tracker/domain/entities/question.dart';

class DataSeeder {
  static final List<String> topics = [
    'Arrays + Strings',
    'Sorting',
    'Two Pointer',
    'Sliding Window',
    'Binary Search',
    'Hashing',
    'Recursion + Backtracking',
    'Linked List',
    'Stack + Queue',
    'Trees',
    'Graphs',
    'Heap',
    'Greedy',
    'Dynamic Programming',
  ];

  static final List<String> companiesList = [
    'Google',
    'Amazon',
    'Microsoft',
    'Apple',
    'Netflix',
    'Uber',
    'Goldman Sachs',
    'Flipkart',
    'PayPal',
    'Adobe',
    'Oracle',
  ];

  static List<Question> generateMockQuestions(int count) {
    final random = Random(42);
    final List<Question> questions = [];

    // Add some real prominent questions first
    questions.addAll(_getRealQuestions());

    int leetcodeIdStart = 100;

    // Generate the rest procedurally
    for (int i = questions.length; i < count; i++) {
      final topicIndex = random.nextInt(topics.length);
      final topic = topics[topicIndex];
      final difficulty = _randomDifficulty(random);

      final numCompanies = random.nextInt(4) + 1;
      final Set<String> qCompanies = {};
      while (qCompanies.length < numCompanies) {
        qCompanies.add(companiesList[random.nextInt(companiesList.length)]);
      }

      questions.add(
        Question(
          leetcodeId: leetcodeIdStart++,
          title: 'Algorithm Challenge $leetcodeIdStart',
          difficulty: difficulty,
          pattern: topic,
          topic: topic,
          url: 'https://leetcode.com/problems/mock-question-$leetcodeIdStart',
          companies: qCompanies.toList(),
          hints: [
            'Level 1: Try to look at the problem constraints. Brute force might be too slow.',
            'Level 2: Observe overlapping subproblems or monotonic properties.',
            'Level 3: Consider using a $topic based approach to optimize Time Complexity.',
          ],
          timeComplexity: difficulty == 'Hard' ? 'O(N log N)' : 'O(N)',
          spaceComplexity: 'O(N)',
          tags: [topic.split(' ').first.toLowerCase()],
          striverStep: topicIndex + 1,
        ),
      );
    }

    return questions;
  }

  static String _randomDifficulty(Random random) {
    final r = random.nextDouble();
    if (r < 0.4) return 'Easy';
    if (r < 0.8) return 'Medium'; // Mapped to Intermediate in UI later
    return 'Hard';
  }

  static List<Question> _getRealQuestions() {
    return [
      Question(
        leetcodeId: 1,
        title: 'Two Sum',
        difficulty: 'Easy',
        pattern: 'Hashing',
        topic: 'Hashing',
        url: 'https://leetcode.com/problems/two-sum/',
        companies: ['Google', 'Amazon', 'Microsoft', 'Adobe', 'Uber'],
        hints: [
          'A brute force approach would be O(n^2). Can we do better?',
          'We need a way to check if the complement (target - current) exists.',
          'Use a HashMap to store visited elements and check for the complement in O(1) time.',
        ],
        timeComplexity: 'O(N)',
        spaceComplexity: 'O(N)',
        tags: ['array', 'hash-table'],
        striverStep: 6,
      ),
      Question(
        leetcodeId: 3,
        title: 'Longest Substring Without Repeating Characters',
        difficulty: 'Medium',
        pattern: 'Sliding Window',
        topic: 'Sliding Window',
        url:
            'https://leetcode.com/problems/longest-substring-without-repeating-characters/',
        companies: ['Amazon', 'Microsoft', 'Facebook'],
        hints: [
          'Check all substrings one by one.',
          'Use a set to store characters in the current window.',
          'If a duplicate is found, slide the left pointer until the duplicate is removed.',
        ],
        timeComplexity: 'O(N)',
        spaceComplexity: 'O(min(M, N))',
        tags: ['hash-table', 'string', 'sliding-window'],
        striverStep: 4,
      ),
    ];
  }
}
