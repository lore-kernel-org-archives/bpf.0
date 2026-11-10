Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328179;
	b=QxhsSKISJgOWKswcQlPVe9pUyZ0i0tatPverSA1VUEj8X/CA+ozSmZQtNQHQ+WxvTG71
	 ICtHEYEgrkLhDiYtZvxYBlz2ct0qh1wl1i1qflrZqQ07CZ/MT1LBYGvxGzBWJNoWJ3wKh
	 VlTm/EXG9sHXAfAIF71vrtu+zcQ0cQTIaiG9n+GEeIOarpXESDZoYyjjCN0qsFnVaYxhr
	 9uSYq90QSO6GbxtKv9YGE/qENTvJBcGHAEvuyYQDaZi6xGS0QXxV86JogCE5UnyTZe82b
	 7tT2LOMNqX/UY/TC40AKGhNOEOLQ5l2XDSRnQHsEUuqdKkGUnmftIvtCtEzHmHliBBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=slpIs/HinfX8orW6FfIUeyL7Jch9yZ8MPXuFx7Rx4z4=;
	b=yVOA/fZLvy9JAcmX6GO5UFl6bRAW+lNG5Tuqj5yFKW9OJGFVlmAXJNve0QlR/rphyFt7
	 /4id7w+rBZm4ZVvHkZPMEZyqlSvGaoYyo2Werg/GAculaA76j+lVXVAOUQxEzH1CNT/gp
	 pJYBlB9QR9JAsPSAO4Z/cT70FRnFmdq5DDLN2WPxkuJjpbTOMfQs36SqE8xCwsHzfrPxX
	 l1enh893dddhsQ7WOXBtMEjQKteAlJ4rWQfT6gzd280aXgGvSQuv/saOkDsWbybPLQxw2
	 MPbbELVXEh2aaSrXtoiOfx6dq4pmL6sa2XhNs/Y+fRSDdKUUpUNRYdfwtduYXg5u9Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8z5h8Ww;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060B60A262D
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4060B60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8z5h8Ww
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so17579765e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328178; x=1794932978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slpIs/HinfX8orW6FfIUeyL7Jch9yZ8MPXuFx7Rx4z4=;
        b=K8z5h8WwIy3qV71SEQiQc/wqoD9AkocZMNSA2AieW/NNac/vbySxOGGBpNLiR1POPx
         h86zDGtxFYKk0Z+Kpt00xkGNcyJNZXQJ0rh6KmU8ks3uoCK4sJ4Afu64E8BQEQGGj0Of
         H5oxALxPZb6SjIJlaWG33+tFyDPLKtTSs3CnVA0tl4demd/c/ATXz1Y3bQ4eL2VG3HSf
         QL7w3VW6MznGDJ9CQyXs509EM2bgrFRzRTGNKtUmXhLr6empvXu9cFYYqjeYCDz5ShIz
         SSKbC6DzSpwz/KCrDuTblNlmchzSpERkDFsvYTxQTfJfhZhyLRZeRP1b4ESYgFkGhiUz
         GFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328178; x=1794932978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slpIs/HinfX8orW6FfIUeyL7Jch9yZ8MPXuFx7Rx4z4=;
        b=A0jidAm8qe4ZPKo/gfJf2R9n6+bHrOIrgMvTxLFgWIthq3RQHRpoN3JUmRsSDA5naE
         yG7j0dYbh8uO5O6Urbz0y+8KSXBoTyfRE/dWTRet17N+p9nBIe6NIo4NFJykGlHHLmYR
         GjbtQ1aLb6PWpq4NdOFSspXOce7D2M4O29+mAKO4CoKR9rwNhXxHpeTdsQpwFvOpMHJg
         o3F4i9EzdeUz76kOq+sEPbTNjndYaQG6wY21rOvRKf6TGhnPLFI1C1LWvFeh5/Ipc2Rd
         7ZmrmsaP21V9iLzq3w+vy77XKJC9GE5bUV4AA/9tZlXOa5RZnEJ96UPj2k/OpbdAPhgE
         C1Sw==
X-Forwarded-Encrypted: i=1; AL+hErHgsqz2UOhzxHIzpgNSm6Bn/tcF551BZhXCFGFuK+JMzZDsjaiEO0wWSRKYIbduAwcBaUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aQrLfOUXA0Fe4aEF5Uny0XpXhbpV3nrfSjiLQe+r8S6IOtfWy
	hXO58AcYaKiAIyxV+UpnKDR4N1HBD0bUrDbWFRRdhkmOAjzihrWCz2em
