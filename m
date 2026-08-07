Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8D314A73
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115657; cv=pass; b=kACmixBeJFpOuch2QxssATFO+9aSeIwroyB+k8Usrs70BXf/w/hkI6k+l/7jhkO7qnUcczgY7IrGm++bOXmI/fHIdIcWG0ODbeR/dfOUTzqKWG0KSNnhQPDLz23nBiwcgIaNVMYkEQHJUIKfzDtCS7cUbbOLlDdSCGXHcScdv8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115657; c=relaxed/simple;
	bh=cw2EjOpQbWdRgXTC2nBTmW8PZpemRbVY3jghsUYXriE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTIYesYBNyw8w64/iM4Ex65g7UE/wjL0Qcn6TeireYU3YditmF+R0OO303vVwUb59grZGxtdl9kBN3sFqF4aue89tpYm5CIKvvWAqU607oIsbHwoTj+CsL4cbSODNKfB9h9YTLqJTk+jrOsZsQRURKrJ7apVUkVeReI0UK95xhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr9QChzi; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr9QChzi"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso416105666b.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 08:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115652; cv=none;
        d=google.com; s=arc-20260327;
        b=EZpADEZSaG6WCwAdDJgwv9F6ViAoh5YayaHtvk5HZ9UmaPrRsc6kiAv9QdmArFj0al
         fkxYyRrq0itew+5yftNy11W2eiIGdYy5iRzgAyQDWaXrT2ggx8sQkX+I9OWGB4fIO7NM
         +9NjHKgWm4I7vsOlySgNEkm8Cq+eqvU2ahOIltG2IeOdO/kGdVBTGoBO9n/cr5CDXY7Q
         mB/otv+LpArm3nEf1ptwR+3gr3KmMZimGqpf6Dlnl9YR41B7Uv9P+tDvMPZr7DUGxvYu
         +KxxhTVNLVXTDulyejkndiErRoVR1MlGq3LdvqzMkKiZYrW1Ovu3CPZ+y+8cfVK73IfD
         GElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R5SqSs5AqefmAeE5V/Z3L3JqaBFSW0y3Aeu4U20RpPQ=;
        fh=Xio2jZnW215xtE44inGvGJ4veIv3a7oFw1sgAsUgEIM=;
        b=iQmtwtYQ204dF0IG0sf2t8U2Mb39dMncoWIeI2dp852aqXWdRdK3E7nPNdKqEJ8RjL
         V/xo02QxJzb1Hb+d4OmiACiveWvQp+qgqrH3UADQQMltByahxDfCumOJQxHeW+CrTj6D
         itjDHDujEvm+OI10VBQQavpIGBO3MrsLszLpR+Z4bNze1NNrGsq6IPp2ftK9KnbofL1X
         K89OwdN3aIog3GN6Wg7PD9rwcG7Ncd5iueU0HzNvIPOwlN2wi2BCZno7fZtAD4QR8yj6
         09zO3AE3cXMYVk+z5Sypk4c8N8//VTGcU0/faG9YKd8zMRNhDz7ETW7MB5NARu+qxeMC
         TXtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786115652; x=1786720452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R5SqSs5AqefmAeE5V/Z3L3JqaBFSW0y3Aeu4U20RpPQ=;
        b=Sr9QChziq9k8ivp5a/j51klbzCQ6i44YWv2sz53zqxgS6/P7wpgcsoAWLBZa5yzlhQ
         u2JS+fnXlJw6QSnXekQxyQIU/lFaxHJJknGrgHrrB0l+hgYnGVy0aEcmbZtFB2kxQsq3
         Lsr7XPnTutefUC3MfanzeAOJ44RllODvCGN3YOcLF4H46d/6JRVkIGQZTJ83PC9Xsxv+
         nE5nNxnDLpU92H/oygw67KR5r4cD9LI+aRlvbX/R/Ha/RwGHUBUzj5x0BSOJaEF4+aMi
         GANiGZ8x+G7efkOdkmJFEEKRoock+q0Mn/YYPQBgBRgNbzuiplNsjd7RJTn3rQy37RuX
         aRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786115652; x=1786720452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5SqSs5AqefmAeE5V/Z3L3JqaBFSW0y3Aeu4U20RpPQ=;
        b=FYsOctXOhSqvG+0bV9RXUGYz7BQYpwSNNJZ7Nka5Q0XBCec42mj7rXje/+aKWIsXUE
         qgRRDyI0mOkuC4/gXcZBx+tKp/yBbj5pQ+bO9k82fHw+9oZCAv1C2bkbMRXlT/OJPK93
         NM7gCtTzWZ731WLTa8Jn+Js4+6gZ3DY0OxIiWfbfyZ9qJoaoXqi4VEdEk1RN2IejTZCb
         V3zIJfHcT7WZmK7JBshaJaE/ckX0ah+GkVdcsn5bPiFA+Cao1+lh+T5KvQmwhbysluj1
         AZA0FoYLfDFrgaCN6yTqZiCdRmhuQj6rVKRV0SB/8S13awq3l4ahVeSrzwqd/NNeAVtd
         59NA==
X-Forwarded-Encrypted: i=1; AHgh+RrShny1G3BU9poovBP5siKptPlPMnCQlBuPJ6mU76aPhFtSW4puzKqGUW7qpfJ7w/TaoU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSe1tWrZWCIkxK4y7/V2gM2l+3uPR9EWLUvZ58x7nKkfL9BSn
	eMPY9ZmH3rRnD479mlKXqO2eqvc0TB9St/ASo70jepCwqm/ARr2yn9zATspDLCJUIEpm4H5YkpK
	l6bgR76xEzqJ54lC7yh46w+9J6ATegiA=
