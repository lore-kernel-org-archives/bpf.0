Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31E3264DF
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677554; cv=none; b=YpDHVcSnG1nM6w2i6Z2xybAZuRID8Q/oX0rSdxzoVsIY71bKCFa28PSFf8vsGn3cqoDHjlxCeQYhTkJoAwUC8E7t0Bx40kis2qNiUb2mk+Fo41nwAcILm4aoIPTB1DYAH3zcZSMhUVua7g44GlkgUQVZiBNu4PUxFBULu5mOeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677554; c=relaxed/simple;
	bh=fZ8ujCBukviJpcAzlSVOWplrengHZEVx/lhKbHU2818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsykHouXLfh0EgOLrV0mylpSdaLutaszfzlWgNXcjSyX0mzjK+ISZv4LyLM9Ok11U4Sy/3/RFzN/Wg2h4DidpIW6sJg1Qdm0HhlufY3AtALw8n1T1a2cWEFSXerRBcswskcVvXW26/oMl1IxYR0v5hS8vayYQjDc+DsenE2Yn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0D499h2q; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0D499h2q"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a1347051aso74891076d6.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773677552; x=1774282352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAL1j+Y8j7FtwW4EflYB6EqmtKs4Ybp51YPFPdnl4vg=;
        b=0D499h2qrBTFV8oKeYtvae3ibkwuFWx4lrUWCbyys4j9Ca3xNNoCF3Y1fRCGSOEDzS
         ydv/Y7xXSrVE3GdLGqxLc+Xmioem9jxRckV7Dr4K0PIIGRsRT3i1TN2LrIOvD6bmIcSE
         o7/P3VXn9UL1/Oz3Jya5Po9bTBfAq/24vYK/n5iL04+mAigDat7fdTWIYY49mtXM4WRX
         Uel63ON6mricopuZijyycs353M/kDPW/OjvTCCvzglcrpe7XeKkS6h2AaEH9du+CeK3z
         nf4qdmXwrRK7U9wa4AOUsqJmd+3CeT1u6dJ0EkGZkbLndxy9i3n6/HDwWA1oiFxPsywU
         V5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677552; x=1774282352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAL1j+Y8j7FtwW4EflYB6EqmtKs4Ybp51YPFPdnl4vg=;
        b=aJGx3VIeeJo0b8cNSMN/z2uQqESE5V9AFeOTQWpQtPowhoyWbeZD2xnEsgN6HdQs0k
         eLlENlP1AIUBnDLe2qIfTAPpsX4t2mX03mCEB8JtgQ8ixcuuLLwBtD7gSC4olSvrLZNo
         7B2EJjCl/9D0IiZWrNVlwwOC4uMxtxIHSVaUHoB0ctAqxGXT91YrAAMDaXMmluQLll84
         HXTi3Y9bqrGzWYeYgZb/QoLkawVax4UXiTIoywVbtE34G3/2if5X6/mQw3g9o66sezgz
         DDWgz3Q/OsYITMZ1lwHmaISHhMCrmF4NmxXvtL7FOGYc87awDZksJKtOjOoRJdMxxFSy
         sCNw==
X-Gm-Message-State: AOJu0YzV70VcH027hD8ysls/UsqCs2R0zsS1dQmVdri9eCxgdM0lO2Gh
	Bw3Xwn9XNHmr1NnvGCcohQRGStjUHnQWHqo4izY99Ox+aJplfx79sKth+4GQ7x2fbC+WQqKQ1vO
	xrNNwbBk=
X-Gm-Gg: ATEYQzy4zf57iW3x7FnJrDSYUPcCss7uefyjyrTUF7nqFn6ML6cawlUqG8mwYlOxiUT
	iLIZlBPx9WRJTrHSAMq24OSWrjlywQSgCtz7p9hVOMxL2NIqIKXwpM0rKg25a1TIvFdfu1C7I7p
	SihKPn/qXqcMeFCYsNo6pc3Gcex4W3sXHVUInK/RE0+f0iJUOKyiEDazajKrI0dJCRZPPxuV1hu
	HXmJQI+cmHXpqGgbm6etDug9z69/ahVhlrOiaGVEeAziOTYBBc5J4Lgiyn/3Jc0/6zusJfqwOUm
	PU5AXnQy9/H9fZrLbtPXR4lBI4l4lTjDKVqM+hGjsBqwoT2Hr1spSsKvz2jZEa0VWuG3XTu6gGw
	G+SKuO9rrLuJF5apJzGFNlNN0SGr1BpPfVBoUhhP5+C19BUwLge7+w/6QWnqJ3SvHIDdc4V7D2Y
	FhvaO2l/bW1hCqhK8eKD7VHg==
X-Received: by 2002:a05:6214:2588:b0:899:fab4:730f with SMTP id 6a1803df08f44-89a81fd34f4mr200330446d6.49.1773677551468;
        Mon, 16 Mar 2026 09:12:31 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c463b0806sm54022626d6.49.2026.03.16.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:12:31 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v6 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
Date: Mon, 16 Mar 2026 12:12:24 -0400
Message-ID: <20260316161225.128011-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260316161225.128011-1-emil@etsalapatis.com>
References: <20260316161225.128011-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently enforces a call stack depth of 8 frames,
regardless of the actual stack space consumption of those frames. The
limit is necessary for static call stacks, because the bookkeeping data
structures used by the verifier when stepping into static functions
during verification only support 8 stack frames. However, this
limitation only matters for static stack frames: Global subprogs are
verified by themselves and do not require limiting the call depth.

Relax this limitation to only apply to static stack frames. Verification
now only fails when there is a sequence of 8 calls to non-global
subprogs. Calling into a global subprog resets the counter. This allows
deeper call stacks, provided all frames still fit in the stack.

