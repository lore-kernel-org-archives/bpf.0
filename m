Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207871;
	b=d/PZNrE9+TIiZaKCdLjzf2ajOzbU2TGKrQ/i3eUmzOb3WJFwKNRuOb0ooeg/dKGEbfiY
	 cxt7T6yaGmWc1lA3gpwv5aWfpe9gDb5nsK5JfOFTEO5mKWRR+51wBd7TSfbyxlLaTg1QD
	 SM8y9i5UoDOveT0UVEtN57D57hPECKKFZx9G/6hhCYdaMFRvMFUPNygA+tS5SQensJcbl
	 Te9bWpN99dpO63R+SnbCO346UONZsEPOh+A/UZB5Le31peTEwzOCBgLwLNeHMu0vRpIEz
	 e4BgK5/P+EirnEaEdWvGxB5HNzhOgJeQ/QdVo6k4WUr2a/FmyHxVjRO5Ju/d8mch4Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KaeLXDzQZxC8bGF+6G07UERHg7zVFXI+lzP7mpMufYU=;
	b=qDDb1+CFfxT9VBIRdTikf6s7OQqQaFQs9uU3uubyLVxP83ecultwQqrvILCQA8jnnMp7
	 GJ1jYI6brvK0jRdROyttZg1xmnBXEBemG0pCjNNnjLcoaZUSplYoWLa4/xYwpZTVc9Yiy
	 dzJiquVM7FmutoZKJhNrQbOrT1jQPX4KsfcPn+MTbotr6Twx2hu3YtW6b10Z/AIlS4uoe
	 dB8Yx3ib4epuJoQRLskNzOMBJPo4u0LG/o9S7za79E1gpQrBsvwKdkzGaYxR0SZN+LKHX
	 gKU3cti153DGEsg3g+BXkV84Nbbf+Uitzdf3nGUsRFTYIgWVIEXL7RGzoFS1CgUQ/yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cds4YFmt;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAA606A6A9
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3EAA606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cds4YFmt
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b402824d07so981437a91.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207869; x=1795812669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaeLXDzQZxC8bGF+6G07UERHg7zVFXI+lzP7mpMufYU=;
        b=cds4YFmtoLauBB1cFCZxsUwY7IIE3Y4eyhAIA0sGupV/uaJ8Kt0lupwGLa6waKTu3/
         nCtkbpH7I6WyQRUlTdAzvOVFBSTiANgpLH6nTCudUBWyl6zTwKC1ddl8RLZrGQ46Zwjk
         LHsIVcci5zNOYdtqBQb5TA2/oHL8Bn4OJ2utQTzvXQt10JoRaVWqS+owyfqKAXQ9+jRa
         SINhtSjO/zSckP5fpwY9XTbwoAz3JVVS9nYiHv3xvMOkoV7OREaR+FWjl++iwRcjx1PN
         OtiKF0EOMJoOXAu7A4YWBmZ8X4X6TbuK8kMNPIMYx6Nsclu2f6jwOcKY2C1l5Xy2YWJf
         Z1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207869; x=1795812669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaeLXDzQZxC8bGF+6G07UERHg7zVFXI+lzP7mpMufYU=;
        b=GREmFk8gfqlqm1q5n06vttWEG3FokQ03Zj/wNQFoPB8F7/dKVTNCez85eBFA/Ld5kj
         V+fEexG1KFPlOkDCTtkxAsdVpbWxCB2SudptTn2tsWRjzgPkPvI+Tnl3Y8T9ykysbIcD
         sQKjn+aRpNrdMKNZMdszO62LYQ5Q4SO7BCBcRWaLizJwHNMPk6epZkn2B5PDM8V1C8/E
         6Fp1lELk7NLCfeQURb3042lpOoX02wsA2i3M0QSU+baVVnuzxfSKL+Iw158dTwOLLtzp
         rwFPoTgQZ8VRLYIwG6+5ZrscLirSLm2F1ThP3enLCp7F/7pnJr/2NQCsHPwoLzDNsL5m
         qKjQ==
X-Gm-Message-State: APuU4Z9cCDBwBjOIHR/1IkuEJOhg3uMDqxeSU9coGEcMjPo72sca37SC
	P6oSsIuSUmhVdlYsA0r9DF/XqpL4j7mTnSEK2WsVNvicHcw6yQU1rzievA2esw==
