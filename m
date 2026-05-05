Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380134B697
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954475; cv=none; b=SO5HlI1lx/aYWt135pQi7Di9bBeh/MjRXDMj/MyCJg0X/E4uhu3W3lOxKhxHWLnrp8loBpm7x1uFvqmgq/F6idRprfeIotKaqceja6ESxSQ4lZSYlYgvg7yHJvs/tkdYjhbPQb77f/1c5tC61YjI2HYfxQFhV0L85zS9ST7boR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954475; c=relaxed/simple;
	bh=vGn8Gg1WJJb2+IzaW6Ijakfr1MuiQNRCziUbCmhTi1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hF/7mjBB6JfF/MAA58tzh8hWv59vErQDokXmpoXhovV30dQ7AA+eIR4RZebSB0GjS4CtcV74ZeS495q/Rcd7TcCqT8o2XMl7Q1l6K6bWCz0Y2F1HVrhTcGQXQkajUwYV3XZPvVzZ5YARrKsP4ZzZCwNP7EZg4bUSFNygkjT1xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqj2hNve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqj2hNve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187D0C2BCB4;
	Tue,  5 May 2026 04:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954475;
	bh=vGn8Gg1WJJb2+IzaW6Ijakfr1MuiQNRCziUbCmhTi1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Hqj2hNveMJI3uKSLfc47K2cIKwc7EJehCMKJiZdBV1BREZIs+55O6mZV5a6MPDdv3
	 R0JsjH3VhOsyKyKD6x98U2OmGGCGU4HfGyhHsLL8lPxVI3PlopJxmCXTmZK9RGcrnR
	 3BzyatpqQWy6xsC8bMPt+lo4AjrnLf1r8vtTwJG4j5EpBHiRNIpgtJyJve9mO1SxHc
	 XJHBgdKrAfpCrTYuLYfSEVXx8n/TWsQ629Lf64gCfTaa6SS6XQqzZR025AYfOpe7Du
	 Whb+CFmERXMmIES4KvgPdDPgxkOmnXrruZmGvcEOvDBL3TFMmPWHyJqEWWBEmVE3+j
	 X7WERAZMD7Zxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 3/6] mptcp: bpf: fix type confusion in
 bpf_mptcp_sock_from_subflow()
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504210610.180150-4-kuniyu@google.com>
References: <20260504210610.180150-4-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:34 +0000
Message-Id: <20260505041435.187D0C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] NULL pointer dereferences in bpf_mptcp_sock_from_subflow due to lo=
ckless concurrent accesses
- [High] Use-After-Free in BPF programs returning freed mptcp socket during=
 teardown
--

commit 52dbcdaad7d49ff5db2faacf11c47b1c581024a8
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()

This commit fixes a type confusion issue in bpf_mptcp_sock_from_subflow() by
checking if the socket is actually a TCP socket before calling sk_is_mptcp(=
).
Previously, raw sockets could bypass the IPPROTO_TCP check and cause incorr=
ect
assumptions about the socket type.

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 8a16672b94e2..4cc16cbeb328 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -14,7 +14,7 @@
> =20
>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>  {
> -	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_i=
s_mptcp(sk))
> +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
>  		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);

Could this cause a regression by dereferencing a NULL pointer when accessed
concurrently?

In subflow_ulp_fallback(), icsk->icsk_ulp_data is set to NULL prior to
clearing tcp_sk(sk)->is_mptcp. If a BPF program triggers in this window,
sk_is_mptcp() would return true but mptcp_subflow_ctx(sk) would return NULL,
leading to a NULL pointer dereference.

Additionally, could ctx->conn be NULL when read here?

During subflow_ulp_init(), the context is allocated and is_mptcp is set to =
1,
but ctx->conn is initially NULL. Passing NULL to mptcp_sk(ctx->conn) trigge=
rs
a kernel panic on CONFIG_DEBUG_NET builds. On non-debug builds, it returns a
non-NULL offset pointer, which bypasses BPF verifier NULL checks and causes
invalid memory accesses.

Could this introduce a regression with a use-after-free of the mptcp_sock
during teardown?

During subflow_ulp_release(), sock_put(ctx->conn) drops the reference to the
parent mptcp_sock and may free it. However, ctx->conn is not cleared, and t=
he
subflow context remains valid until the RCU grace period ends.

If a BPF tracing program triggers after sock_put(), could this retrieve
and return the dangling ctx->conn pointer, enabling the BPF program to read
from freed kernel slab memory?

> =20
>  	return NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504210610.1801=
50-1-kuniyu@google.com?part=3D3
