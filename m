Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E535AC0F
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390845; cv=none; b=coMaa+QjZP3cFX7WNsUKH2w4dHXH82T5h0G/067bwN6G8nLQGBNqsHr+WJeCQ0UDCI+88Fjstc6LVR65tiQsIesYZnGLgTDFrzIRPccAGDFu6gZdh98siQ1tgXLGZ0ho5cMGXAfHkq0XQ/KSvnQlkxm00jRjWUE1V/ADth1jKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390845; c=relaxed/simple;
	bh=5Lp9tByKKNAKjIZa447s8t1iNsrFOxY8MI2FMlHuMN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kv+0fhBM0SHZjR8J+X6lawnjC3X0voYTPYR+jzF4oPBDOtPCc7bs3v8mCzIeISzeWeRgrjX54V+R7gPAB9cB2xgrCl/cRn9lr4Sw1w99bNN+fSOclWJnYOVhaOg9NxrsVt2kGeIp8i8rlmY8h7G6lq0cRSrAjPtLga6hBLGGeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEjnpm6a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEjnpm6a"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso3000265e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390842; x=1774995642; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Lp9tByKKNAKjIZa447s8t1iNsrFOxY8MI2FMlHuMN8=;
        b=nEjnpm6a9EDRHLDi1EdBWELUdbJ8xO4/7CAFVPS6nnZ7jaTPVJUXoVJQD99csNmQIY
         sfI3smsAhnmlTNkFnb5kSlxEttNmbJkqSJuHuNuSjzHuhHNuS2EesImT+EBjDBGYOG9P
         oHoIsZ4KF5HR+3yJEyMeCeaZ9GMw5xffyA0foQm0glxh0tSVawkOhMxV+bzd741LgbZU
         5JtGgrz7ytT9n14QX4aYmbVKZGY5hpbuYmwwVwFNeCals6WwS9foLS31/noyfpQ6l+/4
         MblVyD7FQlS6Qvp8tBHP+fbUFvMjh+yA+md33yRumfeJK85KZJCguP7tu6FqeUkhB16f
         4oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390842; x=1774995642;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Lp9tByKKNAKjIZa447s8t1iNsrFOxY8MI2FMlHuMN8=;
        b=WZ1nTx5UJHhezWVVE0Jhda4Bmy6HYL3dqDKoxetKuC/mVo2HpPl/sxZKIK0QLvXRC1
         Um85uhUKxLbzp4yAm3S7RqYwaXE1MAzhD6mUyWbLtpa5am70yBanz3jqphVXDzgF+bib
         23t7vHKfGUltuJ2/Yv1gfsDxKU2eqUcE/sE3J6xNmrQf9WoOaBP2925AlWvYjG0fhFkA
         21qHsEFonBbbgLfzFEyiNe37nTlWDQWhHa1DK5ACRDa5m78qbbLvzOKGapNk/QotX9om
         LqZiMgTifqW/umAgJ3plMUVphWXJJgSmghlSsCaPtZx4tgzZLf6lE99uC9UgXKd8dXqO
         2RTQ==
X-Gm-Message-State: AOJu0Yyn4Dk8/F8iTxk8ahEpMOuVTRiBa2aeGqmSFc/yCY98xIE6odsu
	Znj2gVTXtZJsamez/5zGE0Bit46YUwh1E7lo5oy9Bym6G4viDwUCDud5
X-Gm-Gg: ATEYQzwF9TELf1D9xNWtOh+5hiaUqN8hHKIRU2Dw4+KyiZrpwDYDQ5CqfjLHCw6sEh4
	guF57Y3h/RX20U9bptmv8qdwGXrvaLy31KFv7WCEbVLWghTMiGvaWGL4lBkGuoTqWBLa7oBSttF
	3YvydhnJAVRMt0rJsAhJaGXD5gVM6sn7UNOV+bver+QipsEuBMpNsKaclnIIcdNDadwjZBR65hr
	HQ6QQ1fzXIbz3OUupKvWxpR+vi6/6Fr8awy+wS0bjdMtcP4ALACe8iaJ57ZtkcHdFC2vWmOdFjT
	x5RFGmQUu7GbORA4WT5Aq70p1WIcSDl3EmsAR56Cu8Mq1D6qoKaizP/e90bOeIqzsu83IxmOmqd
	xsZAkRx/aNkaGKR1WnvKUJZaPd3FupW2erUb03OjOA2lcUdcDnp52xlK66wUXKLQW3kTyUf7cNg
	0w9+YifZzt8xYivc1euEijvoST2HAYikca2r9bXDH50tgF
