Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C82BA45;
	Mon, 29 Jun 2026 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719498; cv=none; b=fvkzRmEolPncxA6YebwMqBEBmS08J7+1zNXtci7dp6blP+Md/jCSz6/P9dxhN5in3Z1vo2rWfP9tciLh6bEXzImt70MbSslkszLGl4rFihK3aUBl/HnXQDnNvOQMbWg+XY6oVb9VdZGYf0CG3gUmK8ZQ5RY8E2/axt4fJgJYvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719498; c=relaxed/simple;
	bh=eBEuRwsonxsBISJwWNuDseekumI8c7aVSN1D4Qb7K3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlnUZ40y6+8nVtbQR4CNcIsr7w6VXzN6A6ZzNg0OuWDQvOYysX9g/ezwOlM9EdAcjlsJVvLK9Dm2JZ/QGv4jHN/Ln/2OVFozQFYwhA67KjeDJFDN/vfwDSenG/kM2Wocrm3knG801lUCcTmvDxq8OAes5NBFOtZg+Po6yuD6E1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpdkx0vbjzKHMVX;
	Mon, 29 Jun 2026 15:51:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 39FE940574;
	Mon, 29 Jun 2026 15:51:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHy_77I0JqFCzkAA--.42713S2;
	Mon, 29 Jun 2026 15:51:25 +0800 (CST)
Message-ID: <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
Date: Mon, 29 Jun 2026 15:51:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
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
 <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
 <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHy_77I0JqFCzkAA--.42713S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1xAFWUKF1kXFyDKr1fCrg_yoWfXryDpF
	9xJa4rK397XF1jyF1xJrWYyayYgw4ftr45J3WrCrWI9w1q9r1FgF1UGFWYkF1Y9r1v9r1I
	v3y2ywsxWr9FkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 6/29/2026 1:26 PM, Leon Hwang wrote:
> On 29/6/26 11:27, Xu Kuohai wrote:
>> On 6/29/2026 10:14 AM, Leon Hwang wrote:
>>> Hi Kuohai,
>>>
>>> On 28/6/26 06:51, Xu Kuohai wrote:
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> This series introduces static-defined tracing probes for BPF programs.
>>>> BPF SDT (static-defined tracing) works similarly to USDT. User defines
>>>
>>>
>>> At first glance, the SDT idea looks cool to me.
>>>
>>> However, what's your purpose of introducing SDT?
>>>
>>
>> Well, the purpose is to add a dynamic, zero-overhead tracing mechanism for
>> bpf, not just at function entry, but anywhere inside the prog source code.
>>
> 
> Better to carry the purpose in cover letter in the future.
>

Ok, will add it in the next verion.

>>> If to provide points in bpf progs to be traced, like tracepoints in
>>> kernel functions, I think subprog+fentry is an alternative approach.
>>> Comparing with SDT, subprog+fentry requires a function call at run time,
>>> instead of a NOP like SDT.
>>>
> [...]
>>>
>>> Furthermore, if users don't want a function call at run time, e.g. they
>>> don't want to call 'my_trace' at run time in production, they can patch
>>> the callsite of 'my_trace' with NOP before loading 'xdp_prog', and drop
>>> the subprog 'my_trace' in their user space application. This elimination
>>> is approachable, since it is used heavily in bpfsnoop [1].
>>
>> Sounds like the subprog+fentry you described gives a good evidance for real
>> demand of dyanmic tracing inside function body.
> 
> Correct.
> 
> A subprog in an existing bpf prog can be used to inspect the prog's
> runtime details, including the 'tail_call_cnt' on the stack.
> 
> An extra subprog as stub is better for dynamic tracing.
> 
> See my blog post:
> https://blog.leonhw.com/post/ebpf-talk-138-debug-tailcall-bug-with-fentry/.
> 
>>
>> IIUC, even though the CALL instruction at the callsite is patched to NOP at
>> runtime, the argument preparation instructions - r1 = len, r2 = ctx -
>> remain
> 
> Correct.
> 
>> in the callsite. For SDT, the argument preparation is recorded as metadata
>> out of line, and is never executed.
> 
> So, does argument preparation require the verifier to analyze the
> registers to identify the argument registers, when an SDT is defined in
> a prog? What if the verifier cannot identify them?
>

The arguemnt registers are identified by libbpf from the source register
of the BPF move instructions (e.g. arg_reg1 from r1 = arg_reg1) created
by the probe mcaro.

For target prog side, the prototype BTF are used by the verifier to check
if the argument register types match the prototype.

