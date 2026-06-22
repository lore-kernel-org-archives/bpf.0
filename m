Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B215242D6B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130385; cv=none; b=YBAxYjc0VEHdZ6ejVk9kwIRm3DHQchA3khDkbvb1VN2XiaCR1UUy+RPqr4cag7fzy/ft4fgvgdF0S4zL0w+fy9JzZZbmIx0c4NqpSnbPAmkbiZ1VVlKqKyy+BN1znSYhTk6+W1z2e+BuO+HZ0cZhQDPl6q0PmSCG0U5IM5yBRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130385; c=relaxed/simple;
	bh=jLMv7U+4HZw4Slk17oYvPj1KyNKJZroMPU6NaJPEX/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzEp9QSi7AkErHvVGOfIDRE/rRBWOqFXqf8prlJC9vaS3d53a5yw0zPfoSNbqbnb81iJ0M6tYHLm76e94W/ALQpEU6ePuAFOjG4zz2E6TbpckWc+R0AOGujsUIgb0uqhWC8yXpA5M9hvttIz3dnO+ZkaiMLI+S3BtM30A9W2tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvldztcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvldztcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CF61F000E9;
	Mon, 22 Jun 2026 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782130384;
	bh=LHGIhoeyO1lJrGZzBCLUAiyHHW4yDMJYFzmqc7PH+do=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvldztclkrFjDeQrVoihVWC4AvPxIxzcKPtkO4GSyLbxwnZV1X0FNlli6rWao6R8N
	 dhEWXymoktnbuwNrzBd3N6Kf3VsMmXrZn5Kfo4JU3mEZDnAEDSqYLmNblZba0Ql/yp
	 wGlJrdflY7lAeYblmSqycJBX7asixeP++S9NB9r2kj5AZSqDJQSpCG2Ln8Eo+/mfj0
	 P1lhGxPBOuKsHm/m8dhFe/lkBO+HM/2B2lXLgsiRjTzNZ5Eq+8F0T6pGEOF1H/3Mrc
	 gooZK3GCp61T/hiOqMhw8q/qnBeiascT7zFVAoQchqe84JzojsM0XxQHpVQynKv4EM
	 ELLpgDVzIlDNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 7/7] selftests/bpf: add bpf_icmp_send
 recursion test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622120515.137082-8-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-8-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:13:03 +0000
Message-Id: <20260622121304.14CF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect cleanup order causes cgroup umount failure and leaks t=
he mount state.
--

commit 1d67b87ccff7644b98064bc08cc47ad24bf14fb6
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send recursion test

This commit adds a new BPF selftest for bpf_icmp_send recursion handling. It
attaches a BPF program to the root cgroup to ensure that generated ICMP
packets re-trigger the BPF program, and verifies the kfunc returns -EBUSY
early.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index 66447681f72db..fd4b8fa78a018 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> +void test_icmp_send_unreach_recursion(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd =3D -1;

[ ... ]

> +cleanup:
> +	cleanup_cgroup_environment();
> +	icmp_send__destroy(skel);
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
> +}

[Severity: Medium]
Does this cleanup order cause the cgroup environment unmount to fail?

It looks like cleanup_cgroup_environment() is called while cgroup_fd is sti=
ll
open and the BPF link inside skel is still active. Because cgroup_fd holds =
an
open file descriptor to the cgroup mount directory, calling
cleanup_cgroup_environment() first will attempt to unmount the directory wh=
ile
it is busy.

Would it be better to close cgroup_fd and destroy the skeleton before clean=
ing
up the cgroup environment to avoid leaking the mount state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622120515.1370=
82-1-mahe.tardy@gmail.com?part=3D7
