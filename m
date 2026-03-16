Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF2372684;
	Mon, 16 Mar 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650116; cv=none; b=bWJh4fEoTs6e+MG4yI44dQo/zMng1KKts1P8WJleLbhsC/kIxsXn4+9w0XhkUS1eui0W0DwXmvAgwgGaXsy+qxzZ8qVVLG+zEAGho9k0kq4pCDZid1oUpboG0YgzZlq9Mw+vavAk2G0N1GX204gmUfW40z2fpTKkvfa0e2jku5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650116; c=relaxed/simple;
	bh=yyB7Xc2VFt+2AztXEbknRu9X2dBM4czY1jzpWiKP5i4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WLdg5l6o0fcAjPfghBcWZgCEl8a0ZahOIURf4qaxFQjQ5v7UzIJRK44uG0wbm9j++mUTnAkLYpvLo8gp+d7Uf4VWzYNvHs07zCu/bMPHUL4oorMWSfPkMA3NxGgYp8lKDunr2XoQbhQ4mpbQfukB+TlYQHPS7PSIcVQWqNsNaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0SqaIvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0SqaIvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E418DC19421;
	Mon, 16 Mar 2026 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650116;
	bh=yyB7Xc2VFt+2AztXEbknRu9X2dBM4czY1jzpWiKP5i4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=F0SqaIvtVpuua/wvdKffXY5n4eae3PMQgmoSWU+1NZRhoJIytGF8CILlzDiJA2EeV
	 +U7RtyU1vnJB1zO6GIr1GKppyVrMj4BQ1c1zc81Orqh9Wz4IY/weszSrf7tzKTA+gA
	 q8YrgVxz3Bp5qNIM0QPN3QG58sWOC0tHKVnkrZHZWc1gVIWBCXzioF9A+hbQPExRKe
	 gzbv9AjLGZUUJGo0Xrkv0geX+8HhJV0d+TfhbELvOCIS7Fa13k+1LzT7q3GS30b5wL
	 pxyxCDpnT3LFpxo44aS9CJw/KOyIKB1rbUF0o9NYTTf+vcNunCPFU9E82iwVFvdkVj
	 zeNoXAk/OyDKA==
Content-Type: multipart/mixed; boundary="===============5043058372494968077=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d97442169a77b667c7f12664cd684f51a8914d4e2c05ef64344aacaae11c3415@mail.kernel.org>
In-Reply-To: <20260316075138.465430-9-jolsa@kernel.org>
References: <20260316075138.465430-9-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 08/24] bpf: Add bpf_trampoline_multi_attach/detach functions
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 08:35:15 +0000 (UTC)

--===============5043058372494968077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The detach works as follows:
> - we lock all the needed trampolines
> - remove the program from each (__bpf_trampoline_unlink_prog)
> - the trampoline_multi_ops passed in __bpf_trampoline_link_prog gathers
>   ftrace_hash (ip -> trampoline) objects

The detach description references __bpf_trampoline_link_prog, but the
detach path calls __bpf_trampoline_unlink_prog.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d55651b13511..9331cca8c0b4 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
> +			       void *new_addr, bool lock_direct_mutex, void *ptr)
> +{
> +	unsigned long addr = (unsigned long) new_addr;
> +	unsigned long ip = ftrace_location(tr->ip);
> +	struct fentry_multi_data *data = ptr;
> +
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		addr = ftrace_jmp_set(addr);
> +	return add_ftrace_hash_entry_direct(data->modify, ip, addr) ? 0 : -ENOMEM;
> +}

Unlike the standard modify_fentry() which calls direct_ops_mod() ->
update_ftrace_direct_mod() to update ftrace immediately,
modify_fentry_multi() only adds a hash entry.  The actual ftrace
update is deferred until after the link loop.

This matters because bpf_trampoline_update() unconditionally calls
bpf_tramp_image_put() on the old cur_image after a successful
modify_fentry callback:

    bpf_trampoline_update() {
        ...
        err = ops->modify_fentry(tr, ...);
        ...
        if (tr->cur_image)
            bpf_tramp_image_put(tr->cur_image);
        tr->cur_image = im;
    }

With the standard ops, the old image is already unreachable when put.
With multi ops, ftrace still points to the old image when it is put.
bpf_tramp_image_put() text-pokes the old image to skip fexit programs
and starts deferred freeing.

In the success path, the window between image_put and the batched
update_ftrace_direct_mod is brief (bounded by trampoline_lock_all).

However, in the rollback path below, ftrace is never updated at all:

[ ... ]

> +	trampoline_lock_all();
> +
> +	for (i = 0; i < cnt; i++) {
> +		mnode = &link->nodes[i];
> +		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
> +						 &trampoline_multi_ops, &data);
> +		if (err)
> +			goto rollback_unlink;
> +	}

[ ... ]

> +rollback_unlink:
> +	for (j = 0; j < i; j++) {
> +		mnode = &link->nodes[j];
> +		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
> +					NULL, &trampoline_multi_ops, &data));
> +	}
> +	trampoline_unlock_all();
> +
> +	i = cnt;

If a trampoline at index 0 already had programs attached through the
standard single-trampoline path, and __bpf_trampoline_link_prog
succeeds for it but fails for a later trampoline, the rollback path
restores tr->cur_image to a correct new image but never calls
update_ftrace_direct_mod.

At that point, ftrace still routes calls through the old image that
was put during the link phase.  bpf_tramp_image_put() has already
patched that old image to skip fexit programs and started the deferred
freeing sequence (percpu_ref_kill).

Could this leave existing fexit/fmod_ret programs on that trampoline
non-functional?  And once the percpu_ref drains during a quiet period,
would the old image be freed while ftrace still references it?

[ ... ]

> +int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> +{
> +	struct bpf_tracing_multi_node *mnode;
> +	struct fentry_multi_data data = {};
> +	int i, cnt = link->nodes_cnt;
> +
> +	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +
> +	if (!data.unreg || !data.modify) {
> +		free_fentry_multi_data(&data);
> +		return -ENOMEM;
> +	}

bpf_trampoline_multi_detach can return -ENOMEM here without detaching
anything.  In e80a839e3d2c ("bpf: Add support for tracing multi
link"), this is called from bpf_tracing_multi_link_release():

    WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));

If detach fails, the programs remain linked to the trampolines via
mnode->node.tramp_hlist, but the link (and its embedded nodes array)
is freed by bpf_tracing_multi_link_dealloc().  Would this leave
dangling hlist entries in each trampoline's progs_hlist?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558
--===============5043058372494968077==--
