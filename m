Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F734A3D40
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873137; cv=pass; b=sXMRWNFeqffd4QAwguDnsne0hPqPYyw2qlCbBjtJuxjca9yjKZF+DeA3mtI/gr9nIBMXgOHIgeyNzkuffoAQS5HPPcv29s6GWU9ay05K1CQrzkMoewjPT+UMFW/4w/gHCNWFoOSDT9radRN4bAjD2WqJFeLCqvRQE/uARPOAhWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873137; c=relaxed/simple;
	bh=skO6HOeEOlSoI8HYXQ1xBxBxbaOcIwy1hi5C/W8lSm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsviVwJ2UBbx2FlqaEnCdis/W5p7D3wqdluBRw1Et05jr8rmj07Qb1/QodCZKY3nU9sgYvf/tArrjpUHasxALsH9/+Z0StM1kQwwdhH6njHTYR2VAVM6aovbTeFK6bnT3hzDjYn5T69uxwLBtWSO9C2JyUnvGUWdBDpbTbDaYys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSHQvlV3; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSHQvlV3"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5337c7b9937so1121cf.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 09:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790873133; cv=none;
        d=google.com; s=arc-20260327;
        b=Jg/RBVJf4qLPtGOJHmOlX+k95rKZkfCmBsybh+uYfF7lnQUYxmrwA6VQeT+kWIKFsl
         jwE6J6amWAs8w//711BFbs4oNWF6VHZyfitHYhf/Lia1BfUaVzekXtaka8JdY4OUWQNe
         ykeDI7xTpjONJUgFbVTUsqCtZWYyjfoX7J1T+X88oFBmn0GcpObSReHjLrAXmpjrD0BL
         QaqOkexaeQIZEH7Ahl91MuZy0bmVdxBqN7q12oqzJEcuROd0fRu4RxILUyyE5R3UgBHi
         TU4hc9Cs+9FtAMMrw+8XVtg9FvFnZ+tdu+o5CofSyM4Yl2nS+U1fQeHW7XsiIPb8momp
         yZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        fh=nRgXSK4WwCs/fTGo+4AIN/CIscQ7wulWfNGX3bdM7yI=;
        b=f0Fso51l2ik/wAxxGsrU+B7IPD5Mm5cQofU9Lx7kQowFkEeeiiLWjSGHqUS94D8h/q
         UJC3ePN0cDwFjle6Vy+gpjIilpbiKRZ3oreJ5N/NknGF0naFn/ItjBes08E6Uchq0EDl
         ohjDJwHj9vmQImutdBNtNzrvOHVf6EHRDEqAwU+QdvMN7tMLNIrTEvTnP17KA+5CtMLT
         XXHipD2ZtWTkJqT+b9medL5zWaeYG3V7O8gI1hgh7wqLWXk+5g/0/aPamCn2bd53sLYJ
         1hJ8rEE8GZihDnhKWZIPrl9bWBpvp+TLZ5qngLK2JBj3CPr60jG9tHJvsqBEayM8j7p0
         i7yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790873133; x=1791477933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        b=dSHQvlV3ttXf+p0UrKNvkc+mwmTE521P+vXOYLKzyAFQ7uoAytn8r+U1gLRKQ5iyBt
         Gjretepz+PLrjFNLaNi9m/aNN2dfHPwCeNxI+sPGsbyY5xmyBUkyalmsoZzzWOQZTGi3
         vzIo96mKt+QGBeyJxX2juiUd1AJZujGhWGxro0WYQG4gmF4/lcJoed/1a5KjkY4ly8SM
         A61aUTGBspAU+wK0M/GpQRhHs4Lk4rFehX/PlJJAqgCJXUR/PuzYT0Yodf928IYWRTUv
         wbmhVrzViTLgEteqKxdBbCSg+l6yj9TrSNj0bl9F4IpsiZSwC/tFQ3LKKDNiaLcM2vd9
         73Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873133; x=1791477933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        b=aSBqKdo1rO8iN5HnFA5nMVNjf2BYHJmpuku996vrYAHip8e6WfQJpxKN2B6l9thCaG
         i0yWs5b22IIFeB42rUZrq95rLpoFskOIX1xNsKeUHke0PoGbySZV3Snt3sUFqIi4+vUF
         G+GsZq7FWUphyptIocyRUxhnPSylg4f9xrKyELT6Qn7NlGnQ4p2EScubGHrFzCaA7Fz3
         q1NWmFYFiO33XUthzYZuctau9ZS/LV0gMLlbyjClpuZZVUnmnL/dwXvsRk4vK6iNz9uK
         V4sF33rDtQqb2qd7HF4BcPqnZk0tsepT5Cm+aSzYckrwSFjGqCUBkksxF2bgRdNq861R
         4dKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBVXLOj5IgNV+lcIlu3C0u9bXeblkYyXIDbYqwJD1MymVieqOXiATfHSVHQxebtmjeySY=@vger.kernel.org
