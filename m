Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A773BADAA;
	Mon, 17 Aug 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986796; cv=none; b=aBSCH0BE2ukH5Vr1gyD3OCjoKgopiVBXXWehsNNHbzusSqj/6NaPUn3xul3hkqE88g5ZLuyUZryW1HLU4aYIEHOoDxcTujMXuCj0rw+MDRgC2CUHDlw4hrzDf4qOnBySSGD+AHcNRks783FhDDK9WEV4xpKalh6Q4ibBGCZ4NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986796; c=relaxed/simple;
	bh=ls9qQUR1hZVFCYLQG8ubjDr2E+9tf8y7M1uxasV+TgA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nUUYq2AOcsrJhj7430II0Bs1TwtgfTMFsXLw1fGsXArj1mEDcrY7oVAGddk6/q2WPW/5+oxwSLzmEKUM8ownAOdl46PkQ8iUhijr71cBmRYEZD5kGCY1b6bkDJQyyS5AlLHpOQRiXGex9SkklTLoR3UTAU1whGDofYjWhdxC5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/EhWD/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/EhWD/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF51F000E9;
	Mon, 17 Aug 2026 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786986794;
	bh=UF1+Qjd+tN08xa7oM68EPTTiZxwvLfr/wr7qKne9RYM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H/EhWD/5MKNElh4vEbnsJk0bx0Z8JUO69vd25fuL3NrMCSaYVqxxP6/HBjnjP7cxD
	 NW7JhQ/QLtiehBPyoPECEVE+z9cYASP8aEuQaEyh3IO5mS9v3VYhXNKQXfwYJjks6M
	 DH0TaH4Y3fgFUf6Nnh/aZxdcLjN1BzitPqegGXYoFsK/iiKPIH0Ii9QpZKoCyDT/hX
	 Nr0P2WFiMCbFgiPBGvq9xZkAojtJ8b1wAomSe30HbdRpH9TfvcRb9c+Xxh93yFwVTC
	 IqoAXA8WNuukwRmoqgc3LHJjDsCADQGSj0zZVJMkjB+kcC/8sZNbc6OqxCVgWFHI0G
	 W7GU9Cpq4q3AA==
Content-Type: multipart/mixed; boundary="===============6078595138110994450=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <254f3972f477e13f89ac620d447750799144c889188ddd6de1bb9bd9e2f34039@mail.kernel.org>
In-Reply-To: <20260817155009.232670-2-zirajs7@gmail.com>
References: <20260817155009.232670-2-zirajs7@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS
From: bot+bpf-ci@kernel.org
To: zirajs7@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev
Cc: davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,eddyz87@gmail.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,rhkrqnwk98@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 17:13:13 +0000 (UTC)

--===============6078595138110994450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..347cb168f749 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -586,21 +586,24 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
>  }
>
>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
> -				     u32 off, u32 len, bool take_ref);
> +				     u32 off, u32 len, bool take_ref,
> +				     bool settle_fwd_alloc);
> +static int sk_psock_skb_ingress_self_backlog(struct sk_psock *psock,
> +					     struct sk_buff *skb,
> +					     u32 off, u32 len, bool take_ref,
> +					     bool settle_fwd_alloc);

The forward declaration of sk_psock_skb_ingress_self() at line 588 is
now dead code. Before the commit, sk_psock_skb_ingress() (defined at
line 596) called it for the skb->sk == psock->sk case, which required
the forward declaration. This commit redirects that call site to
sk_psock_skb_ingress_self_backlog() instead. The only remaining caller
is sk_psock_verdict_apply(), which is well after the definition. Should
this prototype be removed?

[ ... ]

> @@ -618,34 +621,100 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  	return err;
>  }
>
> -/* Puts an skb on the ingress queue of the socket already assigned to the
> - * skb. In this case we do not need to check memory limits or skb_set_owner_r
> - * because the skb is already accounted for here.
> +static int sk_psock_skb_ingress_self_assign(struct sock *sk,
> +					    struct sk_buff *skb,
> +					    bool settle_fwd_alloc)
> +{
> +	/* Leave skbs already receive-accounted to sk untouched. */
> +	if (skb->sk == sk && skb->destructor == sock_rfree)
> +		return 0;
> +
> +	if (settle_fwd_alloc) {
> +		sock_owned_by_me(sk);
> +
> +		if (!sk_rmem_schedule(sk, skb, 0))
> +			return -EAGAIN;
> +	}
> +
> +	skb_set_owner_r(skb, sk);
> +	return 0;
> +}
> +
> +/* Puts an skb on the ingress queue for psock->sk.
> + *
> + * If the skb already has receive ownership for this socket, leave socket
> + * memory accounting untouched. Otherwise, before assigning receive ownership
> + * to an unowned strparser SK_PASS skb, settle any existing sk_forward_alloc
> + * deficit from earlier clone charges.
>   */
>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
> -				     u32 off, u32 len, bool take_ref)
> +				     u32 off, u32 len, bool take_ref,
> +				     bool settle_fwd_alloc)
>  {
> +	struct sock *sk = psock->sk;
>  	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
> +	int err;
> +
> +	if (unlikely(!msg))
> +		return -EAGAIN;
> +
> +	err = sk_psock_skb_ingress_self_assign(sk, skb, settle_fwd_alloc);
> +	if (err)
> +		goto free;
> +
> +	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> +	 * data originates from the socket's own protocol stack. No need to
> +	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
> +	 */
> +	msg->sk = sk;
> +	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg,
> +					   take_ref);
> +	if (err < 0)
> +		goto free;
> +
> +	return err;
> +free:
> +	kfree(msg);
> +	return err;
> +}
> +
> +static int sk_psock_skb_ingress_self_backlog(struct sk_psock *psock,
> +					     struct sk_buff *skb,
> +					     u32 off, u32 len, bool take_ref,
> +					     bool settle_fwd_alloc)
> +{
>  	struct sock *sk = psock->sk;
> +	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
>  	int err;
>
>  	if (unlikely(!msg))
>  		return -EAGAIN;
> -	skb_set_owner_r(skb, sk);
> +
> +	lock_sock(sk);
> +	err = sk_psock_skb_ingress_self_assign(sk, skb, settle_fwd_alloc);
> +	release_sock(sk);
> +	if (err)
> +		goto free;
>
>  	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
>  	 * data originates from the socket's own protocol stack. No need to
>  	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
>  	 */
>  	msg->sk = sk;
> -	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
> +	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg,
> +					   take_ref);
>  	if (err < 0)
> -		kfree(msg);
> +		goto free;
> +
> +	return err;
> +free:
> +	kfree(msg);
>  	return err;
>  }

Is GFP_ATOMIC necessary in sk_psock_skb_ingress_self_backlog()? The
function is only called from sk_psock_backlog(), which is the psock
backlog worker running in plain process context - the lock_sock() call
proves it can sleep. Before this commit, these same skbs were allocated
by sk_psock_create_ingress_msg() with alloc_sk_msg(GFP_KERNEL). Would
GFP_KERNEL be more appropriate here to avoid draining atomic reserves
and reduce the chance of allocation failure under memory pressure?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32045036810
--===============6078595138110994450==--
