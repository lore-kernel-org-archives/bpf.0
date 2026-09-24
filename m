Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40953A05FC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221703; cv=none; b=XfOWPnKXnu7oxTfoTj6f45F9p52iiFDLOq0MhCDVNUlUYxQSS7GHaxL9iMh1X4YLt5oAyS8wNSHF5BlBwS7hncUEV6iFkQwvNxeNQQJCisyB4yy74UoruzsL9MhzCnzodqETcFrA44q6Nf5CkNTUqImqxV9iiZwbQ7/ZMs0gpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221703; c=relaxed/simple;
	bh=u7VfKm5rOaDl8d0G3ZndWq3QuUaMVh/vqQ+AIdsZlfc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pHSG0BAkCY6bREH/yo1KOsWkw1tS+rPI25ESz4CIqAwdUBG3YvguVmoB8sSeUkgPlmtSLYpPj//pfEAM6LshJGlA0eJPPM7h3OHVrUwgCyist5nqVpyJdOPktOFv0Y/PDK5H9rok0jUpYe4nTsAcsSs12n/CQWLIucVcHeHWa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qHcjRU7b; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qHcjRU7b"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d9004a1ac0so7238885ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790221699; x=1790826499; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vyH+46wvVCG42WHP8ZLxeKrUMVBuwkf4fMiMhZ0rDTg=;
        b=qHcjRU7bbGiYDZYWVQtKUkV83qv8owh8mJxTgCs4rimyrFHNg0SfsjWzB0NxZyuj59
         VmW3tm1Kuf7XNt3r2saoVM1QVB6XSXCSgHY0TwhiIR+kDnQjxYvpoZ6mXxFduTc8g/ac
         ex10OZleEzSJkkN8bdQfND+qFw0+iOIeuoBLlXLcpMYD9S6vPPW4ewCSN8L4hHK0axqC
         xPawEIGL7LWzhINI2GH9TsfpZvUT9BSwDICnyAOumWFNJHWQkDfjjyTyxwr2d/MiKQjn
         qPmnUDb7RYQ6GoMfDUgU3IWDZXCYhwRgV+0MO0NfKIOKxiRmSwRmSHwl2W+cfCJYodCH
         3yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221699; x=1790826499;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyH+46wvVCG42WHP8ZLxeKrUMVBuwkf4fMiMhZ0rDTg=;
        b=SrkKhtlnQwDgs98r1YdzpiUE7H4Ylo/100VXOTZYBV+pLTwvUqJhRudc2P0WuG0zsl
         ZglglcY+E2PFfXnY/KWJDAk9H5ZfzdJRYmjRfReHnhljww+ssfv6HVF2Aj1ooYNzQkPX
         Hk2nnhCM7a6QfZJVsPbKpcUoE7CrZ69ciFRNzzEfeZTyltojFZ1Md55bMb/Jl97p9Hhe
         G8DftMh5BBbAPvYiA3jq7Vgy/rrgMNQae6QqVIexMHwkyWw1ZD+1SM4UVScRoLNfFbP8
         +HWErKWOnB6P57LSI6ZtIvWGG7zQ2amaZxAhb5JYlKMGaQJarjbPTp+wZ6GqSHOU6Uhk
         O2tA==
X-Forwarded-Encrypted: i=1; AKwUvBy8DDUByxaTtAvVCz1HkbeGSBtkUCLnmURRPmDHJ/sOrNSDBK/Lmp4LpQkzb5SpXJOClEs=@vger.kernel.org
X-Gm-Message-State: AFuF++naNx0tICYdM6ZDNQfM8qZU/5SHwel/2ev/O5UwjBcLN8/Bqldj
	hgY4vk7eRuOiDB0NU0qGWqFsgwijfb9BkORAQwYQDlYuuhX4EDzVoqtHyPtcujUrqP8=
