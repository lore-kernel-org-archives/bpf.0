Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3053431E3;
	Mon,  1 Jun 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305890; cv=none; b=oSCg1k9KrchVWNckBBbB7ZXjdY+VJcBKRSXOKg14+b+iOfwMDOZxj+2vbjLxreJhRC+rbAp6sbLDf7/PXF6wIauKGAV/qUxE/0krfZ4JjpKIL+spOuQlqyfidDSMuCqq4xqL9rDLC+0oa/pQeSWupPLupUC62nHuRbuY2EuQvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305890; c=relaxed/simple;
	bh=BJO2i4P4I7PMZLSD8hJjc6jYpaJbVNn4EbkTN6wFtD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5x71CNm9eEFmGLolZAce5s0ncUKiqVdXYqno8UQ8Uh3jxqw6CAPSQsGT55aOBF92sOe08bDIKFrp5e4FebOn5H7oiiew1bQ08IwpXLNsJGW1PGxG/kLgk0LybRtGOJwm0+9hGYywcAlJw+q61OGZ0tpp6TeSyQgJwPLgCoQJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Lhghttbd; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Lhghttbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=n5nWqLU2EiANHkp9IITdueqQa7AqbQd7p3WTDLE99bM=;
	b=LhghttbdhCfJ19lYoPzY8C9SLq1JgJ2/P9+K36oOkZwbL7jN8HI5BYZE/Mo/Ot
	02Gswz5NAt4rhfmADRTm6CYTvQ8oije0/Fu6C+XtsmhE6QDISUe2wb2OnXTepKLy
	Tx1E9WNRo0OMMfK1rQ+0smolkrWDHKX+4AItjuhTbpxI0=
Received: from [10.41.105.18] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3H3ieTx1q4Qh7AQ--.25045S2;
	Mon, 01 Jun 2026 17:23:42 +0800 (CST)
Message-ID: <e1580a5a-0942-4204-8311-0a1137336acd@126.com>
Date: Mon, 1 Jun 2026 17:23:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260524082944.10625-1-chensong_2000@126.com>
 <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
 <CAADnVQKWjqmEw6rZNQ5O8SBFs2tfK4q_UX78ZV2pH2fgdq_c2g@mail.gmail.com>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <CAADnVQKWjqmEw6rZNQ5O8SBFs2tfK4q_UX78ZV2pH2fgdq_c2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD3H3ieTx1q4Qh7AQ--.25045S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF45Jw18XFWfCryDtF1kKrg_yoWrur4fpF
	W5JFs0kF4Iqr17X3W2qFn8ury3tw18KF42vF93tFy3Jryqqrnrtr1j9r4Y93sayry8Ca4I
	vF4jgFZxu3yYyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3AwsUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsh-cXGodT5-SOQAA3h

Hi,

在 2026/5/29 11:01, Alexei Starovoitov 写道:
> On Mon, May 25, 2026 at 2:20 AM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>>
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
>>> ---
>>>   kernel/bpf/btf.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>>
>>
>> btf: reject to register duplicated kfunc
>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 4872d2a6c42d..a14ad3720872 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -8618,6 +8618,47 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>>>        return 0;
>>>   }
>>>
>>> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
>>> +{
>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>> +     struct btf_module *btf_mod, *tmp;
>>> +#endif
>>> +     s32 id;
>>> +     int ret = 0;
>>
>> This ret variable may be unnecessary.
>>
>>> +
>>> +     if (!btf_is_module(btf))
>>> +             goto out;
>>> +
>>> +     id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
>>> +                                     func_name, kind);
>>
>> It seems unnecessary to split this call across multiple lines. Also,
>> some of the continuation-line indentation elsewhere does not appear
>> to follow the kernel coding style.
>>
>>> +     if (id >= 0) {
>>> +             pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
>>> +                                     func_name, id);
>>> +             ret = -EINVAL;
>>> +             goto out;
>>
>> return -EINVAL;
>>
>>> +     }
>>> +
>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>> +     mutex_lock(&btf_module_mutex);
>>> +     list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>>> +             if (btf_mod->btf == btf)
>>> +                     continue;
>>> +             id = btf_find_by_name_kind(btf_mod->btf,
>>> +                                     func_name, kind);
>>> +             if (id >= 0) {
>>> +                     pr_err("kfunc %s (id: %d) is already present in module %s.\n",
>>> +                                     func_name, id, btf_mod->module->name);
>>
>> follow the kernel coding style
>>
>>> +                     ret = -EINVAL;
>>> +                     break;
>>
>> mutex_unlock(&btf_module_mutex);
>> return -EINVAL;
>>
>>> +             }
>>> +     }
>>> +     mutex_unlock(&btf_module_mutex);
>>> +#endif
>>> +
>>> +out:
>>> +     return ret;
>>> +}
>>> +
>>>   static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>>>   {
>>>        const struct btf_type *func;
>>> @@ -8631,7 +8672,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>>>
>>>        /* sanity check kfunc name */
>>>        func_name = btf_name_by_offset(btf, func->name_off);
>>> -     if (!func_name || !func_name[0])
>>> +     if (!func_name || !func_name[0]
>>> +                     || btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
>>
>> follow the kernel coding style
> 
> yeah. formatting is way off.
> pls respin.


will do, thanks so much.

Song

