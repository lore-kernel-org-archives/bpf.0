Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECC78F2F
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231832; cv=none; b=CYGH//rIXg8ja2/ofY/ICvsSzanPfCaiADiRWx7hw4lYdW2js8yAKWX9myK7zYdDPAALmTZR8DBIQXJFx65nUS1oTYEfeOnFynuVdQO1jP+g3yAfh5T8xxJohsJkn8LegeDIeZPK5zsjq0UmhiMym9qRrfHZcNcE7DTNc0YuBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231832; c=relaxed/simple;
	bh=xKMAuxSnBaiIQnifO4lO5g7yb/HDUh2AjgWXj9gRzQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BazyBjRzoyPBlF5oHkS7XqKO3PSoB8Cse+QQnujt6RoRs3XEt5x2nBa2BHYYVPzaRuvizImL981cj3F8ls0ggDZPfeDOWMPpoJZ2bXwwtYKdw11oiRVu+mGvE+NeWMYdLLJ3VwYJO0KtC6sR4Mp6tVcpeSFc2VemofnMuhRviSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oolkC350; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oolkC350"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF351F000E9;
	Tue, 19 May 2026 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231826;
	bh=L6x84DScyauFoFkyNCgdMiKe99U2Iy86dHCfRK5nK08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oolkC350fOGaBZP/56vo0AVm8Cc74zrPebNhbNIs3Ss+ZS8SfZul09XlVXXsm3r4R
	 G2UBX8MDrCXjAhSK6siHGsPFeE53keUlNqIfukr3ZPBrnX+8g7AOKjAfZjk3SDWg0f
	 dszjIDBEXbTgtZw7eGWlHMuP6Q4HL5SE1QgFVoFACWghXFBBj3+IoCy25/3LmN5D2m
	 G22tMyQAQKWfZxPfLOGL1dS4Zj8oKHbjAEn6czv90HkaaPGSnkNV3g2wiBOLRY/pEc
	 sQteWFZLp3j0ZS7U9xameh/72hgYfJk3DNhlEDzvwz67XP97ABHWa+8qG/hBNpOGi5
	 2mZBliqr3d3eg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 12/12] selftests/bpf: Test attaching
 struct_ops to a cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215841.2984970-13-martin.lau@linux.dev>
References: <20260519215841.2984970-13-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 23:03:46 +0000
Message-Id: <20260519230346.8EF351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The return values of `bpf_map_get_info_by_fd()` are not checked,=
 and the `info` struct and `info_len` parameter are reused across successiv=
e calls without being reset.
--

commit 7b32bddd7d98a92b1f824ecda2b3ef053e323da3
Author: Martin KaFai Lau <martin.lau@kernel.org>
Date:   Tue May 19 21:58:19 2026 +0000

selftests/bpf: Test attaching struct_ops to a cgroup

Basic tests for attaching struct_ops to cgroup.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c

[ ... ]

> +static void test_query(int cgroup_fd, struct bpf_tcp_ops *skel)
> +{
> +	struct bpf_map_info info =3D {};
> +	__u32 info_len =3D sizeof(info);
> +	LIBBPF_OPTS(bpf_prog_query_opts, query_opts);
> +	struct bpf_link *link1 =3D NULL, *link2 =3D NULL;
> +	__u32 map1_id, map2_id, map_ids[2] =3D {};
> +	__s32 type_id;
> +
> +	type_id =3D get_bpf_tcp_ops_type_id();
> +	if (type_id <=3D 0)
> +		return;
> +
> +	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops1), &info, &info_l=
en);
> +	map1_id =3D info.id;
> +
> +	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops2), &info, &info_l=
en);
> +	map2_id =3D info.id;

[Severity: Medium]
Are the return values of bpf_map_get_info_by_fd() intentionally left
unchecked? If the function fails, it might lead to confusing test failures.

Additionally, does reusing the info struct and info_len between the two cal=
ls
without resetting them pose a risk?=20

The kernel updates info_len during the first call, so reusing it could be
problematic if sizes differ. Also, if the second call were to fail, info.id
would retain the value from the first call, causing map2_id to incorrectly
equal map1_id.

Would it be better to wrap these calls in the standard assert macros and re=
set
the variables before the second call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215841.2984=
970-1-martin.lau@linux.dev?part=3D12
