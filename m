Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C535F609
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742626; cv=none; b=I375q7MFV1L496LdHEb8P7h5DUUHrG4kPUGK3rgnI4/XkJFML8uywdbPQD1yu9RSC+w3+2VshU+GaJvZObHzaZnoO50A4DoFuZvQyRlzVrAv2nhnhpOK7LojJMdpjo5dtbC9uvK2iFBMo2hGNvcu7VKexJygR6S3lVePA0aQYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742626; c=relaxed/simple;
	bh=oeol2gSV4dr9KBYqACi2Hb6sPB5a+9K902Zz8mPv2w8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFFkKT5YNstXVheih6G/EqVQE4qV3P+LvuqwCUVt1zU7dSs4u7jJd5GwMs0MuONSGkUu4EV84svfCmcWK3Ig5EEi7pO+Tr8qanN/vosgKgB12VqhAgZoyoYS9rjxkZFXHr3oYB7eGdVq6VpJio+C2hUh8lqz+P0AYWr9rPzIe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqCOJ03+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqCOJ03+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so17147835e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742622; x=1786347422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3s+kSuKMf0kcK3CLN/8IQFUj2uY628NdmLuh1bGh/Kk=;
        b=jqCOJ03+J29rDI08czaXN4Ym2kvLtMwPhwVxlaoSXyzT56CW3xLtgsTvvLhNodU7nE
         ew4st3lzUJdnogTmKbHral64skmqj+r9nmZRETiBYXTYNzEP67rXHFioY6l1g4lekuhn
         3/l1AsNsKy6bwldj3x04cqGgdgYNdQXb0sSCRZgflLRpl+cgYleQ4w09AgRg9te/gk/A
         zA9ghBnTbqIaT/3WXYcgHwlTNfcP8mLZbfwVC/Ot782GpU3Ohx7Wy+WBOIy2qHY6zv7c
         kEMZH3bNe6NQVPKRMp+Shndpk2tuIGv0o7RjoeioCYp0gJ+fDqoUwNrLVSgT/JPHA4We
         V/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742622; x=1786347422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3s+kSuKMf0kcK3CLN/8IQFUj2uY628NdmLuh1bGh/Kk=;
        b=o1Jai1A0SNZiWGMGG8k+ztikEOMNIG/KpcDbUysyI8C90rtCE2SZ8FKZtTekJP5irx
         9XZ5wRwSNsnG3etBKX7/HIQsxhoEVOFTCJwX5xXTabwbHR6i7A/c73AYCwn0ubRYhDhK
         BUc5kHuvZSPOImUGeIrVziOoQ/oyy3aq6l0idxLko5WdgtReSUDZd+La7+lOREXKy4+e
         ExnSO3MVjBg8LOxBV1SUm/IP4+FIKZou2ONfAg0U5JLxflqcPFtCPAmFuIPiD9TY6Dv5
         6hKu0imrSGR2tsi5DCWKk8FjQPg6+CydBK/T1/DUhm/f+Cotv+GfXBR6YZohkLQcuRz8
         r0QQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyYOC5yokEMptpYgtRjU/T8wEd0qYpoUNYXymgDHiiOD4Xsc5dAlV0+FKJZl33+HD8XsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/j7e9j52X8U3gSiUepPoN4VvkEHn+71U/HDvLM+sV+AGblad
	Z8/yHbf3UdUWaClo/U8nXM/aylhQNyQNmSB3UD3WyxSgZwhsOrtuBN/x
X-Gm-Gg: AR+sD10M/JF6J+MJrlC8lEZP3fMeKTq1kboZxOE/vC+fsMfXQdRcBRJCpA9P3nXzG8p
	mKLAZnZIgIYCBvSBPgbFoCzUA6a9j7HT3GigGff1bz5ABVmUUaZA4hArYMI9dDqA8Lr87vfB+ss
	ljwoYBbLzF9BWzHkvXsqDyYLGrwbCqQ7L00KHknmtdPdUsR46Kj5dr4hZVqjB8+dNom7o76tCCZ
	TuNxWmSICgMfFsqR81zamJFQ3bvka+GBTkevsgP23Aqr37hpP/zFVQoSn4EOl0yoPSMajhUqvPn
	6q4Avq8a6gadwBb2/iKJ5ovERgReZYtS91tq44AQru9n8GMgR+zteaTcnMVIg07d5Anx582CJgF
	LSNNiJY6CdLUX7pzdGwU27ROd+CA5tXh/FFs//WY/eA7Ry2zG4xoy8ynFFujLnLAUnLRHY1Mmzc
	PFO6phEGHgRJK3H4yFwf1NQEt7GztkVMPeUw==
