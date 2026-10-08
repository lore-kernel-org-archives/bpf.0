Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0B35C680
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476597; cv=none; b=u1LvWdDQM2/E9ZC7W55bxnhaZm8MM6xa5caS33+lEEAASIxpIV+7vm52A0QOaJzR8DWgQJQehxzF3ymBRiUMBfafdDf2PLP/zZSPBqXthwPE9NeI0ZnISAaFbw+J2mXr0rXotc4kdCD9YBOv8kTFpzwLRxAf4AByMzIAHscV7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476597; c=relaxed/simple;
	bh=nuG6qc90eMk4hLv7cDdibVyrPYB5JMiuMqTDupYHmfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X55HyqufbMbalBaX+pUtMzdwHbBo9UrblPwv/zj+HHHB90suxb+7lXjvv783cYnbJ14CMu37A6uoGytbdmn+cXAm98ARE8qnj8fVa/4Mdvu6kRLCV8Vjmt1G7mM93vphWlvYkQl5VCvUDQXmKoW2VJHQcXf0YrbhfopRm6JrPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e95idCJB; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e95idCJB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nuG6qc90eMk4hLv7cDdibVyrPYB5JMiuMqTDupYHmfs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791476594; v=1; x=1792081394;
 b=e95idCJByaevFCYOvKfad6xXKIRNYy+Kt+nmFl+AkKVGCwmP5BFc8mDkp5U88FRKED81bG6t
 D+MRyazIXL5RznpeniLjfdV32uuMZVbDZEqqdXNQX0198hgmxm9NeA3Dem8ZT+0awGmKVDNgtqQ
 G7UCRjKThzRjpCqs5AAnd70A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b4b3c8a8e2f02e2;
	Thu, 08 Oct 2026 16:23:14 +0000
X-Mizu-Trace-ID: 2b4b3c8a8e2f02e2
X-Migadu-Flow: FLOW_OUT
Message-ID: <9691f59d-a116-43f6-8fc8-09fc1891a395@linux.dev>
Date: Thu, 8 Oct 2026 18:23:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 14/23] bpf, arm64: Dispatch exception cleanup
 pads at run time
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261008075111.3003497-1-yonghong.song@linux.dev>
 <e886b1d0457c718b5b198c480ed1c5040db1a43391b3c56028b659be85a82031@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e886b1d0457c718b5b198c480ed1c5040db1a43391b3c56028b659be85a82031@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/8/26 10:39 AM, bot+bpf-ci@kernel.org wrote:
>> bpf, arm64: Dispatch exception cleanup pads at run time
> TL;DR: Commit message only, no code issues: the changelog should open with a
> sentence saying what this does for arm64, and one bullet ("aux->epilogue_ip
> and the native cleanup table") lacks a verb.
>
>> bpf, arm64: Dispatch exception cleanup pads at run time
>>
>> - arch_bpf_stack_walk_ra(): walks the frame records with the kernel
>>     unwinder, handing each return address to the consumer and storing a
>>     new one back into the record it was read from. The first frame, whose
>>     return into bpf_unwind() comes from the walk's own record, is
>>     skipped.
>>   - With CONFIG_ARM64_PTR_AUTH_KERNEL and a CPU that supports address
>>     authentication, the new address is signed as the BPF prologue signs
>>     the link register, with PACIASP and the record + 16 as modifier.
>>   - aux->epilogue_ip and the native cleanup table.
>>   - bpf_jit_supports_cleanup_pads() says yes, also with a shadow call
>>     stack: only JITed frames' records are written, and JITed code keeps
>>     no x18 copy of its return address.
>>
>> A pad needs no BTI: it is only reached as a return address.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> this isn't a bug, but could the changelog open with a sentence on what this
> does for arm64, instead of starting directly with a bullet list?

It is my fault. Should have a small paragraph to highlight the key
message before itemizing different cases.

>
> Also, the bullet "aux->epilogue_ip and the native cleanup table." has no
> verb.  Could it say what is done with them, for example that the JIT records
> each function's epilogue address in aux->epilogue_ip and fills in the native
> cleanup ranges once the image is final?

I will expand to have more detailed information for this item.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37747693645

