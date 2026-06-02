Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5D3932EA;
	Tue,  2 Jun 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385390; cv=none; b=TxZiXb0RcirDAdH49tVjjG387st2uliYMZCE9EXJrI7RRTizL9MmDQTkaZmL1o2uqfK/dWWuUMUX4UfKAutlz8k3I24AIXIQZ7AKbIXdvLdn3Dgh1Pz0CcTpXA9m4S4aRpdcy+2AJYIVIWAGYgm6swyg0EIYNbj4ZV0DxLS7uWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385390; c=relaxed/simple;
	bh=tpE9iyO18dyU5LG49u/BjwWvRz1UhB72bCoYzFUlDjQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iaO9QsfhTU9BtXiwomfRil7mWAED4dho9+0BjRWSIgnAmYh+YA92W9SB8gImCpqZSVI/jo9LQiD/jifdPjo4HKC+z47OA935Z/m+RMectV6nDvOWyzyAx+rE1nZKdrXNCRBrCnAeh81zt4dJdNoWc15aZfG8Mw01Ts2sVQFY+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxvsBhhh5qs6UPAA--.19961S3;
	Tue, 02 Jun 2026 15:29:37 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDx6+BVhh5qOg2ZAA--.29239S3;
	Tue, 02 Jun 2026 15:29:27 +0800 (CST)
Subject: Re: [PATCH] LoongArch: bpf: Support kptr xchg inline
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <80088e78-293c-268c-3539-4e9ce66c4fd3@loongson.cn>
Date: Tue, 2 Jun 2026 15:29:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6+BVhh5qOg2ZAA--.29239S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWUKF4DAw47JF1Utw17XFc_yoW8AF45pr
	Zavr9xGr4DXFy0kw18Jw4fX3W3Aw45ArWYqryUC34qy3s8Zrn29F93K3409Fs8GFZIva42
	va1Dt3y3ua1DCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUU
	UU=

On 2026/6/2 上午10:15, Chenguang Zhao wrote:
> The BPF verifier can lower a bpf_kptr_xchg() call into a single BPF_XCHG
> atomic instruction when the JIT advertises support through
> bpf_jit_supports_ptr_xchg(). This drops the helper call overhead from the
> kptr exchange fast path.
> 
> Such inlining is only safe when the JITed atomic exchange provides the
> same full memory ordering as the bpf_kptr_xchg() helper. On LoongArch the
> plain amswap.d instruction carries no barrier semantics, so emit the
> ordered amswap_db.d variant for 64-bit BPF_XCHG instead. Add the
> amswapdbw/amswapdbd instruction emit helpers it relies on, and implement
> bpf_jit_supports_ptr_xchg() to turn the inlining on.
> 
> Extend the kptr_xchg_inline selftest to cover LoongArch64, and add a
> kptr-xchg benchmark to compare the helper and inline paths.

If I understand correctly, please split into two parts, one for JIT
and one for selftest.

1. For the JIT part, there are two logical changes, it is better to
split into two patches:
(1) fix the current code.
(2) add new feature.

Regardless of whether bpf_jit_supports_ptr_xchg returns true or false,
amswap_db.b/h/w/d must be used. The LKMM (Linux Kernel Memory Model)
mandates that all value-returning atomic RMW instructions imply a full
barrier. Consequently, decoupling the JIT instruction selection from
the pointer-support state ensures that regular scalar atomic updates
remain sequentially consistent across multi-core systems.

2. For the selftest part, there are two logical changes, it is better
to split into two patches:
(1) enable the functional test "./test_progs -t kptr_xchg_inline".
(2) add benchmark for kptr-xchg performance.

Thanks,
Tiezhu

