Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853293;
	b=2rq4fT4RQaQOTEWxSW7OE5cUuhELtGftnmezVqACyCB/x0OrJEhHzRLUXOLjNLzaB9ko
	 jpcQY3vUp2o/SyhpQUcep2FNtHIk8nLgRxFAOXQQ7LP0jlOuQpikym7A+kHZVq4cmdKXm
	 Y1SoBaWpKb//qm3HPczUtoCaaSEe1u5vv0omKWuyKWQREpGcUsMOK5pRfm4kicah5zjwj
	 VeyhPEOfJmI+y5PsroK/XoJHhYGO6FpH4fGetNxiSTCKeJ1ZDX3EMfXFVk498psfz7Gap
	 rESolGPqdflFZrIt0EV4fVvwNUaGDrtY8vrKghvNCmMcvJz9Sij8iPZi8kk3Ox/PaEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
	b=ukRwbavEuCEIXF4XNf2JuuVr7Ae1G4ice48UplaQ0qfz1CTSbAv+Lg9KDq3gP1NefPMB
	 1qtyzpCTxbMPr6ZNHBmD4tnJTtlN3XDm6GdPr/zBX+XN2R75xCcBE22HLq9FEeeCgEpVl
	 johLTaNbQsm5AgP6Tsysj6xZGn9JUqZ39/g4B8pYDBzWHdHx4bgwcoAfKGn5YVzJo4PtH
	 Dndzu9FDgRhXEo1HbeLdwEWDMzp1LTyVZ1d8cwWVxBiQRn+daw/u4g+EZ5IguabgFmUbv
	 6xwWiRqDR33g+vfWbod7iwh1DIn0scDEAabRbNuoi2iB190FK5IVaiUPewLiYdwOW4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zm/cbSev";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531A606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A531A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zm/cbSev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-492690dd5daso3656563f8f.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794853291; cv=none;
        d=google.com; s=arc-20260327;
        b=UTWGcvyvEfybnwm92RhiGbFIfyhd6Y2AwiSSR3dFozZPKinSnpHFzhtsZ3F3FzE36+
         kd8cxMQ0LIWnx5m3LR7rR47hPPmyev3o1HaR90nCf6kGVJjOleLTTEtYjHcIQxYR4f9d
         Y+RN3gljx/anRXH4KCKQTWEVhGlFKF16PnU5WxV8M1H1HtiQ2kv0z+PpIfC7qZCGwF9W
         UO9Tr+3sQYu00MHXyrcs0OZnkzImMGyXrlOBaw6ox6wDqLJ5JX+W+lcYfQcfbDnYlILM
         fe+luAjtaRTDUceAU3OIpoBl6dHsXpYBqQryNfxu2YP4V+iRfW+2FKiJp90euoIoD/M7
         9Mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
        fh=tg2ymKxuaj2Q21sAkJobOdFhEg2kvuB/fHoxD450F/Q=;
        b=O83b8lxayBddERKZa/4QLAuPGZ1dL+UpeGJN8QAjrkXaWPcBqFUC4bGGe6jMMnSX3J
         muOT4J1UnuolLcK85K4bhYhPiLLMlCgPz8LbzR+zctONBAUMIC/puX83dKRqGI8E3fq8
         7Sk2DZHytmqGGGxuZIBHXbKLJ4mKH2w84n7Sj9D0N6I1E8TPEtCL1V4B6pk/lFtGJfNJ
         8KT73EB/blrm7m70tdHEIq6E9DkXwZ0+FAbkFrCROpXN79Ye5ps4D//h1PpNmXTPZ7ze
         KaNtrMDdx5hRX0qhxmmg9SSL+bd45EgNbC9cXPtYKrEaT9MSSbSaY65/GovPtkjKAJM4
         EIGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853291; x=1795458091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
        b=zm/cbSevgb5vX1U4LBW+YkNSL8vMI4OWxN5YoiqU1WeBbLrEIkidzr4BETmU1pUE76
         ibA5HIiy6+4OwhPntqQbQdP2rXXUs/qTz296mY8FQLW/qWqFDzkfIII0HrqsVbUizGRW
         qKLh8HoK+iHj6ov2kVxLmzZbX0U3tUBUW4ewYnzwG8lYN41vYG+Pg+4ZSlEhcZ64gKNW
         mfuIA/YECNDIq3brvfaWU+UmNJem2HB6zClJf5fsoL+ofoB4zZTZW9IuiFZ001vvUaOb
         GTwXf1fR9c4JzAvZkdsjsFXHJkinyMKl1wWc9m4k/iPd8NKV04p+tt7H78cGlJjofFXV
         DM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853291; x=1795458091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
        b=KPzthZZ4Wg6kYxIIli5N7EyIST7BkwgbNEFQDSd5nH149Suky3nhkS4xXA3Ib3hapX
         GLI7kamyCoNaYmp6wJq4ho7EvUNhw4nEZTbMl8V8y2XOau8VG2ah/QP09AjAyAr+qtmA
         +XAJv07V/hYBnX1QDTnW/2phIs2f5gUdBdV7CPipMXC5gpvuoqxZPup6g4XEbWTKGnBD
         3aCJfWkYi3dr5NBTyrJu8Bi73QUs88TSBIPVV9mDLQkng72Ssz8Eh0DmUe9wDfT8LAYd
         rIfX+s+eNpBWgLXiOfVpX1iQs4P7SUALueUL1v6cQP+Y1M+J4xaVMri07OADE8iThZJd
         qc5g==
