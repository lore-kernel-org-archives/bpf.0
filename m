Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243298;
	b=ek3Hg8fIioETMHL98cKtEmuffM5wb01vONcSsOoWylaDoeX/3UFHxyza3iP8jzvuWmU7
	 cd7tZS5/4qWVRdZH4bYII6t7qhp4DD5m72nDSCKj+OxscrWkaMC7g4VTF6JM3PhB27o+O
	 eqWdK3QOKbAGOBIiAfErDqwXl00Oqonbb2lioxvP+ftyE2bbeEn94uaNGrtuz7ypLaei3
	 /qbsxgE4iFX9apGf+pxOGIXiWtUgdvykSt6b8exrc2vdtOhTsI3TOIqaht/vg274lgcsG
	 b3T4NbRh0AicerLok6esgvAkUJsnohzJdoAHbkDCR2zUiQuopJ3rNfYxVwkT5BAa6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ilvmL95xJlpNSKLk5utHXZ1bIs/yE6trPAs8lvP1p2U=;
	b=oSc2wNzA14uccJpgdGp7c2jNfq7Lqu8nB4zmFaKWZ+dTTpiCEaYyFGJ2X5ESIOeAOAVm
	 fY48dLkB4f/GuyFKjkQZCSs65uE72+9MxPn3fQ8ev/3YG41zV6Mz8Dam16rvlo6R2iZMp
	 pwS8T+bpkSAnTseQWT/VVH8m6LmkNpb992737CV//0DwebPYSGROYc2IcT28WDnaK43va
	 1dWCLphkrO2F34fkUjhpdOKEL/m+hLXkgSB82Od9tssV2faBB7lO2PktMYeHlLEUWMMg+
	 oEgu38P7eRSFL4vqx4oOKomO/fVwfS5BlvCK4w77315szlfM7p/oHoyjrqSJ6YPf5DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLEpFTx8;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC260A6F78
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FC260A6F78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLEpFTx8
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso575852f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243296; x=1794848096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilvmL95xJlpNSKLk5utHXZ1bIs/yE6trPAs8lvP1p2U=;
        b=wLEpFTx8Q7bDBbLEqKvn6LXr1ciTiCO9eaB/5CyiWkOI/4qthAM7bvwvYaT4FDXltq
         qGo8P/D2hcSG9ZZWLJS3VJhibPT+AQSTipfDZSrKhwRv0aJqCAgMUCUcrmALpbURDJrD
         0lS8w1YOdMtV/MRrZ3YrQUhbZYeMYP/hmQDQzoQrGKu4fRnJNCMZ1jdhypzq+rIGYvze
         f2WNn7IVEPVeWLIqEj5/ygoQQ0vy/aydkb3TzFTGYR/y7pohBg+t3lO1Tcky5MzZdYJb
         HBb7ifPVevhFJRWBjzsKMMReD92H2a/W2X7GNhQI0UQe543KLFz1ZR/Ww6Yndt3h6qlP
         Y7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243296; x=1794848096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilvmL95xJlpNSKLk5utHXZ1bIs/yE6trPAs8lvP1p2U=;
        b=L2ihY19cvB5mEQs/9CQULuazhP/y5u1XYhcqns5Fgup594U7urh9gncXf4ADJVK+Wi
         pyAd4naWuf9QSp5T7XQF6L1U3hYalowIKnowfqcuf1ma0yGuHhb/Yppoq5XgtRLeveMh
         NwA6kI4VezaFU60VrXBDyXEznz06dty2UF+USQ/piUVWNKLGOZ5WaQp+/CH0l0Z0I5zO
         BWwOlPjbBi1fNgCDc1T7WwuDauEreqCQ4sUAXTM7K8wB3gZRaKvn2Hb20BDYiYw2cpjb
         HwWKj9iApd7dI0C7za2I8Wwy3p8j5wWdgVkf3lmwg1yKKlme8GYm8Og3pNCn2hzidy5S
         S4gg==
X-Forwarded-Encrypted: i=1; AL+hErEKyw/dG2be7awaLvzs+z1PpMIHJDDDpGYtS5k9ZWLvg/w9t7tfnUVUdb4PmU8lTZAZSxk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ABLvPoRjToBIJH3uwYhx/5a8Ya9L5jBcAoHQ6w91MhYHvSZq8
	oSmg6wlfT95t6UpZSzyu3zNsSrrKaB+Q1/ICwhqx5/TBF2lb3bSvOaYi
X-Gm-Gg: AYBFou0YzuZtQk7exdOel2mSI/S3JNOVkjBSr1c39pvQjyTxtbm0jpBskYyNGVAcSna
	QJYuBWmK3R9Dr3d81xf6bKcy/5CgCvYxLn/c/a2b1zTqXqRfYaXirETVBiIiYR8NgQtsHruf/B+
	LdNmDF2M8uyBskwZpzKKn8pQFMiMObHQp0ylsbAy1CWmH33caWI3KoGLy+aw1x+Lz2xniQL9fFG
	fueorWZ3Pd/hn9LtEPya14gG4dUka+lrWH43MxtnAcK3u3hB+qgnTyB1DkWBEVDjAMRtCPQtPBB
	RzAZLCyQCj5IWacBIBBGRoin+BaG8hzsoneC1aL62Y1CUkAI3ZxQPIQAMSjO1pKP1b6sjXxfN/u
	dj5c+6mfvpX4WW0HxJkNvN6LV/tb5O4kLPiYmKtKvRvYME5Aq9wRkMBcY5LN0ITHCWOEvYbWEQK
	ufd1A3yNeU9UcdgXy9LZpN4cmrItBMKtOc9R9rogAoTykUCqRZ0KieXqJ7ES5uJ9xLkfWxYVDZ2
	aLgVtWp8KldKiPbt5H0GoFBNSOqhohQg1PzlY6FE7MZHr/+MkL5ApYHVFnsQnoNzc0wYWru0I59
	0fal2gVyp7fdc+sORESp0tWUQy74mHIx7sVRPb7pyLpXAaU=
X-Received: by 2002:a5d:64e4:0:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-4982f77eee1mr88084f8f.13.1794243296305;
        Mon, 09 Nov 2026 08:54:56 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:54 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 09/18] bpf: Find fmod_ret candidates in bpf_scan_ir
Date: Mon,  9 Nov 2026 17:05:29 +0000
Message-ID: <20261109170550.141443-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

