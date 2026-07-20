Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954F30C148
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591913; cv=none; b=uFlYXwT7s8Ay5UKnuuKTE59lPnqTdlDt/FL7gQM0DwAw2KmzFnCSZwVwbPNmEu3SMV78qYDmtcOw2YIteE3+xVcS7SuW9DSPtzNE52eSvWR9f7odBC8MxuTBEQEp20s0TfgSKH8OnenmQdfMn8S/hZnURKNIfadoamYNnMyvzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591913; c=relaxed/simple;
	bh=JxFGolTGFdvyAz36xQVGbPohwCObbW8ZVFsU579opKs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KO5my0GpNFcHexfW8odv6q0+rLy9jbhJEyOI+5NAYNRALw0U7e88d2omMT7qupTR2OYbzkMKY2XbZDZv+7tfLFF7Z/AKG+7K6Q8xaCEzZtMNoRAqV+Wc7ve0cHOe+tVeo8f5E39YEnWcAxXcUOfMfLeJObgpcHhI7TibH+oT7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Z+yQP4RT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Z+yQP4RT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cad8076b01so128682785ad.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784591911; x=1785196711; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zF+4d6/CcI+ikH/4L72pwhOHENVRkJB74Kt9/nH0fmo=;
        b=Z+yQP4RTccHpQaqEDDLi++p5/+jHypvow9hZTtOa+py27Ao6UpvmsNYj0BN0B5dijQ
         7mvKGvzFEscSJFOBicIGfduUAbbcYGUOIEiJIlfAj8/n98yBed+ZiQni1CgScdCVEC+G
         +qY2vcT4QsTPj0TcmObT92lN87P6VeZ90DrMZvGyT3huAxU0umqjiBuCr8Vpu+odlIrB
         Ndtlc3SLlpSEYdK7CnOw/SluOSPbecmkyEqbiNnKLyF9Sc92AQVoOG00sdYwjIGosaxd
         jutLmk844PhbummIrM5R38Li4oKh12lZCqjhLtilUide74herlbOBFHZBV9WuVrrQJkb
         7Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591911; x=1785196711;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zF+4d6/CcI+ikH/4L72pwhOHENVRkJB74Kt9/nH0fmo=;
        b=hWhXPAXrZQZQCdpOOj+86l7nqRX9zWKcZrFmUCAhJpzQ1CRQ8yARWG7ZWpMhfQSEbk
         TMh//hzzhMfueGHQapObahkjlc671KD03rtTvydBKM+IglZZlOM2N+Y3kBlvi+GJYtwq
         rAPrhzo3Cm96n8xZ2+Y7MDEYDW5JaqlmjFJoNnZSXsEhJEUY0P+U4VaR7IJHxBRYsHkN
         19TG0pIP6wVHSBii2Im3uF5OAdbkwPNo1CKktTaZr2QzmjJtu3WFyapeTXAFxWkty8ZZ
         2ScQFyCkNeHQiZTnG/WnJP/aVfpE41HV0kmvwtLD7eyzpvM9Omv2Q8RgQhlL0H/FYOi5
         FZ0A==
X-Gm-Message-State: AOJu0Yy41GAcbAxVcQl05q4uyUPKIzBv1EGuiOV5VUYg0cxV7UiwCn77
	A1lloFl/EkVDGBy7A+AQNw76huFYFFnLlr4ItNOn+rvxn5Xhq8qYkonRBWYoSVYUoCg=
X-Gm-Gg: AR+sD12pDRTLTnD0m0328QpC6yVxXJ69CPX54oaACG+TjRwVOUfJMqVWD0PkitkObt8
	0itEE50yzUKbLMFz3LM6rZLdN8GSOx37isI1m92St1Fhb93yse1u8qfkA+ZUCxXY9/QRl5ucSPI
	nxIb/Z+7oImUsTWyfw4iMZkbQIN2ycQJZdM0qbS9pRUuf6oDkZ2ZGP0mj2biLmFaEbpUWW84GJo
	Up5D61/5dRAHSIHUBTqw9vNlL4q6nceSDl87mw5QNBvuoFM2ulcbCh1437cgH/mjHYfOKFuh/As
	KRh1GwYkwsHT439ItGFQumq2GZvoHuXDQk1aegSg64VyHJaPpUe7wHH7boiAAO6nuhKVnbtfpfH
	1Khpn8nY3llgnbHqtorQKPgnkyX9nz2Q+T7dtEU8VlYpTmujRuCN2feUFOwR5Vuu1lixSPs2eMO
	7ROg5DsNgU01DHirBPBEFAxa4ynGmFT3I=
