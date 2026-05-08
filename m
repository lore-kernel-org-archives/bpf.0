Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A161A3165
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276795; cv=none; b=WWPnOCjN5wGb/7Wnn97RYODRav4BDnYTc3cEu3si7PwWVn/W71OBMshVy83IGCwIoHlnzgUEP3X9wtnhno8/qxaQfuD0O103kbRoMbhCNUpEsEx/plab1G6C2LgWXLLbvHXYZEb/7r9S08JXL0YxuIMtkpGOcQzOB1MTtC7TIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276795; c=relaxed/simple;
	bh=xlvaJKipbHmqqS3BiYENQFy3ug5B0xP9nkZFBmddAag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FL2P71rQp/0R+FOS6Bak8WyMRL4kSGU9sxe/jN5KDOQhg2KNsL5EiSmMoLJHshy2jW1QBz5IcJXiXRn7ByQtIUMNJNI+/21kfuMP7Vwte/mrcQ92DJlE8C4h1fsfR+tX3b4EX08c4NiW8kaEeqXSsPIPWVmktpJHgTgv6EySEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQWS/Csi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQWS/Csi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ABBC2BCB0;
	Fri,  8 May 2026 21:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778276794;
	bh=xlvaJKipbHmqqS3BiYENQFy3ug5B0xP9nkZFBmddAag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TQWS/CsiUsjMSDeU1MxJ0vkW3faHtlhRPOHf+pfrhzdCyYDffZHWyDBDYaTn3w8M4
	 yObgVc59ALM97LKbEptiN94/bXe5MYgTyG/UHaq8b5CqA09rCb+TqtYoRzTCz0EgxN
	 FhCriGoVyOef59o5rl8bOXKHdWM8GviZce+rJTJZtetCM/77Z9vP5/3zATGUohU2hf
	 QrpPT+ilE++E2YnWVHQvH1iKYW7NlN8ljnqgbZe84XtDfg+9KzZGbbwvWNwEcpaa5u
	 QqaYlRulSVrkGpdsuqkA1LwyNbkCZMQIYh5q2SyPu3jlLMG0jBkJ/ATXHOPmZdWmUG
	 B5NGo6WvM+OXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508073355.3916746-8-kuniyu@google.com>
References: <20260508073355.3916746-8-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:46:34 +0000
Message-Id: <20260508214634.A0ABBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new BPF_SOCK_OPS_RCVLOWAT_CB hook is incorrectly rejected by i=
s_locked_tcp_sock_ops(), preventing the BPF program from modifying callback=
 flags.
--

commit ef96e613bd920ae4e567781955c5e3d4f11f7f57
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Add SOCK_OPS rcvlowat hook.

This commit introduces a new BPF_SOCK_OPS_RCVLOWAT_CB hook that is invoked
when TCP enqueues an skb or completes recvmsg(). The hook allows BPF
programs to dynamically adjust sk->sk_rcvlowat to suppress unnecessary
wakeups.

[ ... ]

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7e26503fd96d4..a70a8f5830258 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -204,6 +204,12 @@ static void bpf_skops_established(struct sock *sk, i=
nt bpf_op,
>  	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
>  	bpf_skops_common_locked(sk, bpf_op, skb, skb ? tcp_hdrlen(skb) : 0);
>  }
> +
> +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +	/* skb is NULL when called from __tcp_cleanup_rbuf(). */
> +	bpf_skops_common_locked(sk, BPF_SOCK_OPS_RCVLOWAT_CB, skb, 0);
> +}

Does this regression prevent the BPF program from dynamically disabling the
hook once the RPC boundaries are known?

Since BPF_SOCK_OPS_RCVLOWAT_CB is greater than BPF_SOCK_OPS_WRITE_HDR_OPT_C=
B,
is_locked_tcp_sock_ops() will return false for this hook:

net/core/filter.c:is_locked_tcp_sock_ops() {
	return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
}

While this intentionally prevents bpf_setsockopt() from being used
unnecessarily, bpf_sock_ops_cb_flags_set() also relies on this check:

net/core/filter.c:bpf_sock_ops_cb_flags_set() {
	if (!is_locked_tcp_sock_ops(bpf_sock))
		return -EOPNOTSUPP;
	...
}

This means any attempt to clear the callback flag using
bpf_sock_ops_cb_flags_set() within the hook will fail with -EOPNOTSUPP.
This could force the callback to run on every single SKB enqueue for the
lifetime of the connection.

Should is_locked_tcp_sock_ops() or bpf_sock_ops_cb_flags_set() be updated
to allow disabling the callback flag for this new hook?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508073355.3916=
746-1-kuniyu@google.com?part=3D7
