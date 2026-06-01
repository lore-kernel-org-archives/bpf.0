Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977193BFE31
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324772; cv=pass; b=Tzg1VRPnjRC4r/ASt5Yk0s0lXzzoL2AkA0r3c6Tqb7RHQpCzrt7MjnexIb+rEXu18T3FnX+f1FPFTLvWWKaa6vRx9rk7kS7fcRk8m+1h49J1gbATu2b2E9MrjBuCAgaK4xcgnrh8/pbgQ2fBHr6FoTM6b5yTTJ4LmzMyTcdO22k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324772; c=relaxed/simple;
	bh=OHSvGqIQ7vUQwbN1UD2YIJMwDDsgXFuN8/NYPDCdXOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NA3BqdTcugLWUM2MenqOeI2vYPBuiIxqRPz4OJbP6IGmkqkugrnUyAbpoQYYY8AcJ39dtsNMF0OKr7heX1mYtPEeOAuAiVLwZfX+gC86vW8jUrFgEdMs6n6ZsRzWtq4CFNjkyYo02b2o9gbP6jL9ThAbEHwr7xwaP79PD0M/KfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fl2WHhoU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=afHBz6Tw; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fl2WHhoU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="afHBz6Tw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651BBeeE3129399
	for <bpf@vger.kernel.org>; Mon, 1 Jun 2026 14:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=; b=fl
	2WHhoU2ZbOBnQayMN29RXuPbvfhRf7VSTallEctg+EVOpuK7OgxdBm1XKyW8KVTE
	2FmNSvRNQVGx1p8XxVrQ/Acsaz17y44FmnZf6SXtJAHS7yz6ptk3108QtY5IBJ57
	rGpDJvhLyR6ZpSbbxiv5Cd5Mx+Nx50TKvl7k7InzYMfbjxMf+CT/ouAgiL0kUY12
	hQjpPFe61B5qE52vZYVpldryQZ1paFipGZJISOzTfsMA4uSAHXUCQAf2UYW4q44Z
	m1eRBDEscpykCOKXssGcU4hCKIBbpc83YhNKgOd/8ieznHfQ15SoeqQ1iy/P0qG3
	yGRx31p+5FW9UFEHz3iA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh9010v26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 14:39:30 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-485d2b6d151so2498551b6e.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 07:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780324770; cv=none;
        d=google.com; s=arc-20240605;
        b=eRh2nGiW//TT140boA1kqTTrH/8iWL0AASkfOkvPPuL/0PtPWsV9ice6LOORTfFMtY
         tCPiEHgsfwAzga/Fkg3HKDIpV42MukFwKbg9pCmmiO0cP1g6+oNFnHVJ9QXJB7HdFFDH
         QJOSXXhw4Kj5Cbbd0uDBjIYNYfmt0AzTkeWaR6DW2Qrd01O0PN4bYsxL8d1FeSW4jLx5
         ImVjAaadCPrV7P0RUdSlZLHrdQQNHs4uAZonEqWxfKoond1Ex1EQcLGzVpuFz0ZmfZv0
         SsHPw2PDSIWoAXj50UNMq2ZhHo7X0w5mGU36n+m/7S8o2ItBZBPHp4xWcGa89UcPisvE
         DoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=;
        fh=1aXDA5E+kT/wVs/sIi2OvCV/jKSmIdL1IHHyV7ZcHg4=;
        b=FshBw/pyc0e2MNI5pX7N6Y/25vbG92IrhFjZ3MvJzM3c9HLD8E/wAIL105bXgVcJ0L
         EGkTn8bCJCHwuk+G+H9VfyRhlyC7QJs8Zn2JwUd63DtVdw8eBlMlwmcae1PfXHpohkbt
         ZHCa3vXVsvno4+/Y6WgzdGomadapILD9K1G8HJuiVTM442c6UUvW1a0Gy3BSeQNKSNGO
         mGH2Ql4DOJKd7uNIGrzprQ1WlYyBjdeZUG7DPJOeq8vvUipNNKzRILqeaw2LKMQaPRhN
         LTnwnMDVHakJrdJ+Cka0SZN5iBbPfZRWmkSaqhqvcBjaLY/oLRmdN6G+c8RKIeMa7VlJ
         CbBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780324770; x=1780929570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=;
        b=afHBz6TwfkNZCAmC3N3h6/jIa9hJYKv6s+OgLCa3CfraPm/DU1XNLjf+e8CjQpmHRm
         YfBmHOeF2XURArLN0nybXFouhC/YLMA9WeZlXiUlEY+6kZ653lxNBfDiiBgGaBaxqpEI
         4p55BYcSQh5rghKDmd0Q81clsV+GKcmYu+v6T92IBM4EAgy3wXtANqel+UHeEeQbkdIt
         0O+T5X37kW1YdIvos7/pMoGWpqGcXoZqxnWu0zlCKyozXJi1kBvY6Nx/QpBrC/7QsW7s
         Py0+uCOYhhWICVx9RI5iv0erUpKg8SWaJVnpHrutIHjeWalHR6vxZMth1R+48NLl/31g
         I8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324770; x=1780929570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VN4C3LVZuH1k7AUd4KK8MEyJP8WIXP8lg6sKthHlaQM=;
        b=MrgaPh3upgbCFcFR/u8BghPSWVPUnM+tcZwb0J8Hm8SaQjIslDtCvOcRvn9Ps0SVIY
         cst8PO1Xa++/vjAKV1zNTO/GKawK/9GO3LDihH8sfb4QViTszANqBe9wpwNDS/5HGzIl
         +jstUAjGHQcq+c/z+HRitGLa+T0EZz+naSk/AhO8aq0J88+p75DhoGHhaVscVYMb7aN/
         3L6gfhV8t5MQWUeTReOea8yUXThDM8b+EBhVmMoUUxFLg1zOSam2MokCCMrnpabfRUCr
         BeKfZNQE23iO3ZB7snP2WsoElFvqX/NiwO5B5yZ3BBkexVuV9pF6ZAB6EH0W0GpQPkNK
         WY9w==
