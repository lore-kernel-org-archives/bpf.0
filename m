Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272B4A8400
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380314; cv=pass; b=Whi9/8kxnj4RcjNhRBgktAi80k6bhSCX/wnJmXATXbgA/LnMmnlR9Wa3rRzCXJcfeABTc4lBBzCx/LyRh7o+LQppfoWthujV+veW5Z9tyUlP7NW1r5RmQjxAPAAlUJZGB9p/hF16cgdWQVwnYtFdlUxx4qqXm2e9tfksw4ka27Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380314; c=relaxed/simple;
	bh=0feb9Dsj8W6x0kYnLmhlhBLWrY73duMTtzikgZf7n9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el4xfAsxPB1mdtLIpuqYuQR0RZLq5MGJtZ6FovKrt63YXafltiqrt9qk8buCYL5n8fa0AD2ourShGhZ3xAs0fLG5CGhtatQqQLak7U7AFThDFVnl7RwIlyy7wJ4k1r20sYRxgLo/0vh9mQyq+NpRtjfsmOn+XUkKn8aNyLYQYo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJDh/ZoE; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJDh/ZoE"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17358so5308e87.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 13:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788380310; cv=none;
        d=google.com; s=arc-20260327;
        b=K98xNN0vsrDBNjg8StZxh8m7NRTrxOMhzJgiKBdCQMQFB18iGD3mQM9yd+tNrN2QWI
         Y5hRSjhzEq1k13ODRQ4kZQqXYQmmofncBPw2QgDaSZyg9ztCLnU1TGjtW/GMhRUJYkwP
         gL/zqIBhcfQ/cQgiQkpBmYe1DkmGy+3LoVDh6EPvVtsbf1Pd+8fMYaWg+WVJ2F2lXcJM
         GdiV12VkurKbGTEEtPmph2IeSG4B86gh5pb8SP/9S1B4hWPwcuCuObZmc1flVixl5UI6
         ye5Te3JE8AxboHAy3J2X143IVaMMfCgZ2hiXmEkPKxSI993deDea/c8BKZ+TqtH10f1H
         UphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l53CBDDh2wnE52trRtAKLjMN0pwgiYm7hrP3fTYJ0zE=;
        fh=5S7Bsa6Q3YVzhqaQHId9Kxqr5+T2lTsz/n9zNorf0tI=;
        b=E5xXM6BfWLUOW4keU/9TItA9D218QNipdOuXYZryzLUh2knQAOAtNlNm7IKWOHPn8N
         qsHv0DwMAed4Y8SVP7ffXpVmWX8SGDhnvB6wpCMzUdbXkBstDJ7e/+VtTUAhtWhSJUWn
         M6G8APuQYb8Ug0/waQE64W+0x9wnHmsmnFtvshXr8EjF64uklupsCl3MO7E0SxFmq9no
         rJCcYs5hPGDFVE6p6ZQCKQmWOZAyMoxbhAv3bD3QXR0v6OMXWgEDSNZOuLjI+jwrN7q5
         LN4yW13jTKb05x3KubteEKhVb/u/9hplcn6UVeuum9Wz9xzRaJVPhAEgkXk6X0WeX5zN
         hVjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788380310; x=1788985110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l53CBDDh2wnE52trRtAKLjMN0pwgiYm7hrP3fTYJ0zE=;
        b=TJDh/ZoEuAbT/+KUJ15cjWGNvnghgQtSJKG3jTYON3b2PjKgNqu/GGPus+hyS1x9cS
         ob7BbO/iJiF0SaiWIvY39UFByxCbhoRyqRco2Oy5JbVCt3TmT6fClAsG8e29X3R80SVw
         r87PGvBYNS3/0M0hUpEyLXW6uWrTOlPfSPjo5uhE0Lv+atuGS/Sto25Mlp5IQbNiOHap
         /6nCM6NHXaGLqPeoRbRgEHPzZEW/K1XlIrPsXhUYR9K4TGNww79NjwdAyql7hHcKEDmq
         ebrp4KoJqWykQiqcyIyuA3QMfgaPGkGvlWmPdmZzgjjZuMT+MuD0xr2hjpv1FQaqrfvc
         CLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380310; x=1788985110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l53CBDDh2wnE52trRtAKLjMN0pwgiYm7hrP3fTYJ0zE=;
        b=IVu4O5I5nr433PcaDDpEwfKHgImK/3ysnF2ptol1H1GGw8U961w/8v42dwW77dp06w
         JG4H7lsIIIeU7js49KElaR7cbkQ568P3PE4r5if6oiR+jbaQDPD/vCfsbuxJ3oVuYKgb
         TQVXa/07rP2mZ0GERPP718Qf8wkfcOIQ+WtFqG/W+0FPcI9OXt3FfuXEMNvV9OAUCkZD
         1j4sO7KQTDko57yQGoaqtLUGbuCKCsHplkaPxU6VpB55rJ+pfIb0iDgybrfjMDfEWHv0
         ZNPf3013mKCee/INkaddA5Df7oqgyosPzc+UDVATZctyIWKC6dDqN2fjWWirO/B6IeX4
         HABg==
