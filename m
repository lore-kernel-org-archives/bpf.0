Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8E25776
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515450; cv=pass; b=GzU1eo0pVHcY30CIpi3ErMYslpKIVay13R/VxFWIKOJtVKO3naHwfiz0pkJYfLW+QdCRXprPGwiMlR1h3ryvfBfSd3GOPUwJMsfaeiW23GyGP3cqbcFbZAVM2mcjEhq0GtDj4sJrP+D+rRxNiXtH/4h+fJRsxKdZ5B/m2xKvBH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515450; c=relaxed/simple;
	bh=ptT2d5P9SeLna8e97nY4yBzJRQ9RCTJWUVNhB1VfGvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPeCfI2/R27c2yGPxBxRkg8q4GLQy1QP4vf1F5akUG18NaVrt75NlvA7+Sd211eE1ebSW/LEoVomcKeJdI6mhv66o2GFEt4sUT4KiYgLxKBGUXaULDk76m1zpY8mhF6cavI5mkfF2tTfefaBYL03Zy6k1FeakzObe6Cw8gewsjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ1Qh7EZ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ1Qh7EZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so897356a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 01:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774515446; cv=none;
        d=google.com; s=arc-20240605;
        b=ANGEME9JsnA8FtujZza0Iq7hDeiUOX4uuWP06LBc40GBI+g59vjtjaGNBDqT2g0Yzv
         wdJMQaBdQe+yv7k6Pjy6+KNrcXh9s9Gl8epYTax537I3kQ/RJBkKFt/nJiXXWCGGAEsN
         oEwdNKkb0L5c2Jv0wgBifeRlb54MSnpYPxtp1k3mzq/nF1xhJz1EMpp/GLxnN/ZRsh4r
         1TpHaCxruST+N+lK4wDAKBkgrWU8kY/HOCyvEwr9iGLUS1+j9HPBRQBrV1oD5c3Y+RJv
         ZecUhW1oQPQV8QZM8ZFgTOVYBE5UxyppapliqRgErP1X/ivFtfCCzX+Ot4kGGkNQJod1
         DvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WSjnQNvspGmmDZsOu+XUcYNWj5wosTqN8XrzdpzoIi0=;
        fh=Nyvt+ap/t8jxwzo1/engiKLtaR4Mf1m7Om77UJJ7o0o=;
        b=hxJOcirg0Wreo2NW9Z2RIRStG0RoV3tJbfhLau/5w2/vKsgweDZEnMCveC/JoQpZr4
         /LYQl1Sa8jzT8ZVwwbIWbkKSFT21KtmEj3Hr06Temhy2zgevWjLY3jZZkTFbKGJDqkS8
         LSCL09Ko2J3u8p9hJQ0+6TDBwzLp/I0KyTbRHrN/8cZN0ctgwiWx7lQL5JvfO3/nsNCf
         ocHS1XCGKcv/fbivsOKtKcWbDCpq+Cwvwb72M9Y4acpqE6Lfw9AytPVk7oClMJXr+A3K
         iKXOnpfakfkQUiIibCb2rOz9FlzHBTtEJ19aE4kAXprzmzFzlyZ60ht8LuWYZ73Fl8Ru
         wncw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774515446; x=1775120246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSjnQNvspGmmDZsOu+XUcYNWj5wosTqN8XrzdpzoIi0=;
        b=QQ1Qh7EZ/2vnZIPDRRNLIcBDg48OnpnZsStMd4CG1Wx0Sf/BgtixhblD6D84BKmal+
         HUNZ517dAQ6IMEyjv84gyq6n8QLwZxNCiNx9NLBgac6Fbb2Z79cpVq4ISUHjzsim7XO5
         5cPtTxPEzCeMCj8H7KLs/zRnMtNbmVUssL5730Bf1rQfj/IoSwRqQiWF0VS6BJwpAsMa
         gGPoaGCumOTixuNHUFoAnhStC6b6eitvylc3sLXsdAvA2RGvQBUBuM6UXuSsipY2WTyJ
         qoECLRB09z7LMUvQMKz26dXYXC0DG4alsLSZK3uZtGL1IR1O36WXX1hQ4gcSUenaEAbj
         dxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515446; x=1775120246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSjnQNvspGmmDZsOu+XUcYNWj5wosTqN8XrzdpzoIi0=;
        b=A5e8xnF4F6sZF6d9JLOXjcLCTmiPtd1LTr//Y0ooaIfGK7XTwPGX/3dpHj9TJaeLu/
         XxhX8eR28gqAdR7QA1m11KxREZof2ErCoV67TNupyqPWkg/q7jSE6rseBAQ/wyvsX8CP
         sDXS6qVmFMGpo5qeZYm09MNRkbmrH2ct3EOefB/yDmJ/nD66sc4iGA2tVCB5e8yFXd/T
         yz7lQNpbQCqvvs6dJTWxYma0CbeawGMbhE0SibyxeH9YTA40LnwIJVMloZNYBMCEJ/rz
         lY9M2h0jxmVGjjpb38LS8hhNM7JnYZai/wOdOtURPIPhfVc6J/ExNbK4VPPf/z0OCU8l
         wOEQ==
