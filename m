Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89783803D1
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349400; cv=pass; b=JYa9migq3YzkrmSz6tTutGUNtKEywOJ3uK30c7276UEHv7IDXz6VAipKmuWus7tEIuo2rT6kEN2HhixmNgekF1LEQ7r0zIQ/g7/erohASOFmKjTc4iK6XL8L0QFax/VWT88Y5Dv8P349ROQRs0gxCkTuNQgoS/zjY5W5DSu1Gag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349400; c=relaxed/simple;
	bh=LxXu6+4j3aq8QT9rvVBSKHjHuSoaCEUYe+MBh20IXgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkFqLd16Kqa1rVAJFIaHx4R95Auk+TpX3OEaIgPpfyOdJTpeU5Shqkc7ONNIbdTkyBKhBbQxf9KWK0jN0xDsl23IhTlKS+88kRcDbtYzsXPKT0U8zShVHkOb/aE5iUl2EiZdE6N+xrSo4egtMDfkzLEkiYnaR3XjdFK9Lqjg55Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV19eaR0; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV19eaR0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829928e512aso827865b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 14:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773349395; cv=none;
        d=google.com; s=arc-20240605;
        b=aq1G3aJ7hibb9Mc9xQLL46t8F+ovFmwOQUetOaA/wtL8BF6L4tNop7yrijKq2SI45p
         WiTYAeFwOTBcFLdPjP2a3Adckt9MHF9R0aTFFJVZgr2HNIvEIk7xZVkCRiTdwV26VzX0
         KxAu+aUeDT9GNhT4maQqzcG6/Dgk2wPGT/nVEDhoCH6lnJxJ22B8j8bgrtayaiohA0vq
         TGdYOJiXLtl6ejUlEB1LOJ2Fuiw3zzz+GbBvtVQhp+OQYLv6y/rXRUZ+Rkt5vWB/pzO4
         TZqXmw7u7SUcBK/GpuKOSNdgPWZ3COkQZD7OVxaEeCEmsoFv50KV2tfZtYMRko2/YShY
         dQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fls2CEGeTwBH00qB1WTPOc+8K2rx78cbDySAE6ZwMzU=;
        fh=un2GWPmYwFWbdF1XpxMPQYRxhKazl5Rxm/QZWha9hkc=;
        b=VrpIx7DiEeY8JHbDp5WkTnjnKR8tmhcQ78e3LekjhfCt+4Du1U7cu472LD88nId6Lb
         khYOtUuezYFnBPHS0RBOQ9jOe9CiRz4oNkwzvhmJ3nELOp8HY/MeeQ22TORXCrKmLQEL
         pYwZdfS9DAhptNEexLFDSDKN1tKIvnVNOca/E5bMYXiWzaPmMf0wKJBlhM76G0XF9sRk
         tZ5j2ReFnqneMRkKH28Zn/soZEfj5g2a1L4jMvRH8gipeKa8v/ee284WJxvy+Ky2UleR
         BEW2kVhMCP55vls9swf2LEPEEYRj4NS838IJV/b1GLtyBkKs3QCouP+W2nxsl3VN/4SQ
         Q1HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349395; x=1773954195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fls2CEGeTwBH00qB1WTPOc+8K2rx78cbDySAE6ZwMzU=;
        b=MV19eaR0mWGrpJ6oGdShT+F49rZw3S1mvAUDvjQ8IMHrLltfXGfqxJ7Bfj/AIQyqxQ
         stAhuXzQqIU4DX1/YkEMDtZsRdV7tYUz1pMqJSCZBSnE79kygq2Xm/8pwu2vWYzGV2sJ
         ofNEeDzSbpaSG2KOV3Q2Dgpr023OLPUrXpzks2tx+Zc2VbLVU6DY0llK0RL18Rn45NKN
         B4nuvgiJvVGROWRYZ6XRD9nqzL+TkYwv5+RuBJtTocPG2r+eAn8oBFHaXLYr62quO5+o
         bIphqLZ5y1TUbRboawklLQ/0qwdMhtRu3+naWMBX89nrkcB3tB8uSOkhai2tNX6SAEOV
         LaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349395; x=1773954195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fls2CEGeTwBH00qB1WTPOc+8K2rx78cbDySAE6ZwMzU=;
        b=G4Uk35eqaMdLgW19+DZbF6sPmcYrVM1o1Fp/VtIcRkzB7rNvePQm1qAVkJWZimrG4o
         3rLh4USq0ZMcZMeCtGY1LJXo8864vP4AVL7Me5O40c5VDAUKL5i3eJC5I7CCFUngoPyV
         8eYYBE2KUxVHf3Ayinc+GrLQi4BEfJ3MzygCx/3Wyy44gmZ9pxZ7OKtGthSFP1Acr+sz
         dsqWRe7+0ne7JPZq03wKsIOvyBEe/8ZBVdrKLMlC6CSX/IlSKuB2BzkmSumZsLctIeI8
         /TfXljEQQjCpdsm0CZrzudahWcxxX1YuBtV9acn0vfYGlWq7Vu6dhnzqF37uFJpaHX6V
         jDqw==
