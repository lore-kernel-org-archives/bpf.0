Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937923E3163
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268112; cv=none; b=n2metesA2f+5HQJvWfEXazy3Xo4TcRrf9Qcs8eo/I8rPauYMwcpG77OoC3lMi7HdcSHgbAe4oQG9aodmPJXvfNs5TT6pxs67dirVCvNh2LGELY9ZgrGn7SsOkc61u6Uxfb1c9SPVpB8dVbfVmLr3jfc+bkBLSgccc1T8P+qyuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268112; c=relaxed/simple;
	bh=4U+lGXzdrqaxB/1sHdVpDCnsS8PBYriLa1JgIX2Uijw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHmYGQ2XVULhcVMo3pfRBtzNsyNeAqWc7hrhWQb6ihd7ueNGfp0/d7qq0sQgLgdpogIOIsHpwzfeZQBmmAY3Ui4xZRWbrbEr6SAU9wkHl7HsJwcypfJv73apjWTJbyW3iH/JYsrlecwVM/m+4Xp0jxLeX/8lhP1WUF88ZgVQl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABQ7sPWh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABQ7sPWh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so107234355e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776268106; x=1776872906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HynLTqHYNy+686QPoe/hx3nOpHjVAP0O5bTsZ35kxyk=;
        b=ABQ7sPWh9a1lSMAlAa7JiTSPDp7XGPXlNwDJlPCYmGS+bcySfExvCSdPUBrFbnvKmx
         Re3C3Vq37iuP2gDm/DZpHAJiaNhDUyuNSlMtz7if3ExqSQ0yMK59DZUjivIIdnpAT/B2
         FnKdfA2EAs/FBhNyIxHlD/TSo6rmt1QdKWlbq9oGZ1oPisKVFLU7PsA1/lFmOQAHo4DJ
         H8Yl30Z9i29niVIRjfkL41Vk6etD1BO/VuRW/Ymh4F6dc5zirvWXHO9mq4uZ2xi/fq53
         ukY4NXLyiF0GsG7D6F17fnyrSQTIqcvYxaXIoTgEIR7z70KMqwm1t2sj7KRw2sucMXn7
         27Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268106; x=1776872906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HynLTqHYNy+686QPoe/hx3nOpHjVAP0O5bTsZ35kxyk=;
        b=TxDrKRWrwug4CeSnMNGLpJHE/UrjiJ2XFavo6VITB7jGpgQAv/wj7WYYCBKpJD730Z
         PPgCHpwTvhOTTWMcXrTPo+xlC2t2WcH3x1wHbO+h9CrdMyoyi/H+hFuyPNzAKSf5YmZD
         ANaQMRE+LdmlOD+9NLykZPEyrXyhakacKTWZGVpezR5nwwap4pbnZuhueBV875s04Lhb
         JbUPRNQC58Q53nk669SOLwoZ83ki9nQpHZ2SkNIiZc+YN2NMYfoyWsUAF/L/QcfRBRf5
         RdlBB37AQcyKikOvcp4mDAnIqKoYNgQ80oDP5NOHhG2ZEwONuTH8fDfpfE3UijlLGuCi
         +07g==
X-Gm-Message-State: AOJu0YyGR/3vwoSg9AXkP80ox8vxEA+3minscNXkoaCVGBdR2kyaf1DN
	8mWVzfLXxOPvKzMNeZRFVj+6RJ10dxObvnYvxLb6spGTszzxCpOf+QK/
X-Gm-Gg: AeBDietGBu4coah2teqOrX1PBSKpimXyuADCfTTkkSUld4f5NcOIo+83eol8/DGHlIQ
	FlUMlY/xogYidHsYa2QbOOOYrE3+G0NAOzQuRuUKUqGlZPaqhk/ypoblEDCLCDIzp+P8xXN6ksZ
	gB6IlnLuqDdSW5sCdgy9ooWV6KvBaPy0zQvDbiGPHgHLO4bdurFFGDI2XPoP9XrBAPLFIBO6T06
	+MPCvg+KcqV1WW8PMCNcrRz5HqyedDqb9u5jDw+zn18PJL9tXQ9yyjyH8kxkHbO1K3UsoP8afHi
	oWr/ABtE2KJ783vbdLiWFILL1l4ATyk4LNp136BNaMMRxL1wDdNdkwja3nL8H64Auz0ONP1OM0e
	8cugGJM5bK4Wt6UOgf1IyZ4/iwCxiKDG16OYJrmvDOLrjbLTv5pJOYr1XXEhe7y5TTyNo02xkhf
	v1eiwDm1h5q6iirSQzwtNS5RAuQl3ImWAOLQltlYABnnVJbCC3XISPxlMghVrG
