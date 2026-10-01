Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E164AAC66
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860768; cv=pass; b=R/dkqLYQEpLWueVZcYYG9I4LbZSm+eWMHmMMTVkh1H7+DJQOCEdpVRYOnnqdaqlgN+1eDWPBto02mHx861HOKq1wBPAOJrzTf+KeRWxJN4CZUKcW5Q+1vbLH0siEM1oOH0uY9Wep48I2bxqv2Of6xnjkXVcfcG7xQpvgJ9SfdC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860768; c=relaxed/simple;
	bh=MGoLCFq6aq9zjFkPP2Nfb6QnY8ZNRoyt4k7h8AtCGr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmzZuK03hFtzqmLDVfsvJa84RN2CGz2rPCIrdh7EWsD6efscoP4eWGJ8khn5S4VjgHZCq+/CgssEKXHhckfdOSdAWdle+VauXn0zwKimnw6Ya7/wkBRx8pxaI1OdY19e+cq/9HR0rXIQ47Sz1mlhxSMfgBtPsucPdOACdNKnc88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+YdNX2x; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+YdNX2x"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so54626365ad.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 06:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790860766; cv=none;
        d=google.com; s=arc-20260327;
        b=nYpXR1Pbq6JxJtU0EUxVETFelOJQH2HQB+5P/0ZsDK4Awcsg9HFDkUFqp3T8uNU8UW
         PjtvxW7lhDs2vQe1qTlVpPEK+UPMt6HnPDMT9Z5W8MqRLQMM1uadatVSHgkcPaFetHBZ
         QkeHLAgkLrzp30gLLmaRRXho2KriPbGqsl3Crhe+HGWL1gbDeg/TeWRgzCE4aAqxP8UV
         cykmM4JkGtj/nyJj7+45QxBX3cLW0bXywujmAvdRb+Xb+nEFaHIlGxYDmEw93eGcBrks
         4qMCyWOLj2TAHH545q3xu9D/nUgp/kbN/5vtQPFBI4NCJiCKNItHQRDmR0YcKIm6Oryu
         Ujnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3+Wqr49x4V2nVh+8mNnV24xRF8uklacV4tlWKmUiY0=;
        fh=d0+vKyjGt4om/JKct73SQ18nooDnw4ybla5QFwl4Rzc=;
        b=J6CP2j/d03Q3Yk1AEWvH55pWkBveZU6p71OjFBRkCXnN6X3+7n0nD+xanxDXjkOCy0
         t+C1WLVBCQhTE+c44eAawkw3WXSD+tOm6eAj3kFitaxRGabz5yUcfo7hfngy1tyHbiON
         J24cefmq9txLigexhIF7P5AYOBzBNGCbBrqlB0Cj3nGOu88RDXYGm0yBmLWwdrgdFaNc
         wXuPs9vTg8/n6DHT9ECc0zwwYGXhxNENvh/iUk26FOWzEbuBzGi6i83t9IH06kRK0Gn5
         OL9VXaWKWKzu1w9NhHQQ50SM3tHOgWQmyE1WC5o/PM92AF9rs17kvoDaIWhxK077A0r9
         KV2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790860766; x=1791465566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3+Wqr49x4V2nVh+8mNnV24xRF8uklacV4tlWKmUiY0=;
        b=r+YdNX2xClnVd6gznQXkY03q6gNlYyHYeg16KYRhORS13jq/TxPSZEkkK7+uD8uuHk
         Rfw9WCwz0/qU3hcZsHlx6L4gHH43YpaCzr2px7tz+clFFXuymYWxhBnYVOphgPvHsrjt
         xyjaQ+plzMQB7bdCMLxKZSJbxX9V9+0FBMvTShK/iyHr9WxgE7Wx7UwjgdYOqE/4sY0S
         Vt7mlGcDadrgI8g1+pp55x6pgIBjTsnlAt+7Y0F21DOg/dzeI3dYyzqSir1Rx3KPlrdZ
         7l6JEJhtqx5+l9B+Wbvvhsl7lO7v2HKrVeP2XN0DIFLfYRUvv8POQGUu39/uNavdIxTq
         bBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790860766; x=1791465566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3+Wqr49x4V2nVh+8mNnV24xRF8uklacV4tlWKmUiY0=;
        b=D/KW7+0PdjroM3GUdUNBj5sqjPwTmEuU3KDHZ3U6Ibej8raCKy/YZBoDDFBo0jNDMO
         t3yIR7/Rbaip8zXrl0dLYKsgXb/M1yf6lt+kciM8zhjiJLIprXndeXzkjxHaciQ6Y8mu
         mzZXocAGIHZDiX69xFzdopFi2iJyq5y5m58waH7T0/zb6MnYcK6j+UTxpMmd8eMWjQVM
         xUBYy9x7+A3/3D8oQWll/BJ0v48vzQt6wkfiPMkjWffY18+/X6BlWzhgHDyI47Yj5wP1
         O3cpy8ZoLoCS9M2QGvW8zzU5u9jbWaYlztN3k6huD/DuQXvd/3xZlaIXUchmbpUBCK9y
         eT7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzBC2SKVG6s2ePIRFDaiDqKdC0k1Zs9KnZIWyvet8OwKuMOEsy/YYx97l73Xs6804Bohrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGI4eDjUf5VkPDUI0WBLIyfWAQStQNspmeYLtBw+7YNrRtv0D1
	t5ths76k+FGd8FgHSlP9IbO9MEQOox4o8byVriGh4mFoHjq2r63CBPrDmN7Y7XZ/GVclrZBnzpy
	Jqwa2etMU/ws/dVrxEk3eULlqobskr/jH5vAUmcU=
