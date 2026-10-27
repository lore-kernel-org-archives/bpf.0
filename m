Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123183;
	b=scspoRSKWTvnI9hTp+cbpw0D+hw8eaK6Y9VDa6r2xlLLQkEKLgeoFYGDUcGQIlVBLT/1
	 lXFGAoN0YW4wur6jAyLNrxfyH4pvrvEAdK728bBQV+WhPh4bOXPqBPFMWm7z7w07omxjG
	 4rTDsSHDuw6ISGydiMXfNNr9cGHtg4uUajXPnoYjnqxkdIlN5Xk1VtaSaXcpqYjbdiWqs
	 NZa+fA9wcZbGQgx0YRCs0TNS7Zq/z3xgZygjIzZGgvg/9b0j5YkEc6VukFPgSEiuT5BE6
	 krZU4z3J2F4Zu4F+kgrXahuf8bfbMBAS/vUbVCRes4AfOHtH3T7Any85PB9cHF5XisQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
	b=TO7tTHG7g8gg6n1taowSI93rF7HAc7beEyBisKT068XFzkZGYb4IEJPCRatYA7yjPVv2
	 Smc8i8PGT4plBanMbzfN4Jm6cPQCZAqgWvpjaxFfg96KX2BfrY8Zp/r0Upew2RcOj8dRa
	 4tmszOl0RKzRT090gufIymAyxrkjzZP0z3gT+6zCKLeCpiJ4fAPyHwCbI7urnXzFb/S+K
	 h9qKqypj8vKIgNTkkJ0uBzxHoQm/Dds+FFBibYzV9yl+1hYAmk8xvpa8drHbbZsoCqcS2
	 i+yg1AvGknyd4s6KXOcXgk1PbWwzmwS9t4Yxh9rn7z3wXXS269GJIiaIFqeISarUUmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dJZrWgbc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37655606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37655606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dJZrWgbc
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c423b145922so9772866b.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123181; cv=none;
        d=google.com; s=arc-20260327;
        b=Ct6HvIZV0rE+oXTNypv+5gTh1r2sQpAc9GR2+8vaksyCWEUFt9Ajol+DcDFIcL+O1x
         wnofmCkhMWfgYOuvaG1698FA2qLVxX+kRS/BEjqa1HbpdU13QnLgsUAiVXiaXXGl0YDi
         6ofYUl/5Jx7k7udxZRXYRJ1R09dkLyWYXjZFYX9OsW+GpmU0kyvRPw9cO29N9m0w15SD
         lw9SnVG3Cn/eba+mUINn6xb5mzwLikUeaUgETphqcx6uN0RYUYVdG+dweLWqqQV72xsn
         rAs/8zaUGxpHj98nAvuMcqYVlPpi+fgF/1YCsFr7krjK35lgJjr0k1z5S+mWbJeQkzL1
         G1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        fh=AUVVJwoEbijM0RcrmQjC/cW2frggjl3P6yiNndlEwrA=;
        b=G4KoyTSM1KL2t/ZMusgcwWo7jhOd5dbm8cQ1H+UKeXUspcgC9Lf/ZaSduDzu6tT188
         8n+0TTfJZSco6/MSKRTi/iLmaK1go1RMnuUgl5RpZUf2LKS+w2vkSiDXl7NDvLpofbcs
         zfhFWqzJmkLekY79IkMRLItPA/7R7fYkjIxt2UQRU92BK99r0HMGObGHgHrCyChfCyLA
         Eko8gWdTa6kX6HzAH2TRhAr5mJrbHbOU6vLbYNr97K7QSPUuhP7nDcRvtIzESBgQ58Y7
         +NOWANs8ZEub+Jom+X7KfrR5w2MfLrWiagtK6DX58bdH86SBhBNsYXEf6v3QGf42HxY6
         j4Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123181; x=1793727981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=dJZrWgbceCcvybGI6S+yBWHGKTnRTkeoo+QAXarbXhuJJrcuUxjX6DL3VJxyeJguO7
         EIXUQuToxD9Oj2ADRK5huhz3YAPfLd6CErpWQOPm8uk8bar6rE79bi3bMLs3pZe51bGu
         X4MzPetzpkt4sIfnqO30iZNgo0TbdVmPtmqopEkvLhUnsg2bhmTSLgRVVzhYHy701dNf
         Q0OtvKJRnZ80/E3NbSjyx0npRgDvtmNSPb01SZjgkwzglNyd+xHEbqih3MUFsYvHWiHM
         BQc/ZWywC5lvAnEYkPeZz4JTWFyCYlKLP3X73YxsX8/hg+Ad4REwmoFnONsNmbYY7MNG
         Lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123181; x=1793727981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=DFkbG3cq81GmWpx1gzBnirdxIXieMpDeXrhNQqkTRxlirF+CPpn7yxz2T9DuunoIi8
         jvyr+V+mqk6B+aN3BeoCPXkge8rA49D1K6toHV4N3ncG6NWrGF4W2hj7lTztG5S4WIwI
         qMn9fAvCRSgXErCj/D7rdwjvMU54dkNG5A59fLNRN4Y2ft4Pzpi0ujtLfmMoSZ9kS9F0
         Ur18d1T9v3d61d3qfMt9RZj8YK5qf9GfxEcND0coA7hrjPKZwaMcC0/oz2GF5v2NTc/B
         Ix/Tr9k7UvO9RB+kAFLEE6vlKAO0uPKppDxfQneDZ2Ywd/bt3hGqwR8tLFlg3HmLPY0d
         P5rQ==
