Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2413235C01
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565830; cv=pass; b=t+SkLfApgYJV0oJY7cjxo0dOo2Ol+GPKTtFgpmaxighl8+8yRfmuNUJvQjkmzhrdWC0LV6iCxY+viHphBLVhyw0wf9JM9y3Z8bnd/fmgIVBiGU3kinxU2LK8drIRCmlyy46oKkUScWcPfKJstVUIcUNwmPOFKG4tJPz5PFFBgVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565830; c=relaxed/simple;
	bh=LKFmCuDQNLkJpDjv10PTCN7SoRI92sQX+juYlxXSmCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Onin00d90PKbm8LMwW84rQpuVpS1DcAo5CLXl2IAb5FpNNwVpQRsU2HmutoMX3e8BADwkrFB+hZz3qGJ1gOHXoaxeCHQ6Ku8ub/H3R6/2K6Ade5YDCDEIiSbV/pJJ+RO1gU3F+XRyZKAF0q7sy7IUYDMbBqOOfFlR0gWPbW1H0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gkwQ7pQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hKgd3/UY; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkwQ7pQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKgd3/UY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6546us4m2477907
	for <bpf@vger.kernel.org>; Thu, 4 Jun 2026 09:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=; b=gk
	wQ7pQGrydVH4blqAd03q/e5Ae1bc6NbOQrmi8+rkuGoe4hzxNhqsJTwdZ7wdW/+N
	qDxXNeOTPUwizWZs2hH9w8/Dguipy6CaRuCRoLEcFNj16hvzbndv+YDWdp5V7tbO
	myZCEQ905ekyZ8KmSkGZ4nHoSkeaSZo90THNZ8f1Ow09YhZkoFIQTeHNfhZw9Vx4
	PFfg/aVoZC4rsLW1ANya/izCW3kjD78HPRL82MviYJ9f77AWmu3ujblBlbiwXYV0
	1gWu4CL/J3Nn8B9UV26DMYO+HnPLUwIs+kzQRLfroybnAOf5kfTrCEXsRYwhpABP
	B5FOeZZdPcS6JqR0hCZw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvgkwe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 09:37:07 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-440e399d049so466617fac.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 02:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780565827; cv=none;
        d=google.com; s=arc-20240605;
        b=NbDKsUWRozerGxAHUuiCKrCOO+tU5YMqCqWewSKUCXiNB7Kb1eyUkcoignOK+jh/mB
         Gy753CzgQXtUPSVkV79NEsZenouueAjcNNeTjEQSv7Zhj43EgFp/6sQKNAphX04XkOVP
         QyS9+Pd6eILb5qfEOMKyZ1HPzbGyOG7xS9WcmT/PTjQGM+8e0LTNjJlh/fTrN/NHvB1N
         MH9H7n7WcBB6FZhX3GrfkzRh7q3Qbw03ku6HYfLB/JpnqKVygXded5wyzXT2IhNp+8oG
         ZKUmpIyElcl57UrpcgjQ/4d0ShxnC97yOrMqr0EDFYLq9pPuB+w2shYtqX9udrW6xH+B
         jL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=;
        fh=/xkG9MosMCeLQPleOv/JDNtSUV0O0trVKTimAvLty0Q=;
        b=F0khnnQc1466kjQlX9JaeMaVhWO8N6zDhk3yJifk/jE+YP8QDHxmSc3d33hqiPi1Pk
         kNv7nvj14F2eYD9bvmajDBl07oPIXEAfp6SfEs0vcsNRk6CwHX3vw2MefuXCDsy3tcZx
         4UShGhEni78xG8c6GywmFfwPddreD3THs0dAuw0OsIckReshag/3ZRRS311Yl17xedrg
         IgAWZuaQ1W92sfKyO1z2/l/zXqT36cOGXiLZ4gMnQzGLAngKNB7ddaw12ZalSe1/QeDu
         PuJu/3M1P5NcACanV7j0ToEfMOfAdAOuGx9O9qAGK7s/DG+9jZFQgVyv+59L2206jdIU
         oClw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780565827; x=1781170627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=;
        b=hKgd3/UYOYkLn6Vt4jiCJoWhjU3CQEf++REHBScqG1MtabumpLwC9RKT1QDzSOVkzW
         5Hjej8nFe4FFnlmi3imAptcteDpfftBYMQqE/T+qGOFskaHDM6oW6metZC29PA1GadHC
         Mh00QfXDC4poTJJAqxGY/gmRGRm32+56z/BI6HRLa7mdBTFOcL7ntieksrsxudwfExJt
         kVEw+rr2a3ncxokBKwoRwPRQU3psljLRwWHeoQTqrSwVnpwr779e/7GNdrceGr2MKAyQ
         ko7Ai7QJp7wPy/t0aoxUvFxxQPVef7teClXNSmzsFYK0j/LEA4fjuLV7TW87WkK5/9p4
         80mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565827; x=1781170627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbH2Ej66t35eFH01LN7Yn1mCVFPgBbI2BNIp23nOi0I=;
        b=oBLGbzo4jPST+ne8Gk91r0B4AV/kGclpilX5nm8n+wt5eXhPa4kyzkUCR7B2bD56e6
         JN7L3zpUPlb2pgZXtCE4QPj9nJyROiqL06bItTe5Vq7QRk8ktm2CkAJ/kCd0leomtk6f
         5SebecM32MHdyexGkpR3HrDo/0gEJaaJjaxO7iFZHFIT89MRbzzObY+O7jZq1sCgPweo
         R3y5rO7s1ZcaWtJR1d+tzWk8HhhXQyyfMFJLvKiXYs/5Z7FPgzMkX26c4kqUN1Rr8WX2
         cKBo1z/ZoeWkFL1kOyUuZwkiNs6I6ytwe8D7kxKNTvvS5RT2JCNOne2hSz3jshrS701a
         d/UA==
