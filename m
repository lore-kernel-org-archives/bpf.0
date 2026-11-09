Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243303;
	b=abXrj66byBROT8BxU+cNJK6988SXG88j5/F+wHoflfSDq23rnmustpx4M2DiCG+DbzNz
	 7zcg9WnMbm3kBW9GKstWQ90j2XvRI1qJu6vDRWOASERdnjakUl6RMLCHO/9Mvy9R2Yl8Y
	 D9vQ/Bb/NzdylHjBlJ7kKF0Iu1RuV9Q2eq/eJyNjnqr8mWAGRdgdgHYNY/3IZw1bcLf9S
	 +6mlJYJeO9zOUgHTIM3RoxJB8z7lzGp9H+q2PGynxSJ809bnkOdtl5a4WrKRispd9UP4y
	 +6bFvXjSKR3c/mH2WgQB+oHeF/RaVI2DHj+qHllEq9Tu5kD6mwXADu2+c9IQWvTeoFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=slXrTo8Cr/NVx1W/On0les0MlfgDaZcylgwq5f9qHyY=;
	b=QEk7ba28rLJK/VCJUe/omgYvGRAqgI8Hcq4YDNOdQPaHt3IibeS8bWtfKQMkoxzHm+UB
	 zCE5Hee6b5G6miGqm4TEg+1nnArebFq/GfIt9TaREUQ8csriZPVlRgyPPeVPk88ssN2Cn
	 KvoTIIHy7dA9knBpgCK63Ij+/2soya4nCRVJGEPqoEyeqV8AEfXBTVuWKCsitIdtziIMT
	 E+PMUoOV+RU0qSjujo8ZcNeoSOYBJHQQjbhF+85SvUrPFOlxfndlsvObr9SAN5PrjTOwh
	 Xrc2s58vfSr6WwLraS9//z2hJsodFwg9HQtq95XhI0u0qGgDHNT5OVUw+G2iKUZh/qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jC2F0Srs;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21255606A8A9
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21255606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jC2F0Srs
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4918c2d727fso574719f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243300; x=1794848100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slXrTo8Cr/NVx1W/On0les0MlfgDaZcylgwq5f9qHyY=;
        b=jC2F0SrsgYJYG0UFwBYmwNmg/vftlPA1YKYx1EbhdJKXsH6xummx16NFAo8wMmco6W
         3f9qOMkEaRnkjXLoomqJXG15K+goeiFZUr7Z1QCMubYlXOANxseaf69wE4qsak4nDIdP
         j8/xUpvdIBOL1//qt+2wFoejdnVhhvJc8RyOdoRDDLnpOx6bQDY+zsRevrJQ6RxRNLJr
         VJQDOJINtfgmJ0s6QZjKM7rGsVciWoIbJlXSg+obKGCy4bfQ82v4SI09zBPOksBzVVlV
         rJn6AH7IB6ZRUBYo32cEKcC4ndMpqiWS7J06MeaDrI2wsV/ILPZVc2Rt530xNHQLiKM/
         vmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243300; x=1794848100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slXrTo8Cr/NVx1W/On0les0MlfgDaZcylgwq5f9qHyY=;
        b=dNliSLduQmhcewNaZ4dPQI9Nqt6YRVcE++SdhIIMXqZirJarZjh3aMioRnHEnzqnYd
         J92EFTaFAHWvP8C0tLFitcLs2roOkB/XwEngZ3/iyHHZf0vGIHJEZewAsrtpKerBWIS8
         BarHIOA+zyNPkUDqb4YxjWta129wShVlW5iZ/DYKkY4pDDhSEpHA7PYOuhyBBP+gHzAW
         y9OXBjZlD1gbHcPn7MCo1Nt0zSoeHDFTd+ozcBJJmtX3cxxCXHJ0NVslaPfCahbSClsG
         aIGrgxnZ82WuRj+V25Dzqkhu1FENBFFdsGTlEwChFPH0bCvY1RF+0N2hNI0L83KDVvcW
         cfjA==
X-Forwarded-Encrypted: i=1; AL+hErGdu1nmhtysZ5ZEYPV0ns9cLgAFmd9Y3m3s/6yq/bSMWDeBMPME4kXoPv0DJVWjnfkJn2k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9TxkAto9DV88szGsqCSd3LUwetssgoU1w8+GvHahYqYSQhGQr
	hFAcUlYdIMnPH8sAg6WQeikBPifn42aEykhHMKCRV6qNS418asyzdEcL
