Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794955619;
	b=cc1tXZlwgHKqSjzRBWa5MbWFwy7ovaezo1fKDD8HUAcdb5DdigHAL04M8mIXuRPUHPOQ
	 8GCxX1JCtyZ5u04Cdabfq4JhHiK6hyy/4M60peaCKwUjalcSeSxeFRDqNl+QGkOkTuN2/
	 R00NLxvlJ3K4lUgu4g/oNIbdX/7Mo5vA8OFmET6Z2d1go7e8gUSbsleCxcjLIJdtzQwcx
	 PI8ZG/6XDSz+zLOdKDbkzB5oQ0lzKORfUKJNRR98pR/Ui2bp8cyn1GTQRTVHn7+mQYhwk
	 FBZKOCPzU/lI6uv+i7D5LSsz164INosrNlfzlN8T3Lp8a12xTtAGUcxbHsWSzVz8/dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=KSC81XL1+EQpdKzjuyxfAuAaB+et2a6UKZ6CLWHqjqw=;
	b=FREaWbsK8wVfsSYwt1FyrezIm9jKQxSij32/q38HwlyVPJsLMWGEwkoLJVNW9YibM9yD
	 SXuVo2OjCqSpYq4jHHvMGyN2g9eHOzZ0+ctWNaSPN8uvm0eWY5wGMazCxucBX0Fxl/EWd
	 Di/24XvHqWjCKy90XeXSteeiay9xYvP1PBMXm/EFHIAFS8ei9H6y3rjqsNR3uErHNJD5x
	 Vl0P1Njvu19qdBuIHYvfR2QZ0GZVlxhuToUtMWNFQw4lGLe0VRux68cov8f155CztXDb9
	 iowBXEKqv2xI+X+dqdRYBiLp/VeTzWosLrs2K69elITSAs2UzsqPZAx/thoXhHPQy1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OpD+6PDM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF44606A331
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF44606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OpD+6PDM
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMfYDS1270727
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:46:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=KSC81XL1+EQ
	pdKzjuyxfAuAaB+et2a6UKZ6CLWHqjqw=; b=OpD+6PDMlyRVIQ4gUsxd1pQRiiY
	2xNljoVElEeEhFUiOG5Uk44VLPG4O4uXpXj0+j4jeDetx+c0P8e+noxSYq2lCh5W
	KHejIzt/I4UdTJmzw+Fg/nSj7cB1QTMx/l3bO+xrP+TSeATVVrDxWTZVHibCW5U+
	hjOQG+u9uC1e2kybz2OaCsXrkrsDWl9/U/SGRqGmJY0vG7rKiLXndtlvel7lQl55
	sdjYVggRIUMT42oLfV5wteJXfkuV+1P3ib3Fp4ylW8JJJGpvlzjjnP6mzY9S0HdJ
	AQ9e8xf/1KwJnz4XcYTaX6HmGdSH8UZ30qmpl1eTP9PIAKGbfG22H6j3L9Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu5g3fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:46:58 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so171808a91.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794955617; cv=none;
        d=google.com; s=arc-20260327;
        b=dsUHse1wQP9AyFoYnY1BQgaw6clHRhqW22Eyxla60mEYiMab0j1DI9d2oiGUy9e4NJ
         vfUgXvnSs9t14dz/xHRZQRv4rVw2YByeoLtbe/BWsPvCmY3FpHe0nFeDQXKNfbEe3LlU
         oAiYXSN/TO7kTA6fWpmlUfrfGTwwIt05XdKQthjnBfzopfHgMwtMFpVTeCoxT87oLgLN
         vyBPVC9+qCwrCBnbd+Rn94TWy79pDDHqnCeSjq2ctFrRIzSJUdIRztqCSQX2VkUg0t2v
         m++BuuNvomzZ+yC3C3rEI+5JKQI0js8hsqJZomViOABWcZCCztzypgnSSI6AGIJ6kTh9
         QSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=KSC81XL1+EQpdKzjuyxfAuAaB+et2a6UKZ6CLWHqjqw=;
        fh=DLGwU2d8h8yEo/kfKTb/fKqM9qEpa8j5u7OwK8HBkrw=;
        b=p7CRvBpXWpphfpVq4yS/t6zx7Qf+YgRl6Pwebv1lXG+2T8qjZzLy90AYPg5tYJzz64
         9BekZdmEYlxO50vmeX05zP/y9/KOtaQxa6mZvIoIz8LQ2QTI7NJlLJ5nEdSwg04sRpoO
         352ZJMUDc5Rcyx99cnO3f+dQaW9RE/Wqy3hOcgvijfA9Pglxl0qvZK7rWaJ4S5CYmtJb
         GqEMFrzfOmT3bIJvlyc2HGr8EatPwwq312GfN5QbfY4OOlLbJWljwzY8w2aUWa9nmRAr
         hBO2L8mIic0QUYLVK245iCaD+78wfCQmvdWCoO0pxXAFeCeURzX0/wCONbPM1JhSMttK
         7mAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955617; x=1795560417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KSC81XL1+EQpdKzjuyxfAuAaB+et2a6UKZ6CLWHqjqw=;
        b=lDt6VR11WmOZSHQIR/ayGdNi7xGLQMztuyDDNN3Vy9ADErj96iDSqpjswiQ4JtvDMT
         jcmu7iForwokr2L7mk/VmdBAaWsl0F4Wyi0W30PcMFMfZO/HKnhKeCJjrJtcypbkMY1/
         eBvk4eMn6PBTcd/KHFqW0CA0TuQ2vjNlk0Tt94es6016hafCccT/uYA9likDRInffaXP
         cUmAwn05qERVuN0cIbZqnsRxI/FSSFx/TNrROZBLishm7Hxe9z3nrx3CD0SoerIUCLSE
         gDJQDj7tXWlH4PvB/k5cdsdf+F5uzR6Kt90rVjnjv4TKd4XTr4PtzA0chF82oPyLdxI7
         o5aw==
