Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695193672B1
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779476242; cv=pass; b=JU0oDLzIhSYsF8L2BaAfHl6TB4EJ8ygc8k/RECw1lPe24hE50Th1QAeDYO5fvaz3VmzP7uQEZ3/hj/yQLZ/PzhKBy8oM84bf9mYCrcbf9cbSDPvLwGepTibriOpSVVK/9j2aJyH8tUkDHeYx2nqEZ87gl0chYg+3f7UmszD0mA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779476242; c=relaxed/simple;
	bh=KvnXkyyBCcToMR6RAkZ81a4j99YJk0Qbk/aUVQOKq6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE4BIET5Oyq+ItvI8FriYTOd/pHQr/IpJlHWYHPW8HggcrmPPqi5lQg/thABT2F6PTWo5dCRDhsu/eLh2hGlZoe1kw7GfD/+bD/k5rXnaYOJhyLgtsHeIk8vvHZ+VmKn7X3K/81YUUqaOAeagC0ZGYJlLrvXePrLR1RhQhDArno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8Kls30j; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Kls30j"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367c26471f5so5014493a91.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779476239; cv=none;
        d=google.com; s=arc-20240605;
        b=IbAwGf6Fcte3/1YS0LOm80nOfnjxC5dbg3IJnqAkBtInxRKT+9M5Zd0DCUkdG6mKg8
         X/TxZWgGP1EUSIzSuUkYGlsDk0CHwG8MU50TghgtiXef6mU64RAXEAg+O/GVCj8au57Z
         U5JmbBazZhP538Y+G1xAsGWmbJb5Jf5AwahMH8A0rI0ALLXnqB3mQY9P8iBOAnDxda3b
         WjgB95iN5UxAIjxJpoIAIuNT3v0/rcdaLjtFPt7dctw7DvTjeHqmMUYSCnbPtf8DTD/D
         W18MIDOfFB8G3ZrDM5IHkACHfFYLk+2DpD5sitIW0eVcvdv1I3/qzEno3fbnIy4sXBKA
         DiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XO+dDzVXtvu6vrmWqh59X/IvoZfOr95EfYx7Z0jp+Uo=;
        fh=50Gy6Kpkuc8WtJLtnBzpVWx3xscacG6nKShuohmD1Gg=;
        b=i6M4BjWPOi156KOYsFooGLiTgTYJz5ypYVralOG5xqpJTY166tTywYjiy40ZBHeVrL
         1ysuNjXGx0M4Sc2/ej1/UBdeIM7QUqRvQQ9hOeFWzZiKwcbl3QtwllPzz+3NecMV1yLv
         A8ZJoPGofOgnqTrKwArGNhylrCSfXZ9/qRhjiIWrIyNIpD0s1jtvdWxMjbrstAw1v1oK
         CfHGqVDRg29nCvNoSSr7e6Z/DWqdLRwIEjK9DVF7nkfQY3PypxHWsQwSZuDsYZLp0IWJ
         A+e4piFszog03uvXYiQgrzRvRJJ7Fhol3rNAcXEaxRzQ6N3VACoNvGZ+kVfMsshJP4J4
         /QGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779476239; x=1780081039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO+dDzVXtvu6vrmWqh59X/IvoZfOr95EfYx7Z0jp+Uo=;
        b=H8Kls30jVAr2evcdTOhs6zs5/C5qW87tlzKfqfb5AZSH77YVHynGm1igHGlXjomiEX
         7UOXTEDsG1GS79L5k4w96RMP74wG7Uh5HSfi4nid5XNuM81I73qcvKNsmANtBZ5NKMHt
         mNR9+BCrlTtA3ZM42ht4Yk/zwJWPzHAoDj0CbZp7lndgpgcGFM5I7z+c6Qe6OwcLVzlY
         G05GGPD9hKRNxTGpC4sP1b3zX6Oo9HrAJgOF5WhIuZBhb0oM90TUTjD2g/7+ZuSWNb5L
         QjAMNaqieYC7oI5i6vlXkv6F7BFAbwrDp83RahqBLNSWQWsobX9YeEy+WMkWcsV3rUVh
         dLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476239; x=1780081039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XO+dDzVXtvu6vrmWqh59X/IvoZfOr95EfYx7Z0jp+Uo=;
        b=QgwsGDw00tx4XiZEWUXaBHALkcyoUTYdszsqebH3+Rx7qbYmVokc88U4wekiFM4+sP
         MTMABHxIvVyjALceAp9HwRaQ9WM6iQHZ8EwjsG+A9KWgPtl+yRgm7inxLBE7bqTwHMG/
         HVa0js74Nb3C+ysujt0WW9ojoP3GId4F1sQSbr9sVhTW+idmoP0UPBVt+eK4Rcni9QkA
         uDLVOVMQARjmlGyO0684vkyiift13bEfBw0+QA2c+VVhRKeVgoe7nFmdWBzlWKpZNZI7
         mN3nR2GrdefFg5C8yqWOdS0noq4/oq+jXZY0o2V2Fw4tmLRFc7lLxr6V01nAm1s7R44e
         D/Lg==
