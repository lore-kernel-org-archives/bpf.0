Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795557905;
	b=r6Nbt4Fa1qsQ0pez6Ovl/8cw8G4rIYHmzYFyJt8TGlCEWa4Wafw8+bz5xJ5ycfcN3SK+
	 aFfgDS4l6WCZ3H2gFk39OJeN6Rl5rVSjiptTbQvYfI3UGeoAuvLDnVxDloUKlYQflTf5X
	 cU+Zv43WqV2o1b9NIszIufuzXNtgg59lK2rLQy9cNTAt5NQdr1oMzPOgl4MrosTgRvFk4
	 Acq3H9sLqPQbbAVVvGR0GspKiRdWK/SYmgpldK6sgIMYd/GlvmRnycs7ceslfFIkXS0kr
	 bwF7dpmnCX5+mAx2Wox1j9iQ2FktESZBXwMHnE3gibESXtnsbZ6tOarHO692pH3uhTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=X7EgV7M1nlTNeVW/LvjD4DDHSsWIZ29WUt41R4QNBZE=;
	b=DvD4eOMVCCNutsUUWrw0whObjLXV0Ar5og5R3G0Isat3ptB5ebH441mxnsylDVkl39VW
	 fsVt3ZNp06weutKS7hBSheL5aIc4pqNy5IX2DlFalLVWM6e4Wx5Ls/0K87k0RewwONmDM
	 y6gfG8rpIVgavpDOrWrdFv3y5TVO5m/xDeMoPircKiDn/+7xP/diGsScvhAeRWzFwGzya
	 K992+G59zxGJk0iURC+/hUWm+/FdKsgM5QfL8e4SNRgD2pGABYJMCcbLnzdK0q/4KmNPK
	 rR5BjqujW2XiQ4A8VKyD0o13gssUWgdP9jYXCI1R/rGJb0nyJ/t/wykogB9BYKxm3QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElIVNTJ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3460606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3460606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElIVNTJ3
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b467581b98so49371195e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795557903; cv=none;
        d=google.com; s=arc-20260327;
        b=MCugkK8GuS1JaOa12bPtS3b8hBHCF383Agyq9l46tioceaPk3+GoHNqqn8eQBVwPsQ
         bRIFgf6z9gyCCAkMt7Tfmt0nb4ThBEBIIhIuZKzogFo86O2sbkIqr7fH8rouOoCY3y/5
         c0CNjPtR0+iqAl8vW+cfPhA1bE9ukr/JFnSMZEGbSpGIgYMVexrX8u5vPYWB9S2ySHQQ
         kp07z/NV7yn0SStXSGwX14IzNEkO9tpRPUtxdDv7sneXDvXf/8PfWb+5zXiAIWBPSBGQ
         pQLdXG4E5A+JU+gsuoKfbhUDud+OhiJu+wpTAaJ/41qVzr86/VAwrPTj08J/jnkTk0DW
         rsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7EgV7M1nlTNeVW/LvjD4DDHSsWIZ29WUt41R4QNBZE=;
        fh=C/H3bAOx4aabjmIvRoe9KdK9lJiX3hoVuXUAM452FYc=;
        b=WeJJTZaI12cP7q3110xMZ9AELelI0EV+9c4VDqf/kW2BhJHeEaFNlHP82ib5hXpucq
         9s25FoB5+qvib+au9/9s5+/vh1iW2Gbb0hqnMvSU/cQHC//nt/toELOX7erBNAG2iOKj
         hVtlJiZjACfkTkt/2EpkRAssycNki/s9TLxI4J3NNo5pIlMJFAqi4ArS19y1x0ErBQtc
         bEEDepma+RcawIXBmqtk2ln0sWhQRbef6NKRKR9PLRmTEyRBANGwZeXaV2o4RjR80ULD
         fLOfz+OcOd7zAcINeqUsDGl7InQM9L6PcljxYkBZ8oewIDQvhF+1nR0b51XhiKG8joua
         Z6Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795557903; x=1796162703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X7EgV7M1nlTNeVW/LvjD4DDHSsWIZ29WUt41R4QNBZE=;
        b=ElIVNTJ3Z0lJHLzxGGNRGUDG3fMREP3weOXpxP7riSQbYRymGdX8MF4U0ZyTwsJ78X
         voW4RsziPy/qG5ChssYqqdUvUIFjMuTt2/mbRQCKF2pkvn6ccVZqvJmJPEPkxqy7LznS
         wVPawdroBX3v5Vyg+VxN7H63rX5JTYo7PAFyBYfq7J0CPQeU4R4wgmDrsLFjdbbUGipL
         ORuvjyxKulExAZxWywOfRgkehc5Lnm4sJc16WpGnw71G68xAIORr20LKlAL4P2RciqxI
         Frnd0lnV8ayLYyuzQlKDbclqv5BWyvrwkCV8AaQbYmSM2k7ILQzqR4k5pguT93ZQONTd
         dYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557903; x=1796162703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7EgV7M1nlTNeVW/LvjD4DDHSsWIZ29WUt41R4QNBZE=;
        b=AljwzRwgkPBsHKEaL53GKdVmjJNyBm5rpcZHS4u1f3DO7tOL65S9vjDp/4pE2QROuC
         6PtFXy/DSk58BfglOYQElNpYfLBh8lOliNc9GJqg2MLr61pBMkwopfQtAiIlCke5WLiu
         Fm8b1GptITAfhgpUep4IicM6jBG7i2kXPcxOl3/PWc+XX+cFCNdJ1PmiNUhgpu5A8Zly
         9TlnWyGRUlmGK+tRQdtywBFltuNLPv+VfjYrtX9b8tRkS3/R1j8YF0m2fZeczPN9C5tx
         F3ig/Ei1Y5UCS/39bw8W9vgyjdth7fqYKsIReauwJRTctiKMP2zdL2JPZr5VDKtdUi0e
         fM4g==
