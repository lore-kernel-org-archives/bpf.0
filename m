Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68F3EBF16
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815029; cv=pass; b=EChQke4oQe2fsBTmIyZzxI5VdQVdytZN+gG+xmrmJEJXrb4qdTXLyo703USwhRtPw5y7lBBr7cvVvW1Cl3ADb02/fCdHdFDgCP6/bvVQld/75TUUfh7SdrbrYlQEGwe7UNrtYQ6xgGv4rM1O6NhGUTAE7yIm6zxZrQjrL5SKMnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815029; c=relaxed/simple;
	bh=kXLIv9Z8ptpWQ9lGeWrSdcNDbt3PrhK3S0Ia8ytG55w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgTXrEZ6PUtyIa6+xFHaRjQ2Bgf58tKgRK5Y1H30/IMBhYs0SqExmEF4kS4d0P0ncbL66zdz0VKTUwUePo9BDrwmIy+lzctUv5QxkBCspPOGTlId5EkMled85YAqksojpMg7wRvgeSuAjvZnKC6WfgvK8p3Svnid1nhfGI8BPEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAukuT2e; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAukuT2e"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so1593628d50.2
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 07:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791815027; cv=none;
        d=google.com; s=arc-20260327;
        b=VnX1OlQ208YD36yVlR9v9nRD0k2BGkOd+dvjZO0QD1vTbpYk20OvuXFVB96XN2L/d5
         SHYYh5yEKmKt9ZbGJIx5EkQPW2sjTlBExGMWNloS/2l1Mfzoh2FO0H+YLFmdq9jeEGqQ
         8sEqcB3EtLPoIg3l9Szoe4ioxgv9x2gJoWOFYnMuSa1DvjHbOWKoMnhbEXg5a3lx0Lp8
         dqUwyzPEmSerhESK+2h6rInxPlFWkw/RRZAIryg8uT7HoDKPBGc/vA2hu6qPS1zIk0dd
         tDxZr2W4oCuB8ELHA82Um4vO1wKbl8pqnLXwREGxJGV5O7x/ON8uGCsV9oaKGAiJ+9h5
         cQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYVD2/fOf0nyTIVA/pcXMc/3GdRicISF9zh8lG/z94k=;
        fh=Y/k4U7yoNLjw8JsGo3J4dpewq9eYJPGzO1oh42U3RZ4=;
        b=ILsM3lWwElDYBSnrV9+PbAVJr5OLe/cl08XzZdRmTCjxWRw2xeQeMWgN+OFaYEkWAb
         HwfKtl6zCmO9AeW3pqb/6rkXn3f07gbQiitKLKYbqCv7yw72B3JbtMOwk5bfWGW0Rm54
         tCccdH7F9paso1+neOo3kDU53WzhCbJMwsoNYNA17mm02S8a0XtY5k0CpEl8CeJcA6L3
         yzC8KVlYep+FvwtVfkfISBnTm8/g143Wz1AUqMMZZ01dl1QbrW5qnQ49hq7JBPC3d0pJ
         cQfjyfp0uIYLIE+1KuymOxvZ25312uJZ6py0SYXX9lhejmaHg1WCex6pEIeQGnbD+CEx
         pKqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791815027; x=1792419827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYVD2/fOf0nyTIVA/pcXMc/3GdRicISF9zh8lG/z94k=;
        b=MAukuT2eQa+RAJMIIQLBepvbf5NCtSSr7Vut8cTdN4FiRi2q48Nv5VHs+Z0HcQpZfe
         N7L6oEaORiNrtd90vFkwPYIknfeI9Kf/im/S5J8JhaA+DFIi2uOG8U2GQe9NJuVr+2HG
         y9oof7AHRrWIPlOWZrpgSnXMWtJ0Zr1mWCNXLYEKEB6CwR9ao+/fDEz1fRDOc6XJgsL1
         ZGDNa8R0Qscw2wT6ls77VzAALE8BDrEDqDvi18c13qVFXZBo8Q04g1SqFu5jEf1bKKzg
         Y0zdK9pB2+ZY3jhnGJp+BmP9cGSlfyQQ/YI2TDeKFLDYJC85oDB5Z167/VzBaMp/M22p
         9MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791815027; x=1792419827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYVD2/fOf0nyTIVA/pcXMc/3GdRicISF9zh8lG/z94k=;
        b=TlgfGGxlbdFFhJLbic18enfW6bY51fkgvPe/K+tIIlwsConLS6O6sdOFICKK9zhkrR
         Kbj/ydYedUqFcxJBWZ1Dpn0Sg2As2mWOMJfNeTzy1/H1RdCMTn7upIbPTQzYpPMBqK1N
         TlVLqcSpLVb5t7yaVM5aATUD+dVBOs+nd6TWN2KEGklMZWB9jwtaApIxoVDjPxsK1jDP
         DwZtJVEybVZahSR4SYiqvOkGOgrNAf+cNHpji/+oMoiwLYrSRncTE0BlEYi00nv2j83F
         FyeZ/489eAbO9b2K7m4xQ8+DYdAMn5DrASh5z619ifve33S0fkGmeIOKt0TONQMEIk8j
         ronw==
