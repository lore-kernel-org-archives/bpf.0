Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794596939;
	b=TEhNgsB3kelGNmAaZuw6rrcWc59hhSjGXrDIzTZmDHqHYJicgd0KZ64ju+M3atIMTgeS
	 1FPISpXEHrJ33ofULiENJKaHfT3AV+0hI7WrxWcdMDfhJscclka9tsJU3R0xxuCpKmH2C
	 gFqVx07b7kv+jtN86+jfvlU/vUgvPI6qgrzv9wN8NAs5v81PeozzWiJf9CL5UlDC3ArV/
	 +usscgN8g/b+MGIJzjVzbh8ccWeOUC/+9NG6Xc0vJKvLHCXhOLrGXuvjk6OZ1omYBkf26
	 DBU7Vtrf1u9MJh/CdTjOvVkdImSfpmvoL2H4mmqdfFRk3EI2NkSTQvxaQPQRj0/pLKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=wMGf9TKkw2dAolbYMMRxX3h85UEtf4o2yarI4oY4daU=;
	b=i+/63DgSVXWjMTo2roN+WmNL/8qWBE8gnZ99EK6lyA8x79CFYyNdXkPtd12dz81WQe9d
	 834o3hqBbBLy3oBSxW7qSaD+TP4CwInEtaifNT5hHaT9OUrNocET2NJdYpsC1AXgCk7T2
	 whu6nKPBReCDnoifw92Fur49DHtk4DGrR/I2DFilx1Z6JvOy/PWXOz8x4CyyjZgU7+bnh
	 yzHWcPaojurXVF0lH9SlqA0T5tb0aY/Y5PCJDPtTHfjjT3xvad37X3OpsrNIZGYBulx9S
	 lTBOnFd51s/Qplyf9MZkFuGVxuyLntZ7pNiYo2HCNRy7iIWqtsNMOCCIq8yrJ4cWiyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nOONlcMC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868B606A33B
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 19:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6868B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nOONlcMC
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIwrmx1929182
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:08:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=wMGf9TKkw2d
	AolbYMMRxX3h85UEtf4o2yarI4oY4daU=; b=nOONlcMC8i4eL5z9MdkEXEZlwOx
	Vrvx+jYuO0AU7xRzGRrS3LpEi73YXmUwnlC/dOM+wJ1ODaYOk7bl6zGXh9sfmJfw
	MKNO6Sg6FOBmO6fyVJijB2yweyStubRKYP+YC5sRD+08HFJSgTDbMn2V2e8elqHY
	cir6/wisuzYvGcarXU8Wim98GEnpbLytImhbK0UaDptgWMMAdVa2EzVnCL0Fdt4P
	C8CwU6njpzc16OA1dki1A/QVsYaa2fr1OOoMTrn0yofhzM7HL6RF2Wow7f2tRuaJ
	2PYNcqU0vefF9VfhQZZYt3fhB3NxmITWzERS0MJE8hSc3pgEiPS+lD+uMlQ==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hws2jd7yh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:08:58 -0800 (PST)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso12090825e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794596937; cv=none;
        d=google.com; s=arc-20260327;
        b=nBOwT/eyvoa+BbMJAQMAYQmtrBt4lpaDIQYHKiyHwvJx2vpfpkZGDPV9EO34/z8Yy9
         Vl0FmaQivKe/wipHVBlRuyOuT7xdgN2krYDOTxVHzCupYYO7dIHRR1mYbhMmobCShXT1
         7Q7Zo+QORZSVPGBP5nkDYhG+wNyrOrxrrCC4c6nNu4FFFCOeShHfM6kL7teQeLCE8w1s
         onPcmFpRvwGlNb7P0MyGrS3c4LnjLMk50zhb2P1SMPNlobnUbVlZ0aZ7YBP992xd01E6
         lz205NHcc/3R9a+Hishm0avGKcSvdEBHgpAXp7y6MBk9u2rjHME7rl8/nsr9wbAgWDWM
         g58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=wMGf9TKkw2dAolbYMMRxX3h85UEtf4o2yarI4oY4daU=;
        fh=xnIzawcioFtg+IRyeZ8NwoUt8uvH/cI25mOEv5laYSU=;
        b=V+zlz74RleMOxhdSW8aJbwacPp0eS9D945ulKu3/NlJYRdj08tiqMUisbw/sYBx+p3
         uxu/vwTDUbcZS7A2kHgdL/Ey2cC5ByNnlh30IpK+vWC9HTupORXebAjDlt4GcMmD8sdY
         zKCRcGmD4RYDI3HorbtFGEeSYPfZ6yZivzimXewa0QkmEv6TeGecVDrEsXcZEAt3ULHc
         nfRBqpc0FqmB5WYeuHyI2U4G5iDuqTY00hCsBiiQDX2FRXjdeIhEiMiKUW4+TVVJVaFV
         uXKIggYoJdH0i6rYI4Sa8LT+54+uG8cegCAAUyLM+iC9561KR//6vzFsagf5lnGMZLJv
         nZgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596937; x=1795201737;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wMGf9TKkw2dAolbYMMRxX3h85UEtf4o2yarI4oY4daU=;
        b=YyUXRdVk2e4s4TIUECRJlXwQM+pD8oJVt0H3YTTpPltSthk4v/iTWpvlTFA9zKsJL3
         hVa22dqI4ABCF5Zz5XTUZrPdNvD64APovQF9Ve5DBlX1SawynNlNFjq2zu0jIvJjtnSt
         5drF7lhNuQbE3mLPTFppaf3gWgf7z4DKorWVUsPWv+ljBIVUg83UUsYQgQX+D+fu59Ez
         BlpYwR7Nynyk7setbkQvulTSF8NQmIjo0ZpXj7Tfy3kjKAsf556MdXUTvbbnOslWHOor
         3mqlea3d/Kvba4SQ5uETZkvIftAWppaDy3BNykFcYoWToEgmHYpmqgFWqPeVsZpM6mKf
         OyAQ==
