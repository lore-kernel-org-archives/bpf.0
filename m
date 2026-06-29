Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2A2E11C7
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782710832; cv=none; b=lMgp8qVEYqA0F545fhzvjtOKwFoLO4XbL5TRFt5H8uWxWoSnQ3AO0Ci1GpEF6ZZk1HM+B1g+qTT1fhYksGmpXIwiKEBXlvwS4EA7yKewGZdtJsfmwF1aJYputso4iqbpAJgatl+6n1W+YHTT076AgIiS2CQihoGsukPJJqcTus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782710832; c=relaxed/simple;
	bh=aoHgVDXrPe+khxZ20XA6EzrxsvnL/NCzkvYe2uxL2rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMt9dz07c77ywDnwrIuVgIRR3ohdPdI/7IH88oTL+xwz06WdZWQZphH6i3ECkuWtNhEvXmmca96IPcNsB/3dn7t+MvQlvZ6TiyYIohKHvEWwYkjusZSFqxicg6b3lvkl6qpfDPCqaebCcWtio0bKhJY2JA4Rsu4VbzyTlfhwUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=chNxAmwU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="chNxAmwU"
Message-ID: <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782710818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvMGb1NBWQnzu15950bmdYdpqyEHHT5NPIcwxN+U8qI=;
	b=chNxAmwUa4sO3yqpHX6+7XgeOF27ei2bVCXI5++QVzZhYYK2TUQQKnExqgq6jWjMzzY+2z
	XF3thfN2/al6MWMpIaa+31g2Jiqa06lAx8OjABiADVZMANnNwbislXlNKycWsFdRxD1Iyl
	5eF3xBytYmdY4gMYLLhrczxVWn2p8n8=
Date: Mon, 29 Jun 2026 13:26:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/6/26 11:27, Xu Kuohai wrote:
> On 6/29/2026 10:14 AM, Leon Hwang wrote:
>> Hi Kuohai,
>>
>> On 28/6/26 06:51, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> This series introduces static-defined tracing probes for BPF programs.
>>> BPF SDT (static-defined tracing) works similarly to USDT. User defines
>>
>>
>> At first glance, the SDT idea looks cool to me.
>>
>> However, what's your purpose of introducing SDT?
>>
> 
> Well, the purpose is to add a dynamic, zero-overhead tracing mechanism for
> bpf, not just at function entry, but anywhere inside the prog source code.
> 

Better to carry the purpose in cover letter in the future.

>> If to provide points in bpf progs to be traced, like tracepoints in
>> kernel functions, I think subprog+fentry is an alternative approach.
>> Comparing with SDT, subprog+fentry requires a function call at run time,
>> instead of a NOP like SDT.
>>
[...]
>>
>> Furthermore, if users don't want a function call at run time, e.g. they
>> don't want to call 'my_trace' at run time in production, they can patch
>> the callsite of 'my_trace' with NOP before loading 'xdp_prog', and drop
>> the subprog 'my_trace' in their user space application. This elimination
>> is approachable, since it is used heavily in bpfsnoop [1].
> 
> Sounds like the subprog+fentry you described gives a good evidance for real
> demand of dyanmic tracing inside function body.

Correct.

A subprog in an existing bpf prog can be used to inspect the prog's
runtime details, including the 'tail_call_cnt' on the stack.

An extra subprog as stub is better for dynamic tracing.

See my blog post:
https://blog.leonhw.com/post/ebpf-talk-138-debug-tailcall-bug-with-fentry/.

> 
> IIUC, even though the CALL instruction at the callsite is patched to NOP at
> runtime, the argument preparation instructions - r1 = len, r2 = ctx -
> remain

Correct.

> in the callsite. For SDT, the argument preparation is recorded as metadata
> out of line, and is never executed.

So, does argument preparation require the verifier to analyze the
registers to identify the argument registers, when an SDT is defined in
a prog? What if the verifier cannot identify them?

> 
> And I think SDT is cleaner and easier to use. User just declares the
> prototype
> and insert the probe, no need to hack with subprog+fentry.
> 
>> However, this elimination is not easy to understand. Want me to show >
>> mored etails about this elimination?
>>
> 
> That would be appreciated, thanks.
> 

static __noinline void
subprog(int len, int ret)
{
    __sink(len);
    __sink(ret);
}

SEC("xdp")
int xdp_fn(struct xdp_md *ctx)
{
    struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
    struct iphdr *iph = (struct iphdr *)(eth + 1);
    int len = ctx->data_end - ctx->data;
    int ret = XDP_PASS;

    if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
        return ret;

    if (iph->protocol != IPPROTO_ICMP)
        return ret;

    barrier_var(ret);
    subprog(len, ret);

    return ret;
}

After attaching 'xdp_fn' to 'lo',

===
without the elimination:

bpftool p d x n xdp_fn
int xdp_fn(struct xdp_md * ctx):
; int xdp_fn(struct xdp_md *ctx)
   0: (b7) r0 = 2
; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
   1: (79) r2 = *(u64 *)(r1 +0)
; int len = ctx->data_end - ctx->data;
   2: (79) r1 = *(u64 *)(r1 +8)
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
   3: (bf) r3 = r2
   4: (07) r3 += 34
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
   5: (2d) if r3 > r1 goto pc+10
   6: (b7) r3 = 9
; struct iphdr *iph = (struct iphdr *)(eth + 1);
   7: (bf) r4 = r2
   8: (0f) r4 += r3
; if (iph->protocol != IPPROTO_ICMP)
   9: (71) r3 = *(u8 *)(r4 +14)
; if (iph->protocol != IPPROTO_ICMP)
  10: (55) if r3 != 0x1 goto pc+5
  11: (1f) r1 -= r2
  12: (b7) r6 = 2
