Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8735469836
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766012; cv=none; b=S63VofIiVCoLwMs6mimjNf96KIMfNjxuEVMLX1bQVW7Ol7cwgU2EVlzKA0rO0XDIgc2HrnFfAA+eNCbsLccfxHHMoiYxMVBAtRQScHKXQxoZyoDQILyjKVOHQQ8C89vajfu1EqfdF98FR3rNp3cUOmyDPcH1hFZRxD1R8w1JJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766012; c=relaxed/simple;
	bh=E/JeXWpAQAY69sqUyRoablYU3W4GZeNh5+vWEu+qZZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0K/8NhPaRfRYfRhKCaH3pZctk4oc3wUTaxTU3KkYaJQuLiLSuSDyoxlRQCh/oarg/FpewjAE28Z4xvyhyNRrxVlux5t4l8Pgf38nV5FxzTgx9eamJtw/mWkN2uln3bhjHOlFaFWc1BKlefEmK4Y+co0Fa701zofSwDOuKmmR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CR0p7Jox; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CR0p7Jox"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E/JeXWpAQAY69sqUyRoablYU3W4GZeNh5+vWEu+qZZM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787765991; v=1; x=1788370791;
 b=CR0p7JoxqHdRstxrSyW0n3myw++yo15v66YCpKYoRPxI0iHbkca7SILjUUGOQQF64mEOCqRc
 U6JQ3crYGoRCsX9fnsZqZzFdNFn6AkTq0Oo4ylxpbWqf4KdBUTFBnNVjkDBHJTJ3sNismxqW6oX
 KtmQ6tjro2Ae10DKX6KPa2Ds=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:2cdc)
	by smtp.migadu.com with ESMTPS id 72b71716ccde367b;
	Wed, 26 Aug 2026 17:39:51 +0000
X-Mizu-Trace-ID: 72b71716ccde367b
X-Migadu-Flow: FLOW_OUT
Message-ID: <e6a62d02-2584-474b-9e07-8755a2ebf19d@linux.dev>
Date: Wed, 26 Aug 2026 10:39:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 04/10] bpf: Let the by-value struct walk take
 the kinds of member it accepts
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205432.1322845-1-yonghong.song@linux.dev>
 <bc4461d9d023911ce4c56de3c9cc73e93f1a4091511aa7bb77dc279a4b855239@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bc4461d9d023911ce4c56de3c9cc73e93f1a4091511aa7bb77dc279a4b855239@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/26 2:59 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Let the by-value struct walk take the kinds of member it accepts
>>
>>      Use btf_struct_is_composed_of() instead of btf_type_is_scalar_struct() in
>>      btf.c so in the future, non scalar member (e.g. arena pointer) can be
>>      supported as well. There is no functional change.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This isn't a bug, but the changelog only describes the one-line call swap
> in btf.c, while two other parts of the diff are what the "no functional
> change" claim rests on.
>
> The first is a new enumeration in a global header:
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> +/* Kinds of member a by-value struct or union may be composed of. */
>> +enum btf_member_kind {
>> +	BTF_MEMBER_SCALAR	= BIT(0), /* an int or an enum, or an array of them */
>> +	BTF_MEMBER_ARENA_PTR	= BIT(1), /* a pointer carrying the "arena" type tag */
>> +};
> The second is the array-member branch of the walk losing its trailing
> continue and falling through into the shared kind check:
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>   			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
>> -			if (!btf_type_is_scalar(member_type))
>> -				return false;
>> -			continue;
>>   		}
>> -		if (!btf_type_is_scalar(member_type))
>> +		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
>>   			return false;
> Equivalence here holds because btf_member_kind_allowed() collapses to
> btf_type_is_scalar() when the mask is BTF_MEMBER_SCALAR alone, and because
> the shared check is the last statement of the for_each_member() body, so no
> member is skipped or checked twice.
>
> Would it help to mention the new enum btf_member_kind in bpf_verifier.h and
> this array-branch fall-through in the changelog, since those are what the
> "no functional change" claim rests on?

New enum btf_member_kind is self explanable in the code.
In the commit message, I will explain array-branch fall-through thing.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405