X-Gm-Message-State: AFuF++mHopECBzVue6CSgibHkDpHdhIe8+EY2L+9Vzoy2tJjuJP9mHVp
	bRn3BR8pqQcZQNNM/bhbLKNz5DwPxBxUTsIeHXNZvrzX8TpcVbQVLcrU2PQQAhND9s7fqTAo5Ad
	Za5K+4afEX9ZJcllVZD4RE65NDwVjLEYMc6VezI/C/3sMItzXXPZBGAmqFGk=
X-Gm-Gg: AYBFou2bnZaWGm8aX6xG7skZ7/ctJMcWHqvdy/WYbi83I1FzgEGv7CL21RaHwhMnS8b
	5Y08CLEl+s/eaF+sNHsDQTFtjji5ZVeqvNl4ci7FmPRmNcCPdXzFwZETdw2uSk8Zxj00bFH9uxC
	SXSlxOcLlUVL55xLOW9+r9K+UQ3y1UN2J4vlyiY5NdPwIhiZZ66DoI10rtAxhb6OQi97NFMzLA4
	QIaX6tXRYLpXFNnDSFPUanK4/mTPQfdfA/utJDoSgFnMR+cAYXrB0WK1ar3eEdWNyZtJJOzo7Gk
	JP+7BJLRissSO7XeiPVUFkZAI1eLfWTn5M/zcW/pvmA=
X-Received: by 2002:a05:6512:ba5:b0:5ae:b726:5f1f with SMTP id
 2adb3069b0e04-5b60ecb822bmr38155e87.8.1788380310097; Wed, 02 Sep 2026
 13:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA-VZPmzCKF5uhP0OG4mPwEs8WaL-xyjAYW=bE8z7Z_J4-h6cw@mail.gmail.com>
 <4f6c72f7-9d21-4240-849d-08e10b0b2055@linux.dev>
In-Reply-To: <4f6c72f7-9d21-4240-849d-08e10b0b2055@linux.dev>
From: YiFei Zhu <zhuyifei@google.com>
Date: Wed, 2 Sep 2026 13:18:18 -0700
X-Gm-Features: AcwNN1Vd03NJ1WxklW_s38Cd4VGGpzZvj4e2UXlKNM7JgIC_R1XxRpVypK09r6g
Message-ID: <CAA-VZPk311fJv1YQpk1bfFj_2soh7DLVWKmJDMhLcgFjfw5uUg@mail.gmail.com>
Subject: Re: LLVM regression in memcpy struct bpf_sock_ops->remote_ip6 to
 struct in6_addr
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, =?UTF-8?Q?=C3=96mer_Sinan_A=C4=9Facan?= <omeragacan@gmail.com>, 
	yonghong-song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:02=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 7/21/26 4:56 PM, YiFei Zhu wrote:
> > In one of our BPF progs, there is a pattern of copying IPv6 addresses
> > (which are four u32s) off of struct bpf_sock_ops into a stack variable
> > (a larger struct that contains struct in6_addr), then updating a map
> > with that stack variable. After a recent LLVM upgrade, that program no
> > longer loads.
> >
> > I wrote a reproducer:
> >
> >    #include <string.h>
> >    #include <linux/in6.h>
> >    #include <linux/bpf.h>
> >    #include <bpf/bpf_helpers.h>
> >
> >    struct in6_addr addr6;
> >
> >    SEC("sockops")
> >    int test(struct bpf_sock_ops *skops)
> >    {
> >            struct in6_addr stack_addr6;
> >
> >            memcpy(&stack_addr6, skops->remote_ip6, sizeof(skops->remote=
_ip6));
> >            addr6 =3D stack_addr6;
> >            return 0;
> >    }
> >
> > This will fail loading at latest LLVM main with error:
> >
> >    -- BEGIN PROG LOAD LOG --
> >    0: R1=3Dctx() R10=3Dfp0
> >    0: (7b) *(u64 *)(r10 -8) =3D r1         ; R1=3Dctx() R10=3Dfp0 fp-8=
=3Dctx()
> >    1: (79) r1 =3D *(u64 *)(r10 -8)         ; R1=3Dctx() R10=3Dfp0 fp-8=
=3Dctx()
> >    2: (79) r2 =3D *(u64 *)(r1 +40)
> >    invalid bpf_context access off=3D40 size=3D8
> >    processed 3 insns (limit 1000000) max_states_per_insn 0 total_states
> > 0 peak_states 0 mark_read 0
> >    -- END PROG LOAD LOG --
>
> Are you using -O0 compile flag? The above code is not optimal.
>
> I tried with llvm23/-O2, cpu v3, and get the following code:
>
>         0:       w2 =3D *(u32 *)(r1 + 0x2c)
>         1:       r3 =3D 0x0 ll
>                  0000000000000008:  R_BPF_64_64  addr6
>         3:       *(u32 *)(r3 + 0xc) =3D w2
>         4:       w2 =3D *(u32 *)(r1 + 0x28)
>         5:       *(u32 *)(r3 + 0x8) =3D w2
>         6:       w2 =3D *(u32 *)(r1 + 0x24)
>         7:       *(u32 *)(r3 + 0x4) =3D w2
>         8:       w1 =3D *(u32 *)(r1 + 0x20)
>         9:       *(u32 *)(r3 + 0x0) =3D w1
>        10:       w0 =3D 0x0
>        11:       exit
>

