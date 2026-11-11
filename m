Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382712;
	b=Fquw/qumq1ATOA/Ynnr/wwh01MsVnDK3mt0axj2oNFRhkOOYfAmmuaCEnvEK6ASozMhK
	 3x7hoRvr0/eNmCJEMjEm4MNuEhROQFP/qLiReQ2jvm7A0pAQm9l08/rNgLdtZ+8k/oZr7
	 xxKhnS5tWGjvCovPgtKiCCPSTCp1tMlOd+cuhmKDJMJeWUi33ZYSnY05IRtm05Y2PN6f2
	 rj+OvtZ7zWJr5KQaovKN4EH6xmtqbPK3Y3jOCrSUUpn6N5yqbX5faj2e0z95Gdy4Bi6Zd
	 t4SjtREZbuKoJTUBMj0GKby0ZWJH0KDG7hnmxNW/NHVcywHC4kQ6gnMA/LV49L21pJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bO5rxit6USkrft3N2tcytxP6nv4U9l+A1JlCAlqUMZ0=;
	b=PjpmfRQRW2grj4zDtUde+R8Mg0oyGtblz3IvByPnvKDPJFx9eSYOpuc5E+wIdcORT4C4
	 OIHluhH9HeqJ84W1wH3yz9IZFbC/UewJAnG1EQvwI+iCnUm85k0guA3rPPfoCP1TBgDV9
	 RU41+ai6H4dmImZHbDE8U1lIep1gKaK/CyL8benbSwC7tQ5NvvazWj4xsQQdgIJAQaIek
	 Ej1Je9WAmQD2pBQHlAxFzJPUC1XEXdQGVmXfQgIxl5zKMCsakJ/KNxOl9kq3v25XR6ErP
	 9P7l2t5PFNfxcf3roUFm61yFvhhQVKVF3MrcvFo3LoMbGNWEsqIw8RdgNG/+Oq0jpVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzvwwaZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C8606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzvwwaZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6601F00A05;
	Wed, 11 Nov 2026 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794382712;
	bh=bO5rxit6USkrft3N2tcytxP6nv4U9l+A1JlCAlqUMZ0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TzvwwaZ6LQRdL2og8z8CgZJx7NueZQIJkh+UzbPn2GKWImdqaBjmqezBorRKYTXtS
	 SCtYSgi++MiMCLfxvyAB68mLB11ayE049thqcnjxkSw7V1UkVnGP0vJReEqgeCpQAS
	 c79hCpf6abpgHYrMmlfIa6DGNaByE28XEgyVspqr0RtWfowpa3+c1QZD3wuLlfoM/v
	 GGOdeKtJdBxjYlNB4Z7HHf+Ue7BKIZybAuQ7gZtkQFFmJo6vTMCXorYCieHqNATjx0
	 NA4zIg8f9LzQf20qkQ6YIuOmKAEG5CTnICYUL6QKCRpONCEevZzHvWVX5E/LNuv/P8
	 JbEdF8gGoRIig==
Message-ID: <sashiko-outbox-208531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 1/2] bpftool: Use batch lookups for map
 dumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>, bpf@vger.kernel.org
In-Reply-To: <074a359a044d121b4d85d5b15b7740bc9a9f1073.1794380384.git.hi@tychen.cc>
References: <cover.1794380384.git.hi@tychen.cc>
 <074a359a044d121b4d85d5b15b7740bc9a9f1073.1794380384.git.hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:38:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpftool: silent map dump truncation on RHASH in
  dump_map_batch()
--

commit 7f62f4c69f650b2c84d0fbb5439eadc6c97b8aea
Author: Tianyi Chen <hi@tychen.cc>

bpftool: Use batch lookups for map dumps

This commit updates map_dump() to use BPF_MAP_LOOKUP_BATCH in 1 MiB batches
and fall back to bpf_map_get_next_key() after the last printed key if a
batch lookup fails.

