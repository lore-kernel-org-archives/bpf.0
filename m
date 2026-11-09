Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243300;
	b=PT3p03wqYjHuu+dWKd2JqE3G5CS3sUdhaMC2dSJXKEeXBaXtsHv1Exe0zj0Vh50vS657
	 OMEtsKMUG9XQP5IHUnzt6inondRARufUa8TiybPMd8Gf+wurCOuLit4mYcVNWJFyExRTA
	 kW1Z7pD1Kz6ZZa5MyCgYomm7D1DdKpk2LygOPl9eCs3DCuCXcAMfbzRwwsd6I/65slFru
	 KcmOMBivR6VigmrLS8Mu4+/lWRlC56qEC9vUwZxsVxVetmi1wVy4XfmdqtXaUmKD5QwA5
	 OrOQ/3ArcPQ6/4RFDqUkjUV7zdcJ7IMKRDDnc2lvZLrx2SoVP5wF9qJe+FolHbSjsCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iPNiV1uPKKfIye6r/jbhbX/vFYDAqBTFEyVAJ/rz9gk=;
	b=L1qoDrpjgplR/JLdQowB/s4OyXBDncdVyJ84fzNcMubdegHWj1rrQNvrfJ3NJnAs0LBz
	 1hjbKJJPVqZSMW6rXvFhMNa+COa9m/8Ojt971M3MWEDbomIrI3rakpytVVmPKbfmrm9Q2
	 ebrfi6gKGyXKKDZx7DrM5VI+1AYl5oYZISjyR7G9ux6S/vFd7MhWJhpl8oFa5HBxAGLi0
	 J8WTMl6pHLEAF+cp1cfAAAKInqUd0+oq4af8kvC/hpn1tUbBLVWHrbIrLiB/qNgvpNBuM
	 LqDnenNyUVYDRKoCIOIrEQCsy/k1EanqUR+3eH3XY8K8KkE+5d1S8NcrNgb2Pi1KjDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WUIQd0/l";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5D606A892
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD5D606A892
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WUIQd0/l
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so765441f8f.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243298; x=1794848098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPNiV1uPKKfIye6r/jbhbX/vFYDAqBTFEyVAJ/rz9gk=;
        b=WUIQd0/luTYLe8Ggt69gFM6z6g6qQUmytj+dYC6qJ/YPpgvXu6ndfJAS3PXmaYbiHG
         UZ/xF0Q4W0y5lemQoaO0sSkeH01t3561NkTayu2WLTe9naDzv4cU48sH0N2CC8lZYEmn
         G7r7teHUBG70N6aA7qK+50ki/b0nO9NRSMu2P//q+A5HSTfH+Pcka0RH97Ex8ysUJLUL
         5jL9+hHlpbhfHfwsqVJsvZwcnQQZn1q6AqT5W7OsztfOjHSjUDlTmW0OeW17JkGBB4nH
         pDuBYIUnZMnNBtDnDIxVbQvO0NaZG1rPdmEg6NiQ7YGp2Tx9MJqiYP25RKpBWixO/qCc
         UxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243298; x=1794848098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPNiV1uPKKfIye6r/jbhbX/vFYDAqBTFEyVAJ/rz9gk=;
        b=UvZGfw36my71rXs50AP2nEE4CPf5oEYcejdl9NVb9k8XZ79Thd0C+EfrGrwwLiq2Sa
         SfRf3ES4RcLySbC6o2lgZHp2QEp903DGgYWRQnPg/j/HaTl8KlaPnY4FfsAvUQ8HakH/
         /xcavjiJkuGTTSsYpVSkuM/khTHYTHT/l7NeBQv1XTU/II7vGwu1xTUCJv7/MPqif6Zq
         bLW1LOvjfI5CM7uZ00/lQPz3IJ8SgbZLPODWH0siIPtEXR89MYzR/smHgO95x75lCqhZ
         5ji/1dizavKEjTjkewaNbU5KRaOEKoBoUZ6v4g1AA86hcSzJVX8bHqBGV83n8oaGUrNy
         u/aw==
