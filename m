Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556C37C0FF;
	Mon, 29 Jun 2026 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703638; cv=none; b=jjJ1/IwjQ2rdHkwccWXnSsZdEhEel/56KBS4/Cy88bAa3CtVkG0lLZZwh/hwNLnAjLfexV/+WyCvx4bSN6VQX9TOdg/qp7FwDJ8CWdRFKzYZvdmc2fkfOK/nEdj1RARhAzXi5sZPpCsq2BzQTRRacSy/+bErfyF2B5iott7fAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703638; c=relaxed/simple;
	bh=Cj/8dglih8D0DnH5bXTCPZtOPaooc2mG6W9vEFkkFT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gu8xdDCFvLxoN1Pd+BDNJsIRBo3D1K9czuSZ1SjkV3pT6o2JbtnRUAKdcePuRRt+jK7/4qzvp9+xwIFCgHg+TeHa2YCRhO+0vyBUaucWcB3Ub166zopvZuNny+aBEjfstgW9OKqSiQEVxsdGfloTaS6SRY6Sax0ANM8BdBJyY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpWsv32SkzKHMcn;
	Mon, 29 Jun 2026 11:26:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 39CA540873;
	Mon, 29 Jun 2026 11:27:05 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgD3uv4H5kFqPODNAA--.32934S2;
	Mon, 29 Jun 2026 11:27:05 +0800 (CST)
Message-ID: <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
Date: Mon, 29 Jun 2026 11:27:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3uv4H5kFqPODNAA--.32934S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfXr1xZF48ZF1UtF1fWFg_yoW8tw4UpF
	43ZrnYyF1vqF42yF97Jr4fAFWFv395GrW3Jrn5WrWSv3ZrXr1vgF42gFWYvF98ur48u34I
	qay0vrsxWr15ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/29/2026 10:14 AM, Leon Hwang wrote:
> Hi Kuohai,
> 
> On 28/6/26 06:51, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> This series introduces static-defined tracing probes for BPF programs.
>> BPF SDT (static-defined tracing) works similarly to USDT. User defines
> 
> 
> At first glance, the SDT idea looks cool to me.
> 
> However, what's your purpose of introducing SDT?
>

Well, the purpose is to add a dynamic, zero-overhead tracing mechanism for
bpf, not just at function entry, but anywhere inside the prog source code.

> If to provide points in bpf progs to be traced, like tracepoints in
> kernel functions, I think subprog+fentry is an alternative approach.
> Comparing with SDT, subprog+fentry requires a function call at run time,
> instead of a NOP like SDT.
> 
> For example,
> 
> #define __sink(expr) asm volatile("" : "+g"(expr))
> 
> static __noinline void my_trace(int len, int ret)
> {
> 	__sink(len);
> 	__sink(ret);
> }
> 
> SEC("xdp")
> int xdp_prog(struct xdp_md *ctx)
> {
> 	int len = ctx->data_end - ctx->data;
> 	int ret = XDP_DROP;
> 	...
> 	my_trace(len, ret);
> 	...
> }
> 
> 'my_trace' can be traced using fentry to inspect the details of 'xdp_prog'.
> 
> Furthermore, if users don't want a function call at run time, e.g. they
> don't want to call 'my_trace' at run time in production, they can patch
> the callsite of 'my_trace' with NOP before loading 'xdp_prog', and drop
> the subprog 'my_trace' in their user space application. This elimination
> is approachable, since it is used heavily in bpfsnoop [1].

Sounds like the subprog+fentry you described gives a good evidance for real
demand of dyanmic tracing inside function body.

IIUC, even though the CALL instruction at the callsite is patched to NOP at
runtime, the argument preparation instructions - r1 = len, r2 = ctx - remain
in the callsite. For SDT, the argument preparation is recorded as metadata
out of line, and is never executed.

And I think SDT is cleaner and easier to use. User just declares the prototype
and insert the probe, no need to hack with subprog+fentry.

> However, this elimination is not easy to understand. Want me to show > mored etails about this elimination?
>

That would be appreciated, thanks.

> Link:
> [1] https://github.com/bpfsnoop/bpfsnoop
> 
> Thanks,
> Leon

