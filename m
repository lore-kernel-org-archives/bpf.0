Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795499109;
	b=uWO2TyqddpJj1S0b2VJEll5XAIlkWkIBqQjUef6k2Mxzgx/OX47mNKMjR107hHpb5quE
	 llhZRYm1bxkiAA2sZDZaykQjDFd7/gJe4TMQ7mFlZCVgGNUcy4S944Z5WLMcesy+1kZ+A
	 vXcXSTEGufuE9nmZvelffKQbz06OMkgC+BJW1rjHvIRpmBJCbZLQbuIibLxtF1FqSkaev
	 bORouSfJkzD9+8Js4yahkV8P6WlgXDrk9ul+9IMs4v/z3Yn7pmBOGoEb07kFQnodJcRTI
	 PqsD+rDnHK1f9eB/hpoMOGoH4e18F/dl9NWr5QShN5T4nGvDBxzHztRpG2Zc82EFvsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499109;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aRffa5QGJyeDL2fDxuIlhM+fU5kvvSRm5hMdsycYtrw=;
	b=fYMMJdxjZMNB8vJoxWsSHprzBnsBRy7PlV+c5BCy2c4DzmsjfLWlvBF9yZQdvH+uGmv2
	 xn5Vk4lmRYR+6lueDJLyZwYfCtTQ49/1Nw4PksK9xFKWX+VjnSR1kKrIOgLz7dU23gci5
	 2fU3hvG5yd9NZczgHN1eyHU2htLfUq57NDw4JJM9QmXyt0+8ZEix8bowsKjmo6dT/61gx
	 yJHTbnqz2psKV2EqjBrTKIj8Q/EVOc8GFNtSrYoXV5dRn2mF3YIt3vKU23BzfrNpAyJNM
	 0gjieD5nZ+7ztMjD8yirHr1fhoTYxLBE3wLPafKqYX/dXb5JnJIIDm6fSr+fqhn/MCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ54UdvX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B4606A31E;
	Tue, 24 Nov 2026 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ54UdvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B09C1F000C6;
	Tue, 24 Nov 2026 05:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795499109;
	bh=aRffa5QGJyeDL2fDxuIlhM+fU5kvvSRm5hMdsycYtrw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eJ54UdvXTIbCw6STyIHaf4Jsz7ZjHQmIkuCxT4ozyeVyAJPnm5BWF30vBfvRpLq2N
	 gQl229cL36hQlq3hnPUDagQzdMNmg0FkU/qc6PSEq6IKnYomQS89oRESJD13yFqKYG
	 9/BHYtL48HIzxWvGxHT1AhXxAXvKYeopoIyWpJDwC8gRpNp8u5tU5u615fT2sAC84O
	 jNmNn9KmF2s288MhIGEP3DZF/OU0hxIGTGy93ktgsgUg4pWEN3smxvNGjrs0Nax4G1
	 DqFgbYTVjGV1k9ivno02YFSIMEazoJ6CU0sVd2tfzJnrv+WKOOkztDPuwHKjaN98P+
	 d4r2VgGdYbBIQ==
Subject:
 Re: [PATCH net v12 1/2] tun: run the socket filter from tun_net_xmit()
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, weirongguang@kylinos.cn
Date: Tue, 24 Nov 2026 05:45:08 +0000
Message-ID: <179549910801.3135.11117955228755728713@kernel.org>
In-Reply-To: <20261123054209.89946-2-clementwei90@163.com>
References: <20261123054209.89946-2-clementwei90@163.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not mention that the classic filter's
  runtime and attach semantics change.
- [Low] The commit message understates the bug it fixes, and the subject
  line is misleading.
- [Low] This Fixes-tagged patch (Fixes: 54f968d6efdb, from 2012) also
  removes EXPORT_SYMBOL_GPL(sk_attach_filter) and…

--

tun: run the socket filter from tun_net_xmit()

This commit moves the classic BPF program installed by TUNATTACHFILTER
off the per-queue socket (sk_filter) and onto the device
(tun->cbpf_prog), and runs it directly from tun_net_xmit(). A per-queue
nofilter flag replaces the re-attach of the user filter in tun_attach(),
and the exports of sk_attach_filter() and sk_detach_filter() are removed.

> tun: run the socket filter from tun_net_xmit()
>
> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
> points into the address space of the process that issued the ioctl, and
> tun_attach() reads it again whenever a queue is attached to a persistent
> device. That read can fail, and with the inverted check below the
> failure was not fatal either: the queue was attached without a filter,
> while a successful read returned early and left the queue unpublished.

