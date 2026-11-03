Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748773;
	b=eLresyELHLJ9brj1BrQYI9B3NDjMTFHpCK1gUQoLkD+0wrAFertw0KEIvzVVHey+Jiz0
	 ORLmK5MyN9qPhVopYrSdhFW6IXJVvLb1loMyFnjs4iLU/ZCeWMfEbVKvaYSZOGaXn3ZCB
	 AV+ogXIbgPoI58ezWPjyNIg/AfYo539XQ4ugPK6fqw3cE4hMLtTwEZOAlA7lErfj1aMNY
	 5nbXorGXDLZQ0B+NaR/DOMmfuyA2BfJ6/KhPhvGMzanDiydzxXNfWb2L/NF4rmXAZSrpv
	 PeTC+Lk3CEzjtlaggyx1L0fJsqRMI9DsvhHJcoxvdPtFQffuIeGBNlkzMhwN068/Zng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zku5BWLrJRdzbWUuQu8yNcvLZ9kOnl/61VOfHmMJqfU=;
	b=KsVb1PkqmCVGQffq4ab5PQ6PdI2XRCqoeu5IWjpV5Xk92LJUAumP3U8x+qunGDXFjFNP
	 O+AExP81U5FS3N3MloGDB1/J2b+Aj2JfG7mK+68FnvDTG/+Du3izgvARYyIycu29/ZmIs
	 n8wG4MYoVfmzeCLbbWgEGtXUAQmBzms1Hbzln/4/5cujadSkhFbjCJwbbK+YXNSMPgQAO
	 PjYNpNpV5EtuCQB5buBoEM5CLx0RCPN6iGWPO4E7MHZyX0PQvtv871g3ju6YoUWDVv5XH
	 B6+N3KwyW89C5AcDvw7ohcUz5IFtgTN8ZLK97mAapKZTFdMQm2zlvSkRWmN/iTAaYfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KAm9GhIv;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1835606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1835606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KAm9GhIv
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so128046a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793748772; x=1794353572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zku5BWLrJRdzbWUuQu8yNcvLZ9kOnl/61VOfHmMJqfU=;
        b=KAm9GhIvM1i3lQ09CP6GFl7b6KUngZUbIdfMCDVP8Wf6Dy63FBDa9vkG+6GSxV9tUI
         WoVuXlmyuu8mTEXG4dXlKdpE88vjFBSLFbYd7ddyTXWEnX5Row7dRvJ0IcIEs8QprX1n
         R0kYIwLZaqpi6zAySJPBGlDz6r3AnRwd5tt9I9Nx4nzobpA8PuifSRThpiGEdtritx8O
         x+2pPBOxnJkXR2G/YTun8ZoZC45aYX1aJi92PUgdu4DgvPSwhADCeqo2pYPiSZ6OFGGH
         VcsyWyoUFWBz7pGQ3H3gfJ3jTl439DsVVTAQzseRUNXoL03a8TyJyc40KM6t2Z1ThQ7d
         6P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748772; x=1794353572;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zku5BWLrJRdzbWUuQu8yNcvLZ9kOnl/61VOfHmMJqfU=;
        b=hbqtb3ltvbOABxaejliHV+ONhN8i/zKAMtmW0Pu3dacgggwG1FKiwduQWA390CnHMI
         R41lbj2awxZLh1bipSfoc3H/f9aEn1YS/1tXjZAXZaxaBSdgtDlslZhw05zYRGD+9uzl
         96DPj/oUkVOlf4ZwOJx3ZwScZ4vQu9nIeYxHRwzMZCALjC1ODNSpVh8QwWTj973k8Wpu
         6yJcQmgnDbcNq7wkMbVtnjhqPpt9icRdz15JEbHpkTHl/6FhANwwbm0CTp4iBJlI9zhl
         CA2IikvgsSG62wVaP/B+sUesuyOcHLNt8jvBjcyvG6pAhKg9N77MAdMb4DoU6Bhlx7f3
         vdlw==