X-Gm-Message-State: AOJu0YyPi4BUJ0gpz2grAQRfcT5scGzq6pMrVNiB/of5vy7zRz9N1OhW
	9vf4FU9beZkNqgiRLIkPxrm/Cj475eoZHfOj7a82BQQFubP30Pq4gB2Kv3R/ek4NxK0pTaOsV+/
	Bcq/lTuzojsMisFngzMjn1LB0dCGXM9ahQiUqtbUjfw==
X-Gm-Gg: ATEYQzwUkRMPnFjUks6DPAyM2exqTqN3xCXiSGF06/w6wo3AwGkbSkPsbQJ/zoZfU0P
	ytVXU3YVuZBz3XRRGTstFMcZCu8UEkoPxZNkvseHnAnWcGvIX2AE+tn0vIUSf6JHvsfjfmfblxa
	gr/ixET1lCy9HSNd3321wTMYDxMGeYpEXuwDwSS3UcQxuQj6FPBsvXZrELSX1mAard9lvPI+ZEU
	+UH+B4alomO6F9oj3yMrDom49tDea2a0Ktpt2BxbkAmBczqa6KpSuloUarrSCc5sMJA/Xxo0zg4
	Pa/pn7Kp3Umg+gC9U1IQKNI=
X-Received: by 2002:a05:6402:27d4:b0:665:5e1b:de04 with SMTP id
 4fb4d7f45d1cf-66a82622630mr4696822a12.8.1774515445904; Thu, 26 Mar 2026
 01:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171706.2840512-1-puranjay@kernel.org>
In-Reply-To: <20260318171706.2840512-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 08:57:14 +0000
X-Gm-Features: AQROBzB7QhJ548_kCWv2yOw_2QglR5rh_u7vEtjQXGJvuYjl-MbQL5_xSVj3SE8
Message-ID: <CANk7y0jnY-V7Hv912gwc45jSx2UqLw5PBcdOdoFfS175bNuDmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: bpf@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leo Yan <leo.yan@arm.com>, 
	Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, Mark, and Will,

Would you mind taking a look at this patchset when you have a chance?

Thanks,
Puranjay

