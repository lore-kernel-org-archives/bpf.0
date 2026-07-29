Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D73DD520
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357017; cv=none; b=XDiKGicn3xOtUCjiEPpIjJhSrtBPPZnydjTDA8jjQqaouBfKuqPtHBMfb4ILTI9Xh9tmwgCxHOS293bgdno8fBK2ZyL/tK73kYslzFoTDdviEgehpNqZ7lYoz8lM30xgspLI/FQA1+ZIMyK4oW6n5dxBR/1S0/TW3kJudAm4WUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357017; c=relaxed/simple;
	bh=TIzvQ5yYUuwHOZxSzc2URBeJxr0Wj/Wxqs1MuDtXDC8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LI6S4OtXHAwFXErrzZu+UOnJZfZSM+ilNzZ3LYndUjO/Jl2DUohq70dBL45NwotmmKvmSuk0bJoO80E6awOxJb+MXnPfxVKetzW2VAXRYGt3B2ZAEiksnzk2U1NuKG/imUDK9w5jyx/TyPqXKF4diMDBzFKEWZ1oywy7qAMLHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=snJRu/I1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="snJRu/I1"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1094041a12.3
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785357013; x=1785961813; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ShSGDIdvDY2A/E8agT8O3gUlL/J2ljN0bWMP2ClUyTQ=;
        b=snJRu/I1rxhtPPlplPfA/tc7BkejtbtViAvkD9DjNS3xDMJZBQQsZTurV3pg/2N4uq
         K91Fx8fV7w9VTZeniNBqT9hxURWsEOZlNmrWu2fzwd4XGRc2hhtO+0FWKTGyyWqZbVnq
         UJQaX68HBSZ+oobDIoP36ujpXLD6w87OmHfWNMxXiGPntEdVlMtFnbvB4dZ6NrAUfocB
         Iud3yL+1IOAl0CORgN8OwApT6ivghbj3aAwr4dxAaE6pxSmmtZTC+j1EHnR+vDsmWdLy
         mQzlUP8Ms7tW7LBb4CUMnUzgbi5H1JbwsFVwaiAuC/tT8omQ+5pmd7prBIlfyXoJTiVG
         iABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357013; x=1785961813;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ShSGDIdvDY2A/E8agT8O3gUlL/J2ljN0bWMP2ClUyTQ=;
        b=ja7fqrtRkTcYE95kGrIJvKujk+7R6nw1r95w1m4tENF/LMZTqeeCOwceou3rxG8XH4
         T95zFprmdiV9C6/0DUB6aYrzhjJxTEgWUkWZa57FBJKaaSkYTSaLuGJOP+9xmRRAFTdv
         G34cjCtUDTW07nd9SkE5AlUD853qaCY4YT2s8qqpBdwrvDq8mhl3GuNqYnTbA7GuiWd/
         qhHWYtmOOKs7pdHC7KBtYcfTbI3LP7vJ5YkzEQR7LLCsvnSpUJj5mNQ2l+jC+eYc/vX/
         TCAZiDRrhgbr99COZo+m7sy6tfB841G19e89bJzIEqrKLY1b6pbtdIl9aKRiiKHaKqzQ
         euEw==
X-Forwarded-Encrypted: i=1; AHgh+RqRlAdAIxPJAxzDo3CxkbXvJ/p3FF982tsFJONRjxyqdrs6TGHZc2ADmQQrU+qsVGnlrOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFk9v7rRInLRqTv86NS/nPlVP2wtFAQz9xy5sn33qpSclB0G1D
	XdGThEno6TIC2Ywtmw4DCzX4e20T4qnD0tt/Ld1IbALG0MKq9T7XUUt2IvfhXa22UPE=
