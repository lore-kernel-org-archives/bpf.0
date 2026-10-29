Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311933;
	b=OTTswlRvMY/pj4Vj7GMnpq5zeMzskD0qGXFCVCuSqDzIPZI+DeTOdeSMXWdlIRCEoci4
	 wDafh0vtGS0p6FV8AlUu9f/H9o4OLPH5MH66hWaD6pi8JRIv5Vgq837ZWBXQPnGIKtVLL
	 B5YZGx24eXuI5xApEJwQTa03sFDEYXmGpPagFADTJRIDrP9GBBtHbYvpEIrqjle/PG9io
	 N11fSGezOU0XxIn3lujEJ/KEMMdQyDbGVdSzJWSbb6WDABIohttKahYo5UaEKct0DvqS0
	 5WNcxC3890blhMHulTAitvu+PGpvqrZ2c7g9kAuONtcnMC3KsSi7UfER0bTXun6MJ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311933;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rQTsXzaRX7+0ljFV40z6eTGTsIFH1cPIAtZZ0aw7Uo4=;
	b=GDN7/5Y+zrPl0i6z9wo9INLFIq+4gwopkgjierB1vrwmW9luG1NBzVCoV/dNFmFiAfC1
	 cRRt6rTvh8XQF9frzHRi8tLLFh1zBUd7sGuKQNDNJwSxYCHw4HjVKPlC8FAqj1bWcLY+H
	 m61KNW13UPg8/rHh8f7lzmPg4ZL7FDGeQ0CGurSJI0tZXjRPxuGcoVgtdYFmTDcvNT4Dc
	 iXmUtE8x6k8ZB6vlbfJUDDtOeJxvMfe9bA8YtjGmrNSrTUSJs3Y1mBuX8HkEXNyBwkVFh
	 RjQwtKcA7YYX1I45aaAaDKGrisMEDOt478DmZFwwaN3i/5Q/Gle6SoYJhqi07gg9nFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooN8pDp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F0606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooN8pDp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E83A1F01816;
	Thu, 29 Oct 2026 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793311932;
	bh=rQTsXzaRX7+0ljFV40z6eTGTsIFH1cPIAtZZ0aw7Uo4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ooN8pDp4KF3yus8ObRbzo0tW2AKfvN640ktisMWso1/hChOhvrwrqAagb0dbJ21fS
	 96+RPAhnMIfwXhmrJT9PPcktGjBTJsxnzcHOwk2lwW8GNWoleWdPaqvVxkiVe9lYFq
	 rcRDEdgKEjpv1czBJZou6OUtXEvr8ZRPhK5LINaqGvDBDPVj714f9MA5jzxaYJOayu
	 Yn6NWOSmo+mKfUXUVO7EPpPxSf7UoKBXLnXg6q9XZGaYs5Im1GjKfIrpJEHeS/h02v
	 TCd8aJWGznD9Mfh8EmEf8OEcFF9PnSg4NbiHsu7niehnPw8gSXmRRLR13Sh83JipKI
	 rb7V9vViefx6w==
Content-Type: multipart/mixed; boundary="===============7147148259061016126=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <571f32a410a85199bc9bcecfe07a9a9b6ef425b2052643e64031dd246c13691e@mail.kernel.org>
In-Reply-To: <20261029212551.56964-3-jolsa@kernel.org>
References: <20261029212551.56964-3-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 2/8] bpf: Add user memory kfuncs
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 29 Oct 2026 22:12:12 +0000 (UTC)

--===============7147148259061016126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add user memory kfuncs

TL;DR:
- bpf_user_mmap() may return -ENOMEM for ia32 tasks (and some 64-bit tasks
  with X32_ABI) on x86, since vm_mmap() isn't called from a syscall
- Skipping arch_validate_prot() may allow mappings mmap(2) rejects, e.g.
  powerpc PROT_SAO

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1ba63a..0540e415c7dd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -3738,6 +3741,83 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,

[ ... ]

> +/**
> + * bpf_user_mmap() - Map private anonymous memory into the current process
> + * @len:  Length of the mapping
> + * @prot: PROT_* flags of mmap(2), including PROT_EXEC
> + *
> + * This maps memory by calling vm_mmap() directly. It does not invoke the
> + * mmap(2) syscall, so seccomp filters do not mediate this mapping.
> + *
> + * Return: The address of the mapping on success, -EPERM if the caller has no
> + * user mm, or an unsigned-long encoded negative error code, as returned by
> + * vm_mmap().
> + */
> +__bpf_kfunc unsigned long bpf_user_mmap(unsigned long len, unsigned long prot)
> +{
> +	if (!bpf_user_mm_ok())
> +		return -EPERM;
> +	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
> +}

