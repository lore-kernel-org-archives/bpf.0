Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF431F9B3
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658216; cv=none; b=B1UyKfx07Qj1lBLLXZOTHK/5rM18HNywGQfRaBaoJA8J/+sTgATnXEvbMerRRajpAPyZ2FKmMgLof+fcUqy0MsZoGRiX+LDNnQOxjsgNw9y1dMP4oi1r45ZlpVDgbOXO7S+2j2BmLTNyadxHW5VUQDQYek116F0UGRorgRJq5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658216; c=relaxed/simple;
	bh=hY2dkKZdaw5KDnLwG6KL0YJAym/kj9aoWwirD08atPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPpMUQXvi0PTm30UQu3qRn+IaxrIxGYSzbOj+VkHRS4aSw6TMPj2jMedLbYl98yHefdMMGyA8y0PKEclQw8s1kTwsl5034BwIRk3M2wXAfxVTmFECVjims0Xoi1xCt25cHmJTalFcbHfjYc/14zd4wDnfwGwC2qQs9VtvDC+UL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVMH6nL9; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SVMH6nL9"
Message-ID: <b8f1b021-a255-4464-b1fa-559e8d961bb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780658202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRi6sWFcubB1ojJimFMtoX8Dt81siLGPz4iTPkPpfDo=;
	b=SVMH6nL9j0dn8Y1fG51izBEhOyssE7us5u35W9iPZzvYVmsw53qGEhQkkHR4TUIMszMf+f
	fFpDoBo8qImdJGFx51l53m6EDR7tgyKhaYfdgkG2AtVEx7EOoZYY0j/GUqoUSOwFHyRjga
	ykxFIKDafnvJHPz25U4aOwMeCwaRhZY=
Date: Fri, 5 Jun 2026 19:16:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] tcp: clear sock_ops cb flags before force-closing a
 child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Lawrence Brakmo <brakmo@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/5/26 5:49 PM, Sechang Lim wrote:
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
>
>    WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>    RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>    Call Trace:
>     <IRQ>
>     tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>     tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>     tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>     tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>     </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags before the forced close.
>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>   include/net/tcp.h   | 7 +++++++
>   net/ipv4/tcp_ipv4.c | 1 +
>   net/ipv6/tcp_ipv6.c | 1 +
>   3 files changed, 9 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 98848db62894..97eac5fa341c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>   	return tcp_call_bpf(sk, op, 3, args);
>   }
>   
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> +{
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
> +}
> +
>   #else
>   static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>   {
> @@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>   	return -EPERM;
>   }
>   
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
> +
>   #endif
>   
>   static inline u32 tcp_timeout_init(struct sock *sk)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..7748668dba82 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1783,6 +1783,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>   	return NULL;
>   put_and_exit:
>   	newinet->inet_opt = NULL;
> +	tcp_clear_sock_ops_cb_flags(newsk);
>   	inet_csk_prepare_forced_close(newsk);


I prefer clearing the bit in inet_csk_prepare_forced_close(), since it 
looks like inet_csk_prepare_forced_close()
is already a TCP-specific function.

Let's wait for the TCP maintainer's.


>   	tcp_done(newsk);
>   	goto exit;
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 36d75fb50a70..493477b786db 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1531,6 +1531,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>   	tcp_listendrop(sk);
>   	return NULL;
>   put_and_exit:
> +	tcp_clear_sock_ops_cb_flags(newsk);
>   	inet_csk_prepare_forced_close(newsk);
>   	tcp_done(newsk);
>   	goto exit;
