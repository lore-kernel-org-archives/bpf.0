Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983880;
	b=ILEb3QZzZMi47EEXY45Qr52ORqpPJIznn+uX0aK/iMa5Lc+wSROCfYzFVRyYDs8vDQyb
	 DsKu2OvhiLh9XlAL+xYHQDqVgU8D9FevLcK9h6i0bw3LfVyef8f23ZKVh48xg1zOfNNCk
	 12ovddixv2Ofn/d9d7kFishg62Hyv/G3EgERi0m41qWu3KIXvoPMJlHq3i/p8LkTGLyxL
	 SqTR1JhTY8rkmxlrO0KIG49g2q19eHD7RcB4C9yHXdsvQeEn5bWZA5sQbyijrK+bhampu
	 aLzD+MFg033YmsOmE1Pkep48giFsM1JLwKE4qogZKGGLqb1CzUcKpzTyGm8SDa9jSNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/HnZdDf6BTWHsvhBySpEwNWr2wb/3OiF6XQWorYoy9g=;
	b=B7KQ4lkk7grtFbvjWhVJWvzre0hvKNJt6SJXg5oa+BNIm+Qd3/tYUlV0/VEteoQZVHkH
	 +1v+5C6dFA9PytBSR6mJ7vvKfVjA1UU2tgA8PoQRGG9WtcpgUEAUkokETEQddJLBvKs/a
	 vyu6ZZqinBAufq19wC5PEjhrVGU6k53knjTHn8TJ1YK09smJCWiYoORLUEhM7eVNv4kkq
	 C4iTHtyb97m5Z+PalcRWCoABKmhsQrV8tt3E4tJ4OdQSf7PNUO5hXMiyMTBehyXfyfuZv
	 EX829YhJYRt2yeDYSlqr3+ATwtJq2DiNDqg7XYfRlo97gIwahK3tUyin41kcTeAx35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p4aJcQ1C;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED315606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED315606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p4aJcQ1C
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1503748a12.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983879; x=1793588679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HnZdDf6BTWHsvhBySpEwNWr2wb/3OiF6XQWorYoy9g=;
        b=p4aJcQ1C1W/tS9SFiu8qlaTCOPMkhMj0jyRaCXoKWHwc4qRjJdizc2uA2WVCYSVSSe
         inagU8ebfAQDbEHKEp10odXQ7Y7CkpKIWE9iGjfTBDUW/rzz8GjbvfZ1ZHOUtsqEf0xe
         g1tey9C201oF1m+0LF2pjaBUP7yx9TOblttknYBf7PwoHE10rSEWfWBbhIRbNdygsjFd
         2NrdSLIymqaZoWRUns0ibBO5NziFuLUe8Uqy70No0Ukfo1UsIQED8ghcNt0QnzQaTGvX
         0udL6p1FmSX3VBs8Uo+P2F5qNP+5uNIJ29QH+hZTsDsx5yhgcsHrbk4HYhiOKIcrMes7
         B12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983879; x=1793588679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HnZdDf6BTWHsvhBySpEwNWr2wb/3OiF6XQWorYoy9g=;
        b=vDPIBwWeE/adiIyuQE3ywa84697rihpzx2D54rJ4KMpAR6oku6NQgHImvfhYnrQ+3g
         hrY5AN8ejO8uo5jRE2bh7U02SUK6/8rdJ1N0bWQ3QZ+Xa12u95WwtqdtnzESLqhmbjK9
         rGrMYl1iuohyZJ6PuzV8rXsBofnViCj4lbx8hGGdIIwXBkq8pAvFa/pyss1sFV2QywAB
         TkKbQsrF5HXaEkvgMBFbjVTaNUH2SO+9xexGUmLq9OzAC7yyp4rLfVuAiCmYHPr25XUm
         GgnOgEHyw6Ub4IgIRFPDnZlIx+BClMrbMFGeqGF3zAWQ2tahGchgEJPN8WgEYUWwlIyi
         MRKg==
