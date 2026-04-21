Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898626C39E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789444; cv=none; b=U05CGdqj1EJhuTLDIhCQMVJpHjF6TG5gAD013VgLEvrAO1tP3ua1+8f1Y/zyXv6tVKDIVAbFaBXVURsyZVgGnLH22TIjBnu5Afg7saynpBCsLtwMbduYNjNeT8HD4Nl5ZDrVVwVJvbJA0lN8hqfkkDnGhAGMwA1B7UChYBX0vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789444; c=relaxed/simple;
	bh=WIxskNPKYcLnRVBqQJ+8X2Ygim7MOkndnxXgjy5Eazw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSpFZHr4QWEdRg2qp4Tx907V+X03fnR2QDogzunJHuE278qeOJItJiXTyddjiOP5LrJ6I6i/3q9dBCB0Krn+8p+aCvaFEJnyezEjb5yf+MfQ1UCME7GgmgkMLtXjbr+O7mBnJITxcCedGRm2W5NYUCyaCfKbfK4vBlbzLP8M3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMy+BHwv; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMy+BHwv"
Message-ID: <619e19ab-a8a4-4f62-a883-640d799a1650@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776789441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toAVHravlLRzuEhY+0xZaosMoLfaNpiWrLIoTT6qm7U=;
	b=gMy+BHwv90vf2fkZ+WugJ4kZ9z+S4LZ5wSCY8Uq70qx9XZS9aLzVjHc8r5wTg1XeIdShCF
	JOv9uXO/Wi0DZ8J7vumjmjreEFmwIWqLtixTwA5LrqMJAECoKOcD4jgbX5UZvWKVURqngd
	B/xFjJA410LdeSiMimxhAq5ZxRmM8fU=
Date: Tue, 21 Apr 2026 09:37:15 -0700
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

Good point. Will do.


