Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3338D01E
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324432; cv=none; b=iPcmINOkMSwSV9F/OAbgjCciebBKT03mqZbA8+9Naa0ou1JdKtbEoHnZfvFwnOMdz0/hRUnW1a3kw3oDPyyslObTQIVnnl8QwK4Fqcer00vm6GLmWIIaX9HNlabRrhrPzH0Cdi3bT5Fy3MG8nzpA2yvVQJAPV0TbobYJDuPaUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324432; c=relaxed/simple;
	bh=EOLOCxtm/7tf+uvqYzhNqaRYiUNGG4nK8T5C5LBV4WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1xM1B+2iT0SHGeyKQcYkv1t0WGs7vrSXShi/nkKCfQP10ZqpWENtDQDtr8oBlIePChfm+jabcBqyhsXX95Yx4Od+cCuOcZBtHgyWSEWA4JwOynuk23VHVq1NZpomJ/FTfsjQrM9dCBBGUhC2suc2ouMPlTNt5qihwZPEhuE7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfXur5ny; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfXur5ny"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a84a12aa97so587192a91.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324427; x=1791929227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=asaW3esXB7VA3zeulK04gS0Xy5AIFpiZvrmCwzQuisQ=;
        b=rfXur5ny9CGaGDA4CvhP+oD3lPy1pYL8J8a/7Rdv/fvHMcSMWtkHiY6KymFBMr2Wu/
         O2ISZvkDeAX04p7kqaytClF24bfieNxg1XP1YvOJQz6/k8L/BR6GXOmK4DY6l07/13FO
         qPHtMPRQd6nSutGM6cL2bf2FGIwFDWm/ahjxrX1NJr0ReM+cBhBh5JYpBjW0PWczY/vv
         5Uk8/anpPIl9KDnk5MEmj69NG6UxEU0PDAWElTsy0Vzq0H1Wx1BkRVmu74i029ozlr3p
         giW6RtkzXkXVb8m4B+7CNU73MU4YjCY4ty65vY7s13wd0V7vHFya6UTxb9OxmKP9IUP1
         rpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324427; x=1791929227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asaW3esXB7VA3zeulK04gS0Xy5AIFpiZvrmCwzQuisQ=;
        b=UC0q4y3wyoAl+n9/3+OebI+kqf5ubLg/jbuQLPAwDmDoNu4qeAfWxthOCYTLGRrle3
         1B45qzVOEmiXw3YzjPGiio02KHhbdP7FQIQvZKnCXWh7BZEnTDpwdjyPFCzRk0vLTOGP
         52G8/T2d5S6zb6t2tBE815ryGIQVKHSxWYkJFgNo36tMljSATpv6chj6ua10Wfxobp78
         D8/gMefYskZOs06t6zN24F3EYG9LLtOQirIuqtD/8xmfux/Y8YE4oiCpoPoOeGzdYSj2
         JQ+bUWhDl+l2h3Rhb4y/rbLdCYMeteXxxIh20fqLm8oWeebHFgqXspo6sSszMo/6lcb9
         qBIw==
X-Forwarded-Encrypted: i=1; AKwUvByYllu+63ZDYucCg45wWT1ITmOaHAHDBEkbUJSlQUcFgIAg7s+5jRfPo8KL9wStEAOFS3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+ZZGkHhjigj/XfF1fAQKPUNGIeJKsoGneLnR09k+O4n/EbXzj
	JAn23p0TQshl/G+PRjUKvV5U4Wwc68PypmSxZa7hZr14IaArWdy+g6N8
X-Gm-Gg: AYBFou0KOUvbAmzk/plV9usROpGUrtCHUAxqs4jmX+PNZUSHi8j5Op40ii1sXUWx4yC
	GJ2dtNUtRPtJkBaykZ2eqJB01+E4lMy1sMmGvThVsaqoqfmyRmZKqv9WaJMfbFKH7zoLzuEYfPs
	8ujr0Y0Bm3S0Hk2OqzMet/F11XWjDd7P2WW0A8Aq0CunuSdmgYGyX29ZNRd5Joj9ndtL98HIJq7
	3EshFq12aGag0QrJNQmXLwPV4aRDUvSjeO1XVvz3YfVi16gobX4JCbOpkfK4LKVcG8VpYiRloQZ
	Ph8jvFqaV3JVsWgwQ0FRWR5nvlS8OJas9hKPOkTaHfkacSw/cttz1zGZcUBZRPI24mGNrYDIafj
	JrRZwEClr8zw24w8TI+2oCEVTYcpKYiRIueKCYwE9nfjJ2FnVbv0um0WGM0NZxeP17ROYDsLHsD
	cBE9ZOJUL3AmEKE7aPFIKLRBjLaH0wHmPCdgYJRQqygFhyh8uzEsEJzCzZj8N7jKSc
X-Received: by 2002:a17:903:184b:b0:2df:a608:27d5 with SMTP id d9443c01a7336-2e6003b5d8cmr5405275ad.12.1791324427451;
        Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6044388adsm1656485ad.3.2026.10.06.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:05:11 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
Message-ID: <asVwke8PQ0fVDSm8@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-5-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> incoming / outgoing skb.
> 
> bpf_tcp_ops.rtt is called once per RTT, which is every
> incoming skb in ping-pong workloads like tcp_rr.
> 
> Even attaching NULL callbacks in the fast path hurts performance.
> 
> Let's guard them (and write_hdr_opt) with the new per-socket flags.
> 
> __bpf_tcp_ops_call() and bpf_tcp_ops_call_flag() are added to check
> cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first and avoid accessing
> tp->bpf_tcp_ops_flags when no bpf_tcp_ops is attached.
> 
> Note that bpf_tcp_ops_hdr_opt_len() has 3 callers and previously
> checked the static key both in tcp_established_options() and inside
> bpf_tcp_ops_call().  Now the static key is checked once at the
> beginning of bpf_tcp_ops_hdr_opt_len(), and the redundant check in
> tcp_established_options() is removed.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
