Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749386;
	b=ovC3bJM5UctvKpBkZj+/AjWXPxohHDzth5yMpgyBgIHgl0iTBqw6IT3m4rP/BQFIWij6
	 dS6rTF1uwuyLcxYbN4jGjAYR9rODdhnKRaziw66xYzWoY3rPUN4d32r7y932+UhaeibGV
	 Rpp4kIEtRDusUOkn2tRipx8N/1vCElKTApDiWyQOd+XK7ePbYc5S6MYdBHSa+yAlPdcmT
	 aIVqm2dr24jNO02+j7baCSC8udtvRVNqWGFIq+UZ/pFrjKTqnld0udWAqu+MczaQd8/8d
	 YmW6BXhWsJ0dLGS2bGt/gVovLJ21FoOG9DpgHIoEg4oEDz4yQ6w5wo/UJhIcFhjox0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dLJpvPoumSFexmTFflmUNY8ZT6ZJaVenaHcrkKAe+ng=;
	b=Er3J8fprsvbVfymzGfCFHHqV3f9BCrfmvw8tmNvQolMT0SXTbEaOEoGBZyIQRQEuIfyr
	 egaQhujIW2/08qk3JpYtVcgpAvz+l0IyNwZiyItKqyiHKPZO/L/m7cVjTwGeQT86GYuqx
	 oXbpOZipX8Xr2pJUp2DzUErFFf6UCB8DeViDK72GVoCqNnfy/wUo+Tz0oFWq+xorjHvtS
	 fB4anqt/Kf1gbB6T5XYFx1nP8Q0ucostfFlPDwgWrgHjoJbho2m7VkBxkd7xm3IZbuQ1T
	 ai9wofGTaRihNfpIbDP/bi8+KfYwK/wea2QTLE1jE5AH90gIgw5rWP7NCo7fOg4ho7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgD9i8+p;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66B606A333
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F66B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgD9i8+p
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc751eddf25so77378a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749385; x=1794354185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dLJpvPoumSFexmTFflmUNY8ZT6ZJaVenaHcrkKAe+ng=;
        b=LgD9i8+pzmlPBOR75ucqi80MltF3ok/GAx3or9nxgpBiNz6STouDltkuL/nlX+DNhk
         JbyDj4H1Isj8AVOH9xk14TcgYDkH4vnGvbAlhGOdApE2tfE4JTwWp1c8NiNwSel/aBH0
         2HaTGedJpppllkVlNBW1NlgXMmy47cWCctA4PiMpZGSdrzxdBnTdt3Rms2E13Ewnv5N9
         HYz+Rl5d9EmbM18wS5ziz9AEeBUCagC+bc0zo8vfDu5APKSTqOBrCrLmg39JGK475OyD
         /HhCCjNxd10TO/lyo2f536bcvCkUMwJxm/CZi3srKTmRvKJHiDx7XRNrjHJounKyVgL7
         WpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749385; x=1794354185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dLJpvPoumSFexmTFflmUNY8ZT6ZJaVenaHcrkKAe+ng=;
        b=hZullNYvWN+cv//bF/+5T2bKJbrUP2D6AVVT/WBLQWxRtDOSxE1sZFhNXlTM7/KoEE
         foH7G6FxFkj9g5gXOiEg9U4XXxhSCQx6MUd0T5kQxdM9sh6+BzKWfoqyQO1eQceRW46M
         5CmvZYv0m1EMgi07Q17fvSrj0cLRHa9MWuVS0pLORHzfnjT2TP/07hJt1ooBzJxDt2Cf
         1MTK7yh0gagZly8hWmFuQjnvHkFkwjW5L11BZ+20fHRq0+I4Io2siNwTrqxTIUMnVISs
         ltVG+yejKJb0N6RQTpNu7eAkH0mEke662U2qSgH5VjXRYmsvIcE4wkVFOEJR5xUrQMsy
         7MOg==
X-Gm-Message-State: APuU4Z89DNtmavjX98RIf0ssaeFu8AY58cTjoFAtt2i0lZDgYPatp+1U
	yffX/cwFx2F9H9fShWzxTq/9zY38cuFFP7K07lCEAICyxArR+JMPtd6rmLKl6Q==
X-Gm-Gg: AYBFou2BEr+8fi+2iV13AxkXyGwFOx64y0DUKHy7Jy60x+1uPLdCl+eFNCMpLg11l3t
	q6McCWAumki4vlDZXwPBMdr1WWRWkkONB163/Moc23PDBVuNI5XmVdaIxqbDgpkhBZiQokayOVS
	qLMPWg4rzkpCoNnWP4NTkXeE8ixlWe2nRgI3huNfXORggW0zkysSF0LTDRiUZUPxZhpZvlczRy4
	srCzQlm3GtCndtvLK/5K+vAfh1hGxsbEC+FMt5YFdsQEoR5qfVthD7BGw0KGXrWtIpi/QcbHaQL
	kHIQY8pcb1xRj4LMICnWjizG+h9Phopum3pqm40H4Ai3riuSzNcpOSsoh9HmmzRaGZuGxfrVrtr
	T0vqH+qa+ujxX0nZpAYABFv9Tw23aOB/Dpjvj1PcslucdXutE/d4QaJ/nzqWCENnAGUhtPVGIfg
	w1O4A8ZxNVe/a654cMH99BgjczkGcnYbKxA7OHGPEIQ6lsKRxUg1n1IuN35O1dXYJii6MttY8Us
	tTQv8VcwOlGovwhGOx1WbEydsCSOKYvJ6OlOvXGkVaO40HaXesr86DJLTOR+EpZO4HTz04viacB
	ynxF9cjJ/L2uEcq0Xx3JGlywf6A9O3QeSAKVeljuIUlOlz/PIif4V9VQ4YGicoSQ1YKqCk4M8+l
	B8ZAsdQN5h2yGSWclAit8Un0faPrwgJHR6GSWn+/osQri82g+KaeQbKQz5GTIx9SIB3MWdzMgMA
	==
