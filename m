Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E91BF33
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466931; cv=none; b=oDE7GILwR4dchV6mmztYWR3fLMPzrs5aZMHX3OfwrAVAUwUfREdODk/IxIv1QD9Rx9Ofn+eC/5uAujsfQk5lo4OhXCo1hCSxQpCuVweuAXLE38vJy8ZoRUPhURZxW8r62W7lHUsRZsOlULY319O3EtaptVhgG5/GiuGlygdcU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466931; c=relaxed/simple;
	bh=f5ZK+yr247QwgAmu0jcdp2dX5HtGhru8SRuVd6//VMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pooKyoeHdMLe0j8kWRhMJWpDz/Z8s2+JXOTXxB04br6B3LoYLdzqhagkjFOk88mHcth1bitZ+LE9WgaCi1E5r/0E6qv8y0FDQQW7eGSYswbsx9zrxg3xOC0Y6GVs8lP/6lTp9FirxdJNMsPKLkBxpBh+sih1goKfJPx/8rO6pJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLLonz/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLLonz/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956261F000E9;
	Sun, 19 Jul 2026 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466929;
	bh=OCkbCXsZ3w5CK8jwa23dkcPbBbG0xf7iXb7Evodsms0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLLonz/S8aXNeZrK6eAN1h21PLhCOS3HSfPPZF1o18T4tudwx44hTue0yGzZDAGaC
	 S5vD9z8uU8bpqfEb0A9RKtVsj7O8uBwo+5F78EEgPn8K5AZcD7aRbZ8pxYZnX1ZCSa
	 8ZeHlHlpLrxGttUAOoNVuCaggF9QQ/RaB1fAOIXc1OZXlIfeJ2YrtHAdcKYQ7yKMBy
	 2n1LNAM2Uplyqlc7lblJsPUB/7dzAq8XZW5WVt1RVz+eVsXMfmGrXBF4yAQNTFJyqL
	 Ak+Q6bt1tneuqdtdP7GaWETOvZ5QCbq67h4uTV3qIswQLtjK7d6/gOBNKIhvs2xApA
	 BbsSWsEYqQzHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Zero queue and stack outputs on lock
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719125419.1782196-1-memxor@gmail.com>
References: <20260719125419.1782196-1-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 13:15:29 +0000
Message-Id: <20260719131529.956261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The helper bpf_get_func_arg() fails to initialize its output buffe=
r on error, leading to an information leak of kernel stack memory.
- [High] The helper bpf_get_branch_snapshot() fails to initialize its outpu=
t buffer on error or partial read, leaking kernel stack memory.
- [High] The helpers bpf_get_task_stack() and bpf_get_task_stack_sleepable(=
) fail to initialize their output buffer on certain error paths.
- [High] The `bpf_dynptr_read` helper accepts an uninitialized output buffe=
r but fails to clear it on error paths, leading to a kernel stack memory le=
ak.
--

--- Patch [1]: [PATCH bpf-next] bpf: Zero queue and stack outputs on lock f=
ailure ---
commit 5fdb8c3a145c7d80ff008684d830f42d96eff7e6
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Zero queue and stack outputs on lock failure

This commit fixes an issue where queue and stack pop/peek helpers could
return -EBUSY on lock failure without initializing their output buffers.
It clears the buffer before returning to prevent BPF programs from
observing uninitialized stack contents.

> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index 9a5f94371e506..c1c9dee4dcdd0 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -99,8 +99,10 @@ static long __queue_map_get(struct bpf_map *map, void =
*value, bool delete)
>  	int err =3D 0;
>  	void *ptr;
> =20
> -	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
> +	if (raw_res_spin_lock_irqsave(&qs->lock, flags)) {
> +		memset(value, 0, qs->map.value_size);
>  		return -EBUSY;
> +	}
> =20
>  	if (queue_stack_map_is_empty(qs)) {
>  		memset(value, 0, qs->map.value_size);
> @@ -130,8 +132,10 @@ static long __stack_map_get(struct bpf_map *map, voi=
d *value, bool delete)
>  	void *ptr;
>  	u32 index;
> =20
> -	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
> +	if (raw_res_spin_lock_irqsave(&qs->lock, flags)) {
> +		memset(value, 0, qs->map.value_size);
>  		return -EBUSY;
> +	}
> =20
>  	if (queue_stack_map_is_empty(qs)) {
>  		memset(value, 0, qs->map.value_size);

[Severity: High]
This is a pre-existing issue, but I noticed a similar pattern in other BPF
helpers while reviewing this fix. For example, does get_func_arg() in=20
kernel/trace/bpf_trace.c also leak uninitialized stack memory on its error
path?

kernel/trace/bpf_trace.c:get_func_arg() {
    ...
    if ((u64) n >=3D nr_args)
        return -EINVAL;
    ...
}

The verifier assumes the MEM_UNINIT output buffer is unconditionally
initialized. If this helper returns -EINVAL without clearing the output
buffer, could a BPF program read the uninitialized memory? It looks like
the JIT inline implementation in kernel/bpf/fixups.c:fixup_bpf_calls()
also jumps over the memory write instruction on failure.

[Severity: High]
This isn't a bug introduced by this patch, but does bpf_get_branch_snapshot=
()
have the exact same issue with its ARG_PTR_TO_UNINIT_MEM buffer?

kernel/trace/bpf_trace.c:bpf_get_branch_snapshot() {
    ...
    if (unlikely(flags))
        return -EINVAL;
    ...
}

If it returns early due to flags or !entry_cnt, or if
perf_snapshot_branch_stack() returns fewer entries than the requested
buffer size, the trailing bytes of the buffer are left unwritten. Could a
tracing program exploit this to read kernel stack contents?

[Severity: High]
This is a pre-existing issue, but does __bpf_get_task_stack() also need=20
similar zeroing on its error paths?

kernel/bpf/stackmap.c:__bpf_get_task_stack() {
    ...
    if (!try_get_task_stack(task))
        return -EFAULT;
    ...
}

Both bpf_get_task_stack() and bpf_get_task_stack_sleepable() use
ARG_PTR_TO_UNINIT_MEM for their buffer. If try_get_task_stack() fails, it
returns an error without clearing the caller-provided uninitialized buffer,
which the verifier assumes is fully initialized.

[Severity: High]
This isn't a bug introduced by this patch, but I see the same bug class
present in __bpf_dynptr_read().

kernel/bpf/helpers.c:__bpf_dynptr_read() {
    ...
    if (!src->data || flags)
        return -EINVAL;
    ...
}

Since the verifier definition for bpf_dynptr_read uses
ARG_PTR_TO_UNINIT_MEM for its destination buffer, returning an error here
without zeroing the dst buffer appears to trick the verifier into marking
uninitialized stack memory as initialized. Could this be used by
unprivileged programs to leak kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719125419.1782=
196-1-memxor@gmail.com?part=3D1
