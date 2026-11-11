Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415621;
	b=pT8hIhpBeyrm+yjqmOegM4DMKrlST4GACjW1CEVPwsVS1SDNsdmQ23TKpGLnkOlkbJ8Z
	 BcmPO/YamlKKlZFAbGtz/j932vXLhA3qOIk/WBlCgwqBCv4pzyqw0IvSz/xwyRCDbl+65
	 WphX+9ReTVgMt4Pgx5zO1TegQUkQwMQK4+7OdrEqGrO/vZCrtZYO8aIiZ+99qiCuwW1Xe
	 CUt5tnofcu1b0iwiOjEVEWMNr2lOnmJhjtIdIVnmliercsF8I9v+DMZG+Cq27UlpgmR2X
	 TwLXph0B1WxmUceSzn4X1qW3QnrVAf43NRenN7JiOqAz6kR5XWYsoZ42fTPRqouaS/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u9cIdAc3nI8a5LSCgjAtDOP9iO7yNigc2qisddXvfww=;
	b=tSZH3jK54jvaAaekon7z0b3TmRFZW8OnixP3Re6XCZ9ncHUxVEaj1ScepzO0UGryIUNs
	 MBQJPHnJ+ME09vxQGFAuQfDoqVbeXcABcpQn8XyMSgjllblDWBZag1YoWUSrT+x77usDU
	 X7eEMRPuQB/PtBa2N6KW1fLzFusnVsFrzSVb+oZBtFNJmyvvjQWeiAtEdK5DnWwKhyjJ1
	 yxHQlyGQPDG5ikPcAZD5lGD6M7wy2FA7d9ReyV1dR5z3jr3JbkG/KHYFTwgFPYaP/evzg
	 EFTAfoaLXaNOLxOEKZBR8q/MYgWgDLZh6YQKIoQ6nFahCG1f2d/BN81aNtC1kJ+sGkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqnW9Q7p;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25995606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25995606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqnW9Q7p
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1783656a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415620; x=1795020420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9cIdAc3nI8a5LSCgjAtDOP9iO7yNigc2qisddXvfww=;
        b=IqnW9Q7pEIMYsw5JF0gGQWQvjdc8iSRhLWoocI7u+CedmpOvR8PUIyhWiA4Ol4VrAZ
         LR0gAqe4lsuXdQtzSdEAqVWC3Ymq43RGJ2uibdh7YoMLf5ZuBbFI3CMSlhfTsDRiPoLV
         1rLDLrSUsMBSXwMj70K3bUH//HtbQFVclD80D4beohwEBeBLYmyvKWq+BiKZcQw8Iz6P
         pKGaLWZbRtDkW1usddQW/wCUsvJ00EBlsz1zORau+gBW53hApiFt/HckX4kktbNYeczA
         YE2fQbjEUi8ZmmxtqvxnoeirYO2GXTYlrimyZ5tonNDflQw+qrCDyU0w3W7MEshp02O6
         CF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415620; x=1795020420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9cIdAc3nI8a5LSCgjAtDOP9iO7yNigc2qisddXvfww=;
        b=Tv211XOgM9EOblmt99ObM7W9ml8wzyUSx63J5wsQtRaA3ImL/yWrPRdinE4Xf1+eVS
         r5Clr+9yticFWoPykhf0fkNLPA8IMPuyDaXJkHy/dmma73M539SdmYL2bbxkToLKaUp5
         x5KcdKydrkhXYSyMO4YB45tnjrQEYGb3Zrpk15Ey3ux/R4xZfI32jH57N5JEoyTNLPKy
         T+yWMO9XY7690pcf1RhMi0RPmZjbP9r5iz8IIh3EowjLZoXYVCpV31MP2ldE91S9wH8A
         z+o5jwMV7SeQy3nQeMedbIxyFHW6qkFtkjUwWJEFh7hhLo1EjsAUVubKOVLQQiLIdI8v
         OTjg==