X-Received: by 2002:a17:903:288:b0:2c2:7baf:139f with SMTP id d9443c01a7336-2cf3496003dmr169103715ad.30.1784591910468;
        Mon, 20 Jul 2026 16:58:30 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f91bsm64632745ad.8.2026.07.20.16.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 16:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 19:58:28 -0400
Message-Id: <DK3T18YN2PIG.21FN4EV1MFYSD@etsalapatis.com>
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
 <DK3PKY6RN5FI.4DKPSHWNEBHM@etsalapatis.com>
 <al6iBv_Yn4YSCmWc@localhost.localdomain>
In-Reply-To: <al6iBv_Yn4YSCmWc@localhost.localdomain>

On Mon Jul 20, 2026 at 6:53 PM EDT, Nnamdi Onyeyiri wrote:
> On Mon, Jul 20, 2026 at 05:16:08PM -0400, Emil Tsalapatis wrote:
>> On Mon Jul 20, 2026 at 1:15 PM EDT, Nnamdi Onyeyiri wrote:
>> > recvfrom()/recv() are documented as only returning EAGAIN for blocking=
 sockets
>> > when they have a receive timeout configured.  However, adding a blocki=
ng
>> > ipv4 tcp socket without a receive timeout to a sockmap will cause EAGA=
IN errors
>> > sporadically.  A socket with a receive timeout may return EAGAIN befor=
e the
>> > timeout expires.
>> >
>> > There are 2 code paths affected by this:
>> >
>> >   1. tcp_bpf_recvmsg() - Used when the socket has been added to a sock=
map
>> >      that has no verdict program attached.
>> >
>> >   2. tcp_bpf_recvmsg_parser() - Used when the socket has been added to=
 a
