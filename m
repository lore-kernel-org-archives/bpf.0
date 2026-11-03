Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742435;
	b=RdAouOVCUlAT/cRQCR0r7nqdFrhenO/iF8Kgq7MEnHRzN6tafp1WJzgLfpXUunjWcWCB
	 tIC3ztGEhUZDK9aD8JD3H8mYTuySFZk1bLf34Z9XTfGvRJQv1JvFbHifEM7nzIL/4mxgJ
	 NSt3uMmigmQbx9NrQHhr2H3fSlDAeUnra/l47A+Y+S8zg7kdLRv46haiWBo1IqRPGpRQK
	 8ZMyJ8HJwMWHio7wqs/C78F+MZHYYL9A4bC+IXe+LH/rzCmy+HoxxzIWUnMl6OZvKsJgj
	 kQxd+/puUrmBTForpTj+is2KsbzpJST/hsklunJnv8RsX1eUUER/RgkwBFMk3b9y1jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gslbebf1LMvPLM8Q5E/+GJDx3HzrVAFeNFBvrSeRD3A=;
	b=SFOgytyKoaU++p3ID1fMG5mS/ud2BgO1y1oc2qmAqruQPZi4KsvPQY1QSqgXqh4RWJ5K
	 WpGIgv8X9rH5yWFIU5Rq5qXz5Mlxp+1zOLoukBvF1LzHxhHdekb6M7JoHPTNud+t77EDp
	 UzJzJq+A2RzjwALGYzE/HedPbi7n8yL0dGHnIh3RldITPJW6axBghtYhtunREmzYloHEn
	 p4So9KponxdXXHs+1KYv0tu/r7nXa4CU/2hz8zCts313xJHdZH4Ryxqd1Rv/X3BHK7wXJ
	 7cxnzWERfb9JrQrDP6D8IR+9ljg3mblE8LHac+nryf9kbdDIk28TqJjkK7orIq9BCvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rz9zp9i3;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90067606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90067606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rz9zp9i3
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso79857a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793742434; x=1794347234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gslbebf1LMvPLM8Q5E/+GJDx3HzrVAFeNFBvrSeRD3A=;
        b=Rz9zp9i32GrLsqYq1Wv4k+MOEXRHkge1QpJ7C6/aNofnyPzJwsED2mBJ+BO36t2Hut
         U/X3EX/P4yEQJBoeXN5o24QnyrjGOEkzSU+wtx5SH/xuFKBlH+Cty7/2p2y+FTtjgmls
         7I7QCjDZfxEAhev/iKP3MQSpbIsLV8Ph/6Q+DPR/n0huTq4GXHNbcfILEA1X4NPlfLj2
         ND391PjSxTHj0exOiD1aylibkcBR08bsztmT24DXhejY8LZmDn5tUiL/cjmU17IMgXiy
         Yh3kpGdUO96yk7UD5JPAXXx4ItoLfJNwcyTu4xlyq02RpXu59D1Buwn7SqITNQ1GbrHI
         y5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742434; x=1794347234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gslbebf1LMvPLM8Q5E/+GJDx3HzrVAFeNFBvrSeRD3A=;
        b=sCO4qFcutLBWH/XrGmkFfCmSO2iEMss9fEfAaNGVsnf7YbrIoKZRa30TKb2yAoIbhR
         h373KBnTXiqZc8tPRZZKVlRh5dC+T3HOK2IPYYOGaANAtN1GsC59CMVsQYKmOzU86Q/r
         jmHirwyFRzIKgo8lyWppX3oKQQ0DtkHEQZCjU86jp5Jhz+VqLnLS8pTJpj+eEiLDgADm
         AMNQ1OAGZnz8NqqMoAWtrbgzR7WDrgdmU+BJJ14+rzFLn6PENauYNa8EGdI6hSzRCfHo
         lPuEyfTcbOvVD47f7TxGO7hFCQGDaKi6dlSmu0hme3bcu3m++MbiFC6nrFhrjgHWEhoi
         kW3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwD2VLtGKY8lmA1Vn4XHsmkmL1oxfCjowOawyunKQSq5vNUjIEFDrgZJ1Td1o+GRsQaxWs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t3StI9Vxr1lViL8Bsjhu7trkjwVB4defjG40Ow8YwkF3S+mja
	O30tWbkpD8O3TJkJoLoOALgGCuZrMCqc5/BwmlGml+8iaRlHi4WSTsNqWEgeb2YdX88=
X-Gm-Gg: AYBFou08P87h8fbTLBuvyPnUPefTs5wrAWvC6cPZjvWyHiPmZ1oZ2/zIjwtbOBTBu/S
	i87iIdfd4ZUXynUVyfYTN8i99pu6PNu62JBngEr6aDNQbUU+xindQLbGWgHaPQRfdM1ADzA3fmQ
	DoFLuddOslz41+OQcfHcltXkek9m6yYSyL52M7g9r/orDAWnJLRVzMN18TKb21J2/IyALevkr88
	3F10zI10LHzKqhPopTpxO/vmexAKIioYp406Rk+dgY66qZKYSbhtCkEyN/fEfA3kGPPOjHQklTg
	kwZbxN+OPDAcC+6YmhtNJLGLfP8vKltaIzrIJk/J1rZYtVEqbzJQSSDY8HV4smqlYOAIPgIO6VB
	3jlr8WKL+oaIjp+s71NTDhYLaDzNnKEqj+jkDdYrzY7GFtcnMMxbLoV29iKIUxqikXb2CVnFa+z
	RUK+p/oXJ8x5419W95K1F3jx1A4UDrXAIK4ksINqQf60+T5+GIoPIN5JDi04ouscA338eo7+bLw
	TXswr7A1GgLN8WRcOSBQ0/UPF1qSZ0bXpITj/wXbXDZnpyQTt0xFoGYva7bBav+xmCvWRh/E38C
	oCEilbMcCsDDrgs6GU252v+7DdpkRbpZ1yFHrK1We7AnErsjmZ2F6duXSdjcI60=
X-Received: by 2002:a17:90b:584c:b0:3ac:fe93:a731 with SMTP id 98e67ed59e1d1-3ae8981e640mr10608128a91.56.1793742434015;
        Tue, 03 Nov 2026 13:47:14 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm12790312a91.4.2026.11.03.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:47:12 -0800 (PST)
Date: Tue, 3 Nov 2026 13:47:11 -0800
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
Message-ID: <aupWXwkFZIQi7Mae@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:01AM -0800, Breno Leitao wrote:
> sockopt_expand_out() grows the output iterator up to INT_MAX, but the
> MCAST_MSFILTER getters converted by the next two patches rewind it with
> iov_iter_revert() once they know the real reply size. iov_iter_revert()
> refuses to unroll past MAX_RW_COUNT:
> 
> 	if (WARN_ON(unroll > MAX_RW_COUNT))
> 		return;
> 
> MAX_RW_COUNT is INT_MAX rounded down to a page boundary, so a caller
> that expands into the (MAX_RW_COUNT, INT_MAX] range and then reverts
> hits that WARN_ON, and the iterator is left where it was instead of
> rewound. So does a caller whose optlen already covers such a size.
> 
> Cap the size at MAX_RW_COUNT instead, before the early return for an
> optlen that already covers it, so a size that could never be reverted
> later is rejected up front.
> 
> Sashiko found this while reviewing the conversions.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/net.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
