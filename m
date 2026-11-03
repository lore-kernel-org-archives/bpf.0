Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742313;
	b=384ILLrSAF2ZzXoD5M8JePky2pMRp5oZZ0140d7B+0WQzrHyRM4bXyKq5CHPGzKSZ762
	 JP7pyJSCvECPXiYu/JPEbT2GiMgqkaFrV6kbtnapfnUqhqRQ22VihSRnQ2nyzcI6aZrbp
	 ILP39RcT2Wby6MjwaSzN6iKBchI6HpMT7KuPcZpVn5Z9mLRF7A9L4nB6SGikyKR/yGbC1
	 QG+TO5Mr0eyrNJcB/hj700T+L0EaGrqyfmvgWH2I38BSK+ZaBbx3rA+BVxo/xYpvMTY+6
	 JF8vZdDT3zYg0nO0y6iSXv7K9j4JyDnBOrQOaTEL37GmcejbVIVSRhtSTxUroLxO+Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O+avdGunSth2prLtklqUzo2JveavBUeum6ierbVZfg4=;
	b=szZzwHRx2vBgc+4C/2gHGgsZ/8sIZguUEpCXGaYzcLCzOlkw6+5S2GmiXDd5UZoKwTCl
	 yuq4O/kj8aq2r9ai3EgbfvkAYiQj9E3gB2dKWuHrttOyK7+xr+Otij41WlA9xjBhg28p+
	 REb8zLM2Tbld4SDTC3MyIbsZWb7mgskidH3sbU+QXHz+C2Hupq2xLzOdEajhar7UPkRo1
	 RI7ddqfzDXwdqnAJ+SB9PQd4JPZvfEfHHMoWFALUk4YxZqBRmUq8+dJg4qmd68UnxhmqD
	 xNWPy0zmbnUoTjLwv6JnzKXde0kW1Zk/7gZ3epnKcFJ2zkwtmFgNlk/OVJAyd9wC5eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pta7O0Fb;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47969606A33D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47969606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pta7O0Fb
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc147d86bebso852851a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793742306; x=1794347106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+avdGunSth2prLtklqUzo2JveavBUeum6ierbVZfg4=;
        b=Pta7O0Fbv8w0e8LBRL1im8Q6uNXDtuEJIxVyW5IqEevEXa+Q1M2ZkaaA8t6UYpT/uw
         j6upPM7yggUu5MMTieBus01I0J/3rgB+FvADMK/lys9TM3/oMUmJU0EoE1M/YKS9bAkP
         ISauA7l/y2UUh8NGwfoNpwt2LAfyPUKaeujslHc8RY0xU69v+vhnbiUbOiYjJA7z8kJB
         wPOYTLpIiabkHMcH178CcxVm/XgnaP0yc0zA2r6+gCN79DmEYq3UmNCnPyPFxYy+Zgx9
         ifVZos1Aj3UFvx+jEGhuuiMiMiCbX0jbubaUh4+J+qQrc6launIT8JRbUYdte1xVv5Rp
         vOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742306; x=1794347106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O+avdGunSth2prLtklqUzo2JveavBUeum6ierbVZfg4=;
        b=2EB5wyQldCIvSiXTXszPy3p9WtxuAR5klv6dmnqDulG4FZ6C7O40B6Ng2EdH8NQVXU
         AX1wL+CCeL1a/U7Ye3xedlVzsp/37PTy25xwfeSJKwwzshZH8VcCCyFv+IFlVTPF9S6S
         9Ig/sPilnLzKDs0QbFXL/oHox+D6eTps6d0Lq++8qZ8yFLH2b5HTKGdVY/oqJaoIsQwj
         Omp3Yg0UmoOfibtegVtFfWvuN0iD6W+HfmOZqK09rdp2Vs7k5G52EnQqt1FASJrAQ2aE
         Ur8aBOwa1Lf0FfoyWJBHmWHgof0I0RvGioCm8Cu39AbxjDnLmFv6x/++S8nXw4tNci/G
         Ctwg==
