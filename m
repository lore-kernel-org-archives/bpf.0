Received: from mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0223E342
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938642; cv=none; b=Q62/g+V6F8k6Xt178HEhj3EICa87hhXFbJ3wbmnc7jb9HjQHRff3pCcVNfDYLcnWg4d4oTdBdEa6vK7xGL10VImehGmk/IV5LwZU7rOH0fgHdifjuNeDR9r5P6/EAxgM5+juua7X5s959EC8VIV9k27KRzCcOWRnzffOZCvHXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938642; c=relaxed/simple;
	bh=8wZU3Iss3wmXREHyNW+ytu2hUlwNlnC6rKMAD596Axk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQQCigyOJw1njUIlELl/g7qkxgVMJtJ4o1cdUOoTUllPy7OuWTth4W/FTaa4tGysQa/7nTPO4b/oizDvn9mMfWONfgWKls7VLiSCRYGvGyZ/yNJeBpwvv5oMpHwFpHkCTWeQ9R2Wo4w8MBRRwzY9rjbFG+3dw5FQrmH0IkwsG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=weYM3O2I; arc=none smtp.client-ip=95.215.58.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="weYM3O2I"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8wZU3Iss3wmXREHyNW+ytu2hUlwNlnC6rKMAD596Axk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938638; v=1; x=1787543438;
 b=weYM3O2Ikg69I+jzhvZ+HLIl0GGhpPgYqAfW5Omt/tddDFJ82LhPj/HU2D844fo7txd2ae7P
 lrYrj9ksYmRNPfDTuGy5HWDt2dZPtSyYlowzhFTQvZimcEUxJ68pssshMbHzNo1s+C84zf7I5No
 Zp2J5jyUbTjVwGE6YUtLpwOE=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 1f0e8816264863d2;
	Mon, 17 Aug 2026 03:50:38 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <20ceb335-905d-4301-9e72-ea59d596ea06@linux.dev>
Date: Sun, 16 Aug 2026 20:50:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 09/11] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813200256.1996809-1-yonghong.song@linux.dev>
 <2435b43ae3c7dfdfac13b28256ec34050ed7a7d6b358337263b2c52003476ece@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2435b43ae3c7dfdfac13b28256ec34050ed7a7d6b358337263b2c52003476ece@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 2:11 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c b/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
>> new file mode 100644
>> index 000000000000..83b1a3751988
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
> [ ... ]
>
>> +struct pair {
>> +	__u64 hi;	/* R0 */
>> +	__u64 lo;	/* R2 */
>> +};
>> +
>> +union upair {
>> +	__u64 halves[2];
>> +	struct {
>> +		__u64 lo;	/* R0 */
>> +		__u64 hi;	/* R2 */
>> +	} parts;
>> +};
> This isn't a bug, but struct pair puts hi in R0 while union upair's
> parts puts lo in R0 - was the inverted naming in the union deliberate,
> or would matching the struct's order (or first/second) make the R0:R2
> mapping easier to follow?

Thanks. This is an oversight. Will fix 'struct pair' with proper ordering.

>
>> +
>> +static __noinline struct pair make_pair(__u64 a, __u64 b)
>> +{
>> +	struct pair p = { .hi = a + b, .lo = a - b };
>> +
>> +	return p;
>> +}
>> +
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +int aggregate_ret_struct_c_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len ^ MIX_A;
>> +	__u64 b = skb->len ^ MIX_B;
>> +	struct pair p;
>> +
>> +	p = make_pair(a, b);
>> +	if (p.hi != a + b)
>> +		return 1;
>> +	if (p.lo != a - b)
>> +		return 2;
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>> +static __noinline union upair make_upair(__u64 a, __u64 b)
>> +{
>> +	union upair p;
>> +
>> +	p.halves[0] = a + b;
>> +	p.halves[1] = a - b;
>> +	return p;
>> +}
>> +
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +int aggregate_ret_union_c_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len ^ MIX_A;
>> +	__u64 b = skb->len ^ MIX_B;
>> +	union upair p;
>> +
>> +	p = make_upair(a, b);
>> +	if (p.parts.lo != a + b)
>> +		return 1;
>> +	if (p.parts.hi != a - b)
>> +		return 2;
>> +
>> +	return 0;
>> +}
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277

