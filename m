Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588004;
	b=W5fhBvqR9p5+xHegebIxDlD+36sUGY8JrYE0+8dXWiipUYCrQ5xpoeob6lg9bSLsoMSJ
	 VbTXHFzlqdDOC284QI4l5j6NiPPvhyNxBtf59qo6o9DNvMC4deUB6c5kAyziULKDFTR4G
	 pllFwXBrnN5opgBygj6/wBAJ88Jge5OZSkUTlIycIwwZI0x0E1ySBxk1f/49PhK8ocIcY
	 klGphhRwR8MCYyT6APSbAt7gMezZu1zi1lqEwK4waofCAHfVBhkopWvGWXD07djR3m9LI
	 SK+sXPC8P+VslFkXgVMVgNWNnig49A8J50vq7NGQek6FXCZ4DzGVH6hUgZcsXe5bKIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588004;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Rn9PqFnfpuoHJ1p+/i18uTIImbl2FVfMSYLpDhRmrNk=;
	b=zEspxdu0zI3qOMcbpvNGRiZ/HIiRIFZpmEjtqrBR+ZPfdOEY5FwSZRIxwB0q/38cnF0I
	 DwNNIk5+HatKje8Iwd2hJoQoDmlN7C30yKND2xfZotRky5wX9AZSiBl/0OARqomdxh4o3
	 vVOlST0KunjgsejRbvcZuO9z21OTkKmoqsyJ4S/NuE1M7p/YSrd9ZDtRYO+5Lhj+TvUa7
	 XXEGjXCk+K1j+1VQcO4HMUiPtIWAh0pmwljRWYGI2c9jz9L84Y+2CzEY5/uRjQ9Y3yhwX
	 1L2Nsy8cmQzvQla7bJ42xClHd52Xt4Rm3Z/tvwn91gL+kWi5QD8GnNDLzZhfucl8E9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InkzsUGJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90844606A31E;
	Wed, 25 Nov 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InkzsUGJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B881F000C0;
	Wed, 25 Nov 2026 06:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795588004;
	bh=Rn9PqFnfpuoHJ1p+/i18uTIImbl2FVfMSYLpDhRmrNk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=InkzsUGJgnku+74xY2cYRsa2DHkJvU6QEYWFH88gS7y1lrlP32sFQEARAcY4Z7Qc1
	 yZLBnv2Dnm2GhIlmb/5YcwIDsAS5XWbEfltFpMr9lMLjularJMGcopm0wHzBhLrs7F
	 FDL68Jgexg3ISJQbwf6o9wCaxGrSHEb5jc3FdG/xmzGAjYTp6MMezFjriEFwbckpqs
	 jYMfF5GRSgrjUyyM85nSBuwLQeTZIMoggO/pVLkjgRszBR8ex9bbboamefIz8qlVGu
	 4QksfSCIcBikFbpd3pzlGreNVgSkMKqIX1fNKgnvZ247rGB+lJC85muBLQrXUMlPPj
	 r+UaJ1tVxrefg==
Subject: Re: [PATCH net] tcp: fix CA module refcount underflow in
 tcp_v4_syn_recv_sock()
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, fw@strlen.de, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 25 Nov 2026 06:26:42 +0000
Message-ID: <179558800299.3135.4905748131998876050@kernel.org>
In-Reply-To: <20261124062625.264148-1-jiayuan.chen@linux.dev>
References: <20261124062625.264148-1-jiayuan.chen@linux.dev>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new error path in tcp_v4_syn_recv_sock()
  (net/ipv4/tcp_ipv4.c) jumps to clear_ca_and_exit when…
- [Low] The commit message presents the bug as a module refcount
  underflow that shows up as a module_put() WARNING.

--

tcp: fix CA module refcount underflow in tcp_v4_syn_recv_sock()

The child socket inherits icsk_ca_ops from the listener without taking a
reference. If inet_csk_route_child_sock() fails, the child then puts the
listener's reference. This patch clears icsk_ca_ops on that error path and
makes tcp_cleanup_congestion_control() skip a socket that has no CA.

> If inet_csk_route_child_sock() fails in between, we go to put_and_exit
> and tcp_done() ends up in tcp_cleanup_congestion_control(), which puts
> the reference unconditionally. The one dropped belongs to the listener.

[Severity: Low]

Is the impact larger than a refcount underflow warning?

module_put() uses atomic_dec_if_positive() and only warns when the count
would go negative:

