Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5ABE63
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082675; cv=none; b=qKr4t6RtRyjOpvwHMJmhV6gMsrkPP39jNg27YYCIhb60Nv26ncJdAobagGIClZJWMgH/zEozsTOxY1kjn2Fl3zxmZbBXkbgoYUhfPZkX4bR4kLmn13/OZY54nSy8k6bRfJhFgW9mk8kAsZqU0Iw1CnBE36oWrcqzccSytUl/fWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082675; c=relaxed/simple;
	bh=8NyXEZL5rzNgf1n8opHHzXLRHCdPbR9SPh//ksBe1WI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eTmvVmogRKuD/X80UmJfs6x3chr4KmPfrksjHrFOzYBj7baMhiRbixod11EGthRULoEUG1EpR21ga2kYke9nZk+eg0PbrHJhnuc1t1e1n8xg/9jXyf24zzu+kpknbPD1EKruSzHPvebcTZNxjh9ZUS+3dsV2VNbDbRIDGNPZJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo51Slyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo51Slyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6FD1F000E9;
	Sun, 26 Jul 2026 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785082674;
	bh=O6eD5yGlz2hfWv+2ru2uAX+ot830LTdvYPRNzXq3Bqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wo51SlyfNN/1g7nBKcLS28iAhZx867Ze2NTqCcGCES2rx4/YGVpxcrKIpRXeU4mVp
	 aksv7kpRpMG+fFCu4BXJ3n8TiCU9FeJXOL45VBrEGMN2dn/Fbo4OeDDhoU8HaR9p2m
	 BamTvNCv2LjjuuwKOnKdDElijAtwDbK/uhKd+dbaNr5qwV9Lbgix1iYAc9XDt+pZc/
	 +R98VftgIJbeORhfMLkPKQgHF65ZYOz1HxVESW8X7wFUCRE3Qc/eGu82zce4SKxaIc
	 dSbnXdUx350ijKvrH8E2I+17xMhtSYHoXlgUmqz6aLAa7EyxEivCLfDvFrOrMz3xG7
	 teROvD14rBbIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Cancel RHash special fields on value
 recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>
References: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
 <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 16:17:52 +0000
Message-Id: <20260726161753.AD6FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The `rhtab_map_update_existing` function fails to call `bpf_obj_fr=
ee_fields()` when overwriting an existing map value, explicitly violating B=
TF special field cleanup rules.

Pre-existing issues:
- [Critical] Uninitialized spinlock acquired in `alloc_htab_elem` when `BPF=
_F_LOCK` is used.
- [Critical] BTF special field (kptr) leak and dangerous reuse in prealloca=
ted hash maps.
- [High] Missing field cancellation on locked update in `htab_map_update_el=
em`.
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf: Cancel RHash special fields on val=
ue recycle ---
commit b285c707d0a30a431d69802916cd425986e713ab
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Cancel RHash special fields on value recycle

The patch replaces bpf_obj_free_fields() with bpf_obj_cancel_fields() in
the update and deferred deletion paths for rhtab. It cancels timers and
workqueues while deferring kptr release.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e85..54ea111daa8bd 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -3027,7 +3027,7 @@ static long rhtab_map_update_existing(struct bpf_ma=
p *map, struct rhtab_elem *el
>  	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>  	 * to match arraymap's update semantics.
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	rhtab_check_and_cancel_fields(rhtab, elem);
>  	return 0;
>  }

[Severity: High]
Does replacing bpf_obj_free_fields() with bpf_obj_cancel_fields() violate
the subsystem guidelines for map updates?

According to the BPF documentation, when overwriting an existing map value
with userspace data using copy_map_value(), bpf_obj_free_fields() must be
called to release resources held by the old value.=20

Does using bpf_obj_cancel_fields() here instead fail to release resources
like kptrs during the update?


[Severity: High]
This is a pre-existing issue, but are special fields left active during
locked updates in htab_map_update_elem()?

Looking at kernel/bpf/hashtab.c:htab_map_update_elem():

    if (map_flags & BPF_F_LOCK) {
        ...
        copy_map_value_locked(map, htab_elem_value(l_old, key_size), value,=
 false);
        return 0;
    }

When BPF_F_LOCK is used to overwrite an existing element in-place,
copy_map_value_locked() is called and the function returns 0.=20

Is the cancellation step skipped here, leaving old special fields like
timers or workqueues running indefinitely?


[Severity: Critical]
This is a pre-existing issue, but could alloc_htab_elem() be acquiring an
uninitialized spinlock?

Looking at kernel/bpf/hashtab.c:alloc_htab_elem():

    l_new =3D bpf_mem_cache_alloc(&htab->ma);
    ...
    if (map_flags & BPF_F_LOCK)
        copy_map_value_locked(&htab->map, htab_elem_value(l_new, key_size),=
 value, false);

When updating a non-preallocated hash map with BPF_F_LOCK for a new key,
the new element is allocated but not initialized.=20

Because check_and_init_map_value() is not called before
copy_map_value_locked(), will the kernel attempt to lock an uninitialized
spinlock in the new memory?


[Severity: Critical]
This is a pre-existing issue, but can preallocated hash maps leak kptrs
and improperly reuse them across elements?

When an element is deleted, kernel/bpf/hashtab.c:free_htab_elem() cancels
timers but doesn't free fields:

    check_and_cancel_fields(htab, l);
    pcpu_freelist_push(&htab->freelist, &l->fnode);

Later, kernel/bpf/hashtab.c:alloc_htab_elem() pops the element and skips
initialization:

    l_new =3D prealloc_lru_pop(htab, key, hash);
    if (!l_new)
        ...

Because bpf_obj_free_fields() is skipped on deletion and
check_and_init_map_value() is skipped on reallocation, would the new
element inherit the old kptrs?=20

Might this cause kptr resources to leak or be improperly accessed by the
reallocated element?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-f01-23-rha=
sh-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn?part=3D1
