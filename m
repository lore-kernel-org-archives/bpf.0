Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE004AA032
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055803; cv=none; b=Mse7Q9EruH4bGpJoo0PrGB8LOyXq7zfhodJN8Zd3Hac8j4f2GJ+yYeqTHv3brn8E8shsPPdWc5DF4OBdjiAgJewNlFYbdHKbsf1ENjDLOhNBZdPHmPMhHfdV67Coo00IvPodCuD5XJhTwNCsMj5qcfnoen65GxilaaYmbxONWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055803; c=relaxed/simple;
	bh=BxfaM4F67WwM0NDqetEAQZCaLbFSlZZpACf0QN9vrto=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cgIqZxRF+JlhkQbmcErQ3d5Upemqe4WpeFrxwk7fmYSf9XbwyK9K1+aUhpGwC9kHYAib0OWOa2jBu+/6LJeOA0faasv2FrFZK5P99WTcwYOd3RlMlV98a72/GRPYAOt2GH0d2TXopes9HvcA8xgW/BxtKucaTw1cZ3e+DF54nt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE4SV5Wh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE4SV5Wh"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f4e729368fso6688651a34.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789055800; x=1789660600; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BxfaM4F67WwM0NDqetEAQZCaLbFSlZZpACf0QN9vrto=;
        b=QE4SV5WhDEJjlYHcNJPNsmLuKQkVtwVZzwZnI0OH/LGuv3DtY9FbIx6Svaz8znBzu4
         /KwjX6BPKAcmlvl9LdlExg9Dy23HXYrDzAA8V46lF8tNH0DUIjxOlxhSf/v5e9om2j+R
         Lng/EWMj34a2IY4gNMHpkmYgEELfdTzH1odEjeay5QvvLYVg2jXJ+k0WlCWpPr++AYo1
         C8oHHyCLkFU1Vg33Uu5e6STyLDFnEXQC9VjxhpR+sj/V2A9cj6bw9uOOCN1//3sOyuFb
         wSn7IwPGXR0jxOyqydV7I1etWcn6b/5vpgLdLYivSV0nM83DdMFwDYJ1cvAbT1l32FfH
         9TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789055800; x=1789660600;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxfaM4F67WwM0NDqetEAQZCaLbFSlZZpACf0QN9vrto=;
        b=e/haXNGaU/r3hYJJtXk+1JUixTbPXPjf7bb2achV6tf44ILhh80cOE4bzENEfJ4QF9
         PA7Ltn8pPNoe7eK6FuN3I4rRRnQ9JWtMF7pbadq5usGvxyA1EE47FgJxs9mXqje0YXdj
         tfQlCwwaYcc5xlArNTFMwuTR3h9QJlUEwDsDRsSs4rLizrL9d2FBcNNK08zMTcXtgesI
         BAK7Bxd+0mA6hiI9prYZgOVnRnOrBiFNhc3nKDoQ7BjUrelXzPDmJFPOZgvRTPhW8N5L
         jwwqPLEjuR6T16WV3iDYKw6EBAFt+xmFmbqy834a211A61k1otjC/d30yfF+7Uwn91Ji
         XK0g==
X-Gm-Message-State: AFuF++mlEnPKEzenj9mg6dAQXbWoSsC1Xugjjrzd+LoFutqk/J8VA/iA
	DgY1MgU07sbbxQ6OPeKZxXJfTEIofeNwmGRnvU/EpHmrtQChV9xgNVRz
X-Gm-Gg: AYBFou1TB5yIW84KrKukg8pWu7YZj/tUgUk/EI4zgoxmA+lzsbp+pybH+id/VyE/DD/
	sk/AzBdmf2yEG0WTpk+R73Q8CA9rCi9xHG889Os8sOEeteunqXMWVsn7kgLgNT07w/BPIcA/lxj
	bPPR3SyhvrKvQanXk5ARI8cDXw0upbhqNo/wi/we2a8taSt37kCmQMqTa/gB0+iirqFJWO7137T
	0FR3mK7uEU+kOKOObzJBQReDE01DyBt2KjQc4qaLbVFg9403V4TORKHQ5hEIM9MWYYe/HlznLU3
	ZHa7xsb9EZ1xOKLloccvwrHSxxv2VTiKnUK7EUQbpW88fTLWU4g7z7PKKNTeqnrn8HBUtBYBapi
	4sszHJeVbeTGu6kI4kh/WJ4K+wajklQ+u0oHn4JPBxUkZbkaH76HutsOWvQR4D4xxB0/v0kmA5g
	KoxesPjIJ/lKVEs/MOBVD7xncJGoD/4ulT55KWOTPC5sGms//maRpkkASr0JFYwVuGaZoq294yV
	11KwxXPLQNc0fNbYu8BKCdqm+gUtdmZaE0dor2eWYNzOyf8IdjB5cDreT+eiPHDOw==
X-Received: by 2002:a05:6830:6d28:b0:7e9:e709:44f6 with SMTP id 46e09a7af769-7fa204ac614mr25634037a34.12.1789055799959;
        Thu, 10 Sep 2026 08:56:39 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fcc45d7852sm14684016a34.20.2026.09.10.08.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 08:56:37 -0700
Message-Id: <DLBRCN9O0MAE.9NCB79Y636SS@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, <netdev@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>
Cc: <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 00/14] skb extension for BPF metadata
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>

On Thu Sep 10, 2026 at 7:02 AM PDT, Jakub Sitnicki wrote:
>
> That said, as things stand we have already established in v1 [3] that for
> our existing use case - attaching metadata to <1% of skbs - the

so you'll be using this bpf_skb_ext only on <1% of skb-s ?
How about we add a bit in skb 'special_cleanup' or something.
If set it will trigger a new tracepoint during kfree_skb/consume_skb.=20
Then use bpf_rhashtable, populate when necessary, set bit,
attach to that new tracepoint and delete from rhash where key=3D=3Dskb.
bpf_rhash is specifically optimized for 8-byte keys.
I suspect it would be faster than this approach.

Overall this approach is fine from bpf perspective, but if it can be
done with 1 bit + tracepoint approach that would be better.
