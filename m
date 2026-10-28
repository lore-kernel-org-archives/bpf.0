Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192267;
	b=B+2WccIO/R1pDwteDtys9L1ACkLKg+ddZ27T9PMW3Ydd630ed2yw1hIkaDijhyvJixDP
	 Rg/fT8C7Vyv1/m8M/BAPLsWlmvRN3PZXV9aAkNi51NgyXXNFRc/Gs+rZHB41LXxvkcCwd
	 wwVNKteTQEKmRCvyKh7hSUFpjxAAnTn0YEmMZkqTUoMGV88xQZhKNbiAG7ZA2R+GWKT/6
	 B0rNXJ3uJHIRvvwADw9e0BG+r0C6WBgkfsVyqjZLwnbk9tOvthV3oiID0S2f4ovNBp865
	 N8RePltVhfPPE2aKNgiu2pDkn+SRHJyn7yeQPGRlVfb/ehN+QQ72nTxWnNdUBrsmSaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192267;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HUM8sXQdO7ct4Idv1B7IM4lRnALIhIQ2wSPtdzHuJ28=;
	b=hQQKP533A+rJgKXxcgAJ4L3AZpVV96qNgr+a1cNeoAwp9Zr/Xx/h3FqpIMS56Sdd1Z94
	 8MLlIU5ciO03q0cWr91AggDuzt6nz1y80jtWXZRFNHKXCcGclA5V0151IWvnyeGTw+krE
	 b0I4VQXOGWnw2cdvjVidcXx7LvCtofG9bRpGhEViYgkjhV+2tbi2HOZ53azuckziRhx0U
	 22gTYwssigQoBhBEvhE90u76CI/WDo8Qp0wwR2R6yTTolH37ormzVMxjYY2G9Lzus/Gv2
	 u08petdHDuwZCGjBZYf568Bm0PjeXO8K3ap6l+E4fz7Z93ctMilYsueC6OJuxwgPxgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMPlekMB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B9606A31A;
	Wed, 28 Oct 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMPlekMB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE01F01825;
	Wed, 28 Oct 2026 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192267;
	bh=HUM8sXQdO7ct4Idv1B7IM4lRnALIhIQ2wSPtdzHuJ28=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GMPlekMBzDJfFhFnZ7ijAVGh64wncgseUdJ5kCVSYiWXGKkQPoi82lyQC9zENv25/
	 h8LVmqr5cgaEWmbKBtZGc6I7F78DmQdNlrOP11tnG1BW5W+ewbLuJRHpVogmSZlwWT
	 ImSD5HMofBACYkTYf5TvDmcraocK55BGzRUMrnhvcg7tK/EWkOLDAuUvOQbLWlWEqu
	 /cG1kzLAODwg2zB5fFs5PxZJRq5JZ8UUlgn+b8/8w1EzQLItZV94g/PSECi0b9GEoG
	 Cd4P0wB2BBSZamSygLrWYSMI+2oz1Amk5lnFHeD0HTYc6i1XEqwN4/1mbWWQcOIg46
	 9e69PMZXfmIWg==
Content-Type: multipart/mixed; boundary="===============5912671814999648148=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2775a286c1858223177c92a3bcf151e59f7cadec170a1bb3d4029f731935a68d@mail.kernel.org>
In-Reply-To: <20261028121859.994-1-yangsongsen@insta360.com>
References: <20261028121859.994-1-yangsongsen@insta360.com>
Subject: Re: [PATCH bpf] bpf: Always hold RCU read lock around perf callchain in __bpf_get_stack()
From: bot+bpf-ci@kernel.org
To: yangsongsen@insta360.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 12:57:46 +0000 (UTC)

--===============5912671814999648148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Always hold RCU read lock around perf callchain in __bpf_get_stack()

TL;DR:
- Commit message only: other sleepable program types may also hit this, not
  just syscall programs
- Fixes: tag may need to point to 1e6c62a88215
- Changelog overstates the impact; it looks like only a lockdep warning, not a
  buffer lifetime problem

