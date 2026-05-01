Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946735CB73
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661093; cv=none; b=QBhzEiS2jZIMrdkuwikm2iAq2wqdSXDrtjye9kNBi6vw/J/qhVirEvnugf3RiNeaxqK+nStWEY6/DnqJ56nNL7fZDGgpn6ou+R5rmLIirVOw3BH5sAixd5vavDV90OM+2WEjBSkBprmtgWGxZ3LeEyY3HmLylwblkSjtki3d1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661093; c=relaxed/simple;
	bh=K8nHr3DM6NMvbTY+tBkuvX45tVg7Bk5xes8k36A+pZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyJuecZenmQ13cuUR1VWHJidvFEIfqgCt7I7Fsx9BYLfH/Zxr5Frk/DNDctYJKp5/W1TQDmfbkj3X5QlWVn+Aci5ih+Jt6Jk7eeg0hVkJjUNPWjNPPi9omDGfrvv0Gf9jZ8mtdYyyY5ocVbLSS5l0Nm5II8WzYyOb3nuMYa1Ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnzJ3lTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnzJ3lTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68309C2BCB4;
	Fri,  1 May 2026 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661093;
	bh=K8nHr3DM6NMvbTY+tBkuvX45tVg7Bk5xes8k36A+pZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZnzJ3lTat7Cvd78aagxiF1lFZ2d/6dwh7EGKv/YnWnU+19xHlDCACJc9DOMJN1jrY
	 Nsz8T4kTX/F/jGQYbE7lWk0nlbvJMjGCrXegETMRHelJgcWtyluUL2mlAicFe2CGpI
	 h3fvy32Ka3kMVXDlZAgzPHl10+viXqj+sdUNS4h0dfp/e7+By9Cc1cYelNaGoe5ov9
	 fTQ79h0z/fDY+9ELTStmqNNBMvNTzITwhtSgsKKaLNtb+WiQZfeOkzz/CLbYQcilbf
	 SyotwsL+WDwxv6ph76TGRUSh6zdCUbww2bcenvbiiQ4yJFh3b1MHK52gnc54PwK2U6
	 nq5kv+DJG8R9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf 2/2] selftest: bpf: Add test for bpf_tcp_sock()
 and RAW socket.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430184405.1227386-3-kuniyu@google.com>
References: <20260430184405.1227386-3-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 18:44:52 +0000
Message-Id: <20260501184453.68309C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The selftest logic is inverted: it will fail on a correctly fixed =
kernel and pass on a buggy kernel (if KASAN is disabled).
--

commit ba32f094566f3d6a513a47837fc65f3b355951f9
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.

This patch extends sockopt_sk.c to test the behavior of bpf_tcp_sock()
when called on a socket with the wrong type (SOCK_RAW).

> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testi=
ng/selftests/bpf/progs/sockopt_sk.c
> index cb990a7d3d458..5e0b27e7855cb 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c

[ ... ]

> @@ -149,6 +149,20 @@ int _setsockopt(struct bpf_sockopt *ctx)
>  	if (sk && sk->family =3D=3D AF_NETLINK)
>  		goto out;
> =20
> +	if (sk && sk->family =3D=3D AF_INET && sk->type =3D=3D SOCK_RAW) {
> +		struct bpf_tcp_sock *tp =3D bpf_tcp_sock(sk);
> +
> +		if (tp) {
> +			char saved_syn[60];
> +
> +			bpf_getsockopt(sk, SOL_TCP, TCP_SAVED_SYN,
> +				       &saved_syn, sizeof(saved_syn));
> +			goto consumed;
> +		}
> +
> +		goto out;
> +	}

On a fixed kernel where bpf_tcp_sock() correctly returns NULL for a SOCK_RAW
socket, won't tp evaluate to false? This causes the program to jump to the
out label instead of the consumed label.=20

When jumping to out, ctx->optlen is left unmodified, which tells the kernel
to proceed with the native setsockopt handler instead of bypassing it.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/=
testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 53637431ec5de..87e771c8991fc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c

[ ... ]

> @@ -211,6 +211,21 @@ static int getsetsockopt(void)
>  	}
>  	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
> =20
> +	/* Trick bpf_tcp_sock() with IPPROTO_TCP */
> +	close(fd);
> +	fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> +	if (fd < 0) {
> +		log_err("Failed to create RAW socket");
> +		goto err;
> +	}
> +
> +	optlen =3D 60;
> +	err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> +	if (err) {
> +		log_err("Unexpected setsockopt(TCP_SAVED_SYN)");
> +		goto err;
> +	}

If the BPF program falls back to the native handler (because bpf_tcp_sock()
returned NULL on a fixed kernel), the kernel will process this through
raw_setsockopt() and ip_setsockopt(). Since the level is SOL_TCP, doesn't
ip_setsockopt() return -ENOPROTOOPT here?

This would cause setsockopt() to return -1 and err to be non-zero, meaning
the test will fail unconditionally on a correctly fixed kernel.

Ironically, on a buggy kernel where bpf_tcp_sock() incorrectly returns a
pointer, the BPF program hits the consumed label, sets ctx->optlen =3D -1
to bypass the kernel, and setsockopt() returns 0, causing the test to
falsely pass.

Should this test logic be inverted to expect an error (such as -ENOPROTOOPT)
to properly validate the fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430184405.1227=
386-1-kuniyu@google.com?part=3D2
