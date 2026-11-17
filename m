Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953838;
	b=OMSzj4YTmS4yLva5vSzaAqmD84uV2a2C3EM7K1udx2MricHkv0ztt/2otqnN2qb+Bq3C
	 2ORbcXO/tfiU4WOr30RHqCEza2M4QT3wEX9kdJeOf1QvhNmgL1SzbmiEYxX9/7r3K6gLc
	 cKml9mvr2VGLmyoLK/FCkSX9t5LwE7En0f8e5dE5DGtk6Osbzp/q/U2kF/GrQQ6hGou5a
	 pr6Q9B85kY2NEDfAP4zc1+0e1/LqgZCCb+Wr6Mgvy2kjhDl2151D+WgUs4XTHZeu0UsFU
	 wH+tzHCM+6Iqzo6rF8OHKG8EnC62ZIaYTzje63vwFhR6ZfZ39T/dNJH3vrRckmESEaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953838;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=naIMYO16Tb2J0b8QTmQ8uSWyAJ0zbIqQUrNZeGUwwtw=;
	b=REvVrCIhRB41FlLi21mhk5LJUqOUIErmrD/3H6Fv90YrVx7N8KJPlc1+oadikPRmWMBB
	 AS2MiSXEgrWG8fd4vg5xYRfu2TaaZWw1frHJ7i/npWWmS+kOQLk10uyQWwPKD/y7XYdYP
	 q5ko4jP5HETQCKvlJbY9hx9E7deGNLGacRiIO4YHiafO6fVXwXm9zu/0dAhHAdWwo4e36
	 xBeE3Dv4/2oV7lBK/9j3GpGGmWywMUDI2M6w/N7WFdD0RjpiBWCEhIj9SgHANzJV+qBF0
	 0Bi4u8oLyFIpCNdYT4pK6wOzZrrJoMgfOmnZZmosmNqA1JQ8NOQLOjOxFUw2LM4c9lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=EvkMrAlm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676D606A338
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4676D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=EvkMrAlm
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHM2Fmq1934205
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:17:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=naIMYO16Tb2
	J0b8QTmQ8uSWyAJ0zbIqQUrNZeGUwwtw=; b=EvkMrAlmrDK8ub69Xg7pAjpcfhg
	bZmfLUAoEXVsHI582DX2XvH/l6wGABdG9omOSqhVscA/IEoGuPA0CuKpLQIwkQrd
	hBEyFCYOGEXtjyA8x3b0g3YTHTx/sHwE+cQmDTvaKvteMtyAtX6dmBfQkCozkLZf
	p22cxMmQsz7yD32uSvOi3HsnxIikFWp62dCypEtCz6SeWEqW8jjr10TkF5/Z4PeJ
	/8L+8tNnAtQ73AhwuAwiHeC+vacHLSuhs6/KyihzjSuZu88a3UB0O+P7RJ2pM+Pq
	VMyvbB/nLDYMAxlh+5ivYxFI1VuB1MRuJ0Byb/cV3VEMNBGlBCxo+Gavfxw==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0mn0xqah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:17:17 -0800 (PST)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso127069f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794953836; cv=none;
        d=google.com; s=arc-20260327;
        b=Vq4xiwRMIcn+8z8WyPjONOhaH5eAABA2ty6hmTH8M6lGDs9LYcLGE3JIvoXxjmTljn
         TtFpXfb6rYrWfF/UcSnEE2Q2AKgXIpWH0yp3UIuxlDdLR5JEMIPgwbDMnxRu5kJNsr0X
         pzprst4LJb02cAvN28FRbCJgg8irkiojbvxwhvxmtgElk6TIF8yyt94pI2IO46oZ9EIQ
         RH5P4dqMEQOiUSKV/oomGEeBEHJV/FTDXRa8vct4sroDH0bRGZlo7UaxpuChdgpzXv1W
         rej6jGDhG1ilxxBzukx0Igo45C8vPdeqRIirhUQUvuFa3/deXTq/ZHWiIgzGCxM/6ToJ
         JEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=naIMYO16Tb2J0b8QTmQ8uSWyAJ0zbIqQUrNZeGUwwtw=;
        fh=QU3BPhWp5f6QB3JTTPOR/WMF39wNieS9YxOxX5z4CFs=;
        b=Ck7pnFv1iwsrtSg+y1k2fEVPDD/d9guocEbkA2kDKQv4hgxgIlPL7+0YWSH3vw/BdW
         75qh0jjVWT2w3iHop3bSGN7WaisC1YoBlapb8G9QaR7aXfGw2GsaJBVymyOmGUtkSzbu
         /L4ZyFMDwRT2g2wcnO7xfzdhxYRxy9OFa5T55P+4B4zHOX3fM40rwTZaxk6QlB/pemMa
         VerUkQJWzAAV6rnuvzZ4g5dllNaIBLcU3VnR5lJ/K1131aIBiVmf3nrnhb8wRImoj1tM
         EuKMzfrMFaO63flfQ3jylMptU6Gf00rscQm10VLZqvJWMN4SBb+aePpMb5jWW9la5Qf5
         s0Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953836; x=1795558636;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=naIMYO16Tb2J0b8QTmQ8uSWyAJ0zbIqQUrNZeGUwwtw=;
        b=sGinVV4Xl1vTOemsJ8rs3L2LI/R3ESpKnPZYd/S7O4fO83MUdgn8DNu6nra4YcqFDR
         Yi37eAFSHqwLeavipBwGwvEbZX5cBgikk4ow3aBlCRhGheqY9+gi9zt+QIQxm80VjPfb
         XKui2srSwAsebZ0KT42gD3VjgdYIKtyjtm6G4sGL7826ybjbm1Egl0AHoVIPumaSUenm
         O2D0tj2t+pFv7hUxK0oO3N82qkELDBHVctm6f93QMStgllQ0TzaF+OZbrlRxdKEfsi3Q
         4gsf7meRL2lO5bijmzaFrGsykas0Q+8wEnY/vRkLZyy/qoQYCCLLhH0bXGlSVNsf8FFz
         g70w==
