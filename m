Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415693;
	b=i0sBhlyOwK5zTSwsqvkGCZS4VZl1/pditxFiXvJAPOhg6zmG23YPe5AHc6piq40sHv8q
	 Qkbv/r9ymr1olBPut+mbEg8lAnfRKbliA8ep4oe3IrgbqHvFjm6x5Bflle57X0up8gxJp
	 Kv7Qh9DWOSnDB5nlUviE2+EIP76VMrGPX2I/1Jj6w5p2r1MQbcxv/EuDGOCJan7lmaLoP
	 +k88GorBkDU/4I9WZ7cGKXeM1vPlVnTzNuOj4aKSxW4yl3KLkFqSzCal8nTlYL9jiUkLx
	 rGqK+zKHiPOvooFsl8RoqArd/xKnpZrUBxhJHgF/FqcBWGH41kAPp9hWbaNrp2Ka5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nEUBcccxHQhPrFPp1KvGV3zYMqhmWyrqP+JsNp+WU5A=;
	b=kXtUe0+Eho+9yyLV/39c6Sn/1CoAQC2rrotlLUCSpFOVe920SM8zRetLpitaW5oxzcsm
	 iiJPwTS9sUbRz3PwyWijGxpMuKfzCvIDSVMZ8xdOHX5j1LDv2ojRb9/UZAa3zXJqN6mRW
	 2bWKd3x5TV7NgJiqy44PKCkG/8MbkqjUDP5F8/iX0Ia4x2dBrRcSNdVxh7kb8nioojROQ
	 DWGdYnd+JxArwFjiFo01aRKg/l4JWBDU9bcjqJG5BnnVQXerWJ5yEOt5L+/vo0WdfbHO1
	 PBm8nk2J5hRmrbDbywyw6cBqcl7LRvA4ht1WRR8tHV7FxiDU/IXiQaWSxibB03NZfZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=009ghSil;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB7606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98FB7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=009ghSil
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed06b725fdso230775ad.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415692; x=1795020492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEUBcccxHQhPrFPp1KvGV3zYMqhmWyrqP+JsNp+WU5A=;
        b=009ghSilcdW2F4rd8OWXZ3mQrM8y7OShPUEXUbJhui+UJ/w+gcIlD/NS6Z4W+seo8w
         aM5hDpl4TJOuSf29TJB4AVkxl6UaDKrf25oAlZ8wP9tgBvruIeh8bfHLBkADpJQBkH+1
         cUXGOu4elk1WfIU13u2L5yo9Y2lhyHH4ETfH+AqGFAGxcCujsT9/xGdCqQjtNF7UddD2
         0HqXUlUnW6nSXtJIEQB6mwhzQzQRWABB4T2s793eejtsE6nqZFNkVXHaXOd95gPqQLR2
         jP7QtFukiL0GlmQ3cfwFHwOTls05TrZT7k/nSFIoTgofGWSURXdgG5RdX08g3ermFL8w
         sqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415692; x=1795020492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEUBcccxHQhPrFPp1KvGV3zYMqhmWyrqP+JsNp+WU5A=;
        b=Nvj39umXeBHMPtYtqXU6SVkY5VCopXYdmOTDyEO7mZzSf897x3GbVvDOI4u0OsxIM2
         usUG6kDkpqYN6F01scApz3mlYtJcIVTmFz8MepnvvjOnUR1h8tYemIrH3u2iP6ISUv4i
         Br+HgZGVJHdI1bGvPUjPHSR0ICYhx0A91sULSRPGURioeYa1aUYYSUEpQj5ClzL00IOi
         GFoQfCG9W/7yjimHYZm7NOuldHsni/uzipHbUktsreEVgBBbUCacQli0+AzkZ5EzKdC5
         lTjf177SdV3mwC4QSHpUb6WLudRzAVT4mpmfs9xASDh/W9uLv7wl6iidPYD4n68EpA5i
         32vA==
X-Gm-Message-State: APuU4Z9SkEbTRfOrAOfVq7DQmHqWwH2iCIOTqz2aNaP4uac8xQqYhaff
	fQ2nPXeC4eNQzxwfPl4j1zDkhF0l/pRVQcBMwRchbOP7a4e2c39rz8PSrunsqA==
