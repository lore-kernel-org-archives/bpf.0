Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E023932C8
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781698; cv=none; b=JOLubq77ouokVa4V3oD40q5mLXRpCvAsjOwNfinqfx4vl5soC5cqQB0bo44xzzOL6hYgF0qk/G/CDBg6bLSVDoCC87L7HqVi6jcu0UhfAW2Oy8zv8b3ARfE+tZrURZ4+IPb7bOGux+DEo8hUUuZq2xJ40Sif0VMF8c5obb2T8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781698; c=relaxed/simple;
	bh=CHnianyl3AJLIOfEj9HuwFrfN7cb1MvpzSSx4YN5lrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fG6aWIIWksKHzCvAK4bun5OhZeD0NE/S4+TAs7AIrrcVVOAG98UlYg+qyYf2vJCDKYcVW9X9EwqG5JfksZYdBJ5UHPf+O6Ylo1VC+ZgJoIEgwAfLtN4IXHmrYEwKitxdotVnbuCYHDxA9PsPwC3WHzQCUYLFzaALoco/xoTL+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rsl3qphi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rsl3qphi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926C91F00A3D;
	Sat, 15 Aug 2026 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781696;
	bh=zAjgBFCVV0NLadx7kYQxirmhGh1ufAxoCTSApVt2dF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rsl3qphiEGKO/vDzcTD7EPvlmddfuJ9bM8yQLmxrZufbYeuS9UEzjipULOzBIs4vv
	 TXwovgMxOQ8T3U8gnuV0YZp4k8vI/E+uGvrgWIKvJ5ei6ZjFxDLW1uNElHheyFD7Ms
	 q20f2cAuuk3PnE9hnNHow9/+M4HSZow7mXReJZLCzpwvuiEkcs1HrA51uNeU2vYLiD
	 FzYw6PC3SXOYkGDSaS5Yh+pgpoz6wYK3UGwPrvnHb0vAS5vtJzpzUTNF2O0cVCpQvh
	 ljxCcJ7dsccl8Y5jPGqNBpez94csedjSQ5b7PDcMg6nK2vIzPrSX0U9rcM2IQatzp+
	 M53lCp7sIzaLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 12/14] selftests/bpf: Test skb_ext read from
 seg6local End.BPF hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-12-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-12-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:56 +0000
Message-Id: <20260815081456.926C91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The assertion `ASSERT_GE(tc_hook.ifindex, 0)` incorrectly accept=
s 0 as a valid interface index, masking `if_nametoindex()` failures.
--

--- Patch [12]: [PATCH net-next 12/14] selftests/bpf: Test skb_ext read fro=
m seg6local End.BPF hook ---
commit b36d673a00ed1b242e3b7537fce3622d564183f9
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext read from seg6local End.BPF hook

This patch adds a test for reading skb_ext from an lwt_seg6local context.
It sets up a three-namespace topology to verify that an skb_ext written
at TC egress can be successfully read back by a seg6local End.BPF hook
running in a different namespace.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 7a7537ef80e75..5f9247941aa01 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> +	/* NS1: write skb_ext at TC egress on veth1, then send.
> +	 * TC egress fires after seg6 encap, on the encapped packet.
> +	 */
> +	nstoken =3D open_netns("seg6_1");
> +	if (!ASSERT_OK_PTR(nstoken, "open seg6_1"))
> +		goto cleanup;
> +
> +	tc_hook.ifindex =3D if_nametoindex("veth1");
> +	if (!ASSERT_GE(tc_hook.ifindex, 0, "ifindex veth1"))

[Severity: Medium]
Does this assertion properly detect an interface lookup failure?=20

When if_nametoindex() fails to find the network interface, it returns 0.=20
Using ASSERT_GE(..., 0) allows a return value of 0 to pass the check. If th=
e=20
interface is missing, the test will proceed and likely fail later in=20
bpf_tc_hook_create(), which could obfuscate the true failure point.

Would it be better to ensure the index is strictly greater than 0 here?

> +		goto cleanup;
> +
> +	ret =3D bpf_tc_hook_create(&tc_hook);
> +	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
> +		goto cleanup;
> +
> +	tc_opts.prog_fd =3D bpf_program__fd(skel->progs.tc_skb_ext_write);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D12
