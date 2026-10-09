Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D44749C0
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547667; cv=none; b=lyScqGYz5Daco9+Ttm/B+x7HSVTYHOJ8hbzWCqTOApgXaA5pRh0zpFscElGnXGRfD9tANT3/11+1/njo4Jly58l3HySSq3PZJ+7GoqARB34uZRbugZLjaB2NyOqgroMsaRNbplSvee8NR9EcdULJ5XCDMu7RaFghnpSkbhJL4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547667; c=relaxed/simple;
	bh=bTNY5JS1e+wCuoiPQDOpAC0UVc844Dun68v9izq6Kdk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GnyvqVvDNOX9iLdSPrG5nqgp56oOf7769T/B0LZ5eOhQD2Y3AuNvkhkI+govOomEYegYAyTwSMcun0ApzzbWiwagqtjQ9m2mUSzu98c4+WFXLlCwY5b9aprRqYAYsQmSWQZvFN9nYMX9O0ie1py7STlfEis0S/pc8tRiqngt2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsHX6Tnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsHX6Tnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECE81F00898;
	Fri,  9 Oct 2026 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547662;
	bh=sxDW7q5FnNCINwrSNVpKnefLbMvgkvvR0pDOFnCsJFQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YsHX6TnzH5ZabZjzy7Ksj7om9ZLQ1AgC2KksTZn9xhQT0/R20cNPeLq6/lGvwV+rz
	 jDp+C5E1gIvVIj5QvjmW2Uc/9Dg9HmueLmdbM8sSeavFIfLW62dreV1aY7YHKI8bdy
	 R4LPCaUo6VKnRY57NWzduNZ93IyiaaxYi0ZNYkpum+E0RSxjDqdpQAvYKRAkHBC4ps
	 FobTClQc1BprwwFc3RwzVFCkHtcEkBk4oehvA7znl6NjK4kSn0pvE2LKYZDPd0HF05
	 xwrsewblAGrboKhf7teUS4OCt4T6HN1yMnkFv3ZLF8kZtB/bYLwMKlUW+dW8zjgC5L
	 RC8IM5T9qq4og==
Content-Type: multipart/mixed; boundary="===============2181850962011283839=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <614fc829598e2e9c69e71e1443fbeaa2914d48f6145e49565733887425963399@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-24-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-24-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 24/51] bpf: compute loop hierarchy
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:41 +0000 (UTC)

--===============2181850962011283839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: compute loop hierarchy

TL;DR:
- Per-loop-header allocation (~2.4 KB) is unbounded, so a privileged 1M-insn
  program may use GiBs of memory before verification
