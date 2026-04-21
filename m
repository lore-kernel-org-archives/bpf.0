Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316E301708
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792299; cv=none; b=gnkiBjQDDIij/DSn0G0+0/oW4l0QFyOiSQaKaWf21Jo4YUZvAWKK1i3xYksMi9sxsiDOATEdA3lWOsLvDD9AEyNyuP26ebu/OaUgSd4hkTU3ecuvTn8tMYLFDU1h5l5CYW10q0Zolkco51/a5WphBXsR5x2q4q07efIiBLWGWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792299; c=relaxed/simple;
	bh=Be1pSyzuqUarHtagLbk4dsMbxna2qPRDr9HfAyFEQd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOAuKLEB3vXqP3FqknTWYO8od4RYt/KQZKe0kRYIW0iD8SWCMtNUggDeBBd1uR3tEuZUjXL/eowUlrbMEGxdbnbFHeL9feJERXmyIqzD97cxrdEzYWPO6yr/RyZuD/J40phN2EceTbZkkzu2lfNFhoC1g6aywI+PvQqRHvdLgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FM4D+1JT; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FM4D+1JT"
Message-ID: <96b55f09-04cd-465b-95cb-fa6c392d8cbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776792294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8goJOWptmeilxpIzo3/hE3RoBjNijs7pQXFf+MXkG4=;
	b=FM4D+1JTS83OxltM63LZZEevrt4YVt8McYgB+BTsqcFY282346Te8WnCl0Mtp8tFwSrSl2
	4oBNhhWCLWQcVS8X2lJzYE/BoG6IUNIUoF38UH6pGu2YUSbLsNIpupIbh17ylwGUlnw1bi
	YTKJgLAM8MjYeNmtmIpQuc4wMCXAJsw=
Date: Tue, 21 Apr 2026 10:24:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 04/17] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163336.733654-1-yonghong.song@linux.dev>
 <DHYE574ZW4D7.2RNZPHN9QHT8@gmail.com>
 <2259b511-ca71-46a5-a416-8ea6ff0785b6@linux.dev>
 <CAADnVQ+fb4mY4ermo5GBtz1jx7kB4xsDGE23m2G8qEQa261VNg@mail.gmail.com>
 <cba1d567-84db-4597-8e7a-a2203f1209d6@linux.dev>
 <DHYY7AN4MZGJ.3FU2NLXWT7NX@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHYY7AN4MZGJ.3FU2NLXWT7NX@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 8:46 AM, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 8:41 AM PDT, Yonghong Song wrote:
>>> it does:
>>>
>>> +static u32 make_argno(u32 arg_idx)
>>> +{
>>> +    if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
>>> +            return BPF_REG_1 + arg_idx;
>>>
>>> so for argno == 0 it returns 1 and that's my objection.
>>> Make argno starting at 1.
>> Okay. Will do.
> To move things forward please resend the first 6 patches only.
> So we can make sure that they're in a good shape and land them first.
>
Just send out the preparation patch set:
     https://lore.kernel.org/bpf/20260421171927.3507554-1-yonghong.song@linux.dev/

For one patch: bpf: Fix tail_call_reachable leak
AI commented multiple times for this. So I implemented this. You can decide whether
this is important or not.

