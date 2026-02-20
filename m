Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1F2C3749
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558713; cv=none; b=DOIXqrSM01wBqMO/v/zLlxLsqBz7MVGSVlos3fIDiQmT6Az1jYNnU0Ao91EEEpYyJJQhR1DoSJStqP55BPEZXaqx7SHafw5pZrssEA3wgxbC36oBwBC4ApcOQBHTiuBAcBsZwczpCevIMgPg0oz/p/Z9goN8AvmRCphHxj/OoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558713; c=relaxed/simple;
	bh=D8SvgdnOgfoY0XJi3o5+TlgfhbZv1A0Q/dY4ZIYpF10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGBdG8SpEjKpusORh6o6h3hcdQP7kkS1fDNc9chiqeQ/uENSm8fCD9vWkSGOhvuQhrq148HRSvJD+5zP1nVpx4kR3B1zODT7BPI4XcqnJ6BD2AAfNOAynjt3K1Ooqrcr4rnTc31RYrJzPbdKEJSSFdfpP53RtIhvO3Hhcfbx06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2iB9wKk; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2iB9wKk"
Message-ID: <057c2e5f-7dd4-4080-8550-a48e82d20cdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771558708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLkIm3wksjInD8wf107CZW0Tfj7CWQIliWnQmOOaCxI=;
	b=X2iB9wKkMee3DJoyiJ1p/DHqXkGxOoqEL9YCbbSyrbTeG36rGecw/jH+d4THiIYzAl2bek
	bzLVlrZsA4w/FfKyj35NtwqjutktnW6YQZWHpKvWJYEqkBga8afQeWa78c+DI6CDuZM2nH
	nrHi5MtlXuVtu4Kqr40ZEFfa8UoWH8o=
Date: Thu, 19 Feb 2026 19:38:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Function Return ABI (was Re: Argument passing and ABI: GCC vs
 clang)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, bpf@gcc.gnu.org,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Andrew Pinski <andrew.pinski@oss.qualcomm.com>
References: <87fr7e15l0.fsf@gnu.org>
 <6ac7e425-cf75-4706-9906-4c23eb4f0f41@linux.dev>
 <b77afbde-b6d6-4728-9090-af31027846b2@linux.dev>
 <CAADnVQLKXawH8nuSkXGcafS9d66hYfLF_zjKCVdO5WoQ8TxrGw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQLKXawH8nuSkXGcafS9d66hYfLF_zjKCVdO5WoQ8TxrGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/19/26 6:41 PM, Alexei Starovoitov wrote:
>> It seems the existing clang ABI is not symmetrical. The function
>> arguments promotion is handled in callee, but function return is handled
>> in caller [1] which is a bit atypical IMO and would need to be handled
>> in gcc as well.


Ignore this as it is clearly wrong (my jetlag and waking up at 3 am is 
to blame :-)

With PR/124171 gcc-bpf will promote args in caller same as llvm (not 
callee)


> hmm. I thought we already concluded that for clang-x86 and clang-bpf
> argument extension is handled in*caller*.
> The same thing for returns. It's a caller responsibility.
> gcc-bpf doing args in the callee only is broken and has to be fixed.


Correct, agreed.


>> Since we are on the topic of ABI change, I wanted to surface that as
>> well before we go off and tackle that.
>>
>> Simple example
>>
>> _Bool bar_bool(void);
>>
>> int ret_caller(void) {
>>         if (bar_bool() != 1) return 0; else return 1;
>> }
>>
>> char ret_callee(my_t *s)
>> {
>>       return s->c;    // c is a char in a struct
>> }
>>
>> ret_caller:
>>       call    bar_bool
>>       r0 &= 0xff        <-- ret promotion in caller
>>       exit
>>
>> ret_callee:
>>       r0 = *(u8 *) (r1+6) <-- no ret promotion in callee
>>       exit
> Exactly as it should be because x86 will populate 8-bit sub
> registers in the callee and bpf side has to do r0 &= 0xff
> in the caller.
