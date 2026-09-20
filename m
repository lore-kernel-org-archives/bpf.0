Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87835CB61;
	Sun, 20 Sep 2026 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938999; cv=none; b=EW9MFdLSYDMfpOJXuEfkDbJVNpgCu2P1/o3lEePR8YsW8ayMIiI0/2aKhTTq6T/ekuczs7S4wQI3LC1Gq1yZPch4jMSbIGWxjx47fPWRZoDgK5uwOvj5coiUcR467dTMz7O/NCV6saBBpAxldoLrx8v7ecfrzWRFw7xuhMvaO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938999; c=relaxed/simple;
	bh=QpsXpXTE/O54qP53qDx3dVHeM3eDluhD8GFHYU6QP0c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MjV4DTTwkkCJ1FvftdqFl4KebQOZZT7FVV9CzYA7g6nBao+trSLQ98aWNiiyW29VrgnKDXXyMZHA/YsqQ67x16GgYnzvjRcCOJlFMv+ePgS3W2krCON+25oQJof86J7imphrXC8uf8TsJtq+6CGIriEs2VtF91hIB+q9GLDGYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6UJs+Hl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6UJs+Hl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D541F000FF;
	Sun, 20 Sep 2026 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789938998;
	bh=roZExYX3JeGmy0vQZXO7f/nQ0IzhZRyXtKu6GKA7Mac=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D6UJs+HlczSSMvyI5M05XHGLU9yY2F50WLt5rlTpq+P/DHNqBp6TIcuwUC3kIGpop
	 w94PYn2vD1tiGBrIJCMadWP9MENX5ZnAhZTZDhItPRwwwdg35C+YW3PKRbGiQ7OoWS
	 cYzk+JRXoeN4d2yMEGaSHAy5yEvIYODC9y/7azpMsmEdYrW+0zui7noKt749yBTzeX
	 By+RAX4geszJP9OLCLXb2wj/zodHCZk6TkVhFxHrbSetwhQ6qZyUXs0W7KwhSJPzNw
	 Lh9y60aj5mUK3GSCIpMjmmNe02vue+KwWVjWlh0HEcIVFN+rMABnADO6Q1JSyy64UQ
	 8UgC1k+/QKUIA==
Content-Type: multipart/mixed; boundary="===============7086350958053415542=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <66550c9d79f152d19c4b41e5698bcc778a7a2f436c0f879f3f0130828afb66d3@mail.kernel.org>
In-Reply-To: <20260920195633.3033620-7-kuniyu@google.com>
References: <20260920195633.3033620-7-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 21:16:35 +0000 (UTC)

--===============7086350958053415542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index b0e14b54917eb..3768b1440eb77 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops = {
>  	.owner = THIS_MODULE,
>  };
>
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +					 const struct bpf_prog_aux *aux)
> +{
> +	u32 moff = aux->attach_st_ops_member_off;
> +	bool wakeup = false;
> +
> +	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		wakeup = true;
> +
> +	if (rcvlowat < 0)
> +		rcvlowat = INT_MAX;
> +
> +	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
> +}

The commit message says:

> For enqueue_rcvq(), wakeup is set to false because:
>
>   * tcp_data_ready() is always called after the hooks in
>     tcp_queue_rcv() and tcp_ofo_queue().

Does the "always" claim hold for every tcp_queue_rcv() call site?

Looking at tcp_send_rcvq() in net/ipv4/tcp_input.c, which handles
receive-queue injection via TCP_REPAIR:

tcp_send_rcvq() {
    skb_set_owner_r(skb, sk);
    tcp_queue_rcv(sk, skb, &fragstolen);  /* enqueue_rcvq hook fires */
    return size;
}

tcp_send_rcvq() never calls tcp_data_ready(), and its only caller at
net/ipv4/tcp.c:1205 (the TCP_REPAIR receive-queue injection path in
tcp_sendmsg_locked()) just returns after err = tcp_send_rcvq(sk, msg,
size).

So when a BPF enqueue_rcvq program lowers sk->sk_rcvlowat while data is
injected via TCP_REPAIR, __tcp_set_rcvlowat() writes the new value with
wakeup = false and nothing re-evaluates EPOLLIN. A poll()/epoll waiter
that was blocked by the higher sk_rcvlowat won't wake until the next
real packet arrives.

The non-BPF TCP_REPAIR path already issues no wakeup (tcp_send_rcvq()
itself never calls tcp_data_ready()), so this is arguably a pre-existing
gap in the repair path rather than behavior newly broken by this kfunc.

Either way, should the commit message's "always" be qualified to exclude
the repair path, or should bpf_tcp_ops_set_rcvlowat() pass wakeup = true
whenever the new value is lower than the current READ_ONCE(sk->sk_rcvlowat)
so the decision doesn't depend on assumptions about all call sites?

The other two justifications were verified:

  * TFO SYN: tcp_fastopen_create_child() runs before accept(), so no
    waiter exists.

  * TFO SYN+ACK: tcp_rcv_synsent_state_process() in net/ipv4/tcp_input.c
    calls tcp_rcv_fastopen_synack() (which reaches tcp_fastopen_add_skb())
    before calling sk->sk_state_change(sk), so the wakeup does follow.

  * dequeue_rcvq: none of the tcp_cleanup_rbuf() callers calls
    tcp_data_ready(), so wakeup = true is required.

> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_tcp_ops_rcvlowat_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_tcp_ops_set_rcvlowat, KF_IMPLICIT_ARGS)
> +BTF_KFUNCS_END(bpf_tcp_ops_rcvlowat_kfunc_set)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35535082194
--===============7086350958053415542==--
