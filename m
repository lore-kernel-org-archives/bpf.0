Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F737F8CB;
	Tue,  6 Oct 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273290; cv=none; b=Do+otLzgxPJI+mJrMeMhWFpL+gGUcgF3AzWnmFXn5NDF92wzTGA/IgCp3n6d4j9VTV+0uiVHzYEsLwiNJERY9PR11OasssW1rH6rXFNCJFeFH3LqZbyR3iFMa7v/18AU9QXnI226UlwOPk9ZCYeBlVi3SYQkjuzlZy0zHo3fW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273290; c=relaxed/simple;
	bh=YNkQyaKyn6ScD9zx23d6iFoOM1y0gpFJNhhwGo6R3Ug=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pkfWhJSJePR4bEchX7sveF8pv7TdSs4dimA85spRQ9BnJogstD5xwuEfuZEUn4zZY9oNOcT9MBS8XT06uySChVPU/uIDCBhvoG5w7E+jy5MPFI/t9NC9dkIVBsp1/EFWbrklwEYAlPh86I2UCOH2OD0tuPFRvgiSVcKz7CHZfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7eN6KNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7eN6KNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE611F00893;
	Tue,  6 Oct 2026 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791273289;
	bh=fpa5+JOtkZZuP2tvDHGlTsvFx2gQANVc+3ezgz25LyQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j7eN6KNB25i4mlxGjDOQoCaROpurempRcNbJuXmh/nqQ51MuNvsXA4+NvqamqjkNu
	 ko7PKQMixvo9LWGc5Q/IM+ldYt+6Uc7eDp8km2LW0ETehodUboQ6VrokfocMvi8mpi
	 BzavtxLo7O7aKTczhmGk3btQKClmIK8k2jnwgn3YdW8PFcjYBATBOPw3f3rfVP1dg/
	 XbEXNhoyeA7PWsQCcaHA0NEp3YJ/o+F8dySd9xKioHXgcouzPFvHh4VhkZJhKOKkoT
	 XAZYNvpjgSsScAtLUbVQutDUwmPkxjxDb7S+AFPAbVeyEC5tzSQ/XpL0NuIzQLzo8s
	 h5azkc7oUdCgg==
Subject: Re: [PATCH net-next 1/2] tls: annotate lockless access to sk->sk_err
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 06 Oct 2026 07:54:48 +0000
Message-ID: <179127328838.434549.8857657858630692504@kernel.org>
In-Reply-To: <20261002-tls-fix-sk-kcsan-err-v1-1-baa0ba056323@proton.me>
References: <20261002-tls-fix-sk-kcsan-err-v1-1-baa0ba056323@proton.me>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The title calls this an annotation change, but the patch carries
  a user-visible behavioural fix and has no Fixes: tag.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the async
  receive epilogue of tls_sw_recvmsg() (net/tls/tls_sw.c) can overwrite…

--

tls: annotate lockless access to sk->sk_err

On the no-data path, tls_rx_rec_wait() now calls sock_error() once
instead of doing a plain sk_err check before it. The has_copied path
keeps using READ_ONCE(). In tls_sw_sendmsg_locked(), tls_push_data() and
bpf_exec_tx_verdict(), the two plain sk_err loads become a single
READ_ONCE() snapshot.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d1ad31986cf2c..12e4458b44bb8 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -704,10 +704,14 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
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

[Severity: High]
bpf_exec_tx_verdict() now uses a single snapshot. Its async
counterpart, tls_encrypt_done(), still loads sk->sk_err three times
with plain loads. Is that intended?

net/tls/tls_sw.c:tls_encrypt_done() {
    ...
	/* Check if error is previously set on socket */
	if (err || sk->sk_err) {
		rec = NULL;

		/* If err is already set on socket, return the same code */
		if (sk->sk_err) {
			ctx->async_wait.err = -sk->sk_err;
		} else {
			ctx->async_wait.err = err;
			tls_err_abort(sk, err);
		}
	}
    ...
}

