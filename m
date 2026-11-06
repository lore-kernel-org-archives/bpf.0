Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937144;
	b=Ihy/+6imdUpETPSINsJKXBF9R/cb5VewaTESdcdusxxzP6IyECC7MjcyZtw32nvQ52w0
	 xDyovMbArgpko/WVUJhIUqsZfTPRIKm+mjZokpO73mt9nGYtVrAdlQ4dbm/DiT7wykiIu
	 Un5M16Oi4dGmJc4kiuV5n2yOvRgvy3VZacQwrBcUFRyFYRdM4Wqh+rdXJ7KF5EDfKr6GI
	 pWc4DgFWqORmynnhs3RIZqzg+1qGtCE33VHXNBh3dYq/VWFM62HiKGwW0FGMHqFYb1lfy
	 8rY0+fOE/zTEG3bdplzmLEl9iqvPAf1DS+ezSf2kc7dedovaZG1D+KXNDMtFDMaaQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lnEXSfU2S2Z0ognkz5FaE/LD4V+FT3fwjICuvc+dgmI=;
	b=rM8laebac0uZlEhlMFb0HqHlgWWkRomKRXsvFFM6YJ6KprywAyzaPUSUwJHgV/o8oe7x
	 LfENAtEqjsjNo8hRfkUOB6s3cW9rT5WPGBWPLGAmSVWSkUAcwollRLpkMfc99XLb5CIl8
	 MKZFopiRu+0tZyWVDDdnV/Wa8FuHxBGxoixivMyDVKU9izgRPfL0iNtvV95Vf/sYHv/Ol
	 Zq1eFnEhqu7zt/lZWJYGTpckFumzjWZAQcjqmuWH4atPqAYbQQ0t9RDr5gy7th4NAbQul
	 U1xf4SJqJd3IG2/eFl8UVQyWJEDFjRPpGy8EYpbO5fjfzIfg9C0PX0OZYrjkrFy5/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XILrUO9w;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8E606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XILrUO9w
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea7190aea1so706145ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937144; x=1794541944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnEXSfU2S2Z0ognkz5FaE/LD4V+FT3fwjICuvc+dgmI=;
        b=XILrUO9w+ySCpcUmt80GdD8kz++EC6LrEZXsQmt9PAl9xgC4uemQTh8bZVVylB16/A
         8IktS3fdMrIymdFaIpb1z/u75fYJ36yXVAiQdmwUQnn9AuFdXwuvcvRAGIZyhlWWi789
         I/p3XTWTkc/BBQq4KHgd1l564Fmj530xrVnl4di80crHmVqQetUif/t3QdF1du80BDRR
         PLbcYk/tKKRUvqpYsIxlE/+ssw8r8e8dcBbxZQYVwYJvE3XoPg0jvpwF61WA0aZFO9GJ
         rJ5c2qvSXj3EfHJfBY81bhnGkezQ7/4pV/5IXVA8ic+80dfQJI7niC+QzNfZ8RuOYUHD
         qWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937144; x=1794541944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnEXSfU2S2Z0ognkz5FaE/LD4V+FT3fwjICuvc+dgmI=;
        b=clvTr0D1WJzrFQvl+f13i3XuN6Z1BTiPV/hCNAuWR78hiAWECRdGP4CIXyvkUkqBFa
         1UGJfrZnIB06G4N2YJ56ZPa8SFl1c3NKPHriqPlp32JhsAV31ruv1Td9TI7TiYLIoVkj
         SXOOojyzZ+L+PD2EXEKoJB/cAYx+gb3pQcbbMPxzIzP5u1jIbJfxDxL9v0wULk3mFzgs
         YrxGFJsdr/qqCj2KGkx4sayX72vcfep+q2WB7MmBPQCVJljRFjUFCqYb8kRtSHOCE4Vv
         ZyPL9c4Giq+Yi6M7jX3aXUNV1MX0/ZP4NFU/js2qEO/hhRqzrJGBWaXhdg8SqZY94vPk
         xTPQ==
X-Gm-Message-State: APuU4Z/P8fpCaEi0SP29rPar+iisQnikto2WtDQE3hDYMeDxs/d30PUl
	aG8ADfk+UedcfkLN/sRTq2f7zJ8FUaNqOADt3Ef2Rf6tZoehWd1zZdp4p3QPWA==
X-Gm-Gg: AYBFou2q45pxZ1J5Rao1E8sQMmse2qX8RS5ZLv9wjwJh3AWSPaNmrCa+z04Wmtg6vqR
	fl2Nyr9SEisbC/cDK9YXM3j35famuoi7KWxKuZuyJV8mn4ES9VNiAHnXtGYtdSm5uxzET+yfR3y
	ZiRQv7QQ0hIrnI/e0CBJJb9o8NqXA1wKN1eh36GdMBkoH3WozUN1bnkSmxArh9BYC+MBQ1uryDF
	/sFRNz05VcmhMFStXqj1andZdf9ZsHjWoSjdOy0x0L3kvq7hnIyhk7XU2LPeeUIEPOHj/SYbNb3
	r1BcxXNG5UDP3uI+WzVCJwbFWY77fnsUYmhIdZbIWDVGF/M+mdgSQK9yDzWHQ7hJYNmGt/GJ2Re
	KxcyyuQBK7+bf+hbKKv6AJTRC1gLTb1m/LRm5PkEYeVrMeSptmPwnprrqtW6jilyEBb3VkwYUe7
	O3AhWcj9FQWrxSGz9m4uNxPFnFDctPjulUgo1/VxyQBuLxrx1k2CDkMfmdEkGo/NEbZMFsuZKeb
	+cNyMHmxpD0nprRsKSZpkEazKDZXlBzL0+6tangKWsnRNRYBhDHRtXwhJdW1x7syrL1cth4MryX
	px/h6zDZuuG5gfdRtcEzWWqo+hGxJEwzTIlk07yMndEmsCTTyHm3STBhLnrmipMxc99GNoQDfR2
	lOz9sPDtcghaHSAqtKtFkzPftqvHDLu8mDxc3j+tz1u6pp1yk9C2f3jXr4P1IvAI3sVmTZQPcPQ
	==
X-Received: by 2002:a17:903:41c4:b0:2e9:5059:4477 with SMTP id d9443c01a7336-2ed40989abdmr19055525ad.23.1793937143626;
        Thu, 05 Nov 2026 19:52:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a97desm1309685ad.21.2026.11.05.19.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:52:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 12/45] bpf: Compare states of different iterations of a loop
Date: Fri,  6 Nov 2026 03:50:36 +0000
Message-ID: <20261106035111.3315285-13-alexei.starovoitov@gmail.com>
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

