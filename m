Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937187;
	b=Oq5NnX82FdnEDu8YnPBw5wwMMUfZ+syvg/qs7nW0dBMZkVqh4F4FNFaIrF1lpFaEti7W
	 snk61nlAQcQHAoIR7NfGn0ELOitYbN4Owtp4WBhQd/XtTFcdowLWr99j6Lq42QpS0J5ay
	 Y3O/Wg8Oa1bLHjaniWv15n8dHZKR732pF+aGynaPj1mExMWhDTupE7h/ZRuVRn0FiI6Xp
	 vuHF60wDe6f1+5YspedLbxtJdbwDVV7WMcFX2jTomVVkiLMxtikjVVoPgk8cz4ME18/k0
	 j9fdk9ytdxut1cdEAwuGUKgp4MexW/pYuERHvBjIDkWHIkENzPaj4pQKRfCKi0eUQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cpwerJG8bYDjFrOnze3PLekD7t+rYmplrcs5jnZp8l8=;
	b=ipM+2LRJPkTbL+HQmfQB7cBOl1NGj+IFJSinfzVzYZHTAt9W/A2jc0hHxX2rDuUor+qF
	 Zs0K6W/R+MkIm0qbeF+sA18mp8cpC9vJRIuqbA6SLFkZsAXh7VxkP9nY/93I+V8zHv1QK
	 2vky5CbspFs1YqQfRWg4hsCw/LrKxPhG4KrDdNZwVL6FvMOSuJbxzJRU+ezC6c0ZPekYu
	 nXYkkhZRaSiVLC2aZEMD/rh1K2AKeRecWzv1dwoFcoPNY3gQqs/pS8clNR13cVMx+Krk6
	 vaEb8DaS+eb0+5gpxdxGfLDXyAOmmiJx3nIgrMloeIIo2fEG5Blfsuj9TpWf9KzuA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9KM8ynF;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AAA606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25AAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9KM8ynF
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso183149a91.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937185; x=1794541985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpwerJG8bYDjFrOnze3PLekD7t+rYmplrcs5jnZp8l8=;
        b=b9KM8ynFWyQnLduTHmLrw43dBSalhRKVHcSIOTstIFM2uDo1QO246+QRYFaIp6NJoy
         Ugme6c89Ua5QEawvYTHZgTkuaG1dP3rJvQvMrwSfmD2YAx2xGd+VTajbBkUOsFuMPl5E
         HJPlDJZr0XU7marhOQdDXRCQJc3YIRF4Zew8LM3Yq5A6hzCDo03bF/szzenaqjFaVXrI
         gNPFCsaQDfZeAxL4E6ddQyH/Rudol2nqucMKc9hIei+aE/FSAwHcZhp6uszYKg8law2L
         sovoY0kRg+ODhteAm9N5nO8SlpgpLOOF6L1cSgUxfKCVS+jkWtM3QT/9VSGpaNJzh1Zy
         pI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937185; x=1794541985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cpwerJG8bYDjFrOnze3PLekD7t+rYmplrcs5jnZp8l8=;
        b=laEvK3Nbgy/YCf0gGhnXJ3CRNMi6LoSjcqWcJf94lA+MxbMGJKpmk6c1GbslDaw7z3
         1t7gMhXI1wec6HPLHYBpAG+IbtR1/NWPq4tPmfqL4i3VL6NXFMJcDk7oKbEU6jLZES6m
         iTNYeiTCgJ6fG5eXyDLR53bo2k1LWRID+MGtsFr9Enaq0Qo1ejPjr0EPu67qpuWWFR0i
         dxHonFkxJw1a8NTHR20+PWW//JgGrJFTV27WxJucKHVvBf4YWCX9wQfsPi2iheoZyrgj
         b6cXRFmjx0B4pBJg+er1S2zlqXgT17XmNFuw25n0KIyVRr2dmFhtI+KwFX2DrfiL1kp2
         RJ4Q==
X-Gm-Message-State: APuU4Z/ftd6Uq6QkkbxcR+2wcNx8FbxciYan1ALJxtXEinXL38IrYrC8
	mvsHou2ocglmbRgTwqOJbjBSehZbzeLlVPZ+6MN8oATg3OkIoyWfA+ZIuB6gVQ==
X-Gm-Gg: AYBFou2msQoFMcCwA8et2q+Wmp1eysQRjkif0gaCefK8P81wHAbI1TIgXbJB5jo24CU
	bNvET0Vi3R9tsLifbVXapVoWWBwXjQl+LLNfuFv0zm2DNXiT/LpGyS/uRTmRdaLXg3ETt+fiM4W
	1ykLm2xu4disAxBjLQUxIaXX96hud4KnZBnYlVNaAC/wiIhAqgvrA4IJvO2iT/Oqg5u/RhlsHsa
	p/jzKAWH9qPqRB8v5OC71XBH12yf65lvgm8icEds9Sz0p4EIKMUaKr6iqvuRgCTXs9YpTFOJT6V
	xIa80WUj1Oaz/E3MrfYqgt9QH3XfyUjRCqAWaZC3uo5lYVyQUhNFeMV06UbGmdnU37CaJfMcGNa
	d1ey8qT9YDwWzq+Qj8aqHuxwY7WPHwOza7itpg9Pqb2lB85vPDR7ULyb2KK0EecxeuDpngtW8Am
	c4el/jQtQu7AV15TQmFJctrmLTlSWMCHr9IPnVcNxJvr6TTL1iq0FASc1aMUMADOEkuE3MId25s
	7sy/EIo7JAgKk5xvMoN+UTJiYZScrVJWTFqy+QFctW8OjLTR0Y3t6Vy7H0AYFL7mgcjTvAk+NgJ
	erKBln92yTG2mg4s6GAeaKA4Oo+Du1Jy05aCyxs1VboPp3yI54b8fW8v4EUvl/bbuVw0CDRtpF5
	gUJlsIxTSPNQaZvVG0mCarUdJRxyFJVVxvtZMNr31P1+z0RpjeqvdBRhEUA3WKViuc4Giz8isJg
	==
X-Received: by 2002:a17:90b:1fcf:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3b0db6057aamr1229877a91.9.1793937184567;
        Thu, 05 Nov 2026 19:53:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7cb447esm1489076a91.17.2026.11.05.19.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:53:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 19/45] bpf: Verify programs as a fixpoint over the control flow graph
Date: Fri,  6 Nov 2026 03:50:43 +0000
Message-ID: <20261106035111.3315285-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  for i in 0..n { v.push(i * i); }
Test vec_push_pop of rust-bpf: "The sequence of 8193 jumps is too complex."
The verifier follows each path from the first insn to exit, and each branch
can double the number of paths. 123 tests of rust-bpf hit this limit or
1M insns. C progs are cut until they fit:
Cilium's bpf_xdp/tail_nodeport_nat_ingress_ipv6 took 182050 insns in May
2026, scx_eevdf/eevdf_dispatch takes 350041.

