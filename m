Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0E38333F;
	Wed,  3 Jun 2026 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478257; cv=none; b=EDqXsP9BR5pjmNn8eNuwDVZrU8PTUkwc5U5cO4bK9UDURQBV+8wg3HIgRH3UppkPfHVvMXg9rdnUaqExGXN2EOYE0UR30k1eZBVo0lZtgit9zUVoHomgOxEifzDvmpvNGDlKd6eAXAQPzCR6t+ZClOeZG6PYoPNPkweKiByKavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478257; c=relaxed/simple;
	bh=aXFVWAph2IAGoRFAIHj9s8MoDQp+/Z51PWf1mfGBfq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDm6/WG2RmIDFiTr6/DCGs+kGznCCSFcfJ4QQRNtSJJj71nD8nM2N9y2NPOI8OukQTkxgceN1uEEP9AwGTNdf6RZpk7igcKnvuWic3WUeMp1gfqTf1O3YjV0FsIJG6e8Vv5JpA2Tx2PI4nmkQxn6kKxpQp1anAJj2g1gaXa0k/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TkPFAl26; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TkPFAl26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=P9sWvF/xqvCKAMYH4m9HhgjizdpyX9NLuf3nh0RUxg0=;
	b=TkPFAl26YHoM+guUU7Pe/zgDvSxQmhlQ24n0Szz2kMTG1pfgdmhN+E4tciruxr
	TOzu805aQH+LvIJOEP07B/9w0n3LZ1sMLUhg6dPEQDvyc65SERSLqoQronvmXVdG
	KD9lB9Q2Zusz77Qup/GKP1XyPlgiAbsNoOU8iiTtqeLIo=
Received: from [10.41.105.18] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXvnrI8B9q6X_5Ag--.14449S2;
	Wed, 03 Jun 2026 17:15:53 +0800 (CST)
Message-ID: <1d2d1926-87fe-4437-ab67-4321749fbc83@126.com>
Date: Wed, 3 Jun 2026 17:15:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btf: reject to register duplicated kfunc
To: Leon Hwang <leon.hwang@linux.dev>, Yonghong Song
 <yonghong.song@linux.dev>, martin.lau@linux.dev, ast@kernel.org,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 kaitao.cheng@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602110710.19642-1-chensong_2000@126.com>
 <d4054d34-430c-4360-8392-a21f8ebacff4@linux.dev>
 <6f7bfa86-7f9c-4ac3-baff-88b541e6a48a@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <6f7bfa86-7f9c-4ac3-baff-88b541e6a48a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXvnrI8B9q6X_5Ag--.14449S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWxCr1DCFyDCFyxAw13Jwb_yoWfZrg_ur
	yUZa4fKF4DXa48ursxX34rWr17X3y8Cw13J3yDCFy5XwsxW3ZrJF17W3s2qF4xGr1UGrs2
	9r1rC34fW3y8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUesjjPUUUUU==
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpQrQUGof8Mo0QAAA3U

Hi,

在 2026/6/3 10:18, Leon Hwang 写道:
> On 3/6/26 01:13, Yonghong Song wrote:
>>
>>
>> On 6/2/26 4:07 AM, Song Chen wrote:
> [...]
>>> +
>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>> +    mutex_lock(&btf_module_mutex);
>>> +    list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>>> +        if (btf_mod->btf == btf)
>>> +            continue;
>>> +        id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
>>> +        if (id >= 0) {
>>> +            pr_err("kfunc %s (id: %d) is already present in module
>>> %s.\n",
>>> +                    func_name, id, btf_mod->module->name);
>>> +            mutex_unlock(&btf_module_mutex);
>>> +            return -EINVAL;
>>
>> Let us avoid the above mutex_unlock and 'return -EINVAL', just do
>>      err = -EINVAL;
>>      break;
>>
> 
> Better to use guard(mutex)(&btf_module_mutex)?
> 

This is the first time i used guard and it's awesome. I have tested in 
my code and will send a new patch later, many thanks.


> Thanks,
> Leon
> 
>>> [...]


Song

