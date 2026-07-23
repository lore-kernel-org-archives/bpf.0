Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCC3F3283
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806721; cv=pass; b=s5jSo52oBWd75Ke5NG2ytRS55JV4v/Z+DYqmc2WqsOGZOM0JoVJkJhzS5Q7SxdkqeYpca3Jaun683nrQrbdphT22wZthGD8xS3UmoWLtoNZfab9Rrt78hjwtb5+Fi9JDpoXgrniLUOscg9v2IExN/yCaEArgoeDAelC2QZuRgZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806721; c=relaxed/simple;
	bh=SnHqdFWgUyEPNq9Oxt4pUkeCphttKY6rF9FgnM3DBVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kmkj/F/jGfIguJNTvAQpraA/8qcefN7KH8h24wD1WKpBJtKYnsqPSX1mB5Un9q0FPZ0caUiX6IBSQZmDS6wWKmM2+h0sYTBTzE9gKIauifnbl+QOk+GNNKvR8j0NLAHbJwNn2MkAb3ekyPnU1Ty4dCmo/0e4lQ7Ix99KJJYkC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDMTq8pc; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDMTq8pc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so861305a12.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 04:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784806716; cv=none;
        d=google.com; s=arc-20260327;
        b=laKRalQJ8gmVIU1kfdG2kbV9egKxYUec85Djsqxtb/xF/11J5Ncf4RjmCHZ7P1yoNM
         qt2S6NwGCGWtXsbG//ayUQVXr5zWFuO09P6mkqp5hYjlteJ9iiG7sM3z6MtH3mBkZa6C
         VcG//F8LLDktXi0czm49pPFnoCUJMDmcufQwXAB8h97lgJ9Y+oVJMtCNRdMNO1xg+okr
         RspaoMuZN+PG4ItJv36/2/9niGh5neqAl9s16Q0PU7CgEm/B7XG7mA/6sMH9Dsx1A5TI
         vdqHjMcZx0CMw74rZW0qnG+pvVxJR87Yaa4Htj+ztTRXeGWSLXRxdJqMMUrDK9xzcvBs
         CuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Vm/pUOpaksqwrAeLPB+SFjhRptlFPQ3mBtxFAX2gIE=;
        fh=efRVle/IurXFzyJOAC5NmK/7LxmvzVRJKsGTSglCYug=;
        b=p2a1pxNeFJLdaIrvqW9TNVjwe4YmBlCmA8AlkdfYUh+bEqrz+oYxWoHV6EpaNIBVQh
         VrwtYrIosGEeVUW0fhuSVfG8giTshP+JlLNeAnWkiBkKdm0Et7wlM/N4Txj8RLg1Oj30
         fIn9uUzetd7/gQaoKZeIeRpT2Dh702rwuZj2CuXZ+Wie7UjytgaZWTycq3FJF7NnnzFn
         lTPLmqnL3i/IPBotuEwRYUjsciK4EviIo6BY/IloFBugcY8p1B3bGILvO0RJVdb69+zV
         eLihG5Vxt27Id8nerrVuXwt6lCFwgxuxwY+X6F5WHWF9Ku0xKsyabkJi2ZiBhUPRVjAP
         Yl4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784806716; x=1785411516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Vm/pUOpaksqwrAeLPB+SFjhRptlFPQ3mBtxFAX2gIE=;
        b=RDMTq8pcFycEqomilfiE8N9mjdk4/v/R+22XYdKCnU51p84dKnsuU5jXcfFS6maKDV
         FVCjZn/6sroD5YpqBA/AaTwPkL5UqvFcwRtMMsmCYO9iMoJTHy1d9FozD8Q7CWkj07P8
         4SfLkS0+/bJDV3YRocpHvR7C86z+pHLK/8/J1nn0Lw8PgXBOV1VUhdymD/xYbYrm2lFm
         m82dBSb2FyPBB+SMhldytHCztdNIhNXTkDK5hbmUDuX/dneaJd3Xt9C664GSfznjaUvy
         rHsLYOrqOWdOkaa3o/S4AFtOAqvcS6u+kxaErNONtIFdfyp5GH8A6EjUC5JFGoNdNAfx
         +a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784806716; x=1785411516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Vm/pUOpaksqwrAeLPB+SFjhRptlFPQ3mBtxFAX2gIE=;
        b=Y0Ww91CQCi8qlt1aiN24gpNM5gscunQwrflmhmmfK2dAiJQk9W6XVz/vhctMV3Aku1
         ydFYkkOGZSsSqbFoUHgbxMNH2adqh61TWKWtdVWzmaqXc0Ag1Z/Fa7ao0HWGvOlFLnLI
         11ExACuN3sQVTQVmpVbFRUBVxhaAXoIAHFGTUepfo4uhr8k6ofbCCvWbfFAxyzzE+WqC
         hqg/8sjZ8hE4OI93lY9MpfkTV6U6dB0VyQ5uS96rWFBHhlkjeo6DGyuzRkENXYWjQ+7g
         byuYugy6qfYI2JuYqdM8w7p4bx8j+XWpPPm5OrXsvCCJlxLBZX5BKlmiWL7cfVokoPMy
         XClw==
