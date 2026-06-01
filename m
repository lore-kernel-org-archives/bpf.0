Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B92E62B7
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330206; cv=none; b=TvkqoCgJtJTkdm6JpS6MT0b08HpetmN6z2lm4s5UXcNyl4tp1cT6IGHLKnE2fJyjFCb+P9O5ZxSRVJyouFhbk1/vuHPyeu7PPjcZ5PIFCScKSWPqEnTv/8RiU3GlrS5I2iUj++V+CVYFSfquEiRNd508VUdPqrm/xiVaTgzcGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330206; c=relaxed/simple;
	bh=WZj1yk6CtqUlavxiFy2sXCCovmFIG7BtSz3peZL7Bn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVg7LbUC9V4434E+1XAPt4gXik0Ry873HHWR0CKSdCpI+rbWOnZ4TEF69vT8N8BSDsukakmK5D46RSUnphz/fN8Qbq8cDAxvjThLkAJxdOU0yFHkwOmybHKOIp+hLrqFPx9zo348bZKQDY3xpXe/IaPwo8kT8XVjaldUkwz4IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZqrfenLm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZqrfenLm"
Message-ID: <3e1cf732-bb65-415e-afc0-3b54a2fb1aee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780330201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYWYkMnfhkoHtz+I3UjSnQIiQRAbnq8mEu/3Atwoyc4=;
	b=ZqrfenLm4REeOjvomJJf9yM1vQmJti+wYzoCArFsk6fGpgfy5yIrI3CO4VmvHrsMH7nT6e
	v2UipYljqaqgPhpubkLQzTZdbfVdEcuCyVP5xxWboaAbXYxI98mfNJTqVOfJt2nreEZUy9
	7GaQiO6B7dof08onIXNqfNRHFQGUMxA=
Date: Mon, 1 Jun 2026 09:09:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
Content-Language: en-GB
To: Song Chen <chensong_2000@126.com>, Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260524082944.10625-1-chensong_2000@126.com>
 <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
 <83a466d3-d715-4208-b7c8-1cdcd6d99575@126.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <83a466d3-d715-4208-b7c8-1cdcd6d99575@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/1/26 2:39 AM, Song Chen wrote:
> Hi Kaitao,
>
> 在 2026/5/25 17:18, Kaitao Cheng 写道:
>> 在 2026/5/24 16:29, Song Chen 写道:
>>> I had an ebpf program which calls a kfunc defined and
>>> implemented in one of my kernel modules, it was working
>>> fine in 6.16, but was rejected to run by libbpf in 6.19,
>>> the error message was:
>>>
>>> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
>>> incompatible with vmlinux [94389]
>>>
>>> The reason is there is a new added kfunc in kernel 6.19
>>> which happens to be the same name with my kfunc. However the
>>> error message is not obvious enough to address problem
>>> immediately.
>>>
>>> Therefore, this patches searches duplicated kfunc in
>>> both btf_vmlinux and btf_modules list before a kernel module
>>> attempts to register kfuncs through register_btf_kfunc_id_set,
>>> it prints clear error message and returns error code if same name
>>> kfunc has already implemented and registered, then developer
>>> knows at the first place.
>>>
>>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Suggested-by: Kaitao Cheng <kaitao.cheng@linux.dev>
>>> Signed-off-by: Song Chen <chensong_2000@126.com>
>>>
>>> ---
>>> changelog:
>>> v1 --- v2:
>>> libbpf has already specified which module this kfunc belongs to as
>>> ebpf code onwer's expectation, then verifier uses
>>> find_kallsyms_symbol_value to search kfunc's addr.
>>>
>>> v2 --- v3:
>>> After v2, I tried a new idea of introducing a namespace in libbpf
>>> to specify kfunc owner in an ebpf program suggested by Kaitao Cheng,
>>> please see [1]. Alex suggested to go back to report an error during
>>> kmod load on conflicting kfunc name for now. What's more, v2 only
>>> searched bpf_vmlinux, v3 also traverses btf_modules list.
>>>
>>> [1]:https://lore.kernel.org/all/CAADnVQ+jYGMjAC9aNygmhyppUO9foWN4z9cjSpwCEXAFHpRVJQ@mail.gmail.com/ 
>>>
>>> ---
>>>   kernel/bpf/btf.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>>
>>
>> btf: reject to register duplicated kfunc
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 4872d2a6c42d..a14ad3720872 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -8618,6 +8618,47 @@ static int btf_check_iter_kfuncs(struct btf 
>>> *btf, const char *func_name,
>>>       return 0;
>>>   }
>>>   +static int btf_check_kfunc_name(struct btf *btf, const char 
>>> *func_name, u32 kind)
>>> +{
>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>> +    struct btf_module *btf_mod, *tmp;
>>> +#endif
>>> +    s32 id;
>>> +    int ret = 0;
>>
>> This ret variable may be unnecessary.
>>
>>> +
>>> +    if (!btf_is_module(btf))
>>> +        goto out;
>>> +
>>> +    id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
>>> +                    func_name, kind);
>>
>> It seems unnecessary to split this call across multiple lines. Also,
>> some of the continuation-line indentation elsewhere does not appear
>> to follow the kernel coding style.
>>
>>> +    if (id >= 0) {
>>> +        pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
>>> +                    func_name, id);
>>> +        ret = -EINVAL;
>>> +        goto out;
>>
>> return -EINVAL;
>>
>>> +    }
>>> +
>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>> +    mutex_lock(&btf_module_mutex);
>>> +    list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>>> +        if (btf_mod->btf == btf)
>>> +            continue;
>>> +        id = btf_find_by_name_kind(btf_mod->btf,
>>> +                    func_name, kind);
>>> +        if (id >= 0) {
>>> +            pr_err("kfunc %s (id: %d) is already present in module 
>>> %s.\n",
>>> +                    func_name, id, btf_mod->module->name);
>>
>> follow the kernel coding style
>
> I understood the rest part of your comments, but this one "follow the 
> kernel coding style", is it an indentation problem? checkpatch didn't 
> say anything about it.

See Documentation/process/coding-style.rst.

[...]

