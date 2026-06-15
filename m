Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FD3C0A0D;
	Mon, 15 Jun 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514517; cv=none; b=dhXcdZE6HCKtMqDtqVTBNwYHVkVViwyMbmFrqbc38FIvnZ7pDqRdzr1PDG+q5jljLAXFjKHTNGuVNNf7ARkAE2Pz+NLxwJlD9vCviKRhvR7ywHnYHIppheyV+FLa8+MVXb+24e0QoqMqyti5fx/k8OqjP70AFDKODio2zdxIyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514517; c=relaxed/simple;
	bh=ktQ3gGs6h5tUKX+MwCKTqRQnHTjGY8sISQtky2XhLyM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=myH6Z67bgxuqL2tLVJsBmgcqX1q3eKI828RbzT/n8+G2XBZdhEXu5zqgyHZhMVwGzz5tE49ZxRJrY+1aCdHcWyeerh2js2m6jRYUBd4BxeYa9FC3JsU4O+lnTWxfA0uXQN1VgF8OWVTYtsRclP4RgntNnuF8fK6/DHWLb+GZrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxhngQwS9q4EcUAA--.28453S3;
	Mon, 15 Jun 2026 17:08:32 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxjcIEwS9qFPmmAA--.52334S3;
	Mon, 15 Jun 2026 17:08:21 +0800 (CST)
Subject: Re: [PATCH v1 0/2] LoongArch: BPF: per-CPU addr MOV and timed
 may_goto
To: Huacai Chen <chenhuacai@kernel.org>, George Guo <dongtai.guo@linux.dev>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, WANG Xuerui <kernel@xen0n.name>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
References: <20260609041407.122384-1-dongtai.guo@linux.dev>
 <CAAhV-H76pzANGo3kx7FNNRJu+9F8XFzZ7+Qu-WE3oXO=jM1=oA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ab8e2b43-dbb7-629c-052e-a9a269268b88@loongson.cn>
Date: Mon, 15 Jun 2026 17:08:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H76pzANGo3kx7FNNRJu+9F8XFzZ7+Qu-WE3oXO=jM1=oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcIEwS9qFPmmAA--.52334S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw13WF48JryfCrW3Aw4fZwc_yoWDGFg_W3
	98W342kw4rGFsxta1Iqa13ZFWSqw4jkr1rtryjgF18Jr9YyFWqkF93CFyfXws7Kw4rCFnI
	gw1DXayYvry7ZosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=

On 2026/6/13 上午11:09, Huacai Chen wrote:
> Hi, Tiezhu and Hengqi,
> 
> Any comments about this series?

This is a preliminary review during the current merge window.

Based on the DWARF for the LoongArch Architecture specification,
GCC disassembly, the kernel's ORC definition (unwind_orc.c), and
the BPF JIT stack layout defined in build_prologue(), the saving
position of $ra in your trampoline is incorrect.

build_prologue() explicitly shows that LoongArch BPF JIT expects
$ra to be stored at the highest slot right below the original $sp.
Furthermore, the ORC unwinder strictly mandates .ra_offset = -8
(PREV_SP - 8). Storing $ra at 0($sp) (which is PREV_SP - 64)
breaks both JIT conventions and kernel stack unwinding.

Since we are currently in the Merge Window, please take your time
to rebase this patchset against the latest tree and send a v2 after
the merge window closes (post -rc1), and please wait for more time
to get more comments.

Thanks,
Tiezhu

