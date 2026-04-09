Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904333191D8
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698432; cv=none; b=mR0ekmKVZIeWPJxfRRThOPKn5vTBZEK24Mrbenr3moGRcPpd4YHgaOYO6a1uJkSUEOfYZHwTlX2urfud0sVgAH99rMAMy5Obx/Qsj44/9GnkjNBlPVY9qTyUz2wyjUfrYJinw+QeZHKMGt2LP2R7jnnwQ/R1Q5SdmOiq8gfo64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698432; c=relaxed/simple;
	bh=mIndClX1znD1XalMxpC+AjnyB/6+lejQ5fxB41PAk8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9ZS6xFugM04wdV7uFgpf1ASb47WnryqOKB9flGz0qAXLQV0PihyR/sn8V88WkR6/tFYDmuO5ykf3RKw7bJ7U/y/ub9gHB8Ud8IpIHZC4sX8C1CgevRraZvnc8kdC+uB4prkh3x/8PEDLygK/0QaZYcm8PIKneiUgp4DtmvT2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5ydPbK9; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5ydPbK9"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1273349c56bso314731c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698425; x=1776303225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG+O2Ci7eUv2EiOClKx+kLmGKfp2F+5S8h0CV0Xii0k=;
        b=j5ydPbK9MsMGH9aWeu+/EBBgYmSfu8IyGfjcLJ0ncCDzbo3V05SjNZO2J7pTd1dOQf
         yF2dowKADCuGjkokjAfTXPpJRL8A4bbVMyz4Z1Z+jHUVsJ9m2upK8WiFh48FWQuCOiwb
         utroNHsgRxIpjKUIkW8JcqXbvMc0mvoOkCfNjm4S6WlLjAfnuLjQCb4/ETdhA4oH1R30
         tn8ya9MLd9s8tCwWP1sLh24b/nOlwiGCBh3aYjFiGZE21u8n4fjrHIetuUX2xSuebaeS
         kOQgQiYx7hsBeSDy4WJeSTNmD7aCN3KCHenPkxZKvE8iY+uFawlgwjE1RisGVAU9QEJ+
         Tfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698425; x=1776303225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dG+O2Ci7eUv2EiOClKx+kLmGKfp2F+5S8h0CV0Xii0k=;
        b=deSJH+ikB7A4gj83ez1qCtnZRQac5POxniwfpT/L3LDBvyslXVCt6d969zZj32wuoC
         TuEVx2x8MMD4AQtIVkq4xwiVCAaXmQGnNxYueFqpzVTFk9+Igb417VHJt7m6ka3BBiR0
         jCZO3Yg2TRIVjAEtFj24PBJIClqtQUSamfGKV7Q8mP4KT3XcUYN7lIxZi/ANn9V+Xwu6
         iDtlQzPYu/iVXRTv9Z7HOAeZaMG6lQQsnBJuwrD9TyV2LNmAEk73bDUIhtAOIDfZ+t9h
         FINe/YsBcj0+VitQg7S3X4hWHZmtJ5Y8l0af2dkueyty0N+vUA3yJ9t15/wIx43rZLmm
         krsw==
X-Gm-Message-State: AOJu0YyPh73bw7gDl1NXtHuoaDWQ9LnYhPa+oVXiCrVn2KkmQNhOgCPn
	Q7ozhF2sPKXZy/GgeOBggRMtibNkUzz7/PqhXVxO/5DQwBGmopJ4+Yu7DeRWhPqr
X-Gm-Gg: AeBDievoue7ReOAKUXwQhHhbbrdJuNQWgqP7pg+2Z6ksxgM+hFDllC25ukqoYBMHU8T
	Kn22azNYfokWWqkMs8JQN4N6R7qDbt//3da5i8eVlaFPdvcLfjsOLSiaOjO7LPpuZ0LSw2RW/HP
	g1JjDZvN+NyQZrUf+vCnwtZrUTabdHNwoICbhuf9gAK59Vg9Ib54ycBXiGyrD3dMTmFTIiN4aU5
	XRHWJTusbF4UujFFvXKJVibS/2LrLkbiIXttpxJlTCS6CYxenLLJYloQrAXQmNl76SF5w24cq61
	y9qnLrxBgAUtepP8hCkLUvkW51gjZ9XXbYc7baRsv+PHOMbzOLGyspYWMdakHTbMcx37SjEhais
	wjxWmCvyDO2tJKisX/CB6V4y1PK+9fpULsZi9Ffno0xHVDRTUn3LmiTwL9OzaVxsyh/BXfLdg4A
	lmbXqmMjQrRcIXx+LXEWE04boCEpXb4vp7FwxBklzRfqeyUV6hXalU4LkPKUIqmZydiAb+D9ZIH
	lu5nlNPkGlOXQ==
X-Received: by 2002:a05:7022:91f:b0:128:d6c3:9b18 with SMTP id a92af1059eb24-12c28bd4eabmr856099c88.3.1775698425084;
        Wed, 08 Apr 2026 18:33:45 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 14/14] bpf: poison dead stack slots
Date: Wed,  8 Apr 2026 18:33:16 -0700
Message-ID: <20260408-patch-set-v1-14-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
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
index 75f3ae48431cbb675d76af3d899064cafed2f9ee..1f9ee77aedd7e6747e46c973606d15584a984075 100644
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
index f0902ecb7df69b6d43deaf808b4c0f00cc3438f2..d5779a3426d9773ff36595ff4df2bf070c096070 100644
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
index 2bd8511aa1508a96c23e93df174f64708dafb4b5..e0219be1c0aadd132419c639686372d67d9c4864 100644
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
 
@@ -5574,7 +5575,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		 * that may or may not be written because, if we're reject
 		 * them, the error would be too confusing.
 		 */
-		if (*stype == STACK_INVALID && !env->allow_uninit_stack) {
+		if ((*stype == STACK_INVALID || *stype == STACK_POISON) &&
+		    !env->allow_uninit_stack) {
 			verbose(env, "uninit stack in range of var-offset write prohibited for !root; insn %d, off: %d",
 					insn_idx, i);
 			return -EINVAL;
@@ -5710,8 +5712,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
 
@@ -5760,8 +5767,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
@@ -8326,16 +8338,22 @@ static int check_stack_range_initialized(
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
@@ -8434,7 +8452,12 @@ static int check_stack_range_initialized(
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
@@ -8617,8 +8640,10 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
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
@@ -20078,7 +20103,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
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
index c6ae64b99cd6ef8af8dd8d341c06033bac0f61de..6bc721accbae001a3e16396dc69037071534e324 100644
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