X-Forwarded-Encrypted: i=1; AL+hErFiJ7ODOzEkVgV9yk8rEyjhCjEwW63CN7k/CUjvDAdl4BQiUM7uxL41lB7mRq/lkU//Vqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oQQbYelWGAYeZIs8g/0GSKI9ABqudIm7X20DrzcvjKY8UMdKf
	c4NQFquFjJ2tyExSz182zBmmrQZN23YPGPpVCcgNphpthVr2CWwFdUW/
X-Gm-Gg: AYBFou1ZhBZ3Xp/2HtNRG2QpwFDAk6wudWlRLiTGdXyKHYbh4YtVpvqTYBignePwSCP
	60zV1ktvgkM7ex1wcuzUq2IzTrQS135lVXJp+G1EgU7IA+Ly+RLz25z1gDa0j/yPxSQPQmW1OH8
	1Kvbbrr0d2NM0RHS7/F7GX6SiXHgw2GVejlIcT2k0ivjfAFhQvC59owvOvlSYJnczxFpTJjSiYB
	8Q2eYxhTXgjQVCyNkkvAGgReshJpIPfsNO/U9DSZhXrh+xqK+ZNd7931jpUvMrLm9o7TeQXfSpJ
	LF1jP+7ev8nx3m1aoXpv1b+Ar9c0h50ZN6C0p6/zToWGpE5Fu4XoQL2p5CtK5tQXQ5WPJqkCHuz
	C+0prZkdBorCRlWilxHhEGdUqd9hsVvJgr340Bj3eg5x8jCPa5YfyGYcljAG9szOZ3IfKekK+Nx
	9TH6jTWlHmNE0xzysH6p1aUW/gLOdIuwFk1U+nAyqrj5D2TaZKRUAedTpenm4Owq8th4kNDNfYQ
	iykNR00hjvOfWm3NpS4Z6Dj7Pn0ZTCVqhkzO2ZC09LBU6Ie00YDKkJOuXOpDKLC+Fgn4gcTlflz
	t7Qo035zE6+zP3GnueVuzj4hrt1XQF/U
X-Received: by 2002:a05:6000:469c:b0:495:12e6:c5d0 with SMTP id ffacd0b85a97d-49830c8ce4bmr30798f8f.48.1794243298079;
        Mon, 09 Nov 2026 08:54:58 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:57 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 10/18] bpf: Allow writes to private stack objects in bpf_scan_ir
Date: Mon,  9 Nov 2026 17:05:30 +0000
Message-ID: <20261109170550.141443-11-a.s.protopopov@gmail.com>
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
index 6828fa73717d..0fc60b2130b1 100644
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
@@ -45,41 +49,76 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return N >= -MaxErrno && N < 0;
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
@@ -87,7 +126,7 @@ static void cleanReturnValues(Function &F, ReturnValues &Values)
 		BasicBlock *BB = Worklist.pop_back_val();
 
 		for (BasicBlock *Successor : successors(BB)) {
-			if (!CleanBBs.contains(Successor) && cleanBB(Successor)) {
+			if (!CleanBBs.contains(Successor) && cleanBB(Successor, Clean)) {
 				CleanBBs.insert(Successor);
 				Worklist.push_back(Successor);
 			}
@@ -123,7 +162,7 @@ static void cleanReturnValues(Function &F, ReturnValues &Values)
 		bool Entered = CleanBBs.contains(&BB);
 		int64_t N;
 
-		if (!Return || !Return->getReturnValue() || !cleanBB(&BB))
+		if (!Return || !Return->getReturnValue() || !cleanBB(&BB, Clean))
 			continue;
 		for (BasicBlock *Pred : predecessors(&BB))
 			Entered |= CleanBBs.contains(Pred);
@@ -183,6 +222,7 @@ public:
 			return PreservedAnalyses::all();
 
 		SmallVector<FunctionDescription, 32> Descriptions;
+		auto &FAM = MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
 
 		for (Function &F : M) {
 			if (F.isIntrinsic() || F.isDeclaration() || F.hasAvailableExternallyLinkage())
@@ -197,7 +237,10 @@ public:
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

