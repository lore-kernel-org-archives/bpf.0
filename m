Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96241BC39
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471852; cv=none; b=hU1JHEmRbSCTrWpf42hib35C/qDR2xxuULbHiuK/YL+kHvB32uEkey1xfSOaACcc2Mgp5PAPRvmzVzAK47NYjvpjgRHVvGMCN8hpmdCC7smconopen2Jg3EK2DnUTIWUTu8zjT+uMWeD3PkIgIaq7JLrKeNEWNFQkH8bnzznW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471852; c=relaxed/simple;
	bh=76K8DD1Lv6kdl+awYoeNzE3jP5HHCtHrhNQmsbPdCYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqjTBPFyNGuSzYvquTZk62Tf4H10vCX1W0JeJqmIZDgZz70+tCGmYI86wxRagA7HsSsNZinCmdJFDStGZJqQGRE81DcJ1U/Jp2JOZaFWPLL20U9QlBPZcDZkiTfyYLKYUQsqbOvHO/WpOmPoiS2jkcE+JDtSF1N8RcIShgqHE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4HGCv9o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4HGCv9o"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0d8403257so12982665ad.1
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711471850; x=1712076650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba58PpGPu3HW6TrsTw7EttcWTYaMhFl25oHU2xgUk9s=;
        b=W4HGCv9opXui1RPdQ4V35QQBQHB5omMHqM1tXG1ejStnOvPwYvAkH6hLSkDa6lD/EO
         q+rfk8Po6wJirl1B9gvJVirRoCFmYjFfzusmvq7l9Tnn8P0es3LrkiW0EfpJsfV7Ig4/
         fh/xecEkhangLt3I3JIsLy8v/oi1UQXpJY7ccBAZj4PxWDNmm4HxNLIKaUm4OalW9xvQ
         PCqsKoe3Bc2XqcW7s74/QtjcYy+r0GkFvLMGOcpwGP6R6M9LDutP3ojroz+c1Tb1bUIH
         XMgADadYBMjUe6TyCEvoKAlI4zDi+j2etWYyWuIScEBJwGOSgeRhuVhDvPhEJ8xiLs3D
         Ih9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711471850; x=1712076650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba58PpGPu3HW6TrsTw7EttcWTYaMhFl25oHU2xgUk9s=;
        b=IpuqtFKkYjauDxPhzGdMiU8SOMTuGHH/5d6iVLD7Ll6zbvRUCsOeFUFBfS49RZu3Z6
         lh02ANGJeAhgBGhAG5o5CZEhel0ZknPyIqTkd5YaYoyHDTV4OajhEOeUXSvbNBrLnGs1
         F3MVMo+vekgLWhm2dka64rk+Wm87J44tSei6aKFsfX3AP4b8xieF20OJS7sInZQw1vxG
         ED9htU8rSnlhxrJaHSdEKtHj1ju8QShFJWMzi66rFJ3WqtwzYPSytmHfwdwrUtUuRPR7
         evsq3GV5excmwAammOJQNa4nxi/7CBq3ErPXG5zp/n/2uqWC6O2qVpn/pBLBTm9MoC7I
         /Zaw==
X-Forwarded-Encrypted: i=1; AJvYcCXJwVv2sveEfCgLMa5od/MCiA2InlaTfV9CfQt/aHm1SUgF7Ukfc5IV0Revk/x6OXD/OJB5/71fcmMsqnRkVheJIDtc
X-Gm-Message-State: AOJu0Yx/6VG5WJ+1vjlvPN7YCpfh0BlB7v57ghNHmJbxHYkv9CnG4UdB
	GxbQ+Eej220cnTNK0uVAY4gOZla1/a+31WHOjuQnLl6sC+ggAcBzpmGYzjb0hbsEK9BBnUcrmiT
	Mi/41Jkqt+BJSgWELfBu07LNz2UE=
