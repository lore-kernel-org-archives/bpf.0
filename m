Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C88443AA0
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568752; cv=none; b=YgqjNhmxt/pTOq/dImIP7i0a9Ps1Jejm8iKJtVitewAQEKlLw9sYMdGU5/5a86UuvAJhqU6gXNmL6Ri+/9k8jVeQepW7+Ybqqryjbe/74IUkTYrKZLl35g2hPqzdurcSrThIGhiQ11FFX4QP+Oz/qdqcePSl+O+6y4Un/bxuYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568752; c=relaxed/simple;
	bh=mQcZQVpQzhcfrcziomyR/d9+zqs+pE7T3oA7sMqkT3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kLG/oOPb81H7OjwQgJFib/UcszgdagGfhP76iRgOOq9eMuPIybABsr6zurNliFpN1+zcYRdJwWAEZVK1fs6xZfrJFuxbNqnw8GYlwjaq1oAFfIT0B+MHTgqXiOtdMzRkAPvfmh1NV2KX6FXfk1fgpZZO8U5BRr8vqUcgPexrpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je9MlQYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je9MlQYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9796B1F00A3A;
	Mon, 20 Jul 2026 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784568744;
	bh=oxySv3YCWYmKxl4rU262qh4NVb3bQjrJxwiD0fq7Id4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=je9MlQYGyrTfcx8yGBYT9DNAlYdorrodY2l5S8f48I7mZGheUYRP5n9E5ftdGmLW1
	 tBTZPp97oyhCrmUlbyuuA0/eYijljFoN6xIq0ZZfVR0/DxeLdMuc/z6kmLsuGs89cX
	 QJW/rkJAiQVa8i6IoUHAKKXHPgPiPLACaSll5EebSlVQXCuKsOtG76pMfymwWVlztY
	 2Q8eJiwc2OJwbz2mTuOAXeu0VvaL/CmBAKB35OCQj+9gGHWAUpX9Zrhh0+TDdB2C5m
	 dvgRdi7Ogm4pYKDGpHgqq8TImgfH9YylImbgTFCz47QG0Q1kGT522Hn6K13EmLLjOc
	 fseHwjDuqdMfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720171535.67867-2-nnamdio@gmail.com>
References: <20260720171535.67867-1-nnamdio@gmail.com>
 <20260720171535.67867-2-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 17:32:24 +0000
Message-Id: <20260720173224.9796B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Non-blocking reads and signal interrupts bypass the fallback to tc=
p_recvmsg(), breaking read semantics.
- [High] Early return on SOCK_DONE causes data loss and premature EOF.

Pre-existing issues:
- [High] Calling recvmsg() with a length of 0 causes a kernel hang (infinit=
e loop) if data is present.
--

--- Patch [1]: [PATCH v6 1/2] bpf, sockmap: handle spurious tcp_msg_wait_da=
ta() wakeup ---
commit 82673cd18298f61fda976da0ad0dad3a80e2c280
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

recvfrom()/recv() are documented as only returning EAGAIN for blocking
sockets when they have a receive timeout configured. However, adding a
blocking ipv4 tcp socket without a receive timeout to a sockmap will
cause EAGAIN errors sporadically.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8e905b50deadb..e1c0f8b0930e1 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
[ ... ]
> @@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  		}
>  	}
> =20
> +	timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +
>  msg_bytes_ready:
>  	copied =3D __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_se=
lf);
>  	/* The typical case for EFAULT is the socket was gracefully

[Severity: High]
This is a pre-existing issue, but can this loop spin infinitely if a user
calls recv() with a length of 0?

If len is 0, __sk_msg_recvmsg() bypasses its internal loop and returns 0.
The code then enters the if (!copied) branch and calls tcp_msg_wait_data().=
=20
If there is data in the psock queue, the wait queue condition is met
immediately and it returns 1.

The loop then hits the check:

    if (data && !sk_psock_queue_empty(psock))
        goto msg_bytes_ready;

This unconditionally jumps back to the top of the loop, creating a
CPU-spinning infinite loop that could be triggered by an unprivileged
local user. Does this need an explicit check for len =3D=3D 0? (This same
pattern exists in tcp_bpf_recvmsg as well).

[ ... ]
> @@ -386,14 +390,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
>  		return tcp_recvmsg(sk, msg, len, flags);
>  	}
>  	lock_sock(sk);
> +
> +	timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +
>  msg_bytes_ready:
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> -		long timeo;
>  		int data;
> =20
> -		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> -		data =3D tcp_msg_wait_data(sk, psock, timeo);
> +		if (sock_flag(sk, SOCK_DONE)) {
> +			ret =3D 0;
> +			goto unlock;
> +		}

[Severity: High]
Does this early return cause data loss if unread data remains in the receive
queue after a FIN is received?

When a TCP FIN is received, SOCK_DONE is set on the socket. However, this
does not imply the receive queue is empty; valid data received before the
FIN may still reside in sk->sk_receive_queue.

By returning 0 immediately here, we skip the fallback to tcp_recvmsg() which
would correctly drain the receive queue before returning EOF. Can this stra=
nd
and lose unread data?

[ ... ]
> +		if (!timeo) {
> +			ret =3D -EAGAIN;
> +			goto unlock;
> +		}
> +
> +		if (signal_pending(current)) {
> +			ret =3D sock_intr_errno(timeo);
> +			goto unlock;
> +		}

[Severity: High]
Do these early returns break non-blocking reads and signal handling for
sockets that have buffered data?

When MSG_DONTWAIT is set, timeo is 0 and this code returns -EAGAIN
immediately. This completely skips the fallback check later in the function:

    if (!skb_queue_empty(&sk->sk_receive_queue)) {
        release_sock(sk);
        ...
        return tcp_recvmsg(sk, ...);
    }

For a socket added to a sockmap without a verdict program, incoming data
buffers in the standard TCP receive queue. Returning -EAGAIN or returning
due to a signal here bypasses reading that buffered data, which seems to
break read semantics for non-blocking sockets.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171535.6786=
7-1-nnamdio@gmail.com?part=3D1
