Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746916;
	b=ZS5Nda2jVh9xesiu7gtqvXe8LWjVlgyFzO2kKFBVLWGeBOC5ImbZbQMHCVLDmYXMnYl4
	 FpNEmbY6BYZ8rThvnGkiqfq/sxmRMqnazN1edlIkOyk1IAE6yAj//NygTwRs+HXlAN7ZN
	 HQlrlLP73TweAIdyY8i4x5lA4ZNhdM7xlSd6sN3HFHb5SsMDISmgNaURStZ5JIUDv3Pkq
	 AFpyBM1iRbrIgoR+Ip8iRHHiUiO+Yp2oxpBTgj5wOEUi658puhmZY6WqUDVoIs6VhmwPw
	 d5gyiWFXRjunmZgUs+IeGcFGJybSh+pfBhP6+14fbRKrgjxxi+YEvJHtjIe7s59OUuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1y+XljbojQ8RmFRrqF3tIyG5Meo4CmUH1v4mswRS22o=;
	b=yK45R+OBBKyGWGpbeo9ucntwdJa/CDJb+66T7/v6vkkQ1CoV5YHmKs4tj4in9I2oEyL0
	 VTYuuLBLySLRRkuA6yf6NC6W5F34GsbUpeFhxGqcTmVDSQktvWX+xKoXcHIcUAuIrr6eH
	 GoI+nnQj8yYhPapSwgMYNeuCgZSjuRokQUEOJYXvN5DSep/sR48Lbmi9ORDFPc0jhnHJS
	 4FC2TsuWIbplLX2bNVcRfQLZPSn0fSo0AA7St4uFWcIA3c6snWf600kAYg4qG+VzkzNev
	 LWs183MlW5+u+K99i1wAvpPtpZbUZDDK0FS1JxLGP3lyqTwLvzyP0R7O7CGpRbGKZzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ejRuknpl;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D620606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D620606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ejRuknpl
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a07078200fso58025b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793746915; x=1794351715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1y+XljbojQ8RmFRrqF3tIyG5Meo4CmUH1v4mswRS22o=;
        b=ejRuknplcXcfwh/9Pm+1q3vC/nC31j0L2g1hQblwJK5OkYf5XMNQaLwX98fSc4sKPS
         GlGaL7l6UB1isKdH4qlooC+Q7NTE/7R/+LK7iPuKGYZKvFhIFGKvch7/tJ9JAthzMqQL
         iaLieomJSBX4PqAFcgGvzCkJXF+dreeEghrYzYAGGxv1MsYwsMuDtVSR82SSyBtnpJeG
         8yasj4Bk3K207rozuo4ZDf4DHexrvySyZbWMt2T9enCtAByHAXrniLsAkIwHMYqNx6Jq
         nh98owGBBQTmXS16EiJEm2MuE8QXnSZGqCoqXCdtVja63JIZ+TQsOqu7RBjmdqK4JRkF
         PNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746915; x=1794351715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1y+XljbojQ8RmFRrqF3tIyG5Meo4CmUH1v4mswRS22o=;
        b=bk5+WDebn08SRUm/VNqucpGFwOaCZY5uv7kOvJiAf3o0nk/X3T9y2hRQNNtmAexJvf
         DJWYi1d8OsusQCbotK6QnySqKc2BPkVcj+xxzbKVD+a3cvImGlvsM5PrnSjCs192cf8Y
         9Dp+wRZOujNH9lQ8Q3BjiAq6Ne2YUqrKosot01uKTLS2vMjr5UxcOxc7CEcpuTbNw0N9
         CjvSg4BBac0zHoj6GhNi5hqV01InIBfTBixIDDQqlhVAGpG2FPJ85etxkUZ/0VZ7TkwC
         gd5Zlxa3Or5Y+Pm4Ru3cdXfgVQ1mICL+DAi3D9i6lc4Ykf8BRK0wd9aD8HVpGGMrZr0t
         dGGQ==