X-Gm-Gg: AZFdTZfd0zUNJFOyfNLcVy4cG/vh5uFBXtUPCH5Vhk347T4P0NmqHiRjZQ9NjLt6uSI
	iCMm8u4DDe/YZkeJQxXIYo9deYHUaWk6NVK9peVjcx4SmLGYaFoDe2/no8/e+Sv8Yqd6VNtO3ex
	wrDLgOlh0pN1adQLLQPo0IRfTQ7A3Cha80zxMtusUdWwCZZI2SIk5yNwI/ehxIwf1GuasTpy1rL
	ufGBEtmKg09EIvoC/Dnw+i5zEfzDPg+VUuqMF3YelmihLqK6JO5syFOMDv3Wvjqn8ZOv8xDe8xs
	7Z8PSGpoj0vLoeDoFTOuPdMzq11NO7olclccLXB0WainB1/OizmgtkIFJvojjob05dN34xUKqtm
	qJ029QZLeXBvc181loif6RaT0btgqyEHedc7dwDFOdqddTfL4Ag864utgMwiiTSCC3kzgEYTu/8
	QW6e4bSleuHomX0DCB09ipTnykAdmDvMInt01OacjUxncYrCVoDbnprvI9QkctsfGjynQBy1dAi
	slDHHS5/2MSBkvKQW59/tnVV3L8PrCt2TAx3OoUti/lJkplrTnKtpI3Pnl0d9o4bbh65Qdx9C3V
	IkQvGUN2vJ4D65lmvEHEs48np/Eu0Z1uTzYmtfkwcVhKK19sKv9ijj1nsz0CbbueMdlEciT7xxj
	7cf8rDvCLZBq1CXkAWhLzliLn/VVSjSNGS7fjRqrGC0X30lUrQEseCql+22jFlPB7UXIzY1UWMn
	ZGsiP/Sio75jQGQIt/Ds0B
X-Received: by 2002:a17:90b:2c87:b0:3b0:9e42:b67c with SMTP id 98e67ed59e1d1-3b41c96ed40mr3783755a91.61.1795207868672;
        Fri, 20 Nov 2026 12:51:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm5539648a91.14.2026.11.20.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 11/49] bpf: Put a barrier where no mask fits
Date: Fri, 20 Nov 2026 20:49:19 +0000
Message-ID: <20261120204959.614908-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

Without bypass_spec_v1 the offset of 'ptr += reg' is masked. The program
is rejected if two paths need two masks, or if no mask is possible. To
find such paths, explore_alu_limits keeps all states with other numbers
apart. That cannot work in a pass that joins all states.

Allow the insn and put a barrier before it. A mask fits if it passes
the largest offset that was checked, and no larger one:

  offset 2 or 3, joined to 2..3                    mask passes 0..3
  two masks, mixed signs, pointer to a packet      barrier

A stack pointer with a variable offset is still rejected.

An error in a speculative state is no error. The insn gets a barrier
and the path ends, see nospec_ends_path(). What the state noted at the
insn is dropped. The barrier has to stop each edge that leads there:

  fall-through, jump, call, return     barrier before the insn
  exit of a callback --> helper        barrier at the exit
  may_goto --> r0 = 0; exit            barrier before r0 = 0
  call --> recursion in frames         barrier at the call
  return --> dead code                 'goto -1' replaces the code

That 'goto -1' takes no zext_dst from the insn that it replaces. A jump
that is dead itself is not hard-wired: it is removed later, and the
driver of an offloaded program refuses a new target.

A speculative state starts no async callback, and it asks for no slot
of a stack argument.

This also fixes two bugs of the old code:
- If many insns replace an insn, the barrier has to go before the first
  one. In an inlined bpf_loop() it was before the last one, after the
  callback.
- A speculative path ends after a store to the stack, because a barrier
  follows the store. It also ended after other writes to the stack: an
  atomic, a call, a fastcall spill that is removed. No barrier follows
  them, and the code after them was not checked. Now the path continues.

explore_alu_limits and the REASON_* errors go away. Some unprivileged
programs load now.

