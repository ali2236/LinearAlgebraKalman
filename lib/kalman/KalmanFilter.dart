import 'package:linalg/linalg.dart';

import 'IKalmanFilter.dart';

/// <summary>
/// Abstract class that contains static methods to assist in the development
/// of Kalman Filters.
/// </summary>
abstract class KalmanFilter
{
  /// <summary>
  /// Checks that a state vector and covariance matrix are of the correct
  /// dimensions.
  /// </summary>
  /// <param name="x0">State vector.</param>
  /// <param name="P0">Covariance matrix.</param>
  /// <exception cref="System.ArgumentException">thrown when the x0 matrix is not
  /// a column vector, or when the P0 matrix is not a square matrix of the same order
  /// as the number of state variables.</exception>
  static void checkInitialParameters(Matrix x0, Matrix P0)
  {
    // x0 should be a column vector
    if (x0.n != 1)
    {
      throw 'new ArgumentException(Resources.KFStateNotnVector, "x0")';
    }

    // P0 should be square and of same order as x0
    if (P0.n != P0.m)
    {
      throw 'new ArgumentException(Resources.KFCovarianceNotSquare, "P0")';
    }

    if (P0.n != x0.m)
    {
      throw 'new ArgumentException(Resources.KFCovarianceIncorrectSize, "P0")';
    }
  }

  /// <summary>
  /// Checks that the given matrices for prediction are the correct dimensions.
  /// </summary>
  /// <param name="F">State transition matrix.</param>
  /// <param name="G">Noise coupling matrix.</param>
  /// <param name="Q">Noise process covariance.</param>
  /// <param name="filter">Filter being predicted.</param>
  /// <exception cref="System.ArgumentException">thrown when:
  /// <list type="bullet"><item>F is non-square with same ms/cols as state
  /// the number of state variables.</item>
  /// <item>G does not have same number of columns as number of state variables
  /// and ms as Q.</item>
  /// <item>Q is non-square.</item>
  /// </list></exception>
  static void checkPredictParametersWithNoises(Matrix F, Matrix G, Matrix Q, IKalmanFilter filter)
  {
    // State transition should be n-by-n matrix (n is number of state variables)
    if ((F.n != F.m) || (F.n != filter.state.m))
    {
      throw 'new ArgumentException(Resources.KFStateTransitionMalformed, "F")';
    }

    // Noise coupling should be n-by-p (p is ms in Q)
    if ((G.m != filter.state.m) || (G.n != Q.m))
    {
      throw 'new ArgumentException(Resources.KFNoiseCouplingMalformed, "G")';
    }

    // Noise covariance should be p-by-p
    if (Q.n != Q.m)
    {
      throw 'new ArgumentException(Resources.KFNoiseCovarianceMalformed, "Q")';
    }
  }

  /// Checks that the given prediction matrices are the correct dimension.
  /// <param name="F">State transition matrix.</param>
  /// <param name="Q">Noise covariance matrix.</param>
  /// <param name="filter">Filter being predicted.</param>
  /// <exception cref="System.ArgumentException">thrown when either transition
  /// or process noise matrices are non-square and/or have a number of ms/cols not
  /// equal to the number of state variables for the filter.</exception>
  static void checkPredictParametersWithNoise(Matrix F, Matrix Q, IKalmanFilter filter)
  {
    // State transition should be n-by-n matrix (n is number of state variables)
    if ((F.n != F.m) || (F.n != filter.state.m))
    {
      throw 'new ArgumentException(Resources.KFStateTransitionMalformed, "F")';
    }

    if ((Q.n != Q.m) || (Q.n != filter.state.m))
    {
      throw 'new ArgumentException(Resources.KFSquareNoiseCouplingMalformed, "Q")';
    }
  }

  /// <summary>
  /// Checks the state transition matrix is the correct dimension.
  /// </summary>
  /// <param name="F">State transition matrix.</param>
  /// <param name="filter">Filter being predicted.</param>
  /// <exception cref="System.ArgumentException">thrown when the transition
  /// matrix is non-square or does not have the same number of ms/cols as there
  /// are state variables in the given filter.</exception>
  static void checkPredictParameters(Matrix F, IKalmanFilter filter)
  {
    // State transition should be n-by-n matrix (n is number of state variables)
    if ((F.n != F.m) || (F.n != filter.state.m))
    {
      throw 'new ArgumentException(Resources.KFStateTransitionMalformed, "F")';
    }
  }

  /// <summary>
  /// Checks the given update parameters are of the correct dimension.
  /// </summary>
  /// <param name="z">Measurement matrix.</param>
  /// <param name="H">Measurement sensitivity matrix.</param>
  /// <param name="R">Measurement covariance matrix.</param>
  /// <param name="filter">Filter being updated.</param>
  /// <exception cref="System.ArgumentException">thrown when:
  /// <list type="bullet"><item>z is not a column vector.</item>
  /// <item>H does not have same number of ms as z and columns as R.</item>
  /// <item>R is non square.</item></list></exception>
  static void CheckUpdateParameters(Matrix z, Matrix H, Matrix R, IKalmanFilter filter)
  {
    if (z.n != 1)
    {
      throw 'new ArgumentException(Resources.KFMeasurementVectorMalformed, "z")';
    }

    if ((H.m != z.m) || (H.n != filter.state.m))
    {
      throw 'new ArgumentException(Resources.KFMeasureSensitivityMalformed, "H")';
    }

    if ((R.n != R.m) || (R.n != z.m))
    {
      throw 'new ArgumentException(Resources.KFMeasureCovarainceMalformed, "R")';
    }
  }
}