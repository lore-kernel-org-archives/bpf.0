Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747010;
	b=EOO+DfUnHSO99dtK1WUBLBceHTpgdBfxD/uAVM46bVhHlX/5oo+wgDGhSqEAF24lCUv6
	 AytnJkfhj4CdZ5ag2uM0PzEZbCRN5SvtUJztvJlAXiBxGygIaiQu72vl2KXgSjiERyV9k
	 TK7S3REvLoi7rczvxf18ETH0oQF5LDneaWdikjddg+n+S9fQgtBtn0atzWtF39Ao5LoOq
	 CND8cZF0NDn+XREnkzYjjjLdj4wMjjMFvcuOILtIoitgGJHT6f1ixld9l+MluhwaAi9uW
	 p6OM9rXw3KDlly92ABPvVxeZe/gbZilKIjLXm0/2p8uMfOWoYvdF+uYhMYplHo64qgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bc3q5OMwODprZ3tRrHE2dAObJscCTN7oqVxqSs9CQE0=;
	b=BqcUfJqN3etmkS3STgKIP9RZNtU72NC8DxERcljEcaVSly72g9qmG86MfFHxH+rX2v6K
	 sc0pltzS+/o2PSR8T/lWOZiXRqapCQ6+hzai+Iv2ZORLOz1RBsr2U6eiPuajK5/ms6plg
	 GmQgYn74xFHNdyB44ECh2jjdX8JVv5auU9fThJayLbRfhk2a8QqJqDp1dpXp/2TM8Llnd
	 6SsFasJgL0wSzhHuvIjzyMScxMBxWzqMZ9uI3sE4RxRpk92EevV8aE4ASv8NcNvLRjV/h
	 PTaJO+LziShdm7DIrjBtkpG7YBDwGd3JdFA/MTFpu1cv0CE1VvHFLZOoEo2a6huEbSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kpwSVOrl;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AD606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9AD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kpwSVOrl
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea138a3497so353855ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793747008; x=1794351808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bc3q5OMwODprZ3tRrHE2dAObJscCTN7oqVxqSs9CQE0=;
        b=kpwSVOrlE5nr+/Gbvw2ZwoGd5KDAngbKsPFGSFjG5uZDqDrVI+gLbg5Ff495N25ok1
         /MWhAAh4jBKMFUNyKUGu2YzW9+2b0TL8VX03ypiXw4ssVIJKJ8NdQIdG9nN2L86viunP
         0GQeIke56pCMcajWzsKXoEzb3qyZLHuNRs26ySYLuk5afWNHqc2hxHe5Kj87hslle2R9
         0HqfFeDQeQaCcAimFol3FR5VaxoRVhOlwEu6ZJ0LDsrXDvONJ+G5lXTb5IuudPJXXsHu
         iX2D7vhnsn0beYOgAG84IpsrPPkPEpqzt74z1aG7nR8CPk+sBemoQJWqRSQwhJAJ/2x4
         soxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747008; x=1794351808;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bc3q5OMwODprZ3tRrHE2dAObJscCTN7oqVxqSs9CQE0=;
        b=tYKOygqv1vTRrFuUB6voV0dMqLh6S3BWUIRY/lGxeJF2VRcml9iGKGPXwWfj7iufGt
         zsOKR05CleVSYCkf9Xxg+ndyeHkXFrw6Ihi5bv2o5BTshOLk6NPyplS+ndLybz2y/ajm
         vzItgunsYUB8E8dMjGFa4LtnSt/EtSYjNOEarccuDAOUiMjHZzP+37TMy3hJwnLVaLNY
         H0FTHFE7LyPqmja2MszWBc6gPjydQJ8lihedvDKPB77lIGWg5fi1hSl2oKoxVuPV7dbC
         t44p8nOTC+GIjiqmrsMnXLtw/NHX6ncNOw9oVtD/rHtkpJU2sw2bqRhKFbJKkLXqe5uc
         Sxgg==