X-Forwarded-Encrypted: i=1; AL+hErHpfVnbAV5SXzDyGyRZdwssQRjOqOJVLTvoCly/Ngk4WEKWXqb8leOGjlScZ6DX8dNWDx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+U6aqq+PBG0FQlNY2mzrdxkI+XZAv3XrmQ9vyfkiUYlTOd/e5Z
	gSCYneHX42AP5RumaKsWMPrKpxzUbHmJGqbd464s5fgstlL+8kG+3vkTHImj6/XhCgAlF9k8ZKs
	ZszU+t1rYzkYrMI8xYwIP7Rp3RWVyNqhR+hkSEgJjDSkF5iX3VplUx7m5LCTUCRuo7A2dGy0R+U
	rt3GFzITw4WMjzKwjx0QfRt9Fl9D8=
X-Gm-Gg: AYBFou0zyHsu0bLvzW+pMl8qLGADlrGhJho1CLyu9hRgo4wFKUX6qErGVU3VuI66IK0
	E/UFLPMGpJgLNSIdvk++0S0QiDCQoymtiIFCz+MifHHZP9MqcbRYmEZN9UdeE4jpcH/KxEc3YDH
	wKKmey0A1LvrxQpGbzJ98U7DR5rty6QqL30o8DCDcx06+84e5iAzNF0oyr+a8L8HZ+WdEybfhau
	NOuWp6ULDvw3s6gLGEtzYSTkjQNEWTYZzBNHrY82Hz09EAGuYs=
X-Received: by 2002:a05:600c:c172:b0:4bb:5f07:10d3 with SMTP id 5b1f17b1804b1-4bb5f071385mr25701125e9.21.1794596937126;
        Fri, 13 Nov 2026 11:08:57 -0800 (PST)
X-Received: by 2002:a05:600c:c172:b0:4bb:5f07:10d3 with SMTP id
 5b1f17b1804b1-4bb5f071385mr25700845e9.21.1794596936812; Fri, 13 Nov 2026
 11:08:56 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <CAM0EoMnPM54re5-WKyWgwyoz0cn1uGT6=E96OBG2-4m7M+kx7g@mail.gmail.com>
 <CAM0EoMmrRrmPdXPKyiQgEHQSb=mq3uYfNc69hEKw+Rw1EQAzmw@mail.gmail.com>
In-Reply-To: <CAM0EoMmrRrmPdXPKyiQgEHQSb=mq3uYfNc69hEKw+Rw1EQAzmw@mail.gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Fri, 13 Nov 2026 11:08:44 -0800
X-Gm-Features: AclHuK-U0ThzUJNaBNSfjppeRsNnyfVDY_cTKL9afgrilY3k6R5ZNeb33jtLtAI
Message-ID: <CADh2yMyJ7Fgtv2BAyNpKFkBC6YRC=Z7kOHSiBcH6kTqcriWL4A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less associations
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NiBTYWx0ZWRfX5ZS51ErDQzjF
 Bxx9VrthpUGUwdObNpzv2gFxPAcKpO+3pN+e6vkHunJ9T+FOhay6526Pq/XM6Dbfgcx1PXkziG/
 wdBtcvnfCn7QZly7Ls+dDc//ysQuaDk=
X-Authority-Analysis: v=2.4 cv=B7QsQ+tM c=1 sm=1 tr=0 ts=6af7604a cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=V8I_lJ-4SMfPdcaXHV4A:9 a=QEXdDO2ut3YA:10
 a=nJq5_VNI1X7IEIKzvdHs:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: l3LGeyAa65qWiNda_8QBeI5cBt8eTtvn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NiBTYWx0ZWRfX4aj5ikt3UPAX
 ZeDifsMCO145SaDe99ByrCmcYxtWA3yEsKYaTpyQn/lfeFD5Bhh1bWee0RiainPjWFeZbWfhA/F
 ewImPlg76DxlbD7H6K6d9Q92LAk1AiCLCcbimdHjP+XandRHATCsYXjRgxuivNDcitAJjPQ22hN
 95xTQw0XaaKEdxUTXpcDfghd0BHzG013YF3Hrd3bB+VYyF20Pb+ZPVc8aaDU6sMh7FwDhbIzQfn
 uxed4K9Zv2zOFXaSxYX37oaBNUFF+TUmKsabI1tLMyfoRmNzJuEMYwz6giNgnY7kwQJEO9dRJR/
 BoJS7mN/jLN/NVVEg+5cifqmTUoevGavwYprTwBluuTW6kvI1dgs3IZSKGlOx39pMst2Ey21iWV
 HvukHN5G1b7LIzAtWb7oVFgFL6UZ//pSSEnWUC0NB6Rrpa2afTVBTqJNvO1Mkj8OUu8ndhYa8kw
 cjfV4p+domROsVPT9wg==
X-Proofpoint-GUID: l3LGeyAa65qWiNda_8QBeI5cBt8eTtvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

> My bad - only one of the sashikos (gemini) responded. I suggest you
> wait for the second one. I think it watches this gemini sashiko and
> tries to come up with more clever findings.

Ok, I will wait for that before posting v2. What is the best way to know
if that has happened? This posting is from 3 days ago so I would have
expected all the sashiko reviews to be complete by now. Let me know
if I should adjust my expectation.

I think this is the right place to look

https://sashiko.dev/#/patchset/20261111005533.6436-1-toddfreed%40meta.com

-Todd
