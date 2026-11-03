Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749447;
	b=153egskjE/+Qlrfqr69fi+ZHm6/1yi3sT7jykgsj1CgxU0zkucTGprLaoXTBKhd/+J4d
	 kkAtRrm237CciVZVNp2hsyggwwTJcPZiPgPrpR1skYU6xGmV6YrVxhN82us39208thayj
	 BWWkVXH+OQDyQBjxw7IB5Z+bRvLcM2SHAjrzCZiW8ejw4kGGlx6Pb6/nW+7Kdby77ZhsI
	 JOYFWeD1jGfnqILr0kxYsTzwm00yr/2wFNNSQWGRwfOebzxLAYmyipWMiM5Qf1hO252Vk
	 8ndL4q0SMGVHAYTv9J/hN5Vz3yPdi2F5K33Zij/rPZKkVPDonZdiZuFK1Ydrz1Th34w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYG4yjWcuwcRuYjvWLlJMt749t3NC/tOsckPFfRA6fo=;
	b=KbmwdgvXaVUX5pWRu/FgdDCGpQ7IbXvLZfNCF3gjAArv9jCe1/QeOpPG0FhXcElegr2x
	 ov4Mr0tH8AuB15xm4/oXM6DJCeodEx4ZnEO1lZwT7gJ0eyVpIl9JoqbyHPNfQ0KjO66os
	 63GFpAfWcZjC8y6eRFwSApa3Iy3mW2Sr+rOiBB7d/ExrU0E4CyJS/sHb7cLeyFNcDEtPZ
	 liP2GDNnL1fzqyLVbJf1CbkII+/Zse1b59w4FEHpGmozsIHaDZIya3tgb7stlU0quiFUW
	 md8biWflEjk2QbaTNbC2IFsh5uJ0ptKMbD1Se9B9W+6LscQJ5zHxkAq/x6/UO31N5kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPEAoWsg;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBF606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BBF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPEAoWsg
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so121907a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749446; x=1794354246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYG4yjWcuwcRuYjvWLlJMt749t3NC/tOsckPFfRA6fo=;
        b=SPEAoWsgAyqHH7Ikht1+1tjSnbxf7SaH493lMUCggLUJlTDrkakb8/6IW/Q+MGaqVP
         x9T9zPugmCOtRJiJYZ+MGXqFcYZ3Ad/oSICBYyNqk5EKexW51687J043nmU7w6fVBqho
         G7gmWabfPS0dik8+r3VR7QOeLW5CLfipXpfNfQlAGgfHnSzjVXKgTJxh7poP4vsPJQZl
         2W9OC5LuHniiKidJtwoqPqkndVmdPdFu1XTZghtTFCQA/KEmRmTtHBDm5zm8u8r4DZTB
         dBrDXTulaCheuh98w4DheUA9DNSg4S9PdmW93UnqDfKQTJZuZIrH3lBf60FX0bDQ2uLn
         nKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749446; x=1794354246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYG4yjWcuwcRuYjvWLlJMt749t3NC/tOsckPFfRA6fo=;
        b=06TQBh5SkfgY0tyOVZJo9SwQX3Bm90SO8VSPjRoPoNn52jpprforyNRirqDgNsZd+0
         j7slgRvPJrD20fbq3eeWue5lF8coYkN+5o8juwl1YTUnkDClPxlF6rEoll0HfI7Idt9g
         j6htlVgRJ3YwxP38L5AQOUxZJdfC/ybFb1TsjGXSftw0yjY0xxILogv/p2NAzJdOBSqW
         CD/u+0HIVmu02/HOeagC6MRlC8x2XS1hpJVKQq8kAuCM8eDZvTlxnAVXTwwOrX95bHaQ
         p0sT8dNeAu1qINYOlQD0U6W00H2sUEpRQwobIWCSChfUrQ7XtNXgsTSaMkfwhzE6kJZN
         86DQ==
X-Gm-Message-State: APuU4Z9PR+3JWEM77Ho6Ko+BNEuNrULYJyBGMM3cAHqW4wTC2SZ16uN8
	kolctgyp7BacioBABRjLHM7dklcAaMqvnQkmOjG+SuT5TSU7kGN356JNBPmxiA==