Can this vm_mmap() call fail for ia32 tasks, and for 64-bit tasks when
CONFIG_X86_X32_ABI=y, because it is not made from a syscall?

On x86_64 the address picked by vm_mmap() depends on the bitness of the
current syscall:

vm_mmap()
  do_mmap()
    __get_unmapped_area()
      arch_get_unmapped_area_topdown()
          info.high_limit = get_mmap_base(0);

arch/x86/mm/mmap.c:get_mmap_base() {
    if (in_32bit_syscall()) {
        return is_legacy ? mm->mmap_compat_legacy_base
                         : mm->mmap_compat_base;
    }
    return is_legacy ? mm->mmap_legacy_base : mm->mmap_base;
}

The sleepable kprobe programs that can call this kfunc run either from
uprobe_notify_resume() -> handle_swbp() -> handler_chain() (or
uprobe_prog_run()) on the int3 return-to-user path, or from bpf_task_work
callbacks run by task_work_run().  TS_COMPAT is set only in
syscall_32_enter() and is cleared on every return to user mode, so it is
clear in all of these paths.

For an ia32 task (TIF_ADDR32) on a kernel without CONFIG_X86_X32_ABI, the
top-down search therefore runs below the 64-bit mm->mmap_base.  Everything
above 4GB is free in such a task, so the search returns an address above 4GB
and __get_unmapped_area() rejects it:

    if (addr > TASK_SIZE - len)
        return -ENOMEM;

The bottom-up legacy layout fails the same way, because find_start_end() also
starts from get_mmap_base(1).  So the kfunc always returns -ENOMEM for ia32
processes.

With CONFIG_X86_X32_ABI=y the result is the opposite.  Exception entry
stores orig_ax = -1, so in_x32_syscall() is true in the uprobe handler and
64-bit processes get the compat (below 4GB) layout.  A large len then fails
with -ENOMEM in the bottom-up fallback (end = task_size_32bit()) even though
64-bit address space is free.

The kernel documents this dependency in __set_personality_x32(): "The x86
mmap() code relies on the syscall bitness so set x32 syscall bit right here
to make in_32bit_syscall() work during exec()".  The uprobes XOL area avoids
the problem by passing an explicit TASK_SIZE - PAGE_SIZE hint.

Neither the kernel-doc ("into the current process") nor the commit message
mentions this limitation, and the selftests later in the series only exercise
64-bit binaries.  Should this limitation be handled or documented?

Also, does passing prot straight to vm_mmap() skip the architecture prot
validation that mmap(2) performs?  The kernel-doc describes @prot as "PROT_*
flags of mmap(2)", but the mmap(2) entry points call arch_validate_prot()
and the vm_mmap() path does not.  For example, on powerpc64:

arch/powerpc/kernel/syscalls.c:do_mmap2() {
    if (!arch_validate_prot(prot, addr))
        return -EINVAL;
    ...
}

arch_validate_prot() in arch/powerpc/include/asm/mman.h rejects:

- any bit outside PROT_READ|PROT_WRITE|PROT_EXEC|PROT_SEM|PROT_SAO
- PROT_SAO when !cpu_has_feature(CPU_FTR_SAO), for example on Power10
- PROT_SAO in a guest without CONFIG_PPC_PROT_SAO_LPAR

vm_mmap() -> vm_mmap_pgoff() -> do_mmap() never calls arch_validate_prot().
Instead do_mmap() -> calc_vm_prot_bits() -> arch_calc_vm_prot_bits() sets
VM_SAO for PROT_SAO without any check, and vm_get_page_prot() then adds
_PAGE_SAO to the page table entries.

So a program can create strong-access-ordering mappings that the architecture
code deliberately refuses.  The Kconfig help for PPC_PROT_SAO_LPAR warns that
using them may cause issues when migrating a guest from a host that supports
strong access ordering to one that does not.

Would it make sense to validate prot with arch_validate_prot(), or to
restrict it to PROT_READ|PROT_WRITE|PROT_EXEC?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40959191771
--===============7147148259061016126==--
