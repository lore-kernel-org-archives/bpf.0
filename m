Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D137C90F;
	Wed,  3 Jun 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477972; cv=none; b=h/SjciUIfJ1O4HCkvGyjjNyvSJMUmKRRQ19CuujDMyWoXlPmTzk8VmP5OmDBeFzGkl++PU2vpOoL6E5wfQtXLWXBg7EgVVfecTi641nT8ZbX0VeAlgC2VjWNWfTKQet/pSQb5HaJetr1KFkpIX7ERJcf141m2mfBXO3wU8Be/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477972; c=relaxed/simple;
	bh=asDLIHKdW5SQkt+AvBPms8hBv1FMDVQtDhA1GC2RjOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtVg5CaXVRox4NzBT5vSeOjTKz9FrxrCTtVqKZmhk5jBSa8+2lCOr5kK2aWbpQxjP6ICr3nXQ9KVPG2+EJybjPfxN2dHo3FnWmiBAJGPNQk+pycrI7+0e7OYPwS9UXJ+Xk8TFg1rMpe/KLehOiPsaOObu08y4yE3MhKG2k+VQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dk6L+CXa; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dk6L+CXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=BRtjKeBZ4+8dkfdyf5TNW8mrUZqF45IyG/HSoWHSM1M=;
	b=dk6L+CXav2r3Vh7oHctwwISdq6vjBKf3KCJqpgNZ86Sfmy4gcJJGYq+Afx+bso
	ETSNvS1nj440RXH7FAxUKPBXWkO5QipT07DtKeIH4S2Sq+TIMW91oyrQRC6pexlY
	tK4ZZsAB+y1BjwDpEQQEgmuy+gCigpmzuR4tWtcUdAIvY=
Received: from [10.41.105.18] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn_6e97x9q7LHVAg--.13910S2;
	Wed, 03 Jun 2026 17:11:26 +0800 (CST)
Message-ID: <874ee728-51f2-46ac-93a5-7740abcb0a77@126.com>
Date: Wed, 3 Jun 2026 17:11:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btf: reject to register duplicated kfunc
To: Yonghong Song <yonghong.song@linux.dev>, martin.lau@linux.dev,
 ast@kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, kaitao.cheng@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602110710.19642-1-chensong_2000@126.com>
 <d4054d34-430c-4360-8392-a21f8ebacff4@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <d4054d34-430c-4360-8392-a21f8ebacff4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_6e97x9q7LHVAg--.13910S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1fAF43Kw13ur1kGFWruFg_yoWrCw4UpF
	W5JFZ8uF4xtw17X3W2qF98ury3Gw18Ga1jyF98KFy3Jr1qgrZ7tr1jkF4Y93sayryUCa10
	yF4UWrZxu3yjkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaa0PUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpR+NDWof778pLwAA3Z

Hi,

在 2026/6/3 01:13, Yonghong Song 写道:
> 
> 
> On 6/2/26 4:07 AM, Song Chen wrote:
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
>> Reviewed-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Song Chen <chensong_2000@126.com>
> 
> The subject can be [PATCH bpf v4] bpf: Reject to register duplicated kfunc
> 
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
>> v3 --- v4
>> Fixed some coding style problems suggested from Kaitao Cheng.
>> ---
>>   kernel/bpf/btf.c | 38 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 4872d2a6c42d..fe1612677a4a 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8618,6 +8618,41 @@ static int btf_check_iter_kfuncs(struct btf 
>> *btf, const char *func_name,
>>       return 0;
>>   }
>> +static int btf_check_kfunc_name(struct btf *btf, const char 
>> *func_name, u32 kind)
>> +{
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +    struct btf_module *btf_mod, *tmp;
>> +#endif
>> +    s32 id;
> 
>      s32 err = 0, id;
> 
>> +
>> +    if (!btf_is_module(btf))
>> +        return 0;
>> +
>> +    id = btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);
>> +    if (id >= 0) {
>> +        pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
>> +                func_name, id);
>> +        return -EINVAL;
>> +    }
>> +
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +    mutex_lock(&btf_module_mutex);
>> +    list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>> +        if (btf_mod->btf == btf)
>> +            continue;
>> +        id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
>> +        if (id >= 0) {
>> +            pr_err("kfunc %s (id: %d) is already present in module 
>> %s.\n",
>> +                    func_name, id, btf_mod->module->name);
>> +            mutex_unlock(&btf_module_mutex);
>> +            return -EINVAL;
> 
> Let us avoid the above mutex_unlock and 'return -EINVAL', just do
>      err = -EINVAL;
>      break;
> 
>> +        }
>> +    }
>> +    mutex_unlock(&btf_module_mutex);
>> +#endif
>> +    return 0;
> 
>      return err;
> 

I will go with guard(mutex), please review my next submit and let me 
know if you're ok with it or not. Thanks.

>> +}
>> +
>>   static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 
>> func_flags)
>>   {
>>       const struct btf_type *func;
>> @@ -8631,7 +8666,8 @@ static int btf_check_kfunc_protos(struct btf 
>> *btf, u32 func_id, u32 func_flags)
>>       /* sanity check kfunc name */
>>       func_name = btf_name_by_offset(btf, func->name_off);
>> -    if (!func_name || !func_name[0])
>> +    if (!func_name || !func_name[0] ||
>> +        btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
> 
> format issue:
>      if (!func_name || !func_name[0] ||
>          btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
>      ...
> 

I will fix it with indentation plus space.

>>           return -EINVAL;
>>       func = btf_type_by_id(btf, func->type);
> 


many thanks.

Song

