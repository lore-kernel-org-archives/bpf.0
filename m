Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D03D5C26
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275230; cv=none; b=Bs7ZLUwB7dD7yriNuMMaryZv2VHz7ySg6jNaUreWhAnKegJR1EXD/oBoBX2sYfwk4IXmXvqC0iiBimsGig4noCG/wpLcNnZ2Sbz3cW2zwxk15WOId9YEvpH9gP02MY3QlWMAj5cD6+yyv5OAGLsaie1AtygwlKXvdDozdwa4irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275230; c=relaxed/simple;
	bh=HwaoNR2Et2ESyQlu55kSj5AczyaU7aV5NsyUjE2a1i8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3Iw35xXeebj5l6KKbM0C7CJQi6dZjF1RxJQceBCHE/BBCDtE+fAyhAE8Cj/wgq62dVN0fvOdvYboKAW+3EaApdFW5ola1+FL9aEFGgepvlftG2egPzJShWP2pxbmRiWDi6FeW8zI5Ku6U6SxtE5NKCs/esjWGowU2Fp2n/j8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbOXc5Ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbOXc5Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9F11F000E9;
	Fri, 17 Jul 2026 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275228;
	bh=yvG8AIfdAvxNiWBsOVMcmiEitZ0KlGTLtjEcsA+nl/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbOXc5Ou+QRfopf9S1mBqc6ZA0Evke+VKaILIprbckpmg6FGgeeN2icKhI5xsj+jr
	 rBk/SBwc7w3dVHX1OPh2TV/6ohUIRlERwJkm87iCmnCINbNUc1X+vNWIUyYTllgQni
	 O1ek9X25NtXquBnQmwUIHtU5eq+0JfopgemYZx9Av3A5YmnnqRAwJiq8bLmFSLPlpk
	 Ws7EcJWrT+FgRMsL+icOXO+1IkOse2XkRBCkxx8aPRGETqRxVmE5Kvb11Kb25CG8eR
	 JOF3l1ejW7qF81EP5z0v6N2sk3eMwbCpo3gbq9vhhvtPdsucxIAuQb5mB1ZAodgBI7
	 D8YQPOMgYCAFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717073343.958862-1-pulehui@huaweicloud.com>
References: <20260717073343.958862-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 08:00:27 +0000
Message-Id: <20260717080028.7C9F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `link->prog` in `bpf_link_show_fdinfo` can race=
 with program replacement, leading to a use-after-free.
- [High] `__cgroup_bpf_attach` fails to restore `pl->storage` on its error =
path, leaving dangling pointers when replacing a BPF program.
--

--- Patch [1]: [PATCH bpf v2] bpf, cgroup: Fix storage null-ptr-deref after=
 replacing prog ---
commit 1bd69188dee95afa5142df58a443716090d9272e
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix storage null-ptr-deref after replacing prog

This commit addresses a null pointer dereference caused when an empty BPF
program is replaced by one requiring cgroup storage. It properly allocates
the new storage and checks if the storage pointers changed to decide between
an in-place update or a full RCU-safe replacement array update.

Link: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweiclo=
ud.com

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c6..e2fa0ebeed830 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1032,11 +1032,17 @@ static int __cgroup_bpf_replace(struct cgroup *cg=
rp,
>  				struct bpf_cgroup_link *link,
>  				struct bpf_prog *new_prog)
>  {

[ ... ]

> @@ -1056,10 +1062,39 @@ static int __cgroup_bpf_replace(struct cgroup *cg=
rp,
>  	if (!found)
>  		return -ENOENT;
> =20
> +	if (bpf_cgroup_storages_alloc(storage, new_storage, link->link.attach_t=
ype,
> +				      new_prog, cgrp))
> +		return -ENOMEM;
> +
> +	for_each_cgroup_storage_type(stype) {
> +		if (storage[stype] !=3D pl->storage[stype]) {
> +			storage_changed =3D true;
> +			break;
> +		}
> +	}
> +
>  	cgrp->bpf.revisions[atype] +=3D 1;
>  	old_prog =3D xchg(&link->link.prog, new_prog);
> -	replace_effective_prog(cgrp, atype, pl);
> +
> +	if (!storage_changed) {
> +		replace_effective_prog(cgrp, atype, pl);
> +		bpf_prog_put(old_prog);

[Severity: High]
This is a pre-existing issue, but does dropping the reference to old_prog=20
here introduce a race condition with lockless readers like=20
bpf_link_show_fdinfo() in kernel/bpf/syscall.c?

If a user reads the fdinfo of the cgroup link, bpf_link_show_fdinfo() reads=
=20
link->prog without holding a lock or taking a reference:

kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
	...
	prog =3D link->prog;
	...
	if (prog) {
		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
		...
	}
}

If __cgroup_bpf_replace() is called concurrently, it replaces link->prog vi=
a=20
xchg() and immediately releases old_prog. If the RCU grace period elapses=20
before bpf_link_show_fdinfo() accesses prog->tag, could this result in a=20
use-after-free?

> +		return 0;
> +	}
> +
> +	bpf_cgroup_storages_assign(old_storage, pl->storage);
> +	bpf_cgroup_storages_assign(pl->storage, storage);
> +	err =3D update_effective_progs(cgrp, atype);
> +	if (err) {
> +		xchg(&link->link.prog, old_prog);
> +		bpf_cgroup_storages_assign(pl->storage, old_storage);

[Severity: High]
This is a pre-existing issue, but while this rollback correctly restores=20
pl->storage in __cgroup_bpf_replace(), does the error path in=20
__cgroup_bpf_attach() have a similar issue?

In __cgroup_bpf_attach(), if update_effective_progs() fails, the code resto=
res=20
pl->prog but seems to miss restoring pl->storage before freeing the newly=20
allocated storage:

kernel/bpf/cgroup.c:__cgroup_bpf_attach() {
	...
	bpf_cgroup_storages_assign(pl->storage, storage);
	err =3D update_effective_progs(cgrp, atype);
	if (err)
		goto cleanup;
	...
cleanup:
	if (old_prog) {
		pl->prog =3D old_prog;
		pl->link =3D NULL;
	}
	bpf_cgroup_storages_free(new_storage);
	...
}

Since pl->storage was overwritten but never restored, does freeing=20
new_storage leave pl->storage with dangling pointers?

> +		bpf_cgroup_storages_free(new_storage);
> +		cgrp->bpf.revisions[atype] -=3D 1;
> +		return err;
> +	}
> +
>  	bpf_prog_put(old_prog);
> +	bpf_cgroup_storages_link(new_storage, cgrp, link->link.attach_type);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717073343.9588=
62-1-pulehui@huaweicloud.com?part=3D1
