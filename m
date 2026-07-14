Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7F42BC28
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062279; cv=none; b=guiVxycSXD5YQAk/KXYl79wpdqsQEV95GAiVGewn4tgv9cJUb/ddhIq4cE9WZJRwsdvvhiILZFtAhASA2YZAa9iqDeh27i4WNy1MDP5rkIoWCv3QiTiaYVkrInu8esflRXZnLTk7qwusKZLYcZ7PUSb+u+FJ9P348Q3FAnpGT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062279; c=relaxed/simple;
	bh=a3z+2YImoaTBrzUyyYklSb2cBf55excf0S63KhzHJ2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CLYd//uNpd0UaoxDzn6qbt8sp8BtoHNEYXIaYOs9IW60qDzJa1Ygr/GixoEQTqRnv3/EugwzZtp8qeEiqHbndMi8FoTBb5e/3KdfwxqL0PgULsMr4sEBV/ooOtbKpEw1fChsAYoO12kcfXTkzCS+I4OV/DiRUTos0PXEwUsC/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GizcrnQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GizcrnQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB11F000E9;
	Tue, 14 Jul 2026 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784062278;
	bh=xyCmOsMU+Vw31Hd0AfS+ls1vJ/f156O2wrjPq1lZHBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GizcrnQQdFceIPERR6+Ivb2nEVoIk9cAN9vTgrL9yIuDCjWO5I8OzqhSG0tJhEmHz
	 jb6OybdQWxks5SLRJ8kQCZFusuczouKQHCZ88qEK3q07xIcsrTaKKXidGBbNOpBnm/
	 y70rM0kXgOV9Nl3G9SBCyxp+rR7LKeH5BhfknmrIeydHtGl5eSLvAB8wgqgJP0qFvZ
	 ljl/eh0W3Z1JidpElmEj4Hlwb7a8RXN+SPvytzPR/A6w5cOFlWnHg9JfRfnk0LymEW
	 zK8Dayz2dhKzYZN/SvQ4wE4dfICi3ZEEXi+CsQDtI8xklFmyUqSkDYjlHPKpYLY/D5
	 k32L2A7ygu86A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714203927.32289-2-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260714203927.32289-1-nnamdio@gmail.com>
 <20260714203927.32289-2-nnamdio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:51:17 +0000
Message-Id: <20260714205118.17DB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Socket state checks in `tcp_bpf_recvmsg` bypass unread data in `sk=
_receive_queue`, causing data loss on concurrent socket teardown or errors.

Pre-existing issues:
- [High] Sporadic EAGAIN can still occur on blocking sockets with a verdict=
 parser due to a race with the BPF parser workqueue.
- [High] `tcp_bpf_recvmsg()` incorrectly returns -EAGAIN instead of reading=
 redirected data after waking up.
--

--- Patch [1]: [PATCH v3 1/2] bpf, sockmap: handle spurious tcp_msg_wait_da=
ta() wakeup ---
commit 9cbdba3468945420ba116295ae1dbc0bc188c729
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

This commit modifies tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser() to hand=
le
spurious wakeups from tcp_msg_wait_data(). It updates sk_wait_event() to
maintain the timeout by passing it as a pointer. The commit also introduces
socket state checks into tcp_bpf_recvmsg() to match tcp_bpf_recvmsg_parser(=
).

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..e58ab2d1ee943 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
> =20
> -		data =3D tcp_msg_wait_data(sk, psock, timeo);
> +		data =3D tcp_msg_wait_data(sk, psock, &timeo);
>  		if (data < 0) {
>  			copied =3D data;
>  			goto unlock;
>  		}
>  		if (data && !sk_psock_queue_empty(psock))
>  			goto msg_bytes_ready;
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>  		copied =3D -EAGAIN;
>  	}

[Severity: High]
This is a pre-existing issue, but does this logic still sporadically return
-EAGAIN on blocking sockets when data =3D=3D 1?

If a blocking recv() is called on a sockmap socket with a verdict parser, a=
nd a
packet arrives in sk_receive_queue, tcp_msg_wait_data() will return 1.

However, if the BPF workqueue hasn't yet processed the data into
psock->ingress_msg, sk_psock_queue_empty(psock) could still be true.

It looks like the loop fails to handle data =3D=3D 1 with an empty psock, b=
ypassing
the new !data check and falling through to return -EAGAIN.

[ ... ]

> @@ -371,14 +375,45 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct =
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
> -		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> -		data =3D tcp_msg_wait_data(sk, psock, timeo);
> +		if (sock_flag(sk, SOCK_DONE)) {
> +			ret =3D 0;
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_err) {
> +			ret =3D sock_error(sk);
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +			ret =3D 0;
> +			goto unlock;
> +		}

[Severity: High]
Does evaluating these state flags before falling back to tcp_recvmsg() cause
data loss?

If normal data arrives and is queued in sk_receive_queue, and a FIN
(RCV_SHUTDOWN) or RST (sk_err) arrives immediately after, recv() would see
psock->ingress_msg as empty.

It seems like this newly added code evaluates the state flags and immediate=
ly
returns 0 or an error, bypassing the fallback to tcp_recvmsg() which would =
have
correctly drained the unread data.

[ ... ]

>  		data =3D tcp_msg_wait_data(sk, psock, &timeo);
>  		if (data < 0) {
>  			ret =3D data;
>  			goto unlock;
>  		}
>  		if (data && !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
>  			sk_psock_put(sk, psock);
>  			return tcp_recvmsg(sk, msg, len, flags);
>  		}
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>  		copied =3D -EAGAIN;
>  	}

[Severity: High]
This is a pre-existing issue, but could this return -EAGAIN instead of read=
ing
redirected data?

If data =3D=3D 1 because of redirected data in psock->ingress_msg, but
sk_receive_queue is empty, the condition:

    if (data && !skb_queue_empty_lockless(&sk->sk_receive_queue)) {

will be false.

The next check:

    if (!data && timeo > 0)

will also be false.

It seems the code then falls through to return -EAGAIN instead of looping b=
ack
to read the redirected data from the psock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714203927.3228=
9-1-nnamdio@gmail.com?part=3D1
