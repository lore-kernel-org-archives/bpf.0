Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F255339389
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718075; cv=none; b=GwCw5hoML7Ln89ZHZd2JNGzOcIAkzy+Za6TbkwbD8+cQ64FnjELGKPHaIlCcsxjFGKc8g71IPXmxPVniPrMvcS1e0UUqHtj/a7b7a3iFrDmv7xit5bttIpHaLifa23pMftfYJ0WzYrNq3DYi9oapPZxaaQCIgsDYWyZmMJABi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718075; c=relaxed/simple;
	bh=l4IZePHQHB+DScCVirb0CXs9ouX5UNF/MLRitQsNMSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVmwC4VbacTIuFEgGD4IGW36RxnUTQmKKtVoVgZptuCXR19rSklVRNClEpjKVHo3iUqEpIOSuzsWyrIBMU8trzg4p42lRxOFkzp4dWLXoLl4ZcBW5RwCzBDZ8mBogPIMbtki0uQ6zbBeTKaJXas+2hNBdfrI7+YpwJdRTwUrUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TwLD5H7K; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TwLD5H7K"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1691e4ec40so965537666b.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784718071; x=1785322871; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cO+kmpUCCioIC76CwN3tZnRU7YIi9lxZbY59h36dT8U=;
        b=TwLD5H7K0LIoVZC5JqYE/z4rnjsX86zgga0Ws3d94y+pg3If3cR7khx0kk84nxa/8G
         Z4e91wseKkwY6kfj2Z3191Bta+RqjKFAeCQ2uJqQNYhY/sl4fCZMtKbmx/SwPyU40KAk
         IOLmL/0LbQX+1JZcFzxhrMHp2f7x+ttBqrlcW89VrXhSAftHwXhKv+uWpYHVCTFv+N4q
         pu9avxrz5CTHftQxm+lR1IUttibQwBYcEfs8tiudP7VgrzzgcdVHQNc+jX6Rhj/Fw0xX
         dqqqDhsmWYXyFayFstLdV/ADW7iILzPJBv04dAkQR45JLeWDyYlVAeVc09EU/dBjI+Rx
         yf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718071; x=1785322871;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cO+kmpUCCioIC76CwN3tZnRU7YIi9lxZbY59h36dT8U=;
        b=C3Gh8fmKPvivEFhLOsO7ublP1njb0drszv8Ie8GOXWxvGUOnsBtp2B5WW0nC3dYCdG
         2Ka1eAsycbov2+IChI6Xt5A8T0ct1Lp2pSBKtQTyPgG3pkGQIi5JKG5C1Trz7YREe2PV
         K6XykkinUQLIvWETU2Ck9AH8glozDlSAp85FLut0Jz/8DS+U7bwuWMap4sYhN4OyD+zq
         SJfqzWEQhVU9uyj4BifI765HnsrA9hbwblE6UGEkh07xVvSnEHV1QpBNtQuKJXKer8Nx
         P8hXd35z7GcO/j8ua1umPZjasT4QKfHn8e/8aUpN01YsN7Fb9s/wyYaEX8QVeYB83Kaf
         W+Cg==
X-Gm-Message-State: AOJu0Yxceo17sROqiuKFYkJRXutLZVgR6WxLgzK/kXGtXTqex+X00+OW
	bFNw+RXtlo2tZA6vAEtKJlXD9uzXnWNZcxzDEsEbcC+QZuLfFZi00J5XVQsOid3IxTI=
X-Gm-Gg: AR+sD12PJbJVjE99d0pEMTr6HT53PouxFxnppKElnql33bjZm5rIWINAYgWQa+u6m8x
	pS/qSIRPWOwy0ZjrDYfG9OiMgkkNLl9jX0FBY2P1Piup+xlLxr91ib5ZI8vbmQODX4lOKxoklOi
	vSL8gH7yOY62lPPdO2J5ZXLlQxhI+iXpgw+4aenuNaqy8D7rEqD61Bvo9/vRW8yrgnpMUWyZRA7
	fFD7r1iO2ZuhvK2CbYHd9aXV+a3YWvrgOb/6Kn+AXrZfx5IVUSU+5bmD24KBPQLxQs8+Es7rAMm
	NF41T0UQF41A7S20qBbzgl2BIfuNmHb/zdzRqXNs8VZHZ6BLKV559mX1EPw/xEM4l0Dss0IjSmW
	ysXWrlv3/fzSo9l22s9IQPTnlxOnxZhft70gurzhs1+ojrV3hZv/OMuqctLCeCp+E3GFjWPHiMf
	7d5pHg
X-Received: by 2002:a17:907:8b92:b0:c15:a9a8:66b with SMTP id a640c23a62f3a-c16b48a6687mr854852866b.63.1784718070571;
        Wed, 22 Jul 2026 04:01:10 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a78e0fsm84807466b.2.2026.07.22.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:01:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Nnamdi Onyeyiri <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org,  davem@davemloft.net,  edumazet@google.com,
  horms@kernel.org,  jiayuan.chen@linux.dev,  john.fastabend@gmail.com,
  kuba@kernel.org,  kuniyu@google.com,  ncardwell@google.com,
  netdev@vger.kernel.org,  pabeni@redhat.com,
  sashiko-reviews@lists.linux.dev,  linux-kernel@vger.kernel.org,
  emil@etsalapatis.com