X-Gm-Gg: AYBFou3pzI+DA4/CH30RlRjHAvkvXFe5HFKNvlhQeBEJx3NcUHHhM7JPXf/GSW57pbI
	/jznW5KLvL8qmX772eL2KVpOxOeLt9VHo66it5H0PnGp6yeVKMlUkCg3mLxgRlqOaf1Q77Ty6Qd
	HwRVGmoRw8FDKrqBAIpykO7HsqkfT/YFWhYh/dzC+/x5a8bi/8cYLmNzoCEIb1OkeMqWZgpZCbT
	ZckCX9d+sR+Xkao2/thk1ysdz+y9BuhZPYw9sNYJhC3FDG1oWUpIbxUNZtmHYI9esmwe2L4Emta
	dzYCWOdW4nWtNxgN8xQ2zDAMxKe5DcqGnoXrRnHTr2Rgh0T0z7/5TtqaIUwqNzwFkhgSfilD1ii
	2IKYOtS/+PF2p7eoiMSpM6QCSrid6L7WS53KTuGdsR1XUcQYSsA25fLFAp1KzmHjqt252LCypmz
	kHNZnQPYAQlVGk53Fe5xpc8jO91a9QLcN4QNNMAISv2AsRCtD6/wbNaVkSwZ9L6lmQHCJr1G2Yz
	f5L5VfumoBu0YIiDAOZb0gem6NcGgQuZ9PhE17l2jSOJjmky/pe5WCUTn8mlGTX/TV9djq1CDBv
	7XjIT92U4zbGeBLTeGdsd/JdfF87AP68F+olYj8N7hIHxSke1tWgzL0DFD8tLyXc75KkFrf/8nF
	OLtAHfh7vqpjjFaaJ7u1zouHjuhI51RaO3mblj9n29yynZJqnynfg9IqAxtJvyAvUGsnb4QRf+g
	==
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id 98e67ed59e1d1-3ae8985d52dmr13113961a91.56.1793749445816;
        Tue, 03 Nov 2026 15:44:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46444698sm286908a12.4.2026.11.03.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 30/37] bpf: Count a loop whose latch tests a flag that a jump sets
Date: Tue,  3 Nov 2026 23:40:55 +0000
Message-ID: <20261103234104.208239-31-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A compiler makes a flag of 'while (n--)', 'for (i = n; i-- > 0;)' and
'for (i = n - 1; i >= 0; i--)' when the body of the loop is not small:

     w6 += 1
     w2 = 1
     if w6 == 0 goto l
     w2 = 0
  l: ...
     if w2 != 1 goto head

The jump that leaves the loop looks at 1 or 0. The jump that counts stays
in the loop on both edges, so scalar evolution does not ask it for a count.

bpf_edge_leaves_loop() follows an edge of a jump. It goes through the
constants that the insns next to the jump set, plain insns, calls, 'goto',
and jumps that compare such a constant with a constant. If that way leaves
the loop, the jump is a condition for the back edge like a jump that leaves
the loop itself.

 - There is one way to go from the edge, so no other path has to be
   examined.
 - What is set in front of the jump counts only as far back as nothing else
   leads to the insns in between.
 - A call keeps r6 - r9. r0 - r5 are not known after it.
 - latches[0] stays a jump that leaves the loop itself.

bpf_jump_leaves_loop() tells whether a jump leaves a loop itself.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/loops.c           | 99 +++++++++++++++++++++++++++++++++---
 kernel/bpf/scev.c            |  5 +-
 3 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9a0ed5610650..dfecdfac75ff 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -727,6 +727,7 @@ struct bpf_backedge {
 	 * Conditional jumps within the loop that dominate 'from' and have
 	 * a successor outside the loop, nearest first. latches[0] is the
 	 * latch; the remaining entries are additional exit conditions.
+	 * One of them may leave the loop by way of a flag, see bpf_edge_leaves_loop().
 	 * Each usable condition tells iterations in which the back edge is
 	 * not taken, so keeping only a subset is sound.
 	 */
@@ -1504,6 +1505,8 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
+bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index e584549bd208..cc15712f70d4 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -304,28 +304,95 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
 	return aux[idx].loop ? idx : aux[idx].loop_header;
 }
 
