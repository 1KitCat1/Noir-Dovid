use dep::std;
use dep::array_helpers;


fn main(tree_root: pub Field,
        message_hash: pub [u8; 32],
        signature: [u8; 64],
        tree_path: [Field; 1],
        tree_depth: Field,
        pub_key_x: [u8; 32],
        pub_key_y: [u8; 32],
        ) {

    // 1 - verify ECDSA signature
    std::ecdsa_secp256k1::verify_signature(pub_key_x, pub_key_y, signature, message_hash);
    // 
    let pub_key = array_helpers::u8_32_to_u8_64_unconstrained(pub_key_x, self.pub_key_y);
}

#[test]
fn test_main() {


}
