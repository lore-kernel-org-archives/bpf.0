Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795115213;
	b=azulQWpuljXNg0zSXTzVeUXeyMR3vQb6wMNkl+Z4Pi6lTgDLZfsNVpj2EEf8uZO84fZH
	 wbiBiqBD6aP/Q+57L6zB7k1aIBq714vTPFF45YH8MmHGrqltMZRqHDzPkVv5AugrScd4a
	 n1QK11/DRbTioga9Ur/GKo00osOrOk4pUC+2QuYW5n5FW5f+1If7/NkcQOogwUFNhAGTG
	 4f36AcymSJDlJ9QEZLOeYkVZihw726zX0IG8EOn/BiJIVMbCvrZ+WZ7EStp6AeKWXI2oY
	 weFuJAs/ys9idLplI5BwFITZ+h3rne3V09oEqfzuzLyHXVuJD/2gfQB1ReX6CCJO8iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=7UOIM1gt/HSVdU/4mq+KVCxj8c2UYFHGAIGtG4eIqGw=;
	b=FpH3AHCC5a1j3OQAEh373k0Bq71olcY9hQB1pTDRAmNblhjYA7eUrY0bMIWQxDoy7DKg
	 MBn74CxyEIp0xGD2LdkHzTLYrTOc1YBmDsKVlb8sDPjBRkvQSgti4I0qz8PhPW3+rbUmE
	 /GXhU8O37nbEYUAYOkutN1i5e7uq8L+oCRRk36YKxr2fQVB3QnaCAgAXS/bqmqHOa3soe
	 AZpdCFdUdujEOySrlex7ldFMAHzQf2bvdbBbOr4MA5L7x6BMFhtI8gRWWv8kB2CWVjyXU
	 ZLN1KH3a2KXt/C5mAscl8wSqc4PwqMBchqqXqK8TWF8K2lI8ctIGwGSRAcq9jQQbDMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=FBS35DIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAA606A334
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 19:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31DAA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=FBS35DIl
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJJ17lK3036427
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:06:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=7UOIM1gt/HS
	VdU/4mq+KVCxj8c2UYFHGAIGtG4eIqGw=; b=FBS35DIlYfrNJvTrsnesOsZXjHu
	lShjNbOKcW+4QM1K1aoLTP70qi5tI7RMA2vJwjdT6wVGEM7qbKX7TUCyPn8NYLdN
	w/Nmgi7S2w/MYm2sVSnArpTHYuEgihfprYzgxh5FAlxnM/HsEAdC+iDwpQq8j91D
	5DK3IC6Dq31TEkxovREk9wTM61Ha2trluzl8SPTq3cr+nOiKpROIb3P0l+g+1hNI
	smTrP6XALq2srV1GF94pDR8lBaW/PKZS8xaGmG9b1Y7jfx5W/ycFnN2Xpwp1lGoY
	cjMfYJ9bQqoSqzD9oUEWt7ktQ7AHIi2ub6t9g2Aqv8VWarmC2C4NrUY8Bhg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j21b93fvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:06:52 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb96533adfso46563a12.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795115212; cv=none;
        d=google.com; s=arc-20260327;
        b=j1168T/5uWTI1s6Q3jJjhWpwVRYCo7Q8zIU0eb6G5ej131R86F1uOcGEmtHRTV0RSb
         8cchAUqmZQDsAtU1uZtN+aYzEdIxibbCcfOlB95pd2iRqkPnNvOpe6yZNm1IduxLFBfd
         +wnE12kzj9bym2SHep6h8yCC3D6D2Dq9K5CnWAfmxdF8Gg21sNIvfxCvMeeYYgg9V1lQ
         SWDy0DmEAwHi7aSU/hPN89A+lIvZ0uSs+im0rgK90yH4z++78739UOUSWPN3g9TDay+a
         Lb26H19i+fa/DUXOL4xbtWtnDPzN5MyD1xlN0e1dBug1KN1lLx6j02IShpe9APZaoLod
         y1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=7UOIM1gt/HSVdU/4mq+KVCxj8c2UYFHGAIGtG4eIqGw=;
        fh=zFMp1b3GB3Y2kPAP1aJjzHPrS0ZijN1TDx2CdbxvsZE=;
        b=HvjLET1HdVI4noaG6/35f6fzx991LOxopkEwCxvFGoMZFU776tfzGsARB0dAkhvkdc
         OOoAST8KMM2IcE1J0VyExr6dNfqXB+8cYj8PDxOkAmYzLYn2J/DaFWP0kIuWgySUoQnp
         PaJVFGayZluJp9S3FpEKSEXSFq449rwJI40NKNyKjNB8VGqY1BZ6+F1n+pR5SsO1mylB
         hBaS+iSXRK9eLn16jXEqVQ+bK7OM+opdEp2zPsg31cMBnnCt2AdPrCeXwcFjM4BwJ2zP
         Z/n03yhCr8ZPwSJ5ETPsvNCCuC5/EfKGhZtX3bVBnuWweflPVxgg9eSS3WUzwEZfaLUa
         GG6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115212; x=1795720012;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7UOIM1gt/HSVdU/4mq+KVCxj8c2UYFHGAIGtG4eIqGw=;
        b=C0taOe4KwCsf6x+qHIeArBoVbFdOxhfsD1kSH0uif7JpuGlcIykmnIeJtsnf/c64KN
         ATTY5Vl6PVQpqDSOPtJGSehuGRaKMuE8fP4FrSAWxxArldo5we52iiPEAfhbTDWE9yaD
         RY8N0hy4mLscXLdJZVulMXU0e5qnLg5V8rOBFl1Llz8WGVQRUjDjoSQ0mFSdNG0I59xc
         tI/8GCv42/Kli675IL8eQN9bPxYc8N0lHrWQj8oCqikvI1oJ/nNOSlB83K8jNOV+H7A+
         S+m7EvcGTjgnN+fPnRDAinqqZWVAVhg2PZWODvahG1WYmWNG6sneQXi8blUlpgcvQK8t
         qboQ==