X-Gm-Gg: AR+sD134q3U2rr+axCwg1IH8CXhHU0TfIru54E4cLbaz4WDr2dIVAuLQNV9DXmX4y9k
	/3YJjwfnDpGvxNQ/le9ndSu/HKWPlAgnUDIsni6ACnJsBwzSWCKcXpZ6agbZETl5hIA1IoGViDk
	cdGD68OjDqmWRKRShIl3o+ny8ccHHRur7Ir3O9p8aesxsGMOtnPgsZyfO7ea43bN8daiFErwUlK
	8cdRoODgDxj++GkODAW5RwxNYgLuxjL8Knj9KDSCNfFKX+JtRfkQ9FV3thHpjOylwnRz4yXTnHY
	nBXBEb2wO6HB1fmLAECd0yZ0h9BnjZmeFV6BalTDAGMHQZ8RIAG8M+TWQdD2
X-Received: by 2002:a17:907:9286:b0:c1c:6f0d:5b22 with SMTP id
 a640c23a62f3a-c2039c873a2mr1180266066b.11.1786115652150; Fri, 07 Aug 2026
 08:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-3-puranjay@kernel.org>
 <20260807100828.GT776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807100828.GT776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 16:13:57 +0100
X-Gm-Features: AUfX_mxuITlV6KDGW3daEqhmTeXX9cWKEHeC3fVDfiCi88EOTq-NgZeWz2tSt1E
Message-ID: <CANk7y0gKtCV8ja3MNgqikxEMB4q494s62bCsB5S3xdu8Y4XyCg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] perf/core: Run sched_task() for PMUs with only
 CPU-wide events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:08=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:22AM -0700, Puranjay Mohan wrote:
> > perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
> > leaves the work to perf_ctx_sched_task_cb(). That one only walks
> > ctx->pmu_ctx_list, so a PMU whose events are all CPU-wide is never
> > visited and its sched_task() callback does not run. With
> >
> >   perf record -b -e cycles -a -- ls
> >
> > armv8pmu_sched_task() is skipped on every switch to a task that has a
> > perf event of its own, and BRBE records leak across the task boundary.
> > intel_pmu_lbr_add() calls perf_sched_cb_inc() unconditionally as well,
> > so LBR records leak the same way on x86.
> >
> > Drop the early return and instead skip the individual CPCs that
> > perf_ctx_sched_task_cb() already handles.
> >
> > That requires the two to agree on which CPC belongs to which path, and
> > they do not. perf_ctx_sched_task_cb() gates on cpc->sched_cb_usage,
> > which perf_sched_cb_inc() sets per CPU for every branch stack user,
> > while the new gate uses cpc->task_epc, which __link_epc() sets only on
> > the CPU the task context is scheduled in on. A task with an event for
> > that PMU pinned to another CPU has an epc on ctx->pmu_ctx_list while
> > cpc->task_epc is NULL, so both paths would run and sched_task() would b=
e
> > called twice per context switch. On x86 the second
> > __intel_pmu_lbr_restore() finds lbr_stack_state =3D=3D LBR_NONE and cal=
ls
> > intel_pmu_lbr_reset(), throwing away the callstack the first one
> > restored. So gate perf_ctx_sched_task_cb() on cpc->task_epc too.
> >
> > For the CPCs that perf_pmu_sched_task() now handles, the callback no
> > longer runs inside the perf_ctx_disable() and perf_ctx_enable() pair in
> > perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
> > around the call itself, so the callback still runs with it disabled.
> >
> > Fixes: bd2756811766 ("perf: Rewrite core context handling")
> > Cc: stable@vger.kernel.org
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/events/core.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 9815894b67e77..675dd05935f35 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3757,6 +3757,9 @@ static void perf_ctx_sched_task_cb(struct perf_ev=
ent_context *ctx,
> >       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> >               cpc =3D this_cpc(pmu_ctx->pmu);
> >
> > +             if (cpc->task_epc !=3D pmu_ctx)
> > +                     continue;
>
> Why isn't this the inverse condition of the below? That is, we should
> call either this or the other, right?

It should be. There's only one epc per PMU on ctx->pmu_ctx_list, so
!=3D pmu_ctx here is really just "task_epc isn't set", and once the extra
term below goes the two are inverses.

>
> > +
> >               if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
> >                       pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in)=
;
> >       }
> > @@ -3921,12 +3924,15 @@ static void perf_pmu_sched_task(struct task_str=
uct *prev,
> >       struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
> >       struct perf_cpu_pmu_context *cpc;
> >
> > -     /* cpuctx->task_ctx will be handled in perf_event_context_sched_i=
n/out */
> > -     if (prev =3D=3D next || cpuctx->task_ctx)
> > +     if (prev =3D=3D next)
> >               return;
> >
> > -     list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry)
> > +     list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_e=
ntry) {
> > +             if (cpuctx->task_ctx && cpc->task_epc)
>
> I'm not sure I see the need for the first part of that clause; why
> isn't: 'cpuc->task_epc' sufficient?

It is, task_epc can't be set without task_ctx. ctx_sched_in() sets
task_ctx first, ctx_sched_out() clears both, and the window in between
is under ctx->lock with IRQs off so the scheduler never lands in it.
That includes ctx_resched() scheduling out a single pmu, which leaves it
open the longest.

Will fix both in v7.

Thanks,
Puranjay
