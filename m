Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F3336ECD
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671999; cv=none; b=GTD9HFXzLpSDRXXUychvvhhLUPJ8/gL4Xu3WYYZwqs915ZDefDVPjyiHgMUSgcqOtylGy5P8x6nISQnA0ypQU62fsnFOjON+RMz4cvlFh2BRlYd5k90cM0DNYVh4Xq+nf8AOf5R2CJezIe631++EXa8sTySJOoPTNtjn3H2bfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671999; c=relaxed/simple;
	bh=hVAKgzj940kwyxl/7tP5cGh/eb/SthiQ1kE6kqhF2dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RRSUetqbs0uLSzvq01A496ibZSR9UhdOPSkIB+Vnnmpgs7cHoLgYqY+ev8NqB6m4TeUzOvDp+19F4CjzdLfrqjgZGcpTDCWBYozH7Tsh5SQLBGt0Gqkr1Np6t6cX2/lRf7JTm3rV6DYfg4pGgFkEx00vGie730Rtebpkdj7gauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f1rSx6yrvzJ46jy;
	Thu, 29 Jan 2026 15:32:33 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C85DC40539;
	Thu, 29 Jan 2026 15:33:12 +0800 (CST)
Received: from [10.81.199.98] (10.81.199.98) by mscpeml500003.china.huawei.com
 (7.188.49.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Jan
 2026 10:33:11 +0300
Message-ID: <f7b0a9ae-d53d-4bb3-89c9-2a0b56a99170@h-partners.com>
Date: Thu, 29 Jan 2026 10:33:09 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Userspace JIT for eBPF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
References: <ca43be24-6f54-4689-aa8e-23573e83ca5b@h-partners.com>
 <CAADnVQJCYsA6b_DSZEZMRMyt4cADEvX90KkJf6h2fBpep4z8Vg@mail.gmail.com>
Content-Language: en-US
From: Gladyshev Ilya <gladyshev.ilya1@h-partners.com>
In-Reply-To: <CAADnVQJCYsA6b_DSZEZMRMyt4cADEvX90KkJf6h2fBpep4z8Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 1/29/2026 6:00 AM, Alexei Starovoitov wrote:
> On Thu, Jan 22, 2026 at 10:43 AM Gladyshev Ilya
> <gladyshev.ilya1@h-partners.com> wrote:
>>
>>
>> I'd like to propose the idea of adding support for optional userspace
>> JIT engines to the eBPF subsystem. I have a promising prototype already,
>> but I’d like to discuss the broader implications and open questions
>> around this idea before moving forward.
>>
>> Motivation
>> ==========
>> In modern systems, eBPF is often used as a robust and easy-to-use
>> extension mechanism. However, the verifier that provides this robustness
>> also introduces several issues:
>> - It requires a unified intermediate representation (eBPF bytecode) that
>> limits the expressiveness of underlying architectures.
>> - It can’t verify some sophisticated compiler transformations, which
>> leads to either disabling them or using inline eBPF assembly as a
>> workaround.
>>
>> And while verifier has some basic optimizations like dead code
>> elimination and map access inlining, without register reallocation and
>> other rewrites these optimizations do not provide significant benefit.
>> Furthermore, current JIT implementations translate eBPF code
>> instruction-by-instruction, so generated code is far from optimal (7
>> instructions with push/pop for DIV on x86) and can't fully utilize CPU
>> capabilities (extended ISA like cmov, extra registers available on ARM
>> or even amd64).
> 
> The work on a register allocator has already started. It's very early,
> but yeah we do expect nice performance benefits on arm64.
For any performance gains you will also need stack maps for memory to 
register promotion. Also see below

>>
>> But reinventing yet another sophisticated compiler inside the kernel
>> doesn’t make sense.
> 
> That's actually what was happening for years now.

Right now in-kernel compiler is sophisticated only in terms of code 
complexity...

To replicate LLVM, you would need to perform very complex control-flow 
analysis, and right now, the only existing intermediate representation 
is non-SSA bytecode with a very limited instruction set. I doubt that 
even implementing something as simple as common subexpression 
optimization would be reasonably possible in the eBPF verifier... For 
something like cmov, you would end up reinventing the same optimization 
in each architecture-specific JIT.

The main problem is that eBPF is already compiled to a passable degree, 
so any remaining optimizations that could boost its performance are not 
that easy (and often heuristic).

Implementing modern compiler isn't something simple. Look at Go compiler 
and their codegen after all these years :).  Additionally, many bugs 
would likely appear during the process, and I doubt that there would be 
large enough userbase to debug miscompilations / poor codegen...

