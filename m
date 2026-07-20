Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40093D1CB4
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539141; cv=none; b=laIs32sTqNvZzDdKVUGmaGNOJHX+lfQnCajsdDLi5r561KBWOkwUNYpHAos77DsXp5oFKmx7bY8GhT0ZMNXmD8PdNtnKoqADfW1JQD+lvJVPoNFBieUv8vF39YMtfgatFWYfszvIOtWh4oU/FCuJcCaqW4h6c1d4NuOTs83my/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539141; c=relaxed/simple;
	bh=DM+jm4eywrHylHgoaBw5P58oprez0fe1BhcOuCe+VFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nvfBKIWi9aql4gKeKPdPZidwUxJMZQTgpHLQYrptOivSHFXq8xw05i7+lXx8ooWya5sntfrHnBnskrF+4cGOJF1fTuH7M7aAhXvPqgI+SvEN1Hcc1N97Xtu4cpqrrCzQpqkub9W3Pes0kC75HZzmf5PlC0xtrWCPgW5N2sN7+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPAMF/Vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPAMF/Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7D71F00A3A;
	Mon, 20 Jul 2026 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539139;
	bh=NkUTltkbvwEd4yvuqUzWgWdkj+jbtg0aPVNEtK3NxuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPAMF/VsR2DLzBwIYiZoD1DQHtKEkLuwgMLf6BPR6GIwJxvD3fwmEh0ajTwGc0fCO
	 Iy1/bRc7f6oyzjsgtqebjKH1kTW1sexnixD5j4s6cX3SAxM/AU8n/gAF2zlYOwdutq
	 H9xyz9DgbHUTwB2g1/r95K2mxgLVfVLmpOpqIN1wuL7V9Hdpk5oCQa9Ixpm9dl/8ba
	 DXnicD0Ryos97yNQjn8iGxpNNG80RnWLzrMp6ryrBdceGIwOpFAfQsqgcIl2e2ROAL
	 3uBfcEjbbohJXI9XQb0YCieiFza/E4Hs42F77k/nAMGBZ3JfAKcRu/eLZ9s27Nw+BG
	 n0zOsGlFDOmnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 9/9] bpf: Disable preemption in __bpf_get_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-10-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-10-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:18:58 +0000
Message-Id: <20260720091859.1A7D71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Replacing rcu_read_lock() with preempt_disable() triggers a lockde=
p warning ('suspicious rcu_dereference_check() usage') when __bpf_get_stack=
() is called from sleepable BPF programs.

Pre-existing issues:
- [Critical] Synchronous re-entrancy from BPF trampolines (fentry/fexit) en=
ables a Time-Of-Check to Time-Of-Use (TOCTOU) vulnerability leading to an o=
ut-of-bounds memory write.
- [High] bpf_get_stack_pe permanently truncates the shared perf callchain l=
ength for user stacks.
--

--- Patch [9]: [PATCH bpf-next 9/9] bpf: Disable preemption in __bpf_get_st=
ack ---
commit d1da66040bb1a7fc97bf16d7cb97a0712702bc93
Author: Daniel Borkmann <borkmann@iogearbox.net>

bpf: Disable preemption in __bpf_get_stack

This patch replaces rcu_read_lock() with preempt_disable() in
__bpf_get_stack() to prevent another task from reusing the per-CPU
perf_callchain_entry buffer. It ensures the callchain entry cannot be
reused and overwritten underneath the copy operation. Build ID resolution
is deferred until after preemption is re-enabled.

Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@li=
nux.dev/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 57cd4c33403bd..37f8e46319b34 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -819,8 +819,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
> =20
>  	max_depth =3D stack_map_calculate_max_depth(size, elem_size, flags);
> =20
> -	if (may_fault)
> -		rcu_read_lock(); /* need RCU for perf's callchain below */
> +	preempt_disable();

[Severity: High]
Does replacing rcu_read_lock() with preempt_disable() trigger a lockdep
warning when __bpf_get_stack() is called from sleepable BPF programs?

Sleepable programs run under rcu_read_lock_trace(), not rcu_read_lock().
With preempt_disable() replacing rcu_read_lock(), the lockdep rcu_lock_map
is not acquired.

When get_perf_callchain() calls get_callchain_entry(), it accesses
callchain_cpus_entries using rcu_dereference(). Since rcu_dereference()
explicitly checks for rcu_read_lock_held(), will this evaluate to false
and trigger a suspicious rcu_dereference_check() warning?

> =20
>  	if (kernel && task) {
>  		trace =3D get_callchain_entry_for_task(task, max_depth);
> @@ -830,16 +829,14 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>  	}

[Severity: Critical]
This is a pre-existing issue, but can synchronous re-entrancy from BPF
trampolines enable a Time-Of-Check to Time-Of-Use (TOCTOU) vulnerability?

get_perf_callchain() acquires the shared per-CPU perf_callchain_entry
buffer but drops the recursion lock via put_callchain_entry() right
before returning.

If a BPF fexit program is attached to get_perf_callchain(), it will run
synchronously before __bpf_get_stack() resumes. The fexit program can
recursively call bpf_get_stack() with a much larger size. Since the lock
was dropped, it re-acquires the identical buffer and inflates trace->nr.

Upon returning, __bpf_get_stack() passes the inflated trace to
callchain_store(). Because callchain_store() blindly trusts trace->nr
without re-validating it against max_depth, will this result in an
out-of-bounds memcpy()?

> =20
>  	if (unlikely(!trace) || trace->nr < skip) {
> -		if (may_fault)
> -			rcu_read_unlock();
> +		preempt_enable();
>  		goto err_fault;
>  	}
> =20
>  	trace_nr =3D callchain_store(trace, buf, size, elem_size, flags);
> =20
>  	/* trace should not be dereferenced after this point */
> -	if (may_fault)
> -		rcu_read_unlock();
> +	preempt_enable();
> =20
>  	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id=
, user, may_fault);

[Severity: High]
This is a pre-existing issue, but does bpf_get_stack_pe() permanently
truncate the shared perf callchain length for user stacks?

When bpf_get_stack_pe() is called with BPF_F_USER_STACK, it routes to
__bpf_get_stack_pe(), passing the shared perf event buffer:

kernel/bpf/stackmap.c:__bpf_get_stack_pe() {
    ...
    trace->nr =3D min_t(u32, trace->nr, max_depth);
    ...
}

Unlike the kernel branch which explicitly saves and restores trace->nr,
the user branch fails to restore the original length before returning in
bpf_get_stack_pe().

Can this inadvertently or maliciously corrupt the event record for any
subsequent users of the perf subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D9
