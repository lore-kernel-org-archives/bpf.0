Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022882;
	b=NVjz/SaF3TVBzrzc7K9V+NLhUbijemp+mSy4h2CNjOPhm8sUotqkHQ08Gb9rm4ZJ2vkT
	 Q0VW0gKCbw81WmT1TZEBFkeviiXef8eVtB0SFdFGwchY848VKpTJTTEl31EcyuRqaGKGk
	 DuCxOwkFJ3hG/ozWyX3gcEimHgmWKeia4Q8oEUMr3yZMvS70QjQoKKwwra+XqzAVisRbC
	 Gnpcsc95ZU0vS9gqtiTAHAEBJ+bp7+2JHcrp1SUi80GS9zh4xmixgTiAkgKuu/MyxJoWz
	 IdThz4D7havhdsN/wNF6/zvAkpBcsb2kAbo4hK/1bDcST8VEvGVhy4IG4ilWOT0gJcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oVV7M+9ql1Vuta+qBcIHmClb+GuKrUnopdmhw950Y40=;
	b=DwM58no7mnWHv/o9aMJVOO//1VIr8geZoQ//5tSzk3MmuotgTsCailJm3cwKcLKah7go
	 Tep4lMPBeb8fPrwXjG3c0gH1J+Ez7PcUHdnWoxbTmfh9Ey7NXmJZUK+rxEFWzRsDFn3cH
	 vJNEd4U1l4rL1DzXmevdaCaN6ez5WHtVuktosErCVJiyvmJKKtuqtQfMNQOHvYrAPtPUe
	 Sc4wqE9tsAdILUCmDtTEg+odZVdQ13LTdfgVx19BPQhwOFYC0RCVB8SO6uxOm9bHwPirb
	 43GF7q+IBKCHEwZF7CCL9d4dTN0Iof0HNQVPW3uOpFX2HKHojxIt/GuWA+bEwfxAvTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhLoxPYZ;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920A606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6920A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhLoxPYZ
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd3310348d2so89270a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022882; x=1794627682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVV7M+9ql1Vuta+qBcIHmClb+GuKrUnopdmhw950Y40=;
        b=GhLoxPYZ5BjFUus9WKd8pN464HQdSA65zf0uCB6PztVErb0RQ9jpQEcGoFX44l0mHZ
         cIAhp6+pf/Sbp9tQpBYHzJUXtEbUGTHTeJ1wJCJs1GI/8iwhKIWf1OLiC4ZTSYZEt0jL
         W1SrZbOsOqkptDXo49LHln0ft41a1vLDHIOFLtwi2JCSFs7+Fs/bmdhJDaK7GrD96eOg
         NzG4woJd4tfcJEFP8uaK9Bq2YWSUvHAJkoR8JVXhg7vUCtmDgGVI6g0qBbbPEzN3nbHW
         bVQ5UOLGQ6JMuzfXp7SxopcKMC5COJIrZcItULoG5oygOFqyO/icezjnUkL8ZBrdinSC
         4FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022882; x=1794627682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVV7M+9ql1Vuta+qBcIHmClb+GuKrUnopdmhw950Y40=;
        b=laxLMI52vHHEp6sB6HPjfnpBfIL3/7zemKehoEdHdY5RYOYwW/72D4gfasdT700WyX
         E16+Tu8Tzhgtj8axbJ0zk5k2qypSi1xXzCEIRhqUQHT/zroBw9WCJXgHsfDd5QnQXq/x
         XCKFtDF17+lglUTjy7C/zqQTnj15bEVyR53LBnDujnrRhPsGjuLU026qBBgERxtxdipY
         Yz3y/TMkGtHN2GHTDhdblA6EOGLxH0KLpNjIaxVECF2FvO6QkHY/Zk02BXoIF0JgsWWz
         SWZzM6S089eAKNFfl6GHUCIhJ4QQEA6A+Hn7LqXRrEZv7yxexMJGVJNuXvyS9nCCovEc
         hFuQ==
X-Gm-Message-State: APuU4Z+7aRupCgKvUrqiwe3SvAvHdRoxzxq7OZBZpr19l0CqrtvDIYT7
	g0Dy6KpqXWibusnp+gxxigyFLJoSc/FUpma4XkKpUPCVBzWh9bbS9PuC4luyig==
