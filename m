Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10437268D
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309396; cv=none; b=bvdOgT7p8Cwk+i0kfKQho4Kz1vDJNNco6M1UmpvCEKZI90mSK9uwdpLN81QZ2FDekgKL6X6VApV4gRe9HPBXB6/mwQXdrYjx8GWACzrmkQDIQrke3TZC7HUcgTN0rshiHIAFI668/4G/E/iE7Ixco492a3Y9jaztJry71MC23/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309396; c=relaxed/simple;
	bh=2R9b+jXBMvgrNlv8gUvGqWIss/5rE1IUeGS275EQiHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SJQwXi9t09i25My2+ZrABvO/sqyD4dre81LvFrcnaxg2CpfOGL5tCVt/i9nT2d7vOrNuvOA+btbuYV1iAMbXd1Ecn9LJD4tQNEPq2lGWN4Y+llmqrgVJGluv2drnMpkTb30SnJdTQvT88Gn6U1Y9RvTBS91HG0Xa8qVjBMTJV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZewOT3XU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZewOT3XU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992241F000E9;
	Fri, 17 Jul 2026 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309384;
	bh=6gW1CKRX3e9klDVdOTAehZUSwA3ceuHXcIkG3eKOfdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZewOT3XUNrk1sCyaExLBqaDjsPuS4nJsiYAETjL+Ch4isrW/Iz9ZYbBLmrhFgHP+2
	 PQcX7jax9Gvlg8lVtgy8ITcZeVklFtOvZQ1wDD3iSZypAN4DUqFphcL5V1SL7r4BmT
	 D1R1aF5DW4BEfxItmBTmqxbiJ8DFv0evWbBUuhiXcrbkR1a3vL5UGwnRg3zJ8L5qnp
	 j25b1dP+b6V1K8Rdw7pvBuU4xPdy7dpHD2OLD1+lKBMcxxdQrp/OO7cWT2IhV7zFyT
	 8vpF5ciRAGRwwVuEEONBpyV/ujsYQKkzyvDdFc2Fn1Mxw8GCxdpFouaemXYx3Fgn5v
	 1xDKvUJq58gow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] selftest/bpf: added selftest
 sockmap_basic/sockmap recvfrom eagain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717155348.54975-3-nnamdio@gmail.com>
References: <20260717155348.54975-1-nnamdio@gmail.com>
 <20260717155348.54975-3-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:29:43 +0000
Message-Id: <20260717172944.992241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test silently ignores non-EAGAIN errors from recvfrom(), inc=
orrectly treating socket failures or premature EOFs as a test success.
- [Medium] Test suite hangs indefinitely if the receiver thread encounters =
an error during recvfrom() and exits early.
--

--- Patch [2]: [PATCH v5 2/2] selftest/bpf: added selftest sockmap_basic/so=
ckmap recvfrom eagain ---
commit 5b1a8047d6f2573ba61a579d78502e3442c615cc
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

selftest/bpf: added selftest sockmap_basic/sockmap recvfrom eagain

This commit adds a selftest to ensure that tcp_bpf_recvmsg() and
tcp_bpf_recvmsg_parser() correctly handle spurious wakeups in
tcp_msg_wait_data(). It verifies that recvfrom() does not incorrectly return
EAGAIN.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index e5fc038d747b6..c38d1514e2533 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c

[ ... ]

> @@ -1410,6 +1410,117 @@ static void test_sockmap_no_verdict_fionread(void)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +static void *test_sockmap_recvfrom_eagain_thread(void *arg)
> +{
> +	int fd =3D *(int *)arg;
> +	char buf[1024];
> +	void *result =3D NULL;
> +
> +	while (true) {
> +		ssize_t len =3D recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
> +
> +		if (len =3D=3D -1) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +			result =3D (void *)1;
> +			break;
> +		}
> +
> +		if (!len || buf[len - 1] =3D=3D 'e')
> +			break;
> +	}
> +
> +	send(fd, "test", 4, MSG_NOSIGNAL);
> +
> +	return result;

[Severity: Medium]
If the receiver thread encounters an unexpected error (e.g., -1 from recvfr=
om),
it breaks out of the loop and exits without closing the file descriptor fd.

Meanwhile, the main thread attempts to send 25MB of data via a blocking xse=
nd().
Since fd remains open but is no longer being read, the TCP receive window f=
ills
up, and the main thread will block indefinitely in xsend().

Should the socket fd be closed before returning to prevent the test suite f=
rom
hanging?

> +}

[ ... ]

> +		while (rem) {
> +			sent =3D xsend(c, buf + (buflen - rem), rem, 0);
> +			if (sent =3D=3D -1)
> +				goto end_attempt;
> +			rem -=3D sent;
> +		}
> +
> +		err =3D recvfrom(c, ignored, sizeof(ignored), 0, NULL, NULL);
> +		if (err < 0 && !ASSERT_NEQ(errno, EAGAIN, "recvfrom eagain"))
> +			goto end_attempt;
> +
> +		success =3D true;

[Severity: Medium]
Does this logic silently ignore errors from recvfrom() when errno is not EA=
GAIN?

If recvfrom() fails with an error other than EAGAIN, ASSERT_NEQ(errno, EAGA=
IN)
evaluates to true. The logical NOT operator negates this to false, causing =
the
if condition to fail.

The code then falls through to success =3D true, which treats the failure a=
s a
successful test pass.

> +
> +end_attempt:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717155348.5497=
5-1-nnamdio@gmail.com?part=3D2
