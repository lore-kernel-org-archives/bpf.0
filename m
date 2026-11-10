Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286245;
	b=EsnVTq91P/NZ3DesLH9O3sFYnjIsGmZ2WLxMvir1dUN4KlsIvWfGY6dyJ7w2WCcG3q5V
	 hPyWWJ0p1ddbY+nAyMSR2q0rfIOMThRjvrwbWPsLmCAb7gcH1+e3th+tKnOyhQ11P8YMk
	 8DWXpo03kzggS1XjTTpYFDQt0+i6Ha8DNWJ6X6wiFQZdzIwZoCBqOXsulsy6uhktFyPbG
	 c/UHyswYjIu2KLIrtnAUJor0vmqRE6Rvq3XQE2YVyjR0uWT60ltAGfeXem1rr5PfUYArQ
	 6MA5BA7Iyh6IxEi0utghxZ6LQZT1YlTRLhoG2cdmiwU+1DMsVYq0qCBlOyYbg+UPHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286245;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Q3Bf7hPejYm77KzY5LBwdDmysHBllhE1ydmmnF14wUA=;
	b=qRyBE3T/1+UAQR8XW8Ym+ePhqrjbdlMTEmOH/LmCyESF/6TGbWTtwfBH7wySHFIO9h8l
	 ZgGuqEYdj8pJLlH5oWYN6yCM+vGIZZRiEZLZbLxV/ntzRQHGO+50D8y5H2szFPJkDD1FN
	 SpzVH3KH8r+fT7MDA+eb7x7lnU8D9KxcV2JKPyo8A21g675JhZ1OyJih/AvEtk5zUkML/
	 oFVEK+X2P/or28G4GPU151KdPBNX0n1+JmRUg8AHKPV/2jLdY+igiKm7pMG+nfhsUXJSH
	 v2JeXWoOxKctYRWoKx5W8otS9czhzTCqOJ99gmPZNb56IcvwcSbraUyX7T3aJUd+yTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0AI0Zts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C867606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0AI0Zts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BB41F0089F;
	Tue, 10 Nov 2026 04:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286244;
	bh=Q3Bf7hPejYm77KzY5LBwdDmysHBllhE1ydmmnF14wUA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d0AI0ZtsHpXmlCEp4Hnd8YQdosjDL0EX1ROBcLVV1ZCUpnKApz0kyIi6U3YOa+/fd
	 XHVODLEamm4I7TRM1F3ep/fGItHx7Er9tbBVK0lIX4lkwGzoKKgbPVEjFSTPOuXeNa
	 g1ZDEuPlXF53SA/++sze70+sxKj1vYc5S3GQ96vJZSPrbSBF/VAV8SrBvsiN+dcRAl
	 aU+svVbsd2e4yMeo8QJPpp6y8VGLyqAEs/lKnRX9yaCcP6o97OJ/U5PBM15cEpH0CJ
	 blAysEHPvoXDJnMDcqQKqRiT66Zzvp3lf32m2R9ElzSWwVad570OafOFnOsq3vw2tW
	 S/h9eEWagxITw==
Content-Type: multipart/mixed; boundary="===============6701047358872432177=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fd43253a670294da23913a2112ff664824ddbd61176072b9f679b37d19b34672@mail.kernel.org>
In-Reply-To: <5fd460338bed03de73f4ddf8eeaa4b60f35703bf.1794269506.git.memxor@gmail.com>
References: <5fd460338bed03de73f4ddf8eeaa4b60f35703bf.1794269506.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/20] bpf: Propagate bpf_task_park() through global functions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:44 +0000 (UTC)

--===============6701047358872432177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Propagate bpf_task_park() through global functions

TL;DR: Commit message only: the claim that syscall programs' called global
functions are never extendable is inaccurate when called under
bpf_rcu_read_lock(); the conclusion still holds, so that sentence could be
dropped or narrowed.