X-Forwarded-Encrypted: i=1; AKwUvByiKyS5mCxzsjSbYomTK+POo4p97YLr8CRaTcl1zy4X95NUJW4W/3nLNXLU0532tRG+8d8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+X/AQ3Uxj3KsD6ZCIIpLpd70e+Vf5ngwuXq0JHohxCvEDEsQ7s
	YyQC/vxbCp8H8Ws7rzc/h/oi1gryy7tyDf434aGIA/HGKJMWDIvGkXdHkHl98bN/ZTM=
X-Gm-Gg: AYBFou1iVtvtBINVHpHNhIS3TBeTrui6sPGJINfQNxu9ttQDIqNx0L8gnMCaVD4+FO2
	joF7xGdQox5XsMh5OHC63kfLDH6lPMs3IVkaW1rXayVh4A5QwCzFNQArSzIxP6QLsRKpq/P+Hi8
	nJYyt9NtIqDT5f/vbxhmxlROkUFmNs0g6qxcPD6ynDkHwiTBDRjBylwUapxOZrDCdIxSrpJrZoc
	BWE9q3bE/OsRQweVoRHAzFHOhHQQzn7q2fO7HbJZK4D7RkWyflEZhLsdTRGmx7pCMuoXcR8T7Fw
	1BnvYiuJ8KX0cKmYSe7IMmt7sAQBGQZnLRQHaNGO5MiOw/RgnlWP/Bhz49yZ8S5VFJwr20Yrw6W
	a9Q22a8BlAXvW1NcIv54gjDvSh8KjvQxln3Mevvikj3+mqcqoZkn3QSnTjKebjja1h5F09JSC8Y
	Pfr6ujzJgq8l79FIevyGuVWPqO/leTGRyRnFh09jHSvV6bpS5TOFct5q7BEaTdlKTXnID0Tjuy6
	g44h7rm7ls6DZULDSZxw/BnePlHjOnYcPutgo+TUySmgmXi3xA3Iyo5FZJD0l6b44tdHRB+pscm
	ig98jRNIUb1b+JrqtQMzjav4N2x4SjmYY5SSANpisQ==
X-Received: by 2002:a17:903:1cc:b0:2e5:6158:b9c1 with SMTP id d9443c01a7336-2eb364e0730mr142081315ad.47.1793747008425;
        Tue, 03 Nov 2026 15:03:28 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091207dbsm301785ad.49.2026.11.03.15.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:03:26 -0800 (PST)
Date: Tue, 3 Nov 2026 15:03:25 -0800
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
Subject: Re: [PATCH net-next v4 4/7] ipv4: igmp: convert ip_mc_gsfget() to
 sockopt_t
Message-ID: <aupoPbQlx899hNir@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-4-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-4-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:03AM -0800, Breno Leitao wrote:
> MCAST_MSFILTER reads its reply through ip_mc_gsfget(), reached from
> do_ip_getsockopt() and from nowhere else. Convert it the same way as
> the ipv6 side, and build the sockopt_t at the call site for as long as
> the caller still carries a sockptr_t pair.
> 
> optlen here only has to cover the fixed part, and the real reply size
> comes from the gf_numsrc field inside it. This is nasty, but userspace
> relies on it, so sockopt_expand_out() preserves the same mechanism: it
> grows optval only for a user address, and only far enough for the
> sources the socket has.
> 
> ip_mc_gsfget() writes the source list, and its two callers write the
> fixed part afterwards, at the head of optval. iter_out only moves
> forward, so the callee advances over the fixed part rather than
> addressing each source by offset.
> 
> The callers then rewind. The reply length they already compute is
> exactly what the callee consumed, ss_offset plus the sources it wrote,
> so both land back where they used to write: offset 0 for the native
> reply, gf_fmode for the compat one. The bytes are the same.
> 
> ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter() only store
> *optlen after their own copy succeeds, so a copy failure can't report
> a changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
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
>  include/linux/igmp.h   |  2 +-
>  net/ipv4/igmp.c        | 20 +++++++++++++-----
>  net/ipv4/ip_sockglue.c | 57 +++++++++++++++++++++++++++++++-------------------
>  3 files changed, 52 insertions(+), 27 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
