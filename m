Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9D33B6E3
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992500; cv=pass; b=M0Kk/MTZsS6f1Q2sIUoxFpgh7bhAjFyW6PgFDxkqA1Vah0MfdQE4bJg4e0zLgYaPSzquvFaUdge2M2maeMLDCzV6WmQo7X5jpiS3G330calLvQJXrI8pI25z5s1WoiJIt2u18c6DMVt4C443MLm5fzLV9R38egUu0X4GiDL1mYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992500; c=relaxed/simple;
	bh=sRgBMZ3M2uPrOgfZT1tgj6ndieG3ibGSb+9UWbjJn/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw8UMWpoyhPot+QprninZGcJfXNGAyAX6Ge9WICk0RNw95bDETP4bPVRieZGTPSQ7IbTU17FuA//GaJNUhNX5/K459czquNFOXS3GT9XYqbbiV7V+dPc+yUcG6lD8Ch5XNp9nJmuHX1EikeWGBQOQGyd+7MiECH4L7TmRuUz/x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em8XPdQM; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em8XPdQM"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76af79f029so687595a12.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992499; cv=none;
        d=google.com; s=arc-20240605;
        b=kweZm1pyTuXsKlFXcsoEW3ndhtMTqpsXXK9CrZlxMQx7OXDVgBYvp7+zxB31IQMDUO
         mZwqCeW+GHWVXXIgIFkToKaSBhmVgCeGk8cC4UjVURjfSkUVPbvoyomKyLKhifERphNU
         0odkuVaYD89cP98yjCQ/zABa1jT0ji+HltG+KPngtc+u5al1Wo/8RS5Mce6a1INUYbqr
         6lKhUkjMMkYS2KSiLNtWTxvyqS9fGrpmJGplS+m2t19th4lLORbG4yPC9P30rn8d7BFI
         osjXNQdJyH9jjhwWJu+3ARnnAcc8Mw9Z1dAoTD0wldX/aEsPZlUWWbhzjukDrrXFdooq
         Muhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kKIspEKqIilGus4ZlXNUBmXjyuQCqv6BcoyjUgXPRJ4=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=Ua87xuQoAZnvGV8XLHkKa1uHL5SPMDNs5ykkiYWKIXfNGXHajDatr9fIcGbypmdkEI
         71qnqmk0/YPGAJ+IBMRYTMAuNke9bn43bPDMyXwWDry++8zUShSxOLWzU1kFao0quWox
         V3tL3x3YfZ2LK5lzLTjPNICR+EN2rgGc/TdcSUAOv+nQW31KEzkkCZCVU5hCbIz5LpcS
         rUlZJtaQaWkE3jicMeEOjRStN0ykgJnjIRmmqtASn/36XCzZ8lrsDWTDH3BbObQ4NAas
         AHkH2vlcmp/L8XlJA7fTxiSfRQbeXrMOJ7t2Sk1h8rt/fmHDU6C0/6Nr5lhsRWLy0fD7
         ATJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992499; x=1775597299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKIspEKqIilGus4ZlXNUBmXjyuQCqv6BcoyjUgXPRJ4=;
        b=em8XPdQMMDLFAxhkmzxI9fpsIznrSWjIbUQN90Gb2iKZcukbTP4eJzNtDfe3KQ61+P
         z8hBukR2+ezgM/7jCzC0z5ZlRBqqD5iWR6h+WjP3dqAjx6N69m07zMxf9KP6tTg9Vhj9
         Psdw/ShanbIHcX1oaCgcYsm9jIYfzOhy3mUzqDfen68CiPbWvB2c90Xf7SZuBg5CZ+U7
         QmLvvvyIG0t7f7PAy9CZktaRsNJlKqjI2qJF1fhnuF4ynd/loOnVardR39Newk6rUdxa
         zQkDpfR5hckItIl6wrzs+7m/VwUelxuwjjyXCijYd1UzVsTaKoQI0Dzs175EN8PlsmaG
         SWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992499; x=1775597299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKIspEKqIilGus4ZlXNUBmXjyuQCqv6BcoyjUgXPRJ4=;
        b=dS2AXGpummF+WGA/xNxIf3tcBo7At+UERpHOtIwXzdi+Z6e9u+ytLbb5JF8hST7RWC
         dokE6SaASxwuC86LAXM+xuxiJM9I87rRQ1/aOi+h/4Hh4F0U+QNKMy7yzOC5rZxby5sJ
         MmCyVV7NBf9qqbHeCeSOQMOev91zF65ihiKtjPaNEF51UvFILONAREkM6fb1B60b8Msk
         jeukpOg1s07r9k5JydtC5vBH2/iRIZNxXqJ92r1y7Ai67m71XWMSLWn2J7B+KlMQngop
         +Gvct/fVXb4esQLqh1jYh++ETyGr0n7VKmlhAkdwQC+coFZXBsXoldrvaZf6CLOPmL3U
         VN+Q==
X-Gm-Message-State: AOJu0YzQGw1NO4T0GX9BoQz2c6s5bDKMwZ5ZnIBkBer2yN1+JKBoGEzz
	IiQmistwm/8ej8OeHNfIwBZcjf2pZINkW3MCa9nqeBsmrCYpJihCHgYfGN3gdrHDtlHED8zoI1H
	u2awFnNXJpb7hZvlhOEmTAUaAjFdo9j8=