X-Gm-Gg: AYBFou0zbHJ/Z9sUjwGkVCHwrkRrsnlSpPNJy1djLZ5LSGnzY/VtAniKbZCC5rzwkK4
	MTFiK1/Tt21SwWzBVOfDfMiRZ/3rZe4B/O4nsE8PzWDg2FFNre2RiZPOW6FQULgNTCNTiyP3/gx
	Uip+njxHMtdBBTQh8usf0j/LKTxTH0jOH/n+Sr+KxHJxPzO019wcj7x4N6EmBM8P32e35/ILnZQ
	hNh0tO2qE88GJChGGQPBaPmijQx7bR1/SsH9dOGVcs1DNJa+yWlFshdKk0httvH+kUr5Y0hZIdI
	zISncDOGoLGx9aH8SbiPW/Qdgbn4150GHA86ZSTYrAiwbFD38DJaSmPkl2kba2bSPnJ6NAiIv6U
	Z3nknuC64lc2UaF8CE/CD5tHUV/jtnL8J4uR4GjnMTv7D9nRG2LTH
X-Received: by 2002:a17:903:1a28:b0:2e2:c3a2:9b15 with SMTP id
 d9443c01a7336-2e2e48ada16mr38741635ad.6.1790860765556; Thu, 01 Oct 2026
 06:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001102909.1152572-1-vineet.gupta@linux.dev> <20261001102909.1152572-2-vineet.gupta@linux.dev>
