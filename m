Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D03C0A09;
	Fri, 24 Jul 2026 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880299; cv=none; b=DVdvvst0G/acR/ZLgFOg88ToJF64iaWv/xO7Ga1Si/ESlANXmy1mDxO4f56MLcdbp53PgnjAbyJrknxMcfwP8rDOxcown3WePvR6IyrFUGtlhLIcM/+Z2y3N+7+j2FE4V3CvURKh9pLwA3VnQHD0y4sJ4bZIzyJp/E4ziNH5dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880299; c=relaxed/simple;
	bh=WuA5frFXfBzOnN5dl7SpeNarnryIC77w28RpHEUGw48=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MkfxeXmJiuZOamnY+QT3vW0cvBuuLHK4w2Od3d2y21eNY0ciJiLMCnT8A1tuybpeZxvvU1RSMBSnlHLjsdi24wEC27bAAEDFgXaPNxJOtYLUFzTsmzpU7/0qgm6LgVoxQMhlGvZ1H2q9Kw4+wYxF2l0+GiwFZPQm2SBBUggB3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxvKGlHGNqcdwGAA--.2211S3;
	Fri, 24 Jul 2026 16:04:53 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxEuSiHGNqOzoXAA--.56898S2;
	Fri, 24 Jul 2026 16:04:51 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/4] LoongArch: BPF: Fix memory leak in
 bpf_jit_free
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, Pu Lehui <pulehui@huawei.com>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-3-pulehui@huaweicloud.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d856fb28-273e-99ec-f1dd-426ea087ea24@loongson.cn>
Date: Fri, 24 Jul 2026 16:04:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260722112754.1615201-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuSiHGNqOzoXAA--.56898S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF15JF15Gw4DKw1fAr1xtFc_yoW8WF4fpF
	WDuwnxG3yDWry8tFsrJ3y8WFy8Jrs5G3Waga4Uur18CFnIgr10gF1xC34DWayDArWUJr1r
	Wrs8Cr9I9FyDJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcApnDU
	UUU

Cc: Huacai Chen <chenhuacai@kernel.org> loongarch@lists.linux.dev

On 2026/7/22 下午7:27, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When bpf_int_jit_compile() is called for subprograms, it returns early
> during the first pass (!prog->is_func || extra_pass is false), keeping
> ctx->offset alive for the subsequent extra pass.
> 
> If JIT compilation fails for a later subprogram, the BPF core aborts and
> calls bpf_jit_free() to clean up the first subprogram. However,
> bpf_jit_free() fails to free jit_data->ctx.offset, which causes a memory
> leak of the JIT context offsets array.
> 
> Fix this by adding the missing kvfree(jit_data->ctx.offset) in
> bpf_jit_free().
> 
> Fixes: 4ab17e762b34 ("LoongArch: BPF: Use BPF prog pack allocator")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/loongarch/net/bpf_jit.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 2738b4db1165..3d3ed1677d01 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2361,6 +2361,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>   		 */
>   		if (jit_data) {
>   			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> +			kvfree(jit_data->ctx.offset);
>   			kfree(jit_data);
>   		}
>   		hdr = bpf_jit_binary_pack_hdr(prog);
> 

Here is the link:
https://lore.kernel.org/bpf/20260722112754.1615201-3-pulehui@huaweicloud.com/

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu

