Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064586;
	b=Fik5g2oDNHPuoYAsyoLVHcf8ef7hAZYDK7XeAMjLZJrAT9VZFmxlR/QDgX7X4LHII5/J
	 0Ke7XudkfJA11LzhdybALHwSk+M9oBEFsM2uS++YpObINGuCs4u88YdQnB9AEpgAm94S4
	 fqvGweKOBCYFjYtiH4UI+K+C8+nMHcST6NrWr5CuZBt91HQxOOefk14L7kgR6HkunqMCF
	 X4YoWMww8RT56RsAzAtWtdawpVryDhB0o8tTKCrnciePnC8aLRJBlDg/ECxzOuo8rjPPN
	 kWXmmS41IKEoVCCruAI2Yy8t9Ii2u0eIGXvozr8NyhLScIen35+qd7PiA0KM2PPBULg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064586;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BT7+1r2EbCQwN3k5fIH4q6qWDyQXDFrNj9A0BO8ZTQs=;
	b=nhygQR0yLdTyq5J/UT2Pd533tcTDONolRnnRK/ZjH5g0dlzsZVeViqK3M8hoWeTU9KMY
	 VWUOPGpYkjUIwT07jDJAP/NcJ3m62fidMVR6yiABsksdF8+MaUrAt4zHE8/i57AtiAwXK
	 7MgzJ//QOYyb4wzGVKzWdpfHS3qCB8tHgKE+QEfLwXXg1xYcrSlOpgStFrEepDuC1oewK
	 BuTB4ksSWBSE7FldxDC9Z3i6kJckZ1ZvQZcEUV5ennjFIEJpoAP0kKass3y1Jbiit8hYZ
	 QTPu/c3MqLyuAaGU2R9fHUs8FomExOKCZXTvFt9N1zaXYjfATh6RSC977wR5hxx2/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eSKM5OO6;
	arc=none smtp.remote-ip=91.218.175.50
Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C67606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C67606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eSKM5OO6
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J5rUZ6TR2jk9ww8i3KV8RMWzlPBWx7p9zVMYCEJba0U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795064577; v=1; x=1795669377;
 b=eSKM5OO6IYnYCnvEcHy2foFsZaFISwpVt7NeNyxFATAkpSv/xHSpXDYLj7xlnKwqYnKyR0RR
 F0ZVPkmd0rwU4mgO6xxOus6MSuhwucLlf5b+ww4ixMcC+T2IaEgofNbaTvHxVyagxsk83cczENS
 i2fsx9Ue9ilAJa/ppvGKjq1M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b2ce2cbeb8803d33;
	Thu, 19 Nov 2026 05:02:57 +0000
X-Mizu-Trace-ID: b2ce2cbeb8803d33
X-Migadu-Flow: FLOW_OUT
Message-ID: <9a47ede3-24fa-4fa3-8d7e-50f221de0929@linux.dev>
Date: Wed, 18 Nov 2026 21:02:52 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: mikeba@sentinelone.com, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Kelly <martin.kelly@crowdstrike.com>,
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 tyler.wilson@crowdstrike.com
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mike,
On 11/17/26 3:29 AM, Mike Bazov via B4 Relay wrote:
> fentry, fexit, raw_tp and syscall tracepoint programs can be preempted
> while they run, but their recursion check is a per-CPU counter:
> 
>   task A enters prog on CPU 0       prog->active = 1
>   task A is preempted inside prog
>   task B enters prog on CPU 0       dropped, counted as recursion miss
> 
> Nothing recursed, but B's event is lost. Since 7.0, x86 and arm64 have
> only lazy and full preemption, so this happens on stock kernels. Our
> fentry/fexit probe on inet_sendmsg() and inet_recvmsg() loses 9,254 of
> 8 million runs under HTTP load on a 4-CPU VM. With the series it loses
> none.
> 
> The series checks recursion per task instead: a program is recursing
> only if the current task is already inside it.
> 
> v2 did that for every program, which breaks a program that uses a
> per-CPU map as scratch space: the second task overwrites its buffer,
> and nothing counts that. So in v3 the verifier marks the programs that
> keep per-CPU state, and those keep the per-CPU counter and behave
> exactly as today:
> 
>   - per-CPU maps, bpf_this_cpu_ptr(), bpf_per_cpu_ptr()
>   - tail calls: the target has no recursion check of its own
>   - timed may_goto: its budget is per CPU
>   - a private stack
> 
> Trade-offs:
> 
> - Marked programs are not fixed. A program with a per-CPU map or a
>   tail call loses runs to preemption as it does today.
> - The verifier can't see everything. A program that keeps per-CPU
>   slots of its own, like array[bpf_get_smp_processor_id()], is not
>   marked. Today the counter keeps its runs apart. With the series two
>   runs can write one slot, and nothing counts that.
> - raw_tp is about 2% slower in bench, see the table below. fentry and
>   fexit are within noise.
> - Tracing, raw_tp and tracepoint programs lose the private stack
>   (patch 1). It is already unsafe for them: two raw_tp programs that
>   tail-call one handler let two tasks share its stack today. A program
>   with two 2000-byte frames no longer loads.
> - A marked freplace program can't be attached to an unmarked raw_tp or
>   tracepoint program: -EINVAL.
> 
> One question: the marking is automatic. A flag that the program's
> author sets would avoid the second trade-off, but existing programs
> would keep losing runs until they are rebuilt. Which do you prefer?
> 
>   1. bpf: Avoid per-CPU private stack in preemptible tracing progs
>   2. bpf: Mark programs whose runs must not overlap on a CPU
>   3. bpf: Check program recursion per task via bpf_ctx
>   4. selftests/bpf: Add preemption recursion test for tracing programs
> 
> Testing, x86-64 VM with 4 vCPUs:
> 
> The selftest pins two tasks to one CPU and makes B enter the program
> while A is preempted inside it, 20 rounds per subtest. With the series
> all 19 subtests pass. On bpf-next 7 fail: B is dropped in every round
> (fentry, fentry_s, raw_tp, raw_tp_s, tp_syscall), A's stack is
> overwritten (two_dispatchers), and the freplace attach is not rejected
> (ext_attach).
> 
> bench -w2 -d12 -a trig-<x>, M/s, median of 10 runs [min-max], lazy
> preemption, in boot order, on bpf-next 0fb18ce8a2e9:
> 
>                trig-fentry          trig-fexit           trig-rawtp
>   bpf-next     41.65 [40.81-42.14]  38.89 [37.58-39.41]  42.62 [41.95-42.80]
>   series       42.40 [41.87-43.04]  39.33 [35.24-41.68]  41.31 [40.48-41.74]
>   bpf-next #2  41.64 [40.87-41.74]  39.29 [35.18-40.62]  42.05 [41.24-42.35]
>   series #2    42.34 [42.12-42.78]  39.87 [39.46-41.38]  41.53 [40.79-41.75]

We tested this series and wanted to share the data. Overall unmarked LSM/fentry
hooks previously affected went to zero. Marked hooks remained about the same or
regressed slightly. Normalized data:

category		before	after
raw_tp (marked)		240	213
fexit (marked)		61	135
fentry (unmarked)	3	0
other (unmarked)	805	0

It's nice to see the series progressing since we are affected by the same issue.
See some comments on the individual patches.
