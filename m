Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C938E5C8
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789146; cv=none; b=I4Q0+0VLjy++hdvYK7Bw38F/JuQSYjW5147e8VkxNnSva+iqMtx9ida+LPSvkONROUkadJnjh8ekL5tOVWR/gr0u4TAGkF3CPSatyCL4UDtwGFQZi+UAwTNEQ4UPJtfyFttzBFMIN7s0ynADXBOJ6a/uJtQh5Flxgk7eikZBws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789146; c=relaxed/simple;
	bh=u+QZqoagM7ci76qBwcA8Q0Lj4elvfNteo+6gb9rDCSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qI2NWFCYrs3fbj6gnSnM0jccuWotpzInVJXBlHAc5A8sj7deePdBrz2Z4vNldlfZ38dcCdedCAEOMGHvTkCwy8cNIDluTK4mUMLBMzXmknDt4QJHzfRfgp7LEBcy/kBleW795tc7IWNF85CzCfEIBmcgLY75vAaTrRsVDcS7sFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/zsWmnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/zsWmnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C672EC2BCB3;
	Thu, 14 May 2026 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778789146;
	bh=u+QZqoagM7ci76qBwcA8Q0Lj4elvfNteo+6gb9rDCSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=P/zsWmnE17SsRwxeOy7Ggot/n8c2RG8Mz3eWa5mdFj0Jyz8GlskiuBLTfEHfOM+3/
	 wUu6orOB7bGlXuNDhiofvdIc9D7FE9C0r+pD9cQmZwR1sMFPVg7D/B8BLun9r5ggxY
	 CwaTz0fj26iorTS1JTNzzDQ+C3bQXGt6FaixcGe+AlcjNs0Y5vio/rEwyCHYEwK8YG
	 EkJjlwcEhQXIDnd/oRzmZ63Wz1bKOMtHIfjn8u+/s+cg1c5LKDosYKT1+7ypNqGEhU
	 ae51xDeeHIWJRmcgdGKXTbLN44Ceg62qd1dq2vsa1W7gqSs8SRZ9vERw3+bpgcMX3h
	 fQyQ5Q78HiHRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514135342.22130-2-jolsa@kernel.org>
References: <20260514135342.22130-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:05:45 +0000
Message-Id: <20260514200545.C672EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] set_orig_insn fails to unoptimize uprobes in foreign processes bec=
ause __is_optimized relies on __in_uprobe_trampoline, which hardcodes curre=
nt->mm for VMA lookups, resulting in silent stack pointer corruption.
- [High] set_orig_insn fails to unoptimize a forked child's uprobe due to b=
reakpoint overwriting the lea instruction, leaving a corrupted instruction =
that truncates the stack pointer.
--

commit ecbc682eb0a0b0a7df1fd339bbdb6beeb8e1fc0a
Author: Jiri Olsa <jolsa@kernel.org>

uprobes/x86: Move optimized uprobe from nop5 to nop10

This commit fixes a redzone clobbering issue with optimized uprobes by
moving them to use a 10-byte nop instruction, allowing space for a stack
adjustment before the call.

Link: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

> @@ -1049,19 +1077,21 @@ static bool __is_optimized(uprobe_opcode_t *insn,=
 unsigned long vaddr)
>  	struct __packed __arch_relative_insn {
>  		u8 op;
>  		s32 raddr;
> -	} *call =3D (struct __arch_relative_insn *) insn;
> +	} *call =3D (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
> =20
> -	if (!is_call_insn(insn))
> +	if (!is_lea_insn(insn))
> +		return false;
> +	if (!is_call_insn(insn + LEA_INSN_SIZE))
>  		return false;
> -	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> +	return __in_uprobe_trampoline(vaddr + OPT_INSN_SIZE + call->raddr);
>  }

Does this sequence risk silent stack pointer corruption during uprobe
unregistration?

When a tracer unregisters a uprobe from another process, it runs in the
tracer's context. However, __is_optimized() calls __in_uprobe_trampoline(),
which hardcodes current->mm for the VMA lookup:

arch/x86/kernel/uprobes.c:__in_uprobe_trampoline() {
        struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
        return vma && vma_is_special_mapping(vma, &tramp_mapping);
}

Since current is the tracer, the lookup fails, causing __is_optimized()
to return false.

If __is_optimized() returns false, set_orig_insn() bypasses
swbp_unoptimize() and writes only the first byte of the original
instruction (e.g., 0x66 for nop10) over the 0x48 (lea) byte.

This leaves the instruction 66 8d 64 24 80 e8 ... in the tracee's memory,
which decodes as lea -0x80(%rsp), %sp. Could this truncate the stack
pointer to 16 bits and cause stack corruption when the tracee subsequently
pushes or pops?

[ ... ]

> @@ -1095,14 +1125,25 @@ int set_orig_insn(struct arch_uprobe *auprobe, st=
ruct vm_area_struct *vma,
>  		  unsigned long vaddr)
>  {
>  	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> -		int ret =3D is_optimized(vma->vm_mm, vaddr);
> -		if (ret < 0)
> +		uprobe_opcode_t insn[OPT_INSN_SIZE];
> +		int ret;
> +
> +		ret =3D copy_from_vaddr(vma->vm_mm, vaddr, &insn, OPT_INSN_SIZE);
> +		if (ret)
>  			return ret;
> -		if (ret) {
> +		if (__is_optimized((uprobe_opcode_t *)&insn, vaddr)) {
>  			ret =3D swbp_unoptimize(auprobe, vma, vaddr);
>  			WARN_ON_ONCE(ret);
>  			return ret;
>  		}
> +		/*
> +		 * We can have re-attached probe on top of jmp8 instruction,
> +		 * which did not get optimized. We need to restore the jmp8
> +		 * instruction, instead of the original instruction (nop10).
> +		 */
> +		if (is_swbp_insn(&insn[0]) && insn[1] =3D=3D OPT_JMP8_OFFSET)
> +			return uprobe_write_opcode(auprobe, vma, vaddr, JMP8_INSN_OPCODE,
> +						   false /* is_register */);
>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&au=
probe->insn,
>  				   false /* is_register */);

Is there a similar issue for forked children that inherit the optimized
10-byte sequence?

During fork, uprobe_mmap() installs a breakpoint in the child by writing
0xCC to the first byte, changing the instruction from 48 8d... to cc 8d...

If the uprobe is unregistered before the child hits and re-optimizes it,
__is_optimized() will return false because is_lea_insn() strictly expects
the first byte to be 0x48:

arch/x86/kernel/uprobes.c:is_lea_insn() {
        return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
}

The fallback check for the re-attached probe on top of jmp8 also fails
because insn[1] is 0x8d, not OPT_JMP8_OFFSET.

Could set_orig_insn() then fall back to writing just the first byte of
the original instruction over the 0xcc, again leaving 66 8d 64 24 80 e8 ...
and silently truncating the child's stack pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514135342.2213=
0-1-jolsa@kernel.org?part=3D1
