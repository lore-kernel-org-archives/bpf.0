Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962E2E7394
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712081; cv=none; b=EeWsXtIBaea4EKuqslimceF4Gzg8rRv4YgWS4a7pbLe/yyIuddUyvKUO9FUofGqGXo7k2QcHnGWwDtfSjeP3jGkjmgRE0TU8VrxZPNFJz0L6yGXji9/Q1h+z+0OcHd70thlbL76U5F6Xg37qDL0ZE4HZ24WEWDQcO/9WssiGsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712081; c=relaxed/simple;
	bh=Y6+nf4pYiD66IQwC5MVJ3wtSCsQcpZkmSRvDQF+Qy34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC12syUL3ARMbJ/xkmHle2JWppO6gViZznNkh07K8HG8lcoQuiRMw47btPGEu3D3+sYC3kcRFWKTBSazPjeANiRTFMgacKHnj9a8jT1tBnm8MV9hZ761Rcz81FuLTn+rWHTasQV8wB3tP7XmLv1LzoVo3q7mvMSeptMdlX41P6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wU43qsrA; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wU43qsrA"
Message-ID: <96c07e3a-88f5-4929-aa53-0efb2c2bb0cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783712077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKPDYV6Qi1oG4WEUcHIvfux3VXMOK/Ne754E4CrT+nU=;
	b=wU43qsrA7h3/ElGTL4bNCm5CjFt/YFmNgGzE7Ya1xn2PouyPgLaded6LeK5e5YZvOMls+O
	G556clgmGS0bk7pNgi4QTxlPzR2jVc30E6xLsS3I3zGBTGx5yNCjgjGjeCGfJfBlnicJ7i
	QuKjkwtDA/C4AXBYxZx+9T7TuJWWOAg=
Date: Fri, 10 Jul 2026 12:34:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit args
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
 <20260710012112.577F31F000E9@smtp.kernel.org>
 <ce047740-79fe-4fc5-a118-40252b169be8@linux.dev>
 <DJV2D826YVRY.WSTQ4Z6CFX1I@gmail.com>
 <7a5bb678-4fab-44c8-98b5-272124e08847@linux.dev>
 <DJV2Q54OF8BU.1H6KXCS93P3N6@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DJV2Q54OF8BU.1H6KXCS93P3N6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 10:40 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri Jul 10, 2026 at 7:34 PM CEST, Ihor Solodrai wrote:
>> On 7/10/26 10:23 AM, Kumar Kartikeya Dwivedi wrote:
>>> [...]
>>>
>>> Also, why not do it for BPF_TRACE_ITER case as well? I just feel keeping it
>>> consistent may outweigh figuring out whether it's necessary in that case or not,
>>> etc.
>>
>>
>> I mentioned this in the patch description:
>>
>>   The BPF_TRACE_ITER case distills a registered iterator's
>>   prototype, and bpf_struct_ops_desc_init() distills the
>>   function-pointer members of a struct_ops type. Neither is
>>   a kfunc, and so can't have implicit arguments.
>>
> 
> Yeah, I saw that, but abstracting that inside the function and not having to
> think from the caller about those details would be better. That said, I don't
> have any strong preference, it is obviously correct as it is.

Let's keep the fix patch minimal. I think we can do a more thoughtful
refactoring as a follow up for bpf-next. Hopefully I'll find time for
this in not so distant future.

Just sent a v2 with a module ref fix and a brief cover.

> 
>>
>>>
>>> Please supply a cover letter in the next version too since you're sending
>>> multiple patches.
>>
>> I used the first patch's message as a cover letter, since it's
>> just a fix + selftest pair.
>>
>> The series could be split further into refactoring changes, but I thought
>> it'll be easier to backport if the fix is in a single self-contained patch.
>>
>> I think we want the fix to get into 7.2, and backport it to 7.1.
>>
>> If it's ok to carry separate refactoring patches there, then I'll split.
>> Kartikeya, wdyt?
>>
> 
> You can still keep the patches as is, but just add a cover letter, it will not
> affect backporting. The cover letter is just to summarize the series and the fix
> in the merge commit. Also, my understanding is that with the Fixes: tag, it
> should automatically be picked up for stable kernels.

