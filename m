Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8B450917
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507156; cv=none; b=JqEb9lsfN+DStTmExQvlZihoEEjo8NyYuD7vi/5iEUEVAH0hfa4i34XDg1FnVzto12V4atR4O0hyqishw45e+m4QXoBJjeBdTW/HIyUbXFwEpmSbK4ujNv0yWXbRFpiolvUhBKxrZVtfu0NgMOco6xKVTpx3HdJV7XHkIIMkrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507156; c=relaxed/simple;
	bh=ql4sab1w7TKwOgBM/Ql7wMbRLphrnVowff5ABO0qUKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lz2dH5Oiyry+5oryGZGKDWQWHSIXbTV+OPZmoP6KrFxOn+fLKDjrfZmi/D2h9zld86O9Lq9IHh6THUHxI4ur0JdfY055gK8Y/u7/QsUnFjBOeYL8LSZbc2v4HESBTb3k/EUq5CPzfjlofYIlCSyhH4g449iIwld75Ji20q3uu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gm0H8Fgb; arc=none smtp.client-ip=91.218.175.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gm0H8Fgb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ql4sab1w7TKwOgBM/Ql7wMbRLphrnVowff5ABO0qUKo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789507151; v=1; x=1790111951;
 b=Gm0H8FgbdU85gAElkhAXF0ajvFpBHozVEoFQ1VzQqBxdHzrEB8WU8/WPCbrHOMqzT4b3Z8X2
 sOFk2MxyVR1jEG27iIru9gxpy94LhRFbvkV1c/KBAbGNStUS8Uhk5pfV+JDTIVKfkZrCOflLAIG
 J91080cEB4u/VNM0bOl9Asqc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 190437f01fc1c6cc;
	Tue, 15 Sep 2026 21:19:01 +0000
X-Mizu-Trace-ID: 190437f01fc1c6cc
X-Migadu-Flow: FLOW_OUT
Message-ID: <e1d1fc67-1035-433e-97a9-7bbf2628ccf5@linux.dev>
Date: Tue, 15 Sep 2026 14:18:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 05/13] bpf: keep the range across a sign
 extension that cannot change it
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-6-vineet.gupta@linux.dev>
 <DLDKK1NH3BO1.SZN02MHQTX00@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DLDKK1NH3BO1.SZN02MHQTX00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 12:02 PM, Alexei Starovoitov wrote:
> On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
>> coerce_reg_to_size_sx() decides whether a sign extension is lossless by
>> comparing the bits above the field in smin and smax:
>>
>> 	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
>> 	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
>> 	if (top_smax_value != top_smin_value)
>> 		goto out;
>>
>> Equal high bits do imply the truncation is lossless, but the converse does
>> not hold. Whenever the range straddles zero the high bits necessarily
>> differ -- smin sign-extends to all ones, smax to all zeroes -- even when
>> every value in the range fits the field and (sN)v == v throughout. The
>> second gate, "both of s64_max/s64_min positive or negative", rejects the
>> same shape again for the same reason.
>>
>> So a register holding an errno-or-zero value, [-4095, 0], comes out of r0
>> = (s32)r0 as the full [S32_MIN, S32_MAX] even though the instruction is a
>> no-op on it. The no_sext test at the call site does not help: it is an
>> unsigned check, so it only covers non-negative values that fit.
>>
>> Test the range against the field directly and return early when it fits.
>> Sign extension is then the identity, so nothing needs updating -- which
>> also preserves var_off, where the existing path would have replaced known
>> bits with a coarse tnum_range().
>>
>> This only tightens: the early return fires exactly where the value is
>> provably unchanged, and the cases the current tests do accept still take
>> the same path and produce the same bounds.
>>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>> v2: new. coerce_reg_to_size_sx() is fixed rather than special-cased,
>> which is what was asked on RFC 5/6; it removes the RFC's
>> call-then-overwrite at the mov site.
>>
>>   kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 58e788f53ae5..eb093194e2a3 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5754,6 +5754,7 @@ static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
>>   static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>>   {
>>   	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
>> +	s64 field_smin, field_smax;
>>   	u64 top_smax_value, top_smin_value;
>>   	u64 num_bits = size * 8;
>>   
>> @@ -5773,6 +5774,27 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>>   		return;
>>   	}
>>   
>> +	if (size == 1) {
>> +		field_smin = S8_MIN;
>> +		field_smax = S8_MAX;
>> +	} else if (size == 2) {
>> +		field_smin = S16_MIN;
>> +		field_smax = S16_MAX;
>> +	} else {
>> +		/* size == 4 */
>> +		field_smin = S32_MIN;
>> +		field_smax = S32_MAX;
>> +	}
>> +
>> +	/*
>> +	 * The range already fits the field, so (sN)v == v for every value the
>> +	 * register can hold and the sign extension changes nothing. The tests
>> +	 * below cannot reach this case once smin is negative: a negative smin
>> +	 * and a non-negative smax never share their high bits.
>> +	 */
>> +	if (reg_smin(reg) >= field_smin && reg_smax(reg) <= field_smax)
>> +		return;
>> +
> This patch can be a patch 1, since it looks unrelated to the rest?
> Would be good to test it individually. veristat run before/after.

OK, and the corresponding patch moves too.

Thx,
-Vineet
