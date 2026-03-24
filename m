Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DE37A494
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357692; cv=pass; b=RPVZsPr0FWeFMLtEH+ZmbHmRKvL6blH2ztSCqyr9ZfkzJEIUFLTC19uftD2dEiyaC2GG5h01XSLgNfvgutb6qu26FwRlLS8PEIMEt6e1cz8c4ngFkCUIcagPgk+3RsNMzxE6HB1c4h5X1ElIMRCjNrcdXTmWmDDOac5DPw1gEhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357692; c=relaxed/simple;
	bh=0prnBxae6usShy4iTyK1IjfDqu9hgcalWUhqdmUJyL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl3CSstH6Or1qRt7X79YpjBtI7dP59m/TjaEEVYb5hqRlaiktCuFdBECFCLQJKA8XnE7zrCCDJL8KeTKKPdDMxqUTKhJla0cF+aSHmcv2oIvx4a58Hd/iqtGckVmM32i/0h2eyHj3YIQF0Dd58/WyVmwcO4+jO2GFOlc56djSqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB/apMBx; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB/apMBx"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso7491003a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 06:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357689; cv=none;
        d=google.com; s=arc-20240605;
        b=XFBSRVqaCS0qcCWIQxEaJn0DM69btO+GIoKNNScSK/XsBhe6zIve+wS2ZfcY2tRwez
         2UFppj4kIKPtZEYC4q+vWHbHWmW/bkqpbQyuOa8Mj47HmdTFWpEMyINTpdthuY6cDF6Q
         Wi/k1mK+5Y5YbPAqs5sLZK7K9RVNXnQ/bMADWQpcWkYIphcpsPqq2p1aJPOuetbC4zwm
         SXXi3lgtzKoXak/zBn+4qDjFBIrD65unZWSOufzoVBzJHFgOwCVs0hmWUfpVeMjAQLpp
         aCwE00D1wYiHMvUtZSKEyaAG0UUMFKgM0FXWHfYEGGwTsWzP1SwKao0NJZdTxgwE2qu6
         NC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m3CxLwJFAGMg3jZRKUfOz7NrDJgZ2F9BUWuGCcsmwL8=;
        fh=ocSOvAMKBRIJInEcQuIOTGDmVahYtqK5Dh6s2X05kv4=;
        b=TN1VNcg0hldP77zMZXnGZJgfOQ/QGPPswvTZ/iqzcAunRGbxT6SYxM3Q+NwqaA5cOL
         dsQ5W/UnBSPSCNUdiCXEIxDeWR449vgKJ/zTnxDNg8wy3fjvBXiHh425KANjMUIoGeqa
         A7FvHztwjtKiMyHQRhSc/CRaWzUY+xT/YSI9TAhAPml+Owyg9i8ywJ48/nuQ+8BveSSU
         kEu5o7YOolZBwOapPGE6adpgVqw5QtQv8Dsx47S1Z9fwn9Uze2jFoTfraD4rBs8rhiKq
         +GSmr7PG4Bnx/6nsMr3FEpApb0DK1IQJTIUCowBwABJ9Rr7PuxeG6Ot1YpIGFVvEXeWL
         5pbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774357689; x=1774962489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3CxLwJFAGMg3jZRKUfOz7NrDJgZ2F9BUWuGCcsmwL8=;
        b=YB/apMBxTXELBXu6FtiEcB35UWYd7677Mbb+IoonFUqgHiwk8KDgO4tZEdWbFf6V8U
         cw+txcu6qvhvQCJ8N9173L3Hy4CBpkTl/sqiKcocSkiOC7Hcn7XrERCgqm7S/r94LISJ
         fcDwE/LZlzLAMyQIoAELKu+zExZHKdNMlnMdF2FxL+V6mQSF3L2jlZjzN1/EIKPA79pI
         5I/faRAGdOZsu9fttpMzvo+yjRHy0QDQldtu/9jt3FnfKklluhSlOgX7nhCMRCu83o/e
         00gWAJRtNnmluK6Bg/8euqltoJHpkSGcM06ynR3jTt7NgJYJIRDm/2rIktqUuUMptNvr
         Ph1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357689; x=1774962489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3CxLwJFAGMg3jZRKUfOz7NrDJgZ2F9BUWuGCcsmwL8=;
        b=XlI0hKmsrTA7Ba2XY4TQ9HEh+3/yV4G6ydOEtgweDv0esP7q1vdkpn2WcD/jNixbpm
         7R754x6h5zWAC8YWOjFjUr0CO20TfxM5+ntXz2FKHVHCsgfrfpbiMZrUaw/oMjvAznpR
         TTU/d858y78C+++e8YRM+dITUVGAMVr0/U/IBs1jElza8e5/QECU4JMR+hv2GdNdRXab
         6mOqTOAh4s+0IRTUz//Szz5pTZdNxPVdrKjho60pUGaeB5OHg8RxwXDTQ5AIVFNaAJnH
         ofogszn0nVj6lJtfTWpYNrJjLHma9bmZnbLwydkoyRyfKiwZcKaSHmucYcW7+g43+hsQ
         7fFA==
