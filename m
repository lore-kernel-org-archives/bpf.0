Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328181;
	b=Txke4wxDz6F8pKrr4o2TQ2NzaEcXPlYRHdV9o3CUojhRowlwhSVMDOGKhg0gPPPuyn3o
	 CGGpiffcW7ckx89g8v8MsUysm/j+tTXLbTLkTRdFv+XdK1Txvy/EsxkF0CsNjMTD+8KH3
	 fnW2FF210du8rG4wOyUvH4zXU8EHs4hLUTdyMemRByrNTichLAZ0x/P+ZvzR/KRmOqeul
	 Nbnad2wt/5Y67Mc468kg+GOVwq9uzG1998dQsgtZY3R2mh7beQCfirqa0rrNseK21wAkZ
	 D7U6H3/ba3JabN+hUuDeA2jEZWErhRWprJN8SSuyDK9Fn4fWN/lzLuBZxWsxtSN0Fvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bwd1wdoXEErbMb3reUq96fn7OlYms8ZVerVffjZDvbk=;
	b=TjnEO9WIRczCHt9b/YtL+dHANHlzPvRDLpyEQTX9mrLgxJU6nY/JZCqRTyjFc0cJ02+F
	 fmtC8JuwskDBW4+JuaqlHrGK2NuhslXzodvqlulXWb3lw5gDA1DCHJJ7XGRGvwxAjDHEa
	 qDttoPtOJF0Jlbio+WbSGaMwqoNR8Os1thnLIcVAEKby0ZMpe8AUDT6Jy3qoOTZ+LeVBN
	 oDoz/rllsDwZy1mgfHtmlN6k8mHELYAD97jDLfIMT+jd30vwsIK4bnx9q7Ot+SkaKOlct
	 ClsmjJb0P995pO3PiBQUyikGidTXhGiKJyEAXKURmxQ5b0eux6UevqMh0TC0vdgI5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vbu1U9BY;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920860A5BE3
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C920860A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vbu1U9BY
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a208d93758so23698245e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328179; x=1794932979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bwd1wdoXEErbMb3reUq96fn7OlYms8ZVerVffjZDvbk=;
        b=Vbu1U9BYVlhceF6dAQsh7jHPMyrSyJk54jyyIvq/haHs4WBFo493tuqqRPn68DkujA
         uBnFGQqUMYuOLq/kDRLcIYtfGm77WVyPy6gCArMURg8XVGJquASrcu+yddnVGkei/GuZ
         QeRE//ZQ4hF2f+rXiqHNFA85StZVmKTaHWqivOV5vaQnA5TlzIDJvnLjBWT5y4Dsycr4
         rl8HkhntBZ1hkLoc6Xf4fckJtLaV9JgvXQAeqvYXyPH7boXSVkQUWor85HsDudLKijq5
         E3ya5EHXP3XCTQ+PlJkABrF4gb3Y6wQzDg4WYHVVCh7G7eX/6NrysIzFpj0ERwOtlvqV
         QNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328179; x=1794932979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bwd1wdoXEErbMb3reUq96fn7OlYms8ZVerVffjZDvbk=;
        b=UVKhMAIdH9TR4H3L8rPni1VNV+nwoYMzbmTvADN8D2iL33d3LD/u0+vANNXlwFHxBr
         slPGU+Rl62+tzRIbfZsWSzW/NcOZCJ0oz+lZg6uh45RGIMhKyXFe51ajx3cwdATKS3aY
         32NDVO+yQ9SO437ZpV0PG7gb7Y4B6Gz2cfCGlaoWTdJOQZSVgNIFidsgCIYTiPn45l/l
         J6tCjnAKbwqrSYPcicyquhTPra5lK+/2s31buqAHjot1RynjWfwzmzyIHNNw8V2+PJJn
         iesi0sqHkQ0N7qK77UYqxyFYlrpSNA3tcDtdSH555KXnxb3fiX4SjYx6Y2JEptBk4kvM
         GcRw==
X-Forwarded-Encrypted: i=1; AL+hErHIxZwMPxMavcUHVtCR4gsoIVi56jGev99WfOm35gegq2wo4f/tBsoM0kJ0pldJRYF3pOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lO7xsn8NE6lK3FqnvG+hR1ia0gkNFsdXx0SjUqLzyMj0e4d29
	gmEG2EGNAKP1hmW4jz54Dns+6faLJ9EZ69tDT4HIsYE8wuM3zZe3phyr
