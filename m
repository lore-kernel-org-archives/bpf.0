Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9A2EB5A6
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101969; cv=none; b=n2Ja9DdjA+K3TjV80qYhzQzgTqxkqyJI5Zg8Xuqtvgj+LiM65Sfg+Ni4gkTGfWXjM5RF/gitTFMnHXRhwkH7M4ilYoZpA2RFETsQENvreocCjzV+PTZ/urAjsev/3tZDphI3sS+Y2f7kelW1De2i/UxzPhuq+VH4sA8ZH/vuOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101969; c=relaxed/simple;
	bh=XSJOjzrTG5HnQKC7L12QMalJ3nCRFox/qHo8cXYA6bE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJoiemHESl91qKifkVSmgDw1Bp3SF3IzCTn9ZLdoBaPpyr+vOYW61BV6bHAQ9KkTM9Wcb/UyB3GU0iTUlaWbExN2ueTmKfiXvhSGFyQzN0e4Vww7KATpZMFzg4NVSjb5hHRmX3WtOlkJS2t8WTAyGLAWcx8rvWInpuT9h0a9VOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl1yFUmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl1yFUmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47471F0089C;
	Sat, 30 May 2026 00:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101964;
	bh=G+tEhqRYm6ZNr45pAwPqwJhDJclVTqWvQsvAWUDxmpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wl1yFUmuNa7Y+4uVVIXlzpH4Ufnxq0rlXfT1ILHqfumUoxArKsO+3F0GMSMXTifyB
	 oO5ag4Z6+gMzLeyiVYWv0PZbKomgOWuttq7LEd8lBaI+Rn2QeMIAXMwLlv0NxFUGmc
	 N5HZlSbfDE0dGpRwDNzz/J0ymWHOPVSdMa9vgX1r5zp4Xq6Bwbf7UxQ8/LYUJitBNj
	 GZxb9jXOU2KwGBdFG/qlPI44N5dVlW/z33ft2eUyn6Xacta3XeJ0In+Ws8TBRS4SjG
	 lrbQjsH0yTPi/SnTbu0PzZ7qz92GYirEjuMTVtQjCHuZRTwFypeB93ZNPEXuwVDYp5
	 R5Idch33DUlpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/6] selftests/bpf: Add RX latency tests for
 bpf timestamping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521135244.40869-7-kerneljasonxing@gmail.com>
References: <20260521135244.40869-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:03 +0000
Message-Id: <20260530004603.E47471F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Using a fixed 10ms sleep to synchronize with a kernel workqueue =
introduces a race condition that can lead to flaky tests.
- [Low] Unescaped newline in string literal causes compilation failure.
--

commit fd07aa65d96b1e91b17cb391aadbc4cf4af4b414
Author: Jason Xing <kerneljasonxing@gmail.com>

selftests/bpf: Add RX latency tests for bpf timestamping

This patch extends the test_tcp() functionality to cover the new BPF RX
timestamping path. It adds new assertions, workqueue synchronization, and m=
ixed
timestamping modes to verify SO_TIMESTAMPING and BPF RX can function togeth=
er
without conflict.

> diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/=
tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> index dbfd87499b6b5..e3fe850e4cc70 100644
> --- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> +++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c

[ ... ]

> @@ -143,11 +143,47 @@ static void test_socket_timestamping(int fd)
>  	SK_TS_ACK =3D 0;
>  }
> =20
> +static bool recv_verify_rx_timestamp(int fd, char *buf, int len)
> +{

[ ... ]

> +	if (!ASSERT_TRUE(tss !=3D NULL, "SCM_TIMESTAMPING cmsg present") ||
> +	    !ASSERT_TRUE(tss->ts[0].tv_sec || tss->ts[0].tv_nsec, "rx sw
> +			 timestamp non-zero"))

[Severity: Low]
Does this unescaped newline in the string literal cause a compilation failu=
re?

The error message string is split across lines without a trailing backslash=
 or
string concatenation, which results in invalid syntax in C.

> +		return false;
> +
> +	return true;
> +}
> +
>  static void test_tcp(int family, bool enable_socket_timestamping)
>  {

[ ... ]

> +	afd =3D accept(sfd, NULL, NULL);
> +	if (!ASSERT_OK_FD(afd, "accept"))
> +		goto out;
> +
> +	/* net_enable_timestamp() defers the static key update via
> +	 * schedule_work() when CONFIG_JUMP_LABEL is set. Give the
> +	 * workqueue a chance to run so that netstamp_needed_key is
> +	 * active and skb->tstamp gets populated in the receive path.
> +	 */
> +	usleep(10000);

[Severity: Medium]
Will this hardcoded 10ms sleep cause the test to become flaky?

Using fixed delays to synchronize with asynchronous kernel workqueues can l=
ead
to race conditions. In slow VMs or heavily loaded CI systems, the workqueue
might take longer than 10ms to run, leaving skb->tstamp unpopulated and
causing the test to fail intermittently.

Could a polling mechanism with a reasonable timeout be used here instead?

> +
>  	if (enable_socket_timestamping) {
> +		unsigned int rx_opt;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521135244.4086=
9-1-kerneljasonxing@gmail.com?part=3D6
