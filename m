Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206957;
	b=FRlmzhpYzHAAz2c37HZS9A6CVcLaunkG2qW7eLqHw+iSYzIcettVWk/AnDLLRm70tuPw
	 kYpeHOXl3DisMcP+LmERWHYj2YGTtyY4Cn8nKQutrOVkG5KXZxHZ+gxEjzMlKn/B2PbHA
	 CoRHF6jXRbod6ObMB/WmV1lMZgNmBUw06/SuBC+bpx5t0MFFzxUEwYjPiUAlCsiwWCltq
	 DvgaPvg1OhK6U1JO0MGGmY933lwaFUTn4CI5gKuWDRMNbb4A9DNzE6Mnc5bTJxw5IcY0h
	 Tj6gvwmYaRHht3JlTHzHx6xdYqYH5fXWDzKeF6EFAhjSOhMHpkbDBNbEFFUUipyr1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
	b=stQD47CYgYEpq3QlMDP2hEC0R6B9TFj4HvwcttwW+fkU+B8rAHGN73XeD+uzcu4FOXRs
	 gz/JmcjsfvwtLxV+ZgXIqIezPlvEk6X7ulDSH1NQhV6DEhwp0SN4EHNtG262R4HA8NmHb
	 XYTI6VwfAmcz3SJDcuzhMxwtfzhNKs6/FkFTw+qjGt5pgxS0Yhbc/TwMMCPnNnw3pvmvr
	 4Uq0mnlJnk66z8uLRnfqqNKKFbP/Weq1xO/I0rByTgos+MP9N5DOPqjaANFGpYb4IKHvC
	 k9yPB+Ny0E/kntoO4C0UY6RsGYiJrmyD+gOCKtvmHpBNeeg57WmRUyj1/Lo0vynIzZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFepvbmT;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D71606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFepvbmT
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so180822a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206956; x=1794811756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
        b=lFepvbmTpdoDi17f5zf7sDby6ubR71Rl32/X33mqlgfbVS6qxGIPFNYpfeCBM0tu2H
         yDZ8meF+sDQLl680Bi9avtVSnzuZ7bbTbIRr5UoqtJsEyBkAd0BZLiqfMAqMpa2AoGtH
         1EzpcCcSVgMm9xcwiy70KxpDUDKZ/zb+GI0Qv/RzAIXD3+KsSTFluezC2BfzyrhdeaCc
         OLiJsnN/xXZie89fOOXzy8dEiPEIJCmA/ixBxN9orpF4kMLp+TEtjNLIORQAdBucch7L
         xPrX4sKMEyc3o1Gc+k38NK+NwHd33dcnN3bBP/fIK0qp062SKplVF6JEX00hjbeZ0M/o
         TcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206956; x=1794811756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmvsoqg0UvyFkmW741QEMpZ+DDOrvdomqQq9bMxi3nA=;
        b=FpOmP08RbcYmodtSDQFD/R8RJ3YUneY9dGwWg57RRVxCzPink5mu/YtL9R6nESqqTa
         YPUlqYGG9RWNPu09ppdqKN1X5NTXruSnEORI/mnXXP5zg+N7G/m6lFsQUDL80bY7Lo3y
         YygoUz1FV54z3TOuI5a1JM+iMSB2vNj0i7kBdAUwU6+rki+u/kNRC4FvgjjwwmZulHnd
         rXCxXRPAIwpEsnYG+Vb6TdnaUv/yFr5BN083pp0WgHkWQBVF83DV/eGDSVqNlmWQJOGo
         kNO1fxrQ+L0tllK3lD+818kvWikCescgxwlH3ZDjTq7rdQxspnsNdnugaOxNJIoPtVgn
         rjmg==
X-Gm-Message-State: APuU4Z+Lrs8c/6wG4MOA7CvBvO5wGhjgSin9TrmDWFdw5LlbCXnrezuY
	NAbLN050hGyt+iWPhvDKqTIzTlItlUfAGDnSZXGlyl9sEtK18r1UnqsFkrS2hg==
X-Gm-Gg: AYBFou0weenfNNTA2ZVHxkdz93ZQZd+H9b8/U2MOTt04N4aEmgXiElxLfu0BSSKxpJt
	S0oYAh3PaHkQ52ht4j2Oy8SOz82QS2zW9eNnk4rUCJbTUGeFFu46iItxJ5tgRJ9v3Bwk/m5UK6M
	yKXNNjiqjesD10zYWORbnuknPel82hwNUTRcOcO2oepDMv7tvkrF4Ir9HL6fZJS3A18DByk8cTx
	OWXRtiTKBUNDS+zgpRx98xLtRs23Hiv16t4mCacrwYmAekGxHHUP0cCkZETqoKJzTJRg8qLa/+5
	Ub+66Uuc6uj/M1e6IubM1KQ26DTR8g9JLxOWJVDOutZ22FSJYfYJ3WqNjuOBgNKYPdB+dSdkHon
	eJfOxp3+9UpMwp1F7oraEwNuMkVPfMlpfNg59fbAgY41DaAENSzoI6dFJFJsVWjRT70+cmlICJe
	ew9POAc6WXLX0IZDRZHtX0e8gye7/LuG1PCfnhrJQQUAlzsGRoHX74pQgRGRz04cBSMKTaXv1lG
	rGSDFoKZTh/ODFvb7ygSSupeJB/Wbvd1NIOj7PsZUAoAryeo6+4esPqhvAXGlL8qByjvMm29xve
	48+hKu+dw38ady4mmHsdS8uWv+9KPL3YdMADXhCP/vknpUwAVgisJJzXAgpwBiBQRNT6gdrvBEG
	/h4xHxEl6bT+Pk3FybxhkE2GTRn5gPTYFY43ivaXI2HWkFljAE2SVE4Kgz5a1R0qfF/k4PV8wUA
	==
X-Received: by 2002:a17:90b:4fcb:b0:39e:6a80:dd9d with SMTP id 98e67ed59e1d1-3b12d305c1cmr2759697a91.36.1794206955759;
        Sun, 08 Nov 2026 22:49:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101c28791sm5875582a91.3.2026.11.08.22.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 20/26] bpf: Recognize copies of a scalar by their ranges in flow_join_makes_up()
Date: Mon,  9 Nov 2026 06:47:04 +0000
Message-ID: <20261109064715.2382452-21-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. flow_join_makes_up() is the
last code that learns something about the prog from them: which registers
and stack slots hold copies of a scalar. Recognize the copies by their
ranges. The function is a heuristic that decides which states are joined.
So this patch is about the number of states. Soundness does not depend on
it.

	err = update(); ret = err < 0 ? DROP : 0;
	..
	if (err < 0) goto out;
	..
	if (ret < 0) ..

The states (err >= 0, ret = 0) and (err < 0, ret = DROP) get to a join
point before the jumps. Their join loses the correlation of err and ret:
it has err < 0 with ret = 0. So two states stay apart if two scalars that
later jumps test each have disjoint ranges in the two states, as err and
ret do. Copies of a scalar are treated as one scalar there. A jump that
tests one of them refines the others, so their join makes up nothing, and
compilers keep a value in a register and in stack slots at the same time.
Copies are recognized by their id, in one of the two states:

	if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
		return true;

If every copy is a scalar of its own, too many states stay apart. The
init prog of a sched_ext scheduler in Rust goes from 36 to 512 states at
one insn and takes twice as long to load. At 512 flow_has_room() is false,
and states are joined by force.

Copies have the same range and tnum, in each of the two states. Treat
scalars with that property as copies. Two scalars that are not copies can
have it too. Then two states are joined that stayed apart.

veristat over the selftests, Cilium, sched_ext, katran, bpfjailer and
programs in Rust: no verdict changes, 199 of 32913 progs move, by 0.01 % of
the insns in all. The scheduler stays at 36 states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index c9458b3ad114..778288acb5ba 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2603,10 +2603,9 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 			       struct bpf_verifier_state *b)
 {
 	struct bpf_func_state *fa = a->frame[a->curframe], *fb = b->frame[b->curframe];
-	const struct bpf_reg_state *ra, *rb;
+	const struct bpf_reg_state *ra, *rb, *one_a = NULL, *one_b = NULL;
 	const struct flow_need *tested = flow->need[FLOW_NEED_JUMP], *need;
-	u32 fr, i, id = 0;
-	bool one = false;
+	u32 fr, i, len = offsetof(struct bpf_reg_state, id);
 
 	if (!tested)
 		return false;
@@ -2623,11 +2622,11 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, struct bpf_verifier_
 				continue;
 			if (flow_gap(ra, rb))
 				return true;
-			/* copies of a number are one number */
-			if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
+			/* copies of a scalar count once: same range and tnum in each state */
+			if (one_a && (memcmp(ra, one_a, len) || memcmp(rb, one_b, len)))
 				return true;
-			one = true;
-			id = ra->id & ~BPF_ADD_CONST;
+			one_a = ra;
+			one_b = rb;
 		}
 	}
 	if (!flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b))
-- 
2.55.0

