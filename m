Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647F3D4125
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934750; cv=none; b=dzOjXW5Gr3JxKn778Ggo98KVGuHf82bd2V9ZQBgcpqbYhUutsVPJAS8PxT0PuYYizek8LdtPnRn4UWuAEvPc42X2ipgTjxHtn5oMf6FBLvQy+lxF5BM898EkkWp8boEVUY5IGz9YglT3XJwFRPzUlZJJ6zGwrJiqBlPZuG197V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934750; c=relaxed/simple;
	bh=et6emTLh5iyvN/XtkBPo5U8DO6xRCFSTJ4OU2tygZbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NY+IV5ssfUNJj51jnZ9FLymjcLJNAVjbxmrfVarRD5Kj9OClAkgkSrTEg1kM8iNFs6rlbPNQp6S9/I3buPw5H1kTgkvORQqvfRD65rv/QwImhhKC3nJi04L7ooNKoerH+GXcYCjVM4Mm1ILLZRSS6Ku3YHphe+C0w+510nETxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA/09Svn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA/09Svn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18441F000FF;
	Sun, 20 Sep 2026 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789934749;
	bh=9EA0Ej6aTcf0Otp4d8IakSOnd+T+4OdKi09Yn7/7OAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JA/09SvnBfQmRPIm3f+uXvMaHNNoHxJCmtY8unC3mkU+ultsGjeTK/WP8clGGSVkc
	 LK14SKtAnbpiIBn3XhiN0yrx6bLJeJZlp5EGKJ4xtqZzYLa6/d+KIRo52E/YLKSqrs
	 FW0Ow9+McAoE0g5wNU3U2v3imfTKLF2xOXyc+9QLxhNRBHU4u3JdNatYNGDjOFab4K
	 4zCz/qAz5cqMGXJrtjqCT3b/VIYS3YfEz86nmn7/8c21ArjXhL+vtfR5b7ejK+WAfJ
	 FenmrD4SGz1WW68Y9mfEKbUUbVGM1VkuKXRKWyykqpvtiOFMuZC9826Dm8FeK+ilU6
	 CKwZvmyRCHU2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/7] bpf: mptcp: Don't support
 BPF_SOCK_OPS_RCVQ_CB_FLAG.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920195633.3033620-6-kuniyu@google.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-6-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 20:05:48 +0000
Message-Id: <20260920200548.E18441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: tcp_set_sock_ops_cb_flags breaks ALL_CB_FLAGS for MPTCP
--

commit 578335638acc4a540df534d791edf9c63d563e32
Author: Kuniyuki Iwashima <kuniyu@google.com>
Subject: bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.

This patch prepares for a new kfunc by disabling BPF_SOCK_OPS_RCVQ_CB_FLAG
for MPTCP subflows. It returns -EOPNOTSUPP if this flag is used on an MPTCP
socket.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 07426e8641b7e..d3cf655da9ecd 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2932,6 +2932,16 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>  	return tcp_call_bpf(sk, op, 3, args);
>  }
> =20
> +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> +{
> +	if (sk_is_mptcp(sk) &&
> +	    (val & BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
Will this check unintentionally break existing BPF programs that use
BPF_SOCK_OPS_ALL_CB_FLAGS to enable all callbacks?

If a program passes BPF_SOCK_OPS_ALL_CB_FLAGS (which is expanded in this
patch series to include the new BPF_SOCK_OPS_RCVQ_CB_FLAG bit), this rigid
check evaluates to true for MPTCP subflows and rejects the entire multi-flag
request instead of ignoring the unsupported bit.

> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5feb998846825..f29c061bb0664 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -6178,8 +6177,9 @@ static const struct bpf_func_proto bpf_sock_ops_get=
sockopt_proto =3D {
>  BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_so=
ck,
>  	   int, argval)
>  {
> -	struct sock *sk =3D bpf_sock->sk;
>  	int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +	struct sock *sk =3D bpf_sock->sk;
> +	int err;
> =20
>  	if (!is_locked_tcp_sock_ops(bpf_sock))
>  		return -EOPNOTSUPP;
> @@ -6187,7 +6187,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_so=
ck_ops_kern *, bpf_sock,
>  	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
>  		return -EINVAL;
> =20
> -	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	err =3D tcp_set_sock_ops_cb_flags(sk, val);
> +	if (err)
> +		return err;

[Severity: Medium]
Does returning early here prevent any of the other valid callbacks requested
in val from being enabled?

Because tcp_set_sock_ops_cb_flags() returns -EOPNOTSUPP when the new flag is
present, the BPF helper propagates the error without applying any of the
previously supported flags. This effectively turns a wildcard request for
"all supported flags" into a total failure on MPTCP subflows.

> =20
>  	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920195633.3033=
620-1-kuniyu@google.com?part=3D5
