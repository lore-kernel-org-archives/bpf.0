Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D0446BE9
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981137; cv=pass; b=KS5jRuOxnwlxNkOdoIDBZyUHM/8qUhaseMyQXnqjU8+ahQh04RNxbEeeRMUdAlESbGC5z4mFJsSKQc5KSEGPuOIaQQaZP8n029f7Loys2HdXAA9kb+JECB5HnAWeVDWHc/zCTIOrAhY3VDIc4AJkAH+KujNt1HlFZBpDGtpo26k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981137; c=relaxed/simple;
	bh=PY7qzzbWswp0HpMC972VMNYk8kY+rk9/Sd0tp/OxWPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4bK/+kHtZrwUuHR92uImgNJE3otNDwAnhhZoOJWVeLOW+Q4wMj0Nehsq6Bm0PRo1zOpMo9nzex/gbJHefUqgBzHBa1AwPtvmuAqc8ru9FkeC0d2GjdHj3OfvCZ895f3TkpuiznJeEIl0M5c65BuKvz0T8oeHtAKwNkNFKz+xjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=wAU1XmUK; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=V9gt0y8/; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="wAU1XmUK";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="V9gt0y8/"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HECwur3700675
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=default; bh=smwG5wT4FIAnO7jDSO8gV7YGlt
	w4ElUBgoeHacZ+F8M=; b=wAU1XmUKOZnsyiN+ExasVk4b2sdUcdK5cG5RmYw8px
	zfm0NhhQb6PVd8kvFuf24P5s4Dph08qj+qnYwaQx4AVrCMPoW2rYbAXz1i+ACjK0
	ZF7XTpI+8Mp5Mt5Bj3mL/kk6pYelIqyHr6v51vdCgC54VDgzXEXyTB+hIfWKp1qX
	ojedVR5ZeBFI3/N/So/T1e7HkVVPsRPRrsnMeiTnGkGXzuZ0rQsMwnyZp9mcSW8e
	rkfjQ1iMU+SJ1J0Vcdt+enMdxb76Zns2oO2S0qHCDJq9OX5oiXRjhz7zWrUN4vbt
	mPKItRma2R5DfjTrfdTecx0EjI6VHG3pGbVfxJZPHbYA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4g43v9raj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:32:08 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836c30d4695so128783307b3.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 08:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980727; cv=none;
        d=google.com; s=arc-20260327;
        b=E2ivaumQQjwHgs0SsfGtNpYB9ZaDANYk61IPWuQ4alXmg/PSEnfuB7f6YFmktpEAP5
         Mb3g0S0puAv0Hcqc6qzixIAewMgslPpWIrjld6gaxfmbvNsgWX8V2VcXuLly+cqp1/pU
         NAN2Vz5s7xH+vYkDPIdduwWipuWwl0NpW0AR/SrEBM+qERHu9TGGSMb7Q15y42IJZp7K
         P1zXen71TZhsTuNEWOxtjfiCoNHTlF7JymEFJVBA7SlHEFofvrTb5yvN86xqIH54ZG+F
         T4ASzoL+vevFWefVCuaG45ZvSE67dVxeyj7gQZojPUSDvUQc5hdceCosiI5pQtS922iS
         FmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=smwG5wT4FIAnO7jDSO8gV7YGltw4ElUBgoeHacZ+F8M=;
        fh=O15/nwl8HV8G6ieXo2p7UI0Ao5Ahdq1tXaJVMJ2UZS0=;
        b=CUTlrTP3iFrFpmlYoE+DPEdwiRHckcvVObiKwVZZGoNiTQz1B6dHjMW9UfWLNlT9y3
         Uiphu9DN0oA6/yGufsf4t3J2aTNFfBwg0rZ1zb9KoP5/4hISCdK5By6ECXshzjDkLJsS
         PgunpRc/Lj5ahsFKImQuQDtryPJHMFx9ksh4/43NnN/QwHoHMa6ZnEz4f4coSizbEFrL
         cDOiaPwCvD8OJKERkBILAwqr24fo0uPmTBd+LTg0Hd2+84YxTOiRFyfHL71yfjuDPwxP
         xGqzHxMyeeO8XceEgehZHK8C5rahTgMPU9c4lzLoMKYA7C39u/R/kXPoZ2djXZ7xZOF9
         RUEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786980727; x=1787585527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smwG5wT4FIAnO7jDSO8gV7YGltw4ElUBgoeHacZ+F8M=;
        b=V9gt0y8/QERa3ofdAQvSTwvvCWopS8Bh1fj3u3BrAWfoKKfquDU0deLsTriR3ArSIK
         Zh3LIBY1yMFPn94qbM9ZdLH6cSO6yBlUYDSpODL4rRRMUVv0nBE9P5azIskAECTQ6L7z
         tk1sc7ntr93SN/BDbccuGJ/Rm4Fr+y1W5VBOovcG8ImYCPS2avL8Jj2R8C0naqbQRhyV
         sZ8A1zmMQkOYU1da6oZPnYZokx8jLc26UuPB887NOxF28Q0M06XofuPMNXevTKsLD+A7
         +IwjBtye27kH1MZtoxaOyv2q945cUtVyDt7oapTdnnFIzqYUnDW9xIuLFeU0ZZ1llo26
         Defw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786980727; x=1787585527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=smwG5wT4FIAnO7jDSO8gV7YGltw4ElUBgoeHacZ+F8M=;
        b=YZl9vQOOpPWM6l7QKvkjShX9asDEMNzzuNHhoyHF5kQ+ka2OgoFc8xknmNyOHVIPe3
         Q9hFHYIJYLcpOAzMqNfFSBXkVUHbrgUvaBcqs0GnAzQBwikkucFwLIswhfr3CQkVo3/L
         4JgSmps6VzBa3vT2OsecHm09D8WuxG+4wjpE+BVS45L81QvgQOlbK/SCuG6arCgxNRR3
         hMiRDFTrk7Vfxx4+X9tvmnKiiFVjHtWXHeK/ddwLJyGeEziTa9nUlMV4C+ctKi6/nENY
         586nWPAd+Vsxx5Gn81lFa8owDCM9bqH9b2rrnPk45bgTw3D80R0JXR7RXhwjqv/QEavC
         hqeg==