Oops, apologies, I somehow missed your reply.

For the basic reproducer that I used to bisect, I indeed did not add
an -O flag (so -O0 I assume -O0), but this repro works with -O2 (using
bpf_printk to avoid the copy from being optimized out):

  #include <string.h>
  #include <linux/in6.h>
  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  char _license[] SEC("license") =3D "GPL";

  SEC("sockops")
  int test(struct bpf_sock_ops *skops)
  {
          struct in6_addr stack_addr6;

          memcpy(&stack_addr6, skops->remote_ip6, sizeof(skops->remote_ip6)=
);
          bpf_printk("%px\n", &stack_addr6);
          return 0;
  }

build/bin/clang test.c -O2 -o - -target bpf -S (clang version
24.0.0git (4b5f5954ea4b918b4ef0ec689a26a67693ca7b06))

  test:                                   # @test
  # %bb.0:
          r2 =3D *(u64 *)(r1 + 40)
          *(u64 *)(r10 - 8) =3D r2
          r1 =3D *(u64 *)(r1 + 32)
          *(u64 *)(r10 - 16) =3D r1
          r3 =3D r10
          r3 +=3D -16
          r1 =3D test.____fmt ll
          w2 =3D 5
          call 6
          w0 =3D 0
          exit

clang test.c -O2 -o - -target bpf -S (Debian clang version 21.1.8 (3))

  test:                                   # @test
  # %bb.0:
          w2 =3D *(u32 *)(r1 + 40)
          w3 =3D *(u32 *)(r1 + 44)
          r3 <<=3D 32
          r3 |=3D r2
          *(u64 *)(r10 - 8) =3D r3
          w2 =3D *(u32 *)(r1 + 32)
          w1 =3D *(u32 *)(r1 + 36)
          r1 <<=3D 32
          r1 |=3D r2
          *(u64 *)(r10 - 16) =3D r1
          r3 =3D r10
          r3 +=3D -16
          r1 =3D test.____fmt ll
          w2 =3D 5
          call 6
          w0 =3D 0
          exit

This results in the same error message on load, occurring only with
clang version 24.0.0git, while Debian clang version 21.1.8 loads
completely fine.

The previous reproducer, which only works with -O0, performs the copy
twice. I believe -O2 failed to reproduce the issue because it avoids
the double copy, and only the first copy was failing,

YiFei Zhu

> >
> > It seems that the program is reading the address from the bpf_sock_ops
> > as two u64s instead of four u32s, and the verifier understandably does
> > not allow that due to the complexity of rewriting context accesses. I
> > bisected the regression to
> >
> >    commit 790f0623411d5d9d5c989f14e87f2fe86f52eaf3
> >    Author: =C3=96mer Sinan A=C4=9Facan <omeragacan@gmail.com>
> >    Date:   Tue Jun 9 16:03:26 2026
> >
> >        [SelectionDAG] Pass dest and src alignments separately to memcpy
> > and memmove lowering functions (#201119)
> >
> > Looking at its PR [1], it seems that commit caused another regression
> > for BPF selftests and that has been fixed, but this regression is
> > still reproducible on main with that fix applied.
> >
> > I'm not really familiar enough with LLVM internals to understand
> > exactly why it generates the code this way or how to fix the
> > regression.
> >
> > YiFei Zhu
> >
> > [1] https://github.com/llvm/llvm-project/pull/201119
> >
>
