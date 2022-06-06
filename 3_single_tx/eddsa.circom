pragma circom 2.0.3;
include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/eddsaposeidon.circom";

template VerifyEdDSAPoseidon(k) {
    signal input from_x;
    signal input from_y;
    signal input R8x;
    signal input R8y;
    signal input S;
    signal input leaf[k];
    
    component hasher = Poseidon(k);
    for (var i=0; i<k; i++) {
        hasher.inputs[i] <== leaf[i];
    }
    
    component verifier = EdDSAPoseidonVerifier();
    verifier.S <== S;
    verifier.R8x <== R8x;
    verifier.R8y <== R8y;
    verifier.enabled <== 0;
    verifier.Ax <== from_x;
    verifier.Ay <== from_y;
    
    verifier.M <== hasher.out;

}