X-Gm-Gg: AYBFou2mqbXew9MwBQjgvOyO6AlqZqdLeAK2Jkt/8eJFgBkPkvIwdPSZ7SXMaur4LjF
	8Qws8ihVXdsVrNoQi+ZODhDFyQA3Q7DJQeUCEF8qZmk6KYxugll58cMO1enDkhcIbxP9pfRUAI2
	qW4gnFLRLwtg6yOVRGhEC6RMd/ORdbh7CnRTk83/VnwM0SziADEqjOG9XsWDUcDzi4yCaTel+6O
	ZsEux24fgH1fkqQtcjtwSvH9OdhnAdiAql7olbXpE2Ec0qa0QoyjG/xKOtMR7pcFyCU/DQtAgnJ
	CnS5AeN5wMa7Vuf0nsGVU+Jm2r4lMB8oZpx6DhG0cKHZBkb4u0VbFPXngcIhbeJzFNjdvsySlPA
	Xf7WJlB1jZZSW3k/JH17F6ZoP9QyBXZem/1YG/Y5hF/G+KEaNgYe8kaMEdpajkE6G99i8MRh7XX
	eUam985lMh1s1S9gn1NzJRTwF48GwTdsml2I9jYwwh1yTL1rimoiH9GFFy5uZt3GjDBz6+cKz9A
	J6TXeWdD4obISQPQdLJzb0bIe/OIA0itCeGXplWfLJdFWaN+ob9HrWvWujTIGIgukSRu4yMeKp5
	L7DDKQEs8AtOuGukIDTNczmoIMhsfZVmHFHMsMpea9F3YSZc4yJqOF4WxBKlko/+DF4CE7xCXup
	/VAgwZO1sdSoy12BED2B/i9+arCRIzQ4W0ul+MQJ/3YsH5dLjcPRIWUQ0mgqM8rcSIM9X1ve8eQ
	==
X-Received: by 2002:a17:903:fad:b0:2ed:238b:7db1 with SMTP id d9443c01a7336-2edf1670386mr298115ad.13.1794415691731;
        Wed, 11 Nov 2026 08:48:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a43768sm22673815ad.6.2026.11.11.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 22/29] bpf: Remove sync_linked_regs(), refine by scalar evolution only
Date: Wed, 11 Nov 2026 16:45:45 +0000
Message-ID: <20261111164557.2659679-23-alexei.starovoitov@gmail.com>
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

A removal: sync_linked_regs(), the code that scalar ids exist for, goes.
The ids themselves go in later patches. Precision is lost where only
a state knows that two scalars are linked: on one of several paths, after
a loop, across frames. One selftest has to change.

After a conditional jump sync_linked_regs() copies the range of the tested
register, plus delta, to all scalars with its id. refine_linked_regs()
does that job without ids. It refines the linked registers of the jump:
the live registers and stack slots that are a tested register + a constant
on every path to the jump. Scalar evolution computes them before the main
pass. Both run at a jump with two live branches, sync_linked_regs() first.
Remove it, collect_linked_regs() and struct linked_regs. Scalar ids are
still assigned, no jump reads them.

