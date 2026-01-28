Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0231ED62
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627653; cv=pass; b=QECOUqiuX/JAg0yH0d1du7L/HXCyPFSoUo05ir950nGHjtmly3e2B/BjQoFAQaEw+c8nMjyrb2krPNwgX8UMeVC8MTkaNZedqzzTgOO/6POZrDs6DDyp9OB0/eBbJfFgJfMZ/AIU1ZqsKb+/DY2kLudg/YdI2SbAqbHTvsSuimM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627653; c=relaxed/simple;
	bh=P6HEuBQxmuKtnE3EhHBmItjZrwzt7HkpbH1ok9WvfRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKgmkcglJj7ykrD1bwPa3tv6/VIHEHJuKeF5HXoIkdrAdW3nRXix4/xuceG9xHGECI/Rz1PlmvcM2kBrJmghE2YFSIBxr5TYQxYAZOVGbnjIGPfuuXuJSxRnp4QN5JqULhzpMQkIxov7US8ZIGbcgxTo+SsMVoV/+hWpIsxiCUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2FCixth; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2FCixth"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso85129a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:14:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769627650; cv=none;
        d=google.com; s=arc-20240605;
        b=RktrdKNwNi0S2FgtMSG+oJlDMa9GJ0UlnS4+7Ns2IW5ny6eo7IGnk3nndmjn9QSWYs
         J4uBTRPsxU8pxcOioq8+UfdAbiFRmhYHxGk413wgnwujQ7IvHPnTBr7ZiYH9FKAn2SyG
         lFoAWmuzgsW8qUyB331V3781wqZl1vy266miM4zZVcJTAqCXYcPtq40ImvV90nzRwBDn
         MIEld2ruuJCNXLQ1rIwPjwpMolosoWj3aAWHeSDNxkAVrdl72RCQdFEQcYO/J+XXmeEO
         pEEe2SAq0GhkyuomYmv/SrWsRJB+D+NpiCNXX2FATig+sh7rv8pmQxgvJWRgFweZXn6F
         TPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n3s6Xpuqm/dKJ10t/Qed8QDZ5dDaFZI+uj1WgSJ0/QM=;
        fh=SHV6Ulpm7lFG5MiZwbwtC/zO2Bd8KXtIOhzwlCjym+U=;
        b=XjHkU00tS9E8W49lUOq2KQZTJXRBGzsFMLRmWQtUMcVchbtI6DVB26RAnTfR9V9CWb
         ztrJIRlg+AqqAgBjUlyLv6Tb716oN6DHwAFSmiwYQhtej/mZX1LVroZMP29Q0/Jssfmi
         4MEM2eTgYMxJNR3zOxTFc97VjiUcEbwvaF+R5p6VouTZ2/CAaETVr+SB6HaoXmps2cPw
         c8/dfTXZsEzRmawBEiNItgTCrzAR2Va/nA1b5jpqvHZ2/FswxOxFozgisVVoLBP1zkE+
         MBtmcWPFURA4hyuZo4jYx/7XgxMPc8b/WPwVuOCHrbXU6d+CWbKW70lOooiyPBLjiXyk
         44yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769627650; x=1770232450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3s6Xpuqm/dKJ10t/Qed8QDZ5dDaFZI+uj1WgSJ0/QM=;
        b=d2FCixthQQ/2J5DVI/NGS5rgPbAiV4LcLalUW3qgGprY98CdVd2he5s5v5Ub7c37g1
         4myBYJEd6JaHn4mkCeS4izYwHHX7O/yELzD1hPBMKjAIaYpdd7edNfbmKxyL7GXlX9AX
         mxzIsk/b+FqVojKHBs5Iib02Ra6I4rClB6J7cEZOdlZYENH5Hnio4jXNvsNHcSOYby1e
         cgtWUbIitVTryeGsc53OcJ2m9MvsWVMGyIVgjnH4pgjS6SpfULsH7PKXuSPR1lORSOAd
         Sr192Jl7ZCCFPObaDY2AfGyk9lhfhtYyAD3FlX5hYEwhqBokBoM+TyyAO4gFgcE/jrDG
         mZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769627650; x=1770232450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n3s6Xpuqm/dKJ10t/Qed8QDZ5dDaFZI+uj1WgSJ0/QM=;
        b=bQYBln2gmz4yfJ7ol60OGzLRTDT9F80r1FM7ArMdLxVhgAupIPs4BIafzNeOe9q70I
         BYfSX7/Cg+HhSsE8rmZxI3j8Uke5goXJhSD7ZXtdvmAwq/b4DFhWNuCRTn/LHfdlHyQb
         YqXXz9tNniZkaoKsIIwNSbdYOMRfmJesr+W4NJS0oN8iepdG98d5dOD0Z6QrcWBuS5X1
         A09CjMmhdosT14XNnmLRvdv1Fl/STtrPQp4kaQP2olRdzfotFHf8TX/HPYfoTTVZHmxo
         j+a9VpzrT7g1csk/Wn2a5AN0rNP49661rZdNLN+jf60HMqF+EwsIKiXufneoHNxAlzJR
         U37w==
