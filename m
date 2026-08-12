Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E60432313
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577639; cv=none; b=CmxBSo2uTsKXRm4E7ihvKF2LG4bE7BYHuZICguO1R/KDnpTGpg5yDNKYApMunVjaC/9ZPTKK7WA4ZKcNrj75IzzU3ag3Fp1ezX1WsOJYsjSP/SOV8DVdrSHph2gNZF0VwSv1VovOrf+0z5tOkSIfrWL1x6rXJbL2iVJcn+fGg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577639; c=relaxed/simple;
	bh=RAZJ3OzDZjCnFjQLn1XYiuDaP/3gxxAPcXZtFj8G9Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5OX5/KSAl6nDzVjIj5XjIcqFsOkv+5tO788V3ho4xi00PSEuFFYfc7IP6Z2ATYt4B1E46zrHz55Lc5Gy8R+4vkCNwNaGizSoEPhXWuYpxJcxUIIxrkbzq4Bi3MLF5e8/8tDKE0i4cPYRtW3hO3+9UVP1RKPu39/rrcb9RsT7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TApr2CZr; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TApr2CZr"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4955674321eso2533045e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577635; x=1787182435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g1sdItvtdKZnvOOVRPt3rDh5KaXtUV4MypnLyWOiHhI=;
        b=TApr2CZrmwFlyLtiebb8TJvZK3ctmW2UxMiJ4Veypf/nfBUpcdy82yPH0liIeWddN8
         Nilkac9t1CZb8i5hnTnny5ydtZ+W6Y12X3XOYam2tx3fKGozSnPjOslYsY/zQad6leg/
         FVHrpNMOue/TR74Nn7R0RGZI1+7y4i7sVl5AtxgY3qLknRaIvEET1vuS4RzzKS2z6YAb
         Sxm7HqbhHSFVnbPwQEpBiJP/5Fsv97Ihk5hB9KwEQfUsQlLnW0pwEI5s/FI57HXWLQAZ
         CEK8UYI+ywP+J3/ey619uralLx4Lh0a8ZC1HatGT+L3mWI6nfoEjALKbkJzjfkWs6c4l
         S1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577635; x=1787182435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g1sdItvtdKZnvOOVRPt3rDh5KaXtUV4MypnLyWOiHhI=;
        b=iI0gwlvUIeVviDbwZkKZxXWI/dLcU5pur/yfVJBc46E2w54ytmFvmltJrgOpJjXY83
         xcqIVFakl4He8Fzy5oNjjdxeQHbezkECjWhKWL2cK6YN4Wycv7JcJL2qX71Rj48o9QN9
         svu25hdpNFgvTWFeTFQFDiEh9LEHCKQHbdW/4UlE12+o65+EEzhWjcBR+5O6iwuPvZ91
         g16cxFImkqGKG9Vg7PAwebT/1YKxD9UP+Wi+l3S1v0Vz9T/v+yS9JDePU1INy5De2Rrx
         ZVZHixAg5A2pthtq8zCODcONislRkfmb95FFfRaO2qYP1WHFGywI45kcLfpJDq2lID/i
         ll3g==
X-Gm-Message-State: AOJu0YzN/5Qaiwhhut4o9LE9QoKgJjSNnjts2eHDu16uvRPmOmXvcg9p
	diaSHpWaJGLEwCgPgKVsYupWs+n2rLvYSDADZXuzBBJR4x+aX0svAbB0XbmsXnyl
X-Gm-Gg: AR+sD13QC5rN5Y6BlREGk9vICAB8JN3kekv6MSS9AH66gT5Hzkm4cLS1eIcfBbBjnYr
	xSxh2EyofbLdHAwWdCOR7IL7FFZhK/Ec2q69kCO7sGi+7DlbFmyR8Ea24G62H5RJA6aG8LAhTbz
	a1mH4ImBgTAp7KF2X4NfZYX42vYDkSMZxVk748ILPxcaJxsNExh78qrXDryMn9NOJPnfvGHSTCd
	M6dWM8JdwPds1uyFUSCU9I+l0FkL3mSV4MRIantL53iPdITTxOPeNx4TmCv6yZsDRtDSVRrc0VQ
	J1UL7ACbV6Ykk8ABQcpbOiApQGkMI5AKMZGK48bVVCtuRvYO+8GQPUMoeZiLFfnKZV0lEqaPEN0
	cwB6bIMBQsRFOsLuucnw4YLkpRaYyRR+xQq47w3BtZUBi/G3NJ1/xBpookvHie/kYVtEi0ud4Bb
	DyF0p9hZATMXaZJXN90Ji6N+C8CHJia8E0LEO+VfwlPK2Px4Mw49JHczAqz8oBfdhYKeQZke5vN
	V3yQLNavfBMuHINJqOhiEGSX4lWPRV6e6RsrtEECtNEXf6SQPvxWbuVpCfV4J+Ws3S3agRE5z01
	ZOp94CrN4xhDAYSwxHcq65o6zJobAmVTLr6zdA==