X-Gm-Gg: AYBFou1eNwZom428eE4uyAhKNyYhmQ3UK24mhN60UFX+yD5sPkKBIzJ3h9fFFrO1pVv
	PVRSr3HjxVdICiWoV/Iw77PE7usjqU0YePwo0IKFghs6063Jq5rl4SdWNv3mGlY9VHkWhBB6HeL
	MImwURfpbaD5+AudtVMxb82TuRXIqJxyA0IDN0LD99tQxHQQvjfEX2vcpkuYJVunZ7VcLRqksQK
	2U6Y0C3wAvasBCgEz05UQ61rgYReRvC4UbEMD6eu3wNXrmLSw7bNvgN7c2AGHslXrIlFJ784hrg
	9NX2LadqNbbrrKDa5wh+DmPdEr7VJv0BCr+QaswJJ2mJ0QEXGOfUK8HWsWFKNtbd+JisO2t3XDV
	U6NNpJxzBbgcObHHw4WcpDwy0rFl2tIzxTQRWuolop1YVnOqkt4hjBLyCGl2xTUMGyA5KzGD1xF
	Y3kb3gP0B3aP0veLuWFRo42tkNglPIDxqcR/nOB9HHfjZcOn7e1IJL7YtA+gqipSkuZpBMVBn5M
	5/mCsl373uBYnQ4AsSYIh3Iw3JJury2b7L8tC8rhfAENecBQ1Xio7eegbSbNeEfLcr/bpChzyA3
	XOHf2KJfzdTGcRnyq/fQlbfyafnK7cIaKK/FarRF8u7nxR4=
X-Received: by 2002:a05:600c:3e11:b0:4b3:9540:47a6 with SMTP id 5b1f17b1804b1-4ba0234f7a2mr52146255e9.28.1794328179086;
        Tue, 10 Nov 2026 08:29:39 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:38 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 11/18] bpf: Follow PHIs in bpf_scan_ir
Date: Tue, 10 Nov 2026 16:40:31 +0000
Message-ID: <20261110164046.454431-12-a.s.protopopov@gmail.com>
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

An error often reaches the return through a PHI in the block of the
return which joins it with the results of other paths, some of them
dirty. Take the incoming values of such a PHI on the edges from the
blocks which only clean paths reach. Do not follow a PHI in an earlier
block: a later branch may split its values between clean and dirty
paths.

Take also the errors which LazyValueInfo knows exactly: an incoming
value on its edge and a returned value at the return.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/llvm-plugins/bpf_scan_ir.cpp | 68 ++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index c45fb97d1b93..249412194766 100644
--- a/scripts/llvm-plugins/bpf_scan_ir.cpp
+++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
@@ -8,11 +8,13 @@
 #include "llvm/ADT/SmallPtrSet.h"
 #include "llvm/ADT/SmallVector.h"
 #include "llvm/Analysis/CaptureTracking.h"
+#include "llvm/Analysis/LazyValueInfo.h"
 #include "llvm/Analysis/ValueTracking.h"
 #include "llvm/Config/llvm-config.h"
 #include "llvm/IR/Analysis.h"
 #include "llvm/IR/BasicBlock.h"
 #include "llvm/IR/CFG.h"
+#include "llvm/IR/ConstantRange.h"
 #include "llvm/IR/Constants.h"
 #include "llvm/IR/Dominators.h"
 #include "llvm/IR/GlobalVariable.h"
@@ -46,6 +48,21 @@ static bool isErrno(const APInt &C, int64_t &N)
 	return N >= -MaxErrno && N < 0;
 }
 
+/* Return true and set N if RANGE holds a single errno */
+static bool singleErrno(const ConstantRange &Range, int64_t &N)
+{
+	const APInt *C = Range.getSingleElement();
+
+	return C && isErrno(*C, N);
+}
+
+/* Return true and set N if the value at use U is a single errno */
+static bool singleErrnoAtUse(const Use &U, LazyValueInfo &LVI, int64_t &N)
+{
+	return U.get()->getType()->isIntegerTy() &&
+	       singleErrno(LVI.getConstantRangeAtUse(U, false), N);
+}
+
 /* Return true and set N if V is an errno constant */
 static bool errnoConstant(const Value *V, int64_t &N)
 {
@@ -54,6 +71,42 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return C && isErrno(C->getValue(), N);
 }
 
