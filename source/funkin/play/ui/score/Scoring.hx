package funkin.play.ui.score;


/**
 * Which system to use when scoring and judging notes.
 */
enum abstract ScoringSystem(String)
{
  /**
   * The scoring system used in versions of the game Week 6 and older.
   * Scores the player based on judgement, represented by a step function.
   */
  var LEGACY;

  /**
   * The scoring system used in Week 7. It has tighter scoring windows than Legacy.
   * Scores the player based on judgement, represented by a step function.
   */
  var WEEK7;

  /**
   * Points Based On Timing scoring system, version 1
   * Scores the player based on the offset based on timing, represented by a sigmoid function.
   */
  var PBOT1;
}

class Scoring
{
    public function new(value) {
        
    }
}