Do not follow paths. Where two paths meet, make one state that covers both,
a join: r1=1 and r1=5 give r1=[1,5]. What is safe for the join is safe for
both. Repeat until no state changes. The work depends on the size of the
prog, not on the number of paths: 1761, 7932 and 21209 insns with this
patch, and 120 of the 123 load. do_check() takes the next new state from
flow.c and checks one basic block. The check of an insn is the same.

What user space sees:
 - The limits of 1M processed insns and 8192 jumps are gone, from
   bpf_design_QA.rst too. flow.c limits states, for a prog of N insns:
     1024 at an insn      "more than 1024 states that cannot be joined"
     16 * N + 4096 at a time, 256 * N + 64K in all    "too many states"
 - "infinite loop detected" is gone: 111 of the 225 progs of the schedulers
   of rust-bpf. A fixpoint shows that each iteration is safe, not that the
   loop ends:
     counted, or walked to its end                      nothing is added
     each iteration has may_goto or bpf_iter_*_next()   nothing is added
     no exit                                            rejected
     all other loops                                    may_goto
 - An added may_goto is a new edge. check_loop_guard() verifies it. It goes
   to 'r0 = 0; exit': the probe loop of hashbrown exits only with a bucket,
   and the code after the loop uses it: "R6 invalid mem access 'scalar'".
   If the frame holds more than at its entry, or is a subprog that cannot
   unwind, may_goto goes to the exit of the loop: the prog releases there
   what it holds. While a walk can get to the end of its loop the edge is
   dropped. If it gives up, do_check_all() verifies the prog again.
 - A walk goes on while each iteration decides a jump that leaves the loop.
   A jump that is decided only because states are kept apart by a flag does
   not count: it repeats the jump that set the flag, which went both ways.
   lexical_numbers of rust-bpf: 42136 insns, 99506 if it counts.
 - Log level 2 shows basic blocks, not paths: "from 25 to 19: joined",
   "widened", or "within" for "safe". iter(19)=3 is a walk.
 - A join loses the relation between scalars. This is rejected now:
     if (c) { i = 3; n = 4; } else { i = 7; n = 8; }
     arr[n - i]                   i=[3,7] n=[4,8], thus n - i is [-3, 5]
 - 1 and 2 are joined at exit, and a test for 'r0 is 2 or 3' misses [1, 2].
   Thus a cgroup_skb prog whose r0 can be 2 or 3 attaches to egress only.
 - Static subprogs and recursion are as before. Pruning, jmp_history and
   precision marks are only disabled here.
   kfuncs.rst says 'compares and joins states' for 'state pruning checks'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/bpf_design_QA.rst |   7 +-
 Documentation/bpf/kfuncs.rst        |   2 +-
 include/linux/bpf_verifier.h        |  11 +
 kernel/bpf/backtrack.c              |   7 +
 kernel/bpf/const_fold.c             |   6 +
 kernel/bpf/flow.c                   |  21 +-
 kernel/bpf/log.c                    |   5 +
 kernel/bpf/states.c                 |  50 ++-
 kernel/bpf/verifier.c               | 625 ++++++++++++++++++++--------
 9 files changed, 533 insertions(+), 201 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 98d70b8a2533..f86b272920ae 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -92,11 +92,8 @@ Q: What are the verifier limits?
 A: The only limit known to the user space is BPF_MAXINSNS (4096).
 It's the maximum number of instructions that the unprivileged bpf
 program can have. The verifier has various internal limits.
-Like the maximum number of instructions that can be explored during
-program analysis. Currently, that limit is set to 1 million.
-Which essentially means that the largest program can consist
-of 1 million NOP instructions. There is a limit to the maximum number
-of subsequent branches, a limit to the number of nested bpf-to-bpf
+The largest program can consist of 1 million instructions.
+There is a limit to the number of nested bpf-to-bpf
 calls, a limit to the number of the verifier states per instruction,
 a limit to the number of maps used by the program.
 All these limits can be hit with a sufficiently complex program.
diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index ac9e3a175378..c7da603cab77 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -159,7 +159,7 @@ An example is given below::
 Here, bpf_obj_new uses local_type_id argument to find out the size of that type
 ID in program's BTF and return a sized pointer to it. Each type ID will have a
 distinct size, hence it is crucial to treat each such call as distinct when
-values don't match during verifier state pruning checks.
+values don't match when the verifier compares and joins states.
 
 Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e5bee65807fa..91ef4e0a1204 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -390,6 +390,11 @@ struct loop_stack_entry {
 	u32 probe:1;
 	/* this one did */
 	u32 decided:1;
+	/*
+	 * The state is kept apart from one with the other value of a flag, see
+	 * flow_join_makes_up(). The test of the flag is decided in both, and decides nothing.
+	 */
+	u32 flag_apart:1;
 	/*
 	 * How many times the state came back to the head of the loop. With @apart that is
 	 * the iteration that it is in. A state that stands for many iterations is a join, and has
@@ -1140,9 +1145,14 @@ struct bpf_subprog_info {
 	bool stack_args_from_code: 1;
 	/* it releases what its caller holds, so it's verified in the context of such caller */
 	bool releases_inherited: 1;
+	/* a call of it was verified on its own: its insns are not in insns_total of the caller */
+	bool on_its_own: 1;
 	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
 	bool bail_unwinds: 1;
+	/* some call of it is not followed by unwind_goto */
+	bool plain_call: 1;
 	u8 code_stack_args;
+	int bail_insn; /* an exit of it, for the main pass. -1 if there is none */
 	u16 stack_arg_cnt; /* incoming + max outgoing */
 	u16 max_out_stack_arg_cnt;
 };
@@ -1693,6 +1703,7 @@ void bpf_flow_loop_gets_guards(struct bpf_verifier_env *env, int h);
 void bpf_flow_new_round(struct bpf_verifier_env *env);
 int bpf_flow_place_guards(struct bpf_verifier_env *env);
 int bpf_flow_compute_kinds(struct bpf_verifier_env *env);
+u16 bpf_flow_flag_regs(struct bpf_verifier_env *env, int idx);
 bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r);
 /* verifier.c, for flow.c */
 int bpf_flow_loop_leave(struct bpf_verifier_env *env, bool *enters);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index a85ee6ee3776..a6e69c1f5ff6 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -16,6 +16,9 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
 
+	/* FLOW: nothing looks at the history */
+	return 0;
+
 	/* combine instruction flags if we already recorded this instruction */
 	if (env->cur_hist_ent) {
 		/* atomic instructions push insn_flags twice, for READ and
@@ -861,6 +864,10 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 	struct bpf_func_state *func;
 	bool tmp, skip_first = true;
 	struct bpf_stack_state *ss;
+
+	/* FLOW: there are no precision marks */
+	bt_reset(bt);
+	return 0;
 	struct bpf_reg_state *reg;
 	int i, fr, err;
 
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index bcaec1488fc9..7e088378c302 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -263,6 +263,12 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 
 		for (r = 0; r < MAX_BPF_REG; r++)
 			ci_in[start][r] = unknown;
+		/*
+		 * The subprog gets there from where it is out of budget too, see
+		 * push_budget_exit(). That is not an edge of the graph.
+		 */
+		for (r = 0; r < MAX_BPF_REG && env->subprog_info[i].bail_insn >= 0; r++)
+			ci_in[env->subprog_info[i].bail_insn][r] = unknown;
 	}
 	/* The same from the head of a loop to where the loop is left, once the loops are known. */
 	for (i = 0; i < insn_cnt; i++) {
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index c4a6384d34bc..62115e396635 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -570,7 +570,7 @@ static u16 flow_tested_regs(struct bpf_verifier_env *env, int idx)
 }
 
 /* A jump that compares a register with 0 or 1 */
