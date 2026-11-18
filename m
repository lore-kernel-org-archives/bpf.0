Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029316;
	b=0YV3bMxG0Wy2dHjyFKrXhw/vYZ31LFdk1FA/UH06hFDjo5dgGAdsnnBVo+4BIUb8rfmq
	 WR2NzI89D/gz4P+Z8dq3dcz3fIHk+vkQRWx4gGlXplzee84OjU6WZfwDHKKZSxd9tS/PQ
	 AKwCVHbvjWfhGdlNC9dfc1wcQI9y8YMN7/vNUxJAa025AQsRVOzB8iAaWHgv0R7X6N1Bg
	 zQeS8oaOQuRv/Zf4KXYAFN0r6ghHfhJJAmHCSC4H5dm/CJf2ZIYAf+RrGGP1b2tEIsp0I
	 XWeorPJp057nmtbSVzsZG0yKuhnvGThLWXQRno5lH6GTl+ukPX9RPeDRNj4qPpgljGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029316;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=+xA+qBnR4DhGTpzy0NbqbmSwtcknsJxtpzKOLUxHJh8=;
	b=3lZFbj4X0QsnWNDZ9inz3VkqDB3+KV/4bX/5OCO2AvtJDJzJlxIUd3HPavBE6Y+/Pbuq
	 VvHTJ5YVgIdc2nzOX1SiTfVW4ejwBfL4FsLvGBvtrZNTokuOmXvFXFF2plDmKoGHZxEea
	 Naq3oCBhTKap7LU2iKKtv9tEAKKnStlY1qPiDAdjNZi3My7RwnOiKxqb9PsR5H6VkF/wT
	 3FZP/+Ma0PUQRtC3Y5zKKkeH8A9abWkPBTyx4uwPsMygjmXoQltZzTjbEzvt6wYdnv4ke
	 ylgQqluH+Iq1efJZzWIatuQSbJ4kBZrAwZkzW9tILfjxcYNceQkA/GciCyNGGLYdGog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CI0coo5M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CC606A33B
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 19:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8CC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CI0coo5M
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHGFow154178
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 11:15:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=+xA+qBnR4Dh
	GTpzy0NbqbmSwtcknsJxtpzKOLUxHJh8=; b=CI0coo5MCl6PeMetoQwNQwkRIbu
	JiJgmxit9cRt2nDJWrdAARftxPhoMHNyIVJskaAed9S2yJwVu7Ra0ZkweQuyB5yF
	guA6b+B7Ror/Ay/Qt7H0gVuOq2ynwudmNifTkBxQAYnk71ts4xr1AaSkk4W+eOa8
	idyTtCCV0m4sS5SbBYGeYAKxD77vl1xiK52a0aXDUovzXZHhLZIrtRdrfVhCe76Q
	12cyZpAXp16EprTl+WZPucOgkRXsuml9kXyb/gOq3sIF+GsDHZrnxqsx5q2OGKk9
	Lta3g/1SFu0Ht7eUlEGwKj9v2nyojzUDtpEBFE/6gMcWgBLoOUalALEMPcw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu8089y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 11:15:14 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a073778890so1226546b3a.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 11:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795029314; cv=none;
        d=google.com; s=arc-20260327;
        b=G2gkHd5PQM1TFdDBaPmfB3YqBeO3IMWk7rTwkGxG5FOsjg6QnnGl9uBwTyq2NCuPr6
         5/IDcQuPDhXPrIM0cC3chh32m/haVONJ/hypXRWgJU7wZW1uFKyQmstzRfk0ij5dGZcW
         1KHsO32YYe/rjdW46I8YKZ7Abrh1L/iOjleWby6IsfW+MXFZ7rkIR36bDt2DIFIMuzU0
         AFoMOy9zij+/wZ1iE+HKL9pgKm02keyHLO0tZK2xB2O8A3bspkRWDriw+ZyyUND/oVDS
         0RGq8m/yLlPIRic2t8z8Y9PxgkCtiC5sM2MlEfj0XnT4sFZ/92ex+kwUkGAXGWfmOavN
         gF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=+xA+qBnR4DhGTpzy0NbqbmSwtcknsJxtpzKOLUxHJh8=;
        fh=H3bCBAZkJlnW1xf1r3B5EWwOmA9EPybyOErH8kAcX4o=;
        b=C+GR3PPvA0t/zqZ1GLG3qKQElKW2QZ8RYwi8t0nD6jX7i9IWWlxC9V9Ao+CH19oP+p
         VegxECGbSA1MOP764A6ERLzb0VmHzCT5sHMIEYGkU+v5/0wRiipYQUauLW49ihwWBzKp
         Zo4FemO3GbbYNehMJXeeheXUW9/V9DxqlNMqiAvC8w+Q2hHuM7WFkioH0hcMoGXtTwmN
         qfOMN/jNeoFey6F/TG6smn6egYUzfhaJtgN1bH/I2K4Fj81aB6MdOK/xJESMNUhCBcMT
         KS0zCYwe2k3HrchfZc3bndY8sUHxMkh1WcW/EItSiuPwBf3uOV/jKsnt9GrvBC7EvO2o
         yudw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029314; x=1795634114;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+xA+qBnR4DhGTpzy0NbqbmSwtcknsJxtpzKOLUxHJh8=;
        b=ptVNqBwAzGL6QG+F6zB6/sZFYqEvkuYd2wRhDJYFBvbwRV5iU3XaBF6d5ZsUeDaE+4
         FX7frjLmlaW59hroHC+iANCzSMPGQGnkO0VMgmnOaKkmf6XTOIdcb89t7hNSdmuQUFae
         AOuMBeLHXRDPY8cn6rSdVbh0L5ohLU+cD8SPK7YlKwbniPhNDG6aPgzB7iCHguCfQI1t
         EEEDwFjy7LCT6zBqZrkZt+n7LlWEz2ATwdIJFg14YvplWcPVdCqTTuylWsTgFDjGpR8q
         4X6s0VUIjX/g+MneJCnnYJrlESnXk99OEOrUa1b14I6j3Ah84WzM87KHWeuSsPreqSE1
         D9RA==
