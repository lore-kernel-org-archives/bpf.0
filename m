Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA543E9C4
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023414; cv=pass; b=o1jZ4FIVwVmcyHfCB2/k3Rq5cd/p1O0uEa+dGkRL9HlSO3QhQfy+rsbV+8es71Dh+DDGaykdRVFIShfiefaDuQxMV3DI/fv5tgS9poH0aSLz71DkO4NjwI2lnR0qA6Ktj3OxZcVdwMUpVtcyDHUVaCqHLcEtOqXq0piipN+1k5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023414; c=relaxed/simple;
	bh=ZeeXnTRW6gn8NEAsuf/mvUB03v1GIsbdVpbXeMyOpNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kysRpmd179CAHirH6aXVNN6u2FDEM2CiXp0jle8GFEycDP97Y7y6AsOiZ/0htySnVaPWPc3sVVpTQrhYJxR0njhmfBumcNBYYg+qwqJ6spllJr0x82HWA2zQXd2NXx4szwSOqpPELgtHRf4kKSFj20K8QwNZ4Czwxi0yMxOLok8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic9PaNR+; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic9PaNR+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0b9328c4aso40364665ad.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781023412; cv=none;
        d=google.com; s=arc-20240605;
        b=YxrcDckQ+npGYiNLdAKFx4inVwQStCXJp0oa8vQ65L9woQqMrFCU40Tm8pZZFKCVW2
         R6MI6tLihbr3ZDNGGQSX+WiWsGeruAgfEmy0HQyXoF7Th5SxOWGTllkGcGpBYM1m9p8g
         jUpsCs4OYBm15FLbEI+fgLJDIJghaeWuRSRD9CSOYDGaT3IgHjsGF6jjquIuU76jjpez
         AjXhBGgylrRCwaLnO37nSlqozU+axnsQPBGNiO2y/MJ4sGeIfQQSm7PJysbC5sXGnryU
         hZ+vLKw+RSM+jI5EMEz5HWdFH8n2YfKje8mST2Q9PQ9y0Aej1jY2KEq2NWAsAJ94Np97
         4fjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAzcYQhG7oyOvuLy1RsuzIzorkNF93A1Ez0XAGpnftY=;
        fh=gmwDEIPTZpVx9ZrNxYG131e1TTqW0Mw4vNPL4FBVcnI=;
        b=fAFmjMlXPWjdRujt3Y0hvFF+UmD1/MC2Ol5LlmqClx1fHpFa9SNBbkOgLaCgy1v8SX
         NDSGgHDpIs0NVMLYz3JkVsTeYD0DXb20VyuSjOElQ9iDlHUdlOGwPlU3iZCVV6smVm94
         XCwv0aBmPbgqmF/voJrMM0RQ0B2whdKrGBhcelYX67oYYY6wq8cI+ZRpHy/MFcLkZ6Oi
         aQjchL0hhzj4ZPODLXX1uShXfTeP94HaKPuFk3yglp1qQ/o9tp4FlU+HE7vV/CQDrsWy
         OCzyGuq3OXed1o1OP5JRC8QqfuyMuKTMnDhxSCXTrbAaRANAfMsPMjRjdTF0bjRW21dF
         qo8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023412; x=1781628212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAzcYQhG7oyOvuLy1RsuzIzorkNF93A1Ez0XAGpnftY=;
        b=Ic9PaNR+U7yqLGPOmxMDz/3afyh9PMpmwcROoMGS0M/QgH2OvARkEve7vDutinIMTj
         lHE+NZRWqp04YwTeEBtCr+Y6yDHKBCkvhD/u1HeMuaFSP7hg8mCGOQjAEa26EcKpfp3M
         /5vQKTJ12EwKR94ffKdQatBACfsvwHr0lRygEVLJ88tFhzxSo4VviT24TnMaw/ScRxyO
         820+jijX6hfIVQaFe12ULpej40bcFFcdlEjc2kXCvpx3omCVcFkIenqALMDGPDG6J8qw
         diocl+pL2fhxAgqtOmQJzfde9DgnRLAwunlPlW9xeOl/akENBClsPmaXLnkJ2/4mNOSW
         Qmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023412; x=1781628212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAzcYQhG7oyOvuLy1RsuzIzorkNF93A1Ez0XAGpnftY=;
        b=eV+gKXq8XaqAtf/YjC60XOaJyf05w3zyZSRj6ZyX3t0HNuO/EBqiRFnKbNSFzwJVOa
         N2LQIXxlOvXUaLKzbKNof+1RfBaV7+ButVkROaujNOjDJBJjxVLXIwuqnqgjjSbj00ej
         J/rc3+kNqGiAL1Ejv6oYbgEK644R0gwpNup6oI9JGaaq6WwmESz4hwmbhGQpcj61z1k8
         VPS0VQAlAavlQ2zovWgxq9LM40Kd5/VSuzWZBnH7Gwqgk549KgzvQzehh7MvLbRbt4GA
         VoXbwXd8RlNx0xLPg57S6egi6idZNRlD8XtTd8GBUGxUU1FTG43n6/apEJ0hSF8Ph6ZM
         lXQA==
