Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1393C3429
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408189; cv=none; b=DIqyzsVJyPaN/Wq8yiMVeIs+SYuM0PQuBSAGLX/ksCx6yldmN2POmJ5uTZXzQI4pqZnPAfKXD7SuEeeOgzXQ5lRVC6quOMl792wS5eZ8ArcixkEdEo4lvEcw5F/TXyaH/noDXwl/bAVi5jKSfz0ye9lrvir3gxeQdUlOO3oMNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408189; c=relaxed/simple;
	bh=IZ+Gbe3Pav/PJsSZ8AA+ChCFTjI07dXHqamgwWS6wuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=slPfAjyS0U0RDJo23KTAoahrXrgVWqMLhpBmrld9kaJC3clz2jSskpsz9rGQ22l7nTWuWy+zzIgSMM0y/kL7R6p0c5YDw3rHpBFMU2DQ/Nv6bNNWhSi5OREyLQx2umVkUh0wAyRWNN1DPi6sV2Fmlx9IpTYoyFXuh5DzJBcVR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yoi676Qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yoi676Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8EA1F00898;
	Tue,  2 Jun 2026 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780408188;
	bh=MthUCxWRzLfbijfDbr8DnxzqDLpPXKkbXYp/UxnqWQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yoi676QpafMvqrSri+J3h0DyK8zzNTpdtDhGLX0qyutsdFQUgfSVxVnCZCFVS9ZBY
	 JWMdb1b/y+I7GsJqgGkYTFBVRWUgD9yy4CLucnw5dBlu0WHS/PV4a1SzcxqvzN0+9W
	 2iawoWWbXdlt7PkK24KMOweW892OqbdefV0oKOCm8Ls/TX8c86cuwAaFTdcOpVuLD+
	 ENQ6IkmPihOIH1dQ77GTy4ieX6+BVpCbJvBhKKBvWzqmUY7dntPKUJhdwy5DanohlD
	 BYdngJE6DZVgS3anPgKD/oTlZk2DsU+RtlWfb4+riMQmhC4Ns3+K0ioKAmIKJXtRNb
	 L16F4/Qf8y7dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] bpf: Reject exclusive maps for
 bpf_map_elem iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602133052.423725-2-daniel@iogearbox.net>
References: <20260602133052.423725-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 13:49:47 +0000
Message-Id: <20260602134948.3F8EA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Generic BPF map iterators bypass BPF_F_RDONLY_PROG and map->fr=
ozen protections.
- [High] Incomplete fix for exclusive map security bypass via dynamic attac=
h points
--

commit 9a17d32567844f5c82567e8f969e7dc780b8275c
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Reject exclusive maps for bpf_map_elem iterators

Exclusive maps are meant to be reachable only from the single program whose
hash matches. This patch adds a check in bpf_iter_attach_map() to reject
exclusive maps when binding to a bpf_map_elem iterator.

> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index 261a03ea73d34..ae0741a09c6de 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -112,6 +112,10 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  	map =3D bpf_map_get_with_uref(linfo->map.map_fd);
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
> +	if (map->excl_prog_sha) {
> +		err =3D -EPERM;
> +		goto put_map;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while enforcing the
excl_prog_sha restriction here, are there other dynamic attach points that
still miss this check?

For example, looking at bpf_iter_attach_map() in net/core/bpf_sk_storage.c,
it binds a map to an sk_storage iterator without checking map->excl_prog_sh=
a:

net/core/bpf_sk_storage.c:bpf_iter_attach_map() {
    ...
	map =3D bpf_map_get_with_uref(linfo->map.map_fd);
	if (IS_ERR(map))
		return PTR_ERR(map);
    ...
}

Similarly, sock_map_iter_attach_target(), sock_map_link_create(), and
sock_map_get_from_fd() in net/core/sock_map.c dynamically attach BPF progra=
ms
or iterators to sockmaps but do not appear to check map->excl_prog_sha.

Could these missing checks allow the attachment of an untrusted program or
iterator to an exclusive sk_storage or sockmap, bypassing the exclusivity
constraint?

[Severity: Critical]
This is also a pre-existing issue, but does this function properly enforce
read-only constraints on maps?

Later in this same function, the code checks if the iterator program's
max_rdwr_access exceeds the map's value_size:

kernel/bpf/map_iter.c:bpf_iter_attach_map() {
    ...
	key_acc_size =3D prog->aux->max_rdonly_access;
	value_acc_size =3D prog->aux->max_rdwr_access;
    ...
	if (key_acc_size > key_size || value_acc_size > value_size) {
		err =3D -EACCES;
		goto put_map;
	}
    ...
}

However, it does not appear to check if the target map has the
BPF_F_RDONLY_PROG flag or if map->frozen is set.

Since the BPF verifier defines the bpf_map_elem iterator program argument
ctx->value as PTR_TO_BUF (without MEM_RDONLY), it allows the iterator progr=
am
to write to the map element.

If an iterator is attached to a read-only or frozen map (like a .rodata arr=
ay
map), can it bypass these protections and modify the contents dynamically?
Because the verifier assumes these maps are immutable and optimizes bounds
checks based on their contents, could this lead to out-of-bounds memory
accesses in previously verified BPF programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602133052.4237=
25-1-daniel@iogearbox.net?part=3D1