X-Gm-Message-State: AFq9FYLE81uz8GnO0b4XYfiRgPBmrWFNyIastEjF3TRyMF9dmQJgaYEd
	NmBAoFFIoWEmSPgbJL0nkFuYMhHKOhc/98ssbjHu4ZIAYmHLJ0mbvBSJCkBx2g==
X-Gm-Gg: AYBFou2JQ8SBP+MxRkgPuODDy40vSAJP315gUeqKTG1gmPa5VbEfttyQ/xI4pMbTKnH
	CCpKEKYlffRo49sMk8YaGUAbCNhDMYfKeIIo5/AY/Olnc31KP97DJuVywGZGYySCwQ0Z3hPnOc8
	5cFGe+p0waIZU5TO1fXpGWGMz39sXblu6KFhbQkx+sGEkPhkrPs1m91ORREjFQoECWgLs1n0u++
	Y9BEWHHCj5mTdHzTvFTYqE0Pl0q7vLhKJELaV89hRJvFZi5/w/LnUZCdBhcoSuQ4Kn/lPlv+2bd
	hKOT8gIUaaWe/+vj+c8mwjU7HtRui90ri2/TEThrKYufftFwFEH1MrW4z5tMEAtd6pw+M0h7biH
	OZsJB8STvizKSL1p/rPbs6vnHYkOVeQV6NLzbLYOwsoR7tQzkxeJ23AL7BMN+8C15JWN1HRH2QY
	sJBeUFi//wybmKbhpJfFMVjS7KSYmR+Gt4dQz3VjoaXRgTFzF8msDHkDr+BqO4XRGcJd5U6Tnt9
	3hFzv5igFJAYZEFsCMFSWEwwWxZ+nX/KALpQJCXRBQXQRE+v7vJ9KGU2fDzoBx8QIsymwgVh3ox
	Ecgv09LvOt1YcGUP/bmt2PDWysgTSoWIEODhSRZ++mD8U3Q3+I+4asu2iZiWLpfrjBCsFvDev8G
	wLGDSbhPfdZSPHaV9ZJhOGT3x
X-Received: by 2002:a17:90b:6c3:b0:3ac:8897:7b88 with SMTP id 98e67ed59e1d1-3adeaf9c9c2mr4546336a91.58.1792983879002;
        Sun, 25 Oct 2026 20:04:39 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f09csm6662538a91.7.2026.10.25.20.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 50/81] bpf: Add may_goto to the loops that the verifier marks
Date: Mon, 26 Oct 2026 02:59:11 +0000
Message-ID: <20261026025943.404450-51-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

"bpf: Verify programs as a fixpoint over the control flow graph" verifies a
loop with one state that covers all iterations. This shows that each
iteration is safe. It does not show that the loop ends. Thus the kernel
must stop such a loop at run time.

may_goto is the insn for that: after 250 ms it jumps to its target. The
verifier adds may_goto to each loop that it cannot count. It adds nothing
when each iteration already executes may_goto or bpf_iter_*_next().

The jump of the added may_goto is a new edge in the prog. It must pass the
verifier like each other edge. One target for all loops is not possible:

  do {                                  lock();
          p = lookup();                 do { ... } while (...);
  } while (!p);                         unlock();
  x = *p;

  It cannot exit from the loop:         It cannot exit from the prog:
  p is NULL after the loop.             only the code after the loop
                                        unlocks.

Thus the verifier selects the target for each added may_goto:

          Does the frame hold a lock or a reference
          that it did not hold at its entry?
                | no                       | yes
                v                          v
       exit from the subprog        exit from the loop

  may_goto is in                              exit from the subprog
  ------------------------------------------  ---------------------------
  the main prog                               r0 = 0; exit
  a subprog, unwind_goto follows each call    r0 = 0; unwind_exit
  of it
  all other subprogs, thus all subprogs in C  not possible: exit from the
                                              loop