X-Gm-Message-State: APuU4Z9wdJixHztZMfvNFc3kN1cE7uviCSFjyA/0kaHGxNGd2UCgxOVO
	yYGiRwvgdjfX+pPcUCmsfS7UccdKPCT0CGORHEAtWgU6NokWkxw1klPBIRgmlz85HaK9mHzZQmF
	1WnG6dgHje4HG9o+6rHu2n8H3ErTmiLQ=
X-Gm-Gg: AZFdTZc1WsCe5Iu91T8e4M8WjbtOXVBxLUAj2oI1jaMpCWAGCPHSl7H1kaq4DWnGRhH
	DaGPt86H43ZenYCKEJtow0rC7KrzBgeEi6ZWCUL4BGpqdANUAohQECzZVmEZi0VCGEtvAdRYp5F
	QeZhqAN3/5fYQz2tpGuh7S4lb8hM8u3eqMUl6SLKgnJsI8dlBunNirL7lMvQ4/TyWQ5rvzHWeaT
	PLm0c7J9s83zLWmIZY9Y5zeNkX+6lDGlpUTAqN6f13jXZ4yFDD7Lf6Q5lthSyYl/vdn1L1aSKCE
	THT1wON2NR2xY29GMTiMh3LIwWhOU7X0a2XN+e00hSaOup1abyFp2aq6edH7GY4EVLKBNHduNEg
	FDHtcrCksJSFvoqoh8a2xDBODbxMkBF4bcb25qZ9AwHsV89RJSZB3ZHEJ6Ah0fRTLPWKBJ8n2ab
	/j/dFGLVl9DfOFGag3qg==
X-Received: by 2002:a05:600c:4ec9:b0:4bb:6a5a:782d with SMTP id
 5b1f17b1804b1-4bb88925fcdmr332120265e9.17.1795557902961; Tue, 24 Nov 2026
 14:05:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 14:04:50 -0800
