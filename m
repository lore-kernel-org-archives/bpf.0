Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59312D7814
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982544; cv=none; b=PVGkdWRgWRGeUI1QorHTTucElqy/YFrBSCbGx83AzR46JrLKBTOwXxVGfO+Di4kLzndFiFhuTXhPQoW9ojJqKthw25Lx/aE5nbwharO8SKL/bErP10WsY5V0YdROaw8hRu3lak8vdtMu/yMrn3pgI0HyjrSpEnoOYq0bRzWHFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982544; c=relaxed/simple;
	bh=zc6f8NJW7+csitRwoGcMF2EyAtQs5H1o0QKpM+7R9dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5/f4kSwc+nds7Z8FoxxooiChfrqqZqqTPFECtQp87ZgYACbDnQqXTIMM39hM7CcMJPgUO61XXjS4jvE4tJn+J94e3tyHzDzlUwYC4wGMsxkv0Tz8d9DkEH3++TxccBIt8TZGFEz/A/qAqQb/C2MaVSU4b/WMAopVSyoUzvCVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SR7+OsbQ; arc=none smtp.client-ip=95.215.58.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SR7+OsbQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zc6f8NJW7+csitRwoGcMF2EyAtQs5H1o0QKpM+7R9dA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786982540; v=1; x=1787587340;
 b=SR7+OsbQj//RtYehj7bjKNH0TQGpO7WTaXn1LbW74AB6OwMEphLRK57WdcrdcpLs80fdCnV0
 N5OvG7tPPEaLyCVXnJMN2adWDt4GFH7jq0xfS91fZS6g00F8PrWmhvvca0svowBWaoQdqabZu4o
 TI+S6h0hvlV1znCpxw1GvCgs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id 46aeb71ad82016ec;
	Mon, 17 Aug 2026 16:02:20 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <94b9a907-e8b1-4247-8ff3-2140934bcb4c@linux.dev>
Date: Mon, 17 Aug 2026 09:02:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260817042212.2291498-1-yonghong.song@linux.dev>
 <7549f24ead00d59b53a11482de59a7858aa1fe8118b41f7449887ee9b544b0c8@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7549f24ead00d59b53a11482de59a7858aa1fe8118b41f7449887ee9b544b0c8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/26 10:17 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 5b9d767895c9..2ae7cb9b30f2 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7684,6 +7684,12 @@ static int btf_check_func_type_match(struct bpf_verifier_log *log,
>>   			btf_type_str(t2), fn2);
>>   		return -EINVAL;
>>   	}
>> +	if (btf_type_has_size(t1) && (t1->size > 8 || t2->size > 8)) {
>> +		bpf_log(log,
>> +			"Return type of %s() has size %u while %s() has size %u, and a size above 8 bytes cannot be replaced\n",
>> +			fn1, t1->size, fn2, t2->size);
>> +		return -EINVAL;
>> +	}
> This isn't a bug, but since this check fires on the absolute size rather
> than on a mismatch, the message can end up reading "has size 16 while g()
> has size 16". Would it be clearer to state which side exceeds 8 bytes
> instead of using the "X while Y" mismatch phrasing the neighbouring
> diagnostics use?

Okay, I see. Maybe
  "Return type of %s() has size %u and of %s() size %u, and a size above 8 bytes cannot be replaced\n"
?
I guess the intention is to explicitly mention which function exceeds 8 bytes.
User should be able to know this by checking original func and freplace prog?

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373