X-Gm-Message-State: AOJu0YxV19fmT7F4WRWApGXAA27ogkZmicshUsbtAcS9grKwaHHvEJfL
	OmHAhttU/BxiXiT7CN7LpINVlt5cZSD/5ATgS0kZ4edYZZ8kr7ytLV9FfrMRjembjbIS6TMG1OR
	WN9L7/BPmo4rkgQHes0xp2ALZTafLBmfSvaSpjJc=
X-Gm-Gg: AR+sD10j+5oIh/5P3fMMW1l5pxS/ROdzFKTMDxiKwJW0jPDuSoxiFaiKeGiinB+rDDp
	9972VlWzcxcB6eA09ZYdOIa2h8G7rQ2EHz+Z/oNDD3zTTq0wa/mPg6cEqyF2Q9dtpV/7vTsv251
	sv9kOcMalo4/Hey0gVorA59O7/kX75IvMBltcu1unl2f9oXs2B+YWHs8uNe+wSkzGd+jSuy+YiM
	NCt0R4WTmXaeZbH8lM1T/FpjM4SMsGRWS2UX1hV5/FyXSCc4piZQ/gh47KdoHe/DHFyQVb5Yd3m
	hg==
X-Received: by 2002:a17:907:7b97:b0:c12:34f0:f7b9 with SMTP id
 a640c23a62f3a-c1c509e5e46mr148807066b.56.1784806715357; Thu, 23 Jul 2026
 04:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <CANk7y0j0j9GH7GpN6ahjiUwab_884csZcecrVsfBHupUANMgNw@mail.gmail.com>
In-Reply-To: <CANk7y0j0j9GH7GpN6ahjiUwab_884csZcecrVsfBHupUANMgNw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 23 Jul 2026 12:38:21 +0100
X-Gm-Features: AUfX_myZif7IV3J6fY3GEVJfNHdIvEqNpLWP5QqsObegWnRGod8mf5TyRQGbYSc
Message-ID: <CANk7y0jv7dYpmts0RpoZT305rXvFQicfEXRsJ4f2_PR2Y4WYxA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: bpf@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping for this.

I have been waiting for feedback for 7 months now. Please let me know
how I can make this patchset better.

Thanks,
Puranjay

