Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116776;
	b=2H4InPL6m3nwDp3ZFyoJ8IuiwZFE47rLS7MevkQiH7Hg9Ph3ayrj1P0GtX2DJmd4Wckm
	 /FLMha2vf8uM3h99kTo5ENvsg2q9dH5h6PNYC26fzRGB1TTf1jQSByRpkZ48wzr4r3y8a
	 eeYtoCDA8/n4ma2GTdqMlAx0VE0LTYckxKFMJiOVCupDAtKO+p4+cO+eOxL79PLX3VjWy
	 oA6a0ke/wZ6H9lCfCoqDWSOEhE1xEzD7hG5e3Z6jCzFxcPfN25CgB6UHTyNZwB/BWsYFu
	 WbJeQzOFcEyN2kgmr5z/OEm2frOQT13Nufe3ekBr4zTA14bNIO0nSO0AEBi0yUmzjKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=giBViGSUnkapzy7a0Yv2C7tP4PrRhvD4XipT7tK+x74=;
	b=FTKWICfUgfbYIb8VFYqZK0r/Clas47wBMHPK5TY1Vffl1s/ftO7Nt6vLzjyADZoP2M0I
	 6wmbRfkocpz+yzvrh3EBWUIYjIY8Ce8h+3BTIeLMLyyZWTZhiaCwqTYEFPZe5PRm55cW9
	 c9STjUBMLdaIdv00q2tZzNcEiaDkXPKF7wZbO6c3W1Ou7JHleCfh/4x/w6u/3iLh7Mfzm
	 jEgANycX4nfIvIN8v4RBXoMflwp/8hK/Hk90GpIZZtgSLBtlN7n5bgVyEiduxRNhfGM0D
	 SGtL95m0aAAHBTUdOch7feT/ThCVbiemudx5PLl4I6XoJKO6hltKHmMjYYIR7S6uUxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JNQ6o9C+;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BB606A330
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 19:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0BB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JNQ6o9C+
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f040c6e0ceso892185ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116775; x=1795721575; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=giBViGSUnkapzy7a0Yv2C7tP4PrRhvD4XipT7tK+x74=;
        b=JNQ6o9C+nXn7xcJO0175FhzBDwUUp69Siu1iHxYvB3YNhYPLKUquzQf1/rbNB+QaZK
         6rDmhC1tMJfLLCdgpB9BgnShAx/XPrJ+CSlWY6jDJXdGLpoN05G7ACiRusb+6wC6ULxy
         eX5rkJUn5AfWRgr0yu+k3P+LUfpmqLiI0Fjt+IHi9DiMnSw6ZSudafAfBCUb20LCw1VF
         078YYDv69dIPXF3pnoXIujRbg43+QyUnqy2Iel/MKZhl6AR9Rk7pGOE4kDW7Si/FMA8h
         hKGfuuQMJyo+LI+sViqR0LvU/YJwSSATQKrXJ/zJ4uriKtFKik4b+PT8MIwGD9cAxhJh
         F9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116775; x=1795721575;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=giBViGSUnkapzy7a0Yv2C7tP4PrRhvD4XipT7tK+x74=;
        b=wKyzQFemIiEo+n8BOc0gjFAAa0QSVCd7uVgWVd9uNY0vUNy6nfI9t2p6BU/TNhv+tV
         C9V8quyVAULCoN6PNjHTCiPqDpPoYpgC0x46Lb/LCCCM/OdDaoRgwqk4sWPfHi7I2m0n
         o4kL9wl054zSuoze8ACK6mL5Hx8Tp6EuAYtDKF/8iKRwjR0BBfrrWOoZX6fBTde8pl3q
         TcIYNKmArZ/TikfhcLm3OTv8eYi+RIzs6nY4PuZn2HHmWayUG+rewBK1wp6tVHdf2xXY
         0inHPg24m1SGeNUq9AnzNXH11vezWcNcq6BxVv2O4wwdtB4y1iu+P63V9Gx7mxP6fDXD
         nWLA==
X-Forwarded-Encrypted: i=1; AL+hErGkscsC7JOUD0/5SlgUknGeGQLIxUtyMJmUaJl1cy26KqCUja5c7fj28leGhD+aZ0DWbDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WJs5J/yz1v/BVFuwgf+ENff3ycrkXbPGgDy2hlSpLFX88KB8E
	YJNlCQhFGRU9ynP0f+oGVZcHdamIY1ktmbaU0PXDridQ0Du12eAieicdfo1jaxIO45Jilx8+mzy
	P3ZA8Rg==
