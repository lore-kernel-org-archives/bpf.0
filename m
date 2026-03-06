Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD435F171
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841436; cv=pass; b=KrHZ0Jsf7+1bmr6NcCyQUOkQ8gfH6vnlCEv7163BSXzBk7VTdNwBxZ/52FWztN9FdddJvhmzlBl1/LsUqGJdxTB158PBANIpu4CtHw/cu8mSx+fReUXxdRCoSqFYXzLMLqgxCMsAQxoYjJoB897BK5A3Y7JfsRUeJw86H3w+RmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841436; c=relaxed/simple;
	bh=xJaYcLlwP0wcHO4wunHYPxAiGotnvChtDKGz2eoTQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS9hcBMVMlmadNuDsFrtXhJI2oaNe48IMJwqtvoMqfs2Wg5REL+/n7VF3IoDzS/bA3Sn7/iNSOQmuucFqVryoYaJHxI2qDu7tfjk8TC0/pLfNJDNeZ6lmb3izRrjnt7H92fEqyQm86Cu2xDNszL5f+c/qPoUsGixCFS0TmK0JtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2RBaMFp; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2RBaMFp"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso40821f8f.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:57:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772841433; cv=none;
        d=google.com; s=arc-20240605;
        b=cjbQt3wXM8zRAAZAwACpaq+Qkb5mJZR1svOx97xXfiCtmcurkgeciEPZiydot9OddX
         CGRwAFn582p41RkJYGNV7niJH34l1tw0Gbc6VodeCQLr/Vv8ttT8FXbNHpfObVJcqsKW
         X5ony3w7z9c6paYjuX5O2ICJLVmSRpmzC97ObjUaTJhx9ED4rm+p5Tc+N27R46NnlJSl
         /doxTfy/voqvWIL3oyKANMTl9sjAMmHMp1tVwLoQGyWawLe7QoVd6xejH1R4Axqkbz0u
         L4ETi5WUjwDi2elOco4kpJXdC9WTKPYVG0vDzdJpyAKFflqqXoMVOK2fK+OZZDr56TIM
         7bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gg+uqw8TyWqep58hlfZB1/WyXg9DOF/QuXgeyiRZlQs=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=hw7t25ku/gstXVDbEm4jRbh1cm2VhTqWzry1py88mX4TyecYVUXYY7JVwpQTupdJiS
         SM595clKhyaTBDzTD0Rzmbmk3afIBpFwOBYNMdk8W5MFdWUSM6Ma5OpLo8O13915I7K3
         lFxlKrEAH4v2IGLRoaqPPJqX+lM9zVYnu1yI15ipWrCf73YhuOBrJNbi1rdOnjFkuWvw
         RFVzKGk1bwU1BI575X3Elpjj2pNVpbUL4MvpuLHwpp8Ch1/jzzocT21PRJP/gKwsSnXF
         PU9nzXXbfj3O8cF67mT8wTysG3Q/5prfkn9E6BzuaEtsTcFwRFih/ykvvTW95NmVPEth
         GdZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772841433; x=1773446233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gg+uqw8TyWqep58hlfZB1/WyXg9DOF/QuXgeyiRZlQs=;
        b=k2RBaMFpX+s2pR2dIZcHsiZuyyuP3EQb/gG6PE/+jBFU4FeElqX4eStlPJ6L4XOG+M
         00DpeSJcCN3WJeb60Gwb1t1e/RiplFmDofka2i8fDX3xjVmJUl5NLe3GIOBIhthAEiu3
         Z1riUO+Ao4UMDuGZmX+FWYM15m7nG2aBJYlCk2IJKytkRtbpWDG53gV39Ex6NFSOQNsC
         HvrbtPO8uMZFg4gu64GOPc1/3gxJ17Oo5QK+PgoIbksEdk97JuD1jcX/iSojAyagCmpX
         lDSqFCNrbyv98v5yp3Kv6lIXGOlY/oKgvPoQ7yQltOfEjrKPashhKOtk+Z3ndYYI3avS
         cRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841433; x=1773446233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg+uqw8TyWqep58hlfZB1/WyXg9DOF/QuXgeyiRZlQs=;
        b=QO51GCKUzz259/DK5ToTHQDheEIORj2+Qtoo3RmXlAuw/FGGpqvOKCdKjRSkVuMDQI
         uyUgzBeu/HUhMT0ucmPCKmj3GF8E8wzrpcuES1P1ctCgrF3wY6tYsNilfhMewY5C5xrM
         9KVeJp/YALo15aYRfVCOrNLklDrFHxEKGz3HwK20YtjWBoWICTxsa+K8CbxbHb413FzE
         3nhcSCf4UeUU2az2zR6LUvUvaolsvrUA4huELUW9AqutKnlqYBJXtyg/k1p3O6Ows9+J
         i/jCEHYSDUD73Cv7/IviX0a6hDJXggoO18frH++TkERezx+EIfZWKQaVT9p34fue5j30
         hY4A==
