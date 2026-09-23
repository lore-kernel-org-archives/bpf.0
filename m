Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A214563FA4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190730; cv=none; b=vCV1s+vkcn8o2fc05EwF4y2wfJrjy3Lg5TqJaMi40DXVvW+3X695sq4RCqMHExjjsnQKctZmMvPlsDAywe95DChUorqK0e4Av9STLmPPXZBkLROa650SrkEMLC6oVxKVqeiPKRCL31ur7l67QvsuDmXEMJaT0RV8OxUdx3mZ2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190730; c=relaxed/simple;
	bh=mPIfPgxE4R3dVYRlZKldhuaSZs3nG0O8aMjDG9BgxjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAPwxri9avTthyXYtNi1me6V+f8QrI1nzN4MVuzQoEXAhIqwfk6OzFXGeWyMKAvkCWVKl1dFsADzX1tq+Z9XD3qIrBWh7jK8YEq7KkDjfELvErEwqGYuCQbDcKIKn/XAKya/LtUmLc9bkxD8Ub+GsEr36stfsuCYI2GyGrGj9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUOFFfEv; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUOFFfEv"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4843169420fso426266f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190727; x=1790795527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+Q3NBS84YTmcBbxTzgwe1euIdIUB/bHcVLm6STuVio=;
        b=kUOFFfEvcyipVjSPSUaK2KdKkZSev1JG0lJE+x++rj9OaQOdheW+7VxwQjBc2JR2uN
         FKRZbAQWAtB2PCS484LSCSb+Nu/JkztFpDL+Ub0Tg3uepPkYepr9CMcnVqXaC0ZnOL7/
         il2lyCQIltW7aC3Rvn/6tKP+W/XyMO6O60HrRjmNHi4EHtbZht9DTWg654hhwTQXxd67
         wZXkOEksB/aIN0u939F0g0Pm1B99RmfuUfhxlj7ADIjb70YaduIeXjMNLke9W3lQRmcu
         XbnPQMSvkb5ppGYPVNrbW/IHiLQ9Vi/rsTjPIDtInGXjzCwdIyKZGHAoxwvdLo9X519Y
         Oo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190727; x=1790795527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+Q3NBS84YTmcBbxTzgwe1euIdIUB/bHcVLm6STuVio=;
        b=0tXiwtxPXlBfoFM9AHGQQPpYMJbf7kpQPYeVdXihxO4E1oHnl4v1OYvDnzUrkgeorb
         gzSd1gYGBNTJdeOO9OQwiaWoqxNxGLPsGz+CNjElFdZAZsfQ7hmB+niP9fwtmvTGErGn
         Px+D80i9f9jOyJ2g3uZ0VkNNCNN83CjIqd7ZEC4dhIGi5+BCiOvsrWvj9UFF+97C4Lhq
         ExTBXQe73rC52N73T5NUxUWHOlizR/3179ea1W13fiiuRLmIj1NqVsXDOtZ8ere+VNYZ
         C5RJPOlvRRw2L85sR8YYeASPgIqU1YqD4fLSfLduTmRdtYUSobdjGEVSBJTynfgrM8r9
         rlkg==
X-Gm-Message-State: AFuF++ka9bTHCR70MNlLJF4CJZLyS+jdw+6L4+zw3zAh92pjfb4fuuiH
	1rlnSoL3AFi5Boxl4kc7F4+2Anc+RkkaObN6S4+tvMTbeckM5Td+VitI7P5K6E7f
