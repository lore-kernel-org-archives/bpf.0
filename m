Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA764E01E8;
	Mon, 21 Sep 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013227; cv=none; b=mMfwqGqick8JUQKD8Le7BG0UJQ7jzWknGQX1DC/Hy2ByuM35HZNImxRycrEdtAzIE6BU9d4FEdKQyc/ZEpvU3X1gMx/dFCxzwX3egz+KyVlDQiLTrSNs9g7I7qlbZAFQSQj6B/9FW6vj6dCN+bYn2D2yfOAtHjRWbaMC+TrMAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013227; c=relaxed/simple;
	bh=tY7Vd8NRFhLbocJtcET64P0RFG6F0Je7fr9qTGEZWMQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeAPihHvXByARyfwtDcCACeE8sw7LTibTLop/dHqYcUVyBSENJvU4Yr1k+8GRjVpY6i1rpmmBiLHR6RfqRj2Dfu1xxo++mB5LhJ2B5hTwdvvPmciKD+bTQr/8zGyufQ9nDWq43kZDgD+z7dj3ntESPRjbu3B6CO7T/vVwTp5cok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJzGxOTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJzGxOTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E97B1F000FF;
	Mon, 21 Sep 2026 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013225;
	bh=A8JVvGDjiKb+z6HfLLy8ux29yVX3go19GDF/iGG2Pig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YJzGxOTqGsEq1pXowPouLTYWNwN2Bezr9oOj6a9sfi05xaIKF8tO3D5i9x78AHjR/
	 5IORRaTw7or+dAfZIANQd9ZvTApeaLPkHIIq29c7NHDhmRuQtO1VLzz57xUqt/g4Ly
	 Yh8REUbY/nAkIzsr/kfAJSV6/K6l0OcvAegZbp0YlomHkt8ZQ54M9el6F9oM4b0zYN
	 RTmm+NszqUUnhQ6dB8o5qmI8X8mHMD5aY+myRnJ9zsIrfaWPtFcvRjiFxp2Pvhx2X8
	 73/DACb4r/XHfJFKX1DKlC+EVFX0rZtGn7f5QxFcwFAr6Zxn0NYUC4cnaBTL2rdOmy
	 xbySYwWXfazcQ==
Subject:
 Re: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx fallback
From: netdev-bot+sashiko@kernel.org
To: dw@davidwei.uk
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, willemb@google.com, liuhangbin@gmail.com,
 mkarsten@uwaterloo.ca, kerneljasonxing@gmail.com, bjorn@kernel.org,
 jakub@cloudflare.com, jiayuan.chen@linux.dev
