Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260407;
	b=xFniz3AB5djE2uZhzi7EcyV2tLqGSxfwv02OKFu+3+GSjIYqv0QT6OuAqvx4gCKCng9U
	 0fnZ0Sx3wClpy/l7QqzZ4qpy/ai/JT88bvoAGcF2TcbIN5s/E0zngILgQhxg+m4zorrPm
	 V1D59m9AU3pxpRjNFt1BaYI36vUTYTdoFdgEVYLe/JjT3AsuaLWCDcdH9vtFtNi2D7Syj
	 12ZU1SYL1hM0ie1RgpKvrsQSL/VD53UlzRkH9o8N/r+8NbZtz8F73mdddUURToXmTrmie
	 nRTWdyBr+XJp1RHCSD1pZJI93vE1PaSX9kk8NUj60CQreaS2689IGDXwSK3b9LatKug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260407;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=FrGjP9CCTYgOXpRUiemGqSrgJibrcjFXKaApUNiODHQ=;
	b=pTLgOVrRbCdcylWv0YmFczLOD9r7D3Q89OkCySLHaUMprVjEjSvFr0DbYQM3YcjdOScU
	 xsWb/Q4bCTA67zMtXJiLHfyms1hvIAqSWG8i5Vn4YPM7Z4x5Ufd69R/z2AAP7uN+TFbCy
	 JQfVlHYfeOd5NUqdlyp7RkFjDBTC2Er7VMMyRe4IMiXO4I/17+1SbDHZFNNQap4tVjbVp
	 Z6f9V4I8gPBr7jFxDb9fWsagct/jQw2fhxvt+/Yi1Dajzlh8izzQfn6axoQtzXoC2xWRm
	 3bGnbVypxq5i2GNGoJa2CrtFjIkv/a63/ZUH1d+8n58Sh0raoWH1GZGqdwr7ED8ttTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMDXXOAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868B606A325;
	Sat, 21 Nov 2026 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMDXXOAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360BF1F000CF;
	Sat, 21 Nov 2026 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795260407;
	bh=FrGjP9CCTYgOXpRUiemGqSrgJibrcjFXKaApUNiODHQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gMDXXOAjxCaaP5G3hvFWa2q0njpLV+o3qhdGk9Chs+ioL6XCp6a9orRr0fr7c64j5
	 eOHAjyp4FrBpJw9ZF8noHy70zjKpYyFbfld5lXDDzt2ERa1sW7eB2IGu6jtK/fyBaA
	 Yu3S4KxKAkyvmsqhdK1EW00mfqtHvs8tsWpWfRb5hrgLXrwF0R3vZmiLxOmD9BHV/6
	 cdVyac7Uemy0dWSK13jXUmetvx3AoDF91VqxANJqqSr0hbfFVCdeXuV4RTSDTT+pFd
	 N1aPwRkvI3tP5RGzbbNVDXxumctlkvwdzINHq+56u7V+/70lzSqQIc29/LLpnObMGj
	 BsR15UbcP7Z+Q==
Content-Type: multipart/mixed; boundary="===============5521530718953864705=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ab092342eebeb1a7b9330adb3ee4643fcb025c330a45c80872dcc29ea6874cb6@mail.kernel.org>
In-Reply-To: <20261121103222.88209-4-jiayuan.chen@linux.dev>
References: <20261121103222.88209-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 03/11] bpf, sockmap: Fix strparser reinit after the parser link is removed
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,ast@kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,ncardwell@google.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,rhkrqnwk98@gmail.com,mhal@rbox.co,mattia.meleleo@coralogix.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 11:26:44 +0000 (UTC)

--===============5521530718953864705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Fix strparser reinit after the parser link is removed

TL;DR:
- Behaviour regression possible: re-adding a socket to a parser map after
  removing its only parser link may now fail with -EBUSY (also kcm/TLS setup)
- Misleading comment in sk_psock_destroy() and commit message for single-link
  case

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -879,6 +879,18 @@ static void sk_psock_destroy(struct work_struct *work)
>  {
>  	struct sk_psock *psock = container_of(to_rcu_work(work),
>  					      struct sk_psock, rwork);
> +
> +	if (sk_psock_test_state(psock, SK_PSOCK_STRP_DONE_PENDING)) {
> +		/* Parser link gone, other links keep the psock alive */

This comment doesn't hold when the removed link was the psock's only
link.  In that case only the reference taken in sk_psock_queue_strp_done()
keeps the psock alive.

> +		sk_psock_done_strp(psock);

[ ... ]

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c

[ ... ]

> @@ -169,8 +196,10 @@ static void sock_map_del_link(struct sock *sk,
>
>  	write_lock_bh(&sk->sk_callback_lock);
>  	if (psock->saved_data_ready) {
> -		if (strp_stop)
> +		if (strp_stop) {
>  			sk_psock_stop_strp(sk, psock);
> +			sk_psock_queue_strp_done(psock);
> +		}
>  		if (verdict_stop)
>  			sk_psock_stop_verdict(sk, psock);

[ ... ]

> @@ -297,6 +326,13 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  	}
>
>  	write_lock_bh(&sk->sk_callback_lock);
> +	if (stream_parser &&
> +	    sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED)) {
> +		write_unlock_bh(&sk->sk_callback_lock);
> +		sk_psock_put(sk, psock);
> +		ret = -EBUSY;
> +		goto out_progs;
> +	}

Can this make a previously working sequence fail when the removed parser
link was the only link on the psock?

Before this patch, removing the last link ended in
sock_map_unref() -> sk_psock_put() -> refcnt 0 -> sk_psock_drop(), which
cleared sk_user_data and restored sk_prot synchronously.  A following add
of the same socket to a parser map found no psock in
sock_map_psock_get_checked() and sk_psock_init() created a fresh psock.

With this patch, sock_map_del_link() calls sk_psock_queue_strp_done(),
which does:

	refcount_inc(&psock->refcnt);
	INIT_WORK(&psock->rwork.work, sk_psock_destroy);
	schedule_work(&psock->rwork.work);

so the old psock stays attached until the work runs.
sock_map_psock_get_checked() then returns that psock, and the new check
above sees SK_PSOCK_RX_STRP_ENABLED and returns -EBUSY.

sock_map_update_elem_sys() waits via sock_map_strp_done_wait(), but
sock_map_update_elem() as the map op and bpf_sock_map_update() /
bpf_sock_hash_update() cannot wait.  A sockops or iterator program that
deletes a socket from its only parser map and adds it to a parser map now
fails with -EBUSY whenever the update comes before the work completes.  If
the program runs with the socket lock owned, the work cannot finish in
between at all, since strp_done() takes lock_sock().

The lingering psock also seems to make kcm_attach() fail:

	if (csk->sk_user_data) ... err = -EALREADY

and TLS setup fail in that window, where both would have succeeded on the
psock-less socket before.

The commit message says "Before this change the same sequence
reinitialized a live strparser, so this is the better outcome."  Does that
premise only hold when another link keeps the psock alive?  In the
single-link case the old code returned success.

Could the deferred strp_done be limited to psocks that survive the unlink?
Or could the commit message at least describe the single-link behavior
change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44896626218
--===============5521530718953864705==--