X-Gm-Gg: AYBFou0/D1qIYxAUQJM0PwqSKP0AWBh/Jb2li8fSM+0pYJvYx1Q2yq5guCQCF3ypzD6
	eq00Sq64LgImdMohT/7yToAV+TL3xZ8N604vjD89tSoHK6GQKpFwtNrEy1j03tex9eNtnJtNcP2
	/0PbaNB8oEoRgV63llyM18Wz/+PF9sMuZZgynkJPQg07ocem031UkneKCcUB4T39oq3GW5h/aFX
	GzScATskdvwAjoRBIOFi7NuOhH6yIW1zG8ugL2FAC5MS5at7qB0QwlCzSaYxeTgpP5bGyFyGorX
	3YLOajhpOa15MI1O7W+iYxgChmF+InKWKzN5d+Rk2ucpgDfR3XI84s6GI5gz/MQX4P+viP87X0x
	h38JtYg+yq1+IO76FSfshZOusa/yFOAM06fGgYs7/t/El6EjjhaokrSv2hflIEz4bXUoZm1eLgs
	K9resx87zy89b9HvaUNJCdcF6zjB7s01STlhxfRHDoaw+DqgzgWB3x+M5pRYRkjHPHY1ouJtllq
	ppSiwvOJWi/mqHvnn7JATKX4dGjzvb5B7OebEh2z2Vg/MftkKm7AT2jZPx6TqNB3MkyuO/P2ZfK
	1SsPwpPw/4w4KyxZmN8qDXNkcfTsMYPfLv/0y1MNzkPcuoH3hzA2SEmLmkc=
X-Received: by 2002:a05:6000:41ca:b0:487:bef:31a8 with SMTP id ffacd0b85a97d-48871661cdemr245393f8f.0.1790190726453;
        Wed, 23 Sep 2026 12:12:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688856f0sm8382938f8f.30.2026.09.23.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/18] bpf: Bound program stack use by a per-program limit
Date: Wed, 23 Sep 2026 21:11:20 +0200
Message-ID: <20260923191139.2816206-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17021; i=memxor@gmail.com; h=from:subject; bh=mPIfPgxE4R3dVYRlZKldhuaSZs3nG0O8aMjDG9BgxjM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4veZL4pk1pz4f0XYZ0LY/JuJavcrTq3UXWPhonqzY 2c/n5luRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy1JCR4cnkuTOCAmccjmOd cG3K/xnPSj7/Ka7LO7PkWKmk8dO3XZEM/7M2L186a//ErKbEDf6JjdwVb3g9nrYd8j/reN10Y+1 FQXYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier checks every stack access and the combined depth of a call
chain against MAX_BPF_STACK, which is also the frame size of the
interpreter and the frame that JITs without subprogram tail call
support set up for tail-call targets. A JIT that lays out frames of any
size and lets a tail-called program set up its own frame does not need
that limit; it only needs the verifier to bound how much stack a
program uses in total.

Add bpf_jit_supports_large_stack() for a JIT to claim that, and give
each program its budget through bpf_prog_stack_limit(): MAX_BPF_STACK_JIT
when the JIT is requested, the program is not offloaded and the JIT
supports large stacks as well as tail calls from subprograms,
MAX_BPF_STACK otherwise. The latter is what lets a tail-called program
set up its own frame: without it, do_misc_fixups() gives every program
with tail calls a MAX_BPF_STACK frame, which a deeper frame verified
against the larger budget would overrun. The verifier keeps the budget
in env->stack_limit and uses it for the bounds of fixed and variable
offset stack accesses, for unprivileged stack pointer arithmetic and its
speculation limit, and for the combined and private stack depth checks.
A frame may use any part of its program's budget. The interpreter paths
keep MAX_BPF_STACK: a program whose main frame is deeper falls back to
the JIT-required path of bpf_prog_select_runtime() and one with deeper
subprogram frames is rejected when patching calls for the interpreter.
The extra stack that may_goto and the timed may_goto instrumentation
add below a frame is, as before, not counted against the budget of a
JITed program and rejected past MAX_BPF_STACK for an interpreted one.

Stack liveness treats a read through a pointer of unknown offset, or a
call passing a frame pointer to a subprogram, as reaching the whole
frame, and widens the masks of that frame to the deepest half-slot such
a read can cover. Bound that by the program's budget too: no access
past it is accepted, so a program kept at MAX_BPF_STACK carries masks
of two words for such frames, as before, instead of the eight that
MAX_BPF_STACK_JIT needs. The three selftests matching a whole-frame
read in the liveness log accept either depth.

The capability is a boolean and the budget a single constant, in the
style of the other bpf_jit_supports_*() queries, rather than a per JIT
size: the budget is meant to be the same everywhere it is raised, so
that programs verify identically across those architectures.

