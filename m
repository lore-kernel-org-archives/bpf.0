Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092446;
	b=BlOSeIzVm6SZKYV8WntRcs1TXmgr7W9EIQgVASZsPpPJwn9oPlBQ97OgPIBQJyDaBicp
	 mxR3tgcj49CdhMFc3q5AxZjRtfIFbU+OgXnGwfDSBpuDw4VV5rl94ESRwOoXvzkWeKjA1
	 3Sw51dF3CdQTl/hhVwW2+g5UTBS8DhHw60jrgSDgRsrNYM21t5xmULw+6U/fjVkzIXAq3
	 6l5Ysw0AZJcmO3Y4SacvIuOer09JZWuUd0AvK2gBR+AOjTNjwr9LpXahh+8thrsJz2U5t
	 x7Kd7/rJVmA39BQIZynrkF987rVf9hVs0JY8ZqeFchTeYr2o17bLKofZN3lbTqp7LlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092446;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rVqv6cMnMJmJyMaeUNnqrTWyRG9aoHyUEoKzK90L2Yc=;
	b=alCayhQSqniz8NgAVq6lO5OF9rjMycLZrf361x8vCXoIFM1P186/s+PRqeAQYN0U6FbF
	 0IwT/Yk/3vvlHxMppBXpG6D/eQ2ESx4BiXA8Jp0ztdnPWBHliADWdjZOlI44gboNWpLDC
	 0YO9PvwPYe7PwGgKFAesTz7oQqpVQHaGVZMH3WrO8UmOCE8YvMvulTeW2Sdt9SNFUfJ7P
	 bws11zKSg9sN6uzHz/qacKWyUafqHu7RyN5kJK8neFSNe8f1/l/1PC3L4D7Afy1P4hF75
	 +YYYVecp/XUs9RV5dWgeOJWqhkhEgl+vFRb6IGHDgw0ynIhUnStdjMjE0MZUVz8c97A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf9C+Lfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BD606A32A;
	Thu, 19 Nov 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf9C+Lfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03CB1F000C4;
	Thu, 19 Nov 2026 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795092445;
	bh=rVqv6cMnMJmJyMaeUNnqrTWyRG9aoHyUEoKzK90L2Yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kf9C+LfxLK+jbKCM/dMadCkX6r2Bp8cYJ0gIjnVucPSfgIhGGx6ZoqrKwt/tzmsme
	 EiAAxB4ywBXraUF+7/OzMrFMpRhzc+MxLhuWSifQX95xpIkYVh5OrdXR4VuiMfC6xy
	 J6kuCARjxacBn28iYfgZjo8o4DhW7CeaM469B3BAalrbo/qDeUwqbbi690SnmDlmp9
	 3tx/HcVdk/ooRIs78YqHXt6JnMkni/evh0I16OGR/Vb09ojHVApwyAE7fnD/2dKObS
	 /mdrdX891R4yXi+HMsjjdWbxmd4fSjTedVmg2hy1pxDhZ/1u5q6MxLaDnb0vOlJ5+1
	 ujPEvt+6I+maQ==
Subject: Re: [PATCH net v3 2/2] tcp: accecn: initialize AccECN fields in
 syncookie path
From: netdev-bot+sashiko@kernel.org
To: thaisonphan@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ij@kernel.org, olivier.tilmans@nokia.com,
 chia-yu.chang@nokia-bell-labs.com, stani@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Nov 2026 12:47:24 +0000
Message-ID: <179509244451.3136.7632749576749189281@kernel.org>
In-Reply-To: <20261117124710.1338951-3-thaisonphan@google.com>
References: <20261117124710.1338951-3-thaisonphan@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the BPF custom-syncookie path (bpf_sk_assign_tcp_reqsk() ->
  cookie_bpf_check()), the patch sets syn_ect_snt from a SYN-ACK the…
- [Medium] tcp: accecn: missing 3rd ACK option init in
  cookie_tcp_reqsk_init()

--

tcp: accecn: initialize AccECN fields in syncookie path

This patch initializes saw_accecn_opt, accecn_fail_mode and syn_ect_rcv in
cookie_tcp_reqsk_init(). That function is shared by the regular syncookie
path and the bpf_sk_assign_tcp_reqsk() path. The patch also sets
syn_ect_snt from the listener's TOS/tclass in cookie_{v4,v6}_check(), to
match what tcp_{v4,v6}_send_synack() would have sent on the wire.

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 4e0ff3b820627..1a837ed6efa00 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -290,6 +290,9 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
>  	 */
>  	treq->txhash = treq->snt_isn;
>  	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
> +	treq->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
> +	treq->accecn_fail_mode = 0;
> +	treq->syn_ect_rcv = 0;
>  
>  #if IS_ENABLED(CONFIG_MPTCP)
>  	treq->is_mptcp = sk_is_mptcp(sk);
> @@ -502,6 +505,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  		ireq->rcv_wscale = rcv_wscale;
>  	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
>  	treq->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
> +	treq->syn_ect_snt = READ_ONCE(inet_sk(sk)->tos) & INET_ECN_MASK;

