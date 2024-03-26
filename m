Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A720B3E
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417424; cv=none; b=gPjGrWR9yJfjclItpa9dgAFRVoF2TCGJGfMzV2b13srSmEXa5vQA6qKBEgsfEFb3NCfguqXyF8vUKFkaWT2b9MatgRr5/9W8xmRoqugmhlPB135MqxdINvUP7b5C9GGD85SMCf5yq2UTnXttLy7C6IrBenVysdko+R2TkgGfBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417424; c=relaxed/simple;
	bh=Q9vCVPr2lVwsncKbFdiH8P4NEdJdZ50AH6XtE/E31O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECMAM5/LWGIi4yrrCTNx4HGEm4L18Fz/EFJ/eapXxC4gLdVerclcFhxBzrkaj+0PvPdYy7dpB1+CTngzLqXD4PrElYVwXI30rxl0VXgK/1JtKhxnWQW2YTELXo0QFUy5BcsOt6Btflv/9tntAayTNdFYOSdp9694oJ1prPV+6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Biu6Fhxb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Biu6Fhxb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1def3340682so40953355ad.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711417422; x=1712022222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNn2Cdgr6s7pNAr0DNNJw+RFM14p7JvHUDQvy5eZYas=;
        b=Biu6FhxbC11FMkYQJlbz0s/VUHw5jkcC28gNdBk7qlkEmYCWNbmFrNwD99Jql4eeUu
         Ec5no2dz0Jq7qcoZc9uMniznemUv+uqoNmFF0xfYqiq5XAzBfZmTzeyUd65HK1/ct37W
         J2qd7tOZxwaTKWiIfCDa9OB/6gXYfFBZ1B9xOE7s/34XiXMxM6S1OH6G1ILyI7IcAiyH
         KNdnCOuHpEbU09igQXfZdv+VkkF4pxWK6tEBobIJoD1+5lmpEsNU9MeVA62Af3T1kA1H
         YW9MGt+cjKMhnD6FBMFHhmAC3Sngy8cha7GSnV5nD/H46TaLoOZwfBgps7OUduuPA6+U
         Qg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711417422; x=1712022222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNn2Cdgr6s7pNAr0DNNJw+RFM14p7JvHUDQvy5eZYas=;
        b=gzUabACSaTYNTH3OwNXYVbGvomlzxbLVDl5n8Uj0IQGodMWlOKn9G7NDvaJlXvDgni
         FlI/BFvILHvZIr6Oo6u94DnCQF3ixuAxyhLdqVkndHV1804VpiaVCTyFpZUBQxRGHYE+
         Ps5poWuJOvHBYb5Fdba6eHKTVrTsRrj3F4oziAicJ+l0XVpNp1oUAG8nwW4lI0iWTfKI
         e0aufWGkDJU/cfmcCyyvuLRQRqA4uyM3xSZetk3MhMlyKAi7ne0Dzyw6db213SlSI7z5
         xNs1VOvjLrELhAPbGYrFOi0t7s2m7JNf3Try2ixY/92FNvDh4c4pPa/F3KtHWNoObo0q
         d2EA==
X-Forwarded-Encrypted: i=1; AJvYcCXB5YzBBeEjkXqmmu9S/51ivRTVc+7fIQBU/pkgsVzKBgayFxA6IRj3i/dvBWmHiWWgoIcXy44J/eR8Bsbw1fHIzIbD
X-Gm-Message-State: AOJu0Yxj/slmHSyXBSAXEwQNvwxVFuBstJfCdbc37J1wLeA5wY+LUP0I
	QJRaJw9qxFHs5aozF770tgzUcc6My/12aYlI1Mec7IIQ1VivYQyxr2dRx9+OUAblWqE4jeGMaVu
	ymUJM3kt15sPWywOLo8/YdUEUzI8=
X-Google-Smtp-Source: AGHT+IFBR1Ijn+2lgKG5EMQNhmCgMNnGC4G8rnRNBmlO/phHHsNS3XOQp5YR30sRnvtqBzi5xjMJq0ACX+uwEcjIYWU=
X-Received: by 2002:a17:902:ed15:b0:1e0:5aec:ed9f with SMTP id
 b21-20020a170902ed1500b001e05aeced9fmr9463055pld.30.1711417421650; Mon, 25
 Mar 2024 18:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-6-andrii@kernel.org>
 <CAADnVQ+SWwJMtdXj1s1RtzXJfjXU4Y41eNg+xzFXe2-DNUR8Ag@mail.gmail.com> <CAEf4BzbNRhjALGK7LpHmHsnSHEfmrzserOy07RDyP3aSbF5HcQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbNRhjALGK7LpHmHsnSHEfmrzserOy07RDyP3aSbF5HcQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 18:43:29 -0700
