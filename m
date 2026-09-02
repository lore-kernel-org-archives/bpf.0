Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D03612DB;
	Wed,  2 Sep 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313585; cv=none; b=uxJo+Xg7UQU3Jthh7clh7ABf238Ox/gTwj66pw8WCBpU2DFnS9o4ipTbP3nxUGz807Ve8XZGIMKZbyJMlvHkt0HGTubzKzvLhJAd/wvhAsQi1o7lvrFBb9/wQGMCNfMn6f4gH1TiQ0v8NNm+tCaS+/d04K9Stf2v/AHBlkzv+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313585; c=relaxed/simple;
	bh=rhgLIydweYB3C2eCloR0SIfdz8oK13fVGGg42bd/WUo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o8Krf+wqjRd8i2WfKqC1wrt/0KLGS1W6YT3xA3WcGjtfRdJBHMQeQlXHVo4Dgzs4V/nTEPIOnATED9djGKBgV7BsZ2P0PR8y+4QgGJ1yQf6e+YI11tlejhv1HnvZTSOOvxgLsBfWAQfoz2rgkaFxnkm045bXhhcrhDh2fmbBMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLW60DQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLW60DQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6BF1F000E9;
	Wed,  2 Sep 2026 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788313573;
	bh=C9WLwLDbKgyZLCZxRbFHIxNue4hIyGibfsJd6J+TsqU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CLW60DQe8J5q5ZHfZND+coyuC5Gpwb+c5R67iauv83ua5ZtnJDJlnBsJm8JX32Hj4
	 6PsMONuprxnpxoy6F6lFfUMQy066iEuZIB2vnOzSG+54RiB8yjfE9WYht8dLHsev06
	 lN3Vzb/iU0wumseSmDA7VGL1uj8eyv9z3MdXhD09zVNMjcpU6m2Nz5+neQ1FJLmOHd
	 dEjmtDlV9btK/ioMXboSzg6LlTFVXPT5gcegPHT3rt7IiZJsR1lBv/ijtI+Uegj9rq
	 anMIU+uYWDxjhnp4d8Yh+8whr+65wvUuOJy3CFEh90zR/ZsvHRkOTHTWxPkx8ADvIe
	 hZ2qxJ+wB1sKQ==
Content-Type: multipart/mixed; boundary="===============8589649180634845869=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3f457ea1e335eaf3c4cc867c467adc5ebf33a3481f7bd37c93c8d4d427cd40f@mail.kernel.org>
In-Reply-To: <20260902005106.22187-1-yangtiezhu@loongson.cn>
References: <20260902005106.22187-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf v1 RESEND] bpf: Fix timer_lockup deadlock using atomic_fetch_inc()
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 01:46:12 +0000 (UTC)

--===============8589649180634845869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc875..7d89dc143883 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1591,9 +1591,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
>  	 */
>  	if (!cur_t)
>  		goto drop;
> -	atomic_inc(&t->cancelling);
> -	/* Need full barrier after relaxed atomic_inc */
> -	smp_mb__after_atomic();
> +	atomic_fetch_inc(&t->cancelling);
>  	inc = true;
>  	if (atomic_read(&cur_t->cancelling)) {
>  		/* We're cancelling timer t, while some other timer callback is

The commit message states:

> Instead of relying on arch-specific macro implementations which may vary
> in strictness, fix this issue directly in the BPF core helper by replacing
> atomic_inc() and smp_mb__after_atomic() with a single atomic_fetch_inc()
> to provide full ordering natively.
> ...
> making the lockless deadlock detection logic immune to any
> platform-level barrier interpretation variations.

Is this rationale consistent with the atomic API documentation?
Documentation/atomic_t.txt:208-216 states that atomic_fetch_inc() is
equivalent to:

    smp_mb__before_atomic();
    atomic_fetch_add_relaxed();
    smp_mb__after_atomic();

The generic implementation in include/linux/atomic/atomic-arch-fallback.h
shows that atomic_fetch_inc() expands to __atomic_pre_full_fence() +
relaxed RMW + __atomic_post_full_fence(), where those fences are defined
as smp_mb__before_atomic() and smp_mb__after_atomic() in
include/linux/atomic.h:50-55.

On architectures that only supply the *_relaxed RMW variants, the new line
re-expands to exactly the sequence the patch deleted. The claim that this
makes the code "immune to any platform-level barrier interpretation
variations" and provides "full ordering natively" does not follow from the
API contract.

The patch does fix the reported LoongArch lockup, but only because
arch/loongarch/include/asm/atomic-amo.h emits the fully-ordered fetch
variant as amadd_db.w when CONFIG_CPU_HAS_AMO is set.

The actual contract violation appears to be in the architecture.
Documentation/atomic_t.txt:190-206 defines smp_mb__after_atomic() as a
barrier that augments the ordering inherent to the op, with
smp_mb__after_atomic() ordering all later accesses against the RMW op.
arch/loongarch/include/asm/barrier.h:60-61 defines both as plain
barrier(), while arch/loongarch/include/asm/atomic-amo.h's void-returning
ATOMIC_OP emits am<op>.w with no _db suffix - unordered. That combination
breaks the documented contract for every user, and there are approximately
270 smp_mb__after_atomic() call sites under kernel/, mm/, net/, fs/, lib/
and drivers/ that rely on it.

Fixing only this one BPF helper hides the arch bug rather than fixing it.
Should the fix go to arch/loongarch/include/asm/barrier.h instead, or does
the commit message need to justify why the arch macro is considered
permissibly weak?

The patch also deletes the only in-code record of the ordering requirement:

> -	atomic_inc(&t->cancelling);
> -	/* Need full barrier after relaxed atomic_inc */
> -	smp_mb__after_atomic();
> +	atomic_fetch_inc(&t->cancelling);

Nothing in the resulting code indicates that the value-returning variant
was chosen purely for its full-ordering semantics, so the line reads as a
plain refcount bump with a discarded return value. The store-load pairing
is the whole mechanism: t->cancelling must be globally visible before
cur_t->cancelling is read, otherwise two callbacks cancelling each other
both read 0 and both enter the unbounded wait in hrtimer_cancel()
(kernel/time/hrtimer.c hrtimer_cancel()).

A discarded-return-value RMW is an obvious target for a later unused
result cleanup back to atomic_inc(), which would silently reintroduce
exactly the lockup this commit fixes. Discarding a fetch op's result is
rare in core code - the only other instances are plain counters
(drivers/gpu/drm/drm_file.c:383, drivers/accel/drm_accel.c:129), none of
them ordering-motivated.

Would it make sense to keep a one-line comment on the new statement
explaining that atomic_fetch_inc() is used (return value ignored) for its
full ordering against the atomic_read() of cur_t->cancelling that follows?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33578169526
--===============8589649180634845869==--