Precision that is lost:
 - A path that is dead in the main pass only:

	long n = bpf_probe_read_kernel_str(dst, 16, src);
	if (n < 0 || n > 16) return 0;
	return n;

   clang: 'r1 = 0; if r0 s> 16 goto l; r1 = r0; l: if r0 s< 0 goto ..'. At
   the second jump r1 is phi(0, r0), which is not linked to r0. The helper
   returns at most 16: the only state that got to l had one id in r0, r1.
 - 'r1 = r0' on one of two paths to a jump in general. The id worked until
   the state of that path was joined with the other one. The first
   iteration of a loop is such a path. So is the conditional move that
   clang makes for the off that 'send' needs. It tests 'n < 0' twice:

	if (n < 0) goto send;
	off += n;
	if (off > MAX) goto send;
	buf[off] = x;
	send: emit(off);

 - A link that a loop leaves. For the code after it a nested loop defines
   every register that it changes, each with a name of its own:

	do { len += next(); e.len = len; } while (more());
	if (len > 100) return 0;
	use(buf[e.len]);

 - What only the state knows about an operand. 'w3 = w0' is a copy if r0
   fits in 32 bits. With 'size_t off' and 'u32 sz' clang 18 emits it for
   'off += (u32)n; sz = off <= MAX ? HDR + off : HDR;'. For scev.c off is
   (+ (zext32 n) x) and sz is (zext32 (+ (+ n x) HDR)): no common base.
   'r5 = r3; r5 += r2' is r3 + a constant if r2 is one, as in a loop that
   the verifier unrolls: for 'for (i = n - 1; i >= 0; i--)' clang tests
   n + 1 + k with k = -1, -2, .. in r2. The jump refined n, and the range
   of n ended the loop. A write at a variable offset into the stack defines
   all slots of its bpf_may_write_mask().
 - Linked registers belong to the frame of the jump. Scalar ids also linked
   the registers and stack slots of the callers. A slot that a subprog
   loads or stores through a pointer and tests is still refined, see
   scev_mem_to_slot(), if the pointer is live at the jump. It is dead in
   'c->n = x; if (x >= 16) return -1; return 0;' and in
   'if (w->c->n > 63) return 0;'. A subprog that is only called through
   a function pointer has no memory locations: its slots of the caller are
   not refined. A copy of c.n that the caller keeps in a register during
   'if (!valid(&c)) return 0;' is not refined. Nor is n after
   'r = rd(e, &n); if (r < 0 || r > 63) return 0;' if rd() returns what it
   stores to *n.
 - That two arguments hold the same value is known at the callsite, not in
   the subprog. The selftest "regalloc in callee" passes the same value in
   r1 and r2 and is rejected now. Its 'r2 = r0' before the call becomes
   'r2 = r1' in the callee.
 - refine_linked_regs() runs for loaders with CAP_BPF, sync_linked_regs()
   ran for everybody.
No other prog of the selftests, Cilium, sched_ext, katran, bpfjailer and
of the programs in Rust changes its verdict.

Precision that is gained: sync_linked_regs() overwrites ranges,
refine_linked_regs() intersects them. With n in [0, 19] and 'u64 ent[16]'
clang emits for 'n = n > 4 ? n - 4 : 0; e->ent[n] = 1;':

  10: w2 = w6
  11: w2 += -4
  14: if w2 > w6 goto pc+1

If the jump is not taken w2 did not wrap: it is at most 19. r2 and r6 have
the same id, so sync_linked_regs() overwrites r2 with r6 - 4 modulo 2^32,
which can be 0xfffffffc: "R0 unbounded memory access". With
refine_linked_regs() alone r2 is in [0, 15] and the prog loads.

The selftest linked_regs_too_many_regs sees all six registers refined.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 161 ------------------
 .../bpf/progs/verifier_array_access.c         |   2 +-
 .../selftests/bpf/progs/verifier_regalloc.c   |   2 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  13 +-
 4 files changed, 5 insertions(+), 173 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09847c43d84a..5714c4d1036b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3578,30 +3578,6 @@ static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].non_stack_access = true;
 }
 
-#define LINKED_REGS_MAX	5
-
-struct linked_reg {
-	u8 frameno;
-	union {
-		u16 spi;
-		u16 regno;
-	};
-	bool is_reg;
-};
-
-struct linked_regs {
-	int cnt;
-	struct linked_reg entries[LINKED_REGS_MAX];
-};
-
-static struct linked_reg *linked_regs_push(struct linked_regs *s)
-{
-	if (s->cnt < LINKED_REGS_MAX)
-		return &s->entries[s->cnt++];
-
-	return NULL;
-}
-
 const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 {
 	const struct btf_type *func;
@@ -19596,119 +19572,6 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	return true;
 }
 
