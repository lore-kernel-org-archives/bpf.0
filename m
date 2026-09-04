Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1383B28D;
	Fri,  4 Sep 2026 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491004; cv=none; b=jT9I96w9f6EBGoEvEaHO+vdN8z3RHCM3ke82xxYg5qx0nt1srGH7uhpGUKqZc9dliZA5uwoSUxaocDAuWypR8CI9Ur182Y3lL+V+zXYJ6Phf8Pkc1BxHjay5dp5TBcFucce2qxH9CrtR1pfLM4BEtFAV3hEmwAPjdsVVKpxKT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491004; c=relaxed/simple;
	bh=pwiRQbyfMqVUFWm9PMMbAl+Xw5LrijKWVhj3KDC9z9M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9XneeK96P+VJWsrtRfSJV154Yp0p7i3odBqQni+rF31VqHgjqAk89JlcGvTzXTY0A1eqWiOVLt6DUunjfgSa3jffw5TotyTeZ58dWKbSCgr2LS6swjtBhg1Lz5sy+9BOl2RcZnSxy+NCC4bKdyfGAovcnqDMBdptyIFIKnAZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrNHg5o0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrNHg5o0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D241F00A3D;
	Fri,  4 Sep 2026 03:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491003;
	bh=tYn532goAvj6zjhWikeVegY2fGNjSiT+sKqhWolhvQk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RrNHg5o0zeGn4I1pylAbl4AYgwJpcPRDFhAFi9GEQOEK+eUiXw88YF+vw7eSDV+E7
	 d1+QapM2/AZlBORWEaOj6E++MGxSWEnLVxV4qcB7/YEVup1I+70lG1uY0vTgTT3geE
	 I8XI5fH0/Sv73igMhbB/YVi3dHFuutkcBJWYN4vRwrlQqgGTqY6V/xZGGWFwzuGbnv
	 TTDUqG6vxSRe8ed1CaZ+5EknDuMU4IsEV3UJeNWfGephaaTKTiA0cL+TNOg6AB34+h
	 DkqygT56Spv3vIwNCPcvmLIfB/40yqDteRPEcId2UvRlICECM/W2B75j3JRDTDGxbp
	 AgI6bbKNWAbkw==
Subject:
 Re: [PATCH] bpf, sockmap: Fix self-redirect copied_seq double-counting
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, tanggeliang@kylinos.cn,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 04 Sep 2026 03:03:21 +0000
Message-ID: <178849100183.4131868.10982082287561858713@kernel.org>
In-Reply-To: =?utf-8?q?=3Cb840c35fdfdf36e9fddedfa645b12699bc51aa34=2E1787968?=
 =?utf-8?q?065=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cb840c35fdfdf36e9fddedfa645b12699bc51aa34=2E17879680?=
 =?utf-8?q?65=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 0 · Low: 0

- [High] net/core/skmsg.c:1042-1047 (sk_psock_verdict_apply(),
  __SK_REDIRECT arm): the new self-redirect test compares only the…
- [High] net/core/skmsg.c:1042-1047 (sk_psock_verdict_apply()): for a
  self-redirect the patch drops the up-front tcp_eat_skb() and relies on…

--

bpf, sockmap: Fix self-redirect copied_seq double-counting

This changes the __SK_REDIRECT arm of sk_psock_verdict_apply() so that
tcp_eat_skb() is only called when the redirect destination differs from
psock->sk.  The intent is to avoid advancing tcp_sk->copied_seq twice when
a stream_verdict program redirects an skb back into the same socket's
ingress queue.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..5fa7b9639eef 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1039,10 +1039,14 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
>  				goto out_free;
>  		}
>  		break;
> -	case __SK_REDIRECT:
> -		tcp_eat_skb(psock->sk, skb);
> +	case __SK_REDIRECT: {
> +		struct sock *dst = skb_bpf_redirect_fetch(skb);
> +
> +		if (dst != psock->sk)
> +			tcp_eat_skb(psock->sk, skb);

[Severity: High]
The commit message describes the problem as "self-redirect with
BPF_F_INGRESS", but this test only compares the destination socket and
never looks at the direction.  Does the same-socket *egress* case end up
here too?

skb_bpf_redirect_fetch() in include/linux/skmsg.h masks the flag bits off:

  static inline struct sock *skb_bpf_redirect_fetch(struct sk_buff *skb)
  {
	unsigned long sk_redir = skb->_sk_redir;

	return (struct sock *)(sk_redir & BPF_F_PTR_MASK);
  }

and bpf_sk_redirect_map() in net/core/sock_map.c stores the direction
separately, allowing flags == 0:

	if (unlikely(flags & ~(BPF_F_INGRESS)))
		return SK_DROP;
	...
	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);

