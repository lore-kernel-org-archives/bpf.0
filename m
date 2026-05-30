Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9B1D54FA
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101965; cv=none; b=YE1oGvUF72OKGenZJEJzWa49QYdNNnTCTI9kxJuVOei6eCpqMbHAKE1JHeKk4MIDmDda+frJ90yUtvmcSgcSfoSp763sGnDbnasL8GV5Sh1jltmH9lKtrCCJxhcz1cZdpkUrUE/Q5muPRtxTSN++AfVb5VMml4ZBZ5TJ4EmoU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101965; c=relaxed/simple;
	bh=wDhDdg8yM39HEHNQOlaSiiKgLBjaRiGsK1yd2Afs6Dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gMBwFZdsLBbLNwsX45x/lOwk/iSCDJjg6BIFtnUoI2z6D5SYKp/Pj1Iv2qAGXQYnP8j+zIOfCo3L2HAK8R5gO+TCQj5w/A7RigidEdWVSNimeOENxLniY+9ekghUNWoANtnETMQUj0fP8mpGNYs56bd9BaYSn9xNQLlRr8iKKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqXeJppu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqXeJppu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1951F0089A;
	Sat, 30 May 2026 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101962;
	bh=zrg5cYKz5DjKD30ZopTLs7tZubBv6nGDtWb0RydFiUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqXeJppuntJPUAf4Agh9E3BaXa6qQ1L8BysdRw4/vB+IhwMYPGIqRRBCPCxRrwVZ/
	 Ly/xRaunVoQUOBpAY9EpLmAKBv+8WX3NBEMFexEas+64g0GTqw+PIbQAUj8kk2+plo
	 A+s4s8j9uNdqQCfT3n3naGCw4WE9c8zw9T57j4oC7vrzBB/i3XHlTo73eSJIbYkhnb
	 pCn8jH7jJ9eHOoDqPLv69B78GJLj0c8K/ltueFjB2LAJb7c7OsOuitdqFH3gUv22Mx
	 vXbp7KKVjYu+P/9KvegXxtJbzHmgp4jJYGq0py2CiqDvMGmqH6q9Ljao7Y7Ydl2y8w
	 oQMxGRKmEn+aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: export sock_disable_timestamp()
 declaration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521135244.40869-3-kerneljasonxing@gmail.com>
References: <20260521135244.40869-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:01 +0000
Message-Id: <20260530004602.5C1951F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Lockless modification of `sk->sk_flags` from a BPF context wil=
l race with user context socket modifications, corrupting critical socket f=
lags.
- [High] Concurrent lockless calls to `sock_disable_timestamp` result in a =
Time-of-Check to Time-of-Use (TOCTOU) race that unbalances the global times=
tamp reference counter.
--

commit 070236e8d76283be57936f36bb4d9ae98296d6e1
Author: Jason Xing <kerneljasonxing@gmail.com>

net: export sock_disable_timestamp() declaration

This commit removes the static label from sock_disable_timestamp() and
exports its declaration. This change allows the BPF timestamping RX feature
to dynamically turn off the global time record function.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index f362e3ce1efb6..f3d78da3aeba3 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *sk)
>  	}
>  }
> =20
> -static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
> +void sock_disable_timestamp(struct sock *sk, unsigned long flags)
>  {
>  	if (sk->sk_flags & flags) {
>  		sk->sk_flags &=3D ~flags;

[Severity: Critical]
Since this function is being exported for use by the BPF timestamping rx
feature, will it be called from a lockless context?

If the BPF_SOCK_OPS_TSTAMP_RCV_CB hook calls this outside the socket lock
(for instance, after tcp_recvmsg() drops lock_sock(sk)), this non-atomic
read-modify-write of sk->sk_flags could race with user context socket
modifications like setsockopt().

Could this concurrent access cause torn reads and writes, permanently
corrupting sk_flags and potentially leading to use-after-free issues if
lifecycle flags like SOCK_DEAD are lost?

[Severity: High]
Could exporting this for lockless BPF contexts also result in a Time-of-Che=
ck
to Time-of-Use race that unbalances the global network timestamping referen=
ce
count?

If multiple threads execute recvmsg() on the same socket concurrently witho=
ut
the socket lock, they might both evaluate "if (sk->sk_flags & flags)" as tr=
ue,
clear the flags, and then subsequently call net_disable_timestamp().

Would this double-decrement unbalance the global counter and prematurely
disable network timestamping for all sockets on the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521135244.4086=
9-1-kerneljasonxing@gmail.com?part=3D2
