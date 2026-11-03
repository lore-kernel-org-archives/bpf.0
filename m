Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734403;
	b=K58nntyxpxh0E56o1VkJQpZ+o8MWTc45NGCiOxzp3ag0m/lNS4ijMM4JCgFXjnKedpkV
	 drfa8neHG2l5BTwkU/dEFFfe3kBob9jeOkR1ApVIDMQywK2EOIYE5zGq43GCckuyt+ghy
	 q7ubQFijSg1zQcDfJCCL1VNILPHf0laWT5JzX3ow1aKPk08dl/7pBrEVVRHaALOXfUMeQ
	 Hj0IBpLj88QcRRZhkVRwhMeCnBubadDujSdXiKLcGuvVhQ/HsYoaL9rvaUZy994vT3yzE
	 FI2Vs4ufsdRsApJKkLQR71rTvtLQ+CNQrp+u3hc0bwPfuas0viQ9f3GC3cz4pYmeZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+/+IILrbOopOCnLme60t9BvjxsRF8IeSCPeaXgfCLpA=;
	b=u2c7DDRSW7SkmLJUK8egYNNHnwIeXNLl2+xnXwkUr2QH+DG2uibNS31/o/aO2lqsmMPA
	 XfXc1NeqCR74Yoa40nTlNIq7kUM2CTEODSuOsHlNXvYkICFvfN/gtY/TFWHFD215QQmy1
	 tOHGUH0FyliNaRqutne7tFHKAG0qsuLG2nv79x7IK/0AE6WQkYB+vJYv2PcMzlv7zkkby
	 zbtyUjfskavCbt1s1mRZSLQi+sOztYsE9dO4YfEja3qWqeI5MxPr08QIr6szUaoDRrN4l
	 CZXBl8YyAC44CSLULLKaixM+Q64egDqCyUszYKXOuQRK2lKS1Lm7U1ejBtvtIqI4VVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLOlwJ3e;
	arc=none smtp.remote-ip=74.125.82.196
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F5606A32F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475F5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLOlwJ3e
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-35829219da8so1188148eec.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734402; x=1794339202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/+IILrbOopOCnLme60t9BvjxsRF8IeSCPeaXgfCLpA=;
        b=RLOlwJ3eELPPVZT985+ArtXPGXIAXSmgMhCqBjHZxWtFb81U4qfxqdHKO7E/nNFVxw
         +dWZuJUojEVNTMMSr5KEdRvo7Cu9/yOSG6ezN/5Mux3zoIBZJRn7HuQhmQO8cjEWuFcn
         7B+dr0mHGcivIrJbc2TbAHxL6fnVSWKdiqpw3dR1Ai+Z00xelMsZB+8oiopozrvxY48s
         NxMmo6tT1bUUPZsnVT3DXrh3kOutM6RWm/fJDNUWJLQl4zWtaRmAEs7cYVFHP1j6QNIw
         2TF9jiU4d9i/1vFgoS5Bbd1I/kcGnNAvVjYWdmt006xBeclMmbCc/J5GiG579Fx7M1wQ
         BcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734402; x=1794339202;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/+IILrbOopOCnLme60t9BvjxsRF8IeSCPeaXgfCLpA=;
        b=Ey5Zg+MvoIioscXScxIDNTDy1yAIJcLD/manzd1/1qYgkfYd7cwJgFPCt5G6dQG9ZM
         OnjPJzH/8jjwRFPn6RijKcIAQ4XibxAt5TD0wTNYISryM6cUjjXr0EfjGZPg+qUT0qwf
         Wv/PkF8VVjtjKIcmB5OX6xa1pcH5ozSyWmlD+dg2L+2uhlRdrwgSdkLtx/EBklYyi894
         +FwK7hxOvnKqItCToXe8jcvPG2/ngEDeC+2vXuPRUfyln+DGYuAbDL4DN3qKmAcEZ4I8
         bsHBRx7LVRWUECHe9ecneRACxEOZn7XgS/px/qbw44QGSCsLE/qCf8+eSA/VfrjLtkQc
         7dEw==
X-Forwarded-Encrypted: i=1; AKwUvBxjN7sgN9o8JbVWH+8JpZvCn8817gj8BC0eld94iuril9nRQUyPhecmq8Tefwfjs0DalOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J4B/NlE3L1DxWzbIVzf9Q5IP0mlIkmZgFpB1zNIpQpNnw+D8f
	BOGoZmhvN1C8EkXEuQPbYBO7eNRgkSwJ80+yI5pbYIGybm6GV2GErmRy
X-Gm-Gg: AYBFou0KGnGIgf4MkixbOMu2Ac4ZWne/GjCziol4N68iS5OCFxdrwreDwt+sY0lAWsv
	+86Hjisyd6H8murgpt7Dqv/l57Cs8aGGijfrMhMrUIB7JfvSKN406+c8DCWbSll0MFfzeSyI2KM
	DIbPt60vDisx4R0FkNVsNIB/phGFP+KtZw0nK8ZmRGRtNJ1DvzJtF3xw4WlaEyfv3z9fon7q3OZ
	2fiPIZqz9dquxGKUtWy+FVrHTwR0AccGG6/lRWVQB6PMDi2Hm+Ybi0+envgIStyh7PrLMoh+RNr
	VpmG4Vzs5+Ybk35s2RcaxRLfGim0lD631dWLE46hAGUptfN+m6Y0Hlvc+TAY3DhJcO5leuLycE5
	QG65CQzGO8KU0Jb8hwCbjgIeWTkR41SWwSm7A2VCqbcFHLH9TuN4nUp63+OglXXZ4kFqxsbVzNm
	W+kYtKHbeSUFP2JWpfY7fqPxy0FgdRl2T4th6/kghKt4UriUvglQw66ZM4xpKJK8bLBQmWjwuLH
	0zR91bOW5NzPmRcbG1N+YMqHAjdrlZISZrJGEGi+1tTTZbPKGWR9h5jx9sTUz4bUiMR485wxG/f
	yuAQmVjypu22SVV2w3kZLA==
X-Received: by 2002:a05:7300:f293:b0:361:a195:c46e with SMTP id 5a478bee46e88-36a2fd4c964mr24744916eec.1.1793734402208;
        Tue, 03 Nov 2026 11:33:22 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm238153eec.9.2026.11.03.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:33:21 -0800 (PST)
Date: Tue, 3 Nov 2026 11:32:10 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
Message-ID: <auo2s-G1DHiLK-hH@devvm16445.scu0.facebook.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>

On 11/03, Breno Leitao wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
