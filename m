Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A523D092F
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902805; cv=none; b=Rd8KN31bWfFd7urSHQZBIKw2Ch3NUptuA3jq6al/hQPhk2KUeepvDbJo+bMDqpKewU5VI1biwpHUda3WYEFfbQP/Dc6I+pJXZZQrLTvxvGd88N5ct4lEuFBAdegNZ6x6vcsW3eVKpyF5yodkDl+pqOp/WUB5xCNV9AQ4bC4Jak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902805; c=relaxed/simple;
	bh=/nZDJv0bFXeEoxx9+Xj085FP/bTUCg+82rDGsA9BiqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKYTL+kH5hpVR3Wi/ob/+AEY9ZXnPahP6pBJX21svBSnSPjrtyn2WtYllJyv4XSsywsgQPiOT9YI6Qs7j2SODNkBZ6WVqn/+3V6MqrrPpW/V1/jWMKgdjRlRIFDjk1ewEmN11FsmsPxUfcPRJANWOf74Q4JuozHalNiz9cQGolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTsMk4nV; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTsMk4nV"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so14818845e9.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902791; x=1782507591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzpYme0MTUmnD3Ic0Z6vIDmaeTfyw6437115UXCL9bQ=;
        b=LTsMk4nVoBpGqM14p3gpCzUJ+nmayqorcnDNMih3wiw+FbpXpIOkwdKdYnaiicjAMB
         6oiDhhNunVa4C87jAdod5rXV20s9vIULlS/hGyvVEvaup8nqLB+DR+LjzjFnC98y9DJX
         mwOHkWkweHIaNBir1W4fEVoTxlT3eUttOu8WuoGLeNb3UPenJ6TYWfKSKjX972DmYb70
         q1QE4Yu7igaDqrJQG592eiokroIhDm/AGGn5JLe1vn+vjh71EXb7y6W21gJlAIwp6493
         0sGx+WRzuycrCCa1PbxbxwfLl+1OzOZz1LG+nmlXsspCLJYtlqZkGLNg4Iq1DxkE3ilx
         3KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902791; x=1782507591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzpYme0MTUmnD3Ic0Z6vIDmaeTfyw6437115UXCL9bQ=;
        b=EpVu0k0FC1K40udIGhNEoqEUl/S8dWPlgmKAWJOD1AizgPit+HbKm9yMNQCVwmTzKN
         Le4Ofb3VS7geBDK8y8f6AHfUfIGU7NNoulVK+Ip8aBp2oSyQ/0t+onWOQ0ZXCDlS+fu1
         kJa8Igxof1g0dGc6POuAIpXgEB7O73918e/tK0Zgya2oLOvGrNBAN/GP32V90zHLhv2e
         +265Yy2DFVKR0zeBzUTS1oL68rdb1RqOHdCdKfHHdEw4mZSwYIV5FOStizbglbY+0wXz
         tDn9nbc3AoER/A93CN2AZo1wSLfo2VwdJQhRuS3FiRKT9CcYqRyV5kq+ywSgE8LeQ5YB
         aEtA==
X-Gm-Message-State: AOJu0Yy9AbiUNJRoj5VkXJIAOwfeDLXZaocbjFEJTDcCz1lOKUwDAkX6
	MtL1t27PoJl65roS2IGef5Wd31QbyHfdGNx35Dk0RBuqPGalev1fMW/QzrnA6SRu
X-Gm-Gg: AfdE7ck5Xgg7vPK6gHuNfphq9jWn1Y6DFm9XNVXl3USAeYNG0C8DQYn6VN0DTBn4vWO
	wG/UxTSGzE+S83oY9UPyAdi2oxVzWSD2XHIkoktdpgzl/N2MhItpvbr6mTK+m02cOf0UNsO3fO6
	ZHC67uOXP11Eh6+XUs4cjU2f1fPAV8txQNrYjSpqPctYqqkHbFnhc+qrrwZh65lXdZjFMCcCWSG
	1NUyfetHob8El7WrMR+pbwf4uh3PD8wbuHZckRzZsiS7z+Yi4ab5y1ghSItP7sa04CEXWF8NBTP
	PlIUiH6JbMBn4eHpnOl81ZAEnu3FOTvc2ueghfQVlnRrDmSnxFr0WYTco2eupee+ZLKQL4WXvmi
	zqLgHe6fCZpSUZwuXf038BNINF0TQwBqckxVNNPI7HgCsQzGD4JgsFaM4Nwy/RlRw3H83iEVdew
	XKUcjhEdzMwYAJmoCa/Np4BWxBeDVNChKGHpv8Nt6xBwZvo2jGIRRsOv88+bXWsWL8IOiq1Os2f
	TpjNBjl2mWbjLzqKrc4A1CFkN5QV6imsywIx40ku/Y7j9UtZt9pAI8=
