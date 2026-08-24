Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C653016F5
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571737; cv=none; b=HaI1DDVc5pAQbEgEltTV7Bu+Jm7m/GYDL9geoAPYb8qEC4731Pj9ufenz5Lt50IzLwXjPwzdqodHOOeeiIibtq+qWKaYYgR8p4ZRsPzwE+f5Nq7XYjMMHg+ximZQMKJZDfvzH1mO1Q2IVpRRcZqCgvu7E3UtX78C5J+T05mRHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571737; c=relaxed/simple;
	bh=l9q3A4rkMkDtXoCxpjpLBFQtyN/iLW3aipCe1pFKUwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KBXHqptlewo5eKQhOGytEATXSZ5auLCZzIDcTgeFiDsxDORhO5O/ahBadVUxWvu9sYmU6VfP7RziIexgOi2I1sdG7RoUnKAHNlp6gg05ieyxjwPdS0Lqu3mjPP/pb3LAOaqEgxyR5NBftKFx4BK/vT9DegXzi+o3h4hg8bmPqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsoAUWS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsoAUWS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFFE1F000E9;
	Mon, 24 Aug 2026 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787571736;
	bh=YS/k+UZ+nJ3AG2dGSogqMfnta3PQnkiH+4ODvSvShzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsoAUWS3XuGo1ORNtsbJ7SjVefRfma10TjofIq3lLbouS3dkekb1AybnbZyuUUQM0
	 lZTX80KuHbhRbeoVQaLZBWPSygCGt6qg7w9umf+M0cuKq8OiEBv+N9AVPFQHRPjc/M
	 1WojYqj47cXZmjuoTF2pOZEoZ7jmBlu61af+C9MuQjYEN1UaEotwK/l1JPacjfV6M/
	 9wPRMyUsnU8K7eeGuYigp+CQ/rHfRNM25LahJ2Uz0JAMkgc/wUByzsCqZgBwlT7k8F
	 W/rsLmFRyuYZ/KPHNQAcQGX9xet2NdH7AkGiVjbcI2SOfRwm1nPRKBiwGVK9ygNpKI
	 xN77AVwrRPqNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix u32 overflow issue in map batch operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Masoud Aghasi" <maghasi@disroot.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824113123.270057-1-maghasi@disroot.org>
References: <20260824113123.270057-1-maghasi@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:42:16 +0000
Message-Id: <20260824114216.6CFFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `size_t` cast in `key_size * bucket_cnt` and `value_size *=
 bucket_cnt` length calculations leads to 32-bit integer overflow and silen=
t data truncation in `__htab_map_lookup_and_delete_batch`.
--

--- Patch [1]: [PATCH] bpf: Fix u32 overflow issue in map batch operations =
---
commit c9edb3a32ad168bfaf9df954c22a4563c73796f6
Author: Masoud Aghasi <maghasi@disroot.org>

bpf: Fix u32 overflow issue in map batch operations

This patch addresses a u32 overflow issue in map batch operations where
address calculations exceeding 4GB could lead to data corruption. It
resolves this by casting the counter variables to size_t before
multiplying them by the map's key or value size.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d8db1cebc1936..334eeb297892e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1978,9 +1978,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *=
map,
> =20
>  	rcu_read_unlock();
>  	bpf_enable_instrumentation();
> -	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
> +	if (bucket_cnt && (copy_to_user(ukeys + (size_t)total * key_size, keys,
>  	    key_size * bucket_cnt) ||
> -	    copy_to_user(uvalues + total * value_size, values,
> +	    copy_to_user(uvalues + (size_t)total * value_size, values,

[Severity: High]
This is a pre-existing issue, but does key_size * bucket_cnt or
value_size * bucket_cnt also need a size_t cast here?

If value_size * bucket_cnt exceeds 4GB, the 32-bit integer overflow would
truncate the length argument to copy_to_user() in
__htab_map_lookup_and_delete_batch(), causing it to copy less data than
expected. This could result in silent data loss since the elements are
permanently deleted from the kernel map, while the syscall falsely returns
success.

>  	    value_size * bucket_cnt))) {
>  		ret =3D -EFAULT;
>  		goto after_loop;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824113123.2700=
57-1-maghasi@disroot.org?part=3D1