-static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_state *reg,
-				  u32 id, u32 frameno, u32 spi_or_reg, bool is_reg)
-{
-	struct linked_reg *e;
-
-	if (reg->type != SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) != id)
-		return;
-
-	e = linked_regs_push(reg_set);
-	if (e) {
-		e->frameno = frameno;
-		e->is_reg = is_reg;
-		e->regno = spi_or_reg;
-	} else {
-		clear_scalar_id(reg);
-	}
-}
-
-/* For all R being scalar registers or spilled scalar registers
- * in verifier state, save R in linked_regs if R->id == id.
- * If there are too many Rs sharing same id, reset id for leftover Rs.
- */
-static void collect_linked_regs(struct bpf_verifier_env *env,
-				struct bpf_verifier_state *vstate,
-				u32 id,
-				struct linked_regs *linked_regs)
-{
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	u16 live_regs;
-	int i, j;
-
-	id = id & ~BPF_ADD_CONST;
-	for (i = vstate->curframe; i >= 0; i--) {
-		live_regs = aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
-		func = vstate->frame[i];
-		for (j = 0; j < BPF_REG_FP; j++) {
-			if (!(live_regs & BIT(j)))
-				continue;
-			reg = &func->regs[j];
-			__collect_linked_regs(linked_regs, reg, id, i, j, true);
-		}
-		for (j = 0; j < bpf_stack_nr_slots(func); j++) {
-			struct bpf_stack_state *ss = bpf_stack_slot(func, j);
-
-			if (!bpf_is_spilled_reg(ss))
-				continue;
-			reg = &ss->spilled_ptr;
-			__collect_linked_regs(linked_regs, reg, id, i, j, false);
-		}
-	}
-}
-
-/* For all R in linked_regs, copy known_reg range into R
- * if R->id == known_reg->id.
- */
-static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
-			     struct bpf_reg_state *known_reg, struct linked_regs *linked_regs)
-{
-	struct bpf_reg_state fake_reg;
-	struct bpf_reg_state *reg;
-	struct linked_reg *e;
-	int i;
-
-	for (i = 0; i < linked_regs->cnt; ++i) {
-		e = &linked_regs->entries[i];
-		reg = e->is_reg ? &vstate->frame[e->frameno]->regs[e->regno]
-				: &bpf_stack_slot(vstate->frame[e->frameno], e->spi)->spilled_ptr;
-		if (reg->type != SCALAR_VALUE || reg == known_reg)
-			continue;
-		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
-			continue;
-		/*
-		 * Skip mixed 32/64-bit links: the delta relationship doesn't
-		 * hold across different ALU widths.
-		 */
-		if (((reg->id ^ known_reg->id) & BPF_ADD_CONST) == BPF_ADD_CONST)
-			continue;
-		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
-		    reg->delta == known_reg->delta) {
-			*reg = *known_reg;
-		} else {
-			s32 saved_off = reg->delta;
-			u32 saved_id = reg->id;
-
-			fake_reg.type = SCALAR_VALUE;
-			__mark_reg_known(&fake_reg, (s64)reg->delta - (s64)known_reg->delta);
-
-			/* reg = known_reg; reg += delta */
-			*reg = *known_reg;
-			/*
-			 * Must preserve off and id, otherwise another sync_linked_regs()
-			 * will be incorrect.
-			 */
-			reg->delta = saved_off;
-			reg->id = saved_id;
-
-			scalar_step_add(reg, reg, &fake_reg);
-			scalar32_min_max_add(reg, &fake_reg);
-			scalar_min_max_add(reg, &fake_reg);
-			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
-			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
-				zext_32_to_64(reg);
-			reg_bounds_sync(reg);
-		}
-		if (e->is_reg)
-			mark_reg_scratched(env, e->regno);
-		else
-			mark_stack_slot_scratched(env, e->spi);
-	}
-}
-
 /* a == b (mod 2^N) implies a == b if both fit in uN or both fit in sN. N is @bits. */
 static bool regs_fit_in_bits(const struct bpf_reg_state *a, const struct bpf_reg_state *b,
 			     u32 bits)
@@ -19954,7 +19817,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
 	struct bpf_reg_state *eq_branch_regs;
-	struct linked_regs linked_regs = {};
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -20023,16 +19885,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		__mark_reg_known(src_reg, insn->imm);
 	}
 
-	/*
-	 * Collect the linked registers before env->{true,false}_reg{1,2} setup,
-	 * otherwise ids dropped by collect_linked_regs() would be resurrected
-	 * when env->{true,false}_reg{1,2} are copied back.
-	 */
-	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
-		collect_linked_regs(env, this_branch, src_reg->id, &linked_regs);
-	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
-		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
-
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	env->false_reg1 = *dst_reg;
 	env->false_reg2 = *src_reg;
