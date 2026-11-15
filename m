Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743660;
	b=SlnDamIdTg/+RoBBPTQUPlECCF04ges0XjNHr3ojVQzgsKczAqAXZCHiunpSq96cFmWg
	 jEbp4+nJJHBxWg05jKKaEofGNL6zTOWoqdi36joMtyxnORyE4yGzJ3fNdN8alEkwUKPYS
	 QHm6h4whLzp8y8qbiNr/qA4HodP0iuNCojy0OJqMeHDItTtBD2k3vEBgKSWzSRrnG2hTI
	 ch1yYFrJwNAV81ETC8yaID+xJOPhBx6XH2xtg3+r2Kb2x4OT7rX5ywYJvWYxS4E1jdLEG
	 u8J0GB2umDW+iRAkVlF6tW0iP0RIwVZRIc2yBI1S+sAQSOnshnUV70FPrfhwV9H4CbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743660;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q6PkhZN1LO5aZYteXn+u1sosgPv/a8y6Vpaj2cYwuTI=;
	b=DN6SCr/r0zt7TA45tKmtB7sehloJojrHd9aMZKq3MrLhUi3JtGQD9nioF4bua/JnREWO
	 yyTpgc7w0GiL/ZpRENFPe6PG9agiVlB4VvuNd0b8fmrUgd6gzBO4OVhyuS5tCLgXiyfqj
	 x9NFG6QX8RUAXhGFvA5SoqxHBm+lHMzLrzz8gYGaeE9JaXEN7l9KKB/iklFWXran8o2+U
	 R5l8CGBtQr811S0hSG5mQileZRwARLbLwV718UhrJ5az4mkZTjuoggwYEnITBJ70yyCPn
	 Cn6cqeJvuBY4lM7z4yYONaI8sQwSL0Am9M9QxJBg5x3f3YxOyW/h+BoSUdm0POLlwBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSCx49Z2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929D606A31F;
	Sun, 15 Nov 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSCx49Z2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1A91F000C4;
	Sun, 15 Nov 2026 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743659;
	bh=Q6PkhZN1LO5aZYteXn+u1sosgPv/a8y6Vpaj2cYwuTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HSCx49Z2F7XRlnxLS9u+rO23/JtsmVV5ff/jbEH3Y7JbEfemE7W7UqQRGRHZ5MdSm
	 A0Wdjo4UuOp+7xPbLE47JAfCB6pOCGGIfHvQ3lJma2di8mjNXNmRbWtCEPhOgun6O9
	 T47qMy7p6jHkE+G6tr0pCbLJBlRpH05fRIhs9HHvvNN1O2JZFSZ/dslT9eW5bb6Och
	 eEec9VMAeXrd03CSBQtny59WgX1u0SjIzzn9J31p/UANd0/QoSxdPolE5ZUVK7wSGQ
	 /P0/OF1haSUmDIewEka+MJPrF88BajcjDqaORsCRXzalSOk2gc4LyzPI8TEx/u0wMQ
	 scgb59hHNrvWw==
Subject: Re: [PATCH] bpf, sockmap: fix cork data loss after redirect
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Nov 2026 11:54:18 +0000
Message-ID: <179474365842.2199510.4530388049204286583@kernel.org>
In-Reply-To: <20261114115222.180345-1-omermetekaya0@gmail.com>
References: <20261114115222.180345-1-omermetekaya0@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a memory leak in tcp_bpf_send_verdict()
  (net/ipv4/tcp_bpf.c).
- [Medium] bpf, sockmap: stale msg->cork_bytes re-corks data in
  tcp_bpf_send_verdict()

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it reachable in more ways.

--

bpf, sockmap: fix cork data loss after redirect

