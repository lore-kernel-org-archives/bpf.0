Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1824A483B
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196334; cv=none; b=f5DY2JeByXZvqZdXOG15kuj0pQaUsg9tqeEsqNrLE0/dV/fmUjwBeXZePPIQ7gQp9lKlzEuq+1pf0olKgx3l///daoxjB+fWjrJCDeganIclb9dgaaWEYpBpnXmN7PhEpehgO2UN0y6pE2j0Pp/zK6ebtzyUIYgseVbum6s4g5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196334; c=relaxed/simple;
	bh=j5o5WS7+nbs9jO1rVtyMKj2JON6PWmD7U7h0HwoTX8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yih3h+4Q900THjRdiWI/X+PFnpR33MzarS9dz94Y8FiSMU4TS1KEnL+U64TOMMC4DIVTSW9bgD0MyXwDI66EHqnCU3ERvNnqlaZ/zgrGLxi5fr52ZYqFv62FIhcXMn7kld0G+JA/4l5E3qZ+4lAA6luhc7l3Kt9iQs0+lEROH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwYh4zca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwYh4zca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B431F000E9;
	Mon, 31 Aug 2026 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196333;
	bh=etKpt3WsQIftmepY2kz/EHxxLaoPfYCqywAtBFVu9ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwYh4zcaSqxxXH3grofpK9+SEnp+S7aB6nufU0ssISrWBvh3ASJHex9tJSJeD221w
	 4dCi+7szkWzc8qMjOQw2zWdgPAxxqdsUMw1axavUkqoDlXx34FuGOOmgKMPA2pAUT7
	 qklEJIM83/AOZ5R0VysovYZEX0/fDamZNd+DPVnYQyqT42hl4cMLo+VUqi/NfaX+D3
	 wzet9cr7lq+v5ekqhTYxv30Wxd7vtsVAe6072MdvUEp9OnYtcILzJo5ZMNghnZ0PAD
	 Mo9mFkIU48VESeYqA0dVRptJzoPpnulbrm98VH+e9kqDxye4EZ3CndgAooqKfSu8Ga
	 4up6QnFpXT/hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] bpf: NUL-terminate replaced sysctl
 value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831133314.4125787-556-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-556-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:12:12 +0000
Message-Id: <20260831171212.E1B431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The original sysctl buffer is allocated with `kvzalloc()` but erro=
neously freed with `kfree()` during buffer replacement, leading to potentia=
l kernel panics.
- [High] The sysctl buffer replacement logic is completely broken because i=
t relies on `ret =3D=3D 1`, but the BPF execution engine returns 0 on succe=
ss. Furthermore, a non-zero return aborts the sysctl write.
--

commit 499368353ad755feaab0984797529c1470873194
Author: Dawei Feng <dawei.feng@seu.edu.cn>

bpf: NUL-terminate replaced sysctl value

This commit ensures that BPF-replaced sysctl write buffers are
NUL-terminated before downstream proc handlers parse them. It appends
a '\0' to the buffer in bpf_sysctl_set_new_value() to prevent out-of-bounds
reads when parsing the modified sysctl values.

Link: https://lore.kernel.org/r/20260603105317.944304-2-dawei.feng@seu.edu.=
cn

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 248f517d66d04..aed2f087cfc4e 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2346,6 +2346,7 @@ BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sys=
ctl_kern *, ctx,
>  		return -E2BIG;
> =20
>  	memcpy(ctx->new_val, buf, buf_len);
> +	((char *)ctx->new_val)[buf_len] =3D '\0';

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in the sysctl replacement path that bpf_sysctl_set_new_value() relies on.

Is it possible that replacing the sysctl buffer leads to a kernel panic
due to mismatched allocation and free functions?

In fs/proc/proc_sysctl.c:proc_sys_call_handler(), the user buffer is
allocated using kvzalloc():

    kbuf =3D kvzalloc(count + 1, GFP_KERNEL);

Under memory pressure for allocations larger than PAGE_SIZE, this can fall
back to vmalloc().

However, if a BPF program successfully updates the sysctl value via
bpf_sysctl_set_new_value(), __cgroup_bpf_run_filter_sysctl() in=20
kernel/bpf/cgroup.c frees the original user buffer using kfree():

    kfree(*buf);

Could freeing a vmalloc pointer with kfree() cause memory corruption or a
kernel panic in the slab allocator?


[Severity: High]
This is also a pre-existing issue, but the sysctl buffer replacement logic
appears to be functionally broken.

Can bpf_sysctl_set_new_value() ever successfully modify a sysctl value?

In kernel/bpf/cgroup.c:__cgroup_bpf_run_filter_sysctl(), the replacement
branch is only taken if the return value is exactly 1:

    if (ret =3D=3D 1 && ctx.new_updated) {

But the BPF execution engine in bpf_prog_run_array_cg() normally returns 0
on success, making the replacement branch unreachable:

    if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
        run_ctx.retval =3D -EPERM;

If a BPF program uses bpf_set_retval(1) to force a return value of 1,
__cgroup_bpf_run_filter_sysctl() will bubble up 1 as an error to
fs/proc/proc_sysctl.c:proc_sys_call_handler():

    if (error)
        goto out_free_buf;

Does this abort the sysctl write and skip calling the downstream
table->proc_handler, entirely breaking the replacement functionality?

>  	ctx->new_len =3D buf_len;
>  	ctx->new_updated =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-556-sashal@kernel.org?part=3D1