X-Forwarded-Encrypted: i=1; AFNElJ9waVge5eVsq6T/+VYYGqXQ0JmvPpJk1ypUVL/O/rXQvylBu7vomKr7IPRdqBaenMGRjv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM8sP3YvtnI8Tlax72Sq7SrtgDaQyGzo6giR6v5vVZHw877qV
	viTz0f5LONAzgTVmWRg0ViFrZTZj5geJ3LRhpmQm6cjDHU8fS1F9o7O7EPQ7XHjm4Zcbjc7GRCc
	y/XY5Ph17j4JcKHG1itldlSuhtI2sKapiWdL+ajiDK0UgMrDkbBDzI+KT2+p5b/ikU/rWD7SS/A
	h/4ULYHcrN5Aabq1C5rRFPAa8O8HBnGg==
X-Gm-Gg: Acq92OHeVzhDgVvAvfalc0Ncb1Lyt5UtxmB/hQxMyo+VUUKTIfEmf6DZnwqng7zgzWZ
	JaMkRgebiHTFhC4p/2J/abJQ+TLu0CtsSmnpbpgnSq6TdGRSvG4Hi1n2TxnSprnGzIEc4St+xOG
	WwxePUOAnG21iraNjjN3wQwul0tk2l4AEIB/30gozHjKPTeUkI4Mo7zFQagd62EBu4MKHUIIBOd
	4363EjqqsrkDA==
X-Received: by 2002:a05:6808:1912:b0:485:41fc:71dd with SMTP id 5614622812f47-485fb6a8ec9mr5078459b6e.13.1780324769626;
        Mon, 01 Jun 2026 07:39:29 -0700 (PDT)
X-Received: by 2002:a05:6808:1912:b0:485:41fc:71dd with SMTP id
 5614622812f47-485fb6a8ec9mr5078428b6e.13.1780324769126; Mon, 01 Jun 2026
 07:39:29 -0700 (PDT)
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
 <CACSVV00k-fxW6+waHNqvmYcnVNDkRexoWWprFzfayZfqdyMuuA@mail.gmail.com>