X-Forwarded-Encrypted: i=1; AFNElJ8099BGCYb+zz+bzAvibhtvru+FGThtmYXqSKMZY+jooJBuZgHTpttYV/lH2CRS/72RFmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JeHRskPZ/DalNHhkha/SarNOoN6k7DIC8Hjs8JEoOByOf45h
	8a09XUSAL9fMQI52FW4XOKdr8fm8xSvtYloiH12PiCD+agLRJPt4XbV3lrvUdGWmQkMEeMakXMg
	oVB6EFzh4lpNhjwl7ORo30xtJ+ov4W/4x6Uwu1UmBIyt+9npGXCIr2TPU/7UULk4/XFyicdhJXh
	HuDbfYRC6r3/YP+jgVRaxMqSEj4AdPtw==
X-Gm-Gg: Acq92OE79fhSX6pq7EzXhCH9Y9j8g/NLnF3hsRgfJ3qpRGkO1ZAPTrMKwro+/YZVEr/
	IylyFrVqYJoMDuv1M0KsLOtVVu0cMnWDi+e+alw0Z3IR/8e9QCAmoTj1jiiQETJIe7/6AcwTa+z
	HmBevcuQo5j1pp02zaKcYC9wWVo5d7xUCS970Tj2dcKXSxGmzimg7BZl79Fa40LlRRH5/HOQ++I
	8wSnSwH46IJ5u919A==
X-Received: by 2002:a05:6870:d0d3:b0:43b:9922:9df2 with SMTP id 586e51a60fabf-440db7cf55cmr4593214fac.21.1780565827215;
        Thu, 04 Jun 2026 02:37:07 -0700 (PDT)
X-Received: by 2002:a05:6870:d0d3:b0:43b:9922:9df2 with SMTP id
 586e51a60fabf-440db7cf55cmr4593192fac.21.1780565826858; Thu, 04 Jun 2026
 02:37:06 -0700 (PDT)
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
 <CACSVV00dNWgpNVU5rB=Hmg+3oWF18yTyfKNr_tWesjoP1jMxwg@mail.gmail.com>
 <5e6948b3-d235-4b61-aed7-e8b4d0f5b452@kernel.org> <CACSVV02v0Fuc6=Rqyd89D-_tcSjEXuQmxz0+2-4aoRAEwJE4zg@mail.gmail.com>
 <b6f6323e-6f5b-4928-b474-bd2743eac3f2@kernel.org> <f027078c-6a55-463b-8938-95ede02dca3b@kernel.org>
 <29bd5886-15c7-462b-8a39-f2ff25269ddf@kernel.org>
