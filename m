Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255D3939A3
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112623; cv=none; b=euIYK2K5k3nzUQ5hI0sZ+0PqxWiNiw8wnYT8nTmLA1Ea1jwoJFfXlmOXZNerwawcN5TewHA6T10Pb4fbmnBDlzzq4sigt7R5e0SnSuf01otE7BX+YJcoJfqEfL8caKErohFiZvAHO8FlIebPUM4ghtO6ZdZryPyKHSG0h5bzYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112623; c=relaxed/simple;
	bh=0UQ74kB69Dyno+DAcICRU2Tqkk2lLW/6URejSpoQFJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=BBtIOLwMfS5E9UnTjyLsRx+Ofm2Q1jH72OOYMqJl12c+luBiMGbU3Frt68N0J5D+wOMcPUbuJ94kzwGDHBwYXSbI8W7VVoIr8t3TiNagCcouZ16kdocrx//PicdgkDHS3Y1f4NoMz3gjU5evWARGDvnhMlxvickBxwuYVtT3spA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Lzvu4C2L; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Lzvu4C2L"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so4349691a91.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776112622; x=1776717422; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOvY7h786B+Mhc0IlCcQ5lKW9m2ktBaJjdnLBMGYBpA=;
        b=Lzvu4C2LUkTtq1J5FL2cIpJwCUAz7J+OiiYos4cRHx/9hoZHXC7TS4IRjgUju23XZ8
         V9hHTfCHrZk9cTrKzZU+qQ0/VsOW0FbNWciOqgGAwEuIPUhGvpOdx2cXQgW2JeuWgq8y
         teHlYHvVS7e0CBNfoeHOiA3v6UOgDGQIG0cNkWgViKQggqDhwnG3zUXGEG/SuqAUB5D3
         LM8veJh6ibNTYhI3dIa4tWYSdJy8p/uR8UxfT8G+cSyXDWibkUtGtzvY/kNq4iiug0Hc
         SrV0gtsE3+udqDL7XaW7q/9t+2wBHVng3gsDNvFD3D+KztE+hSUETa9oDAtuAh43ep2O
         Np3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112622; x=1776717422;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOvY7h786B+Mhc0IlCcQ5lKW9m2ktBaJjdnLBMGYBpA=;
        b=knqw1QKh2lPKHSOPK1DHFSey8u6pXcquU1J8VwB7PxdjM3aJrmIEViTQBCmoLpo6jh
         YTEYPkWiHLCq1uMEdWv6rZyeEZKrwmJEezJ+5espUYa+Z3dP1wfOATRdjQVO3Kvdx7vy
         EFigm106o0GJfigCFyhSN6ogXUYhFrCoK8HtzDNvemCk/lPIqTJrc31y1Wc6NEMNx6Zh
         XSi43juh7A/AogWUEXHTBXLFOSbvLtmmYhzbiixctFMqIW68PK68hKPTyIgQKTkvsooj
         QbGmOTQJ5uWsr+GjGHGL2nP3tL4T3I08KypCmYpcsMOnC9da0ZKP2LTckzLXKOmK40Cb
         dwbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+whPBKWdkHonrbebjRJ9RyXKslZcit+jNQ3Uf3EhwBZWkoYTJfrcUTAXTvzR1zEKVRM40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZNZjfKCRBK7n8hXDj1fk3TS7Px/L68c9Wl7uLHZE4ahT4pPw
	/C7ThnBulP4RsJdCC/FCxHfoBAguWQZqDtz4OpKSoRlj+ik4bsuRzwT8d1/76UMozm0=
X-Gm-Gg: AeBDietKbCKrQ8jsHLAI/BJS9rf8z73eyI36T/q7A4PT2AnprghqplzBGvGt1r8bS+8
	ev9YV+332e0YpDVbmecCCfbidUgo3EwnhZ1ZFe21xrQEfHM3W0we6KcJNBqDBhae0moxe3rYsGt
	8TZR1Hrw2WRhXvm0ga8zfNkt8Uq+j7FAE/be07/ZA6jA3EB551PtHrMa8p5O8d7nPoX01L7AewI
	n78gHay9RkwxfSWC86XcqD7Gz4MPWnCSF6Ua7IWpTeOAkGst4FmgwOBqpDfzeETHzdU8LUbIb44
	NO6CeS11ECsvET/h/+w5Er6h124v/bdgKhtfbNYNS8ltYXHRzFAY8H4FU9UvEBZJeXiXn1KhNUU
	A/VhuoTgILlsaPbWaZpVhsdZc6jjPqnHx6DTIOCtJKoJhnNLVLKAbNBz0+fRfV5g9qOqFbfYXkO
	N9dXRrMgkns8IhFkwnOg==
X-Received: by 2002:a17:90b:5746:b0:35d:a861:36de with SMTP id 98e67ed59e1d1-35e42853531mr14336007a91.24.1776112621684;
        Mon, 13 Apr 2026 13:37:01 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3517f2a0sm21240892a91.17.2026.04.13.13.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 13:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 16:37:00 -0400
