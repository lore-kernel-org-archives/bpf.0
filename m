Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E271277007
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116223; cv=none; b=ZePqDQXCs1RStwDkkF+CoXI0qaZW7wdjhFJa+bZX8rqMnbm2dj8Ip98+h2ZpHm+hm4BXmiiOXImb6ei6opLpArk3/c9J/LCmG5h5KgyXe4d7c+p1eLSwCYP2dCdTOB2dpqqsyC55B404pMnJ3ol+sYVeHnicQWOaWC/v4OVN2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116223; c=relaxed/simple;
	bh=VzMbANpaeTZBGGDih/782h7skbKGzfaD+8e3kxnN93A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAzM5juRj+DsbeGxlmuP3e4rsERtpNQTuehj783Jt4MMBudCCBMuLJoN5KX0BSCrTQ11+7m7HRay2ZpqfLrfu+B/OrOYXWACq5TU7F3IxMARigtczbA25VH5ZLynk0dKnEOVNsuuGl5PGvZdzkqhdm9/sFqeNzsmo2rCEq4uCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPF85N/I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPF85N/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D99AC2BCB7;
	Mon, 18 May 2026 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116223;
	bh=VzMbANpaeTZBGGDih/782h7skbKGzfaD+8e3kxnN93A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vPF85N/Iz7tUmyYMFB/oViPIQj/H5nZy6mB34FC09BXA+ew1EM5yGtPIif7iWxzTF
	 b9Lo+mK65tD/z1HKj2iQq/wxG6ychTIWk/tw3hgMeftUc98MEx9ixvK+/t/ErQKf/k
	 iG3+nFa/8dEEnKz52lJoZMPuGY8dptDyt4eNVdQ2+YnRAevzExUEt9Cdk3KC4q0H5i
	 uOa56dIr34hIJXzNeucfj6HNPCMQiu5T+hb/h4gsFwMy6/lJZIbCoifuKvpKEZ4FE1
	 fcdV/1rIq5bmJB+K8/EDEAP53RV3cA5HApdxFsu+rCp2o5D4dwgF0afSbUf7Pm0Q39
	 rXrIaXfYANaIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/2] bpf, skmsg: fix verdict sk_data_ready racing
 with ktls rx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xingwang Xiang" <v3rdant.xiang@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517145630.20521-2-v3rdant.xiang@gmail.com>
References: <20260517145630.20521-2-v3rdant.xiang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 14:57:01 +0000
Message-Id: <20260518145702.4D99AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Concurrent sockmap deletion causes a deterministic NULL pointe=
r dereference and kernel panic.
- [High] Type confusion leading to out-of-bounds reads and BPF verdict bypa=
ss due to blind ULP context cast.
--

commit 99c04859dba221cd63c5238a47d1833983548f83
Author: Xingwang Xiang <v3rdant.xiang@gmail.com>

bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

sk_psock_strp_data_ready() already checks tls_sw_has_ctx_rx() and
defers to psock->saved_data_ready when a TLS RX context is present.
This patch applies the same logic to sk_psock_verdict_data_ready() to
prevent a use-after-free caused by tcp_read_skb draining the queue
without advancing copied_seq.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 6187a83bd7411..e1850caf1a71a 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1268,12 +1268,19 @@ static int sk_psock_verdict_recv(struct sock *sk,=
 struct sk_buff *skb)
>  static void sk_psock_verdict_data_ready(struct sock *sk)
>  {
>  	const struct proto_ops *ops =3D NULL;
> +	struct sk_psock *psock;
>  	struct socket *sock;
>  	int copied;
> =20
>  	trace_sk_data_ready(sk);
> =20
>  	rcu_read_lock();
> +	psock =3D sk_psock(sk);
> +	if (psock && tls_sw_has_ctx_rx(sk)) {

Is it possible for tls_sw_has_ctx_rx() to cause a type confusion regression=
 here?

tls_sw_has_ctx_rx() calls tls_get_ctx(), which casts icsk->icsk_ulp_data
to a struct tls_context pointer. If a socket has a different ULP configured,
like espintcp, and is attached to a sockmap, icsk_ulp_data will point to a
different structure like espintcp_ctx.

Reading from this mismatched structure could yield garbage data. If that
data is non-zero, the code might falsely assume a KTLS RX context is active
and incorrectly skip the BPF verdict program.

While this problem already exists in sk_psock_strp_data_ready(), does this
change spread the same issue to the verdict path?

> +		psock->saved_data_ready(sk);

Can this lead to a NULL pointer dereference regression during concurrent
sockmap deletion?

sk_psock_verdict_data_ready() executes here without holding
sk->sk_callback_lock. If userspace concurrently removes the socket from the
sockmap, sk_psock_stop_verdict() will be called, which explicitly sets
psock->saved_data_ready to NULL.

Since this code doesn't hold read_lock_bh(&sk->sk_callback_lock) or check if
saved_data_ready is NULL before calling it, could it execute the newly null=
ified
pointer and cause a crash?

I notice this vulnerability already exists in sk_psock_strp_data_ready(), b=
ut
does this duplicate it into the verdict handler?

> +		rcu_read_unlock();
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517145630.2052=
1-1-v3rdant.xiang@gmail.com?part=3D1
