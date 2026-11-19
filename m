Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064694;
	b=wAmQLg53CRWyvSmUCGdmT8IFhs8rFcdun460KNy7ZXtw8QNK2IKSmxoswRkWV70Y+ijl
	 yoLv1zaLHV1WMchU8cNlJkM//r9HgWkEJ6w2V8nQQSfcP+FrSF/+V1cMgFp7cmohFN08k
	 4MewMFSg164LKa03COOk2CC3+KWDaQ9vYMqTjSrgNpsPtRYfvls5mqA1tihSRGObxBVzI
	 sBxZ1Umb3mgnHt5vHYuTPSTR6x6Own2W+P1jKM9l0fu864vsfV2joGq5Ygd2jdxUknKEU
	 myUq2wyJ5brXx2IlFd7pFjJikRtg+uzXvRdjp56fmlAIx6EKi6FF+Uj7BfS1JmG00lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064694;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3xoPu8PO0Lsc4kJLb/P6uZm7HiKPKgksw7ld3uk0MOc=;
	b=RY0UMrhyen5BM1FVFQpTjW61d6ZIZxyLVv+UvVn+ivVVe81g5p+LN9FXt/ki1j7lydFr
	 z5LR1WSYCbsSfIVcirNPY0hr6xMAFfp2HK+nE/iD1aoIIO/Hw3ZMPAwiZrLT2OyPbgOat
	 2FDoJTTACCBSLKR6J1Yq6jTGSAxDi/S9BkX5fYlXBaURjZCssNgbrzoIJ5NEWUX36nPVt
	 0uW1uEjqkr4VP03H2FV74xql0CaftsaYDnhWTyZOqPU1pWzb9xAOj3DZK3eYOUKhHMCt3
	 l/SYaTZvnAB89d9ugeaCe7f0R4f7a7lyEUMXlP6C+JED1oqZeR8UQWqy8LeNMx1oORg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="tzoTw/aK";
	arc=none smtp.remote-ip=91.218.175.71
Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498660A5BD5
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A498660A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tzoTw/aK
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9t3e9NyPl/CC5WS4/w4TM+jm9VNbG92GArY8x7eWZPE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795064691; v=1; x=1795669491;
 b=tzoTw/aK+iZb1mf4N/ohqKUyGJGzytZT7Cj7Dtr1OEXdslTOZwzkkax70keVpnxz0Co6zMB0
 l88tDS8APSiBXqkxUxUjHyS50z8G3T4NRJmeozSWbIBW96Lmb9HdhcJ9YdeG6+iY81YTjGcLYVp
 7KcXbhMpAgxMvR3HlTKUTFBU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 019820b0f9d828ee;
	Thu, 19 Nov 2026 05:04:51 +0000
X-Mizu-Trace-ID: 019820b0f9d828ee
X-Migadu-Flow: FLOW_OUT
Message-ID: <a51c74ab-35c4-4b7f-b269-cd650700a632@linux.dev>
Date: Wed, 18 Nov 2026 21:04:46 -0800
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
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Mark programs whose runs must not
 overlap on a CPU
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
 <20261117-bpf-preempt-v2-r2-v3-2-586376ec3672@sentinelone.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-2-586376ec3672@sentinelone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 3:29 AM, Mike Bazov via B4 Relay wrote:
