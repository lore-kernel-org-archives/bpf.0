Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6713C988B
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986227; cv=none; b=gPZWIr2nynSnzMlKZEGUp2fBM3akmgSy3BfBZ0m1cDCwKi73o1g+t2WxuiBc0GURB6UvMzOSfsCmCbB5izRkGqGGlywd0AJaulbd56qr+BQfBFISgILL+2Yoy3hEKRSyCl8nNKGpIiX3GOWujlQaxamNXa6XhG1EULUPhJO4ITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986227; c=relaxed/simple;
	bh=ugZmgQ8XAn3OJeZrOubNuz4HknqVoRWFV6S+16WHLwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEf6tccSJPPLsOb0Dw8NcMjFCzfdBncoifZOR++KCsHiVJiXdxDNYNwCfTGuZZ2F4K9aBU4QRzG/h3eO+UaBr2cdhiZhNvEQJD2hdb3YnGmrGy9l4kg+XcgeHiHRDpZkmFR5EqhJEP2gj7SpPde2VS9zPIVjaSQrNj8a2fFFb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cv5/ReFA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cv5/ReFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VKIoNeOHmxqfnaL3ByUNJQGzN9XnI+AngKP83cI9Xt0=;
	b=Cv5/ReFAW7Y3Wxexu6iCVVOq0y2J29g9fGuEuMO7XcH9ZzHZWV3RXvL9zuvYMu
	AvDpFBbIXBmXpuTD7MKQosvVr8MMNqst3ZRXYdxbuMR1txCFrWUD8wTIaIxugFXd
	pGysXCLcaV4HuTGv7OLMCgX9uwhQbjDv32Xn4YIaQfink=
Message-ID: <c29d5338-ad68-4e0a-8cf6-4ae099fb633c@163.com>
Date: Mon, 21 Sep 2026 18:22:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix task work round ownership during
 cancellation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org
References: <20260918080014.54012-1-luyun_611@163.com>
 <20260918080014.54012-2-luyun_611@163.com>
 <DLIMVC4MY6XT.22U1NMBVLDVM@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DLIMVC4MY6XT.22U1NMBVLDVM@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vy6DBbFq+ODnBw--.42988S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1fAFW8trW5AF4fZw4fXwb_yoW8JFy3pF
	sIva15GrZ8JryIq3W293W8Cr9akFnayF15Cr15Xa43JrZxtF12ya4rKFyY9F15ArWktF15
	Zw4qvF97Xr95X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYjgxUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxARpOGqxBYRJXgAA3c


在 2026/9/19 01:54, Alexei Starovoitov 写道:
> On Fri Sep 18, 2026 at 8:00 AM UTC, Yun Lu wrote:
>>   struct bpf_task_work_ctx {
>>   	enum bpf_task_work_state state;
>>   	refcount_t refcnt;
>> +	/*
>> +	 * References to task/prog/work in the current scheduling round.  The
>> +	 * STANDBY -> PENDING transition serializes initialization from zero.
>> +	 */
>> +	refcount_t round_refs;
>>   	struct callback_head work;
>>   	struct irq_work irq_work;
>> +	struct irq_work cancel_irq_work;
>> +	struct irq_work destroy_irq_work;
> This is overkill. Find a different way to fix it.


Hi, Alexei

Thanks for reviewing, this has been dropped in v2.

Instead of the extra refcount and irq_work objects, v2 adds a
completion edge: the callback claims RUNNING and waits for the
scheduling irq_work invocation with irq_work_sync() before it resets
task/prog or publishes STANDBY.  One temporary reference from the
existing ctx refcount covers the window where the callback bails out
on FREED before the handler's cancellation attempt, and a BUSY check
in acquire covers the add-failure path.  No fields or states are added
to the context, and the cancel/destroy paths are unchanged.

v2: https://lore.kernel.org/all/20260921101453.69273-2-luyun_611@163.com/


---

Thanks,

Yun Lu



>
> pw-bot: cr

