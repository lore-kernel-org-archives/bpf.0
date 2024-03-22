Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862095FDA3
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126356; cv=none; b=SUHGRKfeWZXAZqK/XGK4Y+GtE6TZzgJe4ABcvNqeh33srF2hvalKaBtbtQrg4urP77/Qo/Q8/RxxVcxJTXb7Ggv39D21lWy15qzG6ukGQTGzSGSBzk49p+fqJXvTxBHGQUHhZRl2EXEuKi6n8OVhbZ8cFLVc8LvJ87+TD4GvvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126356; c=relaxed/simple;
	bh=UY9ujOJtr3Gvq+JMR/uMWqJ6cNkKm1xjmSBVb9lVlT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myys7rwwpGTmrll/es7rvjbdmoYCqW96O9eJUeZfjA+EPIGEsnlPTRuhz42VQyCbLvfeu+pK+RUpfQKWE//9Ei4lE6VCU+ABCkvBBgYMHx89HcH4ekfwbCey/Myj0eVsIvHp0nweUfdGnHJlyk8aWaOz7VTfbjk7OU0x5RbIR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnhMYfAC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnhMYfAC"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1644454b3a.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126354; x=1711731154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptm15F6P6FQ96NV2QFT0Vg9sv5KsI32kiRpNkfl6c6E=;
        b=WnhMYfACwWbAkt38oPRkbW39MMBsFJcN1+23U0VNfjiWFRq1FN/DEw7BmBc51bCSS6
         Zu9RJv41oWxU/0VJ41xdqvxA47ypmKoDBp5GQXTqXhEATSJ/AdCPROLkMSVPYgSSJx/K
         R0hgppkIFkcC9aKYUAKNigSgM86rR1ppTUC0x76xfpS9T6ujmm0DT16+sKMefBUZUkmV
         8jowd6Q+MstHw2MdRkel40WJ+HgxhsD1Dtp7tPqD4GBbAz6dUrSosIT7aex9pFUQHvEo
         DsH0N45AdV7TMmJQDbtwOuQ++T9Ya6Ed7MGPa6fBKJYHthhRq5NgQkXDbHATGJgn90NI
         2HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126354; x=1711731154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptm15F6P6FQ96NV2QFT0Vg9sv5KsI32kiRpNkfl6c6E=;
        b=vmTl7bja+wNkYQeniemkR0lOflhUq3tLuQ13dbcurI1QbSPr3q2niX1Mr4yo2NvnRy
         6+IWgQuOJoqUmc3uWk7aTZswjmjb6KPcx9x8jPeyRLPxlow2mlTV3iOfLFhE4vkmUqRH
         kvSw1ldEW4uPInQCf/eIxdc3Oh9aXXD2Aj9sO/YFS31N9qWxwvxHb3f2yNNNyA1ms6aO
         r5wFcvUNoGVUuwRlsxqO9JbvMkPpv622y02Vdwmjg/aoiOKGJ2H7OGQBSf/9dNsWC5wj
         tk+XFThhWzQIGlaaZgQdZIlur6ugjhuZYGMl6HvXGN4seFJRvzdpEZBCpOlkqGAK7G9H
         jQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7tuvyqf44VXY3nVVCBIiCv/BJM1jyoqubHXEYVrlHFR4pNIvuHglNMcGWTcjio3ZVXv9VqrhtOyWMW5TeJgQvd52G
X-Gm-Message-State: AOJu0YyrN912K8OWvgxYpE54KmbHKOhEcRjxt+zfDG/vwS43RUDTnA8N
	TpUVNCQGSKYhrAsYS4+bemnJr9EcQ7eAWHTQGyJcGQC4cxRwOxfyUOKXsZszE35xKJbi4OhzMIv
	TLJqFir9MoAEhzwmEHaFNZ9Ic4Rg=
X-Google-Smtp-Source: AGHT+IFq6c7S4J3Q6xDNdbo0OLX709LwqJdJlxVfdTW3bVXdcowQr0MPtznupDZWEvMimYAba9+aKn3LWms0mAYOGo4=
X-Received: by 2002:a05:6a00:13a1:b0:6e7:30b0:9cc7 with SMTP id
 t33-20020a056a0013a100b006e730b09cc7mr289720pfg.15.1711126353632; Fri, 22 Mar
 2024 09:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-6-andrii@kernel.org>
 <Zf2DzQmhI2e8UGrx@krava>
