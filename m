Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911588;
	b=EqI8HnZaZYvQNC9CnuVa9jrjiVaVi6yioYOQf5lyrPTpgElZkbVStHAelu7SrKA+RoMK
	 10XgDoFX7Gst3VvMYeWox7EqgUIV6n9ibANk9JcddgrIuGflfOrQVxzR+3NTvquQ6AWA5
	 lH2KFUycr5RwmNAH/9L/Q2bqVgeUlwFbqLNE8ZICvAovz2INv66oGm53yS+FgXIPH1eSa
	 ZvA+6/baFFm2/Bs73xI4+OCy3rT23ndyifWMzMuIq31dVd3jPNJyJMqYDLYRBUc7IVbwC
	 mmnZE0ZzzJY/6aogKa5/4G11ig1A12SIFqLWI3wguPrybJczp86vYFb//vtov4s9Q9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lnEXSfU2S2Z0ognkz5FaE/LD4V+FT3fwjICuvc+dgmI=;
	b=lZAJ8mqjFk/utUn2n4L+yLiztm3oMbIzLHkIToL9dgsWgT5wwa3YAsc7+UdouweGnJL7
	 Xa2uKnkORb0Qn4PnTgQWnBpio4UMz8nXSI4ONM4p8HCB0w05LJAowKbHW7UZ1NlSvLT6o
	 BCm3UYRDu/LVd05uNh3QdBtn+x1Eskj8xMgEF8U7kzp+QQKjaF5Vo6M0+Z8kOB6/UTRHB
	 NImi0FrFX67EntrJEgAB2MD9KsBuGhl6MTcJs8zE1vhYsUCRIi6xAEZ0CGP1X+aGogdCl
	 kw+/nKQjhoJgEJ8GBoq+K9tvQ6LH5ihQv0W9VGdA6QPPOCJRlU2zjthhVLw/zddR7+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zDPf/TQi";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAB606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ECAB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDPf/TQi
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc502d509c0so1012472a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911587; x=1794516387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnEXSfU2S2Z0ognkz5FaE/LD4V+FT3fwjICuvc+dgmI=;
        b=zDPf/TQij9XBIDXISSC1bcjfPvXfPCd/A3CH8OabueHJEPBYMWtsldxdaLIb5+CQZ9
         SVB314rwbuM4kE0D4oSgTkZ1BaPinUG+9v/B31674CmlZ0R/gKz8G8i3ZHB9PuodUcSt
         vIcKiR6U/WebvIIG3ooIyP+QOGnDJJ+LVMMEEbVf02nVnuE2WwZv4gxWTdutDlVRwp9V
         P/z+amD06KgmGzKbKMjwiVphTbQq3Qcku8FLWTZ+jgBFU4vKrptoqd7hdj1LTODoKccl
         BdfnZ0fHdGRw62qw4oeshV8ol0LtvACrBUN+Wg0sO2s6FiZTSgdJEj0btvPegJ8TpSWQ
         BlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911587; x=1794516387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnEXSfU2S2Z0ognkz5FaE/LD4V+FT3fwjICuvc+dgmI=;
        b=tLR6NsJGe5KGKZ4FaA9w8yP6/xw2mhhSQaqX5TOyNpzPPNXDsxrEPAGrXVRfRCTKvS
         j2sKio2lUK0tO7xQ4gIcm5ora+H3fAj/FgQ7sNaSK2dkqdTzna7bzS95isDXQJjdMiAD
         xXaXywdCUF23yGjfwO2ze5otDHthPrXMx5na5uKetjDKdMwTfeHLITcZQq8MPpRUZJTL
         pUErnciML4a09xG8i4TIxtOPJaHt+A8pGUzxvZoRwR2tabwlhOt0d2FAbbRiE33/UcYR
         sPek4LBbfNqzjh2AhYmHNNIPSNyLD5YPe3vmGtmEWdM1wkLmOk71BDGz/L4BoGGlH5hn
         QXeQ==
