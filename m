Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539F30C179
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260087; cv=none; b=rqacXyISl5vkJy4YjcA2XJuxEY7AbL++GVkbV4GVatgffBj14FZk4uW+vlZF75gVXMk+oiibuTCsKqv7rk1I2hbZ9TlWZ+ZsPsNTStFJpEB8aNFWLQ/VFc4DaasF47cPkMIlnfDOxTd2MCqxdcczufqpttBjFnXG0IH/zLYK3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260087; c=relaxed/simple;
	bh=fjKt2HdhvbSBPGiISfodMMx0DVymbKvVL0jpyoRgz/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJagEBTIthhl1luDLxvKipY53TcKqQjtwowvyjwgTf5rxcouaGpHjfHE3nA8dDy2JGDXLTdzMcYgAS1DU9ISA5fbDfSgKRWATpOGdlFaWQMTeIrwrT05GSUnEbsOIZcJ049Ls7l9w0qlW0KvPhMWaaVkYgAaQ3S1SC9upU3BISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjAffWr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjAffWr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE70D1F000E9;
	Wed, 24 Jun 2026 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782260085;
	bh=P+zSfZVg9tp/avDQb88wwpiAp8HE2eNjK2r+dePURZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YjAffWr2v7iFZcRiZkWAeVpjfR5pV5sQBK0Mwd4hohzf6T0yzUf4UN/UetI754/0c
	 2/0Oh/6iWXZO3fhtco5/6UJeJu3RLHBU74fRMfZL534o0qfWH2zNn5Cyp7hNdY2tmG
	 aKGByMvIk3sj7uusL8tcxO95mHJ+0ZYN6ypzZDq2Lz2C+rwW+0SQHTT1FArmMuZNFn
	 2vAYsQpO+aR+GxDaAH97cuIAC6Y1Ks4/S01dDa6VS71MSktyEL1YArefhhWrCFHAyV
	 V3LCW3pizqU/5/2VNFAxTKT1GDFYOveT/Y2l8IrdpmwOybmheDNavb4G6XG/IXtaEW
	 rmm/hU7wGqp6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 15/15] selftests/bpf: Add test for
 bpf_tcp_ops header option hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-16-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-16-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 00:14:45 +0000
Message-Id: <20260624001445.AE70D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unchecked ASSERT_EQ failures on blocking sockets can cause the t=
est suite to hang indefinitely.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
--

commit a1c417fa7da14f2f4f18705173e644ec97f1f5c8
Author: Amery Hung <ameryhung@gmail.com>
Subject: Add a test exercising the bpf_tcp_ops parse_hdr, hdr_opt_len and w=
rite_hdr_opt members together with the header option helpers.

This commit adds a new BPF selftest that verifies the behavior of TCP header
option struct_ops callbacks and their associated helpers. It uses a
cgroup-attached program to reserve, write, and parse custom TCP header
options during socket communication.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
> new file mode 100644
> index 000000000000..73e34d2be9a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c

[ ... ]

> +static void send_recv(void)
> +{
> +	char buf[64] =3D {};
> +	int server_fd, client_fd, accept_fd;
> +	ssize_t n;
> +
> +	server_fd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server"))
> +		return;
> +
> +	client_fd =3D connect_to_fd(server_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
> +		goto close_server;
> +
> +	accept_fd =3D accept(server_fd, NULL, NULL);
> +	if (!ASSERT_OK_FD(accept_fd, "accept"))
> +		goto close_client;
> +
> +	/* Exchange data both directions so option-bearing data packets
> +	 * are sent and parsed on each side.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the BPF subsystem
coding style? The BPF guidelines specify that the opening /* should be on
its own line.

> +	n =3D send(client_fd, buf, sizeof(buf), 0);
> +	ASSERT_EQ(n, sizeof(buf), "client_send");
> +	n =3D recv(accept_fd, buf, sizeof(buf), 0);

[Severity: Medium]
If the send() call fails, ASSERT_EQ will log a failure but execution will
fall through to recv(). Will this cause the test suite to hang indefinitely
waiting on the blocking recv() call?=20

Should the return value of ASSERT_EQ be checked (e.g., using an if statemen=
t)
to prevent the test from hanging on local socket errors?

> +	ASSERT_EQ(n, sizeof(buf), "server_recv");
> +
> +	n =3D send(accept_fd, buf, sizeof(buf), 0);
> +	ASSERT_EQ(n, sizeof(buf), "server_send");
> +	n =3D recv(client_fd, buf, sizeof(buf), 0);
> +	ASSERT_EQ(n, sizeof(buf), "client_recv");
> +
> +	close(accept_fd);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/=
testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
> new file mode 100644
> index 000000000000..46618a604d96
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

[ ... ]

> +SEC("struct_ops")
> +void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
> +	      struct request_sock *req, struct sk_buff *syn_skb,
> +	      enum tcp_synack_type synack_type, unsigned int *remaining)
> +{
> +	hdr_opt_len_cnt++;
> +
> +	/* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. Stacks
> +	 * with other progs in the cgroup hierarchy.
> +	 */

[Severity: Low]
This isn't a bug, but should the opening /* be placed on its own line here=
=20
and in the other multi-line comments in this file to match the BPF
subsystem comment style?

> +	bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D15
