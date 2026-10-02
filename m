Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561F402BA9
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945248; cv=none; b=lCQ3ai4HND0+7XXehFjFbVQbrK0nRQoJeRSH23Trw84O0FwsFXXyl20kQ6g/5LqoRbWTR59liaaXC+CCJrrJRm1Xi1RBycMBIP5IrK4ns4iJYI5mhmqMKNAZuKq5exNKB3OdGA2mfVV7yKzyvHg0hZGp+ItxvRPKdxHEVCJSGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945248; c=relaxed/simple;
	bh=NGIdXDzu1nEV5qKNdxaur5FZcZaJG6KmsuUZI9M+81U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXMEhdgi4swzIHIpRIimZqeHAS9FnP0R7A0fRHmQMMYRQRnecxVJm/9lANY0TNvi28m1lEDpRq3pqMGIBGcf7D0I+zxY1qDAA3iuWP8X6uOPwn2enxoU/wX0MZvAcGU6ijjxY/dOQekG+7wq67k7zCva9+tl08XFBv/uBeVOYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlp20Toy; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlp20Toy"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86efece610cso3738002b3a.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945246; x=1791550046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IPvEGmMstQGnUkU+ZxruMU0lW6gIosh2odEGnmIh5U=;
        b=nlp20ToyvUuk0dSnOlqjrOovWJUgiIJD/NC+iB9Muc9n0TL680U5vcpRLy09thEvAb
         GgH3xYfaqpIgCqg6WVfIItaKepX+5vMcC4j5Ugd3TyJjYqRj4IuqhW/S4OFWZ5LPcueC
         YgbcIElfLCeM+gflcoJLPQbcv/DkZzO2T2AGU4w9xcHVkyNrmIoDbO9dPwEqteP9tedL
         cZTlBe8N2JDwhz8sBdmgOAvkaMyEeJ4X9Sm/I0grRiugzGYz/vM/dKZQmN0K3VPLii4A
         JuI/5NVfMXsR8OJJ24yOW29/ARzhttel4cBHm3N9hqKRcHgrCbrPNZRGMDyz+fF4zbDX
         koow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945246; x=1791550046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8IPvEGmMstQGnUkU+ZxruMU0lW6gIosh2odEGnmIh5U=;
        b=o6DjtvO17AwKI6ebsP7hxKkoOrhuG6iAWDSvcK5p/Xs9YVxUcZuFjtLWulpPemPvI+
         NT6xwRABi3Jx98UEEkFxiguX4vqPJGUwfo0t/MJJm23m3gb/rM94oznkPsfE0Cd6HKw4
         EsQ27MaiUUF+WR56ytGXuyMp57ZKX61UIuLi8dgrJL8bzArvl05A6JW4ZYDDCk784OaA
         gtbTeoO4hhaNBr0YIOUeM5+Mdrox6zw1oUcZGoOoYCrJuM4GieP5NVyQwCEXZnuJZmyN
         LnGLIEhXGQ8qGdAJ8PT7YF8bew/YzrsWWThhMuAaJQMpS7CpiybWdpGCJ7Qbbi6+YxmF
         3eVQ==
X-Gm-Message-State: AFuF++m7MaqeIhwav97lPikpn9qzdcBQVpO1gg0hy5l7Sw/elxvtHeAC
	WRnNtN9TLiRp/l5tfSQYMFVeyvMEGtKwWE1Gf8uDxuya/2hvXD4hE4lB8+YS3781F5Q=
X-Gm-Gg: AYBFou3tNzqRNysrC6RTm8pxMM6v+rwQ98QQ12lxhA8sy84UkIEyQ/96Xu8EgYEHVre
	rGjsH76vX3yKUmjxic8+FwNyOtF8AVS4wKqdyncMoDvGdyGVPd8OCr7EeEFj+FAl+MPw41MnES4
	tp6c/ku4v6y2BcDjxoi0P+jeyWGGb9GvtLaCwiatDOwm41ZLCEVZDe5jyMll6kRRsRPzLgk4DFi
	nPA6cEyqyivwNZ9Vn9nKczIkdROxUU98n6XuW9ykQWpkvT34xoqj9DrROD41WPX8v/mcG8m4zXr
	GIpHeEB2hORIzgvBbP2ncGiQaHbsX4xiIsS18/wW8OHq3uBw23MCU9iKkYv2VvXCarPTAFtCnYA
	y1dTf7YuOfllFJbGTjMAiHo3mvlurjFf9fC+yyTen2PUSZXvnP+fiU/E6L3+hE8k8GkCbed1s4o
	biUBNZovupRrRypdZpTp6veYFB9TvXuei0p+XZ5D7YFehiRf0HMPKlxDoFMpRcUAlDh7AWxu/GI
	d2daBnsZGCn1BZIrLeNm1je6PvoVKeiQkocalPwy4ZZdi3orIxtBTfI6cNSE3LHc84L10NfDnwa
	NVt2nHwEcD63N/BlsJlHSZEqxm1nv3nspZCMEjMkZiM=
