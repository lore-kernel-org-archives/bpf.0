Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBA3D9547
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087284; cv=none; b=rrNdHjCERd5oJray3cuwacf+W4CSD3+5iIV/js37/gqxpbuj/6MZl47IyJqGDyDOKDh7oiGmnVvHNvII77Ez3k/NnZ5sIfHDSB9G9BVBg0JgGuAWhDvkSkpVHwdIdhPG5HQqF2k/wy+Q6NGUPITtPrrPy5+DuP66wEYC9s0kYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087284; c=relaxed/simple;
	bh=X8DBTFpGevEUl6wtR1nGWWMT0PbdzWWQ3zZgu7XyDUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LQFJCZMrsi45ZCTq06B16ma5nWrv/iRYOUzDY5QdyWuCW54zSGA5nuADkBnxLcQcx0SMs7U3uWWtXOcSYzd1UxShSRRvmrDt5GpisA/wZYo5l5BMApp3xPB4rwExmGO6kfYBlsQgkmVUtAyIUbgYXm84jzZYFp3LCOrtMstjnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvEWiIt8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvEWiIt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07201F000E9;
	Fri,  3 Jul 2026 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087282;
	bh=Thsh4HrtY8yglP2+vpJ8G5VmMXt+AWtl7M9MAonm7t8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvEWiIt8w0FAAjTtkV56C2l1fqud/2xHEntujmHvZwgbYwnvmGQuU0qY7njJGhimR
	 F8yscon+OJ4w6qFfWp5gjaNWTV85Y59pBwNhYq1Ip9zFQzBDDoHgUcAFv3Z+tNmMfv
	 PKR5LwT4oL3z2SNXBhgrL65Fgf3867LR2FBr0FQXDQEg7ueGyT3wsT9jtQsMUVk35M
	 cDUHQElPbsTa4GcJj8tk7M48/o9YRMCEYGHJ6UxsamjmEqHzFJMGmEjMlVXxCu50K8
	 smD1s2Vbcdwr92Z8ebXpeSO0ovbtWs/Qgl7l7QCdSHFrLBsNRVx3sxxAMz11GLubf7
	 qLt2xgaF6NjEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] bpf, sockmap: account only unread data in
 tcp_eat_skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dong Chenchen" <dongchenchen2@huawei.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702140959.1806754-2-dongchenchen2@huawei.com>
References: <20260702140959.1806754-1-dongchenchen2@huawei.com>
 <20260702140959.1806754-2-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:01:22 +0000
Message-Id: <20260703140122.A07201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] tcp_eat_skb() forcefully advancing copied_seq to end_seq corrupts =
sequence tracking when an SK_DROP/SK_REDIRECT follows an SK_PASS.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the fix is incom=
plete: it addresses copied_seq corruption for SK_DROP and SK_REDIRECT, but =
leaves the exact same vulnerability unpatched for SK_PASS, leading to dupli=
cate data delivery and sequence corruption.
--

commit 53da102476a74ffdf7989fd6066b68acdf141844
Author: Dong Chenchen <dongchenchen2@huawei.com>

bpf, sockmap: account only unread data in tcp_eat_skb

tcp_eat_skb() advances copied_seq by the full skb length when a sockmap
verdict drops or redirects an skb, assuming none of the skb has been consum=
ed.
This assumption does not hold when userspace partially reads an skb before
adding the socket to a sockmap. This patch fixes tcp_eat_skb() to advance
copied_seq to the skb TCP end sequence.

Closes: https://syzkaller.appspot.com/bug?extid=3D06dbd397158ec0ea4983

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..d640f8e065297 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -24,10 +24,11 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>  		return;
> =20
>  	tcp =3D tcp_sk(sk);
> -	copied =3D tcp->copied_seq + skb->len;
> -	WRITE_ONCE(tcp->copied_seq, copied);
> +	end_seq =3D TCP_SKB_CB(skb)->end_seq;
> +	delta =3D end_seq - tcp->copied_seq;
> +	WRITE_ONCE(tcp->copied_seq, end_seq);

[Severity: High]
Does forcefully advancing copied_seq to end_seq corrupt sequence tracking w=
hen
an SK_DROP or SK_REDIRECT follows an SK_PASS?

If a packet is evaluated as SK_PASS and enqueued to ingress_msg, and a
subsequent packet is evaluated as SK_DROP or SK_REDIRECT, this unconditional
overwrite sets copied_seq to the dropped skb's end_seq. This jumps over the
unread SK_PASS sequence space.

When userspace later reads the SK_PASS data, it will increment copied_seq
beyond rcv_nxt, leading to sequence warnings and breaking native TCP reads.


[Severity: High]
This is a pre-existing issue, but does this fix leave the exact same
vulnerability unpatched for SK_PASS?

While this patch addresses copied_seq corruption for SK_DROP and SK_REDIREC=
T,
the vulnerability seems to remain for SK_PASS, leading to duplicate data
delivery and sequence corruption.

If userspace performs a partial native read on a socket (advancing
copied_seq), and the socket is then added to a sockmap:

A packet arrival triggers tcp_read_skb(), which dequeues the partially-read
skb without trimming the already-read prefix or accounting for the differen=
ce
between copied_seq and the skb's start sequence:

net/ipv4/tcp.c:tcp_read_skb() {
    ...
    while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
        __skb_unlink(skb, &sk->sk_receive_queue);
    ...
}

If the BPF program returns SK_PASS, the full skb->len and off=3D0 are
unconditionally used to enqueue the packet, blindly pushing already-read da=
ta
into the ingress queue:

net/core/skmsg.c:sk_psock_verdict_apply() {
    ...
        if (skb_queue_empty(&psock->ingress_skb)) {
            len =3D skb->len;
            off =3D 0;
    ...
}

When userspace reads from the sockmap, it will receive the already-read pre=
fix
again, and copied_seq will be incremented by the full length, overshooting
rcv_nxt.

>  	tcp_rcv_space_adjust(sk);
> -	__tcp_cleanup_rbuf(sk, skb->len);
> +	__tcp_cleanup_rbuf(sk, delta);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702140959.1806=
754-1-dongchenchen2@huawei.com?part=3D1
