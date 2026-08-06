Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D986478E5D;
	Thu,  6 Aug 2026 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018992; cv=none; b=ANxHLQg+JSyzOSEJQFuUcO2x3Y8CPnAt4F6ccl/zYtV9G73w9uvUJ8nf4vCcsklafySwVTw4FGYCdWk4tEo2D65jn20UA8dGhtvceZ7nxb12QaZd5JNQr/uJK1hBkE31pnSMzbwjmZfaeXSdB38cTUuGAQ8KZtC0Gpq+EiD9udk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018992; c=relaxed/simple;
	bh=7TY4VO0V35MkHMTOVsR6vRafUYEoqU02CR/tnCI6tFA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SaCP81tqM2N+B5wd0c6D7HcTe//IfO7WNDkxyNpk+qs/z30T23x+1o9somH7jNuD065J3Gb7nPk/eXvj6oJxnjd96YEjn+W49NLKYsfm2Xienq8H3J/QMJO61IhzMAfRczMG4/jRn1n1+ri/qe/TI9ADXtqALiQFHBfK40aE3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Dx9+qgfHRqs_sKAA--.35352S3;
	Thu, 06 Aug 2026 20:22:56 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxEuSffHRqGcYlAA--.7072S2;
	Thu, 06 Aug 2026 20:22:56 +0800 (CST)
Subject: Re: [PATCH v3 0/2] LoongArch: BPF: per-CPU address resolution and
 timed may_goto
To: George Guo <dongtai.guo@linux.dev>, chenhuacai@kernel.org,
 hengqi.chen@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: kernel@xen0n.name, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, guodongtai@kylinos.cn, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260804153938.16129-1-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <936e5942-5722-c86e-2c5b-c048199ed6e6@loongson.cn>
Date: Thu, 6 Aug 2026 20:22:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260804153938.16129-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuSffHRqGcYlAA--.7072S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF1ftrWxJw13uFyxXrWrZwc_yoWxCFgEgF
	97GFn8Gr18Xry3Ar4IgrW5JFZrX3ya9F429rs7J34UJ3sIv34kXrs0qr13A3W0g39Yyan3
	ta9IvF1fAryFgosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUU
	UU=

On 2026/8/4 下午11:39, George Guo wrote:
> These are the first two patches of the LoongArch BPF JIT feature work,
> sent on their own to make review easier. The remaining pieces
> (per-program private stacks, exceptions/bpf_throw, sign-extending loads
> and atomics on arena pointers, and the matching selftests) will follow in
> a later series.

The patches apply cleanly on top of Chenguang's series.

The following selftests passed on LoongArch:

   # ./test_progs -t cpumask
   # ./test_progs -t percpu_alloc
   # ./test_progs -t iters

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu

