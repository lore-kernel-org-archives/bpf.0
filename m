Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600403A6B6A
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854590; cv=none; b=UJltDsS3g8kAwvVkIfsT/KEB46EUwODaUOq4Eq2DjMjQr37TX0+YDWPLLRzzLdmAE4ZlQDEQ1r/N7Fy8QGulA+WALYX4iwuncvcdW3Yb59P6xAE1KCpFPEdwwiOn6xz9WXlbdxZ34rolceD0E7mCSzCy004h46D/2dT7ZWtl870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854590; c=relaxed/simple;
	bh=FeylLRKzAgJS0dRxm3554NIyUocnrntTakStQVyjB0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFbLVSGQx0dBYPeGH3P6FLRZvgSARWOzKF51bxdSbVMCJhvHUcV2avuHyZSCz5qPHK7b6u49jppkW0fSJuyLD3MJ6yV+vU4C6ak+Qc6Yzh6QFHp427bcoHbHBaveW4Ic0HrjST7JdzHGykZBSwKAo4YOpi9Fmhl9aW79ciz+yeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/aPoie3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/aPoie3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f206f2b54so27694b3a.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854589; x=1776459389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avsfqull4H4ci1mYCgTAVbP4dnYJv8Gjhe9IPad9zHk=;
        b=I/aPoie3Bgq6YW9oMCulTq7YyBaV+b9EUKTY79aM8YRpEWBFkg/XQmHe84xryRoIPw
         mUCqTY9hbN8t3gIJZZYN+Hg1IrprnpZuMtRgEIRHtMdc9x0aFyFjScQx6RN9E8LA0MdO
         3wKSI/0cYMrpr5I+4wHpRgqcOMSIY9F6VgxKTz4C4UY9QV6hdw4iqDmpoDzwfygb9JdU
         l1aJzqsa+uNOL6gtcfZP2UyP11OxJfhiYbZxfgiDTJBsJ/ihlUZ16joRdIV6Xpl+Al8f
         sdZETn/QRHAmTAyxi2xGOWv4Yj5T9alFsOp2PULzPxtkBcMZxUjI4g3raIQ+6VXFMM7K
         C0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854589; x=1776459389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avsfqull4H4ci1mYCgTAVbP4dnYJv8Gjhe9IPad9zHk=;
        b=QaAxLnMK2iGKCgUM48CjslVLCU7XHRl++ckdUwr5O9P35PxWd2oc7vvmeDKXPiESaB
         Ud6ohiDwfbWFP5EJJHkE1DEU0WH2bBxI8HO0Ro9By9pRXmgUdkFQytrb3X116CIeb17x
         Qy98dcMV6UZOuyn8moDBBSjXYUptzB3pK62f8RMpAsVb8fizgUo45MxBijDKdo2M61u3
         7uPDIXMZkjrFrh7/ld3Ps6qO2JTuUwq+ZvIRexfsJkTGhMpcTQygDscuN8jpk0dr0M4/
         Z3zgD1PT2r3fdLh0PNeem7AFNS/dDPtahB+zH89kxnc7Tuk3KIlTk93as9R0D8syQY08
         dB7g==
X-Gm-Message-State: AOJu0Yx1fqA7TVNn8Fb4oUJmEeWkcfovaQuqOaCtb/nzqe1lAQNW1vmC
	iYHr/ocr0OZyF3hp0Lm3hwpvKrZgBlNxmAlWsFSQ0nSmOF0r68pAI09EePHxkz8g
X-Gm-Gg: AeBDiesalEfNRGXpwko3ZvggGSfGNAjdR/bh179hx5xmuv400lqlF6F3uJ7dYpypd95
	OuQ1stO5f6eO6Bzmp89UhjTGOvx0WAvvV5tk2Tr9SfmU4HBEihC7UltG7DCcsRraiCxiUAU9oRI
	y/50xRs0bEjsWUoPoMQ2BvIFYA9iwXgDrT4tpdgBPXHLpdhBQwI4MVPT0mb4gLR7UnT/g1hZjvy
	I1+60QMdd2mgzCFWBFqxXoWY+bNKDdTh/gtSIIggdU7u1DgM/DT0xft90E4dSY12Ax682Px8jVi
	lIAD7AbQ9fOLsAsnAPYHhxKgpMFVXyurVziNkZGZ8A13wTRwZtVfoK8MfBwefTV0jxOlNbkQG2U
	tX8apT7wPn1T2UqJu+9aGWkqUE5LAy99uVQKOozaTO5d3scinHLVr2+Obv0MMZxRdKvv8PNbrvB
	5Pc/DAli7vUfJ7/CZuYiahwGlJ+GLJsQPILek7ImJtshwsztx4J0sZXbgDQ8spcXLvaDk=
