Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDA4343F5
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530215; cv=none; b=hASJbWSH7VS/YGSy+rp6+KW3iq4Yowjb792w5pV2ua0QtSKgm0RW8I7jJlX8L5FlZAQCgvBX2atbkDIbAqXjJCqFfXCdUYpxJSjmq1H6Ij1hOtqZn3bv6ehYi3CvDmFhjhBKJ/Az4V2Zqctiwf/PBlIkpD0+DXNPPkBfnMFD5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530215; c=relaxed/simple;
	bh=xQGLW5Pi0cc7Bfs7uUC76YR6e4+36hSwMNmFEIBMrcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rhKpogL+NrfUIdKRJB81+HJ+FjFnOKuoJQrxMrljXtHb6NJ+e06woJDVbxokOcZJGL1up26TiG3rqQUPjcY7sYvwAW5HVeFYAfWO+L8A/OmzFRZGB61DyJj8/fRnOwQIrVpnhJAF0DSFZlV8856VnrDL1UZsWgzluu9znkhjTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZClvitzr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZClvitzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA5B1F000E9;
	Wed,  8 Jul 2026 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783530211;
	bh=e0yl0xC7gEZNPo0oTrO7/otuZVq7g8lHfZIkJ0cGkoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZClvitzrOCnFQTmsqb6pWYEBUwmUbKVbw8EMxN+oMekKjW7J0utZ5myJOwZ5BuWhg
	 ZLqsqgMjvBuYtzKziJs7ypwOVJqpT6EixrxYPAi2fJPkSnOLsy24CWMmkneWSuAs9z
	 dDnNhuePVW+YRrNsEpfH234NyHffHCqFTj59ZiQLPsEZoH1xB/URwRbhfd3DCuWRZo
	 q5HETnelEOJQdh/mCJhTiEKNLktqhBu+3Ib/WleBjZOpqS8IS5cqQfYAcs7DaDk2Re
	 xJDZApWVKk16xMm2DHxvMhMyNWUn4mk/PjZgXyMOlMLxUYHq3My2tfCs9ptTlXWGYb
	 u0y2RzlwXijqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test FIONREAD on a sockmap
 socket without a verdict program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattia Meleleo" <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-fionread-no-verdict-v3-2-b4ee31b3af53@coralogix.com>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-2-b4ee31b3af53@coralogix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:03:30 +0000
Message-Id: <20260708170331.6CA5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The macro `IO_TIMEOUT_SEC` (30) is passed as the `timeout_ms` ar=
gument to `wait_for_fionread()`, resulting in a very short 30 millisecond t=
imeout instead of 30 seconds.
- [Low] Multi-line comment does not follow the strict BPF subsystem comment=
 style.
- [Low] Unnecessary creation and cleanup of an unused socket pair (`c0` and=
 `p0`).
--

--- Patch [2]: [PATCH bpf v3 2/2] selftests/bpf: Test FIONREAD on a sockmap=
 socket without a verdict program ---
commit ef6ce74d985414c924fd029034cc51c133f6ad26
Author: Mattia Meleleo <mattia.meleleo@coralogix.com>

selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program

Add a test validating that FIONREAD on a TCP socket in a sockmap
without a verdict program reports data pending in sk_receive_queue.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93a..f0f368201ddad 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotype)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +/* A socket in a sockmap without a verdict program keeps its ingress data
> + * in sk_receive_queue: FIONREAD must account for it.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the strict BPF
subsystem style guidelines? It appears the opening /* is expected to be
on its own line.

> +static void test_sockmap_no_verdict_fionread(void)
> +{
> +	int err, map, zero =3D 0, sent, avail;
> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
> +	struct test_sockmap_pass_prog *skel;
> +	char buf[256] =3D "0123456789";
> +
> +	skel =3D test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);

[Severity: Low]
Is there a reason to allocate four socket file descriptors here?

It looks like the c0 and p0 sockets are created but never used in the test.
Could create_pair() be used instead to avoid unnecessarily creating and
closing the unused socket pair?

> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
> +		goto out;
> +
> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
> +		goto out_close;
> +
> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);

[Severity: Medium]
Will this result in a flaky test on slow or heavily loaded CI systems?

Looking at the wait_for_fionread() implementation, the third parameter is
timeout_ms, which dictates the number of 1 millisecond sleep iterations:

	while (elapsed < timeout_ms) {
		if (ioctl(fd, FIONREAD, &avail) < 0)
			return -errno;
		if (avail >=3D expected)
			return avail;
		usleep(1000);
		elapsed++;
	}

By passing IO_TIMEOUT_SEC (which is typically 30), it seems the test will o=
nly
wait 30 milliseconds instead of 30 seconds for the packet to traverse the l=
ocal
network stack.

> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
> +
> +out_close:
> +	close(c0);
> +	close(p0);
> +	close(c1);
> +	close(p1);
> +out:
> +	test_sockmap_pass_prog__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-fionread-n=
o-verdict-v3-0-b4ee31b3af53@coralogix.com?part=3D2
