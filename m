Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD8220F2A;
	Mon, 10 Aug 2026 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786332965; cv=none; b=Sg0Rz22j6DaAbBMuGk4WEfKXguBQj2WmfMpmWHEF4zTNjpJoKwB21HspeElKbXCcRwLfqKq9nekweG28oJW28Fa7H/sqAcTaacq6Vp3elMggjwSDhxTRmjxfKWZEaVyT8WiEhSQ1ozkA8TP0Sq1ewBkG1QeAiwP1K1zDanT4ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786332965; c=relaxed/simple;
	bh=DZzBj23GObx/EgVeHWLrzwLQmN7Fj+ljD+CJScFSgmM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZdcLgCXQ+QKQay7pueOUA1u0LJW2IGnqdksVSOXNHiBo5EW/kZIZkkHx7ogTXFNMbvRQNjKx6o3YPoGIrUQ8gtyWRMOG2pE1D+1vIIvPunTph3eMs4TFhbETy4e/R6u65QYE9qnZk7KEUK6K7aBQhaTT7ujcDvPPnFctHjLj4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeo9DFD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeo9DFD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6C51F000E9;
	Mon, 10 Aug 2026 03:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786332963;
	bh=ZpA6IT7IVUI4TWWu39AWci3Bf0zBUGrgkkiP4lypyx8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jeo9DFD3Zt42eyX1Xl7wcC+/BC6u+Um6DtG6bwPuy1LXJNf/81euLb4drASv4tj52
	 LJDSKyv1H46Pp1UsQrEy1GGTdc2VG/Yg0XBh7TZgqjwEW89/DsZwruTFeOzQHq6lns
	 TKDy1uH+Auj9LlayDW6AsXHRVHl+AhswrHeoLW2KerSaVySlTEqGZOCiIvaYq08XFZ
	 2VEum9W4sU0MqJsOQlto/IMCn8Vj7Kk9trVnepJa4ZpmK5cQlKEzn73uDnQmvMigpx
	 Xv1xd4RViqKo3neI+JViy55XrMXcnVfaUzclttwjCprWFuJNe5+GtwixTndTP0BIZS
	 pco9lrXoRdoNQ==
Content-Type: multipart/mixed; boundary="===============7705861267136571711=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e2bb30dfdd74e3bb05602394bb4e7dc9f86d98eb5d01b00fa3ff9ba571ab3550@mail.kernel.org>
In-Reply-To: <20260810022304.211544-1-hui.zhu@linux.dev>
References: <20260810022304.211544-1-hui.zhu@linux.dev>
Subject: Re: [PATCH v3] bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,kpsingh@kernel.org,matt@bobrowski.net,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 03:36:02 +0000 (UTC)

--===============7705861267136571711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 86d3e38ceefc101816dc27eeae8be587b534aee8
> Author: Hui Zhu <zhuhui@kylinos.cn>
>
>     bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
>
>     When bpf_trampoline_update() fails before modify_fentry_multi()/
>     unregister_fentry_multi() is called, cur_image is unchanged
>     (cur_image == old_image) and ftrace still calls into it.  Freeing
>     old_image in that case causes a UAF.
>
>     Only free old_image when it differs from cur_image.
>
>     Also change bpf_trampoline_multi_detach() to return void and drop
>     the WARN_ON_ONCE at its call site.
>
>     Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

This looks like a bug fix.  Should this include a Fixes: tag pointing
at the commit that introduced bpf_trampoline_multi_attach_free(), so
the backport scope for this UAF is clear?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4a10c9878cf..f4e8d372253a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e07af35ed040..b76d162517e3 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1632,7 +1632,18 @@ static void bpf_trampoline_multi_attach_init(struct bpf_trampoline *tr)
>
>  static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
>  {
> -	if (tr->multi_attach.old_image)
> +	/*
> +	 * Only free old_image if it is no longer the active image.
> +	 * When bpf_trampoline_update() fails before modify_fentry_multi()/
> +	 * unregister_fentry_multi() is called, cur_image is unchanged
> +	 * (cur_image == old_image) and ftrace still points to it. Freeing
> +	 * it would cause a UAF when ftrace calls into the freed memory.
> +	 * On success, cur_image is either a new image or NULL, so
> +	 * old_image != cur_image correctly identifies a stale image that
> +	 * is safe to free.
> +	 */
> +	if (tr->multi_attach.old_image &&
> +	    tr->multi_attach.old_image != tr->cur_image)
>  		bpf_tramp_image_put(tr->multi_attach.old_image);

Does the comment accurately describe when old_image is safe to free?
Looking at modify_fentry_multi() and unregister_fentry_multi(), they
assign cur_image before ftrace is reprogrammed:

kernel/bpf/trampoline.c:modify_fentry_multi()
    ftrace_hash_add(data->modify, data->entry, ip, addr);
    tr->cur_image = im;

kernel/bpf/trampoline.c:unregister_fentry_multi()
    ftrace_hash_add(data->unreg, data->entry, ip, addr);
    tr->cur_image = NULL;

Both return 0 immediately. The actual ftrace updates happen later in
bpf_trampoline_multi_detach():

    if (ftrace_hash_count(data->unreg))
            WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
    if (ftrace_hash_count(data->modify))
            WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true));

    for_each_mnode(mnode, link)
            bpf_trampoline_multi_attach_free(mnode->trampoline);

If update_ftrace_direct_del() fails with -ENOMEM (via hash_sub() ->
alloc_and_copy_ftrace_hash() -> alloc_ftrace_hash()), it goes to
out_unlock before the fixup, leaving direct_functions still mapping
tr->ip to old_image->image. Similarly, if update_ftrace_direct_mod()
fails in register_ftrace_function_nolock() or
__ftrace_hash_update_ipmodify(), it never reaches the loop that would
update direct_functions to point to the new image.

In both cases, cur_image has already been changed (to NULL or to im),
so old_image != cur_image would pass and old_image would be freed even
though ftrace's direct_functions still points to it. Wouldn't this
still be the UAF the commit message describes?

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 891897f8a1b3..29260951aa87 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31350581565
--===============7705861267136571711==--
