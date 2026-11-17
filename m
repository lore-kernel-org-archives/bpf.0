Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794954198;
	b=FT0rghQrppeqk2ALnbR4rGUSh44DYFfqFV81zpLqOWn83w9JC3kS4OIgQlZK+/7DKkZ5
	 fFPJ3wZlwAicZiCYyVdzkVmogLKlHgMUk2QUmAYGdblOqpruiv8wQAS47lk/UncMiLcHs
	 DVrF7WFTq9VTXOJ0AaxTd42uvOa5q6uxEVVyG9MqgNLQ5dsjc3D6NG+HAfo5PjBJ52t3P
	 kB4e5yIhtOooiMHaNfwbWr4PxF80TxhGPu1WOXMG4RUbzD4nK7jzlZrJ3SJozWmKX/Zun
	 Sn257o0aJ7MAck4Hy8eGrpngoUvhfj9EzXPQX+dG2/zys+itCmEePT/yXGDQFP/0wcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954198;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=3q13oIFHchXPM6DaArLZ3eJnxMU1PA66WCABp41gm7Y=;
	b=SSs04LW4FVh27eJq2vhET22Pm4IrqybBYcb4vwXSpXBTua1bzMmUpOr+2JeQ/VkUrYlw
	 tla+kQ2aPFWaFwUlo23jIhsXdIWhGypi5BKZl0bBDc2Sg54pFgJNaAsNMh78m1L7Mesk4
	 DJDtNM7Qr2i+MOD06yTMM4MxD8zt+Xb/1+5B43xd6smLTxmwLGlhJXif9uwv8cW+Iwdai
	 JaE+nHvpLwY1o9uyivlXcWk5RYo7sHZN3/V50tr85F/SGPbfjHEeqINJmkUy+zTd829EE
	 qFb7azZRJ/Xy5tnOvkUoRfqT1HZrxyZDgO2GaeutXZw/0XVmJCuCRrOTVW9LGhXHsag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PUEFdh7q;
	arc=fail smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4A606A32C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A4A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=PUEFdh7q
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHM1qkq4067268
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:23:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=3q13oIFHchX
	PM6DaArLZ3eJnxMU1PA66WCABp41gm7Y=; b=PUEFdh7q5L2JYPw6JJBaFQxI/Q4
	sFzmHEq56Q7i7DCKlM+eBGQXCRALo2QecCYubDNvHctGTlp0t29rtrCt/ksnr/5v
	MYsaGrCwNt7LmrjIEzawBTBesaGCkpwbxnW9OMdlOtzRsR6B65xN5wcA1TYjTeNv
	lvp1H9CHHcxFrUxTA8y6bT/iQO3GLfcR6TTrPZOk+QAmiPz69IHcxbJ8rSYZuY14
	yvPAyZQf2z+g+EmeMCYhDgdvotkNIEvRlGd7J+d0+0Ok95giN7Lrl4QsrNYzci+E
	Ay8F4cJoZUYPPDUYjGUVg+o/we6jxKs1DNWxx2BDTD8p/yy0EZinKo8C18A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0t1jchn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:23:17 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so137522a91.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:23:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794954197; cv=none;
        d=google.com; s=arc-20260327;
        b=d6HuqVNLvPtgjfDRSH8fY9sPex4XTyYRtVIo2OfxOVgnXi2aZf+FMowjsrWtbpuotc
         uf0vuuBWkeu+KAQVUJ9oFz15a7Gtr2Zcht3bQDVyGtxO4ZHoTd9swCENDvorQ0Hu1rh6
         nVEFuSbVsrHpL4cBThdwrH1ZtGqTfPM/HJ22Og5OQC/w0sJirjNNEbUY3QV7clEJvtpN
         jwgYfuApFTbfm6WF3Hp7LPP6ky4pigSvHCkS2JYASvrEEoa1XcVVKqDypddQF99WEvwd
         EAEEe90wxG21p2Qzj+mlTuMu42hfb64xSHVbCx/JNWJigYLmabFNENTiWt5ntazaxClS
         Fcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=3q13oIFHchXPM6DaArLZ3eJnxMU1PA66WCABp41gm7Y=;
        fh=rwPv8HItBm1I4IRg/bBP6Fjnuy4806P0w0oHr0xgGjM=;
        b=ZIk7uXlg7ncpO7jD16aNYY+tNsyBs2nDiwyF+PkV9wR9FEaeQrAtr1lQsWzztyv0m0
         QdxcPKyjm0RZCDhJjTfLXDLztiROFsUZC+/EtNHmV6LcK2f+3d8wI9dkY3eEby21EYdU
         I++8vVMFUrFlDreQkPK4qADHxhIzeMTpABvDT7HtZaujUpmjR/rXwgi3etG36w1cA4/C
         vCIYEQZ67nLFOir7d4xnBjxjg878VuUWl1k+x75VEwgR4408+hIReczEbK4WiYuQgbzw
         ngOpuw4lwiiyPQ4FlwXfPdtvvaOn0VrxnbaUhLNYEgja3LWUmH1d5xw1KNG1lT6pXWC+
         56AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954197; x=1795558997;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3q13oIFHchXPM6DaArLZ3eJnxMU1PA66WCABp41gm7Y=;
        b=K5PHq+PvnafKECf4iUERNejyWskjlMInicS/zH6bl118PpyVvR5rR7L9sQ9gheLkGe
         IyCMqeblgbUN7oEMD/0k/vuKfD143ulN5eLrGKhnAa2UEoOKb3yDGluPeJK/aAU8PZaM
         5gA75+w0i3lf5BiTKzaiQK61Dw9MomdUPc3GycGM8OXWmur+qRYzS16JmkENK0mN0AXC
         64avSagJkw4TwQlp18BOoOuCbRtP1vSgVjK5JA7mSwBe17QR4ZvlIgD0o29iMr44xfs1
         bH8Rbaanroi5U2Mj9F+WtxozNP5yyj/X5+rPpOzMb8yg7SGL6Rdi3RS0kSvOreEvwf6h
         Z/Jw==
