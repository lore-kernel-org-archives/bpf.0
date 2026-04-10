Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104031A7F6
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783531; cv=none; b=aW/tDu5w2gmU89Y586bpOp6+wVK95GEUz7NNns4+NqXU33LeoawW3C4JhwFbSd0zingj+AN3hPxUjJCHkM0AhjCilkcum12nCFfZ9UIjBEfD/BNr9gYI931guXullLFlQbWp9v3HhcAI0YZpCn81ZIsi4kRg8KwGC8tiff2jB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783531; c=relaxed/simple;
	bh=wjavsFQ7sG8NFDVXnH2O+8GTtUnGXc9X+Idbqcgg09k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coSZjW2ThIKLe4QHPA63gHTgXGntHXEXc0E6kRU1AScWTt8N41Dp4ZxM8qVeoYmZCKlSL4FOKiLiCuh7UUrPGxQiEsoRuql8Meh6NN73u7yax5ErHukdvyeR8sG49FQC1cFn/6GvrF3xHPPe0CQ4AVauODySqk1gSo8wbEWi9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6oaAmE7; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6oaAmE7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2cc4c693d59so1268190eec.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783529; x=1776388329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHRieP+d6qfQp0/Bo5joJ+0Kvob/px32L1MbFX8ikWY=;
        b=R6oaAmE7+np3ATjnFcG2q4xuz0H5e43J0cYCH0JIrglbVqxiCLGVIYomW5LcId4n1L
         eGQzgHtg9XV+y/1Vtz29eGv9XwWId/K8ueQ8T4gGvWzoQ/kQdUgheVvkCKdg7aHYT4kg
         xkY/t2gBr9hNR5k3rGmII7Q5pD0V3c/lrNW68rM5GYXgjXyuz9tKsNyK0TWZ262F+XhH
         TILzqQvnX3D37Og8gxoez5PNkvPEOnv6FeQu6+BhacY5CRmT67TRfVoEf8sNlAnDW2s8
         BgYFNQ7U7vLDuFFcRFAPYGu+BQn4XXKpo/bIQa+i02MoU5XeQTKno8iwJjdn7RyK9L50
         9RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783529; x=1776388329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHRieP+d6qfQp0/Bo5joJ+0Kvob/px32L1MbFX8ikWY=;
        b=YFomuYYqIbB1QkOA5lgceP4S0WG0x5i/Te082f5wdvcwSEohlEM/kW7KlYLax7H1CZ
         0+sRRkbStRHmYoN9OM00ROLtOg+c1Dm9s9UOIMfLjXavtSDZNc81YdILzg0XLvlAPkVE
         Rpg2gUOXWig3YiOOzNLIzNqWFBaEOHFfVN/BEJl+vO+I4HJlOGS8cmsnIjVjVawfhpEI
         6NmR9m9UbkSE9EqubwEVNSe17Vhd0gi7OrNRqvjq9t3ekV3Ex3Hb1uuCBEF0UNRt2Do6
         QDVUjivlZcQROnVQYw0hDNHh3DKO5r9g6o6GUZJl7yVTrGZZ5t2ccxZdLTeFLBWUVbRK
         tQ7w==
X-Gm-Message-State: AOJu0YyeDqpIUy/KXCps7XXcGzcgflg6F03Jnk6HwJhcsY7OoSPhA2sJ
	fo1ZJ67TYwHfibKhp3OZePXWdAmmwpNGq+O+jtO41Nt9CWyDwxWMT0Nmh2ooT8qf
X-Gm-Gg: AeBDievXLS9fXShZ9VyBPFodlQg7xd4/p1AsSDyH3QbxyiXZjpdQ8tnr+v5BOuvCoJS
	GBmY5pAT7zea53UoNI2wgSE2r4R19MemXdLyDd2ASkMTlv6uksnb5HqMXnJWBN0/ha/pci7osjd
	4P2lwdtq4D/K0AmAJxeMEivLMPluqfC+kLKtjm4AyaVju2PPL/I911HoqETbEUnOoJ3LIw0lNlV
	g+ULPPwxxTHCzt0NfwX+9ijfnJT6V4Kp6KrD1kLDIoIf+nJkgJGGVuVjPwgzj62l16HvpAsoDZK
	uSA65iz585MBMx4rqq3lBj8VBPLDrk1fVYaTWroS5u4xFbisDQ6mMo13wxy48xQw7z9snb2UPFc
	HkXSNu4DhVRoPylLD1XrMGoDVrdxhPX49kF2wZtKp7++id8wBM7coUUFO5DOxR7/oRdL8eiYNAx
	CEam6JnVVtMWsmMXg9Lx4ax1e77JNW22DPE3wNYFkIxTlO1E5mmDC2ZUj8EOvJ4Lhl59HXFXaqJ
	V8MLmw=
X-Received: by 2002:a05:7300:df05:b0:2d2:d7b7:5c70 with SMTP id 5a478bee46e88-2d5881b0358mr968370eec.15.1775783528593;
        Thu, 09 Apr 2026 18:12:08 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:12:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 13/13] bpf: poison dead stack slots
Date: Thu,  9 Apr 2026 18:11:32 -0700
Message-ID: <20260409-patch-set-v2-13-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
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
 kernel/bpf/verifier.c                              | 80 ++++++++++++++++------
 .../selftests/bpf/progs/verifier_spill_fill.c      |  2 +
 4 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5d6c6d1f46ed..ad1a184d470f 100644
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
index b279c4c93b09..b05019384ee5 100644
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
@@ -1369,14 +1370,14 @@ static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
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
 
@@ -5564,7 +5565,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		 * that may or may not be written because, if we're reject
 		 * them, the error would be too confusing.
 		 */
-		if (*stype == STACK_INVALID && !env->allow_uninit_stack) {
+		if ((*stype == STACK_INVALID || *stype == STACK_POISON) &&
+		    !env->allow_uninit_stack) {
 			verbose(env, "uninit stack in range of var-offset write prohibited for !root; insn %d, off: %d",
 					insn_idx, i);
 			return -EINVAL;
@@ -5700,8 +5702,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
 
@@ -5750,8 +5757,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
@@ -8316,16 +8328,22 @@ static int check_stack_range_initialized(
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
@@ -8424,7 +8442,12 @@ static int check_stack_range_initialized(
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
@@ -8607,8 +8630,10 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
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
@@ -20069,7 +20094,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				__mark_reg_not_init(env, spill);
 			}
 			for (j = start; j < end; j++)
-				st->stack[i].slot_type[j] = STACK_INVALID;
+				st->stack[i].slot_type[j] = STACK_POISON;
 		}
 	}
 }
@@ -20407,7 +20432,8 @@ static bool is_stack_misc_after(struct bpf_verifier_env *env,
 
 	for (i = im; i < ARRAY_SIZE(stack->slot_type); ++i) {
 		if ((stack->slot_type[i] == STACK_MISC) ||
-		    (stack->slot_type[i] == STACK_INVALID && env->allow_uninit_stack))
+		    ((stack->slot_type[i] == STACK_INVALID || stack->slot_type[i] == STACK_POISON) &&
+		     env->allow_uninit_stack))
 			continue;
 		return false;
 	}
@@ -20443,13 +20469,22 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
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
@@ -20547,6 +20582,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