-static u16 flow_flag_regs(struct bpf_verifier_env *env, int idx)
+u16 bpf_flow_flag_regs(struct bpf_verifier_env *env, int idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[idx];
 
@@ -1024,7 +1024,7 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 		if (jump)
 			gen[i] = flow_tested_regs(env, i);
 		else if (flag)
-			gen[i] = flow_flag_regs(env, i);
+			gen[i] = bpf_flow_flag_regs(env, i);
 		else if (kind == FLOW_NEED_STACK_OFF)
 			gen[i] = flow_stack_off_regs(env, i);
 		else if (kind == FLOW_NEED_PTR_OFF || kind == FLOW_NEED_VALUE_OFF)
@@ -2145,13 +2145,18 @@ static bool flow_gap(const struct bpf_reg_state *a, const struct bpf_reg_state *
  * with either, so none of the above keeps them apart. The join has ok = 1 with i >= 64. A flag is
  * made to send states different ways. So 0 and 1 are not joined where a jump that is not far
  * tells one from the other: FLOW_NEED_FLAG.
+ *	while (more) { ...; more = next(&x); }
+ * That jump can be the one that leaves a loop. It is decided in both states, one stays and one
+ * leaves. It's the jump that set the flag, which went both ways, once more: no sign that the
+ * loop gets anywhere. A walk on patience has to know, see mark_loop_exit_decided().
  *
  * The states go on to the jumps on their own. Behind the last one the numbers are dead, and what
  * is left is joined.
  */
-static bool flow_join_makes_up(const struct bpf_flow *flow, const struct bpf_verifier_state *a,
-			       const struct bpf_verifier_state *b)
+static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_state *a,
+			       struct bpf_verifier_state *b)
 {
+	struct bpf_func_state *fa = a->frame[a->curframe], *fb = b->frame[b->curframe];
 	const struct bpf_reg_state *ra, *rb;
 	const struct flow_need *tested = flow->need[FLOW_NEED_JUMP], *need;
 	u32 fr, i, id = 0;
@@ -2179,7 +2184,13 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, const struct bpf_ver
 			id = ra->id & ~BPF_ADD_CONST;
 		}
 	}
-	return flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b);
+	if (!flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b))
+		return false;
+	for (i = 0; i < fa->loop_stack_cnt; i++)
+		fa->loop_stack[i].flag_apart = fa->loop_stack[i].probe;
+	for (i = 0; i < fb->loop_stack_cnt; i++)
+		fb->loop_stack[i].flag_apart = fb->loop_stack[i].probe;
+	return true;
 }
 
 /*
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 916408c63355..e1c9b56cd13f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -802,6 +802,11 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		verbose(env, " cb");
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
+	/* the iterations of the loops in which they are kept apart */
+	for (i = 0; i < state->loop_stack_cnt; i++)
+		if (state->loop_stack[i].apart)
+			verbose(env, " iter(%d)=%u", state->loop_stack[i].loop_id,
+				state->loop_stack[i].trip);
 	if (state->loop_stack_cnt) {
 		verbose(env, " loop_stack=");
 		for (i = 0; i < state->loop_stack_cnt; i++)
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 9d3a86b5820e..4b2506f3e3e2 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -840,6 +840,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    old_reg->iter.btf != cur_reg->iter.btf ||
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
+			    old_reg->iter.loops != cur_reg->iter.loops ||
 			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
 			    !check_ids(old_reg->id, cur_reg->id, idmap))
 				return false;
@@ -872,16 +873,19 @@ static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *
 			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
 			   enum exact_level exact)
 {
-	int i, nslots;
+	int i, nslots, cur_cnt = cur->out_stack_arg_cnt;
 
-	nslots = max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
+	/* incoming arguments are not compared with outgoing ones, the other way is ruled out */
+	if (bpf_stack_args_are_incoming(cur) && !bpf_stack_args_are_incoming(old))
+		cur_cnt = 0;
+	nslots = max(old->out_stack_arg_cnt, cur_cnt);
 	for (i = 0; i < nslots; i++) {
 		struct bpf_reg_state *old_arg, *cur_arg;
 		struct bpf_reg_state not_init = { .type = NOT_INIT };
 
 		old_arg = i < old->out_stack_arg_cnt ?
 			  &old->stack_arg_regs[i] : &not_init;
-		cur_arg = i < cur->out_stack_arg_cnt ?
+		cur_arg = i < cur_cnt ?
 			  &cur->stack_arg_regs[i] : &not_init;
 		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
 			return false;
@@ -940,6 +944,23 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	return true;
 }
 
+/*
+ * In a loop that is walked without a count a state of an earlier iteration stands for a state of
+ * a later one, see flow_cycle_closed(). Never the other way round.
+ *
+ * In a loop that is counted and walked the state that gets to iteration max_header_count is
+ * dropped: there is no such iteration at run time. The number in a state is the number of
+ * iterations that the program has done, and only states with the same number are compared. They
+ * differ in what is counted anyway.
+ *
+ * The walk of a loop with two entries is meant to get to the end of the loop, like today's walk of
+ * all paths. A state that is within the state of the iteration before it is on its way there:
+ *	for (i = 7; i >= 0; i--) { if (i >= n) continue; ... }
+ * i is in 0..6, then in 0..5. So here too only states with the same number are compared.
+ *
+ * Where the iterations are not kept apart a state stands for many of them, and the number says
+ * nothing about what it describes.
+ */
 static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    struct bpf_func_state *cur)
 {
@@ -953,7 +974,13 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
 	for (i = 0; i < old->loop_stack_cnt; i++) {
 		if (old_stack[i].loop_id == cur_stack[i].loop_id &&
 		    old_stack[i].max_header_count == cur_stack[i].max_header_count &&
-		    old_stack[i].terminates == cur_stack[i].terminates)
+		    old_stack[i].terminates == cur_stack[i].terminates &&
+		    old_stack[i].guarded == cur_stack[i].guarded &&
+		    old_stack[i].counted == cur_stack[i].counted &&
+		    old_stack[i].apart == cur_stack[i].apart &&
+		    (!old_stack[i].apart ||
+		     (old_stack[i].probe ? old_stack[i].trip <= cur_stack[i].trip :
+					   old_stack[i].trip == cur_stack[i].trip)))
 			continue;
 		return false;
 	}
@@ -999,9 +1026,19 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
 		return false;
 
+	if (memcmp(&old->callback_ret_range, &cur->callback_ret_range,
+		   sizeof(old->callback_ret_range)))
+		return false;
+
 	if (old->in_rcu_callback_fn != cur->in_rcu_callback_fn)
 		return false;
 