X-Forwarded-Encrypted: i=1; AL+hErE8juG9br80oBT5KZhBmyDlki//SeQf3TisukvEr7ObSoW10dd3RGhPqiJ4Z4rOtGIPdl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Edes1AHsfc7xl8QX94pTVrMLwS9JCsaWVCFYepcxAsnOsbWuy
	MdClmoRSt9ZtM+XrPetFJWnEF0W0Vqe+R8z7k6Pqt6G2o4aJtCeRIc00T7Sr2ILyRi8Oz1B2KKy
	QGQhMqKuJyVQZ9uRzDbs7a3Bnrf9fa/lpTv57rubar0ULQ4cK3h+ubxESuRDe5oG0GtgWGqdFHo
	U2gETqPXjfRh6VzO9AYBpdkL1BLW0=
X-Gm-Gg: AZFdTZcwhzims7BR9pAF12Du3fmMIxMLwFACxNdgRgfcy9dLyTqBPGvMyxJXJ5i62Rg
	s1w9gSydkMBZZjsu6op1pbZ9m5Ra80oqNw16r+ApJCdP1UhgeKXl8LfkyS/GeeBK4+JJXFs4kxx
	lyhYermp8P5DL6mh+yCmhPu4bbA5RYfPG52WVm9O9sgUFuaY4RKG1mBS233dzeaavwAxNY7CFcL
	A40WcoNXKW0oWZNGWXJjmCPwMZmNS/u8avaE84kHEyUMGcpHe4=
X-Received: by 2002:a17:90b:2fc8:b0:3b3:c3b9:7de6 with SMTP id 98e67ed59e1d1-3b3d07a212dmr668818a91.13.1794954196801;
        Tue, 17 Nov 2026 14:23:16 -0800 (PST)
X-Received: by 2002:a17:90b:2fc8:b0:3b3:c3b9:7de6 with SMTP id
 98e67ed59e1d1-3b3d07a212dmr668796a91.13.1794954196341; Tue, 17 Nov 2026
 14:23:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-6-toddfreed@meta.com> <179471269695.2199510.18062590833471363525@kernel.org>
In-Reply-To: <179471269695.2199510.18062590833471363525@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:23:05 -0800
X-Gm-Features: AclHuK_fZNKIqR9h7_djkUI-3BJ-ndjBhRGAOYb0D1EyikjXTaP2ikjH-ZrZrT8
Message-ID: <CADh2yMzkbDDFt00Bnd50HPFJf9-HcKHA8BpfOikBUPHjmdZaAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 05/15] net: add METADATA_PSP dst to carry a
 psp association on an skb
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
X-Authority-Analysis: v=2.4 cv=RsBQvymK c=1 sm=1 tr=0 ts=6afcd3d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=27JUocoGZ6S1wOk3j1gA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfX5JxIo83uJrFO
 MEvw4uswJR4mD9gu4ZlsJe6NdgXOvqCaM2O71mcW2CX5MheoniHydps1s5Q4Ajb6AaHzaM82Ucd
 1wptm6Z3UzTJKplg31m+hZlQfOhk43A=
X-Proofpoint-ORIG-GUID: adtATuSL1vyj96T_PVbscHSa930hX9vj
X-Proofpoint-GUID: adtATuSL1vyj96T_PVbscHSa930hX9vj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfX4ZQYLIfs2A3D
 C5M/ysAnlyPdosWgekbTCm7iRcNsV+v3vfuZbZEt6AM7gA7cJOr4n6kENDq/G+iauOLMULHgl53
 3Q/TtUInesUvxuwqcvYQ/xb2O/BkI3rOUI+M0T/i3qrtG8WEJMqLO4UJrQ5coM4/Rrc34YM2e8e
 SEfuHcTz0pBFfSt0n6gyQ+nJ3P17ZLSdkWyl4EoBvqcSNIJWa6Wf+W7tH0Ck+Z79eUPrKDKDuRW
 mzrGRXCJUXUABan6khD20WPWu2v+korfn7x7xllV1/R6mhwqKBii3nJCjTQJER4ulPSFIDicxaI
 Gg4CFbwes6f9xCdjbG05uUg1M3F1iU68+eS4NKaX9Q6a7E6xJa0T16mMWGJCR2N2v2RKxdejCbH
 IwxU/4oJ1p+r9vAuv1rTBsuaH3L6CUyA3496mW+RzHEPRZu/50Pz3EPPSVvUlr0a/DcdSvAQvIl
 eNgTPiB3245tAmaXg6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

> [Severity: Medium]
>
> The commit message says this re-check handles the case where "the psp
> device may have been unregistered while the packet was queued, and its
> keys deleted". Does that still hold for skbs that get requeued?
>
> ...
>
> Can this hand the NIC the id of a DEK that has already been destroyed, and
> that may have been reused for another association? psp_xmit_md() would
> catch the psd mismatch, but it never runs again for this skb.
>
> ...
>
> The socket path through psp_validate_xmit() was already exposed in the same
> way before this patch. The new METADATA_PSP path, however, depends on this
> re-check to handle the unregister case.

This is true, the checks do not handle skbs that get requeued.

As noted, packets of a psp socket have the same gap today with
psp_validate_xmit().
I'll send a separate Fix to net that covers both. v2 will narrow the
commit message
and mention this gap explicitly.

-Todd
