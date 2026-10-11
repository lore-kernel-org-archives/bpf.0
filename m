Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5A39CD1C;
	Sun, 11 Oct 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731408; cv=none; b=hdlEW0IpPOPTuYZMPLVeqqYddmfHLJ68PUI14v6BdqVdeDP9HZ5Mqff+kmDPwZxx2V2Ukh1DADHTf7Omzne9jH+F84UW3T3SfWlT/wqc9ZK6AU5db7qVLGlWtq4V9HScpSb6uzlEDJVP6f8qO4/O4F0zdpE/NgYzMA0ZL2RvmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731408; c=relaxed/simple;
	bh=Ie7oaV1g4DpCKkWn8CuiYPNNi1a4U341Yz+I8WZTpjQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGZ09HeZS/KKbgrg7+MBMVLWNlXM1Wwda4+9e7e6bx4O/7MlgKcTHrorABSMbhZcDxzezE7sIulGEkGLljH8li/rNgsZzex7eSBm369g709IeAYpIsbH7mO53QwCIzxIbOn+xD5I9qoEX/YXaimxg4Gb3W+t6JgLc1qw7h/eogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmnX3AtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmnX3AtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6F41F0089B;
	Sun, 11 Oct 2026 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791731406;
	bh=fie1+6L/GTg9gjNOky/N34SwpRXzg59gsiBRdtWg8u4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jmnX3AtIE6erXrs7B0u1i8HQDXO7hwldHM5gvqNVudpRMqFOjVceEv78xukHzT3aZ
	 M1pC8O3H+8AFTgVIwPmrxZv2mQq6dFG7nCD0sVkRV5A2gTHc+gIL6aQvVq0z0ExRCG
	 +V2PhGSOj2nlX3jgbSZT0jThqHoA3PTLvQPJaVDpiM4H4AANAh4Gf9pIr2RbZcMVtE
	 ZaUWiqLfHsgmgMwld9woGWlOPx+rofJxpqYVkNOKEzvb+MDY3iw3GG9tyqofgWgiwl
	 TFq8iXWgfKZf7+FDhUbUWWcrkxqCfa992xoU+AwVCFSY7k16Sbr/xK3fUYRDOQZTPa
	 11eIjHcCDNUVg==
Subject:
 Re: [PATCH net-next v3 1/2] tls: annotate lockless access to sk->sk_err
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 15:10:05 +0000
Message-ID: <179173140561.434549.1271106969659357254@kernel.org>
In-Reply-To: <20261010-tls-fix-sk-kcsan-err-v3-1-e28aadeb31ad@proton.me>
References: <20261010-tls-fix-sk-kcsan-err-v3-1-e28aadeb31ad@proton.me>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit body describes a user-visible bug: tls_rx_rec_wait()
  "can return 0 after another thread consumes the error".

Pre-existing issues:
- [Medium] This problem was not introduced by this patch, but the patch
  edits the line involved.

--

tls: annotate lockless access to sk->sk_err

In the kTLS TX paths, this patch replaces repeated unmarked loads of
sk->sk_err with a single READ_ONCE() snapshot. On the no-data path of
tls_rx_rec_wait(), it drops the "if (sk->sk_err)" pre-check and calls
sock_error() just once, so another thread that consumes sk_err can no
longer turn the error into a 0 return.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 312e51270f293..a2be1283ca930 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -704,10 +707,14 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>  	int err;
>  
>  	err = tls_push_record(sk, flags, record_type);
> -	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
> -		*copied -= sk_msg_free(sk, msg);
> -		tls_free_open_rec(sk);
> -		err = -sk->sk_err;
> +	if (err && err != -EINPROGRESS) {
> +		int skerr = READ_ONCE(sk->sk_err);
> +
> +		if (skerr == EBADMSG) {
> +			*copied -= sk_msg_free(sk, msg);
> +			tls_free_open_rec(sk);
> +			err = -skerr;
> +		}
>  	}
>  	return err;
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but the
patch touches this line. Can the EBADMSG test in bpf_exec_tx_verdict() miss
a synchronous encryption failure?

