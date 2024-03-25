Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246D70CC2
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405163; cv=none; b=M7BIBRNhbbFaAH2I/4qy8LW8dy9PbPOGSKpfMC3ftpm+spxJeGd08iWe50LzcfdQx02ylIIMnPYxiJQeDnVcYarFGBbtM4AQETPfaq3YfJ2HVNur+9XIN4yvYP0H+XORDuQ+SeBjrJIKNHCEDZBvCxVN0KJJeCKixCuC0la/w7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405163; c=relaxed/simple;
	bh=WfLbM+Qv/EkSVlBx/KAcj/gHftQoPBY2M5SpQctEyVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEBZk0R+NcbrvGGArKx8cZasnf3ghA+NWeyKgmA8MlLWly1lzJEFJ230D5/VNgXTZRi71Ewq8FqqBm5b5DYEAZoYUgwKLvBaXwoX51SRt6jGgEMDaLaqFpD8vrdegXHtBbLgiGTgRYlFKAZLg0LekZHccu504t52OuQ7ChHlbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZkXhX8Y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZkXhX8Y"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2854810a12.2
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711405161; x=1712009961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRpJw47nb3qo24UoboNC1H43ZJwooSCjVe93b0r10w0=;
        b=KZkXhX8Ygu4U63NNT2q+u3J/G0V/l/9WPBLgqEO+zjRsJIk6RCOPRpRR37IneJEdEa
         u8/aIP3VHJjY/nmbxMZI8unXZt8jsTe5M/MAz0SnZE84ktP92TZi5Ws6uH/2mIIi7znu
         ik/HPopU2/V/5A56+hfnW1xDwo6aHCZp9f3NsHn28YUn1/z5zNqXDh31+wCHjo6yxw78
         GJ0YChC4ojlchQlkJvHrbhizFh2XPI6oljJNzhlBlMAijBJ1d2Tz90nTIp4NOwkFH+BA
         Hy4zhDtYPKOsCuiEmxF+I0nge92Jd34j9TOj45Inxj6ck050MsAbMuYFXYZMkdNx6r4Y
         sRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405161; x=1712009961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRpJw47nb3qo24UoboNC1H43ZJwooSCjVe93b0r10w0=;
        b=ZPJVf3Qg6nCp9lz6mWa20/5T8mcgiC9zgP4kd/6IVvPSI1fpSXVvG9ojqVzD193F+S
         0HREmvL3YtAvS8xJ12iEQQTmTO4vd32WlD1M78gST75mV+eaYT61sVpxk6L0GlG4jdmv
         pvRbijgugfW7GuhS4Gz0DFyZpN6pxUuhvD6JrFh16hhHmQ/QKOUwpgX4cGqt31TPTJKm
         qtFDrAPXxDSLe7koXO/3197+ezXCiZ6ZS9inBi1VcAlWIaeLYpE+Yt8YqzVq8Dem726K
         8uG/gB6IOjmY2On3PGN+Y9X0YINO5FCoxRf2ROFyogKClCjh90JBbRu7bWf6nkUzdtNJ
         wpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXawtM5tXvbuN1l2J6ErMTT1Y2B23HYm1Uy0jFEBynvw7tvkxx74hJRfUshhQEf7K9JqZlXtX5aKV7uZxawIyaW1Vx2
X-Gm-Message-State: AOJu0Yz9OyrcxnT9gnb4gujm0ZOFub4H20XR12J46FRASqdh3dsXXX+7
	Ljp09Jfcu3dP3z3SZTpVQY2mPvGQaDBRY8a16E14ptVxmqanOPo8q1D/6kTo0UR1JuH+5hACQz/
	MCUvsug5Q1F+E9/vcbm+p2WWwMTaEV41pulk=
