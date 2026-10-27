Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119942;
	b=4zQNi11dWcKpK06zUEkCcUZ61QHxjrM7aBVRTF8Sd5j+2cLqiBgszLmWQjd4lIP/MvSI
	 aYjbinSOaZz48MgdKGoJ5KiAk6MRfXWt3/GKD40j8qUCuyBp4HlSlFqj4kPvXVM2RyUpA
	 IW2ncqL1g69Ke1SK8jPMeZZgymjPIdbhsBPQFF9AVKvRexXSL9fUMvIVV8mQC1O93fdbl
	 YgjPqaFKOVYW449NZRSq/+Wgb6O1OYuKMzfcPyYPYywL4jzBR4HKICoZJToS88Y3fchOP
	 cQSrHlgFgfUEYk1a2ISnyFhnB3ZuigY5HVH/S3q2dTVT9BG5MLZmTjO4F9ch9HOg74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AzJ+QxIUhFspmJ0udr58y2bzmAvd0L3tY0wvim749+A=;
	b=UgJdrAkHZuSNzAy6Azb+LXKjitltItqFbI8oQ4SAHn9tgkDDUbzyaQulZAEtqn8ry5t0
	 RZFBQbpo7A8ziG1nHzeNgPtmpxoyZmbdVbvJ+xHCGQnm5Jknw9ZuRwV2G3qkZ+Ua20JeC
	 3ZQP/U3rxnxseNtXZjhlXMMcwWckx9NsdHmtHRVyTvBuMCRd0967JZKDHElrzVKg32Edr
	 +nz55Oh/V9W51TprMWcgHxy1/AeXdn+d8NMuWVkLD7fdUz59egJBjOYG2dsABzd0lSN5v
	 Rw8jUrSJgMvE/dPKW6Lfw+UIKVRR0tn6dj037pbsUXy6iM4BuEEGc4aEaQqEkcjT6GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TP++QFMt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77879606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TP++QFMt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33AF1F031E0;
	Tue, 27 Oct 2026 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119942;
	bh=AzJ+QxIUhFspmJ0udr58y2bzmAvd0L3tY0wvim749+A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TP++QFMt0cBP51YVs3f+b0AEgTmKKB9m2fCDjjVox0kBtMjXbFcQKcWLzjRGGqms4
	 EtZ1ypTjebCrm1Ny3XZZB54VMjx/EwxNPgFFPGcudxSxlH1cPa2pl5MxKfvOj38P0V
	 00m6im/H56o6gHhUzYRxtSVdCDEh1kHIQD97hLBDR2O/EnTKXVVGOrmeyWODrgMy4P
	 HdRTHV9dYzNhkU7wg0f8JQ4CsgzJnACkhVZ9GbjEY5YwBQ4SiRjr+R6uPK5848Gii3
	 hvv/y490VxnX/FnxDQRD2vimxkk9yvWw11Dmx9gJe2lngMF3SIodNOqTNHfHaSVjP4
	 MO522xf92HRDg==
Message-ID: <sashiko-outbox-186960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: libarena: add explicit
 buddy_grow() call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261027162916.10996-4-emil@etsalapatis.com>
References: <20261027162916.10996-1-emil@etsalapatis.com>
 <20261027162916.10996-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:52:21 +0000
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
- [Medium] selftests/bpf: buddy_grow() treats byte size parameter as 1 MiB =
chunk count
--

commit 423ea247cbc2154b99ae3fbf8b3a6fc0e7d6e98f
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: add explicit buddy_grow() call

This commit adds buddy_grow() to libarena to allow BPF programs to
explicitly grow the buddy allocator arena instead of relying on implicit
growth during buddy_alloc().

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.=
h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> index 958450fc5f9db..4cad0649dc17a 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> @@ -78,5 +78,6 @@ int buddy_destroy(struct buddy __arena *buddy);
>  int buddy_free(struct buddy __arena *buddy, void __arena *free);
>  void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
>  void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t siz=
e);
> +int buddy_grow(struct buddy __arena *buddy, size_t size);
> =20
>  #endif /* __BPF__  */
> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index ed359d4af1f4b..f06b6bd5c088e 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -812,6 +812,32 @@ void __arena *buddy_alloc_nogrow(struct buddy __aren=
a *buddy, size_t size)
>  	return buddy_alloc_maygrow(buddy, size, false);
>  }
> =20
> +__weak
> +int buddy_grow(struct buddy __arena *buddy, size_t size)
> +{
> +	struct buddy_chunk __arena  *chunk;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i =3D zero; i < size && can_loop; i++) {
> +		chunk =3D buddy_chunk_get(buddy);
> +		if (!chunk)
> +			return -ENOMEM;

[Severity: Medium]
In tools/testing/selftests/bpf/libarena/include/libarena/buddy.h,
buddy_grow() is declared right below buddy_alloc() and
buddy_alloc_nogrow() with the same size_t size parameter, which takes a
size in bytes in those functions.

In tools/testing/selftests/bpf/libarena/src/buddy.bpf.c, buddy_grow() uses
size directly as the loop trip count for buddy_chunk_get(buddy). Each call
to buddy_chunk_get() allocates a 1 MiB chunk (BUDDY_CHUNK_BYTES, or
BUDDY_CHUNK_PAGES =3D 256 pages) out of the 1 GiB reserved virtual address
range (BUDDY_VADDR_SIZE =3D 1024 chunks).

If a caller passes a byte count (consistent with buddy_alloc()) or a page
count to buddy_grow(buddy, size), it will allocate size 1 MiB chunks, and
any size greater than 1024 will exhaust BUDDY_VADDR_SIZE and fail with
-ENOMEM while leaving the 1024 allocated chunks attached to
buddy->first_chunk.

Should buddy_grow() convert a byte size into the number of chunks to
allocate, or should the parameter be renamed (for example, to nr_chunks)
and documented to make the unit explicit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027162916.1099=
6-1-emil@etsalapatis.com?part=3D3