X-Forwarded-Encrypted: i=1; AL+hErGPBwmV1mFnNsDfHtCOcoCfZoHzkTFudqXvoTDXPg7YHavLnliwH/w8lQ4FHnR8T3/Qa7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0auYdb6RqgIbHW1EbQSmGMbZu3WpH3a6YQ6TR6MFt483t1zpI
	oxBlZ7pFFe88bV3vXvcz40crX7fiPR3jvJeP+0equI5o2WVzp4grSLnr90448YPGYeBwHaSRC9q
	cqc1UjsdWk13N9p1C+z8WSH+g/jMajjE=
X-Gm-Gg: AZFdTZfIQIRScAnYA4XEHcHNwJZ7E1MtZMOzae4TTfvMfExGxd3V4uEB4KgKOFVLkpY
	xaN0DVYrJv7H2eHO49aRhdkhKEQkI+2Q1v/Ba+dBsIyS3IgOPAVQw2g0krSnLGxW7LRfgljIiqZ
	b8LCS3uvUId7ckXS96QhD90MET14bNACXYXaBilRyjGH+IbeJESwZ3ESopPagYQwlykSmiGvfHk
	xkLuZ9fD8muNq5D8bYOBcJxNT7zxAN6QVaatIOtdTVxRza1Xej3zu5hn7iwxRdvjN1lWmQC+oTg
	yU3P9PAntT34fdIZ2wMEZS1fJBz7nKSey3P7SVIPOe0GqNqVnlS8Ugix5ddKmt2qlIcmrvCQJK0
	is4F/CNZzvaP4hJ9Yj/+K4YLMS+UxkYCrVNLXnuJsEUv5+E9dBU/ryiTvblT9MIfe5uNDtzeHdE
	Wi4Sp1P3U8yRaQrX4l4KAUkf8OUXuPxgYjuYZtFZFV
X-Received: by 2002:a05:6000:2997:10b0:48d:f99d:a0d2 with SMTP id
 ffacd0b85a97d-49c6fe87982mr17681937f8f.15.1794853290904; Mon, 16 Nov 2026
 10:21:30 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
In-Reply-To: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 10:21:19 -0800
X-Gm-Features: Aa3M54q2mews4rY30WpsGtsZElX86aOjciD3oE3m5xdhDPqaKHj29XjFeRC-ScQ
Message-ID: <CAEf4Bza3BpgTEpqONMcm6FdH2Qc2Tmv-5feVWJfe9wf55iZxpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Disable preemption while a raw tracepoint
 regs slot is in use
