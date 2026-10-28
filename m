Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154967;
	b=CLUlTi+tQEdQI2KLwq3IRBf3EYG7dn/ARIgX312+Qd3RqGNipWYa143T7kyL+6hCSddk
	 /1qJniTM2cnI4nBcohgxRYa8bYmtyPFX7E8+oNnIzXM9YszckPwV9+SAKwMCQv/t3feeM
	 Qp1sqVxqudJOhjbj1dfio3q0qsIzv1DiCPLf0O/huluyCQn/gz+/kFew6q1n7A7Ui5iJF
	 GFCqgj21jCHM+XLj9+saC3ltn84G6V9vhY8py0/fOXhi9ie+fK8a8XQsWn3FN3oNKy128
	 g8xnHlZzbqZYXUOoaEzgTsj+6vA9Wg0xiYoPX31L/ebv2kKMJrwUcede8ezKn5FCMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154967;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=lchfBkGswiVYcptlMoRipSQtCk8N1VQhQAmlkX6JNbE=;
	b=QZXyK8G+lqos7O+N3MwAjY97cldyEZfFGY4Vn2mqtU9nquG5pVk5KZyQ4dIKsC7LSRwj
	 3DcrzXMsFvf78zoRD8NEba8WhQs3cI/VqDLi0g1weBLG1Du5ePrpyrPiFRLo1z6A50WTT
	 JVW14UC67Irzb5gckJ2Bm5WZ2edsn+Lm3j6aWnzP+AJp95yB5fqoBJDm58VmzmdfpniDs
	 R7kV8lXav5mckL6HnPgkD/0gWvmKRCyiLHMmopAyO8DAbYIu0YBEDRaB18649POxLWNwZ
	 vi+R4EhNFa3JFSCIJJp/k7lO6YZe7V5w9DMEzqXI2PLWEKxP0iq9DmTu/QNyfqfFPAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPHH7SYo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D9606A32A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPHH7SYo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C391F01825;
	Wed, 28 Oct 2026 02:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793154966;
	bh=lchfBkGswiVYcptlMoRipSQtCk8N1VQhQAmlkX6JNbE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XPHH7SYopjYJPb+Qr/8su8/m5P3J14A7elly8mVu0IC9HWmm1AwO4lgYTxBXoGUl1
	 aezdhrlicMpxlV5RR36VxeX2gMAZtbxl495FlCarXmIJ51Z5hSd6TVRS8iNQ1oOVSS
	 ZiwVHNrLPfoPI8hsUscQmXvKCMI8WgAZSoq9Fn4NZI4NU3uWJUtoyrinGusnMz6TV7
	 O+XOVQVjHhNMz5sIRMHQhKdOLSjaGupMnOQZHx4eFtS843SJiF2drvuyQ4N1KY8Eoa
	 7jvdKrjisPJWY8S8sP2K56uN6ELE0G153HBisH+Mv9rWjakvaA8dHqXzE5U//fYtoF
	 t1Ge6zpBq2hFg==
Content-Type: multipart/mixed; boundary="===============5472858899452421490=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5e106e3339f4d685de91442e5f17b97d2f63f1a23a1c585dd8d17178708d85b8@mail.kernel.org>
In-Reply-To: <20261028015141.10710-2-emil@etsalapatis.com>
References: <20261028015141.10710-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf 1/2] bpf: recover page faults across all arenas
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 02:36:06 +0000 (UTC)

--===============5472858899452421490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: recover page faults across all arenas

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit; the
arena-fault oops looks like it first became reachable in abdc2516f100, not
9eca087deb0b.

> bpf: recover page faults across all arenas
>
> The current arena fault handling code accounts for
> misbehaving BPF programs that free arena memory
> while it is being accessed by a kfunc as part of
> another BPF program's execution. This scenario
> triggers a kernel page fault that is intercepted
> by BPF arena-specific code. The code confirms
> that the fault is within the BPF program's arena,
> installs a scratch page, and marks the fault as
> handled. This is necessary to prevent BPF programs
> from being able to trigger an oops.
>
> However, the protection against misbehaving BPF programs
> is currently incomplete: Arena memory is accessed by
> kernel code not just as part of a kfunc, but also from
> non-BPF paths. This is the case with sched-ext that
> includes non-BPF code paths that access arena pointers.
> These paths do not have an arena associated with them,
> and a fault there causes an oops. Such a fault can be
> triggered by a misbehaving BPF program by unmapping the
> pages nominally owned by the genpool allocator used for
> cid management.
>
> Extend the kernel arena fault handling to consider all
> arenas in the system. The handler now scans a global
> arena list till it finds an arena that includes the address,
> and fixes up the address. Retain the stream-based reporting
> code for when the faulting call stack includes the BPF
> program that owns the arena.
>
> Fixes: 9eca087deb0b ("sched_ext: Sub-allocator over kernel-claimed BPF arena pages")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Is the Fixes: tag pointing at the right commit?

9eca087deb0b only adds a gen_pool whose bookkeeping bitmap lives in ordinary
kernel memory (chunk->bits), and at that commit scx_arena_alloc() has no
callers.  Nothing there dereferences arena memory from a non-BPF path.

The oops described above looks like it first became reachable in
abdc2516f100, where scx_call_op_set_cpumask() calls scx_cpumask_to_cmask()
to write into the per-CPU arena cmask through the kern_va mapping.  That
happens with only the rq lock held and no BPF program on the stack, so
bpf_arena_handle_page_fault() returns false because
bpf_prog_find_from_stack() finds no program.  The pool is first used via
scx_set_cmask_scratch_alloc().

The fault handler itself came from dc11a4dba246 ("bpf: Recover arena kernel
faults with scratch page"), but its limitation only matters once a non-BPF
path touches arena memory.

Should this be:

  Fixes: abdc2516f100 ("sched_ext: Convert ops.set_cmask() to arena-resident cmask")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40619190018
--===============5472858899452421490==--
