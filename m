Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795135570;
	b=40uj9jYymeLbHBcCFWfDH7zxEgZBABbUBYrz2smrIrYcFIs7mGqhumhgRqQhgF0SRVvb
	 SQCIoKyZ6qeqjXXp7CiXgVB5DLdtKYj3y+7OrV0geGpSXRkDMSezgC7ihmMBt3mBtfFOt
	 vH5t3vOJSX0INm/NTRwY6SrtmTlNYVgSLk/LN7As/+3zp3MhagOHmUKnlh8pmHv7IshK3
	 WP/EU9HFPiatBvpAcyKyFpuguD9GJVr2hX2eVymRWVZepSvssRAvBrKLsr3KODayjUC9m
	 FRMqAdsyDTkJj8mxGUQ7Jv3rKCKYlTy1KkKr3Sevq/jiJ+4613tBiwzy6HzPyvRWPkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135570;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=0Wk1fOxDDLV4UZ+GtYR1Hq2j6HZ/VcU5vNNYnE2q0m8=;
	b=ME7ZUbDubUYmDXWgOvBxEt/r4Rlmlhi3xAnWeVmwoVEVp1dgTP0scqsfYYHYXrhMHiai
	 XuYFyDbL8w9pQvS+LlZnhdQDls1CZ5wPBAfSlNhrZClLiHEQ9JmuJD24gqNbqNvhQE7Nq
	 qRH9Xkq3k4UQEG7WEsZ3M5IPDwrwbfmMRxM6ACM1Z5BGVScbf2Gt74tEzKSizhKAkJSPr
	 HQUnn15cb0bf3CR9mBE7g50AcNyBaO7QnGq6pSKaEhPua6yTI7vpH+uZROFOb41Blr5ky
	 iLbS/nmsGFqVRAomqR1lMOhQxWEy4nLTvRc33OT7qpnV/HeSX7MU5EYh0mG8kuE9s8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NV6sU6jJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ACD606A325
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 00:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4ACD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NV6sU6jJ
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK0EmX03376770
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:46:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=0Wk1fOxDDLV
	4UZ+GtYR1Hq2j6HZ/VcU5vNNYnE2q0m8=; b=NV6sU6jJZ0mpnUMoIb+pL/HH7xK
	a3UwfYHXKTyMkhahfD417ja4OfWndYESuBDx66rnAVDwPlQLHoHTC+PUnUzHSyNg
	EB9BCAch75SL0RfF6TMsOX3rsu6ySgWFdV1qO1pjkotz9t14GvdoSy2B1VQ824cS
	I8U8XdHNz9p6hG55YvQrdcpQUsH2Ha5jOuqzB1secBKPU6nIK3jqLOhVT0CGQv/C
	dH1uV/DXEjr0ptmtWBbWrdSF0UEPWiDWP7Cu+3e0971fV6/i87OrBnt0iVKDTW+l
	Jnk+o5k/2+7A9//ciWeuLqSmYKAeNlyay0fLuty1auwFGXnBKk/YjVP44yw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j1vcxqwsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:46:08 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b97460a133so326150b3a.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:46:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795135568; cv=none;
        d=google.com; s=arc-20260327;
        b=qLvlEDELkjYxFd7x/nhIdbGET2KNAUi7FaHPcSmtLASMmkAOjQ6vBO7GousHLTxSEQ
         s50F3W+EKSiW6MOReQDPhG1vwRvb3gnku0HDTNMDSHgxInuQdyuzfNFWe/N39MW8oG09
         rtSgvqVb9BToF7l4FDq+famULKkTiq0lN9lfhB07VXV+EW7CY1MBozmIzPpWZYkHJGww
         Tar2d9LukhWskyq+kDFd/DY4oqmHB01McRW3FTo3WUCxfl4Gwjr/M1pW0AMCM0nbA6+h
         gg/42CVHE2SC01FPL1xN36Q1r4OS85m1kl1KVoboDPuos7yOlVJJ7/CCPCOSZxAyffbh
         k7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=0Wk1fOxDDLV4UZ+GtYR1Hq2j6HZ/VcU5vNNYnE2q0m8=;
        fh=zwJ4DxvFlOcDY9/V4ITq+k5sqyKE//ivFvgU1FfnEno=;
        b=ELriZlgq6n4UFTpt/tS9gUQkuxVqJ61oV44nwTC/JCjlQR2CS1gTK2F8yF5Hkdey92
         MS3Lasfxke9IquYJ6rIPRryOvWOVwozJGR0iP5eIdp32MjMbnzGdYlmMPtDeEebr2ekP
         RU57BOC82fpXX3DgonDSgMsf61SwbMtVphj7WVCoIfDEVnykXxNyzHYouzdrnL9VBJAe
         wnDq0GjEQ4xTY+tIgmIMN1p4MN0ani06hNkyFejkE6r0oxjiou34cLzYMbtW7H9ypqwB
         3bYsReEI2sr7QDTB1FvlNZGgeU8qCiZaVPXqiYn87DEmPJbqL7sLDh0+6lV91DIdES6p
         eI1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795135568; x=1795740368;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Wk1fOxDDLV4UZ+GtYR1Hq2j6HZ/VcU5vNNYnE2q0m8=;
        b=13rpmMn6tR78CEELjrSiOFbucfJGzXqDodfYiiV1t3axvaz98tkEZseu7FkZ/hiDp+
         nlFH94gPhIay7OepnT4WjqTnypFAd+ROm555BSbzBMuGyGBedG0zIAhTD1HYH7b9E18/
         Vg08l1jExpSMS4HrbgxPJCC+RAQSlmwqouNJvrXkChgeh38fPjA9o7eaX13szH+xwo7R
         fFjhxyVPCqSs6t5Kj8EtjIElu6YTtN2AmBLnlL9EzgailhvOqu5BcqFKFOvdpF+OU99C
         YSMEahcxwcesEGcnIHjZkmHoYowqLuJQE5idw/HsBUJGx4/xkbMQrxkYfOtH+jYNo93P
         9N5A==