Subject: Re: [PATCH v7 1/2] bpf, sockmap: handle spurious
 tcp_msg_wait_data() wakeup
In-Reply-To: <20260721223807.75101-2-nnamdio@gmail.com> (Nnamdi Onyeyiri's
	message of "Tue, 21 Jul 2026 23:38:06 +0100")
References: <20260721223807.75101-1-nnamdio@gmail.com>
	<20260721223807.75101-2-nnamdio@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 22 Jul 2026 13:01:09 +0200
Message-ID: <87tsprl24q.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 21, 2026 at 11:38 PM +01, Nnamdi Onyeyiri wrote:
> recvfrom()/recv() are documented as only returning EAGAIN for blocking
> sockets when they have a receive timeout configured.  However, adding a
> blocking ipv4 tcp socket without a receive timeout to a sockmap will cause
> EAGAIN errors sporadically.  A socket with a receive timeout may return
> EAGAIN before the timeout expires.
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
> socket errors and closuers in its loop was also added to tcp_bpf_recvmsg().
>
> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> ---
>  net/ipv4/tcp_bpf.c | 72 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6..1755fcf726fc 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
>  
>  #ifdef CONFIG_BPF_SYSCALL
>  static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> -			     long timeo)
> +			     long *timeo)
>  {
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	int ret = 0;
> @@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>  	if (sk->sk_shutdown & RCV_SHUTDOWN)
>  		return 1;
>  
> -	if (!timeo)
> +	if (!*timeo)
>  		return ret;
>  
>  	add_wait_queue(sk_sleep(sk), &wait);
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> -	ret = sk_wait_event(sk, &timeo,
> +	ret = sk_wait_event(sk, timeo,
>  			    !list_empty(&psock->ingress_msg) ||
>  			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	int copied_from_self = 0;
>  	int copied = 0;
>  	u32 seq;
> +	long timeo;
>  
>  	if (unlikely(flags & MSG_ERRQUEUE))
>  		return inet_recv_error(sk, msg, len);
> @@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  		}
>  	}
>  
> +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +
>  msg_bytes_ready:
>  	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
>  	/* The typical case for EFAULT is the socket was gracefully
> @@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	}
>  	seq += copied_from_self;
>  	if (!copied) {
> -		long timeo;
>  		int data;
>  
>  		if (sock_flag(sk, SOCK_DONE))
> @@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
>  
> -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>  		if (!timeo) {
>  			copied = -EAGAIN;
>  			goto out;
> @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
>  
> -		data = tcp_msg_wait_data(sk, psock, timeo);
> +		data = tcp_msg_wait_data(sk, psock, &timeo);
>  		if (data < 0) {
>  			copied = data;
>  			goto unlock;
>  		}
>  		if (data && !sk_psock_queue_empty(psock))
>  			goto msg_bytes_ready;
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>  		copied = -EAGAIN;
>  	}
>  out:
> @@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  {
>  	struct sk_psock *psock;
>  	int copied, ret;
> +	long timeo;
>  
>  	if (unlikely(flags & MSG_ERRQUEUE))
>  		return inet_recv_error(sk, msg, len);
> @@ -371,14 +375,52 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		return tcp_recvmsg(sk, msg, len, flags);
>  	}
>  	lock_sock(sk);
> +
> +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +
>  msg_bytes_ready:
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> -		long timeo;
>  		int data;
>  
> -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> -		data = tcp_msg_wait_data(sk, psock, timeo);
> +		if (sock_flag(sk, SOCK_DONE)) {
> +			ret = 0;
> +			goto check_queues;
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
> +			ret = sock_error(sk);
> +			goto unlock;
> +		}

Isn't that branch the same as:

        if (sk->sk_err) {
                ret = sock_error(sk);
                goto check_queues;
        }

?

> +
> +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +			ret = 0;
> +			goto check_queues;
> +		}
> +
> +		if (sk->sk_state == TCP_CLOSE) {
> +			ret = -ENOTCONN;
> +			goto check_queues;
> +		}
> +
> +		if (!timeo) {
> +			ret = -EAGAIN;
> +			goto check_queues;
> +		}
> +
> +		if (signal_pending(current)) {
> +			ret = sock_intr_errno(timeo);
> +			goto check_queues;
> +		}
> +
> +		data = tcp_msg_wait_data(sk, psock, &timeo);
>  		if (data < 0) {
>  			ret = data;
>  			goto unlock;
> @@ -390,6 +432,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			sk_psock_put(sk, psock);
>  			return tcp_recvmsg(sk, msg, len, flags);
>  		}
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>  		copied = -EAGAIN;
>  	}
>  	ret = copied;
> @@ -398,6 +442,16 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	release_sock(sk);
>  	sk_psock_put(sk, psock);
>  	return ret;
> +
> +check_queues:
> +	if (!sk_psock_queue_empty(psock))
> +		goto msg_bytes_ready;
> +	if (!skb_queue_empty(&sk->sk_receive_queue)) {
> +		release_sock(sk);
> +		sk_psock_put(sk, psock);
> +		return tcp_recvmsg(sk, msg, len, flags);
> +	}
> +	goto unlock;
>  }
>  
>  static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