X-Forwarded-Encrypted: i=1; AL+hErG+cI+SkMp2yPl3VCVEWgULnc2bk4PLpFQBDDaNTylNH0CuuF8GhnvKRrVBKBuL2LioMSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fEtELxDBaiM47DLll7jOd8q699XPXYugoxEtMFQ+dYeqyP3bP
	S80uJP9JhmhRlfEIKnaz/oU3UOQyf4azMhsTNpU8/O6zAyNHlOwp+W0OmbdApScxFKAsfI1ig9+
	E9t+YrsDxvkB+xFrbDy3vN0nRYJULHBf7EOXO7FmgOG2JodXu5msR47cdtF6JO6jvOd0thz1zP7
	NP9dSLDv6zrrCdQWv32qNUm0nlcdQ=
X-Gm-Gg: AZFdTZc0h1YPpqHQ1XUL4tLTYFfTawte4BehZ6Cw5FBmwj51rxU6rbVV/jho2F3XTjr
	0mEvwCx7YpiC4jSCYE7sNxHd13QWhFpdmAkvIfu8IJEC4h/KxvTFMj5wvLwu/+QQ9rFU0d2A8uk
	QDBX9YvCoAJgT4ZfQheq/P07H5tGJicfcfL9cyfwCYumZjDbGw+d5KX3ByDJNf3P5+knPZkbya6
	Lt80GkTD3NW20NTF3JwfluFC+r/QQ9Hho1Ch5/nFMdG395HhQE=
X-Received: by 2002:a17:90b:2fc8:b0:3b3:c3b9:7de6 with SMTP id 98e67ed59e1d1-3b3d07a212dmr710202a91.13.1794955617388;
        Tue, 17 Nov 2026 14:46:57 -0800 (PST)
X-Received: by 2002:a17:90b:2fc8:b0:3b3:c3b9:7de6 with SMTP id
 98e67ed59e1d1-3b3d07a212dmr710167a91.13.1794955616819; Tue, 17 Nov 2026
 14:46:56 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-10-toddfreed@meta.com> <179471270451.2199510.14795764193886368841@kernel.org>
