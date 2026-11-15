Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774197;
	b=pvV0PCtwGF+Sodp55pbCxLd+Q3Tw3GqBR5IKLu3n4lO5VM08HhX1wWfdZV+oKJRVyZY/
	 ROd7il92EnaZMV1MHFZLAHzLIhIH95zjxf9uHpt5+8tcWAd4W43BpsNCqmzlfNPFwFK8t
	 sPNKSwNANmU2Kw8QaVApfGxPoP1HvNyTocRvGZxdTv6dtTZKoq169nOFmfsEYwXyaFiKG
	 S9lWh6CWJBsYMfSl1mARVZvJ7Nger/Pgz5AEYVNmXCxFGjyrfoVkSScu1gtaR47OFi9NE
	 rwa9N1xKypN3JLjpjio3FvdSzrL4575BebTSxTWeP2RnlZC+F3kEPYIviGJlWmVgQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X0QxnSKu9srTBD1v+qCPJE5ZTN+N5zaEGUIuCGP6wjo=;
	b=hd4rNtwghr+cUTziTSV87BZnOvZKu/BXK6o3SdS2RjIRBI8Uy3ReDmKIBxitwhyhxXT5
	 ZktUzEvAlLvFz7f7TGq2uOsRpoZSr09gHgFXWTyX0/ZUDF4/vJBWAHiQbNCr1eenQF0An
	 Enl7Ra+xSH/8Hlg2jDsw3kNJTwYPp0m0y7LxK47/tO2BcdYQwEQQAlCPgdUXiTbU0pdjD
	 eBXJ6xZcWGol4hVlwJ+57uFCfTR7cndR1P/4X1fSrURXbj0fB+EJo8IrkfFhl8vZ3Ise3
	 bBnrw+HLN1YN/oC0eMdtdlf3jCSZyS4bWrCB/yifPhoq3E1Hi6go5tE6dkt3fUSnsXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlbK1UUU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE8606A32C
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlbK1UUU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420B91F000C4;
	Sun, 15 Nov 2026 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774197;
	bh=X0QxnSKu9srTBD1v+qCPJE5ZTN+N5zaEGUIuCGP6wjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlbK1UUUf0TttcrtYxAORV5OtBaRPGK5wKMYF+sxrdiZpc4xaYb79zN6jhdEvQuC9
	 LTgY69oqzSaDLoWiXOLBTy82ecOzpSQeiu7K9gS84jOg/+MwYsZB3oUSkzQcWdIpGa
	 KLJmuh+ylr8J45XkPGPFbrCLCx9tqQwCohnfImt1FzhpvksMVurc7OcGtqrepUqjw0
	 xPtoG5szWSLF3c1RbjsDJvVU1zYRm0LXlABaWwEdwFYcOnWroFo50drrfn9MDQIsvG
	 54OkjNVuR1kmoB/sdvhC/YqjMKhayEb21npsEnrlz9+HU1/NjpYTzyUowXjvzuC+/j
	 jPhsWjmtCD9bw==
Message-ID: <sashiko-outbox-215783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer
 libbpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261115200505.1494710-2-asmadeus@codewreck.org>
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:23:16 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] libbpf: missing Fixes trailer for btf_parse_hdr() endianness
  check
- [Low] libbpf: out-of-bounds access in btf_parse_hdr() when hdr_len >
  sizeof(*hdr)
--

commit c3e5e38661056ceb32071ab50ba595824eefbdbf
Author: Dominique Martinet <asmadeus@codewreck.org>

> libbpf: fix cross-endian build with newer libbpf
>
> commit 087f3964f4b3 ("libbpf: Support layout section handling in BTF")
> added extra data to the BTF header.
>
> This extra data is ignored in the native case, but when building with
> different endianness the bswap code in old libbpf would check for strict
> size equality, leading to build failures such as this when BTF data is
> generated with a newer version of libbpf (through pahole)
>     BTFIDS  vmlinux.unstripped
>   libbpf: Can't load BTF with non-native endianness due to unsupported he=
ader length 32
>   FAILED: load BTF from vmlinux.unstripped: Operation not supported
>   make[2]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error=
 255
>
> Newer libbpf versions also properly ignore trailing data in the bswap
> case, but the patch is too intrusive to backport, just fix the header
> length comparison.
>
> Link: https://github.com/NixOS/nixpkgs/pull/570639
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

[Severity: Low]
Should this include a Fixes tag for the commit that introduced the strict
swapped-endian header size check:

  Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in =
both endianness")

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 231b07203e3d2..8f3f942eda704 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -198,7 +198,7 @@ static int btf_parse_hdr(struct btf *btf)
> =20
>  	if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
>  		btf->swapped_endian =3D true;
> -		if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)) {
> +		if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {
>  			pr_warn("Can't load BTF with non-native endianness due to unsupported=
 header length %u\n",
>  				bswap_32(hdr->hdr_len));
>  			return -ENOTSUP;

[Severity: Low]
Can relaxing this check cause out-of-bounds reads and writes on
btf->raw_data when parsing a malformed cross-endian BTF buffer with
hdr->hdr_len > sizeof(*hdr)?

Previously, requiring hdr->hdr_len =3D=3D sizeof(struct btf_header) together
with btf->raw_size >=3D sizeof(struct btf_header) guaranteed hdr->hdr_len
fit within btf->raw_size.  btf_parse_hdr() still computes meta_left from
sizeof(*hdr) instead of hdr->hdr_len:

tools/lib/bpf/btf.c:btf_parse_hdr() {
	...
	meta_left =3D btf->raw_size - sizeof(*hdr);
	...
}

However, btf__new() offsets the section pointers by btf->hdr->hdr_len:

tools/lib/bpf/btf.c:btf__new() {
	...
	btf->strs_data =3D btf->raw_data + btf->hdr->hdr_len + btf->hdr->str_off;
	btf->types_data =3D btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off;
	...
}

If hdr->hdr_len exceeds sizeof(*hdr) (or exceeds btf->raw_size),
btf->strs_data and btf->types_data can point past btf->raw_data +
btf->raw_size, causing btf_parse_str_sec() to read out of bounds and
btf_parse_type_sec() to byte-swap memory in place past the end of the heap
buffer.  Checking that btf->raw_size >=3D hdr->hdr_len and subtracting
hdr->hdr_len when computing meta_left would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115200505.1494=
710-2-asmadeus@codewreck.org?part=3D1
