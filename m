Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328177;
	b=nOQO6vYDrZoXyFDxa04aMS36c6B4jJTfICTSxIwHfcczwah+1zDD/T2SgIUVYFhlFt/9
	 c90wMLLwMb4M7A7HSLOmsL7HK+fZmAYnJdVRGzMj/VW5nlUUok+dYFv62Myut8i2yFGdp
	 Fd5tooh3MoSLEVkkGC2a0BHO6/fYkZD2a7GY0jf9byQ5ZHOmUK2ig95u/kYg68jGZII/9
	 haXR/ivs2ViCu3oVsGYB1BxNNm6YSW2j+l4w0h7YF/yinIwIRRqg1/mdbCZovfHykSV0X
	 6MElVQboAqNl0go9V/TgwkAIs++uvxvgaB+3iu7geR+9e1Cdw7S7+yOJx+BT88jvzdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gpwg1YP2mQgmQICmCEtUBpduhAkgOFMLRku8rx9ELSc=;
	b=dsH0YJtua8aW3Huo8Kek4E+6r3ECvRq/rCUGNepOnMnm51oCv0jH3+0356/1ZLgkOIlC
	 8Vau9QKlLS0e3/0IsOIrEPvsnxhftodeKNE/ktS1CVehEfoCGPu254kjd5SvfwuOb6gwQ
	 5kQ6I2gi6Gtg+7WEL9XZvrswEopvqV2U/63tkzoWUHSPymJuyBIJom6KwC6ZTxK49Z+SU
	 xvMTTW/z0+E1teowhyOZMF826C1J0VEhUHl8CZv2szfyFOGfquXyzsI1RW/emOPEI09gB
	 nAoKQR7I0MZgl9ScP+SW5Cus4LniJ3brAG69EZfXpLVgq6aJzolkvdXF+xRMoI/jTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mg/iG5RZ";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A260A3802
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D5A260A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mg/iG5RZ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so18833585e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328176; x=1794932976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpwg1YP2mQgmQICmCEtUBpduhAkgOFMLRku8rx9ELSc=;
        b=mg/iG5RZ3k5L17FwDK4srbtZUnw82HRTLNQl9edXew0yLEVH0EhWVkHFlIFGtpoVHL
         9FOezbNtYtYNKSWjZ94Bd8riW0Jty3rXghj6DXWrsnB0OHmn6boWPobW0tSy1rPg7qKt
         wZRrYg9uO8F/gCiopOMgQTQz957O4o5PAyKk+wOy1nYIXvagM7LaKmoNf69EQKTX0g45
         gMf/HkVf/dr8/3hdQ7xyEQY/WutjmRznj97Ly0v/+0lC/BbkpJp4j39tfpMVG1szsIwN
         PxW4ynlU/g5RLBm8OAM4sM7lqPVADPZbBZa6tEp66wBt3XiHW1QvYhZL45/Pug5fbv35
         B2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328176; x=1794932976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpwg1YP2mQgmQICmCEtUBpduhAkgOFMLRku8rx9ELSc=;
        b=OjtbVm8MVLKszLVe3iEFXaVdQZ0++QtZmsHnq2e+EE9zGXq1eqO9w8HnK90LwwNjev
         +kAgKOfVFa5aqMiqMoZQIp7NryI7ef97JmtTw1et/Ffos6HtnDQvwBk7LXKa3JVZ6TlX
         aj7dReOTeDbKgbhkrz8aXOWMOkG6MK3xpR2D0hQiOIcllz1q5gkRtR2b6JHrwe73ddVR
         N/jxgk/xIZToqKU6aqptRByHtLhp1fEhvK+1ObMlxLkYWgKFBfvvQIAgQoVcbpnLqcZW
         WCh06E7kkgd/hfXoCIlKuDCycmPGfGqzyIvH4PaRp06mpxxtegG23dPktFWv/F1FFpfG
         eWog==
X-Forwarded-Encrypted: i=1; AL+hErFzi63c9s29Cd8xDBO4hU1KONPyZxquWIwzWRg1r5z5HZJmP7QFnJzJfEMoJy0q3Dy/eio=@vger.kernel.org
X-Gm-Message-State: APuU4Z85hkJ++QXc2nmb+wm0oLVZAtBM3zwk0G538hD5XPd/pYvX+57V
	HZ1ibkcQgoQXNIVHZWdT/BDJSncj8ihNX4kKAtZkp4Uqk/Gt5aRt4AXB
X-Gm-Gg: AYBFou2g1z6gpwz0p+sgqF/JNQ7FD6Y2Udv2t45s/385dLmNv+Kwhxqsu0waW+pp8vv
	0pea3t3fuGbtlc68rp+D83EVVvtaIKRG10CSnZHkeUrE8cXC5uZzSiWt8d8vFsCwqmyuLxwzEMo
	+6Fn6ySg2+SluZD9B8WlRVriLWUW2jM7eBhgEXaJNGSo09XgT5MAnKl4ujYf0evTwUNbFtrfWK6
	/EZq85n5cLVITrlACnQ8iEZjOCKuAN58TsNKQSaswkU1VDUpr0AvZuJtKjWlxSjDWAetWh+OtGh
	nH+07SgDEQ084fhZepOYKafv6lSHiqd/QmTQgFNzfj46OXaflLWcuY0pxyxVf4Lkqm2pVuXzJzw
	yk9w57fSVMIdGHkf7HchyzHgmBYwhNJgWvuy4BA4eKzk8hyo2pWMXPjRpVUxDKJy5kb3MqrsVpa
	2a8VJ6FJcM/62JV62/MieHzB74zGDKI9jmsSqWM/FWikoQFaVNWFp3ap4C6zv9h4fUEEQkxfYDy
	uW1OiIS+FQJNlwzd72mbROsxRcfBboiX3oSIlfCqXddnQ3YnzJs6vtZR9hR+jxRePZgyNhYHX7o
	ZsA+oNbjCKcsCFhYEqWSPuNXaAbSMlsN9/aCThxuRMhwy6k=
X-Received: by 2002:a05:600c:3b2a:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ba0230856cmr53465545e9.3.1794328175765;
        Tue, 10 Nov 2026 08:29:35 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:34 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 09/18] bpf: Find fmod_ret candidates in bpf_scan_ir
Date: Tue, 10 Nov 2026 16:40:29 +0000
Message-ID: <20261110164046.454431-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
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
 scripts/llvm-plugins/bpf_scan_ir.cpp | 122 ++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 4 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 6700896749d4..3684918eb7fa 100644
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
@@ -22,9 +28,119 @@ using namespace llvm;
 
 namespace {
 
+static constexpr int MaxErrno = 4095;
+
 /* The errors which clean paths of a function return */
 using ReturnValues = SmallVector<int64_t, 8>;
 
+/* Return true and set N if C is an errno */
+static bool isErrno(const APInt &C, int64_t &N)
+{
+	if (C.getBitWidth() != 32 && C.getBitWidth() != 64)
+		return false;
+	N = C.getSExtValue();
+	return N >= -MaxErrno && N < 0;
+}
+
+/* Return true and set N if V is an errno constant */
+static bool errnoConstant(const Value *V, int64_t &N)
+{
+	auto *C = dyn_cast<ConstantInt>(V);
+
+	return C && isErrno(C->getValue(), N);
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
@@ -86,10 +202,8 @@ public:
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