This patch changes the cork cleanup in the __SK_REDIRECT case of
tcp_bpf_send_verdict(). The corked sk_msg is now freed only when it has
been fully consumed or the redirect failed. Otherwise it is kept so the
more_data loop can send the remaining bytes.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed1..e6a8184aad6a4 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -499,9 +499,13 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  				*copied -= free;
>  		}
>  		if (cork) {
> -			sk_msg_free(sk, msg);
> -			kfree(msg);
> -			msg = NULL;
> +			if (ret < 0 ||
> +			    !msg->sg.data[msg->sg.start].page_link ||
> +			    !msg->sg.data[msg->sg.start].length) {
> +				sk_msg_free(sk, msg);
> +				kfree(msg);
> +				msg = NULL;
> +			}

[Severity: Medium]
When the redirect keeps a partially sent cork alive, can the leftover
bytes get re-corked even though the program did not ask for it?

msg->cork_bytes is only written by sk_msg_init() and
bpf_msg_cork_bytes(). When the cork is satisfied, tcp_bpf_sendmsg()
clears psock->cork_bytes and sets psock->eval to __SK_NONE. It leaves
psock->cork->cork_bytes at the old threshold.
sk_psock_msg_verdict() does not reset it before running the program
either.

With this patch the sequence looks like this:

  - the program calls bpf_msg_cork_bytes(msg, N), and the message is
    copied into psock->cork with cork_bytes == N
  - later sends fill the cork, so msg->sg.size >= N, and the program
    returns a redirect with apply_bytes smaller than sg.size
  - tcp_bpf_sendmsg_redir() sends apply_bytes, psock->apply_bytes
    drops to 0, psock->eval becomes __SK_NONE, and msg is now kept
    alive
  - at more_data the program runs again on the leftover, and it may
    not call bpf_msg_cork_bytes() at all

msg->cork_bytes is still N, and the leftover sg.size is usually
smaller than N, so this check fires:

	if (msg->cork_bytes &&
	    msg->cork_bytes > msg->sg.size && !enospc) {
		psock->cork_bytes = msg->cork_bytes - msg->sg.size;

The leftover is parked in a new psock->cork, and nothing is sent until
the application writes another N - sg.size bytes. An application that
waits for a reply before sending more would stall. This is also the
path that orphans the detached cork, as noted above.

Before this patch the cork was always freed after the redirect, so the
stale cork_bytes was never looked at again in this case. The on-stack
msg from tcp_bpf_sendmsg() can probably hit the same stale value on
the existing more_data loop, so part of this may be pre-existing. The
patch does make the cork case reach it.

Should msg->cork_bytes be cleared when tcp_bpf_sendmsg() decides the
cork is fully accounted? Or should sk_psock_msg_verdict() reset it
before each program run? I am not sure which semantics SK_MSG programs
are expected to rely on across reruns.

[Severity: High]
Does this leak the corked struct sk_msg when data remains?

Earlier in the same __SK_REDIRECT case, the cork has already been
detached from the psock:

		if (psock->cork) {
			cork = true;
			psock->cork = NULL;
		}

Once this branch keeps msg alive, the local msg is the only reference to
the kzalloc'd cork. Neither sk_psock_cork_free() nor tcp_bpf_sendmsg() can
reach it any more.

The code then jumps back to more_data. On the next pass, the only exit
that kfree()s the struct is another __SK_REDIRECT that fully consumes the
message or fails. The other exits appear to leak it.

The first one is the re-cork path. Only bpf_msg_cork_bytes() and
sk_msg_init() write msg->cork_bytes, so it is never reset. After a
partial redirect the remaining sg.size is usually smaller than cork_bytes:

	if (msg->cork_bytes &&
	    msg->cork_bytes > msg->sg.size && !enospc) {
		psock->cork_bytes = msg->cork_bytes - msg->sg.size;
		if (!psock->cork) {
			psock->cork = kzalloc_obj(*psock->cork,
						  GFP_ATOMIC | __GFP_NOWARN);
			if (!psock->cork) {
				sk_msg_free(sk, msg);
				*copied = 0;
				return -ENOMEM;
			}
		}
		memcpy(psock->cork, msg, sizeof(*msg));
		return 0;
	}

psock->cork is NULL at this point, so a new cork is allocated, the old
struct is copied into it, and the old struct is orphaned. The -ENOMEM
branch also only calls sk_msg_free().

The second one is the __SK_PASS case. It never calls kfree(msg), whether
the push succeeds or fails. This case is reached when the program returns
SK_PASS, or when the msg_parser has been detached.

The third one is the __SK_DROP/default case. It calls sk_msg_free() and
returns -EACCES without calling kfree(msg).

Before this patch, the cork branch always freed msg and set it to NULL.
So a detached heap cork never went back through the loop.

The existing test_txmsg_cork_hangs case in test_sockmap.c sets
txmsg_redir = 1, txmsg_apply = 4097 and txmsg_cork = 4097. It probably
takes the re-cork path, because the test program calls
bpf_msg_cork_bytes() on every run. The test does not check for leaks.

Could the leftover be handed back to psock->cork? Alternatively, could the
code track that msg is a detached heap cork and kfree() it on every exit?

>  			ret = 0;
>  		}
>  		break;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
the patch adds another way to reach it.

tcp_bpf_send_verdict() drops the socket lock around
tcp_bpf_sendmsg_redir(). It then goes back to more_data without
re-checking psock->cork, psock->eval, psock->sk_redir or
psock->apply_bytes.

The __SK_REDIRECT case also assumes that a non-NULL psock->cork is the
local msg, and never checks msg == psock->cork. The re-cork path also
memcpy()s over any existing psock->cork.

Can a second sender on the same socket race with this window?

Thread A                                Thread B
tcp_bpf_sendmsg()
  msg_tx = &tmp (psock->cork == NULL)
  tcp_bpf_send_verdict()
    __SK_REDIRECT, apply_bytes < size
    apply_bytes hits 0, eval = __SK_NONE
    release_sock(sk)
    tcp_bpf_sendmsg_redir()             tcp_bpf_sendmsg()
                                          lock_sock(sk)
                                          program sets cork_bytes
                                          psock->cork = M2 (kzalloc)
                                          memcpy(psock->cork, msg, ...)
                                          release_sock(sk)
    lock_sock(sk)
    data remains, goto more_data

Thread A can then go one of two ways.

If it takes the re-cork path, memcpy(M2, msg) overwrites thread B's
message. B's data is lost, and its sg pages and sk_mem charge leak.

If it takes __SK_REDIRECT, it sets cork = true and psock->cork = NULL
without owning M2, so M2 leaks. An example is thread A sending exactly
3 * 4097 bytes with apply = cork = 4097.

In that case msg is still the on-stack tmp from tcp_bpf_sendmsg():

		if (psock->cork) {
			msg_tx = psock->cork;
		} else {
			msg_tx = &tmp;
			sk_msg_init(msg_tx);
		}

When the redirect fully consumes the message or fails, the cork cleanup
runs sk_msg_free(sk, msg) and kfree(msg) on a stack address.

With this patch, a detached heap cork msg can now also go around the loop
after the lock is dropped. So both outcomes can now also leak or
overwrite M2 when msg is a heap cork.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114115222.180345-1-omermetekaya0%40gmail.com