Rename push_budget_exit() to push_unwind_exit(): the way to stop is
'r0 = 0; unwind_exit'. budget_exit_insn() becomes emit_unwind_exit(),
and budget_can_unwind() becomes state_can_unwind(). In the next patches
a budget is a limit on the work of the verifier.
bpf_insert_loop_guards() uses emit_unwind_exit() too. A later patch sets
guard_unwinds. pass_cnt counts the calls of do_check(): rename it to
check_cnt.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 +-
 kernel/bpf/const_fold.c      |   2 +-
 kernel/bpf/fixups.c          |  97 +++++++++--------
 kernel/bpf/liveness.c        |   2 +-
 kernel/bpf/verifier.c        | 205 +++++++++++++++++------------------
 5 files changed, 157 insertions(+), 156 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index eb05063c6d8..63c75a68c99 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -847,7 +847,7 @@ struct bpf_insn_aux_data {
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
-	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
+	u32 seen; /* this insn was processed by the verifier at env->check_cnt */
 	u64 nospec:1; /* do not execute this instruction speculatively */
 	u64 nospec_result:1; /* result is unsafe under speculation, nospec must follow */
 	u64 zext_dst:1; /* this insn zero extends dst reg */
@@ -857,6 +857,7 @@ struct bpf_insn_aux_data {
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 loop_guard:1; /* may_goto is added in front of this instruction */
+	u64 guard_unwinds:1; /* it leaves the subprog */
 	u64 call_recorded:1; /* see record_call_fixup() */
 	u64 guard_edge_dropped:1; /* an edge of may_goto from here was dropped */
 	u64 alu_state:5; /* used in combination with alu_limit */
@@ -1270,7 +1271,6 @@ struct bpf_verifier_env {
 	u32 insn_array_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_ARRAY */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	int exception_callback_subprog;
-	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	/* Allow access to uninitialized stack memory. Writes with fixed offset are
 	 * always allowed, so this refers to reads (with fixed or variable offset),
@@ -1283,6 +1283,7 @@ struct bpf_verifier_env {
 	/* a global function is verified for BPF_FUNC_CTX_NO_RCU_LOCK */
 	bool no_rcu_read_lock;
 	bool signature;
+	u8 bug:1;			/* ends the load, see bpf_note_bug() */
 	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	struct bpf_patch_list patch_list;
@@ -1328,7 +1329,7 @@ struct bpf_verifier_env {
 	} cfg;
 	/* Per-callsite snapshot of the parent's tracked spill slots for cross-frame fills. */
 	struct spill_snapshot **callsite_at_stack;
-	u32 pass_cnt; /* number of times do_check() was called */
+	u32 check_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
 	u32 insn_processed;
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 61e22636ff8..3310a55afa3 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -269,7 +269,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 			ci_in[start][r] = unknown;
 		/*
 		 * The subprog gets there from where it is out of budget too, see
-		 * push_budget_exit(). That is not an edge of the graph.
+		 * push_unwind_exit(). That is not an edge of the graph.
 		 */
 		for (r = 0; r < MAX_BPF_REG && env->subprog_info[i].bail_insn >= 0; r++)
 			ci_in[env->subprog_info[i].bail_insn][r] = unknown;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index da69995bcbe..3be90ed308c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -303,10 +303,11 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 	    memcmp(&patch[p->self], orig, sizeof(*orig)))
 		last->non_stack_access = true;
 
-	/* indirect jumps to the replaced insn land on p->target */
-	if (last->indirect_target && p->target != p->self) {
-		slot[p->target].indirect_target = 1;
-		last->indirect_target = 0;
+	/* jumps to the replaced insn land on p->target, so the barrier goes before it */
+	if (p->target != p->self) {
+		slot[p->target].indirect_target = last->indirect_target;
+		slot[p->target].nospec = last->nospec;
+		last->indirect_target = last->nospec = 0;
 	}
 }
 
@@ -565,21 +566,31 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	return err;
 }
 
-/* How a subprog leaves when it is out of budget, see push_budget_exit() */
-static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+/* How subprog @s leaves when it has to stop, see push_unwind_exit(). Returns the length. */
+static int emit_unwind_exit(struct bpf_verifier_env *env, int s, struct bpf_insn *buf)
 {
-	if (!sub->bail_unwinds)
-		return BPF_EXIT_INSN();
-	sub->can_unwind = true;
-	env->prog->jit_required = 1;
-	return BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0);
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	int n = 0;
+
+	if (!env->bypass_spec_v1)
+		buf[n++] = BPF_ST_NOSPEC();
+	buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	if (bpf_ret_reg_pair(env, s))
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+	buf[n] = BPF_EXIT_INSN();
+	if (sub->bail_unwinds) {
+		buf[n].src_reg = BPF_UNWIND_EXIT;
+		sub->can_unwind = true;
+		env->prog->jit_required = 1;
+	}
+	return n + 1;
 }
 
 /*
  * Add may_goto in front of the insns that the main pass marked, see
  * check_loop_guard(). It verified the edge from the insn to where may_goto goes.
  *
- *	may_goto to		or	may_goto leave		see push_budget_exit()
+ *	may_goto to		or	may_goto leave		see push_unwind_exit()
  *	insn				insn
  *					...
  *					last insn of the subprog
@@ -597,18 +608,14 @@ static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf
 int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 {
 	struct bpf_insn patch[2] = { BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0) };
-	struct bpf_insn leave[3] = { BPF_MOV64_IMM(BPF_REG_0, 0) };
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn leave[4], *insn;
 	struct bpf_subprog_info *sub;
-	struct bpf_insn *insn;
 	int i, s, n, err;
-	bool leaves;
 
 	for (s = 0; s < env->subprog_cnt; s++) {
 		sub = &env->subprog_info[s];
-		n = bpf_ret_reg_pair(env, s) ? 3 : 2;
-		leaves = false;
-		for (i = sub->start; i < sub[1].start; i++) {
+		for (i = sub->start, n = 0; i < sub[1].start; i++) {
 			if (!aux[i].loop_guard)
 				continue;
 			/* A jump to itself is a back edge. It goes through may_goto too. */