X-Received: by 2002:a05:600c:58c2:b0:490:b473:8f78 with SMTP id 5b1f17b1804b1-4923f578b48mr72413895e9.17.1781902790861;
        Fri, 19 Jun 2026 13:59:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249455302sm11498535e9.15.2026.06.19.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 15/17] bpf: Report Verifier Limit errors
Date: Fri, 19 Jun 2026 22:59:28 +0200
Message-ID: <20260619205934.1312876-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11566; i=memxor@gmail.com; h=from:subject; bh=/nZDJv0bFXeEoxx9+Xj085FP/bTUCg+82rDGsA9BiqI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FaN539xYxvcxnZGunIfXlJ84NHW/oaSw9L1ylYKOv 57vbxzuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERuPWX4Z/Vg7UVZvWezWrRs 10xbsd7v2NrT7nUHpketPtttkrBT7DrD/6D+fh8F1QunJy1+/sGqscR2Sdei0jkZj7RunYyxmb0 9mBkA
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
 kernel/bpf/diagnostics.c |  40 ++++++++++++++
 kernel/bpf/diagnostics.h |   4 ++
 kernel/bpf/liveness.c    |   6 +++
 kernel/bpf/verifier.c    | 114 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index f199a6eeea54..18217f5f709a 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1155,6 +1155,46 @@ void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
+			   const char *limit, const char *suggestion,
+			   const char *reason_fmt, ...)
+{
+	char *reason, *text;
+	va_list args;
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_VERIFIER_LIMIT,
+			       "limit exceeded");
+	bpf_diag_report_section(env, "Reason");
+
+	va_start(args, reason_fmt);
+	reason = kvasprintf(GFP_KERNEL_ACCOUNT, reason_fmt, args);
+	va_end(args);
+	if (!reason) {
+		bpf_diag_write(env, "%s<failed to allocate diagnostic text>\n",
+			       BPF_DIAG_TEXT_INDENT);
+		goto source;
+	}
+
+	text = kasprintf(GFP_KERNEL_ACCOUNT, "The %s limit was exceeded: %s.",
+			 limit, reason);
+	kfree(reason);
+	if (!text) {
+		bpf_diag_write(env, "%s<failed to allocate diagnostic text>\n",
+			       BPF_DIAG_TEXT_INDENT);
+		goto source;
+	}
+
+	bpf_diag_print_wrapped_text(env, text);
+	kfree(text);
+
+source:
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "limit exceeded: %s", limit);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 99f82292a740..559c0169062c 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -224,6 +224,10 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
 void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
 			    const char *operation, const char *reason,
 			    const char *suggestion);
+void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
+			   const char *limit, const char *suggestion,
+			   const char *reason_fmt, ...)
+		__printf(5, 6);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..288d47b6a408 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 struct per_frame_masks {
@@ -1862,6 +1864,10 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	if (++env->liveness->subprog_calls > 10000) {
 		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n",
 			env->liveness->subprog_calls);
+		bpf_diag_report_limit(env, start,
+				      "liveness analysis complexity",
+				      "Reduce the number of distinct call paths or argument patterns reaching these subprograms.",
+				      "The verifier recomputed subprogram liveness too many times while tracking stack and register reads across call paths");
 		return -E2BIG;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7938c51eb454..ec51e0c81053 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5277,6 +5277,46 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack */
 };
 
