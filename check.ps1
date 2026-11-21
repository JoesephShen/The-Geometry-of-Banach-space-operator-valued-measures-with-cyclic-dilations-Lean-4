$ErrorActionPreference = 'Stop'
Push-Location $PSScriptRoot
try {
    $output = lake env lean -DwarningAsError=true Paper.lean
    $status = $LASTEXITCODE
    $output | Write-Output
    if ($status -ne 0) { exit $status }

    $expected = @(Select-String -LiteralPath Paper.lean -Pattern '^#print axioms ').Count
    $records = [regex]::Matches(($output -join [Environment]::NewLine),
        "depends on axioms:\s*\[(?<dependencies>[^\]]*)\]|does not depend on any axioms")
    if ($records.Count -ne $expected) {
        throw "Found $($records.Count) axiom records for $expected declarations."
    }

    $standard = @('propext', 'Classical.choice', 'Quot.sound')
    $cited = @('citeProbabilityLpReflexive', 'citeRieszThorinProbabilityLp', 'citeDalesLaustsenOikhbergTroitsky2017_AL', 'citeRosenthal1974', 'citeEberleinSmulian', 'citeVitaliHahnSaks1977', 'citeVectorMeasureL1', 'citeOkadaRickerSanchezPerez2014', 'citeKitoverOrhon2017_L1_KB', 'citePettisMeasurability', 'citeVectorMeasureL1Representatives', 'citeRallCyclicLattice', 'citeFreudenthalPrincipalIdeal', 'citeCompleteBandAlgebra', 'citeLoomisSikorski', 'citeOrderContinuousLatticeKB', 'citeHyperstonianLInfinity', 'citeCZeroSequenceDuality', 'citeReflexiveVectorRadonNikodym', 'citeKotheBochnerIntegralDuality', 'citeVectorMeasureL1ControlCoordinates', 'citeOrderContinuousWeakPrecompactSolidHull', 'citeDFJPInterpolation', 'citeRelativeEberleinSmulian', 'citeReflexiveClosedSubspace', 'citeKreinClosedConvexHull', 'citeWeaklyPrecompactClosedConvexHull', 'citeLatticeDFJPKothe', 'citeKotheSimpleDensity', 'citeKotheKB', 'citeProbabilityLpIntegralBound', 'citeAtomlessProbabilityL1ContainsLone', 'citeVectorMeasureSemivariationTails', 'citeCountableWeakDiagonalSelection', 'citeVectorVariationModel', 'citeDiestelUniformIntegrability', 'citeLTwoHilbertDuality', 'citeLTwoProductCoordinates', 'citeLTwoRieszCoordinate', 'citeRademacherWalshOrthogonality', 'citeLTwoSetIntegralBound', 'citeLTwoAdjoinCoordinate', 'citeBochnerDensityVariation', 'citeDFJPWeaklyCompactOperator', 'citeScalarDensityOfVectorVariation', 'citeVectorMeasureL1NormCoordinates', 'citeOrderContinuousKotheIntervals', 'citeScalarRNChangeOfMeasure', 'citeLiLi2017OperatorDensity', 'citeRademacherLTwoSynthesis', 'citeLTwoCoordinatePVM', 'citeRademacherBesselIntoCZero', 'citeVectorDensityL1Coordinates', 'citeLTwoMeasureReflexive', 'citeHardyFourierCoordinates', 'citeCyclicUnitarySpectralTheorem', 'citeEWojtowytschHomogeneousKernel', 'citeConditionalExpectationLp')
    $cited += @('citeDiestelUhlL1WeaklySequentiallyComplete', 'citeDiestelUhlL1IndicatorNoDensity', 'citeHanLarsonLiuLiuUnconditionalBasis', 'citeLindenstraussTzafririExponentialHeart', 'citeLindenstraussTzafririExponentialDual', 'citeLindenstraussTzafririHaarReproducibility', 'citeFerencziUniformlyConvexHI', 'citeDeHeviaTradaceteComplementedLatticeSequence', 'citeLindenstraussTzafririLatticeRenorm', 'citeLindenstraussTzafririVectorCZeroDual', 'citeVectorLTwoReflexivity', 'citeBochnerLTwoReflexivity')
    $axiomLines = @(Select-String -LiteralPath Paper.lean -Pattern '^\s*axiom\s+(\w+)')
    $defined = @($axiomLines | ForEach-Object { $_.Matches[0].Groups[1].Value } | Sort-Object)
    if (Compare-Object -ReferenceObject @($cited | Sort-Object) -DifferenceObject $defined) {
        throw 'The project axiom declarations disagree with the cited-axiom manifest.'
    }
    foreach ($record in $records) {
        $extra = $record.Groups['dependencies'].Value.Trim() -split '\s*,\s*' |
            Where-Object { $_ -and $_ -notin $standard -and ($_ -replace '^(?:Paper\.)?(?:(?:BarronSphere|ExponentialHeartModel)\.)?', '') -notin $cited }
        if ($extra) {
            throw "Unexpected axiom dependency: $extra"
        }
    }
} finally {
    Pop-Location
}


