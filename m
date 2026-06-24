Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D68175A9B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270930; cv=none; b=pyBd+7RT9cf96oKZ3O/OjK5x1meZdbaF0UhDYBVMtp0cvNPpadVmkQJk8K423z/I7GCsKs6c74sVE7JccmYM+TCtxijRBPx47xC/ptT4uY/0BgXNKNG8iz7c6oWwu5Jez9ddWeB1XVwyWebd/fhsLZJzFGjI0ScH09eN83FSgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270930; c=relaxed/simple;
	bh=/+qGT2rbbH2td3U0AyJKpv510KJnNYt8TL7gDk3pj/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EHZxB9kCbbPXpw1GAjUn7p+HlxrGCJzkhHLceaE/JMyzxRYglxXhBO9Ztzrz4WZ3xuxjzf3uttiOTDhXYqn8ceHpI/Sb3ps50RyuzRhoLL8kjZ8gP+T2ggxh+UxRdrNcBoR0cYtPpgXzm1J/fmvxYO6izFNQjFJNMf1/mPbsc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF98kEvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF98kEvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2C91F000E9;
	Wed, 24 Jun 2026 03:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782270929;
	bh=9eacS6gwfF0EpFU89ectwD/dYNL/cMcwJ1/A6EttuHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iF98kEvnE7l9dq158VyYO5/U0c06iorVR7TFmwF8kGOklPl7bn6BEwt2ivGxBV59Z
	 v/SDgW8iL9c5lzuRkDFCfuVgHlRV8W9OHiCZJ+6Padrb9ICDOREzSZfZHsQTagUplL
	 GDgtkIRhf0TdVi3/awSNcObhQIt9T4VEZ6YRlUQVRhiN73HzYY8AEhsXQPgY80lf2m
	 mfF9CrXyczmu4UvTJtvJmx1VP85yDdBBRc5CYyjKyPSa9FoDL26Y3DdYbOad2Ew178
	 TukPh3KV99LxoKN437MTGJH91wB7kHqtlUaLn84IA5+e6KTIrnXDDenUgWMTAr3XMf
	 6pmn860KdL93A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Add bpf_fib_lookup()
 VLAN flag tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624030530.3342884-4-avinash.duduskar@gmail.com>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-4-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 03:15:28 +0000
Message-Id: <20260624031529.4D2C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the modern BPF kernel style.
- [Low] Dead write to `skb.ifindex` before running the XDP test in `test_fi=
b_lookup_vlan_netns`.
--

commit 8850d806ed94f65fe16bb923b209b37fa59c65ae
Author: Avinash Duduskar <avinash.duduskar@gmail.com>

selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

This commit introduces selftests for the bpf_fib_lookup() VLAN flags. It co=
vers
both BPF_FIB_LOOKUP_VLAN for egress and BPF_FIB_LOOKUP_VLAN_INPUT for scopi=
ng
the lookup to a VLAN subinterface.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/=
testing/selftests/bpf/prog_tests/fib_lookup.c
> index bd76589580041..8caed9d43b981 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
[ ... ]
> @@ -343,6 +730,15 @@ void test_fib_lookup(void)
>  		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
>  			continue;
> =20
> +		/* BPF_FIB_LOOKUP_VLAN is XDP-only; the tc helper rejects it.
> +		 * These cases are exercised on the XDP path below.
> +		 */

[Severity: Low]
This isn't a bug, but this multi-line comment does not follow the preferred
kernel comment style for the BPF subsystem, which places the opening /* on
its own line:

/*
 * BPF_FIB_LOOKUP_VLAN is XDP-only; the tc helper rejects it.
 * These cases are exercised on the XDP path below.
 */

> +		if (tests[i].lookup_flags & BPF_FIB_LOOKUP_VLAN) {
> +			ASSERT_EQ(skel->bss->fib_lookup_ret, -EINVAL,
> +				  "tc rejects BPF_FIB_LOOKUP_VLAN");
> +			continue;
> +		}
[ ... ]
> +	/*
> +	 * egress: the fib result is the VLAN device here, but its parent
> +	 * is in the other netns, so the swap must not happen
> +	 */
> +	SYS(fail, "ip link set dev veth7.66 up");
> +	SYS(fail, "ip addr add 10.66.0.1/24 dev veth7.66");
> +	err =3D write_sysctl("/proc/sys/net/ipv4/conf/veth7.66/forwarding", "1"=
);
> +	if (!ASSERT_OK(err, "write_sysctl(forwarding)"))
> +		goto fail;
> +
> +	vlan_idx =3D if_nametoindex("veth7.66");
> +	if (!ASSERT_NEQ(vlan_idx, 0, "if_nametoindex(veth7.66)"))
> +		goto fail;
> +
> +	skb.ifindex =3D vlan_idx;

[Severity: Low]
Is this assignment to skb.ifindex necessary? The subsequent test run uses
xdp_opts, which doesn't specify a context (unlike run_opts which passes skb=
 as
ctx_in), so it appears the skb is ignored here.

> +	memset(fib_params, 0, sizeof(*fib_params));
> +	fib_params->family =3D AF_INET;
> +	fib_params->l4_protocol =3D IPPROTO_TCP;
> +	fib_params->ifindex =3D vlan_idx;
> +	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
> +		       1, "inet_pton(dst)") ||
> +	    !ASSERT_EQ(inet_pton(AF_INET, "10.66.0.1", &fib_params->ipv4_src),
> +		       1, "inet_pton(src)"))
> +		goto fail;
> +
> +	skel->bss->fib_lookup_ret =3D -1;
> +	skel->bss->lookup_flags =3D BPF_FIB_LOOKUP_VLAN |
> +				  BPF_FIB_LOOKUP_SKIP_NEIGH;
> +	err =3D bpf_prog_test_run_opts(xdp_fd, &xdp_opts);
> +	if (!ASSERT_OK(err, "test_run(egress)"))
> +		goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624030530.3342=
884-1-avinash.duduskar@gmail.com?part=3D3
