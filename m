Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998333;
	b=X9vGJq8m4JD/1yRLxgZES7xL4lPycTOMogW0wsEavsSYrEnfUWrZQIha0HOAZyT9rFvU
	 G9fRPks3sbKBMLgdrVe1b1Fsd7sCF6+gBFX6Kst11HL/kQ9cv6ZywZ7QyUNQfJ67zqRli
	 rwCLhbNelTTMl+Cv1LHOXxPrn0TUWvfoOp5eUZKwPOdKOvmwNGXMemHwtvkCIZJ4mzPEO
	 8LM4W7zW1LSzzhj5cMPWDhv50hHOyU/kwVRmMqWp1zsrElmelld5nsMOPbZtXUcKYX2Ag
	 +Z5wDNKg2py3O+c0qfZowWJX1wZYmV1dTnUO1WxP8aq3Gw1B0iXtH/Uyb528OvYwlpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ilvmL95xJlpNSKLk5utHXZ1bIs/yE6trPAs8lvP1p2U=;
	b=4cgPuOQFlOL3hAFHQvzH1bHBuIBc9mReSpB2znp6kdQ704FGxFtg2fv3Fwffvyhsesvy
	 9sdz9rrNwYnS2TOHZGWn/IBQrbgoNbDnFbftEPzfo5+74G85RzV1piRrF0ZgQLN9NKhSI
	 dK9Sq5IIKdrnvu8AzehrOp4snQguFsW0bA/j8fyWGuZ7N47gXkFM2hYl+YH64kW4Jbrjv
	 TuXS7SattMBBGPP9rt4ikEwYHuf7HOFE/jxlVgTRyKRlsi1etH4LSY5VSplWeiwYHEjpB
	 2tOXO0fYsv0HzwapvQl2GWCH+FKo5ns3dVlj8k2DtVRsHOB7nZp1UGEbJTjeAMCPVlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xVAN/nCI";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2288606D81C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2288606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xVAN/nCI
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso9874745e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998331; x=1794603131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilvmL95xJlpNSKLk5utHXZ1bIs/yE6trPAs8lvP1p2U=;
        b=xVAN/nCIKdYJ2+3aL27TP7qAv7zJYln2Xp0lPkZedNJ3738+fmw+kJPXLtyAM8wnI/
         x83SyUbh62/Rh10qNa5QI3lxpigATb99Z7Rw1iUIZzssG7DW7PO3AlFXjECBskWtW/ub
         jACrGrQQ2YTSUAueo98NI1SUSINSbxN3Fyb1cNI4uK5g+4OS10gtOBwAcgR70W3M35lL
         1qGVjZtaLM1cpQnFL8KWQTg3KX4Brx5d4VZzRyGEmcgVhN/Q+bzuP/jXNz0MTsvoYcPe
         bi5NaF8LNI22+X2HkHCdcnpZpHjEuESN3hnfBJZ1EHqG2KCXjnBOMtrzl6Dcau/C4OhT
         0sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998331; x=1794603131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilvmL95xJlpNSKLk5utHXZ1bIs/yE6trPAs8lvP1p2U=;
        b=vrldOtc8eqhElQbP2Z0JSirXUYDXUC8HYl2JlT0pfyjsEtsmDvhFl2bc6L19qjLv1C
         v8RJ1UKuprou5+71GG4/WAy+FBLAzJ3l/d0CpG4xIBBHk4CVGvL7IJ8HRm3LtcXHFPyo
         a5lTNP4URjj11xfrd8Pw6Tnmacb4SyaOtuD7lusKW9D1Yfdx0WO94GGE0twqQRkeQhkH
         Rl2sTIeqI3sFkvc6B5Gl8K+0QT9zqucvPSAVGBJMJLHLLQUNNo7jJOoSG53k/NW4W/hj
         7aiM5ItPAeQUMnrignfIZKVSq+j1cSlui3F0oFVkVv0iqd6txf8P/JCgL1Jot4yuvSx1
         gDmg==
