Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5413340D
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072920; cv=none; b=DFcqfH4fTWgNUtYCWP4FRUVfZyl9pJit91Kv8j+9XT679ofX4Bi6uEHUHp+ufy+Km66W0HybU5d/nBh31CGTxmpoZQ7DPM3Ji18/IUR2+MpDBfLW0zHJ3zSoiZ95HOxY4pAnc/Yzjwms5Ajli7zueKzVy+g0j4+ZnvmVmr+OAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072920; c=relaxed/simple;
	bh=O6bId0/Lm+vyFwikPpOenylllWq6YC8LwINhz5ul1Xc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZI4LJtDw+MsbCX4xKa4vkZNs+PBPdCDAtUa77m4PK3V9QqRDOYqe8SC19kMP30GLCNU0wKpMB8JAeDBQlHG+dOx4L4/e3iyd/fiYALZrZKbK/lL+DLiXr4KKn/bKnsiVwLzHF5lAxmNBFC2vTCPIq1E7taXCdkbsglb1xnfSzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eTOPENqO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eTOPENqO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eMuvWlkE68vkwqUqvG08lz+QcrEcF9ZixxATZL/4FK4=; b=eTOPENqO/goXLxCdE/ofLPxPvx
	6COPijIwTUVOGL7I0nVAwGbhQabe3/Yc2PMruRP+v+608cZ6DnNpnM7AyYKzi2HqQQUCq5SWXPDX+
	UcFWHpfyEJkE/pLPyqQJLMmEXhq7m9TLRkzSD9LanBV+iZ6BPFsOVYCPsO1EV//NSwFYgb2qGmTya
	mbTTzXlLOuFBJGT/qc7dSkBY8Fjog/PaYFSUyX2J7ShqClgh5A60L0YuyGA+0I+c/JeIw/Ya1Vncp
	t/CqaHbqsKjN3UeB0YWWpdthQJdbhTgSp2Q744NDC1xLeO33xJ6z9W16Twa0FKPH6VMwHfRy1GVD6
	XsXIl+SQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrgNG-0000bL-W7; Tue, 02 Apr 2024 17:48:35 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrgNG-000Kho-24;
	Tue, 02 Apr 2024 17:48:34 +0200
Subject: Re: [PATCH bpf-next] bpf: Optimize emit_mov_imm64().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@fb.com
References: <20240401233800.42737-1-alexei.starovoitov@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ec622bce-eb17-e774-db03-7541a31661f4@iogearbox.net>
Date: Tue, 2 Apr 2024 17:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240401233800.42737-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

On 4/2/24 1:38 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Turned out that bpf prog callback addresses, bpf prog addresses
> used in bpf_trampoline, and in other cases the 64-bit address
> can be represented as sign extended 32-bit value.
> According to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82339
> "Skylake has 0.64c throughput for mov r64, imm64, vs. 0.25 for mov r32, imm32."
> So use shorter encoding and faster instruction when possible.
> 
> Special care is needed in jit_subprogs(), since bpf_pseudo_func()
> instruction cannot change its size during the last step of JIT.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   arch/x86/net/bpf_jit_comp.c |  5 ++++-
>   kernel/bpf/verifier.c       | 13 ++++++++++---
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 3b639d6f2f54..47abddac6dc3 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -816,9 +816,10 @@ static void emit_mov_imm32(u8 **pprog, bool sign_propagate,
>   static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
>   			   const u32 imm32_hi, const u32 imm32_lo)
>   {
> +	u64 imm64 = ((u64)imm32_hi << 32) | (u32)imm32_lo;
>   	u8 *prog = *pprog;
>   
> -	if (is_uimm32(((u64)imm32_hi << 32) | (u32)imm32_lo)) {
> +	if (is_uimm32(imm64)) {
>   		/*
>   		 * For emitting plain u32, where sign bit must not be
>   		 * propagated LLVM tends to load imm64 over mov32
> @@ -826,6 +827,8 @@ static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
>   		 * 'mov %eax, imm32' instead.
>   		 */
>   		emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
> +	} else if (is_simm32(imm64)) {
> +		emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
>   	} else {
>   		/* movabsq rax, imm64 */
>   		EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edb650667f44..d4a338e7b5e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19145,12 +19145,19 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   		env->insn_aux_data[i].call_imm = insn->imm;
>   		/* point imm to __bpf_call_base+1 from JITs point of view */
>   		insn->imm = 1;
> -		if (bpf_pseudo_func(insn))
> +		if (bpf_pseudo_func(insn)) {
> +#if defined(MODULES_VADDR)
> +			u64 addr = MODULES_VADDR;
> +#else
> +			u64 addr = VMALLOC_START;
> +#endif

Is this beneficial for all archs? It seems this patch is mainly targetting x86.
Why not having a weak function like u64 bpf_jit_alloc_exec_start() which returns
the MODULES_VADDR for x86, but leaves the rest as-is?

For example, arm64 has MODULES_VADDR defined, but the allocator uses vmalloc
range instead, see bpf_jit_alloc_exec() there, so this is a different pool and
it's also not clear if this is better or worse wrt its imm encoding.

>   			/* jit (e.g. x86_64) may emit fewer instructions
>   			 * if it learns a u32 imm is the same as a u64 imm.
> -			 * Force a non zero here.
> +			 * Set close enough to possible prog address.
>   			 */
> -			insn[1].imm = 1;
> +			insn[0].imm = (u32)addr;
> +			insn[1].imm = addr >> 32;
> +		}
>   	}
>   
>   	err = bpf_prog_alloc_jited_linfo(prog);
> 

