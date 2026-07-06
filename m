Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725D42A79F;
	Mon,  6 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320392; cv=none; b=PCpAXvgDgJc4smpSi7g19NNsu8lvHSh9m50MtgAk8k3cf2V7slVZ4HqKkbg28OAF9rhomcmW8+Px0z2tHweBAPcgJIu8lmkUtIr3Po7fyS2LBQ9cmTmtb8wtdH2E7YdXQb1AB1dtrez3SWPE7eL5jnovKtyDHVth+VJ5Mmyptmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320392; c=relaxed/simple;
	bh=e83rGfsw7ahDdPokrwquGPwhn58FshJu2zDl5WGH2nE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gI8lB2VaJc8Q50Vv51Lb3nAX+6Jfk0mLMzf5WAfRxgLhGgQBPeg7ByaJg0/nfuJJ1rMJhxovJ3jJwMlIt2E28WeN4VyJVfALpXuY85HVgrDcMKS614Jc7NmP/OWFf6xEtPk338rbgf9vfPsMQyVNSwMVKSQqFO31P7D83fhdGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axx+o2T0tq9FAAAA--.1537S3;
	Mon, 06 Jul 2026 14:46:14 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxLcUyT0tqa+kBAA--.234S3;
	Mon, 06 Jul 2026 14:46:11 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 02/11] LoongArch: BPF: Support internal-only
 MOV to resolve per-CPU addrs
To: George Guo <dongtai.guo@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Hengqi Chen <hengqi.chen@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 George Guo <guodongtai@kylinos.cn>, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-3-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bcdfd520-8f88-b8d9-37e1-52e0368d40d3@loongson.cn>
Date: Mon, 6 Jul 2026 14:46:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260702022322.51033-3-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxLcUyT0tqa+kBAA--.234S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DCr4xuw1fKFyxAFW7WrX_yoW8ZFy8pF
	nrArs5GFWvgr13Gwsrtw43Wr15Can3Cr4agr9FkrWUAr9xZry8XF10k3sxWF95Jw4rWryS
	grsakw1a9F1DXabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjLv
	tUUUUU=

On 2026/7/2 上午10:23, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Support the internal-only BPF_MOV instruction that resolves the absolute
> address of per-CPU data from its per-CPU offset. This instruction is used
> only for internal inlining optimizations between the BPF verifier and the
> JITs (e.g. inlining bpf_get_smp_processor_id() and per-CPU map lookups).
> 
> LoongArch keeps the per-CPU offset of the current CPU in $r21
> (__my_cpu_offset), so resolving a per-CPU address only requires adding
> $r21 to the source register holding the per-CPU offset. Advertise the
> capability via bpf_jit_supports_percpu_insn().
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   arch/loongarch/include/asm/inst.h |  1 +
>   arch/loongarch/net/bpf_jit.c      | 14 ++++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 76b723590023..44fb5ad26d1a 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -404,6 +404,7 @@ enum loongarch_gpr {
>   	LOONGARCH_GPR_T6,
>   	LOONGARCH_GPR_T7,
>   	LOONGARCH_GPR_T8,
> +	LOONGARCH_GPR_U0 = 21,	/* Kernel per-CPU base register ($r21) */
>   	LOONGARCH_GPR_FP = 22,
>   	LOONGARCH_GPR_S0 = 23,
>   	LOONGARCH_GPR_S1,
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 5e34e9e3f508..b4208fa3a242 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -759,6 +759,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			move_reg(ctx, dst, t1);
>   			break;
>   		}
> +		if (insn_is_mov_percpu_addr(insn)) {
> +			if (dst != src)
> +				move_reg(ctx, dst, src);
> +#ifdef CONFIG_SMP
> +			/* dst += __my_cpu_offset, held in $r21 */
> +			emit_insn(ctx, addd, dst, dst, LOONGARCH_GPR_U0);
> +#endif

How to test? Did you test under !CONFIG_SMP?

Thanks,
Tiezhu

