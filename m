Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374153;
	b=EU3Y/MNfdZjLRHvKX+W0U3pKwEPBwYNGySgLMHg8DQzXqgKuhSF8WuMzu5oybgLeyj7v
	 wnaea7zEIBwhjIJ0NVsOwgasZCrtIABz6AxbudHKASaPm754Zt/b3Qvrav3rFWlb9Rnik
	 dgGnmJrrTKgmp15vtMek20VN36XDfEQ5njULxkXniTjOp+ogBebiGR6Q5ptJmS8DPRRWk
	 OazJA+/7IvLzjY7ykRrj9pwFmN+rdJxlQAyvYqq1QzpCX1um5KZ3/X5ACnz0nelBqd1F2
	 M6uGIWXp3QxHZAJ2U9Bj04nKRUTqa9cSf22EZhbU8s9/wF1y68mfpLatuhh5aeso7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3d3EAdWNfrk9hvjoYFgzLoD3Elbkunkuey1uxS+vU/8=;
	b=U11lkRl0e2NAe9k3qNUV/MXgGMDjGy0vOEyl647XwDX5/+pU6p83PA0FvixFdbyUFSB8
	 rJcfjPT0zgxy/r5LJDmZxh6F/p3bg90tSqbFymKOmnsJXSXmjMP92Ltdq/tLqVEwz4693
	 xCmZJaAxpEAJBMpbQEZDeO5MV1a+o5pGVikBI6Zf7h7yEss5sARXB5T3mEpDvZADuVreK
	 nuewZfysQevFuusGNY3p1Ufhzqy46l/tMPq7yd4OY4T/2UAJiel67w68ymzUpuGpqhYnb
	 lmnZR6UQx+grz2oky1H2FDJiLnjMKue8XUHPWTMk7lqIucqv2+z5QUlNDaXJq/4FBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SNxcXWE3;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F5606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD3F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SNxcXWE3
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso1326236a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374152; x=1794978952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3d3EAdWNfrk9hvjoYFgzLoD3Elbkunkuey1uxS+vU/8=;
        b=SNxcXWE3ldVaMzOiAJo7/8NW0h6iQSM5UMUZ7xWZgysDhQmQ3R/25tyCztFuecFcAc
         JVAw2aBRv1V3h12psxRsS8rPJgreuE++8LgzxeHrmSIQ+fzbptQQi0lFG5cl2IGiiB3k
         XKodqVEBpd2kk0iRiPXRjL1JXWJd48frnVrKldu4RoxWCo8qQv1oTLHJ433lBlzPuliW
         lkmCmkrr1gnvJei+DiD92wur0D7PCA5o06sZ8UD4+g52x2G86lK0zlrF8QY2EyXjQTyY
         Qv8N/e2UPPacLvFQrBpmg5dXUzCXBtN/f1J8em4t0AdS0UbMxDvlfr3ojS3v46Y7ZTfq
         YPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374152; x=1794978952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3d3EAdWNfrk9hvjoYFgzLoD3Elbkunkuey1uxS+vU/8=;
        b=mWsXrTzihp/Rj5Af4ntymqlPtZo/nK7DjsV2u7psxw1/TJ18hnOk8rQRQYKySaco6W
         woOdV4PtDvNFt9mqorIjaY/MKQI4E0KnbmXOr4tz6snmDmzaLcqvnBxtMQOFJlvaoo09
         mZtenk6Md1qmoPhkX6w38O0ADcEZ+i/xyuN29ZYR+0dq9PtUMHPsxjXLrie5khkp2V4t
         X32DE9Ip3tIqWJSL+2mWwtL576R7V/0HY2nntPxgMLAP2eKJeeX/RbWTc6qFr9dEGZFw
         tR3fd41Icd8vhwSnJpUyARuFmTOXnlfv9T9k8y+ac2tzjE4ly9qsSMinZa02G6WExaq3
         Sxfg==
X-Gm-Message-State: APuU4Z9M227H/gRi/cV6FArv9xf6wLmP+wfrg3lkJAbDc+xM2WvFVz2y
	hhcZAY5vM3r53oZ62XyYAr5fXnfQvMHEPBNeAx5fWMIb5u0LjbSe+mgG4S43xg==