Date: Mon, 21 Sep 2026 17:53:43 +0000
Message-ID: <179001322376.2160803.7069391663364625397@kernel.org>
In-Reply-To: <20260917172050.2191062-1-dw@davidwei.uk>
References: <20260917172050.2191062-1-dw@davidwei.uk>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tcp_tx_timestamp() (net/ipv4/tcp.c) gains an undocumented early
  return in the retransmit-queue fallback: `if (skb &&…
- [Medium] The new release/acquire publication protocol is bypassed by
  copy-on-write of skb_shared_info.

Pre-existing issues:
- [Low] Concern that __sock_tx_timestamp() (net/socket.c:767-783) and
  bpf_sock_ops_enable_tx_tstamp() (net/core/filter.c:12613-12620) now…

--

tcp: prevent stale tx timestamp keys on rtx fallback

This reorders the tskey/tx_flags stores in tcp_tx_timestamp() and
bpf_sock_ops_enable_tx_tstamp() so that tskey is written first and
tx_flags is published with smp_store_release(), and converts the
readers of tx_flags to smp_load_acquire()/READ_ONCE().  It also moves
tcp_has_tx_tstamp() from net/ipv4/tcp_output.c into include/net/tcp.h.

A few questions below.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 436495ff2271d..dccfa127d8c26 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1156,6 +1156,12 @@ struct tcp_skb_cb {
>  
>  #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
>  
> +static inline bool tcp_has_tx_tstamp(const struct sk_buff *skb)
> +{
> +	return TCP_SKB_CB(skb)->txstamp_ack ||
> +		(READ_ONCE(skb_shinfo(skb)->tx_flags) & SKBTX_ANY_TSTAMP);
> +}
> +
>  extern const struct inet_connection_sock_af_ops ipv4_specific;
>  
>  #if IS_ENABLED(CONFIG_IPV6)

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..ed6396704e114 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12611,9 +12613,11 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>  		return -EINVAL;
>  
>  	skb = skops->skb;
> -	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
> +	shinfo = skb_shinfo(skb);
> +	WRITE_ONCE(shinfo->tskey, TCP_SKB_CB(skb)->seq + skb->len - 1);
>  	TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
> -	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +	tx_flags = READ_ONCE(shinfo->tx_flags);
> +	smp_store_release(&shinfo->tx_flags, tx_flags | SKBTX_BPF);
>  
>  	return 0;
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but the split read-modify-write
here and in __sock_tx_timestamp() is still not atomic, and drivers modify
the same shinfo byte of an in-flight clone without any shared lock, for
example igb_xmit_frame_ring():

	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

Before this patch __sock_tx_timestamp() already did

	u8 flags = *tx_flags;
	...
	*tx_flags = flags;

and the SKBTX_BPF update was likewise a plain |=, so the window for a lost
bit is the same size as before; only the annotations changed.  Is it worth
noting in the changelog that these remain non-atomic updates, since the
new release annotation may read as if the update itself became safe?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 609f2c7f4a47a..56609fc28e8a5 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5718,20 +5721,23 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  	struct sk_buff *skb;
>  	bool tsonly, opt_stats = false;
>  	u32 tsflags;
> +	u8 tx_flags;
>  
>  	if (!sk)
>  		return;
>  
> -	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> +	tx_flags = smp_load_acquire(&skb_shinfo(orig_skb)->tx_flags);
> +	if (tx_flags & SKBTX_BPF)
>  		skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps,
>  						      sk, tstype);

[Severity: Medium]
Can the acquire here still see an inconsistent flags/tskey pair when the
shinfo was copied by copy-on-write in between?

The publication in tcp_tx_timestamp() targets the shinfo of an skb that
was already cloned and handed down, and a driver on the clone can reach
pskb_expand_head() via skb_cow_head()/skb_unclone(), which snapshots the
whole shinfo with no barrier and no flag test:

net/core/skbuff.c:pskb_expand_head() {
	...
	memcpy((struct skb_shared_info *)(data + size),
	       skb_shinfo(skb),
	       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->nr_frags]));
	...
}

tx_flags and tskey are separate fields in that copy, so on a weakly
ordered machine the copy can pick up the newly published tx_flags
together with the pre-publication tskey of 0.  After that the private
copy holds the inconsistent pair permanently, and this smp_load_acquire()
reads the copy rather than the original store, so serr->ee.ee_data ends
up as 0 minus sk_tskey - the same underflow the changelog describes.

Does the release/acquire pairing need to cover the shinfo copying paths
too, or does the metadata need to be set before the skb is handed down?

I should note the decisive step is a reordering inside memcpy() on the
copying cpu, which I can only argue is unprevented rather than
demonstrate.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 562752352afe4..ec4ee5e5d2dec 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -483,18 +483,21 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>  	struct sk_buff *skb = tcp_write_queue_tail(sk);
>  	u32 tsflags = sockc->tsflags;
>  
> -	if (unlikely(!skb))
> +	if (unlikely(!skb)) {
>  		skb = skb_rb_last(&sk->tcp_rtx_queue);
> +		if (skb && tcp_has_tx_tstamp(skb))
> +			return;
> +	}

[Severity: High]
Is this early return an intended behaviour change?  The changelog and the
v2 notes only describe reordering the tskey/tx_flags stores and adding
symmetric reader annotations, but this return also drops the timestamp
request belonging to the sendmsg() currently in progress.

The return sits above both the recording block and the sendmsg callback:

net/ipv4/tcp.c:tcp_tx_timestamp() {
	if (tsflags && skb) {
		...
		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
	}

	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
}

so when the rtx tail already carries any timestamp state, shinfo->tskey
keeps the byte offset recorded by the earlier sendmsg(), a newly
requested class is never armed through sock_tx_timestamp() or
tcb->txstamp_ack, and the callback is skipped even when sockc->tsflags
is 0.

The path that reaches the fallback is the one commit 838eb9687691 added
it for:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
	...
out:
	if (copied) {
		tcp_tx_timestamp(sk, &sockc);
		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
	}
	...
do_error:
	tcp_remove_empty_skb(sk);
	if (copied)
		goto out;
	...
}

With a first send arming the tail skb and a second send failing partway
(non blocking -EAGAIN from sk_stream_wait_memory(), or -ENOMEM), the
empty tail is removed, copied is non zero, and tcp_tx_timestamp() runs
with an empty write queue.  skb is then the armed rtx tail,
tcp_has_tx_tstamp() is true, and nothing is recorded for this send.

Since tcp_has_tx_tstamp() also tests txstamp_ack, does an earlier
SOF_TIMESTAMPING_TX_ACK-only request suppress a later
SOF_TIMESTAMPING_TX_SOFTWARE request on the same skb?  And with
SK_BPF_CB_TX_TIMESTAMPING, bpf_sock_ops_enable_tx_tstamp() sets
SKBTX_BPF and TSTAMP_ACK_BPF on every sendmsg, so the next send taking
this fallback loses BPF_SOCK_OPS_TSTAMP_SENDMSG_CB, which
include/uapi/linux/bpf.h documents as:

	BPF_SOCK_OPS_TSTAMP_SENDMSG_CB,	/* Called when every sendmsg syscall
					 * is triggered. It's used to correlate
					 * sendmsg timestamp with corresponding
					 * tskey.
					 */

Also, when the rtx tail has no timestamp bits set yet, tskey and
tx_flags are still written into a possibly already cloned shinfo, so
does this guard cover the case the changelog is about?

>  	if (tsflags && skb) {
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
>  		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>  
> -		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> +			WRITE_ONCE(shinfo->tskey, tcb->seq + skb->len - 1);
>  		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
>  			tcb->txstamp_ack |= TSTAMP_ACK_SK;
> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
>  	}

[ ... ]

> diff --git a/net/socket.c b/net/socket.c
> index c05d86e63abf7..d16e1f491f154 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -766,7 +766,7 @@ EXPORT_SYMBOL(sock_release);
>  
>  void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>  {
> -	u8 flags = *tx_flags;
> +	u8 flags = READ_ONCE(*tx_flags);
>  
>  	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
>  		flags |= SKBTX_HW_TSTAMP_NOBPF;
> @@ -780,7 +780,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>  	if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
>  		flags |= SKBTX_COMPLETION_TSTAMP;
>  
> -	*tx_flags = flags;
> +	smp_store_release(tx_flags, flags);
>  }
>  EXPORT_SYMBOL(__sock_tx_timestamp);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917172050.2191062-1-dw%40davidwei.uk