So a program doing bpf_sk_redirect_map(skb, &sock_map, idx, 0) where
sock_map[idx] resolves to the source socket satisfies dst == psock->sk and
skips tcp_eat_skb().

For that egress case nothing later advances copied_seq.  sk_psock_backlog()
computes:

		ingress = skb_bpf_ingress(skb);

which is false, so sk_psock_handle_skb() takes the transmit path:

		return skb_send_sock(psock->sk, skb, off, len);

and the skb is freed.  It never becomes an sk_msg with msg->sk == sk, so
the from_self accounting in __sk_msg_recvmsg():

		from_self = msg_rx->sk == sk;

never runs, and neither does the copied_from_self path in
tcp_bpf_recvmsg_parser() that the commit message relies on.

Meanwhile tcp_read_skb() already removed the bytes from the receive queue
without touching tp->copied_seq:

		__skb_unlink(skb, &sk->sk_receive_queue);

Can this leave tp->copied_seq permanently behind tp->rcv_nxt, so that
SIOCINQ reports data that no longer exists, __tcp_cleanup_rbuf() and
tcp_rcv_space_adjust() never run for those bytes, tcp_close() sees
data_was_unread != 0 and sends an RST instead of a FIN, and a later plain
tcp_recvmsg_locked() (after the psock is dropped) trips

	WARN(before(*seq, TCP_SKB_CB(skb)->seq), "TCP recvmsg seq # bug...

that is, the same copied_seq desync in the opposite direction?

Worth noting that the program cited as validation,
tools/testing/selftests/bpf/progs/mptcp_sockmap.c, uses exactly the egress
form:

	return bpf_sk_redirect_map(skb, &sock_map, redirect_idx, 0);

Would adding the direction to the condition cover this, e.g.

	if (dst != psock->sk || !skb_bpf_ingress(skb))
		tcp_eat_skb(psock->sk, skb);

[Severity: High]
A second question about the same condition: the accounting is now skipped
before the outcome of the redirect is known.  Is it guaranteed that the skb
really reaches ingress_msg and is read by tcp_bpf_recvmsg_parser()?

sk_psock_skb_redirect() has drop paths that free the skb and return -EIO
without any copied_seq update, and for a self-redirect psock_other is this
very same psock:

  net/core/skmsg.c:sk_psock_skb_redirect() {
	...
	if (!psock_other || sock_flag(sk_other, SOCK_DEAD)) {
		skb_bpf_redirect_clear(skb);
		sock_drop(from->sk, skb);
		return -EIO;
	}
	spin_lock_bh(&psock_other->ingress_lock);
	if (!sk_psock_test_state(psock_other, SK_PSOCK_TX_ENABLED)) {
		spin_unlock_bh(&psock_other->ingress_lock);
		skb_bpf_redirect_clear(skb);
		sock_drop(from->sk, skb);
		return -EIO;
	}
	...
  }

SK_PSOCK_TX_ENABLED can already be clear while sk->sk_data_ready is still
sk_psock_verdict_data_ready, because sk_psock_backlog() clears it on a hard
transmit/ingress error:

			if (ret == -EAGAIN) {
				...
			} else {
				sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
				...
			}

and sk_psock_stop() clears it during close/map-delete before the socket
backlog is drained.  The __SK_PASS arm just above tests the same two states
(SOCK_DEAD and !SK_PSOCK_TX_ENABLED), so they appear reachable at this
point.

Even after a successful skb_queue_tail(), skbs still on ingress_skb are
purged without accounting:

  net/core/skmsg.c:__sk_psock_zap_ingress() {
	while ((skb = skb_dequeue(&psock->ingress_skb)) != NULL) {
		skb_bpf_redirect_clear(skb);
		sock_drop(psock->sk, skb);
	}
	...
  }

and __sk_psock_purge_ingress_msg() frees queued sk_msgs the same way.

In all of these cases tcp_read_skb() has already unlinked the bytes from
sk->sk_receive_queue, and tcp_eat_skb() is the only place that catches up:

  net/ipv4/tcp_bpf.c:tcp_eat_skb() {
	copied = tcp->copied_seq + skb->len;
	WRITE_ONCE(tcp->copied_seq, copied);
	tcp_rcv_space_adjust(sk);
	__tcp_cleanup_rbuf(sk, skb->len);
  }

Note the sibling drop arm in this same switch keeps that contract:

  out_free:
		skb_bpf_redirect_clear(skb);
		tcp_eat_skb(psock->sk, skb);
		sock_drop(psock->sk, skb);

Should the skipped accounting be performed on the redirect-failure and
purge paths as well, or should tcp_eat_skb() only be skipped once the skb
is known to have been retained for same-socket ingress consumption?

>  		err = sk_psock_skb_redirect(psock, skb);
>  		break;
> +	}
>  	case __SK_DROP:
>  	default:
>  out_free:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang%40kylinos.cn
