Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869773E16A8
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357003; cv=none; b=UwCsOgrdOWtn5ib2qiEQhJmhaqTNhGWp1AzMhaceg8TIXHwvjWlmJSbrs1saRIRK50mLuqTYMKPhq/Sq8kRG78PaUtwHNNrAc5kxIVHd9tHpY1yYPL9tvRwBzQ1HlK5zkk4DWyf2+PkEdf+PY2GoxUJxj4YxavApoJlytbzujGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357003; c=relaxed/simple;
	bh=NeG2E7o+v7PpBd8N9EmtNU+R1//qVqRyfbrPbCbFDEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=derW16YY19mR5FY5yixrF2GVhDMcxQZcWqhcz3dD7n9I/PGG7LZ9W+mwsOwKAHHBBbRXcbWdb0xtmcAtqNIlWYfU+KKibwyYJRiEpnP/pKjBZeqNtq2P2634t0J4Cf2UNxHEZJRXrRX7E2Nm+5WEUN2c3XcFAf0afLdlISgLYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=IzXo+qLz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="IzXo+qLz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1886941a91.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785356997; x=1785961797; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DLPzQAEQsLT2O+fSZwXxQMjGKwKGH7hwJYQcxqODA3s=;
        b=IzXo+qLzNqvAm+HOPw5+jup2ycvI3OoNnugNPCUsXE3rhF1hO6ek4Hg4zaGNZm2XCi
         uICfc5TFZyTeCeSGcRCe2ZMsOJkLllsr9aouL42BFzuifEVRiipimqKR/GTzhCtHiQtw
         OELR5/crzimXGpp0EvK1RVLBiUtNuz22kcF84ei3zJgJeUfjuBqECPHyphYSDux3R7Om
         K8eubf3sOmU6UvdgRgDsE4SX/HUQ5EtyDVNtuk9xk5N+0iNyUSU+w70yJTkZm6ZB1+pc
         rs/aiPU7N+Mf/JHcGzI0tPyfT34o31or7ta5FYQGcP1kRd6uvujTS0yFClkS5yNx3yk0
         hgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356997; x=1785961797;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLPzQAEQsLT2O+fSZwXxQMjGKwKGH7hwJYQcxqODA3s=;
        b=MRgnPBFx+lSW4kflAIEdx503TUVzuXrd7JUCZKH7B92bxMGenXHa02ShqYi/bFMK+E
         /ENwQHnZUD5W/7o03T7LO+pZXrZAR0bTJOLQkeLqwFav5WCIlPlB7hcIlhDeF19OW/Pq
         cp2GoHEUUrxjeepXhkziLxrV8L+fRXNgpx6uq5Xi4cdu5r8yLUW9RP6bMt77tFQqjqkq
         t5mZ+BAmHIZd0wn6IibGdq5fRfRTu4xog/TmhpsXWVdrFsZlwdkjyDTK+MX9AWTX6RUh
         f6p0Irh60QBieFqBQkYJPRwMz8AQFcw/DYFMYSER7Nfp34+8346UKwXm/in1zpIHKcyD
         3NOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4EOCVY/xO+oeQj88OyEXe7s0noJJmthM8WLT448l5yk/AasTCr9ahwaPc1yGCnWTYdqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdQuNbWvJRxgiEc7xapNUVDK2UxJLNeF8H0JM4U8R1RP5HjGI
	RrXv44UJqSemATt9tEC7dtykiwOruAPly/VF43/vUds2p5yUJxOTP54D6G1OaOeqhvM=
X-Gm-Gg: AR+sD1304HWCjwlFssyRwKHI7F1zUmX9MfS+zG29bprjOY2GlEsQvrNGovn+pVewGyY
	ZGw9SOlt6Rxyi1q4qLqxhYb9iM+tGNV23dlB1KoCWC+ev3GiEnTZQkwLniia/4wU8lX2CHj/l4a
	xEHEk0O68etNiNu/mr+XOyk4x4VoVjI6NP3Xv9D4nGiSxbvglJIcy6pIQ6zGTeyyI56eHEhXsdr
	BZd4fGX412NhE1bLB0Q09AMbtWTtoiG9RZ/sRfvDY2Kq6LJBK7FLNLielLUUoO7vGxD7IQsfM2Y
	qwgLlvZNyP2+Bnt2n1n4vJEhdAFuZMmfO81+LMaJXsChEnkDV6n8/2ITKIetiP1bL4B8Z2oJW0A
	O1QDrthXQ2TGDU8zkuTLNi9GIjUuBl6vjnqgLtZW16lj1fDLfP0WUyNdB2tMYAEhVvfsBc64k16
	PjphGGmYwa31QN1DXKcxDr/Erm2k2T+6p9dQsYzUz//JGA
X-Received: by 2002:a05:6a21:60c8:b0:3b4:8bc6:138 with SMTP id adf61e73a8af0-3c8acbcdd34mr9864636637.23.1785356997286;
        Wed, 29 Jul 2026 13:29:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7273cd9esm13104919c88.13.2026.07.29.13.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 16:29:53 -0400
Message-Id: <DKBC8GAYVMG5.3PGUZKLGR8QW7@etsalapatis.com>
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
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/3] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>

On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
> psock's hold on the looked up socket isn't dropped until sk_psock_drop() =
->
> queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
> entry is unlinked and an RCU grace period elapses. Since the lookup runs
> under RCU, a non-NULL result guarantees sk_refcnt >=3D 1:
> refcount_inc_not_zero() can never fail here. Use sock_hold() instead.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/core/sock_map.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 9efbd8ca7db8..ca49bc7f8687 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -392,8 +392,8 @@ static void *sock_map_lookup(struct bpf_map *map, voi=
d *key)
>  	sk =3D __sock_map_lookup_elem(map, *(u32 *)key);
>  	if (!sk)
>  		return NULL;
> -	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
> -		return NULL;
> +	if (sk_is_refcounted(sk))
> +		sock_hold(sk);
>  	return sk;
>  }
> =20
> @@ -1218,8 +1218,8 @@ static void *sock_hash_lookup(struct bpf_map *map, =
void *key)
>  	sk =3D __sock_hash_lookup_elem(map, key);
>  	if (!sk)
>  		return NULL;
> -	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
> -		return NULL;
> +	if (sk_is_refcounted(sk))
> +		sock_hold(sk);
>  	return sk;
>  }
> =20