X-Gm-Message-State: AFuF++n7zB7G2WXcsrqfiKKuJwel7BLWf3t9soQlBTy9HPyh+cDpS89I
	bhZ54GP37pH3Wbo6Lnz5D81Ek0ley75DcqTtqSIiFWY8kAqB803+KqoSTx89Mjf7HC+/WI9kvPe
	XRHyqQEFQojmrlBQad0YvpjW7h/RCHsb7PwaCtTlQFUq2qMnlku39/j8F
X-Gm-Gg: AYBFou0G3hGmZ/ZDOn/lZn8uFeaHxGVVnpqlUWDSAgMHCv8/GA9wr3wd74ggBFiFpm2
	zXy3puEBcLfIWWJN2ncSNvHP+TXbqJrU/sdzvyuUHob6GIeueMFwMDuv2vBqSq8TiuyYbi6w99w
	KFOsPDFrGG8FVdk7cNyghPs4NhjCDwuJIN91qGTZ+4nJBLQ+acwhIILpfujwytdbV1jRstwpYWb
	HaBM4stzVMtgVcgZWl0CwxyosnmtQPyw6HTVW8GS8Q2f+Or6P1jYM8RSUJ9diTdJAIjMPqnduZC
	/wRI8w0+8vGuYKbp/r4/D7xYhaD78YROJdZ9t25WdCs6e9VGDdRIlekj7ZNsl+wD
X-Received: by 2002:ac8:5cd4:0:b0:532:858d:e791 with SMTP id
 d75a77b69052e-53389203f68mr14532881cf.8.1790873132647; Thu, 01 Oct 2026
 09:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929182108.794434-1-irogers@google.com> <20260929222332.973435-1-irogers@google.com>
 <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
In-Reply-To: <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 09:45:21 -0700
X-Gm-Features: AclHuK_uPGIN6Z6xFRRwa7F-fBv3kGJch6oICz0HkXG7IE_sZqEVpHGVInH4o1Y
Message-ID: <CAP-5=fXCL7bd08B_i676eVwwvQ7XJua2XTvck2Nu3_ujBD=uGQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf/core: Replace perf_event_header__init_id with
 full header init
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, song@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Sep 29, 2026 at 03:23:32PM -0700, Ian Rogers wrote:
>
> > Rather than splitting header initialization between callers and output
> > callbacks and saving/restoring mutated header fields, replace
> > perf_event_header__init_id() with
> > perf_event_header__init_header_and_id(), which initializes header->type=
,
> > header->misc, and header->size alongside the sample_id fields on each
> > invocation.
>
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 33210aff3ee6..c1b2d0c9b2af 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8119,13 +8119,18 @@ static void __perf_event_header__init_id(struct=
 perf_sample_data *data,
> >       }
> >  }
> >
> > -void perf_event_header__init_id(struct perf_event_header *header,
> > -                             struct perf_sample_data *data,
> > -                             struct perf_event *event)
> > +void perf_event_header__init_header_and_id(struct perf_event_header *h=
eader,
> > +                                        struct perf_sample_data *data,
> > +                                        u32 type, u16 misc, u16 size,
> > +                                        struct perf_event *event)
> >  {
> > +     header->type =3D type;
> > +     header->misc =3D misc;
> >       if (event->attr.sample_id_all) {
> > -             header->size +=3D event->id_header_size;
> > +             header->size =3D size + event->id_header_size;
> >               __perf_event_header__init_id(data, event, event->attr.sam=
ple_type);
> > +     } else {
> > +             header->size =3D size;
> >       }
> >  }
>
> I've renamed the thing to perf_event_header__init(). Also, I've done:
>
>         header->size =3D size;
>
> and restored the:
>
>                 header->size +=3D event->id_header_size;
>
> and lost the else :-)
>
> But yes, this is better. Thanks!

That makes sense, thanks Peter!

Ian