X-Forwarded-Encrypted: i=1; AJvYcCUIPIpWxcK5x+iefvBNGKm5JCkuvFlndqxXjCYTG80ZkmPDmcNMAHtGkULZFo+5GfaLjEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FrjUEBQw59iNYnGfeQX7U0f6wYUPQf8BjmDX6FWr+/hjUNgg
	1B9QktkOH4I8wJ2ATzILOcrlhNaN8h3zLcTUvToH7efbEm00Rkv6BEZtAFpLNT9NG8P3Cas4YZQ
	jYMYidWnO03NlEgYcT2VHjLVPjZAWXVk=
X-Gm-Gg: AZuq6aJ0ovxHuZgXZoiXj0LmOIUp9I4FYY1AMZni4MnG+5aeN/9XjhYqoFYbnGJSoW5
	y0IuzFlQj7R4xJmOpnW0TmToAIt39nAD07b2bUgSQUr3BbiXrjs3PlLsFSe4DV+bvEeUuyoXDIK
	wIAAEs9CqBJeBFo2XHeDAN0mxsLCnES+TrRiAHxJp2d26yc1A7PxUrHBSFEXx3KKuxyRLaWzSPA
	yOm2j4IoPNSzimnsgl+wLHhLmLzw2XP3/XsOLNrr+eVj91Qfyxdn4feIXvkpsRxRjOtwvAmWqNx
	O7LVLI6h3To=
X-Received: by 2002:a17:90b:50c8:b0:340:b908:9665 with SMTP id
 98e67ed59e1d1-353fed94929mr5916568a91.37.1769627649465; Wed, 28 Jan 2026
 11:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-4-chen.dylane@linux.dev> <CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7EXWCqA@mail.gmail.com>
 <e609a4d6-1b28-4858-8a46-a95f0794bb33@linux.dev>
