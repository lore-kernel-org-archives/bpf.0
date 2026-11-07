Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022756;
	b=aaSw8eL7SkOMgqtyPNBpXuN/k/punObDkj4WhmD6vKNSXKb3Aq/64pUwX2oLgNX7gulk
	 a5a9q4PIu3hXEglSaGmTFra3OH0oIPHXhMEKc7Jym+YI6ocTqlkzRXo2k9LODe48WA+nH
	 wwdGY42PClPgb5fPQXoL6YRyDeTB0KKA1XNW6sO6U4ph+5smnWLPYJnPGzERYwdwi54GQ
	 asBLiLUDTN3ceUebiDEh1DRma9obOvSNI7gviEMLFOKBS6C3Vp/RDGKxSD7lHDYs7mdAB
	 HWDaEbWqvIWF6CbCOm3XrngKjWlNASAT9EAGSKX6Yu/IBjqSKlO3DVy64/pUCRcJtQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9qVQ9DE4jhM9BVhg6Bn8+yO+9T9OrsJvbvBg6yaufdY=;
	b=OeYyFr09Pmhd2KCY0F3BHCBOSxdbNFUemGLss5uNVr3s3LzWvGqKAjGEXKB+9fkyfl/s
	 1/tzxdAPxRn1W4bGpqM8Nud/y7r3HAHkMPDyOTfXy0crBFaam2QWYU4TjCgW5ge/Sm20M
	 1E8QMZOmBix6Cn/X1czH5mO9lAfF3O705Y7s0ao5uxsw/jMp+Cc0rV629dcSGlO0xJxGQ
	 Tky4ISQEZ2yXl7kUeYoS0zv4G8yzPwj7VaWDoTPHdM+nS3vv5slvI4r0+DU853nwIoWOM
	 YJJilOAAOOd+4mdDwm/Js+oGAtoU16PqvuvaXa8YvMNfUkU4nvIyQNPQ38HfUd7It7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rO8xeeeE;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237C606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0237C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rO8xeeeE
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9995ce866so9460275ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022755; x=1794627555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qVQ9DE4jhM9BVhg6Bn8+yO+9T9OrsJvbvBg6yaufdY=;
        b=rO8xeeeENfsSnaj3zbXd+Q5JTDB7f5mOt0ZfU0awzcysSLEj3QrU0Wujq/e/QIiza+
         EyLWAkdf3UVdUZHEm7sniJQsD7Efz78Vv+Q0s+QE2jcUSF4ybvfHvYih1YkLfXZ/IQI7
         EluMGMTds/rAxbwBNrhYgJJyWMTgcZg6ie1cNwEMYfbzzpHSkkr1e2wKSBNlaKI4Rfuz
         QRRQX6mEt+Ae4qTkY/Puzxd6/Z1G5wSY21An9IPin+qu7O5HVpf9AgzukSMkiMxa3w5M
         MdYSEQNFKmx7nkuQEEaPEVFM1o2y3Supxh5s4pneReXKlgcozotiOni3ckGAa5r44gZT
         3+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022755; x=1794627555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qVQ9DE4jhM9BVhg6Bn8+yO+9T9OrsJvbvBg6yaufdY=;
        b=lX9WNlGL9N8/W5pIKof4pOc7BJANVQqWuIsQDLxC7jDh76lqTUQJ5R2fWNZK9sH5Et
         qLbcN/UATiH0KXh4iWSnrcEeWq8qMdf6bF6WqE2bya3TRi+7BtBODo49louDjkzli7tC
         /3wY2BkBQNyhkwYefO0eSqgMhqNQgv+Qdr3Mzg/fV4bl6ezkrLB0OEocGIKdHLDsJ9oF
         Wlt8DleKV0u0hGL8dSvHIRF7Xg0EDKlOPFSDyspg8nMiafK7oEk+inhOcJzsUG98LMz5
         +HKMGVUchdSShch3g0bwVUePTGF2yTfYS6riyMhtjEjiRoresrueb8FJ1H6n68C8/1u5
         flxQ==
X-Gm-Message-State: APuU4Z9hDNEC38C6AOo33hiBBxD74VxYTlKfVB1U7MALhGVXPsdi7vPd
	IvhcaY9lSyRt8R2U6kfccZ7zA3Dtm39T8MwGxe91eG2WdPIDt7oJwZu97vJ7iw==
X-Gm-Gg: AYBFou0jLp4QTjQC9quKxWFsZSyKdps02/WBgjwqYlLx+ybMwdJRJ7eW7ZBBXeC+lpJ
	FRXwR9pc7d2d26IwOaW+QPPy98qiq0dwBDAO1es3C+v6DSGJ3kJ9+oIU73j7aElNpX+Rr0kGA94
	I6k+X3UAuMbo/+Nukq8NluqKLYlHL5L5GwQNeaj1c+IY0oO28rSlro7QIkk60AOQmoWcu18Fi6N
	a1UZrhLsSfvAjGkhV0UR0zhHqBjaF2vusaSFzhrZwMYyN2fvvwmwgKmJzRfC1l8IR+5lodkUWFU
	zS5ojXmgu/f3HclfhhxD2dbqndsOddc7Atvn9Co4fjjgv+rXMEhwX5wTVd7nTBDIpUKu+jtGJSD
	VwhUV3h90TfP+UI7ywZ8UfSP7FmULwBkexzPUlRBF4vc5N0NApTJrKZF4lEdC8IaxfzyQ/3Ot2R
	vhh60zu2Oic10/yErAT33Q61JE1JM9xlfnk01xq1JknaSkiHvtLgkTyWf8qtxRIiZ6Nj348xRw+
	TjslkQa0wgsm4YRdYOrAlh3J3B03jFgmILZJUEgKmaZzNRpO9MLeElmufBe+LmZlL4B18pUnrDh
	SkFOcfU0umO9XbBWQ9hiXUs3HxgjPDfEY4pUItbkBiEmhejz+UVvj4K8CAgXQryrBD1tRN7kMjr
	rtvqT/s5R9bvt673eNrM1X7saJHEyXZqcQuf/vnkhD9tWn4qKo2WsU3KFg3I6QDQZVXTVhDGfQg
	==
X-Received: by 2002:a17:902:fc8d:b0:2e4:aa09:fa9f with SMTP id d9443c01a7336-2ed41e84974mr51515135ad.57.1794022755167;
        Fri, 06 Nov 2026 19:39:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed6d5387dcsm828375ad.21.2026.11.06.19.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:39:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 12/46] bpf: Compare states of different iterations of a loop
Date: Sat,  7 Nov 2026 03:37:20 +0000
Message-ID: <20261107033758.1547725-13-alexei.starovoitov@gmail.com>
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
index 3996220f89f0..19b502bcb57c 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1476,3 +1476,176 @@ static int flow_unite(struct bpf_flow *flow, u32 a, u32 b)
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

