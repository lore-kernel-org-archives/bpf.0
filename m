Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374050;
	b=EGlqmAMBeDDK+jF/8tIzCo+cczIYGr+DFN6ZADevmY+aFgD6ISjH4dDSEZyk2z6ljZK6
	 W+xLb5i136JtXv1GJSUNPmBUq+2+HlpeTHxSWgnD01Fhsvg75lc10/unVq8er4sSkdYQ0
	 OAba22w9iwCZMZZk4JfBlZW3MatgFXAWJx6yg14rBt1BNTkBvErbqsK9uKMu0rroWkOOV
	 1sFh3BtgOUcp8azfGP6UbikMqbSculGwT8X3r9KoCwXb9uKsOWHmLyhaapqrK2iv+cXQJ
	 JbuTKko2BJ+n7ckt2J25QOXq70NFqpwQJeUHP9mVlovvYW+lwBc/nW2g2eWhElbf9YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4IxUgNdhIYeR4crCBW+skmyMPmqkusGbizZSabXT/yU=;
	b=igWLv0owxgXoGuednYQnOdDPLXWwZnfI9bPmnIpigdQyUT4JgxSfEGj/lh5g1r04e6bf
	 11hMzzI588JkQHdAA3zIEsGh60k1hD/FluxxfFzIVoBenBvOkPE/CP6j+8h8jcyOARa9E
	 QEZO6OqnHkM61nGTLEZr3Wa/+rIjQW7ZWZDZb0vkRHeH9OHZpkGUggSUuNUquQm4nUeSP
	 +gpeITZxBZtWN4dgQqcq1D95TIrf6/hVd3ZCuJx3vlLIoTZmNBhkfSvq466vGWIXV266Q
	 edagz8P4HyTD0C/J6W00tillEzONj7pGBzrqVqU2vGcIk3kQ2Jm2visVqbV3W5f7oHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxTyv888;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AE606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF1AE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxTyv888
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b1535be329so1501350a91.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374049; x=1794978849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IxUgNdhIYeR4crCBW+skmyMPmqkusGbizZSabXT/yU=;
        b=yxTyv888Mc+XFrrp+xKdMC1LNbky9NG7C8c4IRQakHLZ73YOyTzq4fJEOgnNROBxn0
         TbhYC0nOQp+/q9MVxmQCiYX4jD3ZEhLtGQp6dDMhaROVAwl5gQyW1ukJSDGuq23LsdOM
         8snifIyVLh/KPuBxabLtdvl3+YnUt4nQlHkeqNCDqzZsKuy7t5F2PYwjyBFiXDCEJCB5
         LDqnndyATFbm/O4tAVRhoHmKDZH8qSbDDQz8myfQK7jcZ74v8h58XxZgz7OJpdakgo6N
         BZ7uBqbKgbw4lbajkdAkNDvFMMfLDxQjVNvOMioJ3eps25XdTB/uaiDZfsb83hm6qjlC
         lBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374049; x=1794978849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IxUgNdhIYeR4crCBW+skmyMPmqkusGbizZSabXT/yU=;
        b=PO/mCRXnnwbh6IpQkT7BsADvH4RFPtQUZwezaJJ9G/vInAFzHF5jQCkBSVZSgLsO2v
         02vW6Ycl06wWEvPUw10PW1A6paKsnNRWypzF285BvXWO5ir9rf5/8O11j8Eju+sBTZG6
         FwsZMXKxwuo5z8PwE0+rKMdLGwt/GaV09zaqDrvsSirDNp9ebGu5v/ODSib7NZBuFozS
         eVQ0Bl2nvaDm7FH7cbg34vZ6QsSS9wpg6+qvhDROVcOTVRMrDy5c6Xld3A0HcJ36QfL6
         Gr2CQ9r4IqagvxZfJ8mI099bUTFMyA5J0v+IECKj6DJ6ariSsXuz8Zz9CyeEpkscWucQ
         uVmw==
X-Gm-Message-State: APuU4Z/NjLLLVyDndSzFx6aqxYTrAAA8bv8xF5Mo/2dyuwbE9+TBHucK
	IVuAd2/ac6Jnz2SuBoUt5xFp4Jau/byZav84mRHo+klaAjOIxO2PaVi+qeWspw==
X-Gm-Gg: AYBFou3NUiFIfblET3vnuE3QTqijDTe3+/7V3RxlHpAkkgnz4djnG/PnkKgX0dOd0xF
	qpuHtQykOlVNBT6yC9WuGC2lWjOST+C5kE6x18XcoZlEc1Ja5hew5EjcB0sA++NGYIbox/IRlwv
	wsHOnJmPMg3g+KR+zyA9REX6zWdl5FBZx/NhGF6Pnr+iWIqARdevimRjG+EK65MrGGGAipS83VC
	TKY45JvRLhVXFSgmGYPyGfrEFbcExS7vJgywnbul3n5K9T2TsGcNmV3UEOspY4Q2QhlKc9F53gA
	JazhmQqt45y3BtRlcvFszc4VrF35V0Y8mjz9gmXF62X2eDa537/4BghdJqy6/tN2skWMnDN1FVX
	F93FpkryQU9OrojQo8KlLlt6JjDzXTZyUOuNIRP7UpDAYNFCwUSXmcSUsMlGWUD0MVQLSLm9q1T
	NAw/sLYvxeP/52QrQ9poLaz24aczfVy7c8Ps3HuoOTt9DhOWYNhSAypLJV0bueW5n9IHrD3q/Hl
	S2LjnpfI1PiAvw4nAMV58ue58FSQWbNz7SAXSbjGqTDAn6i6n8D8U5owd5JOhYmrE+Mutn5Q6g6
	nhQxq0PADSqTPCY0GG/bM16u3CtIetnag1f1lt+fi1FiDG3V5OlagvyFUvunk8DJHwUBCTQfIhH
	6htI6cWKaqm6N75BgpvbQv5jYscV3jnsNEnoquiZDJ76yWt3jPEqi/r8WIcTJ5sg5RGVOa9AeeI
	A=
X-Received: by 2002:a17:90b:164a:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3b182f5a30cmr1326666a91.40.1794374048704;
        Tue, 10 Nov 2026 21:14:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db9d1fbsm2678526a91.15.2026.11.10.21.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 04/29] bpf: Don't join dead registers in scalar evolution
Date: Wed, 11 Nov 2026 05:13:15 +0000
Message-ID: <20261111051341.2800252-5-alexei.starovoitov@gmail.com>
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

