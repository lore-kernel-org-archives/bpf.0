Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CC455175;
	Sun, 11 Oct 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731409; cv=none; b=LaSbal8icBerEy0bGRTvyGosysnlBlPAFoDtg0J7XdR5Znem9TVWsm3ABlJz7QiiOKh31kHYqhzRkqWndTlU4j7n+Q/YGQdeAkLdti+nkAq8Ag9GWhpKjZZ7a8yUCQZmUARissRVYK46oXLb80fusRfVoDyk13qzIb866HMjwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731409; c=relaxed/simple;
	bh=WcfdVL47eY/D8J8hmuuuYu69qF74dce9RPnFfBtvfcA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bA56OSneWuZ67ncUcplHiAgfHA7EjViBfe7AK7oxTH2Ec9gGo3IdZqI70jIlgnc940Tj1zUZgJRagxKhNLRHbgWkfxtTTAFmUMPKl3XoWV4Vf060VVqvYeq7JaYy4XwrfywET+QwCIMlKnBGwTxCqNNhx35EqklqD7S4kU9CXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEmfiL5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEmfiL5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DD1F0089C;
	Sun, 11 Oct 2026 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791731408;
	bh=kDL5vJbZRvsNTnyNk04ZJa/LPv+tq85KWybXJ8VOpWQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QEmfiL5OJ2yZneq1rZj9VBwWT684C+5cQ7TJAicRL16ETb8r3GFaymT8J9T/iIwdd
	 mwBA7Jmh7pfpd51hNugmV2MDBqTBXTuWi38bnkAZ23zxxcJcJHS0aD0eYfRKd+JjmQ
	 Pk8OdszhybWpExBeFYXyCGRA9ekyvuv3M6UzUG11IllfEFPZr095XdtV5h88Uvsqht
	 Xra7JHFXDpBIrwqb6iEdFJlR/q9fO6HnOc5Nir7SvPp+LK0rBZQx5fi2nN9o5vGFV+
	 GvJ8bSFxiefApPIel4qw50o1+l81HBFivDjUvY9cG99cJMTjd6NK10n8S83jIAkagh
	 x0UR/tELDmwCg==
Subject:
 Re: [PATCH net-next v3 2/2] net: annotate lockless writes to sk->sk_err
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 15:10:06 +0000
Message-ID: <179173140698.434549.7333602875262073825@kernel.org>
In-Reply-To: <20261010-tls-fix-sk-kcsan-err-v3-2-e28aadeb31ad@proton.me>
References: <20261010-tls-fix-sk-kcsan-err-v3-2-e28aadeb31ad@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch does not annotate every sk_err writer on the TCP
  socket that strparser uses.

Pre-existing issues:
- [Medium] In net/kcm/kcmsock.c, report_csk_error(struct sock *csk, int
  err) ignores its `err` argument and always stores EPIPE (line 54).
- [Low] The inet_sk_error_report tracepoint
  (include/trace/events/sock.h:215) copies sk->sk_err with a plain load:…

--

net: annotate lockless writes to sk->sk_err

This commit changes the plain stores to sk->sk_err in
sock_dequeue_err_skb(), strp_abort_strp() and sk_psock_report_error() to
WRITE_ONCE(). sock_error() and getsockopt(SO_ERROR) clear the field with
xchg() without the socket lock, and TCP, MPTCP and kTLS read it with
READ_ONCE().

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d56f4f0102f75..a6c9cf57bc3bf 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5539,12 +5539,13 @@ struct sk_buff *sock_dequeue_err_skb(struct sock *sk)
>  	if (skb && (skb_next = skb_peek(q))) {
>  		icmp_next = is_icmp_err_skb(skb_next);
>  		if (icmp_next)
> -			sk->sk_err = SKB_EXT_ERR(skb_next)->ee.ee_errno;
> +			WRITE_ONCE(sk->sk_err,
> +				   SKB_EXT_ERR(skb_next)->ee.ee_errno);
>  	}
>  	spin_unlock_irqrestore(&q->lock, flags);
>  
>  	if (is_icmp_err_skb(skb) && !icmp_next)
> -		sk->sk_err = 0;
> +		WRITE_ONCE(sk->sk_err, 0);
>  
>  	if (skb_next)
>  		sk_error_report(sk);

