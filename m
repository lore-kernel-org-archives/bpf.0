Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6973AC0C9
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320773; cv=pass; b=BMPlJ2YNV7hS1/RYW+f7xc+KUPYnhECR0Q+VtD7AfBYXDKjFZgnfiutwynH2vq93ZA8P6dkOgLHatW8/DnM7CCr9bndbXjHGi/xxZOXd1XqxUeKbC50vRnlT9s42aUy4idkeXjbKuA+9rr9RS4ALTpEhHKlrYeUBdEiIYZLaYDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320773; c=relaxed/simple;
	bh=FBFDEqVj5Q4xuk6WgsiiDkfFNegk6+mZoIoqPl6nERU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucdtWhhekf3H8l34VfI8nWlOOSuycVegzmGdAHpL9XF27H945VhiPOJREHxGXJoZsd2KYr72KGaIQ9GS4B8NhnxJmA5TdSzB8iND1mXmaBC8+jsFPcA6D3urz6TeP2zmBDwGf/gNE9ux0UJfmUh/d+YA08/goDM4vQDAo8dFsvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFt2RAar; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8kWfJNB; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFt2RAar";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8kWfJNB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fIEu144951
	for <bpf@vger.kernel.org>; Mon, 1 Jun 2026 13:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=; b=PF
	t2RAar6Rx4C+bsZIRoMqTfW1WZG9nbsuJlWkqn83U135u0Z0bylMV0sOgc7F72gV
	sqKCXLPyNmXIQQ/LM30PPnvWdr+IvT+bUtFdYo+RGnFTWLchsKVSlh0FDoPSne/x
	pT8kRmrDo3AgwU10bbeSYRFnjrk+ckhVN2RePt2wOCFetIxgLNKUCdTFwqKwNPpH
	/4urPc305YRMDkPdekrkeylcnqus27uRpJqJZU23OIJXdUhw1wsfdevOrPX/7UiD
	bCTMtjBiSsut7/eI+6phiKEIvPexyRmaB5KOJrOAmfDDzb3RzByJ1NpduMDLwrt5
	I75z8vm444bwcKCfbr9A==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sts3sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 13:32:51 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-485ebc5706cso3861002b6e.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 06:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320771; cv=none;
        d=google.com; s=arc-20240605;
        b=F9Wn6jMxmlj4fM8I5H8Jy1MvxF3X95GisgIJcPb0LSJDgPz0el0q+GTTvyULz/IU+D
         nf6x4AhqKrMwicUpiUYr5+Z4mS21vUjMLwp6htTxp/jJ6Eb9AW0SDkWd31PUEcUYzaBw
         QDi5RmSvySmsRouX4JhZT1uEmI5QOkEkxaj+KC2+AvXB//Y05vURg9SgdjthCQBqEjHn
         xPA+aIRpOKzqhauRN3qqFvdxu/6wwaaWTBr83V7WNYEExzRwIafYNHDDSEM2xfpqsZ0n
         mmF8yuebyCXxm1KQ+UGG4XWe2mvJcEwSuiD08Uqhd8QRDQ82rWVlsGZ2TMhpGZlMaqH3
         fwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=;
        fh=ud/pSscejWX7d8oH+xXMRAm83F1n20XYSXfmMUcIhTU=;
        b=BHmNfic4P8QrMGtCvhmSc79IGC6Ny91fAjKcASVwlzuyc7oV1TM8yy+yI7VlIYEMRQ
         zASDqwcJvJ5CBRVk8Oz1cSOcDbrXg9JTysOZE93XPkaBQtmRPzyA7D1prGsmnaRVGtbJ
         r8rFe4pJAbSCDB9nDxiXmrIreDZF3HyfQSIpqwp0bi8edhvGAZOKqHCjjSdoVdTTs5yx
         S/kuewp6/hnrIftkkgSYVq0xL6biduMcY837OYsUkWrbu0F6ZAO7z7bmZhLzdd6JNw3+
         8mlMgNrYk5sSzn0nrPg/x4NnlAaJmrG+YnYmjiwtFQAqi7xzlk+LN819JiTba8X67aEi
         b8Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780320771; x=1780925571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=;
        b=G8kWfJNBvCJEkN5Ms3mEU4LmMa3PP7mHdsoVpgtqo0yIlEMBnNYWBO7jdsxIaShjtu
         tQmot2goJiWqTfUOaR85jbKL8gIxwMjC3Od5H5gQRe5BsP6QeEcQU59RSF0J0UNfaS/O
         wrZCEJ/wOX08jIYFVEGuaeqo31aJTzw3rCCy6DeDet/YpfMUCsLBiqyq0zW2Dgm8EBVg
         QBbazINhGi1Rv6lEIJ3gkN2ntya5B7bpg0a0/U5wfce3Eeiux+LA26L0NnxCtlth/PwE
         V5FPeIAoKkh+uVbCikVVx8iD2K5ozw5PkAMaI5qFmHgk8pHA30tSxzzpJWT9bRZ+9jaz
         yrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320771; x=1780925571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSWiEO3+qeWSnedTIbwacWBgpl1B0hKJbCUNlgrD+t8=;
        b=EEgogOfqe3QL9H6WlYMckEYk1pGRjcFtkH6Aa55DRV6znrdC6jwCMN9xOyvhMzM9DQ
         gSDFAfb4L1C4Io4c8W6+JkITu2+AM9iUA/JhEyoKsK0/uFiy7Tabth7yZGrGzP7qlWVx
         6KoeTVLXcSQpcZCJCbV+YE0QH+LxLnV1AvjJWrkahyaxTUCNF/pqmexJbNspZJpo9aCd
         JrL8LPB4B5JtKsxjEXGjHVMjddLYOYJJjOxBgM5mtjiUPfI6A4kbsDR9+Ow1HwFxQVO7
         wmulYEp3PBj7KtbCBLpZMyr1Cx6Hp9kLg5WplJ5+/iRLB+PuoRWWt0cZ9WBXqtktFN8K
         jNNg==
