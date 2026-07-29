Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD23F4DC3
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357148; cv=none; b=s9lwfmRpnpVzH8tK8/tSXu0iKOZCOWVb3oWdophPaVL1C0Dwi0ty7v2+DFMxpTIrW5vyCYskoX9e3S4BpaH2mvL813Tctd1xfZWyfdp4IbpMIgGjMPdN6aWnONkRjiEh0KcYC9EOtWngzHJhYv0lJJZGpOAKfoDJM5ruzUIJs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357148; c=relaxed/simple;
	bh=IZIvUJTftmtCNu/estGFXWd0+fVgT8+7zpvadFJGSF4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HtImocG37Qv3Hroi1nunVYKL2roJOuJbuO61dsAsSylLq6RvJRg7QEDghyQQbUS5MaOCwsCPwSkjK3KFLNoWdw4fB1SRQFMcTqxZ2cvzLWGWL5StFJUpSpxfQjN8H9KxJx8yeo+Ilz25Aglbkjebnlu7XyJJabWBP37wYNKW6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=DNvdikDo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="DNvdikDo"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1107765a91.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785357146; x=1785961946; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GLWph0D0gf9jMPf79Y9vevPriFqqfhdgzEVroySzLQ8=;
        b=DNvdikDoERC8GWcwW9j5l2LlbQydQMdsA6qcelyf48Yy04Rw4noiigw0RP3OLXc/yn
         cKmMcb+vs7ijAom7HrZeEUJu/Hs1fYcn0F/1PmRw8a2yK5m40192K8xwUfnnpRn+18fj
         1diiirdtCEU9Qr/2hAz7dcNKwUYSPiq43WLxvWtcywsexBs7euXvxRE/0OOXbe0RcLZK
         n+jPLxrVaqCwSWD5qCUibBTNcps+KEmbYgnuk4R6eaUfxcgY9PGukFR6x2lZ+hTmtBfK
         uxyA1f+WcQ6QaLkp4HpjVTOD/8pVA6dpxKDkg8VhKusUwngqDKLWIqRC38kYhIGqv2kn
         L+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357146; x=1785961946;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GLWph0D0gf9jMPf79Y9vevPriFqqfhdgzEVroySzLQ8=;
        b=NMKf2ilI4csEM3BSlNduWh5twY3Qh4hNF3EBjA0wcVWx2N3kobxW70YwttNzeMyeLz
         bB/2anUDMQcKQxLwPQ9q2snubk0RlTkDdZlz57Z+uRmLMHhP/KKH7p1dGIdeAtHgF2qf
         NRYmJOci0CVEUgbAF15+bNM7lFozNF/U6wvhm9xZRpqgQdKMtSyX+XlmEb4bXSky2ElW
         xMDZDGhCsdVkLnq+Ywzn11+FDMxB/q//tgwM7MrbffeOVSCid4jcLzocUHALgPTHPy7r
         Sq4Bzl2hZRGVPna/w26/EULt1OcACs7mnVnV9Pj3blhkEXq1TgZMFNAAEABEGJy0VQP8
         iC2w==
X-Forwarded-Encrypted: i=1; AHgh+RqHeGqgC1tTf6suTAc4iEdxqHU9JwjTCfUIppmGOaV3KJQde7BjeRwiaTZCQ0LrfAhs/og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0PBPUxySdPY+VPivcQHRK+bCJ2oLvN6axAk80DPA11IM4qln
	OZ/yQe+ts1GgX6sNCU1FFqAQKzwf50wWjnAwSkQFUr+/OiRprio6P5TzoNp8KGmGOGY=
X-Gm-Gg: AR+sD13QUx/WCoqUaaGOFaEEtEsCLkgoi1da29jla9LcSK6m+2afih1nMVv8F2kV9Uo
	Z1hV5a46gROZ6bnvjUgHC6eZWgM3WUxH8p1rSAlkJpP4LHRcvfomuHp8XKrE0yMleD8t5Ad2ZcM
	QZZsP7kpGZaDUHgrKsS5KAZG0+WQxDrfvJgo2ih2uQ9CPZC5WfptegKJ/EQhlTfGAGJAqyiMyBi
	OE1YOfiRuQuzevdy4hxlMokSnwXluW3T8qhaMKDkysOCggi4lrhqpDKxjrGIJUQkbO9ABqToRzx
	SN+IaBm7RiiVve2sbbSEx2MTdUWgAn/rVrUIiIB2mMqLDC58tR2TXttCvgpkGwtv7ER6ARO9Ru9
	eskp5+F1baN8013seQMNAzIm921fTEr5AHfPEtBZPHvwyBVhsXtkhPQ+XgCyiLG3NQ3t49dBYoo
	YxrqRUx8AGoSLBjyiQWeSIKkoR/gXCAb+QT2Xt/pci0f4o372H/wDBxDHR
