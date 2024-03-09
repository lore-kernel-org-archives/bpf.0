Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC312D603
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975223; cv=none; b=XBbnFgnQWycLFQJPKdzrI01/7iizDcQZN8ltj5+FQZjn7ft40m0V4lRujK1TnmaBfZZjktONI2eR8RNDuNo+fxuBJXddJo/7YLbNkyCpChfLXE3+ffmi0KCAR3KJvECdQSdQQKmGK+L6VOKOtLJysyJZ2PFU3fi9JhTRI0eQMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975223; c=relaxed/simple;
	bh=tWY1mwTX2/3R7Wxfcmz2XQUoEEhQ+9OIWg9nhPbP1o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWNn1rDg45AFnKFdlyzw/G0lZagcPKSmX+L9FgSefnOkkRiwUS6NTS8VglSO204AE1WiQpQFamL/QzT2gvSPlTorVRpV2NdrcxPR04ueZtisfenj/7HSj0UYtj5Ckbpski4Z2jFi2tNAPVEFINhg0EPWEB5VrPL5AfOYJbluIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=bD44JtBT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="bD44JtBT"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2509c66daso21364221fa.3
        for <bpf@vger.kernel.org>; Sat, 09 Mar 2024 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1709975219; x=1710580019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNdlMdkn4bMFHas/qBV23J69CT6Id0msg2LlxZZUy+s=;
        b=bD44JtBTbQQMlpfegrXY6g6VzHIRiEWPLA5SA/EKAjXpR1qZs8sfvBaqV2tOkJXPT4
         j6cjqMsGo+6TCbm/N2+zlm4+8mMFaFfPFVY4ofYOAVZbnda8D24l0Z6cvr6XcD5sixE9
         mrkNlg+eil7mro4DHBVw3v8ek4mPTlELzSe8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709975219; x=1710580019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNdlMdkn4bMFHas/qBV23J69CT6Id0msg2LlxZZUy+s=;
        b=Namssql0tYi0V+0h5SywVhwb+LJy9qo5vAE3wDtX2n+b/pVfbAf3/XTtf+1KvebwSB
         c+AK75btkKOnGETn3Zl5SUWRoE0P5BnV8xtq9z6+nrdyXuPJxWep543ZvoB3dsQqE+/L
         owxTzuDQySiaPgwdooxQyq3bA5B7xpf2fMzvEhjo0sJSxvLVXSr7/lA3+SFQoyO4Hv7s
         jlgozs4j56VVS/jWoBZ+Oy8+pH8+bQ0IrDgB8N4pi+7hBHwM0qln1AApgyxm4LKMBCPL
         VLLYb67UPjmjwIinCxAcG7/umAQwd/OlkXRKsawa5vEyGlM7cq862QmpzwI9R0Mxi+m9
         b6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOyU2BQdFDEWcJw7dqJTjM94xAdbL3SEkvsjt1OjI+hnP1B68r1SGD1JsaFpLbZKg8AAgc6zv92IGvuFR/0y8XAJlH
X-Gm-Message-State: AOJu0YyAHuxoMwNTzZjTg5HtLDNGAOO/rXyiQTJECLV+3Rs7sNXHvD+0
	ThbGUwbjFOZoedBHrWIFXFfeudfuHeB5TFqVimRWUf0NRSvIr/6eUyRvWEjiFaoIEkhNWpOZluR
	soc/7IY6yC44As1KbfmAm3MNgufeaFPov1N5i
X-Google-Smtp-Source: AGHT+IFpdRnYAABErZrctDTk9xaZbFcDKBNE/D76fhc3ClEbqi8MUiSIDabeDH3SCHBMdgDcwbD3SrZ3B4Jkh0jzKKI=
X-Received: by 2002:a05:651c:b26:b0:2d3:f3bc:bb65 with SMTP id
 b38-20020a05651c0b2600b002d3f3bcbb65mr1136662ljr.11.1709975219088; Sat, 09
 Mar 2024 01:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305155223.1823287-1-pulehui@huaweicloud.com>
 <20240307-oat-mule-10441ef7e94a@spud> <f399749b-85bf-4aaf-8af6-ea735c5ab517@huaweicloud.com>
In-Reply-To: <f399749b-85bf-4aaf-8af6-ea735c5ab517@huaweicloud.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Sat, 9 Mar 2024 01:06:47 -0800
Message-ID: <CAOnJCULGctBu6viW7PwpT30o2fZ=aApi6UaJKsB4qjMEaEQ2cg@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while
 not supported
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:48=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
>
>
> On 2024/3/8 1:52, Conor Dooley wrote:
> > On Tue, Mar 05, 2024 at 03:52:23PM +0000, Pu Lehui wrote:
> >> From: Pu Lehui <pulehui@huawei.com>
> >>
> >> RISC-V perf does not yet support branch sampling. Two riscv bpf
> >> testcases get_branch_snapshot and perf_branches/perf_branches_hw faile=
d
> >> due to not disabling such sampling.
> >>
> >> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> >
> > This seems worthy of a fixes tag. For what commit I do not know, but I
> > figure it is a problem currently in mainline and a fix should be
> > backported?
>
> Thanks for review. We need to ban this type of event, otherwise we will
> get unpredictable results. It should be with a fixes tag.
>
> >
> >> ---
> >>   drivers/perf/riscv_pmu.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> >> index c78a6fd6c57f..bc42cb95a97c 100644
> >> --- a/drivers/perf/riscv_pmu.c
> >> +++ b/drivers/perf/riscv_pmu.c
> >> @@ -313,6 +313,10 @@ static int riscv_pmu_event_init(struct perf_event=
 *event)
> >>      u64 event_config =3D 0;
> >>      uint64_t cmask;
> >>
> >> +    /* does not support taken branch sampling */
> >
> > Skimming patchwork, I found this comment confusing.
> > Isolated from the commit message, which it will be once committed, it
> > was not immediately clear that you were referring to the driver. I thin=
k
> > it is just matter of making this a complete sentence that starts by
> > mentioning /what/ does not support this feature. Is it the driver? Does
> > the spec not allow it? etc
>
> I actually just found out that the current implementation of riscv perf
> driver doesn't support it. After reading the relevant spec, I did not
> find any description related to branch record. Maybe I may have missed
> something or it may be supported in the future, but the current driver
> does not support it, so I think it is more appropriate to limit this

Yes. There was no specification at the time this driver was upstreamed.
The spec for branch record being is on its way for ratification and patches
will be available soon.
https://github.com/riscv/riscv-control-transfer-records

The changes look good to me for now. I will be happy to send a RB tag once =
you
add the Fixes tag.

> comment to the driver implementation. How about "riscv perf driver does
> not support branch stack sampling"?
>
> >
> > Cheers,
> > Conor.
> >
> >> +    if (has_branch_stack(event))
> >> +            return -EOPNOTSUPP;
> >> +
> >>      hwc->flags =3D 0;
> >>      mapped_event =3D rvpmu->event_map(event, &event_config);
> >>      if (mapped_event < 0) {
> >> --
> >> 2.34.1
> >>
>


--=20
Regards,
Atish