The change does not increase the maximum size of the call stack, only
the maximum number of frames we can place in it.

Also change the progs/test_global_func3.c selftest to use static
functions, since with the new patch it would otherwise unexpectedly
pass verification.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c                         | 76 +++++++++++++------
 .../selftests/bpf/progs/test_global_func3.c   | 18 ++---
 2 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbacd2149cd..625b0189cc61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6720,22 +6720,30 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
 	return round_up(max_t(u32, stack_depth, 1), 32);
 }
 
+/* temporary state used for call frame depth calculation */
+struct bpf_subprog_call_depth_info {
+	int ret_insn; /* caller instruction where we return to. */
+	int caller; /* caller subprogram idx */
+	int frame; /* # of consecutive static call stack frames on top of stack */
+};
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
- * Since recursion is prevented by check_cfg() this algorithm
- * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
 static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
+					 struct bpf_subprog_call_depth_info *dinfo,
 					 bool priv_stack_supported)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable = false;
-	int ret_insn[MAX_CALL_FRAMES];
-	int ret_prog[MAX_CALL_FRAMES];
-	int j;
+	int total;
+	int tmp;
+
+	/* no caller idx */
+	dinfo[idx].caller = -1;
 
 	i = subprog[idx].start;
 	if (!priv_stack_supported)
@@ -6787,8 +6795,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	} else {
 		depth += subprog_depth;
 		if (depth > MAX_BPF_STACK) {
+			total = 0;
+			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
+				total++;
+
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				frame + 1, depth);
+				total, depth);
 			return -EACCES;
 		}
 	}
@@ -6802,10 +6814,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			if (!is_bpf_throw_kfunc(insn + i))
 				continue;
-			if (subprog[idx].is_cb)
-				err = true;
-			for (int c = 0; c < frame && !err; c++) {
-				if (subprog[ret_prog[c]].is_cb) {
+			for (tmp = idx; tmp >= 0 && !err; tmp = dinfo[tmp].caller) {
+				if (subprog[tmp].is_cb) {
 					err = true;
 					break;
 				}
@@ -6821,8 +6831,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
-		ret_insn[frame] = i + 1;
-		ret_prog[frame] = idx;
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
@@ -6842,7 +6850,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				return -EINVAL;
 			}
 		}
+
+		/* store caller info for after we return from callee */
+		dinfo[idx].frame = frame;
+		dinfo[idx].ret_insn = i + 1;
+
+		/* push caller idx into callee's dinfo */
+		dinfo[sidx].caller = idx;
+
 		i = next_insn;
+
 		idx = sidx;
 		if (!priv_stack_supported)
 			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
@@ -6850,7 +6867,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
 
-		frame++;
+		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -6864,12 +6881,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++) {
-			if (subprog[ret_prog[j]].is_exception_cb) {
+		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
+			if (subprog[tmp].is_exception_cb) {
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
-			subprog[ret_prog[j]].tail_call_reachable = true;
+			subprog[tmp].tail_call_reachable = true;
 		}
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable = true;
@@ -6877,23 +6894,33 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
-	if (frame == 0)
+	if (frame == 0 && dinfo[idx].caller < 0)
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	frame--;
-	i = ret_insn[frame];
-	idx = ret_prog[frame];
+
+	/* pop caller idx from callee */
+	idx = dinfo[idx].caller;
+
+	/* retrieve caller state from its frame */
+	frame = dinfo[idx].frame;
+	i = dinfo[idx].ret_insn;
+
 	goto continue_func;
 }
 
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	enum priv_stack_mode priv_stack_mode = PRIV_STACK_UNKNOWN;
+	struct bpf_subprog_call_depth_info *dinfo;
 	struct bpf_subprog_info *si = env->subprog_info;
 	bool priv_stack_supported;
 	int ret;
 
+	dinfo = kvcalloc(env->subprog_cnt, sizeof(*dinfo), GFP_KERNEL_ACCOUNT);
+	if (!dinfo)
+		return -ENOMEM;
+
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
 			priv_stack_mode = NO_PRIV_STACK;
@@ -6915,9 +6942,12 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	for (int i = env->subprog_cnt - 1; i >= 0; i--) {
 		if (!i || si[i].is_async_cb) {
 			priv_stack_supported = !i && priv_stack_mode == PRIV_STACK_ADAPTIVE;
-			ret = check_max_stack_depth_subprog(env, i, priv_stack_supported);
-			if (ret < 0)
+			ret = check_max_stack_depth_subprog(env, i, dinfo,
+					priv_stack_supported);
+			if (ret < 0) {
+				kvfree(dinfo);
 				return ret;
+			}
 		}
 	}
 
@@ -6928,6 +6958,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		}
 	}
 
+	kvfree(dinfo);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 142b682d3c2f..974fd8c19561 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -5,56 +5,56 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
 {
 	return skb->len;
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f2(int val, struct __sk_buff *skb)
 {
 	return f1(skb) + val;
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f3(int val, struct __sk_buff *skb, int var)
 {
 	return f2(var, skb) + val;
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f4(struct __sk_buff *skb)
 {
 	return f3(1, skb, 2);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f5(struct __sk_buff *skb)
 {
 	return f4(skb);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f6(struct __sk_buff *skb)
 {
 	return f5(skb);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f7(struct __sk_buff *skb)
 {
 	return f6(skb);
 }
 
-__attribute__ ((noinline))
+static __attribute__ ((noinline))
 int f8(struct __sk_buff *skb)
 {
 	return f7(skb);
 }
 
 SEC("tc")
-__failure __msg("the call stack of 8 frames")
+__failure __msg("the call stack of 9 frames")
 int global_func3(struct __sk_buff *skb)
 {
 	return f8(skb);
-- 
2.49.0

