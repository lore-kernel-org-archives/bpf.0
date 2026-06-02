Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F099221DB6
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434440; cv=none; b=swwXhcCI7IHgfRl5Ymg8G+4IaWGuWHFAlgYngHol/khQNq5KkjJjEA/ki0JiphcN/wO1L62GGUl4WxEMnNAB//yIxfk0Q6mQfS4/a8FkLDoUbeQLX+jkHkoEHaswgKZ+m7hLAfYu3RBXE84BTr9NeVzK3cODeKDGn4HoNpyob7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434440; c=relaxed/simple;
	bh=iJM/QvU0dxosYNshmiRi/UsBZWy18J8b0+4/n7CQVPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnCV91fYMLZ+kBA+UfYxuQSwkN0E0SPHM3ZR+2dtfF/WZe2nPTQdCeQvTRIrT7TCdU2kFLUK6yb3PPqlAu6UYjF+hciY5IN7fl934Wpl6eiCOQknc+rZ1FqnJyixJRHyYNwL8pWK1gFjRCNucSxwNtHOspQTGPKJvY8H97JGwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeB+Q4vW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeB+Q4vW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED5C1F00893;
	Tue,  2 Jun 2026 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780434438;
	bh=xlzflsd/FmaXyPDn48FLVSMoDNP37Tt518ogQv4jpos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OeB+Q4vWvaItyjTnzJ//8vgUYo0ardRdmKQE0+InS6IJ5rGmY3rPJsz9GCDozx9Uc
	 na8t8GVxdIz++d922gSYANWM3feqYtEqMY4ndY/4USXubJhTrJNKbdL4sUvKwYWSdc
	 CPWn5NUqmlHXJXlfCwMrcKsDDkMu0Xhk3nGeY1+TaBIp/whQwKE+vy3YjaxqOJ6vHa
	 g+apdoJn8RRXDzLwc3CO39FgsRP8Lwa2MwtJTpoyRkDi6fgP0sbcupr8bn6GysJM9+
	 CWNgRLV6AEhD1LBlWEhuuKw8Y8PlhJCcU9Sc8CE52qIj+9bRHiio2pB33kFfHt+Zvj
	 JJmA3fJATehWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 03/11] bpf: Implement resizable hashmap
 basic functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 21:07:18 +0000
Message-Id: <20260602210718.AED5C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The BPF rhashtable map is not NMI-safe, leading to deadlocks a=
nd illegal `schedule_work` calls from NMI context.
--

commit a3ac6d3147a7f487e19583eefa998031e7f5900a
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement resizable hashmap basic functions

This commit implements basic operations for a new BPF resizable hashmap
(BPF_MAP_TYPE_RHASH) backed by rhashtable. It introduces functions for
lookup, insertion, deletion, and update, operating with RCU and memory
allocators. The map tries to mitigate NMI reentrancy deadlocks by disabling
instrumentation during rhashtable modifications.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4f..10f3a058747b3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -2739,3 +2740,313 @@ const struct bpf_map_ops htab_of_maps_map_ops =3D=
 {
[ ... ]
> +static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
> +{
[ ... ]
> +	params =3D rhtab_params;
> +	params.key_len =3D rhtab->map.key_size;
> +	params.nelem_hint =3D (u32)attr->map_extra;
> +	params.automatic_shrinking =3D true;
> +
> +	err =3D rhashtable_init(&rhtab->ht, &params);
[ ... ]
> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem =
*elem, void *copy,
> +			     u64 flags)
> +{
> +	int err;
> +
> +	/*
> +	 * disable_instrumentation() mitigates the deadlock for programs runnin=
g in NMI context.
> +	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may=
 reenter
> +	 * rhashtable code, bpf_disable_instrumentation() disables programs run=
ning in NMI, except
> +	 * raw tracepoints, which we don't have in rhashtable.
> +	 */
> +	bpf_disable_instrumentation();
> +	err =3D rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);

[Severity: Critical]
Is it possible for raw tracepoints or perf events executing in NMI context
to bypass this bpf_prog_active recursion check?

If an NMI interrupts a map operation and executes a raw tracepoint program
that accesses the same bucket, wouldn't it spin infinitely in
bit_spin_lock() and cause a hard deadlock?

Also, since the map is initialized with automatic_shrinking =3D true, cross=
ing
the 30% residency threshold will synchronously invoke schedule_work().

If this happens within an NMI context (like a perf event), won't it trigger
WARN_ON_ONCE(in_nmi()) in __queue_work() and permanently break the map's
resizing mechanism, while potentially deadlocking on workqueue pool locks?

> +	bpf_enable_instrumentation();
> +
> +	if (err)
> +		return err;
[ ... ]
> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *=
value, u64 map_flags)
> +{
[ ... ]
> +	/* Prevent deadlock for NMI programs attempting to take bucket lock */
> +	bpf_disable_instrumentation();
> +	tmp =3D rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhta=
b_params);

[Severity: Critical]
Similarly, can this insertion trigger schedule_work() from NMI context
when crossing the 75% residency threshold for table expansion?

> +	bpf_enable_instrumentation();
> +
> +	if (tmp) {
> +		bpf_mem_cache_free(&rhtab->ma, elem);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-rhash-v6-0=
-1bfd35a4184f@meta.com?part=3D3