X-Forwarded-Encrypted: i=1; AKwUvByr4Yjmt7tsK6+jxxNw3Yyp3eC1YVBdPJ9Vf3nO92WQIp4gARFv9ig+/Bfkocbtn6UsX0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AiHC0I63DKnd614zkzE9g3yWYMflBpWh2D5qti9NVlCLBJG9y
	REsXd+1y5fxVEFcWu5LyveofI6pDNsCMa200tYJ8HDfJlGhh56YLMS0hZRYB6v9Ncps=
X-Gm-Gg: AYBFou0UrNkOjNPD7V+IsdAOO/H/AjP1alTaPvnyu6EBGdc0bGaLy2DtYFmtUefvrUO
	mnCHCUza4ryppSGJsFG6fUIILhLFYktfrtn2m9+WJDNmJ7nUceS6dMFDrHcz8zYMF7pYtim1Spy
	z36G2uiPgliRYahaJg/OqcI/QyShywuuPbccs9gIS6pJqdeUU0hxIW95d+bEnkfuKLYTC4SXElN
	LXiJ9KWv0hn8XPaXb2TwPKZJfKMk5OHZzRLIN8m2kV2inS1sQF78vMzrK3UvUfaxzBsD/GSPCfH
	Xh7Vd0kM+T99oZIUCnGqE0e29ltsm8I23+34hmG3wmUngnlqKtpVGvBRPnQMVba4pMlNcFFAo9b
	ae6+uw73MdOcfT4OnGHgfWLjMeGdYcfydZQkZoj6WFC4s1V2gYW6Uqor5OqhSmNr2MZrIdCBLc1
	ovIuOQK96L+AaduSzTpV7WJvN24be+4tw7yYWpTo+gR2EOLET9LzeosLCtmB/0wm3REYBP63BHy
	n1liDIq0NypBU2Wjxg3Jj5M7Jhwid7NNHglrEWQAj83tEfvBOOuFC5w4Lxv6bJMCcaNoWpVcD9S
	0/Z/qRocwr/Ds401cCTv2UtCQ3Q1l+Pd60wjvHm32nbxwC4mAD+tQqvYiMizsdI=
X-Received: by 2002:a05:6a21:3991:b0:3de:71c4:a22b with SMTP id adf61e73a8af0-3e928634704mr8781404637.1.1793742306503;
        Tue, 03 Nov 2026 13:45:06 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b65fcf5sm120759b3a.41.2026.11.03.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:45:05 -0800 (PST)
Date: Tue, 3 Nov 2026 13:45:05 -0800
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
Subject: Re: [PATCH net-next v4 1/7] ipv6: treat a negative optlen as 4 in
 do_ipv6_getsockopt()
Message-ID: <aupV4R2eAVlgupXZ@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-1-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-1-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:00AM -0800, Breno Leitao wrote:
> do_ipv6_getsockopt() reads optlen into an int and never checks its
> sign. Most of what consumes len compares it as unsigned, so a negative
> optlen reads as a huge buffer, and the reply depends on the option.
> 
> The int options clamp it to their own size:
> 
> 	len = min_t(unsigned int, sizeof(int), len);
> 
> so getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
> answers 4 bytes and reports 4, rather than failing.
> 
> The other options see a huge buffer. The sticky options reply with
> their whole header, IPV6_2292PKTOPTIONS writes every pending control
> message without a limit, and IPV6_PATHMTU and IPV6_FLOWLABEL_MGR pass
> their length check.
> 
> do_ip_getsockopt() rejects a negative optlen, but doing that here would
> turn a call that works today into an error for a caller that passes an
> uninitialized length. Answer it as 4, as the int options do, for every
> option this function handles itself.
> 
> That leaves the int options as they are. The sticky headers are cut to
> 4 bytes, IPV6_2292PKTOPTIONS gets a 4 byte control buffer, and
> IPV6_PATHMTU and IPV6_FLOWLABEL_MGR fail with -EINVAL, as they do for
> any other undersized buffer.
> 
> MRT6_* is dispatched earlier and keeps rejecting a negative optlen, and
> the netfilter fallback still sees the caller's value.
> 
> This changes what callers that pass a negative length see. It is a
> behaviour change, not a fix, so there is no Fixes: tag.
> 
> The conversion of this function to sockopt_t builds its buffers from
> optlen, which the standard helpers reject when negative, so the answer
> has to be settled before that.
> 
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ipv6_sockglue.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>
