Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4338136351
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962537; cv=none; b=RP6SR9daAQNEQ6+W2Zc5i3PV0sk6it1Citth/RAz0QSn9PBFf7P2lgCGAP43Zu6TSqnVRLBtUCufeLHzbkcFAUcI+UxIFpnMnfSuAxhtVkevuD0FYkVgOZBYDldLFlmkgRB3mZspwFECeNFOfWd1IauSjhJZrFiJolQEmmKFw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962537; c=relaxed/simple;
	bh=QYss90tlNU36AX2gXaVaytLGawVSLRElgsYDWxbH8lI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dBpA098DrdgxRqiRFNiW7U2FoGdAt5GVYi1LMRuuZCxczPR84a2ZIr2blE1PT+waspcD1thdSeIXFJq2vrQT3OLkR+pffQ59egzSCP8+WAQOOgL29cPbn+3m+Rbk5urDww9l6JLdOOB6gnq+KDxFlBerGFYzW/FInaUmG2H+3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBp2xlS9; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBp2xlS9"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so14216555e9.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789962534; x=1790567334; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1KYgZDmTeWYBCLjsf9i2xkGlcAMywzsXeJh/ZsALZqc=;
        b=eBp2xlS9DrcZWUZK5ocFuoqW4urZP4pwuhyWAfwEKgu70PZhXurw+AshpRG96QY1L0
         7VLP5Avr4ZP8RrpB2gWjOyQAj35kb+27JSJFx42momOEdtoXRVYvV/ohZPnvCo3ZSjMn
         OhvHJ4G+FLNuExHsS5OpEUeNyI0OjiyPYHjTjMvRSh7JjV05h/CV1Mh78awNpuAr4Vk1
         1EXxWd1lpF2vEaSfdp3Ez6IItYUA5gAAUcdro++f2Sd/oZ9TH2DhU6AYCAH7JXj/InD3
         cV/0VRAS89EcXDuKzOEQWGrIkFNbcZkPp6RTY57iQoTo2ki1Ep80A+gA04LnJmlR+lfA
         /u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789962534; x=1790567334;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KYgZDmTeWYBCLjsf9i2xkGlcAMywzsXeJh/ZsALZqc=;
        b=T4Z9tceXvf+rvmx+G4QZDjamUFpGFKbRaFbpn0gC9A4d9XE8y/z1bCCkjOrGnZ7Tjd
         3jQfzeXiSr0Mr/38e/xWLwJ8KKdKQl+VksAdXTkNs20K7J0liqYr5Q1bOihJWHxeEP3u
         7QtIlukfJuU7Z7JzE5C0jn5kEDbWKpet+XqGFC4Q3v2Mcet+3pHypPPBG8OMuNRi/4fS
         wMIZAEmbZSfjDuWA1CCeHKSZOi7FnR/12W8HzJivyiYSfE8NxCt82jlcdBoBWhWc01u7
         d69F/PYLSrSDLxwXyVxVjoX46RzzZSpKt0w6JP3R/cdfhFpdk0WS1ufbQwz/4p6wIwn0
         JpBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3p8D+W1WRMWdM/mShzs8S8GBslVaSi8dyftW7LulKeOU1nDGu/kx5ralOmn4S2JqLQbU=@vger.kernel.org
X-Gm-Message-State: AFuF++m45iBlQVflZNGoEAeFBy4EduJigfidns8I0eYdOl/TDqxF2WOg
	AUp9tZKYjL1C0xXq7fFewTVZuR4ze9UCXC+2IaURtV1DAhme2ksN692T
X-Gm-Gg: AYBFou0KnvDs5ETvnqF43wAOL2/suWjU1oiu9DnlaIMNb1i0Jfa63ki/RTlJir+wmgS
	oTq7RusIa9RXgjx1Va1UIePHZ3QTc+P+BsHPqlo1u7+bPpxzDahODE+RJbsQ7GaUDWK7MponfHS
	l18lUtwG73VSoH+9WC7EAzKGm4WtOW5k2hnDQiW5kjvRhq4arxdLmoF8NtzrIRWmIrGXaMrPR8q
	HL9wrgfie8rpoEVaU3zh1JMA/AUk+mAOlNo5z6xc5Hy4bkTP4CLHlgoHm9XijxqcoUb+H/8HjAO
	u7bQAoQrf5tKvg5r/QynAaMOA42J4xrvEudXkFY7i7Y0t3fw83zVRO5QcmKobFH1y5aD24NdeeN
	A+BYIcepzqiT3DpdxO//fOdcLbGk1I9JZneubW3feWAHl8suOXVAs47fvoO1jLS8cRcY/bJF7Mp
	FGtzsj1/njDiWTUyQyqyE/5bawY5lesVSVghP6TI68CJV8mdm964Ej7i6lj8aeFbD9x3Yr5csH8
	d0Z2JLFidHDLKBiffuEz70Q0ItBxn59P7hmhKnWrRrzHz7uaUQUv/zizIGWJp1+mfXtLzveS39F
	m9uqGjOqYEH3axIxEczG1WIKmdFbs3TSiSjj3g==
X-Received: by 2002:a05:600c:46c5:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49fc5743bb7mr125721885e9.24.1789962533860;
        Sun, 20 Sep 2026 20:48:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f8563sm222102405e9.6.2026.09.20.20.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 20:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 05:48:52 +0200
Message-Id: <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, "Puranjay Mohan" <puranjay@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <rlmenge@gmail.com>,
 <hargar@linux.microsoft.com>, <apais@microsoft.com>
