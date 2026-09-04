Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DF3EB802
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520373; cv=none; b=i/cOkZJ0RKyAA8UgQY5LRMVCKolaE8I2fq4VMH6c00ISeXBc4gCUniRk/T0I4NSzp+Jgz7RROy+SgZsWmTHqF1v+T6o7ac+21UTVv/KGEO/VqZY43X4Nx5FhP6LrFc+Tbg+PgwZYxtNl+jZnGSDubtcjEI7khhQnfhxy0rohzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520373; c=relaxed/simple;
	bh=YqUb8nb4amiT7y3phrxVwYrhQ97OrjUEu3dmXB1nprA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSzYw0DrZHHe6Sq6vRHlv2LXnzWIAYN9kW3tfTAuYhcPIEifwVjrltc8vNgrdi/7lujzIxNYOdOsy1nMs0l+OjeGG/gFc5Qir7GOiNZyCHNKW5Qkutcze/BgQLUG1nbChA6z4EYyEUkdowMrPGw9dqEg5N/GFMtSX4WEu0yPKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUnzTe9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUnzTe9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4B81F00A3D;
	Fri,  4 Sep 2026 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520372;
	bh=76laYswThSaWnsQdHGgknHyNEnWOiWv/8F4zrIs+pRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUnzTe9J6j+3GBds55sMcLGqLaZqytfRemPW2XR5OgszHjwprIGck0fdPo24hsW+l
	 dq02L3DWGHD3WArS+BlbYg6+Lu+ufFxq5/hbhjXWIRODXgHKcF+9vK1IHh2x+1ajRk
	 PqCUbSSqdTxUeCbPvQ9TzyYkBSLQpNBqnNzZ5OGpuT4EVLxzqok/A+a8IdCg4paL3F
	 n9QkCdpIv4jNRoW/yHxp1z1vvOxhT94wCl/ifMchBfWVRfa0c3ovb36g+hzOyAQbZb
	 NHG3sPkWXuCq7lNMWBDinA0s+GFLXTHxE9zmK8MeB36Yt2Y4/Bh82one160mL1Rmya
	 pQYyF20qZeFpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Test timer field on recycled
 rhtab element
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904104203.345917-3-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
 <20260904104203.345917-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:12:51 +0000
Message-Id: <20260904111251.CC4B81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Redundant file descriptor validation after successful BPF skeleton =
open_and_load
--

commit 3c5ef82656b9b8e3dd5798348adbe7dae8162f8d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test timer field on recycled rhtab element

This commit adds a selftest to exercise the rhtab special-field lifecycle
using a one-element map. It verifies that deleting a map element and then
replacing it preserves the timer field and successfully recycles the elemen=
t.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c b/tools=
/testing/selftests/bpf/prog_tests/rhash_timer.c
> new file mode 100644
> index 0000000000000..3aad9fc02e063
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c

[ ... ]

> +void test_rhash_timer(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct rhash_timer *skel =3D NULL;

[ ... ]

> +	skel =3D rhash_timer__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto out;
> +
> +	map_fd =3D bpf_map__fd(skel->maps.timer_map);
> +	if (!ASSERT_GE(map_fd, 0, "timer_map fd"))
> +		goto out;

[Severity: Low]
According to the BPF subsystem guidelines for the skeleton API, after a
successful rhash_timer__open_and_load() call, the skeleton pointer is valid
and all maps are guaranteed to be created with valid FDs. Is it necessary
to manually extract and validate map_fd using ASSERT_GE() here?

> +	arm_fd =3D bpf_program__fd(skel->progs.arm_deleted_timer);
> +	if (!ASSERT_GE(arm_fd, 0, "arm_deleted_timer fd"))
> +		goto out;
> +	cancel_fd =3D bpf_program__fd(skel->progs.cancel_recycled_timer);
> +	if (!ASSERT_GE(cancel_fd, 0, "cancel_recycled_timer fd"))
> +		goto out;

[Severity: Low]
Similarly, is this program FD validation needed? The skeleton guarantees
that all programs are loaded with valid FDs after open_and_load succeeds,
so bpf_program__fd() cannot return a negative value here.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904104203.3459=
17-1-memxor@gmail.com?part=3D2
