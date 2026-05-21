Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E21371895
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383676; cv=none; b=UxZlJXjudebVM6DzGwNZhBtpxo05MuRLxniEjbOJ2jts7+MRVTTZtsnk2YQaAx/GFvMj744hsc96rVL7iaSwsLjMXuNobFNeILIK/FkR5yQ2y8HGKPEW7Hf3szp8gR+t/9ktk1q/5re8G1Kuu6hscHahyPnlxd6NVcrmF7rOp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383676; c=relaxed/simple;
	bh=ALwRtFSsVNT9Wt8YdKiuBKuiK6/CPyTgYx/wXMAnrGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSh5+8PeTQ07iDskjz+Ff7HD6ymJj/XrFaSQJIoe3cKiJb1FZutuFRyI0Kt/Gi7TFnHXXwOXIh9jHy52uZrBwE0L08zak93AKrdYb+XqsAzgZawOZio/9xlkgelMHxp8Ixz2qCF+AjY83+rTrpsSmF3tcR1vl2+1PKaOYBVM5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf8lnpyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf8lnpyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511841F000E9;
	Thu, 21 May 2026 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779383675;
	bh=WL+/TQACZIA8FcxLFq9rUsrmwghVzunrKnoaHpKflko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jf8lnpyv+Jj/fuqeI+NMgaoywtwATXyWCdfs+b2m2ScKFZ+vNSGL9WX/BRNMlWgIY
	 bPgow7JDMLFf0agvy96SNli2LHD82J5MAmU+q9lu+jqtox6/h8v3LoRiGp9lIJieJ1
	 y9xJrMeHKNH6NQwxpAVIxjk/cXAEy/jZHznXAOaXKcyd8by+BxyjYlcVC4ACeVQ4oo
	 Wh5JTkwEC9kytPNJ8dAIGHZ+885o7f5YtoEemsVZEmTrKcZ0eKcLwNDaAIM5p8NUz9
	 v9CwAe+TBF+SlPuvPub2Ev1JX6rN+ZOfjYZoHYLiMPb9oN0xWYKDj/t0+OoC0jGKbe
	 /Q+t7DHjJznmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] udp: fix use-after-free in __sk_msg_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521162709.578638-1-dmantipov@yandex.ru>
References: <20260521162709.578638-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 17:14:34 +0000
Message-Id: <20260521171435.511841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Sleeping while holding the socket lock causes a deadlock and d=
enial of service.

Pre-existing issues:
- [High] Delegating blocking receive operations to `sk_udp_recvmsg()` when =
`psock` is empty can cause permanent hangs.
--

commit d6697d072232eff35c98ba1f30c392df860bbf01
Author: Dmitry Antipov <dmantipov@yandex.ru>

udp: fix use-after-free in __sk_msg_recvmsg()

This commit adds socket locking around sk_msg_recvmsg in udp_bpf_recvmsg
to prevent concurrent dequeue/free races.

Closes: https://syzkaller.appspot.com/bug?extid=3D431f9a9e3f5227fbb904
Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -79,6 +79,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  		goto out;
>  	}
> =20
> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);

[Severity: Critical]
Does holding the socket lock during the subsequent blocking operations cause
a deadlock?

It appears udp_msg_wait_data() uses wait_woken() to sleep while the lock
is held, unlike TCP's wait logic which explicitly drops the lock before
sleeping.

Additionally, if the receive operation falls back to sk_udp_recvmsg()
inside the locked section, it blocks inside __skb_wait_for_more_packets().
Since native UDP does not expect the socket lock to be held during receive,
this function also sleeps without dropping the lock.

If a thread sleeps with the socket lock held, incoming UDP packets
processed by softirq are diverted to the socket's backlog queue. The
backlog is only processed when release_sock() is called.

Because the thread is sleeping and never calls release_sock(), the backlog
is never processed, meaning the thread will never receive the packets that
would wake it up.

[ ... ]

> @@ -91,11 +92,13 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;
>  			ret =3D sk_udp_recvmsg(sk, msg, len, flags);

[Severity: High]
This is a pre-existing issue, but does delegating blocking receive
operations to sk_udp_recvmsg() when psock is empty cause permanent hangs?

If psock_has_data() is false, the receive operation is fully delegated to
sk_udp_recvmsg(). If the native receive queue is empty, the thread blocks
inside __skb_recv_udp(), waiting exclusively for data on
sk->sk_receive_queue.

If a new packet subsequently arrives and a BPF program intercepts and
redirects it to the socket's psock, bypassing the native UDP queue, the
socket wait queue is woken up.

However, the wait loop inside __skb_recv_udp() checks only the native
sk_receive_queue.

Finding it still empty, the loop assumes a spurious wakeup and returns to
sleep, completely ignoring the valid data now sitting in psock.

> -			goto out;
> +			goto unlock;
>  		}
>  		copied =3D -EAGAIN;
>  	}
>  	ret =3D copied;
> +unlock:
> +	release_sock(sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521162709.5786=
38-1-dmantipov@yandex.ru?part=3D1
