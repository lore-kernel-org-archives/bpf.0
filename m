Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6C3E638E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051179; cv=none; b=A7l1NLDaIerq+/PzojDoyWzkKRwg3YVaNedc37zwDwgNI9Yhr5Qy90Srz/Ke12Fz9Npap6w7bJv0+Ew584Efc8z6GfmzJrUcAN4fRMknlykPhtliT7cb6sQLyJZMnSUUWgI9EpB/NqttIJQpwBndiwU3jXbnZpCtWCIvI5IGJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051179; c=relaxed/simple;
	bh=9b10dlFjvNk33TCmTExHzq2OsqSKoO+OsBZ2Mojr4pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zdr05AdymemgjjBszhBnRTIQmDFKT1p4rEV+hvgHnamNIG2D1MNlZIpZoBOOZohGmml9w58+26jI7/8kz6MvArYGooIFEOISGxB4cofbJYoBo5pnMN4qFJffsywsdZPfbm6jVb3qQ/UKLVrv+VpPzM0lsl1BrAxKkWBqXukIAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IBNRg1lt; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IBNRg1lt"
Message-ID: <92eff547-55fc-4c67-a092-440d8387925f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786051172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esC8fbhFUXZLhNn5bUID8abZpPEVw3e3vvZlJ46Pxyw=;
	b=IBNRg1ltNhDQ5c5PoMZ1NvosCc8Ph2ig5aQ8qdYNi8UV6x5xDtjwqubYA4+b1E2C4cXDPM
	hiGPNLowdkpXSqu2mp172HoOdO0fSe1cpneUDZGQEKW4I/8V0n3/+iNzdeyifgChBrgwYF
	ZfR2xbez2Gma9ImRV85utrv4LQi0znE=
Date: Thu, 6 Aug 2026 14:19:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF
 annotation emission
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-7-ihor.solodrai@linux.dev>
 <b695bed46f03b4cc1a819bcd0d63272923ba5ca3.camel@gmail.com>
 <f9b8c8b1-906e-458b-b779-faacb2dee66c@linux.dev>
 <7190f11283c2b3727b0e1242c9bcd7db6db4e7a6.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <7190f11283c2b3727b0e1242c9bcd7db6db4e7a6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 2:17 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-06 at 14:06 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>>>> @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
>>>>  else
>>>>  
>>>>  # Switch to using --btf_features for v1.26 and later.
>>>> +#
>>>> +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
>>>> +# address_space(1) type attribute) are emitted by resolve_btfids, not pahole.
>>>
>>> What's the point of this comment?
>>
>> The point is to inform the reader "where did decl_tag_kfuncs go?".
>> Question is whether the git log will be enough, or is a comment
>> also appropriate?
> 
> I don't think we don't do this usually. E.g. it would be a first such
> comment in this makefile. Also, the comment looks suspiciously like
> something Claude inserts :)

It was written by Claude, that is true.

I removed many generated comments, AIs *love* comments.
But this wasn't one of them.

Will clean up.

> 
>>>
>>>>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>>>>  
>>>>  pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
>>>
>>> ...

