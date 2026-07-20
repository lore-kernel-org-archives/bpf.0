Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C06399887
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518874; cv=none; b=XF0KKSTBwGIGAIfBFjUkrw22NyDZxirwAfvBA+vN+dFRrKxMl/HsdKzEvbs31o/mYlTwgGhmbWty+1Eu8yH6C71yMVb0QzUTYswNSvyeDN0LU2BBxUns8W1XwHYGOAcKN3ywVrVrZvMT1WYVFq9zlDfntZpRDXivOaEyDxCr+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518874; c=relaxed/simple;
	bh=7KMyobaVE7Xd6ODqQHEJsz6Z3VCbczCzjAb/bu8jMdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQ0t0d7xyFX67JdgkHf3I6w3qupzws/QWuRkTBu/g031J4p/YFu8s0SLug5PNYCroHtaXW75N9MnnIC/SQOn2EXH1BeLFV9WBpqrlR8xc3wruVW4v44/gbrQjlwaIztt+x3qrOZPjeFn1RPSEg6t9G6FvE7rJYNig/zlhmTWpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx6jnhnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx6jnhnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB51F000E9;
	Mon, 20 Jul 2026 03:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784518870;
	bh=o8IVzubdU4ST9dUU/SDRG9kTYGE/ZHg9LNFq6V+wqYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kx6jnhnEAe0rDkArgt7feGVGRZe/whriTAPH6epY1TJHrUgm2uc1hrJv42S49zj6d
	 d3Oj3NISGPew84L0/LZjxsLfLP0nJ8hsUeaAjIpqiLJpnkMmexQur7yejZVlvokbph
	 Qsk1ZlgEuriZC1TcVQBBIrbNO+8Lj/sUn84QTCcVVsRZwlM2Ly8GulYij8q4U4/nY+
	 Ly22qkYsnR7qXhZCDfYuzZfqjojcbk+Bt0NOu4N397z5Dx8IL5wXZcMIsMj4c9Pmox
	 XCoIvvOxqoEqYqjX+CqbUgnnF1S/pxIY2lA4zV4XtITN6mogQyd8MLtuQhNsjwcPnx
	 WaY4mKbL8GLEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/3] bpf, cgroup: Fix storage not restored when
 update_effective_progs failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720033055.1215477-3-pulehui@huaweicloud.com>
References: <20260720033055.1215477-1-pulehui@huaweicloud.com>
 <20260720033055.1215477-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:41:09 +0000
Message-Id: <20260720034110.19AB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Uninitialized memory is read when saving `pl->storage` into `old=
_storage` for newly allocated `bpf_prog_list` entries.

Pre-existing issues:
- [High] If the first program attach to a cgroup fails, `cgrp->bpf.flags[at=
ype]` is not rolled back, leading to a complete bypass of ancestor mandator=
y security policies.
--

--- Patch [2]: [PATCH bpf v3 2/3] bpf, cgroup: Fix storage not restored whe=
n update_effective_progs failed ---
commit 30470afb00630f3ed1a914958997d62e12b1f60a
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix storage not restored when update_effective_progs failed

In __cgroup_bpf_attach(), if update_effective_progs() fails, pl->storage
is not restored to old_storage. This patch saves the old_storage before
assigning the new one, and restores it in the error path.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
[ ... ]
> @@ -883,6 +884,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	pl->prog =3D prog;
>  	pl->link =3D link;
>  	pl->flags =3D flags;
> +	bpf_cgroup_storages_assign(old_storage, pl->storage);

[Severity: Medium]
When __cgroup_bpf_attach() allocates a new bpf_prog_list entry, it does so
without zeroing the memory:

        pl =3D kmalloc_obj(*pl);

Because pl is not zero-initialized, does calling bpf_cgroup_storages_assign=
()
here result in reading uninitialized garbage pointers from pl->storage and
copying them into old_storage? This could trigger KMSAN uninit-value warnin=
gs
when attaching a new program.

>  	bpf_cgroup_storages_assign(pl->storage, storage);
>  	cgrp->bpf.flags[atype] =3D saved_flags;
> =20
[ ... ]
> @@ -916,6 +918,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  		pl->prog =3D old_prog;
>  		pl->link =3D NULL;
>  	}
> +	bpf_cgroup_storages_assign(pl->storage, old_storage);
>  	bpf_cgroup_storages_free(new_storage);
>  	if (!old_prog) {
>  		hlist_del(&pl->node);
>  		kfree(pl);
>  	}
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error path, if
the very first program attach to a cgroup fails (for example, if
update_effective_progs() fails), the newly added list entry is deleted and
freed here, making the list empty again.

However, the flags set earlier in the function are not rolled back:

        cgrp->bpf.flags[atype] =3D saved_flags;

Could an attacker attempt an attach with BPF_F_ALLOW_MULTI, intentionally
force an error (like hitting memory limits in update_effective_progs()), and
leave the compromised cgroup with permanently altered BPF flags?=20

If the flags stay stuck, does this allow bypassing mandatory, non-overridab=
le
programs from ancestor cgroups during compute_effective_progs()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720033055.1215=
477-1-pulehui@huaweicloud.com?part=3D2