X-Gm-Gg: AYBFou3X0TrCquV6dArH1rnKh82V6pz2lQzlpEyBmweaDdlvMxhyxFevgtcwtWd8ExK
	M97Bgvq4ndbJ1IQSWmcYOxeKoiLSfmbioHQexbtfmfhwvsALi8yMKYwHyf1OCpCqVonRtViT8dM
	7pPFyp+wAPlwBvoy8Aj3KzPWHp4LtEMT77aQlStxwAJLiEnISL9k5vDjOIdP5ptBAqQFlqIFVL+
	vcTDLhLRQ6TBcLkBYeNPEXNjXFmz4fdYAPzWy3gaUlgwf/UC7mhs3i3kpTjC28E0CER3t8GVV3u
	izGWbmQ9E8PBFJivjW19qc23UY9KKPhmk3UfWtG0gZ0DGYvVsb+ZEfmX7exCjO/28p42cjfy3mn
	jwXMTjd0zx/C5ToFudOCWsJwdjeRewvpaNZ2Ypvq3mo8rWIxH2WsiqqYKrbay+TTpG93hxcGHUR
	RMdqrq6j++mFaWt0rOrBtvIyWg+/CSNGzl76BdCMcNdhHZoFnUqN0MXFP9MpHmDeoDP0N68/lOh
	ujJ2zYtxi+wiG7dT4lo+GOPydCA5xEYvD+ZgUw1SMSMvuCRWUmjjZTvOUf1rEn9UYxmszts6S61
	8yTLGzkojoiqRxwvkKM0zDbLN81LK56s3LRbL/o14AXVxKz1
X-Received: by 2002:a05:6000:230b:b0:48d:fdd0:6ce8 with SMTP id ffacd0b85a97d-4982b28a797mr184972f8f.3.1794243300486;
        Mon, 09 Nov 2026 08:55:00 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:58 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 11/18] bpf: Follow PHIs in bpf_scan_ir
Date: Mon,  9 Nov 2026 17:05:31 +0000
Message-ID: <20261109170550.141443-12-a.s.protopopov@gmail.com>
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
 scripts/llvm-plugins/bpf_scan_ir.cpp | 84 ++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 0fc60b2130b1..81de8f941568 100644
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
@@ -34,9 +36,40 @@ namespace {
 
 static constexpr int MaxErrno = 4095;
 
+// is Range in [-4095, 0) ?
+static bool isErrnoRange(const ConstantRange &Range)
+{
+	unsigned Width = Range.getBitWidth();
+
+	if (Width != 32 && Width != 64)
+		return false;
+
+	auto L = APInt(Width, 0) - APInt(Width, MaxErrno);
+	auto R = APInt(Width, 0);
+	return !Range.isEmptySet() && ConstantRange(L, R).contains(Range);
+}
+
 /* The errors which clean paths of a function return */
 using ReturnValues = SmallVector<int64_t, 8>;
 
+/* Return true and set N if RANGE holds a single errno */
+static bool singleErrno(const ConstantRange &Range, int64_t &N)
+{
+	const APInt *C = Range.getSingleElement();
+
+	if (!C || !isErrnoRange(Range))
+		return false;
+	N = C->getSExtValue();
+	return true;
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
@@ -49,6 +82,42 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return N >= -MaxErrno && N < 0;
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
@@ -111,7 +180,8 @@ static bool cleanBB(BasicBlock *BB, CleanInstructions &Clean)
 }
 
 /* Add the errors which clean paths of F are known to return to VALUES */
-static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValues &Values)
+static void cleanReturnValues(Function &F, LazyValueInfo &LVI, CleanInstructions &Clean,
+			      ReturnValues &Values)
 {
 	SmallPtrSet<BasicBlock *, 32> CleanBBs;
 	SmallVector<BasicBlock *, 32> Worklist;
@@ -154,8 +224,7 @@ static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValue
 
 	/*
 	 * The returns of the clean blocks which only clean paths reach or which
-	 * one of them branches to. Dirty paths may also reach the latter, but
-	 * the returned constant is the same on all paths.
+	 * one of them branches to
 	 */
 	for (BasicBlock &BB : F) {
 		auto *Return = dyn_cast<ReturnInst>(BB.getTerminator());
@@ -168,8 +237,11 @@ static void cleanReturnValues(Function &F, CleanInstructions &Clean, ReturnValue
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
@@ -237,10 +309,11 @@ public:
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
@@ -253,6 +326,7 @@ public:
 		PreservedAnalyses PA;
 		PA.preserve<FunctionAnalysisManagerModuleProxy>();
 		PA.preserveSet<CFGAnalyses>();
+		PA.preserve<LazyValueAnalysis>();
 		return PA;
 	}
 
-- 
2.43.0

