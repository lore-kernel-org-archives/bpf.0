Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCE40F8DD
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641273; cv=none; b=FyZ5Ehkpl2z6U6NAKXGMhi5swLrQfK3EQCLeXGFsN0y5tVitc1PQ+ejmjOiyiWg0Vlq0NW4v5lsr1ocf9iystH5D7OoInU9fLJmIBWTvue0qBoEwPibwx+xwKcjjinydX3b4aIpv+F93L9ikllhdywZ1mz2jGZ4uk5EOdIfLI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641273; c=relaxed/simple;
	bh=unw5O7SpVqbFcdVETmeizgULzPTTytBu1lC95INCfc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHljnoPfWOy7DIvs7gZNpB24ljyNsgsf+aZi3++xM5qG8JacDi8rlASJLx8z5uKxdYfS9cJL9OHtA7YxDny5EOLKnkIVxf+f5mWwwVjQH2cRC2tIflIZPW6GojplHqa/e1CtcM69LExodYn92BHBLlTwvNgxj8MUWqQVRMAWzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOgf61XL; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOgf61XL"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4905529b933so15158795e9.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641271; x=1781246071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L29GFi058TxdZCll7lqoGURrZ8M1xbsgZ84Ltxxpx80=;
        b=FOgf61XLuAC+GFV7RnMLlvVF+Gehmfj5H2VcYpgyNcJnrkjSAEzMHfGgmCVFJ/Lznw
         29kd5PD269BTXe2FTeba5Qunw3zlgodOsYeVHTnKhMYnaVdxSyb23n2jQtNhjUNcwXC1
         z4bY/crs1ZwEB9zYuN3BX5wNTcnllXFghvqFttMZtOFLx/cGBznx0rjg+jOMPfEfTaWa
         xWgAQuAWTaP0RK1UVvdHhi32HDgNyTF70E6J8jUYhsF0co48ygIsN/mFwEC1o1B4/4kM
         +OTrFcu6am99NOj1lU1hs9aWIODnin9Tbte5HXPjBs6+WHbz3gRVaLiHhuGWsAb2Px6V
         juPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641271; x=1781246071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L29GFi058TxdZCll7lqoGURrZ8M1xbsgZ84Ltxxpx80=;
        b=hHVjsuBj+l5s1mUjjkgEhDZ4i6N5vgXSkPcIbNUOatBVV7ROFJ2Rn7ISDGedXluxUM
         Dq6INraHHYRQg+iwiFvxSdcSYb/z0/xpcaLw/FA/2/JeNw2skFZ1m0Rpmjmu3M0vqXxe
         ygWDRHmWqbx4YaPyLgnOAlgWq4kUXcCacyEdBGhmSv88QsIjugCC8rw5hOwKYsXvMUrW
         seEUcirDItVtXf6DLpjGktAkglTMvVZCC+C5W06xVWDnrF5d/doqylR5a3zKKyrs2v6L
         6Firo4AnRnkB5HPfxg3rh+MzY4dZhNSiSPxnZ02UiVq9kkvIRyZYu2D4HaMbi1IXIKTx
         paOQ==
X-Gm-Message-State: AOJu0YwXRA1y+jmAUwJBjuUmkVlb2hqf7Eo7KWNebgagFNDXcaDpGoJN
	SB3x3uub5qnCF4lACLeLT4z45sD5v6G0/SXjPyx2s1aI8GUKUZJxUvrAHLI91A1R
X-Gm-Gg: Acq92OGrNiSrPY1ycjLfbARJWzNl48c8wQph+7oyU6yOaLdOJStDTLTOjkaWZ8vGyH8
	qxgFho2I/TWt+aL2ISneNL5JVPdaqLTg51X+xnHVw4JeAtgcSAN3mC2vvSrBMluR7uVwSesvP5S
	eyXvVyCfU+OImiDt80vIwDMO5oJrVhkC4PEehc/lcMA37gDcrJs3pVp/98mvAHQ11Av9CKz0SJ9
	u6s0nyriG7dIuKt7cLQUMgq2+5vJ+DyTXLkfic11P60Kyy8G/2scjqsV8/6HhF+st5H0Curyk1N
	X+TYhgytafAllz7qP75yIuxauu5Mk8Pu/cy2Pxbv0tK6TukLdjbupJBZVFOF80TZNxOaZgT0ISU
	J7XMFObp3S5jvwXh8uU9fsjnxVJHwR9P1ErK4NGaNaA5mn7uZ4qTit09sJvlV8lQ6QBSilyxHhA
	wH9A5oWCnN3yjZRY94serxhX3CBNvoRyJDbKmy+98jeCXDG2oWpQqaL6AC7NFGWr/S+YoNeBzqO
	V/MH6P3d57UAwz+pgf5mlDqe+dstyBoq0ef87XfubNGlZHuxGZ4IoRoRrSy1tG+uzL9cc/9xanS
