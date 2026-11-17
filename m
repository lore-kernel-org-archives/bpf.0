Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953064;
	b=EzmVherg4ng5guM+okzIWU04wSRZjJAh/kS9fESIpCQ0T9JO4JcRzqcYcG3nLFY718Uy
	 0EfmI7EVPSw49ct4bbwgWsrTIUc4aQV/dy82bJuptwi26DwWfqV34laj7SS/BZyqQzkvh
	 ZDVxiFTGDF7x4P8OKzQtUFhQ7rNjHJAxq9GgqoKucWuTo8IldteYraW9A1zelo4wEVrt1
	 YUjV4FMg8PxsST+PuFkLCJsMLm4rX5BvJ858IQfCMjpmtDAZGBfLXyc6/FHbsoLMB2n9i
	 ENPXZWdF85a/PWROFNp8+Uo0SJCVckAFZ4WKQGL4WO6VSwFatW0gqIk213XVvcetMPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=F0h8eziyjQaKcApZn3rXwi6/D2KTrjlf79mLv/zsAlo=;
	b=FM6HrrtgJyrgPUeCVhn0f+LsR0iR7uWuIzds9o1v13qlpEUNOE6x+nysvpFQCjtA3OMg
	 WZsELebGZXt5tK/YA1RXoJVOXyCg1BMdQwyw5em9N9cZu082EEHMvFIOuhzmPvPjHD0hd
	 NmyGlgQVF5JK9GaLkADj90KgU44pmHfTRqucyINQ9IA79WysM9I0YesCMEuWdFLM+sfWG
	 FvP9zv7uYLf2Vv5EWSwcvPuEOk8y/LxLruPUaLzxCZZLTGyUJZbk5T4my2mDSmTqb6Fow
	 zuP1wGdY1wTqOlUGH5kwJf9PK9UuyptniWOGMDXnb4XW6cFz5LuQwGvXa3INDmvRd5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=l7uGjHqQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB0606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CBB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=l7uGjHqQ
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHM1xkH579815
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:04:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=F0h8eziyjQa
	KcApZn3rXwi6/D2KTrjlf79mLv/zsAlo=; b=l7uGjHqQiohs5ekfiARvjRSqonZ
	vfWTdNRDAMTgYbwgHd2DiCaSQiby1P8w8eUQPRR+TIo9nRLlBQFNdDnVag4VjV5v
	zrbZw23J8ETzA0nATXP0IVDkySa05zQZtoRlDwRuy1a2ZoxUH4Pp1yJR43RsCUgv
	tl+xcJlH6woyek733bANbYzH8HReXmgA4za22Txg6BnnOkOdLsXPCv3qcCky4PEl
	oTyV9zDt2xSDfhUpHFVmZaywQ69nMGDlbBxkhLjsgqHBVVkUhwg+7DJBMhDNzWHE
	pFQ8H/gSSYpsYTJQrKrhs1zeRTZ+DY87ItQdcFZRO3NzTPrKdYV1xdB2t8g==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0rduw1tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:04:23 -0800 (PST)
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-499ca65ae87so83353f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794953061; cv=none;
        d=google.com; s=arc-20260327;
        b=Dn1C8nX27YiFKZzbhg3W0b62vQjaDtixbvovFex9xv9QslFh8RJSkH9UNiLBB8MMUu
         6LnplFeO6VJ6J2WfMwTkixp7kT7Y03zuV8DYtejkiq37EUjIRWXoAZky5WP4VHrRVIXn
         YTJA3b6Dwy5kX1C3uE/dxN1XqSSsXrTtuHQSeNpKeTXHm0QajYHNuXqezg7meBvQGp2Y
         kJo+a+0T+FeS1trDJysPOl6TchpnZBKp2nXtnDuPepxTSCOaaNQzisKpdk9FT4DZmP12
         Qon8OznL3EvanprrJQ3vRXivSk24oF4hjzMBnhvSKCLYrJuTgyeMRkYDXg8HSrftsIMj
         R+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=F0h8eziyjQaKcApZn3rXwi6/D2KTrjlf79mLv/zsAlo=;
        fh=YUSdRp71XYT11Nxkud4+gIzTvod/IwDBCjZTQw0FrLQ=;
        b=cji2xnuKiqoPxmMgvDnluZk0xVW0hyOuLnwqQ/H7ODnqGCD/5y6vW09PrAghQxBhY3
         kXYy8R6nSYMurwAk3KaI4M2eotN4tjJxeFmXd7HSPyDAAtcYNXI+iH+Hp5hgTjSPfczV
         wKNPjI20kv4JeAI2yV+mBPV6zm6jIMq6UXpZcCLv8MrOPunqOVeiicgWW/ArvtR1UBEF
         2EIrIdrjK+/8xSg9m86/lDDDHEI1FCx8LfdxTz2F8pzIHO/44exR1FaNp5xw7kKkYwmz
         U5jGEIfinOnxUi1RV1JeqdhUwaclZxip/9XHHMMoi+nc7R6ltJZ0fhpWVmdX3Skj2tSr
         Qhnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953061; x=1795557861;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F0h8eziyjQaKcApZn3rXwi6/D2KTrjlf79mLv/zsAlo=;
        b=1JQIflQ5qnnnKKmdu6o2oBlmD14q0S9XM0QXRuXSUGqrWRA8rdP+yJVBsWHUOGm/M7
         mjy/K4rnzfHBhb8QxQeRlmfMU0AE8cQ4+4CHLn1ka5oHnQrqXbDGs47kBKtpE6qNMB2z
         sauxV2vU1fg4VgoqISWW1y0kTbuKn5HxYpL+l7hHH0hgKkqvlh0cYVexGO+NC35xwC1A
         79T6tyboy2DPKUO8fSRhv5hMMEM9FpH2ZRmx1M/ZGNOTs7bzh7DUU8Bq7TSwySZ/WMjo
         b86FNNiUDHTP6TooH9x+2rMD6E7He3NL6783ccNYScyofKhWMS+fHriBdaV7Oc7SPrIq
         vdTQ==