X-Gm-Gg: AYBFou1XgCYDoQahQLyruQ6qyruic9cCh1B2V3QLLD95H5hoHdHLNfuUwR13JwflNIy
	3oMCv2icxpuiwvxKew0UF+G3gnM6F5tlB2y2hCB8B+oNqykzPSySR4mDOm0aauwh7ptKHor9RiI
	/Mjmdv/vGQl5g7wTqpwcQ6m9ddTyjBtve+jHTf8/wtdKd1Hbb5CPi76fYDBUQeLZwX5MfCkQkOq
	oJ57Ejt4b/eVImpRW1UcjP4QpLiFsCVWMWIIcaG09NFPGQRGnJW7lBAcdQt9oqWAeOrJd03xf+o
	c6FVFd8mbz5/+4OdnriHSMH4FPZiJBeZS2lRoFN4jtFRcncyi464+6ZHM3rgQoP/beyJVk/+sxy
	wjmXRmya6QrBbB8IMcXaKzkiao/hAycqpkVgH28vlqwgqwa69FnGI4aXEkX6+teE7qGMmT3plRK
	ZoJ26bS6h8NfhbK0A2p49ofyd61uOF4W1O3F22Docz9ld6/C9sTQKYM+YlTEAOmLf9osamXSC+y
	4Y01N6FtWv3jzBnWn+M+n8FYSK4Me+G
X-Received: by 2002:a17:902:ebc8:b0:2df:8226:4930 with SMTP id d9443c01a7336-2df82264b0emr3767795ad.37.1790221699268;
        Wed, 23 Sep 2026 20:48:19 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5dbc0fsm19242845ad.57.2026.09.23.20.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 20:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 03:48:17 +0000
Message-Id: <DLN8MMAY53A6.31EWYOHJ1YWLV@etsalapatis.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 6/8] bpf: mptcp: Don't support
 BPF_SOCK_OPS_RCVQ_CB_FLAG.
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-7-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-7-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> to bpf_tcp_ops.
>
> MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> subflows.
>
> Let's disable BPF_SOCK_OPS_RCVQ_CB_FLAG for MPTCP for now.
>
> If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> extended to properly support MPTCP.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/tcp.h      | 15 +++++++++++++++
>  net/core/filter.c      | 10 ++++++----
>  net/ipv4/bpf_tcp_ops.c |  5 ++++-
>  3 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 07426e8641b7..d3cf655da9ec 100644
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
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	return 0;
> +}
> +
>  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>  {
>  	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> @@ -2954,6 +2964,11 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>  	return -EPERM;
>  }
> =20
> +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>  {
>  }
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5feb99884682..f29c061bb066 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5588,8 +5588,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, =
int optname,
>  	case TCP_BPF_SOCK_OPS_CB_FLAGS:
>  		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
>  			return -EINVAL;
> -		tp->bpf_sock_ops_cb_flags =3D val;
> -		break;
> +		return tcp_set_sock_ops_cb_flags(sk, val);
>  	default:
>  		return -EINVAL;
>  	}
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

Afaict the tcp_set_sock_ops_cb_flags is inconsistent with the previous retu=
rn values,
in that it returns an errno instead of the flags it couldn't set (it also d=
oesn't
set the flags that we can set for MPTCP when BPF_SOCK_OPS_RCVQ_CB_FLAG is s=
et, which
is the convention of its callers). Would changing the error path to

	tp->bpf_sock_ops_cb_flags =3D val & BPF_SOCK_OPS_RCVQ_CB_FLAG;
	return (val & (~(BPF_SOCK_OPS_ALL_CB_FLAGS ^ BPF_SOCK_OPS_RCVQ_CB_FLAG);

work?


> =20
>  	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
>  }
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 4b48711d92a2..b0cade34cce6 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -223,8 +223,11 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_p=
roto =3D {
>  BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
>  {
>  	int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +	int err;
> =20
> -	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> +	err =3D tcp_set_sock_ops_cb_flags(sk, val);
> +	if (err)
> +		return err;
> =20
>  	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
>  }