X-Forwarded-Encrypted: i=1; AKwUvBwy4hz1ESkPeqk53mHJddXykmUIKfyTWW910aqFsxW6SJY+Y5NIMZwdHw7awSR6/xy7x3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYK72P4ePllMigFOqtJwUUHljveK0gvAWNi6xfkZEgKtis19r8ff
	Xi7uBJ4GE9SXixDVJAIx0dJqDBz3uhXFA+giVGkHuqZyeVDxYaBRNPc6hWlx4li4CkEjP3cMRBS
	z7WfglzXrrnDfKNk1ZHzdyNNiNgKOL9I7+csKZljW
X-Gm-Gg: AYBFou1SmePNfF0G0/tl709zN1nK/7VCQOgYQADrv14HKFVoA3JeQFh969rACsBonSz
	jbpj4IYkILvv4ULDsY5fDjU2E4Myap/0pCCB04LeWZlwUqynE79B6+FB86PclrRAfAypFwTLLoQ
	6/7gXuqHftqlReZeSECI+RmEdax+KdC35HpdH3fNRq+t3YOx/X+Yluty2clR+/z5MVbfqUF5vfP
	kBIJxd3hpTnwYtdpyl3prxNva1Hus2g4CVe6E4XrFlPGL0pwb8FCHKlR7kb9x8VypDiim5hL3MV
	Y0fWNAvPyMAiKvBzkDvME2MecshjcekSeTYeQh3zqHc4874ogLfvQa2mqz1fE5NWtP0csC841k4
	zHLsfLCrGj87+hCeAJ7qgeBIcmaaiT4z8FyN1gXnWjydzuphPTlhfegoW8Q02t+t/Eae9gFkhlT
	3222tOfd3X4o2r70a8Hws4PJ7iqNvet6bKIFxu2w8XjsfnSL9AkXF4T0/qrg72BkaVC5LK1VAXy
	Hbx+567zIasPxShobRgZ85Uqh7YiFejDA==
X-Received: by 2002:a17:907:7b9e:b0:c41:b94c:4538 with SMTP id
 a640c23a62f3a-c46bdec03f8mr1197886866b.47.1793123179946; Tue, 27 Oct 2026
 10:46:19 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-6-jthoughton@google.com> <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:45:43 -0700
X-Gm-Features: AclHuK-GDZyG6m8BFpUMWxfSIBXFJlvlZbCjTm5c1oLpEFzow0OEe9cdwDWWw7s
Message-ID: <CADrL8HXtBxf=qixBZV5-iz1sqfZAqSrMR4ZsJTFXS0N84G+nkw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/10] perf/core: Don't unwind the user stack without
 an mm
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 26, 2026 at 09:52:21PM +0000, James Houghton wrote:
> > get_perf_callchain() only checks is_user_task(current) when the regs it
> > is given aren't user mode regs. However, BPF's bpf_get_task_stack() (an=
d
> > bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called =
on
> > the current task, which are user mode regs for a user task, even if tha=
t
> > task has already gone through exit_mm(), e.g. when called from a progra=
m
> > attached to exit_files() or to the dying task's final sched_switch.
> >
> > perf_callchain_user() then unwinds the user stack without an mm. That
> > access does not reliably fail: the user half of the address space
> > belongs to whatever mm happens to be lazily loaded, if any, so the
> > unwinder may read another task's memory. This affects e.g. arm64,
> > riscv, loongarch and csky, whose perf_callchain_user() doesn't check
> > current->mm itself. perf events themselves are not affected, as
> > perf_callchain() already clears the user callchain request when
> > current is not a user task with an mm.
> >
> > Check is_user_task(current) regardless of the regs' mode.
> >
> > Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  kernel/events/callchain.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index 9d24b6e0c91f..a451ca2a5573 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -245,11 +245,15 @@ get_perf_callchain(struct pt_regs *regs, bool ker=
nel, bool user,
> >       }
> >
> >       if (user && !crosstask) {
> > -             if (!user_mode(regs)) {
> > -                     if (!is_user_task(current))
> > -                             goto exit_put;
> > +             /*
> > +              * Even if @regs are user mode regs, e.g. task_pt_regs(cu=
rrent)
> > +              * passed in by bpf_get_task_stack(), current may already=
 have
> > +              * gone through exit_mm().
> > +              */
> > +             if (!is_user_task(current))
> > +                     goto exit_put;
> > +             if (!user_mode(regs))
> >                       regs =3D task_pt_regs(current);
> > -             }
> >
> >               if (defer_cookie) {
> >                       /*
>
> We have perf_event_exit_task() before exit_mm().
>
> Still, it doesn't hurt to be cautious. So no real objection, but perhaps
> adjust the Changelog?

Right, perf events can't get here, since perf_event_exit_task() runs
before exit_mm() (and CPU-wide events go through perf_callchain()'s
is_user_task() check).

The case this fixes is BPF: bpf_get_task_stack() calls
get_perf_callchain() directly with task_pt_regs(current), so a program
attached to e.g. exit_files() or the task's final sched_switch would
unwind the user stack without an mm.

I've added this paragraph to the start of the changelog to make it a
little clearer that the perf event case isn't the interesting one:

  get_perf_callchain() only checks is_user_task(current) when the regs it
  is given aren't user mode regs. That's fine for perf events: a task's
  own events are torn down by perf_event_exit_task() before exit_mm(), and
  samples from CPU-wide events go through perf_callchain(), which already
  skips the user callchain if current isn't a user task with an mm.

Are you happy with that?

Thanks for the feedback. :)
