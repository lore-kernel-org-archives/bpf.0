Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EC31A044
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073617; cv=none; b=kabJwp3hZq6HSPJNxlzO1eCJ8C05hW+idU3CuEWa707RLiJosqHjQsI1XMQhyGu7zbkWu+YVB6tJrLQQq8WmENVpxx6W95JWPaytjm7xBnB2p87A74HxJ3IuqsPFqdGtgFrU0icybrUM5BFgMBAFpu1dtneg6fxYaX3Y71rX3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073617; c=relaxed/simple;
	bh=snkTxMn/AkTSOy8qwYLiFYCGpGuzxrmwbE8E4PZiUQc=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=f0mhDuuN4xCn9vXA9vRUAGfCrYMmFfVfzXt8e8zX0RiHAmAtpu+p551PowunqFmuEQTLRtZQgJfjQnMPZUpMpeaEtOycdJwqBMfbBaqzXXI5ug1Ig/LZa64C6kUQy9m4M23gz3Qyj7RKDV1VOqys6GTS8SNwxyiI6sNKldWl4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxb9h0XPSzHnGgd;
	Thu, 22 Jan 2026 17:19:36 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 785C740563;
	Thu, 22 Jan 2026 17:20:11 +0800 (CST)
Received: from [10.123.123.67] (10.123.123.67) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Jan 2026 12:20:10 +0300
Message-ID: <ca43be24-6f54-4689-aa8e-23573e83ca5b@h-partners.com>
Date: Thu, 22 Jan 2026 12:20:07 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Gladyshev Ilya <gladyshev.ilya1@h-partners.com>
To: <lsf-pc@lists.linux-foundation.org>
CC: <bpf@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] Userspace JIT for eBPF
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 mscpeml500003.china.huawei.com (7.188.49.51)


I'd like to propose the idea of adding support for optional userspace 
JIT engines to the eBPF subsystem. I have a promising prototype already, 
but I’d like to discuss the broader implications and open questions 
around this idea before moving forward.

Motivation
==========
In modern systems, eBPF is often used as a robust and easy-to-use 
extension mechanism. However, the verifier that provides this robustness 
also introduces several issues:
- It requires a unified intermediate representation (eBPF bytecode) that 
limits the expressiveness of underlying architectures.
- It can’t verify some sophisticated compiler transformations, which 
leads to either disabling them or using inline eBPF assembly as a 
workaround.

And while verifier has some basic optimizations like dead code 
elimination and map access inlining, without register reallocation and 
other rewrites these optimizations do not provide significant benefit. 
Furthermore, current JIT implementations translate eBPF code 
instruction-by-instruction, so generated code is far from optimal (7 
instructions with push/pop for DIV on x86) and can't fully utilize CPU 
capabilities (extended ISA like cmov, extra registers available on ARM 
or even amd64).

But reinventing yet another sophisticated compiler inside the kernel 
doesn’t make sense. Instead, I propose an optional userspace JIT engine 
with a fallback to the existing in-kernel translators.

Overview
========
Kernel side is very simple: it only sends eBPF code to userspace and 
then integrates resulting binary blob into eBPF subsystem -- or falls 
back to in-kernel translation in case of any error. While this does 
introduce new code, the integration itself is non-invasive and very small.

Userspace side is responsible for correctly compiling eBPF bytecode into 
binary blob and writing it back to the kernel.  In my implementation, 
this is an LLVM-based compiler (single statically linked binary) 
designed to be as simple as possible, offloading all the hard work to 
LLVM. In the future, some reference compiler can reside in linux/tools 
as part of the infrastructure.

Because every loaded eBPF program still passes through verifier before 
JITing, this approach maintains bug-free execution and other eBPF's 
guarantees. However, it now enables sophisticated optimizations and 
advanced instruction selection.

Performance
===========
I ran performance tests on amd64 (Xeon E5-2690 v3) using sched_ext’s 
eBPF programs, along with a few others. Timing measurements had some 
skew, but as a pessimistic estimate LLVM-generated code was ~10-20% 
faster [2] than in-kernel JIT, and produced assembly had 40% less 
instructions. The most noticeable optimizations were:
1. Re-allocating registers, inlining "DCEd" subfunctions, and cleaning 
up code after verifier’s DCE [3].
2. Removing leftovers after verifier's inlining (uneeded register 
shuffles and spills).
3. Using specific instructions like cmov, imulq, seta, mov(8*reg+reg + 
const) and other.
4. Using jump table (though not for sched_ext).
5. Lots of other small optimizations.

Discussion
==========
I’m currently improving existing prototype for an RFC submission and 
will try to collect more reliable performance data. However, there are 
several discussion points that require community feedback:
- Overall design
- Security considerations (attack surface and how to reduce it)
- Level of interoperability with existing JIT engines (re-using 
trampolines, cross-JIT bpf_tail_call and recursion checks)
- Userspace <-> Kernel communication (appropriate "transport")
- Granularity of this feature (system-wide, cgroup, process, per-eBPF 
program).

I’d be glad to hear general feedback as well.

[Footnotes]
[1]: I’m referring to the common pattern of using `const volatile` flags 
in eBPF code that are patched before load to toggle certain 
functionality. Or bpf_ksym_exists() and other load-time checks.
[2]: I measured these timings before implementing a major optimization, 
so the results may now be even better.
[3]: For instance, in one of scx_bpfland’s functions, three out of five 
arguments were unnecessary due to a disabled toggle flag in one specific 
configuration.
