Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA32EEE89
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714983; cv=none; b=SQlsWyq3QNhGEeaMYWZswn7uo/ikPx+ELw3HitsQ7F9u1YjMR6402cHTgEMT+vD5YJHnERSctDXgikGRFeerGtBMPASfKpSrv+ueaFo7SkxuSiwme8OwXtveWuszT9BW3T36sUVRn7KaHp0HmIB1npDOOO9c/tvyvEoKr1Rm/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714983; c=relaxed/simple;
	bh=peuPn2SA9N1BvQ8WRZ+dMHLe7SnKfA84699y5c7UiWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c1jwY3V3/xBaCuSTq3fMqb3TuEbjqvjQUBi6ZYS08hchPyrLVfkR6T+Afm2qx25UPAzEtKEzv4S24UDrCNtCOY/MkYRbzOixb6vaYraf35BJMaaTRT/td453yPCrM+rybmMC0i5IW7Ft5Iad1J6daLakvK39CoZyQqUBsQ35vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TozDMxjl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TozDMxjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F901F00A3A;
	Sun,  6 Sep 2026 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714981;
	bh=a6V21nBKp7BB+cjiV2t4n3hOTa1t6iv63/b+PUK1GPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TozDMxjl8CgeH8jsiq49G7Rp7gC9uWvOgIVoBbN/baIFSEO0oxgmZRzLPin3k62cN
	 dNvLsrVHUMoV6vO7kL2p+3A+yKzFAsSaXHjZ2OwFqv+mVWVO/v7gapm9eq5XLd0JdJ
	 7HhHanRa8fylfpvQK1Z7H8f3q69aKqyUAKa9qYu30899NucUbsI01HBYxMo+mMb0B9
	 E6ixSM5uFx7ZMXKx7tOpzwDrAySGjiSULPHebAnkBo3zoRl3OKpXaWv3rRDb6g1jXR
	 BE53ce2TbGBA9dpf93qfP7+zEuB96JK4WOBM7/XeRD4ZD3CIkc6Rddcof4fJGf8j96
	 W8QhYjdclDr0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check bpftool batch map
 dump contents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260906170819.1212661-3-hi@tychen.cc>
References: <20260906170819.1212661-1-hi@tychen.cc>
 <20260906170819.1212661-3-hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:16:20 +0000
Message-Id: <20260906171621.48F901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF subsystem style.
--

commit c56ab936d02afbcb53a4b6f2e304647318354a05
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Check bpftool batch map dump contents

This commit adds selftests to exercise bpftool hash map dumps using batches.
It compares the unordered key/value results against expected inputs in plai=
n,
JSON, and pretty JSON formats.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b=
/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> new file mode 100644
> index 0000000000000..139d13a49dcef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

[ ... ]

> +static void check_dump(const struct dump_case *test, __u32 id, bool json=
, bool pretty)
> +{

[ ... ]

> +	err =3D get_bpftool_command_output(command, output, OUTPUT_SIZE);
> +	if (!ASSERT_OK(err, "map_dump"))
> +		goto out;
> +	/* Ignore presentation whitespace, but compare complete records and all
> +	 * punctuation. Expected contents come only from the input data, never
> +	 * from another map walk or bpftool invocation.
> +	 */

[Severity: Low]
Could we update this multi-line comment in check_dump() to follow the
preferred BPF subsystem style where the opening /* is placed on its own lin=
e?

> +	for (src =3D output, dst =3D output; *src; src++)
> +		if (!isspace((unsigned char)*src))
> +			*dst++ =3D *src;
> +	*dst =3D '\0';

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906170819.1212=
661-1-hi@tychen.cc?part=3D2
