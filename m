Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211504;
	b=u3dN7dk6De58ZXzPt/Nfg6NyzXEjpe+rlLkSwzjrEib/KCLr3F6885Z2PTJCbzS8U9Y8
	 ZiQVmBYi9K51w8vJ0hNzQQfQwMuc5IEFyXbw4ywLQFj9RpVDS0Ji+wUWeysDnHAzPXalF
	 1Y+BmW5GT0MGj21xL6b9E4TUwQXy8rVcHIbF6kihaneVFTXxZMPkDT11n1Di9rGnuUzxQ
	 ySoRPqFctSVt/EEoI/JaRGx+/Jn6BXzdebvBdAg6bK9/NMWlWwkpOYgUXnLy4Fi3kXbJh
	 +mgjugy1q8Ak3c1pXfRnDMomR96wzvt4QbP/8eOw3SRgrnu9XB7/KHRTDrJN2O1rgzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211504;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=SerjQix9QwYXxhmz9cCzQd3AqAKE4dYWOJDEoeFGd+s=;
	b=UkY4zJif7eOL8Lmzn0CwhnyiNVh6DEF+c4tK9uwaSRbEKtDe8W0QiJi8fehmezRpMhEa
	 V3e3QdYB9sR7JQ0n4Lng+fLkcCwEf3wVZONLgVaVqgazDgBFQre/+SZVtevvPFEajthTq
	 uW7BR/mEIfv+gtje4fum5O493kWsyJEOK/l7b3ycKiTT98o5pyjyjNvO4xY0WLXdVQqRM
	 Jlzw6JGCqrDaihhtbN9lVgO3M/GnzfuIS6kwp3JSNUOt3YWb8lazu6+8buYg2UY3XeUrC
	 Tt1mSs2PwPNj7eDYE9+44Wdwof8mMYmMpcgXbCakt2MpPZuBWo6st7+7wPPGsxyG6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNiBoJCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE879606A6B5
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNiBoJCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D11A1F000C0;
	Fri, 20 Nov 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211503;
	bh=SerjQix9QwYXxhmz9cCzQd3AqAKE4dYWOJDEoeFGd+s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NNiBoJCGRQHhGzYWWJk2HNftG8gJzA7H7QODA7hIwOJWRliQ/4garYnLRi5SDrc+c
	 brt22R271bb4njOk9Oh5UG77997+dbBH4s0sOF8n/XW6Nc9YEtK+8ZRGaPd7xcIPUV
	 56+2rYNEixP2TRsrtcRk3dg3+WxbaycEz1rgjIgFke4/Gqv84RDKT09NPauSb9D5wS
	 m5O2Xq51wDClbHi4cR4uJHpEm31R5XE+cAN5BPfi86Ql7Tv2BJLEcLpa/rajtBfl49
	 g7xJ6/ubXqxxYRVE/7N7tlKIfKVE0wS/uMCJmD0MaAtEVGZ/6vt3UmxPJFqP1zOIfM
	 Pp+Hklk7VS0fw==
Content-Type: multipart/mixed; boundary="===============7566138775493753925=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <99ced36430b2a6667912c1987d2c87fe138c8c670cee01af0d919c9cab8229af@mail.kernel.org>
In-Reply-To: <20261120204959.614908-22-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-22-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 21/49] bpf: Compare states by join_key, then by value
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:42 +0000 (UTC)

--===============7566138775493753925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Compare states by join_key, then by value

TL;DR: join_key has 4 bytes of tail padding on 64-bit, despite the "no holes"
claim. Its memcmp/hash could differ for equal states, possibly blocking
pruning and joining (precision/complexity loss, not safety).

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -603,6 +601,8 @@ struct bpf_verifier_state {
>  	/* the loops that made an xreg of data_deps imprecise, see bpf_loop.suspect_bit */
>  	u64 suspect_loops;
>  
> +	/* equal in states that have a join, see bpf_same_join_key(). No holes. */
> +	struct_group(join_key,
>  	struct_group(held,
>  	void *active_lock_ptr;
>  	u32 acquired_refs;
> @@ -611,9 +611,8 @@ struct bpf_verifier_state {
>  	u32 active_rcu_locks;
>  	u32 active_irq_id;
>  	u32 active_lock_id;
> -
> -	bool speculative;
>  	);
> +	u32 curframe;
>  	bool in_sleepable;
>  	/* a global function or an extension, and what it calls: exit of frame 0 is not the end */
>  	bool callers_unknown;

[ ... ]

>  	u32 flow_entry;
> +	);
> +	/* Not zero in a function that is verified on its own, see bpf_flow_call() */
> +	u32 instance_id;

Is the "No holes" comment accurate on 64-bit?

The members of join_key add up to 44 bytes:

    held (void * plus six u32)    0..31
    curframe                      32
    in_sleepable..changed_pkt_data   36..39
    flow_entry                    40..43

The void * gives the group 8-byte alignment, so sizeof(st->join_key) is 48
and bytes 44..47 are tail padding.  The commit message also says "The group
is compared and hashed as bytes, so it has no padding."

Both users read those bytes:

    bpf_same_join_key(): memcmp(&a->join_key, &b->join_key, sizeof(a->join_key))
    bpf_hash_join_key(): bpf_hash64(&st->join_key, sizeof(st->join_key), ...)

The padding is zero in practice, since states come from kzalloc_obj() or
'= {}', and bpf_copy_verifier_state() copies the group with
'dst_state->join_key = src->join_key'.  But C does not require a struct
assignment to copy padding.  If two states with equal fields ever had
different padding, they would compare unequal and hash to different values,
and would never be pruned or joined.  That costs precision and complexity
rather than safety.

This is the same problem that is avoided for struct bpf_retval_range by
turning return_32bit into a u32.  Would it make sense to move flow_entry out
of the group (or add a 4-byte member), and add a BUILD_BUG_ON() on the size
of the group so the "No holes" claim is enforced?

The later commit 699ddfe056ce ("bpf: Verify a static function once for each
instance") removes flow_entry, which leaves a 40 byte group with no padding.
The commits in between, for example eddb572e724e ("bpf: Join any two states
that have the same join_key") and 8514cc01b0e8 ("bpf: Prune or join each
state that arrives"), use the padded layout.

[ ... ]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> +bool bpf_same_join_key(const struct bpf_verifier_state *a, const struct bpf_verifier_state *b)
> +{
> +	const struct bpf_stack_state *sa, *sb;
> +	const struct loop_stack_entry *ea, *eb;
> +	const struct bpf_func_state *fa, *fb;
> +	u32 fr, i;
> +
> +	if (memcmp(&a->join_key, &b->join_key, sizeof(a->join_key)) ||
> +	    a->instance_id != b->instance_id || !same_refs(a, b))
> +		return false;

This is the same padding question from the struct definition: the memcmp()
of sizeof(a->join_key) covers the 4 bytes of tail padding on 64-bit, and
bpf_hash_join_key() hashes the same range.  Equal join_keys with different
padding would not match or hash alike, so such states would never be pruned
or joined.  Could flow_entry be moved out of the group, or a BUILD_BUG_ON()
added on the size of the group, until 699ddfe056ce removes flow_entry?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============7566138775493753925==--
