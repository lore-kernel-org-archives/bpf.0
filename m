Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979947;
	b=oll88rwxFm0iJj+o6tjkQOMEk9FCZkFBstxu7QDO1NKbXoODliAVEsMYaQjA7BV+kuC7
	 jbGrGjGOJk76x8hFL7A3H81W59T7WFSXVDG/1KX9AdXZmhyvsxOP8gTJBjbJC5DYojcyf
	 vk9upm5SyMY/VgtjBUruh646QPJ10PmaBlIO5DgGi3nfnEJz4cyKLhJFZdIgoUSzOYrMU
	 s8PbkbLEn36pC7wsgHoUzM4YAcYXtnxFm1Gqi7+olbBb025W4LpMEnHCHXjk5R5acq0mx
	 R+z8oN2vpee6dBQZiHngul+WO9urOVItlXW39ERUkYgzTtwJhlaang3GgBgYf+SEBrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979947;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nIRWTvPlLkG36D1roRwTAzMyx7v2xnLdlNLfoFx9rlM=;
	b=HPih0HuHG/Iqjj25wpt7JpcoVC5jBqM1j3WtSGIXfhseJMDm3c4x8kjF2laMh/Yje/6B
	 NnzjRLdSbDJAaMTFmE/0UMQBzkWc703b04UgPDmmoQFfhzDBMJxv5dJSJUT5Lx9C7VQPZ
	 476MrPI5k7/Mke8wTHd96nWF+oEYSLbrSiV4/HCpWlORGXM4eWbGDxbOg76+sPJvwnbrm
	 OUqXigU9WLzypLME3R6jb9Qaj0RTIIycIfV6/Qo3AkNJkTV0Q8nf8jVGowHHZzDzZWWfQ
	 xxJKF/2urzYYr01g23VBwgRP8k5TMIBGDcZFYLnjcqsA5/k6fk4AGJmPHZvWKBRHnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HaSqEAfC;
	arc=none smtp.remote-ip=91.218.175.196
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F5606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 01:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HaSqEAfC
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fivt3j3l99lInPNUAk/uJJjJe/iIb8iOoXTIz7OncWQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792979943; v=1; x=1793584743;
 b=HaSqEAfCYEa0PTLMpF9gcbY1pAuru6jSnZqQBSd+gR7UJecMMJc6S80LgYA5H7aKkv3zpoNT
 3o8cMbMb7D15vxIbo5rKkycHzW2rgrFy/R3Dnte+YfkMatUSmdjlr2rt1PYs42cltfKOhXCVtlf
 v0m7dzFpNq8NUnYqBHb4zogE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7163a4a6614d0ede;
	Mon, 26 Oct 2026 01:59:03 +0000
X-Mizu-Trace-ID: 7163a4a6614d0ede
X-Migadu-Flow: FLOW_OUT
Message-ID: <23181ba7-e4ef-4475-92ee-366e0ca2dcf0@linux.dev>
Date: Mon, 26 Oct 2026 09:59:00 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Stop reporting EPIPE on zero-length
 skb redirect
To: bpf@vger.kernel.org
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
 <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/26/26 7:41 AM, Eli Skeggs via B4 Relay wrote:
> From: Eli Skeggs <kernel@eliskeggs.com>
>
> A FIN can arrive on a packet with no data. In that case, tcp_read_skb()
> produces an empty skb, and the attached BPF stream_verdict program may
> choose to redirect the skb to another socket. Further data redirected to
> that socket from any socket gets dropped, and the target socket starts
> reporting EPIPE. A userspace application may see that EPIPE and decide
> the socket is no longer usable. For a BPF-based proxy, this can break a
> bidirectional stream, truncating the response instead of leaving the
> socket half-open.
>
> Prior to the introduction of tcp_read_skb(), tcp_read_sock() never
> passed a zero-length skb to its actor, sk_psock_verdict_recv(). When a
> redirected skb landed in sk_psock_backlog(), it was always non-empty.
> tcp_read_skb() deviated from the historical behavior by passing any
> zero-length skbs to recv_actor(), exposing this latent bug by adding
> zero-length skbs to a queue that hadn't previously received them.  When
> sk_psock_backlog() encounters a zero-length skb, it interprets ret == 0
> as a hard error, reports EPIPE, and clears the transmit flag.
>
> Treat a return of 0 as success when there is no data to send, while
> continuing to fail on a 0 return with residual bytes. The loop exits
> without incident on an empty skb, and the skb gets cleaned up as usual.
> On an ingress redirect, the empty message is still queued as before, but
> the target socket no longer reports EPIPE.

The target can't receive anything after that though. The empty msg sits
at the head of psock->ingress_msg and nothing ever dequeues it:

__sk_msg_recvmsg()
   sge->length == 0 -> copy == 0 -> copied = -EFAULT; goto out;

The goto skips sk_psock_dequeue_msg() at the end of the loop. Then
tcp_bpf_recvmsg_parser() sees -EFAULT, is_next_msg_fin() finds the FIN
flag on the redirected skb and returns 0. Every later recv() hits the
same msg and returns 0 again, while data queued behind it is never read.
Only sk_psock_purge_ingress_msg() on psock teardown frees it.

So the user gets EOF on a socket whose peer never closed, and everything
redirected to it after the FIN is lost. Without a verdict prog on the
target it is worse, tcp_bpf_recvmsg() returns -EFAULT forever.

Since this patch is already about the zero-length skb, can you handle
the ingress side too? E.g. in sk_psock_skb_ingress(), don't queue an
empty msg when len is 0 and the skb was redirected (skb->sk != sk). The
self PASS case must keep its empty msg since is_next_msg_fin() depends
on it.


> Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> Signed-off-by: Eli Skeggs <kernel@eliskeggs.com>
> ---
>   net/core/skmsg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index df385a5a961e..f9b2e3486cfb 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -716,7 +716,7 @@ static void sk_psock_backlog(struct work_struct *work)
>   			if (!sock_flag(psock->sk, SOCK_DEAD))
>   				ret = sk_psock_handle_skb(psock, skb, off,
>   							  len, ingress);
> -			if (ret <= 0) {
> +			if (ret < 0 || (!ret && len)) {
>   				if (ret == -EAGAIN) {
>   					sk_psock_skb_state(psock, state, len, off);
>   					/* Restore redir info we cleared before */
>
