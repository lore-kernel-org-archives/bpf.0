Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5143B3C3
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957174; cv=none; b=Sxao5utR/RpLsq3VZjp0RLwKNu+RvAioAVyaisCkBVq7Ymus8ZLy4Zm3IhYDF8X4cqEJ9gqXzuN+gCySKMyhbV4naSfgpaifIgY88S8lPb87/69Jh2ZIWnmDRv2wNXxBhRyPj01QJG0dkGXLzKmp6mNtLznJtVtmbip0VwO/lLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957174; c=relaxed/simple;
	bh=sonBAX87yd6OCXfuconfeoiiWrvFwmaEJUPftE//TC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5QfzHzODzspmb8uqk8VKoR4ZlUMXJ1IeDWra1gKHVnbk97gpAv6oEcoPRYaYubEyyEJH3lBqBCKmMtmvVWG1mjIEtBee/jbeigd30XRPk3QeZPoix6F81lkeBttB13HnTRafdHX86ZBW3zW60XcpAkWh6Sw9fE/qKckfNEk2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvnRmkx8; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvnRmkx8"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-493e61727d9so252815e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957171; x=1784561971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhIlYmF8AwEc29joOMq6hwPHJ7AoCluw4YQOLlsaQx4=;
        b=nvnRmkx8jcwkG+bfznS9z+Q43aWzj0XPvxe4+3fZxriqRNUAW62dIKisjonw8k0K0V
         ydNrfrg/LDnUQ0HyqDCsv5vuBdST22dqLWyTeN7Eaxsv4LCRRZVM0iSMms+s5pozU9nl
         k+PKpN8oi6ErpRhfAKYQq6TRY7r0gkXTfqVHiU9UvyzoSn9mAvL+Yxm6pnFRm7VinG19
         J3pk7xJsmOwXYNTFhUpHHFznviHIzuDBQBLuqa4Ar+Y3+gYv1+ZRWs8pIrLPVo2xbAXX
         mk9I3W2avWks+dLEA9dDFr15aPzdVgp2uI28Xx20GPpSP4vYZ3f8apEOpeUvJ9+5PX8K
         w/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957171; x=1784561971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhIlYmF8AwEc29joOMq6hwPHJ7AoCluw4YQOLlsaQx4=;
        b=tJD9r2riJHLTzmKTsGLOyjeqJYir+QnheSq8fwV+A+mDtaXNYEXUoOOinlkiDbZmWu
         xl1HT/lWvVr/9X10241tbUHfhM10MOrq9u606MlIoMV8troyvTaF955wmKrfgZKgw5eu
         gEV6s0OH6zBFXJS1linyAj1s/QCI67Gu34Wjeq0hlxkVH0UcwamYCWuAAl0wSUEd7kK7
         wYs47SZWgRl6pHeHxy6dH7etD2HSCT5yKXH9E5Odf1Zj5ufhDIi0L9hQq3ZZE0hovfe1
         5mVM9mSs0Squ8j/CbjtsRiEmIn4+tWwdC/DsTsCUkOVyx1OWbiQWLO4sFXkZD1Q9UzA+
         uEtg==
X-Gm-Message-State: AOJu0Yx6QOahDWMLb2uKgLGj4rOH4aiAhiAtrXtzgvpRGq6vcsCj6duw
	BrDQj+Du5lpaqabvQW0Lq/Lk67zgdMkre7n1TTn5h3lPTqEkJK6jmimjZizG1U58
X-Gm-Gg: AfdE7cleJ28GF/5fDw+CfDyfXAsjMe86RyCgi48cGanKhU6135yzIZqmfQNCUOCDbHC
	rTv8YSpyQvN142AoNejZpZBjfALejmXhtqYuYbgWF1fTF4+bQZxRUfZKTaqvnAscvPcWxJOohtY
	TRefGNbnJmi5/zf4LEDZi5SKzISyMfXuEhrt0RTwjD0cUh9QK/ToZkcAhh267vAg+7dnPGybTy4
	mQWjQKbrRl1gcHVKP1GLxsfx1TDQ8bhd2ROpa1TV3TafI9dmo/cvnpdokL5DJO+g41BbhdntRuN
	lxXwkGAwBfLiLRFE6yqUMH/pb+lgyM6XrFjNuGK+jt/zZsB+QT52CVL5qPCh1/CRcsgVX+W0KCL
	xxiacpbf9kHIdP5XWHZI69zaBg9I9g6+owNVicEU+yTG6chl/JefcUQjSOGlVOcSxk7hE30iLjz
	x5aawXLS9phPIjoua6/I66XAxLiVsnjMwvbRnB8i1ZarhuBooo3CQTLrL5ZEJk1sfyM81MUtcJK
	DjiX73C+E8vLyny6uHJsQMzhIJXY8HOdv7IaiudCycCiqH3sriUL9aPHuZJWCb7mQ==
