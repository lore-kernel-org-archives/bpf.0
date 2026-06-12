Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4837756C
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227577; cv=none; b=Ss8OOqfgckjNUCrCN5N5VXaztjGmK78+tfeu6fa1oUbJfNha6jcro0e/hk1XRGVRv6CuLwYk8GBQbiTOdqxOmsqfomu6GH3Xz5kYXIv+ubBiROjM11oQ25yXxOfGhA0v4CntCN+ZBmgfwQ2OJVhC2emrSsq4d8AWF3EM54h0iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227577; c=relaxed/simple;
	bh=SYFc5W6M7z5v8qPsY83BVZv17S42E4r5qWMcDCBkPYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6bxPgPOAcxnnJWBf+dSUBx6IfXCle7P7XqGDLGkq04Yp5863T2QIVcKoKZBAxPYHbfiS4QKdXlot08cjl67FhDioZfaF1BS6m0qo7ZO0OEnxC4us6kNCGcE2kYkBxw/ZSBXTDCqng7l3uhcWHOvP1ReigDYoXRUOHSlWtm1m+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyPLrZau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyPLrZau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD3D1F000E9;
	Fri, 12 Jun 2026 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781227574;
	bh=pZFu2+M062+c4d+ZZ1vfsYkVDPT0D6vwbNa1gOYGSlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lyPLrZautZvSYpKtMYd/5sUlNdg08ObagcjRPgGY9baqTntWA4x41pPqV+dcRoI/z
	 Rc6WOEq+iTrQqT0jDFI13i+AlB//QSkyLQVfBTxMU/MqUwRcfkWB5895I8MAcsX4xG
	 pBmwVFneev0nevNUkL34G8hcmovY+vZFhFnLdVpGB6ub8JtuYJiq1TPV7GWhKhFl6v
	 INQkHxfQwAK6Z1DU9Frxy9rC9+WzZGBOFk5whbldrKPKAi2FgoStd7Av7n0EnivahT
	 8xdDzwVrE2SyuH7P0YQpFGnaiSEwKYHpUloZAhuogIG7+icsPKhMqY4RQV1IijZ0Gy
	 WObs1GvAjAEfA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 5/5] selftests/bpf: set SO_BUSY_POLL from
 the tcp_splice sockops prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612011452.134466-6-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-6-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:26:13 +0000
Message-Id: <20260612012614.1AD3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The BPF global variable `busy_poll_us` is never initialized by t=
he userspace test runner, rendering the newly added `SO_BUSY_POLL` test log=
ic unreachable dead code.
- [Low] Multi-line comment does not follow BPF subsystem guidelines.
--

commit c9396935bece9a3118a940f3f318b60c9109d778
Author: Cong Wang <xiyou.wangcong@gmail.com>

selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog

Set SO_BUSY_POLL (busy_poll_us) on each paired socket via
bpf_setsockopt() so the splice receiver busy-polls the ring instead of
parking - without net.core.busy_read or an application setsockopt.

> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_splice.c b/tools/=
testing/selftests/bpf/progs/test_tcp_splice.c
> index 09c7f0f9e3110..da43f00046c0f 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_splice.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_splice.c

[ ... ]

> @@ -71,6 +80,21 @@ int sockops_splice(struct bpf_sock_ops *skops)
>  	if (skops->family !=3D 2 /* AF_INET */)
>  		return 0;
> =20
> +	/* Enable busy-poll on this socket. Both endpoints run this callback,
> +	 * so each sets its own socket; this must happen here, before the

[Severity: Low]
This isn't a bug, but the BPF subsystem multi-line comment style requires
the opening /* to be on its own line. Should this be updated to match the
modern kernel comment style?

> +	 * peer-not-found early return below, because pairing is asymmetric -
> +	 * only the second side to establish finds a peer and calls
> +	 * bpf_sock_splice_pair. Setting it only on the pairing side would
> +	 * leave the other side without busy-poll. bpf_setsockopt acts on
> +	 * skops->sk only - there is no variant to set the peer - but the peer
> +	 * sets itself when its own ESTABLISHED callback fires.
> +	 */
> +	if (busy_poll_us) {
> +		int us =3D busy_poll_us;
> +
> +		bpf_setsockopt(skops, SOL_SOCKET, SO_BUSY_POLL, &us, sizeof(us));
> +	}

[Severity: Medium]
Is the global variable busy_poll_us ever initialized by the userspace test
runner?

Since BPF .bss variables are zero-initialized by default, it appears that
skel->bss->busy_poll_us is never assigned a value in the userspace setup
code (like prog_tests/tcp_splice.c). Does this mean the if (busy_poll_us)
condition will always evaluate to false, leaving the new SO_BUSY_POLL logic
unreachable and untested?

> +
>  	mk_key(skops, &self_key, 0);
>  	mk_key(skops, &peer_key, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612011452.1344=
66-1-xiyou.wangcong@gmail.com?part=3D5