In-Reply-To: <CACSVV00k-fxW6+waHNqvmYcnVNDkRexoWWprFzfayZfqdyMuuA@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 07:39:17 -0700
X-Gm-Features: AVHnY4IeX3RPNliDvhMevHdXSnbKaPpqnSaYQnqMtv5VzgFC7cHejpPkwD8NES4
Message-ID: <CACSVV00dNWgpNVU5rB=Hmg+3oWF18yTyfKNr_tWesjoP1jMxwg@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=H6nrBeYi c=1 sm=1 tr=0 ts=6a1d99a2 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=dBKglsDaislA0vfKbgwA:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: jUhWK_H21qCBNUNxvSPIA8q0aIyDFxmL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE0NSBTYWx0ZWRfXyFWUPRMPyzSG
 DFRoIqAZ9OZmqnM/JMySY+fh8rd7kFzIQ+PTuHGsQLJIHqQbS3Q0ZSfxzsjk1QsNZSQc+j0XmAb
 4NQ8iEIFCcOHWr5C6RQ02ns2jsQcQyzGfJoF8shrgJxlNOnZWjFUx7/pczI4v8Hurdf81YzFu1O
 rM5BSiVNmTubZITLYojSDZ+QWrqNQA3lhNgU0nrfas3t+GPG7PR8VJJvTFw+lFE2Fb+Ik5tcxmX
 LVZeksSd8YH2VoU4z9OsqgGB7CQ4IEsV/r6QrkT/HNc7CDaPxsDbFE2nL7jQ3cslIfM/MmEAAmu
 n+3Lr4Y6234tSuoyIaU7ElW2INaZ1DJz92PtfcXFEja1Ehqz8WYBv+zExbmp5F1knYRE0n70tKR
 4AKD9HNWApRw7GySBUCswjg6OBioWS683sLsj9WEtvr+lyRzo3NEOOlWzd83uOOLmkYqKP4b9Ip
 cfa8/EQK4NBR631WL4Q==
X-Proofpoint-GUID: jUhWK_H21qCBNUNxvSPIA8q0aIyDFxmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010145

On Mon, Jun 1, 2026 at 6:32=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.co=
m> wrote:
>
> On Mon, Jun 1, 2026 at 5:50=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@ker=
nel.org> wrote:
> >
> > On 6/1/26 13:38, Christoph Hellwig wrote:
> > > On Mon, Jun 01, 2026 at 10:16:30AM +0200, Vlastimil Babka (SUSE) wrot=
e:
> > >> > kmem_cache_alloc_bulk() returning 0 was considered a success in th=
at case.
> > >> >
> > >> > Either fixing kmem_cache_alloc_bulk() (and the comment) or fixing =
the
> > >> > user sounds fine to me.
> > >>
> > >> Would it be wrong if we just returned true for size of 0? Would some=
thing
> > >> else break?
> > >
> > > I don't think it is wrong per se, but it feels like the wrong kind of
> > > API.  I.e. I don't think the MSM caller actually wants this, as they'=
d
> > > also do a zero-sized kvmalloc.
> >
> > If p->count is 0 then indeed there's a zero-sized kvmalloc so p->pages =
=3D=3D
> > ZERO_SIZE_PTR but then nothing breaks because nothing tries to derefere=
nce it?
> >
> > msm_iommu_pagetable_prealloc_cleanup() has a "if (p->count > 0)" branch=
 so
> > it seems it's considered possible. But then the rest of the functions a=
lso
> > seems working fine, i.e. kmem_cache_free_bulk() of zero size does nothi=
ng,
> > kvfree() of ZERO_SIZE_PTR does nothing.
> >
> > It seems to me kmem_cache_alloc_bulk() returning true for size =3D=3D 0=
 fits
> > naturally in this world and is less likely to result in a gotcha?
>
> I think I was probably expecting kvmalloc(0) =3D> NULL ... but it
> happened to work out before
>
> Adding an "if (!p->count) return 0;" at the top of
> msm_iommu_pagetable_prealloc_allocate() seems like the thing to do..
> if you want, I can send that patch (but traveling this week... so
> let's see what I can do)

Aaaaaand.. sending patch from hotel wifi doesn't seem to be a thing
that works.. but I've tested the following w/ deqp-vk cts, and works
as expected

----------------

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iomm=
u.c
index 7d449e5202c5..ef744d154bbe 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -332,13 +332,16 @@ msm_iommu_pagetable_prealloc_allocate(struct
msm_mmu *mmu, struct msm_mmu_preall
        struct kmem_cache *pt_cache =3D get_pt_cache(mmu);
        int ret;

+       if (!p->count)
+               return 0;
+
        p->pages =3D kvmalloc_objs(*p->pages, p->count);
        if (!p->pages)
                return -ENOMEM;

        ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count, p->pa=
ges);
        if (ret !=3D p->count) {
-               kfree(p->pages);
+               kvfree(p->pages);
                p->pages =3D NULL;
                p->count =3D ret;
                return -ENOMEM;
