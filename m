Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC033260C
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594606; cv=pass; b=deQUBHSMnis4YvZ5ev5R12mPkTFJTGOXaztbQV7o0uVasQE+zzvUwyoRZZJG53DXbXphBUXUfa9L07vHipSSoas5EYYRbpn10DwBXczzl369gGjcs4dxvTRZ8ubSvrganMHMpSWn1t6s5WaI1tYRla6sbrmXt7vfjISNmeSNdhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594606; c=relaxed/simple;
	bh=kyvju2B3kVRFWxtt3UBGqzSAAkahmS3D2grt7G1bekA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u83rfOozLWbHJZ/6DI3cbBuZtug0wXtsg0/vV58y/GvCEqSI80f4E7zHUZtBmPyJUZqbKncYI/5vvSGdhvKHIYqA++udp4SMYVoBWUdAgbViaMjQdafWUQ4w5HIMe2Ouqu5Z4bZ8V85vYYfizEh/7QyYZJBlMNx46gSAY4YBMU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=req0uku2; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="req0uku2"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664e3ed58bcso873490d50.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786594604; cv=none;
        d=google.com; s=arc-20260327;
        b=GthkN7IYbnCp+23PHVqY0TpKmETRS67NiSu6bTo48sLeakrUXxnMeqXsxCo/Fynp4s
         HoXj3wnWIvsBiBjjsoh0xHYTv3vO7AWXWOysbUgErwwt2L16YGBHm2uVxcaG4y1Uu8H7
         A7W10YUw1nglqd7Cvsot8dO2gfNrtlERn49ppmQ5AsP5XkfIGNlZaY0gV+UGOQ+W4+SE
         3Ak8J5MfpgFOArNSEOWN/dHAcvcH6BvjEvm9OkMR+/UxCyfy9DBPpCkQjDRp9bCiwtoc
         jHV8B2/1nbvHCfOe1F4a4x/fDtCEoC46WlxbDvmjlvsQfofn/qMv/XcTxwE5HTznLHb4
         yTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hj+aZ+4yYhvsPaAhIqtP1+VT7SwFhpMGkiPhnjwuFe4=;
        fh=6xpnP9QYE5/HVJJHdKAYZ8F/r06KD1Q+8qYld7eb8ZM=;
        b=R7NjtVwKIgw5Xpsv3xCDU6iy+W9REJUlz9aqlccBrR1wehiNaPFmLvtPu5VGzGoLY7
         mhIxGzAimp0yUr7vRTo4PPh9gn8m5gebVJ+ihOm7bG/LmjcFZUijqOOV7A6YvctlgOWP
         BD9pycxMwEhIKOkA1aAf/JVNBdcd3s3cvpqRmOAhpp5p0+RaIj48ly+o7Km25WAd9XMu
         7SdKxJzcLdocEz44TJPvw6GZpKb9C97hSu6IHW510pmxJnJwwI1nsaq4elFDxlclMDCt
         hRxrgCRWWmu6e85B0js6+wXEe4JMvKc4zWILdlByjjc23kBLRdrqP9eld2f5hbPtO/yA
         C/gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786594604; x=1787199404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hj+aZ+4yYhvsPaAhIqtP1+VT7SwFhpMGkiPhnjwuFe4=;
        b=req0uku2ETWcB1cJ2WbF+yaXE5uKne+ndkbW/DLtlXfjIvKjv/4VyEKJxoTADWlfnj
         d46ebDXkahmv8Bh16F/Bfu2r0fbOmILJyi7ykzRysVZRDFppPSGB+jTk4bo/Ir7Q+KM/
         RELAr6vOHdQK61h5/CcQRRXzOVl+ZYKFdLkUhM6gQqFHjHO/O+j6PTFKHruVHV/R+J06
         v4zG77kcrZL2A7aZrnLTrgPRa8F7buTYUF9gR5MR3BfiUhyROYK2uUGv2zV+OF9LudtF
         kVWP5ly+9HZBgcCjCvsxjo/YIUEttSzDsSS7H2N8xK67I6l88rw9IXQT46vo9Gh1VJx+
         841g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786594604; x=1787199404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hj+aZ+4yYhvsPaAhIqtP1+VT7SwFhpMGkiPhnjwuFe4=;
        b=jn+LApp83jzkYOgQpxMMbUq23Ln2O/fd6t70e1oDMs4RC0Wr0rXLZ2/1xQsFgwgXle
         6QoPg23RF9ieq+6T2Y2/kH9G6wN+XL8YQ5VTUAAH/Nvn64xBnSSfG8IlF44tdLiqvd3t
         LFRXCwW2TBLwm7YrhL5e4TWEJ5KZfZZr8BqPPRln6RvRyqrrOX4ySTf8BQeveJoeMF5m
         txdTzoFg1jtVXgyVdViCdiVTlJH1RkKSBQXxtJA1ggDjI5FEQBXIw2jS6VSWTvfoQK+Q
         KDQaOnzsCrtBTqK+s0QrL3VXiP98Slk2OErObLsb+3vANg5dqZlG8bGNLmwd0mcItU+k
         mr0A==
