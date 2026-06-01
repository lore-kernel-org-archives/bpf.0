Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465C33438F;
	Mon,  1 Jun 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306855; cv=none; b=ZxhQWIrrTK0Nhvtf2W2VNiwxYtBAZCsmSey8tsdc2DktNe0SPfITyituen/5+Rago5BQR7iEtR6BwogczuYHUr3lA7WK5m8UQODTZKXO7aIyGnJrAyPPGScTz1TApR/7sWJ3WiF6m+DE93Y3GxVSuoDMnkLFeys8Hfsj3uTFnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306855; c=relaxed/simple;
	bh=hwvc3S4XtZjWuhX1fwJl8ieuK59+UONA1GgdO6sY6Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzA525EyDyFLcdgg6njfw7WVXyT8KZo8YM/mPTvb1SQnByEK5vdL3j+1+ppR0hN8zfohGgQAGVigkydlNbF2OvR6KyLfFM44qhtcQXKfCi1yZZQWzSDChP4tpYC/TKDcSf/UXldZYGqEQljNRaH8qgScS1HwJPzxWRvXd1Rthno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oQ/m8Vmg; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oQ/m8Vmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Vrdda/lMnILj02o/mAcpz+xL2UfXRr22H2vfMXxi6Jc=;
	b=oQ/m8Vmg7U+bOqOPwSP7jp78pO4ZXhmy2ExpaRNQJKM0SvWiVi1baTYx2q89f/
	IK8sodaDU3DRUdEKZIwnBhLMMdhUKp9+RLXU20Fq7JpmBjJk8r04rqHqeMhwTI+r
	2+e+4vr4JTVCp6UY6We9o7zSrliZ0ZUfbto4eM5AOR8i4=
Received: from [10.41.105.18] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgD3n61QUx1qMa0PAQ--.26819S2;
	Mon, 01 Jun 2026 17:39:30 +0800 (CST)
Message-ID: <83a466d3-d715-4208-b7c8-1cdcd6d99575@126.com>
Date: Mon, 1 Jun 2026 17:39:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org
References: <20260524082944.10625-1-chensong_2000@126.com>
 <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCkvCgD3n61QUx1qMa0PAQ--.26819S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry3ZrWDur48Zr1DWw1kGrg_yoWrZFWUpF
	W5JFZ8CF4Iqr12va42qFn8ury3Jw18KF4jyF9xtFW3GrWqqrnrtr109F4Y93sayryUCa4I
	vF4UWFZ093yjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaa0PUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRLKSmodU1LmwwAA3k

Hi Kaitao,

在 2026/5/25 17:18, Kaitao Cheng 写道:
> 在 2026/5/24 16:29, Song Chen 写道:
>> I had an ebpf program which calls a kfunc defined and
>> implemented in one of my kernel modules, it was working
>> fine in 6.16, but was rejected to run by libbpf in 6.19,
>> the error message was:
>>
>> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
>> incompatible with vmlinux [94389]
>>
>> The reason is there is a new added kfunc in kernel 6.19
>> which happens to be the same name with my kfunc. However the
>> error message is not obvious enough to address problem
>> immediately.
>>
>> Therefore, this patches searches duplicated kfunc in
>> both btf_vmlinux and btf_modules list before a kernel module
>> attempts to register kfuncs through register_btf_kfunc_id_set,
>> it prints clear error message and returns error code if same name
>> kfunc has already implemented and registered, then developer
>> knows at the first place.
>>
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Suggested-by: Kaitao Cheng <kaitao.cheng@linux.dev>
>> Signed-off-by: Song Chen <chensong_2000@126.com>
>>
>> ---
>> changelog:
>> v1 --- v2:
>> libbpf has already specified which module this kfunc belongs to as
>> ebpf code onwer's expectation, then verifier uses
>> find_kallsyms_symbol_value to search kfunc's addr.
>>
>> v2 --- v3:
>> After v2, I tried a new idea of introducing a namespace in libbpf
>> to specify kfunc owner in an ebpf program suggested by Kaitao Cheng,
>> please see [1]. Alex suggested to go back to report an error during
>> kmod load on conflicting kfunc name for now. What's more, v2 only
>> searched bpf_vmlinux, v3 also traverses btf_modules list.
>>
>> [1]:https://lore.kernel.org/all/CAADnVQ+jYGMjAC9aNygmhyppUO9foWN4z9cjSpwCEXAFHpRVJQ@mail.gmail.com/
>> ---
>>   kernel/bpf/btf.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>
> 
> btf: reject to register duplicated kfunc
>   
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 4872d2a6c42d..a14ad3720872 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8618,6 +8618,47 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>>   	return 0;
>>   }
>>   
>> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
>> +{
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +	struct btf_module *btf_mod, *tmp;
>> +#endif
>> +	s32 id;
>> +	int ret = 0;
> 
> This ret variable may be unnecessary.
> 
>> +
>> +	if (!btf_is_module(btf))
>> +		goto out;
>> +
>> +	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
>> +					func_name, kind);
> 
> It seems unnecessary to split this call across multiple lines. Also,
> some of the continuation-line indentation elsewhere does not appear
> to follow the kernel coding style.
> 
>> +	if (id >= 0) {
>> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
>> +					func_name, id);
>> +		ret = -EINVAL;
>> +		goto out;
> 
> return -EINVAL;
> 
>> +	}
>> +
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +	mutex_lock(&btf_module_mutex);
>> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>> +		if (btf_mod->btf == btf)
>> +			continue;
>> +		id = btf_find_by_name_kind(btf_mod->btf,
>> +					func_name, kind);
>> +		if (id >= 0) {
>> +			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
>> +					func_name, id, btf_mod->module->name);
> 
> follow the kernel coding style

I understood the rest part of your comments, but this one "follow the 
kernel coding style", is it an indentation problem? checkpatch didn't 
say anything about it.
> 
>> +			ret = -EINVAL;
>> +			break;
> 
> mutex_unlock(&btf_module_mutex);
> return -EINVAL;
> 
>> +		}
>> +	}
>> +	mutex_unlock(&btf_module_mutex);
>> +#endif
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>>   static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>>   {
>>   	const struct btf_type *func;
>> @@ -8631,7 +8672,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>>   
>>   	/* sanity check kfunc name */
>>   	func_name = btf_name_by_offset(btf, func->name_off);
>> -	if (!func_name || !func_name[0])
>> +	if (!func_name || !func_name[0]
>> +			|| btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
> 
> follow the kernel coding style

same here.
> 
>>   		return -EINVAL;
>>   
>>   	func = btf_type_by_id(btf, func->type);
> 


/Song

