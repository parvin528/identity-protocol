
// SPDX-License-Identifier: GPL-3.0
/*
    Copyright (c) 2021 0KIMS association.
    Copyright (c) [2024] Galxe.com.

    Modifications to this file are part of the Galxe Identity Protocol SDK,
    which is built using the snarkJS template and is subject to the GNU
    General Public License v3.0.

    snarkJS is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.8.4 <0.9.0;

contract BabyZKGroth16PassportV2d1Verifier {
    error AliasedPublicSignal();

    // Scalar field size
    uint256 constant r   = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 20491192805390485299153009773594534940189261866228447918068658471970481763042;
    uint256 constant alphay  = 9383485363053290200918347156157836566562967994039712273449902621266178545958;
    uint256 constant betax1  = 4252822878758300859123897981450591353533073413197771768651442665752259397132;
    uint256 constant betax2  = 6375614351688725206403948262868962793625744043794305715222011528459656738731;
    uint256 constant betay1  = 21847035105528745403288232691147584728191162732299865338377159692350059136679;
    uint256 constant betay2  = 10505242626370262277552901082094356697409835680220590971873171140371331206856;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 9280329792410452628667551971683307699832276658013591669562603485020396646379;
    uint256 constant deltax2 = 5476252263775978491109238702761942378840336719097803853308358084600788265573;
    uint256 constant deltay1 = 1049823121351203186697116303682849236698288723417545162833437089156180070194;
    uint256 constant deltay2 = 2572716513168397039596988940746176493933557812606561849262833809230995050198;

    uint256 constant IC0x = 10578711943266559635098211269460134233401212006183841219853255316186908579104;
    uint256 constant IC0y = 17522845434119338034857163978884272419815936817443028885809841495053191619673;
    uint256 constant IC1x = 1565430668383666858738271842510312608467637113109968922530854343593050571703;
    uint256 constant IC1y = 11308854158791385922245378858065852236931771072403613306569347467697653656426;
    uint256 constant IC2x = 17761218739377060795616707677317356125039649279354532367642680430253175663425;
    uint256 constant IC2y = 6448582875465317463955575480494033430205306650303195604218639581551830754698;
    uint256 constant IC3x = 4863599656401292851465218693699847957267453377406618214401921776685431430812;
    uint256 constant IC3y = 4748790611975193218382200974408953108333543170904831697911876086057929736010;
    uint256 constant IC4x = 20385681622447582706889807292171691276292397456000318198652638760331068083309;
    uint256 constant IC4y = 5703358349254070982499284326055993845088816894496057145276557373988477667008;
    uint256 constant IC5x = 7126371939191688466035898614612544233801225582752311074768152693644594113666;
    uint256 constant IC5y = 4115799354545620746606970040725104585766462365957728033308854170283490252464;
    uint256 constant IC6x = 16443156542959376660790453016727394266163280033109728575379218011030317840827;
    uint256 constant IC6y = 2012192411979934108417787479198644193093272840297478940961946905087849666707;
    uint256 constant IC7x = 4140471094811097546805351278158435547932456585727595117195857430999298026559;
    uint256 constant IC7y = 8153808831184656343123240858582856275548959473309871300088280139401629132592;
    uint256 constant IC8x = 17401337949700440306863192678735500363664653526378006840095399695408045689686;
    uint256 constant IC8y = 9519918629208612206105305233603397317866424327456501935637785574643681242867;
    uint256 constant IC9x = 8933593784446704062963356283292375947874243217214462093654604864512459143669;
    uint256 constant IC9y = 14108541309253931485234046663604367451299184330815267491805755134814852436503;
    uint256 constant IC10x = 425844214426634884312607640003997099223844925030627223129120616989223963085;
    uint256 constant IC10y = 3393302724082115920267346749509025814615957141107661300131029990056697654585;
    uint256 constant IC11x = 7850667988706317184079731817676202082812517831411175559211583973864116089422;
    uint256 constant IC11y = 9632004603087683419956964377713880731794216511566959689481414637718339946501;
    uint256 constant IC12x = 9759040425629973092860318566760292961267270894151756112965119673278414682865;
    uint256 constant IC12y = 16698096977740358563681942125624300073294759786290393423557341572684464746896;
    uint256 constant IC13x = 10754949615911130471646076990931823025969795266794962838531694379754045756854;
    uint256 constant IC13y = 12064332090824044929200312838129906569966413479518240239077300122213148721203;
    uint256 constant IC14x = 1520754567596508780764594767626592010530309635631709629406737330982961427631;
    uint256 constant IC14y = 5076713651971407963349038367855454098406549064151821137526192958975923522347;
    uint256 constant IC15x = 13567657410574157108907017241104744905240254412028411498401619154139284955443;
    uint256 constant IC15y = 21000685021621042575685932067041629531616450450277391208966170504362965484562;
    uint256 constant IC16x = 17713483156554757544017451187279896820055215690751253866969813553058462803706;
    uint256 constant IC16y = 17609076963164851723356579948085720804194006414529539313556609708429203367641;
    uint256 constant IC17x = 14907999332821260777746752153023085045724272348913222203021590237791368761605;
    uint256 constant IC17y = 13653945638276935008174995044503659231398780917006595316077217244400745737440;
    uint256 constant IC18x = 19281586163003092835473230700489500791341931501689178282723594718784157998394;
    uint256 constant IC18y = 13985708121217733698160198257334330331778083464655178451603346449703574461219;
    uint256 constant IC19x = 6128661271340512645415897311995389552254630134648643826379564884288728531578;
    uint256 constant IC19y = 5689120391943316410301210939389979007005628954194851019164043654279455675763;
    uint256 constant IC20x = 11015739321107026415828850027421826654096369683456757245256180851634864929179;
    uint256 constant IC20y = 393335817409021824698050952019378331142582258722820676377085595810333459862;
    uint256 constant IC21x = 3470292436654646547016546247549594396086290389924354201573943220034871430339;
    uint256 constant IC21y = 7254943137647236827289263844883617667243963852465591829566578379634773119649;
    uint256 constant IC22x = 9610406220294723045662316863468591333202744759520312938778738491224024312714;
    uint256 constant IC22y = 2217158203481702516812547568017018417526134431394602598992111035771572954533;
    uint256 constant IC23x = 15237725780706514935201388225722484437281437183908424140452914928468761642195;
    uint256 constant IC23y = 10216501387618515804781093502182326444021154174736455156415971129404288738638;
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    uint16 constant proofLength = 8;
    uint32 constant pubSignalLength = 23;

    /// @dev returns the verification keys in the order that the verifier expects them:
    /// alpha, beta, gamma, delta, ICs..
    function getVerificationKeys() public pure returns (uint[] memory) {
        uint[] memory vks = new uint[](16 + pubSignalLength * 2);
        vks[0] = 20491192805390485299153009773594534940189261866228447918068658471970481763042;
        vks[1] = 9383485363053290200918347156157836566562967994039712273449902621266178545958;
        vks[2] = 4252822878758300859123897981450591353533073413197771768651442665752259397132;
        vks[3] = 6375614351688725206403948262868962793625744043794305715222011528459656738731;
        vks[4] = 21847035105528745403288232691147584728191162732299865338377159692350059136679;
        vks[5] = 10505242626370262277552901082094356697409835680220590971873171140371331206856;
        vks[6] = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
        vks[7] = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
        vks[8] = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
        vks[9] = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
        vks[10] = 9280329792410452628667551971683307699832276658013591669562603485020396646379;
        vks[11] = 5476252263775978491109238702761942378840336719097803853308358084600788265573;
        vks[12] = 1049823121351203186697116303682849236698288723417545162833437089156180070194;
        vks[13] = 2572716513168397039596988940746176493933557812606561849262833809230995050198;
        vks[14] = 10578711943266559635098211269460134233401212006183841219853255316186908579104;
        vks[15] = 17522845434119338034857163978884272419815936817443028885809841495053191619673;
        vks[16] = 1565430668383666858738271842510312608467637113109968922530854343593050571703;
        vks[17] = 11308854158791385922245378858065852236931771072403613306569347467697653656426;
        vks[18] = 17761218739377060795616707677317356125039649279354532367642680430253175663425;
        vks[19] = 6448582875465317463955575480494033430205306650303195604218639581551830754698;
        vks[20] = 4863599656401292851465218693699847957267453377406618214401921776685431430812;
        vks[21] = 4748790611975193218382200974408953108333543170904831697911876086057929736010;
        vks[22] = 20385681622447582706889807292171691276292397456000318198652638760331068083309;
        vks[23] = 5703358349254070982499284326055993845088816894496057145276557373988477667008;
        vks[24] = 7126371939191688466035898614612544233801225582752311074768152693644594113666;
        vks[25] = 4115799354545620746606970040725104585766462365957728033308854170283490252464;
        vks[26] = 16443156542959376660790453016727394266163280033109728575379218011030317840827;
        vks[27] = 2012192411979934108417787479198644193093272840297478940961946905087849666707;
        vks[28] = 4140471094811097546805351278158435547932456585727595117195857430999298026559;
        vks[29] = 8153808831184656343123240858582856275548959473309871300088280139401629132592;
        vks[30] = 17401337949700440306863192678735500363664653526378006840095399695408045689686;
        vks[31] = 9519918629208612206105305233603397317866424327456501935637785574643681242867;
        vks[32] = 8933593784446704062963356283292375947874243217214462093654604864512459143669;
        vks[33] = 14108541309253931485234046663604367451299184330815267491805755134814852436503;
        vks[34] = 425844214426634884312607640003997099223844925030627223129120616989223963085;
        vks[35] = 3393302724082115920267346749509025814615957141107661300131029990056697654585;
        vks[36] = 7850667988706317184079731817676202082812517831411175559211583973864116089422;
        vks[37] = 9632004603087683419956964377713880731794216511566959689481414637718339946501;
        vks[38] = 9759040425629973092860318566760292961267270894151756112965119673278414682865;
        vks[39] = 16698096977740358563681942125624300073294759786290393423557341572684464746896;
        vks[40] = 10754949615911130471646076990931823025969795266794962838531694379754045756854;
        vks[41] = 12064332090824044929200312838129906569966413479518240239077300122213148721203;
        vks[42] = 1520754567596508780764594767626592010530309635631709629406737330982961427631;
        vks[43] = 5076713651971407963349038367855454098406549064151821137526192958975923522347;
        vks[44] = 13567657410574157108907017241104744905240254412028411498401619154139284955443;
        vks[45] = 21000685021621042575685932067041629531616450450277391208966170504362965484562;
        vks[46] = 17713483156554757544017451187279896820055215690751253866969813553058462803706;
        vks[47] = 17609076963164851723356579948085720804194006414529539313556609708429203367641;
        vks[48] = 14907999332821260777746752153023085045724272348913222203021590237791368761605;
        vks[49] = 13653945638276935008174995044503659231398780917006595316077217244400745737440;
        vks[50] = 19281586163003092835473230700489500791341931501689178282723594718784157998394;
        vks[51] = 13985708121217733698160198257334330331778083464655178451603346449703574461219;
        vks[52] = 6128661271340512645415897311995389552254630134648643826379564884288728531578;
        vks[53] = 5689120391943316410301210939389979007005628954194851019164043654279455675763;
        vks[54] = 11015739321107026415828850027421826654096369683456757245256180851634864929179;
        vks[55] = 393335817409021824698050952019378331142582258722820676377085595810333459862;
        vks[56] = 3470292436654646547016546247549594396086290389924354201573943220034871430339;
        vks[57] = 7254943137647236827289263844883617667243963852465591829566578379634773119649;
        vks[58] = 9610406220294723045662316863468591333202744759520312938778738491224024312714;
        vks[59] = 2217158203481702516812547568017018417526134431394602598992111035771572954533;
        vks[60] = 15237725780706514935201388225722484437281437183908424140452914928468761642195;
        vks[61] = 10216501387618515804781093502182326444021154174736455156415971129404288738638;
        return vks;
    }

    /// @dev return true if the public signal is aliased
    function isAliased(uint[] calldata _pubSignals) public pure returns (bool) {
        // Alias check
        if (_pubSignals[0] >= 1461501637330902918203684832716283019655932542976) { return true; }
        if (_pubSignals[1] >= 1461501637330902918203684832716283019655932542976) { return true; }
        if (_pubSignals[2] >= 21888242871839275222246405745257275088548364400416034343698204186575808495617) { return true; }
        if (_pubSignals[3] >= 1461501637330902918203684832716283019655932542976) { return true; }
        if (_pubSignals[4] >= 452312848583266388373324160190187140051835877600158453279131187530910662656) { return true; }
        if (_pubSignals[5] >= 18446744073709551616) { return true; }
        if (_pubSignals[6] >= 21888242871839275222246405745257275088548364400416034343698204186575808495617) { return true; }
        if (_pubSignals[7] >= 904625697166532776746648320380374280103671755200316906558262375061821325312) { return true; }
        if (_pubSignals[8] >= 18446744073709551616) { return true; }
        if (_pubSignals[9] >= 18446744073709551616) { return true; }
        if (_pubSignals[10] >= 512) { return true; }
        if (_pubSignals[11] >= 131072) { return true; }
        if (_pubSignals[12] >= 512) { return true; }
        if (_pubSignals[13] >= 18446744073709551616) { return true; }
        if (_pubSignals[14] >= 18446744073709551616) { return true; }
        if (_pubSignals[15] >= 18446744073709551616) { return true; }
        if (_pubSignals[16] >= 18446744073709551616) { return true; }
        if (_pubSignals[17] >= 18446744073709551616) { return true; }
        if (_pubSignals[18] >= 18446744073709551616) { return true; }
        if (_pubSignals[19] >= 18446744073709551616) { return true; }
        if (_pubSignals[20] >= 18446744073709551616) { return true; }
        if (_pubSignals[21] >= 256) { return true; }
        if (_pubSignals[22] >= 256) { return true; }
        return false;
    }

    function verifyProof(uint[] calldata _proofs, uint[] calldata _pubSignals) public view returns (bool) {
        // Check Argument
        require(_proofs.length == proofLength, "Invalid proof");
        require(_pubSignals.length == pubSignalLength, "Invalid public signal");
        if (isAliased(_pubSignals)) { return false; }
        assembly {
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination it.vkey.vk_x
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))
                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))
                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))
                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))
                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))
                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))
                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))
                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))
                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))
                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))
                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // it.vkey.vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))

                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)

                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate all evaluations
            let isValid := checkPairing(_proofs.offset, add(_proofs.offset, 64), add(_proofs.offset, 192), _pubSignals.offset, pMem)

            mstore(0, isValid)
            return(0, 0x20)
        }
    }
}
