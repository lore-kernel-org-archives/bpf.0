Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0B2E7F0A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917915; cv=pass; b=fOPPK4ntA9uYQTZXYFco5J8cHjWHMb92A6dr/n/1J8ZKpHQASpXWLK07lnN88TXqEXKz0rcGloJsnzjoIpcDboULJhlC4Pqv+vIiV4Vw5oOxJsWRhJxe6WvFR4nx6mmuAHh3UXwL/bAtwtsiimlX3xPV7FQ6Sh8rWiK0TAfVaAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917915; c=relaxed/simple;
	bh=Da4Zreoxk1xSvnssEsfKIcVCVG3VQVMNsBe7UTq96lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMyivnjKnH5wNJj0+B7u/x1GOnJ85TgOGp3Mhb+oyvZtqN39BFq/oTG2YoYdc+dQTcVRr8CD+mPx/2pqU43Gi2DYBgru8Lw3aNEyWnxq2CCMnC2CorpAKT3ccEgy9CDVnv5hO0YydmS8pKuCfJFL/eekRGUkPRCGVzlNqILCyFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2I+R7k8; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2I+R7k8"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1981065a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774917914; cv=none;
        d=google.com; s=arc-20240605;
        b=EkKmoXqvUhm8N7+0wKrf4BVunDefCdQUyiJ3A8NVVWTFM+d8t+dFkuP22e93K/TQ4k
         +Illb8VnUGq0GrVg01ob+v8u8mU2f9p65l5xNfp3LaIJU7Ra8MDE60CyIarbQOm4qR3p
         HSOp45Zpb1Jb6JXtpGGPT/4hUB14Ei7JrlIfElYmx9z/tJNfOOpvVY9py04pYFAKF+CK
         Fd61dA7qa4dDFaimMMKx3Hc6Re/HPf7MvrLfCXCB1fj4iIMWD/A6dA4Gp4m85AxYcbd2
         3lI8XWuqWEUjMBTctmVNP/3WYS2GieyKfkZCwAv+iPU1fY8OgtTdlx1JqNOgOMJbCWHT
         VHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ppVK+uA+AWzxDcbSXqvqsNDXMKrqL8quxbivrStBL8w=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=ZRUhvHZKWmlcZ9SuVb62DVlcCwSSxwa/zR0y+D1VE9adk5qSEW1DjcIYlrWXKwTM2v
         w32LQjMbrr25baSrgjFJP4/CEpqoR8/1+CdcljKlP9SrqSHsBrGWfUHaesjBPENjnMtB
         k/pTfZaPAhWVkeP2iV84zS76vABhaW4Jp0yjwj+x5b8kteU0ps37w6rQmIasnkT7sDEe
         J46P3gBgqojiY3fbCZ3XF6vrvy5cG4Eh82c7DY8FwLnAgAXbYtyV2ZEsxQQd45vPV3Gz
         cc108C4xh9au7al120A4KPBm9WhVGSr7LOIVKkpMuDrKTucNSY1lVmcC3oianxMN5y1W
         bqMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774917914; x=1775522714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppVK+uA+AWzxDcbSXqvqsNDXMKrqL8quxbivrStBL8w=;
        b=m2I+R7k8tX7KhbCvFs5MOAIAa0/nfS4ofz/Rkn5qoTfyereSd3nQkbJ82T+Piwm6Pd
         Ky96oxKI9+tOR4vFhuH3ELRvptueWFf/xwaqS7bxx81OACj+triiUUtLRw2J4t9MLWX/
         IAsO5eS8GeVSpsFI8sybU5Bhv6AIUpJj2tRxE38FrGKfwsPWQX0vmuDFlEZrRXK7m3y5
         VAyDtS3Uu5eP5f+jYy4GOpmbR800YgzOf5kCVT3Z9OnbRVJt05xklq7mieOj5RU8bniE
         YeDjs1SdSP/4Rx3d1CposarTzQNgn4Q4b3HKAFr9ar4s+WAO/Tp0Z/11mYTCRM9mc75Q
         4YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774917914; x=1775522714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppVK+uA+AWzxDcbSXqvqsNDXMKrqL8quxbivrStBL8w=;
        b=qogvtI05MYNsf6DashRKBgs/ithEt1/0w300ZUy8vSg5z4QeRZJ8K/UbeihuZW7hKA
         ZR61mScCl2axlGJHMbNNbj3qWX66f26YHMeMkMEqPHG0ZE01QIB32ySG/qHAnF9gJHRC
         68T6L8mbZ6U0UbBUm/OmTfTCSJ7rIVOGBEpBzFKsIYHL8LD0i3ZjBuM6kf0mX9mt2qs0
         RjqlE6FfoWH7DmHYRxrPjBKpb4U+rCaRx3SY3uz0OchgAPor6MrLm6nwot1wl0UV+AtB
         bfpitb1R4DrcAARH49pOnEnyIRmnKJMpusv3ypndDofjukZjmU1eS+agj8HeKfnqYSFF
         /ikQ==