+	/* what the frame did to what its callers hold is a part of what it tells them */
+	if (old->entry_refs != cur->entry_refs ||
+	    old->entry_rcu_locks != cur->entry_rcu_locks ||
+	    old->entry_preempt_locks != cur->entry_preempt_locks)
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
@@ -1047,10 +1084,13 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
+	if (old->callers_unknown != cur->callers_unknown)
+		return false;
+
 	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
-	if (old->unwound != cur->unwound)
+	if (old->unwound != cur->unwound || old->changed_pkt_data != cur->changed_pkt_data)
 		return false;
 
 	if (!refsafe(old, cur, &env->idmap_scratch))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5af42d2dcab9..4801e9ac0089 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,13 +194,14 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_state st;
 	int insn_idx;
 	int prev_insn_idx;
+	/* it goes there only if may_goto in front of prev_insn_idx does, see check_loop_guard() */
+	enum bpf_guard_edge guard_edge;
 	struct bpf_verifier_stack_elem *next;
 	/* length of verifier log at the time this state was pushed on stack */
 	u32 log_pos;
 	u64 diag_log_pos;
 };
 
-#define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
@@ -1038,6 +1039,16 @@ static bool in_rcu_cs(struct bpf_verifier_env *env);
 
 static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta);
 
+/* The number of loops that the frames of @st below @frameno are in */
+static u32 nr_loops_below(const struct bpf_verifier_state *st, u32 frameno)
+{
+	u32 fr, nr = 0;
+
+	for (fr = 0; fr < frameno; fr++)
+		nr += st->frame[fr]->loop_stack_cnt;
+	return nr;
+}
+
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 				 struct bpf_call_arg_meta *meta,
 				 struct bpf_reg_state *reg, int insn_idx,
@@ -1070,6 +1081,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		st->iter.btf = btf;
 		st->iter.btf_id = btf_id;
 		st->iter.state = BPF_ITER_STATE_ACTIVE;
+		st->iter.loops = nr_loops_below(env->cur_state, env->cur_state->curframe + 1);
 		st->iter.depth = 0;
 
 		for (j = 0; j < BPF_REG_SIZE; j++)
@@ -1605,9 +1617,14 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 
 static void release_reference_state(struct bpf_verifier_state *state, int idx)
 {
-	int last_idx;
+	int last_idx, fr;
 	size_t rem;
 
+	/* the frames that were entered with it don't hold it ever since */
+	for (fr = 0; fr <= state->curframe; fr++)
+		if (idx < state->frame[fr]->entry_refs)
+			state->frame[fr]->entry_refs--;
+
 	/* IRQ state requires the relative ordering of elements remaining the
 	 * same, since it relies on the refs array to behave as a stack, so that
 	 * it can detect out-of-order IRQ restore. Hence use memmove to shift
@@ -1622,6 +1639,20 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	return;
 }
 
+/* bpf_rcu_read_unlock() or bpf_preempt_enable() is done, see release_reference_state() */
+static void release_context_state(struct bpf_verifier_state *state)
+{
+	struct bpf_func_state *frame;
+	int fr;
+
+	for (fr = 0; fr <= state->curframe; fr++) {
+		frame = state->frame[fr];
+		frame->entry_rcu_locks = min(frame->entry_rcu_locks, state->active_rcu_locks);
+		frame->entry_preempt_locks = min(frame->entry_preempt_locks,
+						 state->active_preempt_locks);
+	}
+}
+
 static bool find_reference_state(struct bpf_verifier_state *state, int id)
 {
 	int i;
@@ -1789,7 +1820,10 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return err;
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
+	dst_state->callers_unknown = src->callers_unknown;
 	dst_state->unwound = src->unwound;
+	dst_state->flow_entry = src->flow_entry;
+	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
@@ -1918,11 +1952,6 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	if (err)
 		return ERR_PTR(-ENOMEM);
 	elem->st.speculative |= speculative;
-	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
-		verbose(env, "The sequence of %d jumps is too complex.\n",
-			env->stack_size);
-		return ERR_PTR(-E2BIG);
-	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
 		/* WARN_ON(branches > 2) technically makes sense here,
@@ -2601,12 +2630,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->diag_log_pos = bpf_diag_event_log_save(env);
 	env->head = elem;
 	env->stack_size++;
-	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
-		verbose(env,
-			"The sequence of %d jumps is too complex for async cb.\n",
-			env->stack_size);
-		return ERR_PTR(-E2BIG);
-	}
 	/* Unlike push_stack() do not bpf_copy_verifier_state().
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
@@ -3459,7 +3482,17 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
 	bool seen = false;
 	int i;
 
+	for (i = 0; i < env->subprog_cnt; i++)
+		env->subprog_info[i].bail_insn = -1;
+
 	for (i = 0; i < env->prog->len; i++, insn++) {
+		if (bpf_is_ldimm64(insn)) {
+			i++;
+			insn++;
+			continue;
+		}
+		if (insn->code == (BPF_JMP | BPF_EXIT))
+			bpf_find_containing_subprog(env, i)->bail_insn = i;
 		if (bpf_is_unwind_exit(insn)) {
 			bpf_find_containing_subprog(env, i)->can_unwind = true;
 			seen = true;
@@ -4626,6 +4659,23 @@ static int check_stack_write(struct bpf_verifier_env *env,
 	return err;
 }
 
+/*
+ * The function that is verified on its own has no caller to look at. Its incoming
+ * arguments are in its stack_arg_regs until it is done with loading them.
+ */
+static void end_stack_arg_loads(struct bpf_verifier_env *env, struct bpf_func_state *state)
+{
+	int i;
+
+	if (state->no_stack_arg_load)
+		return;
+	state->no_stack_arg_load = true;
+	if (state->frameno)
+		return;
+	for (i = 0; i < state->out_stack_arg_cnt; i++)
+		bpf_mark_reg_not_init(env, &state->stack_arg_regs[i]);
+}
+
 /*
  * Write a value to the outgoing stack arg area.
  * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
@@ -4651,6 +4701,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		return -EINVAL;
 	}
 
+	end_stack_arg_loads(env, state);
 	err = grow_stack_arg_slots(env, state, spi + 1);
 	if (err)
 		return err;
@@ -4670,7 +4721,6 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
 	bpf_diag_mod_end(env);
-	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
 				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
 }
@@ -4699,7 +4749,7 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 		return -EACCES;
 	}
 
-	caller = vstate->frame[vstate->curframe - 1];
+	caller = vstate->frame[vstate->curframe ? vstate->curframe - 1 : 0];
 	arg = bpf_get_spilled_stack_arg(spi, caller);
 	if (!arg) {
 		verbose(env, "invalid read from uninitialized stack arg off %d\n", off);
@@ -9068,6 +9118,38 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
 	return &bpf_stack_slot(cur_st->frame[iter_frameno], iter_spi)->spilled_ptr;
 }
 
+/*
+ * bpf_iter_*_next() that every trip of a loop goes through stops the loop if the iterator is
+ * older than the loop: every trip takes an element, and there are only so many. It doesn't stop
+ * - the loop that makes the iterator, which starts from the beginning in every trip then:
+ *	while (v->x) { bpf_for(i, 0, 10) ...; }
+ *   Of the loops that the program is in, the ones that it entered before it made the iterator
+ *   are among the first iter.loops.
+ * - any loop if nothing was left already: the program was told so and did not leave.
+ * A loop with a known number of trips doesn't count on the iterator. Nor does a walk on patience:
+ * there is none in a loop that is taken for bounded, see flow_try_walk().
+ */
+static void iter_stops_loops(struct bpf_verifier_env *env, int insn_idx,
+			     const struct bpf_reg_state *iter)
+{
+	const struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_func_state *frame = st->frame[st->curframe];
+	u32 below = nr_loops_below(st, st->curframe);
+	struct loop_stack_entry *entry;
+	bool stops;
+	int i;
+
+	/* the loops of this subprog: flow_is_bound() doesn't look into the functions it calls */
+	for (i = frame->loop_stack_cnt - 1; i >= 0; i--) {
+		entry = &frame->loop_stack[i];
+		stops = iter->iter.state != BPF_ITER_STATE_DRAINED && below + i >= iter->iter.loops;
+		if (entry->terminates || stops)
+			continue;
+		bpf_flow_next_is_no_bound(env, insn_idx, entry->loop_id);
+		return;
+	}
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -9149,7 +9231,7 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 				  struct bpf_call_arg_meta *meta)
 {
-	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
+	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
 
@@ -9164,20 +9246,9 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		return -EFAULT;
 	}
 
+	iter_stops_loops(env, insn_idx, cur_iter);
+
 	if (cur_iter->iter.state == BPF_ITER_STATE_ACTIVE) {
-		/* Because iter_next() call is a checkpoint is_state_visitied()
-		 * should guarantee parent state with same call sites and insn_idx.
-		 */
-		if (!cur_st->parent || cur_st->parent->insn_idx != insn_idx ||
-		    !same_callsites(cur_st->parent, cur_st)) {
-			verifier_bug(env, "bad parent state for iter next call");
-			return -EFAULT;
-		}
-		/* Note cur_st->parent in the call below, it is necessary to skip
-		 * checkpoint created for cur_st by is_state_visited()
-		 * right at this instruction.
-		 */
-		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
 		if (IS_ERR(queued_st))
@@ -9186,8 +9257,6 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
-		if (prev_st)
-			widen_imprecise_scalars(env, prev_st, queued_st);
 
 		queued_fr = queued_st->frame[queued_st->curframe];
 		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
@@ -11514,6 +11583,9 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			callsite,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
+	callee->entry_refs = state->acquired_refs;
+	callee->entry_rcu_locks = state->active_rcu_locks;
+	callee->entry_preempt_locks = state->active_preempt_locks;
 	err = set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
@@ -11748,6 +11820,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return 0;
 }
 
+enum {
+	PROCESS_BPF_EXIT = 1,
+	INSN_IDX_UPDATED = 2,
+};
 
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state, bool exception_exit);
@@ -11890,9 +11966,9 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 }
 
 /*
- * Call of a static subprog. The callee is verified in the context of
- * the caller, hence set up a new frame and continue from the first
- * instruction of the callee.
+ * Call of a static subprog. Unless the callee is verified on its own it is
+ * verified in the context of the caller, hence set up a new frame and
+ * continue from the first instruction of the callee.
  */
 static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 				  int *insn_idx)
