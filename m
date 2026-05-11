Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843C3D649D
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517501; cv=pass; b=N4l2vm0ufUEYCdnObEwmyrA8Zv3s/BcfApkPXc05NhZ5SI2gX7U62SK7HFA6BiuzfzKWvZTibpKmYivd7rIxSIgvodzhIRxz7q5dj742TtNBkAfuYMcpgymDREiKi9zayX0BJ/zQTROVgE06yxI6C8rqYysnBrzjH4JsGJqwFqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517501; c=relaxed/simple;
	bh=Qkun2XB8543Jt6EiX1m2Cuzld5FktqIVy1nShMEqOyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKpqCRFFkSUN7RdQJ2qfo1zM9vK7yoXTbVNZteahs0NHaThU9CzWBm8pkZ8w7j0MkTaaDVXwY6ffjUbgizNrdRmD2m0SRKnR1NImr1MOScDA2JqxfXfaEjykwBpmARc8QOpjsXUpb5nOR0HllqamAGjtNmFSd+bhHmB+E7a0wso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAXCX1e5; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAXCX1e5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1774481a12.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517500; cv=none;
        d=google.com; s=arc-20240605;
        b=GLQxJWnKJS6CBjRMNf+bfGxEp2FwK6g2gvpuS/B5mZbvY9hAjpf2by5FoXEY4ToJNH
         0hQQZvJImaOR52ZVk1ZuyLBBzEGS5roM9ewm+KpnFbax+2dB+nKFZi2CN7OqkSWknlao
         EloCbkGzro+QWjgGre/IrTL8LsQ6xmUfte6g0K0w8ADUrwx4bc8OKchsyNCGLouMkqoF
         nzV1qYGEItwf6NRC1vXicWV/VH16VgjOK9J2niKI4AY+BwYDs1UvD+JBfjlICrCRAuQx
         JOgnWJup09tEbEH25j6fVotAgL7RLjHDpiYaJqFtqzA3Fugpmb4oBoKk2KrgWCKFKnxy
         b+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jWZm/pn4FsyWFvcjyRMSpyt5xAcwS65Tr7Uc4rQ3R4I=;
        fh=6x+zeIINYGJaH+Ck6Lv2AMKtqNs3vTDgOss2jBBhMZ4=;
        b=bNswgZthJiA7HBOvJ4cUFKpWJjSiUo8p7VxpZr26ITszoKvOe2jzjo39aiUJhlKv6c
         upHzMsBr0P0mWp8LRdPO/ymbIjy0UqaQKqtWj96qUqykwSyLbzJKxOWLOc6wC7+9Sebp
         YVM65V0lR2SHkwiKpm+AWPkToRdK5x/Zj8LdNCTk0GpEIeZmYKkOn68C0wS9z1j58DK2
         Ns9A1B3NGy33uEuIF2okNcQNjt800FiAwU+2HxK9Xoy56DkT6LhfZQUsb8wW0MYz32ba
         TQiFxxL4pUQRM65SVGgfbA2iuZTikCGcmkHpN2X39z6OdBVeONXIss/gG76RUgofkcnu
         MTFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517500; x=1779122300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWZm/pn4FsyWFvcjyRMSpyt5xAcwS65Tr7Uc4rQ3R4I=;
        b=TAXCX1e5JLPTsq2hs44rBJONULfEhmHyDTAGqBt9OEbryq6JcP3QQzSXmzGYshl0CJ
         Snrckgc9VxjgTd2qi9CPBbt1++d3biCbLt5MquIQk9nj8rh84lTDHMzA9Q/Jx6X8wzob
         heHyIuYwiN94vmHlE9irseHS+7+2sa4sf1fG3t61BRHmNlP26OHICPwEvyemhFOFVzg+
         aWm3PvHVeSiVAAkKjkt1AgsEBXdbQz0YLlKIgMn4KUdmGPrDqJ82cXAB74TnL5H6fGPe
         r+JhQZLcCxJc2SfS7yQfqqbQhoayWDshKazevbak+qdV8t38fNcpnGzqIufk/Pi0mXrQ
         wtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517500; x=1779122300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWZm/pn4FsyWFvcjyRMSpyt5xAcwS65Tr7Uc4rQ3R4I=;
        b=QEOnoux0FPMsOfIYsTr/PojP+6FpS03TtfxGcNjl7+EvDYEONnzdYlA3Zc7xG0Qieb
         2xjd/xnjLJyfNSp+WjYq0mqsjndmJZUMnyqz2ClIIzF38dKFHvmcHQ6p4wdEQPiICMho
         7dDDQV2cZcGatO2qTDMUdKn5KU7X+h8hcF8fmtkzB95xMxSwIzCspSRZ60MrCTloSt8j
         qi94F2s5IgpJQS0OZCYU7QOqBcteDMDrzQ7bqnPeWGliuTbol1rdYgqZy0rTbvrcv9Kd
         u1/HQf2MmvSUbFraRi7CQBcXnIchldf+t3iD3EnE/PuFBqzl4geo8pMazj9rJfv+E1X4
         jpKw==
X-Forwarded-Encrypted: i=1; AFNElJ8O9dDfXw/taWlneHRxfDTxtKYonwztUndD+1J66Ao1UZMJa8UShbaL63iuwZcPL0/HFPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOArTHeqre8GJeMkWnUmMEkGcrUVLhKGXdQLkEb4zwhBjvjZw3
	u66KG16wNJaQK68mBgCUOHSurL61o0Ynx4yhYcarPfMOf3ViP8K8Wq2RDnwKwEKO2oPhxjdWn45
	33E/MjD+P8ZbJMryu6VCdarHoUcjlT8M=