> bpf: Always hold RCU read lock around perf callchain in __bpf_get_stack()
>
> __bpf_get_stack() only takes rcu_read_lock() around get_perf_callchain()
> when may_fault is true, assuming that non-faultable callers already run
> inside an RCU read-side critical section.
>
> That assumption does not hold for BPF_PROG_TYPE_SYSCALL programs. They
> are always sleepable and bpf_prog_test_run_syscall() only holds
> rcu_read_lock_trace() while running them, yet through
> tracing_prog_func_proto() they are given the non-sleepable
> bpf_get_stack_raw_tp() helper, which calls __bpf_get_stack() with
> may_fault == false. get_callchain_entry() then does
> rcu_dereference(callchain_cpus_entries) without rcu_read_lock() held,
> and lockdep complains:
>
>   WARNING: suspicious RCU usage
>   kernel/events/callchain.c:163 suspicious rcu_dereference_check() usage!
>   1 lock held by repro:
>    #0: (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: bpf_prog_test_run_syscall
>   Call Trace:
>    lockdep_rcu_suspicious
>    get_callchain_entry
>    get_perf_callchain
>    __bpf_get_stack
>    bpf_get_stack_raw_tp
>    bpf_prog_test_run_syscall
>    __sys_bpf
>
> The callchain buffers are freed with call_rcu(), and an RCU Tasks Trace
> read-side section does not imply a normal RCU read-side section, so
> holding rcu_read_lock_trace() alone is not what get_callchain_entry()
> expects.
>
> Take rcu_read_lock() unconditionally. Nesting it inside an existing RCU
> read-side critical section is cheap and harmless, as suggested by Andrii
> in an earlier discussion.
>
> bpf_get_stackid() is not affected: sleepable programs cannot use
> BPF_MAP_TYPE_STACK_TRACE maps, so syscall programs cannot reach it.
>
> Testing: on top of bpf/master at commit c8a8a68d3ab4 ("bpf: Don't re-sort
> subprog_info[] for every new subprogram"), x86_64 under QEMU TCG with
> CONFIG_PROVE_RCU=y (syzbot config with KASAN/KCOV/modules disabled), the
> syzbot C reproducer
> triggers the splat above without this patch and does not with it. A
> minimal BPF_PROG_TYPE_SYSCALL program calling bpf_get_stack() was also
> run via BPF_PROG_TEST_RUN: it warns before, and returns 0 without a
> warning after. BPF selftests were not run.

[ ... ]

> Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
> Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
> Link: https://lore.kernel.org/all/CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com/
> Signed-off-by: Songsen Yang <yangsongsen@insta360.com>

The changelog says "That assumption does not hold for
BPF_PROG_TYPE_SYSCALL programs".  Are syscall programs the only ones
affected?

For BPF_FUNC_get_stack, tracing_prog_func_proto() falls through to
raw_tp_prog_func_proto(), which returns the non-faultable proto whatever
prog->sleepable is:

kernel/trace/bpf_trace.c:raw_tp_prog_func_proto() {
    ...
    case BPF_FUNC_get_stack:
        return &bpf_get_stack_proto_raw_tp;
    ...
}

Only kprobe_prog_func_proto() switches to bpf_get_stack_sleepable_proto.
So the same path looks reachable from other contexts that hold only
rcu_read_lock_trace() or rcu_read_lock_tasks_trace():

  - sleepable fentry/fexit/fmod_ret/iter programs, which enter through
    __bpf_prog_enter_sleepable() (rcu_read_lock_trace() plus
    migrate_disable())
  - sleepable LSM programs, since bpf_lsm_func_proto() also defaults to
    tracing_prog_func_proto()
  - sleepable raw tracepoint programs, through __bpf_trace_run()
    (rcu_read_lock_tasks_trace() plus migrate_disable())
  - sleepable tracepoint programs, through trace_call_bpf_faultable()
    and bpf_get_stack_tp()
  - bpf_wq callbacks, through bpf_wq_work(), which holds only
    rcu_read_lock_trace()

Could the changelog mention these, with syscall programs as the example
that reproduces it?  The same applies to the bpf_get_stackid() paragraph,
which holds for all sleepable programs because map_needs_no_rcu() does not
list BPF_MAP_TYPE_STACK_TRACE.

On the Fixes: tag, 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and
program type.") is the first commit where syscall programs reach this path,
but the broken assumption is older.  At 1e6c62a88215 ("bpf: Introduce
sleepable BPF programs"), __bpf_prog_enter_sleepable() was just
rcu_read_lock_trace(), and sleepable fentry/fexit/fmod_ret and LSM programs
could already reach bpf_get_stack_proto_raw_tp through
tracing_prog_func_proto().  get_callchain_entry() was already using
rcu_dereference() then.  The rcu_read_lock_trace() in
bpf_prog_test_run_syscall() came later, from 87b7b5335e69 ("bpf: Add
missing bpf_read_[un]lock_trace() for syscall program").

Should the Fixes: tag point to (or also include) 1e6c62a88215 ("bpf:
Introduce sleepable BPF programs")?  With only the current tag, stable
tooling would leave out v5.10.y through v5.13.y, which have sleepable
tracing and LSM programs but no syscall programs.

The changelog also says "The callchain buffers are freed with call_rcu(),
and an RCU Tasks Trace read-side section does not imply a normal RCU
read-side section, so holding rcu_read_lock_trace() alone is not what
get_callchain_entry() expects."  Is this an accurate description of the
exposure?

__bpf_get_stack() already calls preempt_disable() before
get_perf_callchain().  The changelog of b1a47b2708d4 ("bpf: Disable
preemption in __bpf_get_stack") says:

    preempt_disable() also subsumes the buffer-lifetime guarantee the
    rcu_read_lock() provided, since a preempt-disabled section is an RCU
    read-side critical section for the callchain buffers' call_rcu()
    reclaim.

In addition, a program that calls bpf_get_stack() holds a callchain buffer
reference for its lifetime:

check_helper_call()
    get_callchain_buffers()
    env->prog->has_callchain_buf = true;

__bpf_prog_put_noref()
    if (aux->prog->has_callchain_buf)
        put_callchain_buffers();

so release_callchain_buffers() and its call_rcu() should not run while the
program is executing.

If that is right, the problem here is the rcu_dereference() check in
get_callchain_entry() not seeing rcu_read_lock_held(), and not a buffer
lifetime problem.  Could the changelog say that the impact is a lockdep
warning?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40688373762
--===============5912671814999648148==--