'call f; unwind_goto pad' continues at pad, the cleanup code of the caller,
when f leaves with unwind_exit. Thus the callers release what they hold.
The verifier rejects a prog in which the selected edge is not safe.

The main pass selects and verifies the edge, and records it in
insn_aux_data. bpf_insert_loop_guards() adds the insns after the main pass.
No code sets loop_guard in this patch, thus no prog changes.

  short form             long form

  may_goto target        may_goto +1
  insn                   goto +N            the usual path: skip N insns
                         rX = 0, ...
                         goto target        or: exit
                         insn

'r0 = 0; exit' goes after the last insn of the subprog, one time for all
its added may_goto. The long form has one more jump in each iteration. It
has two causes:
 - may_goto has a 16-bit offset. A may_goto that is more than 4096 insns
   before the end of the subprog gets its own 'r0 = 0; exit'.
 - The usual place of may_goto is before a conditional jump that exits the
   loop, with the same target. When no such jump is in each iteration,
   may_goto is at the loop head and its edge skips the body. Then the code
   after the loop can read registers and stack slots that have no value at
   the loop head. The long form sets them to 0.

Progs without such a loop get the same code. An added may_goto costs the
same as a may_goto of the prog. On x86-64 (Zen 5):

  each iteration, tight loop  7 insns            +0.17 .. +0.24 nsec
  once in 65535 iterations    read of the clock  150 nsec
  each run                    2 stores, 16 bytes of stack in each frame
  may_goto in a subprog       4 insns in each run, 16 bytes per cpu,
                              5 insns at the entry and 7 at the exit of
                              each call

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  13 +++
 kernel/bpf/fixups.c          | 216 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   3 +
 3 files changed, 232 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f0f054f98dc1..31b1fa866e49 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -807,6 +807,11 @@ struct bpf_insn_aux_data {
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 bb_end:1; /* last instruction of a basic block */
+	u64 loop_guard:1; /* may_goto is added in front of this instruction */
+	u64 guard_place:1; /* it's the place for may_goto if the loop needs one */
+	u64 guard_at_header:1; /* there is no better place than the head of the loop */
+	u64 guard_unwind:1; /* the subprog unwinds when may_goto is out of budget */
+	u64 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
@@ -870,6 +875,11 @@ struct bpf_insn_aux_data {
 	 * For a loop header, identifies the parent loop instead.
 	 */
 	s32 loop_header;
+	/* where may_goto in front of this instruction goes */
+	s32 guard_to;
+	/* registers and stack slots that are set to 0 on the way: read there, not written here */
+	u16 guard_zero;
+	u64 guard_zero_slots;
 	/* additional information about the loop if this instruction is a loop header */
 	struct bpf_loop *loop;
 };
@@ -1010,6 +1020,8 @@ struct bpf_subprog_info {
 	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
 	 */
 	bool stack_args_from_code: 1;
+	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
+	bool bail_unwinds: 1;
 	u8 code_stack_args:4;
 	u8 arg_slot_cnt:4;
 
@@ -1450,6 +1462,7 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 		    bool widen);
 void bpf_join_free(struct bpf_verifier_env *env);
 
+int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 int bpf_insert_unwound_reports(struct bpf_verifier_env *env);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6a591c954c31..937274c164e8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -393,6 +393,222 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
 	return 0;
 }
 