tls_push_record() reports the failure by writing sk_err, then returns the
raw crypto rc:

net/tls/tls_sw.c:tls_push_record() {
    ...
	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
			       msg_pl->sg.size + prot->tail_size, i);
	if (rc < 0) {
		if (rc != -EINPROGRESS)
			tls_err_abort(sk, -EBADMSG);
		ctx->async_capable = 1;
		return rc;
	}
    ...
}

bpf_exec_tx_verdict() then reads sk_err back to decide whether to clean up.
Some writers that don't hold lock_sock can change sk_err between
tls_err_abort() and the READ_ONCE() here:

  getsockopt(SO_ERROR): sk_getsockopt()->sock_error() does
  xchg(&sk->sk_err, 0)

  do_recvmmsg() or MSG_ERRQUEUE, via sock_dequeue_err_skb()

  tls_encrypt_done() for an earlier async record, which can overwrite
  sk_err with its own error via tls_err_abort()

If one of these lands in the window, sk_msg_free() and tls_free_open_rec()
are skipped. *copied then still counts bytes that were never encrypted or
sent.

ctx->open_rec also keeps pointing at the failed record. On this error path
tls_do_encryption() has already done list_del(&rec->list) and returned
without clearing ctx->open_rec.

If sk_err was cleared, the next sendmsg passes the loop-top sk_err check in
tls_sw_sendmsg_locked() and reuses that record. Its scatterlists were
already end-marked and chained by the earlier tls_push_record().

The single READ_ONCE() snapshot removes the old double load, but it doesn't
close this window between the write and the read-back. Would it be more
robust for tls_push_record() to report the encryption failure to its caller
directly, instead of passing it through sk_err?

[ ... ]

> @@ -1132,10 +1144,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
>  		 * sk_err here so a connection abort surfaces as the
>  		 * actual error rather than a clean EOF.
>  		 */
> -		if (sk->sk_err) {
> -			if (has_copied)
> -				return -READ_ONCE(sk->sk_err);
> -			return sock_error(sk);
> +		if (has_copied) {
> +			int err = READ_ONCE(sk->sk_err);
> +
> +			if (err)
> +				return -err;
> +		} else {
> +			int err = sock_error(sk);
> +
> +			if (err)
> +				return err;
>  		}
>  		if (sk->sk_shutdown & RCV_SHUTDOWN)
>  			return 0;

[Severity: Low]
The commit message describes a fix that users can see:

    On the no-data path that check-then-sock_error() window can return 0
    after another thread consumes the error.

All three callers of tls_rx_rec_wait() end the read on a 0 return. In
tls_sw_recvmsg(), for example:

	err = tls_rx_rec_wait(sk, flags & MSG_DONTWAIT,
			      released, !!(decrypted + copied));
	if (err <= 0)
		goto recv_end;

tls_sw_splice_read() and tls_sw_read_sock() do the same. So before this
patch, with nothing copied, userspace could see a spurious EOF while
RCV_SHUTDOWN was not set. One example is when sk_err came from
tls_err_abort().

Should this patch carry Fixes: tags so the fix reaches stable? The recheck
before the RCV_SHUTDOWN test was added by:

Fixes: edcf32b8a48f ("tls: Flush backlog before waiting for a new record")

That commit's stated goal was to report the error "rather than a clean
EOF". The top-of-loop check was last restructured by:

f508262ae9f2 ("tls: Preserve sk_err across recvmsg() when data has been copied")

although its check-then-sock_error() shape is older than that commit.

Also, the commit message says "the outer if (sk_err) is an unmarked load"
in the singular, but the patch rewrites both such blocks in
tls_rx_rec_wait(). Could the message mention both sites?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad%40proton.me