Message-ID: <CAEf4Bzbu_4OZwgXREAbxY4fjwG2zFhox8nXpRgd_p6aUENCufg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 25, 2024 at 10:37=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2024 at 5:01=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > Add a simple bpf_test_tp() kfunc, available to all program types, tha=
t
> > > is useful for various testing and benchmarking scenarios, as it allow=
s
> > > to trigger most tracing BPF program types from BPF side, allowing to =
do
> > > complex testing and benchmarking scenarios.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/bpf_test.h | 34 ++++++++++++++++++++++++++++++++++
> > >  kernel/bpf/helpers.c  | 13 +++++++++++++
> > >  2 files changed, 47 insertions(+)
> > >  create mode 100644 kernel/bpf/bpf_test.h
> > >
> > > diff --git a/kernel/bpf/bpf_test.h b/kernel/bpf/bpf_test.h
> > > new file mode 100644
> > > index 000000000000..c779927d3574
> > > --- /dev/null
> > > +++ b/kernel/bpf/bpf_test.h
> > > @@ -0,0 +1,34 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM bpf_test
> > > +
> > > +#if !defined(_TRACE_BPF_TEST_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +
> > > +#define _TRACE_BPF_TEST_H
> > > +
> > > +#include <linux/tracepoint.h>
> > > +
> > > +TRACE_EVENT(bpf_test,
> > > +
> > > +       TP_PROTO(int nonce),
> > > +
> > > +       TP_ARGS(nonce),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(int, nonce)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->nonce =3D nonce;
> > > +       ),
> > > +
> > > +       TP_printk("nonce %d", __entry->nonce)
> > > +);
> > > +
> > > +#endif /* _TRACE_BPF_TEST_H */
> > > +
> > > +#undef TRACE_INCLUDE_PATH
> > > +#define TRACE_INCLUDE_PATH .
> > > +#define TRACE_INCLUDE_FILE bpf_test
> > > +
> > > +#include <trace/define_trace.h>
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 9234174ccb21..67bf9659c447 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -26,6 +26,10 @@
> > >
> > >  #include "../../lib/kstrtox.h"
> > >
> > > +#define CREATE_TRACE_POINTS
> > > +#include "bpf_test.h"
> > > +
> > > +
> > >  /* If kernel subsystem is allowing eBPF programs to call this functi=
on,
> > >   * inside its own verifier_ops->get_func_proto() callback it should =
return
> > >   * bpf_map_lookup_elem_proto, so that verifier can properly check th=
e arguments
> > > @@ -2549,6 +2553,14 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> > >         WARN(1, "A call to BPF exception callback should never return=
\n");
> > >  }
> > >
> > > +__bpf_kfunc int bpf_test_tp(int nonce)
> > > +{
> > > +       trace_bpf_test(nonce);
> > > +
> > > +       return nonce;
> > > +}
> > > +ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);
> >
> > There is a better way with register_btf_fmodret_id_set().
> > Error injection can be disabled in config.
>
> ok, didn't know about it
>
> >
> > Also we have two such test funcs already:
> > bpf_modify_return_test*
> > and they can be exercised by bpf_prog_test_run_tracing.
> > Let's make it recognize 'repeat' argument and call
> > bpf_modify_return_test or 3rd such func multiple times ?
>
> I'll add bpf_modify_return_test_tp() to not touch all the tests using
> bpf_modify_return_test() and bpf_modify_return_test2(), if that's ok.
> Existing ones expect some memory pointer, dereference it, etc, it
> seems cleaner to have a dedicated tp-triggering one for this.
>
> > Exercise of test tracepoint can be there as well.
> > Asking bpf prog to call a kfunc to call a tracepoint
> > looks like extra hop.
> > Existing test_run facility should be able to accommodate.
>
> You mean if I add bpf_modify_return_test_tp() above, I should pass an
> argument of how many times that tracepoint should be triggered? Or you
> mean to use test_run's repeat argument to trigger "driver program" N
> times, and the driver program would just call
> bpf_modify_return_test_tp() once? If the latter, I'm not sure it's the
> same as calling the driver program once and doing a loop inside, as
> we'll measure more of calling driver program overhead (N times vs 1
> time right now, per each N tp/fmod_ret calls).
>
> (But tbh, not having to use test_run's repeat functionality is a
> benefit, IMO, we can have more flexible counting/timing code and
> whatever else we might need, I'm not sure why using test_run's repeat
> is advantageous here)
>
> Not sure what you are trying to optimize for here, please clarify.
>

So I currently have these changes. I moved tp into bpf_test_run.h
(didn't know we have that, this should eliminate the issue that Jiri
saw as well). Moved kfunc into net/bpf/test_run.c and renamed it to
bpf_modify_return_test_tp(), but I kept it referenced in "common
kfuncs", so that raw_tp and others could call it (doesn't seem like I
need extern declaration for it).\

I just didn't touch the test_run functionality. All this works in
bench tool, which is nice.

diff --git a/include/trace/events/bpf_test_run.h
b/include/trace/events/bpf_test_run.h
index 265447e3f71a..0c924d39b7cb 100644
--- a/include/trace/events/bpf_test_run.h
+++ b/include/trace/events/bpf_test_run.h
@@ -7,6 +7,23 @@

 #include <linux/tracepoint.h>

+TRACE_EVENT(bpf_trigger_tp,
+
+       TP_PROTO(int nonce),
+
+       TP_ARGS(nonce),
+
+       TP_STRUCT__entry(
+               __field(int, nonce)
+       ),
+
+       TP_fast_assign(
+               __entry->nonce =3D nonce;
+       ),
+
+       TP_printk("nonce %d", __entry->nonce)
+);
+
 DECLARE_EVENT_CLASS(bpf_test_finish,

        TP_PROTO(int *err),
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 67bf9659c447..a85dc684450a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2553,14 +2553,6 @@ __bpf_kfunc void bpf_throw(u64 cookie)
        WARN(1, "A call to BPF exception callback should never return\n");
 }

-__bpf_kfunc int bpf_test_tp(int nonce)
-{
-       trace_bpf_test(nonce);
-
-       return nonce;
-}
-ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);
-
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -2637,7 +2629,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
-BTF_ID_FLAGS(func, bpf_test_tp)
+BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 61efeadaff8d..f6aad4ed2ab2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -575,6 +575,13 @@ __bpf_kfunc int bpf_modify_return_test2(int a,
int *b, short c, int d,
        return a + *b + c + d + (long)e + f + g;
 }

+__bpf_kfunc int bpf_modify_return_test_tp(int nonce)
+{
+       trace_bpf_trigger_tp(nonce);
+
+       return nonce;
+}
+
 int noinline bpf_fentry_shadow_test(int a)
 {
        return a + 1;
@@ -622,6 +629,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
+BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_test_modify_return_ids)

diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c
b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 914ed625441a..2619ed193c65 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -56,7 +56,7 @@ int trigger_driver(void *ctx)
        return 0;
 }

-extern int bpf_test_tp(int nonce) __ksym __weak;
+extern int bpf_modify_return_test_tp(int nonce) __ksym __weak;

 SEC("?raw_tp")
 int trigger_driver_kfunc(void *ctx)
@@ -64,7 +64,7 @@ int trigger_driver_kfunc(void *ctx)
        int i;

        for (i =3D 0; i < batch_iters; i++)
-               (void)bpf_test_tp(0); /* attach point for benchmarking */
+               (void)bpf_modify_return_test_tp(0); /* attach point
for benchmarking */

        return 0;
 }
