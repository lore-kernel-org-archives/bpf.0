Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE443EC2CD
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288674; cv=none; b=G+ifa6Pu89jMFbUybg7epys4BCfZyZA7NDgnN3wVl7Jl4uQkt+eWp0EztDZIN65uCu5zq/7rSp/FZHfou0u/EEgDRRFYBpbmAuakXFYNtsOT7QvJW5jV2KXJ+DOlhaRYoji4/9Yl2I0Qc9tWSqLmF2CupFLkofIzA1bsEOG2dQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288674; c=relaxed/simple;
	bh=xA8nl3WIvelT4GgHPutJiU5tZzAJ5oSb/5Ox9J6M5uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ylza0NO6V1tePiY4YDx0BTccKigzi2SJX21eBDYiOlguHMryHHQwUqBV6euF4ljez3cn2qpbTQZuXTC901s6QGILgTq7/vB7omcoIOzcKudAnW4uZNwlKO/k2Ii+U6/ldLVB00f/TggyCzG2YwDHvk6g5Dsq6DV40qxLuiiPrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBPCQ3E2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBPCQ3E2"
Message-ID: <a07b3d7f-7fda-4c9a-831d-447e4696ddfe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779288670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9CLDhbm9oDeWEsa8Ha8dA9Z3pyAwxFTicIZRmk7Wj4=;
	b=CBPCQ3E2rxga4gdXkZ3NugK2zzoyhEu4plNALcs1TIKV3ObYIYmH5Sv+WTvQ9bXIsCXU86
	h5ZVoHCTNOFgUxPlzqBedwjYEVJeo4sj9sj/01Fkg+8jU4kNvYUybYgjF+FgXDJsvwVcMF
	HUjJJXHYibBSQ1X6TT/OlJ+KEV/2QlE=
Date: Wed, 20 May 2026 22:51:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in
 map_create()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260518145446.6794-1-leon.hwang@linux.dev>
 <20260518145446.6794-3-leon.hwang@linux.dev>
 <261a47f4-a92b-4a61-86ca-c1de362be105@gmail.com>
 <5660e657-f2a5-4866-9881-c705bff0c970@linux.dev>
 <c0fb85f0-38f2-4f31-81a1-6650359752e9@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c0fb85f0-38f2-4f31-81a1-6650359752e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/19 23:15, Mykyta Yatsenko wrote:
> 
> 
> On 5/19/26 3:47 AM, Leon Hwang wrote:
>> On 19/5/26 00:43, Mykyta Yatsenko wrote:
>>>
>>>
>>> On 5/18/26 3:54 PM, Leon Hwang wrote:
>>
>>> If map_crate() failed with error code and then log finalization failed, do we really
>>> want to override error code? It sounds like map_create error is more important.
>>>
>>
>> In that case, there are two error codes that should be returned to user
>> space. How to achieve it?
>>
>> Since we should not ignore any error code of them, can we report the
>> error code of __map_create() failure by adding an error attr to struct
>> bpf_common_attr? Hmm, seems not a good idea.
>>
>> Any idea?
> 
> I think we should do what Alexei suggests.
> 
> For example: we return ENOSPC when log is too short, regardless
> of the status of the operation for BPF_PROG_LOAD (see bpf_object_load_prog()
> in libbpf.c), it makes sense to do it consistently for map_create as well.
> 
> log_finalize() error always overrides map_create() error.
> 
> A precedent: We are safe from this race in bpf_prog_load(): bpf_prog_alloc_id() makes
> prog exposed, only after bpf_check() succeeds, which finalizes log.
> We should do similar for map_create().
> 
Thanks for your explanation.

Will send v2 that follows Alexei's suggestion.

Thanks,
Leon

