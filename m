Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D82727F3;
	Mon, 11 May 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502890; cv=none; b=dw7KC0JTx8xP7YnAloHFsKoDU4HNJ0czfILwJQi/q4oSBn5Oc3BGsSWEyMlhS4faCCJ/QoaYgrvL3Yzv5GwpizxcwAkrlA5QBXMfMjJtk8hZJAsQq4OpCxiCak0KZ87H7YLqQJ1K56Z09Eyw90SSayBp/P5qzDuaUia7hQvaOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502890; c=relaxed/simple;
	bh=LTei2T2o6TWw+MQVO3yyOPDOb0tva7njlRGTMNnuegc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHequLjKxPmU8191dbwj5pF2Wbxz459MCMgvIr8UgMZCbGI3twEJFpkYz0rxROfYiT+8Ps2rpFbXO3YQSOLFXir33IUdhrYV+czls/m+PDbNOiuDtNd53JpJWSZIXnGm7EiWbEyLD7mL009oBAlnQcxw7tZKN/VyjpoYEV2zxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2pU6UiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2pU6UiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44D9C4AF09;
	Mon, 11 May 2026 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778502890;
	bh=LTei2T2o6TWw+MQVO3yyOPDOb0tva7njlRGTMNnuegc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y2pU6UiNJ0LptAfrgwQAzkrlyvX/fa0r9x1MlAUOZSaZhGaS86MCxp2tmRrTM/5VU
	 jhL24AicTQ+OWc4Jksssx5EWC0rYFQXZkeWUfoOPcFIlCOwd8BvwPZnlEOmXWTk8tc
	 IlE2HdRzg2GcBZ0iTNXhD97Q+0dh4gg2K72aBrsywzfizz0geP75g+PwTSPqnRECrX
	 Yg/bnkE+l6P7jLzaWyqQ/MaK3vUh8SYYTeu2Pk19oUXUovgqJjYpF1AKM4UAO4Hfsj
	 JhRJbJf8/tMy3bn6BD8RZtduKvPYPQbe5myVtGvhgIXOXx58Y8tFn8armCaLuAKCD9
	 mddkWDJPnp2Bg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 5/8] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
In-Reply-To: <20260508073355.3916746-6-kuniyu@google.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-6-kuniyu@google.com>
Date: Mon, 11 May 2026 14:34:46 +0200
Message-ID: <87ik8ujfa1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima <kuniyu@google.com> writes:

> We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVLOWAT_CB
> to adjust sk->sk_rcvlowat when
>
>   1. TCP stack enqueues skb to sk->sk_receive_queue
>   2. TCP recvmsg() completes
>
> Let's provide a kfunc to set sk->sk_rcvlowat.
>
> Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
>
> The wakeup flag is determined based on bpf_sock_ops_kern.skb:
>
>   * For the enqueue hook, skb is always non-NULL, and wakeup is
>     set to false because
>
>     * tcp_data_ready() is always called after the hooks in
>        tcp_queue_rcv() and tcp_ofo_queue().
>
>     * when tcp_fastopen_add_skb() is called for TFO SYN,
>        the socket is not yet accept()ed, and when called
>        for TFO SYN+ACK, the socket is woken up by
>        sk->sk_state_change() anyway.
>
>   * For the recvmsg() hook, skb is always NULL, and wakeup is set
>     to true because tcp_data_ready() is not called in the path.
>
> An alternative would be to support bpf_setsockopt() by adding
> BPF_SOCK_OPS_RCVLOWAT_CB to is_locked_tcp_sock_ops().
>
> However, that approach involves excessive conditionals and an
> unnecessary memcpy(), costs we do not want to pay for every skb
> in the TCP fast path.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/filter.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 94d07a15b2ab..9c4cd27c6d4e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12346,6 +12346,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct _=
_sk_buff *s, struct sock *sk,
>  #endif
>  }
>=20=20
> +__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *=
skops,
> +					      int rcvlowat)
> +{
> +#ifdef CONFIG_INET
> +	if (skops->op !=3D BPF_SOCK_OPS_RCVLOWAT_CB)
> +		return -EOPNOTSUPP;
> +
> +	if (rcvlowat < 0)
> +		rcvlowat =3D INT_MAX;
> +
> +	return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +

(Nice work BTW! I played a bit with this, but took a sockmap/stream
parser approach instead -- this is much nicer!)

Curious if we can get into a situation that commit fcf4692fa39e ("mptcp:
prevent BPF accessing lowat from a subflow socket.") fixed?

IOW, we can construct a program that enables autolowat on MPTCP
subflows, right? If so, do we need a similar check (or checking for
subflows) in the kfunc?


Bj=C3=B6rn
