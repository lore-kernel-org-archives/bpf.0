Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA22264B0
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846350; cv=pass; b=o7qLLjKsHuDnNLTzAK7U3g8KJFIoL+GVz+7RosW43+vGlV89QAU/Xb9zLoL6xgIytQBFvNi9CGsw2YKyRL0coKAE4OKddqGp9VcFh3NIC9Hsu9Ebz4XSE5WQEBSuejUIj03A2itJIu0Hdix4x1kM/mIErHrHxCzua8u78OFuSXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846350; c=relaxed/simple;
	bh=z6JT+8rhRVOeA3cs4tsPb8cNApYzdg9b2ZFrNiYGVM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tk+8k2FZ/AR3gCObK2hLQIgeWqvX6zKxXDpzx7tmeKpagc+TLp7j3I3ta3fAIO/aRy2YE6EhI3AqW81zN6pPg4kPPr4rn5Y4HYqv8UYEiXbscXrWe0vDYGvICQ0ZJ5yafhrPPdMBOJnETIyNqfiYKZBVppap2xunvhY4UlKpwEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbpVO2fT; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbpVO2fT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824adf81fa6so192594b3a.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770846348; cv=none;
        d=google.com; s=arc-20240605;
        b=ku20JF+rzj2Rp9gLwgGdWEDAIOwZx2pb/hrIJjOMK7jqp2WD1LBaPPUNhiW+lVhxgJ
         X1oayfpuqm6FKqfdxO7kfdvQZCNgX0s86fX8qdabOwklg+nG4aRR4u+qSYrCTaYbF9aU
         kfgArFmyMCLeTCz4JUO/HiSI7BeT4qPdEYTcqCyTbKGOylTT0qeuCJG4HNoF6tFWRY19
         CesorL6w7b5RQctSZK9PfeQlPrweTU9DlYrAEGMsCzSMgbYSlAOejHO4M5HXyrpcJ3bv
         zh1Mm9qqcDgJQVqOEzEI3ZlacSUPjc7kORUX5l/bw1p8sq8jQGen7janPbXjnvFGwYA2
         CUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Dxi+kGI2wdbOP77DaWXb3YFjF2dXRv39k6bcIAYDyo=;
        fh=V8ABhGL8hNTZzr18JME8KqMpSxy3cJIuN9CRikC7hp0=;
        b=Ui4UIwtQ/BC97dBLF8D6z/7HMYnWqDQ5D6eY2ecZIXCK3awiR9SX4UScdxriCka3RO
         JaITDnK+MabtYa79WI6qwXBs9tMbdQcD6MvCLCPGJkCkt6ePkBrb32qA2tBhEVWdYjxH
         yi/l/ehJAG7+135m4uCLy+0qBSuPNEN1Bq/UvfHdqnidReId19cMBi/slrQZZBQmiZgS
         toEyXJLdEy1L5gqaaMPVJcYLgN7MDU/v97ksgU9PH0O52DHDMp1b4I0AHxCS2Vx9eB/s
         KMiYIwNd0SxmBw5nuopO6/9JTbulnGN5iDmebENKIDx0ipdttzGu/Er0UMTrm/Ij7WLO
         vmhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770846348; x=1771451148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Dxi+kGI2wdbOP77DaWXb3YFjF2dXRv39k6bcIAYDyo=;
        b=DbpVO2fTgudLCkFk4zhg+ohbkiOjCQsuFiLogIO2F9JmeBHegitZEaHskXA+IV+dq2
         bj6jK4oXNalacV9XUjTJDKwfEPDf8Ay73j/MLIWed3rYn61ZWFDHgyLRq1ShGWbsB2h7
         GBx+d+5epFPtl8C2ENbvyrPigxOAmznJk/cTI9x3pxoYUTD6h8fUhTuxHQflqqqBYuhM
         rBgDg/GMTmcUMSLDBWpweMgGsowbmyZ9Qf8YWDABrvxMZZB1ks3SDYp9jJbPJj1XdQ61
         3NLy7xKhV4ZerTB7GedtZnIbkyA5ZFrJXMxObM9NbG9Paq0/F9HGE4BCbpHvn/wSjCEm
         vf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846348; x=1771451148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Dxi+kGI2wdbOP77DaWXb3YFjF2dXRv39k6bcIAYDyo=;
        b=FLiIAanj4Gcon0k3EO8c/Tg0TpS7oPEjPZS+u9UO92LD6wcGBHsyjXyJgzI+4m6zxV
         1NN2cTugUgO5j2UuJItU1Aoyy5IQT20HDAHle0XIOVqNCYwjJtgoKWla4PSihZv4GmuY
         CFr509B/jd/vobzhRY35XkGW15SgKoz9wTQ7auk6Qro/HzSteo3mhpo6l6KmJEL9QfZp
         lvW4tpEafxosI6+USDeKoS8YzfaGDLUow23P9KptMCbKXhKHPJDa99O2D6CL/1vWQBCD
         efx1iIWKz9MecPjwDCIFOpd6KMU7vJyQIXvfBGjshTqxLM9ZVTqrrrohpcnB52Hiaykl
         Momw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHHuOJXcH6rFgEPRpLh6GINUSFiQFOf7U+TGVgqP0fxU51QlbyiwEJbrlHZhOI62viGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjonsGMcc0P/dE7PEl+DDaA4qZOS/A+1d8/i9ppEejJurIyP8l
	LB96+20X/1MHThgBB62u7hQcK4/1XMmeq2aqz+XzUmu1fSVZpx7dNNOmuzp9zyfy5C0qJS8gGVS
	SKihOwMJUUElEz0WQHHqzQR4GNj2OGwM=
