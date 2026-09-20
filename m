Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7798456E04;
	Sun, 20 Sep 2026 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939004; cv=none; b=KGTSpyJ1xKgY/9ILExYfS5/O0I8vGMDMqoi7O3N5o1/VbraM+IORbudFO0h9Za4gB8m8mlppA5NDVoOLtHYKwMY2e2H0Cs+4zWkQ8j+B3x7iQxV8TnWgyElc4GdRTDK5HWKYhznijiWo0oT8XVKHd5kkLCoMjfxjSZOeYVnuLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939004; c=relaxed/simple;
	bh=kx55kT3bKj10jHdfEaFKrtXmbLQzoa/51FWF0mZu1Ns=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SFz+1+bWx1rJCho7L7Xd2vW2S+2U7DeI/HgJ+Zg+dJuyf8STR6rWg8Ym6kkYNnaxGZnZ8Hone2qdjqSmka1QGB6ICIJs1tDMDRwKR7mYppCdNZLpY+5tYPgWe7okpFxsrX5GBqZp6RIQFXvk6N2jrWnVbGXIzOH6cgXu0jVtqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7QHwwP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7QHwwP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1FA1F000FF;
	Sun, 20 Sep 2026 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789939002;
	bh=PBGInfjkwxwAGUnEe8tY1hoZnVx7snPkf2oCVB+ndIQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y7QHwwP7fuZyFJzHNNBOz6JFvKrpdwpV6KCkIpbtYYv8NrOzF0Mz9q4+f8LvICAUz
	 tFMJdNNNRgIBkmotIt8rUgTj6mz5m1Qa1y3ZeHCgsj7S0aX+DaggeoXWkigWiqhJol
	 eJmHDXOXwPnjdJkBpbmTDfmbVofAX4mJ+RWO+1GO6OIOFoZq7A36usmhXY0aFzvRkj
	 dG1okwc2i9ZVwSXyaeW72v1SmQoswREv1uLAxuhQh0+DcLJBH8SmzlBHR7CcEby+HY
	 1eY3zRhsyUWgYTMnDwXHQFgnvCTpKwhdix/o2oLE5MQwbOlfNV+BzYYy0BX2DEKsfI
	 rqYKpsn3D2ZQg==
Content-Type: multipart/mixed; boundary="===============0464181429910322057=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dade43647238ac35540c960adf4a484b8ac4c5b597cb4c7365b53f2b57cbe3f7@mail.kernel.org>
In-Reply-To: <20260920195633.3033620-3-kuniyu@google.com>
References: <20260920195633.3033620-3-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 21:16:40 +0000 (UTC)

--===============0464181429910322057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d61ee00052e33..f2d838bcb0a7f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3053,6 +3053,12 @@ struct bpf_tcp_ops {
>  			      struct request_sock *req, struct sk_buff *syn_skb,
>  			      enum tcp_synack_type synack_type,
>  			      u32 opt_off);
> +
> +	/* Called when an incoming skb is enqueued to sk->sk_receive_queue. */
> +	void (*enqueue_rcvq)(struct sock *sk, struct sk_buff *skb);
> +
> +	/* Called after data is dequeued from sk->sk_receive_queue. */
> +	void (*dequeue_rcvq)(struct sock *sk);
>  };
>
>  #define bpf_tcp_ops_call(op, sk, ...)					\
> @@ -3144,6 +3150,18 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
>  	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
>  }
>
> +static inline void bpf_tcp_ops_enqueue_rcvq(struct sock *sk, struct sk_buff *skb)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		bpf_tcp_ops_call(enqueue_rcvq, sk, skb);
> +}
> +
> +static inline void bpf_tcp_ops_dequeue_rcvq(struct sock *sk)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		bpf_tcp_ops_call(dequeue_rcvq, sk);
> +}
> +

[ ... ]

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a4456b4194122..a714b36a74940 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1610,6 +1610,8 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
>  	     "cleanup rbuf bug: copied %X seq %X rcvnxt %X\n",
>  	     tp->copied_seq, TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt);
>  	__tcp_cleanup_rbuf(sk, copied);
> +
> +	bpf_tcp_ops_dequeue_rcvq(sk);
>  }

The comment at the top of the file documents dequeue_rcvq() as "Called
after data is dequeued from sk->sk_receive_queue". Is it accurate to
invoke this callback unconditionally at the tail of tcp_cleanup_rbuf()?

Looking at the callers, tcp_cleanup_rbuf(sk, copied) is invoked:

1. From __tcp_sock_set_quickack():

net/ipv4/tcp.c:__tcp_sock_set_quickack() {
    ...
    tcp_cleanup_rbuf(sk, 1);
}

This call forces an ACK from setsockopt(TCP_QUICKACK) or TCP_NODELAY
without touching the receive queue.

2. From tcp_recvmsg_locked() with copied == 0:

net/ipv4/tcp.c:tcp_recvmsg_locked() {
    ...
    tcp_cleanup_rbuf(sk, copied);
    ...
    sk_wait_data(sk, &timeo, last);
}

This happens before sk_wait_data() when no data has been dequeued yet.

3. From tcp_recvmsg_locked() with MSG_PEEK:

The final tcp_cleanup_rbuf(sk, copied) runs with copied > 0, but the
skbs remain queued and copied_seq is unchanged because MSG_PEEK leaves
the data in the queue.

With the kfunc added later in the series, dequeue_rcvq() can call
__tcp_set_rcvlowat(..., wakeup=true), which triggers tcp_data_ready()
-> sk->sk_data_ready(). If a BPF program lowers sk_rcvlowat from the
dequeue_rcvq() callback, would these no-dequeue paths cause spurious
EPOLLIN wakeups that the feature is meant to suppress?

