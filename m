Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206951;
	b=nHS7E3UtIuc1ylWpLAV44RKYKDYQ403MIHc5OLYyj1VcNWgd/SZygd+uc85/xxo2TS66
	 MPSgbg2AA0ij2FYo2aqCiJiLCYdCiz2oCtlxcsqZS4KEkOWDOlN2mWAsSyD1/WhwsyCqJ
	 dJHD+uwPwkhI/Kfm2t5KhozSzRhWsZxxkjcXAJTBbYMY4bn728xjK3UQAg+dghLOFEFZJ
	 u2A7nYgxfGX9OCp0VG31AoTZaSQOkkSRfv9+sMfhKt8qRu4barg/I0SvndekRGMRUCCL+
	 z2vrxerIojOFf2niWj0yqJINXds4zLcVnuv1c8rs4DubPT4kFMZJC+z4ZbH3rS5ZlvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yJY9rCwo/K7wE+l1pXfgDOZ3C89FY1A+JDm/Ukm4V2I=;
	b=AhjOPRsA+Tq/XzIqvQKLD8Xd5eFKjMTfo3TCHuWzMrqcuWHC33LwU+nPnz/Yd/zTwxYd
	 myoaL0FbqoNkB4N3/h1w0UqUNxpm8q/jym+fnMMZg1n9K/W1aVTwoMgfrOO/3O7CEQ9gC
	 SnyaMZlJ65HVNPE/uXqGMc5qUbqgMD4X9muSfYROoOTlGIAMOU/Knd2vnN2nbreON5rW7
	 7ZGV3s3V3rFXLoVGBJ63IWyshVj6U/dXt1mpHiy/eWFBAl+U9FFheLYYG2XWJ3GoBW0JH
	 tCEi/UnM6gyW40Gx+1MQCu8DMEp7GS0+vG/YBNXrWK9BS5q8c+O3zhja6N1O9u05nbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfrst+wA;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CF606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E31CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfrst+wA
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso233309a91.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206950; x=1794811750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJY9rCwo/K7wE+l1pXfgDOZ3C89FY1A+JDm/Ukm4V2I=;
        b=wfrst+wA1Jh1DzKdqxafvRgtOLJyHo8MjHH2uNqqR3Oc8OHidcvlg1QH6Kybcv0gGg
         973KFWh4Y75pEwNN8JcJjYJqx3/hzfTNNptaKreUs0Fyu0LQhweJo9+D6y88b90PEGAQ
         RSLhZVo0Ke8+np/Ch414Ono64iVx3sJjnirrY2Tz14NL4F/0Jnp3hY4x9cFzyRy3sobV
         HELg6pGOc5vifM3U1OiF6uv4M3sCnBL5jc51xFdg87M4Poy+8fNtHHb910aS1wb4emCg
         ZciRq+Yl+no1ITpLZ+E7fh7UIkVqgPCC3abyjahs2dY+WJyxXvxv7c6t5bMVvpsNmRGn
         /OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206950; x=1794811750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yJY9rCwo/K7wE+l1pXfgDOZ3C89FY1A+JDm/Ukm4V2I=;
        b=usSKXAymeccjHdK3q0MTcPmUPS0caEWq8OOAFt0iLR1NXRcPAE+uotQ8rpP5ojirFh
         RVGQ/Jww4wZLFKPrApCR0yLbRjYzNa4SNEd7hJPtWxtJUpYEpswm31M2cOQJiSXVSi+I
         qQUnX82DboFF87s9smgWZoehY0MV0/t/k+sKfhWjJ2yZdobsvyCARLliJJaFztmTtqgG
         CH00OX2k6AM7ID6yadA69prLOYJBvf4gSOlrhsWbypJoLQBCUtNPAkQXcuBargcQRHUE
         H3xPnycQ5aNn+xO+WM8+lUARm1bukUBtnzUNb3l8cdl5TjtMQhvnF2sRlawFkO1YWsv1
         a50w==
X-Gm-Message-State: APuU4Z+wF/5Hn7gfZjnHk/Vfr0aSLsfsz8XeFMGOVl7OmA4MHI7Ws99F
	0ASqRCImOdHzo5rIMUyfODjzNqrMKH5MX2vQN9g1AY0a+S6A1gkPYqlzbf8pZg==