X-Received: from plbkj4.prod.google.com ([2002:a17:903:6c4:b0:2e8:1aeb:b4c9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70f:b0:2dd:ad73:5b68
 with SMTP id d9443c01a7336-2f03f11823emr7804365ad.24.1795116774563; Thu, 19
 Nov 2026 11:32:54 -0800 (PST)
Date: Thu, 19 Nov 2026 19:32:54 +0000
In-Reply-To: <20261116151331.500313-1-irlanki.s@samsung.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <DM6GLQVDXGWL.1ZV7PCL5B2B0K@gmail.com> <CGME20261116151200epcas5p4218c26338b3e9580a9e232be400aecc5@epcas5p4.samsung.com>
 <20261116151331.500313-1-irlanki.s@samsung.com>
Message-ID: <av8pip2n63ZBofcE@google.com>
Subject: Re: [PATCH bpf-next v9] bpf: tcp: add ecn_init callback to
 bpf_tcp_ops for per-connection ECN
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Irlanki Sandeep <irlanki.s@samsung.com>, ameryhung@gmail.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org, 
	cpgs@samsung.com, edumazet@google.com, davem@davemloft.net, pabeni@redhat.com, 
	ncardwell@google.com, ast@kernel.org, alexei.starovoitov@gmail.com, 
	ameryhung@gmail.com, daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, lorenzo@google.com, maze@google.com, 
	sporeba@google.com, motomuman@google.com, madhan.raj@samsung.com, 
	srihari.k@samsung.com, g.pokhra@samsung.com, r.kumawat@samsung.com, 
	raj.kumars@samsung.com, ts413.lee@samsung.com, ramyashree.s@samsung.com, 
	daeil2.hwang@samsung.com, sharmasagarika@google.com
Content-Type: text/plain; charset="us-ascii"

On Mon, 16 Nov 2026 20:43:31 +0530, Irlanki Sandeep wrote:
> TCP ECN and Accurate ECN (AccECN) negotiation are currently decided
> globally by the net.ipv4.tcp_ecn sysctl; the per-route knob
> (RTAX_FEATURE_ECN) can only force-enable classic ECN on a path. This
> lacks the granularity required for per-application and per-connection
> ECN policies in multi-application runtimes such as Android.
> 
> ECN/L4S selection is an application-level property, not only a path
> property: on the exact same route, latency-sensitive applications
> (real-time gaming, interactive video/VoIP, low-latency messaging)
> benefit from negotiating AccECN for low-queuing-delay L4S treatment,
> while bulk background transfers or legacy applications in other
> cgroups prefer classic RFC3168 ECN, or no ECN at all where middlebox
> traversal is a concern. On the passive side, a server may further
> want to decide the ECN mode per peer at handshake time. A route
> feature bit cannot express any of this when multiple applications
> share one route.

Why can't ip-rule (or VRF) be used with a per-route attribute ?

Also, a route attribute would work with syncookie.


> 
> To support this without adding per-socket state to struct tcp_sock or
> resorting to the legacy sock_ops interface, add an 'ecn_init' callback
> to struct bpf_tcp_ops, following the existing timeout_init()/
> rwnd_init() pattern.

This is simple, but one concern would be that we end up adding
more single-purpose stateless callbacks during 3WHS, which could
be more expensive than stateful solution.

For stateful use case w/ per-socket field, rwnd_init() + kfunc
would suffice (and we have such a use case).

Amery, what do you think ?


> The ECN mode is only consulted once per handshake,
> so the kernel queries the BPF program via tcp_ecn_init_bpf() when the
> sysctl value is read: before the SYN is built on active open, and when
> an incoming SYN creates a request_sock on passive open, where the
> program sees the listener and the request_sock and can thus decide per
> peer. The sysctl value is passed to the program as the default via
> bpf_get_retval(); an out-of-range return keeps it, and with syncookies
> there is no listener, so the program is not invoked at all. No
> negotiated-mode state is stored; the decision taken at handshake time
> stands for the connection. The struct_ops program is attached
> per-cgroup, giving the per-application policy point (containers,
> Android app sandboxes).
> 
> Document the sysctl precedence in ip-sysctl.rst and add BPF selftests
> covering IPv4 and IPv6 handshakes across active, passive, downgrade,
> refusal and out-of-range fallback cases.
> 
> Signed-off-by: Irlanki Sandeep <irlanki.s@samsung.com>
> ---
> v8 -> v9:
>  - Fix multi-line comment style in
>    selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c (sashiko).
>  - Add copyright headers to both new selftest files.
>  - Update the bpf_get_retval() comment in net/ipv4/bpf_tcp_ops.c to
>    include ecn_init in the list of bpf_get_retval() users (BPF CI).
> 
> v7 -> v8:
>  - Respin on top of bpf-next and convert from the legacy sock_ops
>    kfuncs to a bpf_tcp_ops struct_ops callback 'ecn_init' (Alexei
>    Starovoitov).
>  - Drop tp->ecn_mode, TCP_ECN_MODE_UNSPEC, tcp_ecn_mode_eff() and the
>    kfuncs; the prog is queried on demand during the handshake like
>    timeout_init()/rwnd_init(), which also enables per-peer decisions
>    on the passive side (Alexei Starovoitov).
>  - Clarify the per-application motivation (AccECN for latency-sensitive
>    apps vs bulk traffic on the same route) in the commit log (Alexei
>    Starovoitov).
>  - Drop the AccECN option kfunc to focus on ECN mode negotiation;
>    to be discussed separately.
>  - Replace the sockops selftest with a bpf_tcp_ops_ecn struct_ops
>    selftest covering IPv4 and IPv6.
> 
> v6 -> v7:
>  - Document BPF_SOCK_OPS_TCP_LISTEN_CB timing window in kernel-doc
>    for both kfuncs: connections arriving before the callback runs
>    will use the sysctl value rather than per-socket overrides.
>  - Add fallback behavior note to commit message.
>  - Remove Suggested-by tag per maintainer guidance.
> 
> v5 -> v6:
>  - Reject non-TCP sockets in both kfuncs with sk_is_tcp(). The TX
>    timestamping sockops callbacks run with is_fullsock set for UDP
>    sockets too, so tcp_sk() on them was an out-of-bounds write (sashiko).
>  - Fix selftest and comments: accepted children are cloned from the
>    listener and inherit ecn_mode/ecn_option (sashiko).
>  - Use standard multi-line comment style in the BPF selftests (sashiko).
>  - Document per-socket kfunc override precedence for tcp_ecn and
>    tcp_ecn_option in ip-sysctl.rst.
>  - Reword subject: the TCP_ECN/TCP_ECN_OPTION optnames no longer exist.
> 
> v4 -> v5:
>  - Replaced setsockopt implementation with BPF kfuncs.
>  - Placed ecn_mode/ecn_option in the cold section of tcp_sock to avoid
>    polluting hot cachelines (suggested by Eric Dumazet).
>  - Updated Documentation/networking/net_cachelines/tcp_sock.rst.
>  - Removed userspace UAPI and documentation for the sockopt.
>  - Added new selftest for the kfunc implementation.
> 
> v3 -> v4:
>  - Define TCP_ECN and TCP_ECN_OPTION in bpf_tracing_net.h to fix
>    BPF selftest compilation failure in progs/setget_sockopt.c (bpf-ci).
> 
> v2 -> v3:
>  - Use READ_ONCE() when reading ecn_mode and ecn_option in tcp_ecn_mode_eff()
>    and tcp_accecn_option_eff() to prevent compiler double-fetches (sashiko-bot).
>  - Move cookie_ecn_ok() to include/net/tcp_ecn.h and update syncookies.
> 
> v1 -> v2:
>  - Remove unused variable 'net' in tcp_ecn_create_request() reported
>    by kernel test robot.
> 
>  Documentation/networking/ip-sysctl.rst        |   7 +
>  include/net/tcp.h                             |   6 +
>  include/net/tcp_ecn.h                         |  14 +-
>  net/ipv4/bpf_tcp_ops.c                        |  21 +-
>  net/ipv4/tcp_input.c                          |   6 +-
>  .../bpf/prog_tests/bpf_tcp_ops_ecn.c          | 212 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_tcp_ops_ecn.c     |  57 +++++
>  7 files changed, 314 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index f7af0286341c..bb99a9bddd63 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -484,6 +484,13 @@ tcp_ecn - INTEGER
>  	5     AccECN               No ECN
>  	===== ==================== ====================
>  
> +	Note that a BPF program implementing the bpf_tcp_ops 'ecn_init'
> +	struct_ops callback, attached to a cgroup, can override this value
> +	per connection for the sockets of that cgroup. The callback sees
> +	this sysctl value as the default via bpf_get_retval(), and return
> +	values outside the table above fall back to it. Connections
> +	established via syncookies always use the sysctl value.
> +
>  	Default: 2
>  
>  tcp_ecn_option - INTEGER
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f7624ab9b420..19fd7652b1c1 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2971,6 +2971,12 @@ struct bpf_tcp_ops {
>  	 */
>  	int (*rwnd_init)(struct sock *sk, struct request_sock *req);
>  
> +	/* Should return the ECN variant to negotiate in this handshake:
> +	 * one of net.ipv4.tcp_ecn values. bpf_get_retval() has the sysctl.
> +	 * @req as in timeout_init().
> +	 */
> +	int (*ecn_init)(struct sock *sk, struct request_sock *req);
> +
>  	/* Called when an active connection becomes established.
>  	 * @skb is the SYNACK that completed the 3WHS, or NULL for a
>  	 * TCP_REPAIR socket (tcp_finish_connect() with no skb).
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 865d5c5a7718..fc76b0b5341f 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -32,6 +32,18 @@ enum tcp_accecn_option {
>  	TCP_ACCECN_OPTION_PERSIST = 3,
>  };
>  
> +/* Resolve the effective ECN mode: BPF callback or sysctl fallback */
> +static inline u8 tcp_ecn_init_bpf(struct sock *sk)
> +{
> +	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
> +	int ret;
> +
> +	ret = bpf_tcp_ops_call_int(ecn_init, tcp_ecn, sk);
> +	if (ret < 0 || ret > TCP_ECN_IN_ACCECN_OUT_NOECN)
> +		return tcp_ecn;
> +	return ret;
> +}
> +
>  /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
>  static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
>  {
> @@ -599,7 +611,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
>  	bool use_ecn, use_accecn;
> -	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
> +	u8 tcp_ecn = tcp_ecn_init_bpf(sk);

nit: reverse xmas tree order


>  
>  	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
>  		     tcp_ca_needs_accecn(sk);
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 2ba73dd6c52c..785517364f0b 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -24,6 +24,14 @@ static int rwnd_init_stub(struct sock *sk, struct request_sock *req__nullable)
>  	return ctx->retval;
>  }
>  
> +static int ecn_init_stub(struct sock *sk, struct request_sock *req__nullable)
> +{
> +	struct bpf_tramp_run_ctx *ctx =
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	return ctx->retval;
> +}
> +
>  static void active_established_stub(struct sock *sk, struct sk_buff *skb__nullable)
>  {
>  }
> @@ -87,6 +95,7 @@ static void dequeue_rcvq_stub(struct sock *sk)
>  static struct bpf_tcp_ops __bpf_tcp_ops = {
>  	.timeout_init = timeout_init_stub,
>  	.rwnd_init = rwnd_init_stub,
> +	.ecn_init = ecn_init_stub,
>  	.active_established = active_established_stub,
>  	.passive_established = passive_established_stub,
>  	.rto = rto_stub,
> @@ -202,10 +211,11 @@ BPF_CALL_0(bpf_tcp_ops_get_retval)
>  	struct bpf_tramp_run_ctx *ctx =
>  		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
>  
> -	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
> -	 * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the int
> -	 * return value chained across the bpf_tcp_ops attached to the cgroup
> -	 * and is this program's saved_run_ctx.
> +	/* bpf_get_retval() is only exposed to timeout_init, rwnd_init and
> +	 * ecn_init, which always run via bpf_tcp_ops_call_int(). Its
> +	 * run_ctx carries the int return value chained across the
> +	 * bpf_tcp_ops attached to the cgroup and is this program's
> +	 * saved_run_ctx.
>  	 */
>  	if (WARN_ON_ONCE(!ctx->saved_run_ctx))
>  		return 0;
> @@ -258,7 +268,8 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return NULL;
>  	case BPF_FUNC_get_retval:
>  		if (moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
> -		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
> +		    moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
> +		    moff == offsetof(struct bpf_tcp_ops, ecn_init))
>  			return &bpf_tcp_ops_get_retval_proto;
>  		return NULL;
>  	case BPF_FUNC_reserve_hdr_opt:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 46f5c4fafa8d..1e39c0ec437e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7500,13 +7500,13 @@ static void tcp_ecn_create_request(struct request_sock *req,
>  				   const struct dst_entry *dst)
>  {
>  	const struct tcphdr *th = tcp_hdr(skb);
> -	const struct net *net = sock_net(listen_sk);
> +	u8 tcp_ecn = tcp_ecn_init_bpf((struct sock *)req);

Please avoid calling it if not needed,

!tcp_accecn_syn_requested && !th_ecn

also nit: reverse xmas tree


>  	bool th_ecn = th->ece && th->cwr;
>  	bool ect, ecn_ok;
>  	u32 ecn_ok_dst;
>  
>  	if (tcp_accecn_syn_requested(th) &&
> -	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
> +	    (tcp_ecn >= 3 ||
>  	     tcp_ca_needs_accecn(listen_sk))) {
>  		inet_rsk(req)->ecn_ok = 1;
>  		tcp_rsk(req)->accecn_ok = 1;
> @@ -7520,7 +7520,7 @@ static void tcp_ecn_create_request(struct request_sock *req,
>  
>  	ect = !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->ip_dsfield);
>  	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
> -	ecn_ok = READ_ONCE(net->ipv4.sysctl_tcp_ecn) || ecn_ok_dst;
> +	ecn_ok = tcp_ecn || ecn_ok_dst;
>  
>  	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
>  	    tcp_ca_needs_ecn(listen_sk) ||
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c
> new file mode 100644
> index 000000000000..59cfec70758d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_ecn.c

Please split selftest into a separate patch.


> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Samsung Electronics Co., Ltd. */
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "cgroup_helpers.h"
> +#include "bpf_tcp_ops_ecn.skel.h"
> +
> +#define CGROUP_PATH	"/bpf_tcp_ops_ecn"
> +#define TEST_NETNS	"bpf_tcp_ops_ecn"
> +
> +/* Must match progs/bpf_tcp_ops_ecn.c */
> +#define TCP_ECN_MODE_DISABLED	0x00
> +#define TCP_ECN_MODE_RFC3168	0x01
> +#define TCP_ECN_MODE_ACCECN	0x10
> +
> +struct ecn_case {
> +	const char *name;
> +	int sysctl_ecn;		/* net.ipv4.tcp_ecn in the test netns */
> +	int retval_active;	/* ecn_init() return value, active open */
> +	int retval_passive;	/* ecn_init() return value, passive open */
> +	__u32 mode_client;	/* expected ECN mode on the client socket */
> +	__u32 mode_server;	/* expected ECN mode on the accepted socket */
> +};
> +
> +/*
> + * net.ipv4.tcp_ecn / ecn_init() values (enum tcp_ecn_mode): 0 == no ECN,
> + * 1 == accept + request RFC3168 ECN, 3 == accept + request AccECN.
> + */
> +static const struct ecn_case ecn_cases[] = {
> +	{
> +		/* The sysctl disables ECN; BPF negotiates RFC3168 ECN. */
> +		.name = "bpf_enables_classic",
> +		.sysctl_ecn = 0,
> +		.retval_active = 1,
> +		.retval_passive = 1,
> +		.mode_client = TCP_ECN_MODE_RFC3168,
> +		.mode_server = TCP_ECN_MODE_RFC3168,
> +	},
> +	{
> +		/* The sysctl disables ECN; BPF negotiates AccECN. */
> +		.name = "bpf_enables_accecn",
> +		.sysctl_ecn = 0,
> +		.retval_active = 3,
> +		.retval_passive = 3,
> +		.mode_client = TCP_ECN_MODE_ACCECN,
> +		.mode_server = TCP_ECN_MODE_ACCECN,
> +	},
> +	{
> +		/*
> +		 * The client requests AccECN but the server only accepts
> +		 * RFC3168 ECN (< 3): negotiation degrades to RFC3168.
> +		 */
> +		.name = "passive_clamps_accecn",
> +		.sysctl_ecn = 0,
> +		.retval_active = 3,
> +		.retval_passive = 1,
> +		.mode_client = TCP_ECN_MODE_RFC3168,
> +		.mode_server = TCP_ECN_MODE_RFC3168,
> +	},
> +	{
> +		/* The server refuses ECN although the sysctl allows it. */
> +		.name = "passive_refuses_ecn",
> +		.sysctl_ecn = 1,
> +		.retval_active = 3,
> +		.retval_passive = 0,
> +		.mode_client = TCP_ECN_MODE_DISABLED,
> +		.mode_server = TCP_ECN_MODE_DISABLED,
> +	},
> +	{
> +		/*
> +		 * The client does not request ECN although the sysctl
> +		 * allows it, so there is nothing for the server to accept.
> +		 */
> +		.name = "active_disables_ecn",
> +		.sysctl_ecn = 1,
> +		.retval_active = 0,
> +		.retval_passive = 3,
> +		.mode_client = TCP_ECN_MODE_DISABLED,
> +		.mode_server = TCP_ECN_MODE_DISABLED,
> +	},
> +	{
> +		/*
> +		 * Return values above TCP_ECN_IN_ACCECN_OUT_NOECN fall back
> +		 * to the sysctl on both sides.
> +		 */
> +		.name = "fallback_above_range",
> +		.sysctl_ecn = 1,
> +		.retval_active = 6,
> +		.retval_passive = 6,
> +		.mode_client = TCP_ECN_MODE_RFC3168,
> +		.mode_server = TCP_ECN_MODE_RFC3168,
> +	},
> +	{
> +		/* Negative return values fall back to the sysctl too. */
> +		.name = "fallback_negative",
> +		.sysctl_ecn = 1,
> +		.retval_active = -1,
> +		.retval_passive = -1,
> +		.mode_client = TCP_ECN_MODE_RFC3168,
> +		.mode_server = TCP_ECN_MODE_RFC3168,
> +	},
> +};
> +
> +/*
> + * Connect over loopback and accept() the child socket, so that
> + * passive_established is guaranteed to have run: the listener is woken
> + * up only after tcp_rcv_state_process() moved the child to established.
> + */
> +static void do_ecn_connect(int family)
> +{
> +	const char *addr = family == AF_INET ? "127.0.0.1" : "::1";
> +	int server_fd, client_fd, accepted_fd;
> +
> +	server_fd = start_server(family, SOCK_STREAM, addr, 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server"))
> +		return;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (ASSERT_OK_FD(client_fd, "connect_to_fd")) {
> +		accepted_fd = accept(server_fd, NULL, NULL);
> +		if (ASSERT_OK_FD(accepted_fd, "accept"))
> +			close(accepted_fd);
> +		close(client_fd);
> +	}
> +
> +	close(server_fd);
> +}
> +
> +static void test_ecn(int cgroup_fd, struct bpf_tcp_ops_ecn *skel, int family)
> +{
> +	struct bpf_link *link;
> +	char buf[128];
> +	int i;
> +
> +	link = bpf_map__attach_cgroup_opts(skel->maps.ecn_ops, cgroup_fd, NULL);
> +	if (!ASSERT_OK_PTR(link, "attach_ecn_ops"))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(ecn_cases); i++) {
> +		const struct ecn_case *c = &ecn_cases[i];
> +
> +		snprintf(buf, sizeof(buf), "%d", c->sysctl_ecn);
> +		if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/tcp_ecn", buf),
> +			       "write_sysctl_tcp_ecn"))
> +			break;
> +
> +		skel->bss->ecn_retval_active = c->retval_active;
> +		skel->bss->ecn_retval_passive = c->retval_passive;
> +		skel->bss->ecn_seed_active = -1;
> +		skel->bss->ecn_seed_passive = -1;
> +		skel->bss->ecn_active_cnt = 0;
> +		skel->bss->ecn_passive_cnt = 0;
> +		skel->bss->ecn_mode_client = 0xdead;
> +		skel->bss->ecn_mode_server = 0xdead;
> +
> +		do_ecn_connect(family);
> +
> +		/* ecn_init() runs once per side per handshake. */
> +		snprintf(buf, sizeof(buf), "%s: active_cnt", c->name);
> +		ASSERT_EQ(skel->bss->ecn_active_cnt, 1, buf);
> +		snprintf(buf, sizeof(buf), "%s: passive_cnt", c->name);
> +		ASSERT_EQ(skel->bss->ecn_passive_cnt, 1, buf);
> +
> +		/* bpf_get_retval() must be seeded with the sysctl value. */
> +		snprintf(buf, sizeof(buf), "%s: seed_active", c->name);
> +		ASSERT_EQ(skel->bss->ecn_seed_active, c->sysctl_ecn, buf);
> +		snprintf(buf, sizeof(buf), "%s: seed_passive", c->name);
> +		ASSERT_EQ(skel->bss->ecn_seed_passive, c->sysctl_ecn, buf);
> +
> +		snprintf(buf, sizeof(buf), "%s: mode_client", c->name);
> +		ASSERT_EQ(skel->bss->ecn_mode_client, c->mode_client, buf);
> +		snprintf(buf, sizeof(buf), "%s: mode_server", c->name);
> +		ASSERT_EQ(skel->bss->ecn_mode_server, c->mode_server, buf);
> +	}
> +
> +	bpf_link__destroy(link);
> +}
> +
> +static void run_ecn_subtest(int family)
> +{
> +	struct bpf_tcp_ops_ecn *skel = NULL;
> +	struct netns_obj *ns = NULL;
> +	int cgroup_fd;
> +
> +	cgroup_fd = test__join_cgroup(CGROUP_PATH);
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		return;
> +
> +	ns = netns_new(TEST_NETNS, true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		goto done;
> +
> +	skel = bpf_tcp_ops_ecn__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto done;
> +
> +	test_ecn(cgroup_fd, skel, family);
> +
> +done:
> +	bpf_tcp_ops_ecn__destroy(skel);
> +	netns_free(ns);
> +	close(cgroup_fd);
> +}
> +
> +void test_bpf_tcp_ops_ecn(void)
> +{
> +	if (test__start_subtest("ipv4"))
> +		run_ecn_subtest(AF_INET);
> +	if (test__start_subtest("ipv6"))
> +		run_ecn_subtest(AF_INET6);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c
> new file mode 100644
> index 000000000000..596566148858
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_ecn.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Samsung Electronics Co., Ltd. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +/* TCP_ECN_MODE_* bits of tcp_sock::ecn_flags, from include/net/tcp.h */
> +#define TCP_ECN_MODE_RFC3168	0x01
> +#define TCP_ECN_MODE_ACCECN	0x10
> +#define TCP_ECN_MODE_ANY	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
> +
> +int ecn_retval_active;		/* ecn_init() return value, active open */
> +int ecn_retval_passive;		/* ecn_init() return value, passive open */
> +int ecn_seed_active;		/* bpf_get_retval() seen on active open */
> +int ecn_seed_passive;		/* bpf_get_retval() seen on passive open */
> +__u32 ecn_active_cnt;
> +__u32 ecn_passive_cnt;
> +__u32 ecn_mode_client;		/* negotiated ECN mode, client socket */
> +__u32 ecn_mode_server;		/* negotiated ECN mode, accepted socket */
> +
> +SEC("struct_ops")
> +int BPF_PROG(ecn_ops_ecn_init, struct sock *sk, struct request_sock *req)
> +{
> +	if (req) {
> +		ecn_passive_cnt++;
> +		ecn_seed_passive = bpf_get_retval();
> +		return ecn_retval_passive;
> +	}
> +
> +	ecn_active_cnt++;
> +	ecn_seed_active = bpf_get_retval();
> +	return ecn_retval_active;
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(ecn_ops_active_established, struct sock *sk,
> +	      struct sk_buff *skb)
> +{
> +	ecn_mode_client = ((struct tcp_sock *)sk)->ecn_flags & TCP_ECN_MODE_ANY;
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(ecn_ops_passive_established, struct sock *sk,
> +	      struct sk_buff *skb)
> +{
> +	ecn_mode_server = ((struct tcp_sock *)sk)->ecn_flags & TCP_ECN_MODE_ANY;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_tcp_ops ecn_ops = {
> +	.ecn_init = (void *)ecn_ops_ecn_init,
> +	.active_established = (void *)ecn_ops_active_established,
> +	.passive_established = (void *)ecn_ops_passive_established,
> +};
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.34.1
> 
