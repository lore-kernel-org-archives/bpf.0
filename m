Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEC388E74
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347721; cv=none; b=eUp0TFx1Z/MLzdT0WplPsk6Esv6VVpyHJnYi6TDLJufQAitytN9LYYHxkzHpP6HAa5/kbmd1i4eN/FHUCxybv5GE7i0RVgkE3584BkUsK9toEnEyxn2kUQg2bcA2zORFecAptsc9YBhCs8PaNw2/UwMpGtO6oihV0i9vORKuBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347721; c=relaxed/simple;
	bh=RCupD5v/HPY3feGmb2+sFTgcKMnNdQ1n9OpKThK2ViQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYRem3C9Dy196O9hUQiFnvcG52uEkf5YDH+NTfhqVnZR1LLUya+JZIs0hikh/Dn8gKaM75ixRCJYt2WIYR5KCfQPCuskSkQ2m1e05zgx6v8rLi/iDKSUOkb+LvwAgDcJI5MfZHisM43wgFeh+gugtmdEHTgw4xMFAycZqSc+jgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKCQIAM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKCQIAM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34551F000E9;
	Mon,  6 Jul 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347719;
	bh=Hg1QF8U37UcJSu8D4TbWI0vTz/9KFYcXyIVkV+xDRCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hKCQIAM9cVvNcjkVQ3YzuenS7NxTvpOCX1IA0zSjg/kmBSeK2V8ScgzhM0DsBYLQ4
	 afskqwLDOsS/EQR7TAYyRI4K8FcuoGLYPosR4n1/3EcbHtV1elJQKPI+PRr12td4Kp
	 vgqBkQZbd0/T0KdbgL/nUPF8L7q/4udjh7MKQOGGWGlEyZ8hVtvB/QrVOyVOgtWclT
	 w9CY3koA/3R96SH+Qj5URLcMWGhiElovwfKBM8qpuBW34CGmebFpH39uF3GFfqTVyg
	 srnPrUOZxMlqaeAQafSQU721gSZ8FsBGSFF4fTVry6vWZI+D81e8Xk1ZRfTls2qzqj
	 VaGCl2JHjuHqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/9] bpf: Move bigger allocations below
 fd_array resolution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706135644.326006-3-daniel@iogearbox.net>
References: <20260706135644.326006-1-daniel@iogearbox.net>
 <20260706135644.326006-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:21:59 +0000
Message-Id: <20260706142159.A34551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing memory barrier in double-checked locking of `btf_vmlinux`
- [High] Unprivileged users can hold `bpf_verifier_lock` indefinitely via u=
serfaultfd, causing a Denial of Service
--

commit a8c04cef46e77fd3e978148e583b8fbfc045147f
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Mon Jul 6 13:56:37 2026 +0000

    bpf: Move bigger allocations below fd_array resolution
   =20
    Reorder the preparation work in bpf_check() such that only the minimally
    necessary setup happens up front: allocating the env, initializing the
    verifier log and resolving the fd_array that a signed BPF metadata map
    needs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 33f9c47ee197d..e227c76a8dd96 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19915,21 +19903,33 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>  	env->bypass_spec_v4 =3D bpf_bypass_spec_v4(env->prog->aux->token);
>  	env->bpf_capable =3D is_priv =3D bpf_token_capable(env->prog->aux->toke=
n, CAP_BPF);
> =20
> -	bpf_get_btf_vmlinux();
> -
> -	/* grab the mutex to protect few globals used by verifier */
> -	if (!is_priv)
> -		mutex_lock(&bpf_verifier_lock);
> -
>  	/* user could have requested verbose verifier output
>  	 * and supplied buffer to store the verification trace
>  	 */
>  	ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_=
log->size);
>  	if (ret)
> -		goto err_unlock;
> +		goto err_free_env;
> =20
>  	ret =3D process_fd_array(env, attr, uattr);
>  	if (ret)
> +		goto err_prep;
> +
> +	bpf_get_btf_vmlinux();
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the double-checked
locking pattern in bpf_get_btf_vmlinux() lack necessary memory barriers?

kernel/bpf/verifier.c:bpf_get_btf_vmlinux() {
	if (!btf_vmlinux && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
		mutex_lock(&bpf_verifier_lock);
		if (!btf_vmlinux)
			btf_vmlinux =3D btf_parse_vmlinux();
		mutex_unlock(&bpf_verifier_lock);
	}
	return btf_vmlinux;
}

If btf_vmlinux is read locklessly without smp_load_acquire() or READ_ONCE(),
and the assignment inside the lock lacks smp_store_release(), the CPU could
reorder the initialization of the struct btf object with the store to the
btf_vmlinux pointer.

A concurrent thread calling bpf_get_btf_vmlinux() could observe
btf_vmlinux !=3D NULL and return the pointer before the object's contents a=
re
fully visible, leading to uninitialized memory dereferences.

> +	/* grab the mutex to protect few globals used by verifier */
> +	if (!is_priv)
> +		mutex_lock(&bpf_verifier_lock);

[Severity: High]
This is a pre-existing issue, but can unprivileged users hold
bpf_verifier_lock indefinitely via userfaultfd, causing a local DoS?

When an unprivileged user executes a BPF program load, the verifier acquires
bpf_verifier_lock. While holding this lock, the verifier accesses user-space
memory in a few places.

For example, when reading the user-supplied array in
fd_array_get_map_idx_sparse():

kernel/bpf/verifier.c:fd_array_get_map_idx_sparse() {
	if (copy_from_bpfptr_offset(&fd, env->fd_array_raw, ...))
		return -EFAULT;
	...
}

Similar reads occur in fd_array_get_btf_sparse(). Additionally,
bpf_log_attr_finalize() writes the verification log back to the user-suppli=
ed
attr_log->ubuf before the mutex is released on some error paths.

If an unprivileged user maps these user-space buffers with userfaultfd,
they could cause the kernel thread to pause indefinitely in the fault
handler while still holding bpf_verifier_lock.

Since this blocks all other unprivileged BPF program loads system-wide,
could this be exploited to deny service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706135644.3260=
06-1-daniel@iogearbox.net?part=3D2
