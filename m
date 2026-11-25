Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647762;
	b=2fTEhb4HuDidD1gd2CawcoNhhaZKgr6Cil9Qan//xdM+GUginzmwjkLUjLMy1/bI2iyy
	 hQf7XKR30arO0OlnigsCsAVFKwI2jTSemZeEz3P1SIlNSkCoidtVEkGi/ZLfXWT8SG6h4
	 Wi+sWPwUZlyRSG/+0g74IUhfm2PN9QBoi5ebskZHEROdPuQaXp1EkbeKujPXrzFm8FW2q
	 nP+lPwyqY4MG2exFyFPAksM32KkiR+0t8jZhti1zv+aU6idnlizBUJV8VLRl5nqxLCKlv
	 BMczWpuibENgvk9wigvxHuoIf1CcsV0vetJmsND96L5BcUeeKvf8HKgcEISHnIj+4aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647762;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LPWBhrVd8zGmDChDb6/+1TotWhdUMM0PJEhgo8YgaX4=;
	b=uhf7oS6tUyxd8UPY0Z851slfCycQDLHc6RK8HW5TAoCh20GJuJorhMilziBXdV8gPpip
	 Mo0bSElAhpuvMZPFofTdOyITdGZbIKN7cI+GemBc1olKSb/ZWtyAxI7Tiq2N5jxceDieD
	 lMVPNwt+tn0sSlzKJQkS22OOf+Nzx9kcUq8chtkY+gr56TUUSkfegwO7Knx72b4F6FIj9
	 jZZEn/404C67BKMX9H91YfoVyJRFEThB0wVTX4cgJH+13yKKQCa/tf2vv18O2OPYIbEXs
	 ujy8JprsSplgWn2xhToSU+FsnCibfKndU9s4C1Z3ou0S9B/0bKPcuxYAV2fUeSOIKNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h67Z/Nyi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C50606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h67Z/Nyi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEF01F000C4;
	Wed, 25 Nov 2026 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795647761;
	bh=LPWBhrVd8zGmDChDb6/+1TotWhdUMM0PJEhgo8YgaX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h67Z/NyieeSn9vHn8FrEeg/4Vkw6JhRQMsau722Ku84vhKjVdqpx8ME2OXG9v8Jjy
	 x47+h41FfnlFi8qt9+bam3/O62vUzjvEi06jJuqJRk9NN/9z8UTh1k2XLuxYDLitEs
	 JGl9D8v+SPo7sviiO9TcdI0LMfA8VB7I99WOzmHDhnnodVGRHM7PbhVLpdxvlVTr+r
	 +jkuixLxGaGMbqvOefttzVRPf3B1VepzOpAeJ2kNSohlzvBW1QQ4c5zaxYvCFgWp7K
	 5qIXkW5aJxYuegdeGBTF7sXf3CerlQeOgA4bDXHoesfpeXaVaPM4P7znKp1JfA0W4F
	 VSyJdNUOJplSw==
Message-ID: <sashiko-outbox-234348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] tcp: avoid NULL skb dereference in zerocopy receive
 with sockmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junyoung Jang" <graypanda.inzag@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261124230228.3868519-1-graypanda.inzag@gmail.com>
References: <20261124230228.3868519-1-graypanda.inzag@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 23:02:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] tcp: out-of-bounds read and skb drop in tcp_zerocopy_receive()
  on seq gap
--

commit 51c17d06cb86cc681cbd2093e298086ab3b52896
Author: Junyoung Jang <graypanda.inzag@gmail.com>

tcp: avoid NULL skb dereference in zerocopy receive with sockmap

This commit adds NULL checks after tcp_recv_skb() and stops at the last
skb in sk_receive_queue in tcp_zc_handle_leftover() and
tcp_zerocopy_receive() to prevent NULL pointer dereferences when sockmap
removes skbs without advancing tp->copied_seq.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 418842a2dfd98..fa3b4bcbc726a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2072,6 +2072,8 @@ static int tcp_zc_handle_leftover(struct tcp_zeroco=
py_receive *zc,
>  		offset =3D *seq - TCP_SKB_CB(skb)->seq;
>  	} else {
>  		skb =3D tcp_recv_skb(sk, *seq, &offset);
> +		if (!skb)
> +			return 0;
>  		if (TCP_SKB_CB(skb)->has_rxtstamp) {
>  			tcp_update_recv_tstamps(skb, tss);
>  			zc->msg_flags |=3D TCP_CMSG_TS;
> @@ -2274,10 +2276,14 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  			if (skb) {
>  				if (zc->recv_skip_hint > 0)
>  					break;
> +				if (skb_queue_is_last(&sk->sk_receive_queue, skb))
> +					break;
>  				skb =3D skb->next;
>  				offset =3D seq - TCP_SKB_CB(skb)->seq;
>  			} else {
>  				skb =3D tcp_recv_skb(sk, seq, &offset);
> +				if (!skb)
> +					break;
>  			}
> =20
>  			if (!skb_frags_readable(skb))

[Severity: High]
What happens in tcp_recv_skb() when sk_receive_queue is not empty after
tcp_read_skb() has left tp->copied_seq behind?

If a later segment or FIN arrives (for instance, after the socket is
removed from the sockmap), TCP_SKB_CB(skb)->seq is ahead of seq:

net/ipv4/tcp.c:tcp_recv_skb() {
	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
		offset =3D seq - TCP_SKB_CB(skb)->seq;
		...
		if (offset < skb->len || (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)) {
			*off =3D offset;
			return skb;
		}
		tcp_eat_recv_skb(sk, skb);
	}
}

Because tcp_recv_skb() does not check before(seq, TCP_SKB_CB(skb)->seq)
like tcp_recvmsg_locked() does, offset underflows u32.  For non-FIN
skbs, offset < skb->len is false and tcp_eat_recv_skb() silently drops
and frees all unread data in sk_receive_queue.

If the skb carries TCPHDR_FIN, tcp_recv_skb() returns the non-NULL skb
with the underflowed u32 offset, bypassing the new !skb checks.  In both
the small-request and page-sized paths, tcp_zc_handle_leftover() passes
this offset through tcp_copy_straggler_data() -> skb_copy_datagram_msg()
-> __skb_datagram_iter(), where converting offset to a negative signed
int causes simple_copy_to_iter() to read out-of-bounds kernel memory
before skb->data and copy it to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124230228.3868=
519-1-graypanda.inzag@gmail.com?part=3D1
