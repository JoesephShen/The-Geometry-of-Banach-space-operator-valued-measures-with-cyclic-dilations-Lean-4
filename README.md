# Paper Lean 4 proof audit

This project formalizes the manuscript Representations and dilations of operator-valued measures. The source and Lean SHA-256 hashes are in KernelAudit.txt.

The project formalizes the manuscript results through Section 7. The statements use real Banach spaces where completeness is needed, measurable sets, norm-continuous duals and biduals, and the manuscript's norm-topology countable additivity and localization conditions.

## Axiom disclosure

Lean 4 checks the formalized proofs relative to the standard Lean axioms `propext`, `Classical.choice`, and `Quot.sound`, together with the external results explicitly declared as axioms in [`Paper.lean`](Paper.lean). The project declares 70 such results from textbooks and the cited literature. The [cited-axiom table](ManuscriptCoverage.md#cited-axioms) identifies the results and their sources.

The recorded audit checks the transitive axiom dependencies of 620 declarations. Every recorded dependency is among the standard axioms and the listed external results. The audited declarations have no `sorryAx` dependency. See [`KernelAudit.txt`](KernelAudit.txt) for the per-declaration dependencies and [`check.ps1`](check.ps1) to rerun the audit on Windows.

## AI assistance

GPT 6.2 Sol assisted with generating and reviewing the Lean 4 formalization. Lean 4 checked the resulting formal proofs under the axiom dependencies described above.

## Reproduce

Lean version 4.36.0 and mathlib revision fc4f59e577feb1a4956671bc04ac18aaaf8cd842 are pinned. In the project directory:

    lake update
    lake exe cache get
    lake build Paper
    lake env lean -DwarningAsError=true Paper.lean

On Windows, ./check.ps1 checks every printed axiom list after compilation.

## Manuscript correspondence

| Manuscript location | Lean declarations or coverage |
| --- | --- |
| rem:ovm-bounds and eq:multiplier-bound | The weak-to-strong implication, exact finite multiplier bound and bounded unital multiplier algebra are checked. For a finite faithful control measure, the almost-everywhere quotient has a faithful representation with the exact essential-norm bound. |
| eq:ovm-normal-projection | ScalarCharge.countablyAdditivePart and OVM.normalProjection. The real Yosida–Hewitt projection is implemented using the greatest positive countably additive minorant and Jordan decomposition. Additivity, homogeneity, restriction, identity on countably additive charges, and variation contraction are checked. The bidual operator is bounded by 2 M_μ. |
| lem:normal-restriction and eq:baire-hereditary | Normal projection range and idempotence, intertwining, B₁ inclusion, the invariant subspace normal-part formula, and all maps of the normal-parts short exact sequence are checked. The hereditary B₁ argument uses tail convex combinations in the quotient via Mazur's theorem, as in the text. |
| prop:cyclic-normal | The cyclic null-projection implication and the existence of a faithful positive coefficient are checked. The countable detection and Hahn-decomposition construction proves the faithful coefficient directly. PVM.exists_normalCoefficient_density provides real integrable Radon–Nikodym densities. PVM.cyclic_normal_density proves global product integrability by variation bounds and the exact coefficient identity in eq:normal-density. PVM.localizes_of_cyclic uses that identity and the bounded multipliers to construct canonical representatives. |
| lem:invariant-cyclic | PVM.invariant_eq_projection_range proves that every closed invariant subspace is the range of a measurable projection and that the projection of the original cyclic vector is cyclic for the restriction. PVM.support_cut_mem establishes the support and inverse-truncation step. |
| prop:normal-coverage | The three-space equivalence for (L), the equality of normal vectors with B₁ under (L), and the equivalence of (L) with coverage by cyclic normal parts are checked. The forward implication generates the cyclic subspace from the paper's weighted sum of disjoint localized increments. PVM.localizes_of_finitelyGenerated proves the induction using closed invariant orbit spans and cyclic quotients. PVM.localizes_iff_finitelyGenerated_coverage proves the equivalence with the union of the normal parts of closed finitely generated invariant subspaces. |
| prop:no-l1-general | OVM.shrinking_of_not_contains_lOne proves the assertion for arbitrary strongly countably additive OVMs. OVM.lOneCoefficientMap and OVM.norm_lOneCoefficientMap_le give the coefficient operator and the manuscript's (2 M_μ ‖f‖) bound. |
| rem:finite-subsums | The finite subseries identity and the absolute scalar estimate 2 M_P C ‖f‖ are checked. |
| thm:representation-james and intro:james | PVM.representation_james proves all three parts, with the original localization hypothesis. It includes shrinking, exclusion of ℓ₁ and normality of all bidual vectors, the four bounded-completeness characterizations, and reflexivity. PVM.localizes_of_cyclic and PVM.localizes_of_finitelyGenerated give the two specializations. |
| cor:local-representation-james | PVM.shrinking_james_of_countable_cover and PVM.boundedlyComplete_james_of_countable_cover prove parts (1) and (2). PVM.reflexivity_iff_shrinking_boundedlyComplete_of_countable_cover checks part (3) through the two applications of Eberlein–Šmulian. The local c₀ argument places its basis in one invariant subspace. |
| §3 single-point example | Shrinking and bounded completeness always hold. Localization is equivalent to reflexivity. The same Lean proof works for a PVM supported at any selected point. |
| rem:lattice-james and rem:normal-quotients | The Bade limits, band-projection converse, cyclic coverage and the James equivalences are checked. The hyperstonian model realizes the normal part as the Arens image of the canonical predual projection. The three-space property and normal bidual quotient isomorphisms are checked. The coordinate PVM on c₀ localizes and its normal part is ℓ∞ with proper canonical image. |
| §4.1 α-dilation | OVM.alphaDilation constructs the completion in the manuscript's supremum norm as the closed span of elementary vectors in a complete bounded-function space. Strong countable additivity, normalized PVM identities, and compression are checked. |
| prop:minimal-cyclic | Dilation.alphaComparison is the dense-range comparison map from the generated invariant subspace, with the stated intertwining. Dilation.cyclic_alphaPVM and OVM.cyclic_alphaDilation give both directions of the equivalence. The proof uses the checked invariant-subspace theorem followed by the transfer of the cyclic vector under the dense intertwiner. |
| prop:minimal-bounded-complete | OVM.alpha_boundedlyComplete_of_unconditional verifies the manuscript's successive finite blocks, choice of measurable test sets and finite-subsums estimate. OVM.alpha_boundedlyComplete_of_not_contains_cZero discharges the series-convergence premise under the manuscript's original no-c₀ assumption by the formalized Bessaga–Pełczyński implication. |
| prop:ovm-normal and rem:ovm-normal-transfer | The exact compression formula Q_μ = S** Q_P T**, the normal part identity with B₁, and normal projection range are checked. The proof from bounded completeness of the minimal α-dilation to weak sequential completeness follows the localized-vector and comparison-map argument. The reflexivity equivalence under a localized dilation is also checked. Dilation.james proves all three equivalences with the stated localization assumption. |
| thm:dilation-geometry | The necessity implications are checked by Dilation.not_contains_lOne_of_shrinking_cyclic, Dilation.not_contains_cZero_of_boundedlyComplete_cyclic, and Dilation.reflexive_of_reflexive_space. The Rosenthal seed set, the final weak compactness step for the closed convex hull, and the analysis lift and compression equations are checked. The forward KB construction in part (2) is checked on the standard L¹(m) model. The Köthe interpolation construction in parts (1) and (3) remains open. |
| prop:vector-measure-dilation and cor:review-minimal-kb | The cited standard L¹(m) model is used for the map from the dense cyclic orbit. The comparison, the commuting diagram, the new cyclic dilation, the alpha norm estimates, the positive-cone comparison, and the KB equivalence are checked. |
| §4.2–4.4 | The vector-valued multiplication, multiplier-orbit, and local-variation dilation theorems remain open. |
| Section 5 | All results, including the Hardy-Toeplitz and cyclic Koopman examples, are covered by the audit. |
| Section 6 | The cyclic inductive-limit results, positive resolvent and compatible signed-measure quotients are verified. Consult ManuscriptCoverage.md for the ReLU Barron example. |
| Section 7 | All three examples and all five rows of the property table are checked. The proofs cover the L1 vector integration model, the Orlicz and Haar estimates, the coordinate and Bochner models, and the frame and lattice obstructions. |
| §1 | The first main theorem is checked in full. The second and third main theorems, intro:dilation and intro:frame, remain incomplete. |

## Proof choices to review

- The model for c₀ is mathlib's real-valued functions on the discrete natural numbers vanishing at infinity, with the supremum norm. The theorem containsCopy_iff_closed_range identifies bounded-below maps with closed isomorphic copies.
- The Bessaga–Pełczyński implication is proved by choosing disjoint finite subsums when unconditional convergence fails. Finite-dimensional compactness and Hahn–Banach give a subsequence with triangular norming functionals. The coefficient series defines the bounded-below operator on c₀.

- In the pointwise-limit step of lem:normal-restriction, the control measure is the normalized weighted sum of the coefficient variations. Its mass and domination properties are proved in Lean, and the named Vitali–Hahn–Saks axiom supplies countable additivity of the limit. The earlier Baire argument is available separately.
- For the support argument in lem:invariant-cyclic, the supremum is taken over all measurable cuts A for which P(A)u belongs to the subspace. This includes the finite unions of density supports used by the manuscript. The proof uses the same inverse multipliers and strong limits of the cuts.
- The topological part of prop:cyclic-inductive is proved from sequential continuity on the normed space. The proof captures any convergent sequence and its limit in one cyclic subspace.
- The main no-ℓ₁ proof applies Rosenthal to the coefficient operator from Trans.tex, then uses Schur, compactness, and uniformly small tails. The gliding-hump proof remains a separately named result. The Schur property, weak sequential completeness, and nonreflexivity of ℓ₁ are proved in Lean.
- The reverse implications in the grouped James theorems use exclusion of ℓ₁ and c₀, as in the manuscript.
- In prop:ovm-normal, restriction localization is applied on the generated subspace W before transporting the localized representatives via Q. This uses the checked closed-invariant restriction theorem and yields the same W-valued representatives used in the manuscript's proof.






PVM.cyclicInductive_vectorMeasure identifies the cyclic stages with their vector-measure L¹ models and checks the connecting maps and final topology. The positive resolvent theorem checks the geometric series and domination estimates in eq:resolvent-control.



The signed-measure quotient norm and the final seminorm topology in §6 are now verified. The positive majorant uses the cited AL-space operator modulus theorem.

See the updated manuscript coverage table for the interpolation, local density stage and frame formalization.

For prop:bochner-normal and rem:bochner-localization-dilation, the concrete a.e. quotient, indicator multiplication, exact integral representation, cyclic coverage, and localization equivalence are checked. The converse uses positive total mass.
The closed multiplier hull, all three cyclic dilation equivalences, both minimal multiplier-orbit criteria and the scalar minimal dilation example are covered by the kernel audit.
The local orbit-variation theorem, its operator-variation corollary and the Rademacher counterexample are covered by the kernel audit.
The operator variation measure, the discrete reflexive dilation with finite-rank coordinates, and the Radon–Nikodým property from cyclicity and σ-finite operator variation are covered by the audit.
The continuous Schauder frame representation theorem, including the normalized factors on the actual operator variation measure and their strong measurability when the dual is separable, is covered by the kernel audit.
The first frame counterexample is checked with its disjoint-sum realization, local orbit variation, reflexive cyclic dilation and failure of σ-finite operator variation.
The c₀ counterexample and the real associated-space equivalences, weighted sum, cyclic multiplication measure and counting-measure basis are covered by the audit. The Hardy–Toeplitz and cyclic Koopman examples complete the coverage of §5.

The concrete real sphere, antipodal pushforward, signed integral and Dirac atoms are implemented. The manuscript maps C, A and J satisfy C squared equals C, CJ = AC = 0 and AJ = I, and R = C + JA is an idempotent. ReLU synthesis is defined by the signed integral and the affine atomic representation SJ = ell is verified. The homogeneous synthesis difference is verified as the first-moment identity. Contractivity of C and the l1 bound for the affine atoms are verified. The ReLU synthesis identities S = SC + ell A and SR = S are verified. The equality of kernels is proved using the cited homogeneous kernel theorem. The even measure and affine coefficients are unique. The global affine quotient norm, exact localization error and sharp pointwise bound are proved. The linear right inverse is verified with the manuscript bound 1 + sqrt(4d+1). The canonical range is invariant under even cuts and the compressed values multiply by taking intersections. The compatibility and countable directedness of the concrete probability family are verified via the manuscript mixture with uniform atoms. The Banach quotient has the manuscript norm, and the normalized countably additive compression and its multiplication rule on symmetric cuts are verified. The displayed Radon-Nikodym coefficient formula is verified, including the reflection factor and each normalized atom. The concrete Lp stages have the sharp endpoint and interpolation bounds, cyclic dilations, reflexivity when p > 1, the Radon-Nikodym connecting maps, point evaluations, norm recovery, and the final seminorm topology. The global quotient by affine functions is isometric to the even measures supported away from the poles, and both cut diagrams commute. The homogeneous construction has the same synthesis identity and kernel characterization. The measurable model of the unoriented hyperplanes and the exact antipodal fibres are constructed. The local affine quotient is isometric onto the concrete Lp of the unoriented hyperplanes, with the Radon-Nikodym formula, the indicator cut and the integral error. The symmetric L1 realization has cyclic stages and the final topology. The localization probability is normalized variation. The homogeneous model is realized as a signed-measure Banach quotient with its canonical section, normalized compression and exact localization error in every positive input dimension. The L2 stages are reproducing kernel Hilbert spaces. The surface-measure example has an explicit two-point averaging multiplier, noncompactness on every set of positive surface measure, and no same-space continuous Schauder frame. The p = 2 counterexample has a Hilbert basis.