kernel/module/main.c:module_put() {
    ...
		ret = atomic_dec_if_positive(&module->refcnt);
		WARN_ON(ret < 0);	/* Failed to put refcount */
    ...
}

While the listener still holds its reference, the child's put in
tcp_cleanup_congestion_control() succeeds silently and uses up the
listener's reference. The quoted WARN only fires after earlier occurrences
have already drained that reference.

Once that has happened, try_release_module_ref() lets rmmod of tcp_bbr
succeed while the listener's icsk_ca_ops still points into the module.
Later children read icsk_ca_ops->owner through bpf_try_module_get() in
tcp_ca_openreq_child(), and closing the listener calls ->release() on it.
Could either of these be a use-after-free?

If the count has dropped below the base instead, rmmod would hit
BUG_ON(ret < 0) in try_release_module_ref().

For BPF struct_ops congestion control, bpf_module_put() goes through
bpf_struct_ops_put() -> bpf_map_put():

include/linux/bpf.h:bpf_module_put() {
	if (owner == BPF_MODULE_OWNER)
		bpf_struct_ops_put(data);
	else
		module_put(owner);
}

In that case the extra put drops a struct_ops map reference while the
listener is still using the map.

Could the commit message describe this impact, for the benefit of stable
maintainers?

> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index e3f462f161dd6..0f99405a78b11 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -271,6 +271,9 @@ void tcp_cleanup_congestion_control(struct sock *sk)
>  {
>  	struct inet_connection_sock *icsk = inet_csk(sk);
>  
> +	if (!icsk->icsk_ca_ops)
> +		return;
> +
>  	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
>  		icsk->icsk_ca_ops->release(sk);
>  	icsk->icsk_ca_initialized = 0;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 2fc92a7884fc8..8aa52376cf0aa 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1732,7 +1732,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  	if (!dst) {
>  		dst = inet_csk_route_child_sock(sk, newsk, req);
>  		if (!dst)
> -			goto put_and_exit;
> +			goto clear_ca_and_exit;
>  	} else {
>  		/* syncookie case : see end of cookie_v4_check() */
>  	}
> @@ -1789,6 +1789,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  exit:
>  	tcp_listendrop(sk);
>  	return NULL;
> +clear_ca_and_exit:
> +	/* newsk holds no reference on the inherited CA yet. */
> +	inet_csk(newsk)->icsk_ca_ops = NULL;

[Severity: Medium]

Does this comment hold in all cases?

tcp_create_openreq_child() calls inet_csk_clone_lock(). That function moves
the child to TCP_SYN_RECV and then calls security_inet_csk_clone(), all
before the route lookup above:

net/ipv4/inet_connection_sock.c:inet_csk_clone_lock() {
    ...
	inet_sk_set_state(newsk, TCP_SYN_RECV);

	inet_clone_ulp(req, newsk, priority);

	security_inet_csk_clone(newsk, req);
    ...
}

bpf_lsm_inet_csk_clone is listed in bpf_lsm_locked_sockopt_hooks in
kernel/bpf/bpf_lsm.c. A BPF_LSM_CGROUP program attached there can
therefore call bpf_setsockopt(TCP_CONGESTION) on the child:

sol_tcp_sockopt_congestion()
  do_tcp_setsockopt()
    tcp_set_congestion_control()
      bpf_try_module_get(ca, ca->owner)  <- takes a reference on the new CA
      tcp_reinit_congestion_control()
        tcp_init_congestion_control()    <- ca->init(),
                                            icsk_ca_initialized = 1

If inet_csk_route_child_sock() then fails, clear_ca_and_exit sets
icsk_ca_ops to NULL. tcp_done() -> tcp_v4_destroy_sock() ->
tcp_cleanup_congestion_control() then returns early at the new NULL check.

Does this leak the module (or struct_ops map) reference on the new CA and
skip its ->release()? Before this patch, that reference was put correctly
on this path. Only the listener's reference, dropped by
tcp_reinit_congestion_control(), was unbalanced.

The notes below the --- say the lsm_cgroup case is being fixed separately
in the bpf tree. However, icsk_ca_setsockopt is inherited from the
listener, so this error path cannot tell the two cases apart.

Would taking the reference in tcp_create_openreq_child(), as in the
alternative diff in the notes, cover both cases?

>  put_and_exit:
>  	newinet->inet_opt = NULL;
>  	inet_csk_prepare_forced_close(newsk);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124062625.264148-1-jiayuan.chen%40linux.dev