X-Forwarded-Encrypted: i=1; AL+hErGfetPmL04sZbfKsgO9cb0qEdzdwztnWD5736q3AWwf5Fcb6njKqHx9jHGKMSQUGFrXRmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vjKxXE/29kn8klimvgxxhIovQy/QULKCN8netCMpHcAuwAPat
	apGZwsTFWt0ZMHB6lGSgPaserDAjaAw1QXpd0j/SA17cSeRb408mHcdTNC+GIrSAcCbmSawODbg
	qEOvYVMZ+pf6zI4Pysc2BJTCdJjZSHMH7w0hIq5I1BI8lCzucbPE1/rbqoHjLtHAcGm2o9f69Bu
	5mU9v8V0w6a5f/U9K6SSI5jJpDRMU=
X-Gm-Gg: AYBFou1f2m+Gkfmr4eSjqRjLeGnVF4RJRFEA4IEkEyUjIakZ9sCKt3CVyIbDHDzAVYt
	F2A6GhMdgnRAEE7wjNb5x5EknW1bDIIVh/RCDzRdR9ILDHpe92gB43uwYiWcD9ekNKOhwMOWScv
	0Y0l26VylbEU89wjOZqaTA70E5WaQGm8mwiFpWdNvlfb7d0fV03G9L9pebCOMQMCE3Y5uobegLL
	w1PIiydRegYzqrbP8bTCY9xYj58G7Wo
X-Received: by 2002:a05:6a00:32c7:b0:880:e4a7:b1aa with SMTP id d2e1a72fcca58-8c5d46deeffmr3344615b3a.55.1795029313732;
        Wed, 18 Nov 2026 11:15:13 -0800 (PST)
