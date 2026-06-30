Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307544B693
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853157; cv=none; b=E1T3QQxcpTr/HW4fqk4e1dWQiII6czdm6pICMxndkKelfNMV2KjZzzRLBovazNoqolZ23IkOhGgVtyeBIr5ui0TjHXTfL2BHsj7ZqCEzAGRgnB1VG8syHyPE2DhVhzTEXCpNbbSg4G9wE9uFoFFT4QUrHVQbR0VCPaqBVd5p2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853157; c=relaxed/simple;
	bh=9g1bcE8R3QSMqMWnuD188pnOLxuyG4kJ4SyviaekoZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0ucJbhq0bDIGbXheCwORMaKe4xHQekRlWCAE8+d7h1AF5KIIV5aDOrWyUQ670R8V+kPL/72WIZPT/G/kI/uHKsmtAw+9YkvYdQ7y9h5maJV3qL+kZiXQQPJHPaDnDdcLAlu8UyqCXG4DUKc3Gg0eLKMhh02lhYkMi1fXl8c+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JboZb6L7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JboZb6L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1EA1F000E9;
	Tue, 30 Jun 2026 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782853156;
	bh=ZC98IbuME/tcMtbCq3l4oAWyZczxXEms4SsjOxD0zNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JboZb6L7vzdmRF9A0ROUujXvjskrnMqq09YrVZmUhpSBkBt1L+ngWAZR3Yg+SC/aD
	 z9sx2VMewV9d4Irm5LUVbxcvgnhxWtJm+6k7hcedANIcl6azzDoOTbbdVoSr3EJr5E
	 MxdQwDNbcBeb13bqOvq6RBYEGHR0A4YoFK5BDbbBTzeeHv98LtrTGr0qhfi0qEEaFm
	 Kn8anWZKWCEmroS3vpD8ucUcQ4s08PP0sD8QgC8FmB44E10AgfjRr4Tel75RRgjxge
	 v5wIZbRQvAwdwsrL/wWtywsNrPbRdrCf6GWN9r+G9hWU0lCsEvjqIw57IvtvxL62bw
	 KO40RwDB0YQ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: test sockmap strparser recover
 with undelivered ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630205043.184894-3-rhkrqnwk98@gmail.com>
References: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
 <20260630205043.184894-3-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 20:59:15 +0000
Message-Id: <20260630205916.0F1EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing file descriptor validation on error paths leading to double=
 closes and invalid closes.
- [Low] Missing payload verification in data delivery test.
--

commit 17a0c6f1d3f82f28804bd94c56f370520016d2dd
Author: Sechang Lim <rhkrqnwk98@gmail.com>

selftests/bpf: test sockmap strparser recover with undelivered ingress

Park SK_PASS data on a stream-parser socket's ingress_msg queue, drop the
socket from the sockmap without reading it, then check the native stack
still delivers data queued afterwards. Without the fix copied_seq is left
behind sk_receive_queue and tcp_recvmsg_locked() warns instead of
delivering.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c

[ ... ]

> +static void test_sockmap_strp_recover_undelivered(void)
> +{
> +	struct test_sockmap_pass_prog *skel =3D NULL;
> +	int c0 =3D -1, p0 =3D -1, c1 =3D -1, p1 =3D -1;
> +	char buf[10] =3D "0123456789", rcv[11];
> +	int err, map, verdict, parser, sent, recvd, avail, zero =3D 0;
> +

[ ... ]

> +	sent =3D xsend(c1, buf, sizeof(buf), 0);
> +	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1) native"))
> +		goto out;
> +	recvd =3D recv_timeout(p1, rcv, sizeof(buf), MSG_DONTWAIT, 1);
> +	ASSERT_EQ(recvd, sent, "recv(p1) native after drop");

[Severity: Low]
Does this test omit verifying the payload?

The test checks the length of the received data but does not seem to check =
the
actual contents. Should there be a memcmp check here to verify data integri=
ty,
as done in other tests?

Also, since 10 bytes are sent twice but the test only attempts to read 10
bytes, does this leave the latter half of the data queued and unverified?

> +
> +out:
> +	close(c0);
> +	close(p0);
> +	close(c1);
> +	close(p1);

[Severity: Low]
Could this cleanup path cause double closes or invalid descriptor closes?

If create_socket_pairs fails early, variables like c1 and p1 (which are
initialized to -1) will be passed to close.

Further, if create_socket_pairs fails on the second pair, it internally
closes the first pair without resetting their descriptors to -1. Would the
unconditional close calls here then trigger a double-close of those
descriptors?

> +
> +	test_sockmap_pass_prog__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630205043.1848=
94-1-rhkrqnwk98@gmail.com?part=3D2