X-Gm-Message-State: AOJu0YwR5bxiRraex26/E/V0/9hSbeKIszyOZ20eXlBzuVugGvxTN390
	Dg/VwYrxBsYJhySCtIlMVa6bMdZO2p0O10K7KcgRZdGutmCLPU0ItUOd7H1WXeOThw/LUhl/Sr1
	Ew3El1yUF9bmZcb/ZQWRNbTrDF6lSOUI=
X-Gm-Gg: ATEYQzx5VGxSppajMivv9qFvjOIaqG6bA8y4b9yd6TogcXeUrkdJc88ZV+8Cw4vSTBZ
	aybgGFFbApY5Ge0oz5iS0Acn6loTTCa1eAble76BPod3Ycx+VuoT0lhYfo1WyJD0TyjwbwOzHzT
	/Ia9j79SYWm6nYXuhnlkyUf9XZAtA56Pd63xqmq3ptZRsk5V1fNGNjlZEPrUAYt67Oyt8UhINiK
	JGCvY97dCR2DSExfMQhhLRvr+J1EHLhsU/cxvlkFwHhQ3tQwZo7rgny9AOWjW0eH+0GaTs5UngA
	davPZpCnxQJAh6xwE4TPUSw=
X-Received: by 2002:a05:6a21:2d42:b0:366:14ac:8c70 with SMTP id
 adf61e73a8af0-398ece2251fmr536576637.70.1773349394867; Thu, 12 Mar 2026
 14:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com> <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 14:03:01 -0700
