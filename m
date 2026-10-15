Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17A3EFFC4
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108421; cv=none; b=GlX5Kv7i2jrLJsP/Yo7sHg9QKXcPfByY3g4e9QnPDPlG907Q5iRRDk5MjXKUUEMQQOY4iCP11N7W4VZdPCGxVl1FxdiMkRpYcPRz/CEAN7GJhuY5yMCO66FFZ7Str0vEc1OgTUvYJLPnykgDqBOHYnT/5QIfEoOfgzjYUTxXyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108421; c=relaxed/simple;
	bh=sqqsnzB5l5WXRsMc+rv5poVwU1j3XkmlitqGBTANPBM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=WRQ3hqomjTHQrOtnSBaTjOiv/n8hD/7oqTdltd63rZ9DWy+WP9Y9pNscCvvvcLnTbIxXwGG7ObLj6pNdVa+HdCdzUl2V8go2xuq6ewv54ndGrUnFaSyNnYhUdieOXcrwCO62tG8ag9nfiZcxYtltrtHs/xkvoE0JJGJPPwazTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZJdbN2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZJdbN2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EAD1F000C4;
	Thu, 15 Oct 2026 23:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108420;
	bh=ZR6iw0XEO50MQYDRm8jNU7lpOmnImuEJ9mVYMTDeEAk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jZJdbN2zonpGQWOUBc4ZocdTECALTuEjea/ZAuxDycG0KTCKzSGzfqKD0IuNZByT9
	 Ay7sp7T/zRfVUBDlPviEUAg2Cdkq6F2rzE3oNIxIJssD4KNcOla+A9b1nUpopORjsB
	 ITWSmnSeFIs6+4HC8cWwRo+gU6uLC7PxD73BKTOl7vPEtMSOXaem6Fet1zG54oZ8LQ
	 B1mBdnNybH69o76rqL+bOJ9WB72nrT194urwAsLIY7rF6pLErTPfU5pjj+MRhZ/+gF
	 14ilrA9Cg2kt6IhWwCbuNk/7vnxVUiW3/QCthFVo/xk+ZFNjRfsDTKg+bO+daZJT5L
	 FFuWwRZAVldZQ==
Message-ID: <sashiko-outbox-173493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 02/15] selftests/bpf: Bind an exclusive map
 through a continuous fd_array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261015234125.3152346-3-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 23:53:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing NULL check for skeleton pointer in test_m=
ap_excl_fd_array()
--

commit 1bd492fc1fe89d69931d1485e93eef135d1cd6e5
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Bind an exclusive map through a continuous fd_array

Load the exclusive program of map_excl with the map in a continuous
fd_array rather than through its insns alone, which has to work, and
the other program the same way, which has to be refused. The two
programs used to be identical and so shared a digest; give the second
one a value of its own so that the kernel can tell them apart.

> diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/te=
sting/selftests/bpf/prog_tests/map_excl.c
> index 3f4422b9ffa69..3592f3ec49490 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_excl.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
> @@ -161,12 +161,47 @@ static void test_map_excl_create_validation(void)
>  	ASSERT_EQ(fd, -EINVAL, "reject size with NULL hash pointer");
>  }
> =20
> +/*
> + * The exclusive map bound through a continuous fd_array rather than by =
an
> + * insn. The kernel resolves the array before it verifies the program, s=
o it
> + * has to have the digest of the program at hand by then.
> + */
> +static void test_map_excl_fd_array(void)
> +{
> +	struct map_excl *skel =3D map_excl__open();
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +	int err, fd, map_fd;
> +
> +	err =3D bpf_map__set_exclusive_program(skel->maps.excl_map, skel->progs=
.should_have_access);

[Severity: Medium]
Does this code need to check if skel is NULL before dereferencing it?

If map_excl__open() fails to open the BPF object (for instance, due to
ENOMEM or a missing object file), it returns a NULL pointer. By passing
skel->maps.excl_map and skel->progs.should_have_access directly to
bpf_map__set_exclusive_program(), this will cause a segmentation fault in
the test runner instead of gracefully reporting a test failure.

Should there be an ASSERT_OK_PTR(skel, "open") check here before proceeding?

> +	if (!ASSERT_OK(err, "bpf_map__set_exclusive_program"))
> +		goto out;
> +
> +	bpf_program__set_autoload(skel->progs.should_have_access, true);
> +	bpf_program__set_autoload(skel->progs.should_not_have_access, true);
> +	err =3D bpf_object__prepare(skel->obj);
> +	if (!ASSERT_OK(err, "map_excl prepare"))
> +		goto out;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015234125.3152=
346-1-memxor@gmail.com?part=3D2
