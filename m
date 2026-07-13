Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589236A369
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783916080; cv=none; b=nkiGTOOtAaEpnRIA15hu10u+u/LMSCtOAHEHJl78LNC9jxrTY7uTm7OLUrQbASJRK4VrJhgMcLvkczhwjTngpf5rkne78OOm8fuwGTU/l7iNeYmtr8YCSomPKo+EuREm66jWpwo5Yot5qfkEIz6aRHnSmfDmnp3NokVxCSHiMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783916080; c=relaxed/simple;
	bh=y1Yt2fykqjsWvs7kXOwQ+eAkXv958ODFE7VheXPWId0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqJoJM01NbZNYFp8cIoQi6zTQTamgx6vkV0v7UNaNJW/Eu8qoEVDPdJNB66jgmv6KBOuL8Z5TFO12claXl8MYKI3+llaNfHOxb030yt4BZ4Su0Hv/73TVg55B4cKBRnLsBkh0v3U/mqBHZ3ek2aVVtr4zJTYvd5M9GFy85P5m78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xDOBaWfl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xDOBaWfl"
Message-ID: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783916064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUYIJ9DN/aj3dekLHrJVHchQB1flIZYdeNNZTWSaweE=;
	b=xDOBaWfl3M9diHS22ZehJhE9K0+bazKqg07i01Jz9Bxz5GvdXr5OMrd8A2frtvubdRqQf2
	KNaR7BSVLYCk4kvDUpn6sOVgWTELSYzKr3EAaQ382ThUJO86Njg7vByw2X+XVJWvxMzXAO
	K3k54fLG9xNwnnEFPgf6NqboCdsm6Ow=
Date: Mon, 13 Jul 2026 12:14:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
To: Nnamdi Onyeyiri <nnamdio@gmail.com>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
 <20260709185526.E4DAB1F000E9@smtp.kernel.org>
 <alFRK66z45eDNZA7@localhost.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <alFRK66z45eDNZA7@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/11/26 4:17 AM, Nnamdi Onyeyiri wrote:
> Hi,
>
> The updated patch below addresses the issues raised by sashiko-bot.  The closed
> socket and signal handling code was added to tcp_bpf_recvmsg(), and the fix was
> updated to work for sockets with SO_RCVTIMEO set.
>
> Please let me know if any more changes are required, or if the patch would need
> to be submitted some other way, I'm happy to adjust as necessary.
>
> Thanks!


Thanks for the report.


What's your use case here? With a verdict prog attached, we'd normally

expect the data to be redirected in kernel rather than read back via

  recvmsg(). Are you using SK_PASS? If so, please state that in the

commit message instead of the email body.


Also, this message could be included into commit message.

>
> ----8<----
>  From 20a1275aa5ecb927ff049971454b62682356ef0e Mon Sep 17 00:00:00 2001
> From: Nnamdi Onyeyiri <nnamdio@gmail.com>
> Date: Fri, 10 Jul 2026 20:47:36 +0100
> Subject: [PATCH v2 1/1] bpf, sockmap: handle spurious tcp_msg_wait_data()
>   wakeup
>
> recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
> when they have a receive timeout configured.  however, adding a blocking
> ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
> sporadically.  a socket with a receive timeout may return EAGAIN before the
> timeout expires.
>
> this happens when tcp_msg_wait_data() wakes spuriously (returning 0) in which
> case, if there is no timeout, or the timeout has not yet expired, we loop
> again instead of returning.

Also please add a selftest and send both as a patchset.


>
> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
> ---
>   net/ipv4/tcp_bpf.c | 55 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6..e3109edb9621 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
>   
>   #ifdef CONFIG_BPF_SYSCALL
>   static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
> -			     long timeo)
> +			     long *timeo)
>   {
>   	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>   	int ret = 0;
> @@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>   	if (sk->sk_shutdown & RCV_SHUTDOWN)
>   		return 1;
>   
> -	if (!timeo)
> +	if (!(*timeo))
>   		return ret;

'if (!*timeo)'  is enough


>   
>   	add_wait_queue(sk_sleep(sk), &wait);
>   	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> -	ret = sk_wait_event(sk, &timeo,
> +	ret = sk_wait_event(sk, timeo,
>   			    !list_empty(&psock->ingress_msg) ||
>   			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
>   	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>   	int copied_from_self = 0;
>   	int copied = 0;
>   	u32 seq;
> +	long timeo;
>   
>   	if (unlikely(flags & MSG_ERRQUEUE))
>   		return inet_recv_error(sk, msg, len);
> @@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>   		}
>   	}
>   
> +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +
>   msg_bytes_ready:
>   	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
>   	/* The typical case for EFAULT is the socket was gracefully
> @@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>   	}
>   	seq += copied_from_self;
>   	if (!copied) {
> -		long timeo;
>   		int data;
>   
>   		if (sock_flag(sk, SOCK_DONE))
> @@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>   			goto out;
>   		}
>   
> -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>   		if (!timeo) {
>   			copied = -EAGAIN;
>   			goto out;
> @@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>   			goto out;
>   		}
>   
> -		data = tcp_msg_wait_data(sk, psock, timeo);
> +		data = tcp_msg_wait_data(sk, psock, &timeo);
>   		if (data < 0) {
>   			copied = data;
>   			goto unlock;
>   		}
>   		if (data && !sk_psock_queue_empty(psock))
>   			goto msg_bytes_ready;
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>   		copied = -EAGAIN;
>   	}
>   out:
> @@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   {
>   	struct sk_psock *psock;
>   	int copied, ret;
> +	long timeo;
>   
>   	if (unlikely(flags & MSG_ERRQUEUE))
>   		return inet_recv_error(sk, msg, len);
> @@ -371,14 +375,45 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   		return tcp_recvmsg(sk, msg, len, flags);
>   	}
>   	lock_sock(sk);
> +
> +	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> +
>   msg_bytes_ready:
>   	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>   	if (!copied) {
> -		long timeo;
>   		int data;
>   
> -		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
> -		data = tcp_msg_wait_data(sk, psock, timeo);
> +		if (sock_flag(sk, SOCK_DONE)) {
> +			ret = 0;
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_err) {
> +			ret = sock_error(sk);
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +			ret = 0;
> +			goto unlock;
> +		}
> +
> +		if (sk->sk_state == TCP_CLOSE) {
> +			ret = -ENOTCONN;
> +			goto unlock;
> +		}
> +
> +		if (!timeo) {
> +			ret = -EAGAIN;
> +			goto unlock;
> +		}
> +
> +		if (signal_pending(current)) {
> +			ret = sock_intr_errno(timeo);
> +			goto unlock;
> +		}
> +
> +		data = tcp_msg_wait_data(sk, psock, &timeo);
>   		if (data < 0) {
>   			ret = data;
>   			goto unlock;
> @@ -390,6 +425,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>   			sk_psock_put(sk, psock);
>   			return tcp_recvmsg(sk, msg, len, flags);
>   		}
> +		if (!data && timeo > 0)
> +			goto msg_bytes_ready;
>   		copied = -EAGAIN;
>   	}
>   	ret = copied;
