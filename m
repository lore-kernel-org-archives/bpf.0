Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415585;
	b=DGvUMEpDGNeMCw4FYjyKgMxM6CFjpkemHVj6mQ2OZ+pJrHd5tOoxFBr7Pyr19IqTz8uN
	 Mdx/sxZDHb2TKK4GmF3mEIfFq7Y01hiF0AGBLpQJ9GavDVk3muoHIpYYihTpHcebynlN6
	 f8vvau/ZLGyzGAW+jLs2/8oP5P39zu+dT7uGcdZVMhl3hbc2gSB75RKAZBpgY/fdl1vz5
	 +bwzpvWKngPxlBUj9Pr4rdUoWk9+k2SUCAIV+sh0Be7FkHLvxbOJevUAZHR+mgQSdVvDo
	 jp5z/qyk8XPoA2nytCD+oufwJHIyoT3xN5kqiQ0G53eFWL2Tl1+TZ0T8cV0TV/BTq/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5x9cz3wjv2ktfOJeR/VcoUxM452LIfGFlOo8GPZAyoI=;
	b=M6GRguQkEobYDp5wtcWzqQHyk5uGWL4XYN2yPdXDeisHyGrP8vtuvhtlhzGkuxTEpSrq
	 Pp0vW8IVP7xzSoktUGaeIkW8i1e9xvPP4t6Topn/yTXxdQERVBYPNsJ92xkmL6NJkRIOl
	 8cv1+YD0gSnZZSVzvPHXqPbBRglwrNXj5FOMwkxukxLsckwcVahkxw+fDDGCH54agc7ib
	 2fGORKkBn7qwojghgJYJ+fM+VoD9mfYq8OsL0GdlVXtwJpI/5eUs1vOmpQ9dwzj5feWKj
	 T8Zry8xkoGhwOy9usE2LRL19vdw4ANBOpJCMnOFKD30eqQo0K4mRmgAXtdiwq7egZTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DztJnW0l;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DCC606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DCC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DztJnW0l
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b179528d56so728088a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415584; x=1795020384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5x9cz3wjv2ktfOJeR/VcoUxM452LIfGFlOo8GPZAyoI=;
        b=DztJnW0lMOKGJ2igOqCY9Czj/1qrHukOyK6gICaKkvnE337FQRuUEXcCl6rHiXZPTS
         ziK9jAhAeKAZ/rL3PV1glPa2JcuzxS9S1Pa5wjzSTzuvW1cRzGmnZ56muXpOXpWOwCnr
         WBkpPGoMh5lllF9W90+dQ4TrVOJeZxbdcfqBn0zErC3k+qz/hA1mHy7fOOY+zTjUAhGX
         d0EnJ26ys4syJX2gxr+xuFKEIDLaWm1COz2GcRyTC5UODMb+30EwJOn8BbTxhYyLjAzD
         rN283J3l06DFenGXF2Pi6YcIPwJG0+973q4KNYRS513gfd5mYKgNBb7BVEWKWbue36uu
         +trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415584; x=1795020384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5x9cz3wjv2ktfOJeR/VcoUxM452LIfGFlOo8GPZAyoI=;
        b=qObV2mg7VRhOtieAC/iAaOIQI0hDkCHTwsVWwhewc2kQPASsaaLXKJ+3ZJHGEXKz9o
         OM5nVhIEzaYki8e1kJS+u7ZvMtifnI49xZi7eKV9hu8FMq3TjPj6kjgVKJihQbOA/YYH
         boW1eNQeK/D2jpoTR8h+ofveos//7yghaQB5uLKUSs2Zpvfu6A0nQ+31qFNinrIjRDlb
         9G+/8Zw8//VTiuxq0e/OBy1wzyscLX4r36mVM/CeA/4hm7d/+WMlu+/UvR8qx2bKcg/1
         0+X7YfxzmtCyy9iXdtcp4MM1+kvNjw9FxvYvrc8THu6NVpoa7UNnmm85B1Ifbkngx/z1
         3Ndw==
X-Gm-Message-State: APuU4Z9C4CRHvN4TPz2INOL/Y/siThxKE0xp+Ow10tNtxULh6zBwE7AC
	pTPtJROf/U3rLUcwgBfrqyQKZBIAleMxsSZNNnJD3UGqRP79iCUf+n2Gd9zaOQ==
X-Gm-Gg: AYBFou12GBUjK+YVUVaeY6FnUyGNyahdjSM4pFohD2aZ9RIUjGfYb396NZZb+zJgThz
	YMBZcViPdf55wctMOz/sbnFLSZDkoeprVL6XFKgawBB3G6CrsdZQbnT7tSMPC9N+N640Zo9jnsj
	6kYflrPR7JGzQLxRY8ILt52KV6pvTDP3K6yVtTIkHfJ3++QrsLLt7RT3JTOvQ+iy86SbWn8tR0E
	wgUgkXpUyRpJu5zxMMcZLShtF1LXfp0ShB4GLO/t0x8K6RCy+rMGhjVf+EBA4roULOb4/nWu8Gd
	spmBTGJ5OyNMY1ampL2YZBx5pPe0mTG8CtKg8CI3nBEpsByNydlZQY3TjWFdFDpYdbVnP447pvp
	zr5lF8dVTbxMgFeb6hl7E3MRz2y+OoK0tXmxkOBov6yE82sgWGKaTSdII/MEXJ4MdKx0O1u+ks3
	LFnilyrJef9lGd03GEKVnOUobV8eM88yQN8+VYDZt2IXoPNvLqh3rh+zg28VcKfDpu0abepWMpb
	yTuQAiaIMab0beqgXe0WO7Ac7gFIkma5FESZqzK5BqVOOsehElxTN02P5RMib3eKUaO9aaaI68+
	C4GleYtby3/l9rm+r+NcV/RARLOQAFWrJE0KCgpHN3oGHU9osdW9Wguiqm9H8vR6oAq9B4y3oUx
	PFV6FJPWDhnA1icp3F28wTJ+pyXoWepKbzROvhuA+sS+7IOm43G6WcPNDr4MKTzj7H0vi528Wjc
	4=
