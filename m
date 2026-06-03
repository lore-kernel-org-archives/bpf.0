Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69A3C81B6
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485244; cv=pass; b=K3NKo3Z6P+p1FY+scw1VF6H3z6l9hiX8nWmnPXFQwWOAgcvHi09qNhZatsWndXDFwIuRGko2n8kXsDXt67PV3t9U2yhCGRtiDJut80q103OMXH1AGBf5ltstprsGq90dz1m6aGeV85oItzdFaNemqaBzVISF7S+MNPTE8tW+GIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485244; c=relaxed/simple;
	bh=uBAyAR0iY1bN17nsLETbGFhwL/pntlsubwaqpvC8ork=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzr9l/j6q8p5+rYkXh1efO1LSFC7iWrisYKaUJRID8DBSK6ycF6es8B95IXdLTbuUsLdVG69ErSQdev/hDBvlcXDXHnVD+u+tPylV3PI+qGYJB8twz+P8f4qJSNVCFQ9YAGYmVKFE1eeD3G/aUD9N7NUv7ILIugvh+LuNVFjhfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyFYwlGa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZMT4jcY4; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyFYwlGa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMT4jcY4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RJdq3077826
	for <bpf@vger.kernel.org>; Wed, 3 Jun 2026 11:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=; b=Sy
	FYwlGagsxvh7ElOxJmaihXiqez53lfLpIWWl8M297FhjleULl5awjFAoM5CCEWiB
	JvXI+mZLsZQPYSnPNcg2ugnoQ/gJEUl8hFeBJujbGpipnoB6KK60ku7kENQ97OWA
	5Y/dnbMSMl+swmylyF04SqbWrrIOMrvp+538/VQuHGmfDt4QM8n6aJnQps0CPeQQ
	Zw5xpD95r/bTbUfArT1S42IVDtiPxePAIKB86A54NhuZ4lBvfoIlKToh7F1xnAco
	R3BVyIm8rwKaAb/B6rU2fDdMyufOt99LQP2nwge0bnpH662XZoHu41TfCP8gn3UN
	eZaHisN6F0jKdQZxaU/A==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabbt6m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:14:02 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-43ccd5d5357so4233424fac.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 04:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780485241; cv=none;
        d=google.com; s=arc-20240605;
        b=jjyZzQd7VXydsYcr+1Xb7MSCsN0zmzCLovrrZBT9+uS/u1uATTi6wcfdpMKOOXaGE0
         e1Zmz/8S4VKgev1lahGiApnlM78O5oyL7XKppUdibZcEQKe8echh335FVJiEA+jrStu7
         WOUM0jkD9Cz0sBVNykNdvWX0D4Rv0z6cVtsq+Z5UO1ghYWh5PBMjldeXQMLcjDctlgXP
         C/zkKQXPf8i9Yeo19cHxIhvxrDBY4V/s4P0b0023AFVXJ9i1wqti97bsGu4Kuv4Tb2ao
         /17omI0OwSAa4VRIQgJ7tGz1mqOPu7LX3S0JKYIzbcRECdisv7nZEswx3/gYmHFIkZGZ
         oP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=;
        fh=+TVw5GGU8PXNVZj1NVga6n0F+HOOu04PxvjyNZvjILU=;
        b=O3HkJ2ikAHR88p2iSy87ZQ+ezM7IPIdDdM1/6xtlN3gFWVRqxsBPK9yurRfG6KDxHP
         YRcxloWs1MhnksL8woisHqrJ6hyr4xoEeYCqS1XW/xjXgoi0wb6iFXwCeXrSmtOBlcQC
         Fh4GQcy+qbyD7cQaGX20+QtVDtau7uKm5eAD2NZHN8Y3ku4EU1o8eehlhI9QA2bo3O3H
         z+7bpD1T0Es211Ec9+Sg3Pkj7eO7uMMQ4JfWMJKei642/K1WSvo8o2cUN3G/RqjvEQcK
         x5/j0qIX6ONTOVuNRkgzbDxdLmxcIgZm+kFdLXvSVL7lKpR+uzKeNnw6OZwvE479xXzx
         GoZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780485241; x=1781090041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=;
        b=ZMT4jcY4SxKVBIo7ObriG4J0i/pcBqJ9zDSy0Oj29nWI/wuoBpaqf7p/ExlvWTZZ0q
         CNtcxrSXY0PZ37gEjFajforGGp+XKofPwLJ8stBiAuZXoneTWTeShQAYXSeIgTiQE2KO
         cpvbXgVFLj2CzIs8k0l3Xu6NPSVc7myNGRY12JcvGx0RW5erfPmfwnXnfPkct/pzM8z3
         8Li46cXMXJOnQMS16jyXLft6Ibxjl3E/4g9KUect5eQdsmBR/Qh04btQrGRMt9rb1W7w
         kvWzcTpN4isXL0n6Oy6QwJnZ7XAyrUJQViRxiomth1eAmJen7vbUbaBUdfCgA9OEpFlu
         6A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485241; x=1781090041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19tJFy9lIf9VnTinb1+YfhqFSRdeYqD56zDrzVGVBoM=;
        b=k03YAgw+P87UzVq6EgW1slGFHnNXh06b+pmd6AX8YlBqvusRzwPY7SO9Vk/kSp8B9l
         Hr2K6N0pDX5Jn4XWg/DgEgCfFHPska4pKtob8E69Hvdan8cD3niRZBaDXAmF+hj+zUXL
         93WdImCHhhvQo9TqhC6MBTfpfrsh+G20tzVb4/1vR3j+NcGI1uDXTIjWl4WLrY7ztaes
         tJ38KJdRDvG6eBnInKJ5ubKCuswigrpYSsybt4i3JGs90PkIDvs8AbFPTQ61jS7QlQGh
         o2r4KgDFPp19m2g8JLi+nOifSj5zqasfI1NTkr/H9lslDeU6cON1BRaUaYJ2Xxeou5Pq
         Fs4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zP9j3PPXSD/TY6o8pzen7ak3RekwirroJC1Im74BtA5zWKZned9Y810X4mLLKfYxqbNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleYNypRHk2tU5munhSAalA0qF6ZOdlv9r4cbhznrb+6IMhMht
	4aLBtud93bfEjUSill7uYz+Ld2MOiR1aT0RssdXlNYxjHWpKvuVFXPCCg91EMxAXUpXx1A81/B/
	dJPyRcWeG5i5uX72o00XLLs9/lkaduJ2bSu+twtuVHjsjhkJak1UlM8ClU3FcfPxKIi9R+wVSEn
	v2FjnnwIOV6UsusqtTocA/l4BuqCziGg==