X-Gm-Message-State: APuU4Z8FuKdbqz+/TdMfdfk8r/eQgNd2dcP78zFmK1m1g5rh+7eOMi6r
	D44BC9y9YHQmlvruJSvlPHtVQiYQPXsqc5yn3B2CaZFStf9c0fA3i11RxTk1pQ==
X-Gm-Gg: AYBFou0DT1H+4gIqq12taiovsqUjS8jcWqmp8lUYnI/HKgZFgPua3kk0HvWTqXilduD
	PcoFo9sitvNKcvlTVjE6eZph4alt5HQd9N8cMJxw5/dYcAZGKU/h22W5Turi25d44VrxH0M9WH+
	6QaSaCicXtwGwVLR6tp8h4DPtP2FGCEDBG/QwNy/lS/CUgT6u8zNiOt/NnfgQdReDOdarZI+Lqu
	nHX6VkBey+qQ16ER7gMtFB+RfOoAsmUKZqQKaCpktXb4AtbuYhdVGJNOn/w5E+ko3BrYTU5ohh2
	EabPt+5Q8Zi8dYI2LatvFKzBhMiChxS50NkGGDB6dz7hr/f+b1hCWiI+oLJR3SS6FnXEC19RKRg
	5sEq3BPRlpgf9m8rN0Ib/wDr1i8BfXckOQYWPsjUW38thpP4e9E2kJffPqL+loEGhO3ArTVtNwz
	7QVsEev/MKcL6eao/4CWA/n30vbonjlXLleI/eEVSS0iCBIH+85IAEZShKLr4AoYKZNqgHjNOOJ
	Rglujqhkoq+QgFCK5q4wCy2g/cw7qowVh9qGfgTray3axeanKeo4Ca1O6FynUm2qw+RdK0dql4w
	ysa4Ez6xbnesxbxxeIyVOvCqHRyolT7xeHZ7VObaLlf8WKYRgb0pYOOXE87fUpzkuWUOPnVamHx
	fE78DkwQB5/8VNXyu6V5xyTPerCTOiMPbQRBajqIBJKCDnyHi6d5V47JeRmR/MjvWeQQy+MI4ag
	==
X-Received: by 2002:a17:90b:3846:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3b0db6218d4mr210624a91.4.1793911586474;
        Thu, 05 Nov 2026 12:46:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4694a0e0sm2667533a12.20.2026.11.05.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 12/35] bpf: Compare states of different iterations of a loop
Date: Thu,  5 Nov 2026 20:44:49 +0000
Message-ID: <20261105204513.2230344-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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

Selftest loop1, nested_loops():

  for (j = 0; j < 300; j++)
      for (i = 0; i < j; i++) {
          ...
          sum += i * m;
      }

Scalar evolution counts both loops, but has no closed form for sum, and the
verifier checks sum: it is the return value. It walks such a loop: it
verifies the iterations one by one, each with its own values, as it does
today. A join of j=5 and j=6 ends that. Thus a state has the number of its
iteration in each loop that is walked, and flow_trips_behind() tells the
merge, the code that puts a state into a set, which states not to join.
But then the states of all iterations stay in the sets, up to the limit:

  more than 1024 states that cannot be joined at insn 10

A walk only goes forward: what follows a state of iteration N is of
iteration N or later. flow_earlier_trip() finds the states that are two or
more iterations behind, and the merge frees them. nested_loops() then has
21 states at a time and takes 9954 insns (today: 5505 and 316200).
lavd_init and qmap_init of rust-bpf fail in the same way.

Crate spin, Mutex::lock():

  while self.is_locked() { R::relax(); }

No iteration changes what the verifier sees: each ends in the state of the
one before, with a larger number. Thus in a walk of a loop without a count
a state of an earlier iteration can cover a later one. flow_trips_near():
the merge drops a state that a state of its own iteration or of the two
before it covers. If only states of one iteration are compared, 164 of the
225 progs of the schedulers of rust-bpf take more insns, 9 % in sum.

The drop closes a cycle: the earlier state leads to the later one and now
stands for it. "No state returns to the head, so the loop ends at run time"
does not hold any more. Thus flow_cycle_closed() gives the loop a may_goto.
It does nothing if the loop is counted, or if may_goto or bpf_iter_*_next()
stops each iteration. It rejects a loop that has no place for may_goto.