X-Gm-Message-State: AFq9FYKW9yc11KNLuEMTRwvFB0oaKkSUY2EP6p6e7cCvqAm3SY5ULbZ6
	DepCLAorcxtWzrw1QXjFHfl8AzmwzkqfZIZIIpiIJ1rYp0qwLCq5P5jfc7M0wFdpcBZOTW1s0n5
	/NSvn3ekyHvAlFDca2UAgKLUQWm7AKZU=
X-Gm-Gg: AYBFou2Bx8OQ9HfdGf/w2L0wJ7bftwiYWt+bl0qSkn3KJPrz7L3ZjNGvj6ltkv4Y/v3
	QJyytB3CzcFSI9AtuuBZFtHWSpnr4s/h1h4oDTwFgzfvlPKvWw3gQPRaqRmGFgdSbiOOBmyMO7H
	aU4tSI5Il5B5sPaaaHT5L+RIsd+sJhpiUfuYFdDM6aQDesraZZ5XqkpvbJeL79tC2KNaB0GHeeE
	RKJvcCqLkkiw9aBEn7JTh0hfLzJdQ7p11AdGxtg0ZjEulMq8V4VvzXLl4A5IuPIDIRhdhMyL4a2
	QaqkxJyfZBWzUkhTt8mUNga5qo3bMKfQcSqzuFwr0eJ4SjRQxFa0Qzxx8VcAkpJYyqtD+1hhLNr
	dcnHDNxSDvQ==
X-Received: by 2002:a05:690e:4192:b0:677:d106:6f9c with SMTP id
 956f58d0204a3-679362867a8mr2147661d50.87.1791815026466; Mon, 12 Oct 2026
 07:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012120438.52849-1-laoar.shao@gmail.com> <20261012120438.52849-2-laoar.shao@gmail.com>
 <sashiko-outbox-168087@kernel.org>
