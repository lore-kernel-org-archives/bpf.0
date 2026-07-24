Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954443B6E7
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903063; cv=none; b=tu44wvzYxQoGjbNHlQUjX3EuCreMRs4wdUSzoFRpLymKDRABdFkMMq8tkvkC+QFz9c3Msz+EvebDesfTYAyL3KS5pEcz4Ul6/SPbEFzOzp2fLI4vzkKtdPiWJc7HrQQtbHsFf9Pdyzs1DL76ueQ+qZ/66k80oD9QlUvfV1QDNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903063; c=relaxed/simple;
	bh=FPAs/yBm48d6pXnQ37wvF3Dyk0fQtyD68aqNVi8HVSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVyiwOpO79WmKZSEwoTvhCxVrlKCqE/fx5Tw85pE8spcdjTL2AQqirVz3r3PIFSIm/SZFtxMJAAF4Cf+2KN/m5/tZvONxPCshqcBfE7hTS29Ht7moyrucBLWv+ihenoeeUZyb0wzLH4SFZJGy0uwIafNgP/yDOWQWcbfPQwEP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFExTP0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFExTP0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E191F00A3D;
	Fri, 24 Jul 2026 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903059;
	bh=zu67Pv+KerA1wCD9vFSBzWvyd2EYlvngTi7u+X+xv2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFExTP0v82aHSGFGJFROuyy6g5WcegomtmH1e3v0CW+sHXmSO4gYrj7hjKCSLALER
	 uBVykaNLKqm/D4ILxGoHsS/EJHFlz8+HPBkfXAR+zXk7MRaBCrQl4I+9gKbTxkG6gr
	 Vcu9JCWg/DxDPVwmB5J8p42hJN0YMKGem89ZiExbXCQTt5agw+uo/YCXMldccw7Zni
	 kRKNZy/zbYu8m6GBknbIcC/pIXKqxwHtC/kKweVu88xQnKMq2lVBuA0hGSdeLLDuNT
	 RsilqDt+Wtf7tkTi1n7wheB+2tZYpt+Acy7yxrzKwcj1avamHE3+K+yxJS5Znpcyop
	 qic2C6/msa88g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify rejection of
 sleepable tracing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724141422.10463-3-leon.hwang@linux.dev>
References: <20260724141422.10463-1-leon.hwang@linux.dev>
 <20260724141422.10463-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:24:18 +0000
Message-Id: <20260724142418.B7E191F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test incorrectly handles the expected failure of `fentry_sle=
epable__load()`, leading to dead code on patched kernels and an intentional=
 kernel BUG on unpatched kernels.
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Verify rejection of slee=
pable tracing prog ---
commit 21867bb1ed07f00930e4aa9f252967deb7c142a2
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Verify rejection of sleepable tracing prog

This commit adds a BPF selftest to verify that a sleepable tracing program
cannot attach to a '__x64_sys' prefix program target.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
[ ... ]
> @@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
[ ... ]
> +	err =3D fentry_sleepable__load(skel);
> +	ASSERT_ERR(err, "fentry_sleepable__load");
> +	if (err)
> +		goto out;
> +
> +	skel->links.fentry_xdp =3D bpf_program__attach_trace(skel->progs.fentry=
_xdp);
> +	if (!ASSERT_OK_PTR(skel->links.fentry_xdp, "bpf_program__attach_trace"))
> +		goto out;
> +
> +	skel_xdp->links.__x64_sys_nop =3D bpf_program__attach_xdp(skel_xdp->pro=
gs.__x64_sys_nop,
> +								ifindex);
> +	if (!ASSERT_OK_PTR(skel_xdp->links.__x64_sys_nop, "bpf_program__attach_=
xdp"))
> +		goto out;
> +
> +	err =3D system("ping -q -c 1 -W 1 127.0.0.1 > /dev/null");
> +	ASSERT_OK(err, "ping");
> +	ASSERT_ERR(skel->bss->retval, "retval");

[Severity: Medium]
Is it intended that the attach and ping logic only executes on unpatched
kernels?

When run on a patched kernel, fentry_sleepable__load() fails as expected
(err !=3D 0). The ASSERT_ERR(err) check passes, but the if (err) block then
causes the test to jump to 'out', making the remaining attach and ping code
unreachable.

When run on an unpatched kernel, the load succeeds (err =3D=3D 0). The
ASSERT_ERR(err) check fails, but because err is 0, the test proceeds past
the if (err) check. It then attaches the program and triggers it via ping,
which intentionally crashes the system with a kernel BUG (as noted in the
commit message) instead of failing gracefully.

Could this be resolved by either removing the unreachable attach and ping
code entirely, or by changing the check to if (!err) to prevent the test
from crashing unpatched kernels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141422.1046=
3-1-leon.hwang@linux.dev?part=3D2