flow_within() is 'covers' for the merge: the comparison of pruning, also of
the states that entered each counted loop: its ranges come from them.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 8daee1f22461..f17eb3467708 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1469,3 +1469,176 @@ static int flow_unite(struct bpf_flow *flow, u32 a, u32 b)
 	u->b = b;
 	return 0;
 }
+
+/*
+ * What is known about a counted loop comes from the state it was entered
+ * with. @t stands for @s only if that holds for these states too.
+ */
+static bool flow_loops_within(struct bpf_verifier_env *env, const struct bpf_verifier_state *t,
+			      const struct bpf_verifier_state *s)
+{
+	const struct loop_stack_entry *lt, *ls;
+	u32 fr, i;
+
+	for (fr = 0; fr <= t->curframe; fr++) {
+		if (t->frame[fr]->loop_stack_cnt != s->frame[fr]->loop_stack_cnt)
+			return false;
+		for (i = 0; i < t->frame[fr]->loop_stack_cnt; i++) {
+			lt = &t->frame[fr]->loop_stack[i];
+			ls = &s->frame[fr]->loop_stack[i];
+			if (!lt->terminates || lt->entry_state == ls->entry_state)
+				continue;
+			if (!ls->terminates ||
+			    !bpf_state_subsumes(env, lt->entry_state, ls->entry_state))
+				return false;
+		}
+	}
+	return true;
+}
+
+static bool flow_within(struct bpf_verifier_env *env, struct bpf_verifier_state *t,
+			struct bpf_verifier_state *s)
+{
+	return t->curframe == s->curframe &&
+	       t->frame[0]->subprogno == s->frame[0]->subprogno &&
+	       /* an async callback returns to the kernel, a call of the function to its caller */
+	       !t->flow_entry == !s->flow_entry &&
+	       bpf_state_subsumes(env, t, s) && flow_loops_within(env, t, s);
+}
+
+/*
+ * How many iterations is @t behind @s, in the loop in which that is the most? Only the loops
+ * whose iterations are kept apart are looked at.
+ * 0 if both are in the same iteration of every loop, U32_MAX if @t is ahead of @s in a loop.
+ */
+static u32 flow_trips_behind(const struct bpf_verifier_state *t, const struct bpf_verifier_state *s)
+{
+	const struct loop_stack_entry *lt, *ls;
+	u32 fr, i, behind = 0;
+
+	if (t->curframe != s->curframe)
+		return U32_MAX;
+	for (fr = 0; fr <= t->curframe; fr++) {
+		if (t->frame[fr]->loop_stack_cnt != s->frame[fr]->loop_stack_cnt)
+			return U32_MAX;
+		for (i = 0; i < t->frame[fr]->loop_stack_cnt; i++) {
+			lt = &t->frame[fr]->loop_stack[i];
+			ls = &s->frame[fr]->loop_stack[i];
+			if (!lt->apart && !ls->apart)
+				continue;
+			if (lt->trip > ls->trip)
+				return U32_MAX;
+			behind = max(behind, ls->trip - lt->trip);
+		}
+	}
+	return behind;
+}
+
+/*
+ * A state is compared with the states of its own iteration and of the two before it. The older ones
+ * are gone, see flow_earlier_trip(), but for what is pending or waits: every iteration of a loop
+ * calls a recursive function, and what comes out of it goes to all the calls at once.
+ */
+static bool flow_trips_near(const struct bpf_verifier_state *t, const struct bpf_verifier_state *s)
+{
+	return flow_trips_behind(t, s) <= 2;
+}
+
+/*
+ * @s is within @t, and from now on @t stands for it.
+ *
+ * A walk on patience gets to the end of a loop when no state comes back to the head any more.
+ * Then the loop ends at run time too: the number of the iteration grows at the head, nothing makes
+ * it smaller, and there is a largest one.
+ * If @t is of an earlier iteration than @s that is not true any more. What becomes of @t got to @s
+ * and is @t again: as far as the verifier can see the program goes around for ever. A spin lock
+ * is such a loop. So the loop gets may_goto.
+ *
+ * It's asked for every loop that @t is behind in, not only for the outermost one. This is the only
+ * way for the number of a loop to get smaller. In a walk it doesn't change in another way but at
+ * the head: a state never stands for a state of an earlier iteration, see loop_stack_safe(), and it
+ * takes the place of, or is joined with, states of its own iterations only, see flow_merge().
+ * Where the iterations are not kept apart a join has the larger number, and a state may stand
+ * for one with a smaller number. Such loop has a count or may_goto, or something stops it, since
+ * the state entered it.
+ */
+static int flow_cycle_closed(struct bpf_verifier_env *env, const struct bpf_verifier_state *t,
+			     const struct bpf_verifier_state *s)
+{
+	const struct loop_stack_entry *lt, *ls;
+	struct bpf_loop *loop;
+	u32 fr, i;
+
+	for (fr = 0; fr <= t->curframe; fr++) {
+		for (i = 0; i < t->frame[fr]->loop_stack_cnt; i++) {
+			lt = &t->frame[fr]->loop_stack[i];
+			ls = &s->frame[fr]->loop_stack[i];
+			if (lt->trip >= ls->trip)
+				continue;
+			/* counted: what comes back is expected to be within what is at the head */
+			if (lt->terminates && !bpf_loop_walk_may_give_up(lt))
+				continue;
+			loop = env->insn_aux_data[lt->loop_id].loop;
+			/* it goes around for as long as the iterator has elements or may_goto budget */
+			if (loop->rt_bounded)
+				continue;
+			if (!loop->has_guards) {
+				verbose(env, "loop at insn %d never exits\n", lt->loop_id);
+				return -EINVAL;
+			}
+			bpf_flow_loop_gets_guards(env, lt->loop_id);
+		}
+	}
+	return 0;
+}
+
+/*
+ * @t is of an earlier iteration of a loop whose iterations are kept apart than @s.
+ * What comes after @s is of later iterations too, so @t is not going to be
+ * of use. If something of its iteration does come it is looked at again.
+ *
+ * Not so where a state stands for many iterations. States of different kinds are at the head of
+ * such loop. One of them comes to rest early, and what comes around is within it for as long as
+ * the others take.
+ */
+static bool flow_earlier_trip(const struct bpf_verifier_state *t,
+			      const struct bpf_verifier_state *s)
+{
+	const struct bpf_func_state *ft, *fs;
+	u32 fr, i;
+
+	if (t->curframe != s->curframe)
+		return false;
+	for (fr = 0; fr <= t->curframe; fr++) {
+		ft = t->frame[fr];
+		fs = s->frame[fr];
+		if (ft->subprogno != fs->subprogno || ft->callsite != fs->callsite ||
+		    ft->loop_stack_cnt != fs->loop_stack_cnt)
+			return false;
+		for (i = 0; i < ft->loop_stack_cnt; i++) {
+			if (ft->loop_stack[i].loop_id != fs->loop_stack[i].loop_id ||
+			    ft->loop_stack[i].apart != fs->loop_stack[i].apart)
+				return false;
+			if (ft->loop_stack[i].apart &&
+			    ft->loop_stack[i].trip != fs->loop_stack[i].trip)
+				return ft->loop_stack[i].trip + 1 < fs->loop_stack[i].trip;
+		}
+	}
+	return false;
+}
+
+/* Can flow_earlier_trip() be true for a state and @s? */
+static bool flow_has_earlier_trips(const struct bpf_verifier_state *s)
+{
+	const struct loop_stack_entry *entry;
+	u32 fr, i;
+
+	for (fr = 0; fr <= s->curframe; fr++) {
+		for (i = 0; i < s->frame[fr]->loop_stack_cnt; i++) {
+			entry = &s->frame[fr]->loop_stack[i];
+			if (entry->apart && entry->trip > 1)
+				return true;
+		}
+	}
+	return false;
+}
-- 
2.55.0

