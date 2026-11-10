Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286250;
	b=uxXa7RpulP4Nhb9pEsQKH8lQbUXtTL53axb3vhHpds7ABd6KtnWUWDxB6i+uyWPR5wnW
	 jM2BR5GxIKCm3R1/GVHuQukVyktb+Dors+vNWuqISso56t6Cd+52JN/n9/58jcAXCHbFe
	 3w8sCXk/py7ny+gc5CEvtFp3GBS6XL3EB3yRpg5h5YwAuKuDEZ1z0dXOsn4e/S8bV1zgh
	 cdud7NdZ1yiRHz3uodt4/o0BBcjVO3MutsJiYablAcleAIfi6GsiaXPaIco4o2RJkv86A
	 p7R++84ESRkeDxZ3jM8OUjd6iKoqJoug+Pl8ohnr6RxsZsJAiRN5E0r6JJPy69765jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286250;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=u2eTa5OpVP4tAJ93/muIlIfl6D82a0PbNsf8kKqnVMY=;
	b=fwbBXM9fgbUWXLw+SWsZtosGitV0S3zQgtTd+vaHXpXgOoBLDQH4Vw8OlFIkJUfSzeEk
	 Ez551HAq6VFTtK177ADsamORDBqF9TMa+QRCnAVYoNKNR8BjZMf+edC2SAqd/IQVuo+VC
	 Buh+YCUIQ5igETYwr0I5gDR1SGSVX6cyCO63a9ud8VNql9eGPzapKELu7gM8AMR9neHHk
	 eZnWczrmGMwlczDam3G0s5QfwgDWIbBMwxjQKKg6belHYsFL7Ytc/D+Cf5s60n3UQjoOx
	 Et2DArjn9nGjda7Shgr9eSX332cm3ryHEJmmUhvRkDLRJjCk+yYmKXDcb/DfJe5EI3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2WtX8rP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED0606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2WtX8rP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4091F0089F;
	Tue, 10 Nov 2026 04:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286250;
	bh=u2eTa5OpVP4tAJ93/muIlIfl6D82a0PbNsf8kKqnVMY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c2WtX8rP/t8W2Ur6jUyV0AsjdWS22XxKPkspfYLHGr2jt6tXUt5t42l4YZ91zZ0Uj
	 vS0jW9u6ojS5OuReXxHZ4+vVZTcTupwH09J5k+R37tluwSu+aHhKJaBDMYKY4QHUjy
	 OglF+5KfipFr3IRbkfySToa3a/VOC+0Pc0+0vCxiUG/1+WUbhQvVJn9OE/Lk7fFvBv
	 riC+QrNy1bkvSK3e8B8W6K6EaHm6yzXD39L0uNKEQBiz2RAybctgM6BzsYsl+TEr3u
	 HCiVmvu2auBdJ5l0rLQXeNMUzpcZcQCJYIgTmpCEhUMWfPE6EOR4OvU9sG+E/f3ECI
	 8xG+Fy4duI4bg==
Content-Type: multipart/mixed; boundary="===============0137108041998681607=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3fcf8030dabfa192509bf03e974e1016454f9a78ac13371127d59136256104fe@mail.kernel.org>
In-Reply-To: <ad0973be4a5c323bbdeeafb33c7c88ee15e5caf0.1794269507.git.memxor@gmail.com>
References: <ad0973be4a5c323bbdeeafb33c7c88ee15e5caf0.1794269507.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 13/20] bpf: Add bpf_kthread_attach_cgroup() to place a BPF kthread in a cgroup
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:49 +0000 (UTC)

--===============0137108041998681607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_kthread_attach_cgroup() to place a BPF kthread in a cgroup

TL;DR: bpf_kthread_attach_cgroup() skips cgroup permission checks, so a
CAP_BPF-only or token-delegated program may move a kthread into any cgroup,
even another container's, exhausting its pids.max or CPU.

> diff --git a/kernel/bpf/kthread.c b/kernel/bpf/kthread.c
> --- a/kernel/bpf/kthread.c
> +++ b/kernel/bpf/kthread.c

[ ... ]

> +__bpf_kfunc int bpf_kthread_attach_cgroup(struct task_struct *task, struct cgroup *cgrp,
> +					  u64 flags)
> +{

[ ... ]

> +	/* A running thread joins at its next park: see the comment at the top. */
> +	migrate_enable();
> +	ret = cgroup_attach_kthread(cgrp, task);
> +	migrate_disable();
> +	return ret;
> +}

The commit message says the permission check is left out because "the
program's privilege covers" it.  Is that true?  Nothing in this path
requires more than CAP_BPF, and CAP_BPF does not give the right to migrate
tasks between cgroups.

The kfunc is registered for BPF_PROG_TYPE_SYSCALL, which bpf_prog_load()
lets anyone with bpf_token_capable(token, CAP_BPF) load, and with a BPF
token that is only ns_capable() in the token's user namespace.  Neither
bpf_kthread_create() nor bpf_kthread_attach_cgroup() adds a capable()
check.

A cgroup.procs write goes through cgroup_attach_permissions(), which calls
cgroup_procs_write_permission().  A BPF kthread starts in the root cgroup,
so that needs write access to the root cgroup.procs, and it also enforces
the CGRP_ROOT_NS_DELEGATE visibility of both cgroups.

The destination cgroup is easy to obtain, since bpf_cgroup_from_id() calls
__cgroup_get_from_id() and skips the current_cgns_cgroup_dfl() descendant
check that cgroup_get_from_id() does.

So can a CAP_BPF-only program, or one loaded with a delegated token, create
a BPF kthread and move it into any cgroup on the host, including another
container's?  The effects would be:

- cgroup_destroy_locked() returns -EBUSY for the victim cgroup while
  css_task_iter_next() still finds the thread.

- pids_can_attach() calls pids_charge(pids, 1) without a pids.max check,
  so repeated create and attach can push the victim's pids.current over its
  limit and make its own forks fail.

- The thread's CPU time is charged against the victim's cpu.max and
  pressure.

The commit message itself says "a program that places threads in cgroups it
does not own has to stop them when the cgroup's owner wants it gone", which
treats the missing check as intended.

Should the kfunc (or cgroup_attach_kthread()) require
capable(CAP_SYS_ADMIN), or check the destination against the caller's
cgroup namespace and delegation, the way cgroup.procs does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============0137108041998681607==--
