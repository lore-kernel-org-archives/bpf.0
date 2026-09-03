Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D844A9D70
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440868; cv=none; b=byHvGVuL/hetVgrto9XU76FN5Yjzj+GtsYA/C1VJ7KwA39SqeC3zq7rQUz2lK7Dgwy8oyrvxFsGcxCQAzqC3KNB5N8sNlasSb8fmg/dJnMROFTuxbC/IOvHhwS0v8YLbG+E5+3mKK4CSMtWKh+r8kY6aAIIReJgZjJ6O9f8tsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440868; c=relaxed/simple;
	bh=xN7HQwxjhw2y4Tlozi3+Ur/Z3MZ0pVZkYpzq8OIIvoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QplNOwJwjQSjeI3xyMczvlnm776bqwtFwULr4EmkihVZU2jYXxnOGnKvbFjG5/fxfFvcUZmAL0YSDFdob27n0tdp/QG22immw/bcRqtuQ5FKhWxgFCTlI4c85dtqd6X+g+iCHB+8J1C/EJ3H6YA8Ki5p9k7OzzfKEiAN81qM6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgOk3lAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgOk3lAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B475B1F00AC4;
	Thu,  3 Sep 2026 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788440852;
	bh=/WWqSvHepxZDiJYSGI97OOFl9rIAsSCFCfLGjAecYVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgOk3lAN5TcbSsl21j0E2SkgAh9RjIpxJZwxfDgNSeAJFbyX+6eOHjghJNjy3+3Gh
	 723lMjkUOJwtZUGsmxdk9zyDOc2BmhYg55r2l1ClzqIYpa/FiJOcNPTx1MYNZnzptE
	 OCO+uk6jJM3/XEMAatHLoIpiGcOzTx2d7NKh+bJY5ggr2ShpEzSpqPseEFnyPgm0TP
	 jI39zz0MikPG0IDRl5X0sEvjtr5w5F8F94RzluUksl0i9ta9CsZFJkZUCuF5B/p9uX
	 enEJ8AblGxfY+TgglOvwOsgyypZz68xEtukBm1YvHQ0vaXNkZc9M1cABDbvppa+FVt
	 0BoGy3WUc0CqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test bpf_sock_destroy() on a
 TIME_WAIT sock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903125306.299943-2-jiayuan.chen@linux.dev>
References: <20260903125306.299943-1-jiayuan.chen@linux.dev>
 <20260903125306.299943-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:07:32 +0000
Message-Id: <20260903130732.B475B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test creates a simultaneous close race condition that will c=
ause it to randomly fail by observing the socket in TCP_CLOSING state inste=
ad of TCP_TIME_WAIT.
- [Low] The multi-line comment uses the incorrect style for the BPF subsyst=
em.
--

commit c91152edb079a3ce44e0f45e8d080efb432c5870
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
Date:   Thu Sep 3 12:52:49 2026 +0000

selftests/bpf: Test bpf_sock_destroy() on a TIME_WAIT sock

This commit adds a tcp_timewait subtest to verify that bpf_sock_destroy()
correctly handles TIME_WAIT sockets. A tcp iterator finds the timewait
socket by its inherited cookie and destroys it.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tool=
s/testing/selftests/bpf/prog_tests/sock_destroy.c
> index 9c11938fe597d..6ccc7cda410bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
[ ... ]
> @@ -110,6 +110,65 @@ static void test_tcp_server(struct sock_destroy_prog=
 *skel)
[ ... ]
> +	/* Active close from the client, then close the server side. Once
> +	 * recv() sees EOF the server FIN has been processed and the client
> +	 * sock is in TIME_WAIT. Block without timeout so a loaded CI box
> +	 * can't race us.
> +	 */

[Severity: Low]
Does this multi-line comment follow the BPF subsystem coding style? The
guidelines prefer placing the opening /* on its own line before starting
the comment text.

> +	if (!ASSERT_OK(setsockopt(clien, SOL_SOCKET, SO_RCVTIMEO, &tv,
> +				  sizeof(tv)), "clear rcvtimeo"))
> +		goto cleanup;
> +	if (!ASSERT_OK(shutdown(clien, SHUT_WR), "client shutdown"))
> +		goto cleanup;
> +
> +	close(accept_serv);
> +	accept_serv =3D -1;
> +
> +	/* block until return EOF */
> +	n =3D recv(clien, buf, sizeof(buf), 0);

[Severity: Medium]
Could this sequence create a simultaneous close race condition that leads to
random test failures?

If shutdown(clien, SHUT_WR) sends a FIN, and the test immediately calls
close(accept_serv) on the server without waiting for the client's FIN to be
processed, the server might send its FIN before receiving the client's FIN.

If these FINs cross (simultaneous close), the client will receive the
server's FIN, enter the TCP_CLOSING state, and wake up the blocking recv()
call. The subsequent BPF iterator would then run while the socket is still
in TCP_CLOSING rather than TCP_TIME_WAIT.

Because the socket is in TCP_CLOSING, bpf_skc_to_tcp_timewait_sock() will
return NULL, causing the iterator to miss the socket and the assertion
ASSERT_EQ(skel->bss->tw_found, 1) to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903125306.2999=
43-1-jiayuan.chen@linux.dev?part=3D2
