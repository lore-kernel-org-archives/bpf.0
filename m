Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBE3C3C02
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582172; cv=none; b=n99l11CHS1bBcZz2H89uSSSKOpTXIGBMLZbFXOXRH6XuFzVDMtWg5EFVE2epMiw10n6irw8aMZj+hooMZU7M/mz429RWL/TzTRxII0BAwFo+vu34I5pojWPyNyT1jUEAouC1ETVwoi40bwPQJagSjWdrYNJn+Rs/OLGvTJNNj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582172; c=relaxed/simple;
	bh=EkDLUhHkVdgAGlVlMw4IHFAsXUm0ZTI1gKZCuc2A1eg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KqcUAjlVz7HYxE2M2W6bpsmnfBME9wa+3mTDB+o+XUF7VupDPolx1g5qTRNozxDfL2PYMUWjOiOuc3X5rpRlKRZYZ/Arne7y9Sy75jE1wFRu8nqt3Xr3t4+JpuJQ/nDSf1CB8fPoidUrmPtel0QYttz+mg7ECHyXvCrpaznqDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=FDedrYDj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="FDedrYDj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cedda2ce6fso63632555ad.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784582170; x=1785186970; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Lk9nZncA9Gi9IHgsqlcnOIHsiF41+5jkUNql3/JHM0=;
        b=FDedrYDjk2giWdrbp5ueP1oyl6xhJUX6S9h3GjDeCLCKFqObPd81pglSw2nRBhRFPe
         nskZE0SqK9LjoRWak2jEMmAunDQBXTNKH95qPEyNu0CFgcz6Hq14dge8WksJgpC1LkiX
         R89bTO+zRdzHfwuhzlbRM5IkuIkvzVFPP7uWpG3qAjgyvV1QTXepNhgpGi1mUgtARuCd
         v84k0J1ESD8eIneAqT61D2vzBgy7Mvm4rE6GIHAIBMAWKcFlaTJ6zWrrln2uk5QC1TAn
         Xhg8SiWuCIsaHBra9tjoqTEY5p3OGfpzFP1FUo/cGhahc8kQyPQofmDV785nYSlG8Hjm
         br1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784582170; x=1785186970;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Lk9nZncA9Gi9IHgsqlcnOIHsiF41+5jkUNql3/JHM0=;
        b=BOmgCzkZT60QyRhLQwn8SQCLv/wjGwXIPVRh8kq5OVPyrnwWBoY3HhM3La8U7e8Fag
         18bhhu/MRS6fBNwaT0yuCKl4bDL4DMOHOPw64ScIMYs3u4aOUjTdSdUG+XOOvhmOR5/p
         TxJDLcm/oSY+Zt/JyhT4pCJ0w5PbGPF/rHUrb1F+AvBxzEjjJrv0EWMOxZj/HfkHMxwp
         SpdcLaaLuLRo8VYpRKtv2SBw0BYTfrPhZtJSwM6QAMXqysVBnT1o4H276y0I6n8VPW7q
         ew3GtUW9AVIxxPMBsqWJsa7NnUNGfS2VcvBxuqq0a7ND9L1V9RsFdlVgYDo/YZXNVLvs
         SFKg==
X-Gm-Message-State: AOJu0Yx7qn3CW9F1n5CD6mCjMqkqwqpRTGRclyurnJdc4oaR5bbr3UCo
	XzbZPnaxKzxErmqEOMUcubag60UM77eHbWbyjHMpNl8ODIkVhhkEHPzRtO8KYxtOYT//DyDw6xT
	DExwMt9w=
X-Gm-Gg: AR+sD112IgqoFkFraMxJOICQNdX6wCHdv5aeQWMMpaVrOJtgWUZMa1ZCAm9FReD8977
	9aoZaIDOYD0H7kwQcRfeQr2ZabH+NnwKi6X3VE5ynhrSjhYAJAblbtMuR8pWDe5SStnD8Nwep1d
	oiFpOtCBUrrcBOISoZ1ChWizgwFMRCuXWU3c2fdFuKEIn2+ioWq+ifmg49LtwzAaEc5cK++2u8h
	oO0buh2YQWV3DBAVJNTYXfnR3HsoXYMHm7cGOMhZXkFw+IVH3NYl4bAdFMTe8OJBc5yCxz1Vu7H
	UVvCgxHKg+WerNUL8jG20o4tgDZmmv/16Rkv03A4iiuqgeS5qRlr9dgQn8eODk1po+HGCpx+95h
	DcPiJDwkLRH5l8GZWvkoj8g+VmjaGHFgh8s2wlGsBswSXNsVYGX4lu1pJDa6l8g/aapBPA6w6Pe
	eu3A5BYszfYzr/giMZ5zCKLJfWV8hJ/Ys=
X-Received: by 2002:a17:902:ef49:b0:2ce:9b49:d4a0 with SMTP id d9443c01a7336-2cf34994db6mr177804055ad.35.1784582169654;
        Mon, 20 Jul 2026 14:16:09 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3473ba1dsm62513545ad.65.2026.07.20.14.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 14:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 17:16:08 -0400