@@ -616,16 +623,15 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 			insn = bpf_patch_list_add(env, i, patch, 2);
 			if (IS_ERR(insn))
 				return PTR_ERR(insn);
-			if (aux[i].guard_no_unwind)
+			if (!aux[i].guard_unwinds) {
 				bpf_patch_list_jump(&env->patch_list, insn - 1, aux[i].guard_to, 0);
-			else
-				bpf_patch_list_jump(&env->patch_list, insn - 1, sub[1].start, n);
-			leaves |= !aux[i].guard_no_unwind;
+				continue;
+			}
+			n = emit_unwind_exit(env, s, leave);
+			bpf_patch_list_jump(&env->patch_list, insn - 1, sub[1].start, n);
 		}
-		if (!leaves)
+		if (!n)
 			continue;
-		leave[1] = BPF_MOV64_IMM(BPF_REG_2, 0);
-		leave[n - 1] = budget_exit_insn(env, sub);
 		err = bpf_patch_list_append(env, i - 1, leave, n);
 		if (err)
 			return err;
@@ -697,8 +703,8 @@ int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_insn buf[24], nop = BPF_JMP_A(0), *insn;
+	int s, n, jmp, bail, err;
 	bool found = false;
-	int s, n, jmp, err;
 
 	for (s = 1; s < env->subprog_cnt; s++)
 		found |= si[s].recursive;
@@ -719,14 +725,12 @@ int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
 				return PTR_ERR(insn);
 		}
 		jmp = n++;
-		n += emit_stack_check(buf + n, bpf_ret_reg_pair(env, s) ? 4 : 3);
+		bail = emit_unwind_exit(env, s, buf + n);
+		n += emit_stack_check(buf + n, 1 + bail);
 		/* The arguments are not needed any more */
 		buf[n++] = BPF_EMIT_KERNEL_CALL(bpf_prog_report_recursion);
 		buf[jmp] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, n - jmp - 1, 0);
-		buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
-		if (bpf_ret_reg_pair(env, s))
-			buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
-		buf[n++] = budget_exit_insn(env, &si[s]);
+		n += emit_unwind_exit(env, s, buf + n);
 		/* calls get to the check, jumps to the first insn do not */
 		err = bpf_patch_list_insert(env, si[s].start, buf, n);
 		if (err)
@@ -784,25 +788,24 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 	struct bpf_insn trap = BPF_JMP_IMM(BPF_JA, 0, 0, -1);
 	struct bpf_insn *insn = env->prog->insnsi;
 	const int insn_cnt = env->prog->len;
+	bool unwinds, calls;
 	int i;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (!bpf_insn_is_cond_jump(insn->code))
-			continue;
-
-		if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen) {
-			/*
-			 * The callee never exits. Its unwind_exit needs
-			 * unwind_goto all the same, and the cpu predicts that it
-			 * returns to what follows. Don't let the removal of dead
-			 * code put something else there.
-			 */
-			if (!aux_data[i + 1].seen) {
-				memcpy(insn + 1, &trap, sizeof(trap));
-				aux_data[i + 1].seen = env->pass_cnt;
-			}
-			continue;
+		unwinds = bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen;
+		calls = (bpf_pseudo_call(insn) || bpf_is_callx(insn)) && aux_data[i].seen;
+		/*
+		 * The callee never exits. Its unwind_exit needs unwind_goto all the same.
+		 * The cpu predicts that it returns to what follows, or speculates to an exit.
+		 * Don't let the removal of dead code put something else there.
+		 */
+		if ((unwinds || (calls && !env->bypass_spec_v1)) && !aux_data[i + 1].seen) {
+			memcpy(insn + 1, &trap, sizeof(trap));
+			aux_data[i + 1].zext_dst = false;
+			aux_data[i + 1].seen = env->check_cnt;
 		}
+		if (unwinds || !aux_data[i].seen || !bpf_insn_is_cond_jump(insn->code))
+			continue;
 
 		if (!aux_data[i + 1].seen)
 			ja.off = insn->off;
@@ -841,7 +844,7 @@ static void keep_funcs_with_addr_taken(struct bpf_verifier_env *env)
 			continue;
 		memcpy(insn + t, &trap, sizeof(trap));
 		aux_data[t].zext_dst = false;
-		aux_data[t].seen = env->pass_cnt;
+		aux_data[t].seen = env->check_cnt;
 	}
 }
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 78acb620aa7..4cc29334a69 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2975,7 +2975,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		 */
 		insn_aux[i].zext_dst = def32 >= 0 && (mask_hi(out) & BIT(def32));
 	}
