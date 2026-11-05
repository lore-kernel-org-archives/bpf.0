Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875457;
	b=kB/Y0jG3CESsThTKp/lIePJvwNK/z64Bdu1Uq7D/CNVexRyLtvkv9FNrKllmJ3P8ivx9
	 KfkJy2Xd7rc6FT8EBYgagCVRBstQJ5hKVpDpO8BSe2rxnBXkr4T3duAGwOXocDwHR48WM
	 QmHQaRYVMElB6Z0i6XRRWnS8udiZLq2HjJdJMQrxE/1A9+hFMBG8CCY9kpCYzINu0mjyK
	 /hTkwekB03HVdHfuxBMSAL9H0D+FUO9LvFjATsgSTJa44sgZzobYR/lQkpB1GHKLLCj05
	 +A7Q8IImSIMYRZgqwW67HCREYRLE2mR6qwZ+Yf6zob4FG8+Tbjn81wUL1BVnQ9YjQhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3izgDCKY2tKTrzbElOHUZKuOJR4wxYIvmok7YVL8W0k=;
	b=pAqepWHPI9/xIPy1eNse95Ce+nwCzCKD5GcxBGB4cjtNQpm/O0+DINZ6w5F4GwRKQP0l
	 i4+gMzkbUc53scD7J59OOC+YcM47pi2QIN35pVt7ol5iGNihxE6riv1rEHI4vHmcF+Jx5
	 E68Ewd4A5EW5pmiGbbmYY6jsxupRIn0Lb6tBBlSII8KZwohh5jYMKNfg86zaeu75f2G+L
	 RMpXCJg3W1Cde0ARPUg1tJKa+p42KtPcB8r9icqqzTxp0BZAzAn7vww9Qef+lv+3xPKsH
	 IH2yRl8VIK6Zsi8Jbd2XYLGdsDSHo+Z94cc5obMsJ8m3L/jPyZ8/ImNLF4U7dBGX+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y23/HhZ7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951D606D820
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y23/HhZ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE71F0093A;
	Thu,  5 Nov 2026 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793875457;
	bh=3izgDCKY2tKTrzbElOHUZKuOJR4wxYIvmok7YVL8W0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y23/HhZ7UXBidoMrZf7HKqHWlD4mwne9bc9RuWU7EGUfnINFZU1JUgeXBwApx5+Qc
	 KhGmKBaHLuhNd4eAtoKGwrytm7NlfwXeMnUw8Zd9IOr9c4nM2tdJNlUek0ZTXUkxYP
	 c//Hxl8uCgo3Cq6TPYJ5jesVkY80/+sALbx9LvV8p0oqb2vyopu5BRHGfXSJv7barA
	 zsb6y/WK5lbQsDwAvO8y3MNGer5CgyzujN7ehY2XV9xSucK3F6jFzpiT5TPFqcrpa7
	 4vRfU63ObTeKfQUmh/q8IFlfFsNI9W0sBxGjnJXP245IxvZWsIJsNv/GoP4xcJHLCB
	 z66AKYk9aD5/g==
Message-ID: <sashiko-outbox-198875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 2/8] bpf: Add user memory kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Federico
 Di Pierro" <nierro92@gmail.com>
In-Reply-To: <20261105102343.311331-3-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
 <20261105102343.311331-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 10:44:16 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpf_user_anon_mmap() triggers false in_32bit_syscall() on x=
86_64
--

commit db9c75bc63d6f183a3894259aadc59e0c0a612de
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add user memory kfuncs

This commit adds the sleepable bpf_copy_to_user(), bpf_user_anon_mmap(),
and bpf_user_munmap() kfuncs for BPF_PROG_TYPE_KPROBE programs to manipulate
the current process's user address space.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6788489a2608b..937a0d7d68390 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -3768,6 +3771,88 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u=
32 dst__sz,

[ ... ]

> +__bpf_kfunc unsigned long bpf_user_anon_mmap(unsigned long len, unsigned=
 long prot)
> +{
> +	if (!bpf_user_mm_ok())
> +		return -EPERM;
> +	if (!arch_validate_prot(prot, 0))
> +		return -EINVAL;
> +	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
> +}

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v1 [1], when bpf_user_anon_mmap() is
called from a sleepable uprobe or uretprobe on x86_64 with
CONFIG_X86_X32_ABI=3Dy, can this falsely trigger in_32bit_syscall() for nat=
ive
64-bit processes and restrict the mapping to the 32-bit compatibility addre=
ss
range?

On x86_64, entering a uprobe or uretprobe via an int3 trap or via
sys_uprobe / sys_uretprobe sets task_pt_regs(current)->orig_ax to -1. Under
CONFIG_X86_X32_ABI=3Dy, in_32bit_syscall() checks in_x32_syscall():

arch/x86/include/asm/compat.h:
static inline bool in_x32_syscall(void)
{
#ifdef CONFIG_X86_X32_ABI
	if (task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT)
		return true;
#endif
	return false;
}

Because bpf_user_anon_mmap() passes addr =3D 0 to vm_mmap(),
__get_unmapped_area() calls arch_get_unmapped_area_topdown() /
arch_get_unmapped_area(), which invoke get_mmap_base() and find_start_end():

arch/x86/mm/mmap.c:get_mmap_base() {
    ...
#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
	if (in_32bit_syscall()) {
		return is_legacy ? mm->mmap_compat_legacy_base
				 : mm->mmap_compat_base;
	}
#endif
    ...
}

Since orig_ax is -1, in_32bit_syscall() (and in_compat_syscall() in
__thp_get_unmapped_area()) evaluates to true, placing mappings for native
64-bit tasks below 4 GiB and failing with -ENOMEM if the low 4 GiB range is
exhausted or len exceeds task_size_32bit().

[1] https://lore.kernel.org/r/571f32a410a85199bc9bcecfe07a9a9b6ef425b205264=
3e64031dd246c13691e@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105102343.3113=
31-1-jolsa@kernel.org?part=3D1
