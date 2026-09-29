Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B839768D
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643178; cv=none; b=Ir+vQSHl3W9lCgGEFbkwadnn4zZFfjmRJ7JAb6f3a5AWxIja3iZui77Va8sq09hIdzzhI3CKd80zPfX8MqO8wAoSd07uhWCJiuG/gGH0e5/s8ORw5QnHrei9Mg58ex7IwR0iHkGEzxg9m+Y7R7xqE9WdxnnUEKnKLgRn7Cc20kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643178; c=relaxed/simple;
	bh=oIQYzM5ycIAAoGmjBn+Vb4UK71gJ+qiZTIYhPFz04K4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n6SwFl9QdARlJm/8YNg5OpwZPXEsvDkBvPLbM4d4+aG9cQ8PYFKsUfh/MwtpHlkgKQPGre9ZY0mh7TurfnQ7SeCh6+SGkTg6D+efl6eyOhhPems/W4Vu+FW3Sm8b6EJDO51wh7c/yoHCvkYAVsu9YR01DltXmV1XjD8VODiR9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhtjdGvR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhtjdGvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD11F00893;
	Tue, 29 Sep 2026 00:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643174;
	bh=PiXcOYPTnH9094Tq2T+UkjqRptNVQHCK0lHUQ9RsLds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IhtjdGvRdfW9fw1BvE9vvBID6Co7kOCG6Kh9l1eHdffxC6mZbNSRSpT/+i0kcZ13x
	 dceSn4zYHECK44gGlDqbKFqFzZrJpGIxB573FsBlLgYnLu7WT8bN8CDmiuy0r0k35H
	 6uj3bsfSt2UMQP/M8YEoIG2N5XmfI0XnSu7ZUAMM//scR81AXgPwOi/VMeXn6LzUYP
	 3jFOetYA3aLq/y9JHPRkB2PilXFNpNv7vYpBRQgu+ILS0Hb4czTm1WpDJ6AiRIocft
	 Avv/1gm85qszgHVOdp9x5gmcj4/Jy+brxvHOfleNt0pfx8n4U4/5GCkyYTlZpmUHGE
	 v2La5wI8Yucew==
Content-Type: multipart/mixed; boundary="===============4226251970471679280=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a088778cba5c689e9024c435e0e092047176fff11c56ce6cb04d732b6073c34@mail.kernel.org>
In-Reply-To: <20260929001741.3255990-1-yonghong.song@linux.dev>
References: <20260929001741.3255990-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 19/22] selftests/bpf: Add end-to-end and negative .bpf_cleanup exception tests
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 00:52:54 +0000 (UTC)

--===============4226251970471679280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 000000000000..76cca8dc45a9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> @@ -0,0 +1,878 @@

[ ... ]

> +static __used __noinline void __kfunc_btf_anchor(void)
> +{
> +	bpf_throw(0);
> +	bpf_unwind();
> +	bpf_preempt_disable();
> +	bpf_preempt_enable();
> +	bpf_rcu_read_lock();
> +	bpf_rcu_read_unlock();
> +	bpf_unwind_resume(NULL);
> +}
> +
> +/* An unwind raised in a callee, which is how a cleanup region gets one. */
> +static __used __naked __noinline __u64 inner_unwind(void)
> +{
> +	asm volatile (
> +	"r1 = 1;"
> +	"call bpf_unwind;"
> +	"r0 = 0;"
> +	"exit;"
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 unwind_in_pad_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +"1:"	"call inner_unwind;"		/* cleanup region */
> +"2:"
> +	"call bpf_preempt_enable;"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad that unwinds again */
> +	"call bpf_preempt_enable;"
> +	"r1 = 2;"
> +	"call bpf_unwind;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 cb_and_table_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = 9;"
> +"1:"	"call bpf_unwind;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 pad_calls_thrower_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = 11;"
> +"1:"	"call bpf_unwind;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call pad_callee_that_throws;"	/* ...which can throw: refused */
> +	"call bpf_preempt_enable;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 catch_pad_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = 12;"
> +"1:"	"call bpf_unwind;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* catch pad: no resume, it stops here */
> +	"call bpf_preempt_enable;"
> +	"r0 = 0;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 stray_resume_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = 13;"
> +"1:"	"call bpf_unwind;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline __u64 pad_calls_resumer_frame(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = 14;"
> +"1:"	"call bpf_unwind;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	"call resume_in_callee;"	/* ...which resumes: refused */
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	::: __clobber_all);
> +}

[ ... ]

> +static __used __naked __noinline void gotox_unwinder(void)
> +{
> +	asm volatile (
> +	"r1 = 15;"
> +	"call bpf_unwind;"
> +	"exit;"
> +	::: __clobber_all);
> +}

This isn't a bug, but bpf_unwind() is declared as __bpf_kfunc void
bpf_unwind(void) in kernel/bpf/helpers.c and takes no arguments.

Several of these inline asm frames load r1 with a numbered value right
before calling bpf_unwind: r1=1 in inner_unwind, r1=2 in
unwind_in_pad_frame, r1=9 in cb_and_table_frame, r1=11 in
pad_calls_thrower_frame, r1=12 in catch_pad_frame, r1=13 in
stray_resume_frame, r1=14 in pad_calls_resumer_frame, and r1=15 in
gotox_unwinder.

Other bpf_unwind call sites in the same file like pad_drops_caller_lock_frame,
no_pad_keeps_own_lock_frame, and pad_drops_caller_ref_frame call bpf_unwind
without setting r1 first. The verifier checks no arguments for a zero-argument
kfunc, and neither bpf_exc_keep_exits nor the runtime walk uses r1.

Are the "r1 = N;" loads before these calls left over from an earlier
cookie-style signature? Could they be dropped so the asm matches the kfunc
prototype?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904
--===============4226251970471679280==--
