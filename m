Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC92332EC8
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658292; cv=none; b=lLC+LTiAeKW9EtpQSJwuwZvLSsEpnucw9ZF+U6Eyn8b/r/Am8LJbGfQ8lBvYjBEUltj4eOKPxmtshWFbMyPqOBx6AhmZDYmxPfAooNmYdtX6iQXSnW6s+TnFhfy1HRASw8u+u8zNrq7FBMD5KugtkKochkkYK1BQj13aVkhijYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658292; c=relaxed/simple;
	bh=X2Er36dW6b9JrfFpTHvUORetkfRXInvG1FR10LsA37o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka4lXNWm6yCkyTiBkFEna7VDC4o5gPeOF6Gn5IkZWDvM6zFcYBKuhZ56TKeHfwkUFWKHI78nQttBoj4hzdsh0K3aak9xHlPQa6hTlyg2wwIILMXVxaIaBiWHwdRDv7bYX0Ee9pHMobx9Pa1G49o498Hr9o/pV/jav67aHLJlgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTMhf3Uo; arc=none smtp.client-ip=91.218.175.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTMhf3Uo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X2Er36dW6b9JrfFpTHvUORetkfRXInvG1FR10LsA37o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790658287; v=1; x=1791263087;
 b=pTMhf3UohD5bwsXuI0wgI1yW9DU/U4kpawbS3utkt3TTAzWQ2QkjMmFlZm8HbmvH6jJAmp+7
 7wDFrc/SbvDz0Cow+ShJJn+kAJPE/8UE7zXMUXGJMFVEZDfy8hjA7vkW6G9OyJJfg05Ty++Fw1V
 bUqQ1e9YCOK9Trqd4mq9P2ZA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 31ac00f7d822a3a5;
	Tue, 29 Sep 2026 05:04:47 +0000
X-Mizu-Trace-ID: 31ac00f7d822a3a5
X-Migadu-Flow: FLOW_OUT
Message-ID: <8fce9ea9-1947-4ec4-9154-cb71fbd75671@linux.dev>
Date: Tue, 29 Sep 2026 13:04:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Zero-fill non-target CPU slots on BPF_F_CPU
 insert of new per-CPU element
To: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>,
 ast@kernel.org, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928214932.544124-1-omermetekaya0@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260928214932.544124-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/9/26 05:47, Ömer Mete Kaya wrote:
> pcpu_copy_value() with BPF_F_CPU copies the value only to the target
> CPU's slot and returns immediately, leaving all other CPUs untouched.
> When inserting a *new* element, the backing per-CPU area may be reused
> from bpf_mem_cache or a prealloc freelist without being zero-initialized,
> so non-target CPUs retain stale contents of a previously-deleted
> element in the same map — a same-map information disclosure.
> 
> pcpu_init_value() is used to initialize newly allocated elements, while
> updates to existing elements call pcpu_copy_value() directly; non-target
> CPU slots intentionally retain their previous values there.
> 
> The onallcpus=false path in pcpu_init_value() already handles new
> element initialization correctly by explicitly zeroing non-current CPUs:
> 
>   if (cpu == current_cpu)
>       copy_map_value(..., value);
>   else
>       zero_map_value(...);
> 
> Fix by adding a zero-fill pass in pcpu_init_value() after
> pcpu_copy_value() returns, covering only the BPF_F_CPU new-element
> path: iterate all CPUs and zero-fill every slot except the target.
> This leaves pcpu_copy_value() unchanged so the update-existing-element
> semantics are not affected.
> 
> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> ---
> Tested with a reproducer:
> - Before the fix: CPU 1 retained 0xDEADBEEFCAFEBABE from the deleted
>   element.
> - After the fix: the non-target CPU read back zero.

Could you add a selftest to prove the issue?

You said a reproducer. But, I don't know what it looks like.

> 
>  kernel/bpf/hashtab.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 8cc07e54daaa..dff4321f2828 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1099,6 +1099,16 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
>  		}
>  	} else {
>  		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
> +		if (map_flags & BPF_F_CPU) {
> +			int target = map_flags >> 32;
> +			int cpu;
> +
> +			for_each_possible_cpu(cpu) {

But wait, the 'map_flags & BPF_F_CPU' has been check in the first 'if
()' condition in pcpu_init_value(). See the previous fix:
https://lore.kernel.org/bpf/20260924102321.2120434-1-donggeunyoo.kernel@gmail.com/

Thanks,
Leon

> +				if (cpu != target)
> +					zero_map_value(&htab->map,
> +						       per_cpu_ptr(pptr, cpu));
> +			}
> +		}
>  	}
>  }
> 
> --
> 2.55.0

