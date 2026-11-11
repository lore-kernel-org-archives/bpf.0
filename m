Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374099;
	b=A/d2X0W1VfhSgPCU7xyCbXEGv5nA32ZMlQozmUY3nR3j4oqDh87TmQHC2VepL0ccgz2S
	 tQ+JFVre8GjsQzzZoMF9Tve4/UTYLESy05sWEib0Q9/TvV26bjiZcsjs5IfnRMNdx9JHM
	 KDiJJxRfJq75U5QtR0S2ReoMuBZ8NFxutYGj+y/xHm6zYrcSl3e36IqKves7uhMEf5R4W
	 jsCo0QT5eje2WNaLT/dqI39RTg0hmLZvsQht/zZ3GHpVM2TAroQ63FHHJJgK69gTb7vDZ
	 ClPibDDLHTN1mHFQD8ICXnp3N8vgRlOVs2omxKzp8CgMXsUOi5340kp7Loj6Kjyx6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3mIegdpWOrYNYmqe7x3KNIJW7BEwVCYAJDkyWmHSmMM=;
	b=PGeJ1KX9n99ct0/Iuy9lTxD5ET/0RL3iprksFNm/UAnVvEL7a37caHBB3bJvHqJpp/3s
	 1fWAZn7bV3j4yFtXwfGA9si4Wns6QreEm4seSUTQMXxAayZ3Ezq0F/J4ReHTrhYa6uh5v
	 nb6i/WPUKG4zCb3yVgab0DtyGTJEyQGvYrPC3vVrcS8M6FSwHa3VzLkEUPXAy676q/Ym0
	 ffUWu+Ut/IVNMzEYdlCxdGbOxrrRb00yKOyAJPqygffnT0AYdSeAou33JMdcJNqKUciMk
	 HlA2EP5TU0RkJI6ioPf0d2urmiK+Aw6xehDhK75zaQCpacenTpJtIbKumqljrdKEMqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4NA+Mf9;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271C606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F271C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4NA+Mf9
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so1953367a91.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374097; x=1794978897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mIegdpWOrYNYmqe7x3KNIJW7BEwVCYAJDkyWmHSmMM=;
        b=E4NA+Mf9PkDTo2VoL/ekPIcfDZ2AKlA7bguW/7iQPpnG4FVv6hSkI35eHhzVkA1owd
         7dG6PckMBwJSrn+ZGMGSTQyBjKXQlIWeS+ZEhH/0vkftJMDx/LI2NnLOu7yflx21LjUN
         TKYzuTxlTfLB4bnJwI+JsU2yxDiVh4wxgeacBewjLybKrfMir31WZfGypQf6VDO0t3nY
         ZogoU6MfE0k6r8lCt2YzoUpl1kDhjJR6irf4qzp92ErLxeO8srJ4zJLfnhkZdnc6SGjG
         JTTZ83u0RJuX2pyROvLBK//Ox7ZHmxGRKbL0GeDKjDRONLQ1fdeQ1D3KtT4aNmLgDw8n
         TONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374097; x=1794978897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3mIegdpWOrYNYmqe7x3KNIJW7BEwVCYAJDkyWmHSmMM=;
        b=BxbQ9QMIkQJ+Aquu0hHVwgS7ajQj1Y982B1qL3WbPXWpS7a1tf3xJHGeYhx9+cB9EG
         QaKUoxRmFYyVeCTrgAZsXVjnyh+BlxLj8v+/kfwLTawZUHHVNN8vvn40aS1SHqm4NoIx
         XRwZYZSmkdfwrFsyD8rNQ3VOcxc1cmQc0dcYJ/UDXLiIg3pRj7uviIe3SOkRxBV/5xz+
         xfcx42xXFBqxCPFcD/XvUgAMYt4nea6aP8JkkNmxi1W9hO+9ci540yasslADIR1Rlq+6
         rasCzFieeZNBzn5W+4TepdjgMVuR86x8Sudz4tNMVRZZfTXR1GcGEmkBPNxx6XeKajq9
         qFew==
X-Gm-Message-State: APuU4Z+IrpLnQp5DUpW+1CBcAJjKg/NvVpOWKob/wP2UeuapDS6XRuYh
	HUC8t0EQhwS22cuYxLeHJWEWqhh55aCStwP3XuhI75SYpuAdBHUju6Jx3bCv5w==
X-Gm-Gg: AYBFou3rneofHiZquryfSIVXZu3tKEi44NvaKjWcuyBphsvJqBNESj05/ejaVqmfjyS
	Xs0js7zXSYM/cJEHBulzeG2Xs/tce8PCQsUJ1xGDDL6znp5eJtB7VyIkR/iiL+73FCJZiFq4NK2
	MS89i1pmJ0yHNJZcYrruBWxnMOIOlBA9ZgcoO+mrZqHvacPDXeVx9QZq09Z+m5fheaRCAM7GHwY
	Ilc5XC6ycQvpbrVnP/8bQn3nPvuGnkKivWSf0Wfk7mVW6rfgnk43W9Z0Z5MpRQIbmzk2qWw6/kK
	KgWd8tOvOCOmywpT1+fIE5rx9JC5lac8YCEGe8B+KaTpW5/G69LaCXB0ODr+Yznug5E9vQPvntt
	o9jRMg9E4/CqEVl/xslXL7dXTfy9/jzgHRXuhx7JezDrqsqEYVOaUY4lC7bEHZbttZ3lTXysRGy
	DoekgZrW6wv0tT3dMwK0rKpmEgjeGzEkVOjuY9NjxQwfAFuo80GEDfvzX3i14JTgBf5QEKy3KMN
	4xRdtm3aFUQYn/XOsJ9ZjjbDuQ80qQbxoWxkQa1WScI0duh00jXYCtrmwyIyZjReZXC6xbbqNcg
	6cmQ08JvU5AvyIcMYN8XG43QYOrWkKieIHHybcvz0V1i6eMGV4/SoUC1CQKYdB4M/YnhPhcJgVM
	2i5B6+HzPxaXKO/o6SgEkn6RwDWOGOAehoGgipkMCWbDDBtljLckqYPX12gPd7jOcSsfVJnJ6uA
	==
X-Received: by 2002:a17:90b:2243:b0:3ac:4291:f569 with SMTP id 98e67ed59e1d1-3b182df391dmr1548810a91.8.1794374096749;
        Tue, 10 Nov 2026 21:14:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7fc2dsm2645901a91.13.2026.11.10.21.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 12/29] bpf: Refine registers linked by scalar evolution at conditional jumps
Date: Wed, 11 Nov 2026 05:13:23 +0000
Message-ID: <20261111051341.2800252-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A new ability, and the first user of scalar evolution outside of loops.
The linked registers of a conditional jump are the live registers and
stack slots that are a tested register + a constant on every path to the
jump. scev.c computes them before the main pass, and the main pass refines
them together with the tested registers. Scalar ids do some of that today.
They stay for now, later patches remove them.

	if (bpf_dynptr_from_skb(skb, 0, &ptr))
		return NF_DROP;
	..
	return NF_DROP;

That is ip_check_defrag.c of the selftests. NF_DROP is 0, and GCC returns
the 0 that the call returned:

	27: call bpf_dynptr_from_skb
	28: r5 = (s32)r0
	29: if w0 != 0x0 goto pc-12
	..
	46: r0 = r5
	50: exit
	At program exit the register R0 has smin=-2147483648
	smax=2147483647 should have been in [0, 1]

The jump bounds r0. r5 got no scalar id at 28: r0 was not known to be below
2^31.

