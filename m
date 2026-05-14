Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5838736B;
	Thu, 14 May 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762704; cv=none; b=i7Kdz7xVmRlAX+OBmGx0NksjSK/1l07S1bxDGtwWuZpNAvCtuD0ZRLGbMmzTFuYRzNQ5H1mD1aULRmm0l3rnS3+NYkB+t8OAdZWn1VqSsQ0x/8QDzhR5+H+gyfrlxLXOiGE5mAL8VBruncL6J96/fZnGuNcUvZGrdmCzWAPkZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762704; c=relaxed/simple;
	bh=UvaC7Jxoxw6o2/IENNWbfeLjQgv54ttBPXCj8P784xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbHkkm0OBZYEeoLTHxPV5wmNvQP+z0NopLPPybby+APOIy0cnQKYNP9vMqvA9gW4y2p3s3hQYS4Zuw27O3XBuYO/9yCsI1Pd3LpNT/ONMIfLJGuDjFLBQ88a58NSRkya0F1qTvUXG9mMQV308uMj1xT8WTUeIX0sef5Neyiv4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jjXn90yu; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jjXn90yu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mY2N9tDDkbbSakumSMfZMNd5aZ9U+KdaUV45cgxHeF0=;
	b=jjXn90yumJsEWw8us0egMnHVZpRiOeTmNM5soTxLMYi/KXNutnA5j52aIaNgIQ
	MJAxf6hn2E452m0LRReKbvJSpRvd4nHlFI5Fc+4xnUSA1QOzDvbfs9I3jZmpaZAw
	X9xZHDiv2M7AR0lMdnvKuBrTYNAYutl57qrz+/zn4ExHc=
Received: from [IPV6:2408:8210:480a:2590:67b8:4623:bebc:2a2] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3N8yDwwVqpVd5BQ--.17765S2;
	Thu, 14 May 2026 20:43:48 +0800 (CST)
Message-ID: <b469b3b7-cfd0-4829-8ea5-40293c7a6d07@126.com>
Date: Thu, 14 May 2026 20:43:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 jolsa@kernel.org, haoluo@google.com, kpsingh@kernel.org, song@kernel.org,
 linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me
References: <20260510030136.27876-1-chensong_2000@126.com>
 <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N8yDwwVqpVd5BQ--.17765S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JryUAr4UXrWUZw18AFy8uFg_yoW7Wr45pF
	WrJrn0kF4xJr9IyF4xXrWUWry3KrWxKr4avFW3tFy3ur1vvFn5AF10k3W5u3s8Aw1vvF4I
	9F4Yqr13C3yDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUfHUUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsgTtbWoFw4T8zgAA3s

Hi,

On 5/12/26 11:18, Kaitao Cheng wrote:
> 
> 
> 在 2026/5/10 11:01, Song Chen 写道:
>> Change the kfunc resolution order in find_ksym_btf_id() to search
>> module BTFs before vmlinux BTF. This allows kernel modules to override
>> vmlinux kfuncs with the same name, enabling a form of live-patching
>> for kfuncs.
>>
>> Previously, vmlinux kfuncs were always preferred, making it impossible
>> for modules to provide enhanced or fixed versions of existing kfuncs.
>> With this change, modules can now override kernel kfuncs, while
>> programs that don't use module BTFs remain unaffected.
>>
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Song Chen <chensong_2000@126.com>
>>
>> ---
>> changelog:
>> v1 -->  v2:
>> 1, introduce namespace to specify which module the kfunc belongs to, like:
>> modulea__foo
>> moduleb__foo
>> foo
>> As a result, kfunc foo can co-exist in modulea, moduleb and vmlinux, ebpf
>> code owner can specify which one he wants to call.
>> ---
>>   tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 45 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0be7017800fe..9c9e5ff4d754 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -8532,35 +8532,65 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>>   	return libbpf_kallsyms_parse(kallsyms_cb, obj);
>>   }
>>   
>> +static void split_module_from_ksym(const char *ksym_name,
>> +			const char **module_name,
>> +			size_t *module_name_len,
>> +			const char **kfunc_name)
>> +{
>> +	const char *sep = strstr(ksym_name, "__");
>> +
>> +	if (!sep) {
>> +		*module_name = NULL;
>> +		*module_name_len = 0;
>> +		*kfunc_name = ksym_name;
>> +	} else {
>> +		*module_name = ksym_name;
>> +		*module_name_len = sep - ksym_name;
>> +		*kfunc_name = sep + strlen("__");
>> +	}
>> +}
> 
> I don't think overloading "__" in ksym_name is safe.
> 
> 1. "__" itself is very common in kernel symbol names. Forcibly
>     treating the first "__" as the separator between the module name
>     and the kfunc name is seriously ambiguous. We cannot rule out
>     existing kfuncs, either defined by a module or by the core kernel,
>     whose names already contain "__".

