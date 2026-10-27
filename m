Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079022;
	b=2aDaKbt248CK4tndNwNXbC+rLEhpxCXMo1NCIiJtD8U/KbA2yGIfudHUrNCFdO88rS5P
	 eoCcde/xl9DqPKipuBST6ZD7KwMvFQW9ZzI4A5sbtz5VveudQ5dDKiodfk44VxNVSYz/J
	 6sEllN/xUIIzOZ/3epQbs1aAFLIk4rvBExV6tRCqezCfdtgE1bNA5UvDimJCfNcwW/g+R
	 KvBiEM4wclpw4Kmu8QLRbW/vbLl33ayYUX24ZmzF5eOamksk/gqN5Q49rJxgoCdc8KLxZ
	 ggGYUh1albIPmByAtZWXV5GEqzH15S8ZlJQ27efXa0dzljkNBwZpk568ZEIKKeDNmXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079022;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wgDX8AZbuhQDLrambpgz70Jd1qU/J3fq5NqVCzjiHh4=;
	b=wykVFEQNfikmd2Ozy1R9sQUiKmSljqu1C03m8cHWP8OOwMbxILiKkWP2X8XHaMQP+OHr
	 777CvAv7odWDYom0qmotOpNa7ZIEFTOhNICI/yeEcOv+GnsW7H3RnpATa2VB+1w+Mtn3/
	 Ob2OkNLqGLyESu6uuOcNPQxvOrqfUgp4ZD9aADakQphkydz2km+ggKLTw+g92Pi+reOsQ
	 KnCUJtPo5MGzvA2L8yPTQL2VGloz+JqhvIN3nXkobyUsHeM/WgqD78aO5V4+52lpPcXz6
	 xfpuePcy0eDsOLgNbJhCJiB2ccMS6fGQFfnVww865HMmHP34E+S7ctVfpszNrEiqZRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQczWL6q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0825606A31D;
	Tue, 27 Oct 2026 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQczWL6q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186FB1F01825;
	Tue, 27 Oct 2026 05:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079021;
	bh=wgDX8AZbuhQDLrambpgz70Jd1qU/J3fq5NqVCzjiHh4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aQczWL6qjZ197z2M/CPl+k8ZV2edDG4gk/ybWC01FHIEBuZ0mMaM1tVR8WNt6swJF
	 XBJaBhysX7q2U4W7uzHTVY7VyKk7gwLlj0iBhHrMdITwuApKCsgs2PQ2RMhOheK0u+
	 i5vfKqHyEvmyKcROFVkx8lvXxEqwEpFEkHcQRmcPwT1AOmQDjq9O2Fpg2aexI85z7W
	 5+0AA9p96L7geFHWSF66tFek6X3PENg8vhy9bHUo9Ouk1cHB2Q91FrULa6clN02Tpe
	 sbyvLuVc8wI0rYSOAorlFdIk1rVjuf/1Vz1eWsXtV1RFvpTrui3LNvAxaGntssDbLh
	 ImHiWGjzbe2kg==
Content-Type: multipart/mixed; boundary="===============1515168815184980910=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5d549ed21ea51f32d19eaf6e553c1ab8b6d99ea0134d75f835b902873d16d7d2@mail.kernel.org>
In-Reply-To: <da2b3b99a2f41142acd0eab4b7ecd2210c3f4a51.1793076960.git.zhilinz@nebusec.ai>
References: <da2b3b99a2f41142acd0eab4b7ecd2210c3f4a51.1793076960.git.zhilinz@nebusec.ai>
Subject: Re: [PATCH bpf v2 1/1] tcp_bpf: update copied_seq from current value
From: bot+bpf-ci@kernel.org
To: zhilinz@nebusec.ai,alexei.starovoitov@gmail.com,netdev@vger.kernel.org,bpf@vger.kernel.org
Cc: edumazet@kernel.org,ncardwell@google.com,kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,pabeni@redhat.com,horms@kernel.org,daniel@iogearbox.net,vega@nebusec.ai,zhilinz@nebusec.ai,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 05:30:21 +0000 (UTC)

--===============1515168815184980910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tcp_bpf: update copied_seq from current value

TL;DR:
- In strparser mode, the new copied_seq write-back may over-advance past
  rcv_nxt after multiple rounds, stalling the receiver
- Commit message wrongly says tcp_data_ready() releases the socket lock

> tcp_bpf: update copied_seq from current value
>
> tcp_bpf_recvmsg_parser() snapshots tcp->copied_seq before processing
> queued data and waiting for more. tcp_data_ready() and
> tcp_msg_wait_data() can release the socket lock. While it is released,
> a sockmap verdict can drop or redirect data and advance copied_seq. At
> exit, writing back the old snapshot plus copied_from_self rewinds that
> progress, leaving ordinary TCP receive behind queued data.
> Keep copied_from_self as the count of bytes consumed from this socket,
> but add it to the current tcp->copied_seq at exit instead of writing
> back a stale snapshot. Count the FIN byte in copied_from_self as well.
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

