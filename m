Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206863;
	b=l5rGp08AqXGpRv8qG5+7/d02XrRr02gMlZVGULzZCpeL+ZiRA4IskBbq6hTHE3tnFcli
	 gzaScktqfuZUfFaN+ygvs1mRkx73NB2yrjaTha8gt43qiugK0cb1b7byz8AegHm9iDGv/
	 4XZkxRDDZuutBeYDVUKNzyFA1lM1+BONc/PDRsemRYcVxuthmL/b23zMYIQ9Fh9gduVKt
	 XOLYaymSsg7/iYl+3bvevwgkCeomJmEx4B3WWuVAYpEa99GAA6ShWeEFX7cAWofmTYBKz
	 pGOS45qSxGReLedDGlBqvUOeCewQBFG+pqgUxWnoUBBrBiTJnuPIrqPgmC5KQQzkSUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4IxUgNdhIYeR4crCBW+skmyMPmqkusGbizZSabXT/yU=;
	b=i87fJ+52mVXWtGIgyDccIkLzbZzKBcShOm9+/edF4dRWrzMVPeaTvwAge2aNc4f1EkIp
	 C+Cn0n+JusOQN40iOH1C8DpVCH0uquOufzXZs035OrRzuha7wnhdClry2ydI6mt3zgZMz
	 OrEXK44yx9JE8dGOI93h4OoPw8l7Iv4xLbBI8vKLJnFSg4+Q2+GrPvmEBHNiPXJOXRT/y
	 JTMg5rSV/Oia9g4pJOOC38E99h72zphNEwWhOyRhBF4YYdvldhEefvBKazSxphEoKm9JY
	 BY+snhM5UpzNsZ55l4xEUC209pKwiTPcSDMk2ns+wJpjHpWI6HK/iSwbHCerHm1dqcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xB0JD6qm;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E526606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E526606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xB0JD6qm
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e946155442so3954375ad.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206862; x=1794811662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IxUgNdhIYeR4crCBW+skmyMPmqkusGbizZSabXT/yU=;
        b=xB0JD6qmiH4xeDt7WKZEi9rxt0BL/WI17wrTBNiVrIjFllcmud8IWoKrvokNebOlfb
         8Jxd/MdyFDPRTm/IZo3QBrsiuqu+6V4BBDP6yb0GVJ0IcBT82dNhj/26I2qjw25grycA
         vHRC2wb7E+OuRMjCXy+5DYMy0v+l+JndIIpUjah/KTgr562sFtCsg0jfwqGQ3kffy1PD
         tzY42latLTOYqzqL9OIbR3yNJ+E76wFPE4+QerzMuD+srUG2DFEmnLCGlgutwzFKF/GZ
         3RBlVe9wfs3G1FUycII5sd6I2FOfc6DUhQTm6IH32wUY8Hiuzezp5sVN+JiJtTSMfMfg
         ypaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206862; x=1794811662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IxUgNdhIYeR4crCBW+skmyMPmqkusGbizZSabXT/yU=;
        b=yXZ0WipOixEKrOLr2EEATQYNeIEmzIcqQnfNGJqPrtq0waEF4y4hsQN1uQ+EvY8Roj
         9UVKAoh15oFx72io48EfZRwhN64StpcQuhp+1Tb5Iy87nGAKQyZ2MmntSIH1IQqdu6x0
         FVWaNvhqXBayTgaiArOfNS2i5t7TAJXZa8efh5690oPx4x4MtnJ/u9ys0vmlIP5cRHe2
         JBQmNS0E9IQR0kmPM7xjc4pP2+FIZeOxH9vyjOOyLFpX1zLEJ/X5QUD+HPC7Lj1TPSoM
         RhJ87fdijRRjhjCpC27efpSQCaHDHPKCgi+yB6Oceq5VQAnClFg5Y2tCe6mbr9AuYLHS
         rpQw==
X-Gm-Message-State: APuU4Z/rRiIxz8GKwN8EHI7h9fw0HOeFBeNXNXffjd0QUcBTIGHgZA7q
	Xo0D5aNLTvCZNrcFikX5gSQ4Gy+RImXVQSlo/152IMK3YhVG0BsX+Rqsx14yPw==
X-Gm-Gg: AYBFou2Sq44kBQyMspuLfoF6BrpkoJ+cWLAlFxCVkx9ghRE6kmkgBX88JjWutT9WCbz
	NcIs4sXJu1Xl4Gea877FqHkKdPoZdMBVztbD5mYBCFTtbGagXCj6BWiIt7Hl5YqdUP1Pmd9Tp+c
	g4KIiPjj9QP9fKDdZwWHZJoT6XhiYvsuuJNLex2/RtbZsseKq7nDXpOuz4W0Sssu+YpCePERUvc
	zjUotDoba6MUUQMPCekFFrKmyE9Gl58Tm6r6uEDo6Iv4iGoukHO3fU61Mg92Nwtj+Kn7/WteKE1
	8i8OI5jGgeOjaKwYQm92k/XtBW+3dUv1jPcVIjBbq+Sj2owF7IR4Xw6/pbWRcnbJxMHgxp11JSn
	mX5o9z9CL8tibSKUaARVlHZcz+x5Osc+um3XIaEmbZbxvOQhrn3oHfAWX2RiHbkbpFCtsz6+Wf3
	xpwP3mpagBTjYWQfviv7EZcom9DqYbUsqwnpEO4NKe1787kb+xcKSoI2pq4M5DbvuMAI/RFx4DH
	ifyyxf+ZFDNBHdCMqQTuaRZMnbgCRAZRfdtlHJ8FSBKpKvYakim2NAQE/hyAX1YJ25HgYngsxYw
	W9ZdgqcbaxWB8AGY+aVHU5EREnrXVfUfS2UP55FXDNWdjmi0gK3UXPeqE/8vWWduUIfSSGUz8MG
	W+mWdOw5bzCmvqgu7WBQ+PUmbFFWeK6efE7cqcBMdIQCZms1KEVosv6FN+c5zunbEAlNNXkt/qw
	==
X-Received: by 2002:a17:90b:4c8a:b0:3ae:5525:dc25 with SMTP id 98e67ed59e1d1-3b12d568df4mr3101635a91.51.1794206861850;
        Sun, 08 Nov 2026 22:47:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105881e6bsm9690399a91.7.2026.11.08.22.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:47:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 04/26] bpf: Don't join dead registers in scalar evolution
Date: Mon,  9 Nov 2026 06:46:48 +0000
Message-ID: <20261109064715.2382452-5-alexei.starovoitov@gmail.com>
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

This is about the cost of scalar evolution: the work per join point. The
time in scev.c goes down by a factor of 1.7, the number of expressions
by 2.3. It is what pruned SSA does: no phi for a dead register. Expressions
change, but only those that have no users: a register or stack slot that is
dead at a join point is '?' there.

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