X-Received: by 2002:a05:600c:350c:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4980f23180fmr143249355e9.2.1785742622371;
        Mon, 03 Aug 2026 00:37:02 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199f2csm279174135e9.5.2026.08.03.00.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:37:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Aug 2026 09:37:00 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <anBFHILS3Ac-RmtT@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-10-jolsa@kernel.org>
 <CAEf4BzYRzFH+n7Cj2jKpcG6LOZJMh7O38=R7MnoH2jFKxSG1Tg@mail.gmail.com>
 <amykPmjhfVJlAevL@krava>
 <CAEf4BzaWoB-RnBqa62X4pzM0PBvn21ZA_Fh3P9pWZ6s5_Hjoeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaWoB-RnBqa62X4pzM0PBvn21ZA_Fh3P9pWZ6s5_Hjoeg@mail.gmail.com>

On Fri, Jul 31, 2026 at 08:14:03AM -0700, Andrii Nakryiko wrote:
> On Fri, Jul 31, 2026 at 6:33 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jul 30, 2026 at 04:06:14PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > >  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> > > >            void *, buf, u32, size, u64, flags)
> > > >  {
> > > > @@ -947,7 +970,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> > > >         int err = -EINVAL;
> > > >
> > > >         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> > > > -               return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
> > > > +               return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !may_fault */);
> > > >
> > > >         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> > > >                                BPF_F_USER_BUILD_ID)))
> > > > @@ -966,7 +989,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> > > >
> > > >         if (kernel) {
> > > >                 trace->nr = nr_kernel;
> > >
> > > this whole count_kernel_ip() logic above, why do we have it? I don't
> > > think we can have combined user and kernel stack trace, so how can we
> > > end up with PERF_CONTEXT_USER "ip" at all? I might be missing
> >
> > the callchain comes from perf event's callchain and that can
> > have both kernel and user part
> 
> in general, but bpf_get_stack and bpf_get_stackid never request both
> kernel and user stack trace in one go and we set add_mark to false, so
> we can't have PERF_CONTEXT_USER, which is why I am asking what's the
> deal with this nr_kernel calculation.

it's the bpf_get_stack_pe helper for perf event and we store the
callchain before we run bpf program in bpf_overflow_handler:

  perf_prepare_sample(data, event, regs); 
   -> perf_sample_save_callchain
      -> perf_callchain
         -> get_perf_callchain(... add_mark=true ..)

  ret = bpf_prog_run(prog, &ctx);
   -> bpf_get_stack_pe
      -> trace = ctx->data->callchain

the perf event setup is independent of bpf_get_stack execution,
so you can have PERF_CONTEXT_USER in the callchain

jirka


> 
> If it's unnecessary, we should just drop that part and not have that
> extra unnecessary complication
> 
> >
> > > something subtle here, but can you please check again if this whole
> > > trace->nr calculation/override is even necessary.
> >
> > as I wrote in the other reply I don't think we need to change
> > trace->nr directly, just pass the needed nr/count as argument
> >
> > jirka
> >
> > >
> > > > -               err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> > > > +               err = __bpf_get_stack_pe(trace, buf, size, flags);
> > > >
> > > >         } else { /* user */
> > > >                 u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
> > > > @@ -974,9 +997,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> > > >                 skip += nr_kernel;
> > > >                 if (skip > BPF_F_SKIP_FIELD_MASK)
> > > >                         goto clear;
> > > > -
> > > >                 flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> > > > -               err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> > > > +               err = __bpf_get_stack_pe(trace, buf, size, flags);
> > > >         }
> > > >
> > > >         /* restore nr */
> > > > --
> > > > 2.54.0
> > > >