@@ -111,21 +111,21 @@ int bench_trigger_fexit(void *ctx)
        return 0;
 }

-SEC("?fmod_ret/bpf_test_tp")
+SEC("?fmod_ret/bpf_modify_return_test_tp")
 int bench_trigger_fmodret(void *ctx)
 {
        inc_counter();
        return -22;
 }

-SEC("?tp/bpf_test/bpf_test")
+SEC("?tp/bpf_test_run/bpf_trigger_tp")
 int bench_trigger_tp(void *ctx)
 {
        inc_counter();
        return 0;
 }

-SEC("?raw_tp/bpf_test")
+SEC("?raw_tp/bpf_trigger_tp")
 int bench_trigger_rawtp(void *ctx)
 {
        inc_counter();

> >
> > I still don't get it how modifying the kernel is better than
> > adding all that to a kernel module.
> > When you want to run bench tool on a different server
> > you either need to build/copy bpf_testmod or
> > build/copy the whole kernel.
> > But fine.
>
> I optimize for having a single pre-built bench binary that one can scp
> to multiple different (potentially custom built) kernels and run
> benchmarks. Of course on old kernels where we don't yet have this new
> bpf_modify_return_test_tp() kfunc some of benchmarks won't work
> (raw_tp/fmod_ret/tp only), but that's fine, as newer kernels get
> deployed we'll eventually get them even in production. kprobe/fentry
> benchmark will work as is (which is why I'm not switching them to new
> kfunc, so we can run them on a wider variety of kernels).
>
> > All the test things in net/bpf/test_run.c will stay.
