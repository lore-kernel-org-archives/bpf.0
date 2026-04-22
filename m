Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071B2D8DDF
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891016; cv=pass; b=CO0OjN2GLEEp2bL6H4cqGsnQv+lY6VxUvQogyuGAtqdpMLCsaZi2zyd/ETsY87Voerc1mRkabiFbVT44rIT/A0QLDXbcKfF4A6WJA6/nxJgIeVwHzjO2Do+jCQTcVHQ/LAaXmfmo2PmjQV1RafHcfzrDIa0mXeYObvoW5JyrYr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891016; c=relaxed/simple;
	bh=3Cthv9OE9HrrFIMeyrRuv6hI71ODV4PGN6YaIDE4ONQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifgQP8toSNRYwuclxUYC+2vroi8vtDo7YZ+u7UVMBsfrh9kAAETCViD8Vg8MyWHpSOTbL5Bp16lCcThBZ4JDTX1DKHPViOJKtF3XUNLmtIZBdMH5fSnZqKaDzRA1ldMipjotHh7XI7maAgfqz+wA22qULGFflbEz/sQ9RBNlRoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGae8jBJ; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGae8jBJ"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43eada6d900so5782624f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 13:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776891013; cv=none;
        d=google.com; s=arc-20240605;
        b=ADYUeQWuB1QFS0+Wh3d8r1JZm0qGmO8yplZYdG7oLGOdOsXMPc6kqXV8Y72A7wiS4M
         A4pq+2A/WJLLB6fC4U4HMGmpKPHNGnIIO/QJGvMOmns0F8h1/tKEs2NIspLA9dCy0MI/
         W1K4srJt45ys2AhMZws3TZfhVcIC/lhSr5T6uj7Na59enygqJ+j8SLuSy/cCAwzdLvA3
         4k3RcFUvxc+ddojfufaqfZgmVHv22Q+4rPVLF8AKz6XGl86AZheFhs7WmWvUNKt2ls+R
         0br2ZP6aGcuZRhOQAHob0KlWIAZ5NwUNwwIUOgVuuN2XUi19GsXSt61VkoaOp1+Y0m6J
         cs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c+soleOHWnIH4pOH9mORawKIX6gxGSoMiNRg7wIOJGE=;
        fh=LHEA20+ludzHLz+X8GHxz6JWyqrzPtp6LVjbUn7tP9s=;
        b=QCy3j8joA2MzytbKOf9au81jZZe+0GUzT/NmDYuukgm2SBV50ok3oSktnxP2uLrDHJ
         TA3GuB1IrUBS/8Qa1SG649dDO3rMkE55zNLg4QI6tvejaZcgTPKLrr01e3UevQ6oI9QN
         h3GVsF5XWiYcxuS9cznitXqsml8UHUCSzFXXXE3xnQft8K2j5MXqzC2qS6tMZC18wDWa
         VEMpNjv2s75H+k1MVSXZbCz4iYpccwJFejlUCx5Y6VZ/3vMfyW6tOlJDchIxuZI4euHI
         AP2SU5ZaepNyzRif7K01r5GpZBfQGHMzYo8LZ6wPBEenOCU9z+RwrycMNs9Gc2LdYWN/
         7HKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776891013; x=1777495813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+soleOHWnIH4pOH9mORawKIX6gxGSoMiNRg7wIOJGE=;
        b=QGae8jBJuKqQ8xuk1cxX/AYbhaXoRbwt5aoXFtw4FK+RwjhG/m+bd8DVdVBMvVHNth
         bRfvD6Cfp2O5QUPcI9weVQd83IKbVn8oJY1FC9EUdS28Hi6SZ7CJOPHFjI5g2fwfudkR
         HVXlt5q3/4vycEebw9BeyE+HkqJpoNLyUMKz+0AeBN7rc0IXSQjJBoNeTUTaIBPEEZoV
         gwGRSoG3L6B49Jsp2fXA58rrir/CN8awVBbAs0s7X7m14PPscUUt1+SJCKPBg0rP/X5g
         NwL718Q9vLJaqAUYU76crz0MzPnXS9NW2CYIKSH9DfBPP+gcUd+HkqWoqAqOm3kjNbqD
         IiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776891013; x=1777495813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+soleOHWnIH4pOH9mORawKIX6gxGSoMiNRg7wIOJGE=;
        b=WJ4ymPOGMYBIFsqveuRMvkVBxnjlv4R3ozKjOwCZpzcQu//TrBR5FLZJ+G2n805piH
         +mhyysXgTLyl5UPw0HuQFX+z29HMfjbv4Elb0W2DyuyLsmmq8FrGmMxlAxPS2bkAIL8s
         XIhkhyxzD4JNxQ5WPr5CXWDhVlDmnrLW3hCXeCwyh/ca/V392kLyQ8V8DHXCAcN9LS9m
         FiiH6Y2hAAn0hU2lEpqLHAyNoUdcpTUxDyTS0iHexmT1YD44AwwIfnfWQmvziZujVNH2
         6FjZ/7gXNTa6fRbYUu7FD0rczf/NykUxXoC+hrEEv4QnnEpRYaw/Vcs7mbm7uMRkrdYG
         alVw==
X-Forwarded-Encrypted: i=1; AFNElJ8v1AWBv+QthF4tW0D879AXCgNMrZ4mEpTgId/Iq9BF0vkqQuCMoRin6DzCIlhkb2JPeU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YyBauM3ZEvN35HHwp78OSBtUG2zxVCuPIGFVlbbVwmiIKVlN
	OwRb7nWknS8erqLCavgknOcw7XF/3pvH5uLMF15MFNa1xGnrmEyUDjlMuUgYf4wbb/0kDuFGab4
	JefoqeAccRkQga5c7UoenTni982+efOY=