The changelog says tcp_data_ready() can release the socket lock.  Is that
accurate?

tcp_data_ready() calls sk->sk_data_ready synchronously while recvmsg still
owns the socket.  In verdict mode the verdict runs inline:

tcp_data_ready()
  sk_psock_verdict_data_ready()
    tcp_read_skb()
      sk_psock_verdict_recv()
        sk_psock_verdict_apply()
          tcp_eat_skb()

and tcp_eat_skb() advances copied_seq after the old snapshot was taken.

In strparser mode, strp_data_ready() sees sock_owned_by_user_nocheck() and
only queues work.

The conclusion that the snapshot is stale still holds, but for
tcp_data_ready() the stated reason does not match the code.  Since this is
tagged for stable, could the message say that the verdict runs inline from
tcp_data_ready(), and that only tcp_msg_wait_data() (via
sk_wait_event() -> release_sock()) drops the lock?

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed..a01d6d5449c7 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -319,7 +316,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	}
>  out:
>  	if (!peek)
> -		WRITE_ONCE(tcp->copied_seq, seq);
> +		WRITE_ONCE(tcp->copied_seq, tcp->copied_seq + copied_from_self);
>  	tcp_rcv_space_adjust(sk);
>  	if (copied > 0)
>  		__tcp_cleanup_rbuf(sk, copied);

Can this over-advance tcp->copied_seq in strparser mode (stream_parser +
stream_verdict)?

The new write-back assumes that whatever changed tcp->copied_seq while the
socket lock was dropped only added bytes that this recvmsg will not count
again.  That holds in verdict-only mode, where tcp_eat_skb() only adds
skb->len for dropped or redirected skbs.

It does not hold in strparser mode, which also reaches
tcp_bpf_recvmsg_parser() through TCP_BPF_RX.  There
tcp_bpf_strp_read_sock() writes an absolute value:

    psock->ingress_bytes = 0;
    copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
                                 &psock->copied_seq);
    ...
    tp->copied_seq = psock->copied_seq - psock->ingress_bytes;

psock->ingress_bytes only covers the bytes passed to self by the current
read_sock call.  After a second strparser round, tp->copied_seq already
includes the self bytes from the first round, which are still unread in
ingress_msg.

For example, start with tp->copied_seq == psock->copied_seq == P and nothing
queued:

1. The reader blocks in tcp_msg_wait_data() -> sk_wait_event(), which calls
   release_sock().

2. A 100-byte message arrives.  In softirq, tcp_data_queue() ->
   tcp_data_ready() -> sk_psock_strp_data_ready() -> strp_read_sock() ->
   tcp_bpf_strp_read_sock() runs and the verdict passes it to self
   (sk_psock_skb_ingress_self() adds 100 to ingress_bytes).
   psock->copied_seq becomes P+100 and tp->copied_seq becomes P.  The
   reader is woken.

3. A second 100-byte message is processed before the reader takes the lock
   again, e.g. in the same softirq batch.  ingress_bytes is reset to 0 and
   then set to 100, psock->copied_seq becomes P+200 and tp->copied_seq
   becomes P+100.

4. The reader takes the lock, goes to msg_bytes_ready and reads both
   messages (copied_from_self = 200).

The old code wrote back snapshot + 200 = P+200, which is correct.  The new
code writes P+100 + 200 = P+300, which is 100 bytes past rcv_nxt.

While copied_seq is ahead of rcv_nxt:

- tcp_epollin_ready() computes avail = rcv_nxt - copied_seq <= 0 and
  returns false.  tcp_data_ready() then does not call sk_data_ready, so
  the strparser does not run for new data until more than 100 extra bytes
  arrive.  In a request/response exchange, the receiver stalls.

- tcp_bpf_recvmsg_parser() itself sees a non-empty sk_receive_queue that
  tcp_data_ready() will not drain, and returns -EAGAIN.

- tcp_rcv_space_adjust() computes a negative inq.

- If the socket later leaves the sockmap, tcp_recvmsg() starts from an
  advanced copied_seq.

The overcount comes from tcp_bpf_strp_read_sock(), and it also happens with
the old code when the rounds finish before recvmsg takes the lock.  With the
old snapshot, however, rounds that ran while a blocked reader waited came
out right, and with this patch they now overshoot.

Should this patch handle the strparser case, for example by making
tcp_bpf_strp_read_sock() account for all self bytes still unread rather than
only the current call's ingress_bytes?  Otherwise, could the commit message
explain why the strparser path is still correct?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40453304549
--===============1515168815184980910==--