X-Gm-Gg: AYBFou18RqugtfEFmOsEZSnNSa/Cgha5LJVrXcj0nD5ywrw1UY7l/EJq2yYi7kkoeJK
	HwLQAW/I8hGtBJ7gOI/qYwfsV7Z+E4q5LETur7jp57eXeNghMXZ3z4JR8wbqfEEimUmcAGleZ6m
	cSxoBtHH0q/C0Z66uhEGeH4wtfOhLgmbRcTxoUsZzGWVNKzcF3sUuLihOjg4vVaaTDlx7BJ34wg
	4r4QCZi+xUC5ierFcR+2AfLrOq0p2+NVsHSAo8Yr9+6asgs3+JDuFOLpKn0n2Y693ZnKe5nx43W
	m6rJzH5MvI5Da2RFXwj9Lofbcjz6HG8Iaq9xGLI9p7W+Cu3y4AmYaXtjLtS01LvpDYqj9bj5sru
	mByM81Vwr605pe+wxvEaQP7YT3naMzZgAVQEc5S+L33hid++Xo1Wsj8cYA6B3T7eMMlRUQDKHrg
	Mpr0SmjtPLyxYH4nttsLNi4ouo1hzvx8SAo2BEhhXqYoMMBsbMvFF7AsPJflk7f7Iuf3nBxImjK
	FHH6aeYIc0irKHNI+YPFuk+xTnlNrKowMX8I0dWJXZFXGThCEf8tpCNM5s8tMny6SpoHTzu/JNR
	gVwItoB7DteOUCAwhbVuZdzKgkttr4OvD2mhL51cZ0avYmfyqfu9KwfNHFUQJHOa94paaCkp/6I
	R92P+d+eaIkGFEA83gW2sFPNFZDRIFNqkuu/v23qJCkXmyBy4yV7qPO3NpR0V+zw+5yI8sfufRv
	oq03A6Tl8q8lglN/aPXdMB
X-Received: by 2002:a17:90b:4b8c:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3b182f25969mr1045045a91.24.1794374151850;
        Tue, 10 Nov 2026 21:15:51 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db7df7csm2685999a91.11.2026.11.10.21.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 21/29] bpf: Compute scalar evolution expressions in irreducible loops