@@ -20092,19 +19944,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (BPF_SRC(insn->code) == BPF_X)
 		other_branch_regs[insn->src_reg] = env->true_reg2;
 
-	if (BPF_SRC(insn->code) == BPF_X &&
-	    src_reg->type == SCALAR_VALUE && src_reg->id &&
-	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-		sync_linked_regs(env, this_branch, src_reg, &linked_regs);
-		sync_linked_regs(env, other_branch, &other_branch_regs[insn->src_reg],
-				 &linked_regs);
-	}
-	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
-	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
-		sync_linked_regs(env, this_branch, dst_reg, &linked_regs);
-		sync_linked_regs(env, other_branch, &other_branch_regs[insn->dst_reg],
-				 &linked_regs);
-	}
 	if (env->bpf_capable) {
 		if (BPF_SRC(insn->code) == BPF_X) {
 			refine_linked_regs(env, this_branch, *insn_idx, insn->src_reg);
diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 7f98822889ca..29bed1e496af 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -762,7 +762,7 @@ l0_%=:	*(u32*)(r10 - 8) = r6;				\
 	: __clobber_all);
 }
 
-/* The slot has the id of r6, so the compare sets the range of the slot too */
+/* The slot holds the low 32 bits of r6, so the compare refines the slot too */
 SEC("socket")
 __description("valid map access into an array using a key that is compared after the spill")
 __success __retval(0)
diff --git a/tools/testing/selftests/bpf/progs/verifier_regalloc.c b/tools/testing/selftests/bpf/progs/verifier_regalloc.c
index ee5ddea87c91..cf26617b6ba1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_regalloc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_regalloc.c
@@ -303,7 +303,6 @@ __naked void regalloc_in_callee(void)
 	r7 = r0;					\
 	call %[bpf_get_prandom_u32];			\
 	r1 = r0;					\
-	r2 = r0;					\
 	r3 = r7;					\
 	call regalloc_in_callee__1;			\
 l0_%=:	exit;						\
@@ -318,6 +317,7 @@ static __naked __noinline __attribute__((used))
 void regalloc_in_callee__1(void)
 {
 	asm volatile ("					\
+	r2 = r1;					\
 	if r1 s> 20 goto l0_%=;				\
 	if r2 s< 0 goto l0_%=;				\
 	r3 += r1;					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 819d0a1a6886..e22120e5858f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -285,13 +285,8 @@ __naked void precision_two_ids(void)
 
 SEC("socket")
 __success __log_level(2)
-/*
- * check that r5 is unlinked after 'if', collect_linked_regs() can't tie
- * more than 5 registers for a single insn and the register compared by
- * the jump is not exempt from that. The jump refines the copies all the same.
- */
-__msg("7: (25) if r5 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7) " R3=" LINKED("1", 7, 0x7) " R4=" LINKED("1", 7, 0x7) " R5=scalar(smin=")
-__msg("12: (bf) r5 = r5                      ; R5=scalar(id=2")
+/* there is no limit of 5 registers for a single insn */
+__msg("7: (25) if r5 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7) " R3=" LINKED("1", 7, 0x7) " R4=" LINKED("1", 7, 0x7) " R5=" LINKED("1", 7, 0x7))
 __naked void linked_regs_too_many_regs(void)
 {
 	asm volatile (
@@ -304,14 +299,12 @@ __naked void linked_regs_too_many_regs(void)
 	"r3 = r0;"
 	"r4 = r0;"
 	"r5 = r0;"
-	/* r{0-4} fill the record, r5 does not fit and is unlinked */
 	"if r5 > 7 goto +0;"
-	/* keep r{1-4} live */
+	/* keep r{1-5} live */
 	"r1 = r1;"
 	"r2 = r2;"
 	"r3 = r3;"
 	"r4 = r4;"
-	/* make r5 appear in the log */
 	"r5 = r5;"
 	"r7 = r10;"
 	"r7 += r0;"
-- 
2.55.0