X-Forwarded-Encrypted: i=1; AHgh+Rqhk00D0RRdBYQrODta5B8TEm2oZ3AhFng82oEkNtqZWic7L42ZoxJFDbzAZMSIjiv7tks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7YuxnE1H9DaiLdML5BL2RVPldF9Cz81hr7qg8IOtlZEcLWVU
	33G/4/xPvP41erNxb/DMid8vOeadUyg8BEy1xy/8ZPyv8HFpLkV1oJNdF/3kUYSujZCFG8xYIPf
	8mn+Q07vHkHgK9adPeT1VlYRsmamaga0=
X-Gm-Gg: AR+sD11LTgywNA5ZAwT0/kl3UCEt4BM3fx93rNWqDIpdQM3KIrMsMKBU5bFXg1gES6a
	fq1mtALKNErbdPWdmWcmjEkLD5TJP9GU0z9A4yu9Ult6lw54E2apNHStjCdn9RotEW545pVXjvf
	HUvzs8RNtn6FnGebvoTXGc3JOCcRLxZ0IuYFh9jW+M6bJHFRPTpCMnpfieRt1qC4VwmnsFb4jxe
	4PDQ9NEppdO0ic8yDDaI1xhnifZ6MAZy5icvgjBoTVUkwZ8tQNH/IyxpuFWU0bq2oXtMqwSq/ra
	E+A3bzKzrtgLpVUbTuiNbWlbaam/orkStpwCR/vCXTxiT9Agl3BhBdlQO1JzUixdFC0UrSGSiah
	VEZNOmml9QW93KlYA/EqHkpX97HaJn9yTcH2Vx3SDxWh2
X-Received: by 2002:a05:690e:2584:b0:668:a17:daed with SMTP id
 956f58d0204a3-66c54c49056mr818130d50.21.1786594604022; Wed, 12 Aug 2026
 21:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811235331.10044-1-kartikey406@gmail.com> <20260812000859.654FC1F00A3A@smtp.kernel.org>
 <anxMXBwCX0HCYgxr@krava>
In-Reply-To: <anxMXBwCX0HCYgxr@krava>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 13 Aug 2026 09:46:31 +0530
X-Gm-Features: AUfX_mwfqzym4wGlqOQexfSsnhGUEHmMvw1zBvwX7sKbdWrWjMFru5WvJUuewL8
Message-ID: <CADhLXY5QdvPjyK+X0q4S4wF71CTt-RQ76fHt_W=x-BmVka9LAQ@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix data race in __perf_event_overflow
To: Jiri Olsa <olsajiri@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 4:05=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Aug 12, 2026 at 12:08:58AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] Lockless TOCTOU race in perf_event_alloc() causes NULL pointer=
 dereference or Use-After-Free during BPF program inheritance.
> > - [Medium] Incomplete fix for data races and missing memory barriers in=
 BPF attach/detach paths.
> > - [Medium] Time-of-Check to Time-of-Use (TOCTOU) race drops valid perf =
events during concurrent BPF detach.
> > --
> >
> > --- Patch [1]: [PATCH] perf/bpf: Fix data race in __perf_event_overflow=
 ---
> > commit f63a2be5ceb79a2a8bb0263ba6723f7bf4ae763d
> > Author: Deepanshu Kartikey <kartikey406@gmail.com>
> >
> > perf/bpf: Fix data race in __perf_event_overflow
> >
> > This patch addresses a data race where __perf_event_overflow() concurre=
ntly
> > reads event->prog without lock protection while perf_event_detach_bpf_p=
rog()
> > writes it to NULL. It fixes the race by introducing READ_ONCE() and
> > WRITE_ONCE() in the respective read and write paths.
> >
> > Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D651d2774bd1d8395595f
> > Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through =
overflow machinery")
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> >
> > [ ... ]
> >
> > > @@ -10766,7 +10767,8 @@ static int __perf_event_overflow(struct perf_=
event *event,
> > >     if (event->attr.aux_pause)
> > >             perf_event_aux_pause(event->aux_event, true);
> > >
> > > -   if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> > > +   prog =3D READ_ONCE(event->prog);
> > > +   if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> > >         !bpf_overflow_handler(event, data, regs))
> > >             goto out;
> >
> > [Severity: Medium]
> > This isn't a bug introduced by this patch, but does the independent sec=
ond
> > read in bpf_overflow_handler() create a time-of-check to time-of-use ra=
ce?
> >
> > If a concurrent detach sets event->prog to NULL between the READ_ONCE()=
 here