X-Gm-Features: Aa3M54rWyEOiWn9N3xPgi9IskIYemCYvuFKzmc7MjXfVq_1zxdSl20HVcikpyTo
Message-ID: <CAEf4Bzb6sq6g7jq715fqAAaL=PNSvuVWn6u3o+76w52gsT+bJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Check program recursion per task via bpf_ctx
To: mikeba@sentinelone.com
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 3:29=E2=80=AFAM Mike Bazov via B4 Relay
<devnull+mikeba.sentinelone.com@kernel.org> wrote:
>
> From: Mike Bazov <mikeba@sentinelone.com>
>
> Trampoline programs (fentry, fexit, fsession, fmod_ret and their
> sleepable variants), raw tracepoint programs (raw_tp, raw_tp.s, tp_btf)
> and tracepoint programs on syscall tracepoints run preemptibly, but
> their recursion check is a per-CPU, per-program counter. When a task is
> preempted inside a program, the counter stays raised, and every other
> task that enters the program on that CPU is dropped and counted as a
> recursion miss, although nothing recursed. A program can't avoid that:
> the counter is checked before its first insn.
>
> Since commit 7dadeaa6e851 ("sched: Further restrict the preemption
> modes") x86 and arm64 have only lazy and full preemption, so this
> happens in normal operation. A security agent that pairs fentry and
> fexit programs on inet_sendmsg() and inet_recvmsg() loses one half of a
> pair with every drop. With 200,000 HTTP requests and four CPU-bound
> tasks on a 4-CPU VM, 9,254 of 7,966,760 runs of these programs were
> dropped on bpf-next, and none of 7,975,426 with this series.
>
> Check recursion per task instead. The runners already link a
> stack-allocated bpf_run_ctx into current->bpf_ctx. Move saved_run_ctx
> into struct bpf_run_ctx, so every frame links to the outer one, and
> record in each frame the program it runs. A program is recursing if a
> frame in the current task's chain already runs it. Interrupts and NMIs
> run on top of the interrupted task's chain, so recursion through them
> is still caught.
>
> bpf_prog_enter_run_ctx() and bpf_prog_exit_run_ctx() do the check for
> all runners. The syscall tracepoint runner linked one frame around its
> program array and now links one per program. bpf_set_run_ctx() accepts
> a NULL ctx, which io_uring passes to hide the BPF context; the frames
> below are not walked while it is hidden.
>
> Programs marked by the previous patch keep the per-CPU counter and
> behave exactly as before, so no counted drop is traded for corrupted
> per-CPU data or a renewed may_goto budget. An extension (freplace) runs
> under the check of its target, so a marked one can't be attached to a
> target that is checked per task.
>
> Trade-offs:
>
> - An unmarked program that keeps per-CPU slots of its own, see the
>   previous patch, can have two runs use one slot, and nothing counts
>   that.
> - Marked programs lose runs to preemption as before.
> - bench trig-rawtp is about 2% slower: 42.6 and 42.1 M/s on bpf-next,
>   41.3 and 41.5 M/s with the series. trig-fentry and trig-fexit are
>   not slower.
> - Attaching a marked extension to an unmarked raw_tp, tp_btf or
>   tracepoint program now fails with -EINVAL.
>
> Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
> ---
>  include/linux/bpf.h          | 95 ++++++++++++++++++++++++++++++++++++++=
------
>  include/linux/bpf_verifier.h | 19 +++++++++
>  kernel/bpf/syscall.c         | 10 +++++
>  kernel/bpf/trampoline.c      | 26 +++++-------
>  kernel/trace/bpf_trace.c     | 11 ++---
>  net/bpf/test_run.c           |  9 +----
>  net/ipv4/bpf_tcp_ops.c       |  6 +--
>  7 files changed, 129 insertions(+), 47 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7873f0ef2817..97cbcd4b0d67 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2783,7 +2783,16 @@ int bpf_prog_array_copy(struct bpf_prog_array *old=
_array,
>                         struct bpf_prog_array **new_array);
>  struct bpf_prog *bpf_prog_dummy(void);
>
> -struct bpf_run_ctx {};
> +/*
> + * A frame in the chain of the programs that a task is running, from
> + * current->bpf_ctx to the outermost one.
> + */
> +struct bpf_run_ctx {
> +       /* The next outer frame, NULL in the outermost one */
> +       struct bpf_run_ctx *saved_run_ctx;
> +       /* Set while a program whose recursion is checked per task runs i=
n the frame */
> +       const struct bpf_prog *prog;
> +};
>
>  struct bpf_cg_run_ctx {
>         struct bpf_run_ctx run_ctx;
> @@ -2801,7 +2810,6 @@ struct bpf_tramp_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         u64 bpf_cookie;
>         int retval;
> -       struct bpf_run_ctx *saved_run_ctx;
>  };
>
>  static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *ne=
w_ctx)
> @@ -2809,8 +2817,17 @@ static inline struct bpf_run_ctx *bpf_set_run_ctx(=
struct bpf_run_ctx *new_ctx)
>         struct bpf_run_ctx *old_ctx =3D NULL;
>
>  #ifdef CONFIG_BPF_SYSCALL
> -       old_ctx =3D current->bpf_ctx;
> -       current->bpf_ctx =3D new_ctx;
> +       old_ctx =3D READ_ONCE(current->bpf_ctx);
> +       if (new_ctx) {
> +               new_ctx->saved_run_ctx =3D old_ctx;
> +               new_ctx->prog =3D NULL;
> +       }

