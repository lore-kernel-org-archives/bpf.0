Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB25136358
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696717; cv=none; b=eMrYfFqj1q8lpGxMTuoUNWBzw+PGP+hr2+O4rNXMT4xO7vviWdmPuc8yYdhuOfZyYxJ9aGFLdRyDpKo3iKYI8aoV5e6M+5mc++3f4vUnElbqP5eMx8QTWd5FlwdNErWhVgrVbI/aDc8Ae49pOdj09xjKUw5tgYxPxNDgBJ379bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696717; c=relaxed/simple;
	bh=wbx719+hcKisxWjP4rWXbwjuiLxXrdoJo31gb+Uf2nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWpLOdv7874CVF1iFSY/eaSWC9wUmfcm396Z1r3moAjDVsHfZJ/DVg9IgpR9dGaEIHPUVVwvIKMnY8vR/NyhwL97U7ALkobB52vncBetyViz8Mu+Wv9j/+R1mqfI0+r2nBXHZkD/pnb+SFMKOtPMefz9nc0KvP8Q3cJPpngcuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UyBXG1mr; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UyBXG1mr"
Message-ID: <9beb3bb9-3d11-4ee1-b51d-b80870051b5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783696714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQYY0PfYPWRE+QVtqlTaAeUHkZgECaALx1Y8KnNkfos=;
	b=UyBXG1mrSfkwb+ogA3DftHntqVX1NeyBNmpAZrDUEvlWkDE6e1Ki7G+nQRqv5LBQRhovr+
	lHELerUV959Fu+5rgajzKkIsItaUEaPFfPQ5fo9q3RsG6EQ3nEvpRJgpSrptFcQoMsz+Qf
	/YqFGgB+V4GxonGEv+sWwaDd32kgtqA=
Date: Fri, 10 Jul 2026 08:18:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 00/12] bpf: Support 16-byte return values in the
 R0:R2 register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <b364ef0ad5425d97180220af23be238a4c4281d7.camel@gmail.com>
 <29c790dc-2e14-4ffe-8231-db8dba4de0c1@linux.dev>
 <531d227058b25adf099dbeb467d32507b95d8062.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <531d227058b25adf099dbeb467d32507b95d8062.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 11:13 PM, Eduard Zingerman wrote:
> On Thu, 2026-07-09 at 23:00 -0700, Yonghong Song wrote:
>>
>> On 7/9/26 5:56 PM, Eduard Zingerman wrote:
>>>> On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:
>>> A design question regarding to how this series handles local
>>> functions:
>>> - It relies on the BTF gate to decide if function returns multiple values.
>>> - It also prohibits local functions from returning pointers as a part
>>>     of an aggregate return.
>>>
>>> I think this unnecessarily adds an additional discrepancy between how
>>> the return values are handled. The practical experience shows that
>>> existing differences between local and global functions are already a
>>> constant source of pain and confusion.
>>>
>>> I'd also argue that lifting the above limitations for local functions
>>> would make the implementation somewhat simpler.
>>>
>>> Therefore, I suggest to:
>>> - forgo the BTF check for local functions;
>>> - always copy r2 from callee to caller at EXIT
>> Not sure about this. If r2 is always copied from callee to caller, and
>> interpreter still only supports return r0, then this will imply interpreter
>> will never be used? I know interpreter will be eventually removed, but
>> at this point, people still use interpreter?
> We can detect this statically from compute_live_registers().
> If any r2's are alive after a function call the jit_required flag can be set.

Sounds good, I will do some investigation on this.

>
>>> - forgo the scalar struct requirement for local function
>>>     return types.
>> I think this is doable.
>>
>>> Wdyt?