X-Gm-Message-State: AOJu0YwnvgiBU+Ye2o4pq68z4oR2GUvtT2kNGIitRE8y+BQXCkIMKGUl
	cjDwc/pyeG+t5zCkYUWecCWqUseZoyAAdDrTRad7J+DCyZzkf3dKk/+wAPHbQ5p6cwLdl7GAR2T
	2KSo5RImEZLlEnPEbu3sHzbAEHhSBpcE=
X-Gm-Gg: ATEYQzy/r2zmf7WEfyiMxdrXmhu1c+JpBlPdYCYzNN4d/DVpmJUp2naOWN4Zl17pxXF
	AdivkqJB8yl6a6Qy5OafvQC/bUOFfn2DW3gWASCvqOQIc1/bS+F5s5gwhX3kl0z3NQhICuk0qe2
	HNqmhPwXV8J9CKQD5hXuf2GBqe2qKmlzRp0uuegu/YlSa2YvjvD4gEqxdDygicx/JYklh3iYy+o
	8ZYSHPHtBswuj6CfFp3IPNyBnIr+G3NTF3thXmiT+aTVsF8w66DdWFd3S75YtYVACMDB7teSttc
	PB6oKIJlaHT5Tq+jhZ8JV7L1iEj3XFt/Jg==
X-Received: by 2002:a05:6300:218a:b0:398:9820:f6fa with SMTP id
 adf61e73a8af0-39c87bcf1d6mr14470936637.53.1774917913234; Mon, 30 Mar 2026
 17:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:45:00 -0700
X-Gm-Features: AQROBzCZdmE9GrRKjZX8AJet5coIl7QtEdFh0rLI1_EuzND90WmK7WgZZ8pPerc
Message-ID: <CAEf4Bzax-0cjyCZoQtWFCQrMHZUZQTZjaY4oDLr3Yz_30XE5BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 0/6] bpf: Add support for sleepable tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> This series adds support for sleepable BPF programs attached to raw
> tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic

"classic raw tracepoints" is confusing, let's keep "tp" as "classic".
tp_btf vs raw_tp is just about BTF-awareness. I'd just say that you
add support for sleepable BPF program for raw tracepoints (tp_btf,
raw_tp) and classic tracepoints (tp).


