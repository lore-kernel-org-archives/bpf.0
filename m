Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064748;
	b=Mxs3lUKFFIhU/ruEjeZ8Qju4D94NEY5MfTP9emmbiJ5OG+ubqcKvqJq359OeJsa86V31
	 bidsiZ6NOkVHbmZrHTpgpn0PUkVJuMrHmRhNvhgX1mYBuFeMsEfPKM6HtmySfD47oKGnJ
	 oy27D8iyZwBeUJNAwsM+vsFNXCRE3QvvzNOwZUQIMbJBI8sBVs8lTNimHjrnubU3zHD76
	 wINdlLGVIzCW2Frexy2+4tP6r+GsbwHvT2HfimeDPbZyZC/LxgVCSaGxdDVtlLSaoc11u
	 kDthx3o9i2mi5EUmu7Tt83YV+koUDc83/ms8WSWlCeLKT1d8OBDBLZyzJB0p86GGqyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064748;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=K94dwbn70eq8hG+dDuDYRflKUmSDK0/4JQhZf6rr1Hg=;
	b=qG2yLe/ALhKwyEZuULHM8DdbPGn5T8lxjzUXcod27B4rnG1NyPPd2ULjk2pb0B3vHO0u
	 v1/IWfeYdhp3lHJmzxhFJbWJJ2v7NfGE75Zy/5K6wlkT2yjJYId3beEWXJuOMNKX7lLiN
	 ggzqKRFyjcJlKkjfHcF8k3E05PI0FiF3jji3LR8xa/b3Halmq7VvFFLVCAJV4dDeoBUHL
	 EnpUoCTOWNrgX4TvVnBHraYuKnNA8qtTGEljY0zGUFnghYsS9PaC1Ts9XuAsUL0z+aDHY
	 6karuUaFkFWL8GfYFIbCuX+rKaB4Z0r5IpJwpYGlVXtZ9y9uYCw2j4DnR07gei9bcTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XcbA2hvX;
	arc=none smtp.remote-ip=91.218.175.86
Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED02A606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED02A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XcbA2hvX
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FvbWH/2AI2iL1qC7Fj3d9ZSMtTLeOIOXTVNruSRaiek=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795064745; v=1; x=1795669545;
 b=XcbA2hvXePbeWV8PzLFqLDPVz6FPynAYu55E8oW/FsGcTU6dCX9ceI6IR04C/GnPFKO9jOZU
 WcYHhMaRKgG+8k+R26NviJjxHM7PgRszreoP8vCmL++3vBng/XBlScN7fjvqUtroHTIWXD6JHts
 upwK2Mq3I81xXPS0fjxj6kPo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a611c37a4c7a49c8;
	Thu, 19 Nov 2026 05:05:34 +0000
X-Mizu-Trace-ID: a611c37a4c7a49c8
X-Migadu-Flow: FLOW_OUT
Message-ID: <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
Date: Wed, 18 Nov 2026 21:05:29 -0800
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
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Check program recursion per task via
 bpf_ctx
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
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 3:29 AM, Mike Bazov via B4 Relay wrote:
> From: Mike Bazov <mikeba@sentinelone.com>
> 
> Trampoline programs (fentry, fexit, fsession, fmod_ret and their
> sleepable variants), raw tracepoint programs (raw_tp, raw_tp.s, tp_btf)
> and tracepoint programs on syscall tracepoints run preemptibly, but
> their recursion check is a per-CPU, per-program counter. When a task is
> preempted inside a program, the counter stays raised, and every other
> task that enters the program on that CPU is dropped and counted as a
> recursion miss, although nothing recursed. A program can't avoid that:
> the counter is checked before its first insn.
> 
> Since commit 7dadeaa6e851 ("sched: Further restrict the preemption
> modes") x86 and arm64 have only lazy and full preemption, so this
> happens in normal operation. A security agent that pairs fentry and
> fexit programs on inet_sendmsg() and inet_recvmsg() loses one half of a
> pair with every drop. With 200,000 HTTP requests and four CPU-bound
> tasks on a 4-CPU VM, 9,254 of 7,966,760 runs of these programs were
> dropped on bpf-next, and none of 7,975,426 with this series.
> 
> Check recursion per task instead. The runners already link a
> stack-allocated bpf_run_ctx into current->bpf_ctx. Move saved_run_ctx
> into struct bpf_run_ctx, so every frame links to the outer one, and
> record in each frame the program it runs. A program is recursing if a
> frame in the current task's chain already runs it. Interrupts and NMIs
> run on top of the interrupted task's chain, so recursion through them
> is still caught.

There are some questions outstanding from previous revs.
Was a limit on chain length considered?
Also, did you try the array-based approach mentioned and compare perf?
