Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFA57314
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422810; cv=none; b=RJZu160WnA7l+dMj3h+VbXQKtttLJIEz5dnHf7j3nCkYklAAdfB0GR1a8lNGZhOhMqbWvIXM0G0Hd98xz8xfQ0iqt0Z52N6T/aSijhNxPglxUmEZixbSEHPaTHM/cx+mndMwfVcJ5MlfJXULIPUDoUF947gB1JAukAkgIih4Ieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422810; c=relaxed/simple;
	bh=vKp8D3sR9i3z3I9PGsE34ROPqtuujqiZ+chx2bF98cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJbjtI8w0/BOvcC2JCsbiV7sACJl1fagJKiOpAo6pVgcp5uozlZZWuwR+mC5dLSi+BmOVjiCrodfu3sfE6Jo6fojm4TTWxJDtE/uucP+rXyDFCNwFh3RF8YlR5JxM43sXkrPJVe1O8Z5qiBn1HPkk3Aq+Io0PWgoeh7nBmEn9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzjhbsQb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzjhbsQb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341d730bdfcso255326f8f.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 20:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711422807; x=1712027607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9JGedcMfFDONTZH+5sZfqwn4NjGkHINS//sfkCtaMg=;
        b=JzjhbsQbTQp1cAz9RKhzFtTMkm3RoOSmeyu851oy/AXrBTQn/YJsoGxLqjKqSomdrX
         +ce0n5pPH8+/WacLC8+t/xnPUgaNj1ykNoyKpi7rk+Wilyzrqk+lYsjvEcrgKBEqBceS
         4SBF2NLiGHeW0pM2b7YuukcBZnFibPqPEPLg4LYl8BSsBIX+ClYtciXVFNfh0vuP6Afa
         pSg8LWnRm0h5gKysjQn01YzK+9v4Xvf7L4RZA+yBRvQfRpHuKGy9xnSKj399wnexS3rR
         TS8hoIR7l1eoPUbgbuphD+cRyDRCK3kOHcX1C0OLuSISSHsGnQhVc+S1MXYaQwirIE71
         GZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711422807; x=1712027607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9JGedcMfFDONTZH+5sZfqwn4NjGkHINS//sfkCtaMg=;
        b=BjT6PWqPusMWTTP/4oiJ2SWBvJntVE5L8IYxtpHn/Px+vfeVsIzNT29nPg1kHetwq2
         miv5BT6onxk7rpL6HMO3wDKr3swnsnMV7Q9FOSLRySwNmJKxyI7pvrb1j8t7a9i+3IJc
         8tZt+cxnjEVv+f17yWG0mz/RweR09313XuqJYlDJpfbv1vBVoEwDMe1dKBtmUmke1qgg
         ayrCuDboaDa55sYgUa0cBJftijeuYA5Dk+KcaiRISGqnkFTIYHJkLcIlKG85p1XmF7wp
         klpkZedUpUXmkQvDk5U/R7a9t8TgX7BH/D2C5SkQZ1EpOvZ7COyhGCUng4oPWGKK82z2
         WGlA==
X-Forwarded-Encrypted: i=1; AJvYcCUNYHUmr5JBOLeX62VBbQ6B3KoWlzFUQzZtf3nxfCKLW0T3nIX8KbFW0giMM5cDxOiJURmmDnNESHcu+jAY4GbDvWGD
X-Gm-Message-State: AOJu0YxIWwL5P8EFegP++QHJzYeADEsYuztzqHjaIqE3Z5EGjO4lnxMV
	Aqa4uplaz0nXXWdy9KASPUf8YjnJfC2vZiXqyowzsni0B+CxH9OwxI5BgEVEs9SpvRcpluipTdC
	4EXmDtgBSkweUT0xUHChmwTG00Fs=
X-Google-Smtp-Source: AGHT+IF1rpP2eOdhsDozF663LhyG8Vw2QvVe3B9FeDrXkWSyjZo/XA8chtMAI7b0Fgn0Jwg1MU8acE/AK5KJkoxe9fM=
X-Received: by 2002:adf:e044:0:b0:33d:c572:7641 with SMTP id
 w4-20020adfe044000000b0033dc5727641mr5894476wrh.14.1711422807065; Mon, 25 Mar
 2024 20:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
 <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
 <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com> <CAEf4BzZqem6OQX=LHwz7cfvCGXmbFVHzSgD-9i6C8dfMJTMT3Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZqem6OQX=LHwz7cfvCGXmbFVHzSgD-9i6C8dfMJTMT3Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 20:13:15 -0700
