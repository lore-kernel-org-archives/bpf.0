Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EEE4ED1B9
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676624; cv=none; b=bGsBTwJBku2ElWpQK8DMbV80BmFEToOvhLy8PR7F2BePNpC+tMplvNjDsOoxUONmeVe9gonj/g70fxcGHw6PK1XCBmnVXzc5V/JpBWuovEK2AhLiV4cslUTV5cUa47VfK1EOwV9CEng4my9J6jLB8SHqJM5z6IBlQweqN1z7Fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676624; c=relaxed/simple;
	bh=/gdDMTYi5Gnib5UVvtJkCLwXHO1KxLo4YMidYZ70JZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHM0I953wFYhPKcHSFIZ2ctp2IzgbJW3mZ8IPYOpzrSj1osNy4SmAiHU83IyPsHQ/pSa+sYbFHM9ZO7ZoP0oX+7/0r45Igvr+xLMqguxTwxmsaizGR/u6lqqsQS1cWNuiR9MgoY+BfZiHGPAKBFq2q6UBSOLhl+2QyeK+/HYDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqCIXOoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqCIXOoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198FC1F000FF;
	Thu, 17 Sep 2026 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789676615;
	bh=4hlZYZ7eugSEVgQMLc/2fL1SLnEPIYuWR9MKPbKYCcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqCIXOoHBd6/2Inghw0JphAyXRcFotjZLSxSbXXlwRmywcMWkokGx7Fvgc3KvkbTJ
	 5TZGc7SvYbswJPg114+tJHxzyPgRrV4CZXUioEX0ReIJsKPJBdFWxmfwuSItM6EBUx
	 43xJqIenFVHBlYZ9Qbsy1ggV9/0KL9tKi+9+/z40qTcZ9Q2V7v7tc8lj7qcWFvH+tR
	 sQzu2ypRJPXc46gX0arJ41HSzatkECrHVDWXC/fIMXsrrtnDWR9yNkYnTZzYHAG/PE
	 ZkYCRAziy8RyQRT3CZ0f3PiTAlFvZcSsKF6Fyz3R34stFDymM2A68yScr3Wir7DxMD
	 nk4RqYjaWngww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 14/15] selftests/bpf: Test attaching
 struct_ops to a cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917200542.3689605-15-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
 <20260917200542.3689605-15-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:23:34 +0000
Message-Id: <20260917202335.198FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing error check and info_len reset for bpf_map_get_info=
_by_fd()
--

commit 2cf8a5f36e0f4cc232574cbef36b043f1e914740
Author: Martin KaFai Lau <martin.lau@kernel.org>

selftests/bpf: Test attaching struct_ops to a cgroup

This commit exercises attaching the bpf_tcp_ops struct_ops to cgroups via t=
he
generic cgroup link infrastructure. It adds multiple subtests to validate
execution order, query behavior, updates, and hierarchy inheritance.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
> new file mode 100644
> index 0000000000000..6435ed1c2cf6d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c

[ ... ]

> +static void test_query(int cgroup_fd, struct bpf_tcp_ops *skel)
> +{
> +	LIBBPF_OPTS(bpf_prog_query_opts, query_opts);
> +	struct bpf_map_info info =3D {};
> +	__u32 info_len =3D sizeof(info);
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

[Severity: Medium]
Could the second call to bpf_map_get_info_by_fd() fail to retrieve the full
information?

The first call modifies info_len to reflect the actual size of the returned
structure. If that returned size is smaller than sizeof(info), the second
call will reuse this reduced info_len, potentially missing fields like 'id'.
Should info_len be reset to sizeof(info) before the second call?

Also, does this code need to verify the return values of these calls using
ASSERT_OK() to ensure map1_id and map2_id are populated with valid data?

> +	map2_id =3D info.id;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917200542.3689=
605-1-ameryhung@gmail.com?part=3D14