Message-Id: <DHSBDLRKCAQO.1IPJTSEMPESV7@etsalapatis.com>
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-3-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Use rhashtable_lookup_likely() for lookups, rhashtable_remove_fast()
> for deletes, and rhashtable_lookup_get_insert_fast() for inserts.
>
> Updates modify values in place under RCU rather than allocating a
> new element and swapping the pointer (as regular htab does). This
> trades read consistency for performance: concurrent readers may
> see partial updates. Users requiring consistent reads should use
> BPF_F_LOCK.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 141 +++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 134 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9e7806814fec..ea7314cc3703 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2755,6 +2755,11 @@ struct bpf_rhtab {
>  	u32 elem_size;
>  };
> =20
> +static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
> +{
> +	return l->data + round_up(key_size, 8);
> +}
> +
>  static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
> @@ -2769,33 +2774,155 @@ static void rhtab_map_free(struct bpf_map *map)
>  {
>  }
> =20
> +static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	/* Using constant zeroed params to force rhashtable use inlined hashfun=
c */
> +	static const struct rhashtable_params params =3D { 0 };
> +
> +	return rhashtable_lookup_likely(&rhtab->ht, key, params);
> +}
> +
>  static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __mus=
t_hold(RCU)
>  {
> -	return NULL;
> +	struct rhtab_elem *l;
> +
> +	l =3D rhtab_lookup_elem(map, key);
> +	return l ? rhtab_elem_value(l, map->key_size) : NULL;
> +}
> +
> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem =
*elem)
> +{
> +	int err;
> +
> +	err =3D rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
> +	if (err)
> +		return err;
> +
> +	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab=
->map.key_size));
> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
> +	return 0;
>  }
> =20
>  static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *l;
> +
> +	guard(rcu)();
> +	l =3D rhtab_lookup_elem(map, key);
> +	return l ? rhtab_delete_elem(rhtab, l) : -ENOENT;
> +}
> +
> +static void rhtab_read_elem_value(struct bpf_map *map, void *dst, struct=
 rhtab_elem *elem,
> +				  u64 flags)
> +{
> +	void *src =3D rhtab_elem_value(elem, map->key_size);
> +
> +	if (flags & BPF_F_LOCK)
> +		copy_map_value_locked(map, dst, src, true);
> +	else
> +		copy_map_value(map, dst, src);
>  }
> =20
>  static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *k=
ey, void *value, u64 flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *l;
> +	int err;
> +
> +	if ((flags & ~BPF_F_LOCK) ||
> +	    ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPI=
N_LOCK)))
> +		return -EINVAL;
> +
> +	/* Make sure element is not deleted between lookup and copy */
> +	guard(rcu)();
> +
> +	l =3D rhtab_lookup_elem(map, key);
> +	if (!l)
> +		return -ENOENT;
> +
> +	rhtab_read_elem_value(map, value, l, flags);
> +	err =3D rhtab_delete_elem(rhtab, l);
> +	if (err)
> +		return err;
> +
> +	check_and_init_map_value(map, value);
> +	return 0;
>  }
> =20
> -static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *=
value, u64 map_flags)
> +static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_=
elem *elem, void *value,
> +				      u64 map_flags)
>  {
> -	return -EOPNOTSUPP;
> +	if (map_flags & BPF_NOEXIST)
> +		return -EEXIST;
> +
> +	if (map_flags & BPF_F_LOCK)
> +		copy_map_value_locked(map, rhtab_elem_value(elem, map->key_size), valu=
e, false);
> +	else
> +		copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);

It looks like Sashiko is accurate about special fields not getting handled =
here.

> +	return 0;
>  }
> =20
> -static void rhtab_map_free_internal_structs(struct bpf_map *map)
> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *=
value, u64 map_flags)
>  {
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *elem, *tmp;
> +
> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> +		return -EINVAL;
> +
> +	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_=
SPIN_LOCK))
> +		return -EINVAL;
> +
> +	guard(rcu)();
> +	elem =3D rhtab_lookup_elem(map, key);
> +	if (elem)
> +		return rhtab_map_update_existing(map, elem, value, map_flags);
> +
> +	if (map_flags & BPF_EXIST)
> +		return -ENOENT;
> +
> +	/* Check max_entries limit before inserting new element */
> +	if (atomic_read(&rhtab->ht.nelems) >=3D map->max_entries)
> +		return -E2BIG;
> +
> +	elem =3D bpf_mem_cache_alloc(&rhtab->ma);
> +	if (!elem)
> +		return -ENOMEM;
> +
> +	memcpy(elem->data, key, map->key_size);
> +	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> +
> +	tmp =3D rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhta=
b->params);
> +	if (tmp) {
> +		bpf_mem_cache_free(&rhtab->ma, elem);
> +		if (IS_ERR(tmp))
> +			return PTR_ERR(tmp);
> +
> +		return rhtab_map_update_existing(map, tmp, value, map_flags);
> +	}
> +
> +	return 0;
>  }

Note: I am actually skeptical about Sashiko's warning here. Sure, the
update may get overwritten even as we are returning 0, but we are
providing no guarantees about how long the write will survive in the
map, and there is no inherent atomicity between an update and any other
operations.

> =20
>  static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *in=
sn_buf)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_insn *insn =3D insn_buf;
> +	const int ret =3D BPF_REG_0;
> +
> +	BUILD_BUG_ON(!__same_type(&rhtab_lookup_elem,
> +				  (void *(*)(struct bpf_map *map, void *key)) NULL));
> +	*insn++ =3D BPF_EMIT_CALL(rhtab_lookup_elem);
> +	*insn++ =3D BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
> +	*insn++ =3D BPF_ALU64_IMM(BPF_ADD, ret,
> +				offsetof(struct rhtab_elem, data) + round_up(map->key_size, 8));
> +
> +	return insn - insn_buf;
> +}
> +
> +static void rhtab_map_free_internal_structs(struct bpf_map *map)
> +{
>  }

This gets filled in in later patches, but the fact it's here and a no-op
debatably the line into being non-bisectable. Can we move it to the walk
patch, since that's where it gets populated?

> =20
>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *=
next_key)