To: mike.bazov@gmail.com
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:18=E2=80=AFAM Mike Bazov via B4 Relay
<devnull+mike.bazov.gmail.com@kernel.org> wrote:
>
> From: Mike Bazov <mike.bazov@gmail.com>
>
> bpf_perf_event_output(), bpf_get_stackid() and bpf_get_stack() of raw
> tracepoint and tracing programs have no pt_regs, so they fill in one of
> three per-CPU slots, picked by a per-CPU nest counter:
>
>   get_bpf_raw_tp_regs()   level++, use regs[level - 1]
>   put_bpf_raw_tp_regs()   level--
>
> That only works if the users of a CPU leave in the reverse order they
> came, as a task, an interrupt and an NMI do. These programs run with
> migration disabled but preemption enabled, so tasks can leave in any
> order:
>
>   task A              task B              task C
>   get: regs[0]
>   <preempted>
>                       get: regs[1]
>                       <preempted>
>   put: level 1
>                                           get: regs[1]
>                                           fills in its regs
>                       uses regs[1]
>
> B sends a sample or a stack trace with the registers of C. Profilers and
> tracers then attribute it to the wrong task, and nothing reports an
> error. The per-CPU recursion counter of a program doesn't prevent it:
> the slots are shared by all programs, so it takes two of them.
>
> Disable preemption from get to put, as the two other users of this
> scheme do since commit f2c67a3e60d1 ("bpf: Disable preemption in
> bpf_perf_event_output") and commit d62cc390c2e9 ("bpf: Disable
> preemption in bpf_event_output"). Nothing in between sleeps: the
> sleepable bpf_get_stack() of these programs doesn't use the slots.
>
> The cost is small: the helpers already disable preemption around most
> of their work, the unwind in bpf_get_stack() and bpf_get_stackid() and
> all of bpf_perf_event_output(); this adds the few instructions around
> it.
>
> Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
> ---
> A reproducer, x86-64: two raw tracepoint programs on sys_enter call
> bpf_perf_event_output() once each, with the program's number as data.
> Two threads make syscalls on CPU 0, and a SCHED_FIFO thread preempts
> them every 20us. The IP of a sample is regs->ip of the slot, the return
> address of the helper call. The reproducer reads that address for both
> programs from their JIT images and checks every sample.
>
> Without this patch, 7 to 18 samples per program and 10s run have the IP
> of the other program, out of 1.4M. With it, none. bpf_get_stack() and
> bpf_get_stackid() in the same setup return an empty kernel stack
> instead: the unwinder looks for the other task's sp on the current
> stack and doesn't find it.
>
> 5 runs of 10s, debug config, CONFIG_PREEMPT=3Dy, preempt=3Dfull, on
> bpf-next 0fb18ce8a2e9:
>
>                                      without     with
>   bpf_perf_event_output, wrong IP    7-18        0      per program
>   bpf_get_stack, empty stacks        362-535     0
>   bpf_get_stackid, empty stacks      168-364     0
>
> The bpf_get_stackid() case with bpftrace, whose kstack calls it; @a[]
> and @b[] count the empty stacks:
>
> bpftrace -e '
>   rawtracepoint:sys_enter /comm =3D=3D "dd"/ { @a[kstack(1)] =3D count();=
 }
>   rawtracepoint:sys_enter /comm =3D=3D "dd"/ { @b[kstack(1)] =3D count();=
 }' &
>   taskset -c 0 dd if=3D/dev/zero of=3D/dev/null bs=3D1 &
>   taskset -c 0 dd if=3D/dev/zero of=3D/dev/null bs=3D1 &
>   taskset -c 0 chrt -f 1 perl -e 'select(undef, undef, undef, 2e-5) while=
 1' &
> ---
>  kernel/trace/bpf_trace.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>

this looks fine per se, but I'm just questioning why do we need all
those shenanigans with per-cpu stack of pt_regs and why we don't just
have local bpf_raw_tp_regs where we need them? seems like pt_regs are
around 200-300 bytes, that doesn't seem ridiculous to have them on the
stack

anyone would object if we just has a simple and straightforward local
variable and get rid of per-cpu hacks?


  | Arch        | pt_regs         | BPF ctx               |
  |-------------|-----------------|-----------------------|
  | x86_64      | 168             | pt_regs               |
  | i386        | 68              | pt_regs               |
  | arm64       | 336/320         | user_pt_regs, 272     |
  | arm         | 72              | pt_regs               |
  | riscv64     | 288             | user_regs_struct, 256 |
  | riscv32     | 144             | user_regs_struct, 128 |
  | powerpc64   | 384             | user_pt_regs, 352     |
  | powerpc32   | 176/192/224/240 | user_pt_regs, 176     |
  | s390x       | 200             | user_pt_regs, 152     |
  | loongarch64 | 320             | user_pt_regs, 360     |
  | mips64      | 304/400         | pt_regs               |
  | mips32      | 184             | pt_regs               |
  | sparc64     | 160             | pt_regs               |
  | sparc32     | 80              | pt_regs               |



> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b4ff9d4e8..eb3daf2bf 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1639,11 +1639,17 @@ static DEFINE_PER_CPU(struct bpf_raw_tp_regs, bpf=
_raw_tp_regs);
>  static DEFINE_PER_CPU(int, bpf_raw_tp_nest_level);
>  static struct pt_regs *get_bpf_raw_tp_regs(void)
>  {
> -       struct bpf_raw_tp_regs *tp_regs =3D this_cpu_ptr(&bpf_raw_tp_regs=
);
> -       int nest_level =3D this_cpu_inc_return(bpf_raw_tp_nest_level);
> +       struct bpf_raw_tp_regs *tp_regs;
> +       int nest_level;
> +
> +       /* The slots nest: a task must not be preempted while it holds on=
e */
> +       preempt_disable();
> +       tp_regs =3D this_cpu_ptr(&bpf_raw_tp_regs);
> +       nest_level =3D this_cpu_inc_return(bpf_raw_tp_nest_level);
>
>         if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
>                 this_cpu_dec(bpf_raw_tp_nest_level);
> +               preempt_enable();
>                 return ERR_PTR(-EBUSY);
>         }
>
> @@ -1653,6 +1659,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
>  static void put_bpf_raw_tp_regs(void)
>  {
>         this_cpu_dec(bpf_raw_tp_nest_level);
> +       preempt_enable();
>  }
>
>  BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args =
*, args,
>
> ---
> base-commit: 8835113107b2cf75df33a71e265cdeec5d5d13e0
> change-id: 20261116-bpf-raw-tp-regs-preempt-1f7019989ab9
>
> Best regards,
> --
> Mike Bazov <mike.bazov@gmail.com>
>
>
