Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98193E16B6
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179116; cv=none; b=noVmDhGxXl7WJAG2NwBUkzwd58uAIdE/Jf50InxACZVFY2Rn+GpdU/jWaBDzGO6TcVOES+svYEkIrXPjoCveZP0hi3rIho10OH0SGKmyoaOz7JnO6y3osXHuMulVTCfVdK9olkG30VWOWhr0SkHORJLtviE2Dln7QjewnOKcpHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179116; c=relaxed/simple;
	bh=BgY5uvwCwE0cUj3YRFfGaUEGJQp0tsLv3EsgGIrGanQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gFSm6ImzTKCCpInh4jQJvYkygl+QKpftNjh3Uf5g9zelj13ODc7uYHgflOhvWP6vpqykvSaRTWhuiVlQnQGAMcLBpXPkJZkLcaLSTGyxpZF8WSJhTFObO4YB9rqp60VgzvchiozQm+QADXRJvBjqPh2qIkp3SCts4X92PJpLbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDXYQeJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDXYQeJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF651C2BCB3;
	Tue, 19 May 2026 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179115;
	bh=BgY5uvwCwE0cUj3YRFfGaUEGJQp0tsLv3EsgGIrGanQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GDXYQeJEZXAMqfs0fr0A8xxi1r+lsEnCXeOY9Ww8CZs1U3Mlcj7hU3yqf3MEfTMmo
	 +e5FDwVhHKPKpPlDKiXMN5K/UgvOJ46sqWgWd5tnne5NLI1tBNPi0qUnrhQRmD4p63
	 yFrLJ+C8cVmb/ixJCce3NaE9kIpcFU+T2vuZ/IL/HerFjV2kt9mMiFwJKSjKzusFvs
	 2+hAG07iibqSYOFFv1NAOriAag0zreC5vAMuzyEo7mVXquCYAHpj2aJb4ivGQjSupj
	 gtH2r1YfI5J24d+5b4XXR3MCyTDSLDu2HLsl8MHs5XnhzkIQqgR+ZeZq6gM8VPNN2X
	 xf2hPbE7QBUFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/6] selftests/bpf: Add RX latency tests for
 bpf timestamping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518082344.96647-7-kerneljasonxing@gmail.com>
References: <20260518082344.96647-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 08:25:15 +0000
Message-Id: <20260519082515.AF651C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The return values of `ASSERT_TRUE` are ignored in `recv_verify_r=
x_timestamp`, causing it to unconditionally return `true` on successful `re=
cvmsg`.
- [Medium] Using a fixed `usleep(10000)` to wait for a workqueue to run is =
prone to test flakiness on heavily loaded CI systems.
--

commit 3f1fdeab36943dce908082eb563628a5f8ca353b
Author: Jason Xing <kerneljasonxing@gmail.com>

selftests/bpf: Add RX latency tests for bpf timestamping

This commit extends the test_tcp() selftest to cover the new BPF RX
timestamping path. It tests a mixed mode where SO TX/RX and BPF TX/RX
timestamping operate simultaneously, verifying they do not conflict.

> diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/=
tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> index dbfd87499b6b5..3cc52b670e74b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> +++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c

[ ... ]

> @@ -143,11 +143,45 @@ static void test_socket_timestamping(int fd)
>  	SK_TS_ACK =3D 0;
>  }
> =20
> +static bool recv_verify_rx_timestamp(int fd, char *buf, int len)
> +{

[ ... ]

> +	for (cm =3D CMSG_FIRSTHDR(&msg); cm; cm =3D CMSG_NXTHDR(&msg, cm)) {
> +		if (cm->cmsg_level =3D=3D SOL_SOCKET &&
> +		    cm->cmsg_type =3D=3D SCM_TIMESTAMPING) {
> +			tss =3D (void *)CMSG_DATA(cm);
> +			break;
> +		}
> +	}
> +
> +	ASSERT_TRUE(tss !=3D NULL, "SCM_TIMESTAMPING cmsg present");
> +	ASSERT_TRUE(tss && (tss->ts[0].tv_sec || tss->ts[0].tv_nsec),
> +		    "rx sw timestamp non-zero");
> +	return true;
> +}

Since the return values of ASSERT_TRUE() are ignored here, will this
function unconditionally return true even if the assertions fail?

If the caller expects a false return to abort early, this could cause the
test to proceed regardless of the assertion results.

[ ... ]

> @@ -187,7 +221,27 @@ static void test_tcp(int family, bool enable_socket_=
timestamping)

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

Could this fixed 10ms sleep cause test flakiness on heavily loaded CI
systems?

If the workqueue is delayed for longer than 10ms, the static key might not
be active in time, which would leave skb->tstamp unpopulated and cause the
test to fail intermittently.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518082344.9664=
7-1-kerneljasonxing@gmail.com?part=3D6