X-Gm-Message-State: AOJu0Yz1uoCPlHI6JyNPY5+kWX3FZZU7fTkCRyZqJyx7cfsMwzpUQbVz
	HiLEZnf2DYEKDKr2OYeH+KU84l7fITN55Bhs7zGXO7Y5VYKe5rQuNee6qcOgIknstQIECk/NV5n
	NxFvyVS615C8fSflP3YtbqJrgofHLIPc=
X-Gm-Gg: ATEYQzwQ3/BAWZp9jff99iofrdUdZSQwcqnBT55ZcLb8cvjhS0SFRsZ4Mciw572GmJV
	SpLW4JEMJdH8+xf35lmk39YPLxEzTCFQpvibX0DVkr6YFqBUl2399m7lQ0y4zsfwLC9DW6HOknz
	wP61vbUfwPwUwRGratSfbMr6pneaYUTZeiKA4UBLgjMsRVP4e+zWY8XaF8irbnklEmyMuf91czt
	gM7+LwFVPQBw6oTfUQtkqtoAwI8b9/ffo8AwX1yvfDALa4sLWFqCy+shiCPojQhxiI8DWMF2bda
	EzESxywbl+GCZuz+x15mGsMRHukLk0OFoQ==
X-Received: by 2002:a05:6402:3786:b0:667:df35:873d with SMTP id
 4fb4d7f45d1cf-668c9115101mr10876451a12.2.1774357689006; Tue, 24 Mar 2026
 06:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318172259.2882792-1-puranjay@kernel.org> <DH8T9WRPSRPY.264HCXDHAQT23@etsalapatis.com>
