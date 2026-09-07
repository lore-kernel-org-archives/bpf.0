Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB70488230;
	Mon,  7 Sep 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783432; cv=none; b=q+oajBn3f3kIZUROayEHzgCtTT1PBRFS5qNX3KEQEfCDiYgFQ4/23lFq3F4xXog2CBn/B1SQJ+1zhBpLw7gEH9lDeFFCssqdkiQSH7HEcPJ7QxYuJIqNZvB7KJ1dewCthhCqbdobHd8R/qdFrZ3pwh8sP032oR9Vqx+IOOfjf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783432; c=relaxed/simple;
	bh=HgjAS8yCM9CNJMx0Ihq+MRO2rA14QZbWXZDao7xAuzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyzLuT0vdAAvnGCEoYJS5yKCtsf2yPwhurVlhvLZnxEz4iYIENzjL69xH6Ai+ZuxnKgmtQjXxndOlr3qm3wHXEqI9GoyRuvYIiVQ26dzF3F3Nk7w1/is7oe9JSZFYtcZzRaYqCEo9Q29wnNFeNg1kCn9a4E5j/1jDC9OeAWWXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hdmJ45SrszKHN69;
	Mon,  7 Sep 2026 20:16:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E7FC54056D;
	Mon,  7 Sep 2026 20:17:04 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBH90M_q55qxRxiBA--.20818S2;
	Mon, 07 Sep 2026 20:17:04 +0800 (CST)
Message-ID: <194ad587-cd4d-4ecf-89e6-74466b857d64@huaweicloud.com>
Date: Mon, 7 Sep 2026 20:17:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf, arm64: set up the frame pointer for the
 exception callback
Content-Language: en-US
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
 Will Deacon <will@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260907054235.473103-1-donggeunyoo.kernel@gmail.com>
 <20260907054235.473103-2-donggeunyoo.kernel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260907054235.473103-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBH90M_q55qxRxiBA--.20818S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUXrykGryUur4DGF47XFb_yoW5Xr4Dpa
	98uasIkr4vqw12yw4xJF48XF1Y9rsxJr47Gr48JrWYyr1qgrya9ryrKayjgFZ8Cwn5Wa1F
	vFWjkr9xuan8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/7/2026 1:42 PM, Donggeun Yoo wrote:
> A program acting as exception boundary saves all callee-saved registers,
> so build_prologue() takes the exception_cb path and never calls
> push_callee_regs(). That is the only place find_used_callee_regs() runs,
> and with it the only place ctx->fp_used is set, so the callback prologue
> does not emit the
> 
>    mov x25, sp
> 
> that points BPF_REG_FP at the frame the callback runs on. x25 keeps
> whatever it held when bpf_throw() was called. If the throw came from a
> subprogram that uses its own BPF stack, that is the subprogram's frame
> pointer, and since the subprogram never returns it never restores x25
> either.
> 
> Stack accesses through BPF_REG_FP are rewritten to be stack pointer
> relative, so those still land in the callback's own frame. Materializing
> the register does not: a callback that passes the address of a local
> variable to a helper hands over an address in the dead subprogram's
> frame. That address is below the callback's stack pointer by then, and
> the helper's own call chain covers it, so the helper can write over its
> own return address. 0x1234 below is the value the helper was asked to
> store:
> 
>    pc : 0x1234
>    lr : 0x1234
>    Call trace:
>     0x1234 (P)
>     bpf_test_run+0x188/0x3e0
>     bpf_prog_test_run_skb+0x47c/0x998
>     __sys_bpf+0xbdc/0xdd8
>    Kernel panic - not syncing: Oops: Fatal exception in interrupt
> 
> Set ctx->fp_used on the exception callback path so that the existing code
> further down sets x25 from the stack pointer. The epilogue restores it
> from the main program's save area along with the other callee-saved
> registers, as it already does. x86 sets the frame pointer for the
> callback from the argument it is passed, and powerpc computes it from
> the stack pointer.
> 
> Fixes: 5d4fa9ec5643 ("bpf, arm64: Avoid blindly saving/restoring all callee-saved registers")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c18e005a41db..c5f55d6161fe 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -600,6 +600,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>   		 * 12 registers are on the stack
>   		 */
>   		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
> +		/* The callback may use its own BPF stack, set up fp for it. */
> +		ctx->fp_used = true;
Right, every path in the prologue that backs x25 on the stack should also
set fp_used=true.

Acked-by: Xu Kuohai <xukuohai@huawei.com>

>   	}
>   
>   	/* Stack must be multiples of 16B */