X-Received: by 2002:a05:6a20:3d1f:b0:3de:b120:bba4 with SMTP id adf61e73a8af0-3e0bcff2356mr2534357637.50.1790945245511;
        Fri, 02 Oct 2026 05:47:25 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7370db1sm893531a12.17.2026.10.02.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 03/15] bpf: Treat load and store through a number as arena access
Date: Fri,  2 Oct 2026 12:47:02 +0000
Message-ID: <20261002124714.180012-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

There are no address spaces in Rust. LLVM emits plain loads and stores
for arena memory, without cast_kern:

  r3 = 0x20 ll            // R_BPF_64_64 .bss, libbpf puts it into arena
  r2 = *(u64 *)(r3 + 0)   // R3 invalid mem access 'scalar'
  lock *(u64 *)(r2 + 8) += r1

Add BPF_F_ARENA_SCALAR flag of BPF_PROG_LOAD. When the program is loaded
with it and has an arena treat ldx, stx, st and atomics through a number
as arena access. It's as safe as access through PTR_TO_ARENA: JIT adds
the base of arena to the low 32 bits of the address. The program has
an arena only with CAP_BPF and CAP_PERFMON.

Registers of the program are not changed, since Rust compares and
stores the address after the access. bpf_do_misc_fixups() copies
the low 32 bits into BPF_REG_AX and the access goes through it:

  r2 = *(u64 *)(r3 + 0)  ->  w12 = w3
                             r2 = *(u64 *)(r12 + 0)

Constant blinding needs BPF_REG_AX for immediates and leaves insns that
use BPF_REG_AX alone. So the immediate of st through a number is not
blinded, the rest of the program is:

  *(u64 *)(r3 + 0) = 1   ->  w12 = w3
                             *(u64 *)(r12 + 0) = 1

The same insn may see PTR_TO_ARENA on another path. It works for both.

It's a flag, since a number is also what the verifier makes of a pointer
that went away when the program has CAP_PERFMON: a ringbuf record after
bpf_ringbuf_submit(), a pointer to the packet after bpf_skb_pull_data().
Programs in C that have an arena keep "invalid mem access 'scalar'" for
such bugs.

JIT tells with bpf_jit_supports_arena_scalar() that it takes BPF_REG_AX
as the address of arena access. With other JITs the flag is rejected
with -EOPNOTSUPP. x86 and arm64 do:
- x86: the fault handler finds the register that holds the address
  through reg2pt_regs[]. Add BPF_REG_AX, r10 of x86, there.
- arm64: nothing else is needed. The JIT takes any register as the
  address and the fault handler reads it by its number. Compile tested
  only.

Any number is an address of arena, NULL and small numbers included, like
it is for PTR_TO_ARENA: arena code in C dereferences NULL and relies on
the fault being handled.

