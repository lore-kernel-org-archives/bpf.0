Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832001;
	b=kJ6APrgT7gMWJAN4nbNGJWzX3dT6YI+j7imlimx0v46IO1lI2CEUc8nf1Hb07WwE70UW
	 bJXWYSnfxLwtgjbGOPVVYkzxa3PZJxYIZhg/s9HIQIw/BReG7/R5jomdltRUFYkp75khq
	 a0k1YJPexiC4m01fw3TcDUpR0IKyyFYngKaHniBvcMjTwRi+vy+yrV55ruuFZs89f6zbW
	 Ky6ZY9tix8QwM/HKfM4JPW6B6l2mbrU6bhweNx+s1kd7dB/4pGKcPdjOf/zYClbFtsQwS
	 w6hcVGW1AzjPw9LBBNIEu1Fm4282/Xo1PW2T1LXY7FYyXfjO0zT7hiGh9aJ407yY9ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k+87reHipvnWHviybduV9ukgK/qmYE98Nf2tsuR13f8=;
	b=b5pl8nTCSFeCnPqF6sMLiuB47wTSLU+Re2ETc2wrJhX7MLuC881eM+NJmO/Kwj4WXlY5
	 eiGZ4llQ0SUwFx6jKgzMzfMLES/KP9XV89Ml+UKbfNTX3/lAph77kUWyTRB/UjQZqKkz7
	 4FXlZagxjHDhhhePWKchfIZro0IVhJqWRKQdh7UyngJDs0rX0/yO3eEZ3taHHb4ZnjAcf
	 IWzlKTcKU8PG8ywlO9Ve2Jl4CoJXUhqyqsBj88ev1Imn2dCSS7wbJudIgPwkKk5ESMIyU
	 OaQRFGNU+Bx0KowRvKB69UNKINZK1oxfhvXuzTdaJP7l9jPJAQaV5Si0Cu0yjfFZPMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmAoOzxI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7D606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmAoOzxI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15051F000C4;
	Mon, 16 Nov 2026 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832000;
	bh=k+87reHipvnWHviybduV9ukgK/qmYE98Nf2tsuR13f8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmAoOzxIOcBIviW2X3e7yR+rdA9NXomKFdcayRbTzC3yrSjQwiKwkW9epKadS19MB
	 kALPkxJYfXfXMcqzwO3TfubNMI6HJ3oCxl5IpUaw6k1Ywm6NA+68WGtbYR4vVtC4uu
	 eRbpR/3HtZzi4OJamKGK9EXRK+Uzls3lEZTl9+4zFJHTvXH/KsK8zgjYYZ1BOoTIxw
	 xVdVB65elKWguE/qAdTKoQAGYlGgdAmHnsuQEQvdomba66XyiLP6WjmdcoyvMdLkQE
	 PvG+D3zr35d/b0P17hE+FovsLcKumfJaHiQ8RVxma5MatEt9zH0rKQjqtHy7WfLpdQ
	 D5qrhvjuJFVUQ==
Message-ID: <sashiko-outbox-217010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer
 libbpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <avryc0j9LwdUUGl7@codewreck.org>
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
 <7a931778-2a99-4b33-8d1e-97f9b061fb02@kernel.org>
 <avryc0j9LwdUUGl7@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 12:26:40 +0000
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
- [High] libbpf: missing Signed-off-by trailer and raw email reply as
  commit log
- [Low] libbpf: missing Fixes trailer for btf_parse_hdr() endianness
  check
--

commit bf42d3c49f2ac6667938fafec9c2e11053665406
Author: Dominique Martinet <asmadeus@codewreck.org>

> libbpf: fix cross-endian build with newer libbpf
>
> Alan Maguire wrote on Mon, Nov 16, 2026 at 08:51:24AM +0000:
> > >     if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> > >             btf->swapped_endian =3D true;
> > > -           if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)=
) {
> > > +           if (bswap_32(hdr->hdr_len) < sizeof(struct btf_header)) {
> >
> > Thanks for the fix! A small suggestion; what about matching the upstrea=
m test instead; i.e.
> >
> >               if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_heade=
r, str_len)) {
> >
> > That approach is a bit more portable as the str_len field was the last =
field in the
> > original BTF header, and it will work regardless of the size of struct =
btf_header.
>
> Thanks for the look!
>
> I wouldn't expect the struct to change in stable trees and favored a
> minimal patch; my opinion being that if someone does take the time to
> backport layout section handling or another btf_header extension in old
> trees then they can also fix the check properly...
>
> I actually prepared a v2 with this, but then noticed the raw_size check
> also ought to be updated if you want to handle struct btf_header changes:

[Severity: High]
The commit message is an unedited mailing-list reply that ends
mid-sentence rather than a standalone changelog description, and it is
missing a Signed-off-by trailer.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 231b07203e3d2..2dddee4870343 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -191,14 +191,14 @@ static int btf_parse_hdr(struct btf *btf)
>  	struct btf_header *hdr =3D btf->hdr;
>  	__u32 meta_left;
> =20
> -	if (btf->raw_size < sizeof(struct btf_header)) {
> +	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>  		pr_debug("BTF header not found\n");
>  		return -EINVAL;
>  	}
> =20
>  	if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
>  		btf->swapped_endian =3D true;
> -		if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)) {
> +		if (bswap_32(hdr->hdr_len) < offsetofend(struct btf_header, str_len)) {

[Severity: Low]
This fixes the strict cross-endian header length check in btf_parse_hdr().
Should the commit message include:

  Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in =
both endianness")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/avryc0j9LwdUUGl7@co=
dewreck.org?part=3D1