X-Gm-Features: AaiRm51KmGiW01xUbFS32xhv8ubul2mgIMas9F9vRV5zzqbC2WOa5uiDfjiqK_Y
Message-ID: <CAEf4BzY255ncKM0GY3PwnwuX9UFcf0m_-ijx5EcrGzCJ76hqAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add tests for sleepable raw tracepoint programs:
> - success: Attach a sleepable BPF program to the faultable sys_enter
>   tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
>   a syscall.
> - reject_non_faultable: Verify that loading a sleepable BPF program
>   targeting a non-faultable tracepoint (tp_btf.s/sched_switch) is
>   rejected by the verifier.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 40 ++++++++++++++++=
++++
>  .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 ++++++++++++++++=
++++++
>  .../bpf/progs/test_sleepable_raw_tp_fail.c         | 18 +++++++++
>  tools/testing/selftests/bpf/verifier/sleepable.c   | 17 ++++++++-
>  4 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/=
tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> new file mode 100644
> index 000000000000..e902b41591e7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_sleepable_raw_tp.skel.h"
> +#include "test_sleepable_raw_tp_fail.skel.h"
> +
> +static void test_sleepable_raw_tp_success(void)
> +{
> +       struct test_sleepable_raw_tp *skel;
> +       int err;
> +
> +       skel =3D test_sleepable_raw_tp__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +               return;
> +
> +       skel->bss->target_pid =3D getpid();
> +
> +       err =3D test_sleepable_raw_tp__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec =3D 555 }, N=
ULL);
> +
> +       ASSERT_EQ(skel->bss->triggered, 1, "triggered");
> +       ASSERT_EQ(skel->bss->err, 0, "err");
> +       ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
> +
> +cleanup:
> +       test_sleepable_raw_tp__destroy(skel);
> +}
> +
> +void test_sleepable_raw_tp(void)
> +{
> +       if (test__start_subtest("success"))
> +               test_sleepable_raw_tp_success();
> +
> +       RUN_TESTS(test_sleepable_raw_tp_fail);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c b/=
tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
> new file mode 100644
> index 000000000000..ebacc766df57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <asm/unistd.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int target_pid;
> +int triggered;
> +long err;
> +long copied_tv_nsec;
> +
> +SEC("tp_btf.s/sys_enter")
> +int BPF_PROG(test_sleepable_sys_enter, struct pt_regs *regs, long id)
> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +       struct __kernel_timespec *ts;
> +       long tv_nsec;
> +
> +       if (task->pid !=3D target_pid)
> +               return 0;
> +
> +       if (id !=3D __NR_nanosleep)
> +               return 0;
> +
> +       ts =3D (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);

this is BTF-aware raw tracepoint, so let's use non-CO-RE variant of
this macro (PT_REGS_PARM1_SYSCALL), which will perform direct regs->di
access

but then let's also have non-BTF-aware (SEC("raw_tp")) test, where
you'll have to use PT_REGS_PARM1_CORE_SYSCALL().

And let's also make sure that SEC("tp.s/syscalls/sys_enter_nanosleep")
also works?

> +
> +       /*
> +        * Use bpf_copy_from_user() - a sleepable helper - to read user m=
emory.
> +        * This exercises the sleepable execution path of raw tracepoints=
.
> +        */
> +       err =3D bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nse=
c);
> +       if (err)
> +               return err;
> +
> +       copied_tv_nsec =3D tv_nsec;
> +       triggered =3D 1;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail=
.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
> new file mode 100644
> index 000000000000..54100899f728
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* Sleepable program on a non-faultable tracepoint should fail to load *=
/
> +SEC("tp_btf.s/sched_switch")
> +__failure __msg("Sleepable program cannot attach to non-faultable tracep=
oint")
> +int BPF_PROG(test_sleepable_sched_switch, bool preempt,
> +            struct task_struct *prev, struct task_struct *next)
> +{
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/tes=
ting/selftests/bpf/verifier/sleepable.c
> index 1f0d2bdc673f..6dabc5522945 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,20 @@
>         .runs =3D -1,
>  },
>  {
> -       "sleepable raw tracepoint reject",
> +       "sleepable raw tracepoint accept",
> +       .insns =3D {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type =3D BPF_PROG_TYPE_TRACING,
> +       .expected_attach_type =3D BPF_TRACE_RAW_TP,
> +       .kfunc =3D "sys_enter",
> +       .result =3D ACCEPT,
> +       .flags =3D BPF_F_SLEEPABLE,
> +       .runs =3D -1,
> +},
> +{
> +       "sleepable raw tracepoint reject non-faultable",
>         .insns =3D {
>         BPF_MOV64_IMM(BPF_REG_0, 0),
>         BPF_EXIT_INSN(),
> @@ -85,7 +98,7 @@
>         .expected_attach_type =3D BPF_TRACE_RAW_TP,
>         .kfunc =3D "sched_switch",
>         .result =3D REJECT,
> -       .errstr =3D "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and s=
truct_ops programs can be sleepable",
> +       .errstr =3D "Sleepable program cannot attach to non-faultable tra=
cepoint",
>         .flags =3D BPF_F_SLEEPABLE,
>         .runs =3D -1,
>  },
>
> --
> 2.52.0
>