X-Gm-Gg: AYBFou2e2d83rVhCCs6AFpuFDIZyIo7p7a4XTcYz/DlIRPjK6kJB90DzNH0mbXB8fLA
	TVeabKh7wIlTfR7P1jgBByK97X/XC7aXPjYipxqXMsszlQMjjeAVkwPK3Ap1pdQNDPXMVG7C0UL
	H6tZ2b0PSVkpHJvbe1JHAw1hsTlt3H9kTK0h940t7AF28JGBCxZNvl1vO6gWKiROvfVaV9H+O8j
	ZIaphThNKPXWvDj3bR91m4NvO8/40wdzwhKtmOQgqPXJ1paNai2i0J9gonBmsVVwHs7fLClS2wa
	yLMjK0bFqFEEZgs75MNkF4JsSFc6oMXRHoSpk1sJjdHLYp9bvyzPCKUMbzSqRqnyjznYROQ72q0
	p/hdZ8uQzFHJvVmKXT0VtWdgQ0uo6KiGJrJ2s0wLz9gR42txjaFjxUl9kwcqobnbnz/b1z23HjA
	Uvq4HXxbq9EpLGz+pOIER64vGQoQsm7d+cmDyr1QzzLJc9EcJR1nkTFnlIRK8Eijq5qJzM6Ul40
	xK9xI43xU6prEePWlWljvR3WOeLMqDEbBYzDgyggEDnihubd22K6RUzr/LFUyl5xAqEctEgpSvd
	2MstaEtttpWn0W1UhWeWljYSkSTHNoXRB0ny4s670xPXZOM=
X-Received: by 2002:a05:600c:3b2a:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4ba02336374mr56174855e9.6.1794328177518;
        Tue, 10 Nov 2026 08:29:37 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:36 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 10/18] bpf: Allow writes to private stack objects in bpf_scan_ir
Date: Tue, 10 Nov 2026 16:40:30 +0000
Message-ID: <20261110164046.454431-11-a.s.protopopov@gmail.com>
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

A write to a stack object of the function is not observable outside of
it as long as the object has not escaped. Let such writes and memsets
stay on a clean path. A write after the object may have been captured,
a volatile or atomic one and a write to other memory still make the
path dirty.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/llvm-plugins/bpf_scan_ir.cpp | 85 +++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 3684918eb7fa..c45fb97d1b93 100644
--- a/scripts/llvm-plugins/bpf_scan_ir.cpp
+++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
@@ -4,13 +4,17 @@
 #include "../bpf/fmodret_metadata.h"
 
 #include <algorithm>
+#include "llvm/ADT/DenseMap.h"
 #include "llvm/ADT/SmallPtrSet.h"
 #include "llvm/ADT/SmallVector.h"
+#include "llvm/Analysis/CaptureTracking.h"
+#include "llvm/Analysis/ValueTracking.h"
 #include "llvm/Config/llvm-config.h"
 #include "llvm/IR/Analysis.h"
 #include "llvm/IR/BasicBlock.h"
 #include "llvm/IR/CFG.h"
 #include "llvm/IR/Constants.h"
+#include "llvm/IR/Dominators.h"
 #include "llvm/IR/GlobalVariable.h"
 #include "llvm/IR/Instructions.h"
 #include "llvm/IR/IntrinsicInst.h"
@@ -50,41 +54,76 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return C && isErrno(C->getValue(), N);
 }
 
