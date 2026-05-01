Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527322D5C68;
	Fri,  1 May 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777618766; cv=none; b=mAudk0Aa8m2+toBXjlQrH9jtWt/Oem8TVk9sn4BcA8oqGfLAJve1NZat7oDTcYc7KAwTinnr2a0q75X3F+IzTw+BRR0gW4YG3NsKrjSgRGyL5rNNtW5hOcSv960AbA8OGNuenRGzefuxVqQpsuHU/Lzx+A4+ZYeJLK+0dX6XOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777618766; c=relaxed/simple;
	bh=Dm2r2eycu3JHO+J1C1RQbWr9SNszP3rKN9+VHF6CICA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRSS4+fhEeId/6/RpErvLpcbqDJODrorR8XlCTAB376u0rkqR1wDUxMwpmHZLfPzbSwO1/yO1+4uBGqHGtUzO0JgdLN6Q/F2ZK7xBVdYoU4AsqvEatKWotxmq/Av8pubpC0PZ+rMeAa/XN26JsqZt7trMR14d/qWd1QhdzNwwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BjOTSluK; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BjOTSluK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tGsmZIOtTKZDVQQZ41KSah4rNkkUVdV58+NgnL+cJFw=;
	b=BjOTSluKHEf1DaPdO4VTTkkJtGhXK4Noath4SD04caHi0INy0PnkLaH+szNDif
	iGlFThvfOwz/GJkBWm2LvDhURQgFehb4sXr5Mnug727X99RxGAEsvIPrMP6BuoFO
	xbPO/rtVDt2eep0g/poi+mIuop6hzW4862EKnFr4vl+/Y=
Received: from [IPV6:2408:8210:480a:2590:ac48:b89b:2945:c541] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3P2j3TvRpmsTBAA--.20242S2;
	Fri, 01 May 2026 14:58:00 +0800 (CST)
Message-ID: <d8ae758a-87ad-4c21-9d22-0d26569bf512@126.com>
Date: Fri, 1 May 2026 14:57:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kernel/bpf/verifier: Support module kfunc resolution
 via instruction offset
To: bot+bpf-ci@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260430054714.38980-1-chensong_2000@126.com>
 <b34544363de19e30ab84c1f377b2255490b7b0e69572416efa21d0d2f9148452@mail.kernel.org>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <b34544363de19e30ab84c1f377b2255490b7b0e69572416efa21d0d2f9148452@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PykvCgD3P2j3TvRpmsTBAA--.20242S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1UXF4UAF17Ar4fGFyfWFg_yoW5Gr4kpF
	4xKr4Ykr4qqr17uan2yw4xZFyI9F98Kw43K3Z8KrySyr4vgF10vF10kw1rZ3s5tr48Cw4I
	9FWjgayqvryUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3L05UUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRhp6Gn0TvjaDwAA3C

Hi,

On 4/30/26 14:27, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 03f9e16c2abe..7e6a95e6821d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2734,7 +2734,10 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>>   	if (err)
>>   		return err;
>>
>> -	addr = kallsyms_lookup_name(kfunc.name);
>> +	if (offset)
>> +		addr = module_kallsyms_lookup_name(kfunc.name);
>> +	else
>> +		addr = kallsyms_lookup_name(kfunc.name);
>>   	if (!addr) {
>>   		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
>>   		return -EINVAL;
> 
> When offset is non-zero, module_kallsyms_lookup_name(kfunc.name) searches
> all loaded modules and returns the first match. How does this handle the
> case where multiple modules register kfuncs with the same name?
> 
> In the original discussion thread from January 2026, Alexei Starovoitov
> asked: "but what about kfunc in module A with the same name as kfunc in
> module B?" You acknowledged this concern and indicated it was in your plan
> to address. However, the current implementation appears to rely on module
> load order when multiple modules have identically-named kfuncs.
> 
> Reference: https://lore.kernel.org/all/CAADnVQLVQW-Mb_d+zT+aSpPOZ042erPVcSHVBx9PMGET+a754Q@mail.gmail.com/
> 

This problem is in my mind too, but as far as my understanding, the ebpf 
code of calling an kfunc is:

85 10 00 00 ff ff ff ff

when libbpf relocates this kfunc, it searches all the modules only by 
obj->externs[i]->name, no additional indication tells libbpf which 
module to search from, as a result, the first finding will be relocated 
in ebpf code, like:

code=0x85 dst=0 src=2 off=1 imm=153416

> Is there a mechanism to ensure the correct module's kfunc is selected when
> names collide across different modules?
> 

Is it acceptable to add extra information in ebpf source code when it's 
calling a kfun:

extern int module_a__foo(void *p) __ksym;
extern int module_b__foo(void *p) __ksym;
extern int foo(void *p) __ksym;

Then libbpf interprets obj->externs[i]->name and knows which module or 
vmlinux this kfunc belongs to, kernel will find the correct addr in 
verifier.

Best regards,

/Song

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25150033548

