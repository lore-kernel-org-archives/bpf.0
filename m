Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E52C032C;
	Tue, 11 Aug 2026 04:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423294; cv=none; b=EpEv4Pp2yqVmfynlgvzgRNQzlZwDWmcjU9ShtgiA73J7X/xT6MKj4h1lH5jp4AzbXfuVhAokI9l1R1Ay4HuVlc3MigPOY5c4nL37CQrOP2M+4uk4LNIXOSdPM39e6fYIafCAijtLPQwdjDbO4HobN2t4R6Gr7Y4aNVVnHAfW+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423294; c=relaxed/simple;
	bh=bAqYbBhZjwhNVKy3FeyaGQVXxIZByhj9THKeaY8b5x4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WbJE4WAOH7gL7bLUyHqDUHpOJ2VcmL9V/hElpgAWZj++JNY47nTXSpJZyxqqFzkaEL2ZNFkKum97Nbb2XFLW7MO8L6frXjLma4XFg/aHBN4K9SpdNOuhWuyTIdSNQTNoCkdaHY9UzWqZQAH8DbR8Zo6ZfrukdGH5Ms4GkKUDOD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWm+9Qkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWm+9Qkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B8B1F000E9;
	Tue, 11 Aug 2026 04:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786423293;
	bh=Bq7zIpdiDC6ha4zXitwqMece8LycbMp4UrIwfL4R7FU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HWm+9QkkB3Gnml6qnrE5K63yR7aXlFW1S7TR7khDpf7XTnsT0IlBeoE0VwZBWLFgR
	 Hx0JphlLOa+kiQavAFppNT3fBFpfM+1r7VcgNPW0IYbYNiL/0cTiVcTtpLwlgVQOZN
	 PtrxQb0cTPafk86/M1XP2lHUN1SCn+ddnHVKlwnaR0n+5eYkBEYpx7oJLJ2A8mHGu8
	 Yb5pmhe4BlrZqysqp7SX5/xym/t/KMe+LmnfeJmw8jUaAgKbmKHlXj2xeXlOi38mab
	 lokGc16wT4/Ru62mpWdh66RRfwBnJarI0jM5qLVU+2RMV+B3bprVFDPnacYGqUpkAc
	 7FnSLZkwiuzJg==
Content-Type: multipart/mixed; boundary="===============6798297792273501143=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ac6ad5d1acfbf15bc536519ba1fc748ea85ece109397bbb50e56cdffb9ce726@mail.kernel.org>
In-Reply-To: <20260811035955.132989-3-dingning04@gmail.com>
References: <20260811035955.132989-3-dingning04@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test RCU iterator state pruning
From: bot+bpf-ci@kernel.org
To: dingning04@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,dingning04@gmail.com,zhouchuyi@bytedance.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 04:41:31 +0000 (UTC)

--===============6798297792273501143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test RCU iterator state pruning
>
> Add a path where RCU protection reaches zero and then starts again.
> The iterator is untrusted after this gap and must be rejected.
>
> Signed-off-by: Ning Ding <dingning04@gmail.com>

This isn't a bug, but could the changelog mention why BPF_F_TEST_STATE_FREQ
is needed and that both arms deliberately converge with the same RCU lock
depth, so a future reader knows what keeps this test meaningful?

> diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
> index fe3663dedbe1..566a1d3dffea 100644
> --- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
> +++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
> @@ -61,6 +61,52 @@ int BPF_PROG(iter_tasks_lock_and_unlock)
>  	return 0;
>  }
>
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("expected an RCU CS when using bpf_iter_task_next")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +int BPF_PROG(iter_tasks_rcu_state_pruning)
> +{
> +	struct bpf_iter_task it;
> +
> +	asm volatile (
> +		"call %[bpf_rcu_read_lock];"
> +		"r1 = %[it];"
> +		"r2 = 0;"
> +		"r3 = 0;" /* BPF_TASK_ITER_ALL_PROCS */
> +		"call %[bpf_iter_task_new];"
> +
> +		"call %[bpf_get_prandom_u32];"
> +		"if w0 == 0 goto unprotected_%=;"
> +
> +		/* Keep the outer RCU lock active on the straight-line path. */
> +		"call %[bpf_rcu_read_lock];"
> +		"call %[bpf_rcu_read_unlock];"

This isn't a bug, but would it help to say what the nested lock/unlock
pair is for here - e.g. that it scratches the caller-saved registers so
the only state difference at merge_ is the iterator's MEM_RCU vs
PTR_UNTRUSTED type?

> +		"goto merge_%=;"
> +
> +	"unprotected_%=:"
> +		/* Create an unprotected gap on the taken path. */
> +		"call %[bpf_rcu_read_unlock];"
> +		"call %[bpf_rcu_read_lock];"
> +
> +	"merge_%=: r1 = %[it];"
> +		"call %[bpf_iter_task_next];"
> +		"r1 = %[it];"
> +		"call %[bpf_iter_task_destroy];"
> +		"call %[bpf_rcu_read_unlock];"
> +		:
> +		: __imm_ptr(it),
> +		  __imm(bpf_get_prandom_u32),
> +		  __imm(bpf_iter_task_new),
> +		  __imm(bpf_iter_task_next),
> +		  __imm(bpf_iter_task_destroy),
> +		  __imm(bpf_rcu_read_lock),
> +		  __imm(bpf_rcu_read_unlock)
> +		: __clobber_common
> +	);
> +
> +	return 0;
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31457825387
--===============6798297792273501143==--
