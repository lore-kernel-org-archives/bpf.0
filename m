Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075713655CC;
	Mon,  8 Jun 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917528; cv=none; b=Osd7o+nwAI3W/bWjmD3bi+awW2AGC4GbhCLTuG5dL0XiX5iGWfD+bXB7T9mSvzgolKdRpNuIGOUWMFuexQ7HEElnjDUQsgG5JGlAHZixhTGkN6h3s6U4B/RTfOqEF6sLurK3aerzzKSEP1if8ncgOa9xxZxa+/JzBJpxS2wte1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917528; c=relaxed/simple;
	bh=fgPSFmZU70J4lAyv37jgZbsIHtlby8TPTKMnoy4eeN0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RhwXX1vQF8lWQGn8u6vGxEfdhZvru+agnTr/gSZKnTdRBoNncZiQyzWhgj6731BwnqG2tucs6pfXoTBnUF6bili8B1R1H4q47HCt9LfiS6UI4fWJmh47BCFJceuNv5axBB4B9xEGnsEucvHfItF0maBmqyWEKBVkKHtbcm2SGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY5UWmeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY5UWmeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D931F00898;
	Mon,  8 Jun 2026 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917526;
	bh=kRm/fex1UGV/WyUyxxwCB+Cy/BgaxwrrURO+3519IV8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EY5UWmeT+kxsNwvu0kVV82r14S/KTDbKB/Pe740T0L850hQASc8WzYRX9Q0Do3TK0
	 AggAhq4BNdD19OICHFUDMRrYHvNQPtIcZd2r9EtIhfHwiWudCu8CgPpSmqwLDefot6
	 OPFHW1ELs8wWHTUfE4VR/z3aqFHS5BvQTFZef0rCQH588yYME0HXsAeLLGbBLM/IHq
	 vukeJsXmQbU/go5lSes7pWA+hbdeCTaw6vTTVfPDgd0GRaHlC9jE6rFvWwtO9auKnx
	 7rXIocLlZy3Ta0hH/LZYGfadryTbzBzWxVGKVe44eKaR9vy2IJd5ETbKUSfTMaNShE
	 l11oHj1JdwWUw==
Content-Type: multipart/mixed; boundary="===============2203711265836068332=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25a3cb18ab3ece4604c3de687f5ac721c299a8e44fba0c84098e6e9ab3c68741@mail.kernel.org>
In-Reply-To: <20260608103516.20643-2-yangtiezhu@loongson.cn>
References: <20260608103516.20643-2-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 11:18:46 +0000 (UTC)

--===============2203711265836068332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
> index f377d8f5c51a..33a10221d73a 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
> @@ -12,7 +12,7 @@
>
>  /*
>   * task_struct *__switch_to(task_struct *prev, task_struct *next,
> - *			    struct thread_info *next_ti, void *sched_ra, void *sched_cfa)
> + *			    void *sched_ra, void *sched_cfa)
>   */
>  	.align	5
>  SYM_FUNC_START(__switch_to)

For context, the 32-bit path biases a1 at function entry:

arch/loongarch/kernel/switch.S:__switch_to() {
	#ifdef CONFIG_32BIT
		PTR_ADDI	a0, a0, TASK_STRUCT_OFFSET
		PTR_ADDI	a1, a1, TASK_STRUCT_OFFSET
	#endif
	...
}

so on 32-bit a1 holds (task_struct + TASK_STRUCT_OFFSET).  This bias lets the
THREAD_* field accesses encoded as (FIELD - TASK_STRUCT_OFFSET) fit the 12-bit
signed load/store immediate range.

> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>  	LONG_SPTR	t8, t7, 0
>  #endif
>
> -	move	tp, a2
> +	move	tp, a1
>  	cpu_restore_nonscratch a1

On 32-bit, does this leave $tp biased by TASK_STRUCT_OFFSET?

The old code set $tp from a2 (next_ti), which was an unbiased thread_info
pointer.  The new code sets $tp from a1, and on 32-bit a1 was biased by
+TASK_STRUCT_OFFSET at entry.  a0 is un-biased before return:

arch/loongarch/kernel/switch.S:__switch_to() {
	...
	#ifdef CONFIG_32BIT
		PTR_ADDI	a0, a0, -TASK_STRUCT_OFFSET
	#endif
	jr	ra
}

but a1 is never un-biased, so $tp would hold (task_struct + TASK_STRUCT_OFFSET).

Under THREAD_INFO_IN_TASK, get_current() reads $tp directly as the raw
task_struct pointer with no offset compensation:

arch/loongarch/include/asm/current.h {
	register struct task_struct *current_thread_pointer __asm__("$tp");
	static __always_inline struct task_struct *get_current(void)
	{
		return current_thread_pointer;
	}
}

The exception-entry paths (SAVE_SOME and handle_syscall) restore $tp from
cpu_tasks, which set_current() populates with the raw, unbiased task pointer:

arch/loongarch/include/asm/switch_to.h:set_current() {
	__this_cpu_write(cpu_tasks, task);
	...
}

so everywhere except the scheduler path $tp holds the raw task_struct.

After __switch_to() returns into __schedule(), would every current->field
access on 32-bit then dereference (task_struct + TASK_STRUCT_OFFSET) until the
next exception entry reloads $tp from cpu_tasks?

The commit message says the patch "correctly neutralizes the structural
pointer bias on 32-bit platforms while cleanly falling back to 0 on 64-bit
systems."  That appears to apply to the new

	LONG_LPTR	t0, tp, (TASK_STACK - TASK_STRUCT_OFFSET)

load, but the move tp, a1 itself still stores the biased pointer into the live
current-task register.

THREAD_INFO_IN_TASK is selected unconditionally for LoongArch (no if 64BIT in
arch/loongarch/Kconfig), and CONFIG_32BIT (LA32R/LA32S) is a selectable kernel
type, so the 32-bit path is real, supported code.

Would something like

	move	tp, a1
	#ifdef CONFIG_32BIT
		PTR_ADDI	tp, tp, -TASK_STRUCT_OFFSET
	#endif

be needed here, or some other un-biasing of $tp on 32-bit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27132522999
--===============2203711265836068332==--
