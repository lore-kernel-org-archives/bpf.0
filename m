Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E447127F
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705706; cv=none; b=K7lNBntuiiFgdKOw+ZQMB+jseoqg1nANg7s0LM6LuD8it1YZRFoB/kpR3IGWro7CqMUVBhis8Ao/mCxtiECjOEBFK6Vn2mZXv4LGB43oi2lTWr/MSz/eP7raTm102Wz2rYwPA7MLNPC+cldulHKG/LJd4exDhTKVr2EFcQA4RYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705706; c=relaxed/simple;
	bh=2AgJNc5J8MLhE+ugrxiukQK6DQ0i9xUAYGXR/Y2O8BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AgXI1PgKy6XuV+mgqqhTZbUHMVRYT/H9u79W/iOS5MELGDbQyf7DlL++Pa6q0U99p46gU4EKOuUMYb/GFTxTxpDP35ueHDwsfbzU8sqCgfetHYxEj9ob0ljbg4sbzmhqGV53Sw6KMob6lXXG4th7yLCzIb/kzofQV+N4tFbHPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRpdwYNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRpdwYNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ACE1F00A3A;
	Wed, 22 Jul 2026 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784705701;
	bh=RikEoqAaHvboD8SexfFFQMJ+K22/dA3FxB3+V75hTC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRpdwYNB9nKqs6Jqz6flhku1112VKKuHAZ9ZJROf8NCT0U/oA9u6WIyTWT185JeAW
	 BoNNcJrpIDj2f4rqLLJf3VL/t46W4fjUJXKEKp7n0TybOGdKJu5nPH+o6v+nUyEteY
	 Tg6MeZQPAgcwRxNVGvmIXIFnWAt7WJscMgKb5OpGh8kn9CgpC17lFUTwd3f6UfwR17
	 EhNlj9ZJlb4DMGYs8OnWHa5sPyIwBIKzNtwzpBzAXwuOpd3aCdAuc6yL3laBwKDgTQ
	 3LPDLlqWrUyNj5Nsi+ut9ppeqF26ATg5V4C7RWwm5mgBw90KhrksLyXKv3IoN1kauz
	 /kNp24jrcxQvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v6 4/4] bpf, cgroup: Fix storage null-ptr-deref
 after replacing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722072326.1545677-5-pulehui@huaweicloud.com>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:35:00 +0000
Message-Id: <20260722073501.64ACE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing rollback of `pl->flags` on the error path in `__cgroup_bpf=
_attach` permanently corrupts the execution order of the replaced program.
--

--- Patch [4]: [PATCH bpf v6 4/4] bpf, cgroup: Fix storage null-ptr-deref a=
fter replacing prog ---
commit f8726e124d0a4e72b87976830f0741e286d474df
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix storage null-ptr-deref after replacing prog

Syzkaller reported a storage null-ptr-deref issue after replacing a prog.
The issue is fixed by properly allocating the storage and comparing the old
and new storage pointers, falling back to an RCU-safe update if they change.
Additionally, proper rollbacks for storage and flags are added to the error
path in __cgroup_bpf_attach for code rigor.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -883,7 +885,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	pl->prog =3D prog;
>  	pl->link =3D link;
>  	pl->flags =3D flags;
> +	if (old_prog)
> +		bpf_cgroup_storages_assign(old_storage, pl->storage);
>  	bpf_cgroup_storages_assign(pl->storage, storage);
> +	old_flags =3D cgrp->bpf.flags[atype];
>  	cgrp->bpf.flags[atype] =3D saved_flags;
> =20
>  	if (type =3D=3D BPF_LSM_CGROUP) {

[ ... ]

> @@ -915,12 +920,14 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	if (old_prog) {
>  		pl->prog =3D old_prog;
>  		pl->link =3D NULL;
> +		bpf_cgroup_storages_assign(pl->storage, old_storage);
>  	}

[Severity: High]
This is a pre-existing issue, but since this patch tightens the error handl=
ing
and rollbacks in __cgroup_bpf_attach(), should we also restore the original
pl->flags here?

Earlier in the function, pl->flags is overwritten with the incoming flags:

	pl->prog =3D prog;
	pl->link =3D link;
	pl->flags =3D flags;

If update_effective_progs() later fails (e.g., due to memory allocation
failure), the error path restores pl->prog, pl->link, and pl->storage, but
misses pl->flags. If a user attempts to replace a program using BPF_F_REPLA=
CE
with different BPF_F_PREORDER settings and the replacement fails, could this
leave the original program active but with its execution order silently
corrupted?

>  	bpf_cgroup_storages_free(new_storage);
>  	if (!old_prog) {
>  		hlist_del(&pl->node);
>  		kfree(pl);
>  	}
> +	cgrp->bpf.flags[atype] =3D old_flags;
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722072326.1545=
677-1-pulehui@huaweicloud.com?part=3D4