X-Forwarded-Encrypted: i=1; AFNElJ+rKF/NgO8y7hdxdUfcOA84BRykftfh0tj88E4fJp+pSRN/+LtvzbD8KdaOxmKXHmUAzO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaCNBo7iSXxYcbeDbMBCSS5oCFc/Ar+SM2g7wpDnuocY25hqF
	+AVd/502KNHEPcUa5SMkTKsXVebCF5jImNK40mkL2dCaMonwY958zNm/FbdjyyVvfp7oIfU7dPa
	46E5jh7kT2k6WNdYXYO8EaUh8Gfq9gG4=
X-Gm-Gg: Acq92OH//fw7pctcnBlAkf25/IkjmUHx539TqfiQtTWKdJ4KEuOhm/BvwRj9fhenrij
	Seuarh51Y5hQxxDSchGxseWwy0e/tI08Vj5OvsgsI1wn3aHMlq3ojNr71nWCqY+C7Df7VxWT2gL
	ga0FFljIboAQbt+WnNRPlQwxBdYRzXrHxxDGRK+conGPvDZpB1B5BfhKLUN1znvrgUE7te1BohK
	P9Zb7HD7Y6jPDK4OapioduGmdPksRpFAVq5W55fv2ORwjCZ++AyLNusq7wNZf3xoEw5fl9tpu7f
	dyriGc29bOUTO4P3QKqkkb8cjte6lZzI5ta/ctVm9CZqAZql59W6Zy5Vo1NWylZamupmiePbzM5
	h1Yp1lrvJR28t/Nk=
X-Received: by 2002:a17:903:1acb:b0:2c0:ccdb:e02c with SMTP id
 d9443c01a7336-2c2a1baf93fmr49184375ad.7.1781023412021; Tue, 09 Jun 2026
 09:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <20260526205840.173790-6-jolsa@kernel.org>
 <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com> <aif8jkUPst-tTskE@krava>
In-Reply-To: <aif8jkUPst-tTskE@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jun 2026 09:43:15 -0700
X-Gm-Features: AVVi8CcxU0GCPRZ75YMUdnjcLSr_MdbLTt88syLtDsUgv9esYUAaAZ68vqS0Nr0
Message-ID: <CAEf4BzbsB-PRZRqkz37YK5wYNR=ajZv2N7tEznpZM0rdyYC_xA@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 4:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jun 08, 2026 at 01:46:39PM -0700, Andrii Nakryiko wrote:
> > On Tue, May 26, 2026 at 1:59=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > redzone area with call instruction storing return address on stack
> > > where user code may keep temporary data without adjusting rsp.
> > >
> > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > instruction, so we can squeeze another instruction to escape the
> > > redzone area before doing the call, like:
> > >
> > >   lea -0x80(%rsp), %rsp
> > >   call tramp
> > >
> > > Note the lea instruction is used to adjust the rsp register without
> > > changing the flags.
> > >
> > > We use nop10 and following transformation to optimized instructions
> > > above and back as suggested by Peterz [2].
> > >
> > > Optimize path (int3_update_optimize):
> > >
> > >   1) Initial state after set_swbp() installed the uprobe:
> > >       cc 2e 0f 1f 84 00 00 00 00 00
> > >
> > >      From offset 0 this is INT3 followed by the tail of the original
> > >      10-byte NOP.
> > >
> > >      After a previous unoptimization bytes 5..9 may still contain the
> > >      old call instruction, which remains valid for threads already th=
ere.
> > >
> > >   2) Rewrite the LEA tail and call displacement:
> > >       cc [8d 64 24 80 e8 d0 d1 d2 d3]
> > >
> > >      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are not
> > >      executable entry points while byte 0 is trapped.
> > >
> > >   3) Publish the first LEA byte:
> > >       [48] 8d 64 24 80 e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this is:
> > >         lea -0x80(%rsp), %rsp
> > >         call <uprobe-trampoline>
> > >
> > > Unoptimize path (int3_update_unoptimize):
> > >
> > >   1) Initial optimized state:
> > >       48 8d 64 24 80 e8 d0 d1 d2 d3
> > >      Same as 3) above.
> > >
> > >   2) Trap new entries before restoring the NOP bytes:
> > >       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this traps. A thread that had already executed the
> > >      LEA can still reach the intact CALL at offset 5.
> > >
> > >   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trap=
ped
> > >      and byte 5 as CALL.
> > >       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this still traps. Offset 5 is still the CALL for a=
ny
> > >      thread that was already past the first LEA byte.
> > >
> > >   4) Publish the first byte of the original NOP:
> > >       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
> > >
> > >      From offset 0 this is the restored 10-byte NOP; the CALL opcode =
and
> > >      displacement are now only NOP operands.  Offset 5 still decodes =
as
> > >      CALL for a thread that was already there.
> > >
> > >      Tthere is only a single target uprobe-trampoline for the given n=
op10
> > >      instruction address, so the CALL instruction will not be changed=
 across