X-Forwarded-Encrypted: i=1; AKwUvByGTFfoumyqwC4EGV579sA9lxAI3ABwPJ1RGnOAbqekYxrcpWH8ggULTIZdd0YPb2X4Gow=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XBH2Cs0G2bARbgH5RTYjrqp4wSMgYyOzBj4swHZZtZliTTRpg
	0vFuYjNHEuihcf/Pfc+PRsDkUmISQO4HlMLjsfBbMsBLJ/qyDTHzSn+Tqe0pWV/dGxw=
X-Gm-Gg: AYBFou00Ws32DGTdMOuShmekOM0YPdu8po0kxa2aijNz9lKtfYdbpkE+M2uaVlub1k/
	YOU67Dx3u/nxBR5BGlU0O+5lqx21+NsWFkSRB4bIV7CFSSaiiuyzEd/SpghDVIeGGPJ+kl8uniR
	AXxIiNOBU1LIQvDRQU25Re6cP86aDnKD7Kh8N3e37wHrX3ryez0miwVjpbdXMBH/MFJ+X1Ar/BM
	3hl/s8CuEG2mnKI7kxZXEPE1Bu+Fraewb7gw+UsZbaK8bxRpSHy7WbjawqPukmbK9XxYK8fZWZj
	fMTra295O/ChcDGTpIzwHKi5PzyWi/ChEBo7XjiEAMOvkrF2wx9HsAs/owS9Uhbhp8bJqfK4CAj
	WLg1HDguOcwPRPQYZ3VY9cX3lAEurp/zjh0Ln2i3/XMiDzSPp2omh/aFkdxLd9Vamtg4iKT3J9l
	AXAYBjREno1qXvus0hQVB1S60snZi41staOEvm2xKT4OKRUN1XlNy87LOjhJ6RgBdCQiYd4HcYK
	OpdgYM9voAa/WvvGls6aODa8Hg3meq5R6WvRvT7icdv15STnhXyQ3VVshE2Y2Rx4g7TYmwKDlS0
	PC6+G7G3k28vVctCbPE5Q10FewHy6ppQMV5Y2TRx
X-Received: by 2002:a05:6a00:28cd:b0:8a0:4032:af85 with SMTP id d2e1a72fcca58-8a9b7916fcdmr12491838b3a.0.1793746914675;
        Tue, 03 Nov 2026 15:01:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b097fe108dsm161105b3a.6.2026.11.03.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:01:52 -0800 (PST)
Date: Tue, 3 Nov 2026 15:01:50 -0800
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
Subject: Re: [PATCH net-next v4 3/7] ipv6: mcast: convert ip6_mc_msfget() to
 sockopt_t
Message-ID: <aupn3m8q2oAKeQ59@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:02AM -0800, Breno Leitao wrote:
> MCAST_MSFILTER reads its reply through ip6_mc_msfget(), reached from
> do_ipv6_getsockopt() and from nowhere else. Convert it, and build the
> sockopt_t at the call site for as long as the caller still carries a
> sockptr_t pair.
> 
> optlen only has to cover the fixed part, and the real reply size comes
> from the gf_numsrc field inside it. Userspace relies on that, so
> sockopt_expand_out() grows optval past optlen, for a user address only
> and only far enough for the sources the socket has.
> 
> ip6_mc_msfget() now advances over the fixed part and writes the source
> list through iter_out. Its callers rewind by the reply length they
> already compute, which is exactly what the callee consumed, and land
> back where they used to write: offset 0 for the native reply, gf_fmode
> for the compat one.
> 
> ipv6_get_msfilter() and compat_ipv6_get_msfilter() only store *optlen
> after their own copy succeeds, so a copy failure can't report a
> changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
> caller's optlen word unchanged.
> 
> The old code stored *optlen before writing the fixed part, so an
> unwritable optlen word stopped the fixed part from being written. Now
> the fixed part is written first.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/ipv6.h       |  2 +-
>  net/ipv6/ipv6_sockglue.c | 64 ++++++++++++++++++++++++++++++++----------------
>  net/ipv6/mcast.c         | 19 +++++++++++---
>  3 files changed, 59 insertions(+), 26 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