-static bool cleanInstruction(const Instruction &I)
-{
-	if (auto *Intrinsic = dyn_cast<IntrinsicInst>(&I)) {
-		switch (Intrinsic->getIntrinsicID()) {
-		case Intrinsic::assume:
-		case Intrinsic::lifetime_start:
-		case Intrinsic::lifetime_end:
-		case Intrinsic::invariant_start:
-		case Intrinsic::invariant_end:
-			return true;
-		default:
-			break;
+class CleanInstructions {
+	DominatorTree &DT;
+	DenseMap<const Instruction *, bool> PrivateWrites;
+
+	bool privateDestination(const Value *Pointer, const Instruction &I)
+	{
+		auto It = PrivateWrites.find(&I);
+		if (It != PrivateWrites.end())
+			return It->second;
+		auto *Allocation = dyn_cast<AllocaInst>(getUnderlyingObject(Pointer));
+		bool Private = false;
+
+		if (Allocation && Allocation->getFunction() == I.getFunction()) {
+			// A later call may receive the initialized object. Only captures
+			// that can precede this write make the write externally visible.
+#if LLVM_VERSION_MAJOR >= 21
+			Private = !PointerMayBeCapturedBefore(Allocation, true, &I, &DT, true, 256);
+#else
+			Private = !PointerMayBeCapturedBefore(Allocation, true, true, &I, &DT, true, 256);
+#endif
 		}
+		PrivateWrites[&I] = Private;
+		return Private;
 	}
-	return !I.mayHaveSideEffects();
-}
 
-static bool cleanBB(BasicBlock *BB)
+public:
+	explicit CleanInstructions(DominatorTree &DT) : DT(DT) {}
+
+	bool isClean(const Instruction &I)
+	{
+		if (auto *Store = dyn_cast<StoreInst>(&I))
+			return !Store->isVolatile() && !Store->isAtomic() &&
+			       privateDestination(Store->getPointerOperand(), I);
+		if (auto *Memory = dyn_cast<MemIntrinsic>(&I))
+			return !Memory->isVolatile() &&
+			       privateDestination(Memory->getRawDest(), I);
+		if (auto *Intrinsic = dyn_cast<IntrinsicInst>(&I)) {
+			switch (Intrinsic->getIntrinsicID()) {
+			case Intrinsic::assume:
+			case Intrinsic::lifetime_start:
+			case Intrinsic::lifetime_end:
+			case Intrinsic::invariant_start:
+			case Intrinsic::invariant_end:
+				return true;
+			default:
+				break;
+			}
+		}
+		return !I.mayHaveSideEffects();
+	}
+};
+
+static bool cleanBB(BasicBlock *BB, CleanInstructions &Clean)
 {
 	for (Instruction &I : *BB) {
-		if (!cleanInstruction(I))
+		if (!Clean.isClean(I))
 			return false;
 	}
 	return true;
 }
 
 /* Add the errors which clean paths of F are known to return to VALUES */
-static void cleanReturnValues(Function &F, ReturnValues &Values)
+static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValues &Values)
 {
 	SmallPtrSet<BasicBlock *, 32> CleanBBs;
 	SmallVector<BasicBlock *, 32> Worklist;
 	bool Changed;
 
 	/* The clean blocks which the entry reaches through clean blocks */
-	if (cleanBB(&F.getEntryBlock())) {
+	if (cleanBB(&F.getEntryBlock(), Clean)) {
 		CleanBBs.insert(&F.getEntryBlock());
 		Worklist.push_back(&F.getEntryBlock());
 	}
@@ -92,7 +131,7 @@ static void cleanReturnValues(Function &F, ReturnValues &Values)
 		BasicBlock *BB = Worklist.pop_back_val();
 
 		for (BasicBlock *Successor : successors(BB)) {
-			if (!CleanBBs.contains(Successor) && cleanBB(Successor)) {
+			if (!CleanBBs.contains(Successor) && cleanBB(Successor, Clean)) {
 				CleanBBs.insert(Successor);
 				Worklist.push_back(Successor);
 			}
@@ -128,7 +167,7 @@ static void cleanReturnValues(Function &F, ReturnValues &Values)
 		bool Entered = CleanBBs.contains(&BB);
 		int64_t N;
 
-		if (!Return || !Return->getReturnValue() || !cleanBB(&BB))
+		if (!Return || !Return->getReturnValue() || !cleanBB(&BB, Clean))
 			continue;
 		for (BasicBlock *Pred : predecessors(&BB))
 			Entered |= CleanBBs.contains(Pred);
@@ -188,6 +227,7 @@ public:
 			return PreservedAnalyses::all();
 
 		SmallVector<FunctionDescription, 32> Descriptions;
+		auto &FAM = MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
 
 		for (Function &F : M) {
 			if (F.isIntrinsic() || F.isDeclaration() || F.hasAvailableExternallyLinkage())
@@ -202,7 +242,10 @@ public:
 				Flags |= FMODRET_FN_WEAK;
 			if (Ret->isIntegerTy(64))
 				Flags |= FMODRET_FN_RET64;
-			cleanReturnValues(F, Values);
+			auto &DT = FAM.getResult<DominatorTreeAnalysis>(F);
+			CleanInstructions Clean(DT);
+
+			cleanReturnValues(F, Clean, Values);
 			/* A weak definition always has a record, see fmodret_metadata.h */
 			if (!Values.empty() || (Flags & FMODRET_FN_WEAK))
 				Descriptions.push_back({&F, Flags, std::move(Values)});
-- 
2.43.0

