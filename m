Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998335;
	b=FKiLQjYICyjt+jutl7LJfWWHS/Hzln4cdRfDnaeUHmZTGknkcqBt8HW3sqE2TN0+QCiA
	 QMHf0YA9UL+LqjK0YqzN49WGqbyTeq5RcQUoiG78/uMkBO0WXsSGyw2+9a8FlShCqcqJt
	 Zf6z6VjjpnhgA7q/tCGy5+UAps0fEQHtUxp1WFY011XNrkmno9z4Ziq/MPOOmNTNH2oXR
	 cD4FwYHTG04hW0vmFDVateLDR7ZDTKQtyUTcRcsD+d0cu9wZfT8lGBvcZD+bqYpJ/EV3K
	 bVzWVr0/w4cE19xbIauK+BdwjX6Zfso17hgT1FfJlslz793uGzdEGXvGr0K2nEeqE3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=slXrTo8Cr/NVx1W/On0les0MlfgDaZcylgwq5f9qHyY=;
	b=BM7hgDMLZ203Q8wcmqNGJyy3rEDayzd3n1+msKAOFv2lL9mdfmtVj5p2nM1XN+r/D4Of
	 JG+zhnMXkcZM+ZLe2TwhoaQc01K4eeuEY+RTNASq7GW5YJky1TLQAVi52iWNMAnMiEq7y
	 FeVaEpFCVb9pHwUao4T8iEfmupnZKXYRInZ1NnWhJLlZhHgLT5pF0w23GtgV5jsIpyNKX
	 1Vy/tgNeOdvWodJyu3ntT6b75vLWLD8D2iAjf6+3ET6jIxY4aYn8tcwWZjWsL6HiriQOp
	 muNitirmQSibWqpbGZegNa7CaC7sjnPXc8QGHxL8j4FMh6mcpCyr5gYdD2dLeXt7r2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN2cUmLJ;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB20606D810
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBB20606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN2cUmLJ
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10850395e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998333; x=1794603133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slXrTo8Cr/NVx1W/On0les0MlfgDaZcylgwq5f9qHyY=;
        b=oN2cUmLJ4ji4eGxu1e2K38y8ZTix9KyS2u7ytEpENNLpzs6oPhn0btAcdyklQhZQwL
         kp4sF2tM7Y0tdHunTqnDc/25/13Jce39jCtpLO8P1JPqpNOSPkcSL0aFdLHqfGscoomr
         MnoHNKuxtuU32kJYrrAuDWnmy/D2NkjGcs0FUYEwkzvxmTRzDifyAvifT9som2rjL/RT
         EmqGawfqmkwte8yy4IMX7lYxl9Xzjcscbd0EJn0T7W7yIBWUim137ix+YK3jrNpjD0u+
         FYYVKifyqQvUqorwddH71vJHdTSvoNC9Rcy0/WihCfHjlowk+NeUiswkOqBBAvUelGRD
         CnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998333; x=1794603133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slXrTo8Cr/NVx1W/On0les0MlfgDaZcylgwq5f9qHyY=;
        b=yKDWcJUEuhBvKHO+JHLasetObk9mE5eTnTf4tpewV3RYDtWR3TmNurtTWWYyoqtokX
         iN7Cqq8wh2CP/w0Gg57eu1hyBHcREb3hbxdHIWce/lITkflIX46ThaSOSHquFXdXJQPE
         qKjVQ5miZphEP6xip7C50q6a+gozWQqIYaCGOcH3B/542okZdi5Wkz2GULhd8+OywdU7
         LZEZUTJ9eAgzi3mw4oL26kvtAtkDK8g6mA56wOa89kNqTV2Y/ZIy0VPNfubaikw4ME/m
         Wfh4Fjn0r1imOLU3a53Uidy5rJZYgyGksF1SiR8GqBLYwZLIw5ggBNlLDSkXhgAzmQ8j
         1GCQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/pVeMKZPGSy5fZNJhnOYkcBm7hb+u4QvWkdWfKGdBL83NTAJeH7ZiWSU3GEW8/fPc3LY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5KP5fPgCAC1iE36cFsYPlyljPwRuS586ltN86pvM6cjE9GVoo
	wBVKlQvWTX9ebzWLCM3+yL9YROuAPcQVkj7lzC+9HoTIWZ/iKr0Y9fNq
X-Gm-Gg: AYBFou2KCWrt1AgLU724S5ICZ7XcIQQJBgbC1Kk/4sHhqEt8wPmDeaYviYIXzc15V/T
	GHeFczzAU6Q65szv+sgxHmyWbOkwTLN5BA5wPXOjAHG6+te+541gKCrRUr6LizFUnhQ+6tEoZm2
	wHrmuUX7o8wYQBTvdntweDnDyCgzwAldb+4F4Mx/sfvCfCuZ+wkLwxmJwJWEA0nFG4tZPFRHYL7
	VBOR1rK9wnzp67Tfju0qDLnkdTYwfOu1ef4iBFksv4Z42tIKhK5QLFrPGOY5SBEgqRcEZI2y0Oz
	0qD4ZCJ2x1Ezp0IPIxURFSpdY60hzoBwUjqWB1XLUdeZvJocLP6GplVtUIF9d+BfdpuCibTZ8Yj
	X7wCkOVdEd7wBgd6OOsKqI/hPTS7cDc0R902qnIBSVjjLgLzMUsDw+7rCrIU6g1py7IJX+hhp4h
	TyBLkA0iJGxl9OnMXleWEPgp+2SHQ3OqPXR5LgHhy/Hc8KKhoCpDlOMuW8Q8fue4nJUizixYL9d
	sXc9Gq0I5IXTy5KHunRUbdTFcUpht9NHWDSPOGRIwJUb3OYpKR9vwJ9/ZaKZ9zDDl4MfWPHCWEo
	COoT1mGo8/Dwu9Rdf+aZd1gLcAkTmyqyU7S4ZcNqWaxptYzdxc0rhmIaNBS2L42J6qtU
X-Received: by 2002:a05:600c:8712:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4b6df7d4a3dmr63330635e9.20.1793998333166;
        Fri, 06 Nov 2026 12:52:13 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:12 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 11/18] bpf: Follow PHIs in bpf_scan_ir
Date: Fri,  6 Nov 2026 21:03:00 +0000
Message-ID: <20261106210314.1767267-11-a.s.protopopov@gmail.com>
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