X-Forwarded-Encrypted: i=1; AKwUvBwZVWAR2bdjw5BLzqs1AZEO+IztgcA0RCAujXQ8NE9CN8bzkXxNL4gHcEmAb0OkkjqTLcs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nGeLWYnuA/vd2xn4sB32xxxPB8YnOolMySzeDrYRBo4m5C1QI
	1DBu1d/3l2dtQIMTXxM4Mg9ljKtjljiC9195WRa19oOC0S0uSnuoxI2U
X-Gm-Gg: AYBFou0r7rsOwwRetp4mDzu6IFpgLiGjN20ppZN9qZB8iipjITx0Q3IQkng1TljakfI
	AR+ypjQ1XPs6hWbp+sTGK67Z86kY9Wi1jgNv4G0dR0K7pyj79xGGTUxQF0KCG4HbUQSBGbqTqgj
	Xk1L7eG6qd+jYgzIyaN4itMAG1BaUnkwbK2qr5UxTrYvvclNftUrXTs9IChsmy+O56rGAUHdiSO
	ibMFFKw3arfzHCxbs94Wl6L1p5+QSfz5orgR3d28v/Q4HeO2O9dDP/tgD/2HNvJEykaYeIEPMUI
	0pGerfDKhOOFTA7rsjl7CLmHGDq6AgIU4k8TVqQwYYtdpLAwhZO9JaiiXOtUokU8vOW6lTLK1jO
	gh3BOejmovgZUXNLlZgeb5/EFg1UonJrJ+jm/s3/h9B11gjjhZWnSczR3KWqf2r0ove9d+h8WC0
	AEUpghJ3E/8jOkocM63/xaYCJVtwXWk+bwimSMgEQHFaadVfrw1NEEjR9fKfA2zsEwMAh66PB/N
	z8FDlo5fwd3sAbcOoVpkEl4LAckE+S9S/kOtqoxWbJeS4mW04+jZG2HXSI6Kn0Z/NIic0kWag6Z
	NxuXm3o3B1GPuDJ9wcx/b/ALwTTO9GwL61SShy/8KyTwg5A=
X-Received: by 2002:a05:600c:4e14:b0:4a9:18f4:925e with SMTP id 5b1f17b1804b1-4b6df8c9443mr62643145e9.18.1793998331176;
        Fri, 06 Nov 2026 12:52:11 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:10 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 09/18] bpf: Find fmod_ret candidates in bpf_scan_ir
Date: Fri,  6 Nov 2026 21:02:58 +0000
Message-ID: <20261106210314.1767267-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Find the functions which can become fmod_ret targets: functions which
return a 32 or 64 bit integer and have a path from the entry without
observable side effects (a clean path) which returns an error. A
fmod_ret program which returns this error instead of calling the
function then behaves like the path. List the errors in the record of
the function, sorted and unique.

Take only the blocks which no dirty path reaches: after a dirty path
joins a clean one, a branch may depend on what the dirty path did. Only
the block of the return may also be reached by dirty paths, as it
returns the same constant on all paths.

For now an error must be a constant returned by a clean path. The
following changes find more of the errors.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/llvm-plugins/bpf_scan_ir.cpp | 117 ++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 4 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 6700896749d4..6828fa73717d 100644
--- a/scripts/llvm-plugins/bpf_scan_ir.cpp
+++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
@@ -3,11 +3,17 @@
 
 #include "../bpf/fmodret_metadata.h"
 
+#include <algorithm>
+#include "llvm/ADT/SmallPtrSet.h"
 #include "llvm/ADT/SmallVector.h"
 #include "llvm/Config/llvm-config.h"
 #include "llvm/IR/Analysis.h"
+#include "llvm/IR/BasicBlock.h"
+#include "llvm/IR/CFG.h"
 #include "llvm/IR/Constants.h"
 #include "llvm/IR/GlobalVariable.h"
+#include "llvm/IR/Instructions.h"
+#include "llvm/IR/IntrinsicInst.h"
 #include "llvm/IR/Module.h"
 #include "llvm/IR/PassManager.h"
 #include "llvm/Passes/PassBuilder.h"
