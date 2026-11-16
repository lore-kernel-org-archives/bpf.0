Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837540;
	b=0BGFFmtLDCDHNaZTHZ6jzC95bnM1RrRqohpMEzLRnuZgCR9A080r+mpgkDjwQshWE/bU
	 XqkqkAGNkJCBkjSAwxZVBUpxPj/fbuaOWG6iJ5rMlgDDTTzt/HhP1H9zgLaaWZ9ihbS7W
	 iqMsB54TL6XT+X+W+oyMxcVOaBLGlR6aBoLzVsCHeL15BQ7vdDiVwsVYXBHeHIgTRZLCr
	 HoN0eNDw5zWRoprGHnmfV5Cn/4prfablWhk7n1oNaror4V3LOS/TvqL8GGFoRoD9oid67
	 etUe8Z8gOvH0nxCacOw8dufjLx3S9Oizkwteu+hwAd3b5HxCUc5RBruedSNppa2CBYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vu9toh12u7Lv/UthPhq34qD9yhrT7ZAWt48XjCyR8ZE=;
	b=kkIP08Gb2Ykg9I94AZqsGTY2jTOExqKtHwWkh2BYWbxuTMz18+4EbQ4XzH1V01k94VnI
	 FQzDf0KNGrHiW2H81zy2yfHy2z3rA6KtxIAPQCc+oJAPXMZZ+vwYs2lkyFUWGRh7LgVUh
	 4Gy7fTPcvYvvRjYg+cMk7wx1c1y7vezDkHt5SrlyPd+OYa9gcfYRg7uhpFlw7CcYwBh49
	 Tkn4ONdeHU8jVFKquOhBuApDdNlDAyDkvv7JbIZ+gu9vxm0FigQyypnoQUmmLVlhH2I0B
	 O3ChkdEAhV/vQiVM5qtLbolAnVvn1JuGRYiPZDdFOeAA0FifpxBd7/6jjzflB2rVCxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgRFhjcr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93D606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgRFhjcr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AC21F000C4;
	Mon, 16 Nov 2026 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837539;
	bh=Vu9toh12u7Lv/UthPhq34qD9yhrT7ZAWt48XjCyR8ZE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dgRFhjcruhel4YrLPs3x8/nwG6HjvwkW8N/kIai2I1M9iuncWj1So6ycgFZab3xkq
	 olVnta6HGpsPz7y5Na6pyuLiOPehT+9ZwH3LkaGyKN2wEK2pFdybnlIepvINgPS6ni
	 YoNY1h7DCDXCVS5Xvqxu4RK1yYColXN91OgC9en3uDaeoAoolrXsoyUfeAfK3jAnBx
	 zYtAQqyk7Jhkseb5L+15wmq+lF0i9iGlhcGFaG2HwtNnrZQ52gI/FRXSBJ8gIgcWDd
	 i0rdm4msURfecu5KGgQYlVod0OVq9kOyUpGM/uFV1R16oZcDUQNfJGyEH2IjLu71pm
	 fL6wHFjBDM1rA==
Message-ID: <sashiko-outbox-217122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8] bpf: tcp: add ecn_init callback to
 bpf_tcp_ops for per-connection ECN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Irlanki Sandeep" <irlanki.s@samsung.com>, bpf@vger.kernel.org
In-Reply-To: <20261116134652.322156-1-irlanki.s@samsung.com>
References: <DM6GLQVDXGWL.1ZV7PCL5B2B0K@gmail.com>
 <CGME20261116134521epcas5p1feade37999749181544983efe729600a@epcas5p1.samsung.com>
 <20261116134652.322156-1-irlanki.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:58:58 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: multi-line comment style in bpf_tcp_ops_ecn.c
--

commit 826a67ec5267cf10887c1bb0ea3883a7cff12093
Author: Irlanki Sandeep <irlanki.s@samsung.com>

bpf: tcp: add ecn_init callback to bpf_tcp_ops for per-connection ECN

This commit adds an ecn_init callback to struct bpf_tcp_ops so cgroup
BPF programs can override net.ipv4.tcp_ecn per connection during TCP
handshakes, along with documentation and BPF selftests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c
> new file mode 100644
> index 0000000000000..077148a6127c1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c