No JIT declares support yet, so every program keeps its 512-byte budget.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  | 20 ++++++++++
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             | 13 +++++++
 kernel/bpf/liveness.c                         | 39 +++++++++++--------
 kernel/bpf/verifier.c                         | 24 +++++++-----
 .../selftests/bpf/progs/verifier_live_stack.c |  6 +--
 6 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 11fa9f1f087c..a5d493b3876f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -982,6 +982,8 @@ struct bpf_verifier_env {
 	u32 prev_jmps_processed, jmps_processed;
 	/* maximum combined stack depth */
 	u32 max_stack_depth;
+	/* stack budget of the program, see bpf_prog_stack_limit() */
+	u32 stack_limit;
 	/* total verification time */
 	u64 verification_time;
 	/* maximum number of verifier states kept in 'branching' instructions */
@@ -1235,6 +1237,24 @@ static inline int bpf_get_spi(s32 off)
 	return (-off - 1) / BPF_REG_SIZE;
 }
 
+/*
+ * Stack a program may use in total: combined over the frames of a call
+ * chain on the kernel stack, or per frame on a private stack. Any single
+ * frame may reach that deep. Only a JIT that lays out such frames may go
+ * beyond MAX_BPF_STACK, the interpreter's frame size, and only one whose
+ * tail calls let the target set up its own frame: without subprogram
+ * tail calls, do_misc_fixups() gives every program with tail calls a
+ * MAX_BPF_STACK frame, which a deeper frame would overrun.
+ */
+static inline u32 bpf_prog_stack_limit(const struct bpf_prog *prog)
+{
+	/* an offloaded program never runs on the host JIT, whatever it supports */
+	if (prog->jit_requested && !bpf_prog_is_offloaded(prog->aux) &&
+	    bpf_jit_supports_large_stack() && bpf_jit_supports_subprog_tailcalls())
+		return MAX_BPF_STACK_JIT;
+	return MAX_BPF_STACK;
+}
+
 static inline struct bpf_func_state *bpf_func(struct bpf_verifier_env *env,
 					      const struct bpf_reg_state *reg)
 {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5688bc647df6..cdd16bdd4dfb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1251,6 +1251,7 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 227211166dcc..fbb2d8a840ef 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3471,6 +3471,19 @@ bool __weak bpf_jit_supports_private_stack(void)
 	return false;
 }
 