X-Gm-Gg: Acq92OHZOOM3ZKJNDca81zjE67nIUrqcFHJVVcdmVz2JYwlqRIUu+Y2lmpmW7rc3Pu3
	JARA4ZSPbKB45wyFT5VLBY8OMsqKk7Q+mdjvfnhgbYavM2BGCT9TOBz3kIIu/AeQRiWJQiixbKB
	Oj3g1fv0Wc6jdVXK5M4X3vq/3ug6q37cBCy+VJyq3ewsBIqrNAMMLvi1qviexDrx2vG2pTAOjYt
	8YSi2Yh/whGqDu0Tg==
X-Received: by 2002:a05:6870:171b:b0:439:d504:1465 with SMTP id 586e51a60fabf-440db44d16dmr1912790fac.5.1780485241411;
        Wed, 03 Jun 2026 04:14:01 -0700 (PDT)
X-Received: by 2002:a05:6870:171b:b0:439:d504:1465 with SMTP id
 586e51a60fabf-440db44d16dmr1912767fac.5.1780485240990; Wed, 03 Jun 2026
 04:14:00 -0700 (PDT)
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
 <CACSVV00dNWgpNVU5rB=Hmg+3oWF18yTyfKNr_tWesjoP1jMxwg@mail.gmail.com> <5e6948b3-d235-4b61-aed7-e8b4d0f5b452@kernel.org>
In-Reply-To: <5e6948b3-d235-4b61-aed7-e8b4d0f5b452@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 04:13:49 -0700
X-Gm-Features: AVHnY4L4Mu1tTTnLDgXjw8iz5Wj3eHB3OSZ6g8qAAhd22vyCAP_N07hQtlCZoOc
Message-ID: <CACSVV02v0Fuc6=Rqyd89D-_tcSjEXuQmxz0+2-4aoRAEwJE4zg@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwNyBTYWx0ZWRfX9jtWoUfW/FF9
 Bc/e+cLhRzfizJK2C51VQ6j3h79/RdQiZJ2mMKAMPTERE/2wxK4yph63+jqm+7wDp8zJrNioqOq
 oYBz3ZDOdI7d0Vub9TJx+YrYL1GsRMVqvJn42ik4355j8Ydv1iwIHnQfwYDLITg0tTJvpIxmCR+
 2Rhv1ctsRtoP03623EuJNIN1kR8OtpalbJOCxoxj8UOpei6Zw+rM1457PVwe13/G3c4GNKKgonF
 d2TCBV/Q2Hwc/tBs1FnAkEbEtgnqqcDPt05Pe1xVFaOO29MKRPBrgxY9jhxqmcmkh/o18lvzwet
 hXxaiIOgOotPbaK1weorNvhLJ5NLBfuJPCoJO/w9uWpjf1KAkwxSCh4ScUYnIhyJnOFd9gKX0Q2
 3t+SSO5aXb4wg5OazHgtc7fVX83CzRqncYmY4bfF5SOj2m3KSva/8yKiZ6mh34CDQRUjLGtK0yo
 l4BlQnkE80Enj+DkDaA==
