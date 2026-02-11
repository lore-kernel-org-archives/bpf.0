Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF6345CC9
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846333; cv=pass; b=MH+mIFYieirhSRMI0GgnH59K2aoO/BwE054bRBCht49FYYU7/fFSMkdl3fEiHlcKGkZ/zjy2l5n+3yIjoqfgnzmC/JPTv+9QOjCZi+cklaHTzFtuXpzgEyctOIVKrlSfYd/Gb5DJEJjRQxVMKfSzY7LJS2naiYfX8C4zGYnbe98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846333; c=relaxed/simple;
	bh=+ld6S5SmHPfJ72Y3+dhVdAf0ZZqqUvyOKMUR167+fYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EINeJGZSZ41m87gW0quCOpJUcq6fQP+fM0s+GJBzexqyjRNFn3yBb84LBM46EoYgi684sIXgLbBJFNw1fJmbQyMLB/dLi2iMBKxYIorpBGeS+W3Ap2rv3aKnNa7x8EQmIeMPtBs9bHHmKIRpyUbgV87e9TEbNhk7oEAQtY3MUO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCV2jwGx; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCV2jwGx"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2745464a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:45:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770846331; cv=none;
        d=google.com; s=arc-20240605;
        b=e3xsdBu//6Di3itiegSSEooUI12mRXpXke8V6nmhOkXd53W1KrY5jM1VV8LJ+Dpfgn
         umNs7SVDDEiTbakHWQmyPFfqnb6IYQVbtQp5PkqX/SJo7Kmd2TCK5BuYsDt4WD8Bw4NR
         g/HVBlRxAj8G5stc3KhZHJO4WRp3puOpsoCSHNS/eYbd0yO2YpKtPceGK5U2g6CmW0s2
         TZvEXU3okNBrzCCbCnrdSa1lWxMmwBd6LjfvJ5oUnkFh2C3hFholYkwlJvclSj/l/ma3
         wp+4FxhBt1+QHhlVPnt6SNMQYVuYpV+cVMe4lGDsemFF6h1IuI22kmeJLPcP32KaUASU
         /yQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pbb2wiRq0JgEqK3px/oxkThRlG3aC3vwv2Qq5FTwOM=;
        fh=kwwnMWtz2M+Jc+s0vKhfkPwMjLuRaYsYePp8njinb2M=;
        b=NIL2I9vEO63blI/BdT0KE/bcK+Q8DDMq5gd7vRMhF+rEJXm9ANVSZ715FWqm5dLZaO
         5lJ2zAtc5oky/FGEjbPJOJwlvDw0iQj5w5hmXx7GbNWtiKXLWBGmn0/+u6FscmhRxhQG
         QAIB27b4nt0sbTtp+f3mMHfawvMeYP4G4r0PiqiGbHLsTuERpYwPCztlCqX0DpeD67Tx
         snopsgJChqLd20jx4q2MCW5WRzM+76aUMa+x6jwJCpg9Twtxq8L/F3P2A7yhn/OBD+/o
         FhpnX/z6wT59Wss5z50i5K4WZWU4c/Yo6MmRtn3VqRbkEVrr3/arr5XlcIsw4DRHquTm
         Jfnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770846331; x=1771451131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pbb2wiRq0JgEqK3px/oxkThRlG3aC3vwv2Qq5FTwOM=;
        b=GCV2jwGx7WO9yOY78ZYvmMHT1cV8TmxM3pu6r34/UPTuLcewa/PlyM/ANF5aQ2W+w4
         Nx2NGbN86t7ZF6S+7qYQUZ5KW0xedugJyPjJrgqftaUSzuigrQMdUz+auVnfz8w8ic8e
         MlYudcLqeM1kDOXVW5ZrkQnEoeqcAboiG3/8S3XV5DayRgbySw/fRxNc5SMh2TgevYQr
         n4OMdZ4E6Pub5N82oAJDo6/PJgO6oIRdy+2+6yLTNzPQ3tJx6befV9GtxGX74QaDu4Xm
         saxYNtDmBxiJEL04/dwXXfq0EtXOtDAoREE44ZWKCKwxo03/JGWeNjhpediHaPgOdDFP
         x23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846331; x=1771451131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3pbb2wiRq0JgEqK3px/oxkThRlG3aC3vwv2Qq5FTwOM=;
        b=izB2jAwmCGvCxhJ7SbfCqw7EyEBpLwO0Mwau0M4Z0VuSr4iiylZqlTFGtVVwz1Jzdv
         O1h2t6qsch+xsOr5obvpt+Np8Rw2Esgw/V0XzM9ZFCfBvIJjS489NVyvjz9hhwJN4Olc
         dPK9CokDLQTCydyRa5YSrU4F/PbBmkNfuDwkm9tkEPYTX+KYOF9+3fk8dk91Ky0jQjla
         6GRlyHS2jZpP27DyIiSiQdCflcwSdjlg+dzQOZmpFPPq5K+4WjmRqNFMUdh5K4gDoWYT
         VZyMVohkim5blSLx2WdYGliJ88SfxhN0CYiPKJFZyxB1rTVFBGfqQ3OJk8uYn32KljMj
         D5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJHf43pMUhIemNdjvqgAXG2mS+0lO5qIZtbHSCu8Zzd18SUyTnbuVSELPz4FjfdcdNKEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05I96wyxwPct038zhx0ceBuuDw/ZOvH5LOwi+VfmNG2dIT9PP
	foPdOgztVw/pOZ//hfwh3PGwrZewpYxuW8lnc2vtKRDlXArgVUnJ0oUwwaH1XTTproYoagh8ox/
	5zy1CY6Ou4+Ty+U9wR4VgfeEIxqk86AY=