In-Reply-To: <DH8T9WRPSRPY.264HCXDHAQT23@etsalapatis.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 24 Mar 2026 13:07:57 +0000
X-Gm-Features: AQROBzAF6NPs2IF-y3k5XVQ20-mFqlwPNqAHOjDsqOpsEnfJyaLej4ix48HU7xQ
Message-ID: <CANk7y0jZOKJ=AzyJn-+MLSHH3kDKt-LZd-HndJQ7Qyj08CFYGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: Enable aarch64 ISA extensions for
 JIT disassembly
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, kernel-team@meta.com, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:25=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Wed Mar 18, 2026 at 1:22 PM EDT, Puranjay Mohan wrote:
> > The LLVM disassembler needs ISA extension features enabled to correctly
> > decode instructions from those extensions. On aarch64, without these
> > features, instructions like LSE atomics (e.g. ldaddal) are silently
> > decoded as incorrect instructions and disassembly is truncated.
> >
> > Use LLVMCreateDisasmCPUFeatures() with "+all" features for aarch64
> > targets so that the disassembler can handle any instruction the kernel
> > JIT might emit.
> >
> > Before:
> >
> > int bench_trigger_uprobe(void * ctx):
> > bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> > ; int cpu =3D bpf_get_smp_processor_id();
> >    0:   mov     x9, x30
> >    4:   nop
> >    8:   stp     x29, x30, [sp, #-16]!
> >    c:   mov     x29, sp
> >   10:   stp     xzr, x26, [sp, #-16]!
> >   14:   mov     x26, sp
> >   18:   mrs     x10, SP_EL0
> >   1c:   ldr     w7, [x10, #16]
> > ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >   20:   and     w7, w7, #0xff
> > ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >   24:   lsl     x7, x7, #7
> >   28:   mov     x0, #-281474976710656
> >   2c:   movk    x0, #32768, lsl #32
> >   30:   movk    x0, #35407, lsl #16
> >   34:   add     x0, x0, x7
> >   38:   mov     x1, #1
> > ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >   3c:   mov     x1, #1
> >
> > After:
> >
> > int bench_trigger_uprobe(void * ctx):
> > bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> > ; int cpu =3D bpf_get_smp_processor_id();
> >    0:   mov     x9, x30
> >    4:   nop
> >    8:   stp     x29, x30, [sp, #-16]!
> >    c:   mov     x29, sp
> >   10:   stp     xzr, x26, [sp, #-16]!
> >   14:   mov     x26, sp
> >   18:   mrs     x10, SP_EL0
> >   1c:   ldr     w7, [x10, #16]
> > ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >   20:   and     w7, w7, #0xff
> > ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >   24:   lsl     x7, x7, #7
> >   28:   mov     x0, #-281474976710656
> >   2c:   movk    x0, #32768, lsl #32
> >   30:   movk    x0, #35407, lsl #16
> >   34:   add     x0, x0, x7
> >   38:   mov     x1, #1
> > ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> >   3c:   ldaddal x1, x1, [x0]
> > ; return 0;
> >   40:   mov     w7, #0
> >   44:   ldp     xzr, x26, [sp], #16
> >   48:   ldp     x29, x30, [sp], #16
> >   4c:   mov     x0, x7
> >   50:   ret
> >   54:   nop
> >   58:   ldr     x10, #8
> >   5c:   br      x10
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Acked-by: Leon Hwang <leon.hwang@linux.dev>
> > Acked-by: Quentin Monnet <qmo@kernel.org>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> > ---
> > Changelog:
> > v3: https://lore.kernel.org/all/20260311222608.521549-1-puranjay@kernel=
.org/
> > Changes in v4:
> > - Add acked by Quentin
> > - Rebased on bpf-next/master
> > v2: https://lore.kernel.org/all/20260310223456.1706712-1-puranjay@kerne=
l.org/
> > Chnages in v3:
> > - Fix bug in usage of strncmp() (AI)
> > v1: https://lore.kernel.org/all/20260306163906.2870529-1-puranjay@kerne=
l.org/
> > Changes in v2:
> > - Fix coding style issue (Quentin)
> > - Use strncmp() in place of strstr() for detecting aarch64 in triple. (=
Quentin)
> > ---
> >  tools/bpf/bpftool/jit_disasm.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_dis=
asm.c
> > index 8895b4e1f690..04541155e9cc 100644
> > --- a/tools/bpf/bpftool/jit_disasm.c
> > +++ b/tools/bpf/bpftool/jit_disasm.c
> > @@ -93,7 +93,16 @@ init_context(disasm_ctx_t *ctx, const char *arch,
> >               p_err("Failed to retrieve triple");
> >               return -1;
> >       }
> > -     *ctx =3D LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_ca=
llback);
> > +
> > +     /*
> > +      * Enable all aarch64 ISA extensions so the disassembler can hand=
le any
> > +      * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics)=
.
> > +      */
> > +     if (!strncmp(triple, "aarch64", 7))
> > +             *ctx =3D LLVMCreateDisasmCPUFeatures(triple, "", "+all", =
NULL, 0, NULL,
> > +                                                symbol_lookup_callback=
);
> > +     else
> > +             *ctx =3D LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_l=
ookup_callback);
>
> Question: Are there advantages to special casing aarch64? Shouldn't this
> be a no-op for other architectures where it seems the JIT doesn't emit an=
y
> feature-dependent instructions?

Thanks for the review.

the "+all" is specific to the arm64 target and if I don't special case
it, it will be ignored and that is fine but it prints this to the
stdout:

'+all' is not a recognized feature for this target (ignoring feature)

this will be printed for every target except arm64, which is not
something we want.

Thanks,
Puranjay
