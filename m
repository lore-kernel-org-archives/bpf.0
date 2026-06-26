Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A443BF685
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506604; cv=none; b=iQcLpeasT9VnZ8bsOipV/mluYdrssz7mwW90OPPFRCeebhm+Pd0pWED87MMOqwMU/Zvqfw40l7noCz6/ZuW6bxKcLAptj3wNHS4D8GCeiCckhgOQYT5QywHW3P3HnZC0wkB7BFZxhJKgY3pI0Naq02OgUiFLawmuTkSTZewTqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506604; c=relaxed/simple;
	bh=tigpXZfGjNBNic4A2hZmMBTT5YfaRkx+CeVsZwo6maQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqNupht4f52xn/GUxhoIdwn64z4OZeZXHacWHvgWq6WuU0So4ZmxKCvHTwk8jUC7uRWfbKvKpqSUAysVmarzcHxwocXbEyg1FpnskJmkIlDsjkXowfo8Q/nXvUvszsvpbXkPiggUspGEEXIc4UxFt71/Tnt2yqK5YFhCu6xFVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeU1hglV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeU1hglV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D91F000E9;
	Fri, 26 Jun 2026 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782506603;
	bh=ynmBBv5slwevLBQyxIYYJt3Q36f9mL2LU0Ypov56/Gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DeU1hglVYMcCYzGqnn1a5jdVvFFde3IL19neep9xpiYTFf1ZPeH0DQRO4u3OasSGt
	 rAtQ5PBafWS0sgUDTjiFWhFVLgrfHoYqOmc365o2xSwYgo7LOLVsDoZUw07z1hv8eY
	 /l11eNOFCTX5W5oFDswoDMz17kFHKkHZjHLASKGevwMD/ic/YkIBJL73z+XNTkUfGo
	 Xm6xYtgxqgp2zwxchXZXSUz/H/ZgyNlcUVoFltRb/DLx5w8L+lfbB3Wt6Ddz3P66Ll
	 fmkSOUI2C7fpoZtedbKjemlWL/D4lCCQfAPpCq6ktyrN7oaiSMMhHck/DBtrhRYCSF
	 eoYmsgMpCqWYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/4] selftests/bpf: Adapt sockmap update error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 20:43:22 +0000
Message-Id: <20260626204322.E76D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Usage of legacy FAIL_ERRNO / CHECK_FAIL macros in updated tests ins=
tead of modern ASSERT_* macros.
--

commit bc0e5d743f397cf1347e049495ba4a7950323606
Author: Michal Luczaj <mhal@rbox.co>

selftests/bpf: Adapt sockmap update error handling

This patch updates sockmap_listen to accommodate recent changes in sockmap
that reject unbound UDP sockets.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index cc0c68bab9079..6ee1bc6b3b235 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_lis=
ten *skel __always_unused,
>  	errno =3D 0;
>  	value =3D s;
>  	err =3D bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
> -	if (sotype =3D=3D SOCK_STREAM) {
> -		if (!err || errno !=3D EOPNOTSUPP)
> -			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
> -	} else if (err)
> -		FAIL_ERRNO("map_update: expected success");
> +	if (!err || errno !=3D EOPNOTSUPP)
> +		FAIL_ERRNO("map_update: expected EOPNOTSUPP");

[Severity: Low]
This is a pre-existing issue, but since this block in test_insert_opened() =
is
being updated, should these deprecated FAIL_ERRNO() macros be migrated to t=
he
modern ASSERT_*() macros? The BPF selftests subsystem guidelines prefer usi=
ng
ASSERT_* macros when updating existing tests.

[ ... ]

> @@ -93,8 +90,12 @@ static void test_insert_bound(struct test_sockmap_list=
en *skel __always_unused,
>  	errno =3D 0;
>  	value =3D s;
>  	err =3D bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
> -	if (!err || errno !=3D EOPNOTSUPP)
> -		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
> +	if (sotype =3D=3D SOCK_STREAM) {
> +		if (!err || errno !=3D EOPNOTSUPP)
> +			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
> +	} else if (err) {
> +		FAIL_ERRNO("map_update: expected success");
> +	}

[Severity: Low]
This isn't a bug introduced by this patch, but would it make sense to repla=
ce
these FAIL_ERRNO() checks in test_insert_bound() with ASSERT_ERR() or simil=
ar
modern macros while refactoring this logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-sockmap-lo=
okup-udp-leak-v2-0-7e7e201c951a@rbox.co?part=3D3