X-Gm-Gg: AZuq6aK2fafPUydiORTHyQijjUO8G6cHhMPc2h99GzCquea+r5TkfQJDsaQgcQkP9E0
	k1cX+lOX/hqP5tX6cfRb+407kumQjEiv+AqsGhIGdx0mjQg9OyAzQfeukuLH0guUMvkhSeeBPdo
	saphyd6lmSu0tXAhbOr9f73VS692b7e+YNpX8rsCMR34nnbRwnBTZNSb4vO4HYlbXYUrXPyQnD+
	wNpJA0kzcpKyejU4hoEap2tq+Yyc8PsB/As83q0eRIB5lu8yBH5Oxt2HLli5ByNHkBhYCPdwXx4
	IyWiwUcR8M2V2VGhNY34BrQ=
X-Received: by 2002:a17:90b:2b47:b0:354:9b26:cdfc with SMTP id
 98e67ed59e1d1-3568f30141emr718113a91.11.1770846331471; Wed, 11 Feb 2026
 13:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211084858.750950-1-jolsa@kernel.org> <20260211084858.750950-6-jolsa@kernel.org>
In-Reply-To: <20260211084858.750950-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 13:45:15 -0800
X-Gm-Features: AZwV_QioUfnk14oP09lRCmexTYHGjedaLFsys75a9DpgXzaRJP820psWz4-ptss
Message-ID: <CAEf4BzYP0+u6mMz1NsZW+sT7Ts=VyM4vnFbbo6sxEZKWznGSXQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 5/5] selftests/bpf: Add usdt trigger bench
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:49=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding usdt trigger bench for usdt:
>  trig-usdt_nop - usdt on top of nop1 instruction
>  trig-usdt_nop_combo - usdt on top of nop1/nop5 combo
>
> Adding it to benchs/run_bench_uprobes.sh script.
>
> Example run on x86_64 kernel with uprobe syscall:
>
>   # ./benchs/run_bench_uprobes.sh
>   usermode-count :  152.507 =C2=B1 0.098M/s
>   syscall-count  :   14.309 =C2=B1 0.093M/s
>   uprobe-nop     :    3.190 =C2=B1 0.012M/s
>   uprobe-push    :    3.057 =C2=B1 0.004M/s
>   uprobe-ret     :    1.095 =C2=B1 0.009M/s
>   uprobe-nop5    :    7.305 =C2=B1 0.034M/s
>   uretprobe-nop  :    2.175 =C2=B1 0.005M/s
>   uretprobe-push :    2.109 =C2=B1 0.003M/s
>   uretprobe-ret  :    0.945 =C2=B1 0.002M/s
>   uretprobe-nop5 :    3.530 =C2=B1 0.006M/s
>   usdt_nop       :    3.235 =C2=B1 0.008M/s   <-- added
>   usdt_nop_combo :    7.511 =C2=B1 0.045M/s   <-- added