In-Reply-To: <179471270451.2199510.14795764193886368841@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:46:45 -0800
X-Gm-Features: AclHuK_60Rb9y_3QFrgeQGfRKqUkPpfoiUhcDbbJP8UTYE_KV9Woof2OdSMKaMY
Message-ID: <CADh2yMwGN64zEVedBhYbMDcsyPjSJ90tyPz7evJ6x7B9pAk3TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 09/15] net/sched: add act_psp for psp
 transport mode
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
        bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        daniel.zahka@gmail.com, donald.hunter@gmail.com, edumazet@kernel.org,
        kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
        john.fastabend@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
        saeedm@nvidia.com, horms@kernel.org, tariqt@nvidia.com,
        weiwan@google.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MCBTYWx0ZWRfX7Zf1AkQIXUfW
 +CvtqKVT5+agUaLiWUMSIIZ0+8SOS4/r/eutX2n1HiH1d2MhUQEfunH1MQ4hch0Upl6Yz7JWUa9
 jbG5AFoqnvDMDzpRfwypeZn6E1Yl7Ss=
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6afcd962 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=DHOIGP5XwAi4GC-hQCcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: lo_S6_FjscW-DLkVhxDgXQPjfIUwbSbr
X-Proofpoint-GUID: lo_S6_FjscW-DLkVhxDgXQPjfIUwbSbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MCBTYWx0ZWRfX8Lh7dDrJXFGE
 sb+4kt0ifJLkRB/U4jCS1dLd6guTSCbhEJDvBQYXIbQz2jeu1QfuGLeDOLEvWt2s3mS6ir2h8kg
 49CuCe+v3IbVTlSbDaameJ2k64l2EylC5BeQmNyv6K4dGxEhyTJ114DrCRgO82v36L6pQK3cohQ
 xuBxdgPK7/bOIA0HF+wdiJesKiFkOXfST/72L7fL/MbTGbBEwqM1BCTIEXsAujHHNuKmuh3pb+5
 FZBjkBPhddeDmezt7u6yBl2f8Ab03CUdbs8rwFP64v86RLO24xue58xRczDazBkpt9g5wxjltsK
 PJ4SlSLZMvvBv3W6qICKPd5j0+sT1RGQYrez61VePiAh+I3M7fshymG97p7lVAefj64HivBkSw0
 pMBj4P6t4YdF+gzLE78PlejXtjn0N2REmVjwRjSCAIlw7BVwfovX/GnLwCKDAdaPcxtswSrQ8Sm
 K2vugDEJgoRKnb69nOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

> [Severity: Medium]
> Can the METADATA_PSP dst and skb->decrypted get separated after this
> point?
>
> The commit message relies on skb->decrypted as the backstop: "on egress,
> encap sets skb->decrypted, so that sk_validate_xmit_skb() drops the packet
> if it loses the METADATA_PSP dst on the way". The egress to ingress guards
> in mirred and bpf also check only the decrypted bit:
>
> One path where this happens, on a non-PSP netdev's clsact egress:
>
>   act_ct (defrag, sets tc_skb_cb(skb)->mru)
>   -> psp encap (the reassembled packet is not a fragment, so it is accepted)
>   -> mirred egress redirect to the PSP netdev
>
> tcf_dev_queue_xmit()
>   sch_frag_xmit_hook()
>     sch_fragment()
>       ip_do_fragment(net, skb->sk, skb, sch_frag_xmit)
>
> sch_frag_xmit() then puts the original dst back on each fragment:
>
>         __skb_dst_copy(skb, data->dst);
>
> As a result, every fragment carries the association but has
> decrypted == 0.

The fragment path is handled by "net: don't fragment decrypted skbs" in the
net series,

https://lore.kernel.org/netdev/20261117203137.804424-4-toddfreed@meta.com

This causes the skbs to simply be dropped instead of being fragmented.

> Would it make sense to do one or more of the following?
>
> - propagate decrypted in ip_copy_metadata() and ip6_copy_metadata()

Conceptually it makes sense. But because of the fix above, that would be
dead code. Furthermore, they still couldn't be sent. skbs which are to be
encrypted on tx (ktls, psp) need the L4 header, and non-initial fragments
do not have it.

> - also test skb_psp_md() in the mirred/bpf guards and in the cleartext
>   backstop
>
> - have decap refuse packets that carry a METADATA_PSP dst

In both cases, these guards would be dead code.There's no way for these
to happen once the fragment path is closed.

-Todd