+/* @known: the registers that hold the constant @val behind @insn. False: a jump or the like. */
+static bool track_consts(const struct bpf_insn *insn, u16 *known, s32 *val)
+{
+	u8 class = BPF_CLASS(insn->code);
+
+	if (class == BPF_ST || (class == BPF_STX && BPF_MODE(insn->code) == BPF_MEM))
+		return true;
+	/* r6 - r9 are what they were when the call returns */
+	if (insn->code == (BPF_JMP | BPF_CALL)) {
+		*known &= ~GENMASK(BPF_REG_5, BPF_REG_0);
+		return true;
+	}
+	if (class != BPF_ALU && class != BPF_ALU64 && class != BPF_LDX)
+		return false;
+	*known &= ~BIT(insn->dst_reg);
+	if (class != BPF_LDX && BPF_OP(insn->code) == BPF_MOV && BPF_SRC(insn->code) == BPF_K) {
+		*known |= BIT(insn->dst_reg);
+		val[insn->dst_reg] = insn->imm;
+	}
+	return true;
+}
+
+/*
+ * Does the program leave the loop at @h when the conditional jump at @n goes on at @t?
+ * It does when @t is not in the loop. A compiler also makes
+ *	w2 = 1; if w1 == 0 goto l; w2 = 0; l: ...; if w2 != 1 goto head;
+ * of 'while (n--)'. So follow the constants that are set next to the jump for as long as there
+ * is one way to go.
+ */
+bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *insn;
+	s32 val[MAX_BPF_REG];
+	u16 known = 0;
+	int i, l;
+	u8 op;
+
+	/* the insns in front of the jump, for as long as nothing else leads to the next one */
+	for (i = n; i && i > n - 4 && !env->insn_aux_data[i].loop && env->idoms[i] == i - 1; i--)
+		;
+	for (; i < n; i++)
+		if (!track_consts(&insns[i], &known, val))
+			known = 0;
+	for (i = 0; i < 16; i++, t++) {
+		l = bpf_loop_at_index(env, t);
+		if (l != h && !bpf_is_nested_loop(env, l, h))
+			return true;
+		insn = &insns[t];
+		op = BPF_OP(insn->code);
+		if (t == h) {
+			return false;
+		} else if (insn->code == (BPF_JMP | BPF_JA)) {
+			t += insn->off;
+		} else if (is_cond_jmp_insn(insn)) {
+			/* a 32-bit and a 64-bit jump agree on a number that is not negative */
+			if (!(known & BIT(insn->dst_reg)) || val[insn->dst_reg] < 0 ||
+			    BPF_SRC(insn->code) != BPF_K || (op != BPF_JEQ && op != BPF_JNE))
+				return false;
+			if ((val[insn->dst_reg] == insn->imm) == (op == BPF_JEQ))
+				t += insn->off;
+		} else if (!track_consts(insn, &known, val)) {
+			return false;
+		}
+	}
+	return false;
+}
+
 /*
- * Collect conditional jumps within n's loop that dominate 'n' and have
- * a successor outside the loop, nearest first.
+ * Collect conditional jumps within n's loop that dominate 'n' and leave
+ * the loop on one edge, see bpf_edge_leaves_loop(), nearest first.
  */
 static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
 				       struct bpf_backedge *backedge)
 {
 	struct bpf_insn *insns = env->prog->insnsi;
 	bool t_exits_loop, f_exits_loop;
-	int n_loop, t_loop, f_loop;
 	int *idoms = env->idoms;
+	int n_loop;
 
 	n_loop = bpf_loop_at_index(env, n);
 	if (idoms_intersect(env, n, n_loop) != n_loop)
 		return;
 	while (n >= 0) {
 		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) == n_loop) {
-			t_loop = bpf_loop_at_index(env, n + insns[n].off + 1);
-			f_loop = bpf_loop_at_index(env, n + 1);
-			t_exits_loop = t_loop != n_loop && !bpf_is_nested_loop(env, t_loop, n_loop);
-			f_exits_loop = f_loop != n_loop && !bpf_is_nested_loop(env, f_loop, n_loop);
-			if (t_exits_loop || f_exits_loop) {
+			t_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + insns[n].off + 1);
+			f_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + 1);
+			/* latches[0] is the latch: it has to leave the loop itself */
+			if ((t_exits_loop || f_exits_loop) &&
+			    (backedge->latches_cnt || bpf_jump_leaves_loop(env, n_loop, n))) {
 				if (backedge->latches_cnt == MAX_LATCHES)
 					return;
 				backedge->latches[backedge->latches_cnt++] = n;
@@ -457,6 +524,22 @@ bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int oute
 	return false;
 }
 
+/* Whether the conditional jump at @n, in the loop @h or in a loop nested in it, leaves @h */
+bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[n];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	int t, f;
+
+	if ((class != BPF_JMP && class != BPF_JMP32) || op == BPF_JA || op == BPF_CALL ||
+	    op == BPF_EXIT || op == BPF_JCOND)
+		return false;
+	t = bpf_loop_at_index(env, n + insn->off + 1);
+	f = bpf_loop_at_index(env, n + 1);
+	return (t != h && !bpf_is_nested_loop(env, t, h)) ||
+	       (f != h && !bpf_is_nested_loop(env, f, h));
+}
+
 int bpf_compute_loops(struct bpf_verifier_env *env)
 {
 	int i, j, k, s, t, iloop, sloop, err = 0, len = env->prog->len;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 70d15449eebe..a5fd080a3bc0 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2025,7 +2025,6 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	struct bpf_insn *insn = &env->prog->insnsi[latch_idx];
 	struct scev *scev = env->scev;
 	struct env *latch_env;
-	u32 true_branch_loop;
 	u32 true_branch_tgt;
 	u32 src_reg_scev;
 	u32 dst_reg_scev;
@@ -2036,9 +2035,7 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	latch->jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	/* Flip the condition if true branch jumps out of the loop. */
 	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
-	true_branch_loop = bpf_loop_at_index(env, true_branch_tgt);
-	if (true_branch_loop != header &&
-	    !bpf_is_nested_loop(env, true_branch_loop, header))
+	if (bpf_edge_leaves_loop(env, header, latch_idx, true_branch_tgt))
 		op = bpf_rev_opcode(op);
 	switch (op) {
 	case BPF_JSLT:
-- 
2.55.0