-	/* the exit that stands for 'r0 = 0; exit' may be dead code, see push_budget_exit() */
+	/* the exit that stands for 'r0 = 0; exit' may be dead code, see push_unwind_exit() */
 	for (i = 0; i < env->subprog_cnt; i++)
 		if (env->subprog_info[i].bail_insn >= 0)
 			insn_aux[env->subprog_info[i].bail_insn].live_regs_before |=
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80b4a2a3e93..319b816ee77 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4298,7 +4298,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		return err;
 
 	/* Track the max outgoing stack arg slot count. */
-	if (spi + 1 > subprog->max_out_stack_arg_cnt)
+	if (spi + 1 > subprog->max_out_stack_arg_cnt && !env->cur_state->speculative)
 		subprog->max_out_stack_arg_cnt = spi + 1;
 
 	arg = &state->stack_arg_regs[spi];
@@ -11123,6 +11123,9 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			state->curframe + 2);
 		return -E2BIG;
 	}
+	/* in the frames of the callers it has no end */
+	if (state->speculative && env->subprog_info[subprog].recursive)
+		return -EACCES;
 
 	if (state->frame[state->curframe + 1]) {
 		verifier_bug(env, "Frame %d already allocated", state->curframe + 1);
@@ -11329,6 +11332,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (bpf_is_async_callback_calling_insn(insn)) {
 		struct bpf_verifier_state *async_cb;
 
+		if (state->speculative)
+			return 0;
 		/* there is no real recursion here. timer and workqueue callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
@@ -12290,6 +12295,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		state->unwound = true;
 	}
 	if (callee->in_callback_fn) {
+		/* the helper continues after the barrier of its call */
+		if (state->speculative)
+			return -EACCES;
 		if (r0->type != SCALAR_VALUE) {
 			verbose(env, "R0 not a scalar value\n");
 			return -EACCES;
@@ -16133,14 +16141,6 @@ static bool check_reg_sane_offset_scalar(struct bpf_verifier_env *env,
 	return true;
 }
 
-enum {
-	REASON_BOUNDS	= -1,
-	REASON_TYPE	= -2,
-	REASON_PATHS	= -3,
-	REASON_LIMIT	= -4,
-	REASON_STACK	= -5,
-};
-
 /*
  * A far pointer is no error: a state with near offsets gets here, so this one does too.
  * An access through it is unproven or gets a fault handler, see check_load_mem().
@@ -16163,6 +16163,8 @@ void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	reg_bounds_sync(reg);
 }
 
+#define NO_MASK_FITS	1
+
 static int retrieve_ptr_limit(const struct bpf_verifier_env *env,
 			      const struct bpf_reg_state *ptr_reg,
 			      u32 *alu_limit, bool mask_to_left)
@@ -16184,11 +16186,11 @@ static int retrieve_ptr_limit(const struct bpf_verifier_env *env,
 		ptr_limit = mask_to_left ? reg_smin(ptr_reg) : reg_umax(ptr_reg);
 		break;
 	default:
-		return REASON_TYPE;
+		return NO_MASK_FITS;
 	}
 
 	if (ptr_limit >= max)
-		return REASON_LIMIT;
+		return NO_MASK_FITS;
 	*alu_limit = ptr_limit;
 	return 0;
 }
@@ -16196,7 +16198,7 @@ static int retrieve_ptr_limit(const struct bpf_verifier_env *env,
 static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
 				    const struct bpf_insn *insn)
 {
-	return env->bypass_spec_v1 ||
+	return env->bypass_spec_v1 || env->path_sensitive ||
 		BPF_SRC(insn->code) == BPF_K ||
 		cur_aux(env)->nospec;
 }
@@ -16210,7 +16212,7 @@ static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
 	if (aux->alu_state &&
 	    (aux->alu_state != alu_state ||
 	     aux->alu_limit != alu_limit))
-		return REASON_PATHS;
+		return NO_MASK_FITS;
 
 	/* Corresponding fixup done in do_misc_fixups(). */
 	aux->alu_state = alu_state;
@@ -16237,6 +16239,7 @@ static bool sanitize_needed(u8 opcode)
 struct bpf_sanitize_info {
 	struct bpf_insn_aux_data aux;
 	bool mask_to_left;
+	u64 max_off;
 };
 
 static int sanitize_speculative_path(struct bpf_verifier_env *env,
@@ -16268,8 +16271,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 			    const bool commit_window)
 {
 	struct bpf_insn_aux_data *aux = commit_window ? cur_aux(env) : &info->aux;
-	struct bpf_verifier_state *vstate = env->cur_state;
-	bool off_is_imm = tnum_is_const(off_reg->var_off);
+	bool off_is_imm = cnum64_is_const(off_reg->r64);
 	bool off_is_neg = reg_smin(off_reg) < 0;
 	bool ptr_is_dst_reg = ptr_reg == dst_reg;
 	u8 opcode = BPF_OP(insn->code);
@@ -16280,24 +16282,18 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	if (can_skip_alu_sanitation(env, insn))
 		return 0;
 
-	/* We already marked aux for masking from non-speculative
-	 * paths, thus we got here in the first place. We only care
-	 * to explore bad access from here.
-	 */
-	if (vstate->speculative)
-		goto do_sim;
-
 	if (!commit_window) {
-		if (!tnum_is_const(off_reg->var_off) &&
+		if (!off_is_imm &&
 		    (reg_smin(off_reg) < 0) != (reg_smax(off_reg) < 0))
-			return REASON_BOUNDS;
+			return NO_MASK_FITS;
 
+		info->max_off = off_is_neg ? -(u64)reg_smin(off_reg) : reg_umax(off_reg);
 		info->mask_to_left = (opcode == BPF_ADD &&  off_is_neg) ||
 				     (opcode == BPF_SUB && !off_is_neg);
 	}
 
 	err = retrieve_ptr_limit(env, ptr_reg, &alu_limit, info->mask_to_left);
-	if (err < 0)
+	if (err)
 		return err;
 
 	if (commit_window) {
@@ -16306,24 +16302,24 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		 */
 		alu_state = info->aux.alu_state;
 		alu_limit = abs(info->aux.alu_limit - alu_limit);
+		/*
+		 * The mask passes what was checked: it cuts no real offset and adds no other one.
+		 * It passes all smaller offsets too. The slots of the stack are not alike.
+		 * A stack pointer plus a range gets here if the step makes the sum a constant.
+		 */
+		if (alu_limit != info->max_off ||
+		    (ptr_reg->type == PTR_TO_STACK && !(alu_state & BPF_ALU_IMMEDIATE)))
+			return NO_MASK_FITS;
 	} else {
 		alu_state  = off_is_neg ? BPF_ALU_NEG_VALUE : 0;
 		alu_state |= off_is_imm ? BPF_ALU_IMMEDIATE : 0;
 		alu_state |= ptr_is_dst_reg ?
 			     BPF_ALU_SANITIZE_SRC : BPF_ALU_SANITIZE_DST;
-
-		/*
-		 * Keep states that differ in unknown scalars apart to find
-		 * potential masking differences from other program paths.
-		 */
-		if (!off_is_imm)
-			env->explore_alu_limits = true;
 	}
 
 	err = update_alu_sanitation_state(aux, alu_state, alu_limit);
-	if (err < 0)
+	if (err)
 		return err;
-do_sim:
 	/* If we're in commit phase, we're done here given we already
 	 * pushed the truncated dst_reg into the speculative verification
 	 * stack.
@@ -16350,7 +16346,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	}
 	err = sanitize_speculative_path(env, NULL, env->insn_idx + 1, env->insn_idx);
 	if (err < 0)
-		return REASON_STACK;
+		return err;
 	if (!ptr_is_dst_reg)
 		*dst_reg = tmp;
 	return 0;
@@ -16366,43 +16362,40 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
 	 * rewrite/sanitize them.
 	 */
 	if (!vstate->speculative)
-		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
+		env->insn_aux_data[env->insn_idx].seen = env->check_cnt;
 }
 
-static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *insn, int reason)
+/*
+ * The insn at @idx gets a barrier, and no mask. A fall-through, a jump, a call or a return to
+ * @idx runs the barrier first. So it ends a speculative state that comes that way. The other
+ * edges have their own barrier, and a speculative state does not take them:
+ *
+ *	exit of a callback --> call of the helper	barrier at the exit
+ *	may_goto --> r0 = 0; exit			see emit_unwind_exit()
+ *	return --> dead code				see bpf_opt_hard_wire_dead_code_branches()
+ */
+static void need_nospec(struct bpf_verifier_env *env, u32 idx)
 {
-	static const char *err = "pointer arithmetic with it prohibited for !root";
-	const char *op = BPF_OP(insn->code) == BPF_ADD ? "add" : "sub";
-	u32 dst = insn->dst_reg, src = insn->src_reg;
-	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
 
-	switch (reason) {
-	case REASON_BOUNDS:
-		verbose(env, "R%d has unknown scalar with mixed signed bounds, %s\n",
-			regs[src].type == SCALAR_VALUE ? src : dst, err);
-		break;
-	case REASON_TYPE:
-		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
-			regs[src].type == SCALAR_VALUE ? dst : src, err);
-		break;
-	case REASON_PATHS:
-		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s\n",
-			dst, op, err);
-		break;
-	case REASON_LIMIT:
-		verbose(env, "R%d tried to %s beyond pointer bounds, %s\n",
-			dst, op, err);
-		break;
-	case REASON_STACK:
-		verbose(env, "R%d could not be pushed for speculative verification, %s\n",
-			dst, err);
-		return -ENOMEM;
-	default:
-		verifier_bug(env, "unknown reason (%d)", reason);
-		break;
+	/* nothing fits between it and the call */
+	if (bpf_is_unwind_goto(insn)) {
+		need_nospec(env, idx + 1);
+		return need_nospec(env, idx + insn->off + 1);
 	}
+	aux->nospec = true;
+	aux->alu_state = 0;
+}
 
-	return -EACCES;
+static int sanitize_err(struct bpf_verifier_env *env, int err)
+{
+	if (err != NO_MASK_FITS)
+		return err;
+	if (env->cur_state->speculative)
+		return -EACCES;
+	need_nospec(env, env->insn_idx);
+	return 0;
 }
 
 /* check that stack access falls within stack limits and that 'reg' doesn't
@@ -16623,10 +16616,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	}
 
 	if (sanitize_needed(opcode)) {
-		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
-				       &info, false);
-		if (ret < 0)
-			return sanitize_err(env, insn, ret);
+		ret = sanitize_err(env, sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
+							 &info, false));
+		if (ret)
+			return ret;
 	}
 
 	/*
@@ -16767,14 +16760,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		ret = sanitize_ptr_alu(env, insn, dst_reg, off_reg, dst_reg,
 				       &info, true);
 		if (verifier_bug_if(!can_skip_alu_sanitation(env, insn)
-				    && !env->cur_state->speculative
 				    && bounds_ret
 				    && !ret,
 				    env, "Pointer type unsupported by sanitize_check_bounds() not rejected by retrieve_ptr_limit() as required")) {
 			return -EFAULT;
 		}
-		if (ret < 0)
-			return sanitize_err(env, insn, ret);
+		return sanitize_err(env, ret);
 	}
 
 	return 0;
@@ -17665,9 +17656,9 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struct bpf_i
 	int ret;
 
 	if (sanitize_needed(opcode)) {
-		ret = sanitize_val_alu(env, insn);
-		if (ret < 0)
-			return sanitize_err(env, insn, ret);
+		ret = sanitize_err(env, sanitize_val_alu(env, insn));
+		if (ret)
+			return ret;
 	}
 
 	if ((opcode == BPF_AND || opcode == BPF_OR) && tnum_is_const(src_val.var_off)) {
@@ -20645,8 +20636,8 @@ static bool zero_is_valid_retval(struct bpf_verifier_env *env)
  * @or_exit: there is no such path. 'r0 = 0; exit' has to do where the subprog
  * cannot unwind, and the caller goes on with 0 in place of the result.
  */
-static bool budget_can_unwind(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
-			      bool or_exit)
+static bool state_can_unwind(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			     bool or_exit)
 {
 	const struct bpf_func_state *frame = st->frame[st->curframe];
 	const struct bpf_subprog_info *sub = &env->subprog_info[frame->subprogno];
@@ -20686,12 +20677,14 @@ static bool guard_reads_unset_reg(struct bpf_verifier_env *env,
  * can do that, with exit otherwise. The insns are added when the main pass is over. Until
  * then an exit that the subprog has stands for them.
  */
-static int push_budget_exit(struct bpf_verifier_env *env)
+static int push_unwind_exit(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
 	struct bpf_verifier_state *branch;
 	struct bpf_reg_state *regs;
 
+	if (env->cur_state->speculative)
+		return 0;
 	branch = push_stack(env, sub->bail_insn, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
@@ -20767,14 +20760,14 @@ static int check_loop_guard(struct bpf_verifier_env *env)
 		aux->guard_no_unwind = false;
 	}
 	if (!aux->guard_no_unwind &&
-	    !budget_can_unwind(env, env->cur_state, aux->guard_unset_reg)) {
+	    !state_can_unwind(env, env->cur_state, aux->guard_unset_reg)) {
 		aux->guard_no_unwind = true;
 		/* What would leave the loop from the states that were here is gone. All again. */
 		if (aux->guard_edge_dropped && loop->guarded)
 			env->guards_late = true;
 	}
 	if (!aux->guard_no_unwind) {
-		err = push_budget_exit(env);
+		err = push_unwind_exit(env);
 		if (err)
 			return err;
 		env->head->guard_edge = BPF_GUARD_LEAVES_SUBPROG;
@@ -20819,7 +20812,19 @@ static int check_recursion_guard(struct bpf_verifier_env *env)
 
 	if (!sub->recursive || env->insn_idx != sub->start)
 		return 0;
-	return push_budget_exit(env);
+	return push_unwind_exit(env);
+}
+
+static bool is_error_of_state(struct bpf_verifier_env *env, int err)
+{
+	return err != -ENOMEM && err != -EINTR && !env->over_limit && !env->bug;
+}
+
+/* An error in a speculative state is no error */
+static bool nospec_ends_path(struct bpf_verifier_env *env,
+			     const struct bpf_verifier_state *st, int err)
+{
+	return st->speculative && err < 0 && is_error_of_state(env, err);
 }
 
 static void free_pushed_states(struct bpf_verifier_env *env)
@@ -20844,6 +20849,7 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
+		struct bpf_insn_fixups fixups;
 		int err;
 
 		err = bpf_check_limits(env);
@@ -20944,24 +20950,22 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
-		err = check_loop_guard(env);
-		if (err)
-			return err;
-
-		err = check_recursion_guard(env);
+		err = check_loop_guard(env) ?: check_recursion_guard(env);
 		if (err)
 			return err;
 
+		fixups = insn_aux->fixups;
 		err = do_check_insn(env, &do_print_state);
-		if (error_recoverable_with_nospec(err) && state->speculative) {
+		if (nospec_ends_path(env, state, err)) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
+			 * What it noted does not apply to the other paths.
+			 * check_fastcall_stack_contract() clears the pattern only once.
 			 */
-			insn_aux->nospec = true;
-			/* If it was an ADD/SUB insn, potentially remove any
-			 * markings for alu sanitization.
-			 */
-			insn_aux->alu_state = 0;
+			fixups.fastcall_spills_num = insn_aux->fastcall_spills_num;
+			insn_aux->fixups = fixups;
+			need_nospec(env, prev_insn_idx);
+			free_pushed_states(env);
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
@@ -20972,16 +20976,9 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 			env->insn_idx++;
 		}
 
-		if (state->speculative && insn_aux->nospec_result) {
-			/*
-			 * All non-branch instructions have a single fall-through
-			 * edge. For these, nospec_result should already work.
-			 */
-			if (verifier_bug_if((BPF_CLASS(insn->code) == BPF_JMP ||
-					     BPF_CLASS(insn->code) == BPF_JMP32) &&
-					    BPF_OP(insn->code) != BPF_CALL, env,
-					    "speculation barrier after jump instruction may not have the desired effect"))
-				return -EFAULT;
+		/* only a store that stays gets it, see bpf_convert_ctx_accesses() */
+		if (state->speculative && insn_aux->nospec_result && !insn_aux->fastcall_pattern &&
+		    bpf_is_mem_insn(insn) && BPF_MODE(insn->code) == BPF_MEM) {
 process_bpf_exit:
 			account_current_path(env);
 			mark_verifier_state_scratched(env);
@@ -22128,7 +22125,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	int ret, i;
 
 	env->prev_linfo = NULL;
-	env->pass_cnt++;
+	env->check_cnt++;
 
 	state = kzalloc_obj(struct bpf_verifier_state, BPF_VERIFIER_GFP);
 	if (!state)
-- 
2.55.0

