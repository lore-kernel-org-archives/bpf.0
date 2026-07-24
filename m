Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4C432E9E
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890568; cv=none; b=CVM+TX3QgcCaSwpcrZA6M2gxY+AZZADsIOZRe9NHnz+RQl5/B/3VtjMyBxKr8WvUhH2b8UB2ziAg4DmGxRQnNgdoslnVw7ZNlLLPBqnGKPejagd8iJ5AvbX49cONwMPOj1uR0o9SJwVK0h2P9G3eAJtJ5fSrBbehUe3XGH8ljII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890568; c=relaxed/simple;
	bh=IdH6pcNPx2qWxWJo7CfIYMaaPqEUdw2yY+xf00fy9Ig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtBttx8nJsGSTe+A+j0K/YIfwTVkz5e0DiwaiWh8/jSqmW70lT5hhIET1OGG8RxEtAyYukuUvYxe/YCHnaubZCmIKNcEM9aXZgBcwgXdMCehUeTxnA9g701utLnWxqCGT8JYsv9TZbfMvIFk9R9JDS6GW33tMlmfxrCtVPaFn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvnNCg2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvnNCg2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1851F00A3D;
	Fri, 24 Jul 2026 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890567;
	bh=uYQfu2EhnTgWrAy5JuyQh5JBzz6qbmyHiJkF4IgD7HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvnNCg2qzTMvDm4Jbz55Ff1D6/zxsMSKSiD1Bnlj84dj1jvP3L/SsWbC4fDAJoi/e
	 dHcrug5LMKE2jvOVUeoLrTMHEvCYrp+zMxv5AAYk3mUcCYott9eIW4wn7qmRm6A+TG
	 Pn65KQ2G/ROvQuhHTsrbzLPRIHhFE4fA0JXtMtZdfzWVrCqcYISwT/ZH2eo3Rf4t/c
	 ezpNVhuyL4UTjuHN4/Scxig5v+PPLwmi7BCTYklVgRNBuzVcwahR3BjW+wwX2egV5L
	 l6DQCMQRBfjQwdV2uk6A3hnZfCo8Wp6kpU9FEvh535t/LDwqrNlxgD3C2iY0qXZife
	 s9Dy1V4VMks5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4] bpf, sockmap: Fix cork use-after-free in
 tcp_bpf_sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724103856.3399001-1-nicoyip.dev@gmail.com>
References: <87fr18lmzo.fsf@cloudflare.com>
 <20260724103856.3399001-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:56:06 +0000
Message-Id: <20260724105606.BE1851F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent sends on the same socket with an active redirect verdic=
t cause a Use-After-Free on the target redirect socket (`sk_redir`).
- [High] `memcpy` is called with identical source and destination pointers =
when appending to an existing cork.
- [High] A failed allocation of `psock->cork` leaves `psock->cork_bytes` gr=
eater than zero, leading to a memory leak of the stack-allocated `tmp` mess=
age and silent data loss on subsequent `sendmsg()` calls.
--

--- Patch [1]: [PATCH bpf v4] bpf, sockmap: Fix cork use-after-free in tcp_=
bpf_sendmsg() ---
commit df6d10c569d9a8f6bacb9c15795f057eb688c1ef
Author: Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which drops
and reacquires the socket lock. This patch fixes a use-after-free caused
by an unsafe comparison between msg_tx and psock->cork, resolving it by
checking directly against the stack-local tmp message.

Link: https://lore.kernel.org/bpf/87fr18lmzo.fsf%40cloudflare.com/
Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev%4=
0gmail.com/

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8e905b50deadb..a30475afb6f89 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could this leak the tmp
message and cause silent data loss if an earlier cork allocation fails?

In tcp_bpf_send_verdict(), psock->cork_bytes is updated before allocating
psock->cork:

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
    ...
	if (msg->cork_bytes &&
	    msg->cork_bytes > msg->sg.size && !enospc) {
		psock->cork_bytes =3D msg->cork_bytes - msg->sg.size;
		if (!psock->cork) {
			psock->cork =3D kzalloc_obj(*psock->cork, ...);
			if (!psock->cork) {
				sk_msg_free(sk, msg);
				*copied =3D 0;
				return -ENOMEM;
			}
    ...
}

If the allocation fails, psock->cork_bytes remains greater than zero.

Then, on a subsequent sendmsg(), tcp_bpf_sendmsg() populates the stack-local
tmp message, sees the non-zero psock->cork_bytes, and jumps directly to
out_err:

net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
    ...
		if (psock->cork_bytes) {
			if (size > psock->cork_bytes)
				psock->cork_bytes =3D 0;
			else
				psock->cork_bytes -=3D size;
			if (psock->cork_bytes && !enospc)
				goto out_err;
    ...
}

Because it bypasses the error path cleanup below, doesn't this permanently
leak the tmp message's page fragments and silently drop the data?


[Severity: High]
This is a pre-existing issue, but does appending to a cork execute undefined
behavior by calling memcpy() with identical pointers?

In tcp_bpf_sendmsg(), if psock->cork is already allocated, msg_tx is set to
point to it and passed to tcp_bpf_send_verdict() as the msg argument. If the
BPF program requests further corking, the code does this:

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
    ...
		if (!psock->cork) {
			psock->cork =3D kzalloc_obj(*psock->cork, ...);
            ...
		}
		memcpy(psock->cork, msg, sizeof(*msg));
		return 0;
    ...
}

Since msg is exactly psock->cork here, does this result in a memcpy() with
identical source and destination pointers, potentially causing a kernel
panic with FORTIFY_SOURCE or KASAN?


[Severity: High]
This is a pre-existing issue, but is there a use-after-free on sk_redir
when multiple threads send on the same socket concurrently?

When a BPF program returns __SK_REDIRECT with apply_bytes > 0,
sk_psock_msg_verdict() takes a single reference on the target socket via
sock_hold(psock->sk_redir).

If multiple threads process the remaining apply_bytes for this socket, they
all read psock->sk_redir and release the socket lock to call
tcp_bpf_sendmsg_redir():

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
    ...
	case __SK_REDIRECT:
		redir_ingress =3D psock->redir_ingress;
		sk_redir =3D psock->sk_redir;
		sk_msg_apply_bytes(psock, tosend);
		if (!psock->apply_bytes) {
			/* Clean up before releasing the sock lock. */
			eval =3D psock->eval;
			psock->eval =3D __SK_NONE;
			psock->sk_redir =3D NULL;
		}
        ...
		release_sock(sk);

		origsize =3D msg->sg.size;
		ret =3D tcp_bpf_sendmsg_redir(sk_redir, redir_ingress, ...);
		sent =3D origsize - msg->sg.size;

		if (eval =3D=3D __SK_REDIRECT)
			sock_put(sk_redir);
    ...
}

The thread that exhausts apply_bytes clears psock->sk_redir and calls
sock_put(sk_redir) to drop the single reference. Since it doesn't wait for
other concurrent threads to finish, could the target socket be freed while
they are still executing tcp_bpf_sendmsg_redir(sk_redir)?

[ ... ]

> @@ -604,7 +604,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t size)
>  wait_for_memory:
>  		err =3D sk_stream_wait_memory(sk, &timeo);
>  		if (err) {
> -			if (msg_tx && msg_tx !=3D psock->cork)
> +			if (msg_tx =3D=3D &tmp)
>  				sk_msg_free(sk, msg_tx);
>  			goto out_err;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724103856.3399=
001-1-nicoyip.dev@gmail.com?part=3D1
