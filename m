Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDF38655A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223260; cv=none; b=BnplFLEnhNpVoykWdt7eu6TmfrMs/LAfL5E9orepu6FFXTKQV3B4V1ddJ7bJ+5FtPC/X3LU0H2GPi0vMA2IpnUOwJjnWDC0IaTA5d601ZTmasBbFVllxM8FHDWG3jxfgtLiDlr6pR2pE1TXMbOeusa3xHmT/J4NcXmf2xyaVSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223260; c=relaxed/simple;
	bh=ifu5Wp9GS0t8edGMVohHJ7/VTFEYuVscSXEXx5VfLMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pF2uAa6cp7jgM5/c0vGBGGW2ArQLOs0bCuEnMSmhCPpgY9BAvdpcAg0kMJ4rlWgVrm0GjU5drZDDLgbSVa7vYobYZPv1GySNpiKKccK8CUeiErAv6wdHkPydbimX7+Y8iA2Cmfnq1fxlZ2XpBokM1ZjsLpMlW1K8OLJj7F20tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEEn1V0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEEn1V0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486C61F000FF;
	Thu, 24 Sep 2026 04:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790223258;
	bh=JHqfSB9ZYoyAnxtFOJe1ci1S9YHEXUaaorwd8wUsbOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEEn1V0bqzZkXIRD4NYad5Gd/dacZ1n193Gw7aVhFaDmqNb3g/NgvofZ9RclQsg/y
	 LHlMzNtvW7qT6BoOVfeai9SCTuCkf04Z+oNW7mWY+xDxomNcJ8ZEyAf8rg8YUog/g6
	 mY0cMju5zWYLHNhDZHP/6XIaWRbeJLSKtBSFB2eg9Cpb+44l7qCbYriMuuOkALokPV
	 Jl9S/hQtbQb+fY9+tQz1ACuzh/APiynlFdbVF9r+avgyuB8N2sSZnunBQf/eqGZzGS
	 SisKlkDmCkk0mvIFN1COJV7/lCHzWNoGfPYBq26Y1X7wf/CtqPHdEKuiXtp2umy0en
	 YHGdN74vrfNPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add bpf_proactive_reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <67d8708eeaa771dea97d5c1f15744fe33178c43b.1790222105.git.zhuhui@kylinos.cn>
References: <cover.1790222105.git.zhuhui@kylinos.cn>
 <67d8708eeaa771dea97d5c1f15744fe33178c43b.1790222105.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 04:14:17 +0000
Message-Id: <20260924041418.486C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: selftest fails instead of skipping on tmpfs-only environmen=
ts
--

commit 050e765c2f056e2f47574982f5ca0cece0afd7b8
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: Add bpf_proactive_reclaim test

This commit adds a selftest for the bpf_proactive_reclaim kfunc. It verifies
the bounded reclaim behavior by charging page cache to a cgroup and request=
ing
eviction of the allocated pages in a single call.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_recla=
im.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> new file mode 100644
> index 0000000000000..d642658a21981
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
[ ... ]
> +void test_memcg_proactive_reclaim(void)
> +{
> +	struct memcg_proactive_reclaim *skel =3D NULL;
> +	struct reclaim_args args =3D {};
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		    .ctx_in =3D &args,
> +		    .ctx_size_in =3D sizeof(args));
> +
> +	char data_file[PATH_MAX];
> +	static char buf[BUF_SIZE];
> +	__u64 cgroup_id;
> +	const char *dir;
> +	off_t off;
> +	int cg_fd =3D -1, data_fd =3D -1, err;
> +
> +	dir =3D workload_dir();
> +	if (!ASSERT_OK_PTR(dir, "workload dir on a regular filesystem"))
> +		return;

[Severity: Medium]
Will this cause spurious test failures in tmpfs-only environments?

When workload_dir() cannot find a suitable regular filesystem (for instance,
when both '.' and '/tmp' are tmpfs/ramfs), it returns NULL.

Using ASSERT_OK_PTR() here unconditionally fails the test. Could this be
changed to gracefully skip the test instead via test__skip(), so that CI
environments lacking a disk-backed filesystem do not falsely report a failu=
re?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790222105.gi=
t.zhuhui@kylinos.cn?part=3D1
