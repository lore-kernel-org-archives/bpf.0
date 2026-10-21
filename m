Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614496;
	b=2VK2uHphE2ggyTGxzDr5XYpyNhHvoU5VMDwOde89xSYzEu8TNanHnjq9PJK5OoJNWess
	 TlTupbQan6EWOEueM390xR9TKR/bofc1Bpn0hAXd7RxGOmaJNfrLY/W80WpFM2hhi9twW
	 ynUUed15xluXOu0L4OwWPv1WkTOzJc6raqV1DbDNMNudLAnHRKHxedOpKXzV8ovH4OvZO
	 DWvB0jm6tlrmcVReaCTUHISGObYiGEZIovIi2GObu+ccHqfIMUQVy2R8hMlcImQhBypdr
	 H2nUh9kd5tCBVnXlN6imLGNsWHFGJks3z+bXMsUZ9o8zP+vYlPopUfIGxxXszGuuOGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BCGOvIOXSFvMxRwIgiBADLCmToi4crHzCiIRUh4quek=;
	b=I9TqmrkTz4Z1UWgz7Qc0H577LQS7kE0JOGlEbt2HK6E+u9qm6piGBkjq2gDA9N7qOVNY
	 fQSN1laXzkIk6kMyd1FdFWf6IewXp49AWf6ct5IV90AoM15GHNneFNWlqplEVBgvlh1Z4
	 67asdEEDX+6P0ts7W5dt/aeCbwFKLwhhcXT0xfnjtIxwUzVOIAjw7Mqq7zefpmUvaWGIp
	 JIDvTpkizK3EUzKzhiutFuEGFonkUXB8bjZjec5kpVvf5Yw4pwspx6r02OHrcBRDyzddD
	 mhbhs/HfOU0FnmFYDw9OUV+6kipm1ydc38GAqCsXFfAJ9W4FlJogkqysw+0iakQpDiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgjN7Bge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE15606A320
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgjN7Bge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC61F000C1;
	Wed, 21 Oct 2026 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614495;
	bh=BCGOvIOXSFvMxRwIgiBADLCmToi4crHzCiIRUh4quek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LgjN7BgegFqorxtLsbtxk8li2o6GKllcTmWDHdB5bn7FrPZ7ftpYQy8+J9ZDB8ynh
	 3qzEihekt+WMETZ2wUMBDt0iOTopUisJjGnxwXXlikK/I1r1KlK5R/DxLLRECVNeoY
	 zw1gPCnaU6P17SiMnXF4cc0jG6x5rDNVYhJWlAWabJXpXAVnOz+0DwUvnVcGYM8kcM
	 /3fKHQuJ8F8KheCrFNk1N6fn2jPO3EYmJZK+dWAb8DORNHbw0dnwlG9VvJWakdEb7a
	 JPchHh6fRvyYmjLPIowBTAljeahPWgQYF3ss+AJEp0IEqJbG0uufUQXywNyWG+5qSn
	 4aZw/5vWDROYw==
Message-ID: <sashiko-outbox-180642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 4/9] bpf: Add kfuncs to allocate and seal user
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, linux-mm@kvack.org, "Andrew
 Morton" <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>
In-Reply-To: <20261021195759.119421-5-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
 <20261021195759.119421-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:28:13 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: broken icache flush ordering and sync in bpf_user_page_exec()
- [Medium] bpf: READ_IMPLIES_EXEC cleared too late in bpf_user_page_alloc()
- [Medium] bpf: signed long return in bpf_user_page_alloc() is negative for=
 32-bit user addresses
- [Low] bpf: link failure on !CONFIG_MMU in bpf_user_page_exec()
--

commit bb8df072f0f4bad453d939bfbd2cb461ada4757f
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add kfuncs to allocate and seal user pages