X-Received: by 2002:a17:90b:4408:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3b182d697d7mr2495713a91.0.1794415583675;
        Wed, 11 Nov 2026 08:46:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm11591a91.16.2026.11.11.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 04/29] bpf: Don't join dead registers in scalar evolution
Date: Wed, 11 Nov 2026 16:45:27 +0000
Message-ID: <20261111164557.2659679-5-alexei.starovoitov@gmail.com>
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

This is about the cost of scalar evolution: the work per join point. The
time in scev.c goes down by a factor of 1.7, the number of expressions
by 2.3. It is what pruned SSA does: no phi for a dead register.

Expressions change: a register or stack slot that is dead at a join point
is '?' there. Nothing reads it before it is written, but
reset_scevs_at_indirect_writes() leaves '?' alone: a slot that one of two
branches writes and bpf_probe_read_kernel() then overwrites was '_' after
the call and is '?' now. The loop around it is unrolled by the verifier, or
the slot is joined at the header. No verdict, insn count or state count
changes in the selftests, Cilium, sched_ext, katran, bpfjailer and the
programs in Rust.

join() constructs (any a b), which stands for a phi, for each register and
stack slot that has distinct expressions on the two edges. That is
a traversal of both and two or three calls of add_expr(). In loops it is
rare. A later patch computes expressions for whole subprogs. There
every 11th insn is a join point, and 25 of the 267 registers and stack
slots differ. One of them is live. The others:

- Branches leave temporaries in r0 - r5 and in the slots of their spills
  and buffers. Where two branches join, 7 of them are dead.
- A subprog that is out of budget goes to the last exit of the subprog, on
  an edge that the verifier adds and the CFG does not have. Nothing is
  known on that edge, so every jump to that exit is joined with '?'
  in all 267. Only r0 is live there. These are 6 % of the join points and
  have 72 % of the dead registers and stack slots.

56 % of all expressions would be constructed for them, by 76 % of the calls
of add_expr().

Ask reg_alive_at() first. '?' is the conservative answer: liveness is used
to lose precision only, never to gain it.

What it would cost to compute expressions for all code of the selftests,
Cilium, sched_ext, katran, bpfjailer and programs in Rust. The last two
rows are against loops only:

                                           before     after
  expressions per insn                       1.79      0.78
  calls of add_expr() per insn                6.4       1.5
  scev.c per insn                          291 ns    170 ns
  kernel instructions (perf stat)          +4.2 %    +1.9 %
  load time (veristat)                     +5.7 %    +3.2 %

mem_peak of veristat is 0.7 % less.

An edge to a join point cost up to 267 calls of mk_any(). It costs one per
live register that differs. That is a bound per edge: the time in scev.c is
linear in the number of insns before and after. Progs of 100 to 1000 insns
gain most, 5 % of the load time. Above 10000 insns it is less than 1 %.

With loops only, as today, it makes no difference that can be measured.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 8f8ca69482ca..7031ab00a22a 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -989,8 +989,10 @@ next:;
 	return id;
 }
 
-static int join(struct scev *scev, struct env *acc, struct env *cur)
+/* @acc is the env before the insn at @idx */
+static int join(struct bpf_verifier_env *env, struct env *acc, struct env *cur, int idx)
 {
+	struct scev *scev = env->scev;
 	int i, id;
 
 	if (acc->empty) {
@@ -1001,7 +1003,9 @@ static int join(struct scev *scev, struct env *acc, struct env *cur)
 
 	for (i = 0; i < REGS_NUM; i++) {
 		if (!same_exprs(scev, acc->reg2expr[i], cur->reg2expr[i])) {
-			id = mk_any(scev, acc->reg2expr[i], cur->reg2expr[i]);
+			/* no phi for a dead register: pruned SSA */
+			id = reg_alive_at(env, i, idx) ?
+			     mk_any(scev, acc->reg2expr[i], cur->reg2expr[i]) : UNKNOWN_EXPR_ID;
 			if (id < 0)
 				return id;
 			acc->reg2expr[i] = id;
@@ -1339,7 +1343,7 @@ static int join_successor(struct bpf_verifier_env *env, int cur_header, int succ
 		return -ENOMEM;
 	if (log_level2)
 		memcpy(old_env, succ_env, sizeof(*old_env));
-	err = join(scev, succ_env, cur_env);
+	err = join(env, succ_env, cur_env, succ_idx);
 	if (err)
 		return err;
 	err = worklist_push(env, cur_header, succ_idx);
-- 
2.55.0