@@ -22,9 +28,114 @@ using namespace llvm;
 
 namespace {
 
+static constexpr int MaxErrno = 4095;
+
 /* The errors which clean paths of a function return */
 using ReturnValues = SmallVector<int64_t, 8>;
 
+/* Return true and set N if V is an errno constant */
+static bool errnoConstant(const Value *V, int64_t &N)
+{
+	auto *C = dyn_cast<ConstantInt>(V);
+
+	if (!C || (C->getBitWidth() != 32 && C->getBitWidth() != 64))
+		return false;
+
+	N = C->getSExtValue();
+	return N >= -MaxErrno && N < 0;
+}
+
+static bool cleanInstruction(const Instruction &I)
+{
+	if (auto *Intrinsic = dyn_cast<IntrinsicInst>(&I)) {
+		switch (Intrinsic->getIntrinsicID()) {
+		case Intrinsic::assume:
+		case Intrinsic::lifetime_start:
+		case Intrinsic::lifetime_end:
+		case Intrinsic::invariant_start:
+		case Intrinsic::invariant_end:
+			return true;
+		default:
+			break;
+		}
+	}
+	return !I.mayHaveSideEffects();
+}
+
+static bool cleanBB(BasicBlock *BB)
+{
+	for (Instruction &I : *BB) {
+		if (!cleanInstruction(I))
+			return false;
+	}
+	return true;
+}
+
+/* Add the errors which clean paths of F are known to return to VALUES */
+static void cleanReturnValues(Function &F, ReturnValues &Values)
+{
+	SmallPtrSet<BasicBlock *, 32> CleanBBs;
+	SmallVector<BasicBlock *, 32> Worklist;
+	bool Changed;
+
+	/* The clean blocks which the entry reaches through clean blocks */
+	if (cleanBB(&F.getEntryBlock())) {
+		CleanBBs.insert(&F.getEntryBlock());
+		Worklist.push_back(&F.getEntryBlock());
+	}
+	while (!Worklist.empty()) {
+		BasicBlock *BB = Worklist.pop_back_val();
+
+		for (BasicBlock *Successor : successors(BB)) {
+			if (!CleanBBs.contains(Successor) && cleanBB(Successor)) {
+				CleanBBs.insert(Successor);
+				Worklist.push_back(Successor);
+			}
+		}
+	}
+
+	/*
+	 * Keep the blocks which only clean paths reach: after a dirty path joins
+	 * a clean one, a branch may depend on what the dirty path did
+	 */
+	do {
+		Changed = false;
+		for (BasicBlock &BB : F) {
+			if (!CleanBBs.contains(&BB))
+				continue;
+			for (BasicBlock *Pred : predecessors(&BB)) {
+				if (!CleanBBs.contains(Pred)) {
+					CleanBBs.erase(&BB);
+					Changed = true;
+					break;
+				}
+			}
+		}
+	} while (Changed);
+
+	/*
+	 * The returns of the clean blocks which only clean paths reach or which
+	 * one of them branches to. Dirty paths may also reach the latter, but
+	 * the returned constant is the same on all paths.
+	 */
+	for (BasicBlock &BB : F) {
+		auto *Return = dyn_cast<ReturnInst>(BB.getTerminator());
+		bool Entered = CleanBBs.contains(&BB);
+		int64_t N;
+
+		if (!Return || !Return->getReturnValue() || !cleanBB(&BB))
+			continue;
+		for (BasicBlock *Pred : predecessors(&BB))
+			Entered |= CleanBBs.contains(Pred);
+		if (!Entered)
+			continue;
+		if (errnoConstant(Return->getReturnValue(), N))
+			Values.push_back(N);
+	}
+	llvm::sort(Values);
+	Values.erase(std::unique(Values.begin(), Values.end()), Values.end());
+}
+
 struct FunctionDescription {
 	Function *Fn;
 	unsigned Flags;
@@ -86,10 +197,8 @@ public:
 				Flags |= FMODRET_FN_WEAK;
 			if (Ret->isIntegerTy(64))
 				Flags |= FMODRET_FN_RET64;
-			/*
-			 * Nothing finds the values yet. A weak definition always
-			 * has a record, see fmodret_metadata.h.
-			 */
+			cleanReturnValues(F, Values);
+			/* A weak definition always has a record, see fmodret_metadata.h */
 			if (!Values.empty() || (Flags & FMODRET_FN_WEAK))
 				Descriptions.push_back({&F, Flags, std::move(Values)});
 		}
-- 
2.43.0

