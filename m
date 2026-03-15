Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E551ACEDE
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773561892; cv=none; b=rortHm5HyrGD8+18d12MrhZ7XF/QZ1l2nOYEPgZmRAsjkbNuaJYMewotNDzhcZbhbbNKeJ+B3OXeXT4A5UUJgt6r1XGw2OhjXKY9U0EA5qQTTWgufCJ+JIHT4hWgYKt4oYzr2IiaAnEB5kL/j8zxGjajb1O5ngHD7Dv+WQMVoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773561892; c=relaxed/simple;
	bh=89J2fzFv0E5+/z3QYbLMtJmkhyPIAqbhG+j6lVXYT1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5cJMurL3KSXuvHLhquqOQjDwtHlFpr6t9AcH6JWgEKdPmIJReCmTOkIkBelyD3yYWGxg7vvBjDBwGDJNIC291GT0tKRliOGCpJDeqAt65O5McIr8r4lnn5WA2y+pn2nXxg4Kx60qOgG9KD52hkClxZffhKaFsuXhdOwvQ+rUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFCK7BdB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFCK7BdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8669EC19424
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773561892;
	bh=89J2fzFv0E5+/z3QYbLMtJmkhyPIAqbhG+j6lVXYT1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FFCK7BdBXAUwNe4zflpqYhLRUDn6v/p8zCvRH+/GK4c96YjpB2KyD2lJrm4yaMCfW
	 PrspjMcWKFsbvzA64cae4quq+v/2Wp38yxOIzJZmdLU/9iJa+fNQeVgR+LYtGX58PG
	 PvCI0JyNR/45eN5ptWAAKafn2OguqgycKEKiorv6p4Ui/MR9Nv94Oq8m2Oyfx06Qp8
	 FVgzDRl4CiehfZvtB0Mr/FxOLBzTQWSrwSTji7dUATCj3D3oMv41q97SV/SdPknEsG
	 Hct+7nASrBLuAyuTPPZGr6n36HewpS8BRdtpSM+3V6Ijkj7XtiY5jn3QFVnrG2ErH0
	 OpJoYbPZ0FcpQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so5088110a12.1
        for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 01:04:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgcbKtFFSNOe91APkBQ38oE6hdwu5yIiYuslJKQ2UxjpSAh8mKs86WjFSzuCLTfV58+AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqXMfxrYhLyCJ/vAmFI5QtPEakNYTMVaxdFmdjR2tMiAs2pee
	6J55UjuLKgjGHLYDerXQYDHzlDoIbnwinyPsXSFy0nFhDszJVjgGjc2mEYja9W+0LEAPhEOy11Q
	P1UMVgTb/GvfMuiMHBSXyyH7mYyv+AZ8=
X-Received: by 2002:a17:907:d649:b0:b96:e11e:979b with SMTP id
 a640c23a62f3a-b97651d2146mr528888066b.29.1773561890950; Sun, 15 Mar 2026
 01:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310064706.4985-1-yangtiezhu@loongson.cn> <CAEyhmHQiz510vQMu-WRZ==Q71mW70UEDvyedqe8giXF=0hXSHw@mail.gmail.com>
In-Reply-To: <CAEyhmHQiz510vQMu-WRZ==Q71mW70UEDvyedqe8giXF=0hXSHw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 15 Mar 2026 16:04:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6mSE8Pea=txB=MGYOckwTLN-S57WZ1eHU-uFUsAos1Ng@mail.gmail.com>
X-Gm-Features: AaiRm50FUFf3--D9r03HUBtKuPQN2dSLERKCFQlCDBbBoRgdewGDrPt3Oy91LfU
Message-ID: <CAAhV-H6mSE8Pea=txB=MGYOckwTLN-S57WZ1eHU-uFUsAos1Ng@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: BPF: Make arch_protect_bpf_trampoline()
 return 0
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sun, Mar 15, 2026 at 11:27=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> On Tue, Mar 10, 2026 at 2:47=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > Occasionally, there exists "text_copy_cb: operation failed" when execut=
ing
> > bpf selftests, the reason is copy_to_kernel_nofault() failed and the ec=
ode
> > of estat register is 0x4 (PME: Page Modification Exception) due to the =
pte
> > is not writeable, the root cause is that there is another place to set =
pte
> > readonly which is in the generic weak arch_protect_bpf_trampoline().
> >
> > There are two ways to fix this race condition issue, the direct way is =
to
> > modify the generic weak arch_protect_bpf_trampoline() to add a mutex lo=
ck
> > for set_memory_rox(), but the other simple and proper way is to just ma=
ke
> > arch_protect_bpf_trampoline() return 0 in the arch-specific code becaus=
e
> > LoongArch already uses BPF prog pack allocator for trampoline.
> >
> > Here are the trimmed kernel log messages:
> >
> >   copy_to_kernel_nofault: memory access failed, ecode is 0x4
> >   copy_to_kernel_nofault: caller is text_copy_cb+0x50/0xa0
> >   text_copy_cb: operation failed
> >   ------------[ cut here ]------------
> >   bpf_prog_pack bug: missing bpf_arch_text_invalidate?
> >   WARNING: kernel/bpf/core.c:1008 at bpf_prog_pack_free+0x200/0x228
> >   ...
> >   Call Trace:
> >   [<9000000000248914>] show_stack+0x64/0x188
> >   [<9000000000241308>] dump_stack_lvl+0x6c/0x9c
> >   [<90000000002705bc>] __warn+0x9c/0x200
> >   [<9000000001c428c0>] __report_bug+0xa8/0x1c0
> >   [<9000000001c42b5c>] report_bug+0x64/0x120
> >   [<9000000001c7dcd0>] do_bp+0x270/0x3c0
> >   [<9000000000246f40>] handle_bp+0x120/0x1c0
> >   [<900000000047b030>] bpf_prog_pack_free+0x200/0x228
> >   [<900000000047b2ec>] bpf_jit_binary_pack_free+0x24/0x60
> >   [<900000000026989c>] bpf_jit_free+0x54/0xb0
> >   [<900000000029e10c>] process_one_work+0x184/0x610
> >   [<900000000029ef8c>] worker_thread+0x24c/0x388
> >   [<90000000002a902c>] kthread+0x13c/0x170
> >   [<9000000001c7dfe8>] ret_from_kernel_thread+0x28/0x1c0
> >   [<9000000000246624>] ret_from_kernel_thread_asm+0xc/0x88
> >
> >   ---[ end trace 0000000000000000 ]---
> >
> > Here is a simple shell script to reproduce:
> >
> >   #!/bin/bash
> >
> >   for ((i=3D1; i<=3D1000; i++))
> >   do
> >     echo "under testing $i ..."
> >     dmesg -c > /dev/null
> >     ./test_progs -t fentry_attach_stress > /dev/null
> >     dmesg -t | grep "text_copy_cb: operation failed"
> >     if [ $? -eq 0 ]; then
> >       break
> >     fi
> >   done
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
>
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> >  arch/loongarch/net/bpf_jit.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 3bd89f55960d..4f1af3b7a363 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1568,6 +1568,11 @@ void arch_free_bpf_trampoline(void *image, unsig=
ned int size)
> >         bpf_prog_pack_free(image, size);
> >  }
> >
> > +int arch_protect_bpf_trampoline(void *image, unsigned int size)
> > +{
> > +       return 0;
> > +}
> > +
> >  /*
> >   * Sign-extend the register if necessary
> >   */
> > --
> > 2.42.0
> >