In-Reply-To: <20261001102909.1152572-2-vineet.gupta@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Oct 2026 14:19:11 +0100
X-Gm-Features: AclHuK_MvWdsgJmdHLGbWvavOLFidBs-vhdRf7_lOy5zycebQreGhiK9WQ5bEo8
Message-ID: <CAEf4BzYghT0yXELLODsXbHS4_upUDx9cwP9YU0cFVVREM2hmEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:29=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.de=
v> wrote:
>
> When ftrace graphing is turned on, all tasks in the system missing
> return stack page are assigned one. This is done in a simplistic
> multi-sweep loop of FTRACE_RETSTACK_ALLOC_SIZE (currently 32) tasks
> at a time as follows:
>
>    start_graph_tracing()
>         do {
>                 alloc_retstack_tasklist
>         } while (-EAGAIN);
>
>    alloc_retstack_tasklist()
>         alloc x32           # GFP_KERNEL, may sleep
>         rcu_read_lock()     # preempt off
>                 for_each_process_thread    walk N_total, no cond_resched
>                      t->ret_stack =3D new_page
>         rcu_read_unlock()   # preempt enable but no explicit yield
>
> Each successive iteration of loop invokes for_each_process_thread()
> which doesn't support cursor based resume and always restarts from the
> init_task. Thus each successive loop needs to skip the tasks assigned
> ret_stack in prior sweeps and thus take longer and longer to find the
> candidate 32 tasks. And while the loop end calls rcu unlock,
> and re-enables preemption briefly, there is no explicit yield.
>
> The total number of iterations turn out to be
>
>         N_total * N_null / (2 * FTRACE_RETSTACK_ALLOC_SIZE)
>
> where N_total is the number of threads on the system and N_null the numbe=
r
> of those whose ret_stack is still NULL. After boot with no fgraph user th=
at
> is every thread.
>
> This is not a tracing-only path. Since commit 4346ba160409 ("fprobe:
> Rewrite fprobe on function-graph tracer") fprobe is built on fgraph,
> so an ordinary kprobe_multi BPF attach that flips ftrace_graph_active
> from 0 to 1 pays the whole cost inside one bpf() syscall. Commit
> 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> narrows that to return and session probes but does not remove it.
>
> A host running hundreds of thousands of threads, with the current batch
> size of 32, turns the ftrace_graph_active 0 -> 1 transition into a
> multi-second, and eventually multi-minute, operation which showed up as
> RCU stall and softlockup_panic on heavily loaded Meta Fleet machines
> with preemption disabled.
>
>     rcu: INFO: rcu_sched self-detected stall on CPU
>     rcu: 0-....: (20718 ticks this GP) (t=3D21000 jiffies g=3D913 q=3D8 n=
cpus=3D8)
>     CPU: 0 UID: 0 PID: 160141 Comm: bpftrace
>      ___slab_alloc+0x549/0xa20
>      kmem_cache_alloc_noprof+0x16c/0x340
>      register_ftrace_graph+0x3d7/0x6c0
>      register_fprobe_ips+0x2d5/0x310
>      bpf_kprobe_multi_link_attach+0x218/0x7e0
>      __sys_bpf+0x267a/0x27a0
>
> Fix this by allocating inline with GFP_NOWAIT instead of pre-allocating
> a fixed batch. GFP_NOWAIT does not sleep, so it is legal inside the RCU
> read-side critical section.
>
> A single sweep now serves every task, so the walk becomes O(N) rather
> than O(N_total * N_null), and the retry loop is no longer the normal
> path.
>
> scoped_guard(rcu) replaces the open-coded rcu_read_lock() and the
> goto unlock, which is what makes returning directly from inside the
> critical section legal.
>
> The pre-allocated array remains as a fallback, although the testing
> below never needed it.
>
> smp_store_release() is a drop-in replacement for the smp_wmb() and
> plain store it replaces.
>
> Measured on a 60-core Sapphire Rapids machine running a PREEMPT_LAZY
> kernel (CONFIG_PREEMPT_DYNAMIC=3Dy, mode lazy), timing the write that
> drives the ftrace_graph_active 0 -> 1 transition. Threads are spawned
> while fgraph is inactive so every one of them has ret_stack =3D=3D NULL,
> and the loop was instrumented to count sweeps:
>
>         threads   before              after
>                   sweeps   time       sweeps   time
>         100000     3126     15.3 s      1       0.019 s
>         200000     6253     59.1 s      1       0.047 s
>         400000    12503    227.8 s      1       0.092 s
>
> The sweep count is 1 throughout. Time now scales linearly with the
> thread count at roughly 230 ns per task, which is the allocation and
> initialisation of one shadow stack.
>
> Fixes: f201ae2356c7 ("tracing/function-return-tracer: store return stack =
into task_struct and allocate it dynamically")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
> Cc: stable@vger.kernel.org
> ---
>  kernel/trace/fgraph.c | 44 ++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