- Latch and exit passes in bpf_compute_loops() lack
  signal_pending()/cond_resched(), so deeply nested loops may stall a load

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 59c0670af0e9..d1ebbfef5455 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -655,6 +655,41 @@ struct bpf_iarray {
> +#define MAX_BACKEDGES 16
> +#define MAX_LOOP_EXITS 256

[ ... ]

> +struct bpf_loop {
> +	struct bpf_backedge backedges[MAX_BACKEDGES];
> +	/* edges exiting from this loop, includes edges from nested loops */
> +	struct bpf_loop_exit *exits;
> +	int backedges_cnt;
> +	int exits_cnt;
> +	bool irreducible;
> +	bool backedges_overflow;
> +	bool exits_overflow;
> +};

Each loop header gets its own struct bpf_loop with backedges[MAX_BACKEDGES]
embedded, which is roughly 408 bytes.  On the first exit, add_exit() also
allocates the full MAX_LOOP_EXITS array, 256 * sizeof(struct bpf_loop_exit) =
2048 bytes.  That is about 2.5 kilobytes per loop header, and there is no
limit on the number of loops in a program.

A privileged loader can submit up to BPF_COMPLEXITY_LIMIT_INSNS (1M)
instructions, and back-edges are accepted for it.  Consider 1M instructions
of the form:

    if r1 == 0 goto -1

followed by exit.  Every instruction is a self-loop header, so
compute_loops_in_subprog() calls assign_header() and then mark_as_header()
for each one, which does the kvzalloc_obj().  Each one also has an exit edge
to the next instruction, so bpf_compute_loops() calls add_exit(), which does
the 2048 byte kvcalloc().

Can a single BPF_PROG_LOAD allocate about 2.4 GiB (around 2 million slab
objects) this way before do_check() gets a chance to reject the program?

The existing per-instruction struct bpf_insn_aux_data is about 160 bytes, so
this is more than ten times the verifier's per-instruction footprint.  The
allocations use GFP_KERNEL_ACCOUNT, but privileged loads are not serialized
by bpf_verifier_lock, so concurrent loaders add up.  The commit message does
not mention the memory cost.

Would it make sense to size the exits array on demand, and to keep the
rarely used backedges array out of line?

[ ... ]

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> index 0db823ee42f7..8a6dc805e559 100644
> --- a/kernel/bpf/loops.c
> +++ b/kernel/bpf/loops.c

[ ... ]

> +static int add_exit(struct bpf_loop *loop, int from, int to)
> +{
> +	if (loop->exits_overflow)
> +		return 0;
> +	if (loop->exits_cnt == MAX_LOOP_EXITS) {
> +		loop->exits_overflow = true;
> +		return 0;
> +	}
> +	if (!loop->exits) {
> +		loop->exits = kvcalloc(MAX_LOOP_EXITS, sizeof(*loop->exits), GFP_KERNEL_ACCOUNT);
> +		if (!loop->exits)
> +			return -ENOMEM;
> +	}
> +	loop->exits[loop->exits_cnt] = (struct bpf_loop_exit) {
> +		.from = from,
> +		.to = to,
> +	};
> +	loop->exits_cnt++;
> +	return 0;
> +}

Related to the above, add_exit() allocates the full MAX_LOOP_EXITS array
(256 entries, 2048 bytes) on the first exit of a loop, even though most loops
have only one or two exits.

Together with the struct bpf_loop allocated in mark_as_header(), this is
about 2.4 kilobytes per loop header, all of it charged with
GFP_KERNEL_ACCOUNT and alive until the end of bpf_check().

Could the exits array start small and double on demand up to MAX_LOOP_EXITS?
That would keep the same overflow semantics.

[ ... ]

> +int bpf_compute_loops(struct bpf_verifier_env *env)

[ ... ]

> +	/* find latches */
> +	for (i = 0; i < len; i++) {
> +		loop = aux[i].loop;
> +		if (!loop)
> +			continue;
> +		for (j = 0; j < loop->backedges_cnt; j++) {

[ ... ]

> +			find_dominating_conditions(env, backedge->from, backedge);
> +		}
> +	}
> +	/* find exits */
> +	for (i = 0; i < len; i++) {
> +		iloop = aux[i].loop ? i : aux[i].loop_header;
> +		if (iloop < 0)
> +			continue;
> +		succ = bpf_insn_successors(env, i);
> +		iarray_for_each(s, succ) {

[ ... ]

> +			if (bpf_is_nested_loop(env, sloop, iloop))
> +				continue;

[ ... ]

> +			for (t = iloop; t >= 0 && t != sloop; t = aux[t].loop_header) {

[ ... ]

> +				if (bpf_is_nested_loop(env, sloop, t))
> +					break;

Do the "find latches" and "find exits" passes need the same
signal_pending()/cond_resched() guard that compute_loops_in_subprog() has?

compute_loops_in_subprog() does this:

    if ((++i % 1024) == 0) {
            if (signal_pending(current))
                    return -EAGAIN;
            cond_resched();
    }

with the comment "guard against pathological inputs, just in case", and
compute_subprog_idoms() in the preceding commit does the same.  The two outer
loops over 'len' in bpf_compute_loops() have no such point.

For each exit edge, bpf_is_nested_loop() walks the loop_header chain of
sloop, and the 'for (t = iloop; ...)' walk calls it again for every
enclosing loop, so the cost is O(depth) to O(depth^2) per edge.  Likewise,
find_dominating_conditions() calls idoms_intersect() and walks idoms[] from
each backedge source up to its header.

Privileged programs may have up to BPF_COMPLEXITY_LIMIT_INSNS (1M)
instructions and back-edges are allowed for them, so these walks are bounded
only by program size.  This pass also runs before do_check(), so the
preemption and signal checks in do_check() do not apply.

On a non-preemptible kernel, can a deeply nested input make a single
BPF_PROG_LOAD run for a long time without rescheduling and without being
interruptible by a signal?

Would a periodic signal_pending()/cond_resched() check returning -EAGAIN in
the two outer 'for (i = 0; i < len; i++)' loops be appropriate, to match the
sibling passes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============2181850962011283839==--