X-Received: by 2002:a05:6a00:35ce:b0:781:2291:1045 with SMTP id d2e1a72fcca58-82f0c1cf099mr4785212b3a.8.1775854588653;
        Fri, 10 Apr 2026 13:56:28 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v4 14/14] bpf: poison dead stack slots
Date: Fri, 10 Apr 2026 13:56:05 -0700
Message-ID: <20260410-patch-set-v4-14-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

As a sanity check poison stack slots that stack liveness determined
to be dead, so that any read from such slots will cause program rejection.
If stack liveness logic is incorrect the poison can cause
valid program to be rejected, but it also will prevent unsafe program
to be accepted.

Allow global subprogs "read" poisoned stack slots.
The static stack liveness determined that subprog doesn't read certain
stack slots, but sizeof(arg_type) based global subprog validation
isn't accurate enough to know which slots will actually be read by
the callee, so it needs to check full sizeof(arg_type) at the caller.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                       |  1 +
 kernel/bpf/log.c                                   |  5 +-
 kernel/bpf/verifier.c                              | 89 ++++++++++++++++------
 .../selftests/bpf/progs/verifier_spill_fill.c      |  2 +
 4 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d3dc46aae2e7..05b9fe98b8f8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -220,6 +220,7 @@ enum bpf_stack_slot_type {
 	STACK_DYNPTR,
 	STACK_ITER,
 	STACK_IRQ_FLAG,
+	STACK_POISON,
 };
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f0902ecb7df6..d5779a3426d9 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -542,7 +542,8 @@ static char slot_type_char[] = {
 	[STACK_ZERO]	= '0',
 	[STACK_DYNPTR]	= 'd',
 	[STACK_ITER]	= 'i',
-	[STACK_IRQ_FLAG] = 'f'
+	[STACK_IRQ_FLAG] = 'f',
+	[STACK_POISON]	= 'p',
 };
 
 #define UNUM_MAX_DECIMAL U16_MAX
@@ -779,7 +780,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 
 		for (j = 0; j < BPF_REG_SIZE; j++) {
 			slot_type = state->stack[i].slot_type[j];
-			if (slot_type != STACK_INVALID)
+			if (slot_type != STACK_INVALID && slot_type != STACK_POISON)
 				valid = true;
 			types_buf[j] = slot_type_char[slot_type];
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f40ba186ba..5418669945ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1327,6 +1327,7 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
 	case STACK_IRQ_FLAG:
 		return true;
 	case STACK_INVALID:
+	case STACK_POISON:
 	case STACK_MISC:
 	case STACK_ZERO:
 		return false;
@@ -1356,9 +1357,11 @@ static bool is_spilled_scalar_after(const struct bpf_stack_state *stack, int im)
 	       stack->spilled_ptr.type == SCALAR_VALUE;
 }
 
-/* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in which
- * case they are equivalent, or it's STACK_ZERO, in which case we preserve
- * more precise STACK_ZERO.
+/*
+ * Mark stack slot as STACK_MISC, unless it is already:
+ * - STACK_INVALID, in which case they are equivalent.
+ * - STACK_ZERO, in which case we preserve more precise STACK_ZERO.
+ * - STACK_POISON, which truly forbids access to the slot.
  * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileged
  * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged case it is
  * unnecessary as both are considered equivalent when loading data and pruning,
@@ -1369,14 +1372,14 @@ static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
 {
 	if (*stype == STACK_ZERO)
 		return;
-	if (*stype == STACK_INVALID)
+	if (*stype == STACK_INVALID || *stype == STACK_POISON)
 		return;
 	*stype = STACK_MISC;
 }
 
 static void scrub_spilled_slot(u8 *stype)
 {
-	if (*stype != STACK_INVALID)
+	if (*stype != STACK_INVALID && *stype != STACK_POISON)
 		*stype = STACK_MISC;
 }
 
@@ -5562,8 +5565,10 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		 * For privileged programs, we will accept such reads to slots
 		 * that may or may not be written because, if we're reject
 		 * them, the error would be too confusing.
+		 * Conservatively, treat STACK_POISON in a similar way.
 		 */
-		if (*stype == STACK_INVALID && !env->allow_uninit_stack) {
+		if ((*stype == STACK_INVALID || *stype == STACK_POISON) &&
+		    !env->allow_uninit_stack) {
 			verbose(env, "uninit stack in range of var-offset write prohibited for !root; insn %d, off: %d",
 					insn_idx, i);
 			return -EINVAL;
@@ -5699,8 +5704,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					}
 					if (type == STACK_INVALID && env->allow_uninit_stack)
 						continue;
-					verbose(env, "invalid read from stack off %d+%d size %d\n",
-						off, i, size);
+					if (type == STACK_POISON) {
+						verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
+							off, i, size);
+					} else {
+						verbose(env, "invalid read from stack off %d+%d size %d\n",
+							off, i, size);
+					}
 					return -EACCES;
 				}
 