X-Received: by 2002:a17:90a:d008:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3ae89188f68mr12183487a91.0.1793749385049;
        Tue, 03 Nov 2026 15:43:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b0ec5sm6329623a91.16.2026.11.03.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 20/37] bpf: Compute scev for a loop that has more than 256 exits
Date: Tue,  3 Nov 2026 23:40:45 +0000
Message-ID: <20261103234104.208239-21-alexei.starovoitov@gmail.com>
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

clang unrolls the loop of pyperf600 in part: 4 iterations with 150 copies
of the body. Each copy has two 'break' and a 'return', thus the loop has
451 exits. The list of exits of a loop holds 256. When the list is full
scalar evolution gives up on the loop:

  loop header at 164, unsupported loop: too many exits

The complete list is for the loop around. Scalar evolution takes a nested
loop for one insn, and the exits are the successors of this insn. No result
for the loop itself depends on the list: the number of iterations comes
from the jumps that dominate the back edge. mark_latches() prepares the
exits for the loop around, and compute_max_iters() asks if there is only
one exit.

Keep the two apart:

  exits_overflow           the list of this loop is cut
  nested_exits_overflow    the list of a loop in this one is cut, and the
                           list of this loop can lack exits too

Only the second one makes scalar evolution give up.

  loop header at 164, header_count is [0..4]

A loop around a loop with more than 256 exits is not analysed, as before.

pyperf600 and pyperf180 have 5 such loops each. They get a count. Each of
them changes one more register that has no formula, thus the verifier still
unrolls them.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/loops.c           |  6 ++++--
 kernel/bpf/scev.c            | 15 +++++++++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 724f3b60130f..95e0d7face11 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -746,7 +746,10 @@ struct bpf_loop {
 	int exits_cnt;
 	bool irreducible;
 	bool backedges_overflow;
+	/* @exits is cut at MAX_LOOP_EXITS. Only a loop around this one needs all of them. */
 	bool exits_overflow;
+	/* @exits of a loop in this one is cut. Then @exits of this loop can lack exits too. */
+	bool nested_exits_overflow;
 	/*
 	 * Loop-entry registers used to compute stack addresses for loads,
 	 * stores and calls requiring fixed stack offsets, in this and nested
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 2568079c2945..e584549bd208 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -555,7 +555,7 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 				 *  s: ...
 				 *   }
 				 */
-				/* Enclosing loops inherit the overflow, see below */
+				/* Enclosing loops get nested_exits_overflow, see below */
 				if (aux[t].loop->exits_overflow)
 					break;
 				err = add_exit(aux[t].loop, i, s);
@@ -572,7 +572,7 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 		if (!loop || !loop->exits_overflow)
 			continue;
 		for (t = aux[i].loop_header; t >= 0; t = aux[t].loop_header)
-			aux[t].loop->exits_overflow = true;
+			aux[t].loop->nested_exits_overflow = true;
 	}
 
 	if (env->log.level & BPF_LOG_LEVEL2) {
@@ -587,6 +587,8 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 				bpf_log(log, ", irreducible");
 			if (loop->exits_overflow)
 				bpf_log(log, ", too many exits");
+			if (loop->nested_exits_overflow)
+				bpf_log(log, ", too many exits of a nested loop");
 			bpf_log(log, "\n");
 			for (j = 0; j < loop->backedges_cnt; j++) {
 				backedge = &loop->backedges[j];
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 0d49c9021e30..e0d71df9c0b4 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1260,10 +1260,16 @@ static int join_successor(struct bpf_verifier_env *env, int cur_header, int succ
 	return 0;
 }
 
-/* Unsupported loops get only an unknown header environment. */
+/*
+ * Unsupported loops get only an unknown header environment.
+ * A nested loop is processed as a single instruction, its exits are the successors: all of
+ * them are needed. No result for the loop itself depends on the list of its own exits:
+ * mark_latches() prepares them for the loop around, and compute_max_iters() asks if there is
+ * only one, which a list that is cut does not have.
+ */
 static bool can_compute_loop_scev(const struct bpf_loop *loop)
 {
-	return !loop->irreducible && !loop->exits_overflow;
+	return !loop->irreducible && !loop->nested_exits_overflow;
 }
 
 static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
@@ -3050,12 +3056,13 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	 */
 	loop = aux[insn_idx].loop;
 	if (!loop || loop->irreducible || loop->backedges_cnt != 1 || loop->backedges_overflow ||
-	    loop->exits_overflow) {
+	    loop->nested_exits_overflow) {
 		if (log->level & BPF_LOG_LEVEL2)
 			bpf_log(log, "loop header at %d, unsupported loop:%s%s%s\n", insn_idx,
 				!loop || loop->irreducible ? " irreducible" : "",
 				loop && loop->backedges_cnt > 1 ? " multiple backedges" : "",
-				loop && loop->exits_overflow ? " too many exits" : "");
+				loop && loop->nested_exits_overflow ?
+				" too many exits of a nested loop" : "");
 		return 0;
 	}
 
-- 
2.55.0