@@ -11921,7 +11997,7 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 				    callee_info->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS));
 	if (stack_arg_cnt > caller_info->stack_arg_cnt)
 		caller_info->stack_arg_cnt = stack_arg_cnt;
-
+	/* btf_check_subprog_call() doesn't get to it when BTF is not reliable */
 	err = check_outgoing_stack_args(env, caller, MAX_BPF_FUNC_REG_ARGS + callee_incoming,
 					bpf_subprog_name(env, subprog), NULL, NULL);
 	if (err)
@@ -12439,7 +12515,15 @@ static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
 static void account_processed_insn(struct bpf_verifier_env *env)
 {
+	struct bpf_verifier_state *st = env->cur_state;
 	struct bpf_func_state *frame = cur_func(env);
+	u32 fr, i;
+
+	/* every walk on patience that the state is in pays for the insn */
+	for (fr = 0; fr <= st->curframe; fr++)
+		for (i = 0; i < st->frame[fr]->loop_stack_cnt; i++)
+			if (bpf_loop_walk_may_give_up(&st->frame[fr]->loop_stack[i]))
+				env->walk_insns[st->frame[fr]->loop_stack[i].walk_id]++;
 
 	env->insn_processed++;
 	frame->insns_subtotal++;
@@ -12533,7 +12617,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 
 	caller = state->frame[state->curframe - 1];
-	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx])) {
+	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]) || state->unwound) {
 		/* the helper or the kfunc that called it doesn't expect that */
 		if (callee->in_callback_fn) {
 			verbose(env, "callback cannot unwind\n");
@@ -12552,6 +12636,16 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return -EACCES;
 		}
 
+		/* It's called any number of times: what it takes it has to release. */
+		for (i = callee->entry_refs; i < state->acquired_refs; i++) {
+			if (state->refs[i].type != REF_TYPE_PTR)
+				continue;
+			verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
+				state->refs[i].id, state->refs[i].insn_idx);
+			bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, *insn_idx);
+			return -EINVAL;
+		}
+
 		/* we are going to rely on register's precise value */
 		err = mark_chain_precision(env, BPF_REG_0);
 		if (err)
@@ -16129,6 +16223,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 		env->cur_state->active_rcu_locks--;
+		release_context_state(env->cur_state);
 		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU, false,
 					env->cur_state->active_rcu_locks);
 		if (!in_rcu_cs(env))
@@ -16146,6 +16241,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
+		release_context_state(env->cur_state);
 		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_PREEMPT, false,
 					env->cur_state->active_preempt_locks);
 		if (!in_rcu_cs(env))
@@ -19563,6 +19659,25 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 	}
 }
 
+/* It's known which way the jump at env->insn_idx goes */
+static void mark_loop_exit_decided(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *frame = st->frame[st->curframe];
+	bool flag = bpf_flow_flag_regs(env, env->insn_idx);
+	struct loop_stack_entry *entry;
+	u32 i;
+
+	for (i = 0; i < frame->loop_stack_cnt; i++) {
+		entry = &frame->loop_stack[i];
+		/* only because the states are kept apart. That holds for the first such jump. */
+		if (entry->flag_apart && flag)
+			entry->flag_apart = false;
+		else if (entry->apart && entry->probe &&
+			 bpf_jump_leaves_loop(env, entry->loop_id, env->insn_idx))
+			entry->decided = true;
+	}
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int *insn_idx)
 {
@@ -19675,6 +19790,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	env->true_reg1 = *dst_reg;
 	env->true_reg2 = *src_reg;
 	pred = is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
+	if (pred >= 0)
+		mark_loop_exit_decided(env, this_branch);
 	if (pred >= 0) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
@@ -20287,7 +20404,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	}
 
 	if (!tnum_is_unknown(enforce_attach_type_range) &&
-	    tnum_in(enforce_attach_type_range, reg->var_off))
+	    reg_smax(reg) > 1)
 		env->prog->enforce_expected_attach_type = 1;
 	return 0;
 }
