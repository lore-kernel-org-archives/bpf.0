Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426724;
	b=WdQNDTBoHmWpUT31eiLsXrB/dz9iPl7sDp/mRbRoztTfOjekNpLB2QMxa8uhrBviVxPC
	 naL05+1Loy8c/N9QPcxeI3hTdDwMjfvjs/Ad+kBaA/xz88LLiI/3PwN7L2ZP9leb9Lkz8
	 X8wCFcxrnO11O8RqM217YkdCOU28bWfZEg3CjiWz7EV6cnPquDvzmXWo3YkVnJVbWNtRh
	 xFJI3+3n2DCBgmldI90XRJdV5PxsJ5cMwopaeoxB2jhL89XdZyKTW5vBky1S1gvMzdloM
	 AkzvYYVGEStDvEqL+K61ipZJUYU06N/JzJTz5J8L0RgxIycIHaQ5f0hBDEThW+yoV+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426724;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eQjysNNGlsoUj/cZnZbV4xgqvZHEKysJuGURf1mwqlE=;
	b=erriKJFYPM6DzOgxHlyfCD5PLSqtvll/qwqv3TyQzHHVjWa6V9DJGqdkA1AfwtaZOBsE
	 uZcjL5VZ654wTBD0OmTvMrLGNZNfRycaYK9KdjXdqGIwauTOsLL93C4RGWDqCbd3q08FF
	 w0rQ4E+9/2sVe0Vw4gAdciFcPNyQQkk1NvBvAT50wIB54mqrgPAnE6/1l9mvCXRB85RLt
	 PD4qEDVZjEN5RlUxW91hFG0ZKnPI2RHY+djnITcxvrSRLiFbREO37RRofg/eSP142LP2V
	 GeLMQPlyLVu3BO73TJ5gF6JjLGQfgvFU5NaS8XMVn5adJf2LjJnXc2mvZ6yxI05kzdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nug+G2Y1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C5606A31A;
	Mon, 23 Nov 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nug+G2Y1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567621F000D4;
	Mon, 23 Nov 2026 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795426723;
	bh=eQjysNNGlsoUj/cZnZbV4xgqvZHEKysJuGURf1mwqlE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nug+G2Y1TaD8ogWh5idPqiNwM1/pEjGecOCbWnb4nSG0tAdjrmhLFjmb8jnrfR3xV
	 QSnFKerGH0HgU0PXwQbzbpt3L7dCrk09iLFBarhfqNmeskJwKISaqPE1AZsND7Ufqm
	 zGkaqKQ/ZL5RaU6VYwgFz2A1KdU1pB145x1SIyYPKtHqgX0I2edrSMEHkApNQ9UIsc
	 Emqz7MALPAI0get7b0ztrrZsxB/+SbfhrzyWND5v8IwSDdsAiYaZwQtY1fXsDbrJq8
	 DVhGvml3adCEhXaZu80eX9apgkkpC8HXpAW28pJ28KA6Rk9ISq49FaqtdJvxnfTubo
	 6Cuso/uqon14g==
Content-Type: multipart/mixed; boundary="===============5546299398506454022=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <17a6c638570f5dbce09ea097938e5bcb33d226fd40323af3e27b3f083ad851d9@mail.kernel.org>
In-Reply-To: <20261123084138.723275-2-razor@blackwall.org>
References: <20261123084138.723275-2-razor@blackwall.org>
Subject: Re: [PATCH bpf 1/2] bpf, net: validate assigned socket on receive
From: bot+bpf-ci@kernel.org
To: razor@blackwall.org,bpf@vger.kernel.org
Cc: razor@blackwall.org,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemdebruijn.kernel@gmail.com,kafai@fb.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 09:38:41 +0000 (UTC)

--===============5546299398506454022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, net: validate assigned socket on receive

TL;DR:
- Raw sockets with matching sk_protocol may pass the new check, possibly
  causing type confusion and out-of-bounds writes in UDP/TCP receive
- Changelog says normal path is unaffected, but early-demuxed UDP packets run
  the new checks

> The normal packet path is not affected: the checks run only after the
> prefetched test and the protocol is a constant at every call site.

The commit message says the normal packet path is not affected because the
checks run only after the prefetched test.  Is that accurate for UDP?

skb_sk_is_prefetched() is skb->destructor == sock_pfree, and sock_pfree is
also installed by udp_v4_early_demux() and udp_v6_early_demux(), which run
on ordinary traffic when net.ipv4.udp_early_demux is enabled (the
default).

So early-demuxed UDP packets do reach inet_prefetched_sk_mismatch() or
inet6_prefetched_sk_mismatch() in udp_rcv() and udpv6_rcv().  The early
demux lookups already enforce netns and family, so no valid socket looks
to be rejected, but could the changelog say that these packets run the new
checks and why that is acceptable?

> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h

[ ... ]

> @@ -444,11 +444,24 @@ static inline struct sock *inet_lookup(struct net *net,
>  	return sk;
>  }
>  
> +static inline bool inet_prefetched_sk_mismatch(const struct sock *sk,
> +					       const struct net *net,
> +					       u8 protocol)
> +{
> +	if (unlikely(!net_eq(sock_net(sk), net)))
> +		return true;
> +	if (!sk_fullsock(sk))
> +		return unlikely(protocol != IPPROTO_TCP);
> +	return unlikely(sk->sk_protocol != protocol ||
> +			(sk->sk_family == AF_INET6 && ipv6_only_sock(sk)));
> +}

Does matching sk_protocol prove that this is really a TCP or UDP socket?

For SOCK_RAW, inet_create() stores the user-chosen protocol in
sk->sk_protocol, so socket(AF_INET, SOCK_RAW, IPPROTO_UDP) has
sk_protocol == IPPROTO_UDP and sk_family == AF_INET.  raw_hash_sk() hashes
it and sets SOCK_RCU_FREE, so bpf_sk_assign() accepts it without a
reference.

A tc program can obtain such a socket without a lookup helper.  On
veth_xmit() -> __dev_forward_skb() -> skb_scrub_packet() the skb is not
orphaned, so at the peer's tc ingress skb->sk is still the sender's raw
socket, and __sk_buff->sk can be passed to bpf_sk_assign().

Then in udp_rcv():

inet_steal_sock()
  inet_prefetched_sk_mismatch()   /* netns ok, full sock, sk_protocol ==
                                     IPPROTO_UDP, not AF_INET6 */

passes, sk_state is TCP_CLOSE and sk_reuseport is clear, so the raw_sock is
returned.  udp_unicast_rcv_skb() and udp_queue_rcv_one_skb() then use it as
a struct udp_sock, which is larger than raw_sock.  That looks like the same
type confusion as the KASAN report in the commit message.

The same applies to SOCK_RAW with IPPROTO_TCP on the TCP receive path:
inet_steal_sock() returns it because sk_state != TCP_LISTEN, and
tcp_v4_rcv() then calls tcp_segs_in(tcp_sk(sk), skb), which writes beyond
the raw_sock.  AF_INET6 raw sockets pass inet6_prefetched_sk_mismatch() in
the same way.

The old code had no check at all, but the stated goal is to drop a
prefetched socket that does not match the receiving protocol.  Should the
full socket branch also require sk_type == SOCK_STREAM for TCP and
SOCK_DGRAM for UDP, and an inet family on IPv4?  sk_is_tcp() and
sk_is_udp() already check family, type and protocol together, and
bpf_sk_assign_tcp_reqsk() checks sk->sk_type != SOCK_STREAM.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45143832636
--===============5546299398506454022==--
