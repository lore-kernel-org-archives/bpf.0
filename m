Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D93F99FA
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953029; cv=none; b=NPaYGuXoWk5c4dpQJfZG15E23MsEl3isZyHAJBSd9MYN76/UrYhYfHnv8NuvIk5lj11cWDX8ne+3JxPkjb+G/pn6YfJ8Uv1lNjnLWUGaBVW1SJ44Cf9BhkMhkyUOfheZWWv9ISUuLAZICzBfbQ1xhtHlqU/abGfV1WOztJIQhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953029; c=relaxed/simple;
	bh=Fkwix5CkxchFN7hVl/NIleiTn6fmqn8vWagIM1RchNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJrHMtOqHzWIv5f13P8FMy0w87SGn6MmujYpdxcW1D5zvsSBpFVbIMHUNDtLG4q5tTJ5iIAjh0owiG9I9YjQTQ7IMBFmEo6T2ugkHQZTXsyCUAq0tFnnitZD9HmQYbgZJHeUsiOBWWdRh3Dtl2BOM8zxzwfn5i9ZkYcOxPBdlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qllbdl/o; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qllbdl/o"
Message-ID: <2d654809-e57f-4316-9d09-31c6cfd25508@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773953025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pnf2+JLEGKJ/0BzcGKHqOLq9DNHTzApEqtEDU3eWcp4=;
	b=Qllbdl/o9fcGX/3+fSgjzVlra2OrFKp1OJxQgBarnHvT4LDVf2fqY2pZZYfbUnvlxdGjY2
	O5lo4Fri6lz5iSAvpF1W4zS+G7pq4iP3PZcIGjWfCRcZZMf4Fwa4kQgbW7Z+NPvhN/TN7E
	YD4VhqTTdE8X7VOf1nmj4AjO9QB4CzU=
Date: Thu, 19 Mar 2026 13:43:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Update kfuncs using
 btf_struct_meta to new variants
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <20260318234210.1840295-2-ihor.solodrai@linux.dev> <abvscsnSAiLLWBTZ@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <abvscsnSAiLLWBTZ@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/19/26 5:30 AM, Jiri Olsa wrote:
> On Wed, Mar 18, 2026 at 04:42:10PM -0700, Ihor Solodrai wrote:
>> Update selftests to use the new non-_impl kfuncs marked with
>> KF_IMPLICIT_ARGS by removing redundant declarations and macros from
>> bpf_experimental.h (the new kfuncs are present in the vmlinux.h) and
>> updating relevant callsites.
>>
>> Fix spin_lock verifier-log matching for lock_id_kptr_preserve by
>> accepting variable instruction numbers. The calls to kfuncs with
>> implicit arguments do not have register moves (e.g. r5 = 0)
>> corresponding to dummy arguments anymore, so the order of instructions
>> has shifted.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  .../testing/selftests/bpf/bpf_experimental.h  | 156 +-----------------
>>  .../selftests/bpf/prog_tests/spin_lock.c      |   5 +-
>>  .../selftests/bpf/progs/kptr_xchg_inline.c    |   4 +-
>>  3 files changed, 9 insertions(+), 156 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> index 44466acf8083..2234bd6bc9d3 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -8,156 +8,11 @@
>>  
>>  [...]
>> -
>> -/* Description
>> - *	Free an allocated percpu object. All fields of the object that require
>> - *	destruction will be destructed before the storage is freed.
>> - *
>> - *	The 'meta' parameter is rewritten by the verifier, no need for BPF
>> - *	program to set it.
>> - * Returns
>> - *	Void.
>> - */
>> -extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
>> +/* Convenience macro to wrap over bpf_percpu_obj_new */
>> +#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
> 
> nit, seems like a shame to remove all the comments which are still
> valid, maybe we could leave those externs with comments and just
> drop the _impl suffix

I assumed they were copy-pasted from somewhere, but apparently no.

How about we move the useful comments to kernel/helpers.c, where
the kfuncs are defined?

> 
> jirka

