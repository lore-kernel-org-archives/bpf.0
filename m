Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2D390235;
	Tue,  2 Jun 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398153; cv=none; b=bnBLuEmLrQ/32yXtJbhvHXL9Gpp/EWf8ZJXYbjiuZ4I+aGr4WZopWe+N1QcYJGBMf49rYlR09VUbmyWTsOu+k+x8QfPPAul0kY7vT34H15kmok+h2m6tUE29JJo+uoZvNqKGOenAdszLVFHWoui84U9EFsojJ6kWYm+Lf60MSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398153; c=relaxed/simple;
	bh=582LUVUt8lC3gbG1ilAnsN6j3vIIj4FGYt2FmOURhZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcxY28yN8MnHGo6xQsUwLiWTgCzpseMF9p5OJ57tL4LIRVmtzCprZRURRjovbETVhFOHiHy1axPr3913H0DM078a5hMobb6DJE2zz0yCq+mbR3erRsf8bj7aqe6BJWLm0C5wHNZO+8BlICX1+l3XNNMi9SEG5WJljUn4akVX4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OVOIn1X+; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OVOIn1X+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=2KK59NOvHyhsuQjLMF981wH8r47WGI3iCe+P21MEBe0=;
	b=OVOIn1X+7+/xIoZCwbu9I3ICKA20WBQm+v9r5E1KPlVFFierl0jP5PmUyVc0Ic
	QpC2eGccx3odpnawkvUnDuyf6XSJi0StqIdX2hCxfcBeCkllHXW6EWFGbLXYvSd8
	BmKPR/sLaw18ZYNTH8W+6lXCFzH64tCRmwmMFnIVNo864=
Received: from [10.41.105.18] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3F5T5tx5qRRMLAw--.14105S2;
	Tue, 02 Jun 2026 19:01:14 +0800 (CST)
Message-ID: <8049681c-d1d5-4fc0-8d3f-e7a98154ef3f@126.com>
Date: Tue, 2 Jun 2026 19:01:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Yonghong Song <yonghong.song@linux.dev>,
 Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260524082944.10625-1-chensong_2000@126.com>
 <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
 <83a466d3-d715-4208-b7c8-1cdcd6d99575@126.com>
 <3e1cf732-bb65-415e-afc0-3b54a2fb1aee@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <3e1cf732-bb65-415e-afc0-3b54a2fb1aee@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F5T5tx5qRRMLAw--.14105S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrW3trW5Xr1fJFWUGFWfXwb_yoWrWFykpF
	WUJFs8CF48tr12yF12qa45ur9xtw18Kr47ZFnxtay3Xr1qqFnrtr1jyr15u3sayry8Ga40
	qF4UWFW3u345ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVc_-UUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxxPzmoet-xUOwAA3+

Hi,

在 2026/6/2 00:09, Yonghong Song 写道:
> 
> 
> On 6/1/26 2:39 AM, Song Chen wrote:
>> Hi Kaitao,
>>
>> 在 2026/5/25 17:18, Kaitao Cheng 写道:
>>> 在 2026/5/24 16:29, Song Chen 写道:
>>>> I had an ebpf program which calls a kfunc defined and
>>>> implemented in one of my kernel modules, it was working
>>>> fine in 6.16, but was rejected to run by libbpf in 6.19,
>>>> the error message was:
>>>>
>>>> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
>>>> incompatible with vmlinux [94389]
>>>>
>>>> The reason is there is a new added kfunc in kernel 6.19
>>>> which happens to be the same name with my kfunc. However the
>>>> error message is not obvious enough to address problem
>>>> immediately.
>>>>
>>>> Therefore, this patches searches duplicated kfunc in
>>>> both btf_vmlinux and btf_modules list before a kernel module
>>>> attempts to register kfuncs through register_btf_kfunc_id_set,
>>>> it prints clear error message and returns error code if same name
>>>> kfunc has already implemented and registered, then developer
>>>> knows at the first place.
>>>>
>>>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>>> Suggested-by: Kaitao Cheng <kaitao.cheng@linux.dev>
>>>> Signed-off-by: Song Chen <chensong_2000@126.com>
>>>>
>>>> ---
>>>> changelog:
>>>> v1 --- v2:
>>>> libbpf has already specified which module this kfunc belongs to as
>>>> ebpf code onwer's expectation, then verifier uses
>>>> find_kallsyms_symbol_value to search kfunc's addr.
>>>>
>>>> v2 --- v3:
>>>> After v2, I tried a new idea of introducing a namespace in libbpf
>>>> to specify kfunc owner in an ebpf program suggested by Kaitao Cheng,
>>>> please see [1]. Alex suggested to go back to report an error during
>>>> kmod load on conflicting kfunc name for now. What's more, v2 only
>>>> searched bpf_vmlinux, v3 also traverses btf_modules list.
>>>>
>>>> [1]:https://lore.kernel.org/all/ 
>>>> CAADnVQ+jYGMjAC9aNygmhyppUO9foWN4z9cjSpwCEXAFHpRVJQ@mail.gmail.com/
>>>> ---
>>>>   kernel/bpf/btf.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>>>
>>>
>>> btf: reject to register duplicated kfunc
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> index 4872d2a6c42d..a14ad3720872 100644
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>> @@ -8618,6 +8618,47 @@ static int btf_check_iter_kfuncs(struct btf 
>>>> *btf, const char *func_name,
>>>>       return 0;
>>>>   }
>>>>   +static int btf_check_kfunc_name(struct btf *btf, const char 
>>>> *func_name, u32 kind)
>>>> +{
>>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>>> +    struct btf_module *btf_mod, *tmp;
>>>> +#endif
>>>> +    s32 id;
>>>> +    int ret = 0;
>>>
>>> This ret variable may be unnecessary.
>>>
>>>> +
>>>> +    if (!btf_is_module(btf))
>>>> +        goto out;
>>>> +
>>>> +    id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
>>>> +                    func_name, kind);
>>>
>>> It seems unnecessary to split this call across multiple lines. Also,
>>> some of the continuation-line indentation elsewhere does not appear
>>> to follow the kernel coding style.
>>>
>>>> +    if (id >= 0) {
>>>> +        pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
>>>> +                    func_name, id);
>>>> +        ret = -EINVAL;
>>>> +        goto out;
>>>
>>> return -EINVAL;
>>>
>>>> +    }
>>>> +
>>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>>> +    mutex_lock(&btf_module_mutex);
>>>> +    list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>>>> +        if (btf_mod->btf == btf)
>>>> +            continue;
>>>> +        id = btf_find_by_name_kind(btf_mod->btf,
>>>> +                    func_name, kind);
>>>> +        if (id >= 0) {
>>>> +            pr_err("kfunc %s (id: %d) is already present in module 
>>>> %s.\n",
>>>> +                    func_name, id, btf_mod->module->name);
>>>
>>> follow the kernel coding style
>>
>> I understood the rest part of your comments, but this one "follow the 
>> kernel coding style", is it an indentation problem? checkpatch didn't 
>> say anything about it.
> 
> See Documentation/process/coding-style.rst.
> 
> [...]
> 

helpful, thanks.

/Song

