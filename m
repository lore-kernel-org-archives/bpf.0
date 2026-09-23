Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB636CDE9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129390; cv=none; b=Fn1cU6/iE7R8okP7FWzOPk1DTdE9S4IrW488P+7gZ5d0z4Q2CJHOc2NNWIjJ2B6DbcIdhRV2nxw6Y29Kbx+44LqnxygG7D0uRczR0HCUaiPSINiAw9CoajUkTsbt8Xo1Z3PL8XyQQXxiTBFabXPUQoL4/i5s9+DZUye6+2k9R74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129390; c=relaxed/simple;
	bh=agWi/DiX81XblSHCrvLqgEIx5iQmRMOA4U7xtF8Fw+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHQbSPsG6WY8TCoihKSjyqD4A7KrCoPbpzHO4cJUdUPUxDJiqXP7LXhSEvEYhlFMegDtYJ1TeZHDd4LFZ7q9Bwuu5N4bkIOLFC8MLY0S2WfVXJELrEBceEeClnssmruISpzJlZBqSNZIiDk20ro0T+SydYRRK/bMNNN2MfBtiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+izgrkt; arc=none smtp.client-ip=95.215.58.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+izgrkt"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=agWi/DiX81XblSHCrvLqgEIx5iQmRMOA4U7xtF8Fw+0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790129385; v=1; x=1790734185;
 b=m+izgrktAYyVKXKnlwHWEUGXOGdn0kouo7oTOP0maUfpRDZeikvpaknqQBXzJ0PDdoZBDWX9
 joqLy+8myNsrBfaHT13xxba9kuCTTPywaKBTEvoag0APO5MDxOUIR731wcF38Jvwdq+feE6fvxa
 0SXA5Xef6CHUlrb1czjOmG0I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 913d3832098dc367;
	Wed, 23 Sep 2026 02:09:45 +0000
X-Mizu-Trace-ID: 913d3832098dc367
X-Migadu-Flow: FLOW_OUT
Message-ID: <0a30f489-6771-4798-ab59-b658ef4c24f0@linux.dev>
Date: Wed, 23 Sep 2026 10:09:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU
 creates a per-cpu hash element
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com>
 <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/9/26 08:08, Donggeun Yoo wrote:
> pcpu_init_value() initializes the per-cpu area of a newly created
> [lru_]percpu_hash element.  The area is recycled, so when the value
> comes from a BPF program (onallcpus == false) it writes the running
> CPU's slot and zeroes the rest.
> 
> bpf_percpu_hash_update() passes onallcpus == true, which delegates to
> pcpu_copy_value().  Since BPF_F_CPU was added that writes only the CPU
> named in map_flags when the flag is set, so on the create path the other
> slots keep the recycled element's values:
> 
>   update(k1, 0xdeadc0de, BPF_F_ALL_CPUS)  every CPU holds 0xdeadc0de
>   delete(k1)                              element back on the freelist
>   update(k2, 0xc0ffee, BPF_F_CPU | 0)     creates, writes CPU 0 only
>   lookup(k2)                              CPU 0 0xc0ffee, rest 0xdeadc0de
> 
> Zero-fill the other CPUs on that arm too.
> 
> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> The merged arm no longer calls bpf_obj_cancel_fields() on the named
> CPU.  That call is inert here: it acts only on BPF_TIMER,
> BPF_WORKQUEUE and BPF_TASK_WORK, which map_check_btf() rejects for
> [lru_]percpu_hash.
> 
> v2: name the BPF_F_CPU entry condition in the block comment.
> 
>  kernel/bpf/hashtab.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4f495dcbf670c..f7a9c432d9b76 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1054,14 +1054,16 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
>  	/* When not setting the initial value on all cpus, zero-fill element
>  	 * values for other cpus. Otherwise, bpf program has no way to ensure
>  	 * known initial values for cpus other than current one
> -	 * (onallcpus=false always when coming from bpf prog).
> +	 * (onallcpus=false always when coming from bpf prog,
> +	 *  map_flags & BPF_F_CPU when coming from syscall but setting
> +	 *  only one cpu).
>  	 */
> -	if (!onallcpus) {
> -		int current_cpu = raw_smp_processor_id();
> +	if (!onallcpus || (map_flags & BPF_F_CPU)) {
> +		int init_cpu = onallcpus ? map_flags >> 32 : raw_smp_processor_id();

'onallcpus ? map_flags >> 32' does not look reasonable.

Based on the 'if' above, either of these looks straightforward to me.

int init_cpu = !onallcpus ? raw_smp_processor_id() : map_flags >> 32;

or

int init_cpu = (map_flags & BPF_F_CPU) ? map_flags >> 32 :
raw_smp_processor_id();

Thanks,
Leon

>  		int cpu;
>  
>  		for_each_possible_cpu(cpu) {
> -			if (cpu == current_cpu)
> +			if (cpu == init_cpu)
>  				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
>  			else /* Since elem is preallocated, we cannot touch special fields */
>  				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));

