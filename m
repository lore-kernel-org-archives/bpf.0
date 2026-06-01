Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD183672A1
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343751; cv=none; b=s93FywDiIpc3/5UqS3jF5RIqiuq8PzVrxMyT1WMamSYyVivJ2Vkh0quA9i8A5au42srhmi12/QZX7q9mByfJ/uF9niQj6MXpbw2b44lBmEl0WUur9DBdxY2EKBPcXfwoSbg+1LiJIBckql424ET32I7BKCfS1h1TzYly+ug39AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343751; c=relaxed/simple;
	bh=yy/FahWvVhxwoeV2vAmZivByfJ15h+f2J5IhLIs3LJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=AMPTDRNiv1FQfTNkxoxqVwQt0jc0HU2nKIfS2LHJAzGcjxquJNrqWugmDN6HmTIePABXx0j0BY5HKVo1D32J/vy8wrnA7Y2NiayXbBaz078EF7xwOeUkAdl0yCxPclnrc22bTsSTa23QiOGg+WTOIDi7b/ihBcxJL5BLi0d2YgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eGazGPVt; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eGazGPVt"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304e58292d3so7533395eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780343749; x=1780948549; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clBY1kGXZXA2bHl4zt3mvE+AmGaC+Xd6DYPyFSWFDzM=;
        b=eGazGPVt6DfnCfNtCb4PPsgZa0F9VGBpyrNIASXz8O/SGgYswiOEz1IeVG4wtpZTlP
         YEngNxAhPv9cxzAc2blANGiYibdMylkp5z8WJtv/u5DazlWyXKFKR7wM85WT4xcfqCWs
         fg40SVPNtEuZvhMduEwxYYQeO3smlVukvrghjtDsft7xUJ0MSvnkXnejTXq7EdnMKWzH
         jRYHsYoLfH9Vn1UYsA1WEv5T5/PuEC2goEObwsK3DO4WxVZZm6eFeMO6F2mNhuovUUMt
         4NqjEYjDSTILdEWyKLjHRJkr8iiIIOlNWrTuhU1QhvTwvCWKtedQEvf56HpyCO+4VYD4
         ozPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780343749; x=1780948549;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clBY1kGXZXA2bHl4zt3mvE+AmGaC+Xd6DYPyFSWFDzM=;
        b=XvhjR6UzEMPkMR1OPn8+injgO4LFb0w7IJHWe9p0yF3Ufutothu1E/E+a03f9dUimh
         tIvkJrL0d+e1Q49h2xYSuzbhuHWELVep11qA7ZHEgaoMqH3kziIExW2n6oUqmNQLm0JL
         URf9VKleZ8tIzLPITHgGhJtodl2Eldheds6BUXEjyMoX8JXbdUcN66xhzyci63V/a5Y/
         amxk+YRWaijNn0iWNh5X7ZZM7/dIcOmiEFNUUjBMcYo4oOauiEM/1I3ENw9wRlJ7MBJw
         +BWvSyJ1vTctRLqUjOZEcOaMfguRoexucGwJyXL/ls7eXYayDsSWdRwPsb02Brh/7cDj
         pEWA==
X-Forwarded-Encrypted: i=1; AFNElJ8pJAvGxvXrx6fce+CtM5nxuOmQNVWXnvw8UmSff0smrg/MQ8D4vVXic0I/Zz3EBRXLgVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItJooopmAop6j/be2gBs2fpPWZZHTDiULTSRcwvXXklnMt34B
	7f0Ds03SImW+7G/LZiJ6hl+jMAN8Q8QAV7D2CZF9o8S1ccsbbzizAuP/G8i9gjJ0xDq+PMNGXNF
	b3coChiqlvkSP
X-Gm-Gg: Acq92OEeJj7VY+5G+t4gBXB+tJN6Qztju9EOZSWfq18tIsoA0eqXMOIGfRpaymIzsAe
	LFxiFk06EfWOdcGa3nRUlwCLV9M6vtoAc1Ff14Oc4BoZwKRj+2QsDpJ7Vopk9xQvSxR3L4E92bV
	wl2mE5+SbjXRyhwmJoFO8v21KiCBaiyCQFuh8lg0znG5fz3XtRZX6GnqJeHdo8UxtLXOAqybYc9
	vRlKyOrh40nMLXq9bM9Y4w2fWSKTvgOBcyZysmJ32DGE979nI11TY770KwqIsATKocmNooK8Bq3
	HWTDa2UeF6RyP9W3JKB7J+fhHpeLjWVztDH3QsybxNqSzZGg5McOU6wj9jDGRANb7X2pFOfn9ez
	dwU3GHQl3furH50YI3AV4s1GXanBUWRP+r3KgoM6ehPb2d/C9jH1JYHFvxqDO9bN3y22WQHSfZE
	3otmkgf/U0TJNWt5Y+HDeHMS2BmQ==
