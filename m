Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09630ACF0
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335591; cv=pass; b=TUIQsvMhVGk5ATNvN/LUrFTZfzPHNe5k/lms7dPlPfFJXhcSijVSTvVMHeFkrdFeQ/8EYTQi6vyjRW9mz4RlLOfXua2z86im/p6c+DGTZlP4lmKcshAGuBAISBG1Bd57AFrfJ64kDmIBr5UztybRuBX6Pq/Wo4LZTM4YtdmfyDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335591; c=relaxed/simple;
	bh=0QpD0zc4Kzh1KBQEqAf3G1zL2MCdpSKYrVl2y57+a+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHAgT4SbizDhBMXBpS//mI0nqrkxEwRyEPRSjJ7KB1MMp8CnT7yB8ZS/0lzScKrPHs5Zzafd+MprSlGYEvUbyexP0E7t1q99LGVlpdqpHeOGKujUtbnEIqtcxWU9GGWyM0qtA6vBQhiLhX00880TcYxPSM9+ABt01EainfviCrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgHmUgXR; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgHmUgXR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso1253016b3a.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787335589; cv=none;
        d=google.com; s=arc-20260327;
        b=ooRcxVbD1vo9h74XrtgfqktHn4+aWa14kEr778SV6oZr62+wTSuo4G90F1lq+9jHRK
         aOKRs7nzYXikGUTEGrqCgZQ/0zVWbPDzkOxQiSAOU2gsZg4/p4SYfITEa8b2JoklnaF9
         7k4bi0eG+4P9K9Re9jq5nuZr4+iF32Cm7s40H8NcUz1kzJz1slFNe7M/0SP+dHQJ70BN
         Wm73EIti2vc8qMk7AYZkyS+QP44L1skS7bkPhr4RXPpvHGa246yOlkF3+xE2tvd6G2Z8
         fcm6cGaty2LVfhey7P/S8rIrU1mYb8YMBitEjyfFeE3vZ1cw7TMbBWVXoXxV9c9HDOh+
         T4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndGptA+U8ixdMFYlebt3e9Jv+6ZxFs7uFxmaMka3HTc=;
        fh=j1Z4o+eDBZBPVM4diOC+D1Y0z7e3h7kINPX40TPgiJc=;
        b=LtY6sHVfKO3xamU/oUVjKiuS2ZesLSijGrDVD+IWSi9Rro/7gVRdIdFb0m05O/WwH4
         SVSmLUSNm3Y7PuSO26e8msskJZUCvDvZZUM645ARQnVD8HKTB4rSm297SKlDr509yYhD
         QUDVOuqmd5m0NHXWxENdmwba1JvQmCWoULfB6g8kgzZNv5QvVw8mebLCHslRHlNAeQo9
         yGe8ZIQ7rBy1DurYZRgCtRZLf5Xs3swlTkiy1la5DTy0Au5XE6ap27RYDvtoy8qQfK16
         eoArPDqBoqRNbdNFIjQN4oCwfiBLj9nbgipOcgVQoRFoZA7bQ+c1mtHtmrBRiUMPWPQ/
         i2zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787335589; x=1787940389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndGptA+U8ixdMFYlebt3e9Jv+6ZxFs7uFxmaMka3HTc=;
        b=fgHmUgXRf/AE5OaLVdQrnMfQ/+gTmh2+J9njUXPBHUN3w+FpJkB8WjibHbhraTh4rD
         2J+H9NaZ5DD3gWjV62R7UohmwHXmQHl3C+8AZYJmOtthvlJ29PcQmrjiBoV8Uh6Ps5Yw
         paDFXdk9EvuhIcSU/6zuUeKfAPRnFwvuyqWmw+fM2EtIwRx0UxrwP4gus8CLQI1vL4LP
         2AnQWaJBexyzx8pMWIux3Mjad+t4f37nQmVYjbfarCeOxf5dLkIJinZTS4qx9x7NS1l9
         wOTB7AF6gYGelVu7G6ip+9Wa+z8c5Vw1sSDCqL+I4D8yYNLZBV/J0BmMv0S6oIh7AWcQ
         +X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787335589; x=1787940389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndGptA+U8ixdMFYlebt3e9Jv+6ZxFs7uFxmaMka3HTc=;
        b=aPmpxfcZgpj87Q4y/wbsl9IfZNFVlr/OazvdaYeV4GJNzXzgqFPQWvzalzGElLtw59
         OoCyiAuRvfVuqLrTBRerFa7NA3W2gF/snBddBjEWuxyzh1lTvpPVWHj2wTtYNPL6RN2B
         Jj5BvT5u90olIFVAX3zXlwyVas3+45r7e4aYpT8Gh8h1FzLzRKlC8ClqHXwqoS39x7FM
         5j8i0Qph8dQZE/Cx3iYjaUFZkVJ77PqnLshZ4UypLAltbz9S2uLdyMjR2U2LasAXpwaH
         T20eokqRQjrVTVbbbDAHVd5fBjeTmAOCf9tlc3jLlsMnnAyWgsGTXbe60Rm0PpeBpJz7
         bZFQ==
X-Gm-Message-State: AFuF++lGgXR9B2rdsA0OkF9S1nwebOP6DefH2eqCE/RVbeyh931qKoX7
	arO6rrVeVObI1YTq3BTCVwwYr5KTfkLh7dQP6QhrCWyMftNaGWRl3h7UfuMNjrFetosmdoeDK+o
	9vh+o5Glv4fpj20SnEXRMwyxABqZtazc=
