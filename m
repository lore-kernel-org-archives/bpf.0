Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3D43CEC1
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994764; cv=none; b=mK59BOCAC/in73oJiHXBSXFDQyx2yBNKjz3r1XfJviiZwUTJOaJTJDqWwVtc5Cx4WO09pv2eAeK6qHWcr9REJTBVvvLeVfTWkneK8/bcDTBG/YozBNJzXgx0tJzFvPGt4SJISvEBQc9DPO2Xv5HecViVzhpwqnmmqGeHpiesnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994764; c=relaxed/simple;
	bh=A4xY4fQXmhvbSU/YZsgkufGkkxeQHvo87qRaV1o9jv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYu45/GQczfJLQsX0EnzOKKWpZ6p/waoe5oowu8jDyqK5709XA1OcDDTYAmt7GskhziEaLKfY7VrfkM53wYFAC0j3Z4TN6Vy4W40MCXDzQT1aDE/64eyjUEfwi2OuKOCu7eDhCp8eKrMcoHPSLF5IP9cJ9wMacwDt9Naw9bv2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bovJ+3Yz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bovJ+3Yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820C51F00A3A;
	Mon, 17 Aug 2026 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786994762;
	bh=Y0W3zSOss3QRVb4wbnG85oNiaIMaiJPXb2i4iBx5pj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bovJ+3YzAuZ/s2V8hQdyoa8JEE9EIeLvhy9OWbatYuvpcHG5x5bEQcbA0AwEN521Z
	 868dulHaakVIBfxPtuh88mpKtzBmV6zJXa1c58DnYMHeCcbcd/HeGgDHsHwI9FGCKc
	 M857fxv8XPncAZZdhmg2QKD+9b50h5aP5f2YLJpwzXGPA2u/uHLoFwUU5GNn/bucjL
	 NbNpvOFSe7nVcVduNtAtXDjTMe9xipgo3b8DU37ApGUcsbRmw4kuV7CFNu+VXz6R46
	 +cVunCfiVxogT4TAGD835ceij7poIHEsnNkhoaO9FnLuWjg755e7YjIwwnYWNYH1KJ
	 v/YnfqnD/jH3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] selftests/bpf: libarena: Inline nonatomic bitmap
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817191616.11071-3-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
 <20260817191616.11071-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:26:02 +0000
Message-Id: <20260817192602.820C51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message explicitly states that writes are marked with=
 WRITE_ONCE(), but the implementation uses raw volatile pointer casts inste=
ad.
--

--- Patch [2]: [PATCH 2/6] selftests/bpf: libarena: Inline nonatomic bitmap=
 operations ---
commit 04b634add8119906bf065c817d1ba95b1411fb60
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Inline nonatomic bitmap operations

This commit moves the non-atomic bitmap operations to be static inline
functions in the header to reduce function call overhead. It also updates
these operations to supposedly use READ_ONCE() and WRITE_ONCE() to prevent
compiler optimizations.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> index 8c5936ae9958c..163e2b83d9431 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h

[ ... ]

> @@ -33,3 +32,27 @@ void bmp_copy(size_t bits, struct arena_bitmap __arena=
 *dst, struct arena_bitmap
>  bool bmp_intersects(size_t bits, struct arena_bitmap __arena *arg1, stru=
ct arena_bitmap __arena *arg2);
>  bool bmp_subset(size_t bits, struct arena_bitmap __arena *big, struct ar=
ena_bitmap __arena *small);
>  void bmp_print(size_t bits, struct arena_bitmap __arena *bmp);
> +
> +static __always_inline
> +void __bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp)
> +{
> +	volatile u64 __arena *word =3D &bmp->bits[BIT_WORD(bit)];
> +
> +	*word |=3D BIT_MASK(bit);
> +}

[Severity: Medium]
The commit message explicitly states that writes are marked with WRITE_ONCE=
(),
but this function uses a raw volatile pointer cast instead. Should this be
updated to use WRITE_ONCE() to match the commit description?

> +
> +static __always_inline
> +void __bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
> +{
> +	volatile u64 __arena *word =3D &bmp->bits[BIT_WORD(bit)];
> +
> +	*word &=3D ~BIT_MASK(bit);
> +}

[Severity: Medium]
Similarly here, a raw volatile pointer cast is used rather than WRITE_ONCE(=
).
Does this code intend to use explicit WRITE_ONCE() as promised in the commit
message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817191616.1107=
1-1-emil@etsalapatis.com?part=3D2