tls_encrypt_done() is the async AEAD completion callback. It runs from
the crypto engine, softirq or a kworker without the socket lock. The
racing side is the one the commit message names: sk_getsockopt() for
SO_ERROR does v.val = -sock_error(sk), which clears sk_err with xchg()
without the socket lock.

Suppose err is 0, the first check sees a non-zero sk_err, and the
xchg() clears it before the second check. The else branch then runs
with err == 0:

	ctx->async_wait.err = 0;
	tls_err_abort(sk, 0);

tls_err_abort() starts with WARN_ON_ONCE(err >= 0). Can this fire the
warning (or panic with panic_on_warn) and then write sk_err = 0?

In the other interleaving, the second check sees a non-zero value but
the -sk->sk_err load sees 0. async_wait.err becomes 0, and if err was
non-zero the real AEAD error is lost too. rec was already set to NULL,
so the record is never marked tx_ready. tls_encrypt_async_wait() then
returns 0 to the sender, and tls_tx_records() stops at the first record
that is not tx_ready.

After this patch, this looks like the last plain sk_err reader in
net/tls. The second patch in the series, "net: annotate lockless writes
to sk->sk_err", does not touch tls_encrypt_done() either.

Could this use one snapshot as well, for example
int skerr = READ_ONCE(sk->sk_err), for the test, the branch and the
assignment? Then tls_err_abort() would only ever be called with a
negative err.

[ ... ]

> @@ -1107,10 +1110,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
>  	timeo = sock_rcvtimeo(sk, nonblock);
>  
>  	while (!tls_strp_msg_ready(ctx)) {
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

[Severity: Low]
This isn't a bug, but the subject calls this an annotation change, and
this hunk changes user-visible behavior.

Before the patch, another thread could clear sk_err between the plain
check and sock_error(). The data_race(!sk->sk_err) fast path in
sock_error() then returned 0. With nothing copied, tls_sw_recvmsg()
passed that 0 to userspace as EOF:

	return copied ? : err;

The commit message describes this ("can return 0 after another thread
consumes the error"), but there is no Fixes: tag.

The first site comes from f508262ae9f2 ("tls: Preserve sk_err across
recvmsg() when data has been copied"), which replaced the older
return sock_error(sk) from 35560b7f06b8. The recheck after
sk_flush_backlog() below comes from edcf32b8a48f ("tls: Flush backlog
before waiting for a new record").

Should Fixes: tags be added so stable and backport tooling can pick up
the spurious EOF fix?

>  
>  		if (ret < 0)
> @@ -1132,10 +1141,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
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

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Can
the async receive epilogue in tls_sw_recvmsg() overwrite a negative
return from tls_rx_rec_wait() with 0?

tls_rx_msg_size() only rejects data_len < cipher_overhead, so it
accepts a TLS 1.2 application-data record with empty plaintext. Take
ctx->async_capable with an AEAD that returns -EINPROGRESS:

tls_sw_recvmsg()
  tls_rx_one_record()          /* darg.async stays true */
  async |= darg.async;
  chunk = min_t(int, to_decrypt, len);     /* 0 */
  async_copy_bytes += chunk;               /* still 0 */
  tls_rx_rec_wait(..., has_copied=false)   /* -EAGAIN, or sock_error() */
recv_end:
  tls_decrypt_async_wait()                 /* 0 */
  err = process_rx_list(ctx, msg, &control, 0,
                        async_copy_bytes, is_peek, NULL);

The peek variant passes copied + peeked and decrypted - peeked, which
are also 0 here. With skip and len both 0, process_rx_list() skips both
of its loops and returns 0. That value overwrites err, and since copied
is 0, return copied ? : err returns 0.

On an open socket, would a non-blocking read return 0 (EOF) instead of
-EAGAIN? Would a connection error that sock_error() already consumed in
tls_rx_rec_wait() be lost and reported as a clean EOF?

Could the original receive error be kept when the async drain produces
no bytes and no error of its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323%40proton.me
