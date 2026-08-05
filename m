Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E903515CC
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902709; cv=none; b=lZeA4LcRQgZPBB74f3iXWSElIRKHA6ndklfCTFDBP+IQ4/ueo3hjBjlHnv83V0si8v1a1CKH7Fyen9pP2yIVB75uXzVjx0nF0FIB0cC0RX6IrQ67qWFeGFYtTWK+Uvy/2E0hsZshIwMoxtnllfDz9fl440IVzsIqBUubku6hhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902709; c=relaxed/simple;
	bh=lIs6B6hbRuZz5KdF6CSMLEVYk0K4D+ehCVveYRjGjBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tvmjALcTsSgA7qNJ47iQESrEfTsAlsL0ETcKC8I0ioeO9gyx6VmleJYn6cDS4Glv5p3icNNRFoL3NkhA6Gl2SDkJAViLMKplaQiftV2nFaGOSbHngjcWsv2xgswvr+qpyKnl/nNO0jaKuBajfaWitLdXxC/FcIDqfrNU97chr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WauDSzLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WauDSzLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3031F00A3A;
	Wed,  5 Aug 2026 04:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785902708;
	bh=Vt7vfl4Wh4Z1RnaKeQZZlFHXOQMPRhTRUhfxmvF5mXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WauDSzLr6J13opjo2qaltWwB3f4FC5KCt61E6amq9RUGHZvN9jrQO38x8pfmPCt8N
	 JYFqvSI3iiGGw32YwIJ7tFrJ9lSdhEzgso2SL9d8aE0zRMzMA2uKMO5rKVQrTNc3bL
	 ziSsMOcfYBQbX2DfAk9fw8NaL114vlQ+WPzStYVKt1pl4NSg9IICBHoFuZpvIJmTRE
	 rkRRQBHI3m93T8e12RXtpYQK0U0wRcu6FEQTpFNk5hnFfJSabfVMQuj4R8qFK7+0Fg
	 kg/xcffMvCPCPFjFm/9rsVWfZnwpbOiom32LrFd+MPrU0I9t2SHuIaM9oCw8jtGfBQ
	 AEvZhr6C3bR9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805035342.349421-1-pulehui@huaweicloud.com>
References: <20260805035342.349421-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 04:05:06 +0000
Message-Id: <20260805040507.DF3031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message claims to reject the link update with -EPERM,=
 but the code actually returns -EINVAL.

Pre-existing issues:
- [High] pl->storage is not rolled back in the error path of __cgroup_bpf_a=
ttach(), leading to a Use-After-Free of cgroup storages.
- [High] Lockless access to `link->prog` in `bpf_link_show_fdinfo` and `bpf=
_link_get_info_by_fd` can lead to a Use-After-Free.
--

--- Patch [1]: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after=
 replacing prog ---
commit f5ba6e7a5022bb7261a93a1c9312a6415db0249f
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix storage null-ptr-deref after replacing prog

This commit fixes a null pointer dereference issue when replacing a BPF
program attached to a cgroup. It addresses the problem by rejecting link
updates if the new program's cgroup storage is incompatible with the existi=
ng
link's program.

Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicl=
oud.com
Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaw=
eicloud.com

>     Fix this by rejecting link update with -EPERM if new_prog's cgroup
>     storage is incompatible with link->prog.

[Severity: Medium]
The commit message claims to reject the link update with -EPERM, but the new
code actually returns -EINVAL. Could the commit message be updated to match
the implementation?

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c6..5cc9b2d92fd58 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -1056,6 +1070,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>  	if (!found)
>  		return -ENOENT;
> =20
> +	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
> +		return -EINVAL;
> +
>  	cgrp->bpf.revisions[atype] +=3D 1;
>  	old_prog =3D xchg(&link->link.prog, new_prog);
>  	replace_effective_prog(cgrp, atype, pl);

[Severity: High]
This is a pre-existing issue, but while reviewing this code I noticed a
potential use-after-free in the error path of __cgroup_bpf_attach().

In __cgroup_bpf_attach(), bpf_cgroup_storages_assign(pl->storage, storage)
updates the storage pointers in the existing program list element pl to poi=
nt
to the storages of the new program.=20

If a subsequent operation like update_effective_progs() fails, the code jum=
ps
to the cleanup label:

kernel/bpf/cgroup.c:__cgroup_bpf_attach() {
    ...
cleanup:
	if (old_prog) {
		pl->prog =3D old_prog;
		pl->link =3D NULL;
	}
	bpf_cgroup_storages_free(new_storage);
    ...
}

In this cleanup block, pl->prog is reverted to old_prog, but pl->storage is
never reverted to its original state. Any newly allocated storages for the
failed program, which reside in new_storage, are freed via
bpf_cgroup_storages_free(new_storage).

Because pl remains in the cgroup's active program list, its storage array n=
ow
contains dangling pointers to these freed RCU-reclaimed storages. Can any
future execution of the BPF program dereference them, resulting in a
use-after-free?


[Severity: High]
This is a pre-existing issue, but I also noticed potential lockless access =
to
link->prog which could lead to a use-after-free.

BPF link types that support dynamic program updates (such as cgroup links)
replace their attached program by atomically swapping link->prog (using xch=
g)
and then calling bpf_prog_put() on the old program. This decreases the
reference count and defers the actual freeing of the program until after an
RCU grace period.

However, bpf_link_show_fdinfo() fetches link->prog locklessly and
dereferences its tag without holding rcu_read_lock():

kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
    ...
	const struct bpf_prog *prog =3D link->prog;
    ...
	if (prog) {
		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
    ...
}

Similarly, bpf_link_get_info_by_fd() fetches link->prog and accesses its aux
field without RCU protection:

kernel/bpf/syscall.c:bpf_link_get_info_by_fd() {
    ...
	if (link->prog)
		info.prog_id =3D link->prog->aux->id;
    ...
}

If a program update occurs concurrently and the reader thread is preempted
long enough for the RCU grace period to elapse, would the old program be
freed before the reader dereferences its memory? Should these accesses be
protected by rcu_read_lock()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805035342.3494=
21-1-pulehui@huaweicloud.com?part=3D1