; subprog(len, ret);
  13: (bf) r2 = r6
  14: (85) call pc+2#bpf_prog_6a2f766e16102c10_subprog
  15: (bf) r0 = r6
; }
  16: (95) exit
void subprog(int len, int ret):
; subprog(int len, int ret)
  17: (63) *(u32 *)(r10 -8) = r2
  18: (63) *(u32 *)(r10 -4) = r1
; __sink(len);
  19: (63) *(u32 *)(r10 -4) = r1
; __sink(ret);
  20: (63) *(u32 *)(r10 -8) = r2
; }
  21: (95) exit


bpftool p d j n xdp_fn
int xdp_fn(struct xdp_md * ctx):
bpf_prog_6480db4581c3a618_xdp_fn:
; int xdp_fn(struct xdp_md *ctx)
   0:	nopl	(%rax,%rax)
   5:	nop
   7:	pushq	%rbp
   8:	movq	%rsp, %rbp
   b:	pushq	%rbx
   c:	movl	$2, %eax
; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
  11:	movq	(%rdi), %rsi
; int len = ctx->data_end - ctx->data;
  15:	movq	8(%rdi), %rdi
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
  19:	movq	%rsi, %rdx
  1c:	addq	$34, %rdx
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
  20:	cmpq	%rdi, %rdx
  23:	ja	0xffffffffc0000926
  25:	movl	$9, %edx
; struct iphdr *iph = (struct iphdr *)(eth + 1);
  2a:	movq	%rsi, %rcx
  2d:	addq	%rdx, %rcx
; if (iph->protocol != IPPROTO_ICMP)
  30:	movzbq	14(%rcx), %rdx
; if (iph->protocol != IPPROTO_ICMP)
  35:	cmpq	$1, %rdx
  39:	jne	0xffffffffc0000926
  3b:	subq	%rsi, %rdi
  3e:	movl	$2, %ebx
; subprog(len, ret);
  43:	movq	%rbx, %rsi
  46:	callq	0xffffffffc00009d0
  4b:	movq	%rbx, %rax
; }
  4e:	popq	%rbx
  4f:	leave
  50:	retq
  51:	int3

void subprog(int len, int ret):
bpf_prog_6a2f766e16102c10_subprog:
; subprog(int len, int ret)
   0:	nopl	(%rax,%rax)
   5:	nop
   7:	pushq	%rbp
   8:	movq	%rsp, %rbp
   b:	subq	$8, %rsp
  12:	movl	%esi, -8(%rbp)
  15:	movl	%edi, -4(%rbp)
; __sink(len);
  18:	movl	%edi, -4(%rbp)
; __sink(ret);
  1b:	movl	%esi, -8(%rbp)
; }
  1e:	leave
  1f:	retq
  20:	int3


===
with the elimination:

bpftool p d x n xdp_fn
int xdp_fn(struct xdp_md * ctx):
; int xdp_fn(struct xdp_md *ctx)
   0: (b7) r0 = 2
; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
   1: (79) r2 = *(u64 *)(r1 +0)
; int len = ctx->data_end - ctx->data;
   2: (79) r1 = *(u64 *)(r1 +8)
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
   3: (bf) r3 = r2
   4: (07) r3 += 34
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
   5: (2d) if r3 > r1 goto pc+9
   6: (b7) r3 = 9
; struct iphdr *iph = (struct iphdr *)(eth + 1);
   7: (bf) r4 = r2
   8: (0f) r4 += r3
; if (iph->protocol != IPPROTO_ICMP)
   9: (71) r3 = *(u8 *)(r4 +14)
; if (iph->protocol != IPPROTO_ICMP)
  10: (55) if r3 != 0x1 goto pc+4
  11: (1f) r1 -= r2
  12: (b7) r6 = 2
; subprog(len, ret);
  13: (bf) r2 = r6
  14: (bf) r0 = r6
; }
  15: (95) exit


bpftool p d j n xdp_fn
int xdp_fn(struct xdp_md * ctx):
bpf_prog_861d0ecc72ad8d9e_xdp_fn:
; int xdp_fn(struct xdp_md *ctx)
   0:	nopl	(%rax,%rax)
   5:	nop
   7:	pushq	%rbp
   8:	movq	%rsp, %rbp
   b:	pushq	%rbx
   c:	movl	$2, %eax
; struct ethhdr *eth = (struct ethhdr *)(ctx_ptr(ctx, data));
  11:	movq	(%rdi), %rsi
; int len = ctx->data_end - ctx->data;
  15:	movq	8(%rdi), %rdi
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
  19:	movq	%rsi, %rdx
  1c:	addq	$34, %rdx
; if ((void *)(iph + 1) > ctx_ptr(ctx, data_end))
  20:	cmpq	%rdi, %rdx
  23:	ja	0xffffffffc0000929
  25:	movl	$9, %edx
; struct iphdr *iph = (struct iphdr *)(eth + 1);
  2a:	movq	%rsi, %rcx
  2d:	addq	%rdx, %rcx
; if (iph->protocol != IPPROTO_ICMP)
  30:	movzbq	14(%rcx), %rdx
; if (iph->protocol != IPPROTO_ICMP)
  35:	cmpq	$1, %rdx
  39:	jne	0xffffffffc0000929
  3b:	subq	%rsi, %rdi
  3e:	movl	$2, %ebx
; subprog(len, ret);
  43:	movq	%rbx, %rsi
  46:	movq	%rbx, %rax
; }
  49:	popq	%rbx
  4a:	leave
  4b:	retq
  4c:	int3


Demo source code:
https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/eliminate-subprog


With the elimination, the callsite of 'subprog' has been eliminated.

However, as you mentioned above, the argument preparation insns are kept.

Thanks,
Leon