For observer prog side, the prototype BTF are used to validate the access
to the argument registers, and the registers are used explicitly by the
bpf trampoline to construct the context for the observer prog.

See:
1. sdt_parse_arg() in patch 03
2. check_sdt_probe() in patch 06,
3. check_attach_btf_id() in patch 09, wher check_attach_btf_id() sets the
    prog->aux->attach_func_proto for SDT, then btf_ctx_access() uses it
    to check the access.
4. save_args() in patch 11

>>
>> And I think SDT is cleaner and easier to use. User just declares the
>> prototype
>> and insert the probe, no need to hack with subprog+fentry.
>>
>>> However, this elimination is not easy to understand. Want me to show >
>>> mored etails about this elimination?
>>>
>>
>> That would be appreciated, thanks.
>>
> 
> static __noinline void
> subprog(int len, int ret)
> {
>      __sink(len);
>      __sink(ret);
> }
> 
> SEC("xdp")
> int xdp_fn(struct xdp_md *ctx)
> {
>      struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
>      struct iphdr *iph = (struct iphdr *)(eth + 1);
>      int len = ctx->data_end - ctx->data;
>      int ret = XDP_PASS;
> 
>      if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>          return ret;
> 
>      if (iph->protocol != IPPROTO_ICMP)
>          return ret;
> 
>      barrier_var(ret);
>      subprog(len, ret);
> 
>      return ret;
> }
> 
> After attaching 'xdp_fn' to 'lo',
> 
> ===
> without the elimination:
> 
> bpftool p d x n xdp_fn
> int xdp_fn(struct xdp_md * ctx):
> ; int xdp_fn(struct xdp_md *ctx)
>     0: (b7) r0 = 2
> ; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
>     1: (79) r2 = *(u64 *)(r1 +0)
> ; int len = ctx->data_end - ctx->data;
>     2: (79) r1 = *(u64 *)(r1 +8)
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>     3: (bf) r3 = r2
>     4: (07) r3 += 34
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>     5: (2d) if r3 > r1 goto pc+10
>     6: (b7) r3 = 9
> ; struct iphdr *iph = (struct iphdr *)(eth + 1);
>     7: (bf) r4 = r2
>     8: (0f) r4 += r3
> ; if (iph->protocol != IPPROTO_ICMP)
>     9: (71) r3 = *(u8 *)(r4 +14)
> ; if (iph->protocol != IPPROTO_ICMP)
>    10: (55) if r3 != 0x1 goto pc+5
>    11: (1f) r1 -= r2
>    12: (b7) r6 = 2
> ; subprog(len, ret);
>    13: (bf) r2 = r6
>    14: (85) call pc+2#bpf_prog_6a2f766e16102c10_subprog
>    15: (bf) r0 = r6
> ; }
>    16: (95) exit
> void subprog(int len, int ret):
> ; subprog(int len, int ret)
>    17: (63) *(u32 *)(r10 -8) = r2
>    18: (63) *(u32 *)(r10 -4) = r1
> ; __sink(len);
>    19: (63) *(u32 *)(r10 -4) = r1
> ; __sink(ret);
>    20: (63) *(u32 *)(r10 -8) = r2
> ; }
>    21: (95) exit
> 
> 
> bpftool p d j n xdp_fn
> int xdp_fn(struct xdp_md * ctx):
> bpf_prog_6480db4581c3a618_xdp_fn:
> ; int xdp_fn(struct xdp_md *ctx)
>     0:	nopl	(%rax,%rax)
>     5:	nop
>     7:	pushq	%rbp
>     8:	movq	%rsp, %rbp
>     b:	pushq	%rbx
>     c:	movl	$2, %eax
> ; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
>    11:	movq	(%rdi), %rsi
> ; int len = ctx->data_end - ctx->data;
>    15:	movq	8(%rdi), %rdi
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>    19:	movq	%rsi, %rdx
>    1c:	addq	$34, %rdx
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>    20:	cmpq	%rdi, %rdx
>    23:	ja	0xffffffffc0000926
>    25:	movl	$9, %edx
> ; struct iphdr *iph = (struct iphdr *)(eth + 1);
>    2a:	movq	%rsi, %rcx
>    2d:	addq	%rdx, %rcx
> ; if (iph->protocol != IPPROTO_ICMP)
>    30:	movzbq	14(%rcx), %rdx
> ; if (iph->protocol != IPPROTO_ICMP)
>    35:	cmpq	$1, %rdx
>    39:	jne	0xffffffffc0000926
>    3b:	subq	%rsi, %rdi
>    3e:	movl	$2, %ebx
> ; subprog(len, ret);
>    43:	movq	%rbx, %rsi
>    46:	callq	0xffffffffc00009d0
>    4b:	movq	%rbx, %rax
> ; }
>    4e:	popq	%rbx
>    4f:	leave
>    50:	retq
>    51:	int3
> 
> void subprog(int len, int ret):
> bpf_prog_6a2f766e16102c10_subprog:
> ; subprog(int len, int ret)
>     0:	nopl	(%rax,%rax)
>     5:	nop
>     7:	pushq	%rbp
>     8:	movq	%rsp, %rbp
>     b:	subq	$8, %rsp
>    12:	movl	%esi, -8(%rbp)
>    15:	movl	%edi, -4(%rbp)
> ; __sink(len);
>    18:	movl	%edi, -4(%rbp)
> ; __sink(ret);
>    1b:	movl	%esi, -8(%rbp)
> ; }
>    1e:	leave
>    1f:	retq
>    20:	int3
> 
> 
> ===
> with the elimination:
> 
> bpftool p d x n xdp_fn
> int xdp_fn(struct xdp_md * ctx):
> ; int xdp_fn(struct xdp_md *ctx)
>     0: (b7) r0 = 2
> ; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
>     1: (79) r2 = *(u64 *)(r1 +0)
> ; int len = ctx->data_end - ctx->data;
>     2: (79) r1 = *(u64 *)(r1 +8)
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>     3: (bf) r3 = r2
>     4: (07) r3 += 34
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>     5: (2d) if r3 > r1 goto pc+9
>     6: (b7) r3 = 9
> ; struct iphdr *iph = (struct iphdr *)(eth + 1);
>     7: (bf) r4 = r2
>     8: (0f) r4 += r3
> ; if (iph->protocol != IPPROTO_ICMP)
>     9: (71) r3 = *(u8 *)(r4 +14)
> ; if (iph->protocol != IPPROTO_ICMP)
>    10: (55) if r3 != 0x1 goto pc+4
>    11: (1f) r1 -= r2
>    12: (b7) r6 = 2
> ; subprog(len, ret);
>    13: (bf) r2 = r6
>    14: (bf) r0 = r6
> ; }
>    15: (95) exit
> 
> 
> bpftool p d j n xdp_fn
> int xdp_fn(struct xdp_md * ctx):
> bpf_prog_861d0ecc72ad8d9e_xdp_fn:
> ; int xdp_fn(struct xdp_md *ctx)
>     0:	nopl	(%rax,%rax)
>     5:	nop
>     7:	pushq	%rbp
>     8:	movq	%rsp, %rbp
>     b:	pushq	%rbx
>     c:	movl	$2, %eax
> ; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
>    11:	movq	(%rdi), %rsi
> ; int len = ctx->data_end - ctx->data;
>    15:	movq	8(%rdi), %rdi
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>    19:	movq	%rsi, %rdx
>    1c:	addq	$34, %rdx
> ; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
>    20:	cmpq	%rdi, %rdx
>    23:	ja	0xffffffffc0000929
>    25:	movl	$9, %edx
> ; struct iphdr *iph = (struct iphdr *)(eth + 1);
>    2a:	movq	%rsi, %rcx
>    2d:	addq	%rdx, %rcx
> ; if (iph->protocol != IPPROTO_ICMP)
>    30:	movzbq	14(%rcx), %rdx
> ; if (iph->protocol != IPPROTO_ICMP)
>    35:	cmpq	$1, %rdx
>    39:	jne	0xffffffffc0000929
>    3b:	subq	%rsi, %rdi
>    3e:	movl	$2, %ebx
> ; subprog(len, ret);
>    43:	movq	%rbx, %rsi
>    46:	movq	%rbx, %rax
> ; }
>    49:	popq	%rbx
>    4a:	leave
>    4b:	retq
>    4c:	int3
> 
> 
> Demo source code:
> https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/eliminate-subprog
> 
> 
> With the elimination, the callsite of 'subprog' has been eliminated.
> 
> However, as you mentioned above, the argument preparation insns are kept.
>

I see, the CALL insntruction is removed, not patched to NOP.

So the call site is either a call to subprog, or totally removed. The fentry
tracing only works when the CALL instruction and the subprog are not eliminated.
This is exactly what SDT tries to solve.

> Thanks,
> Leon

