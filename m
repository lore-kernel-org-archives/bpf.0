Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400021;
	b=KQmmSbU4V7/++l9KIUR+qPY1CLHl3bq5k6a3dV+BXZvx9d4vhTyGsAad+CKHOCHFZ9xX
	 kpTgU2Cq0KrcNkxjzvd1wIGAVarx2ptsEkkPyP3kNrwi9ac523EAuLqSUR1DUc0lKnNny
	 1RcOX4S3Fs1a5pGlImmIl94H9BXiFx4kIgOR80WYdrkwsNecZyWr258PEEtxqQiOnVbYp
	 DjsU+El5hOpRiERFw9yyvsz0lxoVyRFKVCba+L2qhOF3OWyuPVXxb0EMOfhrUNSFEIT2L
	 4lwNw+hu5N3wZlWpNoj4g8o/PnCFZ3M6GiRDU2iZ5DyulOTm/rdBwExSlkkaTwr1SOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400021;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=w0qcFHuhOxRFhzy+XALtHsGtZc6YwmNn3t9p0bTe8Ek=;
	b=KxihsPMJU1PrqviMQS6w6tfHSoMw2lqvm5fIFqz15ydluDgXdhR2fft0KYussOt3n0OR
	 k25KoBzr7U2YtsMYihG7+E1H5S3TQxlxqarK2IoVCdJjd/fmsMl1nOW+3SBQ4Yh3x1fD3
	 WMDshIrF6CvG2FAIxl/Z6e5pP5tgvtZId865aIXO56wvyRG2eZ6lyJfZ+bhC5COQJuNSi
	 oZpe60AEVGzFRNWjP9oriXfEILIfa5nEt8dp5y7ICZLl1VSThf9ziFhRzPlfElJZ41xFZ
	 RegmK3aU3sNvsD+A/3aMBOt1jFgBOCFJ5kQfGl9bwhMcBrGrZkjGNMEtT/CXKehzzMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRPPexqY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30EC606A33C;
	Mon, 23 Nov 2026 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRPPexqY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8481F000C6;
	Mon, 23 Nov 2026 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795400019;
	bh=w0qcFHuhOxRFhzy+XALtHsGtZc6YwmNn3t9p0bTe8Ek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cRPPexqYtX4gt98SVt8GN3oQ0ogmZgyPAGRoQo3ek9jc/awTUFDn2vFTuhR10E8sN
	 h9iS/vYQKqZ6sdWCbaI6Ex7NQKmvjT3n6S1V4hLqQwxTnOPU6pEGKb5E7P77byfb7H
	 3KNPtRgBO1MAdtWsqJfsUHe6dlAEmCZNDSdc8AZl7Eo8xsMhVYlIjYijZEDt9LFLOo
	 pWMDMbzFGkxv2ppepByqp9p03A5RBN9NZGOkklK4pxSCCfOBKJji/+md9n037KG0zt
	 Ty+7jPmIEvPdKiXRDJ5CKziZtsnwMMEAMorMghAlV7egPP6yZXmLBnYu7fOe9d9qoi
	 tovYqz40/H8xQ==
Subject: Re: [PATCH net v2] tls: fix send() returning success after the TCP
 send failed
From: netdev-bot+sashiko@kernel.org
To: hengyul@cs.unc.edu
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bcodding@redhat.com, ben.coddington@hammerspace.com,
 rjethwani@purestorage.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 02:13:38 +0000
Message-ID: <179540001873.3135.1838308128939252702@kernel.org>
In-Reply-To: <20261119141106.840038-1-hengyul@cs.unc.edu>
References: <20261119141106.840038-1-hengyul@cs.unc.edu>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] With async encryption, send() still returns success when the TCP
  send fails during that same call.

--

tls: fix send() returning success after the TCP send failed

The patch adds an abort_err field to struct tls_sw_context_tx. It is set
when tls_tx_records() aborts the connection after a failed TCP send. The
field is checked in tls_tx_records(), tls_push_record() and the
tls_sw_sendmsg_locked() loop, and bpf_exec_tx_verdict() uses it to tell
that the record was not sent and to take it out of copied.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 226e0f176fdc8..795cbfe5fb2a1 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -708,13 +717,15 @@ static int tls_push_record(struct sock *sk, int flags,
>  static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>  			       u8 record_type, ssize_t *copied, int flags)
>  {
> +	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_get_ctx(sk));
>  	int err;
>
>  	err = tls_push_record(sk, flags, record_type);
> -	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
> +	if (err && err != -EINPROGRESS &&
> +	    (ctx->abort_err || sk->sk_err == EBADMSG)) {
>  		*copied -= sk_msg_free(sk, msg);
>  		tls_free_open_rec(sk);
> -		err = -sk->sk_err;
> +		err = ctx->abort_err ?: -EBADMSG;
>  	}
>  	return err;
>  }

[Severity: High]
When encryption completes asynchronously, can send() still return success
after the TCP send fails in that same call?

With an async AEAD, or on the MAY_BACKLOG -EBUSY path that ends up as
-EINPROGRESS, tls_push_record() returns before it reaches
tls_tx_records():

    rc = tls_do_encryption(sk, tls_ctx, ctx, req, ...);
    if (rc < 0) {
        if (rc != -EINPROGRESS)
            tls_err_abort(sk, -EBADMSG);
        ctx->async_capable = 1;
        return rc;
    }

That makes err == -EINPROGRESS here, so the new branch is skipped and
nothing is subtracted from *copied.

The record then goes to TCP later in the same sendmsg() call, from the
send_end block of tls_sw_sendmsg_locked():

    /* Transmit if any encryptions have completed */
    if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
        cancel_delayed_work(&ctx->tx_work.work);
        tls_tx_records(sk, msg->msg_flags);
    }

end:
    ret = sk_stream_error(sk, msg->msg_flags, ret);
    return copied > 0 ? copied : ret;

Say tcp_sendmsg_locked() fails there with -EPIPE after shutdown(SHUT_WR)
or a reset. tls_tx_records() sets ctx->abort_err, but its return value
is dropped. ret is still 0 and copied is positive, so the caller is told
that the record was sent.

The two in-loop "Transmit if any encryptions have completed" blocks, on
the zerocopy and copy paths, follow the same pattern. The next iteration
hits the new abort_err check and jumps to send_end, but copied still
counts the failed records.

Take the reproducer from the commit message on a system where gcm(aes)
completes asynchronously. The first send has async_capable == 0 and
eor == true, so it takes the zerocopy path. Then:

tls_sw_sendmsg_locked()
  bpf_exec_tx_verdict() returns -EINPROGRESS, num_async++
  send_end: tls_encrypt_async_wait() returns 0
  tls_tx_records()
    tls_push_sg()
      tcp_sendmsg_locked() returns -EPIPE
  return copied

So it looks like send() would still print 5. Later sends do now fail with
EPIPE because of the new check at the top of the loop.

tx_work_handler() also ignores the result of tls_tx_records(). There,
though, the send that queued the record has usually returned already.

The commit message says "Do not count the record as sent" and "The send()
above then fails with EPIPE". Should the tls_tx_records() error from the
send_end and in-loop transmits be propagated, or ctx->abort_err be checked
after them, so that the failed records are not counted in copied?

This first-send behaviour on the async path also existed before
b341ca51d267. Since this patch targets this class of bug, would it make
sense to cover the async path too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119141106.840038-1-hengyul%40cs.unc.edu