Subject: Re: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
X-Mailer: aerc 0.21.0
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>

On Fri Sep 4, 2026 at 9:51 PM CEST, Siddharth Chintamaneni wrote:
> Jeremy reported a bug[1] while executing a BPF program containing
> timed_may_goto instructions with private stacks.
>
> timed_may_goto[2] is a runtime safety mechanism that allows BPF
> programs to execute longer loops[3]. The BPF verifier replaces each
> may_goto instruction with a loop counter initialized to 0xffff and a
> timestamp check[4] that terminates the loop after 250 ms.
>
> Private stacks[5] allow BPF programs to use per-CPU memory instead of
> consuming more of the native kernel stack when BPF programs are deeply
> nested.
>
> To make timed may_goto work, the BPF program reserves 16 bytes of stack
> space. The first 8 bytes store the loop counter and the next 8 bytes
> store the timestamp.
>
> After the loop counter is exhausted, arch_bpf_timed_may_goto() is
> called. On x86, it adds the counter's stack offset to RBP to obtain a
> pointer to the counter and timestamp[6]. This works when the BPF
> program uses the normal stack because RBP is also the BPF frame pointer.
>
> When a private stack is used, the x86 JIT uses R9 as the BPF frame pointe=
r.
> The verifier-generated loads and stores therefore access the counter and
> timestamp through R9. However, arch_bpf_timed_may_goto() still adds the
> offset to RBP and accesses an unrelated location in the native JIT stack
> frame. This is the mismatch Jeremy reported.
>
> Fix the mismatch by resolving the address in the generated BPF
> instructions:
>
>         BPF_REG_AX =3D BPF_REG_FP
>         BPF_REG_AX +=3D stack_offset
>
> The JIT can then select the correct BPF frame pointer before calling
> arch_bpf_timed_may_goto(). The function receives the resolved pointer
> instead of reconstructing it from RBP.
>
> The LoongArch timed may_goto implementation is currently queued through
> the loongarch-next tree[7], while its selftests were merged separately
> through the bpf-next tree[8]. This series is based on bpf-next and
> therefore does not include the LoongArch trampoline update.
>
> [1] https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.=
cyber.gouv.fr/
> [2] https://lore.kernel.org/all/20250304003239.2390751-1-memxor@gmail.com=
/
> [3] https://elixir.bootlin.com/linux/v7.2.2/source/tools/testing/selftest=
s/bpf/libarena/include/bpf_may_goto.h#L8
> [4] https://elixir.bootlin.com/linux/v7.2.2/source/kernel/bpf/core.c#L340=
7
> [5] https://lore.kernel.org/bpf/20260417034658.2625353-1-yonghong.song@li=
nux.dev/
> [6] https://elixir.bootlin.com/linux/v7.2.2/source/arch/x86/net/bpf_timed=
_may_goto.S#L18
> [7] https://lore.kernel.org/loongarch/20260804153938.16129-3-dongtai.guo@=
linux.dev/
> [8] https://lore.kernel.org/bpf/20260813070906.5164-1-yangtiezhu@loongson=
.cn/
>

I think we can keep this fix local to x86. Would be less churn in the end.

The problem is that x86 switches the BPF frame pointer from RBP to R9 for
private stacks, but the trampoline still uses RBP. arm64 and powerpc64 keep
using X25 and R31 respectively for both stack modes, so their trampolines
already use the right frame pointer.

Instead of changing the generic fixup, can we resolve the pointer in the x8=
6 JIT
when emitting the call to arch_bpf_timed_may_goto()? We already know whethe=
r
priv_frame_ptr is set there. R10 contains the offset passed through BPF_REG=
_AX,
so we can emit:

/* Private stack */
leaq (%r9, %r10), %r10

/* Normal stack */
leaq (%rbp, %r10), %r10

Then remove the LEA from the x86 trampoline, as patch 2 already does.

This gives bpf_check_timed_may_goto() the same address used by the generate=
d
loads and stores: the BPF frame pointer plus the counter=E2=80=99s stack of=
fset. For
normal stacks, we just move the existing calculation into the JIT. For priv=
ate
stacks, we use R9 instead of RBP, which fixes the mismatch.

The existing save/restore of R9 around the call should stay. We also leave =
RBP
alone, since it is still needed for the native frame chain and unwinding.

I haven=E2=80=99t tested this approach, so it still needs checking with bot=
h normal and
private stacks.

pw-bot: cr

> Siddharth Chintamaneni (7):
>   bpf: Fix timed may_goto stack pointer for private stacks
>   bpf, x86: Use resolved pointer for timed may_goto
>   bpf, arm64: Use resolved pointer for timed may_goto
>   bpf, powerpc64: Use resolved pointer for timed may_goto
>   bpf, riscv: Use resolved pointer for timed may_goto
>   bpf, s390: Use resolved pointer for timed may_goto
>   selftests/bpf: Test timed may_goto with private stacks
>
>  arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
>  arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
>  arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
>  arch/s390/net/bpf_jit_comp.c                  |  6 ++--
>  arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
>  arch/x86/net/bpf_timed_may_goto.S             |  6 ----
>  kernel/bpf/fixups.c                           | 19 ++++++------
>  .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
>  .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
>  .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
>  10 files changed, 75 insertions(+), 63 deletions(-)
>
>
> base-commit: d761934c9483ecde93fe99d8705282f716dfee50

