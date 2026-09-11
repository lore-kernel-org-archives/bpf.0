Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316542CB05
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123083; cv=none; b=imcpDdE+J3Dws3p20V0Ewi06iS+RLKcKf2skW2V36J6EVkvCoBhT/rP5aHrKLAebm8uvhgROJQYLBbAxxvpX7xoytm25bu9fEzSgWFeK7U84iV5XqGjM32jxbKQnrW5MnaHMPsLrmHYYXvWhhYNCypVXO6rRKyC8/ImV6VVzo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123083; c=relaxed/simple;
	bh=qcidQxwh1HceK3n0EKSlmvhY5SFvKe+nZW7HpSIIh40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoEbGvfJyA1b7V+PTB6UsBk8Lw3TbI9DnQlhBGD0AigUnbCk+6C6RwUGc0AmjQh/VXZXiD5ZAQv79ijaH2B52hyCqdJHiBDL/6y5HjLHNos8MPVtio78Yb6Esr4nIv1lDmqKZg25ZS7S+0A6iswaleIhzuERB6bzPLK+KWmnjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FeqWRFZj; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FeqWRFZj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qcidQxwh1HceK3n0EKSlmvhY5SFvKe+nZW7HpSIIh40=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789123076; v=1; x=1789727876;
 b=FeqWRFZjB8+M+Fh50goi/A+OFT+O+HoW+UcXUzMyc+keEYtc8vXgvqs7sjmqfyU1CZNlAvJm
 vqmT6wIAgWVFD/Vq4JI2c7t5jzOSMgZYOHKf71wTj88DVAzYPVZ+hgwYzJehSJ9do1xajFlRx0t
 hJNQ9IlD44neFpl8/JxZ7IPo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 53bf64e9feeab3da;
	Fri, 11 Sep 2026 10:37:56 +0000
X-Mizu-Trace-ID: 53bf64e9feeab3da
X-Migadu-Flow: FLOW_OUT
Message-ID: <74387fa7-b2e3-4b12-a75d-d192f08d14ac@linux.dev>
Date: Fri, 11 Sep 2026 16:07:50 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 05/13] bpf: keep the range across a sign
 extension that cannot change it
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260910164635.459558-6-vineet.gupta@linux.dev>
 <92fc8746a5a16b3e0e544244b584cc6b287a466539230bdb4043e0e8a716c9af@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <92fc8746a5a16b3e0e544244b584cc6b287a466539230bdb4043e0e8a716c9af@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 11:22 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: keep the range across a sign extension that cannot change it
>>
>> coerce_reg_to_size_sx() decides whether a sign extension is lossless by
>> comparing the bits above the field in smin and smax:
>>
>>          top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
>>          top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
>>          if (top_smax_value != top_smin_value)
>>                  goto out;
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
> Does the last sentence accurately describe the change? The early return
> is placed before the top_s*_value and sign gates, so it intercepts every
> fitting range, including those the existing gates accept.
>
> For example, with 'w0 &= 0x3c; r0 = (s8)r0', the register holds [0, 60]
> with var_off = (0; 0x3c). The old path passed both gates (equal top bits,
> both non-negative) and set var_off = tnum_range(0, 60) = TNUM(0, 0x3f),
> losing the known low bits. The early return now keeps (0; 0x3c).
>
> This is the var_off preservation the message describes two sentences
> earlier, so "produce the same bounds" seems inaccurate. Would "produce
> bounds no wider than before" be more precise, given that the accepted
> cases are where the behaviour actually changes?

Yes this is the right phrasing.


>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> This looks like a bug fix for sign extension handling in the verifier.
> Should this include:
>
>    Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")

This is a limitation not really a regression - I doubt if this would be 
backported.
but up to the maintainers.

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
> Is the comment's condition accurate? It says the tests below cannot
> reach this case once smin is negative, but the justification only covers
> a negative smin together with a non-negative smax.
>
> A fitting range that is entirely negative is reached and accepted by
> the tests below. For reg_smin = -63, reg_smax = -1 with size == 1:
>
>    top_smax_value = ((u64)-1 >> 8) << 8 = 0xffffffffffffff00
>    top_smin_value = ((u64)-63 >> 8) << 8 = 0xffffffffffffff00
>
> The first gate passes (equal top bits), and the second gate also accepts
> since (s64_max >= 0) == (s64_min >= 0) holds for both negative. The same
> is true for entirely non-negative fitting cases like [0, 60] with size == 1.
>
> So the early return intercepts cases the tests below handle, which is
> the var_off-preserving improvement the commit message describes. Should
> the condition be "once the range straddles zero" rather than "once smin
> is negative"?

Yes this needs fixing.

Thx,
-Vineet

>> +	if (reg_smin(reg) >= field_smin && reg_smax(reg) <= field_smax)
>> +		return;
>> +
>>   	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
>>   	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34506184282