X-Gm-Gg: AR+sD12XEZ4dpsovK77lfTTNct1alPNiH5Yn6lFlMCkpVqi+bIIzYSy5FG1Z1FFC4m4
	jI+oBibFTAv3nmXsM/DAwFCiVcEex3MeEdPQmp1g7p40kUq4ucONMVSa9OhYTHfGUeUmf40X7Cv
	WNREbN06h/VUno4ugRUncNK3jVArqyY7OO/NyA/za++ojPcx11BbdRR/AMO7Nb1Gmx2VXckmdos
	FJLn+iCfn6u40gQhuwp+DXyEM8YFGTEDCWSgucsH1vtEGzzx1L3mC0Bawn6g27Cyh2xo+0dXvQP
	RGU4o+1NvX86WtGnh+UlW4aBDuty/fjEgk8wmeMtRjQBk6MZlSy9sxdybcFdwwndDXbgaDo8jph
	Z3/VpDJsnioPV8/Om7gCnmlKy8A==
X-Received: by 2002:a05:6a21:4a97:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3cd4bb88d70mr1166395637.10.1787335589159; Fri, 21 Aug 2026
 11:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818203234.1142913-1-simon@swine.de>
In-Reply-To: <20260818203234.1142913-1-simon@swine.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:06:16 -0700
X-Gm-Features: AcwNN1V8Vw6WG2u89K6bmMldh8xUfZcS4VGabF7JBU7xZ3qdxRXaQGskJPX5pKg
Message-ID: <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack corruption
To: Christian Simon <simon@swine.de>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	yonghong.song@linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 1:33=E2=80=AFPM Christian Simon <simon@swine.de> wr=
ote:
>
> Eligible BPF programs use one private stack per program and CPU. Both
> bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable()
> to keep an invocation on one CPU, but another task can still preempt it
> and run the same program on that CPU. The second invocation then reuses
> and can overwrite the first invocation's private stack.
>
> Protect each real program invocation with the existing per-program
> recursion context. When the program is already active on this CPU,
> account for the missed invocation and skip it. Return zero when skipping
> an uprobe-multi invocation so session handling does not suppress its
> return probe.
>
> Skip dummy_bpf_prog in the classic array path before acquiring the
> recursion context because its active pointer is NULL.
>
> Add a regression test that pins two threads to one CPU and overlaps
> classic and multi uprobe invocations while preserving a sentinel in a
> private stack frame. Without the guards, the second invocation executes
> and corrupts the first invocation's sentinel.
>
> Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentat=
ion/issues/3056
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Simon <simon@swine.de>
> ---
> Changes in v2:
> - Address review comments from sashiko-bot
>   - Guard the uprobe-multi path as well.
>   - Remove const from correct line
> - Add a regression selftest for uprobe-classic/multi paths.
> - Add the arm64 Fixes tag.
>
>  include/linux/bpf.h                           |  33 +++--
>  kernel/trace/bpf_trace.c                      |  11 +-
>  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++++
>  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
>  4 files changed, 206 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_private=
_stack.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_stac=
k.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..a94fc9898ece 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bpf_ru=
n_ctx *old_ctx)
>
>  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *=
ctx);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> +#else
> +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> +{
> +}
> +#endif
> +
>  static __always_inline u32
>  bpf_prog_run_array(const struct bpf_prog_array *array,
>                    const void *ctx, bpf_prog_run_fn run_prog)
> @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_arr=
ay *array,
>                           const void *ctx, bpf_prog_run_fn run_prog)
>  {
>         const struct bpf_prog_array_item *item;
> -       const struct bpf_prog *prog;
> +       struct bpf_prog *prog;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
>         u32 ret =3D 1;
> @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_a=
rray *array,
>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         item =3D &array->items[0];
>         while ((prog =3D READ_ONCE(item->prog))) {
> +               /* dummy_bpf_prog has no recursion state. */
> +               if (unlikely(!prog->len)) {
> +                       item++;
> +                       continue;
> +               }
> +
> +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +                       bpf_prog_inc_misses_counter(prog);
> +                       bpf_prog_put_recursion_context(prog);
> +                       item++;
> +                       continue;
> +               }
> +

I think it's unacceptable to skip sleepable uprobe execution just
because there is the same BPF program attached to a *different* uprobe
(and all due to a private stack that no one asked for or needs for
uprobes, really).

As a short-term fix, we should probably disable private stack for
sleepable uprobe/kprobe program (and tracepoint/raw_tracepoint), and
think how we can make private stack less per-CPU dependent.

pw-bot: cr


>                 if (!prog->sleepable)
>                         rcu_read_lock();
>
>                 run_ctx.bpf_cookie =3D item->bpf_cookie;
>                 ret &=3D run_prog(prog, ctx);
> -               item++;
>
>                 if (!prog->sleepable)
>                         rcu_read_unlock();
> +
> +               bpf_prog_put_recursion_context(prog);
> +               item++;
>         }
>         bpf_reset_run_ctx(old_run_ctx);
>         migrate_enable();
> @@ -3208,8 +3231,6 @@ static inline bool has_current_bpf_ctx(void)
>         return !!current->bpf_ctx;
>  }
>
> -void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> -
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>                      enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);

[...]