X-Gm-Message-State: APuU4Z8uP7a0oCKpo6TjuFH+bPwF2K3mTrS9AEDv4cvm9pQlswnOsUj8
	falJjrR8h+Q/m1iNIb41VNO+qqCDYTfyqUqewbYgNb4KqnyD1AaBAYNHtJ91vg==
X-Gm-Gg: AYBFou0Hfua1jFwWUVRYbLRDm2FsemXfQ/2c4fDlEZu0eVJmqH2ESD18BMwQG9kYZbf
	OrfhAShfmXsxzpubXe2yZcEqu++qQIVLhg4zaCkcGIizaVCodmEgpuFag7ihdzqmtiuOYHu9NV8
	aRIxiniocyMqZ0USuy0hktcS5r4vxzv0tdlnBQ2jol9W8GZd3JNXI1vcVk+gbnAwdUGZuz1WWyr
	D5ygVyzl6bRX0hgiXpauugxzJ32Ps9vyWW49gqDu1KUL1BE00YadVS5pbqu9VPX4i7S2fPMYmRM
	DgqDifVWCT5SXspvO5ghlsRIyPKGBmdts12k/ZPjNc625mfd4Kq7jiiUDQionWVNUohPHdx6DKg
	w4sLgt4GmuBYm/fnncYctE4uoun0I+tZSFjUqqcle7BqkV6L6yBob75BXwpqqavNUtkhjfECo6Z
	hrV/K/ObZi10bDAC6ia43LEMspsmGCRf/XpSrHl9OnjHRcyO1V1cqPVLWv0VP/mSwqvJGaIUFWB
	Lqd9TblcnZBdYtROcKW4KrAeFGDLbclrj8iif73gf2CSobm381kg/EYq+/w8Jvc2kSY7BQAfdQL
	yIoGvvSTolYq2vhs9XtKF6sIuAotx/+wNDuhdXFfdDl4NvAnbVVmCi80GCaqqLLw+xQmnVq0gTo
	kPFwCuglbXZbh6mHfTmmXxhd0KK4JX3pdNaKl+xwRNIyiY1HyaRNALgRTpq07XFtezzo+jSKuFh
	A=
X-Received: by 2002:a17:90a:e7cd:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3b182f298ecmr2950288a91.53.1794415620138;
        Wed, 11 Nov 2026 08:47:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce556dsm31698a91.6.2026.11.11.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 10/29] bpf: Detect a dead branch when a range and var_off don't overlap
Date: Wed, 11 Nov 2026 16:45:33 +0000
Message-ID: <20261111164557.2659679-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A fix of the main pass that stands alone. It is also a prerequisite of the
patch that refines linked registers at conditional jumps: that patch
intersects the range of one register with var_off of another one and asks
reg_is_empty() if the intersection is empty.

  1: r0 <<= 3
  2: r0 += 5
  3: if r0 s< -2 goto pc+2
  4: if r0 s> 1 goto pc+1
  5: r0 += 3
  verifier bug: REG INVARIANTS VIOLATION (alu): range bounds violation

The low three bits of r0 are 5. No value in [-2, 1] has them: the range and
var_off don't overlap, the fall-through branch of insn 4 is dead. The
verifier takes it with an empty register, and the addition at insn 5 trips
over that.

simulate_both_branches_taken() refines the registers as each branch does
and drops a branch in which a range is empty. It relies on
reg_bounds_sync() to empty the range. __update_reg64_bounds() steps through
var_off from umin to umax, which are 0 and U64_MAX for a range that
crosses 0. __update_reg32_bounds() uses only the smallest and the largest
member of var_off.

tnum_step() returns the next member of var_off. reg_is_empty() asks for the
first one from the start of the range on and compares it with the end, in
64 and in 32 bits. A range that crosses 0 wraps around at U64_MAX or
U32_MAX: tnum_overlaps_cnum() splits it there. The test is sufficient, not
exact: 64 and 32 bits are checked each on its own.

