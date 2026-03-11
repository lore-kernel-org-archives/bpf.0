Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639735CB64
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253720; cv=none; b=Wq2CQ/6v71mBlFYSuP+e0Shm4bab134LNNgK6HE75DaURDI9C4IXICuh4t/fL2//9E9OjQF+vdjeN6sb04OdiIYrnwv52zBqTzzM8puyxxJqQ4NXxVyfSGMdKZB5UlCZDcIqzKoPmJWBjd742W7nIKDi84BdPTWjS/xKeY4I4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253720; c=relaxed/simple;
	bh=y9c6bAg3AhUykaPiMjGu3y7pOS4IXshLFHAHHyNicIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeNvBOFECLR6x3KFHqBpRVjYk8wop9rP5FS6ETGABlJ+GsArMO0gc8B2l2pov4mHNpF60yGuHVHlY4W2eKVVBReRaK+bB2YLqJSmUo0ex3SH8DH3bpoBcHgXPY1gUzSDJXaLlsWoGF8/BALPC+8wfBZ4hIiY3wx/PQRWHu8eXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=v94JR0HX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="v94JR0HX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899fb2b94c1so2042156d6.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773253717; x=1773858517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8aBMjKokQOI/Vf66ycn5lNL1bGcUXOfolYf32430EU=;
        b=v94JR0HXn3lI3rjNjfeV8Qw7wb+Uv3hE+1he9DCt9yMotXAqhO0TqTGr8RNrOw8OVm
         z1dRwR2Kte86LYKIQtm4iy7Oc1v3Glb6oyoMCFSBxgb/wNkQyHUQptd3qLdp1nDGp1+L
         w4YoiJo7v6rHv4xl6NJs7HeZOeJyyTzo88V/S8tK4CcLxyCNRPuyQ27k3YCVm9rjs/0/
         UjL38xe7iRAngmAlTRhYiUkls+C8gcd6WzTTXCFkKA8ETEKifft4vyXpeEPc1vVef4yP
         4yzVqMHFl9PXlhJuesBrNAvBR1/DPZHfP4SEtTzMrXcr5AYGzdDloWWtdmhzC4p3kg31
         txWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253717; x=1773858517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8aBMjKokQOI/Vf66ycn5lNL1bGcUXOfolYf32430EU=;
        b=qMSO2jrn/aXiijRVnZvFX0FZEG5qF3/n6BrMjZsW6jVTZfpchMtL7kBWjAorKpvBAw
         r8rjZlAIFV7ZoT2AxWpjxn1JBTnQwnh7BDCw9BZIvqEOp/F4YoPt9Y6bTAoou5TgJxvT
         YqHJDDHuQ3Qk3O4kZmnqVulnMJ5m1cMyEVIHw+HymrQRh56JFGMMqbC18C80soZz/K6Z
         YyWRrmew+arsGjBtNpbMFXHPEWlToHor/pVTCLyIlWG4ezyci3lbZd8dFVMgC9ymdeSK
         enZTGlJQE7/2W0wUcYyRzN1RQpr9/WBixHtUEHj6oPOy1G9eMn2Wa53b7887/JnKEMU5
         2HqA==
X-Gm-Message-State: AOJu0YwITvm1u9Yx1G6R8oR2a6WLZ65+eBjQ/VX8L3Sg4LixCPUiKFJ7
	Oyy7f2vGit40lA6Wc4BPcevPmCEuGr1whXRPkLVnkCnWVsmVVLPGO7Vg+oWV9lllg0ggvKW5EfW
	ZnRw+
X-Gm-Gg: ATEYQzzh2N5iSKrXblFIb7yNHVbxyEgcn3BTKN4Gvj9RRE9ljs2QxFWFPXOn6ZzcDJU
	QhiDInVZAd6g5ffUgICslDY6NlXdTFN4KwdKn6jln/TQf9ZSzt93pbI6LvTucEVyM+f5mlHeSjG
	G6bHByVMmVg8tJljY8oIAwrwNNjskPXkOrTk6xRhCoa8CyOaeArkEuoMpVRiqon4zTvEh8n5xsK
	+ijNKyx24Qhx/3mnhp9Gl6duhFtnLqsOwcqLM4hZwgUjmpe4xykPyY1ZBDWz8EGuSte6IxzGMf9
	1GR7VwHE8kFsH5spBo5cqanFAOGb3As55XyhKkqnCeWkkbDzaoh+csp6qHooSRNy23kQMMRNW0x
	5sSMrm2Rsud8QbmrCcZcrEPbufxbz7pEZ0A9TdsMrL1YETcm3026J3g68nUaQJeTS8Dx4kqWDaK
	0oRydP33Ob+to+/UJULnxvHQ==
