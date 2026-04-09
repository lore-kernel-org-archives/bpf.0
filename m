Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BB2309AA
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701580; cv=none; b=pFA2RYBho/ojwvslI8l4JJcQ+++rnpQCGQfbbCHbVIpn7ffVjJ6WCZspI3MVwpuOYN3QgL6scvgBZkwyT4/BRnbOnvGciZkdBJp8s6yzqJddIHaxQQ0qxxjaCSi6he9YDkrXCb0XXFaQAikW52/fk74upoXdnwdiEyuapKX0Gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701580; c=relaxed/simple;
	bh=esP9HxOkgA5GKA4ssBAkb2EPAZ4ZguuYjEK+uqlhqSA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JS081JgTvOnT3Vao4AbMDfKdWOyuZLxukioymDHuLGg/cqZjd8c/UJvwQuK0fKAESvPMz4UnVLYidai/+vehplp/jABTW4ymelHJBf7YLKA1x03szDK0FskbCm+/9nIkC4THfUQI29T9667c4R20efM1LAHPYkkeMS23icnN+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5HgnIRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5HgnIRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8B6C19421;
	Thu,  9 Apr 2026 02:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701580;
	bh=esP9HxOkgA5GKA4ssBAkb2EPAZ4ZguuYjEK+uqlhqSA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=N5HgnIRYw+gIxop1DOEU/LQ1OFa+if31fCybzFgSYI1Em+7J+FBaNmTIsi4XwiymX
	 s/VzBUVfzoRzel5SBPKrsWJcvbFADLmsU5/4BBYEbLQLokYPipqzt7d7QRfYYckdWn
	 Vw9TQbd1NUk+yAzJiHYjz5+E7UNi7+1y3zA0VrAaL3/fwOGIrtTPI+msnTz5nRMq1m
	 N2Dgp+ecqB1wq3p7vphPgVZ4xJD16cA49RD2PmSuw+jjGLrzI2HyM/FZ2sHAFOJnDd
	 kCwaTj0Jm/eYZhvWvUQTsIuscAr6NKVJ1Xgp6VVA8wm/N+UvHci2nfoJQ06s26qS3t
	 hjb5ftwKa7g7g==
Content-Type: multipart/mixed; boundary="===============5264469444886364970=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <438e59feaf2325987f2b85c36251a402ac473c9bb87c12b5cc13e404259e7813@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-8-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-8-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 08/14] bpf: record arg tracking results in bpf_liveness masks
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 02:26:19 +0000 (UTC)

--===============5264469444886364970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 4f7748720250..4457cd80d072 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static void record_stack_access_off(struct bpf_verifier_env *env,
> +				    struct func_instance *instance, s64 fp_off,
> +				    s64 access_bytes, u32 frame, u32 insn_idx)
> +{

[ ... ]

> +	if (access_bytes == S64_MIN) {
> +		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
> +		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
> +		mask = SPIS_ZERO;
> +		spis_or_range(&mask, 0, slot_hi);
> +		mark_stack_read(instance, frame, insn_idx, mask);

mark_stack_read() returns int and can fail with -ENOMEM via
alloc_frame_masks(), but this and the other call sites in
record_stack_access_off() silently discard the return value.

The same pattern repeats in record_stack_access():

> +static void record_stack_access(struct bpf_verifier_env *env,

[ ... ]

> +	if (arg->off_cnt == 0) {
> +		if (access_bytes > 0)
> +			mark_stack_read(instance, frame, insn_idx, SPIS_ALL);

and record_imprecise():

> +static void record_imprecise(struct func_instance *instance, u32 mask, u32 insn_idx)
> +{
> +	int depth = instance->callchain.curframe;
> +	int f;
> +
> +	for (f = 0; mask; f++, mask >>= 1) {
> +		if (!(mask & 1))
> +			continue;
> +		if (f <= depth)
> +			mark_stack_read(instance, f, insn_idx, SPIS_ALL);

and record_call_access():

> +static void record_call_access(struct bpf_verifier_env *env,

[ ... ]

> +		} else {
> +			for (int f = 0; f <= depth; f++)
> +				mark_stack_read(instance, f, insn_idx, SPIS_ALL);

However, later in analyze_subprog() the same commit does check the
return value:

> +				for (int f = 0; f <= depth; f++) {
> +					err = mark_stack_read(instance, f, idx, SPIS_ALL);
> +					if (err)
> +						return err;
> +				}

Is the inconsistency intentional?  If alloc_frame_masks() fails in
the recording functions, the may_read mask for that frame/instruction
is never updated, so the slot could silently appear dead to the main
verifier pass.  The existing callers of mark_stack_read()
(bpf_mark_stack_read(), propagate_to_outer_instance()) also propagate
its errors.

Similarly, in the recording loop of compute_subprog_args():

> +		commit_stack_write_marks(env, instance, idx);

commit_stack_write_marks() also returns int (can fail via
alloc_frame_masks()), and the return value is not checked here.

Should these recording functions propagate errors from
mark_stack_read() and commit_stack_write_marks() back to
compute_subprog_args(), which already has error-handling via
goto err_free?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============5264469444886364970==--