> > >      unoptimization/optimization cycles.
> > >      Therefore, any task that is preempted at the CALL instruction is=
 guaranteed
> > >      to observe that CALL and not anything else.
> > >
> > > Note as explained in [2] we need to use following nop10:
> > >        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> > > NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- =
cs nopw 0x00000000(%rax,%rax,1)
> > >
> > > which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> > > attribute in is_prefix_bad function.
> > >
> > > Also changing the uprobe syscall error when called out of uprobe
> > > trampoline to -EPROTO, so we are able to detect the fixed kernel.
> > >
> > > The optimized uprobe performance stays the same:
> > >
> > >         uprobe-nop     :    3.129 =C2=B1 0.013M/s
> > >         uprobe-push    :    3.045 =C2=B1 0.006M/s
> > >         uprobe-ret     :    1.095 =C2=B1 0.004M/s
> > >   -->   uprobe-nop10   :    7.170 =C2=B1 0.020M/s
> > >         uretprobe-nop  :    2.143 =C2=B1 0.021M/s
> > >         uretprobe-push :    2.090 =C2=B1 0.000M/s
> > >         uretprobe-ret  :    0.942 =C2=B1 0.000M/s
> > >   -->   uretprobe-nop10:    3.381 =C2=B1 0.003M/s
> > >         usdt-nop       :    3.245 =C2=B1 0.004M/s
> > >   -->   usdt-nop10     :    7.256 =C2=B1 0.023M/s
> > >
> > > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> > > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.progra=
mming.kicks-ass.net/#t
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@ke=
rnel.org/
> > > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > > Assisted-by: Codex:GPT-5.5
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 190 insertions(+), 65 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe *aup=
robe, struct vm_area_struct *vma,
> > >         smp_text_poke_sync_each_cpu();
> > >
> > >         /*
> > > -        * Write first byte.
> > > +        * 3) Restore bytes 1..4 of the original NOP while keeping by=
te 0 trapped
> > > +        *    and byte 5 as CALL:
> > > +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > > +        */
> > > +       ctx.expect =3D EXPECT_SWBP_OPTIMIZED;
> > > +       err =3D uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> > > +                          LEA_INSN_SIZE - 1, verify_insn,
> > > +                          true /* is_register */, false /* do_update=
_ref_ctr */,
> >
> > tbh, it's quite subtle and non-obvious why is_register should be set
> > to true first two times (and especially that is_register and
> > do_update_ref_ctr are implicitly connected), not sure how to make it
> > cleaner, but maybe leave a short comment explaining this twice
> > register, once unregister sequence?
>
> ok, I came up with comment below
>
> thanks,
> jirka
>
>
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index de544516ea70..92449f34c005 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1011,6 +1011,12 @@ static int int3_update_unoptimize(struct arch_upro=
be *auprobe, struct vm_area_st
>         int err;
>
>         /*
> +        * Note the first two uprobe_write calls use is_register=3Dtrue, =
because they
> +        * are intermediate patching states while the probe is still acti=
ve.

this doesn't really explain why is_register=3Dtrue is the right one. It
actually doesn't matter as long as do_update_ref_ctr=3Dtrue, isn't that
right? So maybe just to avoid a bit of confusion let's pass
is_register=3Dfalse and do_update_ref_ctr=3Dfalse, and in the comment
explain as you said that it's intermediate update and we don't want to
update refctr just yet until the very last step?

> +        *
> +        * The last uprobe_write to nop10 instruction is called with is_r=
egister=3Dfalse
> +        * and do_update_ref_ctr=3Dtrue to trigger the refctr update.
> +        *
>          * 1) Initial optimized state:
>          *    48 8d 64 24 80 e8 d0 d1 d2 d3
>          *
