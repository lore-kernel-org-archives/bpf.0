Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789C38BF81
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588011; cv=none; b=aw1litwT5IXzgfixMXeZqd65oat1ATgMdpbZrj1TsB6VIO4OZsbvnkWvNN5DX5Wq5bCisnJmb+R4LwRDZWdFzfLgDQrGnoTIjb4Vkm5DpLEfOA0lMYrJdmaOHcaGA+grI22JkcgnNjhOU8xQttZBcxFo9upt/zka6iutNJ/IV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588011; c=relaxed/simple;
	bh=bu9MxjR9PrOS7jFoOtI1kzXfsfiOmCRm8agej7/N0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My6Gl87ROYPgCc+SArthNPBwWhc3gJJ8gm15jvq+tJv6/xUWhiILAjKYqhKXkBnlYjtUflIkCBhM+Cb4SzSR0GIiNOleTHRbCMk8LveAl5y+pjMPOPXB095EVMrfxlbAA/KwBn/TS0x9PZf0YMrb4EG5QitURlVziziR2uY0FBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYSw80KT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYSw80KT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso14866685e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784588007; x=1785192807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xaOVkEmI94bSxjGZP8o0unCsarNml6GU1QHwiTIhRTw=;
        b=qYSw80KTcXhIsJmoJ5JfON/ZxwRG+mIFCHhz0GXnMIKkdeasNRh7vNze6MBfOEposa
         ++dLmsCTry0xU1SjRxFQe/iefs90QH8vaVGsdmKmiW3R4joATlDAIFNEbw88Xf/wrEVK
         BeGSGKoV3E5Ss9F+q875gSOhct7T82AS1x33wgxoVTnPag58GrSmvjOWWGMFb2a4c2cZ
         OAGg4nZEDCbZcwLpwHcsqxtJmoqJEdjkeNCDpadXX/Jk3ctlqFBq1aGZTGtKRVJjJTw+
         IR9cahOCrpScwJ+O+vuWNNQ13+OQJCWftAnL7Ys9zFKwo43UERC1T9RVOHG4+v8UHgD7
         pYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784588007; x=1785192807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xaOVkEmI94bSxjGZP8o0unCsarNml6GU1QHwiTIhRTw=;
        b=gpmS9nSiGETV7fd83FKxz3rLU7uNoIHzXqHNiiKbEhE0VFC+UfbCGDC9aqrh564n6A
         Pjhl3SbztvznIPohH/diZHxFg09P46cLXtH6/IsVgilbFrvzKrB/+M8dwIaTKao2X4A6
         7HSYNDwRYUd5ApPcibmdsTAMaKF+jD303tFcIHkML1u8ZM64zQIYQ7EELnP3mQbE7U3P
         EeJUN0ygr+Dxxn4vSpGihK2yQSlrCQxKecJ8uEP+KtO+ZKRSSkCsKR46zzGYPZJUINMO
         r0F0qmPj0+Ubbbf+tFXa1VoNF99PqwPlSIM34IiArLCLXqJd1c9pRMiG9yqa0A519X3j
         KLXg==
X-Gm-Message-State: AOJu0Yxdbx/mxohApI0wW8J5zL7qSN4uloCDGOOYE0YFw8ny1KAd1cCd
	7Yemycy0+mBF4fFl8gTY/VRrEwlO5jAlM/c+DAI/36gBkYB6Vf76QAhU
X-Gm-Gg: AfdE7cnnjiEsTx9OPwtsAoe7eMirXV9fsLRKESlaHPpqoy/CqU4fP+LLedpNdaqd8W1
	x+38Th8OQnN4THEhhUFpxhljXLRU959LlSgRjJ2aglgOpSMrxMLMr1CzZAJyiUJO9kw42RoTGRo
	8f2/VYk+4FFm28lkpmJ5Xvce4l1jkO10PqjFWXkm1LJxm8WKKMmvRywqenGyzVq9uLDnl+PkHpt
	9iLnKKQLUjiHUnVoCLzFoVJCmkXqL4e3EW0ugBPsdimrl0Jjey6Gc//BGN0v+Z6ArD+OcyvB3gW
	siE3owgr1c45JOvsljQW1wWo+Tzz9ZKzdc1GDbbuEVXIzZ1XNzAkow9gSrFz+9vje0GO7IgWjg+
	wFEx4p4IpOht+ScLcdNRmHXGEqoEncuRVxZNGFH5zsAOqbeBLMnhvZx2aLkriSYCST8BzfRIEi2
	rfWeBJycBOZrooxUmsOuxOn9S5JgU1EMCNHCNzLMEKcUeDpxs5hLyFclgekYiu7bukSWhexLRh7
	Aus