X-Google-Smtp-Source: AGHT+IH0/4EQuoKZLGaxeWdn9cuPmJulzHW/DJp4U/4cTVs3Mxk1HQ4d2+lTjDwaDQJkJVYv0LHVKcngPhNM/EsdTO4=
X-Received: by 2002:a17:902:c211:b0:1e0:64bd:51ac with SMTP id
 17-20020a170902c21100b001e064bd51acmr8918369pll.22.1711471849863; Tue, 26 Mar
 2024 09:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
 <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com>
 <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com>
 <CAEf4BzZqem6OQX=LHwz7cfvCGXmbFVHzSgD-9i6C8dfMJTMT3Q@mail.gmail.com> <CAADnVQLUVEWZB2WgkdCGkyh3T7ocZf1SkqWLAz6jGK+9LU_MYw@mail.gmail.com>
In-Reply-To: <CAADnVQLUVEWZB2WgkdCGkyh3T7ocZf1SkqWLAz6jGK+9LU_MYw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Mar 2024 09:50:37 -0700
Message-ID: <CAEf4BzZXYmDCP5WJ786UN+zBS4d9TrZM=cLQCZ9QihRjbriyUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Mar 24, 2024 at 7:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 22, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 21, 2024 at 4:46=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@=
kernel.org> wrote:
> > > > > >
> > > > > >
> > > > > > There are still ways to reduce number of "wasted" records furth=
er, this is
> > > > > > a problem that requires many small and rather independent steps=
.
> > > > >
> > > > > I feel this is a wrong path to follow.
> > > > > I think it would be better to introduce a flag for kprobe/fentry
> > > > > to do perf_snapshot_branch_stack() as early as possible
> > > > > and then bpf prog can copy these 16 or 32 8-byte entries at
> > > > > its leasure.
> > > >
> > > > This is basically how Song started when he was adding this feature =
a
> > > > few years ago. And I feel like we discussed this and decided that i=
t
> > > > would be cleaner to let the BPF program decide when (and whether) t=
o
> > > > get LBR, based on conditions. It still feels like a right tradeoff.
> > >
> > > Right we discussed it back then and at that time it was about
> > > collecting stacks.
> > > What's different now is you want to collect all types of branches
> >
> > I was using --lbr=3Dany
>
> and that's probably something to fix.

Fix in the sense to adjust or add another generic
PERF_SAMPLE_BRANCH_xxx value? Or you mean stop using --lbr=3Dany mode?

> I suspect retsnoop quality won't suffer if ARCH_LBR_REL_JMP is disabled.
> To figure out the path to return in the code
> ARCH_LBR_JCC      |
> ARCH_LBR_REL_CALL |
> ARCH_LBR_IND_CALL |
> ARCH_LBR_RETURN
>
> might be good enough and there won't be a need to do
> inling in odd places just to avoid tail jmp.

retsnoop supports all modes perf exposes generically (see [0]), I
believe I tried all of them and keep gravitating back to --lbr=3Dany as
most useful, unfortunately.

But it's ok, let's put this particular __always_inline on pause for
now, it's one LBR record more, not the end of the world.

  [0] https://github.com/anakryiko/retsnoop/blob/master/src/retsnoop.c#L269=
-L280

>
> > do this to get almost all the benefit. I just need to inline
> > bpf_get_branch_snapshot().
>
> If that is the only one that needs inling then fine,

yes, it's one of the most important ones, I'll take it :)

> but I really don't like to always_inline
> kprobe_multi_link_prog_run().
> A day goes by and somebody will send a patch
> to save 500 bytes of kernel .text by removing always_inline.
> The argument that it's there to help a user space tool that
> wants to do lbr=3Dall instead of excluding rel_jmp
> won't look good.
>

There is a lot of __always_inline in rethook/ftrace code, as well as
some in BPF code as well. I don't remember people trying to roll this
back, so this seems a bit overdramatic. But ok, if you think it will
be problematic to reject such hypothetical patches, let's put
kprobe_multi_link_prog_run inlining aside for now.