X-Received: by 2002:a05:600c:2d47:b0:488:dfbc:490c with SMTP id 5b1f17b1804b1-488dfbc4b2cmr143916905e9.16.1776268106031;
        Wed, 15 Apr 2026 08:48:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cbe8:6434:118f:886d? ([2620:10d:c092:500::5:3ecd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f4352af8sm4364775e9.0.2026.04.15.08.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:48:25 -0700 (PDT)
Message-ID: <e41d94d4-bbef-4d04-a6ef-8f885aab9b72@gmail.com>
Date: Wed, 15 Apr 2026 16:48:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/6] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
To: sashiko@lists.linux.dev, Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
References: <20260414195019.684531-2-alan.maguire@oracle.com>
 <20260414211101.59F73C19425@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260414211101.59F73C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/26 10:11 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] The `env_stack_set_next_member()` helper takes a `u16` argument, which truncates the new 24-bit BTF `vlen` and causes an O(N^2) infinite-loop-like CPU lockup (Denial of Service).
> - [Medium] UAPI Source Breakage: Converting `BTF_MAX_*` macros to `enum btf_max` removes preprocessor macros, breaking existing userspace compilation.
> --
> 
> commit d88c0688f1be53ae1871dacf198a4a18b2e56ae0
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> bpf: Extend BTF UAPI vlen, kinds to use unused bits
> 
> This commit expands the BTF maximum vlen from 16 bits to 24 bits, allowing
> up to 16 million members. It also extends the BTF kind encoding from 5 to 7
> bits, and converts the BTF_MAX_* constants to an enum to expose them in
> kernel BTF.
> 
> Link: https://lore.kernel.org/bpf/CAEf4BzZx=X6vGqcA8SPU6D+v6k+TR=ZewebXMuXtpmML058piw@mail.gmail.com/
> 
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index 638615ebddc22..618167cab4e61 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -33,20 +33,22 @@ struct btf_header {
>>   	__u32	layout_len;	/* length of layout section	*/
>>   };
>>   
>> -/* Max # of type identifier */
>> -#define BTF_MAX_TYPE	0x000fffff
>> -/* Max offset into the string section */
>> -#define BTF_MAX_NAME_OFFSET	0x00ffffff
>> -/* Max # of struct/union/enum members or func args */
>> -#define BTF_MAX_VLEN	0xffff
>> +enum btf_max {
>> +	/* Max possible kind */
>> +	BTF_MAX_KIND =		0x0000007f,
>> +	/* Max # of type identifier */
>> +	BTF_MAX_TYPE =		0x000fffff,
>> +	/* Max offset into the string section */
>> +	BTF_MAX_NAME_OFFSET =	0x00ffffff,
>> +	/* Max # of struct/union/enum members or func args */
>> +	BTF_MAX_VLEN =		0x00ffffff,
>> +};
> 
> Could replacing these #define macros with an enum break existing userspace
> applications?
> 
> Programs using #ifdef BTF_MAX_VLEN or evaluating #if BTF_MAX_VLEN == ...
> for conditional compilation will fail to build without the preprocessor
> macros.
> 
> Would it be better to redefine the macros alongside the enums
> (e.g., #define BTF_MAX_VLEN BTF_MAX_VLEN) to maintain UAPI backward
> compatibility while still exposing the constants to BTF?
> 

Looks like this is done on purpose and we don't expect anyone actually 
use #ifdef BTF_MAX_VLEN, so it's an acceptable change.

> [ ... ]
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index a62d785812076..1663970fc1bf6 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -289,7 +288,7 @@ enum verifier_phase {
>>   struct resolve_vertex {
>>   	const struct btf_type *t;
>>   	u32 type_id;
>> -	u16 next_member;
>> +	u32 next_member;
>>   };
> 
> Does the env_stack_set_next_member() helper also need its next_member
> argument updated to u32?
> 
> Looking at env_stack_set_next_member() in kernel/bpf/btf.c:
> 
> static void env_stack_set_next_member(struct btf_verifier_env *env,
> 				      u16 next_member)
> {
> 	env->stack[env->top_stack - 1].next_member = next_member;
> }
> 
> Since the argument is still u16, won't this silently truncate the i + 1
> index for any struct or datasec member beyond 65,535?
> 
> If this happens, when the verifier resumes resolution of the struct, could
> it restart from the truncated index and redundantly iterate over
> already-resolved members? With a very large number of members, could this
> cause excessive CPU usage or soft lockups?
> 

