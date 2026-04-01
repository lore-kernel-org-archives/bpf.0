Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643B478E42
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061105; cv=pass; b=jszOyPnr3JM7w+b0Y3GW8kCV3bbz1tWc191ucECJPNAwZHHX3uw6tE1qPE8yPUKZTgUgwvIXyExBv7jgsaHvJ8UJ77bLhZj/u3ZnkhpMkCDYGxos8TUk+EgYIfh2WZoKS3HzN3D7hiSVTdxdEQu1LrgFoArc9RcIh5KtyoGDyd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061105; c=relaxed/simple;
	bh=vUWK6Mch/mIIa6f9eQkb3mv+zNUqTT1q1KRQ4lBDuWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2i2jLqrM9OuB/zVoho96Oa9XPuqxga9ys7jPRo8K9OES1OU34WdsFUIIn+e/iV4mG2Fob/ktnC2CM4HlQQuEvAZqZsMtNNWqbQIoutLLK2G71mvJWCkpfrcabXETf9NqXShfP1bwGDAFUzSN94NdmpInG7JykDT3oQroWnc16E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgT3ebTi; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgT3ebTi"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so65606195e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775061100; cv=none;
        d=google.com; s=arc-20240605;
        b=j7bURk2X7uBm0CpcUaF46jOkP+Zo5ea0cLcYJAoLuqCa6sfWOFQwKVwor998BjEjce
         BoChQgKL6VaKpDmTKZhI6i1Un5ip4IRaLJk+Xl005NiA1UUUC+4W6UNFaKY+Ziz/hswn
         kHGofmixnF+nVHRuzOyvBXhHZxBrtXFZN2CdHdZGyXOMEnvez3w3cXpJ0bJR2xxNTXuE
         Z/LeqdOCkEzh4i0jo/VdBsN5lgNR4gdyuITVFW2tyiexXmNZ9FNBFYiUk1Jq8bZ/Aa0g
         +2Vp+dXtu0yFEYfkC33jqZm8IxSnhDRp9X/FfDwiFLKUCy+E1iB6mU9tUU4bFzXWtKz3
         KT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1gpwZ9cqCvOrR11tIHwgUSMSGPcazA0YBYH1IC9uu2Q=;
        fh=f6zcVt/SalqZepWQ+uoBKmOc90TqZ6Ju9hBl/3ueRGg=;
        b=WUgNol9t78ZzAWb3tFHbf10udmBqUM1oMaWB4qLnyat1zuk1QNg6uv6gegShO4I1cb
         0haFk0YsQWXthDel3mTtHUXdiFE8/x24altTKRV76HG/RrLWCot8V0WudbPN7mEWC+zV
         CwAotwDocwJmWfo5BgolGkNLacPBGIBezir1brjASYixU6G+NqzayZXFvGMqNUp0sTjw
         1KQF69SKTFKkhWgCSA2vgM5yGcYkiXdDw/44sv3qhCtNukY5mGJWmndNZW+Cw3sucfIJ
         piKemx4+SMVmAnJpeL/8y9yAXE9IQMDKCztODinV+03ekYPa56TSsYvgd5YX3/k1zM0N
         s5jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775061100; x=1775665900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1gpwZ9cqCvOrR11tIHwgUSMSGPcazA0YBYH1IC9uu2Q=;
        b=YgT3ebTiauqJCwcOeeINZgnKN8P92+08QmVVuaaxC8qjCFZEJexHBK+zYmMHQcrEIX
         iCXvxaXmrEs+FL07j+bOu85KIncHVUsLUz4sO8PL3wmysrlweO209xP5+XBuNiQpgCIH
         nuX9M1vbCK1pQ6Wr3TEr/7mNonbiljXzEDYklGLnysPW6a++QdTJ1eRlDUTyEUN8vd+8
         FQmhP0f8dfI3JT7hstR6TzqlPjOy0hgmkMsUoq3x9qZCtOCSYDuVMtxCJzbvf3mbTwgq
         PHAlz8HnbYvDSWG3PDtQE5D2SEex5W42S4k+VEAfpSnBOeflOlieM6IYodPzlSg+/fZH
         QTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061100; x=1775665900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gpwZ9cqCvOrR11tIHwgUSMSGPcazA0YBYH1IC9uu2Q=;
        b=DJ64qMJpraerpM7GCwL7yWhZ/MRNeefvQUdMlxTnsEnVqdYH63Q+m7AdZDRC3arGJz
         slsVa5D7AJ62yeTMgIT0Dnut+Qvh8r/gg8+ELMXvgLwBn2BiBuMJGwSa9jqpwEf6uvZN
         0CK06Ek36sTyQSqqhzFIZnGprZk2pSp8PdLRWAeT8k6dZelTPA60E3Dqv/ZeT5ZJcbqW
         Aj5Gukmye5MZ8xlWRoqYUJWyEhBNnoLudJPV7e06krh6bwWXEdrbR8BUnwdMV2REGlx/
         oB7zsXuqvm1W1Wy14wFD2JvKSzIIhF3Lg2foTUoVaxzGzzVtgc7lHb/qslkV2oViJtZ6
         T81Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUxeUNNUgOQiLOBlGbd5OdcfrPiXCNgPEUAu25X2H5/7FoY1o9D8+wa/Bm/M6Qmb5TkYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtNJiSvXwpHq3+E+8jYOlSWudUL7pRamr82sHmtY9h+t0OeIU
	Gbl+qjE61VvZjF6AfT6kF48Le0VIeFZhpyjkT03xHun5pv6JPHHE2mJ7ajA4+lvOpzJdDQ0Ife0
	S+a/5LFUDQs2uuwgQAwBmwtPZrFJgNr8=
