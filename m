Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62792D73A6
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256796; cv=none; b=Y9CdC6rssv1xZ68zMDj9UK/BnqsgAumGWvrJ/P9oUoh80UY2AlGSgt38Z1T3OR2STT7yHJHRY8TZ47p6GvGrBNCaLEyl8snuLn1Z1OnydvAhVsqfH5L1ctxrXK1VZUi7m0jnlR2KCxDuof+C1kfGFGi3CFNGU8Gr23gDUauqLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256796; c=relaxed/simple;
	bh=xvF8QaApXFnjALbIemk9VHEp7Ljuejzp21+qjtUWQVs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ajEE4mxr3OhFOxCiE4PzpU7YSjfFVPDw3jPj0WcseZy2Dv6suZMFew7KyJ99USF/OGu6SbxwPsb7jqhvzMfx0XNvaObLKyWfA+GeXCXzWublzT2LXv+msPjmC5drLSnGc9PF+IEi1g0XWoGgOkxv8zFrGeMrwItD9EUAPPWeGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyfGXNXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyfGXNXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E261F000C5;
	Sat, 17 Oct 2026 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256795;
	bh=lOEU7AP2+0I2+TLWBcEGYbmP5ujfYmOFeux4zF1ft0I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KyfGXNXKnm4bNcjUsbbbA8FPvLXkMvK5mFo7WN2ImV0WoLT0l/S694G/mQ7NNmM+H
	 6a5WTyBzHnyEjTpVcN3Kw6KH5bThnaaWmqfVLG8jAN7VtJwV5dht67iZTM8fZBsQjW
	 M2BRhek7Y8RftsiYdnZIt6RBN6U6gqGt9aXyZNau7+Juz00s76RENHHUJ1Irw7IX0m
	 Ser5L7dq1ySZq143blt8JOmwOp9mro5zmxsFilAKf6oRbLeFqrU/SiGiFQsbEAMQaE
	 471vs4v0EnReUl2wQSNuTyY4ybkCcBVwszzbOhgiYwKD137jEtZwL/J0FlVo08yV9J
	 +GvsnrD0ExeqQ==
Message-ID: <sashiko-outbox-175685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 31/43] bpf: Keep values of a dead owner for
 sleepable programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017163745.3341787-32-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
 <20261017163745.3341787-32-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:06:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: special BTF fields leaked in bpf_selem_unlink_nofail() race
--

commit 441f9cc60cc3e26f38a89830b7d3f94a34c7d383
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Keep values of a dead owner for sleepable programs

This commit defers freeing BPF local storage elements and their special BTF
fields until after an RCU Tasks Trace grace period when an owner dies and
the map may be accessed by sleepable BPF programs, including maps that have
been used as inner maps.

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 49ea00c993909..699430f971787 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -352,7 +352,8 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *s=
elem)
>  static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
>  				    struct bpf_local_storage_map_bucket *b)
>  {
> -	bool in_map_free =3D !!b, free_storage =3D false;
> +	bool in_map_free =3D !!b, free_storage =3D false, sleepable_users =3D f=
alse;
> +	bool keep_fields =3D false;
>  	struct bpf_local_storage *local_storage;
>  	struct bpf_local_storage_map *smap;
>  	unsigned long flags;
> @@ -362,17 +363,26 @@ static void bpf_selem_unlink_nofail(struct bpf_loca=
l_storage_elem *selem,
>  	smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
> =20
>  	if (smap) {
> +		/* A map that is freed, or NULL here, has no program left. */
> +		sleepable_users =3D !in_map_free &&
> +				  (atomic64_read(&smap->map.sleepable_refcnt) ||
> +				   READ_ONCE(smap->map.was_inner_map));
>  		b =3D b ? : select_bucket(smap, local_storage);
>  		err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
>  		if (!err) {
>  			/*
>  			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
>  			 * exactly once for an selem. Safe to free special fields immediately
> -			 * as no BPF program should be referencing the selem.
> +			 * as no BPF program should be referencing the selem, unless it
> +			 * is sleepable: see below.
>  			 */
>  			if (likely(selem_linked_to_map(selem))) {
>  				hlist_del_init_rcu(&selem->map_node);
> -				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> +				if (sleepable_users)
> +					keep_fields =3D true;
> +				else
> +					bpf_obj_free_fields(smap->map.record,
> +							    SDATA(selem)->data);
>  				unlink++;
>  			}
>  			raw_res_spin_unlock_irqrestore(&b->lock, flags);
> @@ -387,7 +397,14 @@ static void bpf_selem_unlink_nofail(struct bpf_local=
_storage_elem *selem,
>  		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
>  		 */
>  		WARN_ON_ONCE(err && in_map_free);
> -		if (!err || in_map_free)
> +		/*
> +		 * A sleepable program can still use, and fill, the fields of a value
> +		 * that it got before it let go of the owner. As for bpf_selem_unlink(=
),
> +		 * bpf_selem_free_trace_rcu() frees them, and takes smap for that:
> +		 * map_free() waits for this RCU read side critical section and then
> +		 * for the callback.
> +		 */
> +		if ((!err && !keep_fields) || in_map_free)
>  			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
>  	}

[Severity: High]
Can this race between bpf_local_storage_destroy() and
bpf_local_storage_map_free() leak the special BTF fields in
SDATA(selem)->data (such as referenced kptrs or pinned uptr pages) when
smap->map.was_inner_map is true?

Once a local storage map has been inserted into an outer map via
bpf_map_fd_get_ptr(), smap->map.was_inner_map remains permanently true even
when bpf_local_storage_map_free() later tears down the map.

If bpf_local_storage_destroy() and bpf_local_storage_map_free() concurrently
call bpf_selem_unlink_nofail() on the same selem and both read a non-NULL
smap before either clears SDATA(selem)->smap:

1. In bpf_local_storage_destroy() (in_map_free is false), sleepable_users
   evaluates to true because smap->map.was_inner_map is true. If it acquires
   b->lock first, it sees selem_linked_to_map(selem), unlinks selem->map_no=
de,
   and sets its local keep_fields =3D true instead of calling
   bpf_obj_free_fields(). It then leaves SDATA(selem)->smap non-NULL so
   bpf_selem_free_trace_rcu() can free the fields later.

2. In the racing bpf_local_storage_map_free() (in_map_free is true), after =
it
   acquires b->lock, selem_linked_to_map(selem) is now false, so it also sk=
ips
   bpf_obj_free_fields(). However, because in_map_free is true (and its loc=
al
   keep_fields is false), it then executes:

	if ((!err && !keep_fields) || in_map_free)
		RCU_INIT_POINTER(SDATA(selem)->smap, NULL);

3. When bpf_selem_free_trace_rcu() later runs after the RCU Tasks Trace gra=
ce
   period:

	smap =3D rcu_dereference_check(SDATA(selem)->smap, 1);

	if (smap)
		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);

   smap is now NULL, so bpf_obj_free_fields() is skipped there as well and
   never runs for selem.

[ ... ]

>
> --=20
> 2.51.2
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017163745.3341=
787-1-alexei.starovoitov@gmail.com?part=3D31
