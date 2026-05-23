Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A119327C08
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529374; cv=none; b=IVihuR9G1xbB9y6YbXpqNpBsC2TBW+fBUXt8PooJO1GvINqz5EcD+ZyJFUB5gEMlIq59h5KgT3jnQpjMI/SuY2JquobsbyynfN4wPLZdz7KqyyIXu66hc0Z6tJG5B4sPcm/CBTEOXRcoc4uJfu9Bh3ULTK9Y2meqsHP+lPX9Xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529374; c=relaxed/simple;
	bh=W/6kz4YzNCMzYp7Y2dmV9H1+ozDO4Zw205P1+R+c+hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DGLrubU40nJmj2KHLeL9IgW6i5Mo9dOnTgz3v48run4NbJ/MJNFTjCnHBbnddwN7CM3uEPlWyFbmCbDtIN7KMebJ9s6rajCoknApL/F5xvvpj4YPzJCtEl+1QmoxUdHWXhPlfRxt1bo9IjWQH5gukWyJUp2H5QE6C5ulgjCBsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbmIedzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbmIedzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DAA1F000E9;
	Sat, 23 May 2026 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779529372;
	bh=KzY5xxxpkYMGe3iKbZpuDiu+w8K1/JXW48WFlKXpAXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbmIedzNmS++JLzn+OhY3JcSL/2/BNVuUa9/eNec6a4giljAbmPNXx5/K3TYACqyH
	 aQgGusWfHniCqcnSt41lFxywWrkDnflD8rp9Es43+Lh6LeS6g6ZlwcoibAQKhpUdwU
	 xPrvk+z68rdhgpiAIYeYb/+2f3JUUtnqHAwCcE7mmFIF7Lm2KryrnZ76BYrHExfSHv
	 poNPtd+EGD78TPKOpn12kPvTdSRHFY/L5GmnbpWhCkhVZCPFGX80Wbpt36kC5BnQIH
	 mOtdKr9CX5ZrMO+UVVNhmcN09FkEUptd5SQUzuwP0r+g5S7S9+MliKSB0R2F1hs1au
	 pqvkFV/qAIolw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB
 if receive queue is not empty.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523083001.2911931-9-kuniyu@google.com>
References: <20260523083001.2911931-9-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 09:42:52 +0000
Message-Id: <20260523094252.99DAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Lockless call to `skb_queue_empty()` on `sk_receive_queue` causes a=
 data race.
--

commit 928b34616ed5f1b766d25ef2fd83e4165fe1e903
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.

This commit modifies the behavior of BPF_SOCK_OPS_RCVQ_CB to explicitly fail
if it is enabled while the receive queue is not empty. It returns -EUCLEAN
to signal that the caller must drain the queue first.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 82ec2291d6f00..4041b9fc1c741 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct sock =
*sk, int val)
>  		return 0;
>  	}
> =20
> +	if (!skb_queue_empty(&sk->sk_receive_queue))
> +		return -EUCLEAN;

[Severity: Low]
Does this lockless call to skb_queue_empty() cause a data race?

The __bpf_sock_ops_cb_flags_set() function can be executed without the sock=
et
lock via the bpf_unlocked_sk_setsockopt() helper. At the same time, TCP
softirq processing like tcp_queue_rcv() may enqueue packets and modify
the receive queue.

Since skb_queue_empty() performs a plain read of list->next without
READ_ONCE(), this concurrent access can trigger KCSAN splats. Would it be
better to use skb_queue_empty_lockless() here to safely check the queue
state from potentially unlocked contexts?

> +
>  	if (unlikely(sk_is_mptcp(sk)))
>  		return -EOPNOTSUPP;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523083001.2911=
931-1-kuniyu@google.com?part=3D8
