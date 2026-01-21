Received: from mail.189.cn (189sx01-ptr.21cn.com [125.88.204.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635545BD68;
	Wed, 21 Jan 2026 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.88.204.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982169; cv=none; b=Wlbnembmf7xTzV3zjFvq+xxgQZOu8FPL6Oe2EWZWL9gIpb7wbJiOXdqDW1xkvKXpjOLEviPUALDCMYmlDmjwXTz/RUQSDjRSPX6utySRIKgGLJcs8wlLWdVSgqZnv+QS8gQ6Uwtb5pslSpN76NIDtO0HlAgH+v3fxoQPjr6vYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982169; c=relaxed/simple;
	bh=Dx8XiEcF6skdyUObOd3whe2XtVbiCLdR7Qi077yh61k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA2XgbghgMRIqf3dieR/I1iWOnuV4wkhqS5P9QFpZQWSgjQifBqyWGuPVp3wDWBgXOri4f9H4FT1zDIPDjtXwWh3IlDvp7uuPcdjNJapQt8VNPROkJHK9YYqQ+qvyTExds1ac/Oc8Jo9sPvEg0SV23kNRt2Zrm+lFmWRAnQvYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=125.88.204.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.1964313234
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 4459D40029B;
	Wed, 21 Jan 2026 15:51:25 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-587d8f56d7-sdp2j with ESMTP id 7fbac67939464c62a3d6782dec959390 for bot+bpf-ci@kernel.org;
	Wed, 21 Jan 2026 15:51:27 CST
X-Transaction-ID: 7fbac67939464c62a3d6782dec959390
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <f3e51cd5-9eed-4fc6-af7e-429783a820c1@189.cn>
Date: Wed, 21 Jan 2026 15:51:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/bpf/btf.c: reject to register duplicated kfunc
To: bot+bpf-ci@kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260121015157.7283-1-chensong_2000@189.cn>
 <f5d7058d44d03e21fecfdeb4c6b7d0329ff4f764fe24aa6f86d5c5da9ccfa3ad@mail.kernel.org>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <f5d7058d44d03e21fecfdeb4c6b7d0329ff4f764fe24aa6f86d5c5da9ccfa3ad@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hi,

在 2026/1/21 10:16, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index d10b3404260f..b4ded7669642 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8615,12 +8615,23 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>>   	return 0;
>>   }
>>
>> -static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>> +static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags,
>> +			const struct module *module)
>>   {
>>   	const struct btf_type *func;
>>   	const char *func_name;
>>   	int err;
>>
>> +	/* check if there is any duplicated kfunc in vmlinux */
>> +	if (module) {
>> +		func = btf_type_by_id(btf_vmlinux, func_id);
> 
> The func_id parameter comes from the module's BTF (via btf_relocate_id),
> but this code looks it up in btf_vmlinux. BTF type IDs are specific to
> each BTF - vmlinux and modules have independent ID namespaces.
> 
> Is this lookup correct? btf_type_by_id(btf_vmlinux, func_id) will return
> whatever type happens to be at that numeric ID in vmlinux, not the type
> with the same name as the module's kfunc. For example, if the module's
> kfunc has BTF ID 100, this returns vmlinux type ID 100, which is likely
> an unrelated struct or typedef.
> 
> This seems like it would cause false positives - any module kfunc
> registration would fail if its BTF ID happens to fall within vmlinux's
> BTF ID range (vmlinux typically has tens of thousands of types).
> 
> To detect duplicate names, shouldn't this use btf_find_by_name_kind()
> to search by the function name instead of btf_type_by_id()?

The namespace has come up to my mind at the first place, i dumped kfunc 
info from btf_vmlinux and my module, turned out, they had same btf id:

[  114.348494] Hello, world!, id:150090
[  114.348499] dump_btf_info, btf name:hello, btf 
addr:0xffff8bc468c0bb00, nr_types:153081
[  115.709254] BTF ID 150090:
[  115.709255]   name_off: 2480470
[  115.709259]   name: bpf_strstr
[  115.709259]   kind: 12 (FUNC)
[  115.709260]   type_id: 150066
[  115.709260]   addr: 0xffffffffa93f9f50
[  115.720383] BTF ID 153075:
[  115.720384]   name_off: 2480470
[  115.720384]   name: bpf_strstr
[  115.720385]   kind: 12 (FUNC)
[  115.720385]   type_id: 153074
[  115.720385]   addr: 0xffffffffa93f9f50
[  115.720397] dump_btf_info, btf name:vmlinux, btf 
addr:0xffff8bc446112000, nr_types:153074
[  117.067793] BTF ID 150090:
[  117.067794]   name_off: 2480470
[  117.067794]   name: bpf_strstr
[  117.067795]   kind: 12 (FUNC)
[  117.067796]   type_id: 150066
[  117.067796]   addr: 0xffffffffa93f9f50
[  117.078950] bpf_kfunc_example: Module loaded successfully

Is this a coincidence? I couldn't help but think btf_id is a global 
value. If you have been trained with this kind of knowledge, i would
appreciate it if you could explain.

Nevertheless, btf_find_by_name_kind is a more reasonable way to 
approach, i will submit v2 to review.

many thanks

/Song

> 
>> +		if (func) {
>> +			pr_err("kfunc %s is already present in vmlinux\n",
>> +						btf_name_by_offset(btf_vmlinux, func->name_off));
> 
> Since func is an unrelated vmlinux type (not the module's kfunc), this
> error message prints the wrong function name - it shows whatever random
> vmlinux type was found at that ID, not the module's kfunc name.
> 
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> [ ... ]
> 
>> @@ -8911,7 +8922,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>>
>>   	for (i = 0; i < kset->set->cnt; i++) {
>>   		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
>> -					     kset->set->pairs[i].flags);
>> +					     kset->set->pairs[i].flags, kset->owner);
> 
> This shows that func_id passed to btf_check_kfunc_protos is from the
> module's BTF (btf_relocate_id operates on the module's btf), confirming
> the namespace mismatch when it gets looked up in btf_vmlinux above.
> 
>>   		if (ret)
>>   			goto err_out;
>>   	}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21194595610

