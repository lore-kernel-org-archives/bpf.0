Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134A3D7D78
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841020; cv=pass; b=Yyi5ftJsiae+QUTnjlZH7GlixOmX62zVqPzTkhiFaoOkAtNCRCKdLfTDbdoW11jtMDUucJSmcz4UHY2pz3dAeGe1cuuylOEmVXplukMErmC06LsxnHvpcuJkcFA/QAmmjR2DPm4MAPAAP/1+r76gM6x48VxpeAZd132VEXPF5fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841020; c=relaxed/simple;
	bh=Lg+/TTx8BbBptFQfj20nBYIWu4lmvyGbKjwVgHlwojk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJSEmgpw22qnW+YJm0qaUkwWTt2ncPhVtsCKPYojdS0S5KyNyKfPD2Gh/W/DELS2xFqxuu+613PkHRVaEwCBJaK++vUXy+5+lCeayEsOX5uKZzoJd39gxDMe2eN8AReEWqTgvIZhuOP8QJrBhJ7zhXSXA5hz160AWAqzfv56TVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm4En3ff; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm4En3ff"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8d7f22d405so916454166b.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 06:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773841016; cv=none;
        d=google.com; s=arc-20240605;
        b=X9WFcXyRUj37wI4wuA87q8lnLlPz/5Xy5malRrz/4rWhanOujAp+aCkFqWxxPd0F8S
         pfKXrtHpXb3agQvdr2oLyD//VHcvMi4G2g3Fzj4H4Zn/iSe6j0dWUr/p6agRt6/yHfKu
         5rpFFzUjCdXCL9JvWc66lPRsqmnimcpRRmP1E0R9YHncNyEphnGAM3SiGsZ1bHZouSWo
         suh4T/2MbS6owOEOgbxNh5FqwPug9maR9B9pJi5+mMMV/cnbcs9nNzRB8uPnpAedD1bq
         SuvuFWzy7ajWF7xi5ljpOMWQkTmHJm8CSeK0N+OiEEbyl8iKYf+aM/bJqGvVtW1hD6OH
         TYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D6/bqSpW5+Oi9AxGrrozyndN6Q4jPcmDt6bbbs+htOc=;
        fh=24TcYdoMgfjV8b7K2YQf9RFVnKqSAbSHlpFqL1rD9cw=;
        b=NZyB6ZfEQ+AUC3Ie2A7ZO1omaMnyRwIthsTf014Iflmu/ngM+L/GxhMU0K6IibDakb
         B+I7tKNbQ5l3G5V927QXIdOaX0eJRaYUzIO4bMZrYN9O9qiZjkNPGXzw+m77XL/vpSvm
         02w3xhCuYV1xXLjKqT3TQpMrWuita2A4iAaevR//z6urNnSP0LO1SLNRWwWvJYCMtcA8
         Tj3uG7fFpH7xy1IekINKNS9L2ZzX3bKjg8xz8Wn9eYPERE1nFXjn0SPfYfK+EF2HIAxE
         zsKPQBAmBTu8KYfRHVWe80ykUjvdgskY7bL8ONnAlN/QFe1QqhXVDl1oupH/r8GrgOpf
         ZrqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773841016; x=1774445816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6/bqSpW5+Oi9AxGrrozyndN6Q4jPcmDt6bbbs+htOc=;
        b=Vm4En3ffq61qLYqPd+VJ7/UpnQXy+fB5oP4WdzFA38DHdwBYQhL57BmQ+dLJGjd7ae
         Z2ExfYAz+/NwUIyDmREY/vxRpFQdc0A4KluTH3JNpCWi0DjSeKXEmlBz1HMMazxkO1lT
         P8CikPQOW0GcpxVQBKuvSS9Taz61pqvY+KL8sSvFjOWBWRvJawlm/7EovBOjLENQQzLn
         vbccolkJjmuGLRJTN/yXgFUesodZFImjxl5weP6u2X99d7zhF92tM5qEkHgISAKHKDb6
         rdGk09DWA2MjVtoCY/Oy+/myn351kWTp8GpJQyqQ7UISnYEaxHH9IrPLnIieb2VP9MJa
         vOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841016; x=1774445816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6/bqSpW5+Oi9AxGrrozyndN6Q4jPcmDt6bbbs+htOc=;
        b=AlOUS4Z3Uz4Sgi6z+NYvE+wNWEAgaAhQk6NMFKJtfrZK0vhfC/eDkKyGI8UARQYQaB
         CuPwRYk2D78ZVUURvbRBZjB89e3aeJPY9PdBUbXyMoSwsTnC3CjWzdLKRT/F5x9wcqE7
         t4u5a2NZX6bAsH2FBz4eLHdRLbeLceS4yhIm/P7sr3nYMNNWy7JpGuvqLHYCHV8gjk5r
         59tjWc33EIETclWF7fX3BdpfSBrTDcK2xmDzNCW5v1TDa7XLtoy9EttaW7qM1/L2cEgO
         Xm86hC6+S7p9lVXt1jjF4vXoAn0pnC9G7pQMXXZ0Tav3EEmCPt1A1SksnkBeLAcTe9yj
         uhrQ==
