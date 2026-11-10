Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286248;
	b=p8R7pFMR7QOzwQ5aVage7Bz+mix2G4bcgMMZ9YozF5nAWUgj6FJDsKOGuj2YAPrN4h6n
	 YKWNQGLCa39wJgreEiqDUrGVbBVdBWMkaZkyDJ659jyRMcWwr9RhhTTDTSCJq0e9VosGv
	 1dTeO2dxCsocyEfJueN5OdmRCH+8qAEp2LWqOxiuSqf6QTo+l7QSn+g1mChoZUOUlkzqT
	 eNwJQfLc1kqERGwSJQpN4Ndm30SjcCnQp9qhwZg4JTVExKgtP9LL5B8GXr2IkU/mbuZ4D
	 Q1QId/bgZ4LdTNKtFMSA7I/CUOS96aYNvXeyx1ohPxZ4AVlKrNYmIXWvLUYii0qB7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286248;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=q+DmH6S2cAjpv9BVKGQb34OD5X4eYB8P215MfuxTyiA=;
	b=Ji7QY0wAIyqcYz+kxpPQsNKYDnZrlfKp7BENuD6waRhsNnNo3j44tVjPYobNoVfpb7OT
	 yLbetD3tsUyhI2Im/WdRaxHIz1I4JrOLFtDetkjeYtme4cqWyaKXm7sNrYVoZmOAa+ESj
	 /qIlLCBNPUPU1bt4mVNkiqaMUeSe/Wabk2B5Un0mjpAcqru1mKarmdWsXRj+cYzuckEow
	 T3uWQ+etud+Y/nk7sJ0VcD+C7Jp1BZR83jrOOwww0YVNTbk0D2/hGYVeSiUt6LzsUpZPG
	 NRssBZswT9KG1WEqp1YtJgeuWMx8mbfm6KLypg2ddRb0jGlAR69qwZZponhy9xrvOHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlMrew1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BD606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlMrew1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8441F0089F;
	Tue, 10 Nov 2026 04:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286248;
	bh=q+DmH6S2cAjpv9BVKGQb34OD5X4eYB8P215MfuxTyiA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LlMrew1QDj10RZlG7wNzaTmPdjefZ0lZo9n+GxqjCM7VanEu06whwLVzTAM9tjf0m
	 ZBWk9TvsCJ4nkmYg03O8pSvOq1WnMrtuL33aq+ZA14Ri5fEV7kTbqv8NaeDMQapqDf
	 QLF+KqooWRuhBsKyeMRa9VSvABrovcae+f9BC913QbQx7rGe7FIDXH5Z7uHFY8giRp
	 hnP7/7ulS/R7qHptLbZKgnChr3l0tKTxGBDnGR/CJLItU9dGXgZg9X1azTO3PoQd8G
	 EO1IGnjvXKgt8jQVo8QUaGAdcPSnZ2XRmxtdEp+530jY6qjDyeQQKS1V8ZkedryVuA
	 zIwYiKGClTVWQ==
Content-Type: multipart/mixed; boundary="===============0440061886495440349=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4e69f2de9ba1fa29c2bad5f29706e92d59c391cca1156c156ec45529ad2410e6@mail.kernel.org>
In-Reply-To: <beaad5b1ef2a6ad23c531fd2cbb0d5ecc229143c.1794269507.git.memxor@gmail.com>
References: <beaad5b1ef2a6ad23c531fd2cbb0d5ecc229143c.1794269507.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/20] bpf: Add bpf_kthread_bind() to pin a BPF kthread to a CPU
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:47 +0000 (UTC)

--===============0440061886495440349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_kthread_bind() to pin a BPF kthread to a CPU

TL;DR: bpf_kthread_bind() may bypass cpuset and SCHED_DEADLINE affinity
checks, so a BPF kthread could be pinned to a CPU outside its cpuset or an
isolated partition; add a check, or fix the docs.

> diff --git a/kernel/bpf/kthread.c b/kernel/bpf/kthread.c
> --- a/kernel/bpf/kthread.c
> +++ b/kernel/bpf/kthread.c

[ ... ]

> + * bind itself. Unlike kthread_bind(), this leaves the affinity changeable from
> + * user space and subject to cpusets, like that of any other task. The binding
> + * is lost when @cpu goes offline or when the cpuset of the thread's cgroup

[ ... ]

> +__bpf_kfunc int bpf_kthread_bind(struct task_struct *task, u32 cpu, u64 flags)
> +{

[ ... ]

> +	/* A running thread moves at its next park: see the comment at the top. */
> +	migrate_enable();
> +	ret = set_cpus_allowed_ptr(task, cpumask_of(cpu));
> +	migrate_disable();
> +	return ret;
> +}

Both the kernel-doc and the changelog say the affinity is "subject to
cpusets, like that of any other task", but is that true of the bind itself?

For any other task, an affinity request goes through __sched_setaffinity(),
which clips it to the cpuset:

    cpuset_cpus_allowed(p, cpus_allowed);
    cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
    ...
    retval = dl_task_check_affinity(p, new_mask);

set_cpus_allowed_ptr() -> __set_cpus_allowed_ptr() only intersects with
p->user_cpus_ptr, and for a PF_KTHREAD task
__set_cpus_allowed_ptr_locked() only checks the CPU against cpu_online_mask.
Kernel callers of set_cpus_allowed_ptr() get neither the cpuset intersection
nor dl_task_check_affinity().

This can happen with this commit alone.  kthread() calls
cgroup_kthread_ready(), which clears no_cgroup_migration, and BPF kthreads
have no PF_NO_SETAFFINITY, so cgroup_procs_write_start() lets user space move
a BPF kthread into any cgroup.  Then:

- With the thread in a cpuset with cpuset.cpus=0-3, bpf_kthread_bind(task, 7,
  0) returns 0 and the thread runs on CPU 7, outside its cpuset.  A
  sched_setaffinity() of the same thread to CPU 7 gets -EINVAL.

- With the thread left in the root cgroup, __cpuset_cpus_allowed_locked()
  leaves out subpartitions_cpus for top-cpuset tasks, so user space cannot
  put the thread on CPUs owned by a cpuset partition, isolated ones
  included.  The bind can.  kthreads_update_housekeeping() only resets the
  thread when the housekeeping set changes, so a bind made after an isolated
  partition exists stays on the isolated CPU.

- A SCHED_DEADLINE thread can be narrowed to one CPU, skipping the
  dl_task_check_affinity() -EBUSY check.

The later commit 327c89760bca ("bpf: Add bpf_kthread_attach_cgroup() to place
a BPF kthread in a cgroup") tells users to "bind the thread with
bpf_kthread_bind() afterwards, not before" attaching to a cpuset.  That makes
binding outside the thread's cpuset the normal way to use it, and nothing
later in the series adds a check.

The closest in-tree case already checks.  io_uring's IORING_SETUP_SQ_AFF pins
a kernel-created thread to a caller-chosen CPU and refuses a CPU outside the
cpuset (io_uring/sqpoll.c):

    cpuset_cpus_allowed(current, allowed_mask);
    if (!cpumask_test_cpu(cpu, allowed_mask)) {

Should bpf_kthread_bind() check @cpu against cpuset_cpus_allowed(task, ...)
and return -EINVAL when it is outside, and leave SCHED_DEADLINE tasks alone?

If skipping the cpuset is intended, should the kernel-doc and changelog say
so instead of claiming it behaves like any other task?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============0440061886495440349==--
