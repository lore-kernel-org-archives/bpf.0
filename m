Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4792F1FED
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898424; cv=none; b=ak5S7wmcYlxgEaII6mCN5bg6+B3nvnSsHkk0tZD+v59zsM/+kQd4BhvgxUeL2YU2XrV3vMJx2NuWKh+UEWX7GYF2I48Kuw66im4t9PiVoCciFpyfDB5teIpyz50dqmWqbm5qA8U2ZuT693Yr2sJO19dSXjtJFTm8Bd0xIVFAZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898424; c=relaxed/simple;
	bh=Fv73DWWEbY5FpauGyAMv3BujrLYidcDhnx2I6ymceZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFj3wOHrSlq23TtHiw5GCKSCIJmIa/iHswdLS+PjYZ5CZEb3D87eeJ7vKRDVfo9Xpw9NE8t0ymK40/eDXuVz+Yax5EPuMnZPioPARLbkhE7EP44AOuieYV95y4SSZt/ZDokqnE0qScaey1g7gRf0jcK1LX+DA72lDYixY6NYBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjsycvxz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjsycvxz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954aff6088so3596825e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784898421; x=1785503221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXnv9/z+LNl1XWtrsS23s1yZODaIPCU4+Rpt5aY9Xhs=;
        b=HjsycvxzGjaHuq6k75XV4ylP6i8iUewLaRMRVshV68jPrJ/mozaVReQqHFsm9IjRnr
         rtHrDN/RERCA9nQNSFUw52GDL7aMb/Hu3NtAIcARuqrbtf9BxPBtW4HDveII9brEJTwW
         DD6rLp4fZRgGRL/xgR7xon8Dvp7dstTsBj7rHGuO13UuHgPKzlAH3p4I2xqAxrFkswcr
         gtUMJzMHsgT0N+GCDI9mxHh9U29oZ88IVTb2mwIWC0eR4b6HWXvhtxlzLrJeiDVEs7+a
         ERMMzwxx8HxMXnm+cZO448faFthCBLwEQWBRdVdjY4FzVAcsq7o2CjBz7cs9mcVWyJ37
         SpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784898421; x=1785503221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXnv9/z+LNl1XWtrsS23s1yZODaIPCU4+Rpt5aY9Xhs=;
        b=IR53fxo68CAUUnclxaS8ZgaeRCoeAw1kUqMWvz+pYbKfivTyn3GUuN7tHzI6seuwQ3
         xOSk5e4L7vdh7ZrxfYnUZdhxMntsTSrBnjA5IVEYu8y1wdhuOKrI7j9PBFkZ3IgbkpbC
         5ALhyxSt+e8DZvP8DdUvwy11BmrraXaLDLm+/lbSgXq+iPd1DWfDwQn5kt5gNBtMB7Jn
         VPv3NPOKp5ZgMNHFmEYFv+VtZR1F7HcIBzAxSp+cgsf1PvxYloRciQpEUvKdWCUO6DnS
         /s9NG4WE6unBX/PG/IycFHRYvVkP03SiakeuwVGzT9c1Yz1HQqEBgjZy6HPEpQPyUDnR
         C5Qg==
X-Gm-Message-State: AOJu0Yxo7OrFQVy6kHCqW+n8faWOBwfURHyoKdxHTOXq/RMaSMaD4/oV
	RLzm98t6tr5UJZoSBD1gYJlXSEs6lzBJxKWOI5YiUblatrsBeoPmWNR1
X-Gm-Gg: AR+sD101vBfUK9gWk+dmbOF1xNMY55TGY4C5T2TNgZQhzlZ7Zj66t4aeVKoB6WeNo+0
	/4CnSANT0Xy6KumiLTaBDFR7+qBVSizxdtQs+HGT6ntZaVRr0FzfGrOOhl1i0rifCqvR2EhkX7/
	wPNh4SHrz6Um59v7xnreSnRIlwFlRLdfFOzOC3CNDjd5dMQ/4yROqc8sxrWSk8iHM2kewYiSMg2
	UBr2qw4sRwySfvRS6NIZYiawgolYRXusiNMBu9v3VQEwoZ+tLIaTt7F3bSNVGwqpbxkgZQGl7x2
	Pqa8uJ2YChA4E9fhLNkTMca1Tt4gfZV4A68SVWN4hbpZy/8QQCL/GsKKayMCnh1SxZiGHMmRNv6
	b/B/M5G89axKDY7wA8WWIKHV3vQvhTqzfRfozkMhvzN4yD/o72CYd3mPzs6MMcid/snbnRX4y4o
	wC2sHtinXoIxDOzPzw8u+2Gx5w/P5+MePo2lxnFZ3MqOBT/1xiB4gpDbnPzQFzSQ==
X-Received: by 2002:a05:600c:1c1b:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-49573c9af25mr90123835e9.13.1784898421244;
        Fri, 24 Jul 2026 06:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957afac187sm67659375e9.11.2026.07.24.06.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 06:07:00 -0700 (PDT)
Message-ID: <ee9e9748-c791-44a6-a1eb-b6973f304b1f@gmail.com>
Date: Fri, 24 Jul 2026 14:06:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 7/9] bpf: task work scheduling kfuncs
To: Heiko Carstens <hca@linux.ibm.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Maxim Khmelevskii <max@linux.ibm.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
 <20250923112404.668720-8-mykyta.yatsenko5@gmail.com>
 <20260724112221.212464A3f-hca@linux.ibm.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260724112221.212464A3f-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 12:22 PM, Heiko Carstens wrote:
> On Tue, Sep 23, 2025 at 12:24:02PM +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
>> program schedule task_work callbacks for a target task:
>>  * bpf_task_work_schedule_signal() - schedules with TWA_SIGNAL
>>  * bpf_task_work_schedule_resume() - schedules with TWA_RESUME
> 
> ...
> 
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  kernel/bpf/helpers.c | 292 ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 290 insertions(+), 2 deletions(-)
> 
> ...
> 
>> +static void bpf_task_work_callback(struct callback_head *cb)
>> +{
> ...
>> +	migrate_disable();
>> +	ctx->callback_fn(ctx->map, key, ctx->map_val);
>> +	migrate_enable();
> 
> The above indirect call results in a CFI failure - while trying to make kCFI
> work on s390, and running the bpf selftests I stumbled across this, which can
> also be reproduced on x86:
> 

Thanks for reporting, I'll take a look.

> [   29.357395] CFI failure at bpf_task_work_callback+0x168/0x280 (target: bpf_prog_8ce783214b8218cc_task_work_callback+0x0/0x50f; expected type: 0x37c2b4a2)
> [   29.360146] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   29.360960] CPU: 0 UID: 0 PID: 124 Comm: test_progs Tainted: G           OE       7.2.0-rc4-00365-g48a5a7ab8d6a-dirty #1 PREEMPT(full) 
> [   29.361698] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [   29.362027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
> [   29.362625] RIP: 0010:bpf_task_work_callback+0x168/0x280
> 
> The problem is that above callback_fn is of type
> 
> typedef int (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);
> 
> while in fact the indirectly called bpf subprogram has a function type of
> 
> typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
> 
> which doesn't match and which subsequently leads to the above crash when called.
> This can be reproduced with the following steps:
> 
> cd tools/testing/selftests/bpf/
> 
> Change vmtest.sh to make use of clang:
> 
> -       local make_command="make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \
> +       local make_command="make LLVM=1 ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \
> 
> Add CONFIG_CFI=y to config.x86_64 and then run
> 
> ./vmtest.sh -- ./test_progs -t task_work

