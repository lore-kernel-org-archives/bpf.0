Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6481AA8
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307709; cv=none; b=icfWP26rNUfi2rjY5/MGXZsN6IYBJHhIUHAhrHYg/QCftANxu0VvSFh0kmxcZ3ZfQYmZr26UHhF8JNJxZE72Dml+yS6fFeOBj+CdjXuIJYjFf5i4rqeDukP/xCTtbkroLeUj0dnJopknUjC5KE7rgJLDRLuwMtENOiXeN/SqBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307709; c=relaxed/simple;
	bh=opy10eTJD+OiAhnMh9ziwoul3VfnYUFnqR7QK6DvHjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2Jvp8FzpTy7vtw8w2QB8zOJ8egAIen1YfPHjHmyTCOSF27PR7nNc8yoNwtPsOu6A0Zl3x46sLqJAgsuPj4JxT0XiE4pe4C7voR5oTzlzIB3PZuQs08aSBz9iqQ7M7+/ijISh8lC1WfOuxS8Mbc9abxFlNzcFim9ZcsUMOlDhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEqJsiuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEqJsiuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CCB1F000E9;
	Fri, 17 Jul 2026 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307706;
	bh=p5+NeK7nWNtIRSR0rs14Xabo+xjn8ugTVUo506aoCFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEqJsiuUQYWhrhEk/SaOq3RYjPJsUII9zqme+ZXZp7ndpnemoz/BDxu6hO74+5pk6
	 RmGgPolBC89Qk12TJMUmulmp8YIDAzcNsM0wPPzrdgWzhjrAYCcd8AKwRKdS8rDTw7
	 SvMNkZDjPhEE+EkoPfJ1a35Rk8BwL6PlzoyaEXcMu+OJPHe+/FsJZf4KQARe831CCu
	 qByYAwrriNd82pEgWt/Nn3HamHSpaYmzHFFkzyDSzrzRAcQ/wAqR/4c28Zf+VFF39o
	 07Is55RbfgJH6A5UzVYcoomlR2DppUrT9IxbKRKZKDjPwXZjmS0/CcaB6L631FGSTm
	 eI2cHOUuCyk2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717155348.54975-2-nnamdio@gmail.com>
References: <20260717155348.54975-1-nnamdio@gmail.com>
 <20260717155348.54975-2-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:01:46 +0000
Message-Id: <20260717170146.A8CCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling recv() with a length of 0 on a BPF sockmap TCP socket with=
 pending data and an error state causes an unkillable infinite loop in the =
kernel.
- [High] tcp_bpf_recvmsg propagates -EFAULT to userspace instead of returni=
ng EOF (0) when encountering a 0-length message (such as a redirected FIN).
--

--- Patch [1]: [PATCH v5 1/2] bpf, sockmap: handle spurious tcp_msg_wait_da=
ta() wakeup ---
commit 27d21b0db0456984003fefcc5f3d8528cdd5ea84
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

This commit fixes spurious wakeups in tcp_msg_wait_data() by looping back
to msg_bytes_ready instead of returning -EAGAIN. It also introduces timeo
pointer passing to avoid excessive waits and ports parser logic over to
tcp_bpf_recvmsg().

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8e905b50deadb..e1c0f8b0930e1 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

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
>  		int data;
> =20
> +		if (sock_flag(sk, SOCK_DONE)) {
> +			ret =3D 0;
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_err) {
> +			if (!sk_psock_queue_empty(psock))
> +				goto msg_bytes_ready;
> +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> +				release_sock(sk);
> +				sk_psock_put(sk, psock);
> +				return tcp_recvmsg(sk, msg, len, flags);
> +			}
> +			ret =3D sock_error(sk);
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +			if (!sk_psock_queue_empty(psock))
> +				goto msg_bytes_ready;

[Severity: High]
This is a pre-existing issue in tcp_bpf_recvmsg_parser(), but this patch
copies the same logic into tcp_bpf_recvmsg(). Does this create an unkillable
infinite loop if the user calls recv() with a length of 0?

If a user waits for data to be queued and ensures an error state is set (for
example, the peer sends a FIN setting RCV_SHUTDOWN), and then calls
recv(fd, buf, 0, 0), sk_msg_recvmsg() immediately returns 0 since len is 0.

The code enters the if (!copied) block, hits the RCV_SHUTDOWN check, and
because !sk_psock_queue_empty(psock) is true, it executes goto
msg_bytes_ready.

Since len is 0, the cycle repeats immediately without releasing the socket
lock or checking for signals, pegging the CPU and potentially causing a
soft lockup. Is there a way to safely break out of this loop when len is 0?

> +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> +				release_sock(sk);
> +				sk_psock_put(sk, psock);
> +				return tcp_recvmsg(sk, msg, len, flags);
> +			}
> +			ret =3D 0;
> +			goto unlock;
> +		}

[ ... ]

> @@ -405,6 +454,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  			sk_psock_put(sk, psock);
>  			return tcp_recvmsg(sk, msg, len, flags);
>  		}
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>  		copied =3D -EAGAIN;
>  	}
>  	ret =3D copied;

[Severity: High]
This is a pre-existing issue, but does tcp_bpf_recvmsg() propagate an
incorrect -EFAULT to userspace when receiving a 0-length message?

If a BPF verdict program redirects a 0-length packet (such as an empty TCP
FIN) to a sockmap socket, it is queued as an sk_msg with sge->length =3D=3D=
 0.

When the user calls recv(), __sk_msg_recvmsg() in net/core/skmsg.c
processes the element, sets copy =3D sge->length (which is 0), and bypasses
copy_page_to_iter(). It then evaluates if (!copy).

Since copy is 0, it triggers copied =3D copied ? copied : -EFAULT, returning
-EFAULT.

Because -EFAULT is not 0, tcp_bpf_recvmsg() bypasses the if (!copied) error
handling block above and directly assigns ret =3D copied, returning the
-EFAULT back to the syscall caller. Should this case return EOF (0) instead
of -EFAULT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717155348.5497=
5-1-nnamdio@gmail.com?part=3D1
