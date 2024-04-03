Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19A15538C
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177557; cv=none; b=XggkgijWNgQlA+nrxv+fvlAcS3ccwYfbx56E1iZFhpuPACfs1JMvBe6MIaZ7hYZRfC7ibbkq8jvYFMi9JvXfjdvKWg3y2OxhzY6E8oSS0BLHJueOWJNv+2d1tTqPHUVJ031lx+/T8MqiKtZ5ojdh/LzwqSYojGTycVPFnnqZnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177557; c=relaxed/simple;
	bh=dE/BIZPjqFOuf/Ljx3h0naaNfGl0fTvRoa1pt/v5/uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK1wWYzurX8cJshqwavcR00haBHQmB3wXI/6OCiMOyXBpEdRBxZBHcYR4whWYOgYFdCHLq1MsJdwPEaYfR/LPHmqYxvteKlP3kAhnPFYBDvc0UMoGeBOY7JRmOzFZMte65BPClJGOY8mF3lAwjYX2lLWbZp0cIaJaSXq2d/6OIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECwswlPL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECwswlPL"
Message-ID: <ed6929e4-cf8f-43cc-869a-d79b0158c9ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712177552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rEsiX38OraMKU95npmigr9VLrgmVG7+RZfgYibBmQA=;
	b=ECwswlPLHjQGRVru5pJUStIAX2w8AVhV17IwzEk+nkngNpDRY2mnso5HRcd60nmxYi1TQd
	yWrpuUgoXi/xVD7cIIDWHJOxx2gxGAteAzaR6CRZfcgGWrPCzlnPRJWsT56ClVIHtwuZUZ
	aRTdEbqtMNfqo7eCWSKJ5cer5ORv/ZY=
Date: Wed, 3 Apr 2024 13:52:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: kuifeng@meta.com, John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240401223058.1503400-1-thinker.li@gmail.com>
 <660b62aed55f5_801520863@john.notmuch>
 <cf7c6aaa-123b-43b2-8c7b-2c1e2b2dcb67@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cf7c6aaa-123b-43b2-8c7b-2c1e2b2dcb67@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/2/24 10:00 AM, Kui-Feng Lee wrote:
> 
> 
> 
> On 4/1/24 18:43, John Fastabend wrote:
>> Kui-Feng Lee wrote:
>>> The verifier in the kernel checks the signatures of struct_ops
>>> operators. Libbpf should not verify it in order to allow flexibility in

This description probably is not accurate. iirc, the verifier does not check the 
function signature either. The verifier rejects only when the struct_ops prog 
tries to access something invalid. e.g. reading a function argument that does 
not exist in the running kernel.

>>> loading different implementations of an operator with different signatures
>>> to try to comply with the kernel, even if the signature defined in the BPF
>>> programs does not match with the implementations and the kernel.

>>> This feature enables user space applications to manage the variations
>>> between different versions of the kernel by attempting various
>>> implementations of an operator.
>>
>> What is the utility of this? I'm missing what difference it would be
>> if libbpf rejected vs kernel rejecting it? For backwards compat the
>> kernel will fail or libbpf might throw an error and user will have to
>> fixup signature regardless right? Why not get the error as early as
>> possible.
> 
> The check described here is that libbpf compares BTF types of functions
> and function pointers in struct_ops types in BPF programs, which may
> differ from kernel definitions.
> 
> A scenario here is a struct_ops type that includes an operator op_A with
> different versions depending on the kernel. All other fields in the
> struct_ops type have the same types. The application has only one
> definition for this struct_ops type, but the implementation of op_A is
> done separately for each version.
> 
> The application can try variations by assigning implementations to the
> op_A field until one is accepted by the kernel if libbpf doesn’t enforce

It probably would be clearer if the test actually does the retry. e.g. Try to 
load a struct_ops prog which reads an extra arg that is not supported by the 
running kernel and gets rejected by verifier. Then assigns an older struct_ops 
prog to the skel->struct_ops...->fn and loads successfully by the verifier.