+/*
+ * Return TRUE if the JIT lays out frames of up to MAX_BPF_STACK_JIT bytes.
+ * Its prologue, epilogue and tail call sequences must encode such frame
+ * sizes and a private stack must be sized from the program's depth. The
+ * budget is only granted alongside bpf_jit_supports_subprog_tailcalls(),
+ * whose tail calls land before the target sets up its own frame; see
+ * bpf_prog_stack_limit().
+ */
+bool __weak bpf_jit_supports_large_stack(void)
+{
+	return false;
+}
+
 void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
 }
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index f83254d41043..f9beef6695c4 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -36,9 +36,9 @@ enum {
  * relative index @i is at &bits[(i * FM_MASK_CNT + kind) * words]. A
  * half-slot at or past @words * BITS_PER_LONG is never read by this frame,
  * hence never live. An instruction that may read the whole frame, such as a
- * call passing a frame pointer to another subprog, widens the array to
- * FRAME_MAX_WORDS, so that the read cannot lose half-slots to a later
- * widening.
+ * call passing a frame pointer to another subprog, widens the array to the
+ * program's stack budget, the deepest an accepted program can reach, so
+ * that the read cannot lose half-slots to a later widening.
  */
 struct frame_masks {
 	u32 words;
@@ -264,12 +264,16 @@ static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_
 
 /*
  * Mark every half-slot of @frame as possibly read by @insn_idx. This widens
- * the masks to the maximum width: a full read recorded at a narrower width
- * would leave the bits added by a later widening clear and lose part of it.
+ * the masks to the program's stack budget: a full read recorded at a narrower
+ * width would leave the bits added by a later widening clear and lose part of
+ * it, and an access past the budget is rejected by the main pass later, so no
+ * widening of an accepted program goes further.
  */
-static int mark_stack_read_all(struct func_instance *instance, u32 frame, u32 insn_idx)
+static int mark_stack_read_all(struct bpf_verifier_env *env, struct func_instance *instance,
+			       u32 frame, u32 insn_idx)
 {
-	return mark_stack_read(instance, frame, insn_idx, 0, FRAME_HALF_SPIS - 1);
+	return mark_stack_read(instance, frame, insn_idx, 0,
+			       env->stack_limit / BPF_HALF_REG_SIZE - 1);
 }
 
 /* Accumulate @src, a mask @src_words wide, into may_read of @frame at @insn_idx */
@@ -1384,7 +1388,7 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
  * 'arg' is FP-derived argument to helper/kfunc or load/store that
  * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
  */
-static int record_stack_access(struct func_instance *instance,
+static int record_stack_access(struct bpf_verifier_env *env, struct func_instance *instance,
 			       const struct arg_track *arg,
 			       s64 access_bytes, u32 frame, u32 insn_idx)
 {
@@ -1394,7 +1398,7 @@ static int record_stack_access(struct func_instance *instance,
 		return 0;
 	if (arg->off_cnt == 0) {
 		if (access_bytes > 0 || access_bytes == S64_MIN)
-			return mark_stack_read_all(instance, frame, insn_idx);
+			return mark_stack_read_all(env, instance, frame, insn_idx);
 		return 0;
 	}
 	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
@@ -1413,7 +1417,8 @@ static int record_stack_access(struct func_instance *instance,
  * When a pointer is ARG_IMPRECISE, conservatively mark every frame in
  * the bitmask as fully used.
  */
-static int record_imprecise(struct func_instance *instance, u32 mask, u32 insn_idx)
+static int record_imprecise(struct bpf_verifier_env *env, struct func_instance *instance,
+			    u32 mask, u32 insn_idx)
 {
 	int depth = instance->depth;
 	int f, err;
@@ -1422,7 +1427,7 @@ static int record_imprecise(struct func_instance *instance, u32 mask, u32 insn_i
 		if (!(mask & 1))
 			continue;
 		if (f <= depth) {
-			err = mark_stack_read_all(instance, f, insn_idx);
+			err = mark_stack_read_all(env, instance, f, insn_idx);
 			if (err)
 				return err;
 		}
@@ -1491,9 +1496,9 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	}
 
 	if (ptr->frame >= 0 && ptr->frame <= depth)
-		return record_stack_access(instance, ptr, sz, ptr->frame, insn_idx);
+		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
 	if (ptr->frame == ARG_IMPRECISE)
-		return record_imprecise(instance, ptr->mask, insn_idx);
+		return record_imprecise(env, instance, ptr->mask, insn_idx);
 	/* ARG_NONE: not derived from any frame pointer, skip */
 	return 0;
 }
@@ -1518,7 +1523,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		bytes = bpf_kfunc_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else {
 		for (int f = 0; f <= depth; f++) {
-			err = mark_stack_read_all(instance, f, insn_idx);
+			err = mark_stack_read_all(env, instance, f, insn_idx);
 			if (err)
 				return err;
 		}
@@ -1528,9 +1533,9 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		return 0;
 
 	if (frame >= 0 && frame <= depth)
-		err = record_stack_access(instance, at, bytes, frame, insn_idx);
+		err = record_stack_access(env, instance, at, bytes, frame, insn_idx);
 	else if (frame == ARG_IMPRECISE)
-		err = record_imprecise(instance, at->mask, insn_idx);
+		err = record_imprecise(env, instance, at->mask, insn_idx);
 	return err;
 }
 
@@ -2040,7 +2045,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 				if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
 					continue;
 				for (int f = 0; f <= depth; f++) {
-					err = mark_stack_read_all(instance, f, idx);
+					err = mark_stack_read_all(env, instance, f, idx);
 					if (err)
 						goto out_free;
 				}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8641f1a8d017..9bd7f9b3a67c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3595,7 +3595,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	int hist_spi = spi, hist_frame = state->frameno;
 	struct bpf_stack_state *ss = bpf_stack_slot(state, spi);
 
-	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
+	/*
+	 * caller checked that off % size == 0 and -env->stack_limit <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
 	if (!env->allow_ptr_leaks &&
@@ -5448,7 +5449,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	if (subprog[idx].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
-		if (subprog_depth > MAX_BPF_STACK) {
+		if (subprog_depth > env->stack_limit) {
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
 			return -EACCES;
@@ -5457,7 +5458,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		depth += subprog_depth;
 		if (depth > env->max_stack_depth)
 			env->max_stack_depth = depth;
-		if (depth > MAX_BPF_STACK) {
+		if (depth > env->stack_limit) {
 			total = 0;
 			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
 				total++;
@@ -6308,10 +6309,11 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Check that the stack access at the given offset is within bounds. The
+/*
+ * Check that the stack access at the given offset is within bounds. The
  * maximum valid offset is -1.
  *
- * The minimum valid offset is -MAX_BPF_STACK for writes, and
+ * The minimum valid offset is -env->stack_limit for writes, and
  * -state->allocated_stack for reads.
  */
 static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
@@ -6322,7 +6324,7 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
 	int min_valid_off;
 
 	if (t == BPF_WRITE || env->allow_uninit_stack)
-		min_valid_off = -MAX_BPF_STACK;
+		min_valid_off = -(int)env->stack_limit;
 	else
 		min_valid_off = -state->allocated_stack;
 
@@ -14728,7 +14730,8 @@ enum {
 	REASON_STACK	= -5,
 };
 
-static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
+static int retrieve_ptr_limit(const struct bpf_verifier_env *env,
+			      const struct bpf_reg_state *ptr_reg,
 			      u32 *alu_limit, bool mask_to_left)
 {
 	u32 max = 0, ptr_limit = 0;
@@ -14740,7 +14743,7 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 		 * offset where we would need to deal with min/max bounds is
 		 * currently prohibited for unprivileged.
 		 */
-		max = MAX_BPF_STACK + mask_to_left;
+		max = env->stack_limit + mask_to_left;
 		ptr_limit = -ptr_reg->var_off.value;
 		break;
 	case PTR_TO_MAP_VALUE:
@@ -14860,7 +14863,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 				     (opcode == BPF_SUB && !off_is_neg);
 	}
 
-	err = retrieve_ptr_limit(ptr_reg, &alu_limit, info->mask_to_left);
+	err = retrieve_ptr_limit(env, ptr_reg, &alu_limit, info->mask_to_left);
 	if (err < 0)
 		return err;
 
@@ -14990,7 +14993,7 @@ static int check_stack_access_for_ptr_arithmetic(
 		return -EACCES;
 	}
 
-	if (off >= 0 || off < -MAX_BPF_STACK) {
+	if (off >= 0 || off < -(int)env->stack_limit) {
 		verbose(env, "R%d stack pointer arithmetic goes out of range, "
 			"prohibited for !root; off=%d\n", regno, off);
 		return -EACCES;
@@ -21693,6 +21696,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->bt.env = env;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
+	env->stack_limit = bpf_prog_stack_limit(env->prog);
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index ec27cb40dbef..dec2230f32aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1953,7 +1953,7 @@ static __used __naked void fwd_parent_key_to_helper(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-2048 fp0-8")
+__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-{{(512|2048)}} fp0-8")
 __naked void helper_arg_fallback_keeps_scanning(void)
 {
 	asm volatile (
@@ -2267,7 +2267,7 @@ static __used __naked void merge_leaf_read(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_loop#181            ; use: fp2-8..-2048 fp1-8..-2048 fp0-8..-2048")
+__msg("call bpf_loop#181            ; use: fp2-8..-{{(512|2048)}} fp1-8..-{{(512|2048)}} fp0-8..-{{(512|2048)}}")
 __naked void bpf_loop_two_callbacks(void)
 {
 	asm volatile (
@@ -2872,7 +2872,7 @@ __naked void narrow_store_defines_nothing(void)
 SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[0-9]+}}):")
-__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-2048")
+__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-{{(512|2048)}}")
 __naked void merge_keeps_whole_frame_read(void)
 {
 	asm volatile (
-- 
2.53.0