X-Gm-Gg: AYBFou1jTUfvVsI5WIs2mcHaqxodlyeCyUtbYZd8nwID3TqwChS/ARaFA0yUkgznAxd
	DBfo12bEkIqztx6xK0oTUnaa33WpuU+4djiemxbHv+zrXFB83zBcXloRGrWCg+PVE6GvfiyeNa0
	Zkwo9XVEHQ1NJb2OZ2WQZdl8/mver73ssTB+uXOqlIN1GE8wB2u6cAxpiEyhX8WtbEAzuTg6Ry0
	IGLEjE6Ch9/I4cbE3HS1ReaMReIZkicj56JXL/Cy8eAOKTLbuBIFfJ/5C9xkzqyUtEXHk3knXzv
	KOMFeu/fbby/gLs9sAxzD8YE3qJRrj6mQT47FQXlonrEfLifIsuneI0ksPKTWdsGQL9ksgFYFv1
	2PLgxA0uXD9L7aUTbFcdNAGR7k/FtxoZ7IF5KKx7NijCL/riYcHfyr+Ne0VPwQFn0zyZOrt88Ja
	KLb3aVN9SP4tut8FwrHJeRPHn29O7UtOik1kzLUBPRB7ZBDyJYAERfdY/ib0AFz/6HRiOVDSZxN
	Ew2Hw7rwf16CcGwDa2HGVZ7tAcsNB7QeNXQHQ8dv0iz7vhY7jtAI3LtEdqMKZ4ef7aFz4t+QLyw
	CGB0AkRTpqEAjsZYUOu8im02MHOXwBy1v+x88ruW2AgFyJIRr4OffeyapKoo8mDE+7U1DPHku7s
	V/nFi/cUsMNsS84NaUHhUupIbcw0luOh93RVlRm8SJ1Dd0o138DaGT0uIZmQ0hD1HBkvj5ufWlQ
	==
X-Received: by 2002:a17:90b:1a82:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3b12d395a24mr3248580a91.49.1794206949971;
        Sun, 08 Nov 2026 22:49:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12797095fsm5532571a91.16.2026.11.08.22.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 19/26] bpf: Remove sync_linked_regs(), refine by scalar evolution only
Date: Mon,  9 Nov 2026 06:47:03 +0000
Message-ID: <20261109064715.2382452-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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
a state knows that two scalars are linked: across frames, and on one of
several paths. One selftest has to change.

After a conditional jump sync_linked_regs() copies the range of the tested
register, plus delta, to all scalars with its id. refine_linked_regs()
does that job without ids. It refines the linked registers of the jump:
the live registers and stack slots that are a tested register + a constant
on every path to the jump. Scalar evolution computes them before the main
pass. There is no limit of 5 registers, and a second '+=' does not drop
the link. Both run at every jump, sync_linked_regs() first. Remove it,
collect_linked_regs() and struct linked_regs. Scalar ids are still
assigned, no jump reads them.

Precision that is lost:
 - Linked registers belong to the frame of the jump. Scalar ids also
   linked registers and stack slots of the callers. A subprog that tests
   its argument refined the register that the caller keeps. A field of
   a struct on the stack of the caller that a subprog loads, tests and
   loads again was refined in the slot.
 - That two arguments hold the same value is known at the callsite, not in
   the subprog. The selftest "regalloc in callee" passes the same value in
   r1 and r2 and is rejected now. Its 'r2 = r0' before the call becomes
   'r2 = r1' in the callee.
 - 'r2 = r1' on one of two paths to a jump. A link holds on every path, so
   r2 is not linked. The id worked until the state of that path was joined
   with the other one. The first iteration of a loop is such a path.
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
which can be 0xfffffffc:

  R0 unbounded memory access, make sure to bounds check any such access

With refine_linked_regs() alone r2 is in [0, 15] and the prog loads.

The selftest linked_regs_too_many_regs sees all six registers refined.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 161 ------------------
 .../bpf/progs/verifier_array_access.c         |   2 +-
 .../selftests/bpf/progs/verifier_regalloc.c   |   2 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  13 +-
 4 files changed, 5 insertions(+), 173 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 970211dfe38c..103e83cd23ef 100644
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
@@ -19629,119 +19605,6 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
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
@@ -19886,7 +19749,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
 	struct bpf_reg_state *eq_branch_regs;
-	struct linked_regs linked_regs = {};
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -19955,16 +19817,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -20018,19 +19870,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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