X-Received: by 2002:a17:90b:5404:b0:380:f389:447b with SMTP id 98e67ed59e1d1-38f98f4183fmr365810a91.11.1785357145938;
        Wed, 29 Jul 2026 13:32:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d373c3sm12949029eec.23.2026.07.29.13.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 16:32:22 -0400
Message-Id: <DKBCACHGQHYB.194JPC04N9WT0@etsalapatis.com>
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
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>

On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
> Lookup helpers gate whether to acquire a socket reference on
> sk_is_refcounted(), a check re-evaluated at release. An established socke=
t
> refcounted at acquire time can gain SOCK_RCU_FREE via
> connect(AF_UNSPEC)+listen() before release runs; the release-side re-chec=
k
> then reads sk_is_refcounted() =3D=3D false and skips the put. The referen=
ce
> leaks.
>
> Make acquire and release unconditional and symmetric: always take a
> reference, always put it. Adapt sk_select_reuseport().

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The bot's concern about the comment style is obviously invalid here.

>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCK=
HASH")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kern=
el.org/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/core/filter.c   | 25 ++++++++++++++++---------
>  net/core/sock_map.c |  8 ++------
>  2 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 403aba3ce891..4bc0b59668fa 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7027,6 +7027,13 @@ static struct sock *sk_lookup(struct net *net, str=
uct bpf_sock_tuple *tuple,
>  		WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
>  		sk =3D NULL;
>  	}
> +
> +	/* Always take a reference, even if the lookup skipped one;
> +	 * bpf_sk_release() always puts one.
> +	 */
> +	if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
> +		sk =3D NULL;
> +
>  	return sk;
>  }
> =20
> @@ -7084,11 +7091,15 @@ bpf_sk_lookup_full_sk(struct sock *sk)
>  	 */
>  	if (sk2 !=3D sk) {
>  		sock_gen_put(sk);
> -		/* Ensure there is no need to bump sk2 refcnt. */
>  		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
>  			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
>  			return NULL;
>  		}
> +		/* sk2 is RCU-free, but take a reference anyway;
> +		 * bpf_sk_release() puts.
> +		 */
> +		if (sk2 && !refcount_inc_not_zero(&sk2->sk_refcnt))
> +			sk2 =3D NULL;
>  		sk =3D sk2;
>  	}
> =20
> @@ -7273,7 +7284,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup=
_udp_proto =3D {
> =20
>  BPF_CALL_1(bpf_sk_release, struct sock *, sk)
>  {
> -	if (sk && sk_is_refcounted(sk))
> +	if (sk)
>  		sock_gen_put(sk);
>  	return 0;
>  }
> @@ -11565,11 +11576,13 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuse=
port_kern *, reuse_kern,
>  	bool is_sockarray =3D map->map_type =3D=3D BPF_MAP_TYPE_REUSEPORT_SOCKA=
RRAY;
>  	struct sock_reuseport *reuse;
>  	struct sock *selected_sk;
> -	int err;
> +	int err =3D 0;
> =20
>  	selected_sk =3D map->ops->map_lookup_elem(map, key);
>  	if (!selected_sk)
>  		return -ENOENT;
> +	if (!is_sockarray)
> +		sock_put(selected_sk);
> =20
>  	reuse =3D rcu_dereference(selected_sk->sk_reuseport_cb);
>  	if (!reuse) {
> @@ -11599,13 +11612,7 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reusep=
ort_kern *, reuse_kern,
>  	}
> =20
>  	reuse_kern->selected_sk =3D selected_sk;
> -
> -	return 0;
>  error:
> -	/* Lookup in sock_map can return TCP ESTABLISHED sockets. */
> -	if (sk_is_refcounted(selected_sk))
> -		sock_put(selected_sk);
> -
>  	return err;
>  }
> =20
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index ca49bc7f8687..ae18dc4d60f9 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -390,9 +390,7 @@ static void *sock_map_lookup(struct bpf_map *map, voi=
d *key)
>  	struct sock *sk;
> =20
>  	sk =3D __sock_map_lookup_elem(map, *(u32 *)key);
> -	if (!sk)
> -		return NULL;
> -	if (sk_is_refcounted(sk))
> +	if (sk)
>  		sock_hold(sk);
>  	return sk;
>  }
> @@ -1216,9 +1214,7 @@ static void *sock_hash_lookup(struct bpf_map *map, =
void *key)
>  	struct sock *sk;
> =20
>  	sk =3D __sock_hash_lookup_elem(map, key);
> -	if (!sk)
> -		return NULL;
> -	if (sk_is_refcounted(sk))
> +	if (sk)
>  		sock_hold(sk);
>  	return sk;
>  }