[ ... ]

> +/* net.ipv4.tcp_ecn / ecn_init() values (enum tcp_ecn_mode): 0 =3D=3D no=
 ECN,
> + * 1 =3D=3D accept + request RFC3168 ECN, 3 =3D=3D accept + request AccE=
CN.
> + */
> +static const struct ecn_case ecn_cases[] =3D {
> +	{
> +		/* The sysctl disables ECN; BPF negotiates RFC3168 ECN. */
> +		.name =3D "bpf_enables_classic",
> +		.sysctl_ecn =3D 0,
> +		.retval_active =3D 1,
> +		.retval_passive =3D 1,
> +		.mode_client =3D TCP_ECN_MODE_RFC3168,
> +		.mode_server =3D TCP_ECN_MODE_RFC3168,
> +	},
> +	{
> +		/* The sysctl disables ECN; BPF negotiates AccECN. */
> +		.name =3D "bpf_enables_accecn",
> +		.sysctl_ecn =3D 0,
> +		.retval_active =3D 3,
> +		.retval_passive =3D 3,
> +		.mode_client =3D TCP_ECN_MODE_ACCECN,
> +		.mode_server =3D TCP_ECN_MODE_ACCECN,
> +	},
> +	{
> +		/* The client requests AccECN but the server only accepts
> +		 * RFC3168 ECN (< 3): negotiation degrades to RFC3168.
> +		 */
> +		.name =3D "passive_clamps_accecn",
> +		.sysctl_ecn =3D 0,
> +		.retval_active =3D 3,
> +		.retval_passive =3D 1,
> +		.mode_client =3D TCP_ECN_MODE_RFC3168,
> +		.mode_server =3D TCP_ECN_MODE_RFC3168,
> +	},
> +	{
> +		/* The server refuses ECN although the sysctl allows it. */
> +		.name =3D "passive_refuses_ecn",
> +		.sysctl_ecn =3D 1,
> +		.retval_active =3D 3,
> +		.retval_passive =3D 0,
> +		.mode_client =3D TCP_ECN_MODE_DISABLED,
> +		.mode_server =3D TCP_ECN_MODE_DISABLED,
> +	},
> +	{
> +		/* The client does not request ECN although the sysctl
> +		 * allows it, so there is nothing for the server to accept.
> +		 */
> +		.name =3D "active_disables_ecn",
> +		.sysctl_ecn =3D 1,
> +		.retval_active =3D 0,
> +		.retval_passive =3D 3,
> +		.mode_client =3D TCP_ECN_MODE_DISABLED,
> +		.mode_server =3D TCP_ECN_MODE_DISABLED,
> +	},
> +	{
> +		/* Return values above TCP_ECN_IN_ACCECN_OUT_NOECN fall back
> +		 * to the sysctl on both sides.
> +		 */
> +		.name =3D "fallback_above_range",
> +		.sysctl_ecn =3D 1,
> +		.retval_active =3D 6,
> +		.retval_passive =3D 6,
> +		.mode_client =3D TCP_ECN_MODE_RFC3168,
> +		.mode_server =3D TCP_ECN_MODE_RFC3168,
> +	},
> +	{
> +		/* Negative return values fall back to the sysctl too. */
> +		.name =3D "fallback_negative",
> +		.sysctl_ecn =3D 1,
> +		.retval_active =3D -1,
> +		.retval_passive =3D -1,
> +		.mode_client =3D TCP_ECN_MODE_RFC3168,
> +		.mode_server =3D TCP_ECN_MODE_RFC3168,
> +	},
> +};
> +
> +/* Connect over loopback and accept() the child socket, so that
> + * passive_established is guaranteed to have run: the listener is woken
> + * up only after tcp_rcv_state_process() moved the child to established.
> + */
> +static void do_ecn_connect(int family)

[Severity: Low]
This isn't a bug, but BPF code uses the multi-line comment style where
the opening /* sits on its own line with the comment text starting on
the next line. Could the multi-line comments in ecn_cases[] and above
do_ecn_connect() be formatted that way?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116134652.3221=
56-1-irlanki.s@samsung.com?part=3D1
