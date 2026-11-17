Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794956107;
	b=go48Zl+8SDVPtn1wgC9dDzYzuF0RcViYEFyceNBnBTXL9tbjm2ZD46l0TI+bgxlhAY8r
	 Ckqb+m0IzqTlXMGWS0P8qUkrrvPOFTKfLTh6ZUnIrWOVNeJJH7jwQYDRghiUnyJExFBhS
	 HOaYny3W5UDejI44YlJHfId7dGIQy0H8L9VMkexyiABEYS76W3SAktIfDSQ/GeYMDiX1u
	 M87m8VK+R51pTbXWJnH/BTb2kpZzRyB26M8U5g9LCW7FTVYZcGKGqgQfukjkZTFrVa+2K
	 vgPkCjK+iAuGqP89xRj9PcVqGSrAYZ4Orb7ZSyl7cedTMREl5D+VbX3plOfl90FZiCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=XTWULvHY5M+9jFlLZATjLnhYmcapf/iX/XpM8N+MwzI=;
	b=Hw+o1UFQdiNS9YvSjS+L/86CJX6RL6b3ktWzYJe9dK5Iy5McQh24HG4B0y+MUxIvtq9R
	 LTjrqJyz0wo78+VhU/BvTEnTsgz/Ky46AqQxlwe232qjeaIJyM3Yb0dY28M1vFKCqyIlC
	 tkkrwGYFhxPFEYMPUsYSlGar3m63oLVWsYrzQ82IopMenJZau2GGacEuLTFIWl9F9sV+9
	 S2QQALfIvAzYhu6KCYDOSMCLm5+hE6LgBjA7nJhwWfTaNlYhzocdu13rDW4tjXsJWStMS
	 QQcKm5ym6GK6dS8j0YwECTtRcRhwIj2o+2+V8hAQkO911FaTGBTc3K+d6nlfF/CcQRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NPDWNUn6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2074606A32C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2074606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NPDWNUn6
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMgKYV667340
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:55:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=XTWULvHY5M+
	9jFlLZATjLnhYmcapf/iX/XpM8N+MwzI=; b=NPDWNUn628COc0atYZ/CbMaWxG+
	0TNGfxRCGsv1WrYANoIZaC+tKoYjD5X8kNmyXR8dpBZayuNDuuUCja+hWrjMqbQc
	XxkpdvsWiVArTT9UJfikfZbnelRb/DRpVlYgtxXFa3XtPyVF0540TWjYmvrsqO+P
	R+hi3LRmruY6Y/3r56HGQKoFy0CaepMpMmZG4klMBviT1U+1fEaeySnvKUF8n+Z1
	Wfi1IZWcGzocGnaz/SNYLQqLT3qgJR8XlBsQ+qKgyEYQQVpJE2NW3vnlCVKHFSdC
	M3nFonl+TButab+DN9Vmtl2UIUTzMNzzvKDIVO34G60V2AXaydz6Pdka2IA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yuj05a5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:55:05 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so224981a12.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794956105; cv=none;
        d=google.com; s=arc-20260327;
        b=QKLSqOOCK5PgmMjlC73QqwLDJAdgr8l931gGYxBfMJd8zEtvKVB2at1Dqy0PaypczX
         dVuTsTrrq2CT/SZl9O46zBrfdKlMPUWszQ2lhUA0w+Jz7sbk/w0SMunWp//Actnof2on
         2K8Ng2Ja5WlLRq0kRyCbNc6h2cMEFooOpwv0R+kuqGfIx1SLnMXQjKKL6KOlgenB6t1Z
         TrvKfXum+cR3x4wgYXkvQhhLAwyUEGFK8bD3McQgjJUHzIi/maIoN/T7bN5BQ2PtMNlu
         FXkJVy6VZzYXLSrM35OpmWTVwZoKXHfIegqPGSNNKx5Ys8wAIfxMOrQK8/IB+JyOAysv
         KJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=XTWULvHY5M+9jFlLZATjLnhYmcapf/iX/XpM8N+MwzI=;
        fh=bLBIlWeRzSDctK5HioFsgLj6Oj7IoObdmvfpfzw+g5U=;
        b=OiXdRNzWN8R0dCDsLJZkREVWTlMj9OLpm0WnXqhyHRiTOnK0YQKddSF8KdS4AQTL68
         NCk++2DDwj6nPUzykYR9CPCzSP6bsfSoD73NaLelK7JelTdXj9TSb9cO4PoJPpdDLfbb
         yuxoyMRi0fiZUAYAcJ+t9JV0EeU4VQy0Cil2+zmu/D5laudHRiP0SDV27oE7Qa7dvHOy
         thyETPxyA4yoYI34vb1xSoQywP+opk2llQ3Swud3ohOVZf0DmBFLsJtW9/TguFcPJUOt
         /RfNVc3CUXR3bq30Mbx1vOgPRzmLAudw9MDBcuVNbht2X+L8SAtAAMZ1ie61GgCDfRE7
         59WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956105; x=1795560905;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTWULvHY5M+9jFlLZATjLnhYmcapf/iX/XpM8N+MwzI=;
        b=oV+WQfjMnX9h6rzN+0Q2UUMsEv0GKac0YRhTGNT+3hD4NtY7wH0ppuYAa5JJ2nSXNr
         95+DzGg5F3rAUUAV4DP+9+XrmHBfnNPE2vRVGadJeoN0Y9RNrJBSSqET2umBDgqKfVMF
         dITj13kNR4FozsHLoHHtG3+hGocjq7Az2RMklICHr4UE5L6a88kMS+BAyfFTfEcdhiD7
         Pjyr5ND3s4TkuVoIjZjjItcFH17RWgDtblep957HKQEJf5KSTKh12BbE7KVYaMWAIpRS
         iiwUkP3SvYvkTZ4Mmmzd2YB1hcs3QRzyZdDkGsdvBU2y+eJc92ebB0z2D/nNwuutegG5
         Nl3g==