X-Received: by 2002:a05:600c:6087:b0:490:c024:2eba with SMTP id 5b1f17b1804b1-490c25b06edmr28172485e9.22.1780641270698;
        Thu, 04 Jun 2026 23:34:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm132910805e9.13.2026.06.04.23.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 15/17] bpf: Report Verifier Limit errors
Date: Fri,  5 Jun 2026 08:34:05 +0200
Message-ID: <20260605063412.974640-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11169; i=memxor@gmail.com; h=from:subject; bh=unw5O7SpVqbFcdVETmeizgULzPTTytBu1lC95INCfc8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUsptzRiOofAqvozMsXmtTbZ+9/cTvove7XE5pbbxGcnP Otn/FHtKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQEbzAyTN7afiL95vHyG/lL K1IKOuc4mP7daRaU8OOVaciJEz81rzIyTEi/z7z58WVpjXaPWbtvpRifuqZ2QVdwmwqjb6sSz5Z L/AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected verifier limit failures with Verifier Limit reports.
These reports focus on the limit that was exceeded and the observed
value or condition, rather than causal branch history.

Cover tail-call stack constraints, per-subprogram stack depth, combined
call stack depth, static and runtime bpf2bpf call-frame depth, and
processed-instruction complexity.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c |  16 +++++
 kernel/bpf/diagnostics.h |   3 +
 kernel/bpf/liveness.c    |   6 ++
 kernel/bpf/verifier.c    | 131 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 8d639b498ed4..2ca398798b1e 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -936,6 +936,22 @@ void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
+			   const char *limit, const char *reason,
+			   const char *suggestion)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_VERIFIER_LIMIT,
+			       "limit exceeded");
+	bpf_diag_report_reason(env, "The %s limit was exceeded: %s.",
+			       limit, reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!', "limit exceeded: %s",
+			       limit);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index c309778fd2ff..90a584d5aa0c 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -206,6 +206,9 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
 void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
 			    const char *operation, const char *reason,
 			    const char *suggestion);
+void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
+			   const char *limit, const char *reason,
+			   const char *suggestion);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..11c50b8cc87f 100644
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
+				      "The verifier recomputed subprogram liveness too many times while tracking stack and register reads across call paths.",
+				      "Reduce the number of distinct call paths or argument patterns reaching these subprograms.");
 		return -E2BIG;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f81aad4aeb8e..c5a3b6876c68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5219,6 +5219,40 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack */
 };
 
+static void bpf_diag_format_subprog_call_chain(const struct bpf_verifier_env *env,
+					       struct bpf_subprog_call_depth_info *dinfo,
+					       int idx, char *buf, size_t size)
+{
+	int chain[MAX_CALL_FRAMES + 1];
+	int i, subprog, cnt = 0;
+	size_t len = 0;
+
+	if (!size)
+		return;
+
+	for (subprog = idx; subprog >= 0 && cnt < ARRAY_SIZE(chain);
+	     subprog = dinfo[subprog].caller)
+		chain[cnt++] = subprog;
+
+	if (!cnt) {
+		scnprintf(buf, size, "subprogram %d", idx);
+		return;
+	}
+
+	buf[0] = '\0';
+	for (i = cnt - 1; i >= 0 && len < size; i--) {
+		const char *name = subprog_name(env, chain[i]);
+
+		if (name && *name)
+			len += scnprintf(buf + len, size - len, "%s%s",
+					 len ? " -> " : "", name);
+		else
+			len += scnprintf(buf + len, size - len,
+					 "%ssubprogram %d",
+					 len ? " -> " : "", chain[i]);
+	}
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5233,6 +5267,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	bool tail_call_reachable = false;
 	int total;
 	int tmp;
+	char chain[256];
+	char reason[512];
 
 	/* no caller idx */
 	dinfo[idx].caller = -1;
@@ -5264,6 +5300,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
 			depth);
+		bpf_diag_format_subprog_call_chain(env, dinfo, idx, chain,
+						   sizeof(chain));
+		scnprintf(reason, sizeof(reason),
+			  "Call chain %s reaches a subprogram with tail calls after caller frames already use %d bytes; tail-call paths are limited to 256 bytes "
+			  "in caller frames",
+			  chain, depth);
+		bpf_diag_report_limit(env, subprog[idx].start,
+				      "call stack with tail calls",
+				      reason,
+				      "Reduce stack usage in caller frames, or avoid combining deep bpf2bpf calls with tail calls.");
 		return -EACCES;
 	}
 