On Wed, Mar 18, 2026 at 5:17=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> v1: https://lore.kernel.org/all/20260313180352.3800358-1-puranjay@kernel.=
org/
> Changes in v2:
> - Rebased on arm64/for-next/core
> - Add per-CPU brbe_active flag to guard against UNDEFINED sysreg access
>   on non-BRBE CPUs in heterogeneous big.LITTLE systems.
> - Fix pre-existing bug in perf_clear_branch_entry_bitfields() that missed
>   zeroing new_type and priv bitfields, added as a separate patch with
>   Fixes tags (new patch 2).
> - Use architecture-specific selftest threshold (#if defined(__aarch64__))
>   instead of raising the global threshold, to preserve x86 regression
>   detection.
>
> RFC: https://lore.kernel.org/all/20260102214043.1410242-1-puranjay@kernel=
.org/
> Changes from RFC:
>  - Fix pre-existing NULL pointer dereference in armv8pmu_sched_task()
>    found by Leo Yan during testing (patch 1)
>  - Pause BRBE before local_daif_save() to avoid branch pollution from
>    trace_hardirqs_off()
>  - Use local_daif_save() to prevent pNMI race from counter overflow
>    (Mark Rutland)
>  - Reuse perf_entry_from_brbe_regset() instead of duplicating register
>    read logic, by making it accept NULL event (Mark Rutland)
>  - Invalidate BRBE after reading to maintain record contiguity for
>    other consumers (Mark Rutland)
>  - Adjust selftest wasted_entries threshold for ARM64 (patch 3)
>  - Tested on ARM FVP with BRBE enabled
>
> This series enables the bpf_get_branch_snapshot() BPF helper on ARM64
> by implementing the perf_snapshot_branch_stack static call for ARM's
> Branch Record Buffer Extension (BRBE).
>
> bpf_get_branch_snapshot() [1] allows BPF programs to capture hardware
> branch records on-demand from any BPF tracing context. This was
> previously only available on x86 (Intel LBR) since v5.16. With BRBE
> available on ARMv9, this series closes the gap for ARM64.
>
> Usage model
> -----------
>
> The helper works in conjunction with perf events. The userspace
> component of the BPF application opens a perf event with
> PERF_SAMPLE_BRANCH_STACK on each CPU, which configures the hardware
> to continuously record branches into BRBE (on ARM64) or LBR (on x86).
> A BPF program attached to a tracepoint, kprobe, or fentry hook can
> then call bpf_get_branch_snapshot() to snapshot the branch buffer at
> any point. Without an active perf event, BRBE is not recording and
> the buffer is empty.
>
> On-demand branch snapshots from BPF are useful for diagnosing which
> specific code path was taken inside a function. Stack traces only show
> function boundaries, but branch records reveal the exact sequence of
> jumps, calls, and returns within a function -- making it possible to
> identify which specific error check triggered a failure, or which
> callback implementation was invoked through a function pointer.
>
> For example, retsnoop [2] is a BPF-based tool for non-intrusive
> mass-tracing of kernel internals. Its LBR mode (--lbr) creates per-CPU
> perf events with PERF_SAMPLE_BRANCH_STACK and then uses
> bpf_get_branch_snapshot() in its fentry/fexit BPF programs to capture
> branch records whenever a traced function returns an error.
>
> Consider debugging a bpf() syscall that returns -EINVAL when creating
> a BPF map with invalid parameters. Running retsnoop on an ARM64 FVP
> with BRBE to trace the bpf() syscall and array_map_alloc_check():
>
>   $ retsnoop -e '*sys_bpf' -a 'array_map_alloc_check' --lbr=3Dany \
>              -F -k vmlinux --debug full-lbr
>   $ simfail bpf-bad-map-max-entries-array  # in another terminal
>
> Output of retsnoop:
>
>   --- fentry BPF program (entries #63-#17) ---
>
>   [#63-#59] __htab_map_lookup_elem: hash table walk with memcmp        (h=
ashtab.c)
>   [#58] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xc850           (h=
ashtab.c:750)
>   [#57-#55] ... dump_bpf_prog internal branches ...
>   [#54] dump_bpf_prog+0xcab8        -> bpf_get_current_pid_tgid+0x0    (h=
elpers.c:225)
>   [#53] bpf_get_current_pid_tgid+0x1c -> dump_bpf_prog+0xcabc          (h=
elpers.c:225)
>   [#52-#51] ... dump_bpf_prog -> __htab_map_lookup_elem ...
>   [#50-#47] __htab_map_lookup_elem: htab_map_hash (jhash2), select_bucket
>   [#46-#42] lookup_nulls_elem_raw: hash chain walk with memcmp         (h=
ashtab.c:717)
>   [#41] __htab_map_lookup_elem+0x98  -> dump_bpf_prog+0xcaf8           (h=
ashtab.c:750)
>   [#40-#37] ... dump_bpf_prog -> bpf_ktime_get_ns ...
>   [#36] bpf_ktime_get_ns+0x10       -> ktime_get_mono_fast_ns+0x0      (h=
elpers.c:178)
>   [#35-#32] ktime_get_mono_fast_ns: tk_clock_read -> arch_counter_get_cnt=
pct
>   [#31] ktime_get_mono_fast_ns+0x9c -> bpf_ktime_get_ns+0x14           (t=
imekeeping.c:493)
>   [#30] bpf_ktime_get_ns+0x18       -> dump_bpf_prog+0xcd50            (h=
elpers.c:178)
>   [#29-#25] ... dump_bpf_prog internal branches ...
>   [#24] dump_bpf_prog+0x11b28       -> __bpf_prog_exit_recur+0x0       (t=
rampoline.c:1190)
>   [#23-#17] __bpf_prog_exit_recur: rcu_read_unlock, migrate_enable     (t=
rampoline.c:1195)
>
>   --- array_map_alloc_check (entries #16-#12) ---
>
>   [#16] dump_bpf_prog+0x11b38       -> array_map_alloc_check+0x8       (a=
rraymap.c:55)
>   [#15] array_map_alloc_check+0x18  -> array_map_alloc_check+0xb8      (a=
rraymap.c:56)
>         . bpf_map_attr_numa_node       . bpf_map_attr_numa_node
>   [#14] array_map_alloc_check+0xbc  -> array_map_alloc_check+0x20      (a=
rraymap.c:59)
>         . bpf_map_attr_numa_node
>   [#13] array_map_alloc_check+0x24  -> array_map_alloc_check+0x94      (a=
rraymap.c:64)
>   [#12] array_map_alloc_check+0x98  -> dump_bpf_prog+0x11b3c           (a=
rraymap.c:82)
>
>   --- fexit trampoline overhead (entries #11-#00) ---
>
>   [#11] dump_bpf_prog+0x11b5c       -> __bpf_prog_enter_recur+0x0      (t=
rampoline.c:1145)
>   [#10-#03] __bpf_prog_enter_recur: rcu_read_lock, migrate_disable     (t=
rampoline.c:1146)
>   [#02] __bpf_prog_enter_recur+0x114 -> dump_bpf_prog+0x11b60          (t=
rampoline.c:1157)
>   [#01] dump_bpf_prog+0x11b6c       -> dump_bpf_prog+0xd230
>   [#00] dump_bpf_prog+0xd340        -> arm_brbe_snapshot_branch_stack+0x0=
 (arm_brbe.c:814)
>
>                    el0t_64_sync+0x168
>                    el0t_64_sync_handler+0x98
>                    el0_svc+0x28
>                    do_el0_svc+0x4c
>                    invoke_syscall.constprop.0+0x54
>     373us [-EINVAL] __arm64_sys_bpf+0x8
>                     __sys_bpf+0x87c
>                     map_create+0x120
>      95us [-EINVAL] array_map_alloc_check+0x8
>
> The FVP's BRBE buffer has 64 entries (BRBE supports 8, 16, 32, or
> 64). Of these, entries #63-#17 (47) are consumed by the fentry BPF
> trampoline that ran before the function, and entries #11-#00 (12)
> are consumed by the fexit trampoline that runs after. Entry #00
> shows the very last branch recorded before BRBE is paused: the call
> into arm_brbe_snapshot_branch_stack().
>
> The 5 useful entries (#16-#12) show the exact path taken inside
> array_map_alloc_check(). Record #14 shows a jump from line 56
> (bpf_map_attr_numa_node) to line 59 (the if-condition), and #13
> shows an immediate jump from line 59 (attr->max_entries =3D=3D 0) to
> line 64 (return -EINVAL), skipping lines 60-63. This pinpoints
> max_entries=3D=3D0 as the cause -- a diagnosis impossible with stack
> traces alone.
>
> [1] 856c02dbce4f ("bpf: Introduce helper bpf_get_branch_snapshot")
> [2] https://github.com/anakryiko/retsnoop
>
> Puranjay Mohan (4):
>   perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
>   perf: Fix uninitialized bitfields in
>     perf_clear_branch_entry_bitfields()
>   perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>   selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
>
>  drivers/perf/arm_brbe.c                       | 79 ++++++++++++++++++-
>  drivers/perf/arm_brbe.h                       |  9 +++
>  drivers/perf/arm_pmuv3.c                      | 16 +++-
>  include/linux/perf_event.h                    |  2 +
>  .../bpf/prog_tests/get_branch_snapshot.c      | 13 ++-
>  5 files changed, 110 insertions(+), 9 deletions(-)
>
>
> base-commit: d118f32246fdabfb4f6a3fd2e511dc5e622bc553
> --
> 2.52.0
>