X-Received: by 2002:a05:600c:6995:b0:494:596e:e8c4 with SMTP id 5b1f17b1804b1-499821bdcadmr14483585e9.17.1786577635048;
        Wed, 12 Aug 2026 16:33:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2837sm1343961f8f.37.2026.08.12.16.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 15/16] bpf: Report Verifier Limit errors
Date: Thu, 13 Aug 2026 01:33:18 +0200
Message-ID: <20260812233326.3575958-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11619; i=memxor@gmail.com; h=from:subject; bh=RAZJ3OzDZjCnFjQLn1XYiuDaP/3gxxAPcXZtFj8G9Qo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQU/xlOpd5VMzUstj0jIaRM993P6u+N+6lIjb294IM WQLtZzvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERmrGRk2FW0/MxWRX7Gpy/N fb7cq0soUz7/Tn17Tdb+pPyDFw2fTmL4n3K2nOem08SnacbZU3fJrp/xZXnZvqwV+79obd746va qTXwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected verifier limit failures with Verifier Limit reports. These
reports focus on the limit that was exceeded and the observed value or
condition, rather than causal branch history.

Cover tail-call stack constraints, per-subprogram stack depth, combined call
stack depth, static and runtime bpf2bpf call-frame depth, processed-instruction
complexity, and liveness analysis complexity.

Format reason text in diagnostics.c and allocate call-chain descriptions only
on failure paths, preserving useful call-chain context without adding large
local buffers to verifier frames.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c                      | 25 +++++
 kernel/bpf/diagnostics.h                      |  2 +
 kernel/bpf/liveness.c                         |  6 ++
 kernel/bpf/verifier.c                         | 97 ++++++++++++++++++-
 .../bpf/progs/test_global_func_deep_stack.c   |  1 +
 5 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 74e6f3b576ff..4d214898b2b4 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1170,6 +1170,31 @@ void bpf_diag_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *ope
 	diag_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_limit(struct bpf_verifier_env *env, u32 insn_idx, const char *limit,
+		    const char *suggestion, const char *reason_fmt, ...)
+{
+	const char *reason, *text;
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	bpf_diag_header(env, VERIFIER_LIMIT, "limit exceeded");
+	diag_section(env, "Reason");
+
+	va_start(args, reason_fmt);
+	reason = bpf_diag_vfmt(env, reason_fmt, args);
+	va_end(args);
+	text = bpf_diag_fmt(env, "The %s limit was exceeded: %s.", limit, reason);
+
+	diag_print_wrapped_text(env, text);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "limit exceeded: %s", limit);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index fc5f2812612c..ca9ecb03241a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -159,6 +159,8 @@ void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
 				       const char *reason_fmt, ...) __printf(5, 6);
 void bpf_diag_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
 		     const char *reason, const char *suggestion);
+void bpf_diag_limit(struct bpf_verifier_env *env, u32 insn_idx, const char *limit,
+		    const char *suggestion, const char *reason_fmt, ...) __printf(5, 6);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1c997aeba6fa..f39f01637ac0 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 struct per_frame_masks {
@@ -1856,6 +1858,10 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	if (++env->liveness->subprog_calls > 10000) {
 		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n",
 			env->liveness->subprog_calls);
+		bpf_diag_limit(
+			env, start, "liveness analysis complexity",
+			"Reduce the number of distinct call paths or argument patterns reaching these subprograms.",
+			"The verifier recomputed subprogram liveness too many times while tracking stack and register reads across call paths");
 		return -E2BIG;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e5319f47ccb..a14315d19866 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5252,6 +5252,38 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack */
 };
 
+static const char *bpf_diag_append_subprog_chain(struct bpf_verifier_env *env,
+						 const char *chain, int subprog)
+{
+	const char *prefix = chain && *chain ? " -> " : "";
+	const char *name = bpf_subprog_name(env, subprog);
+	const char *old = chain ?: "";
+
+	if (name && *name)
+		return bpf_diag_fmt(env, "%s%s%s", old, prefix, name);
+	return bpf_diag_fmt(env, "%s%ssubprogram %d", old, prefix, subprog);
+}
+
+static const char *bpf_diag_alloc_subprog_call_chain(struct bpf_verifier_env *env,
+						     struct bpf_subprog_call_depth_info *dinfo,
+						     int idx)
+{
+	int call_chain[MAX_CALL_FRAMES + 1];
+	int i, subprog, cnt = 0;
+	const char *chain = NULL;
+
+	for (subprog = idx; subprog >= 0 && cnt < ARRAY_SIZE(call_chain);
+	     subprog = dinfo[subprog].caller)
+		call_chain[cnt++] = subprog;
+
+	if (subprog >= 0)
+		chain = "...";
+	for (i = cnt - 1; i >= 0; i--)
+		chain = bpf_diag_append_subprog_chain(env, chain, call_chain[i]);
+
+	return chain;
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5294,9 +5326,17 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * of caller's stack as shown on the example above.
 	 */
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
+		const char *chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
 			depth);
