Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9B28690
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788681037; cv=none; b=GS26kFONzOAY2JnrJbd0Cvzryi++02+TJk+4bm8i4+Sy2HJb6SsnZo4TaNCzAgK1qAyM4Y2MXesNFIpzAwLiBtpQ6H8awglbDApv+WusfGVybhPLZHkwd3cNtqJm4fFaBQDq25I3crvhMvwccWNCo/7BeBXhNV6cDnRLDwYz4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788681037; c=relaxed/simple;
	bh=hE3AULDJNnvwny2F+GBwpYF2O+LYmp75OXhdHXSHvBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sxDNFcDrDjfrdTK5MtQK/XYBWOcbzdSAcwmRaYkEM+vMR+9kALl8XY/2/cyhtIfv2wbloAEmt7vTdbt+5klnbc1o7WJ7Ei3VG6nKaVUP7bV6tT5BKFB6Vh72sdGjb7UGdsK5/6RZTfwRhKnTqYGSaxP7/xQVf8XZAgC3YbWaZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b108QIce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b108QIce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED911F00A3A;
	Sun,  6 Sep 2026 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788681036;
	bh=mcqkeJOQmGWEfGCewiknoWj3+1pybwhvO9B3/akQKMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b108QIcemf6mHrhD7d53/mnP1Mbgx3miA0bqmqDrxAdelZq3RhaYINyQs94MlQO8t
	 vxTBrCBm6i/GOwbenkghCqby5yqQq3ksrhgo9Ih7TpMw7zLfgNB+yDtZwHLlW9FnS1
	 C9JCO5ovv/7Dk+d1+JOxyMI1P1J0Ingg9QxZpItWmRJwnD8sw9QSVgmr4zFeNjvUra
	 I3yVHkeptzU1jZ4DfKg8SScDjzwtREXg7yXlzemU4vryVbbfnPdMOyk0xBDH8IYgrY
	 oBYbSY2h4Hg2UZIk+TGYEdvtZ7g3VRhfwAabYxj2UmgpMFY3gpRzwz8Er3NwSLMABA
	 OYdNmO6V1tGaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Test bpf_sock_destroy() on
 TIME_WAIT and listener socks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260906074135.185212-4-jiayuan.chen@linux.dev>
References: <20260906074135.185212-1-jiayuan.chen@linux.dev>
 <20260906074135.185212-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 07:50:35 +0000
Message-Id: <20260906075035.BED911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The file descriptor returned by `accept()` is leaked on the test=
 failure path in `test_tcp_listen_pending()`.
--

commit a0eed787a7f06953fc57cb1d362195f000753ca9
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Test bpf_sock_destroy() on TIME_WAIT and listener socks

This commit adds two subtests to the sock_destroy BPF selftest. The tests
ensure that bpf_sock_destroy() correctly handles sockets in TIME_WAIT and
listener sockets with pending connections in the accept queue.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tool=
s/testing/selftests/bpf/prog_tests/sock_destroy.c
> index 9c11938fe597d..c9f0885709c7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c

[ ... ]

> @@ -110,6 +111,120 @@ static void test_tcp_server(struct sock_destroy_pro=
g *skel)
>  		close(serv);
>  }
> =20
> +static void test_tcp_listen_pending(struct sock_destroy_prog *skel)
> +{
> +	int serv =3D -1, clien =3D -1, n, serv_port;
> +	struct pollfd pfd =3D { .events =3D POLLIN };
> +	char buf[1];
> +
> +	serv =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);

[ ... ]

> +	/* Run iterator program that destroys server sockets. */
> +	start_iter_sockets(skel->progs.iter_tcp6_server);
> +
> +	n =3D accept(serv, NULL, NULL);
> +	if (!ASSERT_LT(n, 0, "accept on destroyed listener"))
> +		goto cleanup;

[Severity: Medium]
Does this code leak the file descriptor on the error path?

If accept(serv, NULL, NULL) unexpectedly succeeds, it returns a valid
file descriptor in n (where n >=3D 0). The ASSERT_LT(n, 0) check then
fails and execution jumps to the cleanup block.

Because n is not closed in cleanup, the accepted socket is leaked.

> +	ASSERT_EQ(errno, EINVAL, "error code on destroyed listener");
> +
> +	/* The unaccepted child was reset along with the listener. */
> +	n =3D recv(clien, buf, sizeof(buf), 0);
> +	if (!ASSERT_LT(n, 0, "client recv on reset child"))
> +		goto cleanup;
> +	ASSERT_EQ(errno, ECONNRESET, "error code on reset child");
> +
> +cleanup:
> +	if (clien !=3D -1)
> +		close(clien);
> +	if (serv !=3D -1)
> +		close(serv);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906074135.1852=
12-1-jiayuan.chen@linux.dev?part=3D3
