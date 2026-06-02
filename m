Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B140395AC7
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379751; cv=none; b=UfzbFCyMC3UkSwjg42h/gNj9KztypT3szjWSiqFCkt/ZB/6w8g9MlHW3EDU6oXm866JSE7L4x5zJENOc0rj9PJl6y2ytED4iv4whc6RXQwN+DOYdaXMASoa7T5NVoFbFkU8EU1KFZGkIlgEdemvd2SNnmijo+RXXUi/zKmroQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379751; c=relaxed/simple;
	bh=rpJIl5WhBl3dFSkFytFFp47nwPvhNlNsH/AaOlT26MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAV1IEE1mWy4tv+kgs0e7iYBokV4KsoKQzShA1GdzXNxpsmWun6qVlydUq0PCfp6MevnAv2n8+ToOFiadBMojydhwhZxcxuGufKj0XVZ4i+0XgcRV9/xD1NxwNLqhqnYvT2i3lbskLhjXsHoYn7WQuOQIsS/qvsgOKWHZZ4Soy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXUPS7iQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXUPS7iQ"
Message-ID: <a775c0b8-07f3-4265-8cfd-ec01ffd9efbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780379738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTx67N7FaBzchy3F7x9/VR7589t0h++mxIcV0ieEro4=;
	b=dXUPS7iQn2YkCwA+7p/eWX29zI2IC4yIFprmBgQoYCz7/C21pxVCVNF1S8wMLQbFZ9xM7J
	YJgQuuUGDOXtpjGyctFu9s9WT9WWFaRk1hyNvsUiNu7Hlh2kx5mTb4TTwki4AVVKlVAUFK
	RYzNDkETTmJkro1TOe1sBGSZXHdm60c=
Date: Mon, 1 Jun 2026 22:55:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Content-Language: en-GB
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, puranjay@kernel.org
References: <CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa3_ZenPOFkA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa3_ZenPOFkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/29/26 1:01 AM, Sanghyun Park wrote:
> bpf_find_vma() reads task->mm without holding task_lock() or taking an
> mm reference via mmget()/mmget_not_zero(). When called on a foreign task
> obtained via bpf_task_from_pid(), a concurrent exit_mm() can free the
> mm_struct between the raw pointer read and mmap_read_trylock(mm),
> resulting in a use-after-free on the mm's mmap_lock.
>
> This is the same bug class fixed by commit d8e27d2d22b6 ("bpf: fix mm
> lifecycle in open-coded task_vma iterator") for the open-coded task_vma
> iterator, but bpf_find_vma() in the same file was missed by that fix.
>
> For the current task, task->mm is stable and needs no extra reference.
> For a foreign task, use get_task_mm() which acquires task_lock(), checks
> task->mm, and calls mmget() atomically, preventing the race with
> exit_mm(). The reference is dropped via mmput() after the mmap lock is
> released.
>
> Race:
>    CPU0 (BPF program)                  CPU1 (exiting task)
>    ============================        ==========================
>    bpf_find_vma(foreign_task):
>      mm = task->mm
>      // raw read, no reference
>                                        exit_mm():
>                                          task->mm = NULL
>                                          mmput(mm) -> frees mm_struct
>      mmap_read_trylock(mm)
>      // UAF: mm is freed
>
> Reproduction:
>
>    1. Build kernel >= 5.17 with CONFIG_KASAN=y, CONFIG_BPF_SYSCALL=y
>    2. Boot in a VM (QEMU works fine)
>    3. Compile the reproducer below:
>         gcc -O2 -o repro -static repro.c -lbpf -lelf -lz
>    4. Run as root: ./repro
>    5. Check dmesg for: BUG: KASAN: slab-use-after-free in down_read_trylock
>
>    The reproducer attaches a BPF program that calls bpf_find_vma() on a
>    foreign task obtained via bpf_task_from_pid(). A racing thread
>    repeatedly fork+exit's that task, creating a window where mm is freed.
>
> KASAN report (reproduced on 6.12.91, CONFIG_PREEMPT + KASAN):
>
>    BUG: KASAN: slab-use-after-free in down_read_trylock+0x380/0x3f0
>    Read of size 8 at addr ffff888003cd2fd0 by task repro/164451
>
>    Call Trace:
>     down_read_trylock+0x380/0x3f0
>     bpf_find_vma+0xdd/0x360
>     bpf_prog_708df9c9a3e172a7_main_f+0x8b/0x9e
>     bpf_trampoline_6442513469+0x43/0xa3
>
>    Freed by task 164453:
>     kmem_cache_free+0x15d/0x4b0
>     finish_task_switch.isra.0+0x4ab/0x810
>
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> ---
> v2: Rebased onto bpf-next to fix merge conflict (no code changes).
>
>   kernel/bpf/task_iter.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e791ae065c..015399e62b 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -757,6 +757,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,
> task, u64, start,
>    struct vm_area_struct *vma;
>    bool irq_work_busy = false;
>    struct mm_struct *mm;
> + bool foreign = task != current;
>    int ret = -ENOENT;
>
>    if (flags)
> @@ -765,7 +766,12 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,
> task, u64, start,
>    if (!task)
>    return -ENOENT;
>
> - mm = task->mm;
> + if (foreign) {
> + mm = get_task_mm(task);
> + } else {
> + mm = task->mm;
> + }
> +
>    if (!mm)
>    return -ENOENT;
>
> @@ -782,6 +788,8 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,
> task, u64, start,
>    ret = 0;
>    }
>    bpf_mmap_unlock_mm(work, mm);
> + if (foreign)
> + mmput(mm);

mmput may sleep. See the code:

void mmput(struct mm_struct *mm)
{
         might_sleep();

         if (atomic_dec_and_test(&mm->mm_users))
                 __mmput(mm);
}

But bpf_find_vma may be in non-sleepable prog context (rcu context).
So the fix does not work.

Also, there is a format issue in the diff.

>    return ret;
>   }
>