@@ -5287,6 +5333,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (subprog_depth > MAX_BPF_STACK) {
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
+			bpf_diag_format_subprog_call_chain(env, dinfo, idx,
+							   chain,
+							   sizeof(chain));
+			scnprintf(reason, sizeof(reason),
+				  "Call chain %s reaches a subprogram that uses %d bytes of stack, exceeding the %d byte limit for one BPF stack frame",
+				  chain, subprog_depth, MAX_BPF_STACK);
+			bpf_diag_report_limit(env, subprog[idx].start,
+					      "subprogram stack depth",
+					      reason,
+					      "Reduce stack usage in this subprogram, or move large data out of the BPF stack.");
 			return -EACCES;
 		}
 	} else {
@@ -5300,13 +5356,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
 				total, depth);
+			bpf_diag_format_subprog_call_chain(env, dinfo, idx,
+							   chain,
+							   sizeof(chain));
+			scnprintf(reason, sizeof(reason),
+				  "Call chain %s uses %d bytes of stack across %d nested calls, exceeding the %d byte limit",
+				  chain, depth, total, MAX_BPF_STACK);
+			bpf_diag_report_limit(env, subprog[idx].start,
+					      "combined call stack depth",
+					      reason,
+					      "Reduce stack usage or call depth along this call chain.");
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
@@ -5357,6 +5423,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
 
+		call_insn = i;
 		i = next_insn;
 
 		idx = sidx;
@@ -5370,6 +5437,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
 				frame);
+			bpf_diag_format_subprog_call_chain(env, dinfo, idx,
+							   chain,
+							   sizeof(chain));
+			scnprintf(reason, sizeof(reason),
+				  "Call chain %s reaches %d static bpf2bpf call frames, exceeding the %d frame limit",
+				  chain, frame, MAX_CALL_FRAMES);
+			bpf_diag_report_limit(env, call_insn,
+					      "bpf2bpf call frames",
+					      reason,
+					      "Reduce the number of nested bpf2bpf calls on this path.");
 			return -E2BIG;
 		}
 		goto process_func;
@@ -9434,6 +9511,43 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static void bpf_diag_format_state_call_chain(const struct bpf_verifier_env *env,
+					     const struct bpf_verifier_state *state,
+					     int next_subprog, char *buf,
+					     size_t size)
+{
+	size_t len = 0;
+	int i;
+
+	if (!size)
+		return;
+
+	buf[0] = '\0';
+	for (i = 0; i <= state->curframe && len < size; i++) {
+		const char *name = subprog_name(env, state->frame[i]->subprogno);
+
+		if (name && *name)
+			len += scnprintf(buf + len, size - len, "%s%s",
+					 len ? " -> " : "", name);
+		else
+			len += scnprintf(buf + len, size - len,
+					 "%ssubprogram %d",
+					 len ? " -> " : "",
+					 state->frame[i]->subprogno);
+	}
+
+	if (next_subprog >= 0 && len < size) {
+		const char *name = subprog_name(env, next_subprog);
+
+		if (name && *name)
+			scnprintf(buf + len, size - len, "%s%s",
+				  len ? " -> " : "", name);
+		else
+			scnprintf(buf + len, size - len, "%ssubprogram %d",
+				  len ? " -> " : "", next_subprog);
+	}
+}
+
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
@@ -9443,11 +9557,22 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			    struct bpf_verifier_state *state)
 {
 	struct bpf_func_state *caller, *callee;
+	char chain[256];
+	char reason[512];
 	int err;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
+		bpf_diag_format_state_call_chain(env, state, subprog, chain,
+						 sizeof(chain));
+		scnprintf(reason, sizeof(reason),
+			  "Call chain %s would create %d verifier call frames, exceeding the %d frame limit",
+			  chain, state->curframe + 2, MAX_CALL_FRAMES);
+		bpf_diag_report_limit(env, callsite,
+				      "bpf2bpf call frames",
+				      reason,
+				      "Reduce the number of nested bpf2bpf calls on this path.");
 		return -E2BIG;
 	}
 
@@ -18099,6 +18224,10 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
+			bpf_diag_report_limit(env, env->insn_idx,
+					      "processed instruction complexity",
+					      "The verifier explored more instructions than the complexity limit allows",
+					      "Simplify control flow, reduce branching, or split the program into smaller pieces.");
 			return -E2BIG;
 		}
 
-- 
2.53.0