It will fallback event kfunc has an ordinary name with "__".
> 
> 2. ksym_name is not used only locally inside find_ksym_btf_id(). If
>     ext->name / ext->essent_name becomes inconsistent with the actual
>     kfunc name, it may affect other code paths as well

ksym_name remains same, no impact to other part.

> 
> It seems that there are two problems to solve here:
> 
> 1. Allowing kernel modules to override vmlinux kfuncs with the same
>     name.
> 
>     This should be relatively straightforward to implement by matching
>     names in kernel modules first, and then falling back to vmlinux.
> 
> 2. Handling the case where different kernel modules have kfuncs with
>     the same name.
> 
>     Could we use a new libbpf API to establish the mapping manually?
>     for example:
>         bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
> 
>     Or define a new attribute, for example:
>         extern void kfunc_name(void) __ksym __module("module_name");
> 
>     We probably need to hear suggestions from other developers on this.
> 
> Note: Adding the module name as a prefix to the kfunc name is
> technically feasible, but it has significant historical compatibility
> issues, which are hard to solve.
> 
>>   static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
>> -			    __u16 kind, struct btf **res_btf,
>> -			    struct module_btf **res_mod_btf)
>> +			__u16 kind, struct btf **res_btf,
>> +			struct module_btf **res_mod_btf)
>>   {
>>   	struct module_btf *mod_btf;
>>   	struct btf *btf;
>> -	int i, id, err;
>> +	int i, id = 0, err;
>> +	const char *module_name;
>> +	const char *kfunc_name;
>> +	size_t module_name_len;
>> +
>> +	split_module_from_ksym(ksym_name, &module_name, &module_name_len, &kfunc_name);
>> +	if (module_name_len == 0)
>> +		goto search_vmlinux;
>>   
>> -	btf = obj->btf_vmlinux;
>>   	mod_btf = NULL;
>> -	id = btf__find_by_name_kind(btf, ksym_name, kind);
>>   
>> -	if (id == -ENOENT) {
>> -		err = load_module_btfs(obj);
>> -		if (err)
>> -			return err;
>> +	err = load_module_btfs(obj);
>> +	if (err)
>> +		goto search_vmlinux;
>>   
>> -		for (i = 0; i < obj->btf_module_cnt; i++) {
>> -			/* we assume module_btf's BTF FD is always >0 */
>> -			mod_btf = &obj->btf_modules[i];
>> +	for (i = 0; i < obj->btf_module_cnt; i++) {
>> +		/* we assume module_btf's BTF FD is always >0 */
>> +		mod_btf = &obj->btf_modules[i];
>> +		if (strlen(mod_btf->name) == module_name_len &&
>> +			!strncmp(mod_btf->name, module_name, module_name_len)) {
>>   			btf = mod_btf->btf;
>> -			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
>> +			id = btf__find_by_name_kind_own(btf, kfunc_name, kind);
>>   			if (id != -ENOENT)
>> -				break;
>> +				goto found;
>>   		}
>>   	}
>> -	if (id <= 0)
>> +
>> +search_vmlinux:
>> +	btf = obj->btf_vmlinux;
>> +	mod_btf = NULL;
>> +	id = btf__find_by_name_kind(btf, ksym_name, kind);
>> +	if (id == -ENOENT)
>>   		return -ESRCH;
>>   
>> +found:
>>   	*res_btf = btf;
>>   	*res_mod_btf = mod_btf;
>>   	return id;
> 


best regards,

Song

