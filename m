Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9734AB19
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813384; cv=none; b=GbHxigcCJqlehim/LXN+4IPvJY5rTkfShRi3nJOVEgWDBkmFSgKbv57secu7WU8aylBfP/Wbo1WIrZF7iWdPWPmz0CIm3Sy/gSULXJaGbveQZrYG21zzTMK60cWRCePlbBmdN/gydCV2uUEP3AwctNnz72xu5FXF8VtvHY3Dm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813384; c=relaxed/simple;
	bh=/FNGoJmSVY+Clw3xfX9ApRrQaw2P6F3v/r8hKffUniU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItiwXqfIQjoHgzG2Z4Sroz2kPH+wiIJVeBD8n20hm7XYCGDCtVG05nz4XS0bQnFVuXctQYD4C3IP34kOgZMSDhmBlefMUARtGJ7F9ikm08i1AzZC4rhm9jC1VtM+axvq+TK0+XQdAlbrBMENjNnyELtIBdjJXN8E5+aP8KMoB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbxKqNCH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbxKqNCH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b23fcf90b2so17845925ad.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813382; x=1776418182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xyEB2AbSpK9c7/p6MJnkrFK5+VHYNQZQ4GlZo9Pfbs=;
        b=kbxKqNCHCGv9veA/H4dYeltmg9A4UIfs8xDxKdalq/7A4qxHUuSv8G3yJ6C4OrfqYj
         TSVGgeIgKpSaJlBGbmH398qcToQw9uIugKVzZie1bYqnL/0g2067cbE7c+OzHK8qTm/8
         J2Fnsj95YPrw26en6D8ozeaIdXYrNjGuxpBTUR9NsPs1x/5g+0nVtMUMbnN2xa5UI1n8
         WJHToNd1mfDetC/MIR5Qt9SL8yxIzXPcaBg2P+E+OcJ+ey+Mu8/yRlI99TYf8zgUkAuV
         17go4X8+5j3cil7+kSlBOideIF8/OVRugJXd2Qy8xzdpxLwJXL/D6GYtwqmI71cQ+Md2
         U/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813382; x=1776418182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xyEB2AbSpK9c7/p6MJnkrFK5+VHYNQZQ4GlZo9Pfbs=;
        b=HRmUYKGJHIqIbnSf5yOR6F5eSd/mTG7rJRcZRzn6Mdho6256Llqz7E4pdxEdxknQ2y
         QSPNBTXvhqjnk543sZmAeVDGCIKIN2CqDdlotM9MC1PEXYWGyQrzHc/KfmUaPjXpiU4h
         bSFOFlSDaqceMOlV9t7Ou3rvG4nGHBaMkLTzF+Eu1o1COKre/97V+H15xnJMtBCoohTM
         eZfJMDRulIaRYkKuI2CNZ0UPEdNhNXF919xnoUE6IKy17lWnKXZdZkZMe6PpxfPKBj71
         TTXiZFetXviKvHivuLt+rsAPf14Ls89tRXuc95YnVGTaHqYqrQtHTwPH4CwkV/gQ9L/2
         zL1A==
X-Gm-Message-State: AOJu0YwJBHGnxUiZfWtTQZT6j6kaXw2MgIWPLlmyK/DZoe2J2vNuhu9s
	CDXnVNfuXi45ZXtoTRRjqEbSrzRNEO2YkSO2A433Kcyxv0iNAReT903Ey5Os9txv
X-Gm-Gg: AeBDieu1+yhXIJpnVk9o+g/2xJLH6qVzcI7Ii9V9BYI/cmQPhbvYO8LnH9u+RXaXh7O
	I/7OhYIDtJojBGJyLEvI7jynme+IhCF1snSfIATqAGOkvdoX9/8+pWZJc9aZw/iPgTU+yt545Jc
	EYUSe84kUu0+JqA5RFuSTCRwXdBwkI9BahjMFBltDQQbVaqWnoApnuj7Ry82GDjlFTUpc2I5Mqg
	zhsYizCOHyuAB3RQMoGDiX9Nxq1OBZ2MFmqn4kswhTVNFH9JiCf3ZTl2vt/4TluaKa1J7yGdaUY
	MQzlg/qsBar24yXWx9j0SG40yfTkE0VLAJnBrwbJ7GLMuhLznKJ62kGJuDoa/nQJJmeQzaKKF6i
	W+f0Krtj7V+F5XHN6hf5AySCH3lJCQ+UZWUX7j9xYEOWOSSbvEEmOhziPHEioaVv3Lk++ze7KVM
	1INmJUfgoN9Lp/2cjJwtaoFghUIDUkBJyD3yZ6kul995VGFwg6afhF63Hr/50j5d/8UzU=
X-Received: by 2002:a17:902:7c93:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2b2d599a212mr18998065ad.16.1775813381796;
        Fri, 10 Apr 2026 02:29:41 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 13/13] bpf: poison dead stack slots
Date: Fri, 10 Apr 2026 02:29:17 -0700
Message-ID: <20260410-patch-set-v3-13-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
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
index 6e7f53f6a1d4..6d4488012fef 100644
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
index b279c4c93b09..2fe7d602f70c 100644
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
 
@@ -5563,8 +5566,10 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
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
@@ -5700,8 +5705,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
 
@@ -5750,8 +5760,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
@@ -8316,16 +8331,22 @@ static int check_stack_range_initialized(
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
@@ -8424,7 +8445,12 @@ static int check_stack_range_initialized(
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
@@ -8607,8 +8633,10 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
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
@@ -20069,7 +20097,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				__mark_reg_not_init(env, spill);
 			}
 			for (j = start; j < end; j++)
-				st->stack[i].slot_type[j] = STACK_INVALID;
+				st->stack[i].slot_type[j] = STACK_POISON;
 		}
 	}
 }
@@ -20407,7 +20435,8 @@ static bool is_stack_misc_after(struct bpf_verifier_env *env,
 
 	for (i = im; i < ARRAY_SIZE(stack->slot_type); ++i) {
 		if ((stack->slot_type[i] == STACK_MISC) ||
-		    (stack->slot_type[i] == STACK_INVALID && env->allow_uninit_stack))
+		    ((stack->slot_type[i] == STACK_INVALID || stack->slot_type[i] == STACK_POISON) &&
+		     env->allow_uninit_stack))
 			continue;
 		return false;
 	}
@@ -20443,13 +20472,22 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
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
@@ -20547,6 +20585,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