>> >      sockmap that has a verdict program.  To reproduce this issue, it =
is
>> >      enough for the verdict program to do nothing but return SK_PASS.
>> >
>> > In both cases this happens when tcp_msg_wait_data() wakes spuriously
>> > (returning 0).  To fix it, we now loop back to msg_bytes_ready instead
>> > of returning -EAGAIN on spurious wakeup.
>> >
>> > To ensure the looping does not cause sockets with a SO_RCVTIMEO set to
>> > wait excessively long, tcp_msg_wait_data() now takes a pointer to time=
o,
>> > allowing sk_wait_event() to update it as appropriate.
>> >
>> > The logic in tcp_bpf_recvmsg_parser() that allow it to handle signals,
>> > socket errors and closuers in its loop was also added to tcp_bpf_recvm=
sg().
>> >
>> > Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
>> > ---
>> >  net/ipv4/tcp_bpf.c | 69 ++++++++++++++++++++++++++++++++++++++++-----=
-
>> >  1 file changed, 60 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> > index cc0bd73f36b6..aa5c5d741599 100644
>> > --- a/net/ipv4/tcp_bpf.c
>> > +++ b/net/ipv4/tcp_bpf.c
>> > @@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
>> > =20
>> >  #ifdef CONFIG_BPF_SYSCALL
>> >  static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>> > -			     long timeo)
>> > +			     long *timeo)
>> >  {
>> >  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>> >  	int ret =3D 0;
>> > @@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, st=
ruct sk_psock *psock,
>> >  	if (sk->sk_shutdown & RCV_SHUTDOWN)
>> >  		return 1;
>> > =20
>> > -	if (!timeo)
>> > +	if (!*timeo)
>> >  		return ret;
>> > =20
>> >  	add_wait_queue(sk_sleep(sk), &wait);
>> >  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>> > -	ret =3D sk_wait_event(sk, &timeo,
>> > +	ret =3D sk_wait_event(sk, timeo,
>> >  			    !list_empty(&psock->ingress_msg) ||
>> >  			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
>> >  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>> > @@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>> >  	int copied_from_self =3D 0;
>> >  	int copied =3D 0;
>> >  	u32 seq;
>> > +	long timeo;
>> > =20
>> >  	if (unlikely(flags & MSG_ERRQUEUE))
>> >  		return inet_recv_error(sk, msg, len);
>> > @@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>> >  		}
>> >  	}
>> > =20
>> > +	timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>> > +
>> >  msg_bytes_ready:
>> >  	copied =3D __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from=
_self);
>> >  	/* The typical case for EFAULT is the socket was gracefully
>> > @@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>> >  	}
>> >  	seq +=3D copied_from_self;
>> >  	if (!copied) {
>> > -		long timeo;
>> >  		int data;
>> > =20
>> >  		if (sock_flag(sk, SOCK_DONE))
>> > @@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>> >  			goto out;
>> >  		}
>> > =20
>> > -		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>> >  		if (!timeo) {
>> >  			copied =3D -EAGAIN;
>> >  			goto out;
>> > @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *s=
k,
>> >  			goto out;
>> >  		}
>> > =20
>> > -		data =3D tcp_msg_wait_data(sk, psock, timeo);
>> > +		data =3D tcp_msg_wait_data(sk, psock, &timeo);
>> >  		if (data < 0) {
>> >  			copied =3D data;
>> >  			goto unlock;
>> >  		}
>> >  		if (data && !sk_psock_queue_empty(psock))
>> >  			goto msg_bytes_ready;
>> > +		if (!data && timeo > 0)
>> > +			goto msg_bytes_ready;
>> >  		copied =3D -EAGAIN;
>> >  	}
>> >  out:
>> > @@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
>> >  {
>> >  	struct sk_psock *psock;
>> >  	int copied, ret;
>> > +	long timeo;
>> > =20
>> >  	if (unlikely(flags & MSG_ERRQUEUE))
>> >  		return inet_recv_error(sk, msg, len);
>> > @@ -371,14 +375,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>> >  		return tcp_recvmsg(sk, msg, len, flags);
>> >  	}
>> >  	lock_sock(sk);
>> > +
>> > +	timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>> > +
>> >  msg_bytes_ready:
>> >  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>> >  	if (!copied) {
>> > -		long timeo;
>> >  		int data;
>> > =20
>> > -		timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>> > -		data =3D tcp_msg_wait_data(sk, psock, timeo);
>> > +		if (sock_flag(sk, SOCK_DONE)) {
>> > +			ret =3D 0;
>> > +			goto unlock;
>> > +		}
>> > +
>> > +		if (sk->sk_err) {
>> > +			if (!sk_psock_queue_empty(psock))
>> > +				goto msg_bytes_ready;
>> > +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
>> > +				release_sock(sk);
>> > +				sk_psock_put(sk, psock);
>> > +				return tcp_recvmsg(sk, msg, len, flags);
>> > +			}
>> > +			ret =3D sock_error(sk);
>> > +			goto unlock;
>> > +		}
>> > +
>> > +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
>> > +			if (!sk_psock_queue_empty(psock))
>> > +				goto msg_bytes_ready;
>> > +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
>> > +				release_sock(sk);
>> > +				sk_psock_put(sk, psock);
>> > +				return tcp_recvmsg(sk, msg, len, flags);
>> > +			}
>> > +			ret =3D 0;
>> > +			goto unlock;
>>=20
>> These two error handling routines above look identical. Can you refactor
>> them?
>>
>
> Will do.  My understanding is the same logic is needed to address the
> issue Sashiko raised with the SOCK_DONE check as well.
>
>> > +		}
>> > +
>> > +		if (sk->sk_state =3D=3D TCP_CLOSE) {
>> > +			ret =3D -ENOTCONN;
>> > +			goto unlock;
>> > +		}
>> > +
>> > +		if (!timeo) {
>> > +			ret =3D -EAGAIN;
>> > +			goto unlock;
>> > +		}
>> > +
>>=20
>> Since this handling (which Sashiko flags by the way, correctly AFAICT)=
=20
>> are taken from tcp_bpf_recvmsg, there is obvious overlap between the two
>> functions. Please factor those out so that they share the logic between
>> them.
>>=20
>> pw-bot: cr
>>=20
>
> Sashiko highlighted the "if (!timeo)" and signal_pending early returns
> when MSG_DONTWAIT is set, but I think I'm missing part of the picture.
> By the time we reach these branches, haven't we already checked for data
> in sk_receive_queue (line 372, after the patch is applied to 7.2-rc2)
> [copied below for ease of viewing]:
>
>     if (!skb_queue_empty(&sk->sk_receive_queue) &&
>         sk_psock_queue_empty(psock)) {
>         sk_psock_put(sk, psock);
>         return tcp_recvmsg(sk, msg, len, flags);
>     }
>
> and in the psock (line 382) [again copied below for viewing]:
>
>     copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);

If I'm understanding your question correctly, and AFAICT:
sk_msg_recvmsg only drains the psock out of sk_msg data. If any data is
still in the backing struct sock but has _not_ been drained into the psock
it gets missed under the new code.

>
>> > +		if (signal_pending(current)) {
>> > +			ret =3D sock_intr_errno(timeo);
>> > +			goto unlock;
>> > +		}
>> > +
>> > +		data =3D tcp_msg_wait_data(sk, psock, &timeo);
>> >  		if (data < 0) {
>> >  			ret =3D data;
>> >  			goto unlock;
>> > @@ -390,6 +439,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
>> >  			sk_psock_put(sk, psock);
>> >  			return tcp_recvmsg(sk, msg, len, flags);
>> >  		}
>> > +		if (!data && timeo > 0)
>> > +			goto msg_bytes_ready;
>> >  		copied =3D -EAGAIN;
>> >  	}
>> >  	ret =3D copied;
>>=20