X-Received: by 2002:a05:600c:1f82:b0:495:607e:5ee7 with SMTP id 5b1f17b1804b1-495607e635amr51345645e9.17.1784588006289;
        Mon, 20 Jul 2026 15:53:26 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm31525849f8f.4.2026.07.20.15.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 15:53:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 23:53:23 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@google.com, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sashiko-reviews@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
Message-ID: <al6iBv_Yn4YSCmWc@localhost.localdomain>
References: <20260720171535.67867-1-nnamdio@gmail.com>
 <20260720171535.67867-2-nnamdio@gmail.com>
 <DK3PKY6RN5FI.4DKPSHWNEBHM@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK3PKY6RN5FI.4DKPSHWNEBHM@etsalapatis.com>

On Mon, Jul 20, 2026 at 05:16:08PM -0400, Emil Tsalapatis wrote:
> On Mon Jul 20, 2026 at 1:15 PM EDT, Nnamdi Onyeyiri wrote:
> > recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
> > when they have a receive timeout configured.  However, adding a blocking
> > ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
> > sporadically.  A socket with a receive timeout may return EAGAIN before the
> > timeout expires.
> >
> > There are 2 code paths affected by this:
> >
> >   1. tcp_bpf_recvmsg() - Used when the socket has been added to a sockmap
> >      that has no verdict program attached.
> >
> >   2. tcp_bpf_recvmsg_parser() - Used when the socket has been added to a
> >      sockmap that has a verdict program.  To reproduce this issue, it is
> >      enough for the verdict program to do nothing but return SK_PASS.
> >
> > In both cases this happens when tcp_msg_wait_data() wakes spuriously
> > (returning 0).  To fix it, we now loop back to msg_bytes_ready instead
> > of returning -EAGAIN on spurious wakeup.
> >
> > To ensure the looping does not cause sockets with a SO_RCVTIMEO set to
> > wait excessively long, tcp_msg_wait_data() now takes a pointer to timeo,
> > allowing sk_wait_event() to update it as appropriate.
> >
> > The logic in tcp_bpf_recvmsg_parser() that allow it to handle signals,
> > socket errors and closuers in its loop was also added to tcp_bpf_recvmsg().
> >
> > Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> > ---
> >  net/ipv4/tcp_bpf.c | 69 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 60 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index cc0bd73f36b6..aa5c5d741599 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
> >  
> >  #ifdef CONFIG_BPF_SYSCALL
> >  static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> > -			     long timeo)
> > +			     long *timeo)
> >  {
> >  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >  	int ret = 0;
> > @@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> >  	if (sk->sk_shutdown & RCV_SHUTDOWN)
> >  		return 1;
> >  
> > -	if (!timeo)
> > +	if (!*timeo)
> >  		return ret;
> >  
> >  	add_wait_queue(sk_sleep(sk), &wait);
> >  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > -	ret = sk_wait_event(sk, &timeo,
> > +	ret = sk_wait_event(sk, timeo,
> >  			    !list_empty(&psock->ingress_msg) ||
> >  			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
> >  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > @@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  	int copied_from_self = 0;
> >  	int copied = 0;
> >  	u32 seq;
> > +	long timeo;
> >  
> >  	if (unlikely(flags & MSG_ERRQUEUE))
> >  		return inet_recv_error(sk, msg, len);
> > @@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  		}
> >  	}
> >  
> > +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> > +
> >  msg_bytes_ready:
> >  	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
> >  	/* The typical case for EFAULT is the socket was gracefully
> > @@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  	}
> >  	seq += copied_from_self;
> >  	if (!copied) {
> > -		long timeo;
> >  		int data;
> >  
> >  		if (sock_flag(sk, SOCK_DONE))
> > @@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  			goto out;
> >  		}
> >  
> > -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> >  		if (!timeo) {
> >  			copied = -EAGAIN;
> >  			goto out;
> > @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> >  			goto out;
> >  		}
> >  
> > -		data = tcp_msg_wait_data(sk, psock, timeo);
> > +		data = tcp_msg_wait_data(sk, psock, &timeo);
> >  		if (data < 0) {
> >  			copied = data;
> >  			goto unlock;
> >  		}
> >  		if (data && !sk_psock_queue_empty(psock))
> >  			goto msg_bytes_ready;
> > +		if (!data && timeo > 0)
> > +			goto msg_bytes_ready;
> >  		copied = -EAGAIN;
> >  	}
> >  out:
> > @@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  {
> >  	struct sk_psock *psock;
> >  	int copied, ret;
> > +	long timeo;
> >  
> >  	if (unlikely(flags & MSG_ERRQUEUE))
> >  		return inet_recv_error(sk, msg, len);
> > @@ -371,14 +375,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  		return tcp_recvmsg(sk, msg, len, flags);
> >  	}
> >  	lock_sock(sk);
> > +
> > +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> > +
> >  msg_bytes_ready:
> >  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> >  	if (!copied) {
> > -		long timeo;
> >  		int data;
> >  
> > -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> > -		data = tcp_msg_wait_data(sk, psock, timeo);
> > +		if (sock_flag(sk, SOCK_DONE)) {
> > +			ret = 0;
> > +			goto unlock;
> > +		}
> > +
> > +		if (sk->sk_err) {
> > +			if (!sk_psock_queue_empty(psock))
> > +				goto msg_bytes_ready;
> > +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> > +				release_sock(sk);
> > +				sk_psock_put(sk, psock);
> > +				return tcp_recvmsg(sk, msg, len, flags);
> > +			}
> > +			ret = sock_error(sk);
> > +			goto unlock;
> > +		}
> > +
> > +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
> > +			if (!sk_psock_queue_empty(psock))
> > +				goto msg_bytes_ready;
> > +			if (!skb_queue_empty(&sk->sk_receive_queue)) {
> > +				release_sock(sk);
> > +				sk_psock_put(sk, psock);
> > +				return tcp_recvmsg(sk, msg, len, flags);
> > +			}
> > +			ret = 0;
> > +			goto unlock;
> 
> These two error handling routines above look identical. Can you refactor
> them?
>

Will do.  My understanding is the same logic is needed to address the
issue Sashiko raised with the SOCK_DONE check as well.

> > +		}
> > +
> > +		if (sk->sk_state == TCP_CLOSE) {
> > +			ret = -ENOTCONN;
> > +			goto unlock;
> > +		}
> > +
> > +		if (!timeo) {
> > +			ret = -EAGAIN;
> > +			goto unlock;
> > +		}
> > +
> 
> Since this handling (which Sashiko flags by the way, correctly AFAICT) 
> are taken from tcp_bpf_recvmsg, there is obvious overlap between the two
> functions. Please factor those out so that they share the logic between
> them.
> 
> pw-bot: cr
> 

Sashiko highlighted the "if (!timeo)" and signal_pending early returns
when MSG_DONTWAIT is set, but I think I'm missing part of the picture.
By the time we reach these branches, haven't we already checked for data
in sk_receive_queue (line 372, after the patch is applied to 7.2-rc2)
[copied below for ease of viewing]:

    if (!skb_queue_empty(&sk->sk_receive_queue) &&
        sk_psock_queue_empty(psock)) {
        sk_psock_put(sk, psock);
        return tcp_recvmsg(sk, msg, len, flags);
    }

and in the psock (line 382) [again copied below for viewing]:

    copied = sk_msg_recvmsg(sk, psock, msg, len, flags);

> > +		if (signal_pending(current)) {
> > +			ret = sock_intr_errno(timeo);
> > +			goto unlock;
> > +		}
> > +
> > +		data = tcp_msg_wait_data(sk, psock, &timeo);
> >  		if (data < 0) {
> >  			ret = data;
> >  			goto unlock;
> > @@ -390,6 +439,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  			sk_psock_put(sk, psock);
> >  			return tcp_recvmsg(sk, msg, len, flags);
> >  		}
> > +		if (!data && timeo > 0)
> > +			goto msg_bytes_ready;
> >  		copied = -EAGAIN;
> >  	}
> >  	ret = copied;
> 
