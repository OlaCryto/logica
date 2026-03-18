type StateDirEnvSnapshot = {
  logicaStateDir: string | undefined;
  clawdbotStateDir: string | undefined;
};

export function snapshotStateDirEnv(): StateDirEnvSnapshot {
  return {
    logicaStateDir: process.env.LOGICA_STATE_DIR,
    clawdbotStateDir: process.env.LOGICA_STATE_DIR,
  };
}

export function restoreStateDirEnv(snapshot: StateDirEnvSnapshot): void {
  if (snapshot.logicaStateDir === undefined) {
    delete process.env.LOGICA_STATE_DIR;
  } else {
    process.env.LOGICA_STATE_DIR = snapshot.logicaStateDir;
  }
  if (snapshot.clawdbotStateDir === undefined) {
    delete process.env.LOGICA_STATE_DIR;
  } else {
    process.env.LOGICA_STATE_DIR = snapshot.clawdbotStateDir;
  }
}

export function setStateDirEnv(stateDir: string): void {
  process.env.LOGICA_STATE_DIR = stateDir;
  delete process.env.LOGICA_STATE_DIR;
}
