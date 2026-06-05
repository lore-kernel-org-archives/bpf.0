Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CE4D98FC
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660566; cv=none; b=U4YpXDFXKr2IQzEmJI9UvN2pnHDvjf9u0eO3h82+mmBFPYVGmek3WqoBU3J/4KSZFjs4h6h2HjiT8ON2N3Zt0uLYazShZQl80NUfFh1Kb4gf8DMbIEHmRb17TyJYtyWLcFqbxYYBtQpD5p1a+msbYmb4kYZKo4LOj35O3M1MZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660566; c=relaxed/simple;
	bh=5KtqOxDkftchInsaU7Cj3bZl3Sxx4Ra5RTwu8ed3VnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5zrtxM6+rjAPxWlamfaUHb30rSCMa8F/Nl1OBQbwgjr2O31Nc7o8/9CGp160tFVy9Gwr+2umjlfAFwtHi00BkpCBFcY0hnlQWwaOo0LNDr6p64OtsgJc1cyDiu+uYzTGCj1iVfm5RI1Vc2I24EsGe5F2EcgBijjc6iW+qPx4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5+MZ+KT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5+MZ+KT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B01F00893;
	Fri,  5 Jun 2026 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660564;
	bh=ZVBte0lxONFzgRAXaRGdu9YuPwy1sbMRgynLSp0yrOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5+MZ+KTfrjUXUdv8Mw2g4/clDjoA5E3YAnHARwW+66wApDVbbyu8vKDXhA1ShneP
	 yVLlf8O4mKq0TfiHrgYQagkiTj3S0SeNj2dtlLFCbsDrmhyCE8JjqhaEWxKEo8Xgn5
	 uE6o3atvnfXT3kjvsa/LzS0dsRhteSLXNALcQ5CDh2QrqzFOlJRP082fSW8x403Y+H
	 wWDiITDNnR9OKtuaubUWUYZAHb4X/h3EFYx1wh4kgC3/po4UW4xxjzpuaLUsB1ARu2
	 zPoRXB9VlJgi8Uao3/HFqcB72HF/mWYq809QI0ZeoRWDiC/fLAojFOLNpv3rx+Xc/B
	 y3V4dW9d+w02w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 05/12] bpf: Implement iteration ops for
 resizable hashtab
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605-rhash-v7-5-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-5-5b8e05f8630d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 11:56:03 +0000
Message-Id: <20260605115604.238B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Map iteration operations (bpf_for_each_map_elem and batch operatio=
ns) prematurely and silently abort if an element is concurrently deleted or=
 intentionally deleted by the BPF program.
- [High] Lack of atomicity in `lookup_and_delete_batch` on RHASH maps allow=
s returning duplicate elements to concurrent consumers.
--

commit 54494d14a4d025348520c4921d8c583a6d4257a2
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement iteration ops for resizable hashtab
   =20
Implement get_next_key, batch lookup/lookup-and-delete, for_each_map_elem
callback, and the seq_file BPF iterator for BPF_MAP_TYPE_RHASH.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3020,8 +3020,79 @@ static void rhtab_map_free_internal_structs(struct=
 bpf_map *map)
>  static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t call=
back_fn,
>  				void *callback_ctx, u64 flags)
>  {
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	void *prev_key =3D NULL;
> +	struct rhtab_elem *elem;
> +	int num_elems =3D 0;
> +	u64 ret =3D 0;

[ ... ]

> +	rcu_read_lock();
> +	/*
> +	 * Best-effort iteration: if rhashtable is concurrently resized or
> +	 * elements are deleted/inserted, there may be missed or duplicate
> +	 * elements visited.
> +	 */
> +	while ((elem =3D rhashtable_next_key(&rhtab->ht, prev_key))) {
> +		if (IS_ERR(elem))
> +			break;

[Severity: High]
If the BPF callback intentionally deletes the current element (which is a
common pattern for map cleanup), will rhashtable_next_key() return -ENOENT
because prev_key is no longer in the table?

If so, does this loop prematurely break and return num_elems without an
error code, silently truncating the iteration?

> +		num_elems++;
> +		ret =3D callback_fn((u64)(long)map,
> +				  (u64)(long)elem->data,
> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
> +				  (u64)(long)callback_ctx, 0);
> +		if (ret)
> +			break;
> +
> +		prev_key =3D elem->data;	/* valid while RCU held */
> +	}
> +	rcu_read_unlock();
> +
> +	return num_elems;
>  }

[ ... ]

> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);

[ ... ]

> +	while (elem && !IS_ERR(elem) && total < max_count) {
> +		memcpy(dst_key, elem->data, key_size);
> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
> +		check_and_init_map_value(map, dst_val);
> +
> +		if (do_delete)
> +			del_elems[total] =3D elem;
> +
> +		elem =3D rhashtable_next_key(&rhtab->ht, dst_key);

[Severity: High]
If a concurrent thread deletes the dst_key element, will
rhashtable_next_key() return -ENOENT and break the loop?

If this happens, has_next_cursor remains false and the function returns
-ENOENT to userspace. Will userspace misinterpret this -ENOENT as the
legitimate end of the map and stop iterating, dropping all remaining
unvisited elements?

> +		dst_key +=3D key_size;
> +		dst_val +=3D value_size;
> +		total++;
> +
> +		/* Bail to userspace to avoid stalls. */
> +		if (need_resched())
> +			break;
> +	}
> +
> +	if (elem && !IS_ERR(elem)) {
> +		/* Stash next-to-process key as cursor for the next batch. */
> +		memcpy(cursor, elem->data, key_size);
> +		has_next_cursor =3D true;
> +	}
> +
> +	if (do_delete) {
> +		for (i =3D 0; i < total; i++)
> +			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +	}

[Severity: High]
Because this function iterates locklessly under RCU and defers deletion
until after the loop, can concurrent batch calls overlap their reads and
observe the exact same elements?

If they both copy the identical elements into their userspace buffers, only
one will successfully delete the element, but the return value of
rhtab_delete_elem() is ignored. Could both threads successfully return the
same elements to userspace, violating the atomic pop semantics required by
applications draining the queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rhash-v7-0=
-5b8e05f8630d@meta.com?part=3D5
