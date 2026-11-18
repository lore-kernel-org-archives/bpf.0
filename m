Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994007;
	b=kpjSJN/rcJdE7dPrDazzThzHLev7IGs0tuNf7JO2Stj5Zi0xo/KoAhcBYjYEouboOiBY
	 DhYN/FtmSXPPx5QJzIRvPBn1567dOWePbpyFpwzw0vVUjT7kuhnUj47x//K7duA1GdCnl
	 dLS7TFfEYr9tg0K7Y36sofv5C7ig0MVklWup7GIQQFMbiNBg1FoYfYSQrsVeNG6wAAHzs
	 bmCRc0CDJrWXLrRaEmeBgy8lL+uSYTIsMSJ1b04EeQNabnrQhu4q4rZ2rNg+r8zvsRJhc
	 FdNyy7FljiXqGHASwN2hNCJ6M5gnS/779+oFspBnXHCSPXJeFd816StfEE/3GtnZxTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994007;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YyTnj21z1o7e2B9mOs4PYUHbERAya5hpvioQJuyfVS0=;
	b=Jqwo4F/QxOGDGZgrXCR3EOWPjhWV8ApZfuApOVEZTslybATxGukfO6HoXbyHl1htn3PC
	 vbQvn0ID0MKHDAe1uPH4esK4vPmkGu4IdvYo1G5jc/T9kjXIVi8Cnbune++MKY+RpWpTX
	 aqh3LDjK7lcuQmL7CJaYXQJ37tLPT5zVFS5TaPW2iVLRBmgr433v48KXuxUK50zPKlIR+
	 qMZ5YcUa+FE0SVda/4gPfuYC+ja7UHzOx0BOigtUc2CUNhE2os8aDO0YIpcV43YYh0guY
	 KNmt3GJRgEB/ugTsmE3x+6VkXXM5+Z/Csi0TM5H+Av2m38KbNSNTSP5+j95c7OjnLgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="b/M8ZsTX";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37167606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 09:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37167606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b/M8ZsTX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5838F1596;
	Wed, 18 Nov 2026 01:26:42 -0800 (PST)
Received: from [10.57.91.192] (unknown [10.57.91.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEFBA3F673;
	Wed, 18 Nov 2026 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794994005; bh=N1QB5zcQkhEUye/mlGIOnn4jhu5njvHRiwWIoEGXYEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b/M8ZsTXaSr+CoRWeIGkYmAwCHHfj9AomXN+jaqHtIRFtSUX3mYfCGV3j7waYyb7S
	 afl2wpimOTXVQ6t9vcpBgLPUPTnvVk98pYEiQUbimyrjLL8v1OEX/qRu2h4SXgrJVn
	 5b4nZz2bRMYnQ1qB8L0NFQCMQ2B5PtjV4GvWumRE=
Message-ID: <66972dce-b645-4083-bae4-dc8109ff5fe2@arm.com>
Date: Wed, 18 Nov 2026 09:26:42 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <sashiko-outbox-219240@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <sashiko-outbox-219240@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 17:34, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: non-standard multi-line comment style in ___bpf_prog_run()
> --
> 
> commit ac6a06b7dc1000d82907323434c2003bed5a8873
> Author: Ryan Roberts <ryan.roberts@arm.com>
> 
> arm64: Mitigate Spectre v1 in the BPF interpreter
> 
> This commit renames spec_bar() to barrier_nospec() on arm64 so that the BPF
> interpreter emits a speculation barrier for BPF_NOSPEC, while avoiding
> unnecessary barriers in uaccess paths where user pointers are already masked.
> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index fc8b133c15f90..adf7ba0cdb06c 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2251,14 +2251,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>>  	/* ST, STX and LDX*/
>>  	ST_NOSPEC:
>>  		/* Speculation barrier for mitigating Speculative Store Bypass,
>> -		 * Bounds-Check Bypass and Type Confusion. In case of arm64, we
>> -		 * rely on the firmware mitigation as controlled via the ssbd
>> -		 * kernel parameter. Whenever the mitigation is enabled, it
>> -		 * works for all of the kernel code with no need to provide any
>> -		 * additional instructions here. In case of x86, we use 'lfence'
>> -		 * insn for mitigation. We reuse preexisting logic from Spectre
>> -		 * v1 mitigation that happens to produce the required code on
>> -		 * x86 for v4 as well.
>> +		 * Bounds-Check Bypass and Type Confusion.
>>  		 */
> 
> [Severity: Low]
> This isn't a bug, but BPF code uses the multi-line comment style where the
> opening /* goes on its own line with the comment text starting on the next
> line.

All other multi-line comments in this file use this more compact style; I was
trying to be consistent.

Thanks,
Ryan

