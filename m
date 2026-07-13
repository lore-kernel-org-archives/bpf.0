Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C6335BB4
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960708; cv=none; b=T2IW4b6cG0KzR53fbw+mH1Gdbm1culRkoFgqKeRLd2UOk/axhqDswpOH1J+TNP9aeaF03eBsUn1AtAr/cutaTCkGYsDGJ4ehPK/Uev0dCq9a5HjvmzjPkLhGe2/8o86gz+Xhn8mppAaGNwcJ95sMjSWhDXtq2fENMSvUCq1uqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960708; c=relaxed/simple;
	bh=TGqNklRmFfYBCBzh00MzxLOeUe/02Ig++aWTe+vFT7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ump/LCGaIb8rArWaaakx/Dww1yfZEMYsJulNM5ekpHdumzf/2UFg6gm7NMocegL5yyLaNws2jO1tuBVKMI14MhI2XlPuQvgv9KCICIF7CAR/EL7rsAonv4s8HngmYBcB/fbFHaMYR8W4jYk5vnqz7O0fbbVdbbtK4x4dwFNcArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D87lis2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D87lis2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70201F000E9;
	Mon, 13 Jul 2026 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960707;
	bh=wFDTA1Dx1oEwfaDUg9NYDRssYMwh/pMMy8eMr0LfbqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D87lis2Bo8Vh+gxd7NCGJ5cjMVQleMxk/Ml+3tMF21NfiPXfXmBV3bEMWO5PAELLe
	 7ue9UpBiUf7KulNyaYYiEuSP3obD/5SNHK8kx57ImbAzfSfs02N9GCwpKJzcyPIT3y
	 BvGejQEXR37JkDLRFBTAjnLO5B5/B6Kqz165lriYZNVChHJgJ3F7gtznMvJmv6rebf
	 litR1kqviUqQLf8sO7whQGZv3AGnBA9IbcB1U4wyTIVViLhAIgSl0e/CJ+meojpydX
	 w6/sHYgsrrTGtrPwsGGp6fX6Ndf5jFlonh/hoFFd2Y6SaCFHlLt87lkuD15pefVgfR
	 jGz2W/D45cCeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 3/3] selftests/bpf: Add bpf_fib_lookup()
 VLAN flag tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713162305.1237211-4-avinash.duduskar@gmail.com>
References: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
 <20260713162305.1237211-4-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:38:26 +0000
Message-Id: <20260713163826.D70201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The input netns boundary check in `test_fib_lookup_vlan_netns` i=
s a tautology and cannot detect regressions.
--

--- Patch [3]: [PATCH bpf-next v7 3/3] selftests/bpf: Add bpf_fib_lookup() =
VLAN flag tests ---
commit dd8cb85eafac54bc022600352c949874324b276d
Author: Avinash Duduskar <avinash.duduskar@gmail.com>

selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

Cover both new VLAN flags in the fib_lookup test. BPF_FIB_LOOKUP_VLAN
reduces a VLAN egress to its physical parent plus the tag, and
BPF_FIB_LOOKUP_VLAN_INPUT scopes the lookup to a VLAN subinterface.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/=
testing/selftests/bpf/prog_tests/fib_lookup.c
> index bd76589580041..f7361f9a34592 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
[ ... ]
> @@ -851,0 +852,136 @@ void test_fib_lookup(void)
> +void test_fib_lookup_vlan_netns(void)
> +{
[ ... ]
> +	/*
> +	 * input: the moved device is still in veth7's VLAN group, but it
> +	 * lives in another netns, so the lookup must fail closed
> +	 */
> +	skb.ifindex =3D parent_idx;
> +	memset(fib_params, 0, sizeof(*fib_params));
> +	fib_params->family =3D AF_INET;
> +	fib_params->l4_protocol =3D IPPROTO_TCP;
> +	fib_params->ifindex =3D parent_idx;
> +	fib_params->h_vlan_proto =3D htons(ETH_P_8021Q);
> +	fib_params->h_vlan_TCI =3D htons(66);
> +	if (!ASSERT_EQ(inet_pton(AF_INET, IPV4_VLAN_NETNS_DST, &fib_params->ipv=
4_dst),
> +		       1, "inet_pton(dst)"))
> +		goto fail;
> +
> +	skel->bss->fib_lookup_ret =3D -1;
> +	skel->bss->lookup_flags =3D BPF_FIB_LOOKUP_VLAN_INPUT |
> +				  BPF_FIB_LOOKUP_SKIP_NEIGH;
> +	err =3D bpf_prog_test_run_opts(prog_fd, &run_opts);
> +	if (!ASSERT_OK(err, "test_run(input)"))
> +		goto fail;
> +	ASSERT_EQ(skel->bss->fib_lookup_ret, BPF_FIB_LKUP_RET_NOT_FWDED,
> +		  "input across netns fails closed");

[Severity: Medium]
Is this test effectively a tautology?

The IP and routing configuration for the target namespace NS_VLAN_B isn't
set up until after this input test runs.=20

If a kernel bug completely skipped the netns boundary check, wouldn't the
route lookup fail anyway and return BPF_FIB_LKUP_RET_NOT_FWDED, causing this
assertion to falsely pass?

> +	ASSERT_EQ(fib_params->ifindex, parent_idx, "ifindex untouched");
> +	ASSERT_EQ(fib_params->h_vlan_TCI, htons(66), "tag untouched");
> +
> +	close_netns(nstoken);
> +	nstoken =3D open_netns(NS_VLAN_B);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns(b)"))
> +		goto fail;
> +
> +	/*
> +	 * egress: the fib result is the VLAN device here, but its parent
> +	 * is in the other netns, so the swap must not happen
> +	 */
> +	SYS(fail, "ip addr add %s/24 dev veth7.66", IPV4_VLAN_NETNS_ADDR);
> +	err =3D write_sysctl("/proc/sys/net/ipv4/conf/veth7.66/forwarding", "1"=
);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162305.1237=
211-1-avinash.duduskar@gmail.com?part=3D3
