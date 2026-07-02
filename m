Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF98309F1D
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003682; cv=none; b=gBBuB6B5BQJGeRSJJRmyzluFq6fOj4LMxN0gj60ujE+jHplb7uoxrPIRg7iovL1vtP1vGpSd4Z/uNOqPHu/PbJOzTHKt6Y6o39nZg2pK/PNqibrJQjGCrAE5zfru5oewcQTufOcNOUR1nAG6rXdSqisrp6C7L45mzFn7LB6Yuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003682; c=relaxed/simple;
	bh=NM3GUIzn0/isOrlbN9INnIfcqJe5E9XQG4/wAVLtomU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0AX06qRfBzVep68iXIXqBqccJtLQQVxPOe878GifDuXc3TOxIad/dw3APsUDcYqQc+YqMgpRCtcVHXkBicWDxfIBzki37B52n76RGXX6xnU7Z8UnTKDiv/iqma4DrSA3BzkOiDpMUZjUP0iGbv7YIp7smMz0i2bvgo1cSe5fSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brji+86A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brji+86A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96AC1F00A3D;
	Thu,  2 Jul 2026 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003681;
	bh=eXyuqz7zJSaGQvLgyOWPsDY646xuLAFEmJ7wrY8ANcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brji+86A/jEyQYHCTV5CRjsmeZN5r4i+UmVAduoX7gTt+NK7pQPCOkLgQ0W28UrZ+
	 UZpNcV8mKA9fzgtM6E9WPlgngaB4J1ZXUCP0wlKdsp8OHKajMD67KGThCgoAtdxfrP
	 a7r6uVIb1ENcsH6GYwWc0FpkG1RFRM5v42ZGBih53aE6rr7nvCR3mylsY0lw0dDSzU
	 Nn1+5fVrBOCBdqck5oxjCcpt0BcVRSdYAfJaPlm5qKN80hFTIBBp2fvZwZM+ScjD66
	 Y6UHlHCSq6G4LSIok79JoU+TAOYmE+ItVcdemnkb26aFXETg07FcYqWmsH1OlUr+21
	 9T6rBTKbxvWSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/6] bpftool: Cover loader metadata with the
 program signature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702143605.252797-5-daniel@iogearbox.net>
References: <20260702143605.252797-1-daniel@iogearbox.net>
 <20260702143605.252797-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 14:48:00 +0000
Message-Id: <20260702144800.E96AC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The return value of EVP_Digest() is ignored, meaning that if the=
 digest computation fails, uninitialized stack memory is embedded as the ex=
cl_prog_hash in the generated C skeleton.
--

commit e281b7d5ac70a49b622a3d4044b8e6f8e9dd90d4
Author: Daniel Borkmann <daniel@iogearbox.net>

bpftool: Cover loader metadata with the program signature

This commit updates bpftool's program signing logic to include loader
metadata alongside instructions. The signed artifact now embeds both in
the generated skeleton, allowing offline signature validation.

Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00=
.camel@HansenPartnership.com [0]

> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> index f9b742f4bb104..7cc991c69dc2c 100644
> --- a/tools/bpf/bpftool/sign.c
> +++ b/tools/bpf/bpftool/sign.c
[ ... ]
> @@ -178,7 +190,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *o=
pts)
>  	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
>  		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);

[Severity: Medium]
This is a pre-existing issue, but should we check the return value of
EVP_Digest() here?

If EVP_Digest() fails (for example, due to an OpenSSL internal error or
memory allocation failure), it returns 0 and leaves the hash uncomputed.

When called from gen_trace() in tools/bpf/bpftool/gen.c, this would result
in an uninitialized stack buffer (prog_sha) being written to the generated
C skeleton file as excl_prog_hash. This could leak build-time tool stack
memory into the generated code and cause the program signature validation
to fail when loaded.

> =20
> -		bd_out =3D BIO_new(BIO_s_mem());
> +	bd_out =3D BIO_new(BIO_s_mem());
>  	if (!bd_out) {
>  		err =3D -ENOMEM;
>  		goto cleanup;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702143605.2527=
97-1-daniel@iogearbox.net?part=3D4
