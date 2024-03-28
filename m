Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573124219
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605613; cv=none; b=lh0IIc+IPqI22UQbN7dAx83s41/9z4yZKdU1Jn486p5FCzUR7zn5wFm+KVXIcG2grZeRvpuZCsEc10+W0+4D8XDOmERbORTv9ueyA2CqDkprxQ9Qpeg6W0uP4It/Yd0HzId2SkYr+oFwJqDlnUFLzDIqO303uQ5Mw/fdU06nUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605613; c=relaxed/simple;
	bh=SzVDkRIUg6dPAe1KOPa8tHiOYvDb5bOxmnWNR2s9HBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyARREACFd1ko3bnEhhZoo9/7q6YuVhcl572wV565jQ3KNRj1JrZRfa5Tejz0nsAluYkCHtSwAfL6e/Eqp6+Zsc51JJSZFWTBTg67gSlduhDqtR1010AdqDnGCl9DzJCEC6eX8+zCvBcwi5vxS9FUo1OP2iFj1HssQ6BrgZ3h/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ3Lk6uB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ3Lk6uB"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789db917876so31763385a.1
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711605611; x=1712210411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1la4TtuGNKnIXTkIswkxLbTUfQUsqIVrT35fhy5dGzE=;
        b=dJ3Lk6uBhI9Moix0IuBkttzEB4XkNOUpsLgOdhbRcCd1nD6KLlNZtOTCwdzT/pDkyi
         To9+O6izrsVwpkEwSdQxYlE/ISEWZBjq+4p92r38AkaSI49HC4UWT6fiq2/wiy0NBaS9
         PVall7JlhtZrcq/RuZ016QahFBusURgAElsNw47ddqlvDrD6RNrtEiwgfhoI2NU1H5qA
         OKcgdNEXxdsIuiiC4jkEsyuMTWLCcvARp12t7VSnjtZTGqcI/w04VOwvh0yIQUFSniqy
         MeI6eyH3xDb5L4vLd0s1txq7bP1/PrCRs+XpSCE+GfeDIgo9KDlQMpi2HPuQUEXS8XSm
         k1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711605611; x=1712210411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1la4TtuGNKnIXTkIswkxLbTUfQUsqIVrT35fhy5dGzE=;
        b=J3zl3QXK+4BWFEiHbLLP8C3N5m2hJPmTa8ZKJJ0pusGFUzMWQEpWQCuOcAjQkCTmyB
         OeoxM6s0WVMS3B+7xD9W1Ieg7UyOxP2n/DYLkcYkr4fybQXy/Yv1t7zv7HxbF2L9YFAb
         wgeZz60exQYkgXC2JyEfh0yj9ebj27wyjJiai8RRSwCgaSCg738OcHztDRSUBFgtGXvJ
         ZgSYlf/M4Czyh2DFA2cWAvc2ex1/abhWiptF2/uqTWxkcggA83ZFFI6K2AkUA5zZzxht
         ApEtLlW7dDbAuRrMkz/ZErlGUcZdeBqDYmndlYo1QdbIEFOg/H9f+fCBfNjQjNN6urRp
         DSTg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ukVM2ryCv5kTOr61JKapI1nPQ3flJw/2OYaE5cYUc5mEL7/0k97+554YJMT39gPtW+2qcqiBgrEeD2BR/UhAxoKx
X-Gm-Message-State: AOJu0YxquFEBHzfJHWJrgEuVUgc3WbZlgJAp6ZikoHBt52/zECjxMzdp
	z1RWkhTubGIoabQlmV1BzEHXGH7283/lscqfdvcubBG0v5lML2YyDgIz/4j5fw5ccJwtoHVD/NL
	wj/pKgqD26UKQPAA8hacAneuoDXE=
X-Google-Smtp-Source: AGHT+IFMQDiWkawe9J0cVgQZRRB5eekHsHPyLwYa2X7LliPPTOift3ZJDOIrk4haDcSVbYs+e0pBhIdhmM76IC3V9/0=
X-Received: by 2002:a05:6214:2d09:b0:690:dce7:76e7 with SMTP id
 mz9-20020a0562142d0900b00690dce776e7mr1653959qvb.25.1711605611226; Wed, 27
 Mar 2024 23:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327115848.84695-1-laoar.shao@gmail.com> <20240327115848.84695-3-laoar.shao@gmail.com>
 <CAEf4BzZ6L2NWf25gJ2CaMo-+rY4tL2Z4UWTqut1BHUEhxLjpUw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6L2NWf25gJ2CaMo-+rY4tL2Z4UWTqut1BHUEhxLjpUw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Mar 2024 13:59:34 +0800
Message-ID: <CALOAHbBT5rRzZveVMSaMRr2SVW5UJS+ZfTagCXg=DPJ3M5-72w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add selftest for bits iter
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:48=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add selftests for the newly added bits iter.
> > - bits_iter_success
> >   - percpu data extracted from the percpu struct should be expected
> >   - RCU lock is not required
> >   - It is fine without calling bpf_iter_cpumask_next()
> >   - It can work as expected when invalid arguments are passed
> >
> > - bits_iter_failure
> >   - bpf_iter_bits_destroy() is required after calling
> >     bpf_iter_bits_new()
> >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> >   - bpf_iter_bits_next() must use an initialized iter
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/bits_iter.c      | 139 +++++++++++++++++
> >  .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
> >  .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++++++
> >  3 files changed, 339 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_fa=
ilure.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_su=
ccess.c
> >
>
> I think all the cgroup and bpf_iter related parts of tests seems like
> an unnecessary complications and just more code to support than
> necessary. We have tests for cgroup iterators, so we know it will
> work. You are adding bits iterator, so let's just add tests that
> validate bits iterator works. We don't need iterator programs and
> cgroups for that. Can we just leave RUN_TESTS-based tests and not add
> yet another test runner mini-setup (I mean those positive_testcases
> and negative_testcases)?

Thanks for your suggestion. I will consider your suggestion carefully.

>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools=
/testing/selftests/bpf/prog_tests/bits_iter.c
> > new file mode 100644
> > index 000000000000..0e2520a9dc62
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#define _GNU_SOURCE
> > +#include <sched.h>
> > +
> > +#include <test_progs.h>
> > +#include "test_bits_iter_success.skel.h"
> > +#include "test_bits_iter_failure.skel.h"
>
> I'd cut out all of this code I cut out from email.

will do it.

>
> [...]
>
> > +
> > +       RUN_TESTS(test_bits_iter_success);
> > +       RUN_TESTS(test_bits_iter_failure);
>
> and I'd put these into prog_tests/verifier.c

will do it.

>
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c=
 b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
> > new file mode 100644
> > index 000000000000..974d0b7a540e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include "bpf_misc.h"
> > +#include "task_kfunc_common.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr=
__ign,
> > +                     u32 nr_bits) __ksym __weak;
> > +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> > +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
> > +
> > +SEC("iter.s/cgroup")
> > +__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")
>
> you don't control assembly instruction generation, so let's not rely
> on specific instruction number in error message

will do it.

--=20
Regards
Yafang