X-Google-Smtp-Source: AGHT+IHkULMsXhzxFWe1BAvxkbkdcTq4NMcNFcREeKHEa1InhXa0fyTZIU6UR6BLH5p8KuAlkPdVayEQUJV5DPkjJsw=
X-Received: by 2002:a17:90a:e542:b0:29f:ce37:50d8 with SMTP id
 ei2-20020a17090ae54200b0029fce3750d8mr5997794pjb.17.1711405161628; Mon, 25
 Mar 2024 15:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-6-andrii@kernel.org>
 <CAADnVQ+SWwJMtdXj1s1RtzXJfjXU4Y41eNg+xzFXe2-DNUR8Ag@mail.gmail.com>
In-Reply-To: <CAADnVQ+SWwJMtdXj1s1RtzXJfjXU4Y41eNg+xzFXe2-DNUR8Ag@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 15:19:09 -0700
Message-ID: <CAEf4BzbNRhjALGK7LpHmHsnSHEfmrzserOy07RDyP3aSbF5HcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 5:01=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Add a simple bpf_test_tp() kfunc, available to all program types, that
> > is useful for various testing and benchmarking scenarios, as it allows
> > to trigger most tracing BPF program types from BPF side, allowing to do
> > complex testing and benchmarking scenarios.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
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
> > +       TP_PROTO(int nonce),
> > +
> > +       TP_ARGS(nonce),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(int, nonce)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->nonce =3D nonce;
> > +       ),
> > +
> > +       TP_printk("nonce %d", __entry->nonce)
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
> >         WARN(1, "A call to BPF exception callback should never return\n=
");
> >  }
> >
> > +__bpf_kfunc int bpf_test_tp(int nonce)
> > +{
> > +       trace_bpf_test(nonce);
> > +
> > +       return nonce;
> > +}
> > +ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);
>
> There is a better way with register_btf_fmodret_id_set().
> Error injection can be disabled in config.

ok, didn't know about it

>
> Also we have two such test funcs already:
> bpf_modify_return_test*
> and they can be exercised by bpf_prog_test_run_tracing.
> Let's make it recognize 'repeat' argument and call
> bpf_modify_return_test or 3rd such func multiple times ?

I'll add bpf_modify_return_test_tp() to not touch all the tests using
bpf_modify_return_test() and bpf_modify_return_test2(), if that's ok.
Existing ones expect some memory pointer, dereference it, etc, it
seems cleaner to have a dedicated tp-triggering one for this.

> Exercise of test tracepoint can be there as well.
> Asking bpf prog to call a kfunc to call a tracepoint
> looks like extra hop.
> Existing test_run facility should be able to accommodate.

You mean if I add bpf_modify_return_test_tp() above, I should pass an
argument of how many times that tracepoint should be triggered? Or you
mean to use test_run's repeat argument to trigger "driver program" N
times, and the driver program would just call
bpf_modify_return_test_tp() once? If the latter, I'm not sure it's the
same as calling the driver program once and doing a loop inside, as
we'll measure more of calling driver program overhead (N times vs 1
time right now, per each N tp/fmod_ret calls).

(But tbh, not having to use test_run's repeat functionality is a
benefit, IMO, we can have more flexible counting/timing code and
whatever else we might need, I'm not sure why using test_run's repeat
is advantageous here)

Not sure what you are trying to optimize for here, please clarify.

>
> I still don't get it how modifying the kernel is better than
> adding all that to a kernel module.
> When you want to run bench tool on a different server
> you either need to build/copy bpf_testmod or
> build/copy the whole kernel.
> But fine.

I optimize for having a single pre-built bench binary that one can scp
to multiple different (potentially custom built) kernels and run
benchmarks. Of course on old kernels where we don't yet have this new
bpf_modify_return_test_tp() kfunc some of benchmarks won't work
(raw_tp/fmod_ret/tp only), but that's fine, as newer kernels get
deployed we'll eventually get them even in production. kprobe/fentry
benchmark will work as is (which is why I'm not switching them to new
kfunc, so we can run them on a wider variety of kernels).

> All the test things in net/bpf/test_run.c will stay.
