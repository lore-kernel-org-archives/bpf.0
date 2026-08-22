Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A333C1B4
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439956; cv=pass; b=X+BIjIhfqTUvtTivkxn6/E3qOYYP8Zy33YRWJVvy8CXRd4FvixklyF7/aposEuyWFML733OsL9bM8i5NcBubGrfU2uAEYs+3Ou8D79rMsDO3ZpXz+goDE87TCSNi6rPszn0o1ZPE8rfm/7/LsgSEsDpL63fjQN5AwkBPePPCT00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439956; c=relaxed/simple;
	bh=UqnduKFL2EbeAMHusd31PGewkBZnevh95wDwasLzMdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIWRlTpY2G16sT5m4u+hRjDCY+nTYx6AdJiCa/aXnmCgKLd5gNuqCbOZUAWRHD40LJJkZoHYaOPjZm08Hlf2tP3VhMvNlZX+ozA4sm5VmmhgGv6vCtOd63F/k6WelSRA3P7O28VXAZ7E5fJ6YpPU+Jkkco3IlWAsAVXxCGWVPBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=l3vpH/Yt; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="l3vpH/Yt"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39fa5e3a428so15690231fa.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 16:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787439952; cv=none;
        d=google.com; s=arc-20260327;
        b=KvafRI9jV2uNyWo4CssC+oErbgzyeWdgnj3Ry9MGKxASNFqHGhQ90GMCvSTIzu1+SR
         eN7yF7SMtQZF5Zq+iXEGjFRouJJicLeTWF4/DMs1XGXhatFpF43oWPwR5Gj2c3l/VvWq
         dIRZVlIWos0O/FEgIiefyQrhwaaN0zpCOvoOt9CAhGLOYv3S9fBkF8Kc64yp5YjRHzaM
         np2GVKubumTnYq9FQEBq2pWxDSC2HWg0YwbJh0h+r7U6qUY4SsmYEJETqD04ER87MOj7
         z7I/ypDE61wsic3fm73C5BYmu8DJLMhZe7FiSo54zVc9uIGRUx6h9Ys9G1lda9bgedQB
         FZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fy5rnWq1kDaaG2oX4KMDDzKQA8TMmgosJ6lz3AIHqbI=;
        fh=NUPtS3byKRwb7NhuJ1+L8IOxgkfwKy31q5CkF3rsGOE=;
        b=h92Fb3IcuauazXyzndw49eWO4n+Yteh2Gfwu7Z8qJtxjaEuGPMFfxm3ycaQcNiiU3f
         vTBOctW7y35Ztp+fXBwZoTnB5bQoN1TrdVpPRbtd2C2aYGKauRaejHKqgjFddUAo2nge
         SDrJwdvprrnzx39Nziolf/S1dX2dltjPtKC7I4VLZNLLrB81j71v+aZTdKgP/VTTYv2o
         9ytNvcz07cVW3V+I5Dniw50Np4JCCT4Fz27nClSNSiVOgRC+yfnBq2yZbj2r+ZE7XxL5
         y2cBvbe72Q3hALzTvFe4IW6sUbGKYNenAAKSbXuXO+VMPLloze9EyOQT6bjhkX3FEwwM
         PSyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787439952; x=1788044752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fy5rnWq1kDaaG2oX4KMDDzKQA8TMmgosJ6lz3AIHqbI=;
        b=l3vpH/YtlHBCXJLFJadodQE49/8elsxLCMPWwbtnvh9O984PTIscVFO8JMcD1WokDR
         dqfXFKKBffyQsemLK5Nsn/6B99yQQ0fIKVYA8poV7cph/PgU5bI3epFYXXV9xJf3udFm
         78ZNko/8IgKAqYjGKLWfDiidTHCRexP3zhtOh9Jj+hVKZo2wNvHQiDm9q9KYwlmVZ6Fq
         xDT2B42y2ZAZziDzAA5Zh2Y9l+TWG6fu/wg1GRnluNRShnyswqceo04ez6MN03x6u2mw
         cFNfkP5ovjP+Azl7d6681YLgBsz2EO6DuMUgXW+JJfYcaCvNRKLJ7Og4hi1PULzA1iBM
         VULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439952; x=1788044752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fy5rnWq1kDaaG2oX4KMDDzKQA8TMmgosJ6lz3AIHqbI=;
        b=FtMhql7GStfPoSohZaw82Jl3xcNFZ5aJG/0s/cpXXROjurkNDLHeWcj4N60RVQKq87
         OoepfwHVv9/+3R2egpHnaWWis+Oqk+E3c/8n9U3mORNzgBRkKPiBl8S9mLAsmv0CDprm
         ReBIEQqJpwoYAuHNbF1f4PpmJtEWVeIA9il0oWonPUpu7StURGhGzhAUlXiSJzoQrApB
         ARAvh0cdNWB3fHU6WpfDQs6guyiSm5MNfUfPNi86aS1iQsoeuB8siXVIVvZFl2NrEHtE
         t3ehKd+oPTDZIq2zggfNqhdMbvWJ8KzbD2aBOq9NXozbnFdd88Q2lLC26j9BptouZ/6O
         v5Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rq8R0LAYPAvH4HsIIgkvVvWWTjQwR1aKT/Lx5slb7P/fsgXa9QVFgKYDY0bFoQlefxoEmE=@vger.kernel.org