X-Forwarded-Encrypted: i=1; AL+hErHcGoarUHmDbEvgOG7+PoQoF8E27N+pVkalbupcdEwWh9qeXGPINbOWV3OT0b5VVPwVGQc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6TyL1oGhICMbcb95lhr1Yv/5KrlVm+RDE/+oJvGPRDON9xjQ9
	0ChHWGalSaQQALoPzvg+OjQPuTKlXl9bRxR6Miq/G8rik1eXuHtSxF/V0WqTU8ay9VGHqFjKJ+y
	//xfl8ISVHic9c3g1sVqZ1iP2GPCiLPTC7w9EEt1EhF4QAzw/M86pDEw/UtkE5oYkA935YrHPeu
	2NLRf1Aa9Jisqd8es1jtHqMMtU23Y=
X-Gm-Gg: AZFdTZeXe9WDKZ1qSASejEVFhCy9gt1DwR4iy+OvRamAKFXsGymg2dHF1OzhR3Vrqp9
	uWmI86TSUOPQu0WKGyT6SvtA+MCl+QpmYyFDJHnG5sZ0xSOqs/k8KVeiBljdmQ/0UCc09Yf0zdL
	bg3Kws6k0UcqlxJq6An+x6fFgNWMqB8SqiephpFLu3YU/zWVm6j2I9njg+CTpXKho12ie7D3bUA
	mYaEMjT785C1Xt25Ukhee/n6KhsBatV
X-Received: by 2002:a17:90b:4a06:b0:3a4:9dd7:296f with SMTP id 98e67ed59e1d1-3b41caec8a1mr251299a91.40.1795115211592;
        Thu, 19 Nov 2026 11:06:51 -0800 (PST)
X-Received: by 2002:a17:90b:4a06:b0:3a4:9dd7:296f with SMTP id
 98e67ed59e1d1-3b41caec8a1mr251262a91.40.1795115211062; Thu, 19 Nov 2026
 11:06:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113185553.171059-1-toddfreed@meta.com> <20261113185553.171059-2-toddfreed@meta.com>
 <20261118182729.21bcf5f5@kernel.org>
In-Reply-To: <20261118182729.21bcf5f5@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 19 Nov 2026 11:06:40 -0800
X-Gm-Features: AclHuK8MIg7IMlCLvugp4MxnFKNBhzqTy9e8on9cRpXBj8Das6tgcuB0baaIcl4
Message-ID: <CADh2yMx3Fw+Xe3E-hwj_bBMG8Cy_0N8-XfoTZXSxDcQgaSgxuA@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: act_mirred: don't send decrypted skbs
 from egress to ingress
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Wei Wang <weiwan@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Boris Pismenny <borisp@nvidia.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=QJf91QLL c=1 sm=1 tr=0 ts=6aff48cc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=jjTLAEkg5ClW6PfqSUgA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: GJxKn1ryAn0nr9HbtfGU-h6RuymUwbm4
X-Proofpoint-GUID: GJxKn1ryAn0nr9HbtfGU-h6RuymUwbm4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX28E6b3ccKNjj
 4VzKcrdksZWCRcvU5CqMiSquAON0Spld+V+3y5YBxWiHy8ntz94CSPrieMpi8W9crxuDkaWDBWP
 ksiDgGL6BTzJLh+IwoULWtvQyGwig6M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3NSBTYWx0ZWRfX7QgLYu0G+MgK
 wlD36Fk/+8oA7CkrD92Z40rVS2GodvxNgNkk/Hu9zhOsmdEPyW8Eok6ifW35wgP78MSFE1JnTFe
 RTP/dRZaKZG0jqZuK82yxMTieJ1ybB4A0Qr2eLt7O03m+Htdy0XFPEK2gAIB0HTUD/z/7FGKLhD
 olEoIelkHL/YM3V4PEC/mLjFdAYoYpQteV1z6LJGMosLmcDX3RpI4Cj4n4W1gTOs0CoSE7yTilj
 wI6HWdQBBhpKk0vhEuxP7gTg222pzOZr1BWkvDp6N2x1QSvwyPEKognfts5fylzKckOqm8Cl9zI
 6FnsmH3yomnYUwDjNPWY5aq0zocn1zWsJsMZXTwZU/0Tq0iMQowc53smTTk0cm2s6v6ubBjfe5w
 Zodrqz86qQhhg1U4VjtsnDbhHfk5BTVCNXQeVUjca16lgEIh0q7B6zkfr/JLhq7Z70UeAORISas
 EnPWMZmOHRFvi6vPq7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01

> > A packet which mirred redirects or mirrors from egress to ingress keeps
> > the bit. On ingress, it then claims to have been decrypted by the device,
> > although it was never encrypted, and its payload, which was to be
> > encrypted before leaving the host, could then be forwarded in cleartext.
>
> I don't get it, TBH. The bit says the data is in cleartext, and as you
> flag we can't forget that. But my understanding was that the only thing
> we have to guarantee about such packet is that never _leaves the host_
> as clear text. Within the host it is clear text, whether its coming in
> or going out. Can you ELI5 what the problem is?

Ok, redirect from egress to ingress can't leak clear text onto the
network. I will drop the mirred and bpf patches.

The clear text leaks have all been fixed in other ways in the net and nf-next
series (extension headers, fragmentation, icmp quoting). This part is
not needed.

-Todd