In-Reply-To: <Zf2DzQmhI2e8UGrx@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 09:52:21 -0700
Message-ID: <CAEf4BzbXOUCihfQ4iP-MSSrQt6Uy=9b=KAO+3K+eBJ+KywTFaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 6:12=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Mar 21, 2024 at 05:00:40PM -0700, Andrii Nakryiko wrote:
> > Add a simple bpf_test_tp() kfunc, available to all program types, that
> > is useful for various testing and benchmarking scenarios, as it allows
> > to trigger most tracing BPF program types from BPF side, allowing to do
> > complex testing and benchmarking scenarios.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> I'm getting compilation fail with this one:
>
>   INSTALL libsubcmd_headers
>   INSTALL libsubcmd_headers
>   CALL    scripts/checksyscalls.sh
>   CC      kernel/bpf/helpers.o
> In file included from kernel/bpf/bpf_test.h:34,
>                  from kernel/bpf/helpers.c:30:
> ./include/trace/define_trace.h:95:42: fatal error: ./bpf_test.h: No such =
file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
>

I can't repro even with a clean build. CI also doesn't see any problem ([0]=
).

Maybe we need to have

#include "trace_probe.h"
#include "trace.h"

Not sure, can you please try?

I tried to do everything just like we do it in
kernel/trace/bpf_trace.c with trace_bpf_trace_printk().


  [0] https://github.com/kernel-patches/bpf/actions/runs/8383349803


> jirka
>
> > ---
> >  kernel/bpf/bpf_test.h | 34 ++++++++++++++++++++++++++++++++++
> >  kernel/bpf/helpers.c  | 13 +++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 kernel/bpf/bpf_test.h
> >
> > diff --git a/kernel/bpf/bpf_test.h b/kernel/bpf/bpf_test.h
> > new file mode 100644
> > index 000000000000..c779927d3574
> > --- /dev/null
> > +++ b/kernel/bpf/bpf_test.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM bpf_test
> > +
> > +#if !defined(_TRACE_BPF_TEST_H) || defined(TRACE_HEADER_MULTI_READ)
> > +
> > +#define _TRACE_BPF_TEST_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(bpf_test,
> > +
> > +     TP_PROTO(int nonce),
> > +
> > +     TP_ARGS(nonce),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(int, nonce)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->nonce =3D nonce;
> > +     ),
> > +
> > +     TP_printk("nonce %d", __entry->nonce)
> > +);
> > +
> > +#endif /* _TRACE_BPF_TEST_H */
> > +
> > +#undef TRACE_INCLUDE_PATH
> > +#define TRACE_INCLUDE_PATH .
> > +#define TRACE_INCLUDE_FILE bpf_test
> > +
> > +#include <trace/define_trace.h>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9234174ccb21..67bf9659c447 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -26,6 +26,10 @@
> >
> >  #include "../../lib/kstrtox.h"
> >
> > +#define CREATE_TRACE_POINTS
> > +#include "bpf_test.h"
> > +
> > +
> >  /* If kernel subsystem is allowing eBPF programs to call this function=
,
> >   * inside its own verifier_ops->get_func_proto() callback it should re=
turn
> >   * bpf_map_lookup_elem_proto, so that verifier can properly check the =
arguments
> > @@ -2549,6 +2553,14 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >       WARN(1, "A call to BPF exception callback should never return\n")=
;
> >  }
> >
> > +__bpf_kfunc int bpf_test_tp(int nonce)
> > +{
> > +     trace_bpf_test(nonce);
> > +
> > +     return nonce;
> > +}
> > +ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_KFUNCS_START(generic_btf_ids)
> > @@ -2625,6 +2637,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_ID_FLAGS(func, bpf_dynptr_size)
> >  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> > +BTF_ID_FLAGS(func, bpf_test_tp)
> >  BTF_KFUNCS_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > --
> > 2.43.0
> >
> >