X-Gm-Gg: Acq92OGTkQwczDS/xkxx9N/0gyCZLGss+M/QXDv9ZL1h/lvZxRUnC27PSeJW8pZ62kT
	d+ML+Z8pRq/0voBkHkBlxITUI9RfJZMM40dFE6VSf9ofA13OlJPNSP1ubG7YPaQGoxklZcIBLd0
	Ht1AgoK9aX+11b5pnHlwueXqnR0XgYT2ICeVUfvoAKOumDu00VI2zzuqmoIYuRlzUPam5S7qJdn
	FWlkl1/IKe9tGt9PrKVTN0+ur11hJiMzNqI1q+dPDSVKGIbtTf7SwpGOp2k340nuJzKjf0KToX2
	lEU5x6yuZK7y7xKQunamA68=
X-Received: by 2002:a05:6a21:328b:b0:39b:f026:6f8e with SMTP id
 adf61e73a8af0-3aab16eb247mr17743487637.34.1778517499593; Mon, 11 May 2026
 09:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <20260509020243.223B1C2BCB0@smtp.kernel.org>
In-Reply-To: <20260509020243.223B1C2BCB0@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:38:07 +0200
X-Gm-Features: AVHnY4K1PGFzP1mFf471xzd0eIhUEeWHeOaZ86Y8osvuCHJ97l3GMSG-JBfn3Bc
Message-ID: <CAEf4BzbS0512oBcnPsPKrLiVWtDoevqS1Yvv-DHwCsDX0vANig@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: sashiko@lists.linux.dev
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 7:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] `resolve_uprobe_addr()` unconditionally uses `current->mm`, =
causing `is_optimized()` to fail when called from tracer context, which lea=
ds to target instruction stream corruption and potential kernel panics.
> - [High] Exhausting a process's trampoline page slots permanently disable=
s nop5 optimization for that uprobe across the entire system.
> --
>
> commit 2c63c19710be8b050bc0e126d84e52c24209e062
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Sat May 9 00:30:56 2026 +0000
>
> uprobes/x86: Fix red zone clobbering in nop5 optimization
>
> The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> probe site with a CALL into a uprobe trampoline. This commit changes the
> optimization to use JMP instead, introducing a trampoline page with slots
> to handle register state saving and jumping to the syscall.
>
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index ebb1baf1eb1d0..7e1f14200bbbf 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
>
> [ ... ]
>
> > @@ -761,147 +785,153 @@ void arch_uprobe_clear_state(struct mm_struct *=
mm)
> [ ... ]
> > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe=
_addr)
> >  {
> > -     struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
> > +     struct uprobes_state *state =3D &current->mm->uprobes_state;
>
> Can this cause a NULL pointer dereference or instruction corruption when
> executed outside the target task's context?
>

...

>
> Could we pass the correct mm struct down from is_optimized() to
> resolve_uprobe_addr() instead of relying on current->mm?

yes, good observation, I'll change resolve_uprobe_addr() to accept
mm_struct directly

>
> [ ... ]
>
> > @@ -1113,8 +1149,9 @@ static int __arch_uprobe_optimize(struct arch_upr=
obe *auprobe, struct mm_struct
> >  {
> >       struct uprobe_trampoline *tramp;
> >       struct vm_area_struct *vma;
> > +     unsigned long slot_vaddr;
> >       bool new =3D false;
> > -     int err =3D 0;
> > +     int slot, err;
> >
> >       vma =3D find_vma(mm, vaddr);
> >       if (!vma)
> > @@ -1122,8 +1159,17 @@ static int __arch_uprobe_optimize(struct arch_up=
robe *auprobe, struct mm_struct
> >       tramp =3D get_uprobe_trampoline(vaddr, &new);
> >       if (!tramp)
> >               return -EINVAL;
> > -     err =3D swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> > -     if (WARN_ON_ONCE(err) && new)
> > +
> > +     slot =3D tramp_alloc_slot(tramp, vaddr);
> > +     if (slot < 0) {
> > +             if (new)
> > +                     destroy_uprobe_trampoline(tramp);
> > +             return slot;
> > +     }
>
> If a process exhausts its trampoline page slots, will this permanently
> disable the nop5 optimization for this uprobe across the entire system?
>
> If get_uprobe_trampoline() returns a reachable trampoline that is complet=
ely
> full (all 256 slots used), tramp_alloc_slot() returns -ENOSPC. This error
> propagates up to arch_uprobe_optimize(), which handles failures by settin=
g
> the ARCH_UPROBE_FLAG_OPTIMIZE_FAIL bit on auprobe->flags.
>
> Since struct arch_uprobe is shared across all processes tracing the same
> inode and offset, hitting the 256-slot limit in any single process seems
> to permanently blacklist the probe from being optimized system-wide for
> all other processes, even if those processes have completely empty
> trampolines.
>
> Should get_uprobe_trampoline() also check if the trampoline has available
> slots before returning it, or can the failure be handled without setting
> the global failure flag?

It's a trade off. If we don't set ARCH_UPROBE_FLAG_OPTIMIZE_FAIL,
we'll keep wasting time trying to find and use uprobe trampoline for
each uprobe execution in that process, which is wasteful. So, given
this is a performance optimization, I think we'll just live with this.
The alternative would be a per-mm+per-uprobe extra information, which
seems like an overkill, so probably a no-go.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509003146.97=
6844-1-andrii@kernel.org?part=3D1