Message-ID: <CAADnVQLUVEWZB2WgkdCGkyh3T7ocZf1SkqWLAz6jGK+9LU_MYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 7:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 4:46=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@ke=
rnel.org> wrote:
> > > > >
> > > > >
> > > > > There are still ways to reduce number of "wasted" records further=
, this is
> > > > > a problem that requires many small and rather independent steps.
> > > >
> > > > I feel this is a wrong path to follow.
> > > > I think it would be better to introduce a flag for kprobe/fentry
> > > > to do perf_snapshot_branch_stack() as early as possible
> > > > and then bpf prog can copy these 16 or 32 8-byte entries at
> > > > its leasure.
> > >
> > > This is basically how Song started when he was adding this feature a
> > > few years ago. And I feel like we discussed this and decided that it
> > > would be cleaner to let the BPF program decide when (and whether) to
> > > get LBR, based on conditions. It still feels like a right tradeoff.
> >
> > Right we discussed it back then and at that time it was about
> > collecting stacks.
> > What's different now is you want to collect all types of branches
>
> I was using --lbr=3Dany

and that's probably something to fix.
I suspect retsnoop quality won't suffer if ARCH_LBR_REL_JMP is disabled.
To figure out the path to return in the code
ARCH_LBR_JCC      |
ARCH_LBR_REL_CALL |
ARCH_LBR_IND_CALL |
ARCH_LBR_RETURN

might be good enough and there won't be a need to do
inling in odd places just to avoid tail jmp.

> do this to get almost all the benefit. I just need to inline
> bpf_get_branch_snapshot().

If that is the only one that needs inling then fine,
but I really don't like to always_inline
kprobe_multi_link_prog_run().
A day goes by and somebody will send a patch
to save 500 bytes of kernel .text by removing always_inline.
The argument that it's there to help a user space tool that
wants to do lbr=3Dall instead of excluding rel_jmp
won't look good.

>
> I don't think we can get rid of migrate_disable, we need to make sure
> we are freezing LBR on the CPU on which BPF program will run. So it's
> either preempt_disable or migrate_disable.

we cannot extend preempt disable across the prog
and migrate_disable won't really help, since
there could be another prog on the same cpu
doing the same "save lbr" action in a different hook
that will trash per-cpu scratch space.

But we don't need to either migrate_disable or preempt_disable.
We can have a 32*24 byte buffer per attach point.
In case of fentry it can be in bpf_trampoline or in bpf_link
(I didn't analyze pros/cons too far) and
fentry will only do the single "call intel_pmu_snapshot_branch_stack"
with that address.
That's a trivial addition to arch_prepare_bpf_trampoline.

Then bpf prog will take entries from link, since it has access to it.

Same thing for kprobes. As soon as it's triggered it will
call intel_pmu_snapshot_branch_stack.
Should be simple to add.

Recursion can overwrite that per-attach buffer, but
lbr is screwed anyway if we recursed. So not a concern.

> Note also __x64_sys_bpf+0x1a, it's the artifact of how fexit is
> implemented, we call into original function and it returns into
> trampoline. So this seems unavoidable as well without completely
> changing how trampoline works for fexit. Multi-kprobe actually,
> conveniently, avoids this problem.

Definitely do not want to redesign that to help retsnoop save an lbr entry.

> > Inlining bpf_get_branch_snapshot() may be ok,
> > but the way you're doing is not a clear win.
> > Replacing size / 24 (that compiler optimize into mul)
> > with actual divide and adding extra mul will be slower.
> > div+mul vs mul is quite a difference.
> > How noticable is that is questionable,
> > but from inlining perspective it doesn't feel right to do
> > "inline to avoid extra frame" instead of
> > "inline to improve performance".
>
> Yes, I saw this division-through-multiplication division. I can
> replicate that as well, but it will be pretty hard to understand, so I
> thought it is probably not worth it. Note that
> bpf_get_branch_snapshot() is not some sort of performance-critical
> helper, if you are calling it on some super frequent kprobe/fentry,
> you are paying a lot of price just for copying 700+ bytes (and
> probably a bunch of other stuff).

div is the slowest instruction.
On skylake it takes 57 uops and 40-90 cycles while mul takes 3 cycles.
L1 cache is 1-2.
So it might be faster to copy 768 bytes than do a single div.

I still think that adding call intel_pmu_snapshot_branch_stack
to fenty and kprobes is a simpler and cleaner solution that eliminates
all guess work of compiler inlining and optimizations.

We can potentially optimize it further.
Since arch_prepare_bpf_trampoline() is arch specific,
for x86 we can inline:
        local_irq_save(flags);
        __intel_pmu_disable_all(false);
        __intel_pmu_lbr_disable();
into generated trampoline (since above is just 5-6 instructions)
and call into __intel_pmu_snapshot_branch_stack.
