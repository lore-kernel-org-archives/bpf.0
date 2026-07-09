Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8B3403FA
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567209; cv=none; b=bw0ziXpDvoR2DkUF57gxwdDktGXIVppj1OmiWEhA64qgNXzWQOkxwZdh1Jx1yRn67RClRgn/As1n/qAtU/81GF4XebtX5FMxHVywKYzR3IXRUAw7CgwbjfVP6w8B/20WA277/RS1ert0d+7oPzRbptTT1O9nojbi10hjZiEbP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567209; c=relaxed/simple;
	bh=vFtHrmRS6i6s9c+5qFQGm2cKshyNcVCGx/dmUx/Plek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iEs5gBmpDqBnma1VtybVVOPp8ZxXmWfHsrEmcr3itOY2Bpxi/9By0FyzR9mQMbf1h4L15bMrqCB9Fo0KIdO5UYNOJDL/sN57qsyf8Ey+Aeet/MbEFLmkDkYj+LPQhv/LIejYDEMHIekope7bs2w9Lpf2wjr9J7vf0gBLOBj0yLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR5BUozd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR5BUozd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4D61F000E9;
	Thu,  9 Jul 2026 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783567207;
	bh=NC/JoWseIQ6flwRW6VtbFOyKDSHnExocseh9RabD5ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OR5BUozdMnJEZJVoiYhdSRq5y7QbVQwBajvIJ/I77BF8IpvM5DzCUk6j261TSbYea
	 HinZ1jJbYYK9YqDJXU2NrjkHZ6IvfJ1vXccz1GrxbUiASoWkM8gTOBtx5cG233ltPY
	 gk4NiBhEKslUex9OvxFvImFjex+kqaCn6eCGtXxh+gcZpWuVvV7d3hIN3LM66ycs+A
	 d81auZIPe/w2eQj281A6z8CFgiwA8GX3nExvFi6nMj2prox1BzxDhokQhdYvVEQRCh
	 1yANebFCki+DvOVLdl54YdgxxIwqiLbhCHYOxIdLUK68sVLesyR+pKp6yXc7aLfu1q
	 SeGGCLdsGRlxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Bobrowski" <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709025316.999913-1-mattbobrowski@google.com>
References: <20260709025316.999913-1-mattbobrowski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:20:07 +0000
Message-Id: <20260709032007.9E4D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF map corruption via shallow-copied sk_user_data and sk_reusepor=
t_cb during sk_clone early bailouts.
- [High] Unbalanced decrement of global network timestamp static key during=
 sk_clone early bailouts.
--

--- Patch [1]: [PATCH bpf] bpf: fix UAF in sock clone early bailouts ---
commit 81577dfc9f1b10000a3b1dfc19a5b577e986ec33
Author: Matt Bobrowski <mattbobrowski@google.com>

bpf: fix UAF in sock clone early bailouts

This commit fixes a use-after-free on parent socket's BPF local storage
caused by an early bailout in sk_clone() prior to clearing
newsk->sk_bpf_storage. By resetting newsk->sk_bpf_storage to NULL
immediately after sock_copy(), the deallocation path won't destroy the
parent socket's storage.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8a59bfaa8096e..498a57f34f5b5 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2492,6 +2492,9 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>  	sock_copy(newsk, sk);
> =20
>  	newsk->sk_prot_creator =3D prot;
> +#ifdef CONFIG_BPF_SYSCALL
> +	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
> +#endif

[Severity: High]
This is a pre-existing issue, but I noticed there might be a similar issue
with sk_reuseport_cb and sk_user_data. Since sock_copy() does a shallow
copy, newsk initially points to the parent's sk_reuseport_cb and
sk_user_data.

If sk_clone() bails out early (e.g., sk_filter_charge() fails):

net/core/sock.c:sk_clone() {
    ...
    if (unlikely(!is_charged || xfrm_sk_clone_policy(newsk, sk))) {
        ...
        goto free;
    }

    RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
    ...
}

The bailout happens before sk_reuseport_cb is cleared. When newsk is freed,
bpf_sk_reuseport_detach() can follow the copied sk_user_data to the parent's
BPF map slot and write NULL to it:

kernel/bpf/reuseport_array.c:bpf_sk_reuseport_detach() {
    ...
    RCU_INIT_POINTER(*socks, NULL);
    ...
}

Does this corrupt the parent socket's BPF map during early bailouts?


[Severity: High]
This is also a pre-existing issue, but could the same early bailout pattern
cause an unbalanced decrement of the global network timestamp static key?

sock_copy() copies SK_FLAGS_TIMESTAMP into newsk->sk_flags. The global
timestamp counter is only incremented at the end of sk_clone():

net/core/sock.c:sk_clone() {
    ...
    if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
        net_enable_timestamp();
}

However, during destruction of the aborted clone, the global counter is
decremented unconditionally because the copied flag was set:

net/core/sock.c:__sk_destruct() {
    ...
    sock_disable_timestamp(sk, SK_FLAGS_TIMESTAMP);
    ...
}

Could an early bailout skip the net_enable_timestamp() call but still
execute the sock_disable_timestamp() call on free, leading to an underflow?

>  	/* SANITY */
>  	if (likely(newsk->sk_net_refcnt)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709025316.9999=
13-1-mattbobrowski@google.com?part=3D1