Should the hook be gated on an actual dequeue (copied > 0 and not
MSG_PEEK), or should the documented contract be adjusted?

[ ... ]

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 6ac6f9d5b6c38..c60c61bb0a715 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5344,6 +5344,8 @@ static void tcp_ofo_queue(struct sock *sk)
>  			continue;
>  		}
>
> +		bpf_tcp_ops_enqueue_rcvq(sk, skb);
> +
>  		tail = skb_peek_tail(&sk->sk_receive_queue);
>  		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
>  		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
> @@ -5547,6 +5549,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
>  	int eaten;
>  	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
>
> +	bpf_tcp_ops_enqueue_rcvq(sk, skb);
> +
>  	eaten = (tail &&
>  		 tcp_try_coalesce(sk, tail,
>  				  skb, fragstolen)) ? 1 : 0;

In tcp_queue_rcv(), bpf_tcp_ops_enqueue_rcvq(sk, skb) is invoked after
tail has been cached from sk->sk_receive_queue but before tail is
dereferenced by tcp_try_coalesce(). Can the BPF callback synchronously
drain sk->sk_receive_queue, leaving tail pointing at freed memory?

Concrete path (verified in this commit):

1. net/ipv4/bpf_tcp_ops.c only blocks bpf_setsockopt() for
rwnd_init/timeout_init/hdr_opt_len/write_hdr_opt:

net/ipv4/bpf_tcp_ops.c:bpf_tcp_ops_get_func_proto() {
    case BPF_FUNC_setsockopt:
        if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) || ... write_hdr_opt))
            return NULL;
        return &bpf_sk_setsockopt_proto;
}

enqueue_rcvq is not in the blocked list, so a prog attached to
.enqueue_rcvq may call bpf_setsockopt(). The commit message states the
intended use is to adjust sk->sk_rcvlowat, so
bpf_setsockopt(SOL_SOCKET, SO_RCVLOWAT, ...) is permitted.

2. bpf_sk_setsockopt -> _bpf_setsockopt -> __bpf_setsockopt ->
sol_socket_sockopt() accepts SO_RCVLOWAT and calls sk_setsockopt().

3. sk_setsockopt() SO_RCVLOWAT calls tcp_set_rcvlowat() for a TCP
socket with a non-NULL sk->sk_socket.

4. tcp_set_rcvlowat() calls tcp_data_ready(sk):

net/ipv4/tcp.c:tcp_set_rcvlowat() {
    ...
    tcp_data_ready(sk);
}

net/ipv4/tcp_input.c:tcp_data_ready() {
    if (tcp_epollin_ready(sk, sk->sk_rcvlowat) || sock_flag(sk, SOCK_DONE))
        READ_ONCE(sk->sk_data_ready)(sk);
}

Since tail != NULL means unread bytes are queued, rcv_nxt - copied_seq >
0, and the prog chooses the new (small) rcvlowat, tcp_epollin_ready()
returns true.

5. For a socket whose sk_data_ready drains the receive queue:

SOCKMAP verdict mode: sk_psock_verdict_data_ready() ->
tcp_read_skb() unlinks and consumes every queued skb:

net/core/skmsg.c:sk_psock_verdict_data_ready() {
    ...
    ops->read_skb(sk, sk_psock_verdict_recv);
}

net/ipv4/tcp.c:tcp_read_skb() {
    while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
        ...
        __skb_unlink(skb, &sk->sk_receive_queue);
        ...
        if (used < 0 || !skb->len) {
            tcp_eat_recv_skb(sk, skb);
            ...
        }
        ...
    }
}

There is no pause, ownership guard, or re-entrancy protection.

SOCKMAP strparser/kTLS: sk_psock_strp_data_ready() ->
strp_data_ready() -> strp_read_sock() -> tcp_bpf_strp_read_sock() ->
tcp_eat_recv_skb() -> __skb_unlink() + __kfree_skb()/
skb_attempt_defer_free(). strp_data_ready() only defers to a workqueue
when the socket is owned by a user; in the softirq receive path it runs
inline.

6. Control returns to tcp_queue_rcv(), which then evaluates:

eaten = (tail && tcp_try_coalesce(sk, tail, skb, fragstolen)) ? 1 : 0;

tcp_try_coalesce() immediately dereferences the stale pointer:

net/ipv4/tcp_input.c:tcp_try_coalesce() {
    if (TCP_SKB_CB(to)->end_seq != TCP_SKB_CB(from)->seq)
        return false;
    ...
}

This causes a use-after-free if the skb was freed, or silent data
duplication/loss plus sk_rmem_alloc mis-accounting if the skb was
unlinked but not yet freed (handed to the psock ingress queue).

Note that the sibling hook in tcp_ofo_queue() is not affected because
tail is read *after* bpf_tcp_ops_enqueue_rcvq(). Would reading tail
after the callback in tcp_queue_rcv() as well close this window? The skb
being queued is still owned by the caller and is not on any queue, so it
cannot be consumed by the nested drain.

Also note that bpf_sk_setsockopt_nodelay_proto was introduced
specifically to block TCP_NODELAY because "TCP_NODELAY triggers
tcp_push_pending_frames() and re-enters CA_EVENT_TX_START in
bpf_tcp_cc", but bpf_tcp_ops uses the unfiltered
bpf_sk_setsockopt_proto. Is this difference intentional?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35535082194
--===============0464181429910322057==--
