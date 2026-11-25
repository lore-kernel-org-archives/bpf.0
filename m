Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621257;
	b=vm+cRYOtPSkCoG1gOmSOzmlpvez4uZ8G4lwjLMIvBNFJuzwbgnGeZrYhBfDdHBNbpN7d
	 hUeZx6Nwd/fncvMvjRgv3lzMCkqm9ytryNyqXNS9kjGUJB+ubS0RhzKEeaOBLppUHt8Wl
	 CDLZ+/AkBk3+YWhwJA9SZ9Y7qk5OelnyyBlHW7rjsTjZImI7Ya/wRUXgSmc47myCC6P7x
	 efBiWFRAusumcgezwQfV6ZRKWZj90WsntNOPqM/MU/A1zO88U8XGCi75hQB88/0W+OhLq
	 BOCs5wsVHZl/cBxv2LgCKeArRSrTRP1OHS+Lui8n1NqrLlN8RHvxu4TIUXCIMj/8M/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621257;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0ft09Mw7eCH/uDRGhEOzKpS+G5jEokfqfqNhmiL/Vyc=;
	b=DxF/5Q1s+W4XonGlW5CnJq6m5GTqgTaNd2furKvg5n7upt9t4Va530oqtQg+ZAv34s8c
	 hSImvX/CW6uqltkC5ebmj5XPT33eopZ3dCYi12bnKFVqns0ePTBZGWktI1jmVDczoJLpJ
	 +gEyARHg/jC92aHhK00KdHdiqw07fBkWAlDUJcXyoit1BWxgKXHG/d2yJgArIhm1AhvCZ
	 vk1Y+62h/fH16XKsksNQ7tcIwRQgvnVQDrcphXpueeAIzSpwngG9LFzQAm6kxb6e1/Mn0
	 bi2PJ7N1BuVyfimIDuR3t7dnWEUuLg5qs3VOUoIDKB6/ip3EVMYmIp5qzjn67cSr7Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvBGgfk2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04C60A3826
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvBGgfk2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE01F000D8;
	Wed, 25 Nov 2026 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621256;
	bh=0ft09Mw7eCH/uDRGhEOzKpS+G5jEokfqfqNhmiL/Vyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvBGgfk23IjX2245+ZjXVheAb0DsisoMs9XZXEy+Ypa/tROrAQw3De/Ff5COXZtlp
	 kkQLZJwP8WmTK0V3QNEZW8E1A4UTMRHQ9ZJku4XRygtI8zm9fPilJj5VEMjFFB/QBB
	 Wh88lnCBN4ZwbzfBY8YIHotq/7uDvtUSPqsRe1DoDb2Yj/VU6K9zIt8twE10jGKhUt
	 ak9XhRoUX6HPa0uF5PCT6zJeCy/Z2BQLxyOculdk4REW9h5Tqc7iIMNh7y4+8ka84X
	 ZYq7Pp+71MBhH1ZvS5OXm0jjEHzU1yBOfYnRCMYOkzoTXmcTfnlYiVXqPUXEHXwgQd
	 WWCm8GOpnVSug==
Message-ID: <sashiko-outbox-233665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Explicitly disable token in
 token/obj_priv_freplace_prog_fail test
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-6-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
 <20261125-bpf-relax-get-next-id-v1-6-49175227c8cf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:40:55 +0000
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
- [Medium] selftests/bpf: char literal assigned to pointer in
  userns_obj_priv_freplace_setup()
--

commit 2c21fda1bda78f7e8ad66a69f75df48fbe870eed
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

selftests/bpf: Explicitly disable token in token/obj_priv_freplace_prog_fai=
l test

This commit updates userns_obj_priv_freplace_setup() to take a boolean
flag controlling whether the BPF token is disabled for the freplace
program in the obj_priv_freplace_prog_fail test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
> index f2f5d36ae00a4..dcb5e9f2d61e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/token.c
> +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> @@ -797,7 +797,7 @@ static int userns_obj_priv_prog(int mnt_fd, struct to=
ken_lsm *lsm_skel)
>  }
> =20
>  static int userns_obj_priv_freplace_setup(int mnt_fd, struct priv_frepla=
ce_prog **fr_skel,
> -					  struct priv_prog **skel, int *tgt_fd)
> +					  struct priv_prog **skel, int *tgt_fd, bool fr_token)
>  {
>  	LIBBPF_OPTS(bpf_object_open_opts, opts);
>  	int err;
> @@ -813,6 +813,8 @@ static int userns_obj_priv_freplace_setup(int mnt_fd,=
 struct priv_freplace_prog
>  	if (!ASSERT_OK(err, "priv_prog__load"))
>  		return -EINVAL;
> =20
> +	if (!fr_token)
> +		opts.bpf_token_path =3D '\0';

[Severity: Medium]
Should opts.bpf_token_path be set to "" instead of '\0'?

opts.bpf_token_path is a const char *, so assigning the character constant
'\0' sets the pointer to NULL rather than an empty string.  Building with
Clang fails under -Werror,-Wnon-literal-null-conversion, and at runtime
bpf_object_prepare_token() checks for a non-NULL empty string
(obj->token_path && obj->token_path[0] =3D=3D '\0') to skip token creation,
treating NULL as unspecified and falling back to the default bpffs path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-bpf-relax-=
get-next-id-v1-0-49175227c8cf@toke.dk?part=3D6
