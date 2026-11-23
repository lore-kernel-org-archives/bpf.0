Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423643;
	b=ug5GUOonisR83PsJPtADgsUdabU9EgXHbDAmBRHPkYZnsOqpGBT5hHJkpphYa9JvpaYE
	 hNpA1ikUgnKODhQ3U1xvFadjmxCE2X0yW69yp71igp8aKr5+tFGcj72Nts3NeJXhdRsi1
	 WN2bbEmMlOwKXPEQPZ1rbjFeg5ujp80ngXqWEaOCQuvdtm5pPAtwwbFvd3woP1fwInEsj
	 150Gn9D/om35gRR8CsWxMocnEqW2u5OCOpYXmO6LI6tFJ/4E/L1Ecs+UFYbn0yiiQNmdz
	 V8C3r07gwY4/UJmmBjWd8j4dx8ELlfkObGDoUezhJdBvX3SwI3rVZvmOMez+WR1v8pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423643;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0xoAI2aZiZKz5fbdLwbV+D0yONBgbldgE9alS44kdKk=;
	b=OEeKWWiGGaKaqgXUvg+ocfTyWILUVreUEUauniwLNTSB1A9SbG2C7fEXev6xWAzfTkRP
	 0oR2Cn203T1NHPX//q35Yju6ocA1rXW5+PtLaF/bbDkNnCUftTBIbZ60KT1KzgldBzfdd
	 3VmrklB+nEo+pQ9Br86uyDB+OeSibBn8+KOW2crOv6QFv+gH6XsWhcbSgpbrqNcGvFLo2
	 IhC9jdwFQXaN50taKxZnlb2y9tUYVjKgJ2DYxitNBM2bejElnJ6n9DVZUDZcPnbAlxFVM
	 Bp9nH4Wt9SoCH7u/xhD5RAepff70ri/LfCKMLkZtV+MUwkyotQYbscBjl/2COtRFE3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rwf2JgKV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC30606A31A;
	Mon, 23 Nov 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rwf2JgKV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874071F000CF;
	Mon, 23 Nov 2026 08:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423643;
	bh=0xoAI2aZiZKz5fbdLwbV+D0yONBgbldgE9alS44kdKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rwf2JgKVsS3H77PJppUUvv4nvblUNhTmnDqxT48OAdT320TnAi1uKuDRQraIwOHaG
	 JCzJ0OKgG61F1cK9knaS845UxSk6CpippWqnnhBaPP5kYAdH9M+C0gsvV7tLUQGHCh
	 OYaNnjGujS3YmQ29L0uKMFj6fmB/N2KhhCHIYHIXxOOiRJ3xCrRqTKz+Zc9N9SqsxD
	 UPcft5J44vREXgLF+PiIpSqO8lP5qv4OQsuiqZEE6jf2GPoR/dEMPrmUrc4i3eGM+Y
	 gXGhyXAhr+71ykOkbRT5qUvGqrhZi0iQvmPyWDIwEYQaas4XC0apDCmcu5MBMAmCHu
	 U1ZraY5e/o6Lg==
Subject: Re: [PATCH net] net: reuseport: honour SO_LOCK_FILTER in
 SO_DETACH_REUSEPORT_BPF
From: netdev-bot+sashiko@kernel.org
To: shyckless@gmail.com
Cc: pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 linux-kernel@vger.kernel.org, horms@kernel.org
Date: Mon, 23 Nov 2026 08:47:22 +0000
Message-ID: <179542364209.3135.6346728453187808939@kernel.org>
In-Reply-To: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
References: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix only covers the setsockopt(SO_DETACH_REUSEPORT_BPF)
  path.

--

net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF

This commit makes reuseport_detach_prog() return -EPERM when
SOCK_FILTER_LOCKED is set. Without it, an unprivileged process that is
handed a locked socket can remove the reuseport program with
SO_DETACH_REUSEPORT_BPF. This matches what sk_detach_filter() already
does.

> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index b9e5648fa4c51..cdff61161a70a 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -727,6 +727,9 @@ int reuseport_detach_prog(struct sock *sk)
>  	struct sock_reuseport *reuse;
>  	struct bpf_prog *old_prog;
>  
> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
> +		return -EPERM;
> +

[Severity: Medium]
This closes the setsockopt(SO_DETACH_REUSEPORT_BPF) path. Can the holder
of a locked TCP SO_REUSEPORT listener still drop the program by
disconnecting the listener and then calling listen() again?

connect(fd, AF_UNSPEC) or shutdown(fd, SHUT_RD) on a listener goes
through this chain, and none of these functions check SOCK_FILTER_LOCKED:

tcp_disconnect()
  tcp_set_state(sk, TCP_CLOSE)
    sk->sk_prot->unhash(sk)
      inet_unhash()
        reuseport_stop_listen_sock()
          reuseport_detach_sock()

With net.ipv4.tcp_migrate_req at its default of 0, and a program that is
not BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, reuseport_stop_listen_sock()
reaches the immediate detach:

net/core/sock_reuseport.c:reuseport_stop_listen_sock() {
    ...
	/* Not capable to do migration, detach immediately */
	reuseport_detach_sock(sk);
    ...
}

reuseport_detach_sock() clears sk->sk_reuseport_cb. If this socket was
the only member, it also frees the group:

	if (reuse->num_socks + reuse->num_closed_socks == 0)
		call_rcu(&reuse->rcu, reuseport_free_rcu);

reuseport_free_rcu() then releases the locked program:

	sk_reuseport_prog_free(rcu_dereference_protected(reuse->prog, 1));

tcp_set_state() keeps the port bound when SOCK_BINDPORT_LOCK is set, so
listen() can be called again on the same port:

		sk->sk_prot->unhash(sk);
		if (inet_csk(sk)->icsk_bind_hash &&
		    !(sk->sk_userlocks & SOCK_BINDPORT_LOCK))
			inet_put_port(sk);

On the second listen(), inet_reuseport_add_sock() finds no sibling and
calls reuseport_alloc(). Because sk_reuseport_cb is now NULL, this
creates a new group with prog == NULL. The socket keeps listening on
the same port, but the program is gone.

Documentation/networking/filter.rst says that once SO_LOCK_FILTER is
set, "a filter cannot be removed or changed" and that the filter "will
be kept until the socket is closed".

This only happens when the locked socket is the only member of its
group. If it has siblings, re-listen puts it back into the existing
group through reuseport_add_sock(). With migration enabled, the socket
moves to the closed section and keeps the program.

In a one-socket group, the program matters mostly when an SK_REUSEPORT
eBPF program uses SK_DROP to decide which connections are admitted. The
group-wide load-balancing change described in the commit message cannot
happen through this path.

Should the disconnect and re-listen path also respect
SOCK_FILTER_LOCKED, or should the commit message say that only the
setsockopt detach path is covered?

>  	old_prog = NULL;
>  	spin_lock_bh(&reuseport_lock);
>  	reuse = rcu_dereference_protected(sk->sk_reuseport_cb,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-reuseport-lock-filter-v1-1-a3e5324c8d55%40gmail.com