X-Gm-Gg: AZuq6aLUgwEiYR0RJ1fVl0l1fvIz3m6kac/T7ktfrLxhzcSywIAtP1RB2iCjBTXRpap
	XLsBYZT8PdaTAcZo7R/IM1mV0J28eUSfP+q2m401/8SNEWRUQqISYieUmRiQKibTFYnPR2b0X1P
	qkU3/rto+0UuaG0ht6XBjgCUMen8DX6eCufcoz1koYkYhrKVHXyBrsBFoVYxDs5HEtRWo5HkFvW
	FWoqhSJHBTC1nJnzG9JhcFyBErm36jQpOLRNYJwLhTdZ8HVfzpU0wUYYFxx4ZTvCZnyCrOpCQWw
	snjD7HPoTv5p2/ZgcLNpYRo=
X-Received: by 2002:a17:90b:49:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-3568f3e103cmr703986a91.20.1770846347745; Wed, 11 Feb 2026
 13:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211084858.750950-1-jolsa@kernel.org> <20260211084858.750950-5-jolsa@kernel.org>
In-Reply-To: <20260211084858.750950-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 13:45:24 -0800
X-Gm-Features: AZwV_QiMUvqvu9fzrkrqQ2Rl7qbd4pKOaewE7ockiKq7Q79_LYPO9d8xnXCrur8
Message-ID: <CAEf4BzYVhVabvXRNGycSzA57HbF7ECZeYCQ1chq7HxXTi6gogQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 4/5] selftests/bpf: Add test for checking
 correct nop of optimized usdt
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:49=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding test that attaches bpf program on usdt probe in 2 scenarios;
>
> - attach program on top of usdt_1, which is single nop instruction,
>   so the probe stays on nop instruction and is not optimized.
>
> - attach program on top of usdt_2 which is probe defined on top
>   of nop,nop5 combo, so the probe is placed on top of nop5 and
>   is optimized.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore        |  2 +
>  tools/testing/selftests/bpf/Makefile          |  3 +-
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 85 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_usdt.c |  9 ++
>  tools/testing/selftests/bpf/usdt_1.c          | 18 ++++
>  tools/testing/selftests/bpf/usdt_2.c          | 16 ++++
>  6 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/usdt_1.c
>  create mode 100644 tools/testing/selftests/bpf/usdt_2.c
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index a3ea98211ea6..bfdc5518ecc8 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -47,3 +47,5 @@ verification_cert.h
>  *.BTF
>  *.BTF_ids
>  *.BTF.base
> +usdt_1
> +usdt_2
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index c6bf4dfb1495..306949162a5b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -749,7 +749,8 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c              =
 \
>                          $(VERIFY_SIG_HDR)              \
>                          flow_dissector_load.h  \
>                          ip_check_defrag_frags.h        \
> -                        bpftool_helpers.c
> +                        bpftool_helpers.c      \
> +                        usdt_1.c usdt_2.c
>  TRUNNER_LIB_SOURCES :=3D find_bit.c
>  TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read                         =
 \
