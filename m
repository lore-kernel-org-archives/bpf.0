Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3A374E46
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781694; cv=none; b=AQ8jueA3/SKqzXMOhRE9d4PdgAC66nosjx7uU9whocJLpYTrGGA0Eu1J8BOwyf2Wt93mC8KtSskc480v+PJaj7Sfek9Up7NlwIjO1IA/hvbPa0IFk0st0LPJ+T7WhLtArm9GIBXI56bXABcabi4X949ThpBQJuG97SXO7ncUGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781694; c=relaxed/simple;
	bh=3r6l8LnGfmhJ0x91sNFTF3kNUv6l8qKk7CAboicgYro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSMqyzLRr3tTK/HeB9CaYElmDKXzyB36xSuDautra8pCUvh8SQcYUEEPhC6ASe7qbXnBQslEq/thVOUv/1Y/0T30oScTiUasmgoh1aYmJtqWNfI5g5i9X01yH2ELoj3246FTjCSJM/gAanOZQMwLHYLXfGPNMaWPhk5uheLMq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtTeLc1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtTeLc1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B381F000E9;
	Sat, 15 Aug 2026 08:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781692;
	bh=ufc1lF1ElPFBw2DzTL/RPBMd+9mgeKZejJz3BvCCAgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WtTeLc1LedFZHXsNMidpna4mfRjRlDv2NMCJqIJRVqcFnqJV1LrKvWq6fRlGA+81c
	 UHepvLSnSO5Gd8wI8umEU4skRNiyIwZwK7hEcXada/Aiz4uJt/QFuw5PM/uIezAOif
	 oz9WmetHqrvwbaBI9mo4AfiSG0BMe/iy661Yl5+F84i6dw9O9W8VEcTODTs1rosuaK
	 N3nI+KsOkDwxnlnuPOR6xX2F4Hj1tgnD2GDliGtVwO4LSS5WPYlXdpffP+EsinykFd
	 z8UYjRwJWxbZGwOpoVSldLXa9xGf+R5toDyX11bAXn/2J+HZg/B6TJXGPc8MMRMwUO
	 A2fKc+p8TV+iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 07/14] selftests/bpf: Test skb_ext read from
 cgroup_skb and sk_filter hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-7-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-7-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:52 +0000
Message-Id: <20260815081452.A6B381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Implicit truncation of error code to unsigned short masks get_so=
cket_local_port() failure.
--

--- Patch [7]: [PATCH net-next 07/14] selftests/bpf: Test skb_ext read from=
 cgroup_skb and sk_filter hooks ---
commit b524b9baad48611cd0f3fbe2f1b770ea85d7c5df
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext read from cgroup_skb and sk_filter hooks

This commit extends the skb_ext cross-hook coverage to UDP readers. It atta=
ches
a TC ingress program on loopback to write the extension, sends a UDP datagr=
am,
and reads the extension back from a cgroup_skb/ingress program and a socket
filter.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index de60303025361..808eb158fe0f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> +/* Send test_payload over loopback UDP to recv_fd */
> +static int send_loopback_udp(int recv_fd)
> +{
> +	struct sockaddr_in addr =3D {
> +		.sin_family =3D AF_INET,
> +		.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK),
> +	};
> +	char buf[TEST_PAYLOAD_LEN];
> +	int ret =3D -1;
> +	int fd =3D -1;
> +	__be16 port;
> +
> +	port =3D get_socket_local_port(recv_fd);
> +	if (!ASSERT_GE(port, 0, "get_port"))
> +		goto out;

[Severity: Medium]
Will this error check ever trigger if get_socket_local_port() fails?

Because port is declared as a __be16 (an unsigned 16-bit integer), a -1 ret=
urn
value from get_socket_local_port() would be implicitly truncated and conver=
ted
to 65535.

The ASSERT_GE(port, 0, ...) check would then compare 65535 >=3D 0, which is=
 always
true. This masks the failure and allows the test to proceed with an invalid
port.

Should the return value be captured in an int variable for the error check
before assigning it to the __be16 port?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D7
