Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB1373BEC;
	Fri,  8 May 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236670; cv=none; b=EMN+n8Dh6UGqNGheHQiNU6I+K43VnLPzt/P8/qXKX/Qwrj/HOFNLF5acUkdujuNplGs52o88jyBBOrFh868LU0P0ifyBghnGx/HDwO5fd7EOP5FM8/VokNDltDEILLougzSvYJtDDK4ZZy8HdmtgtbFK7D4m+yXMumuzbyXmcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236670; c=relaxed/simple;
	bh=PBLzax5+O8KVt78kjB99U2xa1drvmseggjVC2lifs3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ikg/H0GCiP3XLu7G7boElydGaHkXZc2IMlEMK+tBaTwezw1rvf4LZwogVDWHXOtEg2Jg18Z45Hwq6BAo4cPMFzieZgvoEh32S3oUAcw/atFysPcGPv8lauICoB9SmoWI6LwMmyAak3IWYx1LldTHAZFKDnQuCCSib9g5BZ01Mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21ee2d5d-fc8c-497e-aa98-e5e4e3fbecf8@linux.dev>
Date: Fri, 8 May 2026 18:37:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-8-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260508073355.3916746-8-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/8/26 3:33 PM, Kuniyuki Iwashima wrote:
> Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
>
> Let's invoke the BPF SOCK_OPS prog when
>
>    1. TCP stack enqueues skb to sk->sk_receive_queue
>       -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
>
>    2. TCP recvmsg() completes
>       -> __tcp_cleanup_rbuf()
>
> This will allow the BPF prog to parse each skb and dynamically
> adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> until sufficient data (e.g., a full RPC frame) is available
> in the receive queue.
>
> Note that the direct access to bpf_sock_ops.data is intentionally
> disabled by passing 0 as end_offset.
>
> Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> with bpf_sock_ops because payload is not in the linear area
> with TCP header/data split on and skb may contain a RPC
> descriptor in skb frag.  This also simplifies the BPF prog.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   include/net/tcp.h       | 14 ++++++++++++++
>   net/ipv4/tcp.c          |  2 ++
>   net/ipv4/tcp_fastopen.c |  2 ++
>   net/ipv4/tcp_input.c    | 10 ++++++++++
>   4 files changed, 28 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4e9e634e276b..003e46c9b500 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock
>   }
>   #endif
>   
> +#ifdef CONFIG_CGROUP_BPF
> +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> +
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_FLAG))
> +		bpf_skops_rcvlowat(sk, skb);
> +}
> +#else
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +}
> +#endif
> +
>   /* From net/ipv6/syncookies.c */
>   int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
>   struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1d9e52fc454f..80144b97a87a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
>   		tcp_mstamp_refresh(tp);
>   		tcp_send_ack(sk);
>   	}
> +
> +	tcp_bpf_rcvlowat(sk, NULL);
>   }
>   

tcp_read_skb (process frame 1 and __skb_unlink)
└─ sk_psock_verdict_recv
     └─ sk_psock_verdict_apply
         └─ tcp_eat_skb
             └─ tcp_cleanup_rbuf
                 └─ __tcp_cleanup_rbuf
                     └─ BPF RCVLOWAT_CB
                         └─ bpf_sock_ops_tcp_set_rcvlowat (wakeup=true)
                             └─ tcp_data_ready
                                 └─ sk_psock_verdict_data_ready
                                     └─ tcp_read_skb (frame 2)
                                         └─ ... → tcp_read_skb (frame 3) ...

For strparser it use read_sock instead of read_skb and it will become 
more complicated...

I think this will cause stack overflow with amounts of skbs in receive 
queue or infinite call(not tested) for sockmap/kTLS/strparser.