+static char *bpf_diag_append_subprog_chain(const struct bpf_verifier_env *env,
+					   char *chain, int subprog)
+{
+	const char *prefix = chain && *chain ? " -> " : "";
+	const char *name = subprog_name(env, subprog);
+	const char *old = chain ?: "";
+	char *next;
+
+	if (name && *name)
+		next = kasprintf(GFP_KERNEL_ACCOUNT, "%s%s%s",
+				 old, prefix, name);
+	else
+		next = kasprintf(GFP_KERNEL_ACCOUNT, "%s%ssubprogram %d",
+				 old, prefix, subprog);
+	if (!next)
+		return chain;
+
+	kfree(chain);
+	return next;
+}
+
+static char *
+bpf_diag_alloc_subprog_call_chain(const struct bpf_verifier_env *env,
+				  struct bpf_subprog_call_depth_info *dinfo,
+				  int idx)
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
@@ -5319,9 +5359,17 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * of caller's stack as shown on the example above.
 	 */
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
+		char *chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
 			depth);
+		bpf_diag_report_limit(env, subprog[idx].start,
+				      "call stack with tail calls",
+				      "Reduce stack usage in caller frames, or avoid combining deep bpf2bpf calls with tail calls.",
+				      "Call chain %s reaches a subprogram with tail calls after caller frames already use %d bytes; tail-call paths are limited to 256 bytes in caller frames",
+				      chain ?: "the current call chain", depth);
+		kfree(chain);
 		return -EACCES;
 	}
 
@@ -5343,8 +5391,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
+			char *chain;
+
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			bpf_diag_report_limit(env, subprog[idx].start,
+					      "subprogram stack depth",
+					      "Reduce stack usage in this subprogram, or move large data out of the BPF stack.",
+					      "Call chain %s reaches a subprogram that uses %d bytes of stack, exceeding the %d byte limit for one BPF stack frame",
+					      chain ?: "the current call chain",
+					      subprog_depth, MAX_BPF_STACK);
+			kfree(chain);
 			return -EACCES;
 		}
 	} else {
@@ -5358,13 +5416,25 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
 				total, depth);
+			{
+				char *chain;
+
+				chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+				bpf_diag_report_limit(env, subprog[idx].start,
+						      "combined call stack depth",
+						      "Reduce stack usage or call depth along this call chain.",
+						      "Call chain %s uses %d bytes of stack across %d nested calls, exceeding the %d byte limit",
+						      chain ?: "the current call chain",
+						      depth, total, MAX_BPF_STACK);
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
@@ -5415,6 +5485,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
 
+		call_insn = i;
 		i = next_insn;
 
 		idx = sidx;
@@ -5426,8 +5497,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
+			char *chain;
+
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
+			chain = bpf_diag_alloc_subprog_call_chain(env, dinfo, idx);
+			bpf_diag_report_limit(env, call_insn,
+					      "bpf2bpf call frames",
+					      "Reduce the number of nested bpf2bpf calls on this path.",
+					      "Call chain %s reaches %d static bpf2bpf call frames, exceeding the %d frame limit",
+					      chain ?: "the current call chain",
+					      frame, MAX_CALL_FRAMES);
+			kfree(chain);
 			return -E2BIG;
 		}
 		goto process_func;
@@ -9646,6 +9727,24 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static char *
+bpf_diag_alloc_state_call_chain(const struct bpf_verifier_env *env,
+				const struct bpf_verifier_state *state,
+				int next_subprog)
+{
+	char *chain = NULL;
+	int i;
+
+	for (i = 0; i <= state->curframe; i++)
+		chain = bpf_diag_append_subprog_chain(env, chain,
+						      state->frame[i]->subprogno);
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
@@ -9658,8 +9757,17 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	int err;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
+		char *chain;
+
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
+		chain = bpf_diag_alloc_state_call_chain(env, state, subprog);
+		bpf_diag_report_limit(env, callsite, "bpf2bpf call frames",
+				      "Reduce the number of nested bpf2bpf calls on this path.",
+				      "Call chain %s would create %d verifier call frames, exceeding the %d frame limit",
+				      chain ?: "the current call chain",
+				      state->curframe + 2, MAX_CALL_FRAMES);
+		kfree(chain);
 		return -E2BIG;
 	}
 
@@ -18370,6 +18478,10 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
+			bpf_diag_report_limit(env, env->insn_idx,
+					      "processed instruction complexity",
+					      "Simplify control flow, reduce branching, or split the program into smaller pieces.",
+					      "The verifier explored more instructions than the complexity limit allows");
 			return -E2BIG;
 		}
 
-- 
2.53.0