X-Gm-Message-State: AFuF++k+V1YOCCidMLdzW4XcJLD460f/zq635nBNe4lFPmzvCpMxOs1x
	xkG1EZsb/Jz1Z4Q6LJeG1cGjQtX2sPEo3PaPaWpZYCTzztbzGcWdGAC3UL4RunVpZdj0ZtU9VTi
	S0P3hsTR+hspcpP/C69b38k4fJF8la9eCHN0d7lV5mA==
X-Gm-Gg: AR+sD13vjcBqKev1iqdpe2kOnRuEAq7Z+Ul9s8X2Ltsbs9J+io7q7PWUQoS04VO8gQS
	VWqYXiWCQ8/t/6zjERppzkw5pEeiP1NsuNsigLBKGDx7k+HWLCvwbm2ciRNTcze0ndksvVeHrxY
	eYgl9zNFB5StYRn9b5qY6O+7cjasMdlq1XaDHNnF/INkDt4DF9LMDqs1ROgE/K4IBeIWiQgZhOy
	cE1WUdbxhsDBBImPrbEOGENbvBb0McA73ez5cag21O17j3Ik26I7nuIVxl5+qn2RfBvkAXqD2+u
	qATDQs5V9xx160lxH1Raslp7x+yEZUtccWeK3pp7jmVMv5yZV+RW8xeyGtF/Dd6lZ/4t7G0Qo0n
	ImqM=
X-Received: by 2002:a05:651c:1508:b0:3a1:749:3031 with SMTP id
 38308e7fff4ca-3a1b0a79fdbmr22421211fa.0.1787439951826; Sat, 22 Aug 2026
 16:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818203234.1142913-1-simon@swine.de> <CAEf4BzbkKwM-uwc1=o2p2v-bjuYNxM++La8Gr5edv5H6sGGqDA@mail.gmail.com>
 <aooIR-oRaN4iIQRy@krava>
