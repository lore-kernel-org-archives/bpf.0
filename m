Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF512CDA5
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938298; cv=none; b=oTp2oglMrVKYA1DLJry8DwTPjGs5uT4OkwwDsnndnCxl0qohj2x7bqUuqu0T23ipuwu0p8/5Ur+/OuX1W25YKVtWqntYtrzrpo+OMFEs35PogbSHjMVGHbZ39PLGDxRom60QoX+rQnVhqCloxqxdl9x9BfV4BA6sG5c28ONJZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938298; c=relaxed/simple;
	bh=1e4k3DbtLAc6hYzwcD2I/rLiXEF1z5pCt3JnRewvq4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0fWDzSqUAY/uzk58MI4+ebpKh6IJrR7uN5TI9W75HHnlqojbZAjQcHg3LmPCT0mIzAhiifB8NpKiZrkN7rEkj+SzigkLSrjTmP8uPPFqp8eAywwRlLy6IU+I+gVrFOgBj1OUK4Y1oQZqkPrky/+q2i8lS5Gxj8nLzkkS8Ved98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cc+q76s5; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cc+q76s5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1e4k3DbtLAc6hYzwcD2I/rLiXEF1z5pCt3JnRewvq4w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938295; v=1; x=1787543095;
 b=cc+q76s56T0IdP14u9BdvV72EDOI7V1pLGHTVhkEqEwNET9RSGH8eKTh1rfwJnDTGWQAlMlr
 88JqwXB8UZGdKMHHfLUyoW3ZZHq9YtREEYRQJXD2M8BV14FA/ebJAF3VunGdTu0M5H/d9s4AFCM
 f7oQRQXPxtfkXLMgfMWgAveU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 09262ad0a48056c2;
	Mon, 17 Aug 2026 03:44:55 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <f75fd498-047e-47e9-b8be-7ee7a4563825@linux.dev>
Date: Sun, 16 Aug 2026 20:44:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200240.1995795-1-yonghong.song@linux.dev>
 <c028bea425c3ea04df2156aec8a8b889fd6339ec.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c028bea425c3ea04df2156aec8a8b889fd6339ec.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 4:53 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:
>> LLVM 23 added support for returning a value in two registers for an
>> __int128, or a struct/union whose size is greater than 8 but not more than
>> 16 bytes. See LLVM patches [1] and [2].
>>
>> Before LLVM 23 the BPF backend could not return these values at all. A
>> by-value struct or union return (of any size) was rejected at compile time
>> with:
>>
>>    error: aggregate returns are not supported
>>
>> and an __int128 return failed later in the backend with:
>>
>>    fatal error: error in backend: unable to allocate function return #1
>>
>> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
>> register pair.
>>
>> This patch models that pair at calls to global and static BPF subprograms
>> and at kfunc calls: R2 is marked alongside R0 at the call, propagated out
>> of a callee at its exit, and held to the same scalar-only and no-stack-
>> pointer rules that R0 already is. A struct returned by a kfunc must be
>> composed of scalars, since its bytes reach the program as raw register
>> contents and a pointer field would otherwise be laundered into a scalar.
>>
>> An extension program is the one caller of the convention that cannot take
>> part in it: its own return value is the program exit code, read out of R0
>> alone, so it has no way to hand back an upper half. Replacing a function
>> whose return value is larger than 8 bytes is therefore rejected with
>> -EOPNOTSUPP rather than supported.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/190894
>>    [2] https://github.com/llvm/llvm-project/pull/206876
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>> @@ -19404,6 +19458,13 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			return -EOPNOTSUPP;
>>   		}
>>   
>> +		if (prog_extension && tgt_info->fmodel.ret_size > 8) {
>> +			bpf_log(log,
>> +				"Cannot replace function %s with a >8 byte return value\n",
>> +				tname);
>> +			return -EOPNOTSUPP;
>> +		}
>> +
> As commented in v4 [1], this check belongs to btf_check_type_match().
>
> [1] https://lore.kernel.org/bpf/e1bf30cac04d54aa328fee5282de348a89494048.camel@gmail.com/

Okay, will do.

>
>>   		/*
>>   		 * *.multi programs don't need an address during program
>>   		 * verification, we just take the module ref if needed.

