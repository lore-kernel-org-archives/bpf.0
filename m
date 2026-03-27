Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AA396D07
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649218; cv=none; b=K2OrwEp5jd+IwfKJBq3r2g1pNxpzMbPtOPxkmNcDCO2SPdWVnyJ0MW6EvjOSCdsLoXDOyivhm9C5PrA57CMv2Ka0f7C3ZtnZpbWyI6ar0IauQRdWZ/v2XypD+WIshzSmO5EkjH5hXQsPI6ZUs0dGfWRVYDQvQGmyG5gtsApdY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649218; c=relaxed/simple;
	bh=O/ucsDOKIHqs2jfQF8GdhkJzKmq+kzECMmBmhk/S/GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjcvIUmphjqDsNdSB1PNzGMU/dt345xUe2P6fuZG4Zcn5IYqFNbxge1FEikfCNlv2Bd/iaDPt2zhoMDWR+J2XuPgKNr8mA5OoDHfx/XS33ME/WP+NPpGrbcnKU9nlmIZgrMO6SFfO8QczBMRLDOM9Q/9zAQAtt4kY1B+g4isYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjgKdFto; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjgKdFto"
Message-ID: <fd982667-1fce-4472-a13b-ade388b01b88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774649214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsu4ehr5QCa4IWWa28R8kXlndKZoFjuzNQJi3QWKNAo=;
	b=wjgKdFtoFfX3swa4pC0fNCoo00vRIRSAOIWubl0Y3mKhvjcjlgxpz4Ks4tWZi642K19NbV
	X06qnuNMfR29mzsDehkm6BZsL3Fq9Wx+gGI0nHHjoTregZeA5gi9VqmOKmr2c9aIUdK38b
	TjZ8GtErqXsbUfXM3beRW1AL/3nRqSE=
Date: Fri, 27 Mar 2026 15:06:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
 <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
 <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev>
 <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
 <676332b5-1f7f-4c8d-b41e-e2dbbc1d7e4e@linux.dev>
 <CAADnVQLUTNoa4qXW357CU5e2hP+DpxM=QYK2ZuWHR_aLbmb7Hg@mail.gmail.com>
 <97357814-57e9-498f-894f-4c5dc4e3d0ce@linux.dev>
 <CAADnVQKRDHu=kn1U98jnY1XVk__ZGC1iyRQZdPH1g1=wgA1pWQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKRDHu=kn1U98jnY1XVk__ZGC1iyRQZdPH1g1=wgA1pWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/27/26 2:47 PM, Alexei Starovoitov wrote:
> On Fri, Mar 27, 2026 at 2:08 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 3/27/26 2:00 PM, Alexei Starovoitov wrote:
>>> On Fri, Mar 27, 2026 at 1:55 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> On 3/27/26 1:48 PM, Alexei Starovoitov wrote:
>>>>> On Thu, Mar 26, 2026 at 12:13 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> The above works, and the question now is if we like this mechanism
>>>>>> more than current setup with explicit enums.
>>>>>
>>>>> Got it. Thanks for the explanation.
>>>>> Your approach does sound a lot better than explicit enums.
>>>>> Make a proper patch out of it.
>>>>>
>>>>> If we do this can we remove <counter><line> approach everywhere
>>>>> while at it and only use named ?
>>>>
>>>> This crossed my mind too. I'll try to *replace* the suffixes and if
>>>> it works fine submit that.
>>>>
>>>> One inconvenience is that with named suffixes BTF_ID() macro will
>>>> have to accept an additional arg (the list name), but I think
>>>> that's ok. We already have to pass struct/func everywhere too.
>>>
>>> and that name has to be unique.. I think it's fine.
>>> I'd do such change, and reuse all of BTF_ID macros.
>>> So that only BTF_SET_START line will differ.
>>>
>>> The overall diff stat shouldn't be big ?
>>
>> Depends on whether we are refactoring BTF_ID, or just adding new
>> BTF_ID_NAMED set of macros.
> 
> I meant that BTF_ID_NAMED(special_kfunc_list
> would somehow remember that it belongs to BTF_ID_LIST_NAMED
> that started this "scrope" few lines above an actual BTF_ID(..)
> ?
> 
> or for BTF_ID(func, bpf_lsm_bpf_prog_free)
> we consider 'func' to be that 'scope' ?
> 
> we don't have uniqueness across files:
> BTF_SET_START(untrusted_lsm_hooks)
> BTF_ID(func, bpf_lsm_bpf_map_free)
> BTF_ID(func, bpf_lsm_bpf_prog_free)
> ..
> 
> BTF_SET_START(sleepable_lsm_hooks)
> ...
> BTF_ID(func, bpf_lsm_bpf_map_free)
> ...
> BTF_ID(func, bpf_lsm_bpf_prog_free)
> 
> but does it matter?
> This new BTF_ID() will define multiple extern u32 with the same name.
> Make them weak since they point to the same id ?

Let me play with this, maybe I (or AI) can come up with something
like you're describing.

I'll aim to submit a patch next week.