@@ -20783,10 +20900,6 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 	return 0;
 }
 
-enum {
-	PROCESS_BPF_EXIT = 1,
-	INSN_IDX_UPDATED = 2,
-};
 
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state,
@@ -21102,7 +21215,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			}
 			mark_reg_scratched(env, BPF_REG_0);
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
-				cur_func(env)->no_stack_arg_load = true;
+				end_stack_arg_loads(env, cur_func(env));
 			if (bpf_is_callx(insn))
 				return check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_CALL)
@@ -21145,6 +21258,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return -EFAULT;
 }
 
+static int flow_try_walk(struct bpf_verifier_env *env, struct loop_stack_entry *entry);
+
 /*
  * Push the loop entered at insn_idx onto the stack. Usually this adds a single
  * entry on top of its enclosing loop. However, an edge may enter an inner loop
@@ -21159,7 +21274,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
  * Such a bypass makes the enclosing loop irreducible, so its header is missing
  * from the stack and both headers (1) and (2) need to be pushed onto stack.
  * Only the innermost loop (the one actually entered at insn_idx) carries SCEV bounds;
- * the bypassed ancestors are irreducible and pushed as non-terminating.
+ * the bypassed ancestors are irreducible: walked, see flow_try_walk(), or pushed as
+ * non-terminating.
  *
  * Assumes loop_stack_pop() has already truncated the stack to the common ancestor
  * of the bpf_loop_at_index(env->insn_idx) and whatever was at the top of the loop stack.
@@ -21172,7 +21288,7 @@ static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
 	u32 missing_headers[LOOP_STACK_SIZE];
 	u32 cnt = frame->loop_stack_cnt;
 	u32 num_missing = 0;
-	int h;
+	int h, err;
 
 	*pushed = false;
 
@@ -21196,7 +21312,25 @@ static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
 
 	for (; num_missing; num_missing--, cnt++) {
 		h = missing_headers[num_missing - 1];
-		loop_stack[cnt] = (struct loop_stack_entry){ .loop_id = h };
+		/* wherever it is entered: a loop can have more than one entry */
+		if (!aux[h].loop->exits_cnt) {
+			verbose(env, "loop at insn %d never exits\n", h);
+			return -EINVAL;
+		}
+		loop_stack[cnt] = (struct loop_stack_entry){
+			.loop_id = h,
+			.refs = env->cur_state->acquired_refs,
+		};
+		/* there is no count for a loop that is not entered at its head */
+		if (h != env->insn_idx && !aux[h].loop->rt_bounded) {
+			frame->loop_stack_cnt = cnt;
+			err = flow_try_walk(env, &loop_stack[cnt]);
+			if (err < 0)
+				return err;
+			if (!err)
+				bpf_flow_loop_gets_guards(env, h);
+		}
+		loop_stack[cnt].guarded = aux[h].loop->guarded;
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "entering loop %d\n", h);
 		*pushed = true;
@@ -21265,59 +21399,6 @@ static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
 	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry);
 }
 
