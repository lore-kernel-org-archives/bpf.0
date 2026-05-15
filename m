Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092B413D8D
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874846; cv=none; b=jP4+DEwX3/nPmMtdun3pEV8mavM89iUAwqVSVWtYllUo5PxCgOrrYFhNeYiAZVy7+725YBlisS47CKuG+ifDyrymKCsWJVfbAIRtzmjSVs7gYv66fpR0ZFDNZSMV/H6Pjk6xwPHg5005rRzL1EAeHCOkypURvLARs0F0SzlRaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874846; c=relaxed/simple;
	bh=9z5ofOW3zF4tIwOxw6MLgiE61uAc+fsPZsMYSZAw7cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO0mWhOgtnpMks5GOz/zS0AQM/HNgubABdAdhUUXiSXGs4QLLSPnyyidP+vpMl/KLv5Xie3InEXA4ExL1PXL2JjUJDs/mgR0ux0W6rP+7SVRBmeA5qygOvwD4dVrPXcOSttUcUoMI2FI6ims3kG4dOjJq4NwnQvLzTbV1hW+/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcGpT+Sm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcGpT+Sm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-444826c16ffso111107f8f.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874844; x=1779479644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+RFDSNSW3gsfyThVyv4mA2CxoP8ob3lZvZu86McAFU=;
        b=YcGpT+SmSzlby+vlId1CMX9jKhPlskl1i4s0YskIeYOH4gQ0jvq6WIQ1cmL/Z3rgVt
         x+/BQ88td7k5TKCfDPx3ALW+MhhH8V3MZiyStakSHaOz7I/AvxRrIEwWVCQh0v8YDOow
         BdUlrKiP4Tiw2YCF3wxWvj+mdVa1Wpo0wdON0IcsGxxyayygwfWWqbbmZSUBWUqmYWnY
         QFuJZVYDQq7gEiVVfWBTwagvuVgen43CEYUnpucZL0dhOsIqgp/8IgJeTTt2ewMb4L08
         FEkOOzO84mn+yVvgjE5q0tTa6+WzSpIoF6keeSJ05+eMPAXOkcFK2FgPcnJ7uJiUHNP2
         rlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874844; x=1779479644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+RFDSNSW3gsfyThVyv4mA2CxoP8ob3lZvZu86McAFU=;
        b=cuvD8fX38WztBLrtimQwvfsw0YatAPBvCqzc4BUbnqojRjW/neH4DxXTdM58WMXntf
         5x5sdOs3znH95JawfzSJI/QW4IsmfA9PGfVe1S6INQzKwD57NwYmuAubuRDnVCUQAob7
         oXDnPg8gKxS/8uu2xfS/Jtk3hQoR1MXQUxR8iAjFMGOVVq+HTFomGIy3xvyE3UGxgnGa
         p+tKbFt/v5+3CsB/y6CKZMHbQN5qDjkiQZUygAxfm0kzJX2jeJCGcK8ox2UmLxBpRwin
         enWP+1+AJvCWczqftozsMXuQsO4960JwfezFT+tVs1vOKRHYz8Zg9Y8MNK5uYhbkO7rm
         HDmQ==
X-Gm-Message-State: AOJu0YwGAHK1K6VtZZ19GQ0NAbvvX3TXx/YCKVVCQKRwm6JSfTDKoMoJ
	5Yqggql/F17LwPRi4eHC8P116kmesk5eqol/DTmys57lhh7QadahRevDtCdHgI4m
X-Gm-Gg: Acq92OG+k4FWmjqFh+Ib9df5VePMgFT/tAs2Q+oadJ+2uewrWw2AhmMuxF8rl4lT5kG
	Sy7gUIrnXOXi8hxpOP38rBWLM3ZEJ59yGnKmWFy9XE3cfpEU7CWlXh2Lq3fHC6bB71qqj+9r29A
	dx1FJ8yb7vAn5pL6eywGhEQhhWNdle7EIQ6UqZSvAEEZNulvy8OJX/7WC1TfrEDpJB4dfk+8C+v
	42OUlDSxtXeZOtdNOIIC6eF2aamXx8tWixmy3JhLHkGxSkqmNNDk3PFrE64A8YBt3ys3LIU5Jxv
	JK49uTxs9ANWz/PpuHqKxSZ2D8DKIWIt0a0KCaCfEkqA7FpyIChYL8vYBpNyV985QQKd/8fwde/
	/+HWhyYCm7+7eaikie5Lk9BQtVuo0v1eeR99MtlOKHo9cedAgwzh0Cc29zYWzWPhVOe1RbsctsR
	Q7kNVF4LGUQrfeBTCRgfM2YQtGsk49EvvZTEFDrlnMXosrpxsfPIjy3oIReofK89NmUswFvBUMs
	TdECy4yn8E6VRrjH6FVi/vg5uj/UfZy
X-Received: by 2002:a05:6000:1ace:b0:45d:3cbf:bdda with SMTP id ffacd0b85a97d-45e5c58d4ccmr7721860f8f.20.1778874843831;
        Fri, 15 May 2026 12:54:03 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm16989475f8f.34.2026.05.15.12.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 12:54:03 -0700 (PDT)
Message-ID: <b158bfbc-dfa7-4e87-bda0-430bab4b7538@gmail.com>
Date: Fri, 15 May 2026 20:54:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Export btf_get_module_btf() and
 btf_relocate_id()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260515-generic_tracepoint-v1-1-aa619fa94132@meta.com>
 <20260515175618.A4059C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260515175618.A4059C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 6:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] API Asymmetry and Resource Leak due to unexported btf_put()
> --
> 
> commit 51050bef777abcb3d2969804b1e3693feb10a170
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Export btf_get_module_btf() and btf_relocate_id()
> 
> This commit makes btf_get_module_btf() and btf_relocate_id() available outside
> kernel/bpf/btf.c by exporting them. This allows the tracing core to look up
> module BTF and translate split BTF ids.
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 77af44d8a3ad3..aa88d18247bda 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> @@ -8500,7 +8501,7 @@ struct module *btf_try_get_module(const struct btf *btf)
>>  /* Returns struct btf corresponding to the struct module.
>>   * This function can return NULL or ERR_PTR.
>>   */
>> -static struct btf *btf_get_module_btf(const struct module *module)
>> +struct btf *btf_get_module_btf(const struct module *module)
>>  {
> [ ... ]
>> @@ -8529,6 +8530,7 @@ static struct btf *btf_get_module_btf(const struct module *module)
>>  
>>  	return btf;
>>  }
>> +EXPORT_SYMBOL_GPL(btf_get_module_btf);
> 
> Because btf_get_module_btf() increments the reference count on the returned
> struct btf object using btf_get(), callers are required to release this
> reference by calling btf_put().
> 
> Since btf_put() is not exported, won't loadable modules using this new API
> fail to link or be forced to leak the struct btf reference?
> 
> Alternatively, if these functions are only meant for the tracing core, which
> is always built-in, are these EXPORT_SYMBOL_GPL declarations necessary?
> 

yes, I should drop EXPORT_SYMBOL_GPL, and move these function prototypes
to the header.