X-Gm-Message-State: AOJu0YxSeotTN4COqCOHPBf8f4U37vH9mskaHGuZLjCvYquggdR5hrVk
	UR1i8vnHLpuu7h8u80DE1xVjQLkeLzO3BbhshxepPToz5TWasuPGYu6xym/sv15JhvXp9+u7QII
	WuifMb9L4Jd56ZQ33W8sUyPoke0cM7x7SXwdmlW4=
X-Gm-Gg: ATEYQzwg6vLOB0JCAwJ79TPV4S4d+uvnbwO/B7T8z4YlSPGQnVcUOIzgSHR3moN2hUX
	F/mggG/ZfUmCHUDBY8OdC0RWqdPbtjQFpMiC+pALjx3jLHm1gARMH+dEisuH6yFfXz3C5yppQL3
	iyGUgu6JG77fP5k3DUQ7nn4EJRTOagErpW5byD6ICsilO3UIe2L5Wo36maL9r60tUOfxG+pXzC3
	ttowgl5hYMSPb6Yo591cSwx+XDivPm5Jnja/MIOivBk/ICgqEv0t74gVOmGBOH6twGlFZx99t+r
	vJN1ByB4i5MQatHrulHzx6M=
X-Received: by 2002:a17:907:3f19:b0:b98:5d8:4fcb with SMTP id
 a640c23a62f3a-b9805d85532mr115473766b.33.1773841015811; Wed, 18 Mar 2026
 06:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313180352.3800358-1-puranjay@kernel.org>
In-Reply-To: <20260313180352.3800358-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 18 Mar 2026 13:36:44 +0000
X-Gm-Features: AaiRm500ICMe5FjGPFHKAmejEpH_zDzyFcFIWkH-r90t0VjGj-E8ZcJxEcK1X7c
Message-ID: <CANk7y0jmnraKP7k4Rzapq5jio4GGZwFadT0X12bTc-LoKBkzCg@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will send v2 of this patch with minor changes that I discovered are
needed, will remove the bpf tag and send it based off the arm64 tree
as that is the correct place for this set to go.

On Fri, Mar 13, 2026 at 6:04=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
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
> Puranjay Mohan (3):
>   perf/arm_pmuv3: Fix NULL pointer dereference in armv8pmu_sched_task()
>   perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>   selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
>
>  drivers/perf/arm_brbe.c                       | 70 ++++++++++++++++++-
>  drivers/perf/arm_brbe.h                       |  9 +++
>  drivers/perf/arm_pmuv3.c                      | 16 ++++-
>  .../bpf/prog_tests/get_branch_snapshot.c      |  9 +--
>  4 files changed, 95 insertions(+), 9 deletions(-)
>
>
> base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
> --
> 2.52.0
>