X-Gm-Gg: AYBFou2Z3ly8uTxxJvwQihodq1siBk2e567miRraRPdEJjaSXxtleSYfcNOfeYvqZMI
	snTcRqJOr9ZbMasVtviZFF38QepSLfyZU4eTBynzLLGyxvUAksJMuikguEY9l519brO9amMaHo3
	bb2q1eOU2zqjcl7zVYiZ3mzRhnuGXqtqFzYlsLVGBNmOuHEXLpPIz9DYqX1FX6eq5DkxVj0u5Gy
	4Td46rEAGrf7bt7/ZJkfejunOxRg4+NprjPVLChqURYqx7TudKUakh6bwfd7A962mq0p77a5y5t
	K8956RaYmqZZkOoAH6H5eF9lkRNO9U+0DlOSYAxCIeIMloWYQhvuPlwPLqNdTj9WQH4X4Hrk7Fp
	nXCSwqurxlgP/vHn4ETc1Ce6zpEcIE8RuVlq7l+2eVULY45B0l2XVuAZb9HU6r/ydWX4EkttRsN
	SF76rTckSTRf+uBb3PBGhDP9Zp35ZIzE/idV9lCS47VkL744LbVOnq6eB/mYM8Tgasu69O8LnGy
	N/WL+D7E/2mTQxizA6mq4ynh44RfdJqzRWFAvv1NugXOj7NYslDDOQooQmpXEfN/dUDrCtaF16i
	OJeNiKO6Ocb1pMznuVQUgU13ebbDgc8tQzz16nrIaQ9Sa8uCs57OHYRB1yS7W5GaCQCCj2O40iv
	V7BVd3RiN7GBmLNAsPBViQYN4lJvXrA5DYuK5+mSvOAKyG5pAeBJUGpQmhiDPvfN7DC5rDLiLDg
	==
X-Received: by 2002:a17:90b:4a06:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3b106314922mr724263a91.24.1794022881596;
        Fri, 06 Nov 2026 19:41:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7e3dsm1590485a91.11.2026.11.06.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 33/46] bpf: Give the places of a back edge to the jumps that count
Date: Sat,  7 Nov 2026 03:37:41 +0000
Message-ID: <20261107033758.1547725-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

A stack walker reads a few words per frame, leaves the loop when a read
fails, and appends up to 32 words per frame:

	bpf_for(i, 0, 100) {
		if (frames == 8)
			break;
		if (READ(a) || READ(b) || READ(c) || READ(d) || READ(e))
			break;
		n = 32 - (a & 1);
		for (j = 0; j < n; j++)
			out[idx + j] = b + c + d + e;
		idx += n;
		frames++;
	}

'R1 unbounded memory access': only 'frames == 8' limits idx, and nothing
looks at that jump. A back edge has four places for the jumps that leave
the loop and dominate it. The nearest ones take them: the NULL test of
bpf_iter_num_next() and three statuses. None of them counts.

Scalar evolution knows which jumps test a counter. Collect the jumps again
when it is done and pass over the others. The latch keeps its place. The
search ends at the head of the loop, as for a loop with less than four such
jumps. Every jump that is kept tells iterations in which the back edge is
not taken, so any choice is sound.

The loop has 9 iterations at most. idx has no closed form, so they are
looked at one by one: idx is 0, [31, 32], [62, 64] .. [217, 224].
pyperf.h with STACK_MAX_LEN 250 and UNROLL_COUNT 8 leaves its loops from
the second of 8 copies of the body: 59713 -> 2877 insns.

A jump can leave the loop by way of a flag. These jumps are known before
scalar evolution starts, so mark_latches() asks for the SCEV of each.
  do { ..; more = ++i < 256 && v->in[i & 63];
       if (READ(a) || READ(b) || READ(c)) break; } while (more);
The four places went to jumps that are nearer to the back edge:
"R1 unbounded memory access", 12562 insns on bpf-next. Now 63.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/loops.c           | 27 ++++++++++++++++++++-------
 kernel/bpf/scev.c            | 24 ++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 61f133e4d72f..656ed55b96ec 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -716,6 +716,7 @@ struct bpf_backedge {
 	 * Conditional jumps within the loop that dominate 'from' and have
 	 * a successor outside the loop, nearest first. latches[0] is the
 	 * latch; the remaining entries are additional exit conditions.
+	 * After scalar evolution: those that test a counter, see bpf_scev_jump_counts().
 	 * One of them may leave the loop by way of a flag, see bpf_edge_leaves_loop().
 	 * Each usable condition tells iterations in which the back edge is
 	 * not taken, so keeping only a subset is sound.
@@ -2212,6 +2213,7 @@ bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int oute
 int bpf_init_scev(struct bpf_verifier_env *env);
 void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
+int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool taken_leaves);
 
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters);
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 0f3b0411003b..ce6cef5e1c15 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -307,18 +307,19 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
 /*
  * Collect conditional jumps within n's loop that dominate 'n' and leave
  * the loop on one edge, see bpf_edge_leaves_loop(), nearest first.
+ * A jump that cannot count the iterations takes no place, see bpf_scev_jump_counts().
  */