> tracepoints (tp). The motivation is to allow BPF programs on syscall
> tracepoints to use sleepable helpers such as bpf_copy_from_user(),
> enabling reliable user memory reads that can page-fault.
>
> This series removes restriction for faultable tracepoints:
>
> Patch 1 modifies __bpf_trace_run() to support sleepable programs
> following the uprobe_prog_run() pattern: use explicit
> rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
> non-sleepable programs. Also removes preempt_disable from the faultable
> tracepoint BPF callback wrapper, since migration protection and RCU
> locking are now managed per-program inside __bpf_trace_run().
>
> Patch 2 renames bpf_prog_run_array_uprobe() to
> bpf_prog_run_array_sleepable() to support new usecase.
>
> Patch 3 adds sleepable support for classic tracepoints
> (BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
> and restructuring perf_syscall_enter/exit() to run BPF programs in
> faultable context before the preempt-disabled per-cpu buffer
> allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
> lifetime protection, following the uprobe pattern. This adds
> rcu_tasks_trace overhead for all classic tracepoint BPF programs on
> syscall tracepoints, not just sleepable ones.
>
> Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
> BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
> load-time and attach-time checks to reject sleepable programs on
> non-faultable tracepoints.
>
> Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
> raw_tracepoint.s, tp.s, and tracepoint.s.
>
> Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
> cases using bpf_copy_from_user() on sys_enter nanosleep, plus negative
> tests for non-faultable tracepoints.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v8:
> - Fix sleepable tracepoint support in bpf_prog_test_run() (Kumar, sashiko=
)
> - Link to v7: https://patch.msgid.link/20260325-sleepable_tracepoints-v6-=
0-2b182dacea13@meta.com
>
> Changes in v7:
> - Add recursion check (bpf_prog_get_recursion_context()) to make sure
> private stack is safe when sleepable program is preempted by itself
> (Alexei, Kumar)
> - Use combined rcu_read_lock_dont_migrate() instead of separate
> rcu_read_lock()/migrate_disable() calls for non-sleepable path (Alexei)
> - Link to v6: https://lore.kernel.org/bpf/20260324-sleepable_tracepoints-=
v6-0-81bab3a43f25@meta.com/
>
> Changes in v6:
> - Remove recursion check from trace_call_bpf_faultable(), sleepable
> tracepoints are called from syscall enter/exit, no recursion is
> possible.(Kumar)
> - Refactor bpf_prog_run_array_uprobe() to support tracepoints
> usecase cleanly (Kumar)
> - Link to v5: https://lore.kernel.org/r/20260316-sleepable_tracepoints-v5=
-0-85525de71d25@meta.com
>
> Changes in v5:
> - Addressed AI review: zero initialize struct pt_regs in
> perf_call_bpf_enter(); changed handling tp.s and tracepoint.s in
> attach_tp() in libbpf.
> - Updated commit messages
> - Link to v4: https://lore.kernel.org/r/20260313-sleepable_tracepoints-v4=
-0-debc688a66b3@meta.com
>
> Changes in v4:
> - Follow uprobe_prog_run() pattern with explicit rcu_read_lock_trace()
>   instead of relying on outer rcu_tasks_trace lock
> - Add sleepable support for classic raw tracepoints (raw_tp.s)
> - Add sleepable support for classic tracepoints (tp.s) with new
>   trace_call_bpf_faultable() and restructured perf_syscall_enter/exit()
> - Add raw_tp.s, raw_tracepoint.s, tp.s, tracepoint.s SEC_DEF handlers
> - Replace growing type enumeration in error message with generic
>   "program of this type cannot be sleepable"
> - Use PT_REGS_PARM1_SYSCALL (non-CO-RE) in BTF test
> - Add classic raw_tp and classic tracepoint sleepable tests
> - Link to v3: https://lore.kernel.org/r/20260311-sleepable_tracepoints-v3=
-0-3e9bbde5bd22@meta.com
>
> Changes in v3:
>   - Moved faultable tracepoint check from attach time to load time in
>     bpf_check_attach_target(), providing a clear verifier error message
>   - Folded preempt_disable removal into the sleepable execution path
>     patch
>   - Used RUN_TESTS() with __failure/__msg for negative test case instead
>     of explicit userspace program
>   - Reduced series from 6 patches to 4
>   - Link to v2: https://lore.kernel.org/r/20260225-sleepable_tracepoints-=
v2-0-0330dafd650f@meta.com
>
> Changes in v2:
>   - Address AI review points - modified the order of the patches
>   - Link to v1: https://lore.kernel.org/bpf/20260218-sleepable_tracepoint=
s-v1-0-ec2705497208@meta.com/
>
> ---
> Mykyta Yatsenko (6):
>       bpf: Add sleepable support for raw tracepoint programs
>       bpf: Rename bpf_prog_run_array_uprobe() to bpf_prog_run_array_sleep=
able()
>       bpf: Add sleepable support for classic tracepoint programs
>       bpf: Verifier support for sleepable tracepoint programs
>       libbpf: Add section handlers for sleepable tracepoints
>       selftests/bpf: Add tests for sleepable tracepoint programs
>
>  include/linux/bpf.h                                |  25 +++-
>  include/linux/trace_events.h                       |   6 +
>  include/trace/bpf_probe.h                          |   2 -
>  kernel/bpf/syscall.c                               |   5 +
>  kernel/bpf/verifier.c                              |  13 +-
>  kernel/events/core.c                               |   9 ++
>  kernel/trace/bpf_trace.c                           |  49 ++++++-
>  kernel/trace/trace_syscalls.c                      | 110 ++++++++-------
>  kernel/trace/trace_uprobe.c                        |   2 +-
>  net/bpf/test_run.c                                 |  55 ++++++--
>  tools/lib/bpf/libbpf.c                             |  39 +++++-
>  .../bpf/prog_tests/sleepable_tracepoints.c         | 153 +++++++++++++++=
++++++
>  .../bpf/progs/test_sleepable_tracepoints.c         | 128 +++++++++++++++=
++
>  .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
>  tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
>  15 files changed, 543 insertions(+), 88 deletions(-)
> ---
> base-commit: 596817673dc2d226bdacb72d7a03a328966f563b
> change-id: 20260216-sleepable_tracepoints-381ae1410550
>
> Best regards,
> --
> Mykyta Yatsenko <yatsenko@meta.com>
>