X-Authority-Analysis: v=2.4 cv=UqZT8ewB c=1 sm=1 tr=0 ts=6a200c7a cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8jdotb935GZv83SU0eMA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: pj4L9VwdG4hv1I7kaxBzqqyi2LusFO94
X-Proofpoint-GUID: pj4L9VwdG4hv1I7kaxBzqqyi2LusFO94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030107

On Wed, Jun 3, 2026 at 2:17=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 6/1/26 16:39, Rob Clark wrote:
> > On Mon, Jun 1, 2026 at 6:32=E2=80=AFAM Rob Clark <rob.clark@oss.qualcom=
m.com> wrote:
> >>
> >> On Mon, Jun 1, 2026 at 5:50=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka@=
kernel.org> wrote:
> >> >
> >> > On 6/1/26 13:38, Christoph Hellwig wrote:
> >> > > On Mon, Jun 01, 2026 at 10:16:30AM +0200, Vlastimil Babka (SUSE) w=
rote:
> >> > >> > kmem_cache_alloc_bulk() returning 0 was considered a success in=
 that case.
> >> > >> >
> >> > >> > Either fixing kmem_cache_alloc_bulk() (and the comment) or fixi=
ng the
> >> > >> > user sounds fine to me.
> >> > >>
> >> > >> Would it be wrong if we just returned true for size of 0? Would s=
omething
> >> > >> else break?
> >> > >
> >> > > I don't think it is wrong per se, but it feels like the wrong kind=
 of
> >> > > API.  I.e. I don't think the MSM caller actually wants this, as th=
ey'd
> >> > > also do a zero-sized kvmalloc.
> >> >
> >> > If p->count is 0 then indeed there's a zero-sized kvmalloc so p->pag=
es =3D=3D
> >> > ZERO_SIZE_PTR but then nothing breaks because nothing tries to deref=
erence it?
> >> >
> >> > msm_iommu_pagetable_prealloc_cleanup() has a "if (p->count > 0)" bra=
nch so
> >> > it seems it's considered possible. But then the rest of the function=
s also
> >> > seems working fine, i.e. kmem_cache_free_bulk() of zero size does no=
thing,
> >> > kvfree() of ZERO_SIZE_PTR does nothing.
> >> >
> >> > It seems to me kmem_cache_alloc_bulk() returning true for size =3D=
=3D 0 fits
> >> > naturally in this world and is less likely to result in a gotcha?
> >>
> >> I think I was probably expecting kvmalloc(0) =3D> NULL ... but it
> >> happened to work out before
> >>
> >> Adding an "if (!p->count) return 0;" at the top of
> >> msm_iommu_pagetable_prealloc_allocate() seems like the thing to do..
> >> if you want, I can send that patch (but traveling this week... so
> >> let's see what I can do)
> >
> > Aaaaaand.. sending patch from hotel wifi doesn't seem to be a thing
> > that works.. but I've tested the following w/ deqp-vk cts, and works
> > as expected
>
> Thanks, I will amend the commit in slab tree with this as the easiest way=
 to
> go foward.

Thanks

> Just a quick question though:
>
> > ----------------
> >
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_=
iommu.c
> > index 7d449e5202c5..ef744d154bbe 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -332,13 +332,16 @@ msm_iommu_pagetable_prealloc_allocate(struct
> > msm_mmu *mmu, struct msm_mmu_preall
> >         struct kmem_cache *pt_cache =3D get_pt_cache(mmu);
> >         int ret;
> >
> > +       if (!p->count)
> > +               return 0;
>
> We know p->pages is NULL in this case, right? Because it was allocated by
> vm_bind_job_create() using kzalloc().
> And the job can't be reused with a leftover value?
> (msm_iommu_pagetable_prealloc_cleanup doesn't set p->pages to zero).
> Or should we set p->pages to NULL here.

Correct, the job is not reused.  But I suppose setting p->pages to
NULL would make things more obvious, so no objection to that.

BR,
-R

> > +
> >         p->pages =3D kvmalloc_objs(*p->pages, p->count);
> >         if (!p->pages)
> >                 return -ENOMEM;
> >
> >         ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count, p=
->pages);
> >         if (ret !=3D p->count) {
> > -               kfree(p->pages);
> > +               kvfree(p->pages);
> >                 p->pages =3D NULL;
> >                 p->count =3D ret;
> >                 return -ENOMEM;
>