> From: Mike Bazov <mikeba@sentinelone.com>
> 
> The per-CPU recursion counter of tracing and raw tracepoint programs
> also keeps a second task out of a program while another task is
> preempted inside it on the same CPU. Programs rely on that:
> 
> - A per-CPU map value that a program looked up stays its own until the
>   run ends, which is how programs use these maps as scratch space.
> - The budget of timed may_goto is per-CPU memory that the first insns
>   of a run reset, see commit ec274bb4665c ("bpf: One may_goto time
>   slice per prog invocation"). A second run on the CPU gives the first
>   one more time.
> - A private stack is per CPU. After the previous patch, struct_ops
>   programs that request one are the only programs with this check that
>   still have it.
> 
> The next patch checks recursion per task, which lets a second task in.
> For these programs that would turn a counted, dropped run into silently
> corrupted data, or into a may_goto loop that another task keeps
> renewing. Mark them at load time, so that they keep the per-CPU counter.
> 
> Set prog->recur_per_cpu when the verifier sees:
> 
> - a helper called with a per-CPU map, also through an inner map,
> - the address of a per-CPU array value loaded directly,
> - bpf_this_cpu_ptr() or bpf_per_cpu_ptr(),
> - a tail call: the target runs without its own recursion check,
> - timed may_goto,
> - a private stack, in a struct_ops program that requests one.

This feels brittle. As code evolves, it may be hard to keep track of these.
Would explicitly opting in avoid unexpected regressions?

If the marking approach is accepted, would it make sense to make it visible
via bpftool?

> 
> Only verified code counts: a per-CPU map referenced in a branch that a
> constant in .rodata disables doesn't mark the program.
> 
> No functional change: nothing reads the flag yet.
> 
> Trade-offs, once the next patch reads it:
> 
> - A program that keeps per-CPU slots of its own, e.g. in a regular
>   array indexed by bpf_get_smp_processor_id(), is not marked.
> - Marked programs keep losing runs to preemption.
> 
> Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
> ---
>  include/linux/bpf.h   |  3 ++-
>  kernel/bpf/fixups.c   |  1 +
>  kernel/bpf/verifier.c | 11 +++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a5ad08b7937c..7873f0ef2817 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2063,7 +2063,8 @@ struct bpf_prog {
>  				call_get_func_ip:1, /* Do we call get_func_ip() */
>  				call_session_cookie:1, /* Do we call bpf_session_cookie() */
>  				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> -				sleepable:1;	/* BPF program is sleepable */
> +				sleepable:1,	/* BPF program is sleepable */
> +				recur_per_cpu:1; /* Runs must not overlap on a CPU */
>  	enum bpf_prog_type	type;		/* Type of BPF program */
>  	enum bpf_attach_type	expected_attach_type; /* For some prog types */
>  	u32			len;		/* Number of filter blocks */
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 4d9b67981520..82ad0d3bf465 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2591,6 +2591,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  				if (!tmg)
>  					return -ENOMEM;
>  				prog->aux->timed_may_goto = tmg;
> +				prog->recur_per_cpu = true;
>  			}
>  			prog->jit_required = 1;
>  			cnt = may_goto_expand_timed(insn_buf, &jmp, tmg, reg, save_off);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2ca1469d8dee..3d54520df3e3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6050,6 +6050,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>  		if (round_up_stack_depth(env, si[s].stack_depth) >= BPF_PRIV_STACK_MIN_SIZE) {
>  			si[s].priv_stack_mode = PRIV_STACK_ADAPTIVE;
>  			env->prog->aux->jits_use_priv_stack = true;
> +			env->prog->recur_per_cpu = true;
>  		}
>  	}
>  
> @@ -12916,6 +12917,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	if (err)
>  		return err;
>  
> +	/* A per-CPU value stays the run's own only while no other run starts on the CPU */
> +	if (meta.map.ptr && bpf_map_is_percpu_map(meta.map.ptr->map_type))
> +		env->prog->recur_per_cpu = true;
> +
>  	err = record_func_map(env, &meta, func_id, insn_idx);
>  	if (err)
>  		return err;
> @@ -12942,6 +12947,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  
>  	switch (func_id) {
>  	case BPF_FUNC_tail_call:
> +		/* The target runs without a recursion check of its own */
> +		env->prog->recur_per_cpu = true;
>  		err = check_resource_leak(env, false, true, "tail_call");
>  		if (err)
>  			return err;
> @@ -13048,6 +13055,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		struct bpf_reg_state *reg = &regs[BPF_REG_1];
>  		const struct btf_type *type;
>  
> +		env->prog->recur_per_cpu = true;
> +
>  		if (reg->type & MEM_RCU) {
>  			type = btf_type_by_id(reg->btf, reg->btf_id);
>  			if (!type || !btf_type_is_struct(type)) {
> @@ -19690,6 +19699,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		__mark_reg_known(dst_reg, aux->map_off);
>  		dst_reg->type = PTR_TO_MAP_VALUE;
>  		dst_reg->map_ptr = map;
> +		if (bpf_map_is_percpu_map(map->map_type))
> +			env->prog->recur_per_cpu = true;
>  		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
>  			     map->max_entries != 1);
>  		/* We want reg->id to be same (0) as map_value is not distinct */
> 

