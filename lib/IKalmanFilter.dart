

import 'package:linalg/matrix.dart';

abstract class IKalmanFilter {
  
/// The covariance of the current state estimate.
Matrix get cov;

/// The current best estimate of the state of the system.
Matrix get state;

/// Performs a prediction of the next state of the system.
/// <param name="F">The state transition matrix.</param>
void predictState(Matrix F);

/// Perform a prediction of the next state of the system.
/// <param name="F">The state transition matrix.</param>
/// <param name="G">The linear equations to describe the effect of the noise
/// on the system.</param>
/// <param name="Q">The covariance of the noise acting on the system.</param>
void predict(Matrix F, Matrix G, Matrix Q);

/// Updates the state estimate and covariance of the system based on the
/// given measurement.
/// <param name="z">The measurements of the system.</param>
/// <param name="H">Linear equations to describe relationship between
/// measurements and state variables.</param>
/// <param name="R">The covariance matrix of the measurements.</param>
void update(Matrix z, Matrix H, Matrix R);
}