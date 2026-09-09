Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFE36B934
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975544; cv=none; b=IssUNBfYtZgV/pYumHay/75vA9hoRC78BcS4hocKqhzKzeAoKj7AlJZwT6wtqzVLSrf6pYBWQhu9BE+P1q6HUV8Az7wcuWDgw9cTFI7RsCejuTIi/JC+17l2jAyJA1UgqNirSVK3rjAUczQQJ1CO/5JaSUZSUOWK5wR7nnmQypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975544; c=relaxed/simple;
	bh=EnnRHDWfqBGm5+O+OlUx4K5NSMsJ9BC3rDHa6lTbFgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjYFRU1++gB/4yPeI6wmKeTkbqUNnMwrXa0ldLZsn5O9IKux/GzasyRy+gYr6niKh0EI5nhqd4tmpGdHMZ03DfpOQjAPNcMhSyYcutCWfDFU2hGg8SDeK+kIFBKl8gfNNp3aSDMcxVOAZxw3k3tLUcJNyuQ+FCDRDgQmY3sRpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vd2XCcfi; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vd2XCcfi"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EnnRHDWfqBGm5+O+OlUx4K5NSMsJ9BC3rDHa6lTbFgk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788975539; v=1; x=1789580339;
 b=Vd2XCcfifrSyIw5pHWRZ1Tgj+eZNyNYOt8QtpST3i44j1rf7UQQin28KxaftGRhfjTLoCUsT
 AwMUBnwsRxG1SMZvNPay6ZYuKO+BQT6yNCBur8i6xfTkMBtRRKAiuRa4wgXpXfytYJB6P6jFA3w
 3ZDmZf3RkbYD+gWqyHJfpDwI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6fd7739b0bf8718a;
	Wed, 09 Sep 2026 17:38:59 +0000
X-Mizu-Trace-ID: 6fd7739b0bf8718a
X-Migadu-Flow: FLOW_OUT
Message-ID: <c636bef6-9ab4-45cf-8566-bab9c09fc6b7@linux.dev>
Date: Wed, 9 Sep 2026 10:38:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm/pat: skip RWX verification until kernel text is
 set to read only
To: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, bpf <bpf@vger.kernel.org>
References: <20260908092730.4002628-1-rppt@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260908092730.4002628-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 2:27 AM, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Nathan Chancellor reports the following warning:
> 
>   CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0400000 - 0xffffffffc0400fff PFN 100e00
>   WARNING: arch/x86/mm/pat/set_memory.c:722 at __change_page_attr_set_clr+0xde7/0x1290, CPU#0: swapper/0/0
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.3.0-rc1-debug-00006-g453e78594434 #1 PREEMPT(full)  2950d432dd3910251071a66f3134fe0875432786
>   Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BIOS 1801 12/26/2022
>   RIP: 0010:__change_page_attr_set_clr+0xdff/0x1290
>   Code: 80 7c 24 42 00 0f 85 3a 04 00 00 48 8d 3d 19 8d 79 02 49 89 d9 4c 89 e1 4c 89 d2 4c 89 f6 4d 8d 84 24 ff 0f 00 00 4c 89 14 24 <67> 48 0f b9 3a 4c 8b 14 24 48 8b 0d 81 44 bf 01 41 f6 c2 01
>   RSP: 0000:ffffffff87003c60 EFLAGS: 00010246
>   RAX: 0000000000000002 RBX: 0000000000100e00 RCX: ffffffffc0400000
>   RDX: 0000000000000123 RSI: 8000000000000123 RDI: ffffffff872e50c0
>   RBP: 8000000100e00123 R08: ffffffffc0400fff R09: 0000000000100e00
>   R10: 0000000000000123 R11: 0000000000000001 R12: ffffffffc0400000
>   R13: 0000000100e00123 R14: 8000000000000123 R15: ffffffff87003d58
>   FS:  0000000000000000(0000) GS:ffff8ad1777a7000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffff8ad0a4201000 CR3: 00000007e3022001 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? _vm_unmap_aliases+0x219/0x280
>    change_page_attr_set_clr+0x161/0x250
>    ? events_sysfs_show+0x5d/0x80
>    set_memory_x+0x39/0x50
>    apply_retpolines+0x656/0x6d0
>    ? events_sysfs_show+0x5d/0x80
>    ? events_sysfs_show+0x6c/0x80
>    ? events_sysfs_show+0x62/0x80
>    alternative_instructions+0x3c/0xd0
>    arch_cpu_finalize_init+0x130/0x190
>    start_kernel+0x97d/0xa10
>    x86_64_start_reservations+0x24/0x30
>    x86_64_start_kernel+0xda/0xe0
>    common_startup_64+0x13e/0x151
>    </TASK>
>   ---[ end trace 0000000000000000 ]---

BPF CI has caught similar splats on linux-next [1].
The patch fixes it [2][3].

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

[1] https://github.com/kernel-patches/bpf/actions/runs/33918575854/job/101174705812
[2] https://github.com/kernel-patches/vmtest/pull/523
[3] https://github.com/kernel-patches/bpf/actions/runs/34279792157

> 
> The warning appears because commit 038176c21617f ("x86/mm/pat: fix
> effective RW computation in lookup_address_in_pgd_attr()") fixed the
> effective RW checked by verify_rwx() and it exposed that pages used
> for ITS trampolines temporarily have RWX permissions.
> 
> The permissions are updated in its_fini_core() after all the ITS
> trampolines are generated, but since verify_rwx() detects invalid
> transitions, it warns when its_alloc() makes RW memory executable.
> 
> At the time of alternatives patching the entire kernel text is mapped
> RWX, so the warning is bogus anyway.
> 
> Skip verification of W^X violations in verify_rwx() when they are
> triggered by transitions happening before the kernel text is remapped as
> read-only.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20260905044253.GA3816371@ax162
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 226660973d515..2eecb76703bb4 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -708,6 +708,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  	if (!(__supported_pte_mask & _PAGE_NX))
>  		return new;
>  
> +	/* skip verification until kernel text is set to read only */
> +	if (!kernel_set_to_readonly)
> +		return new;
> +
>  	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
>  		return new;
>  
> 
> base-commit: 038176c21617fcc03ccc1ca43230ffedb712c047