[Severity: Medium]
Does the syncookie path ever look at the AccECN option carried on
the third ACK?

On the normal SYN-RECV path, tcp_openreq_init() also sets
saw_accecn_opt to TCP_ACCECN_OPT_NOT_SEEN. tcp_check_req() then
checks tmp_opt.accecn on the third ACK and calls
tcp_accecn_option_init() before syn_recv_sock() runs. That updates
tcp_rsk(req)->saw_accecn_opt and, when the option was zeroed, ORs
TCP_ACCECN_OPT_FAIL_RECV into accecn_fail_mode.
tcp_ecn_openreq_child() then copies both fields into the child.

cookie_v4_check() and cookie_v6_check() process the third ACK
directly and never go through tcp_check_req(). cookie_tcp_check()
does call tcp_parse_options(), so tcp_opt.accecn is filled in.
Nothing passes it to tcp_accecn_option_init(), though. With this
patch, saw_accecn_opt is always TCP_ACCECN_OPT_NOT_SEEN when the
child is created, even when the peer did send an AccECN option on
the third ACK.

The child also does not seem to catch up when it processes the same
skb. In tcp_child_process() -> tcp_rcv_state_process() -> tcp_ack():

  - snd_una already equals the ACK sequence and there are no packets
    in flight, so FLAG_FORWARD_PROGRESS is not set.
  - ts_recent was already copied from req->ts_recent, so
    FLAG_TS_PROGRESS is not set either.

__tcp_accecn_process() therefore returns before it calls
tcp_accecn_process_option().

As a result, tp->saw_accecn_opt stays at 0 on the child:

  - tcp_established_options() requires tp->saw_accecn_opt to be
    non-zero, so no AccECN options are sent even though
    accecn_opt_demand is set.
  - A zeroed option on the third ACK is never detected as
    TCP_ACCECN_OPT_FAIL_SEEN, and TCP_ACCECN_OPT_FAIL_RECV is never
    set.
  - tcpi_accecn_opt_seen in TCP_INFO reads 0 even when an option was
    received. It is no longer random, but it is still wrong.

Should cookie_v4_check() and cookie_v6_check() repeat the
tcp_accecn_option_init() step from tcp_check_req() once accecn_ok is
known? That would mean passing tcp_opt.accecn out of
cookie_tcp_check(), or parsing the options again. The
cookie_bpf_check() path would presumably need the same handling.

[Severity: Medium]
Is this value correct on the BPF custom syncookie path?

When cookie_bpf_ok(skb) is true, req comes from cookie_bpf_check(). In that
case a tc ingress BPF program built and sent the SYN-ACK.
tcp_v4_send_synack() and tcp_v6_send_synack() never run for that
connection, so the listener's tos/tclass may not match the ECN codepoint
that was actually sent. The same question applies to the new
tcp_rsk(req)->syn_ect_snt assignment in cookie_v6_check(), and to
syn_ect_rcv = 0 in cookie_tcp_reqsk_init(), which the BPF path also uses
whatever the SYN's ECN field was.

bpf_sk_assign_tcp_reqsk() fills the request sock only from
struct bpf_tcp_req_attrs:

net/core/filter.c:bpf_sk_assign_tcp_reqsk() {
    ...
	ireq->wscale_ok = !!attrs->wscale_ok;
	ireq->ecn_ok = !!attrs->ecn_ok;
    ...
}

and that struct has no field for the SYN-ACK or SYN ECN codepoint:

include/net/tcp.h:
struct bpf_tcp_req_attrs {
	...
	u8 ecn_ok;
	...
	u8 usec_ts_ok;
	u8 reserved[3];
};

The in-tree example already chooses its SYN-ACK TOS without looking at the
listener:

tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c:
		ctx->ipv4->tos = 0;

Here is one example:

  - The listener has ECT bits in IP_TOS or IPV6_TCLASS (for example a
    DCTCP listener, which gets ECT(0)), and tcp_ecn >= 3.
  - The BPF program sends a Not-ECT SYN-ACK that negotiates AccECN and
    passes ecn_ok=1.
  - The peer's third ACK reflects Not-ECT (ACE=0b010), so
    cookie_accecn_ok() is true and accecn_ok=1.

The child socket setup then goes:

tcp_ecn_openreq_child()
  tcp_accecn_third_ack()
    tcp_accecn_validate_syn_feedback()
      tcp_ect_transition_valid(ECT_0, NOT_ECT) returns false
      tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV)

With the default tcp_ecn_fallback=1, this sets TCP_ACCECN_ACE_FAIL_RECV.
After that, tcp_ecn_send() uses INET_ECN_dontxmit() for the rest of the
connection.

This looks like the same false ACE_FAIL_RECV that the commit message says
it fixes, and it can still happen through bpf_sk_assign_tcp_reqsk(). Does
the BPF path need a way to pass the SYN-ACK (and SYN) ECN codepoint in
through bpf_tcp_req_attrs, instead of using the listener's tos/tclass?

>  
>  	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
>  	/* ip_queue_xmit() depends on our flow being setup

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117124710.1338951-1-thaisonphan%40google.com
