Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E17455173
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327840; cv=none; b=AaManAJb3C+gzX0e20GToOEr6RPjMJzAzAaSkpLlXOWHDGHrc/P7p1FPlKFFZpYYS4q1JVFC4YLsuClmffDwKzev6kTKYwmYpKvoCbSfqsZGcClD3XrOQBHI0xc/t4yMsEasMG36bll9EjU8dT3OlhRj/8BdriZOn/QDTyp9Irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327840; c=relaxed/simple;
	bh=APreP2O6tYmZ0sgnofROIYS7faftnQh6nQ7b0OujIjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsXzj0kKRYbP5acjxC7VJUYycSO1JjhwuLZKnSqBXQAxegHEqecMfwB0oBRZqRz8sMsmAuDTqLh7g4wrwup14iQ5Sgp+oEArzkOnFfzxdHEit/f2bUSw7IzFi3FrsdJwhajjjAhRtO0FEXleXRofrGq0iXlJrh7jG8VCk+1xl/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K8bx1wRg; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K8bx1wRg"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f6cf16bso229421f8f.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790327837; x=1790932637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nnmbgx42B2WKMVnWZdimnYHvUD+KfWZiyEk99BwL/To=;
        b=K8bx1wRgFrG9JKkNzfaJDBH+IzlCkE/ysxF3AaKBrzK+U5qFmqB12KamMjuou/W81k
         Iq/th3bAa2fdxJSyP4iS17GbO0wXaSwOY0cfZ5SyXpPykzfa1OnKNSu8Gg3vdwat3fhe
         /XC7rClw084h2P74mKMnCoAl7uKIQ8nsoNp4fyAVB8nz9HUEY617baBLc8m+/vV9ckct
         Z9TgkDMJf39kQTeY9lR9WDjAxTcEqtdeF+ZaVZjmmqYDvzG0UXfUZ9a4NOlXU9v5FCGx
         D5+ncYJ8RWkQGwvEJiMhiQWNbw7exbTSfa/i5LDdr0D0A20Pmt8HCzsQQUZ9doVuU0G/
         QJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327837; x=1790932637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nnmbgx42B2WKMVnWZdimnYHvUD+KfWZiyEk99BwL/To=;
        b=VBAxcVs+tyHOJD3REuyV5uWfo6jZgTihZ5MJEw8actL1C/k7m9W7os8KQyEp693a/R
         OJfEXLzIp2s7Gx37EamdeJlZrjMa9O/tzu1RfOqsJabjLq/XU8RKcUX2nb967c3V5BJw
         iqsGfcsDptEEFPWZRK1bvs5ONsPYGBt9iBuXZuukkrM4hGSKj0RfxRypbDqVOIn8zyCd
         INv1cnqoapvngdxLYYnA5pRUlSfIkbtcdH8C2/7rXYbn5e20SaClj6Wfnk6UByq4yr7q
         BJXmsl6KuMtflwHzsjNBa1mmUnJKfQLg8RRmLiqcjdkXOcuCX23qHxsbwblS2xW7W9No
         U/sg==
X-Forwarded-Encrypted: i=1; AKwUvBwd81tflFdk2oRps0TenAxk3zE4sheNs32HTVBoMGs20gsWYSTDuWsCfGzptrjGAoeEsCM=@vger.kernel.org
X-Gm-Message-State: AFuF++kJqE72T4ERB46QQ1/IvnJx/Qg3uerd5yyHrZEPUcV0E5NThoU0
	oRGrj4A0mzsE7C/43/F4jD5UAme/7cPZGVgLgQMGjMg2G69MHoVGZTCJl9bdTFvGJhE=
X-Gm-Gg: AYBFou0E50+G4Jw2K4uO5u1XNRMXD2W1FKA7nmQNvyWF3b2Y7mJP+v3ScOVsJZdrMsq
	i/PUmy/Mp9GwOl3vk363n+JmWqRU0yL1wZsBWOih3TFgqCNH0xYczCJ55KiBI4jratZeAV3ukAg
	QHC24fAMhJwS2DrIPxlWCADnftXb3rp9hjeCjeZkyIAgic3eeTVWm3O3ydubeeFpEJHUF/ScZx0
	49YmOn/5gkC4bVekh6Lr4YQ4SlTo4VCMRcCtYPImiCJuR+fP8ZetR++Hg9baxmq8ZQ4TLqfGR1a
	V3pXyHL1bFCl4x10YKJg4ohBSOTaUna8HyQCBpWiaDWaVlPkMJ3Zjqzo1IXR8EUB6WrpPV3Lf11
	bgjPFg83HD8QwwJuL+OE6VUMtG1jLAe9PiHw5RvufAF2wKxgytvcmEmc5eBZXWlO7NudPST2A1e
	hnzH9NkpnZA1+qwMYWYBzOYOodWiNzzRYnAiaavtQALkJ8U3gmxt9Juht9jzCrVPXksDaFekrVu
	71+O9ZCCHvLfLD/ovP1NI1WKijheBNV91M=
X-Received: by 2002:a5d:5d88:0:b0:487:c43:e577 with SMTP id ffacd0b85a97d-4887db0b3acmr2954651f8f.24.1790327837078;
        Fri, 25 Sep 2026 02:17:17 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64f9bcsm5496772f8f.32.2026.09.25.02.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:17:16 -0700 (PDT)
Message-ID: <2452a9dc-4622-4de5-b58a-ea9e0a911387@suse.com>
Date: Fri, 25 Sep 2026 11:17:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Add stubs.c for CONFIG_MODULES=n
 module_put_and_kthread_exit()
To: bot+bpf-ci@kernel.org
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 ast@kernel.org, daniel@iogearbox.net, atomlin@atomlin.com,
 john.fastabend@gmail.com, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260922-module-stubs-v1-1-abe465a24879@suse.com>
 <ee510141f44725527b6a2f60cae4323f26ecde36d3a592ba997648de45c80134@mail.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ee510141f44725527b6a2f60cae4323f26ecde36d3a592ba997648de45c80134@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 4:16 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/module/stubs.c b/kernel/module/stubs.c
>> new file mode 100644
>> index 0000000000000..81e66c02260c8
>> --- /dev/null
>> +++ b/kernel/module/stubs.c
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +#include <linux/kthread.h>
>> +#include <linux/module.h>
>> +#include "internal.h"
> 
> This isn't a bug, but does stubs.c need "internal.h" here, or would
> <linux/kthread.h> plus <linux/module.h> be enough?
> 
> kthread_exit() comes from <linux/kthread.h>, and struct module,
> __noreturn, and EXPORT_SYMBOL come from <linux/module.h>. The file
> doesn't appear to use anything that internal.h provides.
> 
> This makes stubs.c the only consumer of that header outside
> CONFIG_MODULES=y, which future internal.h changes would have to keep
> working.

Ack.

> 
>> +
>> +void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
>> +{
>> +	kthread_exit(code);
>> +}
>> +EXPORT_SYMBOL(__module_put_and_kthread_exit);
> 
> This isn't a bug, but since stubs.o only exists for CONFIG_MODULES=n, is
> the EXPORT_SYMBOL() reachable by any module, or can it be dropped?
> 
> No loadable module can resolve this export when CONFIG_MODULES=n. The
> macro still expands (producing an .export_symbol entry that
> COMMON_DISCARDS drops at link, plus __ADDRESSABLE()), so it's harmless
> but has no consumer.
> 
> kernel/time/posix-stubs.c, cited in the commit message as the model,
> exports nothing.

Ack.

I'll incorporate these two suggested cleanups in v2.

-- Petr
