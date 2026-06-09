Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3893DCD86
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039357; cv=none; b=uBOyx/X/oR5FHDHyciH7p7qs0FdKmINWD9OH/mIobphkhzn5/n9NhbD3r+Vjy/dlfwZplOoeoL68I4bLeG8akg/hUaAsZ62ozGu8JSV35piMXFO55PIB6BPIHBMMCpvRWYRQq+dm1vOUXe7U8ZAgZZB1/rwHu6es+JhFU+LlQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039357; c=relaxed/simple;
	bh=bQTf/VPzcDVfTK5BMqyBUHntdTSO+Rzt3tJLMhJvInA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pzej+dO/OLxXsUxXcCcQMi8k34KdDF/r9uhOHVsK4y3ttA2mVA1QylGgoXWT5iBd7MUEKJef7a0pLpKGgJ0FyA6v9cbttM5STQtxMcQlFTReaKMuwv9zDZMEOtIeExMxG91bNLyyp7mckXE74LEqkjxJduzcThd210iXoIuK47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRw9mrxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRw9mrxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0181F00893;
	Tue,  9 Jun 2026 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781039356;
	bh=54CpXtj2q6szzKYZ0cFHtFMHfR3/Yv9VNk2vzXFKm8g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GRw9mrxBIHMFW914UHSeYHQHzBWOWY4kJfq6zw0f9LL2qC62vfk1hDrYn7zKNR/Gu
	 7AVfLHloMNPnDCgi/RV7iLRT2a7kY8qdFSY4RNQkRw5Ub48WluhhH0dBeVW/0vWYE/
	 MOJWd9vIugBT/ANNbF4AcgiL299/QM2DGnTZc6OEVFE25X5st/oCwEaRzqodAU6goH
	 z3mPgqR5zkHPSzCu21fu4bdtS7ON5aklzclipatZp1u4H8pN4vIY3T4Ve24Mb6ozdY
	 baBvekZmuidIOnv0qDDHhQ2uI1L88Ro+lbVl0zGVPwLcRxm4vCIp205+UVgI+fUIz2
	 SdnWrTPNUxWvQ==
Content-Type: multipart/mixed; boundary="===============3594136085040134997=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62a3616a92b0f2c1f9202f3efe1d39990dd38d12159f326ebf97f088d2535a00@mail.kernel.org>
In-Reply-To: <20260609202548.3571690-4-memxor@gmail.com>
References: <20260609202548.3571690-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Exercise unsafe obj drops from tracing progs
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,utilityemal77@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 21:09:16 +0000 (UTC)

--===============3594136085040134997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> index 8e947d445f8e..8942b5478129 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c

[ ... ]

> @@ -233,6 +234,45 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
>  	return 0;
>  }
>
> +SEC("tp_btf/task_newtask")
> +__failure __msg("bpf_obj_drop cannot be used in tracing programs on types with NMI unsafe fields")
> +int BPF_PROG(task_kfunc_obj_drop_with_kptr, struct task_struct *task, u64 clone_flags)
> +{

[ ... ]

> +SEC("tp_btf/task_newtask")
> +__failure __msg("bpf_obj_drop cannot be used in tracing programs on types with NMI unsafe fields")
> +int BPF_PROG(task_kfunc_obj_drop_nmi_with_kptr, struct task_struct *task,
> +	     u64 clone_flags)
> +{

Does task_kfunc_obj_drop_nmi_with_kptr actually exercise the NMI tracing
context its name and the commit message refer to?

It uses SEC("tp_btf/task_newtask"), the same standard tracing section as
task_kfunc_obj_drop_with_kptr just above it, so it would fail at load time
for the same verifier reason rather than from an NMI-specific path.

Would an NMI context such as BPF_PROG_TYPE_PERF_EVENT / SEC("perf_event")
be needed here to actually cover the NMI tracing case?

As written the two tests appear to provide redundant coverage and leave the
intended NMI context untested.

For context, an earlier version used SEC("tp_btf/nmi_handler"), which was
x86-only; switching to SEC("tp_btf/task_newtask") fixed that portability
issue but no longer exercises any NMI context.  This was raised in review
on the list and appears unaddressed in the current version:

  https://lore.kernel.org/bpf/20260609202548.3571690-4-memxor@gmail.com

> +	struct __tasks_kfunc_map_value *local;
> +	struct task_struct *acquired, *old;
> +
> +	(void)clone_flags;
> +
> +	local = bpf_obj_new(typeof(*local));
> +	if (!local)
> +		return 0;
> +
> +	acquired = bpf_task_acquire(task);
> +	if (acquired) {
> +		old = bpf_kptr_xchg(&local->task, acquired);
> +		if (old)
> +			bpf_task_release(old);
> +	}
> +
> +	bpf_obj_drop(local);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27234422852
--===============3594136085040134997==--
