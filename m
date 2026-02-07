Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B8271450;
	Sat,  7 Feb 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770472807; cv=none; b=BackGYAZowMmT+Bqqf6OAPA5uZ7T3bErBgJZHI8WSNRs9MtEG2fDZ6eUcUvLxNDM/vcbWN7WZ1nhe3njf8tJDGwtMu5g9fIWeBWP9eMmrt5nQoTjZDo1VnXiNfV7VA8QhDWryC8Vum+SGeBPjcNhQemahzrosIWy8xF/RJFAYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770472807; c=relaxed/simple;
	bh=rjdm1Ic7XoZk25AH0X9RP+05ak1ktFxkWjaJcXYGSm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSbpNzoV+5kkIgCnaKomCkGcBO/QVOLXnxMXFgfNe07DxOWOpIDM8nx1AYC+/eXOocEes+H4K/P2jeX6gJM1FiTG9C3O3xXgATEdBft0OyybnqoMSr8bva96Cd8R5ryHUJHuFLNXBF9WRs8DMRwK+w/tVfp41rRMlkYDgsV72Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.671580944
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-60.27.224.131 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id DBB45400088;
	Sat,  7 Feb 2026 21:55:21 +0800 (CST)
Received: from  ([60.27.224.131])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 589abf40d3564fb186639cebaec3af04 for alexei.starovoitov@gmail.com;
	Sat, 07 Feb 2026 21:55:22 CST
X-Transaction-ID: 589abf40d3564fb186639cebaec3af04
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 60.27.224.131
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <49e41217-d96e-4234-a18c-633cc22fbbd4@189.cn>
Date: Sat, 7 Feb 2026 21:55:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260122090404.15553-1-chensong_2000@189.cn>
 <CAADnVQLVQW-Mb_d+zT+aSpPOZ042erPVcSHVBx9PMGET+a754Q@mail.gmail.com>
 <bb4a868d-d4e2-40dc-aed4-4788b159a7f6@189.cn>
 <CAADnVQJEjhJH6+2cLJ0jM_fZ366oU3yoK1b5aMk=VgksXhJtoQ@mail.gmail.com>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <CAADnVQJEjhJH6+2cLJ0jM_fZ366oU3yoK1b5aMk=VgksXhJtoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/30/26 10:54, Alexei Starovoitov wrote:
> On Thu, Jan 29, 2026 at 6:18 PM Song Chen <chensong_2000@189.cn> wrote:
>>
>> hi,
>>
>> my comments are in line, thanks.
>>
>> Song
>>
>> 在 2026/1/28 12:28, Alexei Starovoitov 写道:
>>> On Thu, Jan 22, 2026 at 1:04 AM <chensong_2000@189.cn> wrote:
>>>>
>>>> From: Song Chen <chensong_2000@189.cn>
>>>>
>>>> I had an ebpf program which calls a kfunc defined and
>>>> implemented in one of my kernel modules, they were working
>>>> fine in 6.16, but was broken by libbpf in 6.19, the error
>>>> message was:
>>>>
>>>> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
>>>> incompatible with vmlinux [94389]
>>>>
>>>> yes, the reason is there is a new added kfunc in kernel 6.19
>>>> which happens to be the same name with my kfunc. However the
>>>> error message is not obvious enough to address problem
>>>> immediately.
>>>
>>> I don't quite understand what you're trying to say.
>>> "broken by libbpf"?! You mean that kernel 6.19 got
>>> new kfunc bpf_strstr() ?
>>> Why libbpf error is relevant?
>>> You mean you had your own custom .h file where
>>> you defined your own kfunc from a custom module
>>> and libbpf complained that your bpf_strstr() kfunc
>>> definition doesn't match the kernel 6.19 ?
>>
>> let me explain:
>>
>> I had a module, defined a kfunc(bpf_strstr) in its c file and register
>> it through register_btf_kfunc_id_set.I also had a ebpf program to use
>> bpf_strstr in this module.
>>
>> They were working fine in kernel 6.16, but kernel 6.19 has its own
>> bpf_strstr, so when i ran my ebpf program in kernel 6.19, libbpf broke
>> it here:
>>
>> bpf_object__resolve_ksym_func_btf_id
>>     --bpf_core_types_are_compat
>>       --__bpf_core_types_are_compat
>>
>> yes, your understanding is pretty much correct.
>>
>>>
>>> and your proposed solution is ...
>>>
>>>> Therefore, this patches searches duplicated kfunc in
>>>> btf_vmlinux before a kernel module attempts to register kfuncs
>>>> through register_btf_kfunc_id_set, it prints clear error message
>>>> and returns error code if same name kfunc has already implemented
>>>> and registered, then developer knows at the first place.
>>>
>>> Are you saying that the kernel module that supplied bpf_strstr
>>> shouldn't be allowed to register its kfunc if kfunc with
>>> the same name exists in vmlinux. So insmod will fail?
>>
>> yes, two kfuncs of bpf_strstr are registered in the system and one of
>> them is never used, this is a problem.
>>
>>>
>>> This is debatable. I guess we can add such sanity check,
>>
>> agree, even it's not a big deal.
>>
>>> but what about kfunc in module A with the same name as kfunc
>>> in module B?
>>
>> It's in my plan, also go through "list_for_each_entry_safe(btf_mod, tmp,
>> &btf_modules, list)", but i haven't gone that far yet, i can add it.
> 
> I'm not convinced that we should be doing it.
> 
>>> Currently libbpf tells kernel both btf FD and kfunc btf ID,
>>> though there is a single namespace for all kfuncs from bpf
>>> program pov the kernel and libbpf api-s allow a selection.
>>>
>>> Technically we can hack something in bpf.c to "namespace" kfuncs
>>> and say that the kfunc "foo" is in the module "bar".
>>> It won't be pretty in C, but possible in principle.
>>>
>>> Maybe a kfunc with the same name in the module should be allowed
>>> to override a kfunc in the kernel.
>>> It can be seen as livepatching of kfuncs.
>>> imo that's a more interesting use case than helping
>>> out-of-tree module to produce nicier error.
> 
> because ^^^ is what I think we should be doing instead.
> Since it is more applicable and useful.
> 
> I'd like to hear what other folks are thinking

If I understand you correctly, you need both kfuncs to co-exist and 
kfunc in module has higher priority.

I did some research and test:
kfunc addr is set in function add_kfunc_call by calling 
kallsyms_lookup_name(func_name), if it calls 
module_kallsyms_lookup_name(func_name) instead, it will get the kfunc in 
module and it works like a livepatch literally.

The problem is how can we know which one should be called, insn->off 
seems to indicate kfunc is from module if it's bigger than 0, but it's 0 
in this case.

Any advice in this case?

/Song