> bpf: Propagate bpf_task_park() through global functions
>
> A global function is verified on its own, with no knowledge of its
> callers, and a call to it is checked against its declared contract
> rather than by walking into it. The two rules the previous patches
> added at the park are therefore blind to a park that happens inside a
> global function: the caller keeps its map value pointers across the
> call, and a callback may call a global function that parks. The first
> is a use after free waiting to happen, the second defeats the callback
> restriction.
>
> Record the fact per subprogram the way might_sleep and changes_pkt_data
> are recorded. The CFG pass marks the subprogram containing a
> bpf_task_park() call and merges the mark into every caller through
> merge_callee_effects(), so might_park on a subprogram means that some
> call reachable from it may park, through static and global callees
> alike. Like the other two marks it is computed before dead code
> elimination, so an unreachable park still sets it; the consequence is
> conservative, a caller that invalidates more than it had to.
>
> At a call to a global function with the mark, apply at the call site
> what the park would apply inside: refuse the call from any callback
> frame, refuse it while the caller holds a live dynptr or an iterator
> other than bpf_iter_num, and after the call invalidate the caller's
> registers that would not survive the sleep. The callee's own frame is
> covered when the callee is verified, where the park itself runs the
> checks; this patch completes them for the frames the callee cannot see.
> A global function that parks and is called from a non-sleepable
> context needs nothing new: a global function is verified once per
> calling context, and the park is registered as a sleepable kfunc.
>
> Extension programs need no further rule. An extension replacing a
> global function of a syscall program resolves to the syscall type for
> its kfunc set and could name bpf_task_park(), but an extension cannot
> be loaded sleepable, so the park is refused there as any sleepable
> kfunc is in a non-sleepable program. Behind that, bpf_check_attach_target()
> refuses to extend a function that runs without an RCU read lock, which
> is every function a syscall program actually calls, since its sleepable
> main body marks each callee as called in a sleepable context; only a
> global function that nothing calls stays extendable, and nothing would
> run it.
>
> The mark does not cross the instruction that only loads a callback's
> address, unless the program uses callx. A park in a synchronous callback
> is refused at the park, with the caller's frames in view, and an
> asynchronous callback is a root of its own, so the function that passes
> the callback does not park on its account. With the mark it would be
> treated as if it did, refused from callbacks and made to invalidate its
> caller's pointers, which matters as soon as some callback may park
> legitimately, as the body of a BPF kthread does. A loaded address may
> also be called through callx, which is a call like any other, so the mark
> follows it when the program has callx.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>

The commit message says:

> Behind that, bpf_check_attach_target()
> refuses to extend a function that runs without an RCU read lock, which
> is every function a syscall program actually calls, since its sleepable
> main body marks each callee as called in a sleepable context; only a
> global function that nothing calls stays extendable, and nothing would
> run it.

Is this description accurate?

check_func_call() records the calling context as:

	if (in_sleepable_context(env))
		sub_aux->called[BPF_FUNC_CTX_SLEEPABLE] = true;
	else if (has_rcu_read_lock(env))
		sub_aux->called[BPF_FUNC_CTX_NON_SLEEPABLE] = true;
	else
		sub_aux->called[BPF_FUNC_CTX_NO_RCU_LOCK] = true;

bpf_rcu_read_lock() is in common_btf_ids, so a syscall program can call it.
If such a program calls a global function only between bpf_rcu_read_lock()
and bpf_rcu_read_unlock(), in_sleepable_context() is false and
has_rcu_read_lock() is true, so only called[BPF_FUNC_CTX_NON_SLEEPABLE] is
set.

func_has_rcu_read_lock() then returns true, bpf_check_attach_target() lets
an extension replace that function, and the function does run.  That makes
both "every function a syscall program actually calls" and "only a global
function that nothing calls stays extendable" inaccurate.

The conclusion still holds for the first reason given, since
BPF_PROG_TYPE_EXT cannot be sleepable and check_kfunc_call() refuses the
KF_SLEEPABLE park there.  Could the "Behind that" sentence be dropped or
narrowed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============6701047358872432177==--
