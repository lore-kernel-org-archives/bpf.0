Received: from mta1.migadu.com (out-105.mta1.migadu.com [95.215.58.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D135331203
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645361; cv=none; b=p9fHh9eQeFh6Fl4FfEMsSTY4glBek1/xmJwNVtl9RkwUMRph0JFZcUD8j9AXhCLKMpk/l8fedc7dygVy0pLgqGIg30f6BBs4D4ocnWS/8khKUh5rBqZOOA3o2RiWRpwoqk9e1Sdo7hFBHZDcDgNUD2v+9lGVsGHfmbpZKWvUDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645361; c=relaxed/simple;
	bh=SOAyNhW8GHekK1r1i9QOuqHCTacah0TwH12GL9VzPdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDZim2P+1vLNjb2UBqOrsQg1gR57ZlbZw89zgaPEYV78ZU6HkGeetACL5/Rr8vhokINMH11kXFHdS0Y4ZCkQhbGI90GpDUaGEa6Nf5337++sf5j+J+7ytmZVuxpNk4c3y2Nly9b+ja8a5ELFnBS6lvZUuQeJpCwZ+YGpzYztDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UCewtFJT; arc=none smtp.client-ip=95.215.58.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UCewtFJT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SOAyNhW8GHekK1r1i9QOuqHCTacah0TwH12GL9VzPdg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645357; v=1; x=1787250157;
 b=UCewtFJTjFyo75doF8nVh+xQAHFFwd8tf+7XpcCSuRvlhgW1hDirm5s/Q/orCzMttuJuGmn4
 0ALQgYV2l1TdYRv9xvHwUvlswJ7YagfFoBco2f0CvUU4BcnBTrxyvYdjvaq7fCW6IYlhzjGI3Y4
 K/esmr386pgMcTQoc+qD0ZNU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id 1f9f38d572e0218d;
	Thu, 13 Aug 2026 18:22:37 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <f048f289-defb-4c8a-af5e-ad40ac761bff@linux.dev>
Date: Thu, 13 Aug 2026 11:22:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 08/13] bpf: Reject register-pair returns when
 the subprog BTF is unreliable
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000952.2382568-1-yonghong.song@linux.dev>
 <2dba3a4228d2d19e8865421d564bdc687d801c1d.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2dba3a4228d2d19e8865421d564bdc687d801c1d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/26 3:24 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>> The R0:R2 return convention is derived from the BTF function prototype:
>> bpf_compute_subprog_ret_regs() inspects the return type of every
>> subprogram and records whether its value comes back in a register pair.
>>
>> btf_check_subprog_call() can decide, at a call site, that this BTF is
>> not to be trusted and mark the subprogram unreliable, which happens when
>> compiler optimizations remove arguments from a static function or when a
>> mismatched type is passed to a global one. From that point on the
>> verifier falls back to conservative, R0-only, semantics for the
>> subprogram, while the compiled code keeps returning a pair and leaves
>> the upper half in R2 behind the verifier's back.
>>
>> Rather than silently mistracking R2, reject a return value larger than
>> 8 bytes as soon as the prototype it was derived from becomes unreliable.
>> Add subprog_ret_pair_unreliable() and test it at the two places that can
>> observe the flag: check_func_call(), for the call itself, and
>> prepare_func_exit(), for the return from an inlined static subprogram.
>>
>> Note that the main program needs no such check: a >8 byte return from
>> subprog 0 is rejected at BPF_EXIT regardless of whether its BTF is
>> reliable. Callbacks need none either: a callback address only becomes a
>> PTR_TO_FUNC through check_ld_imm(), which already rejects any callback
>> returning more than 8 bytes.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> I think this is a good example on why r0:r2 has to be inferred from
> register liveness. The user has not real control over reliability of
> BTF for static functions. Hence, this limitation might be quite
> inconvenient in practice.
>
> Another option is to assume that static subprograms always return two
> registers. Then if for some of them static liveness analysis shows
> that second register is never used -- skip the register move in jit.
> This latter option seem appealing to me, as it appears to simplify
> the patch-set.

For >= llvm23 we have true signatures so return types (registers)
should match actual code.

>
> ...

