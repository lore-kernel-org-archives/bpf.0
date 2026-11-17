Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918014;
	b=fzqgc7AgFTc2Bc0ZflsOlSDvLnHv/iHjaKwnyPwsSAyKYmTGqU8RbJ/+Fi14mQbgkGvY
	 R/gE8BvWKClzCkvbaD+0kndkWAiRzg7L0vN46/3t9ymDt1jQJ/RkS9Kj1kfeubMVLUfAy
	 tfSWH0h9QUcywS1ow3tyr/0uYJQCR8EBCW0FuRkczwOphmroG+YMnal7h74n38CG9N4Wb
	 IXRQIKtZgGd5NkezIxLfitcClxfgadARw39oHbiRUGaLbbKjT8UEWBq8yk8PvmXJnyiZP
	 G607REziBX0Sbu0CkVYeol5yBFj7OgawA7Jr+EcJdKsrTTD2+I8o+N4NZAGOgDu8DNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918014;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=itS94mPURDHQuTgfMaOaJrPnv0UhhYADw1GfXqxCZ8U=;
	b=3rCPS+z6lurTuH/80cOizMgYd1UHdjHFLk+W7kU64hxyI5ebFm7BZxiiLf3dYRgG0pLG
	 PVJhswNx6nZsFuKFhlGPKlNV3wApaJPYkeIHoZjtgt6969HfnEEmRW152OoOleVXBE+ne
	 /X72Rsgn+duRrIDEY9LuCtrrf4RCcFwDsXNdmz9oBxhAow4oKqWuUV41OMHaNMm5dt9+a
	 w54CPuw4oVfaUL/mIpUopkuQijbl+jp+RNbs/OCFVjFANaohkwfGo0oemPFu+h698wXTG
	 6GgTw5rEE1Y2Lwo+ft8iSmbCA5YwtykVRuMriN83Q6h2ggHVxWKK6ylzMR9txAcWnKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2OKohOS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1911606A33A;
	Tue, 17 Nov 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2OKohOS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591CD1F000C6;
	Tue, 17 Nov 2026 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918013;
	bh=itS94mPURDHQuTgfMaOaJrPnv0UhhYADw1GfXqxCZ8U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z2OKohOSwtd5zMUEsHNR2U6BXCrVWD0SljcAPX4n85fTuiIEdyK9zZnxamd+Ttu7b
	 qLA9U6LuJnvXV5ierKxnLDrRZDLWbHPoe4Q5JnBS2wyPbvRJyVlz6m+qtHW7ArxLBJ
	 iR9U/KQRk5r+KS/9knuwmOWOHu0Z+v2WyMGSfi/1AxItZkQZBTajh0kBzIL8VUPEyp
	 bQeJJPCpl5t7ZtYo8KesyOTOC+6zoto+7V4w1fdEEZx1XHMkWOxIrn69Hx13QgHqOH
	 zoyl/PyrNc11Ls7i6Z39mcAnsvadAluOpWxlxcGQBDl1UgRIRw7Ll2gMqmU9vzBzSD
	 SPrgeCWdYY+Sg==
Content-Type: multipart/mixed; boundary="===============1081829159996909370=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <846b0937d121e4e7537851e6dd045c8045b721cbe06e8a22a66686e94b51006b@mail.kernel.org>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com>
References: <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Check program recursion per task via bpf_ctx
From: bot+bpf-ci@kernel.org
To: mikeba@sentinelone.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,jp.kobryn@linux.dev,linux-trace-kernel@vger.kernel.org,linux-kernel@vger.kernel.org,mikeba@sentinelone.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 17 Nov 2026 12:20:11 +0000 (UTC)

--===============1081829159996909370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check program recursion per task via bpf_ctx

TL;DR: Commit message only: the trade-off list omits that attaching a marked
freplace extension to an fmod_ret target now also fails with -EINVAL, a
userspace-visible change.