In-Reply-To: <aooIR-oRaN4iIQRy@krava>
From: Christian Simon <simon@swine.de>
Date: Sun, 23 Aug 2026 00:05:40 +0100
X-Gm-Features: AcwNN1Vv-nf0VBmihVMfV-S3aCvE9tNB2MNJNhpZKzPLBL03QOqHYXXBhMbep4c
Message-ID: <CAE_y42AS2egu9athNHmqSYVP7wc8E4fhLg5T51tDTVx6QL3LMQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack corruption
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	yonghong.song@linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Aug 2026 at 21:36, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Aug 21, 2026 at 11:06:16AM -0700, Andrii Nakryiko wrote:
> > On Tue, Aug 18, 2026 at 1:33=E2=80=AFPM Christian Simon <simon@swine.de=
> wrote:
> > >
> > > Eligible BPF programs use one private stack per program and CPU. Both
> > > bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable=
()
> > > to keep an invocation on one CPU, but another task can still preempt =
it
> > > and run the same program on that CPU. The second invocation then reus=
es
> > > and can overwrite the first invocation's private stack.
> > >
> > > Protect each real program invocation with the existing per-program
> > > recursion context. When the program is already active on this CPU,
> > > account for the missed invocation and skip it. Return zero when skipp=
ing
> > > an uprobe-multi invocation so session handling does not suppress its
> > > return probe.
> > >
> > > Skip dummy_bpf_prog in the classic array path before acquiring the
> > > recursion context because its active pointer is NULL.
> > >
> > > Add a regression test that pins two threads to one CPU and overlaps
> > > classic and multi uprobe invocations while preserving a sentinel in a
> > > private stack frame. Without the guards, the second invocation execut=
es
> > > and corrupts the first invocation's sentinel.
> > >
> > > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > > Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrume=
ntation/issues/3056
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian Simon <simon@swine.de>
> > > ---
> > > Changes in v2:
> > > - Address review comments from sashiko-bot
> > >   - Guard the uprobe-multi path as well.
> > >   - Remove const from correct line
> > > - Add a regression selftest for uprobe-classic/multi paths.
> > > - Add the arm64 Fixes tag.
> > >
> > >  include/linux/bpf.h                           |  33 +++--
> > >  kernel/trace/bpf_trace.c                      |  11 +-
> > >  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++=
++
> > >  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
> > >  4 files changed, 206 insertions(+), 10 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_pri=
vate_stack.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_=
stack.c
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 7719f6528445..a94fc9898ece 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bp=
f_run_ctx *old_ctx)
> > >
> > >  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const vo=
id *ctx);
> > >
> > > +#ifdef CONFIG_BPF_SYSCALL
> > > +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> > > +#else
> > > +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog=
)
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  static __always_inline u32
> > >  bpf_prog_run_array(const struct bpf_prog_array *array,
> > >                    const void *ctx, bpf_prog_run_fn run_prog)
> > > @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog=
_array *array,
> > >                           const void *ctx, bpf_prog_run_fn run_prog)
> > >  {
> > >         const struct bpf_prog_array_item *item;
> > > -       const struct bpf_prog *prog;
> > > +       struct bpf_prog *prog;
> > >         struct bpf_run_ctx *old_run_ctx;
> > >         struct bpf_trace_run_ctx run_ctx;
> > >         u32 ret =3D 1;
> > > @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_pr=
og_array *array,
> > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > >         item =3D &array->items[0];
> > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > +               /* dummy_bpf_prog has no recursion state. */
> > > +               if (unlikely(!prog->len)) {
> > > +                       item++;
> > > +                       continue;
> > > +               }
> > > +
> > > +               if (unlikely(!bpf_prog_get_recursion_context(prog))) =
{
> > > +                       bpf_prog_inc_misses_counter(prog);
> > > +                       bpf_prog_put_recursion_context(prog);
> > > +                       item++;
> > > +                       continue;
> > > +               }
> > > +
> >
> > I think it's unacceptable to skip sleepable uprobe execution just
> > because there is the same BPF program attached to a *different* uprobe
> > (and all due to a private stack that no one asked for or needs for
> > uprobes, really).
> >
> > As a short-term fix, we should probably disable private stack for
> > sleepable uprobe/kprobe program (and tracepoint/raw_tracepoint), and
> > think how we can make private stack less per-CPU dependent.
>
> +1 for disabling private stack for uprobes
>
> thanks,
> jirka

Thanks for your guidance. I have just posted v3 of the patch set, which
disables private stacks for sleepable programs.

I am still unsure why non-sleepable uprobes would be unaffected. On a
preemptible kernel, their execution paths use migrate_disable() rather than
preempt_disable(), and rcu_read_lock() does not prevent preemption with
preemptible RCU. It therefore seems possible for a task to be scheduled out
while running a non-sleepable uprobe, after which another task could invoke=
 the
same program on the same CPU and reuse its per-CPU, per-program private sta=
ck.
Am I missing another mechanism that prevents this?

Cheers,
Christian

---
v3: https://lore.kernel.org/bpf/20260822225444.2774461-1-simon@swine.de/