Date: Wed, 11 Nov 2026 05:13:32 +0000
Message-ID: <20261111051341.2800252-22-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. bpfj_proc_file_open of
bpfjailer loads before and after the patch. Today it loads because of
a scalar id, and scev.c has no replacement for that id in an irreducible
loop:

	for (int i = BPFJ_MAX_POD_PER_PID - 1; i >= 0; --i) {
		if (i >= num_pods) {
			continue;
		}
		struct bpfj_pod __arena* pod = actor->pods[i];

That is role_gate.h. i lives on the stack (clang, -mcpu=v4):

	171: r1 = *(u64 *)(r10 -40)
	172: if w1 > 0x7 goto pc-10
	173: r1 = *(u64 *)(r10 -40)
	174: r1 <<= 3

The loop is entered at 163 and at 171: 'loop at 171, irreducible' in the
level 2 log. compute_scev_for_loop() gives up on such a loop: nothing is
known at its header, its body is not analyzed. The linked registers of
a conditional jump are found while its loop is analyzed, so the jump at 172
has none. Only the scalar id that r1 and fp-40 share bounds what insn 173
fills.

scev.c has two layers. Expressions for registers and stack slots are value
numbering, which works on any CFG. Recurrences, latches and iteration
counts need a natural loop. So analyze the body of an irreducible loop like
any other body, with the same worklist, and keep the second layer off:
at the end the header env is set to unknown. For the enclosing loop and for
the main pass the loop clobbers everything.

Why that is correct:

- The worklist needs a topological order of the body, without backedges
  and with nested loops collapsed. Reverse post-order is one for every
  loop: compute_loops_in_subprog() makes the target of every retreating
  edge of its depth-first search a loop header, and
  bpf_compute_postorder() does the same search.

- (REG r) is the value of r at the header, and the header of an
  irreducible loop does not dominate the body: executions enter at
  a secondary entry. What they bring is not known here. So an insn
  of the loop whose immediate dominator is outside of the loop gets a phi
  for every live register and stack slot and tracks no memory, like
  the target of an edge that the verifier adds, see join_added_edges().

- An edge that the verifier adds goes where an exit of an outermost loop
  goes. In another loop that is the header or a secondary entry.

A natural loop nested in an irreducible one now has an env at loop entry,
for const_diff_at_header() and compute_header_adds(). A loop that nests
a loop with more than 256 exits is still not analyzed: the successors of
the nested loop are not known.

Tests: a link within a basic block, across basic blocks, at the header of
a nested natural loop. Each has a negative test that makes the link before
the secondary entry.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 50 +++++++++++--------
 .../selftests/bpf/progs/verifier_scev.c       | 35 +++++++++++++
 2 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 28fd06c16fe4..d95b8d26dc51 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1938,7 +1938,7 @@ static int join_successor(struct bpf_verifier_env *env, int cur_header, int succ
 {
 	bool log_level2 = env->log.level & BPF_LOG_LEVEL2;
 	struct scev *scev = env->scev;
-	int err, nested_header;
+	int err, nested_header, idom;
 	struct env *succ_env;
 
 	/*
@@ -1966,6 +1966,18 @@ static int join_successor(struct bpf_verifier_env *env, int cur_header, int succ
 	succ_env = get_loop_env(scev, cur_header, succ_idx);
 	if (!succ_env)
 		return -ENOMEM;
+	/*
+	 * The header of an irreducible loop does not dominate its body. An insn whose immediate
+	 * dominator is outside of the loop is reached from a secondary entry, without the header.
+	 * The env at the source of an entering edge is not known: all '?', like a new env. So the
+	 * insn is a join point with a phi for every live register, see join_added_edges().
+	 */
+	idom = env->idoms[succ_idx];
+	if (cur_header >= 0 && succ_idx != cur_header &&
+	    env->insn_aux_data[cur_header].loop->irreducible &&
+	    bpf_loop_at_index(env, idom) != cur_header &&
+	    topmost_nested_loop(env, idom, cur_header) < 0)
+		succ_env->empty = false;
 	if (log_level2)
 		memcpy(old_env, succ_env, sizeof(*old_env));
 	err = join(env, succ_env, cur_env, succ_idx);
@@ -1980,7 +1992,7 @@ static int join_successor(struct bpf_verifier_env *env, int cur_header, int succ
 }
 
 /*
- * Unsupported loops get only an unknown header environment.
+ * Recurrences need a natural loop. Unsupported loops get an unknown header environment.
  * A nested loop is processed as a single instruction, its exits are the successors: all of
  * them are needed. No result for the loop itself depends on the list of its own exits:
  * mark_latches() prepares them for the loop around, and compute_max_iters() asks if there is
@@ -2371,6 +2383,10 @@ bool bpf_scev_mem_addr(struct bpf_verifier_env *env, int insn_idx, u32 regno, u3
  * @cur_header and @first are a loop header. Or -1 and the first insn of a subprog: the subprog is
  * the outermost loop, which runs once. (REG r) is the entry value of r, the loops in it are single
  * instructions.
+ * Value numbering works on any CFG: the body of an irreducible loop is walked like any other. Every
+ * retreating edge of the depth-first search goes to a loop header, see compute_loops_in_subprog(),
+ * and bpf_compute_postorder() does the same search. So reverse post-order is a topological order of
+ * this body too.
  */
 static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, int first)
 {
@@ -2395,21 +2411,6 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, i
 	if (!cur_loop && !can_compute_subprog_scev(env, sub))
 		return 0;
 
-	/*
-	 * For irreducible loops, and for loops nesting a loop with a truncated
-	 * exit list, just assume that everything is clobbered for now.
-	 */
-	if (cur_loop && !can_compute_loop_scev(cur_loop)) {
-		header_env = get_loop_env(scev, cur_header, cur_header);
-		if (!header_env)
-			return -ENOMEM;
-		/* The freshly allocated environment has all expressions unknown. */
-		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
-		bitmap_fill(cur_loop->tested_regs, REGS_NUM);
-		header_env->empty = false;
-		return 0;
-	}
-
 	cur_env = kzalloc(sizeof(*cur_env), GFP_KERNEL_ACCOUNT);
 	if (!cur_env)
 		goto nomem;
@@ -2422,9 +2423,12 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, i
 	if (!header_env)
 		goto nomem;
 	setup_initial_loop_env(header_env);
-	err = worklist_push(env, cur_header, first);
-	if (err)
-		goto out;
+	/* The successors of a nested loop with a truncated exit list are not known: no walk */
+	if (!cur_loop || !cur_loop->nested_exits_overflow) {
+		err = worklist_push(env, cur_header, first);
+		if (err)
+			goto out;
+	}
 	if (!cur_loop) {
 		/* no backedge overwrites it */
 		header_env->empty = false;
@@ -2527,6 +2531,12 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, i
 			free_loop_env(scev, cur_header, start);
 	}
 
+	/* For the enclosing loop and for the main pass it clobbers everything */
+	if (cur_loop && !can_compute_loop_scev(cur_loop)) {
+		memset(header_env, 0, sizeof(*header_env));
+		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
+		bitmap_fill(cur_loop->tested_regs, REGS_NUM);
+	}
 	err = 0;
 out:
 	kfree(cur_env);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 0f737ca6bd07..9b1877a1b5e5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3574,6 +3574,41 @@ LINKED(linked_at_loop_header, VALID,
 LINKED(linked_at_loop_entry_only, __failure,
 	LOOP_HEADER("r3 = r8; r2 = r8; r2 += 1; r2 += 1;", "r2 += 2; r3 += 1;"))
 
+/*
+ * An irreducible loop: 'l' is the header, 'm' is a secondary entry. A link that is made in the loop
+ * holds in the next basic blocks too. Not after 'm' if it is made before 'm': every edge of the
+ * loop to 'm' has it, the edge that enters the loop there does not. That edge can come from
+ * a natural loop 'o' around the irreducible one.
+ * In the last two tests 'o' is the header. The natural loop in it has an env at loop entry. Its
+ * header can be the secondary entry.
+ */
+LINKED(irreducible_loop, VALID,
+	"if r7 > 5 goto m_%=; l_%=: r7 += 1;"
+	"m_%=: r2 = r8; r2 += 1; r2 += 1; if r8 > 61 goto out_%=; r1 = r6; r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0); if r7 < 10 goto l_%=;")
+LINKED(irreducible_loop_fallthrough_pred, UNBOUND,
+	"r2 = r7; if r7 > 5 goto m_%=; l_%=: r7 += 1; r2 = r8;"
+	"m_%=: if r8 > 63 goto out_%=; r1 = r6; r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0); if r7 < 10 goto l_%=;")
+LINKED(irreducible_loop_next_bb, VALID,
+	"if r7 > 5 goto m_%=; l_%=: r7 += 1;"
+	"m_%=: r2 = r8; r2 += 1; r2 += 1; if r7 == 3 goto n_%=; r3 = 0;"
+	"n_%=: if r8 > 61 goto out_%=; r1 = r6; r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0); if r7 < 10 goto l_%=;")
+LINKED(irreducible_loop_secondary_entry, UNBOUND,
+	"r9 = 0; o_%=: r9 += 1; call %[bpf_ktime_get_ns]; r8 = r0; r2 = r7; if r7 > 5 goto m_%=;"
+	"l_%=: r7 += 1; r2 = r8; r2 += 1; r2 += 1; if r7 == 3 goto m_%=; r3 = 0;"
+	"m_%=: if r8 > 61 goto out_%=; r1 = r6; r1 += r2;"
+	"r0 = *(u8 *)(r1 + 0); if r7 < 10 goto l_%=; if r9 < 3 goto o_%=;")
+LINKED(natural_loop_in_irreducible_loop, VALID,
+	"if r7 > 5 goto m_%=; o_%=: r7 += 1; m_%=:"
+	LOOP_HEADER("r3 = r8; r2 = r8; r2 += 1; r2 += 1;", "r2 += 1; r3 += 1;")
+	"if r7 < 10 goto o_%=;")
+LINKED(natural_loop_is_secondary_entry, MAP_OOB,
+	"r3 = r8; r2 = r7; if r7 > 5 goto l_%=; o_%=: r7 += 1;"
+	LOOP_HEADER("r3 = r8; r2 = r8; r2 += 1; r2 += 1;", "r2 += 1; r3 += 1;")
+	"if r7 < 10 goto o_%=;")
+
 /*
  * No exit of the inner loop dominates its backedges: may_goto is added before its header. The prog
  * holds a reference, so may_goto goes to the exit of the outer loop: an edge that the verifier
-- 
2.55.0

