Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71980382F0F
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425135; cv=none; b=W81Z2VNgkkFJ+xiwenvrCjQcf8se4zMIGuQg63FSnPH3HUecRFLNSgKtMOYanUGTwe04u/aWKSF0RRcXw2PJEnG9s6fpB/yJx7WB7WKANkHM1M3pxD0rRHOChOz0XQJMg0jNJ6Ww8xi0Gd1NVQQWasPqADhRIUDxWeIkl98aybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425135; c=relaxed/simple;
	bh=VPOsF/INLDBEL9F0s2IXacxaoYWB5BuXae4JUog73OY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YvoSem0bgrlBlrK3OoYAIkQwfU1xsu5mx6HKWaW3dssW8QLY8f1WrSJe4bocTVTA2UTDwomcet2/mV8azvlyMIMDCCF1n00cZd2eWFC9SLxtuQSvr8yXejE3mXbBAB1FWlLeB3pk5PxgELHKpuQoZNFrzc99EB0xEW9AN7CV6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHDFAip4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHDFAip4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78781F000E9;
	Thu,  3 Sep 2026 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788425134;
	bh=Wt18/RotoCBCiayW0LcHjSaDQYW2WmE4uR8g3jtmHBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lHDFAip46RP4XDvR+1HLN2JLLod7cf/hvq8ltzIGBw5zSRy4igsleFVW/1Jpqt4vs
	 gFGuckTBBJnlotO24+9g4Y+MwbnrzHCosIedT/FRWfkhVcvuF/hRWRB5+F1R+/NlX6
	 oOs193gId4mk4Gk5u0YSBe5OjZypI9VbUNsIxe5XIzojwWWOLMXINGR78nsmCNaAT8
	 cQAQAdStjuRioaRTbAGPys/Qp2ZWs9QCnPKzP8YsefHWXgPLgO/4JDBQ+xtnJy6rfl
	 IkORr/ymepj61AC1wNK8zT10ck7z1tNVfxGSysJlK7LF2lYTqN4dRPuOzGNqGs60Vd
	 SCaBcH/riH5XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Masoud Aghasi" <maghasi@disroot.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903082734.623904-1-maghasi@disroot.org>
References: <20260902204439.287888-1-maghasi@disroot.org>
 <20260903082734.623904-1-maghasi@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:45:33 +0000
Message-Id: <20260903084533.E78781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing size_t casts in queue_stack_maps.c cause pointer arith=
metic to overflow u32, corrupting map data.
- [High] qs->size is typed as u32, which can silently overflow to 0 when ma=
x_entries is U32_MAX.
--

commit aa1d0d53f1c01402c01cb62c0b2ef581ca4869bd
Author: Masoud Aghasi <maghasi@disroot.org>

bpf: Fix u32 overflow issue in map batch operations

This patch fixes a u32 overflow in several map batch operations that can oc=
cur
when the map size exceeds 4GB. It adds size_t casts to prevent the offset a=
nd
size calculations from overflowing during memory operations.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af0..731388ae00ad1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -2179,12 +2179,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  		if (err)
>  			goto free_buf;
> =20
> -		if (copy_to_user(keys + cp * map->key_size, key,
> +		if (copy_to_user(keys + (size_t)cp * map->key_size, key,
>  				 map->key_size)) {
>  			err =3D -EFAULT;
>  			goto free_buf;
>  		}
> -		if (copy_to_user(values + cp * value_size, value, value_size)) {
> +		if (copy_to_user(values + (size_t)cp * value_size, value, value_size))=
 {
>  			err =3D -EFAULT;
>  			goto free_buf;
>  		}

[Severity: Critical]
This is a pre-existing issue, but since this patch fixes u32 overflows for
map element offsets, could we also address similar overflows in
queue_stack_maps.c?

If a queue or stack map is created where the capacity (max_entries *
value_size) exceeds 4GB, do these calculations wrap the element offset when
head, tail, or index counters multiply with map.value_size?

kernel/bpf/queue_stack_maps.c:__queue_map_get() {
    ...
    ptr =3D &qs->elements[qs->tail * qs->map.value_size];
    ...
}

kernel/bpf/queue_stack_maps.c:__stack_map_get() {
    ...
    ptr =3D &qs->elements[index * qs->map.value_size];
    ...
}

kernel/bpf/queue_stack_maps.c:queue_stack_map_push_elem() {
    ...
    dst =3D &qs->elements[qs->head * qs->map.value_size];
    ...
}

[Severity: High]
This is also a pre-existing issue, but I noticed a potential truncation=20
when allocating these maps:

kernel/bpf/queue_stack_maps.c:queue_stack_map_alloc() {
    ...
    qs->size =3D size;
    ...
}

If a user allocates a queue or stack map with max_entries set exactly to
U32_MAX, the required size calculation (u64)attr->max_entries + 1 evaluates
to 0x100000000. Because qs->size is typed as u32, does this assignment
silently truncate the size to 0, resulting in a map that behaves like it has
0 capacity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903082734.6239=
04-1-maghasi@disroot.org?part=3D1