In-Reply-To: <e609a4d6-1b28-4858-8a46-a95f0794bb33@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 11:13:57 -0800
X-Gm-Features: AZwV_QgcPA1FPxVdEnNMUDxdbDYjl6yxuwre2AG95wokrOq3iwNZ6wcvnzUI1dw
Message-ID: <CAEf4BzZw=E_fP77HT_jSUXxCho4zBPGED0_YbvjxHHGZFvbcsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/3] bpf: Hold ther perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:21=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/1/28 05:35, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Sun, Jan 25, 2026 at 11:46=E2=80=AFPM Tao Chen <chen.dylane@linux.de=
v> wrote:
> >>
> >> As Alexei noted, get_perf_callchain() return values may be reused
> >> if a task is preempted after the BPF program enters migrate disable
> >> mode. The perf_callchain_entres has a small stack of entries, and
> >> we can reuse it as follows:
> >>
> >> 1. get the perf callchain entry
> >> 2. BPF use...
> >> 3. put the perf callchain entry
> >>
> >> And Peter suggested that get_recursion_context used with preemption
> >> disabled, so we should disable preemption at BPF side.
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   kernel/bpf/stackmap.c | 55 ++++++++++++++++++++++++++++++++++++-----=
--
> >>   1 file changed, 47 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index e77dcdc2164..6bdee6cc05f 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> >> @@ -215,7 +215,9 @@ get_callchain_entry_for_task(struct task_struct *t=
ask, u32 max_depth)
> >>   #ifdef CONFIG_STACKTRACE
> >>          struct perf_callchain_entry *entry;
> >>
> >> +       preempt_disable();
> >>          entry =3D get_callchain_entry();
> >> +       preempt_enable();
> >
> > pass perf_callchain_entry as input argument, to keep similar approach
> > to __get_perf_callchain, see below
> >
> >>
> >>          if (!entry)
> >>                  return NULL;
> >> @@ -237,14 +239,40 @@ get_callchain_entry_for_task(struct task_struct =
*task, u32 max_depth)
> >>                          to[i] =3D (u64)(from[i]);
> >>          }
> >>
> >> -       put_callchain_entry(entry);
> >> -
> >>          return entry;
> >>   #else /* CONFIG_STACKTRACE */
> >>          return NULL;
> >>   #endif
> >>   }
> >>
> >> +static struct perf_callchain_entry *
> >> +bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user, =
int max_stack,
> >> +                      bool crosstask)
> >> +{
> >
> > I don't really like having this wrapper, it feels like the flow will
> > be cleaner and easier to follow if we modify the code as suggested
> > below
> >
>
> Ok, will use it directly.
> >> +       struct perf_callchain_entry *entry;
> >> +       int ret;
> >> +
> >> +       preempt_disable();
> >> +       entry =3D get_callchain_entry();
> >> +       preempt_enable();
> >
> > I'd actually consider having __get_callchain_entry() that does what
> > get_callchain_entry() does right now under assumption that
> > preemption/migration is disabled, and then make get_callchain_entry do
> > preempt_disable + fetch entry + preevent_enable + return entry dance.
> >
>
> in v4, YongHong suggested add preempt_disable in get_callchain_entry,
> but Peter suggested that do it from BPF side, so maybe keeping the
> existing method is a compromise.

yeah, I guess perf's own usage of this is happening under constant
preempt_disable(), so this would be unnecessary for them. That's fine,
let's keep it outside

>
> > This will simplify the flow here to just with no explicit
> > preempt_{disable,enable} visible. Either way all of this has
> > assumption that we are staying on the same CPU throughout (so at the
> > very least we need to have migration disabled)
> >
> > entry =3D get_callchain_entry();
> > __get_perf_callchain(entry, ...);
> > put_callchain_entry();
> >
> >
> > BTW, is there a way to assert that either preemption or migration is
> > currently disabled? I think both get_callchain_entry and
> > put_callchain_entry would benefit from that
> >
> > pw-bot: cr
> >
> >
> >> +
> >> +       if (unlikely(!entry))
> >> +               return NULL;
> >> +
> >> +       ret =3D __get_perf_callchain(entry, regs, kernel, user, max_st=
ack, crosstask, false, 0);
> >> +       if (ret) {
> >> +               put_callchain_entry(entry);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       return entry;
> >> +}
> >> +
> >> +static void bpf_put_perf_callchain(struct perf_callchain_entry *entry=
)
> >> +{
> >> +       put_callchain_entry(entry);
> >> +}
> >> +
> >>   static long __bpf_get_stackid(struct bpf_map *map,
> >>                                struct perf_callchain_entry *trace, u64=
 flags)
> >>   {
> >> @@ -327,20 +355,23 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, re=
gs, struct bpf_map *, map,
> >>          struct perf_callchain_entry *trace;
> >>          bool kernel =3D !user;
> >>          u32 max_depth;
> >> +       int ret;
> >>
> >>          if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STA=
CK |
> >>                                 BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STA=
CKID)))
> >>                  return -EINVAL;
> >>
> >>          max_depth =3D stack_map_calculate_max_depth(map->value_size, =
elem_size, flags);
> >> -       trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> >> -                                  false, false, 0);
> >> +       trace =3D bpf_get_perf_callchain(regs, kernel, user, max_depth=
, false);
> >>
> >>          if (unlikely(!trace))
> >>                  /* couldn't fetch the stack trace */
> >>                  return -EFAULT;
> >>
> >> -       return __bpf_get_stackid(map, trace, flags);
> >> +       ret =3D __bpf_get_stackid(map, trace, flags);
> >> +       bpf_put_perf_callchain(trace);
> >
> > Just as above, I think get_callchain_entry + __get_perf_callchain +
> > put_callchain_entry is better, IMO
> >
> >> +
> >> +       return ret;
> >>   }
> >>
> >>   const struct bpf_func_proto bpf_get_stackid_proto =3D {
> >> @@ -468,13 +499,19 @@ static long __bpf_get_stack(struct pt_regs *regs=
, struct task_struct *task,
> >>          } else if (kernel && task) {
> >>                  trace =3D get_callchain_entry_for_task(task, max_dept=
h);
> >>          } else {
> >> -               trace =3D get_perf_callchain(regs, kernel, user, max_d=
epth,
> >> -                                          crosstask, false, 0);
> >> +               trace =3D bpf_get_perf_callchain(regs, kernel, user, m=
ax_depth, crosstask);
> >>          }
> >
> > with the above suggestions this will be a pretty streamlined:
> >
> > trace =3D trace_in ?: get_callchain_entry();
> > if (!trace)
> >      goto err_fault;
> >
> > if (trace_in) {
> >      trace->nr =3D ...
> >      err =3D 0
> > } else if (kernel && task) {
> >      err =3D get_callchain_entry_for_task(trace, ...);
> > } else {
> >      err =3D __get_perf_callchain(trace, ...);
> > }
> > if (err)
> >      goto clear;
> >
>
> This code looks much cleaner, i will change it, thanks.
>
> > ... proceed as before, we have our stack trace inside trace ...
> >
> > for successful and failed paths (you'll have to duplicate this logic):
> >
> > if (trace !=3D trace_in)
> >      put_callchain_entry(trace);
> >
> >>
> >> -       if (unlikely(!trace) || trace->nr < skip) {
> >> +       if (unlikely(!trace)) {
> >
> > this condition cannot happen: we either get trace_in !=3D NULL or we ge=
t
> > it using __get_callchain_entry and then validate it's not NULL
> > earlier, so drop this condition
> >
>
> will remove it.
>
> >> +               if (may_fault)
> >> +                       rcu_read_unlock();
> >> +               goto err_fault;
> >> +       }
> >> +       if (trace->nr < skip) {
> >>                  if (may_fault)
> >>                          rcu_read_unlock();
> >> +               if (!trace_in)
> >> +                       bpf_put_perf_callchain(trace);
> >
> > do this clean up in one place, behind the new goto label? it's a bit
> > too easy to miss this, IMO
> >
>
> ok, will do.
>
> >>                  goto err_fault;
> >>          }
> >>
> >> @@ -495,6 +532,8 @@ static long __bpf_get_stack(struct pt_regs *regs, =
struct task_struct *task,
> >>          /* trace/ips should not be dereferenced after this point */
> >>          if (may_fault)
> >>                  rcu_read_unlock();
> >
> > now that I looked at this code, I feel like we don't really need this
> > rcu_read_{lock,unlock}() dance (even though I added it in the first
> > place). I this RCU was supposed to be need to keep
> > perf_callchain_entry alive long enough, but for BPF this is guaranteed
> > because either BPF stack map will keep them alive by delaying
> > put_callchain_buffer() until freeing time (after RCU Tasks Trace + RCU
> > grace periods), or for bpf_get_stack/bpf_get_task_stack, BPF program
> > itself will hold these buffers alive again, until freeing time which
> > is delayed until after RCU Tasks Trace + RCU grace period.
>
> It seems so, for both, put_callchain_buffer is always called at the end,
> which ensures it won't be released during use, i will remove it as a new
> patch.
>
> >
> > Please send this clean up as the first patch in the series so we can
> > review and ack this separately. Thanks!
> >
> >> +       if (!trace_in)
> >> +               bpf_put_perf_callchain(trace);
> >>
> >>          if (user_build_id)
> >>                  stack_map_get_build_id_offset(buf, trace_nr, user, ma=
y_fault);
> >> --
> >> 2.48.1
> >>
>
>
> --
> Best Regards
> Tao Chen