> bpf: Check program recursion per task via bpf_ctx
>
> Trampoline programs (fentry, fexit, fsession, fmod_ret and their
> sleepable variants), raw tracepoint programs (raw_tp, raw_tp.s, tp_btf)
> and tracepoint programs on syscall tracepoints run preemptibly, but
> their recursion check is a per-CPU, per-program counter. When a task is
> preempted inside a program, the counter stays raised, and every other
> task that enters the program on that CPU is dropped and counted as a
> recursion miss, although nothing recursed. A program can't avoid that:
> the counter is checked before its first insn.
>
> Since commit 7dadeaa6e851 ("sched: Further restrict the preemption
> modes") x86 and arm64 have only lazy and full preemption, so this
> happens in normal operation. A security agent that pairs fentry and
> fexit programs on inet_sendmsg() and inet_recvmsg() loses one half of a
> pair with every drop. With 200,000 HTTP requests and four CPU-bound
> tasks on a 4-CPU VM, 9,254 of 7,966,760 runs of these programs were
> dropped on bpf-next, and none of 7,975,426 with this series.
>
> Check recursion per task instead. The runners already link a
> stack-allocated bpf_run_ctx into current->bpf_ctx. Move saved_run_ctx
> into struct bpf_run_ctx, so every frame links to the outer one, and
> record in each frame the program it runs. A program is recursing if a
> frame in the current task's chain already runs it. Interrupts and NMIs
> run on top of the interrupted task's chain, so recursion through them
> is still caught.
>
> bpf_prog_enter_run_ctx() and bpf_prog_exit_run_ctx() do the check for
> all runners. The syscall tracepoint runner linked one frame around its
> program array and now links one per program. bpf_set_run_ctx() accepts
> a NULL ctx, which io_uring passes to hide the BPF context; the frames
> below are not walked while it is hidden.
>
> Programs marked by the previous patch keep the per-CPU counter and
> behave exactly as before, so no counted drop is traded for corrupted
> per-CPU data or a renewed may_goto budget. An extension (freplace) runs
> under the check of its target, so a marked one can't be attached to a
> target that is checked per task.
>
> Trade-offs:
>
> - An unmarked program that keeps per-CPU slots of its own, see the
>   previous patch, can have two runs use one slot, and nothing counts
>   that.
> - Marked programs lose runs to preemption as before.
> - bench trig-rawtp is about 2% slower: 42.6 and 42.1 M/s on bpf-next,
>   41.3 and 41.5 M/s with the series. trig-fentry and trig-fexit are
>   not slower.
> - Attaching a marked extension to an unmarked raw_tp, tp_btf or
>   tracepoint program now fails with -EINVAL.
>
> Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
>

The trade-off list says a marked extension fails with -EINVAL when
attached to an unmarked raw_tp, tp_btf or tracepoint program.  Is the list
complete?

bpf_prog_recur_per_task() returns bpf_prog_check_recur(prog) for
BPF_PROG_TYPE_TRACING:

	case BPF_PROG_TYPE_TRACING:
		return bpf_prog_check_recur(prog);

That is true for every expected_attach_type except BPF_TRACE_ITER, so it
is also true for BPF_MODIFY_RETURN.  bpf_check_attach_target() only rejects
an extension when the target is fentry, fexit, fsession or one of their
_MULTI variants, so a non-sleepable fmod_ret program with a global subprog
is a valid freplace target.

An extension that uses a per-CPU map, a tail call, timed may_goto or
bpf_this_cpu_ptr()/bpf_per_cpu_ptr() could be attached to such a target
before this patch.  It now hits the new check in bpf_tracing_prog_attach():

	if (prog->type == BPF_PROG_TYPE_EXT && prog->recur_per_cpu &&
	    bpf_prog_recur_per_task(tgt_prog)) {
		err = -EINVAL;
		goto out_unlock;
	}

Should the commit message list fmod_ret targets next to raw_tp, tp_btf and
tracepoint, since this is a userspace-visible attach failure?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44076814540
--===============1081829159996909370==--
