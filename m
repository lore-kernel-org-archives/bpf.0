Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88B42AA6
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784132; cv=none; b=imI+kfzbV5PgOEZYTbewW9ND4C2dW/LMtA2PyHCs4gfwxVLKd+UD+vp6HrxpiUi5vn7kDAuWJqiYj2pVuTuvBur8dQy1W1nNytttJ7iHvWWNuUmZV/NJMQfHhptuM+AHn9Rt4OARPtZn8bP7KLmE0ndjHd2neBbG0plJUgUVU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784132; c=relaxed/simple;
	bh=qLOURlE2EgSYW+y/aqV1mWxO63kKVIvDu5Gx5r2thMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ber+nUakvc28QDFZFo7XhHX4JznOiVHVf48hxo7TCU9PhuFshVkG97iiVqWU+gwC3eCB/YsuvrFE+9ESgVl1L/UwiLkFsRUogzB4NkhZEFwe6fQT0+ri75MFp5hO2n8iNIl7B/hnyszl3369Ljh3KoZXwn08fD1tScynl9Pe9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YyqQlWTR; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YyqQlWTR"
Message-ID: <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782784127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAO4HQmOrZNYmlyWXHLdasaCnAiXempbTm0/OfxDInk=;
	b=YyqQlWTR8b+m1iZ5phaCOAIz64MOEznCpfVZ0jFi4whKoQgxsgWB6cio5G3UAyHBvsvesx
	I5OGpN/FgF5E6seoKWGat2nCH+XDPb30pfYMPLm/T/EcmhYnsJXc4jJGUKY49+559QfHu5
	gcIfMg5DYMExMh794mPTuuf1i4jizAo=
Date: Tue, 30 Jun 2026 09:48:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Content-Language: en-US
To: Vincent Thiberville <vincent@harfanglab.fr>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Vincent,

Thank you for the report.

On 29/6/26 22:42, Vincent Thiberville wrote:
> Hello BPF maintainers
> 
> I have stumbled upon what I believe is a kernel bug that occurs when a BPF program is executed
> in specific conditions. The in-the-wild situation is a fairly large BPF program that runs as a kretprobe,
> and the crash happened on up-to-date debian13 computers, with the parameter `net.core.bpf_jit_harden=2`.
> 
> I have managed to reduce the conditions to a fairly small reproducer (joined to this mail), that does the
> following:
> 
> 
>   *
> Call bpf_map_lookup_elem (1)
>   *
> Dereference the result if non null (2)
>   *
> Jump with a large enough offset (>=11000) over instructions using constants (3)
> 
> ```
>     0: .......... (62) *(u32 *)(r10 -4) = 0
>     1: .......... (bf) r2 = r10
>     2: ..2....... (07) r2 += -4
>     3: ..2....... (18) r1 = 0xffff8f0708cca200
>     5: .12....... (85) call bpf_map_lookup_elem#1
>     6: 0......... (15) if r0 == 0x0 goto pc+1
>     7: 0......... (79) r0 = *(u64 *)(r0 +0)
>     8: .......... (b7) r0 = 0
>     9: 0......... (15) if r0 == 0x12345678 goto pc+11001
>    10: 0......... (07) r0 += 1
>    11: 0......... (07) r0 += 1
> ...
> 11009: 0......... (07) r0 += 1
> 11010: .......... (b7) r0 = 0
> 11011: 0......... (95) exit
> ```
> 
> This program,  in most situations, will either be JIT compiled and run properly, or will be rejected with the
> error ENOTSUPP. But on machines with:
> 
> 
>   *
> `CONFIG_BPF_JIT_ALWAYS_ON` not set
>   *
> `net.core.bpf_jit_harden=2`


I tried your reproducer with latest bpf-next code, but failed. It did
not crash the kernel.

gcc -o bpf-interpreter-bug ./repro.c

uname -r
7.1.0-ga187b7f97305

zgrep BPF /proc/config.gz
# BPF subsystem
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set

sysctl -a | grep bpf_jit
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 2
net.core.bpf_jit_kallsyms = 1
net.core.bpf_jit_limit = 528482304

./bpf-interpreter-bug
BPF_ADDR_PERCPU JIT bug reproducer

WARNING: this WILL crash the kernel. Run in a disposable VM.

Current config: bpf_jit_enable=1 bpf_jit_harden=2 bpf_jit_limit=528482304
Created per-cpu array map (fd 3)
Loaded target BPF program (fd 4)
Verifier:
processed 11011 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 0

BPF program was unexpectedly JIT-compiled, the bug will not occur. Aborting.


Did I miss something?

> 
> the program will fail to be JIT compiled, will fallback to the interpreter, and when executed, will cause
> a invalid pointer dereference leading to a kernel panic.
> 
> To the best of my understanding, what happens is that:
> 
> 
>   *
> The JIT compiler will optimize the map lookup at (1)
>   *
> The JIT compiler will fail when reaching (3). This is because the JIT hardening enables constant blinding, which triples the size of the jump, overflowing 32767.
>   *
> Since the JIT compiler failed, and CONFIG_BPF_JIT_ALWAYS_ON is not set, the kernel falls back to the interpreter
>   *
> When executed, the interpreter will badly interpret (1), I suppose due to some JIT optimization not being cleaned after the JIT compiler failure.
>   *
> This will leave R0 with an invalid value, which is dereferenced when the interpreter reaches (2)
> 
> But of course this may not be what is happening, I am far from an expert and you will know better than me.
> 
> This is easily reproducible on debian images, which do not set CONFIG_BPF_JIT_ALWAYS_ON. I have reproduced it on 6.12.74+deb13+1-amd64,
> 6.12.94+deb13-amd64 and 7.0.13+deb14-amd64. Setting `net.core.bpf_jit_harden=2` and running the reproducer is enough to trigger the kernel panic.
> 
> I am not entirely sure when this bug was introduced, or if it is fixed on the latest version. From some research, it may be related to this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bdbf7446305
> 
> and there is a commit in review for bpf-next that mentions a fix for the aforementioned commit: `bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn` in https://lore.kernel.org/bpf/20260622143557.22955-1-leon.hwang@linux.dev/T/#t


I've posted another patch series to fix the assorted interpreter
fallback issues:
https://lore.kernel.org/bpf/20260626154330.33619-1-leon.hwang@linux.dev/

Thanks,
Leon

> 
> that would indicate an impact since 6.10.
> 
> Joined to this mail are the reproducer for the issue, and the dmesg of a kernel panic caused by the reproducer on the standard debian image `debian-sid-nocloud-amd64-daily-20260629-2524.qcow2`.
> 
> Thank you for all your work and for your help on this matter.
> 
> Best Regards
> 
> Vincent Thiberville
> 
> 
> 