On Wed, Jul 15, 2026 at 2:24=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi Mark and Will,
>
> Could you please have a look at this patchset when you get a chance?
>
> It has been reviewed by Rob.
>
> Thanks,
> Puranjay
>
> On Tue, Jun 16, 2026 at 4:57=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Changelog:
> >
> > v4: https://lore.kernel.org/all/20260527121207.2312181-1-puranjay@kerne=
l.org/
> > Changes in v5:
> > - Rework patch 2: drop the UAPI union. Instead rename the helper to per=
f_clear_branch_entry() and
> >   clear the entry with a single
> >         *br =3D (struct perf_branch_entry){ }.
> >   This stays kernel-internal, with no changes to the uapi/ or tools/ he=
aders (James Clark).
> > - Add an isb() to the BRBCR_EL1 =3D=3D 0 early-exit in the snapshot, fo=
r consistency with the other
> >   two exit paths (bpf-ci).
> > - Add Rob Herring's Reviewed-by to patch 3
> >
> > v3: https://lore.kernel.org/all/20260413185740.3286146-1-puranjay@kerne=
l.org/
> > Changes in v4:
> > - Fix leaking branch records when scheduled task has an unrelated perf =
event (Sashiko)
> > - Update tools/include/uapi/linux/perf_event.h as well for patch 2
> > - Introduce cpu_has_brbe() and use it in
> >   arm_brbe_snapshot_branch_stack(0 to make sure we don't run on a CPU
> >   without BRBE.
> > - Add explicit isb() after after writing to SYS_BRBFCR_EL1.
> > - Rebase on latest arm64 tree.
> >
> > v2: https://lore.kernel.org/all/20260318171706.2840512-1-puranjay@kerne=
l.org/
> > Changes in v3:
> > - Move NULL pmu_ctx fix from arm_pmuv3.c to perf core (Leo Yan)
> > - Use union to clear branch entry bitfields instead of per-field
> >   zeroing (Leo Yan)
> > - Remove per-CPU brbe_active flag; check BRBCR_EL1 =3D=3D 0 instead (Ro=
b
> >   Herring)
> > - Remove redundant valid_brbidr() check in snapshot path (Rob Herring)
> > - Introduce for_each_brbe_entry() iterator to deduplicate bank
> >   iteration (Rob Herring)
> > - Include perf core maintainers (Leo Yan, Rob Herring)
> >
> > v1: https://lore.kernel.org/all/20260313180352.3800358-1-puranjay@kerne=
l.org/
> > Changes in v2:
> > - Rebased on arm64/for-next/core
> > - Add per-CPU brbe_active flag to guard against UNDEFINED sysreg access
> >   on non-BRBE CPUs in heterogeneous big.LITTLE systems.
> > - Fix pre-existing bug in perf_clear_branch_entry_bitfields() that miss=
ed
> >   zeroing new_type and priv bitfields, added as a separate patch with
> >   Fixes tags (new patch 2).
> > - Use architecture-specific selftest threshold (#if defined(__aarch64__=
))
> >   instead of raising the global threshold, to preserve x86 regression
> >   detection.
> >
> > RFC: https://lore.kernel.org/all/20260102214043.1410242-1-puranjay@kern=
el.org/
> > Changes from RFC:
> >  - Fix pre-existing NULL pointer dereference in armv8pmu_sched_task()
> >    found by Leo Yan during testing (patch 1)
> >  - Pause BRBE before local_daif_save() to avoid branch pollution from
> >    trace_hardirqs_off()
> >  - Use local_daif_save() to prevent pNMI race from counter overflow
> >    (Mark Rutland)
> >  - Reuse perf_entry_from_brbe_regset() instead of duplicating register
> >    read logic, by making it accept NULL event (Mark Rutland)
> >  - Invalidate BRBE after reading to maintain record contiguity for
> >    other consumers (Mark Rutland)
> >  - Adjust selftest wasted_entries threshold for ARM64 (patch 3)
> >  - Tested on ARM FVP with BRBE enabled
> >
> > This series enables the bpf_get_branch_snapshot() BPF helper on ARM64
> > by implementing the perf_snapshot_branch_stack static call for ARM's
> > Branch Record Buffer Extension (BRBE).
> >
> > bpf_get_branch_snapshot() [1] allows BPF programs to capture hardware
> > branch records on-demand from any BPF tracing context. This was
> > previously only available on x86 (Intel LBR) since v5.16. With BRBE
> > available on ARMv9, this series closes the gap for ARM64.
> >
> > Usage model
> > -----------
> >
> > The helper works in conjunction with perf events. The userspace
> > component of the BPF application opens a perf event with
> > PERF_SAMPLE_BRANCH_STACK on each CPU, which configures the hardware
> > to continuously record branches into BRBE (on ARM64) or LBR (on x86).
> > A BPF program attached to a tracepoint, kprobe, or fentry hook can
> > then call bpf_get_branch_snapshot() to snapshot the branch buffer at
> > any point. Without an active perf event, BRBE is not recording and
> > the buffer is empty.
> >
> > On-demand branch snapshots from BPF are useful for diagnosing which
> > specific code path was taken inside a function. Stack traces only show
> > function boundaries, but branch records reveal the exact sequence of
> > jumps, calls, and returns within a function -- making it possible to
> > identify which specific error check triggered a failure, or which
> > callback implementation was invoked through a function pointer.
> >
> > For example, retsnoop [2] is a BPF-based tool for non-intrusive
> > mass-tracing of kernel internals. Its LBR mode (--lbr) creates per-CPU
> > perf events with PERF_SAMPLE_BRANCH_STACK and then uses
> > bpf_get_branch_snapshot() in its fentry/fexit BPF programs to capture
> > branch records whenever a traced function returns an error.
> >
> > Consider debugging a bpf() syscall that returns -EINVAL when creating
> > a BPF map with invalid parameters. Running retsnoop on an ARM64 FVP
> > with BRBE to trace the bpf() syscall and array_map_alloc_check():
> >
> >   $ retsnoop -e '*sys_bpf' -a 'array_map_alloc_check' --lbr=3Dany \
> >              -F -k vmlinux --debug full-lbr
> >   $ simfail bpf-bad-map-max-entries-array  # in another terminal
> >
> > Output of retsnoop:
> >
> >   --- fentry BPF program (entries #63-#17) ---
> >
> >   [#63-#59] __htab_map_lookup_elem: hash table walk with memcmp        =
(hashtab.c)
> >   [#58] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xc850           =
(hashtab.c:750)
> >   [#57-#55] ... dump_bpf_prog internal branches ...
> >   [#54] dump_bpf_prog+0xcab8        -> bpf_get_current_pid_tgid+0x0    =
(helpers.c:225)
> >   [#53] bpf_get_current_pid_tgid+0x1c -> dump_bpf_prog+0xcabc          =
(helpers.c:225)
> >   [#52-#51] ... dump_bpf_prog -> __htab_map_lookup_elem ...
> >   [#50-#47] __htab_map_lookup_elem: htab_map_hash (jhash2), select_buck=
et
> >   [#46-#42] lookup_nulls_elem_raw: hash chain walk with memcmp         =
(hashtab.c:717)
> >   [#41] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xcaf8           =
(hashtab.c:750)
> >   [#40-#37] ... dump_bpf_prog -> bpf_ktime_get_ns ...
> >   [#36] bpf_ktime_get_ns+0x10       -> ktime_get_mono_fast_ns+0x0      =
(helpers.c:178)
> >   [#35-#32] ktime_get_mono_fast_ns: tk_clock_read -> arch_counter_get_c=
ntpct
> >   [#31] ktime_get_mono_fast_ns+0x9c -> bpf_ktime_get_ns+0x14           =
(timekeeping.c:493)
> >   [#30] bpf_ktime_get_ns+0x18       -> dump_bpf_prog+0xcd50            =
(helpers.c:178)
> >   [#29-#25] ... dump_bpf_prog internal branches ...
> >   [#24] dump_bpf_prog+0x11b28       -> __bpf_prog_exit_recur+0x0       =
(trampoline.c:1190)
> >   [#23-#17] __bpf_prog_exit_recur: rcu_read_unlock, migrate_enable     =
(trampoline.c:1195)
> >
> >   --- array_map_alloc_check (entries #16-#12) ---
> >
> >   [#16] dump_bpf_prog+0x11b38       -> array_map_alloc_check+0x8       =
(arraymap.c:55)
> >   [#15] array_map_alloc_check+0x18  -> array_map_alloc_check+0xb8      =
(arraymap.c:56)
> >         . bpf_map_attr_numa_node       . bpf_map_attr_numa_node
> >   [#14] array_map_alloc_check+0xbc  -> array_map_alloc_check+0x20      =
(arraymap.c:59)
> >         . bpf_map_attr_numa_node
> >   [#13] array_map_alloc_check+0x24  -> array_map_alloc_check+0x94      =
(arraymap.c:64)
> >   [#12] array_map_alloc_check+0x98  -> dump_bpf_prog+0x11b3c           =
(arraymap.c:82)
> >
> >   --- fexit trampoline overhead (entries #11-#00) ---
> >
> >   [#11] dump_bpf_prog+0x11b5c       -> __bpf_prog_enter_recur+0x0      =
(trampoline.c:1145)
> >   [#10-#03] __bpf_prog_enter_recur: rcu_read_lock, migrate_disable     =
(trampoline.c:1146)
> >   [#02] __bpf_prog_enter_recur+0x114 -> dump_bpf_prog+0x11b60          =
(trampoline.c:1157)
> >   [#01] dump_bpf_prog+0x11b6c       -> dump_bpf_prog+0xd230
> >   [#00] dump_bpf_prog+0xd340        -> arm_brbe_snapshot_branch_stack+0=
x0 (arm_brbe.c:814)
> >
> >                    el0t_64_sync+0x168
> >                    el0t_64_sync_handler+0x98
> >                    el0_svc+0x28
> >                    do_el0_svc+0x4c
> >                    invoke_syscall.constprop.0+0x54
> >     373us [-EINVAL] __arm64_sys_bpf+0x8
> >                     __sys_bpf+0x87c
> >                     map_create+0x120
> >      95us [-EINVAL] array_map_alloc_check+0x8
> >
> > The FVP's BRBE buffer has 64 entries (BRBE supports 8, 16, 32, or
> > 64). Of these, entries #63-#17 (47) are consumed by the fentry BPF
> > trampoline that ran before the function, and entries #11-#00 (12)
> > are consumed by the fexit trampoline that runs after. Entry #00
> > shows the very last branch recorded before BRBE is paused: the call
> > into arm_brbe_snapshot_branch_stack().
> >
> > The 5 useful entries (#16-#12) show the exact path taken inside
> > array_map_alloc_check(). Record #14 shows a jump from line 56
> > (bpf_map_attr_numa_node) to line 59 (the if-condition), and #13
> > shows an immediate jump from line 59 (attr->max_entries =3D=3D 0) to
> > line 64 (return -EINVAL), skipping lines 60-63. This pinpoints
> > max_entries=3D=3D0 as the cause -- a diagnosis impossible with stack
> > traces alone.
> >
> > [1] 856c02dbce4f ("bpf: Introduce helper bpf_get_branch_snapshot")
> > [2] https://github.com/anakryiko/retsnoop
> >
> > Puranjay Mohan (4):
> >   perf/core: Fix sched_task callbacks for CPU-wide branch stack events
> >   perf/core: Clear the whole branch entry in perf_clear_branch_entry()
> >   perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
> >   selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
> >
> >  arch/x86/events/amd/brs.c                     |   2 +-
> >  arch/x86/events/amd/lbr.c                     |   2 +-
> >  arch/x86/events/intel/lbr.c                   |   6 +-
> >  drivers/perf/arm_brbe.c                       | 130 +++++++++++++++---
> >  drivers/perf/arm_brbe.h                       |   9 ++
> >  drivers/perf/arm_pmuv3.c                      |   5 +-
> >  include/linux/perf_event.h                    |  16 +--
> >  kernel/events/core.c                          |  17 ++-
> >  .../bpf/prog_tests/get_branch_snapshot.c      |  13 +-
> >  9 files changed, 150 insertions(+), 50 deletions(-)
> >
> >
> > base-commit: 61c19a9feb1d87156e46e38d7759f3ad23710e24
> > --
> > 2.53.0-Meta
> >
