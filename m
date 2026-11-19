Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101558;
	b=x7jQKlbqGoGmBLKvZrrTr+nX/ZEU/ORHtgwR7kPQU+7lJxxi+5PwKhCnNgsGFpOkXGVj
	 iTK7omWs3inAcTfzb4uQfDKTGATJnq3TqH6gl/KIY+bdiKtRpr58nHIukcUrdH/vNC7Fp
	 uJTlUY/7YQAxa18cGVPWEjnhddhjAf5L/0Vmrc4g8u9z3NSP76yyzalUtAzCp59GdYxeP
	 gfxhd0bO3JdexHNU+Ef/GW0NJzCFYRq8B2If3bduIJ2kQ5khG4f57d42PdjaLkdgDNeY6
	 cmGCG7Iz8/kDhoJrMQ5nF7lemLRJve4+Y0ItzDngGHbOk2hQrpKP54rDZJlaNP9brLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101558;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=M7sCKL1sfvK10u19rDG/6Mu1LXARQdWjOTJLt9g16i4=;
	b=Mr3JZ8zLrnad+prTfHnpr5q13ZrZonK2rBu6xQsAQMY2EgP25/xOUByoOlHxq+8q0aa5
	 MVtliO68KGeCb4IwtAGH7flGiwQX5XZ+tfnEprzHwLz4yrXJwUSpA29Fb8otzFOLfQG9k
	 oXD9HG49fPGsl4DJj9WdWUGuWF1TKCNP7maEbOuwdLxFDKv3TokFlx99+o6Hlc4MGoP+/
	 NjUC8IW8wm/FsL/oiaudi1RCJBP7sg8HRmC7b1hFFBFS+MEgumGOSMTxya4jNIfzgXQnE
	 xrpGgVKf04l1f4LBSJjx7OyVOIt0ORHPSSkFdoR72tChEa3U2mN9TPzOf4jRDToJyDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg0JDFKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB63606A325;
	Thu, 19 Nov 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg0JDFKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504201F000C5;
	Thu, 19 Nov 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795101557;
	bh=M7sCKL1sfvK10u19rDG/6Mu1LXARQdWjOTJLt9g16i4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Lg0JDFKBjuwS7FakiWE1sm+uH5LVfHqt63AR+fjt5IVyYJ2cgez6hfUzxDeIh04L6
	 hbMhpZCT54lfwJfrUTZlAQ++RJ/rtanPH4dpkuickkE2ZGrD8XP9qWrOM0tTpRL1XT
	 5Bb/bARJ7Z4sxepYk2N2p8btO2l9C/F7EPPTtDdRL9LKfxsji0p5JXtgeOLLpCZnQi
	 jgLqNP2LdUVnEo42oH+zP4c/RR8REdDAegwgM74OczLswvr+9kt3pLcPQv8wGTnl3G
	 Qxt2x79tZ3M1iYtmVb5sCxZcRnvkBN7+zuhwnQWCieevMT2Dtfb2i//4rQdvSHefXU
	 RLO6rdJ9vhBlQ==
Content-Type: multipart/mixed; boundary="===============8478692278203113852=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a4c31b033613fa51016f2cf42f90e3f2c61d0e9a8c1012c20e5074a0e92bbe95@mail.kernel.org>
In-Reply-To: <20261119142231.2612515-4-razor@blackwall.org>
References: <20261119142231.2612515-4-razor@blackwall.org>
Subject: Re: [PATCH bpf-next 3/8] bpf: allow bpf_sk_assign on tc egress with refcounted sockets
From: bot+bpf-ci@kernel.org
To: razor@blackwall.org,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,razor@blackwall.org,ayush.sawal@chelsio.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,horms@kernel.org,kuniyu@google.com,willemb@google.com,jhs@mojatatu.com,jiri@resnulli.us,sd@queasysnail.net,paul@isovalent.com,alasdair.mcwilliam@isovalent.com,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 15:19:14 +0000 (UTC)

--===============8478692278203113852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: allow bpf_sk_assign on tc egress with refcounted sockets

TL;DR:
- bpf_sk_assign() on egress may hit BUG_ON in skb_orphan() for test-run skbs
  with skb->sk but no destructor
