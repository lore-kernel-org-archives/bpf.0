Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995843;
	b=MaP048rLOkgO5N+29trIOkw+4HpFNHS45dk7LhpNJTZDzR0BVMnJ2XfIgRrSJVv5xmMl
	 9SY3/i0+8yZcS1STWNwJKwa8fXcqF+OFzRXRL02vZGPz8jbasvQ/HtsMMPh3COFveudYV
	 ZrQoA0CRm7j5ix7j2/0t5/qNFOiqyipwVwQOo2b3leGsU1Hfc56pCaV+BAxz0YrmBZsvz
	 gpLqbmE/zpeKvtUFsqpZt1nkeEBR1mSmhw/yf2hZWZSM6UYfCzbwBxMFa4yzEJTJ9AAkx
	 pV2gVXTWLSebFZhAY9KikWL3vOFLXfBIRJz+GvNXkXO3c3nbcPhaOaGRO5VSLCtvqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995843;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mQgknlMcFh7YkLQGDtcBN7DE0e8P0JWuuv3aI+pCJYQ=;
	b=4jOuS/pkFmwd1FMIsacolnwm3bqY9TIm5PXK/pdirO1nLERUxP9sH3X5pz7CUepEufDv
	 ZJZtnAW++zoJiI6Kcw6CdjXsa2yWLCr8ODG4jRnIiqCfO0vXwD9eNgD/z6RFKVquiVJmZ
	 Ogw1JVwTKruwnpNawfL8+6KUQDOFkTBAqkrZpj8EIIM4O9u3vlA91gMj4d4lwPcs1GbhS
	 p/jgBzfBgaVBJ3gNYh8VjIaglo9tl4L51oLrCfFXQbgR1k1oYhst02rD7Xs1ojej4Zhc3
	 cQ8bxnXJDmZyOmn6dTHlY+gcqE8xHyvfW4XIL5cmOqr8N7qV1umAm1zJ409TV9XcKig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnUdqwU6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B5606A326;
	Fri,  6 Nov 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnUdqwU6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EDC1F0089F;
	Fri,  6 Nov 2026 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793995842;
	bh=mQgknlMcFh7YkLQGDtcBN7DE0e8P0JWuuv3aI+pCJYQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RnUdqwU69JoRUt8RZUa4ecesZuW7rHh2EHuIQp68p38g3KmbYSlVv9nHAMpiRx1SO
	 p9QxX95BJI8O2DoAVbKQjIud2xDDHvE58beRPR6kAoNDBWaAE9WQa0n33CJWPfwAEB
	 i2i9Qjmqnk7TK4R2kf9J4UytS9J20gvwU8DhjifZHc2taGEJNw2dEZnzWZI0f6mmhC
	 1GrHuRqdcjXF86swcy7V9fSYe+CzfBe0Bc8n2aXE8p0RTXwuzbklxuVeMEeoX34Xvp
	 i4pxiPm+pNVaO6YfEq4rI/XFl98fmsRX41iQv8R2Xoqd/p2WE7aXtKcNGPs6mpUf/O
	 nJE05GLp5WewA==
Content-Type: multipart/mixed; boundary="===============1898950710558378953=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f043064ddbaa8d0c3bd479100993d6f157076ed25b1ab98b78c05bb2f1effae8@mail.kernel.org>
In-Reply-To: <20261106094343.174905-2-radu.m.toader@gmail.com>
References: <20261106094343.174905-2-radu.m.toader@gmail.com>
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU
From: bot+bpf-ci@kernel.org
To: radu.m.toader@gmail.com,peterz@infradead.org,mingo@redhat.com,tj@kernel.org,tglx@kernel.org
Cc: juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,frederic@kernel.org,anna-maria@linutronix.de,bigeasy@linutronix.de,joshdon@google.com,haoluo@google.com,brho@google.com,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 20:10:42 +0000 (UTC)

--===============1898950710558378953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU

TL;DR:
- Possible starvation of a task pinned to the target CPU until the sched_ext
  watchdog unloads the scheduler
- Question whether this debug scheduler belongs in tree
- README tense and a sleepable-comment nit

> sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU

Tejun Heo replied to the posting of this patch:

> this scheduler is more of an one-off debug code and I'm not sure we want
> to carry this in tree. Maybe put it in a github gist or sth and point to
> it from the fix patch?

I didn't see a reply to this.  Is the plan still to carry scx_tickbug in
tools/sched_ext?

> diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
> --- a/tools/sched_ext/README.md
> +++ b/tools/sched_ext/README.md

[ ... ]

> +This is a test scheduler, not a policy. It exists so that the idle-time
> +bookkeeping skipped by an interrupt taken in that state can be measured.

The README says the scheduler measures the bookkeeping skipped by an
interrupt in that state, which matches tick_irq_exit() at this commit.  The
next commit in the series, 24b81cae8220 ("softirq: Treat an interrupted idle
task as idle in tick_irq_exit()"), changes the gate so that skip no longer
happens, and does not update this README.

Meanwhile the header comment in scx_tickbug.bpf.c already says
"tick_irq_exit() used to ask idle_cpu()", which is past tense.

Could the README say that the scheduler reproduces the condition handled by
the tick_irq_exit() change and can be used to check it, and could the README
and the BPF header comment use the same tense?

> diff --git a/tools/sched_ext/scx_tickbug.bpf.c b/tools/sched_ext/scx_tickbug.bpf.c
> --- /dev/null
> +++ b/tools/sched_ext/scx_tickbug.bpf.c

[ ... ]

> +void BPF_STRUCT_OPS(tickbug_dispatch, s32 cpu, struct task_struct *prev)
> +{
[ ... ]
> +	if (cpu == target_cpu) {
> +		if (release_now) {
> +			release_now = false;
> +			if (release_one())
> +				return;
> +		}
> +
> +		/*
> +		 * Leave @target_cpu in the idle loop for as long as it is
> +		 * holding something. Taking shared work here would end the
> +		 * idle stretch under test, and the hold reported for the task
> +		 * would cover time the CPU spent running.
> +		 */
> +		if (nr_held_now)
> +			return;
> +	}

Can this starve an untagged task that is pinned to @target_cpu?

tickbug_enqueue() sends everything except per-CPU kthreads and
SCX_ENQ_LAST tasks to SHARED_DSQ, which includes a user task pinned with
something like taskset -c 0.  While nr_held_now is non-zero, the early
return above skips:

    scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);

and no other CPU can consume that task, because it fails
task_allowed_on_cpu() there.

nr_held_now can stay non-zero at every dispatch when two tagged tasks hand
off to each other.  For example, A wakes B and blocks; B's wakeup on
@target_cpu is held, so nr_held_now is 1; ops.dispatch(target_cpu) returns
early and the CPU idles; the timer releases B, B wakes A, A is held, B
blocks, and so on.

The pinned task would then sit on the runnable list until the watchdog
(timeout_ms of 5000) raises SCX_EXIT_ERROR_STALL and unloads the scheduler,
which doesn't match the commit message's "the machine stays usable".

Would sending any task with nr_cpus_allowed == 1 to SCX_DSQ_LOCAL, as is
done for per-CPU kthreads, address this?

[ ... ]

> +s32 BPF_STRUCT_OPS(tickbug_init_task, struct task_struct *p,
> +		   struct scx_init_task_args *args)
> +{
> +	struct task_ctx *tctx;
> +
> +	/* Sleepable, so this allocation can use GFP_KERNEL. */
> +	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
> +				    BPF_LOCAL_STORAGE_GET_F_CREATE);

This isn't a bug, but is this comment accurate?  tickbug_init_task() is
declared with BPF_STRUCT_OPS(), not BPF_STRUCT_OPS_SLEEPABLE() as scx_qmap
and scx_sdt do for their init_task, so the program isn't sleepable.

Also, since commit 136deea435dc ("bpf: Remove gfp_flags plumbing from
bpf_local_storage_update()"), bpf_task_storage_get() allocates with
bpf_map_kmalloc_nolock() regardless of sleepability.

Should the comment be dropped, or should the op be declared with
BPF_STRUCT_OPS_SLEEPABLE() if sleepability was intended?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42280840441
--===============1898950710558378953==--