X-Gm-Gg: AeBDiesX2iKujQAATF5Oa64uGMoJwVCRuZ45fKYS7F2iK2wY8KiDGA5XUOSzz0vUA1Q
	1tnDIXBrmZgbLwIiMiy0LW+Xd9NHFvSB4y4SiA+xNguKmbRBSnW/8BPq1PYf2d6l4JcBfXny3Ty
	IBhjh3NhVQbYVQihBM6D9z6KuDDkyOBF/nQyS4IZOzjh21ule8ugvOsoza6V+ULN0QGHhORgfpk
	KZzgdQFzhp+yS12gpt/bFBAMoeGj7Qfp9FXLtF4xYUVSO4WVLgEgmZx6Wt+zRZ1wngiu1BO3pVL
	+7dW+YfpzoSLB2sdmGS2R3pZOzA1BELOs8C/nEO/sEGDY69ycR79EprpSnPpSfjca4QoUK4oMfg
	8t6wP/NrDlG+lc1LZahCTy3Sm9NWdPx0jYSPQTUHWJDeWJXpEUxyOMi0gb9NcImylZ7Y=
X-Received: by 2002:a05:6000:2282:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-43fe3e0b7e9mr37008002f8f.30.1776891012828; Wed, 22 Apr 2026
 13:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com>
 <0ca1420ce830b146a1ed429af9af7bb489a7959bad702d7080d3be6a325a483d@mail.kernel.org>
 <df7094ce-c286-4201-af8e-442eb7a97743@gmail.com>
In-Reply-To: <df7094ce-c286-4201-af8e-442eb7a97743@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 22 Apr 2026 22:49:36 +0200
X-Gm-Features: AQROBzD9dpGjhsEta_7uNcj9paPYU5ezR_7FmAbJKqySUgG7Us9pTuoEjuqrn-A
Message-ID: <CAP01T77GS+Mgjmy=qCuCWj1mZCS394jze7cvsWS1XaKpxmzuoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 22:37, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/22/26 9:30 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
> >
> > [ ... ]
> >
> >> @@ -0,0 +1,142 @@
> >> +void test_sleepable_tracepoints(void)
> >> +{
> >> +    struct test_sleepable_tracepoints *skel;
> >> +
> >> +    skel = test_sleepable_tracepoints__open_and_load();
> >> +    if (!ASSERT_OK_PTR(skel, "open_and_load"))
> >> +            return;
> >> +
> >> +    if (test__start_subtest("tp_btf"))
> >> +            run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
> >> +    if (test__start_subtest("raw_tp"))
> >> +            run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
> >> +    if (test__start_subtest("tracepoint"))
> >> +            run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
> >> +    if (test__start_subtest("sys_exit"))
> >> +            run_auto_attach_test(skel->progs.handle_sys_exit_tp, skel);
> >> +    if (test__start_subtest("tracepoint_alias"))
> >> +            test_attach_only(skel->progs.handle_sys_enter_tp_alias);
> >> +    if (test__start_subtest("raw_tracepoint_alias"))
> >> +            test_attach_only(skel->progs.handle_sys_enter_raw_tp_alias);
> >> +    if (test__start_subtest("raw_tp_bare"))
> >> +            test_raw_tp_bare(skel);
> >> +    if (test__start_subtest("tp_bare"))
> >> +            test_tp_bare(skel);
> >> +    if (test__start_subtest("test_run"))
> >> +            test_test_run(skel);
> >> +    if (test__start_subtest("test_run_on_cpu_reject"))
> >> +            test_test_run_on_cpu_reject(skel);
> >> +    if (test__start_subtest("raw_tp_non_faultable"))
> >> +            test_attach_reject(skel->progs.handle_raw_tp_non_faultable);
> >> +    if (test__start_subtest("tp_non_syscall"))
> >> +            test_attach_reject(skel->progs.handle_tp_non_syscall);
> >> +    if (test__start_subtest("tp_btf_non_faultable_reject"))
> >> +            RUN_TESTS(test_sleepable_tracepoints_fail);
> >> +
> >> +    test_sleepable_tracepoints__destroy(skel);
> >> +}
> >
> > In v8, Andrii Nakryiko suggested simplifying this test structure by using
> > an array-based approach instead of individual if statements for each test
> > case:
> >
> >    "why not have an array
> >
> >    struct { const char *name; struct bpf_program *prog } cases[] = {
> >       { "tp_btf", skel->progs.handle_sys_enter_tp_btf},
> >        ...
> >    }
> >
> >    and then do the tests in a loop?"
> >
> > Reference: https://lore.kernel.org/bpf/CAEf4BzZ_YOb1MNpUxuhFESqRWARFiBJ6yGZ-Z8xBqdCvqi_Bow@mail.gmail.com/
> >
> > Would an array-driven approach reduce repetition and make it easier to
> > maintain as new test cases are added?
> >
> I did array-driven approach around v10, but then after few de-claudings
> and simplifications ended up with this structure that is more common in
> our selftests. This implementation reuses test logic via generic
> functions, like test_attach_only() or run_auto_attach_test().
> I find it's even better this way.
>

Yeah, I think it's fine this way; it's a matter of preference.

> > [ ... ]
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24799223877
>
