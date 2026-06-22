Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5674A23
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130548; cv=none; b=IFpYSjWPTnMtI30r9ADypRn/1+qLdADiIPORdnIwYT1oE3u/HZv3mvbZOB8dCAKeSVFlFtMe3ClzyLPX8XYcDq/YHQ+kSlccKEJfvClb3wsPk0kVlKjmu15y5vxAfcpDXy8eyIkH5j1LJZIFRx+qJIVrJebj4Gw2bNbwtMR0SUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130548; c=relaxed/simple;
	bh=wDZuKN6AqGfIdCc0+dVqy3gPUAcmBCaYKBvPjefUoBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y1b2sSnKAWKQdEBRuJf8eEf+etEMM0O/oG/Z7f1sMB1NZfiG1i2Tx6NDV3W0gHoG3hCu3k3SxZOkad3OTbf53VhNDHO3KxkHrmQQsM5PpMeiRjLEBOwMeVXgT5bMoZz332mVoBRZKlCngzewpqf431S1psi5WQ2k0jrP2wo63lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxJr1z5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxJr1z5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F021F000E9;
	Mon, 22 Jun 2026 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782130547;
	bh=tUrby1LGp958uIQRVB8tOwrXhSmDpuwE6v1nh5xnE6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxJr1z5uaJ32T3Mssd442vW67OqH9VEpTUvINAOL6lcNN2kDlQYAQZgNyECBq/I7n
	 ja0Av9BgelbuJr43pS+vbFKlQy8rkdYSq39QEX12GOgu/LvnACXV6K01FbG1l8qarP
	 t3lIQysu1fjbvVIBScG1SC8KT2aFoQkqdeNRHQl2CyzwUQvpsDtXvuuzEs1RbfiKYo
	 MOYUo7wskdt8fcJCrP1Auy+GYJOYXiN6V1mYsAeArzjVfoDlw70s3HSPdJ29HSY+N8
	 bGnR2chs5DsAVrgJAePrSdAxg3y3demXljvV6Qkh0AW1N4GWXrlhVjFslGEr2Fjxmn
	 VyaVdLVL3omyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 5/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb IPv6 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622120515.137082-6-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-6-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:15:46 +0000
Message-Id: <20260622121547.43F021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling getsockname() with a struct sockaddr_in buffer on an IPv=
6 socket causes address truncation and relies on unsafe type punning.
--

commit 89e403390c4ceaaf94ef22de532a6ce7e24b710b
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests

This commit extends the existing cgroup_skb tests for the bpf_icmp_send
kfunc to include IPv6 support. It updates the test client and server
creation to handle both AF_INET and AF_INET6 families.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
[ ... ]
> -static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int =
code)
> +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int =
code,
> +					    int af, const char *ip)
>  {
>  	int srv_fd =3D -1, client_fd =3D -1;
>  	struct sockaddr_in addr;
>  	socklen_t len =3D sizeof(addr);

[Severity: Medium]
Since this function now handles IPv6 sockets when af is AF_INET6, does using
a struct sockaddr_in buffer for getsockname() cause address truncation?

When getsockname() is called on an IPv6 socket, the kernel will attempt to
write a 28-byte struct sockaddr_in6, but it is constrained by the 16-byte
buffer size here. While extracting the port via addr.sin_port later in this
function coincidentally works because the port offset is the same in both
structures, should this use struct sockaddr_storage instead to safely
accommodate both IPv4 and IPv6 addresses?

> -	srv_fd =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_M=
S);
> +	srv_fd =3D start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
>  	if (!ASSERT_OK_FD(srv_fd, "start_server"))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622120515.1370=
82-1-mahe.tardy@gmail.com?part=3D5
