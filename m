Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EA22F767;
	Sat, 17 Oct 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247965; cv=none; b=OiVUeUdGJvIYubpb7ithvMUTAqUCoY5ny+07vOKIal2fhvQcZHHVH5pySvINvuxMM/vfm7dxxnJmTFSBgj2qXfgc2i/WBOTgxv5BS/TkF2IMCO5lzNEhX+mc/FEBAyulOfC0Qsy426u/5Pvosk7QilavGfJSvpee1sbPX/1CWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247965; c=relaxed/simple;
	bh=qCdW2IvupPTRCzPUrvbgvKS0JVPnTzVER91qLdF4xvg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QT2/6WRfvobZOGXsF3Xk9E4hd2sa/55Jf2r0K6cU+7RrT0UZJseJ/OO2EaXET46HSvR6Kti5uHvQ4J3U4mUnWnxcw420ZaKiJIW7ijQgMI9D969aHDsiComjZ6JXDlIHRAnwCHcTI8DCQ+PC3kXcxDbM1LZEzgfZiOTrYEER3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guCd0e1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guCd0e1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B981F000C4;
	Sat, 17 Oct 2026 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247964;
	bh=QQzbXfqBg7b3FhTdHYkokWb42NjX1LZ3peT0AewB2SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guCd0e1qIb26H+EbI2QYlzZeDpqy2xxBe0r9K95kjpko7EOyaoFS9iGsr2pjmaXXa
	 tZZtmOInw9geq5F4JwNqmBwhyz8wYi6aYPWksFvFKj2pxpI1n9FmRQ3Y+Y0sBNxNif
	 9bajLGvRhL/dHQ3vg4t/8VXuk4tarQTq4uFyDApHo9f28Yej4nyd5Pz2Bn+aLGojxd
	 T76srLjNVKf9Z1mP+agrwHskFUg2nHeUGwPmkPJmxy3h1xazWD5wRI+8VKcFOck1Gf
	 cUo5gS23bI9wueTFnZsmODdwjfpi0w71NQtlBTI0Lhm/UoW5bpiLZS7kEKSewNZ/M0
	 /Zm9jgg9Yj+zQ==
Message-ID: <sashiko-outbox-175562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/6] bpf: Add syscall common attrs support for
 link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261017142649.51047-2-leon.hwang@linux.dev>
References: <20261017142649.51047-1-leon.hwang@linux.dev>
 <20261017142649.51047-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:39:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: prog refcount underflow and fd leak in link_create() on l=
og error
--

commit 56fa3f4abf91b9651c1cd02884b19754bd9ebcb5
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attrs support for link_create

This commit adds syscall common attributes support to link_create(),
creating and finalizing an internal verifier log instance and reporting
error messages for an invalid prog_fd or attach_type.

Link: https://lore.kernel.org/bpf/20260514004634.3DA09C19425@smtp.kernel.or=
g/

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0f27604a54aae..252b479937a4d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5839,10 +5839,13 @@ static int bpf_map_do_batch(const union bpf_attr =
*attr,
>  }
> =20
>  #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
> -static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> +static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_=
common_attr *attr_common,
> +		       bpfptr_t uattr_common, u32 size_common)
>  {
> +	struct bpf_verifier_log *log;
> +	struct bpf_log_attr attr_log;
>  	struct bpf_prog *prog;
> -	int ret;
> +	int ret, err;
> =20
>  	if (CHECK_ATTR(BPF_LINK_CREATE))
>  		return -EINVAL;
> @@ -5850,14 +5853,24 @@ static int link_create(union bpf_attr *attr, bpfp=
tr_t uattr)
>  	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS)
>  		return bpf_struct_ops_link_create(attr);
> =20
> +	log =3D bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, =
size_common);
> +	if (IS_ERR(log))
> +		return PTR_ERR(log);
> +
>  	prog =3D bpf_prog_get(attr->link_create.prog_fd);
> -	if (IS_ERR(prog))
> -		return PTR_ERR(prog);
> +	if (IS_ERR(prog)) {
> +		bpf_log(log, "Invalid prog_fd.\n");
> +		ret =3D PTR_ERR(prog);
> +		prog =3D NULL;
> +		goto out;
> +	}
> =20
>  	ret =3D bpf_prog_attach_check_attach_type(prog,
>  						attr->link_create.attach_type);
> -	if (ret)
> +	if (ret) {
> +		bpf_log(log, "Invalid attach_type.\n");
>  		goto out;
> +	}
> =20
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_CGROUP_SKB:
> @@ -5940,7 +5953,14 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>  	}
> =20
>  out:
> -	if (ret < 0)
> +	/* preserve original error even if log finalization is successful */
> +	err =3D bpf_log_attr_finalize(&attr_log, log);
> +	if (err)
> +		ret =3D err;
> +
> +	kfree(log);
> +
> +	if (ret < 0 && prog)
>  		bpf_prog_put(prog);
>  	return ret;
>  }

[Severity: Critical]
Can this underflow the refcount on prog and leak the newly installed link
file descriptor if bpf_log_attr_finalize() fails after link attachment
succeeds?

When one of the link attach helpers in switch (prog->type) succeeds, it
transfers ownership of the prog reference acquired by bpf_prog_get() to
link->prog and calls bpf_link_settle() (or bpf_link_new_fd()), which
installs the file descriptor via fd_install() and returns the non-negative
fd in ret.

At the out label, bpf_log_attr_finalize() is then called:

kernel/bpf/log.c:bpf_log_attr_finalize() {
	err =3D bpf_vlog_finalize(log, &log_true_size);

	if (attr->offsetof_true_size &&
	    copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, &log_true=
_size,
				  sizeof(log_true_size)))
		return -EFAULT;

	return err;
}

If uattr_common was passed with size_common large enough to include
log_true_size and resides in read-only memory (or is unmapped before
finalization), copy_to_bpfptr_offset() returns -EFAULT even when nothing
was logged.

In link_create(), ret is then overwritten with -EFAULT, causing
if (ret < 0 && prog) to call bpf_prog_put(prog) on the reference that is
now owned by the active bpf_link. When the installed link fd is later
closed, bpf_link_free() -> bpf_link_dealloc() will call
bpf_prog_put(link->prog) a second time:

kernel/bpf/syscall.c:bpf_link_dealloc() {
	if (link->prog)
		bpf_prog_put(link->prog);
	...
}

Should the ret < 0 check for bpf_prog_put(prog) happen before
ret is overwritten by err from bpf_log_attr_finalize(), or should log
finalization be handled before settling the link?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017142649.5104=
7-1-leon.hwang@linux.dev?part=3D1