X-Received: by 2002:a05:7300:6c84:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-304fa67401amr6648256eec.22.1780343749241;
        Mon, 01 Jun 2026 12:55:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::ceef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c3121sm9848957eec.5.2026.06.01.12.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:55:47 -0400
Message-Id: <DIXZ6QFPCYP6.105GNJKB1H44U@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 6/6] selftests/bpf: test budget
 exhaustion profiling report
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-6-b3ede0588a75@gmail.com>
In-Reply-To: <20260527-better-1m-reporting-v3-6-b3ede0588a75@gmail.com>

On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> Add verifier selftests that exhaust the 1M instruction budget and
> verify that the new profiling report is produced:
> - nested function calls with inner loop, check that stack trace is
>   print correctly;
> - two loops on the same level, check that both are reported;
> - iterator-based loop with non-converging register, check that
>   register is in the report;
> - iterator-based loop with non-converging stack slot, check that stack
>   slot is in the report.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
>  .../selftests/bpf/progs/verifier_budget_report.c   | 175 +++++++++++++++=
++++++
>  2 files changed, 177 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 35d92d176c1f..61a732a499b0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -14,6 +14,7 @@
>  #include "verifier_basic_stack.skel.h"
>  #include "verifier_bitfield_write.skel.h"
>  #include "verifier_bounds.skel.h"
> +#include "verifier_budget_report.skel.h"
>  #include "verifier_bounds_deduction.skel.h"
>  #include "verifier_bounds_deduction_non_const.skel.h"
>  #include "verifier_bounds_mix_sign_unsign.skel.h"
> @@ -169,6 +170,7 @@ void test_verifier_bounds(void)               { RUN(v=
erifier_bounds); }
>  void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_dedu=
ction); }
>  void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_b=
ounds_deduction_non_const); }
>  void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mi=
x_sign_unsign); }
> +void test_verifier_budget_report(void)        { RUN(verifier_budget_repo=
rt); }
>  void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_sta=
ck); }
>  void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); =
}
>  void test_verifier_bswap(void)                { RUN(verifier_bswap); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_budget_report.c b=
/tools/testing/selftests/bpf/progs/verifier_budget_report.c
> new file mode 100644
> index 000000000000..7b87e53831c2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_budget_report.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("tracepoint")
> +__failure
> +__log_level(1)
> +__msg("two_level_calls():")
> +__msg("  0: (85) call pc+1")
> +__msg("  1: (95) exit")
> +__msg("two_level_calls__l1():")
> +__msg("  2: (85) call pc+1")
> +__msg("  3: (95) exit")
> +__msg("two_level_calls__l2():")
> +__msg("  4: (b7) r0 =3D 0")
> +__msg("  5: (07) r0 +=3D 1")
> +__msg("  6: (05) goto pc-2")
> +__msg("#1 most visited simulated stacktrace (visited 499999 times):")
> +__msg("  two_level_calls/0 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})"=
)
> +__msg("  two_level_calls__l1/2 ({{.*}}/verifier_budget_report.c:{{[0-9]+=
}})")
> +__msg("  two_level_calls__l2/5 ({{.*}}/verifier_budget_report.c:{{[0-9]+=
}})")
> +__msg("BPF program is too large. Processed 1000001 insn")
> +__naked void two_level_calls(void)
> +{
> +	asm volatile ("					\
> +	call two_level_calls__l1;		\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +__used
> +static __naked void two_level_calls__l1(void)
> +{
> +	asm volatile ("					\
> +	call two_level_calls__l2;		\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +__used
> +static __naked void two_level_calls__l2(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	goto 1b;					\
> +"	::: __clobber_all);
> +}
> +
> +SEC("tracepoint")
> +__failure
> +__log_level(1)
> +__msg("two_loops():")
> +__msg("  0: (b7) r6 =3D 250000")
> +__msg("  1: (b7) r0 =3D 0")
> +__msg("  2: (07) r0 +=3D 1")
> +__msg("  3: (ad) if r0 < r6 goto pc-2")
> +__msg("  4: (b7) r0 =3D 0")
> +__msg("  5: (07) r0 +=3D 1")
> +__msg("  6: (05) goto pc-2")
> +__msg("#1 most visited simulated stacktrace (visited 250000 times):")
> +__msg("  two_loops/2 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
> +__msg("#2 most visited simulated stacktrace (visited 249999 times):")
> +__msg("  two_loops/5 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
> +__msg("BPF program is too large")
> +__naked void two_loops(void)
> +{
> +	asm volatile ("					\
> +	r6 =3D 250000;					\
> +	r0 =3D 0;						\
> +1:	r0 +=3D 1;					\
> +	if r0 < r6 goto 1b;				\
> +	r0 =3D 0;						\
> +2:	r0 +=3D 1;					\
> +	goto 2b;					\
> +"	::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__failure
> +__log_level(1)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("iter_loop():")
> +__msg("  8: (bf) r1 =3D r6")
> +__msg("  9: (85) call bpf_iter_num_next")
> +__msg("  10: (15) if r0 =3D=3D 0x0 goto pc+3")
> +__msg("  11: (07) r7 +=3D 1")
> +__msg("  12: (25) if r7 > 0xf4240 goto pc+1")
> +__msg("  13: (05) goto pc-6")
> +__msg("#1 most visited simulated stacktrace (visited 142856 times):")
> +__msg("  iter_loop/8 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
> +__msg("#2 most visited simulated stacktrace (visited 142856 times):")
> +__msg("  iter_loop/9 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
> +__msg("    Most varying: R7 (frame 0)")
> +__msg("BPF program is too large. Processed 1000001 insn")
> +__naked void iter_loop(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D r10;					\
> +	r1 +=3D -16;					\
> +	w2 =3D 0;						\
> +	w3 =3D 1000000;					\
> +	call %[bpf_iter_num_new];			\
> +	r7 =3D 0;						\
> +	r6 =3D r10;					\
> +	r6 +=3D -16;					\
> +1:	r1 =3D r6;					\
> +	call %[bpf_iter_num_next];			\
> +	if r0 =3D=3D 0 goto 2f;				\
> +	r7 +=3D 1;					\
> +	if r7 > 1000000 goto 2f;			\
> +	goto 1b;					\
> +2:	r1 =3D r6;					\
> +	call %[bpf_iter_num_destroy];			\
> +	r0 =3D r7;					\
> +	exit;						\
> +"	:
> +	: __imm(bpf_iter_num_new),
> +	  __imm(bpf_iter_num_next),
> +	  __imm(bpf_iter_num_destroy)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__failure
> +__log_level(1)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("iter_stack_varying():")
> +__msg("  10: (85) call bpf_iter_num_next")
> +__msg("#1 most visited simulated stacktrace (visited 111110 times):")
> +__msg("  iter_stack_varying/10 ({{.*}}/verifier_budget_report.c:{{[0-9]+=
}})")
> +__msg("    Most varying: fp-24 (frame 0)")
> +__msg("BPF program is too large. Processed 1000001 insn")
> +__naked void iter_stack_varying(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D r10;					\
> +	r1 +=3D -16;					\
> +	w2 =3D 0;						\
> +	w3 =3D 1000000;					\
> +	call %[bpf_iter_num_new];			\
> +	r8 =3D 0;						\
> +	*(u64 *)(r10 - 24) =3D r8;			\
> +	r6 =3D r10;					\
> +	r6 +=3D -16;					\
> +1:	r1 =3D r6;					\
> +	call %[bpf_iter_num_next];			\
> +	if r0 =3D=3D 0 goto 2f;				\
> +	r8 =3D *(u64 *)(r10 - 24);			\
> +	r8 +=3D 1;					\
> +	*(u64 *)(r10 - 24) =3D r8;			\
> +	if r8 > 1000000 goto 2f;			\
> +	goto 1b;					\
> +2:	r1 =3D r6;					\
> +	call %[bpf_iter_num_destroy];			\
> +	r0 =3D *(u64 *)(r10 - 24);			\
> +	exit;						\
> +"	:
> +	: __imm(bpf_iter_num_new),
> +	  __imm(bpf_iter_num_next),
> +	  __imm(bpf_iter_num_destroy)
> +	: __clobber_all);
> +}
> +
> +void iter_num_btf_fixup(void)
> +{
> +	bpf_iter_num_new(0, 0, 0);
> +	bpf_iter_num_next(0);
> +	bpf_iter_num_destroy(0);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