X-Received: by 2002:a05:600d:8444:20b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-493f87d8909mr80386435e9.6.1783957170930;
        Mon, 13 Jul 2026 08:39:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2ed840sm3658165e9.10.2026.07.13.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/17] bpf: Report Verifier Limit errors
Date: Mon, 13 Jul 2026 17:39:04 +0200
Message-ID: <20260713153910.2556007-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11880; i=memxor@gmail.com; h=from:subject; bh=sonBAX87yd6OCXfuconfeoiiWrvFwmaEJUPftE//TC8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURcnt5KIdxmpTu/rjHM/Wspe29GTxHj689cgVxb//n k5wmC/YUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIm8t2P4xTS5NTVXh0Uh4131 hkzBxR9i+39LlO608f3s4pZddY2Bg5HhZuPf2U7u/u0b7is6m1pNWn7R6rk0j0ido7j2uUUn51/ gBgA=
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
 kernel/bpf/diagnostics.c |  37 ++++++++++++
 kernel/bpf/diagnostics.h |   2 +
 kernel/bpf/liveness.c    |   7 +++
 kernel/bpf/verifier.c    | 119 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 8bf5aef0315b..e2772c1deaff 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1309,6 +1309,43 @@ void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx, const ch
 	diag_report_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx, const char *limit,
+			   const char *suggestion, const char *reason_fmt, ...)
+{
+	char *reason, *text;
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	bpf_diag_report_header(env, CATEGORY_VERIFIER_LIMIT, "limit exceeded");
+	diag_report_section(env, "Reason");
+
+	va_start(args, reason_fmt);
+	reason = kvasprintf(GFP_KERNEL_ACCOUNT, reason_fmt, args);
+	va_end(args);
+	if (!reason) {
+		diag_write(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
+		goto source;
+	}
+
+	text = kasprintf(GFP_KERNEL_ACCOUNT, "The %s limit was exceeded: %s.", limit, reason);
+	kfree(reason);
+	if (!text) {
+		diag_write(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
+		goto source;
+	}
+
+	diag_print_wrapped_text(env, text);
+	kfree(text);
+
+source:
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "limit exceeded: %s", limit);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 64ab9de2bbf6..6a013f1e748b 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -173,6 +173,8 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env, u32 insn_id
 				       const char *reason_fmt, ...) __printf(5, 6);
 void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
 			    const char *reason, const char *suggestion);
+void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx, const char *limit,
+			   const char *suggestion, const char *reason_fmt, ...) __printf(5, 6);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..9003be0e5fb8 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 struct per_frame_masks {
@@ -1862,6 +1864,11 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	if (++env->liveness->subprog_calls > 10000) {
 		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n",
 			env->liveness->subprog_calls);
+		bpf_diag_report_limit(env, start, "liveness analysis complexity",
+				      "Reduce the number of distinct call paths or argument "
+				      "patterns reaching these subprograms.",
+				      "The verifier recomputed subprogram liveness too many times "
+				      "while tracking stack and register reads across call paths");
 		return -E2BIG;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c67646f98134..552b3d4dd5ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5431,6 +5431,42 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack */
 };
 
