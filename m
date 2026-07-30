Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3739DBD7
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419312; cv=none; b=aqrdO0gUoeZS8v3opj4rJm9zaGMG5Svb/jd2BwYBN5L96igw8/w4LYYwO1ga848552dI09V4ee0bRz40KvUeCEFAIXfeGuE65fNbdpajc5bn3M0SyDmYVeMDF6/tTbegswiD950TZgxkXwBUc74XrxDjai/Dt259z7/g6lJia+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419312; c=relaxed/simple;
	bh=vCQIJUU9nXDr4xoQdwGY1bHF89iCiRm/jH6lv31XiEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiuYodpd3fkdJthxvf1y1c+7t10oDZLQy/iOk9y8K4xArlwZ9nsa6j7MuIUZVKaM+ZnM/04DpOgQGMmfahdxN1wgVuEZyLX+N296Kb1xPbO/kYlBAxi7TFu+AXmbwWVAMSO9QV7JLfaY8pHhz0qj9oj9CJ4zu9obaoPsxkGhBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cszu2rmz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cszu2rmz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so260823066b.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419309; x=1786024109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVywrhfa15eapzigH1Kkl2ZWf3WvjIE2DixDgT8FK2I=;
        b=cszu2rmz1JKNb1TvoCdQexeFaZxd94J1lCPiwhMjX2JhE+gZhUZ/q5AfYubvkyoVYt
         U8aVoG5fy0mN0cZyVqaFVxxPt/XYNdVXgIvv2UixfVSgvpdUVuqP7MiRVUxLbEnGL9y6
         eBZxPqcJmsPjXHLP9PNPXglYF6lLabI1rB97gHqeFYzuxZI9VnsUdQlksnJN+F95r7lN
         s9WEdpF8Zh/nlcvRDiis7y447O1pPConYAKMS5dp7Pzj992/d92oXKOtXIrsZXzPynEu
         QgpsdydMrTu7UhUlS9dQXAQKTFujXqcCnYMc+wc6r5OXf2e1y74ANFSyHYHHBbE8XGWM
         g+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419309; x=1786024109;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVywrhfa15eapzigH1Kkl2ZWf3WvjIE2DixDgT8FK2I=;
        b=gL6xM7Dk4sjzHpOKGDLqDReMDOSZX/KpKUKlMc2VmNRUpg6vc9AdLzlAKgZIQrfyCg
         kFlDRxLRaNw1kaMyNMTu/4cAMkzUwiSSqIzLpclR4DiSKiUml0GWSyBUItMZ1XaYixDG
         P2WxCfVckteAmc4P/+QyaCUS7Wfo0Uilny4HOkAC3f7vmDgPUlNV6QMZDc1cWYtelLZj
         j/MAeQY/j0oWLmBNwhXFhHCDFnhDG2P55BrnuDB4Vty64Mnk16Ynjz8en7xMBSSFUB/8
         1XiJ2CCoQFEAO+UyuLlS2h8zFqJ3Cq5zONi63lr9zcrUOagfaIrp+ScXtpPjHjSqp4Fk
         /Npw==
X-Gm-Message-State: AOJu0YxoI/qYNf/3UHuIl3jLol2PN6/BP3bVKhI0qt31bQEKmAXD6Rze
	vfcX+w6r4DzrLHIuUBGR+MNCK4qO/i2B/u9+46fh0lVca8VIb6THEz3S