> >
> > I don't think we can get rid of migrate_disable, we need to make sure
> > we are freezing LBR on the CPU on which BPF program will run. So it's
> > either preempt_disable or migrate_disable.
>
> we cannot extend preempt disable across the prog
> and migrate_disable won't really help, since
> there could be another prog on the same cpu
> doing the same "save lbr" action in a different hook
> that will trash per-cpu scratch space.
>
> But we don't need to either migrate_disable or preempt_disable.
> We can have a 32*24 byte buffer per attach point.

I'm missing how we can get away from having a per-CPU buffer. LBRs on
different CPU cores are completely independent and one BPF prog
attachment can be simultaneously running on many CPUs.

Or do you mean per-CPU allocation for each attach point?

We can do LBR capture before migrate_disable calls and still have
correct data most of the time (hopefully), though, so yeah, it can be
another improvement (but with inlining of those two BPF helpers I'm
not sure we have to do this just yet).

> In case of fentry it can be in bpf_trampoline or in bpf_link
> (I didn't analyze pros/cons too far) and
> fentry will only do the single "call intel_pmu_snapshot_branch_stack"
> with that address.
> That's a trivial addition to arch_prepare_bpf_trampoline.
>
> Then bpf prog will take entries from link, since it has access to it.
>
> Same thing for kprobes. As soon as it's triggered it will
> call intel_pmu_snapshot_branch_stack.
> Should be simple to add.
>
> Recursion can overwrite that per-attach buffer, but
> lbr is screwed anyway if we recursed. So not a concern.
>
> > Note also __x64_sys_bpf+0x1a, it's the artifact of how fexit is
> > implemented, we call into original function and it returns into
> > trampoline. So this seems unavoidable as well without completely
> > changing how trampoline works for fexit. Multi-kprobe actually,
> > conveniently, avoids this problem.
>
> Definitely do not want to redesign that to help retsnoop save an lbr entr=
y.

Yep.

>
> > > Inlining bpf_get_branch_snapshot() may be ok,
> > > but the way you're doing is not a clear win.
> > > Replacing size / 24 (that compiler optimize into mul)
> > > with actual divide and adding extra mul will be slower.
> > > div+mul vs mul is quite a difference.
> > > How noticable is that is questionable,
> > > but from inlining perspective it doesn't feel right to do
> > > "inline to avoid extra frame" instead of
> > > "inline to improve performance".
> >
> > Yes, I saw this division-through-multiplication division. I can
> > replicate that as well, but it will be pretty hard to understand, so I
> > thought it is probably not worth it. Note that
> > bpf_get_branch_snapshot() is not some sort of performance-critical
> > helper, if you are calling it on some super frequent kprobe/fentry,
> > you are paying a lot of price just for copying 700+ bytes (and
> > probably a bunch of other stuff).
>
> div is the slowest instruction.
> On skylake it takes 57 uops and 40-90 cycles while mul takes 3 cycles.
> L1 cache is 1-2.
> So it might be faster to copy 768 bytes than do a single div.

Ok, I can add the div-through-multiplication code to keep it 1:1 w/
compiled helper code, no problem.

>
> I still think that adding call intel_pmu_snapshot_branch_stack
> to fenty and kprobes is a simpler and cleaner solution that eliminates
> all guess work of compiler inlining and optimizations.
>
> We can potentially optimize it further.
> Since arch_prepare_bpf_trampoline() is arch specific,
> for x86 we can inline:
>         local_irq_save(flags);
>         __intel_pmu_disable_all(false);
>         __intel_pmu_lbr_disable();
> into generated trampoline (since above is just 5-6 instructions)
> and call into __intel_pmu_snapshot_branch_stack.

Let's keep it as plan B, given this gets into gnarly internals of
Intel-specific x86-64 code.
