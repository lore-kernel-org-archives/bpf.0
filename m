Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43C5B21A
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074466; cv=none; b=e+S+F1qzgomQMQC+p+ua+kiYZyXn55UuxwfpMOFoP7uOwmHcn1BfxcrxP7z7s7trIHIkhsQ3gwzjwAxKGmGI3E44VrYJr/94rO6dZKJu3GQCVnBlbiVEVvqLwiG+pdJZy/dX4vXpcVvWt0VjqXdXsjVWKqtPW2+fcv32JPZ4Yu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074466; c=relaxed/simple;
	bh=tuCgp03AP8h8Gix7NFKE1UTFSZ+tZSV/CYzYmi/VtwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3SirwBCkEICYFQsXuu+dNsa5xvFRFmR1BibJl18RShcQd+ydneQHvf+R19EXmstAYLPB9lJ7H54qkDq+9ryPKxxQ1230Yv0HdIfH4GFF68SI8Y6EBCx/VVgNjJjIEMi4B+cWOzGlXaBlNXWw89PT3hJDifRt1Xn3C+0Z/8d2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fLwxt6sq3zKHMh6
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:53:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A0EB34056F
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:54:19 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBnIObatZ9p00eYIg--.59121S2;
	Thu, 26 Feb 2026 10:54:19 +0800 (CST)
Message-ID: <5688dd03-cd4e-4802-a025-8e847d6444fe@huaweicloud.com>
Date: Thu, 26 Feb 2026 10:54:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, arm64: Use ORR-based MOV for
 general-purpose registers
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
References: <20260225134339.2723288-1-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260225134339.2723288-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnIObatZ9p00eYIg--.59121S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17KF13WF4xWw4UGr1rJFb_yoWrCr17p3
	s8uasFvwn7Wr1xA393JFWDZF13Gws5Ja1Ykr1xWrWrKrnFvrykWr4xKF15JFW3Crn0vw4r
	Za10vrZ5u3W8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 2/25/2026 9:43 PM, Puranjay Mohan wrote:
> The A64_MOV macro unconditionally uses ADD Rd, Rn, #0 to implement
> register moves. While functionally correct, this is not the canonical
> encoding when both operands are general-purpose registers.
> 
> On AArch64, MOV has two aliases depending on the operand registers:
>    - MOV <Xd|SP>, <Xn|SP>  →  ADD <Xd|SP>, <Xn|SP>, #0
>    - MOV <Xd>, <Xn>        →  ORR <Xd>, XZR, <Xn>
> 
> The ADD form is required when the stack pointer is involved (as ORR
> does not accept SP), while the ORR form is the preferred encoding for
> general-purpose registers.
> 
> The ORR encoding is also measurably faster on modern microarchitectures.
> A microbenchmark [1] comparing dependent chains of MOV (ORR) vs ADD #0
> on an ARM Neoverse-V2 (72-core, 3.4 GHz) shows:
> 
>    === mov (ORR Xd, XZR, Xn) ===
>    run1 cycles/op=0.749859456
>    run2 cycles/op=0.749991250
>    run3 cycles/op=0.749601847
>    avg cycles/op=0.749817518
> 
>    === add0 (ADD Xd, Xn, #0) ===
>    run1 cycles/op=1.004777689
>    run2 cycles/op=1.004558266
>    run3 cycles/op=1.004806559
>    avg cycles/op=1.004714171
> 
> The ORR form completes in ~0.75 cycles/op vs ~1.00 cycles/op for ADD #0,
> a ~25% improvement. This is likely because the CPU's register renaming
> hardware can eliminate ORR-based moves, while ADD #0 must go through the
> ALU pipeline.
>

Excellent find! I ran your benchmark locally and observed a similar improvement.

> Update A64_MOV to select the appropriate encoding at JIT time:
> use ADD when either register is A64_SP, and ORR (via
> aarch64_insn_gen_move_reg()) otherwise.
> 
> Update verifier_private_stack selftests to expect "mov x7, x0" instead
> of "add x7, x0, #0x0" in the JITed instruction checks, matching the
> new ORR-based encoding.
> 
> [1] https://github.com/puranjaymohan/scripts/blob/main/arm64/bench/run_mov_vs_add0.sh
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit.h                                  | 4 +++-
>   .../testing/selftests/bpf/progs/verifier_private_stack.c  | 8 ++++----
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index bbea4f36f9f2..d13de4222cfb 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -187,7 +187,9 @@
>   /* Rn - imm12; set condition flags */
>   #define A64_CMP_I(sf, Rn, imm12) A64_SUBS_I(sf, A64_ZR, Rn, imm12)
>   /* Rd = Rn */
> -#define A64_MOV(sf, Rd, Rn) A64_ADD_I(sf, Rd, Rn, 0)
> +#define A64_MOV(sf, Rd, Rn) \
> +	(((Rd) == A64_SP || (Rn) == A64_SP) ? A64_ADD_I(sf, Rd, Rn, 0) : \
> +	 aarch64_insn_gen_move_reg(Rd, Rn, A64_VARIANT(sf)))
>   
>   /* Bitfield move */
>   #define A64_BITFIELD(sf, Rd, Rn, immr, imms, type) \
> diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> index 1ecd34ebde19..646e8ef82051 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> @@ -170,11 +170,11 @@ __jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
>   __jited("	add	x27, x27, x10")
>   __jited("	add	x25, x27, {{.*}}")
>   __jited("	bl	0x{{.*}}")
> -__jited("	add	x7, x0, #0x0")
> +__jited("	mov	x7, x0")
>   __jited("	mov	x0, #0x2a")
>   __jited("	str	x0, [x27]")
>   __jited("	bl	0x{{.*}}")
> -__jited("	add	x7, x0, #0x0")
> +__jited("	mov	x7, x0")
>   __jited("	mov	x7, #0x0")
>   __jited("	ldp	x25, x27, [sp], {{.*}}")
>   __naked void private_stack_callback(void)
> @@ -220,7 +220,7 @@ __jited("	mov	x0, #0x2a")
>   __jited("	str	x0, [x27]")
>   __jited("	mov	x0, #0x0")
>   __jited("	bl	0x{{.*}}")
> -__jited("	add	x7, x0, #0x0")
> +__jited("	mov	x7, x0")
>   __jited("	ldp	x27, x28, [sp], #0x10")
>   int private_stack_exception_main_prog(void)
>   {
> @@ -258,7 +258,7 @@ __jited("	add	x25, x27, {{.*}}")
>   __jited("	mov	x0, #0x2a")
>   __jited("	str	x0, [x27]")
>   __jited("	bl	0x{{.*}}")
> -__jited("	add	x7, x0, #0x0")
> +__jited("	mov	x7, x0")
>   __jited("	ldp	x27, x28, [sp], #0x10")
>   int private_stack_exception_sub_prog(void)
>   {
>
> base-commit: f620af11c27b8ec9994a39fe968aa778112d1566

Acked-by: Xu Kuohai <xukuohai@huawei.com>

