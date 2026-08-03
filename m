Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FC3AAF52
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743060; cv=none; b=sf0uRVBTHBXYVwrgp/EuANyXiN1BNTQ+zkcM2UhqNeD/XpHZeyID5+dJTeD04G/LJCtbZo7m+y3bCqt7u3mNnJaEhftNO8f1Cs8PY4G5M3WCn9eSJ1qzq9403xUs2rWbofhhTRirBcLsCxZDsNySQLGmDDfrXO5brjGuifIUB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743060; c=relaxed/simple;
	bh=tSPReXkPZLxrcV+GEsibeY8vQd6DYF+CzV9ofur4EJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tW8X6IZISu/tUVc9IIOKuGryIlSuQnw3qq8HyVmeQrMaaSsH5LxjOSPMdkQt3PWntImT3sQpOop/iV4aleT7oMlFMjOv/vqSdk48sF9HsvMoqVLl10ik7umliactvI/6W6rCYJQOkYM4e0P2N5Su9zJqGYysBVAkZ+dFXpqEA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+tmreFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+tmreFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7F21F00A3A;
	Mon,  3 Aug 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785743059;
	bh=cw7BxN5dnwTrW/vY17AQAuBleaqopO80o5Z7pdUXyzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+tmreFuP2MBgkq2CclaIoXpSbsLt/SSN+cnY6gHk7nyEcihLCyFHSWhgrt/grQLH
	 cU5EPaGr2+2h0hRl5V6VY2kLuOvGzb4v1fHl3jNOQcJHO85kKeEzSquAKpSw6lAugO
	 smZQVrapo/AlbB8QlwfJHynSX4HV9DudZdbn5V7qaLEMGXJJc3xw41uGqVWXWrq4bC
	 6H8sDEbu9UZnQ0LCIkI+t2QJUR0xWVOvPwNBEo+1DES9ANqBXcz0mq//VPM2+CzEWh
	 S7jaNkRV1nHyKMNufPNCJZWzHHI8P43ZKl/VtmHbXozbbuOTMnOxvcZGFU2FzVXU6a
	 H9ZDluTqNqFdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] selftests/bpf: keep polling connection that is
 still in progress
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
References: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 07:44:19 +0000
Message-Id: <20260803074419.7E7F21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `log_err()` prints the wrong error string because `errno` is upd=
ated after the logging call in the asynchronous connection failure paths.
--

--- Patch [1]: [PATCH bpf v2] selftests/bpf: keep polling connection that i=
s still in progress ---
commit 533fe7390970bae0c12d4d1a4c61075dda1b64ff
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: keep polling connection that is still in progress

This commit reduces flaky connection failures in CI by polling sockets that
initially return EINPROGRESS. It uses poll() to wait up to a few seconds
for the socket to become writable. If the connection completes, it checks
the final result via getsockopt() without requiring large timeout increases.

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7d..2f2719a28f026 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -305,13 +309,42 @@ int connect_to_addr(int type, const struct sockaddr=
_storage *addr, socklen_t add
>  		return -1;
>  	}
> =20
> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> +	err =3D connect(fd, (const struct sockaddr *)addr, addrlen);
> +	if (err && errno =3D=3D EINPROGRESS) {
> +		struct pollfd pfd =3D { .fd =3D fd, .events =3D POLLOUT };
> +
> +		err =3D poll(&pfd, 1, CONNECTION_IN_PROGRESS_TIMEOUT_MS);
> +
> +		if (err <=3D 0) {
> +			if (err =3D=3D 0) {
> +				log_err("Connection timeout");
> +				errno =3D ETIMEDOUT;

[Severity: Medium]
Will this log the wrong error string?

Because log_err() automatically incorporates the current errno into its
output, and errno is still set to EINPROGRESS here, this will log an
unexpected error message instead of ETIMEDOUT. Should errno be set to
ETIMEDOUT before calling log_err()?

> +			} else {
> +				log_err("Failed to poll connection status");
> +			}
> +			goto close;
> +		}
> +
> +		errlen =3D sizeof(err);
> +		if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &errlen) < 0) {
> +			log_err("Failed to getsockopt");
> +			goto close;
> +		}
> +
> +		if (err) {
> +			log_err("Eventually failed to connect to server");
> +			errno =3D err;

[Severity: Medium]
Does this code also suffer from the same issue?

Since errno is still EINPROGRESS when log_err() is called, this will print =
the
wrong error reason. Should errno be updated to the socket error in err befo=
re
calling log_err()?

> +			goto close;
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-tc_tunnel_=
flaky-v2-1-657b287dfa75@bootlin.com?part=3D1