X-Forwarded-Encrypted: i=1; AFNElJ9+uxaPcbaxy6VTuRdgj9JEtmLaxsGiP056zUAaoxnxYKyMJNyF9GIKprrTfvpdeeWjG/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4CzUzbp6977++KI0QsXFPbf4T1bfuJpWGl9PiNF3R5ZKimmV
	pRJC70Mq+RVlCwnAXEhD8vOx4Ctrr7KnjoXphs+pe9zqToDeMrfBzRcRfkmVz2r8BdADD2uQgcH
	Z76eG0EnG10cnX4Wc8tS6iByCajPidCdaAJLEhYnivvtrQpfbHSRiAvmuEAGP/aEkB77pS4Egbg
	jLiJ34gu6ne992m0zvJcV96CdjsjdwwQ==
X-Gm-Gg: Acq92OG99Hw8bxGfTpgD8vz5EaXgJ5gIVBcMdaKSj39JzZeSsqy5y6W/frxCpaQB00d
	0hSxCC36l0cf9DQ59FJ07vP9LmHAStEFfKTHJ0wV3vwszCV3eRLP4PBWeFsimy9mRznPwyJHOOo
	cpshVlq/xyzizsS3GAHcoDSarJKrwaglSZ2CypnbwQM2cKia5WaxFkK5EqoaPJv8jfc21IrY2pn
	KUVHSzmmpIreQ==
X-Received: by 2002:a05:6808:c413:b0:472:c4ba:32d9 with SMTP id 5614622812f47-485e73685aemr7697306b6e.20.1780320770631;
        Mon, 01 Jun 2026 06:32:50 -0700 (PDT)
X-Received: by 2002:a05:6808:c413:b0:472:c4ba:32d9 with SMTP id
 5614622812f47-485e73685aemr7697281b6e.20.1780320770193; Mon, 01 Jun 2026
 06:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528093437.2519248-1-hch@lst.de> <20260528093437.2519248-2-hch@lst.de>
 <5f7f90d8-cb32-4ffb-8f1c-0722aafbe869@kernel.org> <20260529135045.GA10647@lst.de>
 <5f3ba603-a6ad-4cf2-9a54-aebc10273c59@kernel.org> <58cc76e7-2348-443d-a989-2a06e61178af@kernel.org>
 <20260601113831.GA25535@lst.de> <d7b08296-7f6e-4d89-ab3b-04e43d04929e@kernel.org>