[Severity: Low]
This is a pre-existing issue, but sk_error_report() here runs after q->lock
has been dropped. For AF_INET/AF_INET6 sockets it calls the
inet_sk_error_report tracepoint, and that tracepoint reads the field with a
plain load:

include/trace/events/sock.h:inet_sk_error_report {
    ...
	__entry->error = sk->sk_err;
    ...
}

When tracing is enabled, can this race with sock_error()'s xchg() or with
the WRITE_ONCE() writers on another CPU? The worst result looks like a
stale errno in the trace event. Should this read also be a READ_ONCE()?

[ ... ]

> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index 9c1559d7923f2..5f1da32b152fc 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -56,7 +56,7 @@ static void strp_abort_strp(struct strparser *strp, int err)
>  	strp->need_bytes = 0;
>  
>  	/* Report an error on the lower socket */
> -	sk->sk_err = -err;
> +	WRITE_ONCE(sk->sk_err, -err);
>  	sk_error_report(sk);
>  }

[Severity: Medium]
Does this cover every writer on the TCP sockets that strparser runs on?

KCM attaches the strparser to the same lower TCP socket:

net/kcm/kcmsock.c:kcm_attach() {
    ...
	err = strp_init(&psock->strp, csk, &cb);
    ...
	csk->sk_state_change = psock_state_change;
    ...
}

KCM still reports errors on that socket with a plain store:

net/kcm/kcmsock.c:report_csk_error() {
	csk->sk_err = EPIPE;
	sk_error_report(csk);
}

Two paths reach this store:

  kcm_abort_tx_psock(), after mux->lock is dropped (callers are
  kcm_write_msgs(), kcm_unattach() and kcm_release())

  psock_state_change(), which is the csk->sk_state_change callback

None of these paths holds the lock of the lower TCP socket. Userspace still
holds the TCP fd, so getsockopt(SO_ERROR) or recvmmsg() can xchg() the
field at the same time, while tcp_poll() reads it with READ_ONCE().

Should report_csk_error() get the same WRITE_ONCE() treatment?

smc_clc_wait_msg() has similar plain stores to the TCP clcsock's sk_err.
They run after sock_recvmsg() returns, without the socket lock:

net/smc/smc_clc.c:smc_clc_wait_msg() {
    ...
		clc_sk->sk_err = EINTR;
    ...
			clc_sk->sk_err = 0; /* reset for fallback usage */
    ...
}

UDP, raw and ping sockets also use sock_dequeue_err_skb(), through
ip_recv_error()/ipv6_recv_error(). On those sockets the other writers are
still plain stores. Examples are __udp4_lib_err(), udp_abort(),
__udp6_lib_err(), raw_err(), raw_abort(), the IPv6 raw error path in
net/ipv6/raw.c, and ping_err().

The subject line reads as a general annotation of lockless sk_err writes,
but the body doesn't say that the conversion is partial. Could the commit
message say what is left for follow-ups?

[Severity: Medium]
This isn't a bug introduced by this patch, but report_csk_error() above
never uses its err argument and always stores EPIPE.

kcm_tx_work() logs the real error and passes it in:

net/kcm/kcmsock.c:kcm_tx_work() {
    ...
		pr_warn("KCM: Hard failure on kcm_write_msgs %d\n", err);
		report_csk_error(&kcm->sk, -err);
    ...
}

kcm_sendmsg() and kcm_abort_tx_psock() pass their error values the same
way, and those values are dropped too.

Is it intended that userspace always sees EPIPE through SO_ERROR here,
rather than the actual transmit error? This behaviour goes back to the
original KCM code.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad%40proton.me