+static char *bpf_diag_append_subprog_chain(const struct bpf_verifier_env *env, char *chain,
+					   int subprog)
+{
+	const char *prefix = chain && *chain ? " -> " : "";
+	const char *name = bpf_verifier_subprog_name(env, subprog);
+	const char *old = chain ?: "";
+	char *next;
+
+	if (name && *name)
+		next = kasprintf(GFP_KERNEL_ACCOUNT, "%s%s%s", old, prefix, name);
+	else
+		next = kasprintf(GFP_KERNEL_ACCOUNT, "%s%ssubprogram %d", old, prefix, subprog);
+	if (!next)
+		return chain;
+
+	kfree(chain);
+	return next;
+}
+
+static char *bpf_diag_alloc_subprog_call_chain(const struct bpf_verifier_env *env,
+					       struct bpf_subprog_call_depth_info *dinfo, int idx)
+{
+	int call_chain[MAX_CALL_FRAMES + 1];
+	int i, subprog, cnt = 0;
+	char *chain = NULL;
+
+	for (subprog = idx; subprog >= 0 && cnt < ARRAY_SIZE(call_chain);
+	     subprog = dinfo[subprog].caller)
+		call_chain[cnt++] = subprog;
+
+	for (i = cnt - 1; i >= 0; i--)
+		chain = bpf_diag_append_subprog_chain(env, chain, call_chain[i]);
+
+	return chain;
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5473,9 +5509,19 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * of caller's stack as shown on the example above.
 	 */
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
+		char *chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
 			depth);
+		bpf_diag_report_limit(env, subprog[idx].start, "call stack with tail calls",
+				      "Reduce stack usage in caller frames, or avoid combining "
+				      "deep bpf2bpf calls with tail calls.",
+				      "Call chain %s reaches a subprogram with tail calls after "
+				      "caller frames already use %d bytes; tail-call paths are "
+				      "limited to 256 bytes in caller frames",
+				      chain ?: "the current call chain", depth);
+		kfree(chain);
 		return -EACCES;
 	}
 
@@ -5497,8 +5543,20 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
+			char *chain;
+
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			bpf_diag_report_limit(env, subprog[idx].start, "subprogram stack depth",
+					      "Reduce stack usage in this subprogram, or move "
+					      "large data out of the BPF stack.",
+					      "Call chain %s reaches a subprogram that uses %d "
+					      "bytes of stack, exceeding the %d byte limit for one "
+					      "BPF stack frame",
+					      chain ?: "the current call chain", subprog_depth,
+					      MAX_BPF_STACK);
+			kfree(chain);
 			return -EACCES;
 		}
 	} else {
@@ -5512,13 +5570,28 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
 				total, depth);
+			{
+				char *chain;
+
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+				bpf_diag_report_limit(env, subprog[idx].start,
+						      "combined call stack depth",
+						      "Reduce stack usage or call depth along this "
+						      "call chain.",
+						      "Call chain %s uses %d bytes of stack across "
+						      "%d nested calls, exceeding the %d byte "
+						      "limit",
+						      chain ?: "the current call chain", depth,
+						      total, MAX_BPF_STACK);
+				kfree(chain);
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
@@ -5569,6 +5642,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
 
+		call_insn = i;
 		i = next_insn;
 
 		idx = sidx;
@@ -5580,8 +5654,19 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
+			char *chain;
+
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			bpf_diag_report_limit(env, call_insn, "bpf2bpf call frames",
+					      "Reduce the number of nested bpf2bpf calls on this "
+					      "path.",
+					      "Call chain %s reaches %d static bpf2bpf call "
+					      "frames, exceeding the %d frame limit",
+					      chain ?: "the current call chain", frame,
+					      MAX_CALL_FRAMES);
+			kfree(chain);
 			return -E2BIG;
 		}
 		goto process_func;
@@ -9851,6 +9936,22 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static char *bpf_diag_alloc_state_call_chain(const struct bpf_verifier_env *env,
+					     const struct bpf_verifier_state *state,
+					     int next_subprog)
+{
+	char *chain = NULL;
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
@@ -9863,8 +9964,18 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	int err;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
+		char *chain;
+
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
+		chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
+		bpf_diag_report_limit(env, callsite, "bpf2bpf call frames",
+				      "Reduce the number of nested bpf2bpf calls on this path.",
+				      "Call chain %s would create %d verifier call frames, "
+				      "exceeding the %d frame limit",
+				      chain ?: "the current call chain", state->curframe + 2,
+				      MAX_CALL_FRAMES);
+		kfree(chain);
 		return -E2BIG;
 	}
 
@@ -18597,6 +18708,12 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
+			bpf_diag_report_limit(env, env->insn_idx,
+					      "processed instruction complexity",
+					      "Simplify control flow, reduce branching, or split "
+					      "the program into smaller pieces.",
+					      "The verifier explored more instructions than the "
+					      "complexity limit allows");
 			return -E2BIG;
 		}
 
-- 
2.53.0