This commit adds the sleepable bpf_user_page_alloc() and
bpf_user_page_exec() kfuncs for kprobe/uprobe BPF programs to allocate
anonymous user pages in the current process and seal individual pages as
read/execute.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4d9e9423826a9..246f4969a144a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -3739,6 +3743,127 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, =
u32 dst__sz,
>  	return ret;
>  }
> =20
> +/* vm_private_data token for the unmergeable anonymous mapping below. */
> +static char bpf_user_page_marker;
> +
> +/**
> + * bpf_user_page_alloc() - Allocate lazy anonymous pages in the current =
mm
> + * @nr_pages: Number of pages to allocate
> + *
> + * Creates a read/write anonymous mapping in the current task's address =
space.
> + * The mapping is kept non-executable even for tasks with READ_IMPLIES_E=
XEC,
> + * to avoid creating a writable executable mapping. The physical page is
> + * allocated on its first access. The mapping remains until userspace un=
maps
> + * it or the process exits.
> + *
> + * Return: The userspace address on success, or a negative error code.
> + */
> +__bpf_kfunc long bpf_user_page_alloc(unsigned long nr_pages)
> +{
> +	const unsigned long prot =3D PROT_READ | PROT_WRITE;
> +	const unsigned long flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
> +	struct mm_struct *mm =3D current->mm;
> +	unsigned long addr, populate, len;
> +	struct vm_area_struct *vma;
> +	int err;
> +
> +	if (unlikely(in_interrupt() || current->flags & (PF_KTHREAD | PF_EXITIN=
G)))
> +		return -EPERM;
> +	if (unlikely(!nmi_uaccess_okay()))
> +		return -EPERM;
> +	if (unlikely(!mm))
> +		return -EFAULT;
> +	if (unlikely(!nr_pages || nr_pages > (ULONG_MAX >> PAGE_SHIFT)))
> +		return -EINVAL;
> +
> +	len =3D nr_pages << PAGE_SHIFT;
> +	err =3D security_mmap_file(NULL, prot, flags);
> +	if (err)
> +		return err;
> +
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
> +	addr =3D do_mmap(NULL, 0, len, prot, flags,
> +		       mk_vma_flags(VMA_DONTEXPAND_BIT, VMA_DONTCOPY_BIT, VMA_DONTDUMP=
_BIT),
> +		       0, &populate, NULL);
> +	if (!IS_ERR_VALUE(addr)) {
> +		/* VM_DONTEXPAND prevents merging this mapping into another VMA. */
> +		vma =3D find_vma(mm, addr);
> +		vma_start_write(vma);
> +		if (current->personality & READ_IMPLIES_EXEC) {
> +			vm_flags_clear(vma, VM_EXEC);
> +			vma_set_page_prot(vma);
> +		}
> +		vma->vm_private_data =3D &bpf_user_page_marker;
> +	}

[Severity: Medium]
When current->personality has READ_IMPLIES_EXEC set, is clearing VM_EXEC
after do_mmap() too late?

Before bpf_user_page_alloc() clears VM_EXEC on the VMA, both
security_mmap_file() and do_mmap() evaluate the request with PROT_EXEC
implied:

security/security.c:mmap_prot()
    if (!(current->personality & READ_IMPLIES_EXEC))
        return prot;
    if (!file)
        return prot | PROT_EXEC;

mm/mmap.c:do_mmap()
    if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
        if (!(file && path_noexec(&file->f_path)))
            prot |=3D PROT_EXEC;
    ...
    mmap_region()
        if (map_deny_write_exec(&vma_flags, &vma_flags))
            return -EACCES;

Because prot becomes PROT_READ | PROT_WRITE | PROT_EXEC during those calls,
selinux_mmap_file() checks PROCESS__EXECMEM for an anonymous W+X mapping and
map_deny_write_exec() rejects the mapping with -EACCES when MMF_HAS_MDWE is
enabled, and perf_event_mmap() emits an executable PERF_RECORD_MMAP event
before VM_EXEC is cleared.

> +
> +	mmap_write_unlock(mm);
> +
> +	if (!IS_ERR_VALUE(addr) && populate)
> +		mm_populate(addr, populate);
> +	return addr;
> +}

[Severity: Medium]
On 32-bit architectures (such as x86-32), can returning addr as a signed
long in bpf_user_page_alloc() turn valid userspace addresses into negative
values?

do_mmap() returns an unsigned long where valid 32-bit user addresses in
[0x80000000, 0xfffff000) have bit 31 set and pass !IS_ERR_VALUE(addr), but
returning addr as long makes those addresses negative and indistinguishable
from error codes.

In addition, long is 64 bits wide in BPF target programs while long in a
32-bit kernel's vmlinux BTF has ret_size =3D 4, so emit_kfunc_call() in
arch/x86/net/bpf_jit_comp32.c only populates the low 32 bits of R0.

