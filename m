Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED233CA4BB
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152036; cv=none; b=LcYfG8I/M3LDNArWIxHaGwKuVRQm62SAT7kJga0f09zWvs28HMRA4fAuvVg/EEfNihkdjQQYlqB6gGq0mExtPanC8OIHRx7FR/b6Hp+HWB9AF2gRcJST7EjRTR/3vbKA/NcSl8gJ42W9fG5YgwP9xe2YbIKMpjmL9JrTU1Tl+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152036; c=relaxed/simple;
	bh=EM9H+0uo2o6e/bmohYGZuvifJFIsvbKCH98d0noV1GE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cxe/sUF4qX3Kay+I77h1gta7OZdhUrgUDuE9PbftvwivVV+wUwZDQ8mJhi4FwlnislK48Z0i4rNAjy89dDfDLw91pUUgdZ0gfsUw8vAyV5nEHiwPwzxLV1CdW/cCP0Rir6yTMALS5GrVVPvZp/lfigmRGmzu0cKzUR/WG2i+o6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnJxcpAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnJxcpAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518671F00A3A;
	Wed, 15 Jul 2026 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152029;
	bh=IpvoQSzd5iV2txM40z22MuR9k/L+bbdsWakBsoExD5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HnJxcpAPMNe1TqlCSZf4RbiK7EeJT2mwtS8dQ9MqaiSPvW4BqXMo/VM+QHQTuR23T
	 5jMN2VL57Y097+WtN6tK7pGPink8UQioInlF28JD0J6ypzaj6ekhVBqhSPN/Hp2ySE
	 nJtntcWitjafbizzoOsxxe61rpntrjdzxhQyHWApi3HQ2aGx1si1/+dmV/S8fmD3JF
	 BqaOo+xIixvFYQU4vlOYUr0Lc3Ynt0f53WRc1qE7ax6v9TxhXS/00MRCIZwvlJuxvL
	 zZS+vnKp4bQpCjo04BlrtuqVHkr2ImTIGRzFmMj2GHBFR39/oxy4QmiFu7ZasHSvf4
	 pHF17cFsOn1RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715213538.37229-3-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260715213538.37229-1-nnamdio@gmail.com>
 <20260715213538.37229-3-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:47:08 +0000
Message-Id: <20260715214709.518671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flaky test assertion due to jiffy-based timeout resolution.
- [Medium] Infinite busy-loop in server thread on fatal socket error.
--

--- Patch [2]: [PATCH v4 2/2] bpf, sockmap: handle spurious tcp_msg_wait_da=
ta() wakeup ---
commit f1fdd86e116d5c194a4d7e31256e4a2e38d105e0
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

This commit adds a selftest to ensure tcp_bpf_recvmsg() and
tcp_bpf_recvmsg_parser() correctly handle spurious wakeups in
tcp_msg_wait_data(). It verifies that recvfrom() doesn't return EAGAIN with=
out
a timeout and properly respects SO_RCVTIMEO when configured.

> diff --git a/tools/testing/selftests/net/sockmap_recvfrom.c b/tools/testi=
ng/selftests/net/sockmap_recvfrom.c
> new file mode 100644
> index 0000000000000..25657fc3dbcd2
> --- /dev/null
> +++ b/tools/testing/selftests/net/sockmap_recvfrom.c

[ ... ]

> +static void process_client(int fd, atomic_int *running, bool *failed)
> +{

[ ... ]

> +	while (atomic_load(running)) {
> +		ssize_t len =3D recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
> +
> +		if (len =3D=3D -1) {
> +			if (errno !=3D EAGAIN && errno !=3D EINTR)
> +				*failed =3D true;
> +			continue;

[Severity: Medium]
Will this result in an infinite busy-loop if a fatal socket error occurs?

If recvfrom() encounters a fatal error like ECONNRESET, *failed is set to t=
rue
but the loop continues. Since the socket remains in an error state, subsequ=
ent
calls to recvfrom() will immediately return -1 without blocking.=20

This creates a tight busy-wait loop that starves the CPU until the global t=
est
timeout intervenes. Should this break out of the loop on fatal errors inste=
ad?

> +		}
> +
> +		if (len <=3D 0 || buf[len - 1] =3D=3D PAYLOAD_END)
> +			break;
> +	}

[ ... ]

> +TEST_F(sockmap_recvfrom, with_timeout)
> +{

[ ... ]

> +	for (int i =3D 0; i < MAX_ITERATIONS; ++i) {
> +		struct timespec beg;
> +		struct timespec end;
> +		int err;
> +
> +		int fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +
> +		ASSERT_NE(fd, -1);
> +		ASSERT_EQ(connect(fd, (struct sockaddr *)&self->addr, sizeof(self->add=
r)), 0);
> +
> +		ASSERT_EQ(send_payload(_metadata, fd, self->payload, self->payload_len=
), 0);
> +
> +		ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo=
)), 0);
> +
> +		clock_gettime(CLOCK_MONOTONIC, &beg);
> +		ASSERT_EQ(recvfrom(fd, ignored, sizeof(ignored), 0, NULL, NULL), -1);
> +		err =3D errno;
> +		clock_gettime(CLOCK_MONOTONIC, &end);
> +
> +		ASSERT_EQ(err, EAGAIN);
> +		ASSERT_GE(to_nanos(&end) - to_nanos(&beg), timeo.tv_usec * 1000);

[Severity: Medium]
Is it safe to assume strict microsecond precision for SO_RCVTIMEO here?

The test expects the blocked duration to be strictly greater than or equal =
to
5ms. However, in the kernel, socket timeouts are converted to jiffies via
sk_rcvtimeo.

On systems with HZ=3D100, 5ms translates to less than a jiffy. Even on HZ=
=3D1000,
waiting 5 jiffies can complete in slightly over 4ms depending on tick
alignment.=20

Because the test demands strict microsecond accuracy from a jiffy-based tim=
er,
could this cause intermittent test failures?

> +
> +		close(fd);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715213538.3722=
9-1-nnamdio@gmail.com?part=3D2