The live branch gets the operands that simulate_both_branches_taken()
refined for it, as when both branches are live: refine_live_branch(). Not
after JSET, whose fall-through branch forgets the ranges. So far
check_cond_jmp_op() followed the live branch with the operands as they were
before the jump: with more branches found dead, valid progs would get
looser bounds. Registers with the same scalar id are not refined there. The
patch that refines linked registers at conditional jumps does it.

Three tests in verifier_bounds.c. Two have the values above shifted left
by 32: no member of var_off is in [-2, 1] and the branch is dead, -3 is one
in [-3, 1] and the branch is verified. The third one has the jumps above:
the fall-through branch is dead, r0 is not negative in the jump branch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 80 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_bounds.c     | 58 ++++++++++++++
 2 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bffc1e288f6..9db855bd6e1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2325,6 +2325,36 @@ static bool range_bounds_violation(struct bpf_reg_state *reg)
 	return cnum32_is_empty(reg->r32) || cnum64_is_empty(reg->r64);
 }
 
+/* Do @t and [min, max] overlap: is a member of @t in the range? */
+static bool tnum_overlaps_urange(struct tnum t, u64 min, u64 max)
+{
+	u64 tnum_next = tnum_step(t, min);
+
+	return (min & ~t.mask) == t.value || (tnum_next > min && tnum_next <= max);
+}
+
+/* The same for the cnum [@base, @base + @size]. It wraps around at @ut_max. */
+static bool tnum_overlaps_cnum(struct tnum t, u64 base, u64 size, u64 ut_max)
+{
+	u64 end = (base + size) & ut_max;
+
+	if (base <= end)
+		return tnum_overlaps_urange(t, base, end);
+	return tnum_overlaps_urange(t, base, ut_max) || tnum_overlaps_urange(t, 0, end);
+}
+
+/*
+ * A range and var_off don't overlap. reg_bounds_sync() compares var_off with umin and umax: it
+ * doesn't see that [-2, 1], which crosses 0, has no member with 5 in its low three bits.
+ */
+static bool reg_is_empty(struct bpf_reg_state *reg)
+{
+	return range_bounds_violation(reg) ||
+	       !tnum_overlaps_cnum(reg->var_off, reg->r64.base, reg->r64.size, U64_MAX) ||
+	       !tnum_overlaps_cnum(tnum_subreg(reg->var_off), reg->r32.base, reg->r32.size,
+				   U32_MAX);
+}
+
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
@@ -18911,24 +18941,24 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, bpf_rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(&env->false_reg1);
 	reg_bounds_sync(&env->false_reg2);
+	/* Jump (TRUE) branch. If FALSE is dead refine_live_branch() takes these registers. */
+	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
+	reg_bounds_sync(&env->true_reg1);
+	reg_bounds_sync(&env->true_reg2);
 	/*
 	 * If there is a range bounds violation in *any* of the abstract values in either
 	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
 	 * TRUE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
+	if (reg_is_empty(&env->false_reg1) || reg_is_empty(&env->false_reg2))
 		return 1;
 
-	/* Jump (TRUE) branch */
-	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
-	reg_bounds_sync(&env->true_reg1);
-	reg_bounds_sync(&env->true_reg2);
 	/*
 	 * If there is a range bounds violation in *any* of the abstract values in either
 	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
 	 * Only FALSE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
+	if (reg_is_empty(&env->true_reg1) || reg_is_empty(&env->true_reg2))
 		return 0;
 
 	/* Both branches are possible, we can't determine which one will be taken. */
@@ -19683,6 +19713,38 @@ static void mark_loop_exit_decided(struct bpf_verifier_env *env, struct bpf_veri
 	}
 }
 
