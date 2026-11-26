Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716179;
	b=pcK43UW6zjBtT8cgqJnBKgTIGNn0m8bBMZdx1QfauAKRJ5sG1lLXJRpCkeac2l/DUNQS
	 eYvC3NmTdbnh3mfIOwy1X5bYPBfJQ4VzLzAORylYfl82iT+RVQAsK3ASNowzz/Y9D8t4s
	 ITU16LfPnjFrZA407fPqw9zjik6YPoDd2ljv5u1ApthtzK/46ZsGtBMBDf8HtEd+U/fVQ
	 aX41DXcz2rS+q6xApzZPYFW5UudBlPSe2Gn12WakvDMSHbkkHK4UC6z+bwp9LVA6cEYu4
	 2Lz3aiblT3hJCPbKu8VzpTPCvp/e7mZwhvzqcKyjlfGc3e4s8/gTjqwLSlfOhJlUF9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3R6S35HfxmEtmBWf4L9xz7ZEb0CLISkLf0fqyEA2tmU=;
	b=NfbJzhT0q0EIp1QAWjw3XQWmTb6jqeKlXN+2P9yufVWVi/IuMAxxEBql0ubybTX6b/SM
	 fmjsmIAIuAzVp5N7wi4o1OXk794LSgMCqja2HYMw6IdrA2zMrbxHNKAIaV/j1Diazhuyo
	 p+5oY5fBgg+tS9n3jP5xkpFjLpPvkjFEsbHyxZnbhVr88gVcsw+ZJzDPL/lVR8OEQtkcX
	 UwP+g9wOGOfGwpxVbAEtxtvRhV8Lff+fdvksZzKfVN2ZJNx++RcljWYd4pdpL5RXjtG+y
	 ty2oiDVQI/2n6FtmAyOWSoYW8fjXAOj8Wk84Ov/0mxFyag/HllXm5IWawUotjjuLm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj4bHqir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FA606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj4bHqir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A9D1F000C6;
	Thu, 26 Nov 2026 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716178;
	bh=3R6S35HfxmEtmBWf4L9xz7ZEb0CLISkLf0fqyEA2tmU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Zj4bHqirN1CDn6geqQCur1FDlZ7U0T+VsME6oI2zdUYbpt+b5i1PsQ7EfHTvJD38G
	 sYorTSaPwgd3n80GdkXf/L7iNHh6bqtyIkfyRrpjXwYfSQuUm84clCuaCmO93JwGWO
	 JtX4xvmyv0PaPq6YRZa6P3Y5JgpsBRrFqQF2QcMOy7fNL0LMB0efak3KvJxx8rU3Ww
	 GBjWCKNk8AGJ2rjCwyMPmTq8R4HfB4BQrFBdLLVAQijZRhJxS0dah0vxiQz++hoDjK
	 JRMRwy2dVSi00xtDrG8ibb61DYZfErQGw5vxFWf5smvIXB/S4k8ovtKoS3af7I23Kl
	 TD3ljUd47jPkw==
Message-ID: <sashiko-outbox-235988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test enum value relocations
 out of the local enumerator range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261126175618.1884490-1-yonghong.song@linux.dev>
References: <20261126175602.1882988-1-yonghong.song@linux.dev>
 <20261126175618.1884490-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 18:02:58 +0000
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
- [Low] selftests/bpf: non-standard multi-line comments in
  core_reloc_types.h
--

commit b84e0514078e764d621bc1f043d99af2bc50dbfb
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Test enum value relocations out of the local enumerator range

This commit adds CO-RE relocation selftests verifying that libbpf poisons
enum and enum64 value relocations whose target values fall outside the
range of the local enumerator type.

> diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
> index 116a67fdd1b2e..01d67521efd12 100644
> --- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
> +++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
> @@ -1409,6 +1409,62 @@ struct core_reloc_enumval___byte_unpacked {
>  	enum named_byte_enum___byte_unpacked f3;
>  };
> =20
> +/* second enum value out of the range of the local int enumerator, as the
> + * target enum is 8 bytes, should fail
> + */
> +enum named_enum___err_too_big {
> +	NAMED_ENUM_VAL1___err_too_big =3D 1,
> +	NAMED_ENUM_VAL2___err_too_big =3D 0x200000000ULL,
> +	NAMED_ENUM_VAL3___err_too_big =3D 3,
> +};
> +
> +struct core_reloc_enumval___err_too_big {
> +	enum named_enum___err_too_big f1;
> +	anon_enum f2;
> +};
> +
> +/* second enum value out of the range of the local int enumerator, as the
> + * target enum is signed and 8 bytes, should fail
> + */
> +enum named_enum___err_too_small {
> +	NAMED_ENUM_VAL1___err_too_small =3D 1,
> +	NAMED_ENUM_VAL2___err_too_small =3D -0x100000000LL,
> +	NAMED_ENUM_VAL3___err_too_small =3D 3,
> +};
> +
> +struct core_reloc_enumval___err_too_small {
> +	enum named_enum___err_too_small f1;
> +	anon_enum f2;
> +};
> +
> +/* second enum value out of the range of the local int enumerator, as the
> + * target enum is unsigned, should fail
> + */
> +enum named_enum___err_int {
> +	NAMED_ENUM_VAL1___err_int =3D 1,
> +	NAMED_ENUM_VAL2___err_int =3D 0x80000000,
> +	NAMED_ENUM_VAL3___err_int =3D 3,
> +};
> +
> +struct core_reloc_enumval___err_int {
> +	enum named_enum___err_int f1;
> +	anon_enum f2;
> +};
> +
> +/* first unsigned enum value out of the range of the local unsigned int
> + * enumerator, as the target enum is 8 bytes, should fail
> + */
> +enum named_uint_enum___err_uint {
> +	UINT_ENUM_VAL1___err_uint =3D 0x100000000ULL,
> +	UINT_ENUM_VAL2___err_uint =3D 0xffffffff,
> +};
> +
> +struct core_reloc_enumval___err_uint {
> +	enum named_enum f1;
> +	anon_enum f2;
> +	enum named_uint_enum___err_uint f3;
> +};
> +
>  enum named_unsigned_enum64___err_missing {
>  	UNSIGNED_ENUM64_VAL1___err_missing =3D 0x1ffffffffULL,
>  	UNSIGNED_ENUM64_VAL3___err_missing =3D 0x3ffffffffULL,
> @@ -1423,3 +1479,17 @@ struct core_reloc_enum64val___err_missing {
>  	enum named_unsigned_enum64___err_missing f1;
>  	enum named_signed_enum64___err_missing f2;
>  };
> +
> +/* first signed enum value out of the range of the local long enumerator=
, as
> + * the target enum is unsigned, should fail
> + */

[Severity: Low]
This isn't a bug, but the five new multi-line comments in
core_reloc_types.h place text on the same line as the opening /*.  Per
BPF coding style, the opening /* of a multi-line comment should be on its
own line with the comment text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126175602.1882=
988-1-yonghong.song@linux.dev?part=3D3