Still rejected:
 - insn that sees a number on one path and a pointer that is not
   PTR_TO_ARENA on another.
 - numbers passed to helpers and kfuncs, except __arena arguments.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c  |  5 +++
 arch/x86/net/bpf_jit_comp.c    |  6 ++++
 include/linux/bpf_verifier.h   |  2 ++
 include/linux/filter.h         |  1 +
 include/uapi/linux/bpf.h       |  6 ++++
 kernel/bpf/core.c              |  6 ++++
 kernel/bpf/fixups.c            | 39 ++++++++++++++++++++++
 kernel/bpf/syscall.c           |  4 +++
 kernel/bpf/verifier.c          | 61 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |  6 ++++
 10 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 475e70653454..6979c8ead0e8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3413,6 +3413,11 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_scalar(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	if (!in_arena)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6c7a0578760e..8199d28e2a12 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -236,6 +236,7 @@ static const int reg2pt_regs[] = {
 	[BPF_REG_7] = offsetof(struct pt_regs, r13),
 	[BPF_REG_8] = offsetof(struct pt_regs, r14),
 	[BPF_REG_9] = offsetof(struct pt_regs, r15),
+	[BPF_REG_AX] = offsetof(struct pt_regs, r10),
 };
 
 /*
@@ -4667,6 +4668,11 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_scalar(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	if (!in_arena)
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 811342e3c041..0074f1356c58 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -672,6 +672,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool arena_scalar; /* ldx/stx/st/atomic through a number, it's an address in arena */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
@@ -943,6 +944,7 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
+	bool arena_scalar;		/* load and store through a number is arena access */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
 	 * lists of struct bpf_verifier_state_list.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e42eccb0990e..9339c6131f8f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1250,6 +1250,7 @@ bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
+bool bpf_jit_supports_arena_scalar(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 bool bpf_jit_supports_large_stack(void);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4687c3310996..e0ed44b1bbcb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1344,6 +1344,12 @@ enum bpf_perf_event_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
 
+/*
+ * Load and store through a number is an access to the arena of the program
+ * at the low 32 bits of the number. It's for programs written in Rust.
+ */
+#define BPF_F_ARENA_SCALAR	(1U << 8)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d3b8b626ec0f..a1721f9c0f52 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3429,6 +3429,12 @@ bool __weak bpf_jit_supports_arena(void)
 	return false;
 }
 
+/* Whether JIT takes BPF_REG_AX as the address of arena access */
+bool __weak bpf_jit_supports_arena_scalar(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	return false;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 37cf130ebb57..b4bfe5522003 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -46,6 +46,31 @@ static bool is_addr_space_cast32(struct bpf_prog *prog, const struct bpf_insn *i
 	return false;
 }
 
+/*
+ * The insn accesses arena through a number. JITs add the base of arena
+ * to the register as it is, so the access goes through the low 32 bits of
+ * the number in BPF_REG_AX. Registers of the program are not changed: the
+ * number may be compared or stored later, and on another path the register
+ * may be PTR_TO_ARENA.
+ *
+ * Constant blinding leaves insns that use BPF_REG_AX alone, so the immediate
+ * of st through a number is not blinded.
+ */
+static int arena_scalar_access(const struct bpf_insn *insn, struct bpf_insn *buf)
+{
+	bool load = BPF_CLASS(insn->code) == BPF_LDX || bpf_atomic_is_load_acq(insn);
+	struct bpf_insn *patch = buf;
+
+	*patch++ = BPF_MOV32_REG(BPF_REG_AX, load ? insn->src_reg : insn->dst_reg);
+	*patch = *insn;
+	if (load)
+		patch->src_reg = BPF_REG_AX;
+	else
+		patch->dst_reg = BPF_REG_AX;
+	patch++;
+	return patch - buf;
+}
+
 /* Return the regno defined by the insn, or -1. */
 static int insn_def_regno(const struct bpf_insn *insn)
 {
@@ -1785,6 +1810,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 
+		if (env->insn_aux_data[i + delta].arena_scalar) {
+			cnt = arena_scalar_access(insn, insn_buf);
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			prog = new_prog;
+			env->prog = prog;
+			insn = prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
 		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
 		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
 		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ac52f4ae414c..778bca2abc04 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2948,9 +2948,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
 				 BPF_F_TEST_REG_INVARIANTS |
+				 BPF_F_ARENA_SCALAR |
 				 BPF_F_TOKEN_FD))
 		return -EINVAL;
 
+	if ((attr->prog_flags & BPF_F_ARENA_SCALAR) && !bpf_jit_supports_arena_scalar())
+		return -EOPNOTSUPP;
+
 	bpf_prog_load_fixup_attach_type(attr);
 
 	if (attr->prog_flags & BPF_F_TOKEN_FD) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1033167cfa93..2daee0130e5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5250,6 +5250,19 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
+/*
+ * There are no address spaces in Rust, addresses of arena are plain numbers.
+ * When the program is loaded with BPF_F_ARENA_SCALAR and has an arena a load or
+ * a store through a number is an access to arena at the low 32 bits of it,
+ * like the access through PTR_TO_ARENA is. The register stays a number.
+ */
+static bool is_arena_scalar(struct bpf_verifier_env *env, int regno)
+{
+	const struct bpf_reg_state *reg = reg_state(env, regno);
+
+	return reg->type == SCALAR_VALUE && env->arena_scalar && env->prog->aux->arena;
+}
+
 static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
 			       struct bpf_insn *insn)
 {
@@ -5280,7 +5293,7 @@ static bool atomic_ptr_type_ok(struct bpf_verifier_env *env, int regno,
 		return false;
 	if (is_sk_reg(env, regno))
 		return false;
-	if (is_arena_reg(env, regno))
+	if (is_arena_reg(env, regno) || is_arena_scalar(env, regno))
 		return bpf_jit_supports_insn(insn, true);
 	if (is_load_acq_unsafe(env, regno, insn))
 		return false;
@@ -7161,6 +7174,22 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+/*
+ * Returns the register to check the access of the current insn with.
+ * For a number in a program with an arena that is 'arena'.
+ */
+static struct bpf_reg_state *mem_access_reg(struct bpf_verifier_env *env, int regno,
+					    struct bpf_reg_state *arena)
+{
+	if (!is_arena_scalar(env, regno))
+		return cur_regs(env) + regno;
+
+	memset(arena, 0, sizeof(*arena));
+	arena->type = PTR_TO_ARENA;
+	env->insn_aux_data[env->insn_idx].arena_scalar = true;
+	return arena;
+}
+
 static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			  bool strict_alignment_once, bool is_ldsx,
 			  bool allow_trust_mismatch, const char *ctx)
@@ -7168,6 +7197,7 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state arena, *src_reg;
 	enum bpf_reg_type src_reg_type;
 	int err;
 
@@ -7189,15 +7219,16 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
-	src_reg_type = regs[insn->src_reg].type;
+	src_reg = mem_access_reg(env, insn->src_reg, &arena);
+	src_reg_type = src_reg->type;
 
 	/*
 	 * check_stack_read_fixed_off() may refine the modification's origin to
 	 * the source stack slot.
 	 */
 	bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
-	err = check_mem_access(env, env->insn_idx, regs + insn->src_reg, argno_from_reg(insn->src_reg), insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
+	err = check_mem_access(env, env->insn_idx, src_reg, argno_from_reg(insn->src_reg),
+			       insn->off, BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
 			       strict_alignment_once, is_ldsx);
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
@@ -7214,6 +7245,7 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state arena, *dst_reg;
 	enum bpf_reg_type dst_reg_type;
 	int err;
 
@@ -7235,11 +7267,12 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
-	dst_reg_type = regs[insn->dst_reg].type;
+	dst_reg = mem_access_reg(env, insn->dst_reg, &arena);
+	dst_reg_type = dst_reg->type;
 
 	/* Check if (dst_reg + off) is writeable. */
-	err = check_mem_access(env, env->insn_idx, regs + insn->dst_reg, argno_from_reg(insn->dst_reg), insn->off,
-			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
+	err = check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn->dst_reg),
+			       insn->off, BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
 			       strict_alignment_once, false);
 	err = err ?: save_aux_ptr_type(env, dst_reg_type, false);
 
@@ -7249,7 +7282,7 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 static int check_atomic_rmw(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn)
 {
-	struct bpf_reg_state *dst_reg;
+	struct bpf_reg_state arena, *dst_reg;
 	int load_reg;
 	int err;
 
@@ -7294,6 +7327,9 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	/* load_reg may be dst_reg. Look at dst_reg before it's marked as unknown. */
+	dst_reg = mem_access_reg(env, insn->dst_reg, &arena);
+
 	load_reg = bpf_atomic_load_reg(insn);
 	if (load_reg >= 0) {
 		/* check and record load of old value */
@@ -7302,8 +7338,6 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 			return err;
 	}
 
-	dst_reg = cur_regs(env) + insn->dst_reg;
-
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
@@ -19351,15 +19385,17 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			return check_stack_arg_write(env, state, insn->off, NULL);
 		}
 
+		struct bpf_reg_state arena, *dst_reg;
 		enum bpf_reg_type dst_reg_type;
 
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 		if (err)
 			return err;
 
-		dst_reg_type = cur_regs(env)[insn->dst_reg].type;
+		dst_reg = mem_access_reg(env, insn->dst_reg, &arena);
+		dst_reg_type = dst_reg->type;
 
-		err = check_mem_access(env, env->insn_idx, cur_regs(env) + insn->dst_reg, argno_from_reg(insn->dst_reg),
+		err = check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn->dst_reg),
 				       insn->off, BPF_SIZE(insn->code),
 				       BPF_WRITE, -1, false, false);
 		if (err)
@@ -22518,6 +22554,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
+	env->arena_scalar = attr->prog_flags & BPF_F_ARENA_SCALAR;
 
 	env->explored_states = kvzalloc_objs(struct list_head,
 					     state_htab_size(env),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4687c3310996..e0ed44b1bbcb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1344,6 +1344,12 @@ enum bpf_perf_event_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
 
+/*
+ * Load and store through a number is an access to the arena of the program
+ * at the low 32 bits of the number. It's for programs written in Rust.
+ */
+#define BPF_F_ARENA_SCALAR	(1U << 8)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
-- 
2.55.0