-static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
-				       struct bpf_backedge *backedge)
+static int find_dominating_conditions(struct bpf_verifier_env *env, int n,
+				      struct bpf_backedge *backedge)
 {
 	struct bpf_insn *insns = env->prog->insnsi;
 	bool t_exits_loop, f_exits_loop;
 	int *idoms = env->idoms;
-	int n_loop;
+	int n_loop, counts;
 
 	n_loop = bpf_loop_at_index(env, n);
 	if (idoms_intersect(env, n, n_loop) != n_loop)
-		return;
+		return 0;
 	while (n >= 0) {
 		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) == n_loop) {
 			t_exits_loop = bpf_edge_leaves_loop(env, n_loop, n, n + insns[n].off + 1);
@@ -326,22 +327,32 @@ static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
 			/* latches[0] is the latch: it has to leave the loop itself */
 			if ((t_exits_loop || f_exits_loop) &&
 			    (backedge->latches_cnt || bpf_jump_leaves_loop(env, n_loop, n))) {
+				counts = !backedge->latches_cnt ? 1 :
+					 bpf_scev_jump_counts(env, n_loop, n, t_exits_loop);
+				if (counts < 0)
+					return counts;
+				if (!counts)
+					goto next;
 				if (backedge->latches_cnt == MAX_LATCHES)
-					return;
+					return 0;
 				if (t_exits_loop)
 					backedge->taken_leaves |= BIT(backedge->latches_cnt);
 				backedge->latches[backedge->latches_cnt++] = n;
 			}
 		}
+next:
 		if (n == n_loop)
 			break;
 		n = idoms[n];
 	}
+	return 0;
 }
 
 /*
  * Without @flags: the jumps that leave a loop themselves. That tells where the verifier may add
  * may_goto. It takes the constants that hold with these edges to follow a flag.
+ * Once more after scalar evolution, which knows the jumps that count. The flags that were found
+ * are remembered.
  */
 int bpf_find_latches(struct bpf_verifier_env *env, bool flags)
 {
@@ -377,8 +388,10 @@ int bpf_find_latches(struct bpf_verifier_env *env, bool flags)
 			 */
 			if (bpf_loop_at_index(env, backedge->from) != i)
 				continue;
-			find_dominating_conditions(env, backedge->from, backedge);
-			for (k = 1; k < backedge->latches_cnt; k++)
+			err = find_dominating_conditions(env, backedge->from, backedge);
+			if (err)
+				return err;
+			for (k = 1; flags && k < backedge->latches_cnt; k++)
 				if ((env->log.level & BPF_LOG_LEVEL2) &&
 				    !bpf_jump_leaves_loop(env, i, backedge->latches[k]))
 					bpf_log(&env->log, "loop at %d, exit by way of a flag at %d\n",
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 4ce8ad5d5a27..64903ab738a0 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1452,6 +1452,10 @@ static void mark_latches(struct bpf_verifier_env *env)
 	int i, j, k, from;
 
 	for (i = 0; i < len; i++) {
+		/* An exit by way of a flag. It may have no place yet, see bpf_scev_jump_counts() */
+		if (aux[i].edge_leaves &&
+		    can_compute_loop_scev(aux[bpf_loop_at_index(env, i)].loop))
+			aux[i].need_scev = true;
 		loop = aux[i].loop;
 		if (!loop)
 			continue;
@@ -1864,6 +1868,11 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 						 find_header_env(scev, header));
 	}
 
+	/* Now it's known which jumps test a counter: the places of a back edge are for them */
+	err = bpf_find_latches(env, false);
+	if (err)
+		return err;
+
 	if (env->log.level & BPF_LOG_LEVEL2) {
 		err = log_scevs(env);
 		if (err)
@@ -2190,6 +2199,21 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	return false;
 }
 
+/*
+ * Can the jump at @n tell the number of iterations of the loop at @header? The status of a call
+ * and a NULL test cannot. 1 as long as scalar evolution has not looked at the program.
+ */
+int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool taken_leaves)
+{
+	struct linear_latch latch;
+
+	if (!env->scev)
+		return 1;
+	if (!find_loop_env(env->scev, header, n))
+		return 0;
+	return match_linear_latch(env, header, n, taken_leaves, &latch);
+}
+
 /* What is known about a scalar or about the offset of a pointer. */
 struct scev_value {
 	u64 umin, umax;
-- 
2.55.0

