Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A73D0916;
	Wed,  8 Apr 2026 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656161; cv=none; b=uusuhvEEj3k8+vOx63zVvcicip11x9E83S208ae0WwX7xiX2qSf/CiI/QOD52c8+Km2Oeee+D5y0bdtXP4nrA3WHQgZZz74frCHOcaLS5hEBqTv2LSA+sw77JKrj4wgmfSNczwFxNG/DTqOszGNiy30gVkVaGWZrQsHG9nMaNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656161; c=relaxed/simple;
	bh=8gRJp9QAYSyyDY06/q5cdAtJuxc/ookvWoLfeNQv9D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbjHfBBUh3Hu8goc/qbGz6xPN05zQuzwmjGRm19xmMO2wopoG+scDdbhz4wnKcY8MEAOJeG+YoyWTLNP7KafprB2XiY71RXf8afF1y+9qy90HISMjrOOd6PrLrIgeCaQVdx/J6QSJGoLXusE8s9EtEe9czpUp9MDdqkYdrz1aeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC2tYDyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC2tYDyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D40C19421;
	Wed,  8 Apr 2026 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656160;
	bh=8gRJp9QAYSyyDY06/q5cdAtJuxc/ookvWoLfeNQv9D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lC2tYDyWBXEaQSWEUcdOIYULmre7wupFQwHAuzThRrcxBC4vXsrLEvtdX0BFZUfsf
	 C61GmAGzZ8RHx03JI6N0REAQPJsfPeg++sucwlOzAjqFPGDLW4j1graN3QpwXryxAz
	 4khYchbkUJ7swaoxNHOCgsCXm9HHLDZktsvCrurOANt+B8FWp+N7mFutWgHDSNT/l/
	 r3h1yk07Oe+ALOOpakkOaF4iIxX2INVPnZDSBZGaW4Xw3/o8FFbWLHc4dSr+hDnfPo
	 wAJ70PHQCKK3r6UkEkNr3IkIruL1iYJBJN8+imWUHrHwtgBkG1Xkp0OB+m/pwzKSu2
	 I0Ah3Csoo/5Lw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Song Liu <song@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Puranjay Mohan
 <puranjay12@gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Avoid faultable build ID reads under mm locks