+/*
+ * Add the errors which V, the value returned in RET, is known to be on the
+ * edges to RET from CLEANBBS to VALUES. V may be a PHI in RET. A PHI in an
+ * earlier block is not followed: a later branch may split its values between
+ * clean and dirty paths.
+ */
+static void collectErrnos(Value *V, BasicBlock *Ret, LazyValueInfo &LVI,
+			  const SmallPtrSetImpl<BasicBlock *> &CleanBBs, ReturnValues &Values)
+{
+	int64_t N;
+
+	auto *Phi = dyn_cast<PHINode>(V);
+
+	if (!Phi || Phi->getParent() != Ret)
+		return;
+	for (unsigned i = 0; i < Phi->getNumIncomingValues(); i++) {
+		Value *Incoming = Phi->getIncomingValue(i);
+		BasicBlock *Pred = Phi->getIncomingBlock(i);
+
+		if (!CleanBBs.contains(Pred))
+			continue;
+		if (errnoConstant(Incoming, N)) {
+			Values.push_back(N);
+			continue;
+		}
+		/*
+		 * LazyValueInfo knows the ranges of integers only. On an edge it
+		 * also uses the branch condition, as in "if (err == -EINVAL) goto
+		 * out", where err is the error.
+		 */
+		if (Incoming->getType()->isIntegerTy() &&
+		    singleErrno(LVI.getConstantRangeOnEdge(Incoming, Pred, Ret), N))
+			Values.push_back(N);
+	}
+}
+
 class CleanInstructions {
 	DominatorTree &DT;
 	DenseMap<const Instruction *, bool> PrivateWrites;
@@ -116,7 +169,8 @@ static bool cleanBB(BasicBlock *BB, CleanInstructions &Clean)
 }
 
 /* Add the errors which clean paths of F are known to return to VALUES */
-static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValues &Values)
+static void cleanReturnValues(Function &F, LazyValueInfo &LVI, CleanInstructions &Clean,
+			      ReturnValues &Values)
 {
 	SmallPtrSet<BasicBlock *, 32> CleanBBs;
 	SmallVector<BasicBlock *, 32> Worklist;
@@ -159,8 +213,7 @@ static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValue
 
 	/*
 	 * The returns of the clean blocks which only clean paths reach or which
-	 * one of them branches to. Dirty paths may also reach the latter, but
-	 * the returned constant is the same on all paths.
+	 * one of them branches to
 	 */
 	for (BasicBlock &BB : F) {
 		auto *Return = dyn_cast<ReturnInst>(BB.getTerminator());
@@ -173,8 +226,11 @@ static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValue
 			Entered |= CleanBBs.contains(Pred);
 		if (!Entered)
 			continue;
-		if (errnoConstant(Return->getReturnValue(), N))
+		if (singleErrnoAtUse(Return->getOperandUse(0), LVI, N)) {
 			Values.push_back(N);
+			continue;
+		}
+		collectErrnos(Return->getReturnValue(), &BB, LVI, CleanBBs, Values);
 	}
 	llvm::sort(Values);
 	Values.erase(std::unique(Values.begin(), Values.end()), Values.end());
@@ -242,10 +298,11 @@ public:
 				Flags |= FMODRET_FN_WEAK;
 			if (Ret->isIntegerTy(64))
 				Flags |= FMODRET_FN_RET64;
+			auto &LVI = FAM.getResult<LazyValueAnalysis>(F);
 			auto &DT = FAM.getResult<DominatorTreeAnalysis>(F);
 			CleanInstructions Clean(DT);
 
-			cleanReturnValues(F, Clean, Values);
+			cleanReturnValues(F, LVI, Clean, Values);
 			/* A weak definition always has a record, see fmodret_metadata.h */
 			if (!Values.empty() || (Flags & FMODRET_FN_WEAK))
 				Descriptions.push_back({&F, Flags, std::move(Values)});
@@ -258,6 +315,7 @@ public:
 		PreservedAnalyses PA;
 		PA.preserve<FunctionAnalysisManagerModuleProxy>();
 		PA.preserveSet<CFGAnalyses>();
+		PA.preserve<LazyValueAnalysis>();
 		return PA;
 	}
 
-- 
2.43.0