@@ -5749,8 +5759,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				continue;
 			if (type == STACK_INVALID && env->allow_uninit_stack)
 				continue;
-			verbose(env, "invalid read from stack off %d+%d size %d\n",
-				off, i, size);
+			if (type == STACK_POISON) {
+				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by dead code elimination\n",
+					off, i, size);
+			} else {
+				verbose(env, "invalid read from stack off %d+%d size %d\n",
+					off, i, size);
+			}
 			return -EACCES;
 		}
 		if (dst_regno >= 0)
@@ -8315,16 +8330,22 @@ static int check_stack_range_initialized(
 	/* Some accesses can write anything into the stack, others are
 	 * read-only.
 	 */
-	bool clobber = false;
+	bool clobber = type == BPF_WRITE;
+	/*
+	 * Negative access_size signals global subprog/kfunc arg check where
+	 * STACK_POISON slots are acceptable. static stack liveness
+	 * might have determined that subprog doesn't read them,
+	 * but BTF based global subprog validation isn't accurate enough.
+	 */
+	bool allow_poison = access_size < 0 || clobber;
+
+	access_size = abs(access_size);
 
 	if (access_size == 0 && !zero_size_allowed) {
 		verbose(env, "invalid zero-sized read\n");
 		return -EACCES;
 	}
 
-	if (type == BPF_WRITE)
-		clobber = true;
-
 	err = check_stack_access_within_bounds(env, regno, off, access_size, type);
 	if (err)
 		return err;
@@ -8423,7 +8444,12 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (tnum_is_const(reg->var_off)) {
+		if (*stype == STACK_POISON) {
+			if (allow_poison)
+				goto mark;
+			verbose(env, "reading from stack R%d off %d+%d size %d, slot poisoned by dead code elimination\n",
+				regno, min_off, i - min_off, access_size);
+		} else if (tnum_is_const(reg->var_off)) {
 			verbose(env, "invalid read from stack R%d off %d+%d size %d\n",
 				regno, min_off, i - min_off, access_size);
 		} else {
@@ -8606,8 +8632,10 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
-	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
+	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
+
+	err = check_helper_mem_access(env, regno, size, BPF_READ, true, NULL);
+	err = err ?: check_helper_mem_access(env, regno, size, BPF_WRITE, true, NULL);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -20068,7 +20096,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				__mark_reg_not_init(env, spill);
 			}
 			for (j = start; j < end; j++)
-				st->stack[i].slot_type[j] = STACK_INVALID;
+				st->stack[i].slot_type[j] = STACK_POISON;
 		}
 	}
 }
@@ -20339,7 +20367,8 @@ static bool is_stack_misc_after(struct bpf_verifier_env *env,
 
 	for (i = im; i < ARRAY_SIZE(stack->slot_type); ++i) {
 		if ((stack->slot_type[i] == STACK_MISC) ||
-		    (stack->slot_type[i] == STACK_INVALID && env->allow_uninit_stack))
+		    ((stack->slot_type[i] == STACK_INVALID || stack->slot_type[i] == STACK_POISON) &&
+		     env->allow_uninit_stack))
 			continue;
 		return false;
 	}
@@ -20375,13 +20404,22 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 		spi = i / BPF_REG_SIZE;
 
-		if (exact == EXACT &&
-		    (i >= cur->allocated_stack ||
-		     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
-			return false;
+		if (exact == EXACT) {
+			u8 old_type = old->stack[spi].slot_type[i % BPF_REG_SIZE];
+			u8 cur_type = i < cur->allocated_stack ?
+				      cur->stack[spi].slot_type[i % BPF_REG_SIZE] : STACK_INVALID;
+
+			/* STACK_INVALID and STACK_POISON are equivalent for pruning */
+			if (old_type == STACK_POISON)
+				old_type = STACK_INVALID;
+			if (cur_type == STACK_POISON)
+				cur_type = STACK_INVALID;
+			if (i >= cur->allocated_stack || old_type != cur_type)
+				return false;
+		}
 
-		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
+		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID ||
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_POISON)
 			continue;
 
 		if (env->allow_uninit_stack &&
@@ -20479,6 +20517,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		case STACK_MISC:
 		case STACK_ZERO:
 		case STACK_INVALID:
+		case STACK_POISON:
 			continue;
 		/* Ensure that new unhandled slot types return false by default */
 		default:
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index c6ae64b99cd6..6bc721accbae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -780,6 +780,8 @@ __naked void stack_load_preserves_const_precision_subreg(void)
 		"r1 += r2;"
 		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
 
+		"r2 = *(u64 *)(r10 -8);" /* keep slots alive */
+		"r2 = *(u64 *)(r10 -16);"
 		"r0 = 0;"
 		"exit;"
 	:

-- 
2.53.0
