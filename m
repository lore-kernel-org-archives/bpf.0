Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700286;
	b=d+xQEnbyrhRu5+eBG0niyRP0bS3Cv5SYrpohg59IV9FXxNK93kV0+2VmCm6zV8ADdEma
	 vzXsFhldePyJD3FT+dPwMBsgR+jPlqm2H+gKAaZONjp6eoGYNF7FWA3+WcK1dG/UU4k72
	 8Cv4guHPZS2ZTNc/Zp/gQ0okZq0iZg8wtNAOptrEyvITNzScQyUyxL0GFnESW91C+Rg5Q
	 NdWhcAaGierOEdlR9HhcwKjw+TaING12Or+2TepCd3QMBeBbGRfuB9pYE8jvzU5xZQ29i
	 uJA1/0CTHjyB6HYLzFHbdwOmmMxUoDn/o7Z1U35u52Phm5s3eZGMgTxtbHmm8T2/Xig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FkYeuOnW620HblLDYcruWVbvcqhxxou1nKwmKrtsFdc=;
	b=OTgMPc4/Upwi4POrBIG2jvcLuEJXSbGlD9lx9im6ouN294HQiJoe0hdEL6Twh4a3O134
	 jI6EfCq0L17fT+NfVHXaqMjBv+j+iHyb2M31cmVScKpKzSAOyOfE4JhK9glk+/g9dHBoN
	 d/yfG3JZZ2AdBnUanrGnK4WaQfICUwVPFoOkG/AqvhGCCDNflChtsVy63bOrkUPWtWJP3
	 5fq6mZ2uOQLx0m0VoZ8kiHtdZ1x27BbFeHTkW5O0YW+30nmKi1lbor4czj1wvSoU0ZIGo
	 SszxmfYzaovy9X/dQARrDaJIk8/2TbMWSUDdTxHy5rId/0ccqUIp+cnQD7h3UoLo+cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D14A6z72;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED28606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D14A6z72
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069A81F000E6;
	Thu, 26 Nov 2026 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700286;
	bh=FkYeuOnW620HblLDYcruWVbvcqhxxou1nKwmKrtsFdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D14A6z726Wy+F94w8WpoVubq2fnSyWI88oI8ywAAq4+sqqy4blgT/vhUbQeFBzlcT
	 PbHdOrob9p30XaUSQO5ri3zCiA8Ca0PqaWuqV9pABXu837S4caAGyiAZ0xYTQoC5cR
	 LImPmeILYT+UxWv8xncCoFk4bXzVutrz1jYOIcHgqCtl+Ouaxi+htsTBBb05YvgRW4
	 MMT5SAyYJ9/yF9oqgTae8Nwd+CJWxZQGj58RSTqSiKoaI42WDUx3n1r61bJ1TShZDZ
	 lFCzsQ+W/i7ooETHIFLdQDFp/g8h7OItZGYT6S/Jt8qXjcmtwEeWOON7jO7fxsRMgc
	 gYp2s79FEg49Q==
Message-ID: <sashiko-outbox-235632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/7] libbpf: Move bpf_object_prepare_token()
 to object creation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-4-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
 <20261126-bpf-relax-get-next-id-v2-4-039e92757f9c@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:38:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] libbpf: bpf_object_open() runs bpf_object_prepare_token()
  before gen_loader
--

commit c11c45202857082e826eb4bc3551463d49a2d5fa
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

libbpf: Move bpf_object_prepare_token() to object creation

This commit moves bpf_object_prepare_token() from bpf_object_prepare() to
bpf_object_open() so that the BPF token is available before loading the
object, such as during BTF access in bpf_program__set_attach_target().

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 540daf7752b45..6d0e71aff3e14 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9281,6 +9281,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
>  	err =3D err ? : bpf_object__init_maps(obj, opts);
>  	err =3D err ? : bpf_object_init_progs(obj, opts);
>  	err =3D err ? : bpf_object__collect_relos(obj);
> +	err =3D err ? : bpf_object_prepare_token(obj);
>  	if (err)
>  		goto out;
> =20

[Severity: Medium]
Does calling bpf_object_prepare_token() during bpf_object_open() bypass the
obj->gen_loader check added in d92defe04ad5 ("libbpf: Skip BPF token
preparation when generating loader")?

obj->gen_loader is only set when the caller invokes bpf_object__gen_loader()
on the already-opened object, so it is always NULL inside bpf_object_open():

tools/lib/bpf/libbpf.c:bpf_object_prepare_token() {
	...
	if (obj->gen_loader)
		return 0;
	...
}

If the host has a token-delegated bpffs mounted at /sys/fs/bpf (or
LIBBPF_BPF_TOKEN_PATH set), bpf_object_open() populates obj->token_fd and
bpf_object__gen_loader() does not clear it.  Subsequent calls to
bpf_object__create_map() and bpf_object_load_prog() then set BPF_F_TOKEN_FD
in the generated loader program's map_flags and prog_flags without a
runtime token_fd, causing the generated loader to fail at runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-bpf-relax-=
get-next-id-v2-0-039e92757f9c@toke.dk?part=3D4