X-Forwarded-Encrypted: i=1; AL+hErF55gx4EZEHxK3EnkmJHL9E/lB6zJqzwC+ObHAgqELFTGzzlivqkFJLOJE9bCWnVcgA1fE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+79vMK37pYd7suhD73IDlu1t8mfuzy4dolCKoaSCoA8O/sEH5
	HP6TnIdE2cIYFFITK5Lrw71XSVFmiRqH/M+/tUbNjwH4bTSWBN0C3PoUm3/ZBTywgsPcvzALfp0
	wYg3X69tCJ6sfqObMmf234/j8X8kOe4GBpRUjLrhA6g/JBNfp3U21D9Kh3TDhjvoIzBYtrdSKrV
	us5gVNM0rxR8WcNpSMQgCuFSvM0k8=
X-Gm-Gg: AZFdTZfAdG9qCQ33K8W/aYbDYCo1Nks/3pROn5o7n81kyu+ORqp3q/y3yU2lM81w3mP
	2jikX5edIC00MP820E1oXOwRuUJr3SpGP0i9fPOidXuY3Q400zw5sgUe7dGmqBM1t4WZBo44+Yh
	Nf8K0crN+EhojQ8aBVICqaU4DIaZjUWSyCaB/7JckKb1D8tpxF6BlCitzr4dOyokvEH1H1hzGT4
	59JlFf1bDRbe2tYZF7Ex1/gFNz9UXZm0vYxnVwEDQL78RgcUMA=
X-Received: by 2002:a05:6000:4213:b0:49a:94e6:378d with SMTP id ffacd0b85a97d-4a377f4f68bmr8136030f8f.30.1794953061547;
        Tue, 17 Nov 2026 14:04:21 -0800 (PST)
X-Received: by 2002:a05:6000:4213:b0:49a:94e6:378d with SMTP id
 ffacd0b85a97d-4a377f4f68bmr8135992f8f.30.1794953061161; Tue, 17 Nov 2026
 14:04:21 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-9-toddfreed@meta.com> <179471270271.2199510.4403404984222798506@kernel.org>
In-Reply-To: <179471270271.2199510.4403404984222798506@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:04:09 -0800
X-Gm-Features: Aa3M54r8wXLJNYnHzeKDYLuWuEkGFgDFBdsvsZ-D9Jbgov-qnF9vSIAxOghmZf8
Message-ID: <CADh2yMyL_SSJqD4=H4zkzmUCJCL4OwxeY+iPq5FQrBZyCb8+tg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 08/15] psp: only give time-wait sockets of psp
 connections a validator
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
X-Proofpoint-ORIG-GUID: N7YKZlQb0sEQ8hbBXIs3Kd_VJuTjlEtx
X-Authority-Analysis: v=2.4 cv=Apx7T+9P c=1 sm=1 tr=0 ts=6afccf67 cx=c_pps
 a=pX1sPZUoWPGeQgUnKQNIgA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=kH2YsCX8xyqK-3fOXDQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=XGGHjNwGSpTZ5T66x7Ix:22
X-Proofpoint-GUID: N7YKZlQb0sEQ8hbBXIs3Kd_VJuTjlEtx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NyBTYWx0ZWRfXxkrHy2rFoQKK
 tVobtcGm5+jDqHjVJeacVsC5G0ks6Jj7Ftmzit4WEqprNI1RpK1z+ruUZVFndIe4VRz1HjlfB/a
 pQFVLPdLI9b5AEpSQ6XuJENVTvFF5ew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NyBTYWx0ZWRfX9TGcQ3ZMpTiA
 Ljh9eqQsSt+kTBW+jveECgCN92N+CWzLAfAS+yWZxEpumLVs699L3vYqj0sH+cihArUc4oKkFvH
 zY17gDovD5joNgtNmbsHQP0+cfDnnTWfiey7avlZad9SqVsyUr01eJg/ld3A6+7/fP0cIJz6FDx
 cLG5k5JlO4VNRylIpF1irC57olsz8AJN77x0AyZaViLpZW6GdsnWpWzwsrIwbSVB040w0LOv6q5
 JECc7fmUboKO5pUe66or20mut/h/bS2L1CssYcujJoklW2pIEtnqYG55GoY+c136vj3zZlZxyjM
 q8bdHLbDCMesXk0D0Ifa09dD94KzcQHuu5fYL34ByVEcyWlLoUOSDmcN/pSQeAo2lUMnp+yNM2Y
 GkD2QiCPHvp6jHEgyZ0pt2ehn6KSabxUccxoXJwdt/m+j+UvQpqdii24tSt6yRvAgMk8MBywu4U
 8abD6AmHt7/3Df1yTKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

> [Severity: High]
> Should this also check pas->tx.spi? As written, an Rx-only association
> (pas->tx.spi == 0) also gets the validator here.

This patch has been re-posted to net, as patch 3 in the series "net: don't
redirect decrypted skbs to ingress, psp time-wait validator".

It is now checking pas->tx.spi, as suggested here.

-Todd
