Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693995;
	b=qQaTVujv6kySAeRDBOplM4oAJ6yYaM5REKPpBbA1B6BdYNQD1GEczeQ1EZlWiyvL4VnR
	 fLdJERf3kF8Waap792UmZUt9lIfkInKr6EBjDsvD3eCBYOuN3Zf8rlCnevWxhh81MGek9
	 zLOUrOAeeyiXT0BQQp/8OHsxw4jCg3WiCNtWaSWwMRdYFrvAE11wpnSd8sy2rMkfiDUm8
	 cI7LBM9sekXyVUVZQF5IdGYeYbn+aLBUJ50/pPRzp5DiRNZ9YsTyBmCI+R7IeFJoITQvJ
	 Srhn1rwjnvLInjIyWT+AUCZDV4qnQh4tDhTTFhw4ImVi5oRrFkcpkWfLtBLQ6gq3qgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QV8OQbqEgAbxmMI7EXk6eiYDzzCN82f0lLhovGPvCRE=;
	b=S61Mzo5R+1oP8MXW4hWjnXITQSY22UMdbF9zo8pQoJUdXE0v9VNk1Bw8HjZl1Em6yN95
	 WVTJTuOVmTkADP7ZrwsBV9tj+g0M/xPAA6x/T47BTazjztPTEsTX4s/pmbPHTGCOWtLDB
	 zUJ0vDmoKxNgjLhjx9P7lBeBr61RmjCbLMqO6nqgk9ADE8qICo8Tw5CZBQJ4Pph7beMpi
	 P1JlYByA01krfu4JQqQmIAkTPeLZx+UEsWxlWrm4l+Qy1eY8oDNV86bzGSvGG/ZShFD7c
	 DMstviLXfOFsmJJgJqy10S893L74nW1vfaHQ3mzLhu3DKmjlly9qPUblklph8dh9nDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwvsNrut;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E71606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwvsNrut
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A628D1F000C1;
	Tue,  3 Nov 2026 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693995;
	bh=QV8OQbqEgAbxmMI7EXk6eiYDzzCN82f0lLhovGPvCRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwvsNrutpfuguMNeSWIfyUqAD6nD8ZT9TCHfXU8MutBmcDYL52Gx9TFwpiQDeupjL
	 K0m0fV2+WdZtu9vmW3bmnlagk02Yei7S0mswVuuLWC60pb5yw36MyhFyofDH76wGxW
	 x+uJ1t61RO8ODByH58EpcoSGcVAP005yfKsyup6lmrJlxsgfT8Ttd++O6b1K8QS/4i
	 etvXnQfakTB4/uEf/tvpFktS2Kfk8G8bwsha9Uvf8NSX1VJp0G8lma61PJcM+KrVKk
	 pY6IWZiBUfgt3hH1NmEP1WE7WEob2sknt0Nlq150u24xhYzstaQhkr/Dwnx/iEOone
	 YhoJ/JH6gZvTA==
Message-ID: <sashiko-outbox-194818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 2/8] bpf: Add user memory kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Federico
 Di Pierro" <nierro92@gmail.com>
In-Reply-To: <20261103075916.100050-3-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:19:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: bpf_user_vm_mmap() clears active TS_COMPAT on TIF_ADDR32 ta=
sks
- [Medium] bpf: bpf_user_vm_mmap() triggers false in_32bit_syscall() on x86=
_64
--

commit f91c9a5c8eeb0a10c48d0c7030bd2cd248f6d3fd
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add user memory kfuncs

This commit adds the sleepable kfuncs bpf_copy_to_user(),
bpf_user_anon_mmap(), and bpf_user_munmap() for KPROBE BPF programs to
modify a user task's address space and manage private anonymous mappings.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 58e357302850e..ae7dfa58ae95c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -3741,6 +3747,110 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, =
u32 dst__sz,

[ ... ]

> +/* bpf_wq and bpf_task_work callbacks can run without a usable mm. */
> +static bool bpf_user_mm_ok(void)
> +{
> +	return current->mm && !(current->flags & (PF_KTHREAD | PF_EXITING));
> +}
> +
> +#ifdef CONFIG_IA32_EMULATION
> +static unsigned long bpf_user_vm_mmap(unsigned long len, unsigned long p=
rot)
> +{
> +	struct thread_info *ti =3D current_thread_info();
> +	bool compat =3D test_thread_flag(TIF_ADDR32);
> +	unsigned long addr;
> +
> +	/*
> +	 * We are not in a syscall, but x86 get_unmapped_area() paths
> +	 * ignore TIF_ADDR32 and rely on in_32bit_syscall().
> +	 */
> +	if (compat)
> +		ti->status |=3D TS_COMPAT;
> +	addr =3D vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v1 [1], on x86_64 kernels with
CONFIG_X86_X32_ABI=3Dy, will calling bpf_user_anon_mmap() from a sleepable
uprobe in a native 64-bit process falsely trigger in_32bit_syscall() and
restrict mappings to the 32-bit compat range below 4 GiB?

When a 64-bit task enters a uprobe breakpoint exception (or sys_uprobe /
sys_uretprobe), task_pt_regs(current)->orig_ax is -1. Under
CONFIG_X86_X32_ABI=3Dy, in_32bit_syscall() checks in_x32_syscall():

arch/x86/include/asm/compat.h:in_x32_syscall() {
#ifdef CONFIG_X86_X32_ABI
	if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
		return true;
#endif
	return false;
}

Because bpf_user_vm_mmap() passes addr =3D 0 to vm_mmap(),
arch_get_unmapped_area_topdown() and arch_get_unmapped_area() call
get_mmap_base() and find_start_end(), which both check in_32bit_syscall()
and select mm->mmap_compat_base and task_size_32bit() instead of the 64-bit
address space.

> +	if (compat)
> +		ti->status &=3D ~TS_COMPAT;

[Severity: Medium]
Could clearing TS_COMPAT unconditionally whenever TIF_ADDR32 is set clobber
an active 32-bit syscall's TS_COMPAT state?

When a 32-bit IA32 task enters a syscall via syscall_32_enter(), TS_COMPAT
is set in current_thread_info()->status and must remain set until
arch_exit_to_user_mode_prepare() clears it after signal handling and
syscall restart fixups:

arch/x86/include/asm/entry-common.h:arch_exit_to_user_mode_prepare() {
	...
	/*
	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
	 * returning to user mode.  We need to clear it *after* signal
	 * handling, because syscall restart has a fixup for compat
	 * syscalls.  The fixup is exercised by the ptrace_syscall_32
	 * selftest.
	...
	 */
	current_thread_info()->status &=3D ~(TS_COMPAT | TS_I386_REGS_POKED);
}

If a kprobe schedules a sleepable bpf_task_work callback that runs during
syscall exit (for example via task_work_run() inside get_signal() or
ptrace_notify()) and calls bpf_user_anon_mmap() -> bpf_user_vm_mmap(),
ti->status &=3D ~TS_COMPAT will clear TS_COMPAT before signal handling
finishes. Subsequent calls to syscall_get_error(), in_ia32_syscall(), and
in_compat_syscall() will then treat the active 32-bit syscall as a 64-bit
syscall.

Should bpf_user_vm_mmap() only set and clear TS_COMPAT when
!(ti->status & TS_COMPAT)?

[1] https://lore.kernel.org/r/571f32a410a85199bc9bcecfe07a9a9b6ef425b205264=
3e64031dd246c13691e@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103075916.1000=
50-1-jolsa@kernel.org?part=3D1