X-Gm-Gg: ATEYQzxi0QzSAJ/Rv9K1DbrEoLaU6yUao854zfA+yYMdbzFCwfmzg33q0jXLKXfXHMJ
	utE84AW8NLjSl/w943S+TqwAqabolP4b7EalRKrAXDLd7GCTRL74+3heGxeVfmG0b2okJy0JOI/
	CdfuzW/z7MzRClrP/FK5OHe1+//4hN8B7Egh1lBGt4Xikhk3d9Twkow4u9r8WJdRJ1yiP/bjOhV
	uayR8qOJhFNrBxDkHy3Mzzy5R+2DXU8FUwoNFlzq2HlCUCJa/RbD2bv+aulKpz1YsK46genkzQb
	3YL99KgbOcpVNfMux14lbHo=
X-Received: by 2002:a05:6a20:9145:b0:398:7855:1596 with SMTP id
 adf61e73a8af0-39ef71fc84bmr810112637.10.1774992498758; Tue, 31 Mar 2026
 14:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com> <20260330-sleepable_tracepoints-v8-6-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-6-2e323467f3a0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 14:28:04 -0700
X-Gm-Features: AQROBzBIg7HB2qtDOZqqUfLV4NqYaxDFl477F6TYqZLT2vujlLAcAdJFpIO573E
Message-ID: <CAEf4BzZ_YOb1MNpUxuhFESqRWARFiBJ6yGZ-Z8xBqdCvqi_Bow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add functional tests for sleepable tracepoint programs that attach to
> the nanosleep syscall and use bpf_copy_from_user() to read user memory:
>  * BTF-based raw tracepoint using SEC("tp_btf.s/sys_enter")
>  * Classic raw tracepoint using SEC("raw_tp.s/sys_enter")
>  * Classic tracepoint using
>    SEC("tp.s/syscalls/sys_enter_nanosleep") receiving
>    struct syscall_trace_enter with direct access to args[].
>  * Sleepable raw_tp executed via bpf_prog_test_run_raw_tp()
>
> Add a negative test (handle_sched_switch) that verifies sleepable
> programs are rejected on non-faultable tracepoints (sched_switch).
>
> Update verifier/sleepable.c tests:
>   - Add "sleepable raw tracepoint accept" test for sys_enter.
>   - Rename reject test and update error message to match the new
>     descriptive "Sleepable program cannot attach to non-faultable
>     tracepoint" message.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../bpf/prog_tests/sleepable_tracepoints.c         | 153 +++++++++++++++=
++++++
>  .../bpf/progs/test_sleepable_tracepoints.c         | 128 +++++++++++++++=
++
>  .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
>  tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
>  4 files changed, 314 insertions(+), 2 deletions(-)
>

[...]

> +void test_sleepable_tracepoints(void)
> +{
> +       struct test_sleepable_tracepoints *skel;
> +       struct bpf_link *link;
> +       int err;
> +
> +       skel =3D test_sleepable_tracepoints__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +               return;
> +
> +       /* Primary functional tests: full bpf_copy_from_user exercise */
> +
> +       if (test__start_subtest("tp_btf"))
> +               run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf,=
 skel);
> +
> +       if (test__start_subtest("raw_tp"))
> +               run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp,=
 skel);
> +
> +       if (test__start_subtest("tracepoint"))
> +               run_auto_attach_test(skel->progs.handle_sys_enter_tp, ske=
l);
> +
> +       /* Alias SEC variants: verify libbpf prefix parsing */
> +
> +       if (test__start_subtest("tracepoint_alias")) {
> +               link =3D bpf_program__attach(skel->progs.handle_sys_enter=
_tp_alias);
> +               if (ASSERT_OK_PTR(link, "tp_alias_attach"))
> +                       bpf_link__destroy(link);
> +       }
> +
> +       if (test__start_subtest("raw_tracepoint_alias")) {
> +               link =3D bpf_program__attach(skel->progs.handle_sys_enter=
_raw_tp_alias);
> +               if (ASSERT_OK_PTR(link, "raw_tp_alias_attach"))
> +                       bpf_link__destroy(link);
> +       }


why alias tests are different? and why not have an array

struct { const char *name; struct bpf_program *prog } cases[] =3D {
   { "tp_btf", skel->progs.handle_sys_enter_tp_btf},
    ...
}

and then do the tests in a loop?
> +
> +       /* Bare SEC variants: verify manual attach */
> +
> +       if (test__start_subtest("raw_tp_bare")) {
> +               link =3D bpf_program__attach_raw_tracepoint(skel->progs.h=
andle_raw_tp_bare,
> +                                                         "sys_enter");
> +               if (ASSERT_OK_PTR(link, "raw_tp_bare_attach"))
> +                       bpf_link__destroy(link);
> +       }
> +
> +       if (test__start_subtest("tp_bare")) {
> +               link =3D bpf_program__attach_tracepoint(skel->progs.handl=
e_tp_bare, "syscalls",
> +                                                     "sys_enter_nanoslee=
p");
> +               if (ASSERT_OK_PTR(link, "tp_bare_attach"))
> +                       bpf_link__destroy(link);
> +       }
> +

[...]

> +
> +static __always_inline bool is_target_nanosleep(long id)
> +{
> +       return (bpf_get_current_pid_tgid() >> 32) =3D=3D target_pid &&
> +              id =3D=3D __NR_nanosleep;
> +}
> +
> +/* Primary functional tests: full bpf_copy_from_user exercise */
> +
> +SEC("tp_btf.s/sys_enter")
> +int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
> +{
> +       if (!is_target_nanosleep(id))

inline the check

> +               return 0;
> +
> +       return copy_nanosleep_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
> +}
> +
> +SEC("raw_tp.s/sys_enter")
> +int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
> +{
> +       if (!is_target_nanosleep(id))

same, just takes longer to find what is_target_nanosleep() does for no
added benefit

> +               return 0;
> +
> +       return copy_nanosleep_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs=
));
> +}
> +

[...]
