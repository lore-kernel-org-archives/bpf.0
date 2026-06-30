Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C5360ED7
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847680; cv=none; b=NSG1tUZu1f63FuOx8HpX6R/7uI1FhbT2fIgJrMpyC3plMcQC4AnpziPYgJyDXRLyTYXIkA6Vow3hp7+4Ab20ex6iwj32ar9i8JOq4ZZMb5+tUC3+b1eZkbBUImxRYdVoC+cbGBPaDl5ARNHmZXE1db7X1GbDu9RJwkjtIyQTeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847680; c=relaxed/simple;
	bh=nIDpRwp2V9a7NhRIy43wSrzBtHa0PTvyl/0GXccYSHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d07/tDbSchC5MZQcYcVrFJ41TMKoFMfGEiIh7nMuZwG5K/hJnHDzBFE11wSLazKDzlcA7nQcpK6B5r4ieaOGjNsCFliwTV4y6uiIccarDkFzBduQiR5Gu2JfaqqdjwYfz3F+VQbewoJWBkDswgZZZAKhGyLgvJvo5NEed1zjyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvEmgcM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvEmgcM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D31F000E9;
	Tue, 30 Jun 2026 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847679;
	bh=w4ycM4cc0lwXA3OIbHGnJnUlUWm4HN6Z4vt4RVumTUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvEmgcM58VeBMz1cIwyrT0q3pVEOVBWTiOrEbzxNe1i5Dn7F5W00FXMjKEefxJwsT
	 vwXF7iRJmxEqdozfjZJGK39e15JN9HDTXUcBM2rbJKz2vxlFDpgyi9L6kY7K8CUSJf
	 Fgu1jKbCzCGlR82Kvnubd6tFl3XaQ+OVd411GYJU0AM+NPuBRVF9H8fl9u7iYouBvG
	 HmNOmuSf0Z+ryQuERROKT0ZjLKq9yahUu2DO6adUG3duO0oa+iJ9mBr0Ktz1PNaN4H
	 UEE8oGSB4kC6bicdSf4ENPk1u05Bclyu9VyoeI0rLPiqyoYDYEEfiadnpCJsOJVxZU
	 EqTLqM0VIWlnQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 2/7] selftests/bpf: add test for
 bpf_xdp_assert_rx_csum over cpumap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630191510.81402-3-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <20260630191510.81402-3-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:27:58 +0000
Message-Id: <20260630192759.7E6D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The XDP program redirects all IPv6 packets unconditionally witho=
ut filtering for the specific test UDP packet, causing the test to be flaky=
 due to background IPv6 noise (e.g., MLD/ND).
- [Low] Multi-line comments do not follow the required BPF subsystem style.
--

commit 846ee2231e17e81d931043f95937a20e26145ff4
Author: Vladimir Vdovin <deliran@verdict.gg>

selftests/bpf: add test for bpf_xdp_assert_rx_csum over cpumap

This commit adds a selftest to verify that the bpf_xdp_assert_rx_csum helper
properly propagates checksum status through a cpumap redirect. It uses an X=
DP
program and an fexit hook on __xdp_build_skb_from_frame to observe the
resulting ip_summed value.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c =
b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c
> new file mode 100644
> index 0000000000000..2def92fe11118
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c
[ ... ]
> +static struct udp_pkt pkt =3D {
> +	.eth.h_proto =3D __bpf_constant_htons(ETH_P_IPV6),
[ ... ]
> +	.udp.len =3D __bpf_constant_htons(sizeof(struct udphdr) + 16),
> +};
> +
> +/* Inject one frame on veth0; it is received on veth1 where native XDP
> + * redirects it into the cpumap. Report the ip_summed the rebuilt skb ca=
rried.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style? The guidelines suggest putting the opening /* on its own l=
ine.

> +static int inject_and_observe(struct test_xdp_cpumap_rx_csum *skel, int =
sfd,
[ ... ]
> +void test_xdp_cpumap_rx_csum(void)
> +{
[ ... ]
> +	skel =3D test_xdp_cpumap_rx_csum__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		goto out;
> +
> +	/* cpumap entry without a program: a plain redirect that forces the
> +	 * frame->skb conversion in __xdp_build_skb_from_frame().
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style?

> +	map_fd =3D bpf_map__fd(skel->maps.cpu_map);
[ ... ]
> +	ifindex_dst =3D if_nametoindex("veth1");
> +	ifindex_src =3D if_nametoindex("veth0");
> +	if (!ASSERT_GT(ifindex_dst, 0, "veth1 ifindex") ||
> +	    !ASSERT_GT(ifindex_src, 0, "veth0 ifindex"))
> +		goto out;
> +
> +	/* Native XDP so the redirect goes through xdp_convert_buff_to_frame(),
> +	 * which propagates the rx-csum flag into the frame. Generic mode would
> +	 * redirect a ready-made skb and never hit our code path.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style?

> +	err =3D bpf_xdp_attach(ifindex_dst, bpf_program__fd(skel->progs.xdp_red=
ir),
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c =
b/tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c
> new file mode 100644
> index 0000000000000..86c691887d254
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c
[ ... ]
> +SEC("xdp")
> +int xdp_redir(struct xdp_md *ctx)
> +{
> +	/* Assert the L4 checksum so the skb built on the cpumap redirect
> +	 * path is marked CHECKSUM_UNNECESSARY instead of validated in software.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style?

> +	if (assert_csum)
> +		bpf_xdp_assert_rx_csum(ctx);
> +
> +	return bpf_redirect_map(&cpu_map, 0, 0);
> +}

[Severity: Medium]
Will this unconditionally redirect all packets (including background noise
like IPv6 MLD/ND) to the cpu_map? If the kernel generates asynchronous
background packets when the veth interfaces are brought up, could this
cause the test to be flaky?

> +
> +/* Observe ip_summed exactly as __xdp_build_skb_from_frame() leaves it, =
before
> + * GRO in the cpumap kthread can normalize it. tc-ingress would be too l=
ate:
> + * GRO software-validates a CHECKSUM_NONE skb and marks it UNNECESSARY a=
nyway.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style?

> +SEC("fexit/__xdp_build_skb_from_frame")
> +int BPF_PROG(on_build, struct xdp_frame *xdpf, struct sk_buff *skb,
> +	     struct net_device *dev, struct sk_buff *ret)
> +{
> +	if (ret && ret->protocol =3D=3D bpf_htons(ETH_P_IPV6)) {

[Severity: Medium]
Since the check only looks for ETH_P_IPV6, could this inadvertently capture
background IPv6 noise like MLD/ND packets and short-circuit the test loop in
inject_and_observe() with an unexpected ip_summed value? Might it be safer
to filter for the specific test UDP packet?

> +		observed_ip_summed =3D ret->ip_summed;
> +		seen =3D true;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630191510.8140=
2-1-deliran@verdict.gg?part=3D2