In-Reply-To: <20260407223003.720428-1-ihor.solodrai@linux.dev>
References: <20260407223003.720428-1-ihor.solodrai@linux.dev>
Date: Wed, 08 Apr 2026 14:49:08 +0100
Message-ID: <m25x611s17.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> Sleepable build ID parsing can block in __kernel_read() [1], so the
> stackmap sleepable path must not call it while holding mmap_lock or a
> per-VMA read lock.
>
> The issue and the fix are similar to a recent procfs patch [2].
>
> Resolve each covered VMA with a stable read-side reference, preferring
> lock_vma_under_rcu() and falling back to mmap_read_lock() only long
> enough to acquire the VMA read lock. Take a reference to the backing
> file, drop the VMA lock, and then parse the build ID through
> (sleepable) build_id_parse_file().
>
> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>
> Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
> Assisted-by: Codex:gpt-5.4
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---
>
> Below is a sequence of events leading up to this patch.
>
> I noticed a following deadlock splat on bpf-next, when running a
> subset of selftests/bpf:
>
>   #526     uprobe_multi_test:OK
>   #28      bpf_obj_id:OK
>   [   27.561465]
>   [   27.561603] ======================================================
>   [   27.561899] WARNING: possible circular locking dependency detected
>   [   27.562193] 7.0.0-rc5-g0eeb0094ba03 #3 Tainted: G           OE
>   [   27.562523] ------------------------------------------------------
>   [   27.562820] uprobe_multi/561 is trying to acquire lock:
>   [   27.563071] ff1100010768ba18 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: netfs_start_io_read+0x24/0x110
>   [   27.563556]
>   [   27.563556] but task is already holding lock:
>   [   27.563845] ff1100010b12a640 (&mm->mmap_lock){++++}-{4:4}, at: stack_map_get_build_id_offset+0xfa/0x650
>   [   27.564296]
>   [   27.564296] which lock already depends on the new lock.
>   [   27.564296]
>   [   27.564696]
>   [   27.564696] the existing dependency chain (in reverse order) is:
>   [   27.565044]
>   [   27.565044] -> #1 (&mm->mmap_lock){++++}-{4:4}:
>   [   27.565340]        __might_fault+0xa3/0x100
>   [   27.565572]        _copy_to_iter+0xdf/0x1520
>   [   27.565786]        copy_page_to_iter+0x1c6/0x2d0
>   [   27.566011]        filemap_read+0x5f7/0xbf0
>   [   27.566218]        netfs_file_read_iter+0x1ca/0x240
>   [   27.566453]        vfs_read+0x482/0x9e0
>   [   27.566658]        ksys_read+0x115/0x1f0
>   [   27.566852]        do_syscall_64+0xde/0x390
>   [   27.567057]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [   27.567322]
>   [   27.567322] -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>   [   27.567701]        __lock_acquire+0x1529/0x2a10
>   [   27.567923]        lock_acquire+0xd7/0x280
>   [   27.568124]        down_read_interruptible+0x55/0x340
>   [   27.568368]        netfs_start_io_read+0x24/0x110
>   [   27.568622]        netfs_file_read_iter+0x191/0x240
>   [   27.568858]        __kernel_read+0x401/0x850
>   [   27.569068]        freader_fetch+0x19b/0x790
>   [   27.569279]        __build_id_parse+0xde/0x580
>   [   27.569528]        stack_map_get_build_id_offset+0x248/0x650
>   [   27.569802]        __bpf_get_stack+0x653/0x890
>   [   27.570019]        bpf_get_stack_sleepable+0x1d/0x30
>   [   27.570257]        bpf_prog_51bb4c0f31ae471b_uprobe_sleepable+0x2d/0x42
>   [   27.570594]        uprobe_prog_run+0x425/0x870
>   [   27.570816]        uprobe_multi_link_handler+0x58/0xb0
>   [   27.571062]        handler_chain+0x234/0x1270
>   [   27.571275]        uprobe_notify_resume+0x4de/0xd60
>   [   27.571542]        exit_to_user_mode_loop+0xe0/0x480
>   [   27.571785]        exc_int3+0x1bd/0x260
>   [   27.571973]        asm_exc_int3+0x39/0x40
>   [   27.572169]
>   [   27.572169] other info that might help us debug this:
>   [   27.572169]
>   [   27.572571]  Possible unsafe locking scenario:
>   [   27.572571]
>   [   27.572854]        CPU0                    CPU1
>   [   27.573074]        ----                    ----
>   [   27.573293]   rlock(&mm->mmap_lock);
>   [   27.573502]                                lock(&sb->s_type->i_mutex_key#8);
>   [   27.573846]                                lock(&mm->mmap_lock);
>   [   27.574135]   rlock(&sb->s_type->i_mutex_key#8);
>   [   27.574364]
>   [   27.574364]  *** DEADLOCK ***
>   [   27.574364]
>   [   27.574671] 3 locks held by uprobe_multi/561:
>   [   27.574884]  #0: ffffffff852e0038 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: uprobe_notify_resume+0x229/0xd60
>   [   27.575371]  #1: ffffffff852e0038 (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: uprobe_prog_run+0x239/0x870
>   [   27.575874]  #2: ff1100010b12a640 (&mm->mmap_lock){++++}-{4:4}, at: stack_map_get_build_id_offset+0xfa/0x650
>   [   27.576342]
>   [   27.576342] stack backtrace:
>   [   27.576578] CPU: 7 UID: 0 PID: 561 Comm: uprobe_multi Tainted: G           OE       7.0.0-rc5-g0eeb0094ba03 #3 PREEMPT(full)
>   [   27.576586] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>   [   27.576588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
>   [   27.576591] Call Trace:
>   [   27.576595]  <TASK>
>   [   27.576598]  dump_stack_lvl+0x54/0x70
>   [   27.576606]  print_circular_bug+0x2e8/0x300
>   [   27.576616]  check_noncircular+0x12e/0x150
>   [   27.576628]  __lock_acquire+0x1529/0x2a10
>   [   27.576642]  ? __pfx_walk_pgd_range+0x10/0x10
>   [   27.576651]  ? srso_return_thunk+0x5/0x5f
>   [   27.576656]  ? lock_acquire+0xd7/0x280
>   [   27.576661]  ? avc_has_perm_noaudit+0x38/0x1f0
>   [   27.576672]  lock_acquire+0xd7/0x280
>   [   27.576677]  ? netfs_start_io_read+0x24/0x110
>   [   27.576685]  ? srso_return_thunk+0x5/0x5f
>   [   27.576693]  ? netfs_start_io_read+0x24/0x110
>   [   27.576698]  down_read_interruptible+0x55/0x340
>   [   27.576702]  ? netfs_start_io_read+0x24/0x110
>   [   27.576707]  ? __pfx_cmp_ex_search+0x10/0x10
>   [   27.576716]  netfs_start_io_read+0x24/0x110
>   [   27.576723]  netfs_file_read_iter+0x191/0x240
>   [   27.576731]  __kernel_read+0x401/0x850
>   [   27.576741]  ? __pfx___kernel_read+0x10/0x10
>   [   27.576752]  ? __pfx_fixup_exception+0x10/0x10
>   [   27.576761]  ? srso_return_thunk+0x5/0x5f
>   [   27.576766]  ? lock_is_held_type+0x76/0x100
>   [   27.576773]  ? srso_return_thunk+0x5/0x5f
>   [   27.576777]  ? mtree_range_walk+0x421/0x6c0
>   [   27.576785]  freader_fetch+0x19b/0x790
>   [   27.576793]  ? mt_find+0x14b/0x340
>   [   27.576801]  ? __pfx_freader_fetch+0x10/0x10
>   [   27.576805]  ? mt_find+0x29a/0x340
>   [   27.576810]  ? mt_find+0x14b/0x340
>   [   27.576820]  __build_id_parse+0xde/0x580
>   [   27.576832]  ? __pfx___build_id_parse+0x10/0x10
>   [   27.576850]  stack_map_get_build_id_offset+0x248/0x650
>   [   27.576863]  __bpf_get_stack+0x653/0x890
>   [   27.576867]  ? __pfx_stack_trace_consume_entry+0x10/0x10
>   [   27.576880]  ? __pfx___bpf_get_stack+0x10/0x10
>   [   27.576884]  ? lock_acquire+0xd7/0x280
>   [   27.576889]  ? uprobe_prog_run+0x239/0x870
>   [   27.576895]  ? srso_return_thunk+0x5/0x5f
>   [   27.576899]  ? stack_trace_save+0xae/0x100
>   [   27.576908]  bpf_get_stack_sleepable+0x1d/0x30
>   [   27.576913]  bpf_prog_51bb4c0f31ae471b_uprobe_sleepable+0x2d/0x42
>   [   27.576919]  uprobe_prog_run+0x425/0x870
>   [   27.576927]  ? srso_return_thunk+0x5/0x5f
>   [   27.576933]  ? __pfx_uprobe_prog_run+0x10/0x10
>   [   27.576937]  ? uprobe_notify_resume+0x413/0xd60
>   [   27.576952]  uprobe_multi_link_handler+0x58/0xb0
>   [   27.576960]  handler_chain+0x234/0x1270
>   [   27.576976]  ? __pfx_handler_chain+0x10/0x10
>   [   27.576988]  ? srso_return_thunk+0x5/0x5f
>   [   27.576992]  ? __kasan_kmalloc+0x72/0x90
>   [   27.576998]  ? __pfx_ri_timer+0x10/0x10
>   [   27.577003]  ? timer_init_key+0xf5/0x200
>   [   27.577013]  uprobe_notify_resume+0x4de/0xd60
>   [   27.577025]  ? uprobe_notify_resume+0x229/0xd60
>   [   27.577030]  ? __pfx_uprobe_notify_resume+0x10/0x10
>   [   27.577035]  ? srso_return_thunk+0x5/0x5f
>   [   27.577039]  ? atomic_notifier_call_chain+0xfc/0x110
>   [   27.577047]  ? srso_return_thunk+0x5/0x5f
>   [   27.577051]  ? notify_die+0xe5/0x130
>   [   27.577056]  ? __pfx_notify_die+0x10/0x10
>   [   27.577063]  ? srso_return_thunk+0x5/0x5f
>   [   27.577071]  exit_to_user_mode_loop+0xe0/0x480
>   [   27.577076]  ? asm_exc_int3+0x39/0x40
>   [   27.577083]  exc_int3+0x1bd/0x260
>   [   27.577090]  asm_exc_int3+0x39/0x40
>   [   27.577095] RIP: 0033:0x6c4180
>   [   27.577100] Code: c6 05 0b 6f 32 00 01 5d c3 90 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa eb 8a 66 2e 0f 1f 84 00 00 00 00 00 <cc> 48 89 e5 31 c0 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 31 c0
>   [   27.577104] RSP: 002b:00007ffcbf71ada8 EFLAGS: 00000246
>   [   27.577109] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fec9163db7b
>   [   27.577112] RDX: 00007ffcbf71adbf RSI: 0000000000001000 RDI: 00000000007f0000
>   [   27.577115] RBP: 00007ffcbf71add0 R08: 00007fec91731330 R09: 00007fec9178d060
>   [   27.577118] R10: 00007fec9153ad98 R11: 0000000000000202 R12: 00007ffcbf71af08
>   [   27.577120] R13: 0000000000787760 R14: 00000000009eade8 R15: 00007fec917bf000
>   [   27.577135]  </TASK>
>   #54/1    build_id/nofault-paged-out:OK
>
> It was reproducable, which allowed me to bisect to commit
> 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable
> context")
>
> Then I used Codex for analysis of the splat, patch and relevant lore
> discussions, and then asked it to produce a patch draft.
>
> I then asked Puranjay to review the draft, and he advised to use
> lock_vma_under_rcu() here, which seems appropriate. I also did a bit
> of refactoring of the LLM-produced code.
>
> I verified the resulting patch fixes the deadlock splat.
>
> ---
>  kernel/bpf/stackmap.c | 80 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..017ecbc22c96 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/btf_ids.h>
>  #include <linux/buildid.h>
> +#include <linux/mmap_lock.h>
>  #include "percpu_freelist.h"
>  #include "mmap_unlock_work.h"
>  
> @@ -152,6 +153,65 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>  			 : build_id_parse_nofault(vma, build_id, NULL);
>  }
>  
> +static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id_offs)
> +{
> +	id_offs->status = BPF_STACK_BUILD_ID_IP;
> +	memset(id_offs->build_id, 0, BUILD_ID_SIZE_MAX);
> +}

As you will be doing another version, can you put this refactoring in a
preparatory patch.

> +
> +static struct vm_area_struct *stack_map_lock_vma(struct mm_struct *mm, unsigned long ip)
> +{
> +	struct vm_area_struct *vma;
> +
> +	vma = lock_vma_under_rcu(mm, ip);
> +	if (vma)
> +		return vma;
> +
> +	mmap_read_lock(mm);

This will deadlock if the caller already holds mmap_lock, shouldn't this
be:
        if (!mmap_read_trylock(mm))
                return NULL;

similar to the non-sleepable path?

> +	vma = find_vma(mm, ip);
> +	if (range_in_vma(vma, ip, ip) && vma_start_read_locked(vma))

I think this will not compile for !CONFIG_PER_VMA_LOCK as there is no
stub for vma_start_read_locked().


Also, lock_vma_under_rcu() returns NULL if address is not in vma's
range, I think if replace find_vma() with vma_lookup(), you will not
need any calls to range_in_vma(). (but please validate this as I am not
sure)

> +		goto out;
> +
> +	vma = NULL;
> +out:
> +	mmap_read_unlock(mm);
> +
> +	return vma;
> +}
> +
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	struct file *file;
> +	u64 ip;
> +
> +	for (u32 i = 0; i < trace_nr; i++) {
> +		ip = READ_ONCE(id_offs[i].ip);
> +		vma = stack_map_lock_vma(mm, ip);
> +		if (!range_in_vma(vma, ip, ip) || !vma->vm_file) {

stack_map_lock_vma() already guarantees that any non-NULL return
contains the IP as lock_vma_under_rcu() checks address < vma->vm_start
 || address >= vma->vm_end at mmap_lock.c:332 and fallback explicitly
checks range_in_vma(vma, ip, ip) before returning 

> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			if (vma)
> +				vma_end_read(vma);
> +			continue;
> +		}

This is doing lock->unlock + finding vma for every ip, but the non
sleepable path has an optimization which we should do here as well.
As frames in the same library or executable will have the same file.

something like:

-- 8< --

                /* Snapshot VMA fields before dropping the lock */
                vm_start = vma->vm_start;
                vm_pgoff = vma->vm_pgoff;
                file = vma->vm_file;

                if (file == prev_file) {
                        /* Same backing file as previous frame, reuse build ID */
                        memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
                        vma_end_read(vma);
                } else {
                        get_file(file);
                        vma_end_read(vma);

                        /* build_id_parse_file() may block on filesystem reads */
                        if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
                                stack_map_build_id_set_ip(&id_offs[i]);
                                fput(file);
                                continue;
                        }
                        memcpy(prev_build_id, id_offs[i].build_id, BUILD_ID_SIZE_MAX);
                        if (prev_file)
                                fput(prev_file);
                        prev_file = file;
                }

                id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
                id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
        }

        if (prev_file)
                fput(prev_file);