X-Gm-Message-State: AOJu0YyhWzqLVKSSJf8IX5ab1MjkMr3Ti6CVJ06BXqjdfI9E8nTL18HU
	VHerE+2yLXIkykIK7rptpEjKKqu9u6GOH5M1YsJLbuqepRmFgUAh07IlzHo7t+ovuOU5qO6IMmH
	EBoQ2hU/DVDfYfyLiTLuscJPutWgA4AM=
X-Gm-Gg: ATEYQzxEt/IgZ8HlTtKLOBpGxP0BTXedTZx/Q/1kkYFjZBHHE+0QPSzfBU0WdsDNvlf
	UpFLG87sCnfWaA1XMwmT6D1GTdK96yDba6YMso7Qk4UrTdQ6yU7uiis2yxIWfeapkXiur/RdA3l
	rIMrB+xpvA3qRSaDBcezGe/3mEAuJK8DguAy1Yp7jw4jo/GuTiVmkHZNKg6XDALg1wNWO4za/XF
	TBDBds1tUfsVv9iiZMNyRhzmnH3Aybutepa3ciGF2jKaXpaiVcdfYXVp6KxbtZghBTLzpKrxa33
	ILp3GliI9TKaljUUErmIMAvPd3JlB0857gD43pV5pm618DTfB6iBrEru4gg=
X-Received: by 2002:a05:6000:2dca:b0:439:b046:2044 with SMTP id
 ffacd0b85a97d-439da354a8emr7569758f8f.12.1772841432984; Fri, 06 Mar 2026
 15:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
 <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com> <CAP01T77gHpzcOHK3kDHsPCdyAu17i4kk5C+uYeD-xWdsmT6gYw@mail.gmail.com>
In-Reply-To: <CAP01T77gHpzcOHK3kDHsPCdyAu17i4kk5C+uYeD-xWdsmT6gYw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Mar 2026 00:56:36 +0100
X-Gm-Features: AaiRm51PJo91EyNifFwNpv5rOZAH7DFSE-T3ojaTPPYNA2gVa3ax4Y6igXGZuqg
Message-ID: <CAP01T7719fHx5OXF2K11k_o+xm41HozB3i=ZuuAPcR71thsFiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 05:41, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 25 Feb 2026 at 17:25, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Add two subtests:
> > - success: Attach a sleepable BPF program to the faultable sys_enter
> >   tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
> >   a syscall.
> > - reject_non_faultable: Attempt to attach a sleepable BPF program to
> >   a non-faultable tracepoint (tp_btf.s/sched_switch). Verify that
> >   attachment is rejected.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> ... but see nit below.
>
> >  .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 56 ++++++++++++++++++++++
> >  .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 +++++++++++++++++
> >  .../bpf/progs/test_sleepable_raw_tp_fail.c         | 16 +++++++
> >  tools/testing/selftests/bpf/verifier/sleepable.c   |  5 +-
> >  4 files changed, 117 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> > new file mode 100644
> > index 000000000000..9b0ec7cc4cac
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <test_progs.h>
> > +#include <time.h>
> > +#include "test_sleepable_raw_tp.skel.h"
> > +#include "test_sleepable_raw_tp_fail.skel.h"
> > +
> > +static void test_sleepable_raw_tp_success(void)
> > +{
> > +       struct test_sleepable_raw_tp *skel;
> > +       int err;
> > +
> > +       skel = test_sleepable_raw_tp__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> > +               return;
> > +
> > +       skel->bss->target_pid = getpid();
>
> Shouldn't this be sys_gettid()? Otherwise the filter in prog only
> works for the main thread (pid == tgid) in parallel test_progs mode.
>

Answering myself, this is fine, since parallel mode uses fork() vs
pthread_create().

> > [...]