X-Gm-Message-State: AOJu0Yw+k5surdn9ZW2Gap8YDZ200WCFZ0Ly7OlyPugC4NQyq1X9DPiL
	DDNyAlm9Z4wacqCItkQdu8HnzlRykyk890kKMJuyVufV0R1VWAiDNPlWDddAowyh9t+hfqjoePs
	/JMWLo9OWBxtONBmkry3B1+yNQmtbkAzM2yPL//qRT0n+LpPWtKuGxl5uEDuROjpvTLEKyA+lO1
	1pyqo1494+XSdf+vLOpxD1p75W18Uw
X-Gm-Gg: AR+sD12E3TCh68KmZFKxvaXUSktH1VORpFpsDJWyaJl1UD8lCQkg0Lj9kKnyGCdCR8M
	nQ0vtjmWar8FKlXFLBdzwQuPloqKfUVCNSTxUtKS5w96ioz5ttwQIyopRcqVVUJc33Ukub8sO/f
	FxBw3x/RvEitmhXglZH9wiw2M1dbFiYMfqhx60Nev+ZLypMdCWHWuXKKB2MQ==
X-Received: by 2002:a53:d381:0:b0:667:e8a3:eb77 with SMTP id 956f58d0204a3-66c72b45dadmr7317013d50.12.1786980727028;
        Mon, 17 Aug 2026 08:32:07 -0700 (PDT)
X-Received: by 2002:a53:d381:0:b0:667:e8a3:eb77 with SMTP id
 956f58d0204a3-66c72b45dadmr7316934d50.12.1786980725511; Mon, 17 Aug 2026
 08:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com>
 <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com>
 <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
 <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com> <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com>
In-Reply-To: <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 17 Aug 2026 11:31:54 -0400
X-Gm-Features: AcwNN1W3pOG8zAq5_F0UsSTvcEKw2TwctnYxRKJ4n5wj_FMPosC7ronYrmzWYxU
Message-ID: <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: WB6zyK65SdcjAwOZh4RXERA8KmZ0M2Y0
X-Proofpoint-ORIG-GUID: WB6zyK65SdcjAwOZh4RXERA8KmZ0M2Y0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOCBTYWx0ZWRfX8YJ22yoVVg1q
 lcg4iTZ/+/MInPKPmAyO+bLY5dJOzoG0YIqTty52TpwmE1o60l5sMSl44ZxkWELwIB02LFg2PNn
 VtHqPbAJ9QQDcwNUJMEPOtQ7W2CLtQRG/uIIjm44eTlotskmVYP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOCBTYWx0ZWRfX9jHiquga9+lR
 hXFsQaCHkzxbJuVbKTlCKMVvypg8lHCTidD2HhWoIUS3S00IRLm4mpAnYeg3ITX45MPlpjrpB0i
 PgGHjDG7CzWY+0emH+UjLPGfEfGlAsF2EheEeaURmJ5bSnAd1qCMmRgh7mbbxVGFsSfKLW76uwB
 x0155HkC0py9lmv6GmUobmL5/mCQr2XaXuyo9juAxt79z08+ofncGdt2ia4ZoQ8mDL7oHDmEnt6
 I3dnz4j9698JnqUjWz9PEYzQ88meBCYTJOjpIsc4MXvjXj91YYb4X28OJjcqIcEEmSneIdYVaeU
 2YvzzofSAcpNn43SNRmk9nzXEdRgMKKd5jkWvc5Dcnm1QAyHOUwSwIESxrJVWl7n66itrsROedw
 1zz0ukfMU9DfuGzsy603ufHgC25lum8GKER4XaCFdlsjvVfwBb75kpsn2SIpaa2CjeD3Dt88/Xb
 dJJKsdxjgopn/4uPS8Q==