-- >8 --

P.S. - Above code is not even compile tested.

> +		file = get_file(vma->vm_file);
> +		vma_end_read(vma);

AI is right, we need to snapshot vm_pgoff and vm_start before vma_end_read()

> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +		} else {
> +			id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
> +			id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> +		}
> +
> +		fput(file);
> +	}
> +}
> +
>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -165,23 +225,26 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  					  u32 trace_nr, bool user, bool may_fault)
>  {
> -	int i;
>  	struct mmap_unlock_irq_work *work = NULL;
>  	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
> +	bool has_user_ctx = user && current && current->mm;
>  	struct vm_area_struct *vma, *prev_vma = NULL;
>  	const char *prev_build_id;
> +	int i;
> +
> +	if (may_fault && has_user_ctx) {
> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
> +		return;
> +	}
>  
>  	/* If the irq_work is in use, fall back to report ips. Same
>  	 * fallback is used for kernel stack (!user) on a stackmap with
>  	 * build_id.
>  	 */
> -	if (!user || !current || !current->mm || irq_work_busy ||
> -	    !mmap_read_trylock(current->mm)) {
> +	if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
>  		/* cannot access current->mm, fall back to ips */
> -		for (i = 0; i < trace_nr; i++) {
> -			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> -			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
> -		}
> +		for (i = 0; i < trace_nr; i++)
> +			stack_map_build_id_set_ip(&id_offs[i]);
>  		return;
>  	}
>  
> @@ -196,8 +259,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  		vma = find_vma(current->mm, ip);
>  		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>  			/* per entry fall back to ips */
> -			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> -			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
> +			stack_map_build_id_set_ip(&id_offs[i]);
>  			continue;
>  		}
>  build_id_valid:
> -- 
> 2.53.0