Link: https://github.com/libbpf/bpftool/issues/63

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 4b65edf74859b..c5c56323f0623 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
[ ... ]
> @@ -763,10 +761,75 @@ static int dump_map_elem(int fd, void *key, void *v=
alue,
>  	} else {
>  		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
>  	}
> +}
>
> +static int dump_map_elem(int fd, void *key, void *value,
> +			 struct bpf_map_info *map_info, struct btf *btf,
> +			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
> +{
> +	if (bpf_map_lookup_elem(fd, key, value)) {
> +		print_entry_error(map_info, key, errno);
> +		return -1;
> +	}
> +
> +	print_map_elem(key, value, map_info, btf, btf_wtr, cpu_ids, cpu_cnt);
>  	return 0;
>  }
>
> +#define MAP_DUMP_BATCH_BYTES (1U << 20)
> +
> +/*
> + * Print the elements returned by batched lookups, leaving the last one =
in
> + * @key. Return true at the end of the map. After any error, the caller
> + * continues with bpf_map_get_next_key(), which walks the map in the sam=
e order.
> + * The caller must ensure that key_size + value_size is non-zero.
> + */
> +static bool dump_map_batch(int fd, void *key, void *value,
> +			   struct bpf_map_info *info, struct btf *btf,
> +			   json_writer_t *wtr, const int *cpu_ids, int cpu_cnt,
> +			   unsigned int *num_elems)
> +{
> +	size_t value_size =3D map_value_size(info);
> +	void *keys, *values, *batch, *in_batch =3D NULL;
> +	__u32 capacity, count, i;
> +	bool done =3D false;
> +	int err;
> +
> +	capacity =3D min(MAP_DUMP_BATCH_BYTES / (info->key_size + value_size),
> +		       (size_t)info->max_entries);
> +	if (!capacity)
> +		return false;
> +
> +	/* Hash table batch cursors are u32 bucket indices; other maps use keys=
. */
> +	batch =3D malloc(max(info->key_size, 4U));
> +	keys =3D malloc((size_t)capacity * info->key_size);
> +	values =3D malloc((size_t)capacity * value_size);
> +	if (!batch || !keys || !values)
> +		goto out;
> +
> +	do {
> +		count =3D capacity;
> +		err =3D bpf_map_lookup_batch(fd, in_batch, batch, keys, values,
> +					   &count, NULL);
> +		if (err && err !=3D -ENOENT)
> +			goto out;
> +		for (i =3D 0; i < count; i++) {
> +			/* Preserve alignment for odd-sized BTF keys and values. */
> +			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
> +			memcpy(value, values + (size_t)i * value_size, value_size);
> +			print_map_elem(key, value, info, btf, wtr, cpu_ids, cpu_cnt);
> +		}
> +		*num_elems +=3D count;
> +		in_batch =3D batch;
> +	} while (!err);
> +	done =3D true;

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v9 [1], can dump_map_batch()
silently truncate a BPF_MAP_TYPE_RHASH dump when an element is deleted
concurrently?

For BPF_MAP_TYPE_RHASH, __rhtab_map_lookup_and_delete_batch() holds only
rcu_read_lock().  If dst_key is removed between copying elem->data and
calling rhashtable_next_key(&rhtab->ht, dst_key), rhashtable_next_key()
returns ERR_PTR(-ENOENT), which leaves has_next_cursor false and causes
__rhtab_map_lookup_and_delete_batch() to return -ENOENT early:

kernel/bpf/hashtab.c:__rhtab_map_lookup_and_delete_batch() {
	...
	while (elem && !IS_ERR(elem) && total < max_count) {
		memcpy(dst_key, elem->data, key_size);
		...
		elem =3D rhashtable_next_key(&rhtab->ht, dst_key);
		...
	}

	if (elem && !IS_ERR(elem)) {
		/* Stash next-to-process key as cursor for the next batch. */
		memcpy(cursor, elem->data, key_size);
		has_next_cursor =3D true;
	}
	...
	/* No more elements after this batch. */
	if (!has_next_cursor)
		ret =3D -ENOENT;
}

Because dump_map_batch() treats -ENOENT as end-of-map and returns true,
map_dump() skips the bpf_map_get_next_key() fallback loop (where
rhtab_map_get_next_key() restarts from NULL on -ENOENT) and exits with
success after printing only part of the map.

[1] https://lore.kernel.org/r/33b057d852c258c157f6aa31e45083418944efe0efaad=
1d72bcb5513205a67f6@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794380384.gi=
t.hi@tychen.cc?part=3D1
