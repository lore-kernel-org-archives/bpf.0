Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072B23E334
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885927; cv=none; b=Qh8N+LQl1bzOC5eMXa6immgNM4pz0aogYXItg/aIgQZDYb5gDmpHgPLnC2b3dd6tuTcXavL3rnz1HNkfjcnGISrGmH2baPikgAzB4InNCCqKTPJb2FeSs/PlF2buyH5NfeLCxy2Tpbk4j1ZnL63AojQW0hLvma03wL7RgrtV5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885927; c=relaxed/simple;
	bh=IdS7Xd6ZOGIB1atLr2WQu25HdB+qMttaX1xUouNxZOI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DSNSaDMYqAGU1m68IdrEa3Sn+QBrbiortZfJmqr1ynKqsvL7mVjtMZa5BW5SVzp89nvu5KKyW+7yuRPB/pUUVwQ4Kz+xgEmhIlbQj5AiHgxxmKR16bWlBVNNmtC7qXiNpS/ltAdW/kko0TV++SPexV33Kk7yXWAcVaEh8z+wI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWXc8j6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWXc8j6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4249F1F000FF;
	Sun, 20 Sep 2026 06:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885925;
	bh=UWOVAKwyWt8QPpSRZ4+L4ybEUCo1gHj0L/WN08gFOug=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PWXc8j6lnWEzbfYrAiFIouowXUcVWe0STpgGzTOAf3kyA9ZSNpjAEMvASjfuU2RR1
	 hPXqVjSmsO6GLL/EEA1bfmnNsJ9XXF/jC9mizN/CngNtvKjcNUOogi1nbCnduFdKZe
	 gEiaRyXuodn06JK1LLwIlarSV2nfxk4bgQwCwBGM37tFK85Mv3VmCQ0ZFFbW9rhlZB
	 5RBHpEO/LzYbTLn6uEsmmFIf1QbexEvgoykpfFyk8po6YZcc88XevVFVq6ELEeZ7Ji
	 6Q5fEgeYlmK/6GLgOVJCR+UbCKAXEU2U86+ds2qy/hvmN2k4nIzY9eyBdb/nC79PG4
	 JZTQfWRP73OqA==
Content-Type: multipart/mixed; boundary="===============6168351595801485270=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <13e6a8419b642616c50e7586ebd51734c456d19fcea3e3c6649f79b480093533@mail.kernel.org>
In-Reply-To: <20260920054301.867768-1-yonghong.song@linux.dev>
References: <20260920054301.867768-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 07/20] bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:32:04 +0000 (UTC)

--===============6168351595801485270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0cd7c27a50fa..382177b80745 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -683,6 +683,7 @@ struct bpf_insn_aux_data {
>  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>  	bool cleanup_throw_site; /* call to bpf_throw() */
>  	bool cleanup_resume_site; /* call to bpf_unwind_resume() */
> +	bool in_cleanup_pad; /* only runs with an exception in flight */
>  	/*
>  	 * 1 + the instruction index of the exception cleanup landing pad this
>  	 * call site unwinds to, or 0 for none.

Does the in_cleanup_pad comment accurately describe what the field
represents at this commit? The comment says "only runs with an exception
in flight", but cleanup_mark_pad_bodies() marks reachability from a
landing pad without checking whether the pad is unreachable by ordinary
control flow.

For example, with a record {begin_off=0, end_off=1, landing_pad_off=1}:

    0: call pcall foo        /* covered by the record */
    1: r0 = 0                /* landing pad, also insn 0's fall-through */
    2: call bpf_unwind_resume
    3: exit

check_cleanup_info() permits this (it only rejects a pad that lies
*inside* a call-site range). cleanup_reachability() gives pad 1 only
CLEANUP_REACH_RESUME, cleanup_pad_is_catch() accepts it, and insns 1-2
get in_cleanup_pad = true. Yet on normal return from foo, execution falls
into insns 1-2 with no exception in flight.

The next commit (c046fa312ea4 "bpf: Walk the exception unwind in the
verifier") adds the state->unwinding check that actually refuses this
shape ("bpf_unwind_resume() at insn %d reached without an exception in
flight"). Should the field comment say "reachable from a landing pad"
rather than "only runs with an exception in flight" until that enforcement
is in place, or does the check belong in this commit since the changelog
promises to refuse every cleanup shape bpf_throw() cannot dispatch?

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index cc7c8595dd64..4859d6484cc8 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[ ... ]

> @@ -37,6 +162,255 @@ static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)

[ ... ]

> +/* What every instruction can reach along intra-subprog edges, for
> + * cleanup_pad_is_catch(). One backward walk over a predecessor index, rather
> + * than a forward walk from each landing pad, which would be quadratic.
> + */
> +static int cleanup_reachability(struct cleanup_ctx *ctx)
> +{
> +	struct bpf_verifier_env *env = ctx->env;
> +	u32 len = env->prog->len;
> +	struct cleanup_cursor c = CLEANUP_CURSOR_INIT;
> +	u32 *head = NULL, *link = NULL;
> +	bool *queued = NULL;
> +	u32 i, sp = 0;
> +	void *scratch;
> +	const struct cleanup_alloc_req tab[] = {
> +		{ (void **)&head,   len,             sizeof(*head) },
> +		{ (void **)&link,   2 * (size_t)len, sizeof(*link) },
> +		{ (void **)&queued, len,             sizeof(*queued) },
> +	};
> +
> +	scratch = cleanup_alloc(tab, ARRAY_SIZE(tab));
> +	if (!scratch)
> +		return -ENOMEM;
> +
> +	/* Index the predecessors, and seed the walk at the terminators. */
> +	for (i = 0; i < len; i++) {

[ ... ]

> +	}
> +
> +	/* Each instruction re-enters the worklist at most once per bit it
> +	 * gains, so this is linear in the number of edges.
> +	 */
> +	while (sp) {

This isn't a bug, but could the two multi-line comments in
cleanup_reachability() follow the BPF comment style with the opening /*
on its own line? The other multi-line comments added by this series use
that format, and the guide requires it for files under kernel/bpf/.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============6168351595801485270==--
