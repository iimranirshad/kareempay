double calculateFicoScore({
  required double paymentHistory,      // 0 to 100
  required double creditUtilization,   // 0 to 100
  required double creditHistoryLength, // 0 to 100
  required double creditMix,           // 0 to 100
  required double newCredit,           // 0 to 100
}) {
  // Weight percentages based on FICO model
  const double weightPaymentHistory = 0.35;
  const double weightCreditUtilization = 0.30;
  const double weightCreditHistoryLength = 0.15;
  const double weightCreditMix = 0.10;
  const double weightNewCredit = 0.10;

  // Calculate score out of 100
  double scoreOutOf100 = (paymentHistory * weightPaymentHistory) +
      (creditUtilization * weightCreditUtilization) +
      (creditHistoryLength * weightCreditHistoryLength) +
      (creditMix * weightCreditMix) +
      (newCredit * weightNewCredit);

  // Convert to FICO scale (300 - 850)
  double ficoScore = 300 + (scoreOutOf100 * 5.5); // 100 * 5.5 = 550 + 300 = 850

  return ficoScore.clamp(300, 850);
}
