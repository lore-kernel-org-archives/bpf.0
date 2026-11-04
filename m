Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792669;
	b=3Gx1RIfjmRTgim7mnqqzKaxgyqocBrRzzs60zRNa+spxwFeDyLs6PiyH0T6LbXZY+9w8
	 6Z5qndhhrcsmJDP4qTq0oRgfxTHx1wcBI4cwLADE2fyHiraP7v3cNj1alEgsA/Gs4qbkT
	 WaroaK8loHJItXl/KLwVBOb41mqL1fTcDEuFjNpkZwFngtrQFxPDgpd9rTp2aAl3CGlNM
	 4tzoU7zS9uzIAZ1qcO2sJTmclQfalOLIMn97jhXBqLBp0qFSAgsylEjiucpEA3dzAZntL
	 GO5xddD7EgRqgqwWsoGCewcCcFWV0c/oWniIn1XVghe9cAfmCaZUWqgHTcGye8miOBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792669;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MCHLSDt+HGfIFfBZxPhOJyFqDa+Aaf/f8dPGVuBq0k0=;
	b=NCKOOckzgOMHN+g1M7RXjE9d113tES7oPlxp/J3qtYUemXVPVY6vhES4Wdw6//TcSpOa
	 YwFpi/kaXrSS6hJiJUkLVUVJdl+fA0a5erhhe6/xxSjgF/jyR7Vo/mAotj8o3j8E1dRt6
	 VKC8rbaHTLK84STvYL+GQPCRMtvMy3p0n53n/OrGBANhpl6I+ILeDuxkylLQ+x1oRleAp
	 LMjV/0DV1g9SFiDVvaWujcf+IIqkM/XilnLjvoq6ipI1kN8bHB1K02+nzhnAjEmo7CYbD
	 aJ7pqNXftPyL6yP+9t+u9LAqBnGiKBvIBjXMjpxLb5Y9Tcrwz2nHg6q9oVWzTPRLjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEa3BscL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47A606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEa3BscL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338A21F000C1;
	Wed,  4 Nov 2026 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792668;
	bh=MCHLSDt+HGfIFfBZxPhOJyFqDa+Aaf/f8dPGVuBq0k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEa3BscLm++y+6NFLsTf8L5/ZHSqtNF28hV16FVWisQleQDwphAEW0830Y8OllJ+l
	 8+wIV271xELmUR5jGnCauWD6wY/OgdxsLUd8avo1faoZnyqQsNooTBB1lJBRGWy2+H
	 DFM0hnixV+2if1tjNYDSkvFoD8zkuyj6d83hdCve9TpXfnEa68KKu7qrssDtx3Dvkb
	 d3AwQSc5obtXKhhQqaQyhEgF5A3LN5vrvWFZrYxANF+GteO1rkjPmqoc/OSK7HZboK
	 /oTtFGmNV2p9lkNIgDIC/s8Q6TbkTETF4kBKqVhv9C9O6IQtVSq+uBKD5kvh1zzNNJ
	 8Rq32GldnXGdQ==
Message-ID: <sashiko-outbox-197207@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Limit local storage value size to max
 kmalloc_nolock() allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonathan Bastari Thamrin" <thamrinjonathan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261104-local-storage-max-v1-1-c836731bd184@gmail.com>
References: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
 <20261104-local-storage-max-v1-1-c836731bd184@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:44:27 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: non-standard multi-line comment style in local storage files
--

commit bbb69a62fc0fe47ec15aa691029d15c86b6ea57a
Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

bpf: Limit local storage value size to max kmalloc_nolock() allocation

This commit updates BPF_LOCAL_STORAGE_MAX_VALUE_SIZE to be bounded by
KMALLOC_MAX_CACHE_SIZE so that local storage maps using kmalloc_nolock()
reject oversized values with E2BIG at map creation time. It also introduces
BPF_CGROUP_STORAGE_MAX_VALUE_SIZE to preserve the previous limit for
BPF_MAP_TYPE_CGROUP_STORAGE, which allocates elements with kmalloc().

Link: https://lore.kernel.org/bpf/CAADnVQKeFF--bgnZZSU12UY0muuwYA=3D7EdzLyO=
i837oZs+bXTA@mail.gmail.com/

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 6c643ac510799..e1ce75b0fb0ac 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -117,13 +117,13 @@ bpf_local_storage_unpin_owner(struct bpf_local_stor=
age *local_storage)
>  	last =3D refcount_dec_and_test(&local_storage->owner_refcnt);
>  }
> =20
> -/* U16_MAX is much more than enough for sk local storage
> - * considering a tcp_sock is ~2k.
> +/* Elements come from kmalloc_nolock() where the max size
> + * is KMALLOC_MAX_CACHE_SIZE.
>   */
> -#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				       \
> +#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE                                =
       \
>  	min_t(u32,                                                             \
> -	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -                              \
> -	       sizeof(struct bpf_local_storage_elem)),                         \
> +	      (KMALLOC_MAX_CACHE_SIZE -                                        \
> +	       offsetof(struct bpf_local_storage_elem, sdata.data)),           \
>  	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
> =20
>  #define SELEM(_SDATA)                                                   =
       \
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 83cd527a2542b..22a9841d4fd55 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -18,6 +18,15 @@
>  #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
>  	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
> =20
> +/* Cgroup storage allocates with kmalloc() where the max size is
> + * larger than kmalloc_nolock() used by other local storages.
> + */
> +#define BPF_CGROUP_STORAGE_MAX_VALUE_SIZE                               =
       \
> +	min_t(u32,                                                             \
> +	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -                              \
> +	       sizeof(struct bpf_local_storage_elem)),                         \
> +	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
> +
>  struct bpf_cgroup_storage_map {
>  	struct bpf_map map;
> =20
> @@ -296,12 +305,12 @@ static int cgroup_storage_get_next_key(struct bpf_m=
ap *_map, void *key,
> =20
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -	__u32 max_value_size =3D BPF_LOCAL_STORAGE_MAX_VALUE_SIZE;
> +	__u32 max_value_size =3D BPF_CGROUP_STORAGE_MAX_VALUE_SIZE;
>  	int numa_node =3D bpf_map_attr_numa_node(attr);
>  	struct bpf_cgroup_storage_map *map;
> =20
>  	/* percpu is bound by PCPU_MIN_UNIT_SIZE, non-percu
> -	 * is the same as other local storages.
> +	 * uses the cgroup storage limit above
>  	 */

[Severity: Low]
This isn't a bug, but in BPF code, multi-line comments place the opening /*
on its own line with the comment text starting on the following line. Could
the multi-line comments above BPF_LOCAL_STORAGE_MAX_VALUE_SIZE in
include/linux/bpf_local_storage.h, as well as above
BPF_CGROUP_STORAGE_MAX_VALUE_SIZE and in cgroup_storage_map_alloc() in
kernel/bpf/local_storage.c, be formatted to follow this style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-local-stor=
age-max-v1-0-c836731bd184@gmail.com?part=3D1
