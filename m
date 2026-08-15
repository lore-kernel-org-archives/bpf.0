Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008A3BB4A
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752094; cv=none; b=HlkokyIazdhNJ73+n077jCvvc9E3XjNe7vutJT7lRahnfJX/DwnNlzFB1G0Z3P0bSM59Ct9MMjFCEGSKFnKNrfmP16OgQ6sXPjXvjuVv+dZtfWNKTkHCOd23aiuYbz5z7RJGUNzTcD5G58m55MfvWyXj5UY41mTqHDKjcupLYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752094; c=relaxed/simple;
	bh=ajEtm7Cc9gbBg7ONgIlCKTKF9E+P1en9GcyNIOemgso=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VYgNVxLyYMGCeDiNHojUZIwWhtm1tQSDHT1Sj6zBGQjIXgsIKxsP0bTS3B+LdspoNYj1pR7bDBAdYj7TJ2qxrtZGoYmxZGvNoW7tS0CqPfPxZFC9jFaOP/V5KyiEcnw79t4oHoM9aVFic4kjX/llCZApK3qQYDV4XPearCO8/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mb28iZQw; arc=none smtp.client-ip=95.215.58.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mb28iZQw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ajEtm7Cc9gbBg7ONgIlCKTKF9E+P1en9GcyNIOemgso=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786752090; v=1; x=1787356890;
 b=mb28iZQw7+Pikc+Vm1b8zir3PTmYz80nHNc0AXqWFiZ376xFV6ZYvPuWObOftdA34MZdtY6x
 /a/JRv+4WdP+GTujwNlJHKnZqkCp9p21rnR+uhZpssbZs9QUoOH+lx/0P0fapN7GwAQPQBdwOoq
 CHfmQMTxUpOBh5iZ+1fhYo1w=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.1.116] (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 709e2110065d8f26;
	Sat, 15 Aug 2026 00:01:30 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d7e534e1-ab78-4c6e-ad0c-0cfeed5049e6@linux.dev>
Date: Sat, 15 Aug 2026 08:01:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, Tao Cui <cuitao@kylinos.cn>, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, mingo@redhat.com,
 peterz@infradead.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: don't BUG_ON a destroyed DSQ in
 process_deferred_reenq_users
To: Tejun Heo <tj@kernel.org>
References: <20260811075913.344033-1-cui.tao@linux.dev>
 <f3a7965cc9d6527de793fdda816b6b63@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <f3a7965cc9d6527de793fdda816b6b63@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/15 02:56, Tejun Heo 写道:
> Hello,
> 
> On Tue, Aug 11, 2026 at 03:59:12PM +0800, Tao Cui wrote:
>> -		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
>> +		/* destroy_dsq() may race and invalidate @dsq; skip */
>> +		if (unlikely(dsq->id & SCX_DSQ_FLAG_BUILTIN))
>> +			continue;
> 
> Nice catch, but this also swallows states which can never occur
> legitimately. The only builtin-flagged value that can show up here is
> SCX_DSQ_INVALID from destroy_dsq(). Let's keep the BUG_ON for everything
> else:
> 
> 	/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
> 	if (unlikely(dsq->id == SCX_DSQ_INVALID))
> 		continue;
> 
> 	BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
> 
> Can you please spin v2? Also, please capitalize the subject after the
> prefix ("Don't ...") and remove the blank line between the tags.
> 
Right, that was too broad. v2 skips only SCX_DSQ_INVALID and keeps the BUG_ON otherwise, as you suggested. Also fixed the subject capitalization and the blank line between the tags.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

