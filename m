Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B73344D8C;
	Mon,  1 Jun 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305870; cv=none; b=CjKEg6GHi+py/yz5BhMu6CFOwhCFUnP8HIxM4MgSbbS/PAFc0IFJiWMQ1Jp4XyVjNVzxF72thMdlipdRWU/kzam9gQg3erKmuyOFv/XOwkLkVXv0lQATfN/Xxglx8ji41EeKSmoYAECw5g1J/+lQBmv2RW9Sa/IQUJgtUcZdLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305870; c=relaxed/simple;
	bh=IW5cfo/bC26+LgC0z/aL2YXuQi6OOqMSgcNFJWcxSoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGxk78F5C91zhe3TtVQ/qFDMj11vRDZsnpAgQ2wJyzlf1W04vShRKxeFhemEzLCZhGjXo6fOoTHGtiat3Z2INPN4L2KtPNijjRg7cW1LHBiDSZ77zi8eDY1T7dVuh/YyRsGN5BvGzKFPFa/m4cRPMzPALZam0kzXq0+FFz1Nn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DgJKZXdp; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DgJKZXdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=e/+rvHoW/ia7sXFiB0Wxz22rzbKfAYctmMx0aF8/tsc=;
	b=DgJKZXdpqyKuBiRqmd3cR7C+n6UwllJ59ArmSNZHBuO3ZJNBnBPKFuMQ4J5qun
	5/5vtZ98Fa9wsbpaQcByjYEZ6TmmtW+SK8zY6t1sokPxgTabb9PtsTIHn2SqUMqK
	tTJFdZDJO6xrtsmY5+44tOrBXm7NvAsQCThUga3fq4nHE=
Received: from [10.41.105.18] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXH5MYTx1qevPZAg--.52898S2;
	Mon, 01 Jun 2026 17:21:29 +0800 (CST)
Message-ID: <9d2609fb-6658-4a47-bdbd-b72538b35ae7@126.com>
Date: Mon, 1 Jun 2026 17:21:28 +0800
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
X-CM-TRANSID:_____wBXH5MYTx1qevPZAg--.52898S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry3ZrWDur48Zr1DWw1kGrg_yoWrCrWDpF
	W5JFZ8uF4Iqw17Xa42qFn8ury3Jw18GF4jyF9xtFW3Gr4qqrsrtr1j9F4Y93sakryUCa4I
	vF4UWFZF93yjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaa0PUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRq7O2odTxq36gAA3A

Hi,

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
> 
>>   		return -EINVAL;
>>   
>>   	func = btf_type_by_id(btf, func->type);
> 

will do, thanks so much.

Song

