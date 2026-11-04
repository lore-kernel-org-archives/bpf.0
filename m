Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825634;
	b=HkPQN3YJzvg/EKoKWt/X6QaxpkhRDEnyce+8CTAgadsHXfI8r0wCw1dLs2jO7pLrU/nq
	 W553fzzUTst4Gs6ME4+W8OZYrX2PqCH2Iljs9UULPPNTJFOgGkD3H+K9O3vvhs2GISxyd
	 0j8agVPxY+oDSSxzlSUlrQUZaD97ecYc6+um95g0425DEU68VJLYAHLGeVNTQMs7jF9M1
	 nG+0saqB0gYQuGuPTAY/J+36aRRM3kJu+xxCEMIU8f2ie73i2RCsHzrJxrTuJ/YxEVrvA
	 jpHhH6Utwc42fxjKjg7z4OWmme7C3oa4vYsYWhkxxkq3dXbYRH7Eo5bvezGIaMLhgLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825634;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y+PC7jHTM1E8Vn7cVLdmAfNEOuE8u386qwA62Ju0uyI=;
	b=noEeAPV9vZjLnPalUQYhBZDKi8WgYKpa7kvvH+N1QMVudH3f88bzjLmr84hOaqWMlVjP
	 ur9cpvmFMpb9SJ2awxbAouTetDrZnBvc3N6dB2EIMR+iQLMzdwMvlXbdQ7BkbGN+HsKsr
	 qUTIv+XpZMpfCYC+iB7icWz+YaWRkV9ziohp6PVE8TdeyQHVJbE+p00g6sZUUKaJm+x64
	 h5qzVEtsTOYVTRyuVut+vdlgB2kdv3FIEePb4Iv1v9zeICmiTpSM1IdLgxC5G6aC6lKJC
	 zZftmOG9gle/3XPrj4IjsPt301KwZlnQq6LLhUJhyqqMLVadLbJWm36kmVA5c3Yp0nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sb+q5FLD;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476C606C910
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1476C606C910
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sb+q5FLD
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2eu3NaYFL+BtaLJBYIyCWYYqp3hmqybleGi1ZXsiZxA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793825630; v=1; x=1794430430;
 b=Sb+q5FLDG5lfdr3gkjg+cdm9VO9nU24kfKoqEa+tr2kwaitFJyDrj3nvrm8qGMmIyZn1XzK9
 cUIUfO1pB7o44aZI5JDu9QXb9Bfn+tZeb/BTqX7Dk7dM4wDlP6k/iNfqdDep+wBnxZZTweq61CO
 iSKzKsKTzDAxbJaA6bJl/4IQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef2066239f9c474a;
	Wed, 04 Nov 2026 20:53:50 +0000
X-Mizu-Trace-ID: ef2066239f9c474a
X-Migadu-Flow: FLOW_OUT
Message-ID: <efda3685-8a09-48b2-9592-7a74fdd3238f@linux.dev>
Date: Wed, 4 Nov 2026 12:53:46 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/12] bpf: Keep the 32-bit range across a
 sign extension that cannot change it
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-2-vineet.gupta@linux.dev>
 <9720ed1ff19dea17a1b379c02d7dd52ae886d807.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <9720ed1ff19dea17a1b379c02d7dd52ae886d807.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eduard,

Thx for taking the time to review.

On 10/29/26 3:30 PM, Eduard Zingerman wrote:
> On Tue, 2026-10-20 at 09:18 -0700, Vineet Gupta wrote:
>
> ...
>
>> @@ -6192,6 +6193,27 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
>>   	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
>>   		return;
>>   
>> +	if (size == 1) {
>> +		field_smin = S8_MIN;
>> +		field_smax = S8_MAX;
>> +	} else {
>> +		/* size == 2 */
>> +		field_smin = S16_MIN;
>> +		field_smax = S16_MAX;
>> +	}
>> +
>> +	/*
>> +	 * The range already fits the field, so (sN)v == v for every value the
>> +	 * register can hold and the sign extension changes nothing. The test
>> +	 * above misses this once the range straddles zero: it only looks at
>> +	 * reg_umax(), which a negative smin makes huge.
> The `if (reg_umax(reg) < (1ULL << (num_bits - 1))) return` check is no
> longer necessary, the new check below subsumes it.
> Please drop it, otherwise commit lgtm.

Agree. Dropped in v4.

Thx,
-Vineet

>
>> +	 * This has to precede reg_step_reset() below: the extension is a noop,
>> +	 * so the base/step line still holds and there is nothing to discard.
>> +	 */
>> +	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
>> +		return;
>> +
>>   	/* See comment at reg_step_check_unsigned(). */
>>   	reg_step_reset(reg);
>>   