+/*
+ * One branch of the jump @insn is dead, the current state takes the other one. @reg1 and @reg2 are
+ * the operands as that branch refines them. They hold every value that takes it, whether the other
+ * branch is dead or not.
+ */
+static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			      struct bpf_reg_state *reg1, struct bpf_reg_state *reg2)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	int err;
+
+	/* is_branch_taken() knew the branch before it refined anything */
+	if (!memcmp(reg1, &regs[insn->dst_reg], sizeof(*reg1)) &&
+	    (BPF_SRC(insn->code) == BPF_K || !memcmp(reg2, &regs[insn->src_reg], sizeof(*reg2))))
+		return 0;
+	/*
+	 * The fall-through branch of JSET forgets the ranges. Or this branch is dead too: the path
+	 * is infeasible. The registers are left as they are.
+	 */
+	if (BPF_OP(insn->code) == BPF_JSET || reg_is_empty(reg1) || reg_is_empty(reg2))
+		return 0;
+	err = reg_bounds_sanity_check(env, reg1, "live_reg1");
+	err = err ?: reg_bounds_sanity_check(env, reg2, "live_reg2");
+	if (err)
+		return err;
+
+	regs[insn->dst_reg] = *reg1;
+	if (BPF_SRC(insn->code) == BPF_X)
+		regs[insn->src_reg] = *reg2;
+	return 0;
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int *insn_idx)
 {
@@ -19788,6 +19850,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			if (err < 0)
 				return err;
 		}
+		err = refine_live_branch(env, insn, &env->true_reg1, &env->true_reg2);
+		if (err)
+			return err;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx += insn->off;
@@ -19803,6 +19868,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			if (err < 0)
 				return err;
 		}
+		err = refine_live_branch(env, insn, &env->false_reg1, &env->false_reg2);
+		if (err)
+			return err;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index f55d58af8004..f4fe85c46c04 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1995,6 +1995,64 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * r0 is x << 32, the low three bits of x are 5. No such x is in [-2, 1], -3 is in [-3, 1].
+ * umin and umax are unbounded for a range that crosses 0.
+ */
+#define RANGE_CROSSES_0(name, smin)		\
+__naked void name(void *ctx)			\
+{						\
+	asm volatile(				\
+	"call %[bpf_ktime_get_ns];"		\
+	"r0 <<= 35;"				\
+	"r1 = 0x500000000 ll;"			\
+	"r0 += r1;"				\
+	"r1 = " #smin " ll;"			\
+	"if r0 s< r1 goto 1f;"			\
+	"r1 = 0x100000000 ll;"			\
+	"if r0 s> r1 goto 1f;"			\
+	"r10 = 0;"				\
+"1:	exit;"					\
+	:					\
+	: __imm(bpf_ktime_get_ns)		\
+	: __clobber_all);			\
+}
+
+SEC("socket")
+__description("dead branch: tnum and a range that crosses 0 don't overlap")
+__success
+RANGE_CROSSES_0(range_crossing_0_no_tnum_overlap, -0x200000000)
+
+SEC("socket")
+__description("tnum overlaps the negative part of a range that crosses 0")
+__failure __msg("frame pointer is read only")
+RANGE_CROSSES_0(range_crossing_0_tnum_overlap_below_0, -0x300000000)
+
+/*
+ * The low three bits of r0 are 5. No such value is in [-2, 1]: the fall-through branch of the
+ * second jump is dead. The jump branch refines r0 to [5, S64_MAX - 2].
+ */
+SEC("socket")
+__description("dead branch: the live branch is refined")
+__success
+__naked void dead_branch_live_branch_is_refined(void *ctx)
+{
+	asm volatile(
+	"call %[bpf_ktime_get_ns];"
+	"r0 <<= 3;"
+	"r0 += 5;"
+	"if r0 s< -2 goto 1f;"
+	"if r0 s> 1 goto +1;"
+	"exit;"
+	"r0 s>>= 63;"
+	"if r0 == 0 goto 1f;"
+	"r10 = 0;"
+"1:	exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 SEC("socket")
 __success
 __naked void signed_unsigned_intersection32_case1(void *ctx)
-- 
2.55.0