+		bpf_diag_limit(
+			env, subprog[idx].start, "call stack with tail calls",
+			"Reduce stack usage in caller frames, or avoid combining deep bpf2bpf calls with tail calls.",
+			"Call chain %s reaches a subprogram with tail calls after caller frames already use %d bytes; "
+			"tail-call paths are limited to 256 bytes in caller frames",
+			chain ?: "the current call chain", depth);
 		return -EACCES;
 	}
 
@@ -5318,8 +5358,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
+			const char *chain;
+
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			bpf_diag_limit(
+				env, subprog[idx].start, "subprogram stack depth",
+				"Reduce stack usage in this subprogram, or move large data out of the BPF stack.",
+				"Call chain %s reaches a subprogram that uses %d bytes of stack, exceeding the %d byte limit for one BPF stack frame",
+				chain ?: "the current call chain", subprog_depth, MAX_BPF_STACK);
 			return -EACCES;
 		}
 	} else {
@@ -5333,13 +5381,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
 				total, depth);
+			{
+				const char *chain;
+
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+				bpf_diag_limit(
+					env, subprog[idx].start, "combined call stack depth",
+					"Reduce stack usage or call depth along this call chain.",
+					"Call chain %s uses %d bytes of stack across %d nested calls, exceeding the %d byte limit",
+					chain ?: "the current call chain", depth, total, MAX_BPF_STACK);
+			}
 			return -EACCES;
 		}
 	}
 continue_func:
 	subprog_end = subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		int next_insn, sidx;
+		int next_insn, call_insn, sidx;
 
 		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
 			bool err = false;
@@ -5386,6 +5444,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
 
+		call_insn = i;
 		i = next_insn;
 
 		idx = sidx;
@@ -5397,8 +5456,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
+			const char *chain;
+
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			bpf_diag_limit(
+				env, call_insn, "bpf2bpf call frames",
+				"Reduce the number of nested bpf2bpf calls on this path.",
+				"Call chain %s reaches %d static bpf2bpf call frames, exceeding the %d frame limit",
+				chain ?: "the current call chain", frame, MAX_CALL_FRAMES);
 			return -E2BIG;
 		}
 		goto process_func;
@@ -9490,6 +9557,22 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static const char *bpf_diag_alloc_state_call_chain(struct bpf_verifier_env *env,
+						   const struct bpf_verifier_state *state,
+						   int next_subprog)
+{
+	const char *chain = NULL;
+	int i;
+
+	for (i = 0; i <= state->curframe; i++)
+		chain = bpf_diag_append_subprog_chain(env, chain, state->frame[i]->subprogno);
+
+	if (next_subprog >= 0)
+		chain = bpf_diag_append_subprog_chain(env, chain, next_subprog);
+
+	return chain;
+}
+
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
@@ -9502,8 +9585,16 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	int err;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
+		const char *chain;
+
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
+		chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
+		bpf_diag_limit(
+			env, callsite, "bpf2bpf call frames",
+			"Reduce the number of nested bpf2bpf calls on this path.",
+			"Call chain %s would create %d verifier call frames, exceeding the %d frame limit",
+			chain ?: "the current call chain", state->curframe + 2, MAX_CALL_FRAMES);
 		return -E2BIG;
 	}
 
@@ -18098,6 +18189,10 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
+			bpf_diag_limit(
+				env, env->insn_idx, "processed instruction complexity",
+				"Simplify control flow, reduce branching, or split the program into smaller pieces.",
+				"The verifier explored more instructions than the complexity limit allows");
 			return -E2BIG;
 		}
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
index 1b634b543b62..621207683ce4 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -89,6 +89,7 @@ int global_func_deep_stack_success(struct __sk_buff *skb)
  */
 SEC("syscall")
 __failure __msg("combined stack size of 34 calls")
+__msg("Call chain ... -> f16")
 int global_func_deep_stack_fail(struct __sk_buff *skb)
 {
 	return f32(123);
-- 
2.53.0