Before insn 29 r0 is %r0.27, the def of r0 by insn 27, and r5 is
(sext32 %r0.27). split_const_offset() strips added constants, extensions
and partial spills: expr == base + off (mod 2^bits). Expressions with the
same base, a value number, have a constant difference: const_diff(). Then
find_linked_regs() links the registers:
linked == tested + delta (mod 2^bits), here r5 == r0 (mod 2^32).

Unlike scalar ids the links are not stored in a state and have no limit of
five registers (LINKED_REGS_MAX). They also cover registers that agree in
their low 8, 16 or 32 bits only, like r5 and r0 above, where a scalar gets
no id or loses it. A link stays within one frame. At the header, a latch or
an exit of a loop the difference may also be one that holds at the header
in every iteration: it holds at loop entry and every backedge preserves it,
const_diff_at_header().

refine_linked_regs() adds delta to the tested register and intersects the
linked one with the result, as 'if r5 == r0' does, in 64 or 32 bits. Values
that are equal modulo 2^8, 2^16 or 2^32 are equal if both fit in uN or both
in sN: then all 64 bits are intersected. Equal in 64 bits is equal in the
low 32 bits: 'if w1 s> 200' on a zero-extended int refines nothing but the
32-bit range, and the linked registers get that too. The intersection is
empty, or the two var_off don't overlap: no execution gets here with this
state (the path is infeasible), the register is left as it is. Types are
read in the state: both have to be scalars. So is the width of a spill:
__clean_func_state() leaves a 32-bit spill of a 64-bit spill whose other
half-slot is dead, and a link in 64 bits refines its low 32 bits.

scev.c has the insns, no types and no states. Where that matters:
 - Arena: an ALU64 insn is converted to ALU32 at fixup if an operand is an
   arena pointer. In a prog with an arena its result gets a def too:
   %r2.12=(+ x 4) is x + 4 in 64 or in 32 bits. It is trusted modulo 2^32,
   and modulo 2^64 once the main pass has verified insn 12 without an arena
   pointer: prevent_zext is only ever set, and the def dominates every use.
   %r2.25=phi((+ x 4)) joins two such defs. The phi is not (+ x 4).
 - Slices: a store through what bpf_dynptr_slice_rdwr() returned may alias
   the buffer on the stack and is in no bpf_may_write_mask(). In a prog
   with that kfunc a slot that a call may write is a value number only
   after a store through r10, which invalidates the slices. Two fills from
   such a slot can read distinct values, one fill reads one: the fill
   defines the register, like a load from other memory.
 - Phis: the op of a phi is what the joined values have in common, any op.
   simplify() and expr_spill_size() look through extensions and partial
   spills, not through a phi.

20 more progs of the selftests load when GCC builds them, among them
profiler1-3, test_sk_lookup and setget_sockopt. The kernel spends
0.7 % more instructions on loading the selftests, Cilium, sched_ext, katran
and bpfjailer, 1.5 % more on programs in Rust.

scalars_double_add and subreg_equality_2 expected a missing link and load
now. bounds_deduct_negative_overlap, linked_regs_too_many_regs and
ldsx_fill_scalar_id_not_shared pin a range or a message that is more
precise now. The arena tests of verifier_scev.c move to verifier_arena.c:
libbpf binds an arena to all progs of an object, so every prog of
verifier_scev.c had one.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/scev.c                             | 493 ++++++++++++++++--
 kernel/bpf/verifier.c                         | 118 +++++
 .../selftests/bpf/progs/verifier_arena.c      |  28 +
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../bpf/progs/verifier_linked_scalars.c       |   5 +-
 .../selftests/bpf/progs/verifier_reg_equal.c  |  11 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |   6 +-
 .../selftests/bpf/progs/verifier_scev.c       |  36 --
 9 files changed, 616 insertions(+), 87 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4771c55d8f41..d1841f68437d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1902,6 +1902,7 @@ u32 btf_func_arg_align(const struct btf *btf, const struct btf_type *t);
 
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
+bool bpf_is_dynptr_slice_rdwr_kfunc(struct bpf_insn *insn);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
@@ -2224,6 +2225,9 @@ int bpf_init_scev(struct bpf_verifier_env *env);
 void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
 int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool taken_leaves);
+bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
+			      u32 *linked_regno, u32 *fill_off, s64 *delta, u32 *bits);
+bool bpf_scev_in_slice_slots(struct bpf_verifier_env *env, int off, u32 size, bool fixed_off);
 
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index a0324fbc875e..5506e0d4e534 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -65,6 +65,10 @@ enum expr_op {
  * a value number of its own.
  * In the env of loop H a phi at H merges the backedge values only, the header phi itself is
  * (REG r). In the env of the enclosing loop a phi at H merges the entering edges.
+ * Op and params of a def by an insn are what that insn computes, see alu64_with_def():
+ * set_expr_base() looks through such an add, split_const_offset() checks prevent_zext of the insn.
+ * Those of a phi are the shape that its operands share, no insn computes them: nothing looks
+ * through a phi.
  */
 struct expr_def {
 	u32 set:1;	/* 0: the expression has no def */
@@ -80,6 +84,8 @@ struct expr {
 	u16 op;
 	/* A value number: all SCEV registers of an env that have this id hold the same value */
 	bool is_vn;
+	/* expr == base + off (mod 2^bits), see split_const_offset() */
+	u8 bits;
 	/*
 	 * UNKNOWN, OPAQUE and ANY don't describe a value. With a def the id stands for one value,
 	 * see struct expr_def. Without a def every use of the id can be another value.
@@ -89,6 +95,13 @@ struct expr {
 		u32 params[2];
 		s64 imm;
 	};
+	u32 base;
+	/*
+	 * id of the first add on the way to 'base' whose insn may still become ALU32, see
+	 * prevent_zext. 0: none
+	 */
+	u32 arena_add;
+	s64 off;
 };
 
 struct env {
@@ -97,8 +110,17 @@ struct env {
 	u32 reg2scev[REGS_NUM];
 };
 
+/* A SCEV register and the id of its expression before a conditional jump */
+struct scev_linked_reg {
+	u32 reg;
+	u32 id;
+};
+
 struct insn_envs {
 	u32 cnt;
+	/* The linked registers of a jump, see find_linked_regs(): linked_cnt of scev->linked[] */
+	u32 linked_first;
+	u32 linked_cnt;
 	struct {
 		int loop_header;
 		struct env *env;
@@ -119,6 +141,8 @@ struct scev {
 	/* Read-only representatives for stack slots without a saved register. */
 	struct bpf_reg_state zero_reg;
 	struct bpf_reg_state unknown_reg;
+	/* r -> (REG r): before the first insn of a loop every SCEV register is its header phi */
+	struct env identity_env;
 	/*
 	 * Expressions are identified by id, exprs_ht ensures that
 	 * each expression exists as a unique instance.
@@ -131,6 +155,9 @@ struct scev {
 	struct scev_worklist worklist;
 	struct insn_envs **envs;
 	struct expr *exprs;
+	struct scev_linked_reg *linked;
+	/* The stack slots that a store through a dynptr slice may alias, see expr_is_vn() */
+	DECLARE_BITMAP(slice_slots, MAX_BPF_STACK_SLOTS);
 	/*
 	 * Loops are analyzed one by one, this array keeps track if a particular
 	 * instruction was visited on a current pass.
@@ -138,6 +165,8 @@ struct scev {
 	u32 *discovered;
 	int exprs_cnt;
 	int exprs_cap;
+	u32 linked_cnt;
+	u32 linked_cap;
 	int envs_cnt;
 	int stack_sz;
 	int simplify_depth;
@@ -200,10 +229,17 @@ static u32 op_params_num(u32 op);
 
 static bool expr_is_vn(struct scev *scev, struct expr *e)
 {
-	u32 i;
+	u32 i, reg = e->def.reg;
 
+	/*
+	 * bpf_dynptr_slice_rdwr() can return the buffer that it got. A store through that slice may
+	 * alias the slots of the buffer and is in no bpf_may_write_mask(): it is no def, so a def
+	 * of such a slot is no value number. A spill through r10 has the expression of the
+	 * register, and invalidate_stack_slices() invalidates the slices there. The next slice
+	 * comes from a call that may write to the slot.
+	 */
 	if (e->def.set)
-		return true;
+		return reg < MAX_BPF_REG || !test_bit(reg - MAX_BPF_REG, scev->slice_slots);
 	switch (e->op) {
 	case UNKNOWN:
 	case OPAQUE:
@@ -223,6 +259,37 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	return true;
 }
 
+static u32 op_low_bits(u32 op);
+
+/*
+ * @e gets the id @id. (+ x imm), an extension and a partial spill of x have the base of x, which
+ * was constructed earlier. Every other expression is its own base. So split_const_offset() does not
+ * traverse the expression.
+ */
+static void set_expr_base(struct scev *scev, struct expr *e, u32 id)
+{
+	u32 low = op_low_bits(e->op);
+	struct expr *x;
+	s64 imm = 0;
+
+	e->base = id;
+	e->off = 0;
+	e->bits = 64;
+	e->arena_add = 0;
+	/* nothing looks through a phi, see struct expr_def */
+	if (e->def.phi)
+		return;
+	if (e->op == BPF_ADD && scev->exprs[e->params[1]].op == IMM)
+		imm = scev->exprs[e->params[1]].imm;
+	else if (!low || e->def.set)
+		return;
+	x = &scev->exprs[e->params[0]];
+	e->base = x->base;
+	e->off = (u64)x->off + imm;
+	e->bits = low ? min(x->bits, low) : x->bits;
+	e->arena_add = e->def.set ? id : x->arena_add;
+}
+
 static int add_expr(struct scev *scev, struct expr e)
 {
 	u32 id;
@@ -242,6 +309,7 @@ static int add_expr(struct scev *scev, struct expr e)
 
 	id = scev->exprs_cnt++;
 	e.is_vn = expr_is_vn(scev, &e);
+	set_expr_base(scev, &e, id);
 	scev->exprs[id] = e;
 	exprs_ht_add(scev, id);
 	return id;
@@ -590,6 +658,9 @@ static bool expr_next(struct scev *scev, u32 *id, u32 *order)
  *	%r8.7=phi(1, 2)		the phi of r8 before insn 7
  *	%r0.7=phi(_)		a phi of distinct OPAQUE values
  *	%r6.9=phi(?)		a phi of distinct UNKNOWN values, or of more than 8 values
+ *	%r2.12=(+ x 4)		insn 12 defines r2, see alu64_with_def()
+ *	%r2.25=phi((+ x 4))	two adds of one shape, each may have been converted to ALU32:
+ *				the phi is not (+ x 4)
  * A name is unique within the env of one loop. In the env of loop H a phi at H merges the backedge
  * values only, the header phi itself is (REG r): in 'scev at header 1: r6=%r6.1=phi(r6, (+ r6 1))'
  * one backedge leaves r6 as it is, the other one adds 1.
@@ -754,7 +825,7 @@ static struct env *get_loop_env(struct scev *scev, int loop_header, int insn_idx
 	if (!e)
 		return NULL;
 
-	tmp = krealloc(envs, struct_size(envs, entries, cnt + 1), GFP_KERNEL_ACCOUNT);
+	tmp = krealloc(envs, struct_size(envs, entries, cnt + 1), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!tmp) {
 		kfree(e);
 		return NULL;
@@ -781,7 +852,7 @@ static void free_loop_env(struct scev *scev, int loop_header, int insn_idx)
 		envs->entries[i] = envs->entries[--envs->cnt];
 		break;
 	}
-	if (envs->cnt)
+	if (envs->cnt || envs->linked_cnt)
 		return;
 	kfree(envs);
 	scev->envs[insn_idx] = NULL;
@@ -833,7 +904,7 @@ static int forget_call_regs(struct bpf_verifier_env *env, struct env *e, int idx
 
 static u32 spill_spi(struct bpf_insn *insn)
 {
-	return -insn->off / BPF_REG_SIZE - 1;
+	return (-insn->off - 1) / BPF_REG_SIZE;
 }
 
 static u32 off_to_reg(struct bpf_insn *insn)
@@ -874,18 +945,40 @@ static int mk_spill(struct scev *scev, u8 size, int id)
 	return UNKNOWN_EXPR_ID;
 }
 
-static int mk_fill(struct scev *scev, int id, u8 code)
+/* The size of the spill in a slot with the expression @id. It holds the low bytes of *@x. */
+static u32 expr_spill_size(struct scev *scev, u32 id, u32 *x)
 {
-	bool sx = BPF_MODE(code) == BPF_MEMSX;
+	struct expr *e = &scev->exprs[id];
+	/* nothing looks through a phi, see struct expr_def */
+	bool partial = (e->op == SPILL8 || e->op == SPILL16 || e->op == SPILL32) && !e->def.phi;
+
+	*x = partial ? e->params[0] : id;
+	return partial ? op_low_bits(e->op) / BITS_PER_BYTE : BPF_REG_SIZE;
+}
+
+/* -ENOENT: the value of the fill is not known */
+static int mk_fill(struct scev *scev, int id, struct bpf_insn *insn)
+{
+	u32 x, spill_size = expr_spill_size(scev, id, &x);
+	u32 size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	bool sx = BPF_MODE(insn->code) == BPF_MEMSX;
 
+	/* The fill reads the low bytes of the spill, as in check_stack_read_fixed_off() */
+	if (size <= spill_size && bpf_stack_narrow_access_ok(insn->off, size, spill_size))
+		id = x;
+	else if (!is_spill_off(insn->off))
+		return -ENOENT;
 #ifdef __BIG_ENDIAN
+	/* No register becomes (spillN x): its low bits would not be those of x */
+	else if (spill_size < BPF_REG_SIZE)
+		return -ENOENT;
 	/* A narrow fill reads the high bits of the slot on big-endian. */
-	if (BPF_SIZE(code) != BPF_DW)
+	else
 		return expr2(scev, sx ? BPF_ARSH : BPF_RSH, id,
-			     imm_expr(scev, 64 - BITS_PER_BYTE * bpf_size_to_bytes(BPF_SIZE(code))));
+			     imm_expr(scev, BITS_PER_BYTE * (BPF_REG_SIZE - size)));
 #endif
 
-	switch (BPF_SIZE(code)) {
+	switch (BPF_SIZE(insn->code)) {
 	case BPF_B:  return expr1(scev, sx ? SEXT8  : ZEXT8,  id);
 	case BPF_H:  return expr1(scev, sx ? SEXT16 : ZEXT16, id);
 	case BPF_W:  return expr1(scev, sx ? SEXT32 : ZEXT32, id);
@@ -907,10 +1000,21 @@ static int maybe_store_fp(struct scev *scev, struct env *e, struct bpf_insn *ins
 
 static int maybe_load_fp(struct scev *scev, struct env *e, struct bpf_insn *insn, int idx)
 {
-	if (insn->src_reg != BPF_REG_FP || !is_spill_off(insn->off))
+	int id = -ENOENT;
+
+	if (insn->src_reg == BPF_REG_FP && insn->off < 0 && insn->off >= -MAX_BPF_STACK_JIT)
+		id = e->reg2expr[off_to_reg(insn)];
+	/*
+	 * The def of a slot that a slice may alias is no value number, see expr_is_vn(): two fills
+	 * can read distinct values. One fill reads one value: the insn defines the register.
+	 */
+	if (id >= 0 && scev->exprs[id].def.set && !scev->exprs[id].is_vn)
+		id = -ENOENT;
+	if (id >= 0)
+		id = mk_fill(scev, id, insn);
+	if (id == -ENOENT)
 		return forget_reg(scev, e, insn->dst_reg, OPAQUE_EXPR_ID, idx);
-	return replace_reg(scev, e, insn->dst_reg,
-			   mk_fill(scev, e->reg2expr[off_to_reg(insn)], insn->code));
+	return replace_reg(scev, e, insn->dst_reg, id);
 }
 
 /*
@@ -945,10 +1049,28 @@ static void alu32_operands(struct scev *scev, u32 op, int *a, int *b)
 	}
 }
 
+/*
+ * In a prog with an arena an ALU64 insn is converted to ALU32 at fixup if an operand is a pointer
+ * to the arena, see adjust_reg_min_max_vals(). Types are not known here. So @id, what the insn at
+ * @idx computes from @a, gets a def: the value of @dst after the insn, converted or not. See
+ * split_const_offset() for when the op can be trusted. Constant operands are scalars in every
+ * state.
+ */
+static int alu64_with_def(struct scev *scev, int id, int a, int idx, u32 dst)
+{
+	s64 imm;
+
+	if (id < 0 || is_imm(scev, id, &imm))
+		return id;
+	/* (+ x 0) is x only if the insn stays ALU64 */
+	return expr_with_def(scev, id == a ? UNKNOWN_EXPR_ID : id, insn_def(idx, dst));
+}
+
 static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 {
 	const bool little_endian = htons(0x3412) == 0x1234;
 	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	bool arena = env->prog->aux->arena;
 	struct scev *scev = env->scev;
 	u32 *reg2expr = e->reg2expr;
 	u8 class = BPF_CLASS(insn->code);
@@ -957,7 +1079,7 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 	u8 mode = BPF_MODE(insn->code);
 	u32 dst = insn->dst_reg;
 	u32 src = insn->src_reg;
-	u32 op, sext, l, r;
+	u32 op, sext;
 	bool need_bswap;
 	int i, id, a;
 	s64 imm;
@@ -1023,13 +1145,6 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 			else
 				goto mark_dst_unknown;
 
-			/* 'r1 <<= 32; r1 >>= 32' is (u32)r1 for cpu v1 and v2 */
-			if (class == BPF_ALU64 && op == BPF_RSH && id >= 0 &&
-			    is_imm(scev, id, &imm) && imm == 32 &&
-			    is_binop(scev, BPF_LSH, reg2expr[dst], &l, &r) &&
-			    is_imm(scev, r, &imm) && imm == 32)
-				return replace_reg(scev, e, dst, expr1(scev, ZEXT32, l));
-
 			a = reg2expr[dst];
 			if (class == BPF_ALU)
 				alu32_operands(scev, op, &a, &id);
@@ -1037,6 +1152,8 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 
 			if (class == BPF_ALU)
 				id = expr1(scev, ZEXT32, id);
+			else if (arena)
+				id = alu64_with_def(scev, id, a, idx, dst);
 
 			return replace_reg(scev, e, dst, id);
 
@@ -1676,6 +1793,227 @@ static int join_added_edges(struct bpf_verifier_env *env, struct bpf_subprog_inf
 	return sub->bail_insn < 0 ? 0 : join_successor(env, -1, sub->bail_insn, old_env, cur_env);
 }
 
+/*
+ * @id == *@base + *@off (mod 2^*@bits): constant offsets, extensions and partial spills are
+ * stripped, see set_expr_base(). An add with a def holds modulo 2^32 whether its insn is converted
+ * to ALU32 or not, see alu64_with_def(). It holds modulo 2^64 once the main pass has set
+ * prevent_zext: it verified the insn without a pointer to the arena and rejects a state that brings
+ * one. The def dominates every use, and prevent_zext is only ever set: such an add is not checked
+ * again.
+ */
+static void split_const_offset(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off, u32 *bits)
+{
+	struct scev *scev = env->scev;
+	struct expr *add, *e = &scev->exprs[id];
+
+	*base = e->base;
+	*off = e->off;
+	*bits = e->bits;
+	while (e->arena_add) {
+		add = &scev->exprs[e->arena_add];
+		if (!env->insn_aux_data[add->def.idx].prevent_zext) {
+			*bits = min(*bits, 32);
+			break;
+		}
+		e->arena_add = scev->exprs[add->params[0]].arena_add;
+	}
+}
+
+static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u32 rb, s64 *delta);
+
+/*
+ * @id_a and @id_b are expressions of one env of the loop at @h, or of a subprog: @h is -1. Do they
+ * have a constant difference, @id_b == @id_a + *@delta (mod 2^*@bits)?
+ */
+static bool const_diff(struct bpf_verifier_env *env, int h, u32 id_a, u32 id_b, s64 *delta,
+		       u32 *bits)
+{
+	struct scev *scev = env->scev;
+	u32 base_a, base_b, bits_a, ra, rb;
+	s64 off_a, c;
+
+	split_const_offset(env, id_a, &base_a, &off_a, &bits_a);
+	split_const_offset(env, id_b, &base_b, delta, bits);
+	*delta = (u64)*delta - off_a;
+	*bits = min(*bits, bits_a);
+	/* copies are equal in all bits */
+	if (id_a == id_b && scev->exprs[id_a].is_vn) {
+		*bits = 64;
+		return true;
+	}
+	if (base_a == base_b)
+		return scev->exprs[base_a].is_vn;
+	if (h < 0 || !is_reg(scev, base_a, &ra) || !is_reg(scev, base_b, &rb) ||
+	    !const_diff_at_header(env, h, ra, rb, &c))
+		return false;
+	*delta = (u64)*delta + c;
+	return true;
+}
+
+/*
+ *	old = i = 0; do { i++; if (old > 1021) break; c = buf[old]; old = i; } while (c);
+ * Does @rb == @ra + *@delta hold at the header of the loop at @h in every iteration? It does if it
+ * holds at loop entry, by the env of the enclosing loop at @h, and every backedge preserves it: the
+ * backedge values have this constant difference, or both are the header phi plus one constant.
+ * Loops nest LOOP_STACK_SIZE deep at most, see bpf_flow_place_guards().
+ */
+static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u32 rb, s64 *delta)
+{
+	int outer_header = env->insn_aux_data[h].loop_header;
+	struct env *entry_env = find_loop_env(env->scev, outer_header, h);
+	struct env *header_env = find_header_env(env->scev, h);
+	u32 base_a, base_b, bits_a, bits;
+	s64 off_a, c;
+
+	if (!entry_env || !can_compute_loop_scev(env->insn_aux_data[h].loop) ||
+	    !const_diff(env, outer_header, entry_env->reg2expr[ra], entry_env->reg2expr[rb],
+			delta, &bits) || bits != 64)
+		return false;
+	if (const_diff(env, -1, header_env->reg2expr[ra], header_env->reg2expr[rb], &c, &bits))
+		return bits == 64 && c == *delta;
+	split_const_offset(env, header_env->reg2expr[ra], &base_a, &off_a, &bits_a);
+	split_const_offset(env, header_env->reg2expr[rb], &base_b, &c, &bits);
+	return base_a == REG_EXPR_ID(ra) && base_b == REG_EXPR_ID(rb) && off_a == c &&
+	       bits_a == 64 && bits == 64;
+}
+
+/* The first bytes of a stack slot are its high bits */
+static bool is_big_endian_slot(u32 reg)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && reg >= MAX_BPF_REG;
+}
+
+/*
+ * const_diff() for the SCEV register @reg, which has the expression @id_b. A fill from byte
+ * *@fill_off of a slot reads these bits. On big endian the low bytes of a spill are the last ones,
+ * and a narrow fill from the start of a slot is a right shift, see mk_fill().
+ */
+static bool const_diff_reg(struct bpf_verifier_env *env, int h, u32 id_a, u32 reg, u32 id_b,
+			   u32 *fill_off, s64 *delta, u32 *bits)
+{
+	struct scev *scev = env->scev;
+	struct expr *e;
+	u32 x;
+	s64 k;
+
+	*fill_off = 0;
+	if (const_diff(env, h, id_a, id_b, delta, bits)) {
+		if (is_big_endian_slot(reg))
+			*fill_off = expr_spill_size(scev, id_b, &x) - *bits / BITS_PER_BYTE;
+		return true;
+	}
+	if (!is_big_endian_slot(reg) || !scev->exprs[id_b].is_vn)
+		return false;
+	split_const_offset(env, id_a, &x, delta, bits);
+	e = &scev->exprs[x];
+	if ((e->op != BPF_RSH && e->op != BPF_ARSH) || e->def.set || e->params[0] != id_b ||
+	    !is_imm(scev, e->params[1], &k) || (k != 32 && k != 48 && k != 56))
+		return false;
+	*delta = -(u64)*delta;
+	*bits = min_t(u32, *bits, 64 - k);
+	*fill_off = (64 - k - *bits) / BITS_PER_BYTE;
+	return true;
+}
+
+/*
+ *	n = bpf_get_stack(..); m = n; if (n < 0) ..; use(m);
+ * The main pass refines the registers that the conditional jump at @idx tests. Find the live SCEV
+ * registers that are linked to one of them in @e, the env before the jump, and keep them with their
+ * expressions: what bpf_scev_next_linked_reg() needs of @e.
+ */
+static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u32 dst = e->reg2expr[insn->dst_reg], src = dst;
+	struct insn_envs *envs = env->scev->envs[idx];
+	struct scev *scev = env->scev;
+	u32 r, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
+	u32 first = scev->linked_cnt;
+	DECLARE_BITMAP(live, REGS_NUM) = {};
+	void *tmp;
+	s64 delta;
+
+	if (!bpf_insn_is_cond_jump(insn->code) || BPF_OP(insn->code) == BPF_JCOND)
+		return 0;
+	if (BPF_SRC(insn->code) == BPF_X)
+		src = e->reg2expr[insn->src_reg];
+	bitmap_copy(live, aux->live_stack_before, MAX_BPF_STACK_SLOTS);
+	bitmap_shift_left(live, live, MAX_BPF_REG, REGS_NUM);
+	live[0] |= aux->live_regs_before;
+	split_const_offset(env, dst, &base_dst, &delta, &bits);
+	split_const_offset(env, src, &base_src, &delta, &bits);
+	for_each_set_bit(r, live, REGS_NUM) {
+		id = e->reg2expr[r];
+		/* most are not linked */
+		split_const_offset(env, id, &base, &delta, &bits);
+		if (base != base_dst && base != base_src && (h < 0 || !is_op(scev, base, REG)) &&
+		    !is_big_endian_slot(r))
+			continue;
+		if (!const_diff_reg(env, h, dst, r, id, &fill_off, &delta, &bits) &&
+		    (src == dst || !const_diff_reg(env, h, src, r, id, &fill_off, &delta, &bits)))
+			continue;
+		if (scev->linked_cnt == scev->linked_cap) {
+			cap = max(scev->linked_cap * 2, 16);
+			tmp = kvrealloc(scev->linked, array_size(cap, sizeof(*scev->linked)),
+					GFP_KERNEL_ACCOUNT);
+			if (!tmp)
+				return -ENOMEM;
+			scev->linked = tmp;
+			scev->linked_cap = cap;
+		}
+		tested += r == insn->dst_reg || (src != dst && r == insn->src_reg);
+		scev->linked[scev->linked_cnt].reg = r;
+		scev->linked[scev->linked_cnt++].id = id;
+	}
+	/* nothing but the tested registers */
+	if (scev->linked_cnt - first == tested) {
+		scev->linked_cnt = first;
+		return 0;
+	}
+	if (!envs) {
+		envs = kzalloc(sizeof(*envs), GFP_KERNEL_ACCOUNT);
+		if (!envs)
+			return -ENOMEM;
+		scev->envs[idx] = envs;
+	}
+	envs->linked_first = first;
+	envs->linked_cnt = scev->linked_cnt - first;
+	return 0;
+}
+
+/*
+ * Find the next SCEV register that is linked to @regno at the conditional jump at @insn_idx: on
+ * every path to the jump *@linked_regno == @regno + *@delta (mod 2^*@bits). It is live there and of
+ * the same frame. It is a register, or MAX_BPF_REG + the index of a stack slot: a fill from byte
+ * *@fill_off of the slot reads these bits. *@pos is the position of the search, 0 at first. False:
+ * no more links are known. Types are not known here: the caller checks them in its state.
+ */
+bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
+			      u32 *linked_regno, u32 *fill_off, s64 *delta, u32 *bits)
+{
+	struct insn_envs *envs = env->scev->envs[insn_idx];
+	int h = bpf_loop_at_index(env, insn_idx);
+	struct scev_linked_reg *linked;
+	u32 i;
+
+	if (!envs || !envs->linked_cnt)
+		return false;
+	linked = &env->scev->linked[envs->linked_first];
+	/* registers come first */
+	for (i = 0; linked[i].reg != regno; i++)
+		if (i + 1 == envs->linked_cnt || linked[i].reg > regno)
+			return false;
+	for (; *pos < envs->linked_cnt; ++*pos) {
+		*linked_regno = linked[*pos].reg;
+		if (*pos != i &&
+		    const_diff_reg(env, h, linked[i].id, *linked_regno, linked[*pos].id, fill_off,
+				   delta, bits))
+			return true;
+	}
+	return false;
+}
+
 /*
  * @cur_header and @first are a loop header. Or -1 and the first insn of a subprog: the subprog is
  * the outermost loop, which runs once. (REG r) is the entry value of r, the loops in it are single
@@ -1801,6 +2139,12 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, i
 					collect_tested_regs(env, cur_env, idx,
 							    cur_loop->tested_regs);
 				}
+				/* the others wait for the envs of all loop headers */
+				if (!aux[idx].need_scev) {
+					err = find_linked_regs(env, cur_env, -1, idx);
+					if (err)
+						goto out;
+				}
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
@@ -1942,13 +2286,20 @@ static int simplify(struct scev *scev, u32 id)
 	if (is_add(scev, id, &l, &r) && is_imm(scev, r, &imm1) && !imm1)
 		return l;
 
-	/* (+ (+ x imm) imm) -> (+ x imm) */
+	/* (+ (+ x imm) imm) -> (+ x imm). Not through a def, see alu64_with_def() */
 	if (is_add(scev, id, &l, &r) &&
 	    is_imm(scev, r, &imm2) &&
 	    is_add(scev, l, &a, &b) &&
-	    is_imm(scev, b, &imm1))
+	    is_imm(scev, b, &imm1) && !scev->exprs[l].def.set)
 		return expr2(scev, BPF_ADD, a, imm_expr(scev, (s64)((u64)imm1 + (u64)imm2)));
 
+	/* 'r1 <<= 32; r1 >>= 32' is (u32)r1 for cpu v1 and v2: (>> (<< x 32) 32) -> (zext32 x) */
+	if (is_binop(scev, BPF_RSH, id, &l, &r) &&
+	    is_imm(scev, r, &imm2) && imm2 == 32 &&
+	    is_binop(scev, BPF_LSH, l, &a, &b) &&
+	    is_imm(scev, b, &imm1) && imm1 == 32 && !scev->exprs[l].def.set)
+		return expr1(scev, ZEXT32, a);
+
 	/* (+ (linear base slope) imm) -> (linear (+ base imm) slope) */
 	if (is_add(scev, id, &l, &r) &&
 	    is_linear(scev, l, &base, &slope) &&
@@ -1965,12 +2316,18 @@ static int simplify(struct scev *scev, u32 id)
 	if (is_zext32(scev, id, &l) && is_imm(scev, l, &imm1))
 		return imm_expr(scev, (u64)(u32)imm1);
 
+	/* The rules below look through the operand, not through a phi: see struct expr_def */
+	if (op_low_bits(op) && scev->exprs[scev->exprs[id].params[0]].def.phi)
+		return id;
+
 	/*
 	 * (zext32 (+ (zext32 $a) $b)) -> (zext32 (+ $a $b))
 	 * (zext32 (+ $a (zext32 $b))) -> (zext32 (+ $a $b))
 	 */
-	if ((is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a)) ||
-	    (is_zext32(scev, id, &t) && is_add(scev, t, &a, &r) && is_zext32(scev, r, &b))) {
+	if ((is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a) &&
+	     !scev->exprs[l].def.phi) ||
+	    (is_zext32(scev, id, &t) && is_add(scev, t, &a, &r) && is_zext32(scev, r, &b) &&
+	     !scev->exprs[r].def.phi)) {
 		t = expr2(scev, BPF_ADD, a, b);
 		t = expr1(scev, ZEXT32, t);
 		return t;
@@ -1987,7 +2344,8 @@ static int simplify(struct scev *scev, u32 id)
 	 */
 	if (is_spill32(scev, id, &t) && is_zext32(scev, t, &a))
 		return expr1(scev, SPILL32, a);
-	if (is_spill32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a))
+	if (is_spill32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a) &&
+	    !scev->exprs[l].def.phi)
 		return expr1(scev, SPILL32, expr2(scev, BPF_ADD, a, b));
 
 	/*
@@ -1999,12 +2357,24 @@ static int simplify(struct scev *scev, u32 id)
 	if (op_low_bits(op) && is_spill(scev, scev->exprs[id].params[0], &bits, &a) &&
 	    op_low_bits(op) <= bits)
 		return expr1(scev, op, a);
-	if (is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_spill32(scev, l, &a))
+	if (is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_spill32(scev, l, &a) &&
+	    !scev->exprs[l].def.phi)
 		return expr1(scev, ZEXT32, expr2(scev, BPF_ADD, a, b));
 
 	return id;
 }
 
+static int instantiate_header_scevs(struct scev *scev, u32 id, void *priv)
+{
+	u32 reg, *reg2scev = priv;
+
+	/* (reg r) -> ... equation at header ... */
+	if (is_reg(scev, id, &reg))
+		return reg2scev[reg];
+	/* keep expression shapes */
+	return id;
+}
+
 static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header_env)
 {
 	struct scev *scev = env->scev;
@@ -2028,6 +2398,12 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	 */
 	for (ra = 0; ra < REGS_NUM; ra++) {
 		ra_expr = header_env->reg2expr[ra];
+		/* Constructed again it has no defs, see alu64_with_def(): they hide the shape */
+		if (env->prog->aux->arena)
+			ra_expr = transform_expr_once(scev, 0, ra_expr, scev->identity_env.reg2expr,
+						      instantiate_header_scevs);
+		if (ra_expr < 0)
+			return ra_expr;
 		/* rA = (+ rA IMM) -> (linear rA IMM) */
 		if (is_add(scev, ra_expr, &l, &r) &&
 		    is_reg(scev, l, &rb) &&
@@ -2158,17 +2534,6 @@ static void scev_compute_linear_regs(struct scev *scev, struct bpf_loop *loop,
 	}
 }
 
-static int instantiate_header_scevs(struct scev *scev, u32 id, void *priv)
-{
-	u32 reg, *reg2scev = priv;
-
-	/* (reg r) -> ... equation at header ... */
-	if (is_reg(scev, id, &reg))
-		return reg2scev[reg];
-	/* keep expression shapes */
-	return id;
-}
-
 static int compute_insn_scevs(struct bpf_verifier_env *env, struct env *eheader, struct env *einsn)
 {
 	struct scev *scev = env->scev;
@@ -2218,6 +2583,27 @@ static int log_scevs(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * A slice comes from a call that may write to the buffer: the kfunc, or a subprog that calls it.
+ * See expr_is_vn().
+ */
+static void find_slice_slots(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	struct scev *scev = env->scev;
+	bool slices = false;
+	u32 i, spi;
+
+	for (i = 0; i < env->prog->len; i++)
+		slices |= bpf_is_dynptr_slice_rdwr_kfunc(&insn[i]);
+	for (i = 0; slices && i < env->prog->len; i++)
+		if (BPF_CLASS(insn[i].code) == BPF_JMP && BPF_OP(insn[i].code) == BPF_CALL)
+			bitmap_or(scev->slice_slots, scev->slice_slots, bpf_may_write_mask(env, i),
+				  MAX_BPF_STACK_SLOTS);
+	for_each_set_bit(spi, scev->slice_slots, MAX_BPF_STACK_SLOTS)
+		scev->exprs[REG_EXPR_ID(MAX_BPF_REG + spi)].is_vn = false;
+}
+
 int bpf_compute_scev(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
@@ -2226,6 +2612,7 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 	int cnt = env->cfg.cur_postorder;
 	int i, idx, err, header;
 
+	find_slice_slots(env);
 	mark_latches(env);
 	/*
 	 * Visit loop headers in postorder, to guarantee that scevs
@@ -2254,6 +2641,9 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		idx = postorder[i];
 		if (!aux[idx].need_scev)
 			continue;
+		if (signal_pending(current))
+			return -EAGAIN;
+		cond_resched();
 		header = bpf_loop_at_index(env, idx);
 		err = aux[idx].loop
 		      ? compute_header_scevs(env, find_header_env(scev, header))
@@ -2265,6 +2655,10 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		if (aux[idx].loop)
 			scev_compute_linear_regs(scev, aux[idx].loop,
 						 find_header_env(scev, header));
+		err = find_linked_regs(env, aux[idx].loop ? &scev->identity_env :
+				       find_loop_env(scev, header, idx), header, idx);
+		if (err)
+			return err;
 	}
 
 	/* Now it's known which jumps test a counter: the places of a back edge are for them */
@@ -2281,6 +2675,21 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * Are all slots of the buffer [off, off + size) in slice_slots? Without @fixed_off the buffer is
+ * somewhere in the range, and the range can be wider than slice_slots: two offsets become a range
+ * at a join point.
+ */
+bool bpf_scev_in_slice_slots(struct bpf_verifier_env *env, int off, u32 size, bool fixed_off)
+{
+	int first = bpf_get_spi(off + size - 1), last = bpf_get_spi(off);
+	const unsigned long *slots = env->scev->slice_slots;
+
+	if (fixed_off)
+		return find_next_zero_bit(slots, last + 1, first) > last;
+	return find_next_bit(slots, last + 1, first) <= last;
+}
+
 void bpf_free_scev(struct bpf_verifier_env *env)
 {
 	struct scev *scev = env->scev;
@@ -2303,6 +2712,7 @@ void bpf_free_scev(struct bpf_verifier_env *env)
 	kvfree(scev->worklist.data);
 	kvfree(scev->envs);
 	kvfree(scev->exprs);
+	kvfree(scev->linked);
 	kvfree(scev->discovered);
 	kfree(scev);
 	env->scev = NULL;
@@ -2319,6 +2729,7 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	env->scev = scev;
 	bpf_mark_reg_known_scalar(&scev->zero_reg, 0);
 	bpf_mark_reg_unknown(&scev->unknown_reg);
+	setup_initial_loop_env(&scev->identity_env);
 	if (grow_exprs(scev, roundup_pow_of_two(REG_EXPR_ID(REGS_NUM))))
 		goto nomem;
 	scev->exprs[UNKNOWN_EXPR_ID] = (struct expr){ .op = UNKNOWN };
@@ -2326,6 +2737,8 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	for (r = 0; r < REGS_NUM; r++)
 		scev->exprs[REG_EXPR_ID(r)] = (struct expr){ .op = REG, .is_vn = true,
 							     .params = { r, 0 } };
+	for (r = 0; r < REG_EXPR_ID(REGS_NUM); r++)
+		set_expr_base(scev, &scev->exprs[r], r);
 	scev->exprs_cnt = REG_EXPR_ID(REGS_NUM);
 	scev->envs = kvcalloc(env->prog->len, sizeof(*scev->envs), GFP_KERNEL_ACCOUNT);
 	scev->discovered = kvcalloc(env->prog->len, sizeof(*scev->discovered), GFP_KERNEL_ACCOUNT);
@@ -2394,6 +2807,10 @@ static struct bpf_reg_state *scev_reg_for_spill32(struct bpf_func_state *st, u32
 {
 	struct bpf_stack_state *stack = scev_regno_to_stack(st, r);
 
+#ifdef __BIG_ENDIAN
+	/* a 32-bit spill is in the upper 32 bits of the slot */
+	return NULL;
+#endif
 	if (!stack || bpf_spill_size(stack) != 4 || stack->spilled_ptr.type != SCALAR_VALUE)
 		return NULL;
 	return &stack->spilled_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc0937b98818..138581a759bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15194,6 +15194,12 @@ bool bpf_is_throw_kfunc(struct bpf_insn *insn)
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
+bool bpf_is_dynptr_slice_rdwr_kfunc(struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
+	       insn->imm == special_kfunc_list[KF_bpf_dynptr_slice_rdwr];
+}
+
 static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback];
@@ -16018,6 +16024,15 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		regs[BPF_REG_0].buf = meta->slice_buf;
 		if (meta->slice_buf.size)
 			env->seen_stack_slice = true;
+		/* No insn stores through a slice of 0 bytes */
+		if (verifier_bug_if(meta->slice_buf.size && meta->arg_constant.value &&
+				    !type_is_rdonly_mem(regs[BPF_REG_0].type) &&
+				    !bpf_scev_in_slice_slots(env, meta->slice_buf.off,
+							     meta->slice_buf.size,
+							     meta->slice_buf.size ==
+							     meta->arg_constant.value),
+				    env, "slice buffer is not in scev slice_slots"))
+			return -EFAULT;
 	} else {
 		return 0;
 	}
@@ -19694,6 +19709,101 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 	}
 }
 
+/* a == b (mod 2^N) implies a == b if both fit in uN or both fit in sN. N is @bits. */
+static bool regs_fit_in_bits(const struct bpf_reg_state *a, const struct bpf_reg_state *b,
+			     u32 bits)
+{
+	u64 umax = GENMASK_ULL(bits - 1, 0);
+	s64 smax = umax >> 1;
+
+	return (reg_umax(a) <= umax && reg_umax(b) <= umax) ||
+	       (reg_smin(a) >= -smax - 1 && reg_smax(a) <= smax &&
+		reg_smin(b) >= -smax - 1 && reg_smax(b) <= smax);
+}
+
+/*
+ * The state of the SCEV register @r. As in check_stack_read_fixed_off() a fill of @bits bits from
+ * byte @fill_off of the slot reads the low bits of the spill.
+ */
+static struct bpf_reg_state *scev_reg_for_fill(struct bpf_func_state *frame, u32 r, u32 fill_off,
+					       u32 bits)
+{
+	struct bpf_stack_state *ss;
+
+	if (r < MAX_BPF_REG)
+		return &frame->regs[r];
+	if (r - MAX_BPF_REG >= bpf_stack_nr_slots(frame))
+		return NULL;
+	ss = bpf_stack_slot(frame, r - MAX_BPF_REG);
+	if (!bpf_is_spilled_reg(ss) || bpf_spill_size(ss) * BITS_PER_BYTE < bits ||
+	    !bpf_stack_narrow_access_ok(fill_off, bits / BITS_PER_BYTE, bpf_spill_size(ss)))
+		return NULL;
+	return &ss->spilled_ptr;
+}
+
+/*
+ * The jump at @idx refined @regno. A register that scalar evolution links to it holds
+ * @regno + delta on every path to the jump: intersect the two. The intersection is empty: no
+ * execution gets here with this state (the path is infeasible), the register is left as it is.
+ */
+static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
+			       int idx, u32 regno)
+{
+	struct bpf_func_state *frame = vstate->frame[vstate->curframe];
+	struct bpf_reg_state *reg, implied, saved;
+	u32 pos, linked_regno, fill_off, bits;
+	s64 delta;
+
+	if (frame->regs[regno].type != SCALAR_VALUE)
+		return;
+	for (pos = 0;
+	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &delta,
+				      &bits);
+	     pos++) {
+		reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
+		/*
+		 * The other half-slot of a 64-bit spill is dead: __clean_func_state() left
+		 * a 32-bit spill, the low 32 bits of the value.
+		 */
+		if (!reg && bits == 64 &&
+		    bpf_stack_narrow_access_ok(fill_off, BPF_REG_SIZE / 2, BPF_REG_SIZE)) {
+			bits = 32;
+			reg = scev_reg_for_fill(frame, linked_regno, fill_off, bits);
+		}
+		if (!reg || reg->type != SCALAR_VALUE)
+			continue;
+
+		implied = frame->regs[regno];
+		add_scalar_to_reg(&implied, delta);
+		if (regs_fit_in_bits(reg, &implied, bits))
+			bits = 64;
+		if (bits < 32)
+			continue;
+		/* tnum_intersect() of two tnums that don't overlap is not empty */
+		if (!tnum_overlap(bits == 32 ? tnum_subreg(reg->var_off) : reg->var_off,
+				  bits == 32 ? tnum_subreg(implied.var_off) : implied.var_off))
+			continue;
+		saved = *reg;
+		/*
+		 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a zero
+		 * extended int refines nothing but the 32-bit range.
+		 */
+		regs_refine_cond_op(reg, &implied, BPF_JEQ, true);
+		if (bits == 64)
+			regs_refine_cond_op(reg, &implied, BPF_JEQ, false);
+		reg_bounds_sync(reg);
+		if (reg_is_empty(reg) || const_tnum_range_mismatch(reg) ||
+		    const_tnum_range_mismatch_32(reg)) {
+			*reg = saved;
+			continue;
+		}
+		if (linked_regno < MAX_BPF_REG)
+			mark_reg_scratched(env, linked_regno);
+		else
+			mark_stack_slot_scratched(env, linked_regno - MAX_BPF_REG);
+	}
+}
+
 /* It's known which way the jump at env->insn_idx goes */
 static void mark_loop_exit_decided(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
@@ -19866,6 +19976,14 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		sync_linked_regs(env, other_branch, &other_branch_regs[insn->dst_reg],
 				 &linked_regs);
 	}
+	if (env->bpf_capable) {
+		if (BPF_SRC(insn->code) == BPF_X) {
+			refine_linked_regs(env, this_branch, *insn_idx, insn->src_reg);
+			refine_linked_regs(env, other_branch, *insn_idx, insn->src_reg);
+		}
+		refine_linked_regs(env, this_branch, *insn_idx, insn->dst_reg);
+		refine_linked_regs(env, other_branch, *insn_idx, insn->dst_reg);
+	}
 
 	/* if one pointer register is compared to another pointer
 	 * register check if PTR_MAYBE_NULL could be lifted.
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index cadb13f023d2..bebb607000a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -597,6 +597,34 @@ __naked void mixed_arena_scalar_alu64_arena_first(void)
 	: __clobber_all);
 }
 
+/* The offset of a pointer to arena is not tracked */
+#define ARENA_TEST(name, op, expect)						\
+SEC("syscall")									\
+__log_level(2)									\
+expect										\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r1 = %[arena] ll;"							\
+	"r6 = 0;"								\
+	"r6 = addr_space_cast(r6, 0, 1);"					\
+	"r7 = 0;"								\
+"1:	*(u64 *)(r6 + 0) = r7;"							\
+	op									\
+	"r7 += 1;"								\
+	"if r7 < 100 goto 1b;"							\
+	"r0 = 0;"								\
+	"exit;"									\
+	:: __imm_addr(arena) : __clobber_all);					\
+}
+
+#define NOT_UNROLLED100	__msg("loop header at 5, widening r7 to 0..99 step 1")
+/* A loop that moves the pointer is not unrolled */
+ARENA_TEST(arena_pointer_moves, "r6 += 8;", __success NOT_UNROLLED100)
+/* The loop makes a number of it: the state that returns to the loop header tells */
+ARENA_TEST(arena_pointer_becomes_a_number, "if r7 != 5 goto +1; r6 = 4096;",
+	   __failure NOT_UNROLLED100 __msg("R6 invalid mem access 'scalar'"))
+
 SEC("syscall")
 __description("arena: a number is not an address in arena")
 __failure __msg("R6 invalid mem access 'scalar'")
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 316e9377caa8..94d52154b0c6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1572,7 +1572,7 @@ l0_%=:	r0 = 0;				\
 SEC("socket")
 __description("bounds deduction cross sign boundary, negative overlap")
 __success __log_level(2)
-__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,umin32=0xfffffd71,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=smin32=-527,smax=smax32=-146,umin=0xfffffffffffffdf1,umax=0xffffffffffffff6e,umin32=0xfffffdf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
 __retval(0)
 __naked void bounds_deduct_negative_overlap(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index caae67feaf5b..42b9e46a88af 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -190,10 +190,9 @@ l0_%=:							\
 	: __clobber_all);
 }
 
-/* Double ADD clears the ID (can't accumulate offsets) */
+/* Double ADD clears the ID. That r1 = r0 + 4 is known all the same: r0 /= 0 is dead code */
 SEC("socket")
-__failure
-__msg("div by zero")
+__success
 __naked void scalars_double_add(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30fb0e..91daa5b323c9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -31,17 +31,16 @@ l1_%=:	exit;						\
 }
 
 SEC("socket")
-__description("check w reg not equal if r reg upper32 bits not 0")
-__failure __msg("R1 !read_ok")
+__description("check w reg equal if r reg upper32 bits not 0")
+__success
 __naked void subreg_equality_2(void)
 {
 	asm volatile ("					\
 	call %[bpf_ktime_get_ns];			\
 	r2 = r0;					\
-	/* Upper 4-bytes of r2 may not be 0, thus insn	\
-	 * w3 = w2 should not propagate reg id,	and	\
-	 * w2 < 9 comparison should not propagate	\
-	 * the range for r3 either.			\
+	/* Upper 4-bytes of r2 may not be 0. r3 is the	\
+	 * lower 4-bytes of r2, which is what w2 < 9	\
+	 * compares.					\
 	 */						\
 	w3 = w2;					\
 	if w2 < 9 goto l0_%=;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 9ea61b162736..819d0a1a6886 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -288,9 +288,9 @@ __success __log_level(2)
 /*
  * check that r5 is unlinked after 'if', collect_linked_regs() can't tie
  * more than 5 registers for a single insn and the register compared by
- * the jump is not exempt from that.
+ * the jump is not exempt from that. The jump refines the copies all the same.
  */
-__msg("7: (25) if r5 > 0x7 goto pc+0         ; R5=scalar(smin=")
+__msg("7: (25) if r5 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7) " R3=" LINKED("1", 7, 0x7) " R4=" LINKED("1", 7, 0x7) " R5=scalar(smin=")
 __msg("12: (bf) r5 = r5                      ; R5=scalar(id=2")
 __naked void linked_regs_too_many_regs(void)
 {
@@ -808,7 +808,7 @@ __naked void linked_regs_and_subreg_def(void)
  * at runtime), which must be rejected.
  */
 SEC("socket")
-__failure __msg("R0 max value is outside of the allowed memory range")
+__failure __msg("invalid access to map value, value_size=8 off=8 size=1")
 __naked void ldsx_fill_scalar_id_not_shared(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 6d1b8542f801..b961a12b5224 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3338,42 +3338,6 @@ NOT_LINEAR_TEST(lsh_grows, "r7 &= 15;", "r7 <<= 1;", UNROLLED("(<< r7 1)"))
 NOT_LINEAR_TEST(same_constant, "r7 = 17;", "r7 &= 31;", NOT_CHANGED)
 NOT_LINEAR_TEST(same_wide_constant, "r7 = 0xffffffff00000011 ll;", "r7 &= -239;", NOT_CHANGED)
 
-#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
-struct {
-	__uint(type, BPF_MAP_TYPE_ARENA);
-	__uint(map_flags, BPF_F_MMAPABLE);
-	__uint(max_entries, 1);
-} arena SEC(".maps");
-
-/* The offset of a pointer to arena is not tracked */
-#define ARENA_TEST(name, op, expect)						\
-SEC("syscall")									\
-__log_level(2)									\
-expect										\
-__naked void name(void)								\
-{										\
-	asm volatile (								\
-	"r1 = %[arena] ll;"							\
-	"r6 = 0;"								\
-	"r6 = addr_space_cast(r6, 0, 1);"					\
-	"r7 = 0;"								\
-"1:	*(u64 *)(r6 + 0) = r7;"							\
-	op									\
-	"r7 += 1;"								\
-	"if r7 < 100 goto 1b;"							\
-	"r0 = 0;"								\
-	"exit;"									\
-	:: __imm_addr(arena) : __clobber_all);					\
-}
-
-#define NOT_UNROLLED100	__msg("loop header at 5, widening r7 to 0..99 step 1")
-/* A loop that moves the pointer is not unrolled */
-ARENA_TEST(arena_pointer_moves, "r6 += 8;", __success NOT_UNROLLED100)
-/* The loop makes a number of it: the state that returns to the loop header tells */
-ARENA_TEST(arena_pointer_becomes_a_number, "if r7 != 5 goto +1; r6 = 4096;",
-	   __failure NOT_UNROLLED100 __msg("R6 invalid mem access 'scalar'"))
-#endif
-
 /*
  * r7 = ctx->data;
  * r8 = r7
-- 
2.55.0