>> Instead, I propose an optional userspace JIT engine
>> with a fallback to the existing in-kernel translators.
> 
> There are several issues with external JIT.
> 1. It's hard to extend the trust into user space.
> Currently there is no mechanism at all.
> There were proposals to send proof-check into the kernel, but that's
> not trivial either and not compatible with JITing.

That's why this feature is proposed as _optional_. We can relax trust 
model a little bit, and if someone isn't OK with it -- they will just 
use existing in-kernel JIT.

For similar security model see Rex extensions [1]

> 2. JITs have to conform to BPF and kernel memory model.
> The barrier() doesn't exist as an instruction in BPF ISA.
> So any kind of instruction scheduling by JIT (whether in kernel
> or external) might break memory model and break concurrent programs.
> JITs have to follow Documentation/memory-barriers.txt
> We added bpf_load_acquire() insn recently, but it's not enough.
Isn't lack of barrier() trivially fixable via additional pseudo-helper 
function?

>> Overview
>> ========
>> Kernel side is very simple: it only sends eBPF code to userspace and
>> then integrates resulting binary blob into eBPF subsystem -- or falls
>> back to in-kernel translation in case of any error. While this does
>> introduce new code, the integration itself is non-invasive and very small.
>>
>> Userspace side is responsible for correctly compiling eBPF bytecode into
>> binary blob and writing it back to the kernel.  In my implementation,
>> this is an LLVM-based compiler (single statically linked binary)
>> designed to be as simple as possible, offloading all the hard work to
>> LLVM. In the future, some reference compiler can reside in linux/tools
>> as part of the infrastructure.
> 
> LLVM and any other compiler will break concurrent bpf program.
This is solvabe and I don't see any challenges here

>> Because every loaded eBPF program still passes through verifier before
>> JITing, this approach maintains bug-free execution and other eBPF's
> 
> ... maybe bug-free.
Just like any code, including in-kernel JIT :)

>>
>> Performance
>> ===========
>> I ran performance tests on amd64 (Xeon E5-2690 v3) using sched_ext’s
>> eBPF programs, along with a few others. Timing measurements had some
>> skew, but as a pessimistic estimate LLVM-generated code was ~10-20%
>> faster [2] than in-kernel JIT, and produced assembly had 40% less
>> instructions. The most noticeable optimizations were:
>> 1. Re-allocating registers, inlining "DCEd" subfunctions, and cleaning
>> up code after verifier’s DCE [3].
>> 2. Removing leftovers after verifier's inlining (uneeded register
>> shuffles and spills).
>> 3. Using specific instructions like cmov, imulq, seta, mov(8*reg+reg +
>> const) and other.
>> 4. Using jump table (though not for sched_ext).
>> 5. Lots of other small optimizations.
> 
> Would be great if you can contribute these optimizations to the kernel.
There is no infrastructure for them right now and there won't be in the 
foreseeable future.
> 
>> Discussion
>> ==========
>> I’m currently improving existing prototype for an RFC submission and
>> will try to collect more reliable performance data. However, there are
>> several discussion points that require community feedback:
>> - Overall design
> 
> Sorry. no go.

[1]: https://lpc.events/event/19/contributions/2190/