X-Gm-Gg: ATEYQzylcScc0JfUNjc4Es5Mq7eyBIJvr1OFoNVCO7F3/H7QW9bIZmvWoaCeXJhOA0P
	ABY6yzLOhw63fawQF8gVkzUe1F13W7cTWoqOn2UzniekgcGHvMMwg+vExVXpH1vTbokfoBMOsaI
	VpXNxWFBPsCVbw9fDpadNEs9yMX5jPHMAXtOiCKtsoYKxIqGQ10Gthw0m8xMuK/HLeCbxxQ+uJ+
	P0HsRUovzOpr/X81YE/KDHk7hQq3ikbA0MAAVrTDBxT2fbKWG9U+GALElNJqT42QJxlT7wRGwkE
	LfwBViTX8ttxNxBKHUiZZP8f4RainNb0X4GgbES1u0Yqi44XAnGBUMPBg0CNWmeemMbVdQ==
X-Received: by 2002:a05:600c:4c27:b0:487:1826:d89b with SMTP id
 5b1f17b1804b1-4888b2edb80mr1278555e9.9.1775061100246; Wed, 01 Apr 2026
 09:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0hLyMuPHiZfnVc@computer> <20260401162555.426867-1-varunrmallya@gmail.com>
In-Reply-To: <20260401162555.426867-1-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 18:31:02 +0200
X-Gm-Features: AQROBzBVfO752JX-VtB9VPdZLJOP2Hq_tKzfFd_W-hvYatioGx43o4rgHLoCLp4
Message-ID: <CAP01T74YgnKop-dgwBToOcfg4_D44t1wUBopFYPMquirCmaLfg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Reject sleepable kprobe_multi programs at
 attach time
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 18:26, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
>
> This causes a "sleeping function called from invalid context" splat:
>
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
>
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
>
> Also add a selftest that tries to load a sleepable kprobe_multi program
> and it needs to be rejected for the test to pass.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---

Looks ok, but please split kernel fix and tests into separate patches,
and no need to reply to this thread.

pw-bot: cr


>  kernel/trace/bpf_trace.c                      |  4 ++
>  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
>  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..af7079aa0f36 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>         if (!is_kprobe_multi(prog))
>                 return -EINVAL;
>
> +       /* kprobe_multi is not allowed to be sleepable. */
> +       if (prog->sleepable)
> +               return -EINVAL;
> +
>         /* Writing to context is not allowed for kprobes. */
>         if (prog->aux->kprobe_write_ctx)
>                 return -EINVAL;
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 78c974d4ea33..f02fec2b6fda 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -10,6 +10,7 @@
>  #include "kprobe_multi_session_cookie.skel.h"
>  #include "kprobe_multi_verifier.skel.h"
>  #include "kprobe_write_ctx.skel.h"
> +#include "kprobe_multi_sleepable.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "bpf/hashmap.h"
>
> @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
>  }
>  #endif
>
> +static void test_attach_multi_sleepable(void)
> +{
> +       struct kprobe_multi_sleepable *skel;
> +       int err;
> +
> +       skel = kprobe_multi_sleepable__open();
> +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> +               return;
> +
> +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> +                                    BPF_F_SLEEPABLE);
> +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> +               goto cleanup;
> +
> +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> +       err = kprobe_multi_sleepable__load(skel);
> +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> +               goto cleanup;
> +
> +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> +        * Also chosen a stable symbol to send into opts
> +        */
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       const char *sym = "vfs_read";
> +
> +       opts.syms = &sym;
> +       opts.cnt = 1;
> +
> +       skel->links.handle_kprobe_multi_sleepable =
> +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> +                                                     NULL, &opts);
> +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> +                      "bpf_program__attach_kprobe_multi_opts");
> +
> +cleanup:
> +       kprobe_multi_sleepable__destroy(skel);
> +}
> +
>  void serial_test_kprobe_multi_bench_attach(void)
>  {
>         if (test__start_subtest("kernel"))
> @@ -676,5 +715,7 @@ void test_kprobe_multi_test(void)
>                 test_unique_match();
>         if (test__start_subtest("attach_write_ctx"))
>                 test_attach_write_ctx();
> +       if (test__start_subtest("attach_multi_sleepable"))
> +               test_attach_multi_sleepable();
>         RUN_TESTS(kprobe_multi_verifier);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> new file mode 100644
> index 000000000000..56973ad8779d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +SEC("kprobe.multi")
> +int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
> +{
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.53.0
>
