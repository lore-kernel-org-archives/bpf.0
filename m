Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAF4418E4
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905448; cv=none; b=OFHk7Qe4LnTUWPL+BMmRzzVW5EWWVwM/4v7unjyugXxExlQMQRzKHfobEdnDmAK6eBhNNyzamDe/UPZjRzpmXOJR0vi7sfdyNdphWTVbPYLhhfuzYL22jNMj3OUxQk3iAe3lAy2XzbeuoOONkLy848dSlqCzRNazmcGHNkmVaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905448; c=relaxed/simple;
	bh=aKzmtouCn7eMViGtv5LehHGPk/d4Vunibmcx6hGknac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1Hq4IGFenemrIjdH+oWZyHSiotE9GPsqf9PbL4kMaJcE1lmG7w2s50iBQkSOVkPexEZ2AdrrHtMNR3P7DY6QLrkL7L9ifOqw6hEZarHYIu0Q872t1iAq/7bmEj+aZFAY6LxNG+W2p5wSmZKDpaiYeKt2PE3ADllkYIz727I2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHLZBSEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHLZBSEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAE71F000E9;
	Wed,  1 Jul 2026 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782905446;
	bh=ZETwXXRpwqSruorkFrVdxUEYggRfwA+zEts2gKyY4jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHLZBSEilfTr3txN8PLP/G9GY7hlKA4Ok4JcX9Sn6pu9OFPheANNjN/m60OuVkvjJ
	 q+g2E+VXIxjM9d46FWc3ynLmNQw4vAVBAyyM2n4ASMe7fwPgaDh67QM4IFWhSByx/B
	 JgI50Wxb2Dyl3QJfbxB51hQO1x8aiETr6tobUjlmQ1LQ5xXIais7Ys89+owfy4UxGJ
	 y33TF/m9rjhtVjspftCBXIf76Xhl1kX3qaVX6GE6G9MdbG08WRAM+Y0YBtmqAxqhGT
	 bSs4cqhuaw9/TsRp6D52lLmSpQKsaNHjaVAifSMFSTiFEM+hk45cz6q6HKCTfqxTi/
	 MQEusCwU7ibkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 07/13] libbpf: Detect uprobe syscall with new error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701111337.53943-8-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <20260701111337.53943-8-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:30:45 +0000
Message-Id: <20260701113046.4FAE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unmerged cross-tree dependency breaks `test_uprobe_error()` self=
test and drops backward compatibility.
--

commit 7f7a698fa2699de0d1d3b920e07eb13831d5223e
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Detect uprobe syscall with new error

This commit updates the uprobe syscall feature detection in libbpf and the
corresponding selftest to expect EPROTO instead of ENXIO.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..e5641fa601637 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_f=
d)
>  static int probe_uprobe_syscall(int token_fd)
>  {
>  	/*
> -	 * If kernel supports uprobe() syscall, it will return -ENXIO when call=
ed
> +	 * If kernel supports uprobe() syscall, it will return -EPROTO when cal=
led
>  	 * from the outside of a kernel-generated uprobe trampoline.
>  	 */
> -	return syscall(__NR_uprobe) < 0 && errno =3D=3D ENXIO;
> +	return syscall(__NR_uprobe) < 0 && errno =3D=3D EPROTO;

[Severity: Medium]
Does modifying this check to strictly require EPROTO break backward
compatibility for libbpf? Older kernels that support the uprobe syscall but
return ENXIO will no longer be detected, which might needlessly prevent the
use of optimized uprobes on those versions.

Could this check accept both ENXIO and EPROTO?

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52d..c944136252c6d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> @@ -762,7 +762,7 @@ static void test_uprobe_error(void)
>  	long err =3D syscall(__NR_uprobe);
> =20
>  	ASSERT_EQ(err, -1, "error");
> -	ASSERT_EQ(errno, ENXIO, "errno");
> +	ASSERT_EQ(errno, EPROTO, "errno");

[Severity: Medium]
Will this test fail against the current kernel tree? If the kernel patch
changing the return value from ENXIO to EPROTO hasn't been merged yet,
the syscall might still return -ENXIO, causing this assertion to fail when
running the BPF selftests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701111337.5394=
3-8-jolsa@kernel.org?part=3D1
