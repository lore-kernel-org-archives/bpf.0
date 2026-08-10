Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571E3DDDB1;
	Mon, 10 Aug 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367080; cv=none; b=c5Y+4KeDCrRXrGzbKk6b5P+stwpez0BJCLx7+7iIBtw+7XKWFNaWcD1HaOQzSoGu2JNc+z3YPAz7f5D3izpJT+0zlLYLF5OOqyCpQ5qp58FVJQrzCiDWy+Y2okyHTWgCShMofm/MlYjsCPaWv5ja7X15X5JyUoKUW5lnShMhA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367080; c=relaxed/simple;
	bh=hlXJomjLgBXp0Ul7Z1Job3/bOI0RHCPuj7WyA5oymnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4O8JMN+1+q8b2lmuIgarFhx9bcb/71WUiJDEiX+EeWS19TSJRwTGPSVWdiOSuBmbHloNxlWgndVkW8PFKGTzLpAT4tjLFs4RPWcsg0UR7+MIiesyqShFNsqjp3gPmcg4jcx+8zZ+v77WVV+79/fMf2oLfy3U9zk8Po6WusuB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vTbMpWMY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vTbMpWMY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D80F41477;
	Mon, 10 Aug 2026 06:04:30 -0700 (PDT)
Received: from [10.1.34.163] (e121487-lin.cambridge.arm.com [10.1.34.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351C93F632;
	Mon, 10 Aug 2026 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786367074; bh=hlXJomjLgBXp0Ul7Z1Job3/bOI0RHCPuj7WyA5oymnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vTbMpWMYAlu1DOrMZXzzJmdoxgfgdTRRrk7V2ZRJq8vKD5PqjeUrNU7umCA44YSp1
	 CJFqn1/65rrwYMEbAZrpeC/KF0mYp6G6z9ydg7gwt+mMMZ8zAQnutoTOBj6ZOVXXD3
	 b2HeKsmZEXfHoBDuVnPMGN0K82GgS7tqsl0c1Kf4=
Message-ID: <3e5f1532-ea17-4994-8cd0-5ce1d42e9049@arm.com>
Date: Mon, 10 Aug 2026 14:04:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Jinjie Ruan <ruanjinjie@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <0c47125b-6a5e-41c9-b31c-d78643cbe6bd@arm.com>
 <7b16d183-86d5-481e-b212-977ad0598ac7@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <7b16d183-86d5-481e-b212-977ad0598ac7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 13:44, Jinjie Ruan wrote:
>> Agreed on the need for a clearer explanation.
>>
>> Perhaps local_irq_disable() isn't the right API here, and we should
>> use local_daif_restore(DAIF_PROCCTX_NOIRQ) instead?
> The local_irq_disable() here is pair with the local_irq_enable() in
> preempt_schedule_irq(). So I think it is not correct to replace them
> separately.
> 
> The pseudo NMI does not consider how to do local_irq_disable() /enable()
> when the interrupt is masked by the DAIF.I bit as I reported before.

Unless I missed anything local_daif_restore(DAIF_PROCCTX_NOIRQ) would
clear DAIF.{IF} and set PMR to GIC_PRIO_IRQOFF which is the state we
expect from local_irq_disable() so we can do local_irq_{en,dis}able()
later on.

Cheers
Vladimir
