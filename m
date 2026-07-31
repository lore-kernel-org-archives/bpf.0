Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E304408607
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504836; cv=none; b=rMJ+FTjlqFTID6YhIGTv2WbDe06PpMCtz7fztBuz3pmdxlOyiKQxzupeBzh70NAsuZrcwoFjSdeQQiX1aaQ8GNMpAU9hBFM3YYWlEnhafzcwXCUL4mQsfkqGycmw+X7n/lV0vs/m5tdd4383Ljs3kL8IJH58F7dqJ7Cl+Bpybnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504836; c=relaxed/simple;
	bh=RbZLt8fkSLnL2Uv6XSBaQNN6YA00n7rdXP+C9CoQQcs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9+hMGqslb3F25FEV5Cds5hUwbkr95rKP40j9XsOAJYhl6LLNqwjJ0Lw73s1Te+kNx1jlAitWvX42wG/1t3kbH15J10yudWfwanVSpd08j+TlX1B3Loy7L4H5wIEelshevdBjMHjDUgpLlxzLUBvDYy5Ci7URJ7ka3LSz1sKBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnFqc+sk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnFqc+sk"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1c52d920b8so143812266b.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504833; x=1786109633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gJi00OLthEiJEkSsClrj5TbmAG5MkWC16MQGorARHw0=;
        b=NnFqc+skIsMjIVUpXgomYEdBlaquWMzBXO/oS24hKJImU3NoZIWkgoIW0zWg3b8plA
         Dy/6qqWNUSWyD2jsOhRHxaptigEqgfT46m3RqrLJot5nMnXK1W8CbD/keVlTraCF4T7U
         SqwkrGOCcP/1Ul9jKej27DhY4llEdBzp5KYhJCZyg5Yl/BIgCX2bp9qarcPSMETxsqJv
         +4Big938osNMcmh2HgeHn9GSfebAcpFPggrHiRY28oZcIb7JWy4M2TfN1jD4+76N1lgx
         2M9vZqlCsZAUT0w2yljWJNMlg5WFY/ZzO4/Gux4rq5yqJ1H6PTLA1I2B1yRi4svQYqpi
         hPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504833; x=1786109633;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJi00OLthEiJEkSsClrj5TbmAG5MkWC16MQGorARHw0=;
        b=INK1SmkVi0KL4xW6ikX/7rn2y0TKo/i/0yY6iv7mPHAcp5lsBe6G/NjtZ1VeBZx4wr
         DUlh7HvR4TXwlcB15gxF221CqeJEoc/eIDyzwINQKsqKNd5T1/LPjkTBs9Fg8CQFzgdS
         wg+89ZLYQLoBTD6ocb7ZIoRRLJieApRgYps8ukYvwqHWmAnuCzIGDKu3Xi7Cf1h5kk3P
         CxMybtzlNwbHg+wg2YY8G3A4OfjyALO2c9ArpHsPc4T2kHFv/zGbn1u0jlPMDcKupCkw
         gNnIMz5I41E1XhpJ44sJXoPjTuO0T2FmbtrSuI8+vVluW8znGDlRg3QxA/3E60O+BOJa
         qWSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMS8PAF5u1yfPWwfBz8qkz7eE1+HSLwW6QJW+ySvpCShAscOmEIO/DOyL6pKVHPMXcj8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8BIBxTSDtGHyLHVHFV8jeJMHiBnTUHLgla1sumLTrPadGoIH
	G1HwBjznLSZPJueS59QnrcjtoTKz1Lp6EuNmvPOeYNhOmy1HB7ReSKlk
X-Gm-Gg: AR+sD116ZNsooDDVyJPq01Rvej3VbhPh7XzQHbNd9JMVk6lXei+/7RCSBZUXmP3HIyH
	QG++b/L8DOlBv3U8BCB6w+rrlW5zcSm9k+t5z4AD7lw++uyhBU87Ig6/Gv2uInLGByDDvveWMzu
	WYP/xVmGyoR8i/VOBBCR7Rc1nv0aHMb26YmuBm2Fg1fukPnv75r57aq/sq/fzCfghOMfLKi8Tvc
	uyYWLxjBrEs+O0qAtWBIV2vQ2VhVFdTDc+k7j8YvSeEKElocr401SFQa/ADMOuHmu7klM8zuyxL
	6SxTtznaogtZNyQu2QZrCIlAdIec9QG3nuA+XKH0ED5aCMr4Gf3wN6TauXC8doT1CesUAUkieWY
	oJusMpoHXtibaPKfsuxq2vREcynwxcYrQJj9Q3wuDt0MaZZ83UxXDjOtT3ZLnLbeLl86OM3cD6E
	gCSJBNFtWQDYQumqYsmUHkA8y04d6p6OdtWFSTKpNRd9Q6YS4=
X-Received: by 2002:a17:907:9449:b0:c1c:4887:7b00 with SMTP id a640c23a62f3a-c1fd2379409mr118335666b.44.1785504833311;
        Fri, 31 Jul 2026 06:33:53 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd44ebf2esm132023866b.44.2026.07.31.06.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:33:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 Jul 2026 15:33:50 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>, Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: Re: [PATCHv2 bpf-next 09/11] bpf: Remove trace_in argument from
 __bpf_get_stack
Message-ID: <amykPmjhfVJlAevL@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-10-jolsa@kernel.org>
 <CAEf4BzYRzFH+n7Cj2jKpcG6LOZJMh7O38=R7MnoH2jFKxSG1Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYRzFH+n7Cj2jKpcG6LOZJMh7O38=R7MnoH2jFKxSG1Tg@mail.gmail.com>

On Thu, Jul 30, 2026 at 04:06:14PM -0700, Andrii Nakryiko wrote:

SNIP

> >  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >            void *, buf, u32, size, u64, flags)
> >  {
> > @@ -947,7 +970,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >         int err = -EINVAL;
> >
> >         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> > -               return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
> > +               return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
> >
> >         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> >                                BPF_F_USER_BUILD_ID)))
> > @@ -966,7 +989,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >
> >         if (kernel) {
> >                 trace->nr = nr_kernel;
> 
> this whole count_kernel_ip() logic above, why do we have it? I don't
> think we can have combined user and kernel stack trace, so how can we
> end up with PERF_CONTEXT_USER "ip" at all? I might be missing

the callchain comes from perf event's callchain and that can
have both kernel and user part

> something subtle here, but can you please check again if this whole
> trace->nr calculation/override is even necessary.

as I wrote in the other reply I don't think we need to change
trace->nr directly, just pass the needed nr/count as argument

jirka

> 
> > -               err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> > +               err = __bpf_get_stack_pe(trace, buf, size, flags);
> >
> >         } else { /* user */
> >                 u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
> > @@ -974,9 +997,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >                 skip += nr_kernel;
> >                 if (skip > BPF_F_SKIP_FIELD_MASK)
> >                         goto clear;
> > -
> >                 flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> > -               err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> > +               err = __bpf_get_stack_pe(trace, buf, size, flags);
> >         }
> >
> >         /* restore nr */
> > --
> > 2.54.0
> >