X-Received: by 2002:a05:600c:1e88:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-4871603a058mr17633925e9.8.1774390842191;
        Tue, 24 Mar 2026 15:20:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487165ed21csm6094905e9.6.2026.03.24.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:20:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable
 tracepoint programs
In-Reply-To: <CAP01T74asfp5DY+wFd6pDVpSsiuPxjPaPE8iaFaczBUHe0BERw@mail.gmail.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
 <CAP01T74asfp5DY+wFd6pDVpSsiuPxjPaPE8iaFaczBUHe0BERw@mail.gmail.com>
Date: Tue, 24 Mar 2026 22:20:41 +0000
Message-ID: <871ph8kgxy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Tue, 24 Mar 2026 at 20:03, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> This series adds support for sleepable BPF programs attached to raw
>> tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic
>> tracepoints (tp). The motivation is to allow BPF programs on syscall
>> tracepoints to use sleepable helpers such as bpf_copy_from_user(),
>> enabling reliable user memory reads that can page-fault.
>>
>> This series removes restriction for faultable tracepoints:
>>
>> Patch 1 modifies __bpf_trace_run() to support sleepable programs
>> following the uprobe_prog_run() pattern: use explicit
>> rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
>> non-sleepable programs. Also removes preempt_disable from the faultable
>> tracepoint BPF callback wrapper, since migration protection and RCU
>> locking are now managed per-program inside __bpf_trace_run().
>>
>> Patch 2 renames bpf_prog_run_array_uprobe() to
>> bpf_prog_run_array_sleepable() to support new usecase.
>>
>> Patch 3 adds sleepable support for classic tracepoints
>> (BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
>> and restructuring perf_syscall_enter/exit() to run BPF programs in
>> faultable context before the preempt-disabled per-cpu buffer
>> allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
>> lifetime protection, following the uprobe pattern. This adds
>> rcu_tasks_trace overhead for all classic tracepoint BPF programs on
>> syscall tracepoints, not just sleepable ones.
>>
>> Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
>> BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
>> load-time and attach-time checks to reject sleepable programs on
>> non-faultable tracepoints.
>>
>> Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
>> raw_tracepoint.s, tp.s, and tracepoint.s.
>>
>> Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
>> cases using bpf_copy_from_user() on sys_enter nanosleep, plus negative
>> tests for non-faultable tracepoints.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>> Changes in v6:
>> - Remove recursion check from trace_call_bpf_faultable(), sleepable
>> tracepoints are called from syscall enter/exit, no recursion is
>> possible.(Kumar)
>
> Is this true? Can't the same program reenter due to the same syscall
> from a different task which preempted the task running the previous
> program?
> Just asking because it wasn't clear to me, since we discussed
> bpf_prog_get_recursion_context() instead.
>
Good question, this is my understanding, though I'm not 100% confident:
There are 2 mechanisms we discussed:
 * bpf_prog_get_recursion_context() - per program recursion guard, I
 understand this is used to prevent self-recursion, where BPF program
 infinitely generates calls to itself.
 * bpf_prog_active - per CPU counter used to prevent deadlock between
 instrumentation BPF prog (tracepoint, kprobe) and map operation
 generating an event triggering those BPF progs when holding map bucket
 spinlock.

I suggest that none of these applies for the usecase, because we open
sleepable only for syscall enter/exit:
 * Deadlock on the map bucket spinlock is not possible (bpf_prog_active)
 * BPF program can't generate another syscall enter/exit - no infinite
 recursion (bpf_prog_get_recursion_context())

As for the situation that you describe: same program reenter due to the
same syscall from a different task which preempted the task running the
previous - this is normally supported, behaviour - similar to what
we have when NMI runs on the same CPU and calls common BPF subprog, or
two tasks schedule sleepable bpf_task_works callbacks, that can
interleave on the same CPU.

Let me know if my understanding is not correct. Thanks for checking this
series!
>> [...]