[Severity: Low]
Is "whenever a queue is attached to a persistent device" accurate? In
the baseline tun_attach(), the re-attach block depends only on
tun->filter_attached and not on IFF_PERSIST:

    if (!skip_filter && (tun->filter_attached == true)) {
        lock_sock(tfile->socket.sk);
        err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
        release_sock(tfile->socket.sk);
        if (!err)
            goto out;
    }

TUNATTACHFILTER sets filter_attached whether or not IFF_PERSIST is set.
That means the inverted check is also reached in two more cases:

  - adding a queue to a live, non-persistent multiqueue TAP through
    tun_set_iff()
  - every TUNSETQUEUE with IFF_ATTACH_QUEUE, because tun_set_queue()
    always passes false for skip_filter:

    ret = tun_attach(tun, file, false, tun->flags & IFF_NAPI,
                     tun->flags & IFF_NAPI_FRAGS, true);

In those cases a successful filter read makes TUNSETIFF or TUNSETQUEUE
return success for a queue that was never published.

A failed read on a detached tfile leaves err negative. TUNSETQUEUE then
reports failure for a queue that was in fact attached, without a filter.

Could the commit message describe the full scope? It matters when
deciding on backports.

The subject line also looks misleading. The baseline tun_net_xmit()
already ran the filter through sk_filter_reason(). What changes is where
the program is stored: per-socket sk_filter before, per-device
tun->cbpf_prog now.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d4870bdc156f4..fe3e197997098 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -1096,10 +1089,20 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto drop;
>  	}
>
> -	if (tfile->socket.sk->sk_filter) {
> -		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
> -		if (drop_reason)
> +	/* Classic filter set with TUNATTACHFILTER.  A queue attached with
> +	 * IFF_NOFILTER does not run it.
> +	 */
> +	prog = rcu_dereference(tun->cbpf_prog);
> +	if (prog && !READ_ONCE(tfile->nofilter)) {
> +		/* A filter returning 0 drops the packet, any other value is
> +		 * the length to keep.  pskb_trim() does nothing when that
> +		 * length is larger than the skb.
> +		 */
> +		len = bpf_prog_run_clear_cb(prog->prog, skb);
> +		if (!len || pskb_trim(skb, len)) {
> +			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
>  			goto drop;
> +		}
>  	}
>
>  	len = run_ebpf_filter(tun, skb, len);

[Severity: Low]
Should the commit message mention that the classic filter behaves
differently at runtime now?

The old sk_filter_reason() call goes through sk_filter_trim_cap(). Before
it runs the program, that function does three things:

  - drops skb_pfmemalloc() skbs for sockets without SOCK_MEMALLOC
    (SKB_DROP_REASON_PFMEMALLOC)
  - runs BPF_CGROUP_RUN_PROG_INET_INGRESS
  - calls security_sock_rcv_skb() (SKB_DROP_REASON_SECURITY_HOOK)

It also sets skb->sk while the program runs and uses
bpf_prog_run_save_cb().

The new code only calls bpf_prog_run_clear_cb() and pskb_trim(). Filtered
queues therefore lose the pfmemalloc drop, the LSM hook and those drop
reasons. Losing the cgroup hook changes nothing, because the tun socket
is AF_UNSPEC.

The attach side changes as well. The old sk_attach_filter() path charged
bpf_prog_size(prog->len) against net.core.optmem_max in
__sk_filter_charge() and returned -ENOMEM above that limit.

The new tun_attach_filter() uses bpf_prog_create_from_user(), which has
no such limit. TUNATTACHFILTER now accepts filters it used to reject.

This is a UAPI ioctl path in a Fixes-tagged patch. Could the changelog
list these differences, or explain why they are not needed?

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 53c042b267ab6..fdd7fd8542747 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1565,7 +1565,6 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(sk_attach_filter);
>
>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>  {
> @@ -11775,7 +11774,6 @@ int sk_detach_filter(struct sock *sk)
>
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(sk_detach_filter);

[Severity: Low]
This isn't a bug, but does the export removal belong in a Fixes-tagged
patch? The fix itself does not need it.

Nothing in-tree breaks. The only remaining callers are SO_ATTACH_FILTER
and SO_DETACH_FILTER in net/core/sock.c. However, a stable branch that
picks this up because of the Fixes tag would also lose two exported core
networking symbols.

Could the export removal go to net-next as a separate patch, so the fix
stays minimal?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123054209.89946-1-clementwei90%40163.com