In-Reply-To: <sashiko-outbox-168087@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 12 Oct 2026 22:23:09 +0800
X-Gm-Features: AclHuK-9lM9g9S-C3ROal123aP5fOYW0LLV-IaA5rIADxO0M27DcvcX-i1S5wUc
Message-ID: <CALOAHbD5K32=Vq8sEk2nor4NzVWwXrgG15=5MFHxwbvxVJrrbw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] sched: add helpers for numa balancing
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 8:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] sched: Incomplete refactoring leaves direct sched_numa_balanci=
ng accesses
> - [Low] sched: performance regression in task_numa_fault() due to incorre=
ct static branch hint
> --
>
> commit 6333e53c9f6ee67bda34cc209d9f45e01a0af5fd
> Author: Yafang Shao <laoar.shao@gmail.com>
>
>     sched: add helpers for numa balancing
>
>     Two new helpers task_numab_enabled() and numab_mode_tiering() are
>     introduced to replace the scattered direct accesses to the
>     sched_numa_balancing static key and the sysctl_numa_balancing_mode
>     bitmask.
>
> > diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched=
/numa_balancing.h
> > index 52b22c5c396db..353772b49c5f9 100644
> > --- a/include/linux/sched/numa_balancing.h
> > +++ b/include/linux/sched/numa_balancing.h
> > @@ -32,6 +33,28 @@ extern void set_numabalancing_state(bool enabled);
> >  extern void task_numa_free(struct task_struct *p, bool final);
> >  bool should_numa_migrate_memory(struct task_struct *p, struct folio *f=
olio,
> >                               int src_nid, int dst_cpu);
> > +
> > +extern struct static_key_false sched_numa_balancing;
> > +
> > +/*
> > + * Whether NUMA balancing applies to @p.  The @p argument is unused fo=
r
> > + * now: a later patch will consult a per-cgroup BPF policy with it.
> > + */
> > +static inline bool task_numab_enabled(struct task_struct *p)
> > +{
> > +     return static_branch_unlikely(&sched_numa_balancing);
> > +}
>
> [Severity: Low]
> Does this wrapper unintentionally flip the branch prediction hint from
> likely to unlikely on hot paths?
>
> For instance, task_numa_fault() is almost exclusively called from NUMA
> hinting fault handlers, which only trigger when NUMA balancing is active.
> Before this patch, it used static_branch_likely():
>
> -       if (!static_branch_likely(&sched_numa_balancing))
> +       if (!task_numab_enabled(p))
>
> Because the new task_numab_enabled() wrapper hardcodes
> static_branch_unlikely(), could the compiler now outline the body of
> task_numa_fault() and other functions that expect the condition to usuall=
y
> be true?

Nice catch.

They are all static_branch_likely(&sched_numa_balancing) except
the one in task_tick_fair().  Since NUMA balancing is enabled by
default:

config NUMA_BALANCING_DEFAULT_ENABLED
        bool "Automatically enable NUMA aware memory/task placement"
        default y
        depends on NUMA_BALANCING
        help
          If set, automatic NUMA balancing will be enabled if running on a =
NUMA
          machine.

I believe we'd better make the change below first and then switch
the helper to static_branch_likely().

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15082,7 +15082,7 @@ static void task_tick_fair(struct rq *rq,
struct task_struct *curr, int queued)
        if (queued)
                return;

-       if (static_branch_unlikely(&sched_numa_balancing))
+       if (static_branch_likely(&sched_numa_balancing))
                task_tick_numa(rq, curr);

        task_tick_cache(rq, curr);

>
> [ ... ]
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c52c29dcb6a2e..451e26da5af24 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4199,7 +4200,7 @@ void task_numa_fault(int last_cpupid, int mem_nod=
e, int pages, int flags)
> >       struct numa_group *ng;
> >       int priv;
> >
> > -     if (!static_branch_likely(&sched_numa_balancing))
> > +     if (!task_numab_enabled(p))
> >               return;
>
> [Severity: Medium]
> Are there a few direct accesses to the sched_numa_balancing static key in
> kernel/sched/fair.c that might have been missed by this refactoring?
>
> For example:
>
> kernel/sched/fair.c:exceed_llc_capacity() {
>     ...
>         if (static_branch_likely(&sched_numa_balancing)) {
>     ...
> }
>
> kernel/sched/fair.c:get_pref_llc() {
>     ...
>                 if (static_branch_likely(&sched_numa_balancing) &&
>                     p->numa_preferred_nid >=3D 0 &&
>     ...
> }
>
> kernel/sched/fair.c:get_scan_cpumasks() {
>     ...
>         if (!static_branch_likely(&sched_numa_balancing))
>                 goto out;
>     ...
> }
>
> Since get_pref_llc() and get_scan_cpumasks() already take a task_struct
> pointer 'p', shouldn't they also be updated to use the new
> task_numab_enabled(p) wrapper?
>
> If these direct checks remain, might they bypass the per-cgroup BPF polic=
y
> that the commit message notes will be consulted in a later patch?

I will update it.

--=20
Regards
Yafang