Message-Id: <DK3PKY6RN5FI.4DKPSHWNEBHM@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>,
 <john.fastabend@gmail.com>, <kuba@kernel.org>, <kuniyu@google.com>,
 <ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sashiko-reviews@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260720171535.67867-1-nnamdio@gmail.com>
 <20260720171535.67867-2-nnamdio@gmail.com>
In-Reply-To: <20260720171535.67867-2-nnamdio@gmail.com>

On Mon Jul 20, 2026 at 1:15 PM EDT, Nnamdi Onyeyiri wrote:
> recvfrom()/recv() are documented as only returning EAGAIN for blocking so=
ckets
> when they have a receive timeout configured.  However, adding a blocking
> ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN =
errors
> sporadically.  A socket with a receive timeout may return EAGAIN before t=
he
> timeout expires.
>
> There are 2 code paths affected by this:
>
>   1. tcp_bpf_recvmsg() - Used when the socket has been added to a sockmap
>      that has no verdict program attached.
>
>   2. tcp_bpf_recvmsg_parser() - Used when the socket has been added to a
>      sockmap that has a verdict program.  To reproduce this issue, it is
>      enough for the verdict program to do nothing but return SK_PASS.
>
> In both cases this happens when tcp_msg_wait_data() wakes spuriously
> (returning 0).  To fix it, we now loop back to msg_bytes_ready instead
> of returning -EAGAIN on spurious wakeup.
>
> To ensure the looping does not cause sockets with a SO_RCVTIMEO set to
> wait excessively long, tcp_msg_wait_data() now takes a pointer to timeo,
> allowing sk_wait_event() to update it as appropriate.
>
> The logic in tcp_bpf_recvmsg_parser() that allow it to handle signals,
> socket errors and closuers in its loop was also added to tcp_bpf_recvmsg(=
).
>
> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> ---
>  net/ipv4/tcp_bpf.c | 69 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6..aa5c5d741599 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
> =20
>  #ifdef CONFIG_BPF_SYSCALL
>  static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> -			     long timeo)
> +			     long *timeo)
>  {
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	int ret =3D 0;
> @@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struc=
t sk_psock *psock,
>  	if (sk->sk_shutdown & RCV_SHUTDOWN)
>  		return 1;
> =20
> -	if (!timeo)
> +	if (!*timeo)
>  		return ret;
> =20
>  	add_wait_queue(sk_sleep(sk), &wait);
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> -	ret =3D sk_wait_event(sk, &timeo,
> +	ret =3D sk_wait_event(sk, timeo,
>  			    !list_empty(&psock->ingress_msg) ||
>  			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	int copied_from_self =3D 0;
>  	int copied =3D 0;
>  	u32 seq;
> +	long timeo;
> =20
>  	if (unlikely(flags & MSG_ERRQUEUE))
>  		return inet_recv_error(sk, msg, len);
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
> @@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	}
>  	seq +=3D copied_from_self;
>  	if (!copied) {
> -		long timeo;
>  		int data;
> =20
>  		if (sock_flag(sk, SOCK_DONE))
> @@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
> =20
> -		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>  		if (!timeo) {
>  			copied =3D -EAGAIN;
>  			goto out;
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
>  out:
> @@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  {
>  	struct sk_psock *psock;
>  	int copied, ret;
> +	long timeo;
> =20
>  	if (unlikely(flags & MSG_ERRQUEUE))
>  		return inet_recv_error(sk, msg, len);
> @@ -371,14 +375,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct =
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
> +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> +				release_sock(sk);
> +				sk_psock_put(sk, psock);
> +				return tcp_recvmsg(sk, msg, len, flags);
> +			}
> +			ret =3D 0;
> +			goto unlock;

These two error handling routines above look identical. Can you refactor
them?

> +		}
> +
> +		if (sk->sk_state =3D=3D TCP_CLOSE) {
> +			ret =3D -ENOTCONN;
> +			goto unlock;
> +		}
> +
> +		if (!timeo) {
> +			ret =3D -EAGAIN;
> +			goto unlock;
> +		}
> +

Since this handling (which Sashiko flags by the way, correctly AFAICT)=20
are taken from tcp_bpf_recvmsg, there is obvious overlap between the two
functions. Please factor those out so that they share the logic between
them.

pw-bot: cr

> +		if (signal_pending(current)) {
> +			ret =3D sock_intr_errno(timeo);
> +			goto unlock;
> +		}
> +
> +		data =3D tcp_msg_wait_data(sk, psock, &timeo);
>  		if (data < 0) {
>  			ret =3D data;
>  			goto unlock;
> @@ -390,6 +439,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  			sk_psock_put(sk, psock);
>  			return tcp_recvmsg(sk, msg, len, flags);
>  		}
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>  		copied =3D -EAGAIN;
>  	}
>  	ret =3D copied;