>                        $(OUTPUT)/liburandom_read.so                     \
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index f4be5269fa90..6daed3dfa75b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -247,6 +247,89 @@ static void subtest_basic_usdt(bool optimized)
>  #undef TRIGGER
>  }
>
> +#ifdef __x86_64__
> +extern void usdt_1(void);
> +extern void usdt_2(void);
> +
> +/* nop, nop5 */
> +static unsigned char nop1_nop5_combo[6] =3D { 0x90, 0x0f, 0x1f, 0x44, 0x=
00, 0x00 };
> +static unsigned char nop1[6] =3D { 0x90 };
> +
> +static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < 10; i++) {
> +               if (!memcmp(instr, fn + i, cnt))
> +                       return fn + i;
> +       }
> +       return NULL;
> +}
> +
> +static void subtest_optimized_attach(void)
> +{
> +       struct test_usdt *skel;
> +       __u8 *addr_1, *addr_2;
> +
> +       /* usdt_1 USDT probe has single nop instruction */
> +       addr_1 =3D find_instr(usdt_1, nop1_nop5_combo, 6);
> +       if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
> +               return;
> +
> +       addr_1 =3D find_instr(usdt_1, nop1, 1);
> +       if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
> +               return;
> +
> +       /* usdt_1 USDT probe has nop,nop5 instructions combo */
> +       addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, 6);
> +       if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
> +               return;
> +
> +       skel =3D test_usdt__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_usdt__open_and_load"))
> +               return;
> +
> +       /*
> +        * Attach program on top of usdt_1 which is single nop probe,
> +        * so the probe won't get optimized.
> +        */
> +       skel->links.usdt_executed =3D bpf_program__attach_usdt(skel->prog=
s.usdt_executed,
> +                                                    0 /*self*/, "/proc/s=
elf/exe",
> +                                                    "optimized_attach", =
"usdt_1", NULL);
> +       if (!ASSERT_OK_PTR(skel->links.usdt_executed, "bpf_program__attac=
h_usdt"))
> +               goto cleanup;
> +
> +       usdt_1();
> +       usdt_1();
> +
> +       /* nop is on addr_1 address */
> +       ASSERT_EQ(*addr_1, 0xcc, "int3");
> +       ASSERT_EQ(skel->bss->executed, 2, "executed");
> +
> +       bpf_link__destroy(skel->links.usdt_executed);
> +
> +       /*
> +        * Attach program on top of usdt_2 which is probe defined on top
> +        * of nop1,nop5 combo, so the probe gets optimized on top of nop5=
.
> +        */
> +       skel->links.usdt_executed =3D bpf_program__attach_usdt(skel->prog=
s.usdt_executed,
> +                                                    0 /*self*/, "/proc/s=
elf/exe",
> +                                                    "optimized_attach", =
"usdt_2", NULL);
> +       if (!ASSERT_OK_PTR(skel->links.usdt_executed, "bpf_program__attac=
h_usdt"))
> +               goto cleanup;
> +
> +       usdt_2();
> +       usdt_2();
> +
> +       /* nop5 is on addr_2 + 1 address */
> +       ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");
> +       ASSERT_EQ(skel->bss->executed, 4, "executed");
> +
> +cleanup:
> +       test_usdt__destroy(skel);
> +}
> +#endif
> +
>  unsigned short test_usdt_100_semaphore SEC(".probes");
>  unsigned short test_usdt_300_semaphore SEC(".probes");
>  unsigned short test_usdt_400_semaphore SEC(".probes");
> @@ -516,6 +599,8 @@ void test_usdt(void)
>  #ifdef __x86_64__
>         if (test__start_subtest("basic_optimized"))
>                 subtest_basic_usdt(true);
> +       if (test__start_subtest("optimized_attach"))
> +               subtest_optimized_attach();
>  #endif
>         if (test__start_subtest("multispec"))
>                 subtest_multispec_usdt();
> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testin=
g/selftests/bpf/progs/test_usdt.c
> index a78c87537b07..6911868cdf67 100644
> --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> @@ -138,4 +138,13 @@ int usdt_sib(struct pt_regs *ctx)
>         return 0;
>  }
>
> +int executed;
> +
> +SEC("usdt")
> +int usdt_executed(struct pt_regs *ctx)
> +{
> +       executed++;

did you try capturing pt_reg's ip value and validating it?


> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/usdt_1.c b/tools/testing/selftes=
ts/bpf/usdt_1.c
> new file mode 100644
> index 000000000000..4f06e8bcf58b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/usdt_1.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#if defined(__x86_64__)
> +
> +/*
> + * Include usdt.h with defined USDT_NOP macro to use single
> + * nop instruction.
> + */
> +#define USDT_NOP .byte 0x90
> +#include "usdt.h"
> +
> +__attribute__((aligned(16)))
> +void usdt_1(void)
> +{
> +       USDT(optimized_attach, usdt_1);
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftes=
ts/bpf/usdt_2.c
> new file mode 100644
> index 000000000000..789883aaca4c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/usdt_2.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#if defined(__x86_64__)
> +
> +/*
> + * Include usdt.h with default nop,nop5 instructions combo.
> + */
> +#include "usdt.h"
> +
> +__attribute__((aligned(16)))
> +void usdt_2(void)
> +{
> +       USDT(optimized_attach, usdt_2);
> +}
> +
> +#endif
> --
> 2.53.0
>
