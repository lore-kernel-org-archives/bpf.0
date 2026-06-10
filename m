Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D3301465;
	Wed, 10 Jun 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099277; cv=none; b=SVaLBHUaLMC/EDynuN/ciI35Syn323yijJ6kFyJE8yy7OkingVx2M0slzSZOLxQA6LdGvY1OJwU0hvJTq6t8FXe8rzDTPjPP7JjEzeVLV6lHITuxvjFOWQxGi8RrSTmjqLraIUqDO4IIqszNXXN9X7LGkvb3vBb992qP+3gsH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099277; c=relaxed/simple;
	bh=EcqrCMJnLaI4ahCPCDa1jjuU7A2nPGKEK3alQBuM/L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhGy+ly7oiTV/uMBNLzNaAs0D1b2ATj3bTuKS3W4UFttt0cNzbsu9APNRhjAIkMOLB/lTclEX+9R8lbVKOngy7jVWaWyWv4aCyH1xIer945cQORl/ocvelKoyGPuJHEGkBh1nO11jcKF/kfyfOnziJ5wB5QoWNs0SbjBSL0h1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGKf7O7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGKf7O7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132111F00893;
	Wed, 10 Jun 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099276;
	bh=5aqdONDLwfsE1SB/1cQIVbs5/yzaZE551VClwYnd4ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGKf7O7mLBMw97SnUrDLtZEJkkNSWlKxRtoeH43LMuOWwjGTJhFKY+LOvIsHtSwpw
	 Bzeuk4hWMVmXP4bBJJ5W7c448d3HSmTIKLAc8kwwPU3THiO8hTPRy5tIKRTH/AuoGR
	 BfK+fIlAgtinungqDZDRgU9mw7aYPq8jJLltSOrrUHsLLtqBYe4mNlwAnOsfAu0wXm
	 1Bso7VY50dyFnxtt3LAgBakvYpT89mC+ympSz380NXlJFSdo+ZZonNdCZnSKhFolJN
	 pnX2TY4Wc4DzfIsIHYb1x0hTuBWVOr+v0YHD07FvskE7KIIVLO2PZH4o9ZJLypCFfs
	 LNkMajmuA+0rg==
From: Simon Horman <horms@kernel.org>
To: rhkrqnwk98@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	brakmo@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Wed, 10 Jun 2026 14:46:34 +0100
Message-ID: <20260610134633.428711-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
References: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
tcp: clear sock_ops cb flags before force-closing a child socket

This patch clears the inherited bpf_sock_ops_cb_flags on a child socket
before inet_csk_prepare_forced_close() drops the socket lock, so the
subsequent tcp_done() does not invoke tcp_call_bpf() without the lock and
trip sock_owned_by_me(). The fix is applied at the put_and_exit labels in
tcp_v4_syn_recv_sock() and tcp_v6_syn_recv_sock().

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 98848db62894..97eac5fa341c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>  	return tcp_call_bpf(sk, op, 3, args);
>  }
>  
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> +{
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
> +}
> +
>  #else

[ ... ]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..7748668dba82 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1783,6 +1783,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  	return NULL;
>  put_and_exit:
>  	newinet->inet_opt = NULL;
> +	tcp_clear_sock_ops_cb_flags(newsk);
>  	inet_csk_prepare_forced_close(newsk);
>  	tcp_done(newsk);
>  	goto exit;

[High]
Should the same clearing also be added to chtls_recv_sock() in
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c?

That function clones a child via tcp_create_openreq_child() ->
inet_csk_clone_lock() (which inherits the listener's
bpf_sock_ops_cb_flags), and on its error paths (dst lookup, neighbour
lookup, port mismatch, chtls_sock_create(), or l2t_entry allocation
failure) it falls through to free_sk:

drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c:chtls_recv_sock() {
    [ ... ]
free_sk:
	inet_csk_prepare_forced_close(newsk);
	tcp_done(newsk);
free_oreq:
	chtls_reqsk_free(oreq);
	return NULL;
}

That sequence looks like it would hit the same sock_owned_by_me() warning
in tcp_set_state() -> tcp_call_bpf() if BPF_SOCK_OPS_STATE_CB_FLAG was set
on the listener, which is the case the commit message describes.

Would it be more robust to clear the cb flags inside
inet_csk_prepare_forced_close() itself so the invariant holds for every
present and future caller, or alternatively to add
tcp_clear_sock_ops_cb_flags(newsk) at the chtls free_sk label as well?