X-Authority-Analysis: v=2.4 cv=W9MIkxWk c=1 sm=1 tr=0 ts=6a832978 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=4LRa77Z5p0gEtPvPSDAA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11877
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170118

> > > Hey Andrii, getting back to this important topic -
> > >
> > > I reviewed the proposed solution and the code . An object-wide
> > > bpf_object_open_opts flag that means "all programs must be
> > > considered loadable, but maybe later" collapses two things that need
> > > to stay separate: a program that is not currently loaded but may load
> > > later (feature gated, config-driven), and a program that is
> > > permanently not going to load on this object instance (e.g. it
> > > targets a kernel symbol/struct field that doesn't exist on the running
> > > kernel, or it lost out to an equivalent alternative implementation and
> > > will never be used). Today those are distinguished by the autoload
> > > bool: false + never load = the second case. If the semantics of "not
> > > autoloaded" change object-wide to "loadable later," we lose the
> > > ability to express the second case at all -- every non-autoloaded
> > > program in the object now implicitly carries the cost and risk of
> > > being treated as eventually loadable, even the ones that never will
> > > be. So, every non-autoloaded program is implicitly pulled into
> > > relocation resolution and map creation, since nothing can rule out
> > > that it might load. For a program that  never will, that's
> > > wasted preprocessing, and if its relocations fail against this
> > > kernel's BTF, that failure is no longer isolated to just that program.
> > >
> > > Given this I wonder if it's reasonable to re-evaluate the approach of
> > > per-program enum from the original patch series we prosposed , rather than a
> > > boolean plus an object-wide opt-in flag. Keeping disabled as its own
> > > per-program state (excluded from relocation and map-creation, failures
> > > isolated) alongside auto and the new dynamic case state gets us
> > > the capabilities we want without forcing every already-
> > > disabled program in an object to be reclassified as "maybe loadable.
> > >
> >
> > Goodness, 4 month since that discussion... I don't remember all the
> > details, we can start a new conversation and go over details, but I'm
> > just about to leave for vacation and Mykyta is still out on vacation,
> > so I'd suggest to restart this conversation with all the details anew
> > in about a month of so, if that's ok?
>
> Defenetly! So just to clarify, per your advice from earlier in this thread,
> we don't plan to rely on the cloned sessions concept anymore and suggest
> instead to review again the approach we proposed initially [1].
>
> >
> > Explicit tri-state per program vs implicit tri-state (if not
> > explicitly disabled -> maybe enabled, if per-object setting is set) is
> > probably not the most blocking part of this. But again, let's come
> > back to this with fresh heads :)
>
> We will gladly review it again and adapt it so that it is acceptable
> to the community and can be
> beneficial to all users of libbpf.
>
> I will reach out again in the second half of August.
>
> Thans,
> Andrey
>
> [1] -https://lore.kernel.org/all/20250122215206.59859-1-slava.imameev@crowdstrike.com/t/#m93ec917b3dfe3115be2a4b6439e2c649c791686d

Hi Andrii,

Following up as promised from our discussion last month regarding
dynamic program loading.

I reviewed our initial patchset and the subsequent mailing list
thread. It seems the conversation previously veered into unrelated
topics, such as concurrent programs loading and dynamic map loading,
which are beyond the scope of the dynamic program loading capability
we are trying to introduce.

To recap our main point from July, using a global object-wide flag
collapses two distinct states: programs that are genuinely disabled
(e.g., due to missing kernel symbols, where we want failure isolation)
and programs intended for late, dynamic loading. If we use a
per-object setting, every non-autoloaded program is forced into
relocation resolution, potentially causing load failure and wasting
preprocessing time.

If that is ok with you, I would like to resend the original two-patch
series as an RFC with a cover letter, rebased and retested against the
latest bpf-next branch. This way we can review and discuss the
approach from a clean slate.

Thanks,
Andrey
>
>
>
> >
> >
> > > Thanks!
> > > Andrey
> > > >
> > > >
> >
> > [...]