X-Forwarded-Encrypted: i=1; AKwUvBx+IY7VcivYXrP4oPYnHaFaUZIEnCFmgo0rxFFf1A94juFCFM8udt2iUMut/TULoeRp/vg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rszRqM8LKc8Ol93DKBP39XNIXAU9ESIrpGe//Jx1eB9Rd7tBZ
	tIzI3kDdYp0POpHcXD7p4HF9W7SRthxIQGIKBKL1UkOth2QVxuyc6e4AdiS0BIQjZRM=
X-Gm-Gg: AYBFou33BKrDDyhen+k4MdBCD8DOI5MzHl8d9r142RR6EMLQQtnl3dXhSY78hfI+YR+
	KJBpYeP851fK+mXiJy1V0Q2qArg20s1PyD33ilLRCCT+zfDn/zBQkjd/Bwcf5tJVacK7oFVct6S
	h7wo7NsdIY42n3cBVDJ0lbf3q5bVV3ZFgBBB7z98XD0Bk7wceCzzCpHoNkg43dD4rLPM2ZL0CMs
	lXw2i1wlhwBNbvwxeKx1yupm/KOctkx0OrhWozz0/ig52alkbvfY/i/HK+URrJSOyG0+dmoN1EC
	PmxlSnMsCupI5GMLAe16Tc9X+FcRsiRhhM/R3c8FSE69B2gdJnIpTn2/LNReoTH4d2cgsSbFRc2
	fwbZuTwMAbDDbxo8lYFVAxBSjJg0DmkVvMXdciGtkePvX/ItD+VGJ8XQionVbGsutNz7cVxvmOE
	WFXnv8a3N47EAczwcOU4rYRkiECxOerAH6UFj0OjO9av9J5i8PIyxecEmS89z7cRmgcwCUsh9eE
	C70pFxRBAnv1ryXEEOk9PXRecJ6jy8wZUhesP9HBX8OJXyLcDb6Rq/09/6JLmZvYRwwklQO5z64
	XlDpWolqm7aDhO3msZVuywnPYWfqqHuwkOO0borfug==
X-Received: by 2002:a17:90b:3b85:b0:3ab:188b:c5b1 with SMTP id 98e67ed59e1d1-3ae897e4182mr12303028a91.56.1793748772265;
        Tue, 03 Nov 2026 15:32:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm6343342a91.8.2026.11.03.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:32:51 -0800 (PST)
Date: Tue, 3 Nov 2026 15:32:50 -0800
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
Subject: Re: [PATCH net-next v4 7/7] selftests: net: getsockopt_iter: cover
 ip and ipv6
Message-ID: <aupvIuOSQpv8nJ5F@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:06AM -0800, Breno Leitao wrote:
> Add an ip and an ipv6 fixture, pinning the returned length and errno
> across buffer sizes, the branches that answer empty, an unknown
> optname and the options dispatched before the switch. The clamp tests
> also compare the bytes copied back, not just the length.
> 
> SOL_IP answers a sub-int buffer with one byte where SOL_IPV6 clamps the
> int. IP_PKTOPTIONS and IPV6_2292PKTOPTIONS want a stream socket;
> MRT_*/MRT6_* want a raw one.
> 
> ipv6.pathmtu_negative_optlen pins the clamp of a negative optlen: taken
> as 4, it is too short for IPV6_PATHMTU and fails with -EINVAL, where it
> used to pass the length check and fail with -ENOTCONN.
> 
> Only the two hop-by-hop tests set IPV6_HOPOPTS, which needs
> CAP_NET_RAW, so the other ipv6 tests run unprivileged.
> 
> The MRT_*/MRT6_* tests skip on a missing /proc/net/ip_mr_vif or
> ip6_mr_vif, rather than on the ENOPROTOOPT the switch also answers for
> an unrelated regression. A kernel with CONFIG_IP_MROUTE or
> CONFIG_IPV6_MROUTE built in no longer hides that regression behind a
> skip.
> 
> The config fragment only had CONFIG_IPV6_MROUTE=y, so add
> CONFIG_IP_MROUTE=y for the ip test, and CONFIG_IP_MULTICAST=y, which
> IP_MROUTE depends on.
> 
> MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
> coexist with netinet/in.h here.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/net/config            |   2 +
>  tools/testing/selftests/net/getsockopt_iter.c | 372 ++++++++++++++++++++++++++
>  2 files changed, 374 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>
