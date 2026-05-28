Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361553F6C4B
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981482; cv=none; b=SCUr1wQQGiU/VPnfkleUu8Fj9VYxZ4J1elMAZIITAPnF4Kg4k8aj5JxknglRIYtoQ85F9lA20wln5Rqqyc/NgpPZxG6babqoYE1yOp7ZVcmADIQ1h6g4NEVaR4vjeoxYOOeW4AahPAAjcmSrs3wokgy6Hnsnu93UOT4+PW8pit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981482; c=relaxed/simple;
	bh=9BXuFWqc087laW7rHkKeLe51vQjQmRhHB41lSq9oASo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLHuD2YHGM8rOoPV5Bw2Zz1NTq7EWygOkoHQZvcVsgRAESFSj7wtFXF655QhMpYz87M7m56NXwQO8Haxo+KykS7gRUI836K56ILCX/8ChNroo/dO0KWptWrnr0jJ2LTM+VuPKMcNMOiezFv/2V89CEu3KdHW9aSLdZ1RUwYmruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oRt8iLaM; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oRt8iLaM"
Message-ID: <691a2da2-9aa0-4e93-b80f-81ab8c4d3a93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779981479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAaYPbk57Gt7+nL0z2F4dB5t6Xp1jRNCQW4BlNQKz9o=;
	b=oRt8iLaMYU0STTAVlF7nyWFD5Cllz0PKM79CKaNG/WknM+Pik/pAms+FUHPx8/49HKQr6X
	E7LeZd8zA4MVzzZ/zIm9LyAogxu+P0qsLkCWOK1uDjsFshT71VUhog2vtvzXPHMOyoDrYk
	bHfkEYqej0zhIVLTaMpYVEWOxQnHpsg=
Date: Thu, 28 May 2026 08:17:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: reject overlarge global subprog argument
 sizes
Content-Language: en-GB
To: Taegu Ha <hataegu0826@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <yatsenko@meta.com>, Song Liu <song@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Emil Tantilov <emil@etsalapatis.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260528052533.3940181-1-hataegu0826@gmail.com>
 <20260528062155.3988156-1-hataegu0826@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260528062155.3988156-1-hataegu0826@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/27/26 11:21 PM, Taegu Ha wrote:
> Global subprogram argument checking derives generic pointer sizes from BTF
> and passes the resolved size to check_mem_reg() as a u32. The access-size
> validation path then uses a signed int, and stack pointers negate the value
> before calling check_helper_mem_access().
>
> This creates a wrap when BTF describes a pointee size larger than S32_MAX.
> For example, a global subprogram argument of type:
>
>    int (*p)[0x3fffffff]
>
> has a BTF-resolved pointee size of 0xfffffffc bytes. At a call site the
> caller can pass a pointer to a 4-byte stack slot at fp-4. The current
> PTR_TO_STACK path computes:
>
>    size = -(int)mem_size
>
> so 0xfffffffc becomes -4 as a signed int and the negation validates only
> a 4-byte stack range. That range is covered by the caller's stack slot,
> so the call is accepted.
>
> The callee is then verified independently with R1 as PTR_TO_MEM and
> mem_size 0xfffffffc. A small instruction such as:
>
>    r0 = *(u32 *)(r1 + 4)
>
> is accepted as being inside that BTF-described memory region. At run time,
> however, the actual argument value is still fp-4, so r1 + 4 addresses fp+0,
> outside the 4-byte object that the caller provided.
>
> Reject sizes that cannot be represented by the verifier's signed
> access-size API before the stack-specific negation. Add a verifier
> regression test for the oversized BTF argument.
>
> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Signed-off-by: Taegu Ha <hataegu0826@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