Should bpf_user_page_alloc() return s64 instead, for example returning
(long)addr when IS_ERR_VALUE(addr) is true and (s64)addr otherwise?

> +
> +/**
> + * bpf_user_page_exec() - Make a BPF-allocated user page read/execute
> + * @addr: Address of the page to change
> + *
> + * Changes a writable page created by bpf_user_page_alloc() to read/exec=
ute.
> + * The page cannot be made writable again after this call.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +__bpf_kfunc int bpf_user_page_exec(unsigned long addr)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct vm_area_struct *vma;
> +	struct page *page;
> +	int err =3D -EINVAL;

[ ... ]

> +	vma_start_write(vma);
> +
> +	err =3D get_user_pages(addr, 1, FOLL_WRITE, &page);
> +	if (err !=3D 1) {
> +		if (!err)
> +			err =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	flush_icache_user_page(vma, page, addr, PAGE_SIZE);

[Severity: High]
Does calling flush_icache_user_page() in bpf_user_page_exec() before
do_mprotect_pkey_locked() leave stale instructions in the instruction cache?

At the point where flush_icache_user_page() is called, the VMA still has
VM_READ | VM_WRITE without VM_EXEC. Several architectures gate
flush_icache_user_page() on VM_EXEC and turn this call into a no-op:

arch/riscv/include/asm/cacheflush.h:
    #define flush_icache_user_page(vma, pg, addr, len) \
    do {                                               \
        if (vma->vm_flags & VM_EXEC)                   \
            flush_icache_mm(vma->vm_mm, 0);            \
    } while (0)

arch/openrisc/include/asm/cacheflush.h:
    #define flush_icache_user_page(vma, page, addr, len) \
    do {                                                 \
        if (vma->vm_flags & VM_EXEC)                     \
            sync_icache_dcache(page);                    \
    } while (0)

arch/alpha/kernel/smp.c:flush_icache_user_page()
    if ((vma->vm_flags & VM_EXEC) =3D=3D 0)
        return;

In addition:

1. Because flush_icache_user_page() runs while the PTE is still writable and
before do_mprotect_pkey_locked() write-protects the PTE and flushes remote
TLBs, another thread in current->mm can write to addr after the icache flush
and before write access is removed.

2. On arm64 and riscv, mprotect's set_ptes() path only synchronizes caches
when PG_dcache_clean is clear on the folio and then sets PG_dcache_clean
(for example in arch/arm64/mm/flush.c:__sync_icache_dcache()). If a
multi-page allocation from bpf_user_page_alloc() is backed by a multi-page
anonymous folio (mTHP), sealing a second modified subpage of the same folio
will see PG_dcache_clean already set and skip cache maintenance unless
flush_dcache_page(page) is called to clear PG_dcache_clean.

3. On LoongArch (arch/loongarch/include/asm/cacheflush.h), both
flush_icache_user_page() and flush_dcache_page() are no-ops and set_pte()
does not emit an instruction barrier.

> +	err =3D do_mprotect_pkey_locked(addr, PAGE_SIZE, PROT_READ | PROT_EXEC,=
 -1);

[Severity: Low]
Will calling do_mprotect_pkey_locked() unconditionally in
bpf_user_page_exec() fail to link when CONFIG_BPF_SYSCALL=3Dy and
CONFIG_MMU=3Dn?

kernel/bpf/helpers.c is built whenever CONFIG_BPF_SYSCALL=3Dy, which does n=
ot
depend on CONFIG_MMU, whereas do_mprotect_pkey_locked() is only defined in
mm/mprotect.c when CONFIG_MMU=3Dy:

mm/Makefile:
    mmu-$(CONFIG_MMU) :=3D highmem.o memory.o mincore.o \
                         mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \

include/linux/mm.h declares do_mprotect_pkey_locked() without a !CONFIG_MMU
stub, and mm/nommu.c:do_mmap() allocates non-lazy physical memory that
cannot be transitioned to read/execute via page tables.

> +	if (!err) {
> +		vma =3D find_vma(mm, addr);
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +	}
> +	put_page(page);
> +out:
> +	mmap_write_unlock(mm);
> +	return err;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021195759.1194=
21-1-jolsa@kernel.org?part=3D4
