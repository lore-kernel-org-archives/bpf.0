Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032890;
	b=YmG0FhqTemHzPOSITikmwasDCvKDUPNO58KvC5zCrBIt8yKM/7y/QSmzcVQhjcBFrs4Q
	 3Xgb0Dc7zsda92CJXdxphgOsDRHnL+VWhETW+raXaTr8PomQIBoN9lBB8UIJIu9odhtw2
	 yV2GGUtBwYWy7kK9cNuXCNZuFlcfh+fDoVI7sk73eioZ1h/kG/pO4tKN63haM7nprV53u
	 t/EYc/6+9j0dqsnRV/2UMhFRSI2RY9um5HxUaDwqBzy5Q174rvP1wtlna620b597Nn6DC
	 kxTrcX2ZMyG1j9ysI91dScOg24PNA08sq4HKrw0mmS0y6z0H3u3p9lHzKym/ix1h1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Wobu/QRwQ+jJzshZIr4bBY7OwAD6q6nxKF5CYr+4D8=;
	b=w2CYH7B4ZyK0kwx5ByenSIgEXZMoI+FshJQy28z25iZKNcIibC7P8Kg2AmfyB5F3P46T
	 YxYfaveddxcWi5yrE13XhJpkjM28fwnNw3BaktCrVxetMBkzSfNcUyk75lvA+ZV9oTqtV
	 fupVRZnGIFSVeH7PGOV3Ix4qI4r3+lH+Qs/5bGE1/wde/QtxD9IFhAeH4RNuQCc2kufr2
	 9DStbLKxgd3Oql7LzUXA9sbXMgPBNBRDIzGSUnWnv1FSDhJ0Lm8cnj0+Gc0fMq7QiiR2A
	 lHSd1QfYCOzgVmx1ftdbkm0B5ioN7uKc8aLi4NtC8pGZKK2edzCxbxNcGAQd/p3SIbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LWwxF/Dn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71705606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWwxF/Dn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB291F01829;
	Mon, 26 Oct 2026 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032890;
	bh=0Wobu/QRwQ+jJzshZIr4bBY7OwAD6q6nxKF5CYr+4D8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LWwxF/DnCj7dzs9ZpthwKyN6RoM6da2ctlSp8hN80GEJX+SBRx0yXE2ThZTrVtTOO
	 A80M1Fs9kG9rqmks0g9BME4HxYhAuoyb99d/s+wJHRi9MfmtfOE7Udx5hFlZVU+SDl
	 8nc9Vfbw3gYH6sPb9y89UVnsSf8IJJulLGWxT3liOuabX5wrZckdSgS/zidcaGcQir
	 lip9t8PrXNfzzbHFr8Vwv5yq67VYRfkvA760+RE8ne6SqFPVxv/5AK28MFdjAk141e
	 CVBOu9FS3iDTQRqz7DUwxPNvufXhm/Y00ABVgrJ+o9AdL19i8Ai02hp9hz9ImEUNr4
	 J0hgX1bkJ88cA==
Message-ID: <sashiko-outbox-185549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix bpf_dynptr_copy() for overlapping
 ranges in one packet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ayushman Rout" <ayushmanrout27@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261026162810.12862-2-ayushmanrout27@gmail.com>
References: <20261026162810.12862-1-ayushmanrout27@gmail.com>
 <20261026162810.12862-2-ayushmanrout27@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:41:29 +0000
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
- [Low] bpf: non-standard multi-line comment style in bpf_dynptr_copy()
--

commit 4a57e7196e830451e2770433571b9c37faffc18b
Author: Ayushman Rout <ayushmanrout27@gmail.com>

bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet

This commit fixes overlapping copies within the same packet in
bpf_dynptr_copy() by avoiding direct slice buffers when both dynptrs share =
the
same underlying data and copying chunks in reverse when the destination is
above the source.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63ae..b74c03669b5fd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3291,8 +3291,10 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_d=
ynptr *dst_ptr, u64 dst_off,
>  {
>  	const struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr;
>  	const struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr;
> +	bool same =3D src->data =3D=3D dst->data;
>  	void *src_slice, *dst_slice;
>  	char buf[256];
> +	bool rev;
>  	u64 off;
> =20
>  	src_slice =3D bpf_dynptr_slice(src_ptr, src_off, NULL, size);
> @@ -3303,25 +3305,31 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_=
dynptr *dst_ptr, u64 dst_off,
>  		return 0;
>  	}
> =20
> -	if (src_slice)
> +	/* The other range is copied piece by piece. A slice of the same packet
> +	 * may overlap with it, so it cannot be the buffer for that.
> +	 */

[Severity: Low]
This isn't a bug, but in bpf_dynptr_copy() in kernel/bpf/helpers.c, could t=
his
new multi-line comment follow the BPF subsystem comment style with the open=
ing
/* on its own line:

	/*
	 * The other range is copied piece by piece. A slice of the same packet
	 * may overlap with it, so it cannot be the buffer for that.
	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026162810.1286=
2-1-ayushmanrout27@gmail.com?part=3D1
