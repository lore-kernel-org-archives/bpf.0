Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D13783A8
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782881; cv=none; b=OuZ7Vj1PcrihKZ+bCjz5njy441ThR5xj9YzhzBg6JrTO8lnybLxqPv69mnZgT/OHzKWQd1Tl8TbloWous4xsgfE1lA2npWUqv1V0jmEpTukxr0aIeMX2O2FsVy+XzHai52MzkCQyww6qzzhOev6GNmUIhnQcb+UcdkSAkcnnaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782881; c=relaxed/simple;
	bh=RVkqfCueqP9DMKl2AQamIBnCkAQq9EjtqesSmDyAAMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6kT2+1Uptr1fLJ3/38vqfDedcg/zZiN931Rg8DZTWAjhoLCKNZ2V0vcpl61Tc+mNbTVipWMZMW8tXd9Kr3bhRN7DnVeLEGQJqXZEg5Vf8Gbtp8V9lhZ8BYpfZgZZJSlKpxRuqgm8ptcXEo8aYxJFAckcMhvJdvv/BJbjOGtgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hXuZFGeq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXuZFGeq"
Message-ID: <b5a0099c-6f28-4a54-ba0a-5d3f878cc495@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772782870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/1HJsN+fS18qh6YSlbF0wFrWlTQtOCsTm9BGCFOt/M=;
	b=hXuZFGeqZZA3BKeOl3zoNrAKLoPFyaKODHIyfLiWdFUMt8VlMNgTe2zJftxHcjBTs+yuGC
	ISfGAV/hlyEz0+Qrx1tOgudOJ2y+pV8Dc6iZMBU71/Z8iM3wIdaoPgCAgG0V1rKh9tq1Ed
	3957L9HYn2ABq8/5Rs7/tuS2xRGg3Ys=
Date: Fri, 6 Mar 2026 15:41:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on
 syscalls
Content-Language: en-US
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772721009.git.vmalik@redhat.com>
 <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
 <69b41a54-fb91-4924-999a-06ba94edf72a@linux.dev>
 <862423cd-ee96-478a-a13f-cd4ab5f4ba7a@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <862423cd-ee96-478a-a13f-cd4ab5f4ba7a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 15:09, Viktor Malik wrote:
> On 3/6/26 03:05, Leon Hwang wrote:
>> On 5/3/26 23:25, Viktor Malik wrote:
>>> Sleepable BPF programs can only be attached to selected functions. For
>>> convenience, the error injection list was originally used, which
>>> contains syscalls and several other functions.
>>>
>>> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
>>> that list is empty and sleepable tracing programs are effectively
>>> unavailable. In such a case, at least enable sleepable programs on
>>> syscalls.
>>>
>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>> ---
>>>  kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 48 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index d92cf2821657..cb80a3ddb7a4 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -24930,6 +24930,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>>  	return -EINVAL;
>>>  }
>>>  
>>> +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
>>> +
>>>  /* list of non-sleepable functions that are otherwise on
>>>   * ALLOW_ERROR_INJECTION list
>>>   */
>>> @@ -24951,6 +24953,51 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>>>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>>>  }
>>>  
>>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
>>> +{
>>> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
>>> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>> +	 */
>>> +	if (!check_non_sleepable_error_inject(btf_id) &&
>>> +	    within_error_injection_list(addr))
>>> +		return 0;
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +#else
>>> +
>>> +static bool has_arch_syscall_prefix(const char *func_name)
>>> +{
>>> +#if defined(__x86_64__)
>>> +	return !strncmp(func_name, "__x64_", 6);
>>> +#elif defined(__i386__)
>>> +	return !strncmp(func_name, "__ia32_", 7);
>>> +#elif defined(__s390x__)
>>> +	return !strncmp(func_name, "__s390x_", 8);
>>> +#elif defined(__aarch64__)
>>> +	return !strncmp(func_name, "__arm64_", 8);
>>> +#elif defined(__riscv)
>>> +	return !strncmp(func_name, "__riscv_", 8);
>>> +#elif defined(__powerpc__) || defined(__powerpc64__)
>>> +	return !strncmp(func_name, "sys", 3);
>>> +#else
>>> +	return false;
>>> +#endif
>>> +}
>>
>> At first glance, it is not a good taste to hard code these prefixes here.
>>
>> Furthermore, the arch_syscall_match_sym_name() of ftrace does the same
>> thing. Consider it instead.
> 
> I did consider it but arch_syscall_match_sym_name() matches two strings
> (the arch-specific syscall function and the generic "sys_<name>") while
> we need to just check the prefix (we don't have the other string).
> 
> Another generic option is to implement has_arch_syscall_prefix() in arch
> code, next to arch_syscall_match_sym_name(). But that seems like too big
> of a change in ftrace for a small use-case such as this one.
> 
> That's why I ended up with the current form. In addition, arches
> hard-code the prefixes in their syscall code so we'll have to hard-code
> them anyways, no matter the solution we end up with.
> 
Hmm, I don't have a strong preference.

However, it is worth adding some explanation in the commit log and code
comment.

Thanks,
Leon

[...]

