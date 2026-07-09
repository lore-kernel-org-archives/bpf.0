Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234D32E126
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609212; cv=none; b=lQ9X/+Lvhy9sH4/vlPsgHtu3p+eqRambzy4gExsqqCMk2sEKPQdq37trYNRXKzP3baDzhTKi+kllFgJkMYJF3xgiSsYGOOJBdZclkFDLG1EcoER5o2XoFVlO1pg/rjcayNw5VPRUqIFRemgpDfK7B0Dbe2G5OXQgE0lEKSIPU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609212; c=relaxed/simple;
	bh=FUHT+9qUDk5L/feelFpLVfsXmzWMavb3jCG1g9AVsCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zyh3z2IqmrXhijx9UJuj/etqvkbH9L4O5E5rvaJjLpJk0tnPq8Y+Vjk8eCTRSZ2T3ZBfedUN18nj/DeWEEWuwAw28SIPZ946Mj5aYjvNISzmSqcRCn/lt27tudLr011q3JEzu2Q1aetIWAmGSLG/lSoQPXBw6XCWJb9hjGjcafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3gYEuQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3gYEuQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672651F00A3A;
	Thu,  9 Jul 2026 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609210;
	bh=TiJldjKK1fVgDQoMTR/S6hQVZxaj4a0w48MyjyRe57k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3gYEuQRUwIL6z7SQ7QZA3pxOtiCrDGYZFP2BqUHMw6MvX/GpB3wuMUYzTRpavJmk
	 9PDltPJx8Yh2T6LBIGbXfu5pSwtOgDg6sGjkPVqEYxoEzH3evQetsgRB7BB8iSEbIf
	 RzHJQ+5TzRUyyOYiDa5zqWMhUfii91IvUYio71IAlbeifMnLneRU4nQA90fk4ncFIN
	 rPhn3mzmWJ1RJDnpEHqpAwGhZh/pxxPfD2stZM0fh2/KCdXGYP42KDhPJM4DYHLMgW
	 ErZDP+Kfc7PvXLGQ22zh//6X0AbTeUMZbQ+3zPRBZvxfXYKC46nx0S8n/+xyFG5/U9
	 OkvW9Mn066raA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 5/5] selftests/bpf: add bpf_icmp_send no
 route test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709144900.245904-6-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-6-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:00:10 +0000
Message-Id: <20260709150010.672651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The run_icmp_no_route_test subtest suffers from state pollution bec=
ause it fails to reset skel->bss->unreach_code, passing stale or invalid IC=
MP codes to the BPF program.
--

--- Patch [5]: [PATCH bpf-next v11 5/5] selftests/bpf: add bpf_icmp_send no=
 route test ---
commit 43111be9123ff27205045da2a59f2daf8fc9a986
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send no route test

This commit adds a test to verify that the bpf_icmp_send kfunc returns
-ENETUNREACH when a test run is performed on an skb without a destination
route.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index bb532aa0d1580..9318d4bc7ce8b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> @@ -169,6 +169,49 @@ static void run_icmp_test(struct icmp_send *skel, in=
t af, const char *ip,
> +static void run_icmp_no_route_test(struct icmp_send *skel, int af)
> +{
> +	union {
> +		struct ipv4_packet v4;
> +		struct ipv6_packet v6;
> +	} pkt;
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.data_in =3D &pkt,
> +	);
> +	int err;
> +
> +	switch (af) {
> +	case AF_INET:
> +		pkt.v4 =3D pkt_v4;
> +		pkt.v4.iph.version =3D 4;
> +		pkt.v4.iph.daddr =3D htonl(INADDR_LOOPBACK);
> +		pkt.v4.tcp.dest =3D htons(80);
> +		opts.data_size_in =3D sizeof(pkt.v4);
> +		skel->bss->unreach_type =3D ICMP_DEST_UNREACH;
> +		break;
> +	case AF_INET6:
> +		pkt.v6 =3D pkt_v6;
> +		pkt.v6.iph.version =3D 6;
> +		pkt.v6.iph.daddr =3D in6addr_loopback;
> +		pkt.v6.tcp.dest =3D htons(80);
> +		opts.data_size_in =3D sizeof(pkt.v6);
> +		skel->bss->unreach_type =3D ICMPV6_DEST_UNREACH;
> +		break;
> +	default:
> +		ASSERT_FAIL("af_not_supported");
> +		return;
> +	}
> +
> +	skel->bss->server_port =3D 80;

[Severity: Low]
Does this leave skel->bss->unreach_code uninitialized for this test?

Since the run_icmp_no_route_test subtests share the same BPF skeleton as the
previous run_icmp_test subtests, if they run after the ipv6 subtest,
unreach_code is left at 7 (max_code + 1 from testing invalid codes).

For no_route_ipv6, code 7 is passed to the kernel, which is an invalid ICMP=
v6
code (max is 6). The test currently passes only because the kernel's
bpf_icmp_send implementation checks for a missing destination route and ret=
urns
early before validating the code parameter.

Would it be better to reset skel->bss->unreach_code to a valid value here to
prevent test state pollution?

> +	skel->data->kfunc_ret =3D KFUNC_RET_UNSET;
> +
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &op=
ts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		return;
> +
> +	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709144900.2459=
04-1-mahe.tardy@gmail.com?part=3D5