In-Reply-To: <29bd5886-15c7-462b-8a39-f2ff25269ddf@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 02:36:55 -0700
X-Gm-Features: AVVi8CdLwF-PFxeKWBcz71YZzZxxEA0LQrJYMS3qkVqAqJLyt2EL9LT70o-g4fs
Message-ID: <CACSVV03Ez9uKw0WDm9G2HTfyXy8SLu9AFGGnY58z-GK+32DV3A@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
X-Proofpoint-GUID: gil35_QucdjDf6CwpqRsqQ-gB5km5fCJ
X-Proofpoint-ORIG-GUID: gil35_QucdjDf6CwpqRsqQ-gB5km5fCJ
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a214744 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=G_pyjxEXS8sYRXXvRXQA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MiBTYWx0ZWRfXxGfLK+9aw6EW
 /mOtWV4LWYTfGHUTbRcoHuf05Y7B6/ZjpBsGuDeuFRxMSGvJeHJuUti/nclGfSS4sIkuyASZs7U
 +TsTzmJu6dijOV8dnr+O4zDTzj+mPM9ISE/TbotstrPQVwPc+ocLfI/axjNYVApNJ15/5A2cst6
 5+nzJ6+irOHJVtKyeyaFnlPsx6LJyM1Gyg+xXYYuXOwZ64rk6+SeTyTix0euEyhffYCZcooyNhj
 Mv43JmkYCkZ9Avj/dpc+xB8owhN3/5qxkRZWJoxVcLEM8OChtqUNvv8u7VtF6lnXBVq4GYeH3Sq
 RSZl+RjIw6LAWFTZY6Dl6hVpL8HX8e/dgyDq1Xp4yk6PVqkTCZtlP19829W6MBpyAu9DizKzmPf
 K8PiD7FwPtNA5/Ttnm9uB18ADrM0C8J90gWLC1GGc88PUBPe6C3tVyJSozE5M6vDYBxkcFx5WD6
 qNowBcSXfC2oIG69ZFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040092

On Thu, Jun 4, 2026 at 12:35=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/4/26 09:10, Harry Yoo wrote:
> >
> >
> > On 6/4/26 1:22 AM, Vlastimil Babka (SUSE) wrote:
> >> On 6/3/26 13:13, Rob Clark wrote:
> >>> On Wed, Jun 3, 2026 at 2:17=E2=80=AFAM Vlastimil Babka (SUSE) <vbabka=
@kernel.org> wrote:
> >>>>
> >>>> We know p->pages is NULL in this case, right? Because it was allocat=
ed by
> >>>> vm_bind_job_create() using kzalloc().
> >>>> And the job can't be reused with a leftover value?
> >>>> (msm_iommu_pagetable_prealloc_cleanup doesn't set p->pages to zero).
> >>>> Or should we set p->pages to NULL here.
> >>>
> >>> Correct, the job is not reused.  But I suppose setting p->pages to
> >>> NULL would make things more obvious, so no objection to that.
> >>
> >> OK, did that, just in case. Thanks.
> >
> > The kvfree() -> kfree() part should probably be a separate patch
> > with Fixes: 830d68f2cb8a ("drm/msm: Fix pgtable prealloc error
> > path") and Cc: stable?
> >
> > ...as the commit landed v6.18.
>
> Hm right, but realistically, can there be so many pages necessary, that t=
he
> array to hold their pointers would be over what kmalloc() can provide?

Pretty unlikely.. IIRC kvmalloc won't fallback to vmalloc for anything
under PAGE_SIZE, so count=3D=3D512..  which is more than 10x what I've
seen in practice

BR,
-R

> >>> BR,
> >>> -R
> >>>
> >>>>> +
> >>>>>         p->pages =3D kvmalloc_objs(*p->pages, p->count);
> >>>>>         if (!p->pages)
> >>>>>                 return -ENOMEM;
> >>>>>
> >>>>>         ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->coun=
t, p->pages);
> >>>>>         if (ret !=3D p->count) {
> >>>>> -               kfree(p->pages);
> >>>>> +               kvfree(p->pages);
> >>>>>                 p->pages =3D NULL;
> >>>>>                 p->count =3D ret;
> >>>>>                 return -ENOMEM;
> >
>
