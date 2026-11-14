Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658393;
	b=x4P6U7Pc6coMCyIm4hhHihe0sjI/7swVzy1INeSAOHwKxAEX1zbq82VsRXAmxx3plrlh
	 9AEk6J2HfyKEQQ5Guylg+r9XYHVpOW19a29PO53X0PN1VxvNI0T58dK/yYMxmOLAEiubq
	 h8SDUmddsAU/+iaDKL3TiltbrqpVsroKpyWKZVx1PGjZ8kXZ3oKWLlf9nQ0lGhkt/XZnG
	 Hif77//Xglb+50UFqOuSc5kIGERcd+4+odMEquehTKkigZKKTSPKDHG8/P4woRymth2HK
	 sZqtN0vNkU2beCrUu94fUqI88GzTiGsxHqBhnLpeymnIyASmvhQp7Le2igpicTqd2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2QHcxx0rcOH/YBaZLNjtYPhhngiIYFJ+ZLEPxkTTOsw=;
	b=HwR42y5tCs0Cqbvpr+YoIsuNbiW8KEJapsWE9ZykIm15iSFs9n7zMgPLer3ufYeVL/jd
	 jBAZLSecck+N5SOeECswBsE4UNHye8FPj9Qxy/eRX+VFrHtcIVHxCnbpdbNrcr1Y3R6ON
	 SGSAKwbRYlte+Hg+ggV+BX4TuPjFWHTB76XE6X5qkcwX+VpR34jWmPXwEK7seayKjtqst
	 0iZY4QNyS0XTTf4aX0kDwoHQ7TwD+N0aXfSs9JEKII9kkEBxnlJTGMIOZ//FQalyvMZol
	 gDPH+p3BFDfcxoalFMTP1UNnawXw9qxQMfGxnTrAeBx4DzjU381aBEr/uREelcH+ckA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vid7BLst;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E1606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vid7BLst
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18911F000C4;
	Sat, 14 Nov 2026 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794658393;
	bh=2QHcxx0rcOH/YBaZLNjtYPhhngiIYFJ+ZLEPxkTTOsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vid7BLstrXY0lqnxH8gVm/N1XEy8Fvwj1OiyKhmwb1c+teXTPeeEKG0C3aS0hpupk
	 SYVqe8SElM99QZfd5wbi9bTWIayBMamGPhBoc/3Mem4/WjvcT1VOhZQyx6kotdV1Ft
	 hMzC0JuHXU8ErLAHviVZdkmJDlsUOqJyHsXKaRNveQsrBBB5rqbXurYiDNoQH00rm3
	 g22fS4pxrH4CK+Mu4yihnNpnKHMRQ8Pq8tzDKAxg9oGiBwud4ZaoGjf8GD7ejLjNFw
	 Q4EsLwxFW/9zUA4RMuxwgDymayqxkcmg3J7zJyDK/zcHX80WtwBndjLAKSa5ymwWyw
	 Q+d/LwXje0cFQ==
Message-ID: <sashiko-outbox-214497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, sockmap: fix cork data loss after redirect
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5ZtZXIgTWV0ZSBLYXlh?= <omermetekaya0@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261114115222.180345-1-omermetekaya0@gmail.com>
References: <20261114115222.180345-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:13:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf, sockmap: leak of detached cork sk_msg in
  tcp_bpf_send_verdict()
- [Medium] bpf, sockmap: stale msg->cork_bytes re-corks data in
  tcp_bpf_send_verdict()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] bpf: memory leak in tcp_bpf_sendmsg() due to cork allocation
  failure [1]
--

commit 5eaba7adf21d338926f608cc6e21ea8e9156e647
Author: =C3=96mer Mete Kaya <omermetekaya0@gmail.com>

bpf, sockmap: fix cork data loss after redirect

This commit keeps a corked sk_msg alive across partial __SK_REDIRECT
sends in tcp_bpf_send_verdict() so that remaining bytes can be processed
by the more_data loop.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed1..e6a8184aad6a4 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -499,9 +499,13 @@ static int tcp_bpf_send_verdict(struct sock *sk, str=
uct sk_psock *psock,
>  				*copied -=3D free;
>  		}
>  		if (cork) {
> -			sk_msg_free(sk, msg);
> -			kfree(msg);
> -			msg =3D NULL;
> +			if (ret < 0 ||
> +			    !msg->sg.data[msg->sg.start].page_link ||
> +			    !msg->sg.data[msg->sg.start].length) {
> +				sk_msg_free(sk, msg);
> +				kfree(msg);
> +				msg =3D NULL;
> +			}
>  			ret =3D 0;
>  		}
>  		break;

[Severity: High]
Does keeping msg alive across goto more_data leak the heap-allocated
struct sk_msg when a subsequent iteration does not take __SK_REDIRECT?

When a corked message enters __SK_REDIRECT, tcp_bpf_send_verdict() sets
cork =3D true and psock->cork =3D NULL before releasing the socket lock,
leaving msg as the only pointer to that allocation.  If a partial
redirect leaves unsent bytes and jumps to more_data, kfree(msg) is only
called in the __SK_REDIRECT branch.  If the next iteration instead hits
the re-cork path (which sees !psock->cork, allocates a new psock->cork
and copies msg into it), __SK_PASS, or __SK_DROP, tcp_bpf_send_verdict()
returns without freeing msg:

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
	if (msg->cork_bytes &&
	    msg->cork_bytes > msg->sg.size && !enospc) {
		psock->cork_bytes =3D msg->cork_bytes - msg->sg.size;
		if (!psock->cork) {
			psock->cork =3D kzalloc_obj(*psock->cork,
						  GFP_ATOMIC | __GFP_NOWARN);
			...
		}
		memcpy(psock->cork, msg, sizeof(*msg));
		return 0;
	}
}

[Severity: Medium]
Can a stale msg->cork_bytes value also spuriously re-cork the remaining
bytes on the next more_data iteration?

When tcp_bpf_sendmsg() finishes accumulating psock->cork_bytes, it resets
psock->cork_bytes =3D 0 and psock->eval =3D __SK_NONE, but leaves
msg_tx->cork_bytes set to the old threshold on psock->cork:

net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
		if (psock->cork_bytes) {
			if (size > psock->cork_bytes)
				psock->cork_bytes =3D 0;
			else
				psock->cork_bytes -=3D size;
			if (psock->cork_bytes && !enospc)
				goto out_err;
			/* All cork bytes are accounted, rerun the prog. */
			psock->eval =3D __SK_NONE;
			psock->cork_bytes =3D 0;
		}
}

Once a partial send reduces msg->sg.size below that original
msg->cork_bytes value and loops back to more_data, the check
msg->cork_bytes > msg->sg.size in tcp_bpf_send_verdict() triggers again
and re-corks the residual data even if the BPF verdict program did not
request corking for the remaining bytes.

[Severity: High]
This problem wasn't introduced by this patch, but setting
psock->cork_bytes before checking whether kzalloc_obj() succeeds in
tcp_bpf_send_verdict() [1] leaves psock->cork_bytes non-zero while
psock->cork is NULL on allocation failure.  On a subsequent
tcp_bpf_sendmsg() call, msg_tx falls back to the stack-allocated tmp
message, allocates scatterlist pages via sk_msg_alloc(), and then takes
the psock->cork_bytes check to out_err without calling sk_msg_free() on
tmp, leaking the allocated pages.

[1] https://sashiko.dev/#/bug/linux-2ff2eab9-5d5b-4e91-82d9-b38be18677c9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114115222.1803=
45-1-omermetekaya0@gmail.com?part=3D1
