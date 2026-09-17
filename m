Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEE26F2A0
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642710; cv=none; b=tIhqxf7K9rhbr1hhceZySrgdYUlF8pdZb0jD2hg7IHQ2o5RfAShDt9bTScg8k8IPJiZ/YrCVlVL6uiMRukhtG/5PeojHWr+6BHg4Lej2m8O0Nf43Ydvz75jaVyfgaI83nIGMLkCWKB449JSDyfSMjRclQttuvUtn2xEFgCqGp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642710; c=relaxed/simple;
	bh=2iDIhQcNBAoLdpFjPD/OayQvsulTsQ9Zbhs6SqtUABQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTm8uzaxqMB3RyGlj3geFkNwSaVP520yXRviknQPJExS2rKQKCgJJlLcaSoqTq/FwtFxzGNDMJfWYF6bCBTfWP6euPB7cUrGnGYvLotBSXoRqE+OF5N9cl6kO19TWVuMyfsw8gWyv3/YMIcs4MXem7FDCoJb8AMJjsW6FJcaHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUoX26wM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUoX26wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765B61F00893;
	Thu, 17 Sep 2026 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789642692;
	bh=zq+Tm8SEtDyeDZjvWdW6VYO21uuaQfkidg5o0q4UZEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aUoX26wMJ+rCRE5xbFtTfuIhhMoCmho28Sa99QBRbkTlHQjqT2DOoQuXCNb9t3+wu
	 T2nPOfy8wsV+uoL9mgcjtF/LODkrFfWvb1YkP6eYKA32udcJO//QWGIlmviOnI6OkN
	 AMVq5QmaTo8kiAiEnd0aT97LN2Y4bNilJrGh0e1TLoWDuiK3pO8lpH131fQct2Q/Z3
	 AQkMD7bmx2VKE+ueiX4b0bAywEgb2VjP1s/5Q4c4RgImUR8vchUUO+LUszyWBVrWvN
	 tdFUb1Mvi/aof03FbIcovth8CqTb4HMvCY25iD86lWe3Qe6J3HgAawYGGdUg/ALL1j
	 /Cegroir5Nybg==
Message-ID: <f4b9f9e0-7d32-41cd-bc66-f33863b0534e@kernel.org>
Date: Thu, 17 Sep 2026 11:58:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/2] bpftool: Fix sparse CPU IDs in prog profile
To: Hui Su <sh_def@163.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com
References: <20260907155735.2929529-1-sh_def@163.com>
 <20260907155735.2929529-3-sh_def@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260907155735.2929529-3-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 16:57, Hui Su wrote:
> bpftool prog profile currently treats the number of possible CPUs as
> both the logical CPU ID range and the stride of the perf event array.
> That misses valid logical CPUs when the possible CPU mask is sparse, such
> as 0,2-3, and can use incorrect PERF_EVENT_ARRAY keys.
> 
> Keep the compact possible CPU count for per-CPU result buffers, while
> using the actual logical CPU IDs for perf events and the maximum logical
> CPU ID plus one as the metric stride in the PERF_EVENT_ARRAY. Keep the
> userspace perf file descriptor index separate from the BPF map key. Do
> not advance profile_perf_event_cnt for CPUs that return ENODEV, since it
> tracks opened userspace perf file descriptors rather than event-array
> slots.
> 
> Tested:
> - Built tools/bpf/bpftool successfully on the host.
> - Booted an arm64 QEMU guest with a patched virt device tree reporting
>   possible=0,2-3, present=0,2-3, and online=0,2-3.
> - Ran both pre-fix and fixed bpftool with cycles and instructions against
>   a BTF-enabled fentry target. The pre-fix binary faulted in
>   perf_event_alloc(), while the fixed binary reached perf-event setup and
>   reported failure to create the instructions event on CPU 0. QEMU did
>   not provide a usable hardware PMU runtime result, so no profile counts
>   are claimed.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Hui Su <sh_def@163.com>
> Link: https://lore.kernel.org/bpf/20260813160858.1042834-3-sh_def@163.com/
> ---

[...]

> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> index f48c783cb9f7..9486498f7605 100644
> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> @@ -10,7 +10,7 @@ struct bpf_perf_event_value___local {
>  	__u64 running;
>  } __attribute__((preserve_access_index));
>  
> -/* map of perf event fds, num_cpu * num_metric entries */
> +/* map of perf event fds, cpu_id_span * num_metric entries */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>  	__uint(key_size, sizeof(u32));
> @@ -40,6 +40,7 @@ struct {
>  
>  const volatile __u32 num_cpu = 1;


It looks like num_cpu is now unused in the file, can you remove it, please?

pw-bot: cr

Looks good to me otherwise.


>  const volatile __u32 num_metric = 1;
> +const volatile __u32 cpu_id_span = 1;
>  #define MAX_NUM_METRICS 4
>  
>  SEC("fentry/XXX")
> @@ -67,7 +68,7 @@ int BPF_PROG(fentry_XXX)
>  		if (err)
>  			return 0;
>  		*(ptrs[i]) = reading;
> -		key += num_cpu;
> +		key += cpu_id_span;
>  	}
>  
>  	return 0;
> @@ -107,7 +108,7 @@ int BPF_PROG(fexit_XXX)
>  
>  	/* read all events before updating the maps, to reduce error */
>  	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
> -		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
> +		err = bpf_perf_event_read_value(&events, cpu + i * cpu_id_span,
>  						(void *)(readings + i),
>  						sizeof(*readings));
>  		if (err)

