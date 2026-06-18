Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310733DEC2
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821592; cv=none; b=mapPGVzFXk/McNw9R6QhOYsrcBECIRtQ9PEjlzoPNW72qK7iSDOAq+k6gb8JnBXdfKOUSvY+v5InZbNuaHiyWk6JYS3GWKWOxf+wisxRd326hjHGpocA4oUpLpl8Lz0A9qj42B9Zckzu0u8qX+TOkoJ09FuWSclrcIuvhWDJ70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821592; c=relaxed/simple;
	bh=vq5VOcKHcJVbRzZGmdP812Rqm88vbo3+Y+WoSirSiPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mk7nHB5EW7HuM1CjzydKNZq0qd26FSxFa6cIcQI5LedzZQp2Ewp4Obb0kt4A9PcvGBLOSLdX7y6KrTN+S/R/0iA7iokrGxnueVyBkNZ/IGgZ4LZ7d0hWJy7VSlfdNyDFP7AkZ5zdoiCWkeQsci/2FGACEpcIZDjIxxUIasvlErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa3WOFCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa3WOFCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755041F000E9;
	Thu, 18 Jun 2026 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781821590;
	bh=/EbXXZf6iBjkkIHoO10AQYoNhuMjkKse2aFUCNn/8cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fa3WOFCdndmvhUedN/uyFPSw2vm58u/kLmc33UlgAE17jRNw8uOTRT/zSVdTdZrp/
	 b33Go+aGrsLb1Xem9Sm/ZbJ2jNKqvvEtkZI2YXxnEyuzgjTvukVRxkwRTH+B991g/S
	 6BOkAftNtn+ION5KDWGQ61q41ZUq8ezY1CKSGfAPqpjFdQlwmj2oKswhHa+K01/LVU
	 nyJwkM+MtMI5aGQl4KpXxXxtosgjlqi92lS9pxmb2aSjT74uBA/8m+Jzyw30ECYLLn
	 bMwUPX9RgZVGvPIr91MkCbF+UaplnnRKqRjNhi9WgYhknwfhl90ZbPvD1ebwitgqVe
	 cxNmIFtfgBHwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test cgroup link replace with
 BPF_F_PREORDER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618221919.2919512-2-ameryhung@gmail.com>
References: <20260618221919.2919512-1-ameryhung@gmail.com>
 <20260618221919.2919512-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 22:26:29 +0000
Message-Id: <20260618222630.755041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing error code propagation on `bpf_link_create` failures cau=
ses the test function to incorrectly return success.
--

commit 5273c7a6df31aa862a2601f91f12e4d696020f49
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Test cgroup link replace with BPF_F_PREORDER

This commit adds a cgroup_preorder test case that attaches both a normal
and a BPF_F_PREORDER program to a cgroup. It then replaces the normal
link's program via bpf_link_update() to verify the effective order changes
correctly without array corruption.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c b/t=
ools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
> index d4d583872fa26..80a17203c4fd5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c

[ ... ]

> @@ -102,6 +102,75 @@ static int run_getsockopt_test(int cg_parent, int cg=
_child, int sock_fd, bool al
> +static int run_link_replace_test(int cgroup_fd, int sock_fd)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, create_opts);
> +	struct cgroup_preorder *skel =3D NULL;
> +	int normal_link =3D -1, preorder_link =3D -1;
> +	int atype, err =3D 0;
> +	__u8 *result, buf =3D 0x00;
> +	socklen_t optlen =3D 1;
> +
> +	skel =3D cgroup_preorder__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "cgroup_preorder__open_and_load"))
> +		return -1;
> +
> +	err =3D setsockopt(sock_fd, SOL_IP, IP_TOS, &buf, 1);
> +	if (!ASSERT_OK(err, "setsockopt"))
> +		goto close_skel;
> +
> +	atype =3D bpf_program__expected_attach_type(skel->progs.child);
> +
> +	create_opts.flags =3D 0;
> +	normal_link =3D bpf_link_create(bpf_program__fd(skel->progs.child),
> +				      cgroup_fd, atype, &create_opts);
> +	if (!ASSERT_GE(normal_link, 0, "create_normal_link"))
> +		goto close_skel;

[Severity: Medium]
Will run_link_replace_test() incorrectly return success if this first=20
bpf_link_create() fails?

The err variable is 0 here from the previously successful setsockopt() call.
If normal_link fails, we jump to close_skel and return err, causing the=20
caller's ASSERT_OK() check to see a successful test run despite the failure.

> +
> +	create_opts.flags =3D BPF_F_PREORDER;
> +	preorder_link =3D bpf_link_create(bpf_program__fd(skel->progs.child_2),
> +					cgroup_fd, atype, &create_opts);
> +	if (!ASSERT_GE(preorder_link, 0, "create_preorder_link"))
> +		goto close_links;

[Severity: Medium]
Similarly, should err be set to a negative value before jumping to
close_links if this second bpf_link_create() fails?

> +
> +	result =3D skel->bss->result;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618221919.2919=
512-1-ameryhung@gmail.com?part=3D2
