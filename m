Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65585346E57
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803114; cv=none; b=Yar+86deotYstRtaXOTjsuRwNRr8lTWhgx/RqMN6QBkROhy2Ef/xYmJdjU2jeyHYltafXQu9YVB7OyiRC1glhaogoz+qFE7Wlot20a0VI9zR8bN2498eYxPoVaAfeU2I4Tc8uNNeOVGBi7AwWnEH+S796Y/XxOOhs7gs58c+qV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803114; c=relaxed/simple;
	bh=Jz0A5qydOVFbTKVNouEcyrwig+LXMvAFbkgXcxps4R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG7SuJIUxhuLOqaWoLfRKMZTuUaOrDAIzR4rkXzBIYDTmYqV7eoadTbzvL1/EW5n37mTgEZxyXeGemZlPg4K1ezMu/gUWnRWbmNC1o/uhCJIwAdQWD7L5R4AECglxGYXlkUdmJtYE+Pt1yqYvUScaSD3QQgZLDFRHzrGjtMJDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SU8840Rz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SU8840Rz"
Message-ID: <a753dae1-6a4f-404c-aef5-e28cfc708f31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781803110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWkfRD+XeftsrUohEka8Qfm4BXzhYJhM5vZADskByts=;
	b=SU8840RzLeBS8Q/DBx3KukJBcT/5HoeBh3fF/BD6ewucdApKigWQQDKZLN+b1ylXxDehzn
	35VCPs1o+vsD0XIRla3T4xB9aUBX5V9HDkcR4oaP6z2i07mYebTc81QV6JpQPloS1UYhCM
	eydaZUF1jeekuY20E9RcNqyXb5OfPq0=
Date: Thu, 18 Jun 2026 10:18:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v5 1/5] btf_loader: Handle decl tag component_idx for
 parameters
To: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>, Yonghong Song <yonghong.song@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-2-vineet.gupta@linux.dev>
 <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>
 <92447e74-7578-47cb-a08e-f6ca8a9e9274@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <92447e74-7578-47cb-a08e-f6ca8a9e9274@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 7:38 AM, Alan Maguire wrote:
> On 18/06/2026 05:46, Emil Tsalapatis wrote:
>> On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
>>> From: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> A BTF_KIND_DECL_TAG with a non-negative component_idx applies to a
>>> specific function parameter (or struct/union member), not to the
>>> function itself. btf_loader.c however attached every decl tag to the
>>> type named by btf_type->type, so parameter decl tags were recorded on
>>> the function rather than on the parameter, and pfunct never printed
>>> them with the parameter.
>>>
>>> Resolve a non-negative component_idx to the corresponding parameter via
>>> new helpers ftype__parameter()/function__parameter(), and attach the
>>> tag there. Teach the pretty printer to emit a parameter's attributes by
>>> factoring the function-level attribute loop into tag__attributes_fprintf()
>>> and calling it from ftype__fprintf_parms() for each parameter.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> With one nit:
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> (Also feel free to keep the tags for the other 3 patches since the
>> changes are minimal).
>>
>> </SNIP>
>>
>>> +	if (component_idx >= 0) {
>>> +		struct tag *func_tag = cu__function(cu, tp->type);
>>> +
>>> +		if (func_tag != NULL) {
>>> +			tag = function__parameter(tag__function(func_tag), cu,
>>> +						  component_idx);
>>> +			if (tag == NULL) {
>>> +				fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
>>> +					component_idx, tp->type);
>>> +				return 0;
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	if (tag == NULL && component_idx < 0)
>>>   		tag = cu__function(cu, tp->type);
>> Nit, I think this can be simplified as follows:
>>
>> tag = cu__function(cu, tp->type);
>> if (component_idx >= 0 && tag != NULL) {
>> 	tag = function__parameter(tag__function(tag), cu, component_idx);
>> 	if (tag == NULL) {
>> 		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
>> 			component_idx, tp->type);
>> 		return 0;
>> 	}
>> }
>>
>> <SNIP>
> yep, that looks good to me. if there are no other issues arising from this
> round and Vineet is happy with that change I can roll it in when landing this
> to save having to roll a v6.

Cool, works for me and and indeed it will be nice to avoid a v6 :-)

Thx,
-Vineet

>
> One other issue; we need to install bpftool for CI. I'm working on a change to
> support this (installing the version from the kernel tree), I'll try and get
> this in place ASAP. Thanks!

