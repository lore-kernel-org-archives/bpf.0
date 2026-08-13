Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840B3A8759
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665598; cv=none; b=V61zcMjjfdNboizmNMhsESaaUQcXlftiBTnyy6/QqnKfWtEd8/xW8j8fGjsApeI9j3ESoeLb3Fz5yzYShY+vvUZjRxYz1o37XOv3TT8W8j0E7szaBgC40melF9WcFHxUeIa3DPvx7A54rZUGiNTWk2FESrgT03MLkSOqmeqrv90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665598; c=relaxed/simple;
	bh=JYYEEsvTD0nDdtJVQ4+qR1cel9EoP7I5GlpLolq0L7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPb/RXJCqfRbkHlkJDC7hoK3buRdsR4laSZz3yM3VszWSVukLdusZMesEJmKiwpxvGt0uHG7Lb+0f6LwBJKADaq6OwmAPMlfUDpz64U/8/RD6nZZ5zHaq0PyIf+OYxoOdVXQKvYgYnNmgqHA/7SXi/XAJsbBTjt+TIkwmt4A7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npnew+rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npnew+rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC751F000E9;
	Thu, 13 Aug 2026 23:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665597;
	bh=4mxZexypqozCpASw9MytcV0V9iDQ8KA4qRuuc1A0vuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Npnew+rn1gJOO7bqNcWBio1FAKQq+W0Vlu7kA6yxLNEKQ+0QQ9clA2V+prjyjtOHg
	 phMwCdv18NpbTpLqSKHv+1jbQrMPvJI45b7Yn0U2D8yVmaq0u3RHoaoPI9hC2CiTMb
	 ochcYYC7w13/e3Mh4nfamwlq/bGiuInzPbow+HdWARYFfd0uaZ6twT+m2TPPFhUwhf
	 G2gK2W28xTA/ZHBzanpk7EK3lzCVAF2RvIDLbhxDjCc2vyUZRfmWhCCAZJOIHUE0ge
	 aUY7QgckdTxgBbTSugz764j6ankL89VQo47oL5jsDCsKhrlcWrwkGTrHGW1v2a0owE
	 UmzZhkPvnXvVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for
 resizable hashtab
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260408-rhash-v2-8-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-8-3b3675da1f6e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:59:51 +0000
Message-Id: <20260813235957.0AC751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Uninitialized memory read in `last_key` when `seq_show` overflows.
- [High] `rhashtable_walk_enter_from` resets iterator on deleted cursor key=
, causing O(N^2) complexity and infinite loops.
- [Medium] Missing __GFP_NOWARN flag in user-controlled kmalloc for map->ke=
y_size can lead to OOM splats.
--

--- Patch [8]: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs f=
or resizable hashtab ---
commit 226ce1988038cf4876ff0a72b5ae8e5ebc263151
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement iterator APIs for resizable hashtab

Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
bpf_iter and bpftool map dump work with resizable hash maps.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4611671bf8e74..5ca4d26e70178 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3205,36 +3218,113 @@ struct bpf_iter_seq_rhash_map_info {
>  	struct bpf_map *map;
>  	struct bpf_rhtab *rhtab;
>  	struct rhashtable_iter iter;
> -	u32 skip_elems;
> +	void *last_key;
>  	bool iter_active;
>  };
> =20
>  static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>  {
> -	return NULL;
> +	struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> +	struct rhtab_elem *elem;
> +	void *key =3D *pos > 0 ? info->last_key : NULL;
> +
> +	scoped_guard(rcu) {
> +		rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
> +					   key, info->rhtab->params);

[Severity: High]
Will this silently restart iteration from bucket 0 if the cursor key is del=
eted?

rhashtable_walk_enter_from() looks up the provided cursor key to resume
iteration. If the key is missing, it returns early and leaves the iterator =
at
bucket 0 (iter->slot =3D 0).

In __rhtab_map_lookup_and_delete_batch(), the batch operation deletes eleme=
nts
and returns the last deleted key to userspace. On the next batch syscall, t=
he
user passes this deleted key back as the cursor. Since the key no longer
exists, rhashtable_walk_enter_from() resets the iterator to 0.

The inner loop then executes while (total < max_count) holding rcu_read_loc=
k(),
rescanning all previously emptied buckets from the beginning of the table.

For lookup_batch and seq_file iterators, does this yield massive duplicate
outputs to userspace and enormous RCU stall times?

> +		rhashtable_walk_start(&info->iter);
> +	}
> +	info->iter_active =3D true;
> +
> +	elem =3D rhtab_iter_next(&info->iter);
> +	if (!elem)
> +		return NULL;
> +	/*
> +	 * if *pos is not 0, previously iteration failed on this elem,
> +	 * so we are restarting it. That's why no need to increment *pos.
> +	 */
> +	if (*pos =3D=3D 0)
> +		++*pos;

[Severity: High]
Does this pass uninitialized memory as a hash key if seq_show() output
overflows?

When reading a BPF iterator, seq_read_iter() calls bpf_rhash_map_seq_start(=
),
which increments *pos from 0 to 1 and returns the first element.

If the output of seq_show() for this element exceeds the initial seq_file
buffer, the buffer overflows. The sequence machinery reallocates a larger
buffer and calls seq_start() again.

Since *pos is now 1, the code executes key =3D info->last_key. However, las=
t_key
is only populated in seq_next(), which hasn't been called yet. Thus, last_k=
ey
remains uninitialized from its kmalloc(..., GFP_USER) allocation.

> +	return elem;
>  }

[ ... ]

>  static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_=
info *aux)
>  {
> +	struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
> +	struct bpf_map *map =3D aux->map;
> +
> +	info->last_key =3D kmalloc(map->key_size, GFP_USER);

[Severity: Medium]
Does this need __GFP_NOWARN?

Since BPF hash map key sizes can be extremely large, requesting large
contiguous memory blocks without __GFP_NOWARN can fail loudly under memory
fragmentation and trigger high-order page allocation warnings.

> +	if (!info->last_key)
> +		return -ENOMEM;
> +
> +	bpf_map_inc_with_uref(map);
> +	info->map =3D map;
> +	info->rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	info->iter_active =3D false;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-rhash-v2-0=
-3b3675da1f6e@meta.com?part=3D8