In-Reply-To: <d7b08296-7f6e-4d89-ab3b-04e43d04929e@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 06:32:38 -0700
X-Gm-Features: AVHnY4IDUhXdIIQ59yCVYlfBYI5ZXqh2r6jh6SDaQfttaiXqq2hNkv_bQjj9LiA
Message-ID: <CACSVV00k-fxW6+waHNqvmYcnVNDkRexoWWprFzfayZfqdyMuuA@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Harry Yoo <harry@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Hao Li <hao.li@linux.dev>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, io-uring@vger.kernel.org,
        kasan-dev@googlegroups.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNSBTYWx0ZWRfX6WOsZbyp5lgb
 bFaubpPGUR8j55/fOxJSKWNeYTOdYL1QfJOzPnNzHTqc8c5toK5gH0dCE8AZLeP1KQodgGckKQI
 ZotXBR2smNIynt7iYBDmL5l1bsJtynl7n9k8Vc0zDO7mhFgS7Q7rDKcZy4w1qfXIAPSFHTNkpWe
 FylJGFnRU/W1esc1PDwEmFpjgLnx6h0GCDdWINRsXySq4nsLrYwMys1RRPmlD99kPaae3VRfwGQ
 tgudrtSqiY7XvBMRMD8MFPdlVuVM4NJ3NnzHmQ/w1l0cHtijT3e+UStjOIJTErask7L4QEYXu2T
 X1jkbyJhirIsWZj8zxPnZo/CyOUrfEjLUGTIqY1PKc/HY3bx3LVfjSeHj3llqsUfKYKKtQk54a1
 mCi2SFMEQBRo3U2l6iC4ClFDztv9q1D7MxfMmhnJdiOfrAbhnCkFM6WLEQ8sRxBU/5GJ2bEXN9A
 jUK03Bn1OkWIJg0Nq4Q==
X-Proofpoint-ORIG-GUID: c39I0S76RG0Yc6GJkend6BNiP8awSJcs
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1d8a03 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=gxV2vm59AnE_F2JHV74A:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: c39I0S76RG0Yc6GJkend6BNiP8awSJcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010135

On Mon, Jun 1, 2026 at 5:50=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 6/1/26 13:38, Christoph Hellwig wrote:
> > On Mon, Jun 01, 2026 at 10:16:30AM +0200, Vlastimil Babka (SUSE) wrote:
> >> > kmem_cache_alloc_bulk() returning 0 was considered a success in that=
 case.
> >> >
> >> > Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing th=
e
> >> > user sounds fine to me.
> >>
> >> Would it be wrong if we just returned true for size of 0? Would someth=
ing
> >> else break?
> >
> > I don't think it is wrong per se, but it feels like the wrong kind of
> > API.  I.e. I don't think the MSM caller actually wants this, as they'd
> > also do a zero-sized kvmalloc.
>
> If p->count is 0 then indeed there's a zero-sized kvmalloc so p->pages =
=3D=3D
> ZERO_SIZE_PTR but then nothing breaks because nothing tries to dereferenc=
e it?
>
> msm_iommu_pagetable_prealloc_cleanup() has a "if (p->count > 0)" branch s=
o
> it seems it's considered possible. But then the rest of the functions als=
o
> seems working fine, i.e. kmem_cache_free_bulk() of zero size does nothing=
,
> kvfree() of ZERO_SIZE_PTR does nothing.
>
> It seems to me kmem_cache_alloc_bulk() returning true for size =3D=3D 0 f=
its
> naturally in this world and is less likely to result in a gotcha?

I think I was probably expecting kvmalloc(0) =3D> NULL ... but it
happened to work out before

Adding an "if (!p->count) return 0;" at the top of
msm_iommu_pagetable_prealloc_allocate() seems like the thing to do..
if you want, I can send that patch (but traveling this week... so
let's see what I can do)

BR,
-R
