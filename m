Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA434D90A9
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537568; cv=none; b=rdqXXLu/QE8Wg5UyOfdBdHLULdsHBMkjKVsMZA7hTTfJyfT2/HJYE6me63RdVeyFNXMZc/Soopba8fMMnlf3u7htLBBU9ekabZCDeh6SNT9lnXWfsL3y8ovN7Ekxvjtd5SbqGbSivCtSLkIgUoMtOiUHJrP2Aeo1h8wxFDBzstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537568; c=relaxed/simple;
	bh=JAMUnCdmHaJM8xN4EfhAsOmc9DzbXKJLsPpV/Guz5Jw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PBzkTybbMwBXEyuvGLC0ZgJq7FQX++AC56QdGLvhWCwA9IROJTKNZo0wPbqOJTriV1EYOqwEmrdWd6SU5zInvABU8+hoJaKASnEzDA8ngUMlXvlRS6EM0jDyTs3E8naf7lzqxuLstDnuCv+eaCapov6tHMxLv6NtY6Dg/D8WgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdxDpNZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdxDpNZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CFDC2BCB0;
	Mon, 11 May 2026 22:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537568;
	bh=JAMUnCdmHaJM8xN4EfhAsOmc9DzbXKJLsPpV/Guz5Jw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gdxDpNZc4hYH2LGVMiQwL1MS6MeCak0FZK7p7LOurwxD6jWGR17BS8h7CAiRowpcX
	 AC4Zn+azMD6xwNS0x25vypVCCXXIob/eSJ9XiEBs3zTkLqsrzvOkq2qDICQ56AuQLa
	 mV+yxFm6j5qqORlBAFRONWJErSTZSZvDDs6T+aUdDm5u3o6VosUmPqoR9tw8owLVGu
	 VoYewivpq2Dcr2w2YCEfEZHn5R0iaUrYqY5XeD8gNZYHgMnWsnqZAJoyjElOoht39o
	 3FJACapcTDyVV16t3CEaepjZwaiKqZWZcHyftPl/NGibuoWjPRtrA8JqM/46O7uuDZ
	 dqsENl4YznLFQ==
Content-Type: multipart/mixed; boundary="===============4453318093253301914=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c4601c9bc4a124aaaa0c981923fb415af769be9d59ab9a9acf5505426ebbc130@mail.kernel.org>
In-Reply-To: <20260511214100.9487-3-emil@etsalapatis.com>
References: <20260511214100.9487-3-emil@etsalapatis.com>
Subject: Re: [RESEND PATCH bpf-next 2/2] selftests/bpf: libarena: Add Lev-Chase queue data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 22:12:46 +0000 (UTC)

--===============4453318093253301914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The data structure exposes three main calls. two of them are available to
> the thread owning the queue and one available to all threads in the program:
>
> lvqueue_owner_push(): Push an item to the top of the lvqueue.
> lvqueue_owner_pop(): Pop an item from the top of the lvqueue.
> lvqueue_steal(): Steal a thread from the bottom of the lvqueue from
> any thread.

The API names in the commit message don't match the actual functions.
Looking at tools/testing/selftests/bpf/libarena/include/libarena/lvqueue.h:

    int lvq_owner_push(lv_queue_t *lvq, u64 val);
    int lvq_owner_pop(lv_queue_t *lvq, u64 *val);
    int lvq_steal(lv_queue_t *lvq, u64 *val);

The functions use 'lvq_' prefix, not 'lvqueue_'.

Also, the commit message describes push/pop as operating on the 'top' and
steal as operating on the 'bottom', while the code follows the standard
Chase-Lev convention where the owner operates at 'bottom' and stealers at
'top'. In lvq_owner_push():

    b = smp_load_acquire(&lvq->bottom);
    ...
    lv_arr_put(lvq->cur, b, val);
    smp_store_release(&lvq->bottom, b + 1);

And in lvq_steal():

    t = smp_load_acquire(&lvq->top);
    ...
    if (cmpxchg(&lvq->top, t, t + 1) != t)

Could the commit message use the correct API names and clarify the
terminology to match the variable names in the code?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
> new file mode 100644
> index 000000000000..b93c4f9d1c92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/lvqueue.bpf.c
> @@ -0,0 +1,241 @@

[ ... ]

> +static inline
> +int lvq_order_init(lv_queue_t *lvq __arg_arena, int order)
> +{
> +	lv_arr_t *arr = &lvq->arr[order];
> +
> +	if (unlikely(!lvq))
> +		return -EINVAL;
> +
> +	if (order >= LV_ARR_ORDERS)
> +		return -E2BIG;

The pointer 'arr' is computed from '&lvq->arr[order]' before both the NULL
check and the bounds check. Although this pointer is never dereferenced on
the failure paths, forming a pointer more than one past the end of an array
is undefined behavior per C17 6.5.6p8.

This can occur when lvq_owner_push() calls lvq_order_init(lvq, arr->order + 1)
with arr->order + 1 == LV_ARR_ORDERS.

Since this function is marked '__arg_arena' and invoked by BPF programs, the
verifier may reject the out-of-bounds pointer arithmetic. Should the 'arr'
assignment be moved after both checks?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25699461713
--===============4453318093253301914==--