> > in __perf_event_overflow() and the second READ_ONCE() inside
> > bpf_overflow_handler():
> >
> > bpf_overflow_handler() {
> >     prog =3D READ_ONCE(event->prog);
> >     if (prog) {
> >         ...
> >     }
> >     return 0;
> > }
> >
> > Wouldn't bpf_overflow_handler() evaluate prog as NULL and return 0? The
> > caller __perf_event_overflow() evaluates !0 as true and executes goto o=
ut,
> > which unconditionally drops the perf sample.
> >
> > Should the already-validated prog pointer be passed directly to
> > bpf_overflow_handler()?
>
> seems legit
>
> >
> >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_eve=
nt *event)
> > >
> > >  put:
> > >     prog =3D event->prog;
> > > -   event->prog =3D NULL;
> > > +   WRITE_ONCE(event->prog, NULL);
> > >
> > >  unlock:
> >
> > [Severity: Medium]
> > This is a pre-existing issue, but does this incomplete fix leave other =
data
> > races in the attach and detach paths?
> >
> > Other functions like perf_event_set_bpf_handler(),
> > perf_event_free_bpf_handler(), and perf_event_attach_bpf_prog() still
> > perform plain writes to event->prog without WRITE_ONCE().
>
> was wondering the same, the perf_event_detach_bpf_prog is called for
> tracing events (tracepoint/kprobe/uprobe) the perf event release goes
> through perf_event_free_bpf_handler, check perf_event_free_bpf_prog
>
> jirka
>
> >
> > Additionally, does this need release and acquire semantics? If the writ=
es to
> > event->prog and event->bpf_cookie in the attach paths are reordered by =
the
> > CPU, could the NMI handler read a valid event->prog but a stale or
> > uninitialized event->bpf_cookie?
> >
> > [Severity: High]
> > This is also a pre-existing issue, but does the lockless access in
> > perf_event_alloc() create a use-after-free or NULL pointer dereference
> > during BPF program inheritance?
> >
> > During fork, perf_event_alloc() inherits the BPF program:
> >
> > perf_event_alloc() {
> >     ...
> >     if (parent_event->prog) {
> >         struct bpf_prog *prog =3D parent_event->prog;
> >         bpf_prog_inc(prog);
> >         ...
> >     }
> > }
> >
> > Since this accesses parent_event->prog locklessly, can a concurrent
> > bpf_perf_link_release() clear the pointer? If the compiler reloads the
> > pointer after the check, bpf_prog_inc() would dereference NULL.
> >
> > Even if it is optimized to a single read, perf_event_alloc() is not ins=
ide
> > an RCU read-side critical section. Could a concurrent detach finish its=
 RCU
> > grace period and free the BPF program, causing bpf_prog_inc() to write =
to
> > freed memory?
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811235331.=
10044-1-kartikey406@gmail.com?part=3D1
> >


Thank you for the thorough review!

On the three issues raised:

[1] TOCTOU in bpf_overflow_handler():

You are correct. The second READ_ONCE() inside bpf_overflow_handler()
creates a TOCTOU race. If a concurrent detach sets event->prog to NULL
between the two reads, bpf_overflow_handler() returns 0, causing
__perf_event_overflow() to drop the perf sample via goto out.

I will fix this by passing the already-validated prog pointer directly
to bpf_overflow_handler() instead of having it re-read event->prog.

[2] Incomplete fix - other write paths:

Thanks Jirka for pointing out that perf_event_free_bpf_handler() is
used for handler-based events (tracepoint/kprobe/uprobe). You are
right that my fix is incomplete.

I will extend the fix to also add WRITE_ONCE() in:
- perf_event_free_bpf_handler()
- perf_event_set_bpf_handler()
- perf_event_attach_bpf_prog()

[3] Lockless access in perf_event_alloc() - UAF:

Agreed. The lockless access to parent_event->prog in
perf_event_alloc() during fork can lead to NULL pointer dereference or
use-after-free if a concurrent detach clears and frees the prog.

I will fix this by using READ_ONCE() to capture the pointer atomically
before the NULL check.

I will send a v2 patch addressing all three issues.

Thanks

Deepanshu