X-Gm-Gg: AR+sD10YWIDS0UhJMK1EDQMOL1VpA9EKy95lCKjvsR8xDENDdFBkuhw+IohOGTyvKPq
	JNC7f4iz0oMSNWhJ2Rr9T/r0RJpCkhaFd4P1L0bwfU101qX6vMrI26iE9jgsOmjr7iimI2MYkI4
	g7KxKcCC2GdxKwq7X4Bc0TETF16SO2+MSaJXHLESL7wfAUj3gdA+3PfG5z0/rzQMYJ2vjeWpsA9
	hPNqPD/a+soofjIpUcHZEa4loP9mf1m4ItOcovoiD1QiTd5Xnx1mbvYCxgGDY6KB6Jbc0B0g7qW
	qqoJ7G26zKwBJdS36SwrtF3wOsrFFMUS0API7kqAlt6DmDnwBo6rGiQSCMh5Oz+6clvgBZWl0rZ
	C6w7iGFYEFrTzlBuRruNwiht7iZcbfmGTwNmKr0rsglVELvcYGjO1CoxJ8ElKx0RnqojPNN94th
	sNkxMfSYByUQiW+rYT9pN2XudrG4BdhjomceYV+4gdsBrSMvwpSUGcBYc=
X-Received: by 2002:a05:6a21:112:b0:3c3:7bb9:c93 with SMTP id adf61e73a8af0-3c8ba61523bmr9792974637.53.1785357013468;
        Wed, 29 Jul 2026 13:30:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm19441406c88.5.2026.07.29.13.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 16:30:10 -0400
Message-Id: <DKBC8NVXBTW8.C20199U1ITBD@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 2/3] bpf: Extract shared reqsk-to-listener upgrade
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman"
 <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Joe Stringer" <joe@wand.net.nz>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-2-1bbdc58ce514@rbox.co>
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-2-1bbdc58ce514@rbox.co>

On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
> __bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
> reqsk-to-listener upgrade. Extract it into a helper.
>
> Leave the currently unreachable WARN_ONCE as a defensive assert.
>
> No functional change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/filter.c | 57 ++++++++++++++++++++++++-------------------------=
------
>  1 file changed, 25 insertions(+), 32 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b446aa8be5c3..403aba3ce891 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7074,6 +7074,27 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_s=
ock_tuple *tuple, u32 len,
>  	return sk;
>  }
> =20
> +static struct sock *
> +bpf_sk_lookup_full_sk(struct sock *sk)
> +{
> +	struct sock *sk2 =3D sk_to_full_sk(sk);
> +
> +	/* sk_to_full_sk() may return sk->rsk_listener, make sure the original
> +	 * sk sock refcnt is decremented to prevent a request_sock leak.
> +	 */
> +	if (sk2 !=3D sk) {
> +		sock_gen_put(sk);
> +		/* Ensure there is no need to bump sk2 refcnt. */
> +		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> +			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> +			return NULL;
> +		}
> +		sk =3D sk2;
> +	}
> +
> +	return sk;
> +}
> +
>  static struct sock *
>  __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 l=
en,
>  		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
> @@ -7083,22 +7104,8 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_so=
ck_tuple *tuple, u32 len,
>  					   ifindex, proto, netns_id, flags,
>  					   sdif);
> =20
> -	if (sk) {
> -		struct sock *sk2 =3D sk_to_full_sk(sk);
> -
> -		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the ori=
ginal sk
> -		 * sock refcnt is decremented to prevent a request_sock leak.
> -		 */
> -		if (sk2 !=3D sk) {
> -			sock_gen_put(sk);
> -			/* Ensure there is no need to bump sk2 refcnt */
> -			if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> -				WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> -				return NULL;
> -			}
> -			sk =3D sk2;
> -		}
> -	}
> +	if (sk)
> +		sk =3D bpf_sk_lookup_full_sk(sk);
> =20
>  	return sk;
>  }
> @@ -7129,22 +7136,8 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock=
_tuple *tuple, u32 len,
>  	struct sock *sk =3D bpf_skc_lookup(skb, tuple, len, proto, netns_id,
>  					 flags);
> =20
> -	if (sk) {
> -		struct sock *sk2 =3D sk_to_full_sk(sk);
> -
> -		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the ori=
ginal sk
> -		 * sock refcnt is decremented to prevent a request_sock leak.
> -		 */
> -		if (sk2 !=3D sk) {
> -			sock_gen_put(sk);
> -			/* Ensure there is no need to bump sk2 refcnt */
> -			if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> -				WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> -				return NULL;
> -			}
> -			sk =3D sk2;
> -		}
> -	}
> +	if (sk)
> +		sk =3D bpf_sk_lookup_full_sk(sk);
> =20
>  	return sk;
>  }

