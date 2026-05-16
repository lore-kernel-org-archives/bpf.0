Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DB1E9B3A
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944589; cv=none; b=X2F3B3/Z7YW7mK74X8ZnsqguJaZroD1D9tT5lLfyg5A66gq90tLRp82REuq9Yo/0ewGghUj8SzatIXm6WoPHiiwSYwnNbHV43b+mEhaK/bQwywy9lkSZmvfe8+AMjMybc/TCulYX3Ff3hp81qbIz0x7fEfVWAwQxFSLl5lcdQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944589; c=relaxed/simple;
	bh=arysl6a7kHgr5CmBj+LmZp65LAGwnzntbO8BP6f4krg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l+2Q7ATqhhPu8lB0ajfWhx2M3tSASkZ0H0t53tGEuqQS2uDvHBSw2xXJ7fMeFBB+9bOSrV3AZXlo/oawikQuCknw6j/BIUkJU+XxokP1KIIlwF/RdQG0jxA94SPuaHC5iIg7cm2owgweoZrr11EwkBr8xopMENktUOrkFNBjGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfHQP+ZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfHQP+ZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18DEC19425;
	Sat, 16 May 2026 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778944589;
	bh=arysl6a7kHgr5CmBj+LmZp65LAGwnzntbO8BP6f4krg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FfHQP+ZBlRQ2XmT3bsoPnGjKTEo4ht/sn+OhBGYPgGmNzIu1AzgW+j8ZQa6SoJ7GG
	 o9ycCrAwgJTC3DHJK3DBcFNS/H3GTHvk/PC4yV2jfZsxhJnbrEcHXt+S3BtOJMQFjL
	 fboIWKlPNIjJS5MG4NxkoWIpFVBy92+ZpMCN03kV1jRfk3le5O2U2wsbSOfsChQdzh
	 ZJ/nyGfGGsdKg+8J0qF1MWx7NhhOCNsDFCusvutLZmvEqtC94Ov24OemPCq/Jph7tP
	 2MDhhcMh/yAt+sifqbgm2qDklfezWb9ecCh4r5LLqHmJpM7eodJBK8LLq2fiMD8KCp
	 R+wCNcB7ph2mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: tls: preserve split open record on async
 encrypt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Lusk" <clusk@northecho.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515151556.189841-2-clusk@northecho.dev>
References: <20260515151556.189841-2-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 15:16:28 +0000
Message-Id: <20260516151628.F18DEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Error masking in bpf_exec_tx_verdict() leads to zero-copy Use-=
After-Free
- [Critical] Use-After-Free during __SK_REDIRECT socket lock drop
--

commit d94934a96df0cedb5ae4fee1bc9264e363a4efb9
Author: Christopher Lusk <clusk@northecho.dev>

net: tls: preserve split open record on async encrypt

When a BPF sk_msg verdict reduces the apply_bytes size below the open
record, the record is split. This patch ensures the remainder record
remains rooted when the initial encryption completes asynchronously.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2590e855f6a5a..5682849e102c7 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -861,6 +869,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, st=
ruct sock *sk,
>  	struct sock *sk_redir;
>  	struct tls_rec *rec;
>  	bool enospc, policy, redir_ingress;
> +	bool async =3D false;
>  	int err =3D 0, send;
>  	u32 delta =3D 0;

[ ... ]

> @@ -910,6 +919,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, s=
truct sock *sk,
>  	switch (psock->eval) {
>  	case __SK_PASS:
>  		err =3D tls_push_record(sk, flags, record_type);
> +		if (err =3D=3D -EINPROGRESS) {
> +			async =3D true;
> +			err =3D 0;
> +		}
>  		if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
>  			*copied -=3D sk_msg_free(sk, msg);
>  			tls_free_open_rec(sk);

[ ... ]

> @@ -979,7 +992,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, st=
ruct sock *sk,
>  	}
>   out_err:
>  	sk_psock_put(sk, psock);
> -	return err;
> +	return err ?: (async ? -EINPROGRESS : 0);
>  }

If async is true due to -EINPROGRESS from a previous fragment, but a
subsequent fragment encounters an error (for example, if __SK_DROP returns
-EACCES, or if tls_push_record() returns -ENOMEM), does this return
statement mask the -EINPROGRESS status?

If the error code overrides -EINPROGRESS, the caller tls_sw_sendmsg() might
not increment its num_async counter. When the send ends, it could skip
calling tls_encrypt_async_wait(). If MSG_ZEROCOPY was used, could this
allow the function to return to userspace while the hardware crypto engine
is still reading the pages, leading to a use-after-free?

Additionally, while looking at this function, there appears to be a
pre-existing issue when handling __SK_REDIRECT:

net/tls/tls_sw.c:bpf_exec_tx_verdict() {
    ...
    case __SK_REDIRECT:
        ...
        release_sock(sk);
        err =3D tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
                                    &msg_redir, send, flags);
        lock_sock(sk);
        if (err < 0) {
            sk_mem_uncharge(sk, msg->sg.size);
    ...
}

The msg argument points to the plaintext buffer inside ctx->open_rec.
When the socket lock is dropped via release_sock(sk) before calling
tcp_bpf_sendmsg_redir(), could a concurrent thread acquire the lock and
transmit or free ctx->open_rec?

If that happens, when the original thread reacquires the lock and accesses
msg->sg.size, does this result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515151556.1898=
41-1-clusk@northecho.dev?part=3D1