X-Forwarded-Encrypted: i=1; AL+hErF0JVskM+15ETBGQClZg5DMplPCkSvr54/A3AzddHdMu66lCZs5Sa17agrX+Bx3GARcE/E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qIbzLw2nlUxXyaPNciWQZRjkRxpzq6W+kmOVtjskvLx6djNVf
	0xrVyjd4LJP2H7Ry+4LyLgZ2oMAGCmU2jm4kEBtx+pj9+sdlywm5EPrZgixK8ccpeaUXTzDeUke
	b6n14Eq7BntIzxnnSVlievGwD1o3+9GbcREPh81xuWKCXyiD64DyGNfltQjWDRyRS+7GCGQw0Lc
	xyo8A37kLBw/eRgSGtYrihrqHwNlA=
X-Gm-Gg: AZFdTZdwyrfvDBW8gKgh+7TZ2dU1033BIG95ISzD10AVsGUv++JYAMGB6N1mUPqSKyG
	5MlGovSVO0w2vLsl9XDyOOoezccmv3Uqz/mUqfwhnLueBvs1Dk0UFZ/gz9J07fMhEsiJOefMkpt
	PRC2CBlRgGrAHPPYWOfkydNiHMy9+LdZirayyg6cmMZvr9YZYoPuhl7/s1L5g5LS+4hGi3DEVrj
	G7JYx3ztYUl5Wm+F/TyqgglneUzzKn3LjRElMQOWjlwCohul1o=
X-Received: by 2002:a17:90b:5390:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b3d0640f3bmr891151a91.6.1794956105122;
        Tue, 17 Nov 2026 14:55:05 -0800 (PST)
X-Received: by 2002:a17:90b:5390:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3b3d0640f3bmr891106a91.6.1794956104611; Tue, 17 Nov 2026
 14:55:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-11-toddfreed@meta.com> <179471270629.2199510.9480561958902023552@kernel.org>
In-Reply-To: <179471270629.2199510.9480561958902023552@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:54:52 -0800
X-Gm-Features: Aa3M54pEdqPp10DAjnIjgsYaaHWMRisY79HeZKYFQbRbnu5DENxcJuo9y0o8SvU
Message-ID: <CADh2yMxPrJZNtVdCgQWkHsKBk0cnAZ-0RiVaCMquQNSH8K32Mw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 10/15] net/sched: flower: add psp_spi,
 psp_ver, and psp_dev matches
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
X-Authority-Analysis: v=2.4 cv=TasDJhQh c=1 sm=1 tr=0 ts=6afcdb49 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=e8l9bKk9WhIOE85pT1MA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX5s8yzkEiF1T2
 XeynaJgDxaUzbyD9727llvjp7uZERzProLfpd0HvNV6YzMIZfEXUtoNkUgbX7APqaS9SvozfMKn
 IcSq005MQDSV0QEg6rQmGccUdp/DwHSQMK9+QymvuCITHI1509/uk0BoVYZlBE/VChVicdhDtho
 KKD6cQ4YB2pOr3LFc787UMWuv/ZSEkVQ4PZVapxVpvvpRuz7PZ3KM5zJR3ESM4x3yrxDiF2ZQcB
 E+XvkpN/5ZojqByg/BbGuH+XPzm6mQQP0DyOBTtuDa5zvzQrBL8RDsx3+eKQlmyDOHNPsh4ImUA
 RfR9D6espVOXESeAhkhcTcFpD6NTUFZBdnUfRSNjtQmVuiwMEncx99PoElgxDHSRneyeThlqqrG
 rHKIKx9j3i59yDbXpCXF1Hy+SnD5vljmZQxVddt+Q5GXkmZdltlg0md+jEZ9XyeyTQjQtxUdHLz
 iDhBxaya2P9djIvSUhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXwy8Dd2w721Cu
 ops3zMbO7k2LZ2KwJGAD7y2qMy2xmhzib0V6plNhnPqhnTzbN7Psp9GOrd1LgTbzwUWSLK8Raa4
 3nnsl9C1Ec5p+VrsgYxjLzN+8m0YDOU=
X-Proofpoint-ORIG-GUID: _MBO6UJ-otXenz1r--ihvmR8iaI474FU
X-Proofpoint-GUID: _MBO6UJ-otXenz1r--ihvmR8iaI474FU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

> [Severity: Medium]
> Does the commit message describe the right failure mode for rules that
> are still installed after two key rotations?
>
> The commit message says:
>
>   Together these matches tie a rule to one association, ...
>
> and:
>
>   this means that a rule matching packets that correspond to an rx
>   association which is stale (two rotations have passed), can still match.
>
> The "Socket-less associations" text that a later patch in this series
> adds to Documentation/networking/psp.rst has the same gap. It only says
> userspace should replace such rules before two rotations, and it repeats
> that the matches tie a decap rule to one Rx association. No later patch
> in the series adds a generation match or any enforcement.
>
> Could the commit message and the documentation say that a stale rule can
> end up matching a different association that reused the SPI, rather
> than the stale association itself?

In v2, there are no Rx associations. It will be more clear that matches tie a
rule to a SPI not to an association. And the reliance on userspace to replace
rules before that SPI could be re-used, will be further highlighted.

-Todd
