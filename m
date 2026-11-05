Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914518;
	b=WuSH8m6VCSJKaumByXRjNRxQi4jk3jqNHiedZ3gO+1ioNTEUqC9EWw7bn9d7XBYYlLJf
	 8geiLyLuWD3KRh/6PkYiq1U09OWF1CVLqXWVvmR+GRwHjtLQDp9Zm2sfTjJ2tVyvF6pDU
	 KybfF7T5PA7p9ch/zXqer/vZpa/571UyWblAavHiHL6JguQL+nTVteM0O1oRPahpdrBZE
	 OEzx74ry+gptS3z4j2hpxYEB9BlmcvWeuw77LLuxBW+R9LleWoBof+0a96hOtQfQXs202
	 uy9WdxlhNb/EZ+UjoHykCUWS5t6Og+j9cHa6S1DKrkW2zH7Ww0NirZ1QSH/jJKLAWvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914518;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=s5upxJbA/t7Sb+dXUJHPA9zsouHVQteK6MPfOEu2hjg=;
	b=j8rbb2aLFbPlU22KgzsYxCXSTE4u55dqysOUCe+AOnCSkdp/TqMpGjtzn9xmKsA/rVRb
	 LtbS1VgzQViR/xbeTB4TDL64KiV1wsh48gVvS2j0KYA+/bT/XRXXLjXOfcn0He5oTHkmF
	 hqRhsqU32w/AbmG3+AVqZWDtzxaKroYcFDTBfow2EbCaGHbkw+1mZ4LHx0wyx9mMpagPT
	 CsvuqyvnCr92tqDNV5qUnkiu73Vfe7jDxDOwE9hmkbNCvZduyqp7U2HOXtHHjnH49QdGt
	 S9PeT9FRU/YBd7eRvylxNR+KdBxIqtvBCASyBoWUjFy32n1VuGZ8Z6Ey0lBB6+0Jh4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Akn74zw2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388D606A339
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Akn74zw2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFE91F0089F;
	Thu,  5 Nov 2026 21:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914518;
	bh=s5upxJbA/t7Sb+dXUJHPA9zsouHVQteK6MPfOEu2hjg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Akn74zw2CpRWOqzalXG70ektpcUDrfExcwA/3YLavdOWSNbrbb83CVGVnca+QDigS
	 Z2QtwvWp51zZ4qdRnjIJ++r7q+5DpMCF5O+KeL4k62AHNGCIhK4atzMn9oniJ7kYHr
	 6AbBALwUC2DA8s9PRWV86FA5qDM/R6pYMdzp/WGNNFdWyXUae2SDxWfkz6U+6Zc3Bx
	 BZbUnrpSkA3uD3cSBaeVXVnTr9XziPETac7jA+ocdZZZMoNJtrxLnmHTsJ7vei3xHG
	 AcFSzGkVeXClxQmUoXzuAdOTKqobISOEnPRPurQ5GTzltQbe7wjgjHmqfdeGwyfLRv
	 cqWDXCYJwxlWA==
Content-Type: multipart/mixed; boundary="===============3532816860953062628=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a99e51d9a9501d70c6f7b4010b00794b9e69b3d841ac6c0e00e9a0641c45ec32@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-14-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-14-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/35] bpf: Decide which states are not joined
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:17 +0000 (UTC)

--===============3532816860953062628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Decide which states are not joined

TL;DR: The "copies of a number" check in flow_join_makes_up() only looks at
state a's ids, so states may be joined that lose register links, costing
precision and order-dependent results; not unsafe.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +static bool flow_join_makes_up(const struct bpf_flow *flow, const struct bpf_verifier_state *a,
> +			       const struct bpf_verifier_state *b)
> +{

[ ... ]

> +			ra = flow_number_at(a->frame[fr], i);
> +			rb = flow_number_at(b->frame[fr], i);
> +			if (!ra || !rb || !flow_disjoint(ra, rb))
> +				continue;
> +			if (flow_gap(ra, rb))
> +				return true;
> +			/* copies of a number are one number */
> +			if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
> +				return true;
> +			one = true;
> +			id = ra->id & ~BPF_ADD_CONST;

Does this "copies of a number are one number" test only look at the ids in
state a?  It never checks that the same registers or slots are linked in
state b, or that a BPF_ADD_CONST link has the same delta there.

The join does not keep a link that only one side has.  In join_reg() in
kernel/bpf/join.c, the first pass calls
jid_note(js, ra->id, rb->id, scalar_link_consistent(ra, rb)), which records
nothing when rb->id is 0 and marks the pair bad when the deltas differ.  The
second pass then does:

	if (ra->id && !jid_good(js, ra->id, rb->id)) {
		dst->id = 0;
		dst->delta = 0;
	}

So when two registers are copies in a but not in b, the joined state holds
two independent numbers.

For example, in a, r6 = r7 in [0,1] (same id X).  In b, r6 = [2,3] and
r7 = [2,3] with no shared id.  Both are in FLOW_NEED_JUMP, and each pair is
disjoint with no gap, so flow_gap() is false.  On the second register,
id == (ra->id & ~BPF_ADD_CONST), so the function returns false and
bpf_states_join() goes ahead.

The join then has r6 = [0,3] and r7 = [0,3] with no link, which includes
r6 = 0 with r7 = 3, a combination no path has.  A later 'if (r6 < 2)' no
longer narrows r7.  The same happens when a has r7 = r6 + 10 and b has
r7 = r6 + 6: the masked ids are equal, but scalar_link_consistent() fails
because the deltas differ.

Is the result also dependent on argument order?  With the links in b instead
of a, the first number's id is 0 (or does not match), so the join is refused.
flow_merge() calls flow_join_makes_up(flow, &t->st, &s->st), so whether a
join happens depends on which state arrived first.

This cannot make the verifier accept an unsafe program, since the joined
state is still a superset of both inputs.  The cost is precision, which is
what the commit message says this change is meant to protect ("Two tested
numbers, each without a common value").  This function is unchanged at the
end of the series (e9cbd02faf11).

Would tracking the id of the first disjoint number in b as well, and
requiring both ids (and a consistent link per scalar_link_consistent()) to
match, make the test symmetric?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============3532816860953062628==--
