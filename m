Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAA313E34
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068103; cv=none; b=qCnTDUqgVsK5dxf9HrqGkDmUfOQDU8CG7xcvU3IkwtBejKWzrzJTxpPi1mvALhRh66LlPtkbzrLWaPlxoJUkk8QKy21cv49vxrR2tmoGymgdNVHRboYIJdYHj7QfVcBs6n4AyweNSDVEbMWxkRhHhPPeXwbHsHuJe/nLuiyZSaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068103; c=relaxed/simple;
	bh=BfdMk1deRwkGct0082SMOV0ltUaLANT9tv+UE1qBWLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zjxmlb8AWQbNM0Jx35GYOWQ8atUELFTY4H9R62k9YemxQ7roUz39AIPQmytsTb1DKs7dVxPElUW8Rr2nzZrpzjPR5X7Su11uTOAzuvcatWHU7OAOZqPFJH3ptyJZRwYhBq5Fhv29B9YZ80EWbtgrtppiOJz3tC0f8Xdl1mOoQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YLafTUH5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YLafTUH5"
Message-ID: <d69810c5-3961-49ad-8f34-f686524829c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775068099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DG2MB12tK9xce5Yn7mUdQDKx3QtcY+asf1sBmdmQpE=;
	b=YLafTUH5aWOXVqbb1IT7kltIsEA6uDk4dcd9NuzQF8HyYf9jqEqXQEJIHE3zNXJIZex6+J
	UOtFuUrLRzU8T9NrrVXWbUjSaWJerXPKKfXyRxYk+UEN8EzW5BQnEPMHMKkp+GJJePUZ7x
	OIVbs064uA2rbgZ65AgAeqPggXIos64=
Date: Wed, 1 Apr 2026 11:28:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] bpf, doc: Improve MOV* documentation ...
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org, jose.marchesi@oracle.com, ast@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260401170115.495836-3-vineet.gupta@linux.dev>
 <3ac88e05c887d679301e873b3968ebb41deaee08f9f41d7f225cd2268c7fc133@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <3ac88e05c887d679301e873b3968ebb41deaee08f9f41d7f225cd2268c7fc133@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/1/26 10:59 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
>> index fd688c5d3f04d..ac61d3be7af21 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
> [ ... ]
>
>> +``{MOV, X, ALU64}`` means::
>> +
>> +  dst = src  (e.g. r1 = r2)
>> +
>> +``{MOV, K, ALU64}`` means::
>> +
>> +  dst = (s64)imm
>> +
>> +e.g. r1 = -4; r5 = 9282009
>> +
>> +``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed)::
>> +
>> +  dst = (u32)src
>> +
>> +e.g. w5 = w9
> Should the example for {MOV, X, ALU64} be placed outside the code block,
> matching the style used by {MOV, K, ALU64} and {MOV, X, ALU} just below?
>
> As written, the RST literal block renders "(e.g. r1 = r2)" as part of
> the formal pseudo-C definition.  The other two entries place their
> examples as separate paragraph text after the code block, which keeps
> the spec definition distinct from the illustrative examples.
>
> Something like this would be consistent:
>
>    ``{MOV, X, ALU64}`` means::
>
>      dst = src
>
>    e.g. r1 = r2

OK.

Thx,
-Vineet
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23861455083

