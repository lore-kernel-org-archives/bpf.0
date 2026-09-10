Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E14756CC
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040670; cv=none; b=R+9FgXbZ7iABK2XUk5+lBc7b16Ve9J2FajBT2g1DGRXj39Ng5Nc88sNTCuQJPbPW3n/AAnX/tS23u2EHdNq0Mr783PrEswiBUcmIHm6yZcXF1G5QlhUyQiLYGNtw2w/afjlRxNehCjb9EZWd906mtKbFB9rt6mKXPxkBZQydf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040670; c=relaxed/simple;
	bh=HnPBN6SNedQlvL1n95xP/v2bAruOf38ARPd+fI36Auk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/4RUFLxOZp3E9Nwk7vilNWhFjyOUhZfEcOii6K+TE4Z8Xuj2vU5+9dMwrhKdgr65yS7zJbPJ7pHlmbNIvXd+9+/ArtG5qae5Ykk8iGnaXxwbXVHnHVt6YquTuuDw/7uX90PddF4tob94DjAH//a5Dzn/eDjBHilOCoT6GYN+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxkUfMCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxkUfMCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFDF1F000FF;
	Thu, 10 Sep 2026 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040668;
	bh=MgM91SQ6kfOiswfm+Yyg5zLxN0JKUA8bgUa3B5ZHnvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxkUfMCxL1qMJagSVcdlbKOBKsCEGw7dJ/YgI4F7qTF5t7GKUOd4pP64SK/3t8DdI
	 /XPybDMHKMJMWeRCU0tiF+fcQEHW0D4kDUlQ+xIWYQyD+QJlfn5oO30fM4/6bZBKrC
	 Z5Fu7qu8991QsR2gu0aAqWqBObi/zjUcFFNxet5IfVbavIvUZIUNkPytn4V0iglaBa
	 hL/fawq+pS5EFveKj3e4Dox/PYZv89YkQfWBnOuoUvgQZY7S6RY4IYKPCRqc4wAMtt
	 6eXZcBzBEBilNR4K+ARquJvh3izbLTK3hCu6OIL+vC3ObWio3VA8eTj3zntuGB236H
	 aBqelw7NvMMSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/3] tcp: Skip cond_resched() in
 inet_csk_listen_stop() under BPF context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910112736.153710-1-jiayuan.chen@linux.dev>
References: <20260910112107.148770-1-jiayuan.chen@linux.dev>
 <20260910112736.153710-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:44:28 +0000
Message-Id: <20260910114428.7CFDF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_sock_destroy() incorrectly relies on has_current_bpf_ctx() to =
bypass lock_sock(), leading to lockless socket state mutations and data cor=
ruption.
--

commit 5e3e5dd8730687f6f2e1d9b86f565fa03b6e3366
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context

This commit skips cond_resched() in inet_csk_listen_stop() when running
under a BPF context. It prevents a "sleeping function called from invalid
context" BUG when bpf_sock_destroy() triggers tcp_abort() from a BPF
iterator.

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 6257459bcee24..6a30f11384547 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
[ ... ]
> @@ -1520,7 +1520,8 @@ void inet_csk_listen_stop(struct sock *sk)
>  		local_bh_enable();
>  		sock_put(child);
> =20
> -		cond_resched();
> +		if (!has_current_bpf_ctx())
> +			cond_resched();

[Severity: High]
This is a pre-existing issue, but propagating the use of
has_current_bpf_ctx() highlights a deeper locking bug in
bpf_sock_destroy().

Does relying on has_current_bpf_ctx() in tcp_abort() and udp_abort()
lead to lockless socket state mutations and data corruption?

When a BPF program of type BPF_TRACE_ITER obtains a socket pointer via a
lookup helper like bpf_sk_lookup_tcp(), or operates in an iterator like
iter/task_file that doesn't inherently lock the target socket, passing
this socket to bpf_sock_destroy() calls tcp_abort() or udp_abort().

In those functions, the socket lock is currently bypassed:

net/ipv4/tcp.c:tcp_abort() {
    ...
    /* BPF context ensures sock locking. */
    if (!has_current_bpf_ctx())
        /* Don't race with userspace socket closes such as tcp_close. */
        lock_sock(sk);
    ...
}

Because has_current_bpf_ctx() returns true in BPF context, lock_sock(sk)
is bypassed. Modifying socket state (like accept queues, timers, and
flags) locklessly can lead to use-after-free and list/RB-tree corruption.

Since the underlying bug stems from the commit that added
bpf_sock_destroy(), should the lock acquisition be addressed structurally
for those code paths instead of relying on has_current_bpf_ctx()?

>  	}
>  	if (queue->fastopenq.rskq_rst_head) {
>  		/* Free all the reqs queued in rskq_rst_head. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910112107.1487=
70-1-jiayuan.chen@linux.dev?part=3D2