consistency, usdt-nop. And for nop_combo I'd use usdt-nop5, that combo
doesn't matter for performance beyond the fact that we have nop5 there

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +
>  tools/testing/selftests/bpf/bench.c           |  4 ++
>  .../selftests/bpf/benchs/bench_trigger.c      | 60 +++++++++++++++++++
>  .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
>  .../selftests/bpf/progs/trigger_bench.c       | 10 +++-
>  5 files changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 306949162a5b..9b2ca0028322 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -874,6 +874,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>                  $(OUTPUT)/bench_bpf_crypto.o \
>                  $(OUTPUT)/bench_sockmap.o \
>                  $(OUTPUT)/bench_lpm_trie_map.o \
> +                $(OUTPUT)/usdt_1.o \
> +                $(OUTPUT)/usdt_2.o \
>                  #
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index 8368bd3a0665..4dacb87e464e 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -541,6 +541,8 @@ extern const struct bench bench_trig_uprobe_nop5;
>  extern const struct bench bench_trig_uretprobe_nop5;
>  extern const struct bench bench_trig_uprobe_multi_nop5;
>  extern const struct bench bench_trig_uretprobe_multi_nop5;
> +extern const struct bench bench_trig_usdt_nop;
> +extern const struct bench bench_trig_usdt_nop_combo;
>  #endif
>
>  extern const struct bench bench_rb_libbpf;
> @@ -617,6 +619,8 @@ static const struct bench *benchs[] =3D {
>         &bench_trig_uretprobe_nop5,
>         &bench_trig_uprobe_multi_nop5,
>         &bench_trig_uretprobe_multi_nop5,
> +       &bench_trig_usdt_nop,
> +       &bench_trig_usdt_nop_combo,
>  #endif
>         /* ringbuf/perfbuf benchmarks */
>         &bench_rb_libbpf,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index aeec9edd3851..b4b03fe1f61d 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -405,6 +405,23 @@ static void *uprobe_producer_nop5(void *input)
>                 uprobe_target_nop5();
>         return NULL;
>  }
> +
> +void usdt_1(void);
> +void usdt_2(void);
> +
> +static void *uprobe_producer_usdt_nop(void *input)
> +{
> +       while (true)
> +               usdt_1();
> +       return NULL;
> +}
> +
> +static void *uprobe_producer_usdt_nop_combo(void *input)
> +{
> +       while (true)
> +               usdt_2();
> +       return NULL;
> +}
>  #endif
>
>  static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
> @@ -542,6 +559,47 @@ static void uretprobe_multi_nop5_setup(void)
>  {
>         usetup(true, true /* use_multi */, &uprobe_target_nop5);
>  }
> +
> +static void usdt_setup(const char *name)
> +{
> +       struct bpf_link *link;
> +       int err;
> +
> +       setup_libbpf();
> +
> +       ctx.skel =3D trigger_bench__open();
> +       if (!ctx.skel) {
> +               fprintf(stderr, "failed to open skeleton\n");
> +               exit(1);
> +       }
> +
> +       bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt, tru=
e);
> +
> +       err =3D trigger_bench__load(ctx.skel);
> +       if (err) {
> +               fprintf(stderr, "failed to load skeleton\n");
> +               exit(1);
> +       }
> +
> +       link =3D bpf_program__attach_usdt(ctx.skel->progs.bench_trigger_u=
sdt,
> +                                       0 /*self*/, "/proc/self/exe",
> +                                       "optimized_attach", name, NULL);
> +       if (libbpf_get_error(link)) {
> +               fprintf(stderr, "failed to attach optimized_attach:%s usd=
t probe\n", name);
> +               exit(1);
> +       }
> +       ctx.skel->links.bench_trigger_usdt =3D link;
> +}
> +
> +static void usdt_nop_setup(void)
> +{
> +       usdt_setup("usdt_1");
> +}
> +
> +static void usdt_nop_combo_setup(void)
> +{
> +       usdt_setup("usdt_2");
> +}
>  #endif
>
>  const struct bench bench_trig_syscall_count =3D {
> @@ -609,4 +667,6 @@ BENCH_TRIG_USERMODE(uprobe_nop5, nop5, "uprobe-nop5")=
;
>  BENCH_TRIG_USERMODE(uretprobe_nop5, nop5, "uretprobe-nop5");
>  BENCH_TRIG_USERMODE(uprobe_multi_nop5, nop5, "uprobe-multi-nop5");
>  BENCH_TRIG_USERMODE(uretprobe_multi_nop5, nop5, "uretprobe-multi-nop5");
> +BENCH_TRIG_USERMODE(usdt_nop, usdt_nop, "usdt_nop");
> +BENCH_TRIG_USERMODE(usdt_nop_combo, usdt_nop_combo, "usdt_nop_combo");
>  #endif
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh b/to=
ols/testing/selftests/bpf/benchs/run_bench_uprobes.sh
> index 03f55405484b..3656676d99d2 100755
> --- a/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
> @@ -2,7 +2,7 @@
>
>  set -eufo pipefail
>
> -for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,n=
op5}
> +for i in usermode-count syscall-count {uprobe,uretprobe}-{nop,push,ret,n=
op5} usdt_nop usdt_nop_combo

usdt_{nop,nop5}, consistency ;)


>  do
>         summary=3D$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(=
' -f1 | cut -d' ' -f3-)
>         printf "%-15s: %s\n" $i "$summary"
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/te=
sting/selftests/bpf/progs/trigger_bench.c
> index 4ea0422d1042..3225b4aee8ff 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -1,10 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2020 Facebook
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <asm/unistd.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
> +#include "bpf/usdt.bpf.h"
>
>  char _license[] SEC("license") =3D "GPL";
>
> @@ -180,3 +181,10 @@ int bench_trigger_rawtp(void *ctx)
>         handle(ctx);
>         return 0;
>  }
> +
> +SEC("?usdt")
> +int bench_trigger_usdt(void *ctx)
> +{
> +       inc_counter();
> +       return 0;
> +}
> --
> 2.53.0
>
