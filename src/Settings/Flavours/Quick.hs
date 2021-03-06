module Settings.Flavours.Quick (quickFlavour) where

import Expression
import Flavour
import Oracles.Flag
import {-# SOURCE #-} Settings.Default
import Settings.Flavours.Common (naturalInBaseFixArgs)

-- Please update doc/flavours.md when changing this file.
quickFlavour :: Flavour
quickFlavour = defaultFlavour
    { name        = "quick"
    , args        = defaultBuilderArgs <> quickArgs <> defaultPackageArgs
    , libraryWays = mconcat
                    [ pure [vanilla]
                    , notStage0 ? platformSupportsSharedLibs ? pure [dynamic] ] }

quickArgs :: Args
quickArgs = sourceArgs SourceArgs
    { hsDefault  = mconcat $
        [ pure ["-O0", "-H64m"]
        , naturalInBaseFixArgs
        ]
    , hsLibrary  = notStage0 ? arg "-O"
    , hsCompiler =    stage0 ? arg "-O"
    , hsGhc      =    stage0 ? arg "-O" }