- skb_do_redirect() may keep a borrowed listener via syncookie reqsk, a
  possible use-after-free; also possible socket double-put

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2559,14 +2559,17 @@ int skb_do_redirect(struct sk_buff *skb)
>  	if (unlikely(!dev))
>  		goto out_drop;
>
> +#ifdef CONFIG_INET
>  	/*
> -	 * Prefetched sockets may borrow a listener under RCU. Orphan them
> -	 * before redirects that can outlive this section. Peer ingress
> -	 * stays in the same RCU section.
> +	 * Prefetched listeners may be borrowed under RCU. Drop borrowed
> +	 * assignments before redirects that can outlive this section.
> +	 * Peer ingress stays in the same RCU section.
>  	 */
> -	if (skb_sk_is_prefetched(skb) &&
> +	if (skb->destructor == sock_pfree &&
> +	    !sk_is_refcounted(skb->sk) &&
>  	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
>  		skb_orphan(skb);
> +#endif

Can this leave a borrowed listener behind a redirect?

bpf_sk_assign_tcp_reqsk() installs a syncookie request sock whose
rsk_listener is a borrowed SOCK_RCU_FREE listener:

    req = inet_reqsk_alloc(ops, sk, false);   /* no ref on sk */
    req->rsk_listener = sk;
    skb->sk = req_to_sk(req);
    skb->destructor = sock_pfree;

skb->sk is a TCP_NEW_SYN_RECV request sock, so sk_is_refcounted(skb->sk)
is true and the new condition is false.  The skb then keeps the reqsk
across bpf_redirect(ifindex, BPF_F_INGRESS) and non-peer egress
redirects.  For example:

    sch_handle_ingress()
      skb_do_redirect()                    /* no orphan */
        __bpf_redirect_common()
          __bpf_rx_skb()
            dev_forward_skb_nomtu()
              netif_rx_internal()          /* queued past the RCU section */

Later tcp_v4_rcv() -> __inet_lookup_skb() -> inet_steal_sock() ->
skb_steal_sock() takes the syncookie branch:

    *refcounted = false;
    sk = req->rsk_listener;
    req->rsk_listener = NULL;
    return sk;

and inet_steal_sock() dereferences that listener.  If the listener was
closed and its SOCK_RCU_FREE grace period elapsed while the skb sat in
the backlog or a qdisc, is this a use-after-free?

The updated comment says borrowed listener assignments are dropped, and the
commit message describes "sock_pfree + !sk_is_refcounted" as "the true
no-refcount case from ingress", but the reqsk case above is not covered.

Separately, refcounted sock_pfree assignments made at ingress now survive
non-peer redirects into egress.  complete_skb() and
chcr_ktls_copy_record_in_skb() treat any destructor other than
sock_efree/sock_pfree_ref as charged to sk_wmem_alloc, and chcr copies
sock_pfree to nskb without sock_hold().  Would that double-put the socket
when both skbs are freed?  The commit message says only sock_pfree_ref
sockets are meant to be preserved; would testing
skb->destructor == sock_pfree alone, as before, keep that and close both
problems?

[ ... ]

> @@ -8115,21 +8118,26 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
>
>  BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
>  {
> +	bool egress = !skb_at_tc_ingress(skb);
> +	bool refcounted;
> +
>  	if (!sk || flags != 0)
>  		return -EINVAL;
> -	if (!skb_at_tc_ingress(skb))
> +	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
> +		       skb_is_decrypted(skb)))
>  		return -EOPNOTSUPP;
> +	refcounted = egress || sk_is_refcounted(sk);
>  	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
>  		return -ENETUNREACH;
>  	if (sk_unhashed(sk))
>  		return -EOPNOTSUPP;
> -	if (sk_is_refcounted(sk) &&
> +	if (refcounted &&
>  	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  		return -ENOENT;
>
>  	skb_orphan(skb);
>  	skb->sk = sk;
> -	skb->destructor = sock_pfree;
> +	skb->destructor = egress ? sock_pfree_ref : sock_pfree;

Can skb_orphan() hit BUG_ON(skb->sk) here?

Removing the !skb_at_tc_ingress() rejection lets every non-ingress skb
reach skb_orphan(), including skbs that have skb->sk set and no
destructor.  bpf_prog_test_run_skb() builds exactly such an skb:

    sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
    skb = slab_build_skb(data);
    skb->sk = sk;          /* no destructor */

tc_at_ingress is zero there and convert___skb_to_skb() never sets it, so
skb_at_tc_ingress() is false and the new egress branch is taken.  A tc
program that does bpf_sk_lookup_tcp(skb, &tuple, ..., BPF_F_CURRENT_NETNS,
0) on an established socket and then bpf_sk_assign(skb, sk, 0) passes
sk_fullsock(), sk_is_refcounted(), skb_is_decrypted(), the netns check and
sk_unhashed(), and refcount_inc_not_zero_acquire() succeeds.  Then:

    static __always_inline void skb_orphan(struct sk_buff *skb)
    {
        if (skb->destructor) {
            ...
        } else {
            BUG_ON(skb->sk);   /* skb->sk == dummy sk */
        }
    }

Before this patch the same program got -EOPNOTSUPP and never reached
skb_orphan().  The selftest added later in the series (probe_timewait in
sk_assign_netkit) goes through bpf_prog_test_run_opts() but only avoids
the BUG because its socket is in TIME_WAIT and fails sk_fullsock().  A
later patch in the series that accepts listeners does not add a guard
either.

Could the egress branch reject skbs that have skb->sk set but no
destructor (or the test-run context) before calling skb_orphan()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44548126067
--===============8478692278203113852==--
