Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AF3F4DD1
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494467; cv=none; b=HOqUVsW3UARob8rSigsV/QKK0kYz4vNw5FJRqPctnuIvlxt4Uk2pAfS8520ViZRt/pk3ibPZ8faD8Mf5/bfhkUy/ndDPwcjkH1N82l97f6XIxZW4bY9be65rTqbyyexzNz2jjYUcmj/LwbAIf10R+sEXVCkUSadUidcDNMLMSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494467; c=relaxed/simple;
	bh=BSX4fvKHlPsWG2VFqhKNzDugnwS/7TOTcQmMdVlQNSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fl9Gfo3CcNpQPu3FmfiFvR9xLWmQGK2QXVuUAQfjUNagag1ju/n8Cy22JOG4Q5Rr5yqcKXHQK4xIG2LT8+uru+dBagMxrX6pJRXjDlNhpfe0Kx/vgszq78wWOFHu/BWovhOThlPSAF/6K9DjC2jwNLCBFIgWqjksAAUwxtyzESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/AKbZ/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/AKbZ/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B571F000E9;
	Wed,  8 Jul 2026 07:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783494456;
	bh=NicUaUqHCPppemV1v4M+0ag9KNDwkGSUyr7EGapo+2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/AKbZ/8G0tTSm9hKlo8Ov2WZ6KQZ6KDW5MawAwwDcvSSopnb5Tp03KWXg+AnnOJa
	 HbmOjGPrnaR4/IANMMcqaZZ743IybKnaD2Cz/gEmzWgYH/ra+BYqDv0mG9daOP/DXb
	 hO4ZYFUqdjyJyVCC5YeT1iiMaucuFdW4Y//nsN//r2blau8764vkskEFkeU9zbE2qD
	 l2V3/FgctyyYfQQFqSg0e9U7/Qa6GK7klhdC1UnOmXfliMumOewG4Zje06+flosSDD
	 Xc7txGNs7BFznz6ccKuUL3j8JuIMgZ2u2xqqMhVGgL657MTLupqXqaNm/MNN6uhQ87
	 iOePUlpA63iXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and
 tailcalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708064436.2971933-7-pulehui@huaweicloud.com>
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
 <20260708064436.2971933-7-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:07:35 +0000
Message-Id: <20260708070736.47B571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized Tail Call Count (TCC) in synchronous BPF callbacks a=
llows bypassing tail call limits, leading to kernel stack overflow or DoS.
--

--- Patch [6]: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailc=
alls ---
commit c63e8081e54742ee045ae19d7f5fc9de4b31396f
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Mixing bpf2bpf and tailcalls
   =20
This commit implements mixing bpf2bpf and tailcalls for the RV64 JIT,
similar to x86_64, by using a non-callee saved register to transfer the
TCC between functions and saving that register to the stack. It stores the
TCC back to the stack after bpf2bpf calls or calling the original bpf
func in a bpf trampoline.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 7c6304e0b846a..823262ca47ebf 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -2038,11 +2038,10 @@ void bpf_jit_build_prologue(struct rv_jit_context=
 *ctx, bool is_subprog)
>  	for (i =3D 0; i < RV_FENTRY_NINSNS; i++)
>  		emit(rv_nop(), ctx);
> =20
> -	/* First instruction is always setting the tail-call-counter
> -	 * (TCC) register. This instruction is skipped for tail calls.
> -	 * Force using a 4-byte (non-compressed) instruction.
> -	 */
> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +	if (!is_subprog)
> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +

[Severity: High]
Does skipping TCC initialization for all subprograms leave the TCC uninitia=
lized
for synchronous BPF callbacks?

If a BPF program uses a C helper like bpf_loop() to invoke a synchronous
callback (which is treated as a subprogram where is_subprog is true), the C
helper will have clobbered the RV_REG_TCC (A6) register.

Because the callback skips initializing the TCC, it will inherit whatever
garbage value was left in A6 and save it to the stack. If this callback then
calls another subprogram that executes a tail call, could this garbage TCC
value bypass the tail-call limit, leading to unbounded tail calls and
a kernel stack overflow?

> +	/* tailcall starts here, emit insn before it must be fixed */
> =20
>  	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708064436.2971=
933-1-pulehui@huaweicloud.com?part=3D6