[...]

>  /* BPF program asks to bypass CAP_NET_BIND_SERVICE in bind. */
> @@ -3492,7 +3565,6 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_=
array *array,
>  {
>         const struct bpf_prog_array_item *item;
>         struct bpf_prog *prog;
> -       struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
>         u32 ret =3D 1;
>
> @@ -3503,7 +3575,6 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_=
array *array,
>
>         run_ctx.is_uprobe =3D false;
>
> -       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         item =3D &array->items[0];
>         while ((prog =3D READ_ONCE(item->prog))) {
>                 /* Skip dummy_bpf_prog placeholder (len =3D=3D 0) */
> @@ -3512,15 +3583,14 @@ bpf_prog_run_array_sleepable(const struct bpf_pro=
g_array *array,
>                         continue;
>                 }
>
> -               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +               run_ctx.bpf_cookie =3D item->bpf_cookie;
> +               if (unlikely(!bpf_prog_enter_run_ctx(prog, &run_ctx.run_c=
tx))) {

it feels like bpf_prog_enter_run_ctx() is doing too much and the logic
becomes convoluted... we had old_run_ctx above after setting current
run_ctx, why can't we pass that *old* run_ctx and our prog pointer
into bpf_prog_enter_run_ctx() to check that our prog is not already
running (and do that recursion context accounting). And before that
you already optimistically set run_ctx.bpf_cookie, you can just as
much set program pointer.

So in short, bpf_set_run_ctx() sets up chain of run_ctx, and then in
the inner loop we set up bpf_cookie + current prog (sort of
speculatively), and then bpf_prog_enter_run_cxt() checks if we can run
prog or not.

Am I missing some complications that would prevent that separation of conce=
rns?

>                         bpf_prog_inc_misses_counter(prog);
> -                       bpf_prog_put_recursion_context(prog);
> +                       bpf_prog_exit_run_ctx(prog, &run_ctx.run_ctx);
>                         item++;
>                         continue;
>                 }
>
> -               run_ctx.bpf_cookie =3D item->bpf_cookie;
> -
>                 if (!prog->sleepable) {
>                         guard(rcu)();
>                         ret &=3D run_prog(prog, ctx);
> @@ -3528,10 +3598,9 @@ bpf_prog_run_array_sleepable(const struct bpf_prog=
_array *array,
>                         ret &=3D run_prog(prog, ctx);
>                 }
>
> -               bpf_prog_put_recursion_context(prog);
> +               bpf_prog_exit_run_ctx(prog, &run_ctx.run_ctx);
>                 item++;
>         }
> -       bpf_reset_run_ctx(old_run_ctx);

same here, what's wrong with doing reset just once, all we really need
is to update bpf_cookie and prog pointer inside that while() loop over
bpf_prog_array items, right? the chaining itself doesn't really change
and shouldn't be done for each item separately.

>         migrate_enable();
>         return ret;

[...]