-static int handle_loop_entry_exit(struct bpf_verifier_env *env)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-	struct bpf_func_state *frame = cur_func(env);
-	struct loop_stack_entry *entry;
-	struct bpf_loop_iters iters;
-	bool pushed, terminates;
-	int err;
-
-	err = loop_stack_pop(env);
-	if (err)
-		return err;
-
-	err = loop_stack_push(env, &pushed);
-	if (err)
-		return err;
-
-	if (frame->loop_stack_cnt == 0)
-		return 0;
-
-	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
-	if (env->insn_idx != entry->loop_id)
-		return 0;
-
-	/* If nothing was pushed and env->insn_idx is a loop header, we've taken a backedge. */
-	if (!pushed)
-		return maybe_clamp_scev_regs(env);
-
-	err = bpf_compute_loop_iters(env, env->cur_state, &iters);
-	if (err < 0)
-		return err;
-
-	terminates = err == 1;
-	if (!terminates)
-		return 0;
-
-	/* Create a loop_entry checkpoint before widening */
-	err = bpf_split_cur_state(env);
-	if (err)
-		return err;
-
-	entry->min_header_count = iters.min_header_count;
-	entry->max_header_count = iters.max_header_count;
-	entry->iv_reg = iters.iv_reg;
-	entry->iv_range = iters.iv_range;
-	entry->entry_state = cur->parent;
-	entry->terminates = true;
-	err = bpf_widen_scev_regs(env, cur, cur->parent, &iters);
-	if (err < 0)
-		return err;
-	return 0;
-}
-
 /*
  * The current state came back to the head of a loop. If it has a reference more than the states
  * that are there it is neither within one of them nor joined with one. It goes around again:
@@ -21515,6 +21596,7 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 		trip = entry->trip;
 		decided = !entry->probe || entry->decided || !trip;
 		entry->decided = false;
+		entry->flag_apart = false;
 		if (decided && ++entry->trip < entry->max_header_count &&
 		    (entry->counted ||
 		     env->walk_insns[entry->walk_id] <= entry->walk_patience))
@@ -21581,14 +21663,174 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 	return err < 0 ? err : 0;
 }
 
-static int do_check(struct bpf_verifier_env *env)
+/* Can the main program return 0? */
+static bool zero_is_valid_retval(struct bpf_verifier_env *env)
+{
+	struct bpf_retval_range range;
+
+	if (program_returns_void(env) || !return_retval_range(env, &range))
+		return true;
+	return range.minval <= 0 && range.maxval >= 0;
+}
+
+/*
+ * A loop or a recursion is out of budget in the current frame of @st. What the
+ * program computed so far is not what it was meant to compute, so it's better
+ * not to go on. The way to stop is to unwind: 'r0 = 0; unwind_exit'. The landing
+ * pads of the callers are code like any other. They release what the callers
+ * hold, or the program is rejected.
+ *
+ * False when it cannot:
+ * - There is no landing pad for what this frame took itself.
+ * - There is a call of the subprog that unwind_goto doesn't follow. That is every
+ *   program that is compiled without unwinding.
+ * - A helper that calls a callback doesn't expect it to unwind.
+ * Then the program goes on along a path that it has, like after may_goto of
+ * its own. It releases what it holds there.
+ */
+static bool budget_can_unwind(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	const struct bpf_subprog_info *sub = &env->subprog_info[frame->subprogno];
+	bool top;
+
+	if (sub->bail_insn < 0)
+		return false;
+	if (st->acquired_refs != frame->entry_refs ||
+	    st->active_rcu_locks != frame->entry_rcu_locks ||
+	    st->active_preempt_locks != frame->entry_preempt_locks)
+		return false;
+	if (frame->in_callback_fn || frame->in_exception_callback_fn)
+		return false;
+	/* the kernel called it: either exit ends it */
+	top = !st->curframe && !st->callers_unknown &&
+	      (!frame->subprogno || frame->in_async_callback_fn);
+	if (top && !frame->subprogno && !zero_is_valid_retval(env))
+		return false;
+	return top || sub->bail_unwinds;
+}
+
+/*
+ * The current frame leaves with 0 in place of the result: with unwind_exit if the subprog
+ * can do that, with exit otherwise. The insns are added when the main pass is over. Until
+ * then an exit that the subprog has stands for them.
+ */
+static int push_budget_exit(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
+	struct bpf_verifier_state *branch;
+	struct bpf_reg_state *regs;
+
+	branch = push_stack(env, sub->bail_insn, env->insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+	branch->unwound = sub->bail_unwinds;
+	regs = branch->frame[branch->curframe]->regs;
+	__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+	if (bpf_ret_reg_pair(env, cur_func(env)->subprogno))
+		__mark_reg_const_zero(env, &regs[BPF_REG_2]);
+	return 0;
+}
+
+/*
+ * The loop that is not counted and has nothing that stops it at run time gets
+ * may_goto in front of this insn. When it is out of budget the program goes
+ * where may_goto goes with the registers and the stack as they are here.
+ * Every state that goes through the loop does, see bpf_flow_loop_gets_guards().
+ */
+static int check_loop_guard(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+	struct bpf_verifier_state *branch;
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+	struct bpf_loop *loop;
+	int h, err;
+
+	h = bpf_loop_at_index(env, env->insn_idx);
+	/* The callback came back to the helper that calls it: the program is not in front of it. */
+	if (h < 0 || !frame->loop_stack_cnt || frame->callback_depth)
+		return 0;
+	loop = env->insn_aux_data[h].loop;
+	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	if (loop->rt_bounded || !env->insn_aux_data[env->insn_idx].guard_place ||
+	    entry->loop_id != h)
+		return 0;
+	if (verifier_bug_if(!entry->terminates && !entry->guarded, env,
+			    "nothing stops the loop at %d", h))
+		return -EFAULT;
+	if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
+		return 0;
+
+	/* the device runs the insns that the driver was given, without may_goto */
+	if (bpf_prog_is_offloaded(env->prog->aux)) {
+		verbose(env, "loop at insn %d has no known bound in an offloaded program\n", h);
+		return -EINVAL;
+	}
+
+	/*
+	 * A guard has one way out, and only that one is looked at.
+	 *
+	 * Leave the subprog, if that is possible every time the program gets here:
+	 *	do { p = lookup(); } while (!p); *p
+	 * The code that follows the loop counts on what the jump that leaves it has found out.
+	 *
+	 * Otherwise leave the loop:
+	 *	lock(); do { ... } while (...); unlock();
+	 * The code that follows the loop releases what is held.
+	 *
+	 * It's the same way for all states that get here. As long as they leave the subprog
+	 * what would leave the loop is dropped. Both are dropped as long as the loop has
+	 * no may_goto: the state is in a walk that may get to the end of the loop.
+	 */
+	if (!aux->guard_no_unwind && !budget_can_unwind(env, env->cur_state)) {
+		aux->guard_no_unwind = true;
+		/* What would leave the loop from the states that were here is gone. All again. */
+		if (aux->guard_edge_dropped && loop->guarded)
+			env->guards_late = true;
+	}
+	if (!aux->guard_no_unwind) {
+		err = push_budget_exit(env);
+		if (err)
+			return err;
+		env->head->guard_edge = BPF_GUARD_LEAVES_SUBPROG;
+	}
+
+	branch = push_stack(env, env->insn_aux_data[env->insn_idx].guard_to, env->insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+	env->head->guard_edge = BPF_GUARD_LEAVES_LOOP;
+	return 0;
+}
+
+/* The states that the insn pushed go where they were pushed to. */
+static int flow_drain(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_stack_elem *elem;
+	int err = 0;
+
+	while ((elem = env->head)) {
+		env->head = elem->next;
+		env->stack_size--;
+		if (!err && elem->guard_edge)
+			err = bpf_flow_guard_edge(env, &elem->st, elem->insn_idx,
+						  elem->prev_insn_idx, elem->guard_edge);
+		else if (!err)
+			err = bpf_flow_deliver(env, &elem->st, elem->insn_idx,
+					       elem->prev_insn_idx);
+		bpf_free_verifier_state(&elem->st, false);
+		kfree(elem);
+	}
+	return err;
+}
+
+/* Process the current state until it gets to the start of a basic block. */
+static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 {
-	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	bool do_print_state = false;
-	int prev_insn_idx = -1;
+	bool do_print_state = true;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -21601,9 +21843,6 @@ static int do_check(struct bpf_verifier_env *env)
 		if (need_resched())
 			cond_resched();
 
-		/* reset current history entry on each new instruction */
-		env->cur_hist_ent = NULL;
-
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -21616,18 +21855,10 @@ static int do_check(struct bpf_verifier_env *env)
 
 		account_processed_insn(env);
 
-		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
-			verbose(env,
-				"BPF program is too large. Processed %d insn\n",
-				env->insn_processed);
-			return -E2BIG;
-		}
-
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
 		/*
-		 * Record the incoming edge so active and queued paths use the same
-		 * branch-recording path. A zero-offset conditional has identical
+		 * Record the incoming edge. A zero-offset conditional has identical
 		 * successors, so its outcome cannot be reconstructed from the edge.
 		 */
 		if (!state->speculative && prev_insn_idx >= 0 && prev_insn_idx < insn_cnt) {
@@ -21647,40 +21878,6 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 		}
 
-		/*
-		 * Possibly widen the registers before creating a checkpoint
-		 * in bpf_is_state_visited(). The next loop iteration will
-		 * have a chance to hit this checkpoint and converge.
-		 */
-		err = handle_loop_entry_exit(env);
-		if (err)
-			return err;
-
-		if (bpf_is_prune_point(env, env->insn_idx)) {
-			err = bpf_is_state_visited(env, env->insn_idx);
-			if (err < 0)
-				return err;
-			if (err == 1) {
-				/* found equivalent state, can prune the search */
-				if (env->log.level & BPF_LOG_LEVEL) {
-					if (do_print_state)
-						verbose(env, "\nfrom %d to %d%s: safe\n",
-							env->prev_insn_idx, env->insn_idx,
-							env->cur_state->speculative ?
-							" (speculative execution)" : "");
-					else
-						verbose(env, "%d: safe\n", env->insn_idx);
-				}
-				goto process_bpf_exit;
-			}
-		}
-
-		if (bpf_is_jmp_point(env, env->insn_idx)) {
-			err = bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
-			if (err)
-				return err;
-		}
-
 		if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
 			verbose(env, "\nfrom %d to %d%s:",
 				env->prev_insn_idx, env->insn_idx,
@@ -21690,13 +21887,6 @@ static int do_check(struct bpf_verifier_env *env)
 			do_print_state = false;
 		}
 
-		if (bpf_loop_at_index(env, env->insn_idx) >= 0 &&
-		    cur_func(env)->loop_stack_cnt == 0) {
-			verifier_bug(env, "loop stack empty at %d, while inside the loop %d\n",
-				     env->insn_idx, bpf_loop_at_index(env, env->insn_idx));
-			return -EFAULT;
-		}
-
 		if (env->log.level & BPF_LOG_LEVEL) {
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
@@ -21747,6 +21937,10 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
+		err = check_loop_guard(env);
+		if (err)
+			return err;
+
 		err = do_check_insn(env, &do_print_state);
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
@@ -21768,19 +21962,9 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (state->speculative && insn_aux->nospec_result) {
-			/* If we are on a path that performed a jump-op, this
-			 * may skip a nospec patched-in after the jump. This can
-			 * currently never happen because nospec_result is only
-			 * used for the write-ops
-			 * `*(size*)(dst_reg+off)=src_reg|imm32` and helper
-			 * calls. These must never skip the following insn
-			 * (i.e., bpf_insn_successors()'s opcode_info.can_jump
-			 * is false). Still, add a warning to document this in
-			 * case nospec_result is used elsewhere in the future.
-			 *
-			 * All non-branch instructions have a single
-			 * fall-through edge. For these, nospec_result should
-			 * already work.
+			/*
+			 * All non-branch instructions have a single fall-through
+			 * edge. For these, nospec_result should already work.
 			 */
 			if (verifier_bug_if((BPF_CLASS(insn->code) == BPF_JMP ||
 					     BPF_CLASS(insn->code) == BPF_JMP32) &&
@@ -21790,23 +21974,40 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 			account_current_path(env);
 			mark_verifier_state_scratched(env);
-			err = bpf_update_branch_counts(env, env->cur_state);
-			if (err)
-				return err;
-			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
-					pop_log);
-			if (err < 0) {
-				if (err != -ENOENT)
-					return err;
-				break;
-			} else {
-				do_print_state = true;
-				continue;
-			}
+			bpf_free_verifier_state(state, false);
+			memset(state, 0, sizeof(*state));
+			return flow_drain(env);
+		}
+
+		err = flow_drain(env);
+		if (err)
+			return err;
+
+		if (env->insn_idx < insn_cnt && bpf_flow_is_point(env, env->insn_idx)) {
+			account_current_path(env);
+			mark_verifier_state_scratched(env);
+			return bpf_flow_deliver(env, state, env->insn_idx, prev_insn_idx);
 		}
 	}
+}
 
-	return 0;
+static int do_check(struct bpf_verifier_env *env)
+{
+	int prev_insn_idx = -1;
+	int err;
+
+	err = bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1);
+	while (!err) {
+		err = bpf_flow_next(env, &prev_insn_idx);
+		if (err == -ENOENT)
+			return 0;
+		if (err)
+			break;
+		/* What is known about how the state came to be is not kept with it. */
+		bpf_diag_event_log_restore(env, 0);
+		err = do_check_block(env, prev_insn_idx);
+	}
+	return err;
 }
 
 static int find_btf_percpu_datasec(struct btf *btf)
@@ -22902,6 +23103,7 @@ static void free_states(struct bpf_verifier_env *env)
 	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 	while (!pop_stack(env, NULL, NULL, false));
+	bpf_flow_reset(env);
 
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -22957,6 +23159,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	state->speculative = false;
 	state->branches = 1;
 	state->in_sleepable = context == BPF_FUNC_CTX_SLEEPABLE;
+	/* nobody knows what the callers of a global function or of an extension hold */
+	state->callers_unknown = subprog || env->prog->type == BPF_PROG_TYPE_EXT;
 	env->no_rcu_read_lock = context == BPF_FUNC_CTX_NO_RCU_LOCK;
 	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
@@ -23063,7 +23267,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 		 * it's matching expected signature, and otherwise mark BTF
 		 * info for main program as unreliable
 		 */
-		if (env->prog->aux->func_info_aux) {
+		if (env->prog->aux->func_info_aux && !env->prog->aux->func_info_aux[0].unreliable) {
 			ret = btf_prepare_func_args(env, 0);
 			if (ret || sub->arg_slot_cnt != 1 ||
 			    sub->args[0].arg_type != ARG_PTR_TO_CTX) {
@@ -23196,6 +23400,44 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
+/*
+ * What stops a loop is assumed before the main pass and checked in it, see flow_is_bound(). The
+ * main prog and global functions may get to the same loop. It has may_goto for all of them or
+ * for none, so all are done again when the assumption doesn't hold, whatever came out.
+ * The same when a loop gets may_goto, or its may_goto gets another way out, and what went through
+ * the loop before is not there any more, see bpf_flow_loop_gets_guards().
+ *
+ * A round that is dropped counts as paths that never run. What it found out about the insns, the
+ * subprogs and the prog stays. Each of these is made for more than one state that gets to an insn:
+ * it grows to the safe side, or another value is refused, or the last one that gets there sets it.
+ * Where the round got to is dropped with its verdict: the passes that follow take an insn that was
+ * seen for one that passed its checks, and a function that is called has to be safe.
+ */
+static int do_check_all(struct bpf_verifier_env *env)
+{
+	struct bpf_func_info_aux *sub_aux;
+	u64 log_pos = env->log.end_pos;
+	int i, ret;
+
+	for (;;) {
+		bpf_flow_new_round(env);
+		ret = do_check_main(env);
+		ret = ret ?: do_check_subprogs(env);
+		if (!(env->restart && bpf_flow_loops_lost_bound(env)) && !env->guards_late)
+			return ret;
+		/* the log is dropped when a function is found to be safe */
+		bpf_vlog_reset(&env->log, min(log_pos, env->log.end_pos));
+		for (i = 0; i < env->prog->len; i++)
+			env->insn_aux_data[i].seen = 0;
+		for (i = 1; env->prog->aux->func_info && i < env->subprog_cnt; i++) {
+			sub_aux = subprog_aux(env, i);
+			memset(sub_aux->called, 0, sizeof(sub_aux->called));
+			memset(sub_aux->verified, 0, sizeof(sub_aux->verified));
+			sub_aux->called_with_pkt_ptrs = false;
+		}
+	}
+}
+
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
@@ -25196,6 +25438,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = sort_subprogs_topo(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -25238,6 +25483,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_flow_compute_kinds(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	if (env->log.level & BPF_LOG_LEVEL2)
 		log_program(env);
 
@@ -25249,14 +25498,17 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_flow_prepare(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	bpf_free_subprog_jts(env);
 
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = do_check_main(env);
-	ret = ret ?: do_check_subprogs(env);
+	ret = do_check_all(env);
 
 	/* reject recursion through the callx edges found by the main pass */
 	if (ret == 0 && env->callx_edges)
@@ -25418,6 +25670,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_patch_list_free(env);
 	kvfree(env->fd_array);
 	bpf_free_scev(env);
+	kvfree(env->walk_insns);
+	bpf_flow_free(env);
+	bpf_join_free(env);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.postorder_nums);
 	kvfree(env->cfg.insn_postorder);
-- 
2.55.0