X-Forwarded-Encrypted: i=1; AL+hErH6IgsBE4OQTS/xho8CHpEWybJ4P7279xSbqmQte0ryp/11tgpDK/HKkYIIha8Z0U2IddU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ScJYFYAU97EG5JdXW86EQqpRqGjZrRU2Vbhk/VmQb0x34aM01
	XUe4BlsX2IwSU1lwe4XxLWGZlvB1y83ua6lbe1a2cdttkkMJZMPIwm/2U1cvMre1hpIcwi17W6R
	dMnI2mIRZUEam28CsPMeu8w/kkgME2LwGkpIlRF3hZS5nblu4nkX5PDtB8Pr0TwAhQg8pMzSUVD
	AV0A0+h204I2kOZR3YQVb5fnsvLJ8=
X-Gm-Gg: AZFdTZfji/85V4vVtM2t45dErS+Hzd2Y4vYrY6NvPBeJ3bCbn2TSAZyICrJyX/fg457
	bbPwkQHGasuvtXt0RU5GxtKTiHuhieruqOOY0JXJpmISQ/00ROrNQof3N6YbBlh0FNrT7XBfoy5
	/JAlU5a8xpluz635OXqfQM/+cZvkHsvCV6LbPbMISvCYUnuEhESrQxDZnMQFdU/vxQpx5Nk0+rx
	n/R9tVGgP0rlWmDDXlPbG6t1bMvfIuc9gFuZrbTuPnqJoPqWjw=
X-Received: by 2002:a05:6000:603:b0:48e:5eac:7e48 with SMTP id ffacd0b85a97d-4a63d2cf7f1mr1645580f8f.22.1794953835994;
        Tue, 17 Nov 2026 14:17:15 -0800 (PST)
X-Received: by 2002:a05:6000:603:b0:48e:5eac:7e48 with SMTP id
 ffacd0b85a97d-4a63d2cf7f1mr1645531f8f.22.1794953835465; Tue, 17 Nov 2026
 14:17:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-3-toddfreed@meta.com> <179471269307.2199510.1215468778950936295@kernel.org>
In-Reply-To: <179471269307.2199510.1215468778950936295@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:17:02 -0800
X-Gm-Features: Aa3M54r5Hu3045uljd3xO655IC2ADA2xeFtOm9g-Da5bBZKD676NvfeHASL2RN4
Message-ID: <CADh2yMznmWWJsh4ArEhrm2n9fG8i7o3u-kjLrvs_dwsBPiFvtw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/15] psp: take the psp nexthdr from the
 packet on encap
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfX1Wz4frXxq6hi
 c9VaT6T+cBlwMuCacj0m/831Z1+cwR0JVWJWbrfb8EdFPMpj0tcb6F2iYrvAbUZJZrb4JXhHBcK
 7Kr8G2x05h7ukunRIhwUqABSBm614P85lynUN65NfOxu6ONExNOmzPgNCFiuYesOppPDb113uGZ
 vNuLa86KaJ6tNG+wE4BpVHvnFfD+Bp3WqKdG/jmeKBta1Z2FGNfbiD2eCdoOaQRNQUqED8hmdyE
 yMhz162ksefS5aZsizd5SEMSnyYmL2VO5NSUOjZ7WaSjTsQLaLklB4LlUD6oopNhcnXQeAOD533
 FIdxbhwWZkJ+lcwV8mb5/hdz11wxPAEn7uOEvA5CC6ILx3pmSl4GgeIO2Lri2OCtR8BdSyolv85
 po+lx/IUjvLZp9PggPoF2owzbHdjsgLe649ny3yG7exKKvJDf5RmtRxi0kEIPP5Sg1/pXA2B4/A
 gJ6CZm75Il6H4aVqH+w==
X-Proofpoint-ORIG-GUID: h-ySkUhDZvUpZlBUGOKK6xwFf4-cVsyN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfX7h7AJygzvb9/
 2eoQNPeucF0KbkqbjMEoYpDIy8eNeCejwTPzZC9YkYgDqRjVLhUhZo/J/PU8eyXbxAXnTASLq0S
 MkDf1ofeuUdFBSL8rEsunW7aU1UQPjQ=
X-Authority-Analysis: v=2.4 cv=HcmB3SE8 c=1 sm=1 tr=0 ts=6afcd26d cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=-eSvoOO0VIkvbIxHXOgA:9 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22
X-Proofpoint-GUID: h-ySkUhDZvUpZlBUGOKK6xwFf4-cVsyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

> [Severity: Medium]
>
> psp_dev_encapsulate() now accepts non-TCP packets. Is the outer UDP
> source port selection in psp_write_headers() still correct when skb->sk
> is a UDP socket?
>
> ...
>
> Should the sk->sk_hash path be limited to TCP sockets, with other sockets
> falling back to udp_flow_src_port()?

Yep. v2 will only use sk_hash for TCP.

pw-bot: cr

-Todd