X-Received: by 2002:a05:6214:cab:b0:89a:ce8:ad9b with SMTP id 6a1803df08f44-89a669c0f65mr49660946d6.9.1773253717115;
        Wed, 11 Mar 2026 11:28:37 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm21178946d6.19.2026.03.11.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:28:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
Date: Wed, 11 Mar 2026 14:28:30 -0400
Message-ID: <20260311182831.91219-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260311182831.91219-1-emil@etsalapatis.com>
References: <20260311182831.91219-1-emil@etsalapatis.com>
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
 include/linux/bpf_verifier.h                  |  9 +++
 kernel/bpf/verifier.c                         | 62 +++++++++++++------
 .../selftests/bpf/progs/test_global_func3.c   | 18 +++---
 3 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090aa26d1c98..f31194c2f0a8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -742,6 +742,12 @@ struct bpf_scc_info {
 
 struct bpf_liveness;
 
+struct bpf_subprog_call_depth_info {
+	int ret_insn; /* caller instruction where we return to. */
+	int caller; /* caller subprogram idx */
+	int frame; /* # of consecutive static call stack frames on top of stack */
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -851,6 +857,9 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
+
+	/* temporary state used for call frame depth calculation */
+	struct bpf_subprog_call_depth_info *dinfo;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e4f69918693..7dda75c5992e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6733,9 +6733,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
+	env->dinfo[idx].caller = -1;
 
 	i = subprog[idx].start;
 	if (!priv_stack_supported)
@@ -6787,8 +6789,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	} else {
 		depth += subprog_depth;
 		if (depth > MAX_BPF_STACK) {
+			total = 0;
+			for (tmp = idx; tmp >= 0; tmp = env->dinfo[tmp].caller)
+				total++;
+
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				frame + 1, depth);
+				total, depth);
 			return -EACCES;
 		}
 	}
@@ -6802,10 +6808,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			if (!is_bpf_throw_kfunc(insn + i))
 				continue;
-			if (subprog[idx].is_cb)
-				err = true;
-			for (int c = 0; c < frame && !err; c++) {
-				if (subprog[ret_prog[c]].is_cb) {
+			for (tmp = idx; tmp >= 0 && !err; tmp = env->dinfo[tmp].caller) {
+				if (subprog[tmp].is_cb) {
 					err = true;
 					break;
 				}
@@ -6821,8 +6825,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
-		ret_insn[frame] = i + 1;
-		ret_prog[frame] = idx;
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
@@ -6842,7 +6844,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				return -EINVAL;
 			}
 		}
+
+		/* store caller info for after we return from callee */
+		env->dinfo[idx].frame = frame;
+		env->dinfo[idx].ret_insn = i + 1;
+
+		/* push caller idx into callee's dinfo */
+		env->dinfo[sidx].caller = idx;
+
 		i = next_insn;
+
 		idx = sidx;
 		if (!priv_stack_supported)
 			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
@@ -6850,7 +6861,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
 
-		frame++;
+		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
@@ -6864,12 +6875,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
 	if (tail_call_reachable)
-		for (j = 0; j < frame; j++) {
-			if (subprog[ret_prog[j]].is_exception_cb) {
+		for (tmp = idx; tmp >= 0; tmp = env->dinfo[tmp].caller) {
+			if (subprog[tmp].is_exception_cb) {
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
-			subprog[ret_prog[j]].tail_call_reachable = true;
+			subprog[tmp].tail_call_reachable = true;
 		}
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable = true;
@@ -6877,13 +6888,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
-	if (frame == 0)
+	if (frame == 0 && env->dinfo[idx].caller < 0)
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
-	frame--;
-	i = ret_insn[frame];
-	idx = ret_prog[frame];
+
+	/* pop caller idx from callee */
+	idx = env->dinfo[idx].caller;
+
+	/* retrieve caller state from its frame */
+	frame = env->dinfo[idx].frame;
+	i = env->dinfo[idx].ret_insn;
+
 	goto continue_func;
 }
 
@@ -6894,6 +6910,10 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	bool priv_stack_supported;
 	int ret;
 
+	env->dinfo = kvcalloc(env->subprog_cnt, sizeof(*env->dinfo), GFP_KERNEL_ACCOUNT);
+	if (!env->dinfo)
+		return -ENOMEM;
+
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
 			priv_stack_mode = NO_PRIV_STACK;
@@ -6916,8 +6936,10 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		if (!i || si[i].is_async_cb) {
 			priv_stack_supported = !i && priv_stack_mode == PRIV_STACK_ADAPTIVE;
 			ret = check_max_stack_depth_subprog(env, i, priv_stack_supported);
-			if (ret < 0)
+			if (ret < 0) {
+				kvfree(env->dinfo);
 				return ret;
+			}
 		}
 	}
 
@@ -6928,6 +6950,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		}
 	}
 
+	kvfree(env->dinfo);
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