X-Forwarded-Encrypted: i=1; AFNElJ9Zac42MnjhZQ4U9s0ECSmJ8BYfUB6RvT6wekQr12np3AUQUsnn5UuwUnDPCY1aOj6pIbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yza1ioQ1cXBucCAxrMWoC+yL1tnfNy/7aIT0c8LsnnmJsvW3
	FNlmf7hGlRJ0+MG3s6tCFQP3QZn8YG/uuCmEgQAbjTvvyco5o+0Q0TZAKhy0Ol8LJQBujULhvQr
	O4Ypc8bwQi4CHuNiDyr3LypwTsk3udFw=
X-Gm-Gg: Acq92OFF7TczK+RTYTLDue1CMFqN33/4+TIefuI/OILTqNHEQgdaR5BAc7r9YaAllh0
	n3niK6evyOy/e6B8oHO1VMTDW9l983eT8q49obVqz5I82zhuUKLj0u19YJVM1gyJ3yO7jcwnTyI
	2GwsZHsAJPinFb8UefC43kYiv0JnsV2lrSUyml+sUMDWhNjg3Yj+qbqvtobdLZi2Up8tcqIbrT/
	VeOovjLyNVKviaKwSZurvFRpPEjZsqrE324iC99isrDeUfBo0ffReFZTRIMb3palk052Hp6/yS4
	Nz1Nj7ClaldBjlI9j2air/A=
X-Received: by 2002:a17:90b:33c1:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-36a677303ccmr4500182a91.11.1779476239508; Fri, 22 May 2026
 11:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-9-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:57:04 -0700
X-Gm-Features: AVHnY4K6VCnW74mH-qu0lu-YDdA-o94r4C-kRqw70HIPj74Zva_JJdNwjmZtqSY
Message-ID: <CAEf4BzZn0NvNwuPdh10z+MAdw-9K6CgZ0XnAL0J4XRpQHhFv2w@mail.gmail.com>
Subject: Re: [PATCHv3 08/12] selftests/bpf: Change uprobe syscall tests to use nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:45=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Optimized uprobes are now on top of 10-bytes nop instructions,
> reflect that in existing tests.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/benchs/bench_trigger.c      |  2 +-
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 28 ++++++++++---------
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 25 ++++++++++-------
>  tools/testing/selftests/bpf/usdt_2.c          |  2 +-
>  4 files changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 2f22ec61667b..a60b8173cdc4 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
>  #ifdef __x86_64__
>  __nocf_check __weak void uprobe_target_nop5(void)

heh, nop5 -> nop_a_lot ;)


>  {
> -       asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
> +       asm volatile (".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x=
00, 0x00, 0x00");
>  }
>

[...]

> @@ -420,7 +421,8 @@ static void *check_attach(struct uprobe_syscall_execu=
ted *skel, trigger_t trigge
>         ASSERT_EQ(skel->bss->executed, executed, "executed");
>
>         /* .. and check the trampoline is as expected. */
> -       call =3D (struct __arch_relative_insn *) addr;
> +       ASSERT_OK(memcmp(addr, lea_rsp, 5), "lea_rsp");
> +       call =3D (struct __arch_relative_insn *)(addr + 5);
>         tramp =3D (void *) (call + 1) + call->raddr;
>         ASSERT_EQ(call->op, 0xe8, "call");
>         ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> @@ -432,7 +434,7 @@ static void check_detach(void *addr, void *tramp)
>  {
>         /* [uprobes_trampoline] stays after detach */
>         ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -       ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +       ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");

yeah, not jump anymore?

>  }
>
>  static void check(struct uprobe_syscall_executed *skel, struct bpf_link =
*link,

[...]