X-Forwarded-Encrypted: i=1; AL+hErHye9wm4dFSv5XDi9HTe6J5UXw9HDWq+e9jOZmeyWaYmVa5HA7yoMZbLNWT12rfsBGhbyQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Fk3kejX46a+OpzffvYv9KqSIANhjShKyQtMMAL51Al9OfrGQf
	OOId7PQ2lsqsubnaGYT64xGe7KvcKxVR+1WLsvaiBmvGlIhCR8N/ay08r9d+7bSnX0LafyLN5oq
	vKjQjukTck7qi4s7EDLYDewt1XknCeWREtUtYZnhBckTDqB6iFKH18UtM6xgVXVT3oT+EoJZTiB
	HBlZzIdBWjKVZ9VPw44yvIyrFkECk=
X-Gm-Gg: AYBFou36QkOJ9cP8Mpr+kn49nwdQq5ZcLbF3RG+RPC69SIoZv99Y4/a2k9xRzL8kYJ7
	6XN0Z9uj2xkkata04aVx2UH9hKtW/U4a7xiCBmamlSW8DeDRnNZ1xU4BZlRq3UJovrLG3T0d4Eq
	WDUnAjMfb4KdB3e/oS7QX4VmBPakF5gqnWr8B5+0dW/nzQYqjwynBPMNQx2dpayIrYBshwhojr/
	ktsIEiS2tFaG2/J6GaSKgUngP3EjRMt
X-Received: by 2002:a05:6a00:8d6:b0:8b6:400d:7cc3 with SMTP id d2e1a72fcca58-8c87c67021bmr1122497b3a.27.1795135567603;
        Thu, 19 Nov 2026 16:46:07 -0800 (PST)
X-Received: by 2002:a05:6a00:8d6:b0:8b6:400d:7cc3 with SMTP id
 d2e1a72fcca58-8c87c67021bmr1122469b3a.27.1795135567119; Thu, 19 Nov 2026
 16:46:07 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117192411.247117-1-toddfreed@meta.com> <20261119162146.28229969@kernel.org>
In-Reply-To: <20261119162146.28229969@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 19 Nov 2026 16:45:55 -0800
X-Gm-Features: Aa3M54qP1YCQf7NpHxLxwgOH9sNuFK0oZ-H3E0wPLjIaO2Wa5zKJBx45I7vhaDw
Message-ID: <CADh2yMyEv46Ms1ne7rDWEJ6EFxQTe_OLnW4-TDCRSWusPoodVg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/3] net: don't redirect decrypted skbs to ingress,
 psp time-wait validator
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Wei Wang <weiwan@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Boris Pismenny <borisp@nvidia.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: 94-z2Hjdpfic0ufVGoo6VBSNSljmP0Wc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAwMiBTYWx0ZWRfX2oL6K9uOPdUq
 +nfqUiwzlUsBExUiG9m4p55D4xAW7T8N5TeeT2zCcdOYbKFdu/mhpUJrEmWTpfrZv5s4wCPy8Bw
 5T5N7afLsL9XmRmRXRkAiSpWnAgBWEY=
X-Proofpoint-ORIG-GUID: 94-z2Hjdpfic0ufVGoo6VBSNSljmP0Wc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAwMiBTYWx0ZWRfX/4r4i6nUjXuc
 ee6fSn+VGlAWBVNTESS+RQ7g4/gVOQWRMp8zXHQbCddiT5yN+Lyn+1uMCCJjwBkbRYKKibpsF0/
 cfBgoApZ3HxxOAXcHwtdDOAYoeeVvM/aWlYaHydRUDWmk44/dZwSzEfg5Rzd0ARt7P2BEXBjSqF
 TVkRuekhMWQGa0RADw6vsqr4ztJ9obPouQfhcN6wqHQlxiILOp9AQWEUddu++7O89kt8uX38Aox
 sb28qDUhXvh+I6ShX5LOtOHt35cuP3+bcun43zZnxu4HXLop5GAtGkPSIrj8hqpGGmWNHRV546j
 WjokbDY7SCqw5NOlIVfXOgmN54b2u24sTGCduEj3VQTZMIJiL6u5E5J2NgJD15YF17eTGmGQIvD
 VXkR478Cq2Ly7fg5AcVGeeg6lVkdJwowbM+goIDTAC6eszYaK53MAuoh8qlVh3e1yjGvJm7XO3H
 NoRCskYJ14dI1JVHazQ==
X-Authority-Analysis: v=2.4 cv=A6T5rKWG c=1 sm=1 tr=0 ts=6aff9850 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=uh9GPBYV2gxs7o8O5dIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_01,2026-11-19_01,2025-10-01_01

> For future reference - there needs to be a path in net that hits the bug
> for something to be considered a net-worthy fix. Otherwise no Fixes tag
> and to net-next it goes.

Makes sense, I will keep this in mind.

-Todd