X-Received: by 2002:a05:6a00:32c7:b0:880:e4a7:b1aa with SMTP id
 d2e1a72fcca58-8c5d46deeffmr3344573b3a.55.1795029313133; Wed, 18 Nov 2026
 11:15:13 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-8-toddfreed@meta.com>
 <ea8a18e0-12cc-48e0-903e-325a8ece5a0f@iogearbox.net> <CADh2yMxffQ3cywT3aNg3SkVfog5CFnUSp34F1esyun-xUBVa9g@mail.gmail.com>
 <4d271539-b2f5-4fb9-a4dd-32becd02ce5e@iogearbox.net>
In-Reply-To: <4d271539-b2f5-4fb9-a4dd-32becd02ce5e@iogearbox.net>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 18 Nov 2026 11:15:02 -0800
X-Gm-Features: AclHuK-4R9Nf7O3FLY7hrUyXB1KdmwvUFFQk3aRrICEDQQcjmr2v5AAMDg1nX5s
Message-ID: <CADh2yMyo1VCNKC58oJiOLJ2NtGqAFQfxLY3iNbP5mtQhaFsR0g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 07/15] bpf: don't redirect decrypted skbs from
 egress to ingress
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: Eja3C0BlhlGb2CFRfx3mFjOMssWMz4BM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NSBTYWx0ZWRfX5/FUz69fnV88
 Tbj09X22u6u7fdrf+LTAE0BMV5SQRBDZ2H27kKeKVVM4Nz3hyvYtD4TaTbR5WiuZgmoXHxoE5xO
 wg4Ywaw7qqj3fPE7iHrrDTs1eI/Zl0Q=
X-Proofpoint-GUID: Eja3C0BlhlGb2CFRfx3mFjOMssWMz4BM
X-Authority-Analysis: v=2.4 cv=MvDHeGae c=1 sm=1 tr=0 ts=6afdf942 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=DIuMb9_t4Eg30DVr1XQA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NSBTYWx0ZWRfXyILuniTtSjQb
 EHY5GF/NO6IFXNpEpXxFoLucu9B/XPO+sjtoWsV57PzF9i8XSsw3cYteQaDcBe7ntwx1kPB+RXU
 nW+jCR621cD6hA++2IgZvLZow1+0Kj7XsaiTuHgC1aXTh1nQZAnSbPJ3omCqyJ3NCagn3mBtT9U
 zFnE8CbwrUWqDW+Q3WZG9vD+rKY9JXoQMkEQb15/LdX+Pv0awdwNbTWljKxq12byX86sgRhPtEJ
 czhoQDZbl4ZBLZoyUuzfgXvmwZTzZh8ZZALOnn8Iqm2QCD2lFjSEb+VHB0jAPrXHR8qGxVxeGRM
 SjLvDBelrbQfga/CIfEDldvHcXCqPJORSlgk8lN0xwaChHk2DcrvDzTdvTLwHkrsZT7wDHseB+C
 BIvJalfJsfCmYzhYW6pmDY2IhGezA7PV3rlXaJX19fsVMclTJny9XAaA7ensCsS2UrXLuAwFBeV
 ccbRftKeZseVXBPkCgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01

> But why under skb_do_redirect? I meant just here:
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 532405988fd9..ba112111de22 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2471,6 +2471,8 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
>
>          if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
>                  return -EINVAL;
> +       if (...cond...)
> +               return -EOPNOTSUPP;

Yep we are on the same page for this one.

>          /* BPF test infra's convert___skb_to_skb() can create type-less
>           * GSO packets. gso_features_check() will detect this as a bad
> @@ -2563,6 +2565,8 @@ BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
>          if (unlikely(!bpf_net_ctx_get() ||
>                       (flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL))))
>                  return TC_ACT_SHOT;
> +       if (...cond...)
> +               return TC_ACT_SHOT;

bpf_redirect() does not see the skb, so it can't check skb->decrypted.
After the program has returned TC_ACT_REDIRECT and
skb_do_redirect() is called, is the earliest point at which the policy
can be enforced.

-Todd