X-Gm-Gg: AR+sD10gctEK1wUcXzZw6NHfSr64Z/0Ti8yCyBkOaoxvOG2Odzi8xYPAFiQtzdgrTva
	9eRvBgCL6pfBqU1sr5m7tEXwA/+Kyp+fCOHnid5I9sFjBqgm7ZQnHrvf0XH/1+e3pw2EMkvv1N2
	Yg7MqiN8D/gwyW+xrAH6m1G0nxdd547NqZjj/LYLsMGPNJeSLhDN2CSTh6CrDf8f4CHNWAPZ8eJ
	hw5cqP5S9pSSObSlnAFStuwhYzlt0vG/cPc85uNLzxwmckXIumLTzQ1Aho1YDWOYp3HdTOv6vVq
	Tq1p1zqksCCzqJ0FDJ5jyZrNE5NRfhNmtfzWe6JCvn6lMX+2vQe5j3D47WqMlxzGfgDulI8yG2d
	PXsLdQsjZ3ADWd3wtxRyuIjUx4yQuDCOgD4p4LKCKIlZ+VCZTMN/qw9NosLWYHPhohkSGwI78TE
	jssK3SGCWXzY3Z4UDwX8LJ2aGxfj/+2uxAfLvXNJMwdYC/0e4I31kQfFNcK70nFGgbLQ/0XRsli
	mJ3S1uf71/YXW6MI2Z5U41AHbMC/x4jM9NK5AxfhTU5O7rv
X-Received: by 2002:a17:907:db15:b0:c12:80f6:7fac with SMTP id a640c23a62f3a-c1fa575322dmr126619166b.36.1785419308681;
        Thu, 30 Jul 2026 06:48:28 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:50b3:c1a9:d2a7:4006? ([2a02:8109:a307:d900:50b3:c1a9:d2a7:4006])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851b723sm70384766b.12.2026.07.30.06.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 06:48:28 -0700 (PDT)
Message-ID: <e248c9d5-862e-4783-a984-ab29cb8f16f8@gmail.com>
Date: Thu, 30 Jul 2026 14:48:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] tracing: Make per-template BTF id lists
 file-local
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
 <20260730130352.476D51F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260730130352.476D51F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 2:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Using `BTF_ID_LIST()` instead of `BTF_ID_LIST_GLOBAL()` for tracepoint classes introduces significant BSS memory bloat when `CONFIG_DEBUG_INFO_BTF` is disabled.
> --
> 
> --- Patch [1]: [PATCH bpf-next] tracing: Make per-template BTF id lists file-local ---
> commit 49d7faf72ef8695ae45768a193f5a09e2cfe872d
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> tracing: Make per-template BTF id lists file-local
> 
> This commit converts trace event BTF id lists from global to file-local to
> avoid symbol clashes when multiple translation units instantiate the same
> class. It also explicitly provides local BTF id lists for handcrafted syscall
> events.
> 
> Link: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@sirena.org.uk/
> 
>> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
>> index 09ad57ac4b73e..45ffbe04b5805 100644
>> --- a/include/trace/trace_events.h
>> +++ b/include/trace/trace_events.h
>> @@ -404,10 +404,12 @@ static inline notrace int trace_event_get_offsets_##call(		\
>>   *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
>>   *   [1] STRUCT trace_event_raw_<call> (the ring-buffer record)
>>   * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
>> + *
>> + * File-local: the class name is not unique, so a global symbol would
>> + * clash across translation units.
>>   */
>>  #define _TRACE_BTF_IDS_DECLARE(call)					\
>> -	extern u32 __bpf_trace_btf_ids_##call[];			\
>> -	BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)		\
>> +	BTF_ID_LIST(__bpf_trace_btf_ids_##call)				\
>>  	BTF_ID(func,   __bpf_trace_##call)				\
>>  	BTF_ID(struct, trace_event_raw_##call)
> 
> [Severity: Medium]
> Does changing this to BTF_ID_LIST() introduce significant BSS memory bloat
> when CONFIG_DEBUG_INFO_BTF is disabled?
> 
> When CONFIG_DEBUG_INFO_BTF is disabled, the fallback for BTF_ID_LIST is
> defined as:
> 
> include/linux/btf_ids.h:
> #define BTF_ID_LIST(name) static u32 __maybe_unused name[128];
> 
> BTF_ID_LIST_GLOBAL(..., 2) only allocated 2 elements (8 bytes), but this
> fallback statically allocates a 128-element u32 array (512 bytes) per
> instance.
> 
> Because _TRACE_BTF_IDS_DECLARE is instantiated via DECLARE_EVENT_CLASS for
> over a thousand trace event classes across the kernel, this seems to silently
> add roughly 750 KB of wasted BSS memory.
> 
I'll follow up on this

