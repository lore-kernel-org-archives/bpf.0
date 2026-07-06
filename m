Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A83932C9;
	Mon,  6 Jul 2026 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321631; cv=none; b=aX7iLYbDtv+ItDQwKGiHyKJRJ57tQPWdW2HYMkkzRAkDrrsCSEAn/oXkfcTrSOe6VGNPq+U1Ay1DvaC0zDsiUYZh3MPIDXn40nfKy7rOBnKl6xbu89MnGYM9SCWIUHcm4BJTwK+n2/qj7ql3YvHhDhfNYEfUGBTWt194Jb4rFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321631; c=relaxed/simple;
	bh=PcXkgkc40eT6/Vffd5lGo5QZnIGSuYAfh8Qs6ovIxVo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CuUYkqmqhoxeQoWTeVJl/QPCgm4eSvBCSmccypNfxkyyMZdol6eBPe0pxwGR3zvXqbPDxHDyi9q8breKiTrXr9l9IiW5/1j4Emz7L9daSxBRAyhr3nh7q5BY06M/WCvSGrtWmtXgCmi0LX1DiuIbozJPkwARdgheaOuOqjFGZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxNOoNVEtqb1IAAA--.106S3;
	Mon, 06 Jul 2026 15:06:53 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxX8cDVEtqfe4BAA--.11984S3;
	Mon, 06 Jul 2026 15:06:45 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 07/11] LoongArch: BPF: Support atomics on
 arena pointers
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
 <20260702022322.51033-8-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <850ef512-b48c-3fd6-1959-2a71363f983f@loongson.cn>
Date: Mon, 6 Jul 2026 15:06:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260702022322.51033-8-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX8cDVEtqfe4BAA--.11984S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4xJFW8ZF43ZF1fZFyxZwc_yoW8ArW7pa
	yrAFW5trs5W3yxu347tw4Iy3WF93yfAFZ8Jr1Ut348CwnrXF4rtFW0qayjqFyDKrn7W347
	WF4jya92934DAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
	6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
	2YLPUUUUU==

On 2026/7/2 上午10:23, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Implement atomic operations on arena pointers (BPF_PROBE_ATOMIC): the
> read-modify-write ops, atomic_fetch_*, xchg, cmpxchg and
> load-acquire/store-release.  For each, the arena base held in REG_ARENA
> is folded into the address and an exception table entry is registered on
> the access so a fault is handled like the other arena probes.
> 
> The exception entry must point at the actual memory-accessing
> instruction rather than the last one emitted: the fetch variants append
> a zero-extend after the am* op, and cmpxchg accesses memory with the ll
> of an ll/sc loop.  Generalise add_exception_handler() to take explicit
> fault and resume instruction indices.  A faulting ll resumes past the
> whole ll/sc loop: if the ll faults the sc is never reached, and once the
> ll succeeds the page is mapped so the sc cannot fault, so a single entry
> on the ll suffices.

...

>   
>   bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   {
> -	if (!in_arena)
> -		return true;
> -
> -	switch (insn->code) {
> -	case BPF_STX | BPF_ATOMIC | BPF_W:
> -	case BPF_STX | BPF_ATOMIC | BPF_DW:
> -		/* Atomics on arena pointers are not implemented yet. */
> -		return false;
> -	}
> -

Adding code in patch 6 and deleting it in patch 7
is unnecessary code noise.

Please implement it cleanly in patch 6 from the start.

> +	/*
> +	 * All arena access instructions are implemented: regular and
> +	 * sign-extending loads/stores (BPF_PROBE_MEM32 / BPF_PROBE_MEM32SX)
> +	 * and atomics (BPF_PROBE_ATOMIC).  The default weak helper rejects
> +	 * everything, so the override is required to enable arena programs.
> +	 */
>   	return true;
>   }

Thanks,
Tiezhu