+static bool jumps_to_itself(const struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	return (class == BPF_JMP || class == BPF_JMP32) && op != BPF_CALL && op != BPF_EXIT &&
+	       insn->code != (BPF_JMP32 | BPF_JA) && insn->off == -1;
+}
+
+/* How a subprog leaves when it is out of budget, see push_budget_exit() */
+static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+{
+	if (!sub->bail_unwinds)
+		return BPF_EXIT_INSN();
+	sub->can_unwind = true;
+	env->prog->jit_required = 1;
+	return BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0);
+}
+
+/*
+ * may_goto has 16 bits for the offset, and what is between it and its target is going
+ * to grow: may_goto itself becomes 7 insns.
+ */
+#define BPF_GUARD_NEAR	4096
+
+static bool guard_leaves_subprog(const struct bpf_insn_aux_data *aux)
+{
+	return aux->loop_guard && !aux->guard_no_unwind;
+}
+
+/*
+ * 'r0 = 0; exit' behind the last insn of the subprog, for all its guards that are near.
+ * Returns the number of insns that were added.
+ */
+static int append_budget_exit(struct bpf_verifier_env *env, int s)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	int last = (sub + 1)->start - 1, n = 0, i;
+	struct bpf_prog *new_prog;
+	struct bpf_insn buf[4];
+
+	for (i = max_t(int, sub->start, last + 1 - BPF_GUARD_NEAR); i <= last; i++)
+		if (guard_leaves_subprog(&env->insn_aux_data[i]))
+			break;
+	if (i > last)
+		return 0;
+
+	buf[n++] = env->prog->insnsi[last];
+	buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	if (bpf_ret_reg_pair(env, s))
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+	buf[n++] = budget_exit_insn(env, sub);
+	new_prog = bpf_patch_insn_data(env, last, buf, n);
+	if (!new_prog)
+		return -ENOMEM;
+	env->prog = new_prog;
+	/* the original insn is the first one of the patch, not the last one */
+	swap(env->insn_aux_data[last], env->insn_aux_data[last + n - 1]);
+	for (i = last + 1; i < last + n; i++)
+		env->insn_aux_data[i].seen = 1;
+	return n - 1;
+}
+
+/*
+ * Add may_goto in front of the insns that the main pass marked, see
+ * check_loop_guard(). It verified the edge from the insn to where may_goto goes.
+ */
+int bpf_insert_loop_guards(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int len = env->prog->len, i, r, s, to, n, jmp, delta = 0, err = 0;
+	struct bpf_insn *patch;
+	struct bpf_prog *new_prog;
+	u32 *before;
+	int *target, *leave, *moved;
+	u16 *zero;
+	u64 *slots;
+	s64 off;
+
+	for (i = 0; i < len; i++)
+		if (aux[i].loop_guard)
+			break;
+	if (i == len)
+		return 0;
+
+	/*
+	 * Where the subprog has 'r0 = 0; exit', 0 if it has none. And how far that moved
+	 * the subprog: guard_to is from the time before.
+	 */
+	leave = kvcalloc(2 * env->subprog_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	if (!leave)
+		return -ENOMEM;
+	moved = leave + env->subprog_cnt;
+	for (s = env->subprog_cnt - 1; s >= 0; s--) {
+		leave[s] = append_budget_exit(env, s);
+		if (leave[s] < 0) {
+			err = leave[s];
+			kvfree(leave);
+			return err;
+		}
+	}
+	for (s = 0, n = 0; s < env->subprog_cnt; s++) {
+		moved[s] = n;
+		n += leave[s];
+		if (leave[s])
+			leave[s] = env->subprog_info[s + 1].start - leave[s];
+	}
+	aux = env->insn_aux_data;
+	len = env->prog->len;
+
+	/* the number of insns added in front of the insn, where the guard of the insn goes */
+	before = kvcalloc(len + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	target = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	zero = kvcalloc(len, sizeof(u16), GFP_KERNEL_ACCOUNT);
+	slots = kvcalloc(len, sizeof(u64), GFP_KERNEL_ACCOUNT);
+	patch = kvcalloc(80, sizeof(*patch), GFP_KERNEL_ACCOUNT);
+	if (!before || !target || !zero || !slots || !patch) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < len; i++) {
+		s = bpf_find_containing_subprog(env, i) - env->subprog_info;
+		target[i] = aux[i].loop_guard ? aux[i].guard_to + moved[s] : -1;
+		zero[i] = aux[i].loop_guard ? aux[i].guard_zero : 0;
+		slots[i] = aux[i].loop_guard ? aux[i].guard_zero_slots : 0;
+		if (guard_leaves_subprog(&aux[i])) {
+			/* see push_budget_exit() */
+			slots[i] = 0;
+			if (leave[s] && leave[s] - i <= BPF_GUARD_NEAR) {
+				target[i] = leave[s];
+				zero[i] = 0;
+			} else {
+				target[i] = -2;
+				zero[i] = BIT(BPF_REG_0);
+				if (bpf_ret_reg_pair(env, s))
+					zero[i] |= BIT(BPF_REG_2);
+			}
+		}
+		before[i + 1] = before[i];
+		if (aux[i].loop_guard)
+			before[i + 1] += zero[i] || slots[i] ?
+					 3 + hweight16(zero[i]) + hweight64(slots[i]) : 1;
+	}
+
+	for (i = 0; i < len; i++) {
+		to = target[i];
+		if (to == -1)
+			continue;
+		/*
+		 *	may_goto to		or	may_goto +1
+		 *	insn				goto +N
+		 *					rX = 0, ...
+		 *					goto to, or exit
+		 *					insn
+		 */
+		n = 0;
+		if (zero[i] || slots[i]) {
+			patch[n++] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0);
+			patch[n++] = BPF_JMP_A(hweight16(zero[i]) + hweight64(slots[i]) + 1);
+			for (r = BPF_REG_0; r < BPF_REG_FP; r++)
+				if (zero[i] & BIT(r))
+					patch[n++] = BPF_MOV64_IMM(r, 0);
+			for (r = 0; r < 64; r++)
+				if (slots[i] & BIT_ULL(r))
+					patch[n++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+								-(r + 1) * BPF_REG_SIZE, 0);
+		}
+		jmp = n++;
+		/*
+		 * What is behind moves with this patch and is adjusted by
+		 * the patches to come. What is in front is where it is going to be.
+		 */
+		if (to == -2)
+			off = 0;
+		else if (to > i)
+			off = to - i + n - jmp - 1;
+		else
+			off = (s64)to + before[to] - (i + delta + jmp) - 1;
+		if (!zero[i] && !slots[i] && (off > S16_MAX || off < S16_MIN)) {
+			verbose(env, "exit of the loop is too far from insn %d for may_goto\n", i);
+			err = -ERANGE;
+			break;
+		}
+		patch[jmp] = zero[i] || slots[i] ? BPF_JMP32_A(off) :
+			     BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0);
+		if (to == -2)
+			patch[jmp] = budget_exit_insn(env, bpf_find_containing_subprog(env,
+										      i + delta));
+		patch[n] = env->prog->insnsi[i + delta];
+		/* A jump to itself is a back edge. It goes through may_goto like the others. */
+		if (jumps_to_itself(&patch[n]))
+			patch[n].off -= n;
+		else
+			err = bpf_adj_moved_insn(&patch[n], n);
+		if (err) {
+			verbose(env, "insn %d cannot be patched due to 16-bit range\n", i);
+			break;
+		}
+		n++;
+		new_prog = bpf_patch_insn_data(env, i + delta, patch, n);
+		if (!new_prog) {
+			err = -ENOMEM;
+			break;
+		}
+		env->prog = new_prog;
+		delta += n - 1;
+	}
+out:
+	kvfree(leave);
+	kvfree(before);
+	kvfree(target);
+	kvfree(zero);
+	kvfree(slots);
+	kvfree(patch);
+	return err;
+}
+
 /*
  * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
  * jump offset by 'delta'.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 32b256bc1513..c3fac4586c92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24393,6 +24393,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0 && env->callx_edges)
 		ret = sort_subprogs_topo(env);
 
+	if (ret == 0)
+		ret = bpf_insert_loop_guards(env);
+
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
 
-- 
2.55.0

