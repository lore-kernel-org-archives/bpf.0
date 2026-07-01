Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5F224AF2
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886882; cv=none; b=c+WzA8ltZWSzgsTEHl8odVmn9YjFB7QSC/RN0AmCuGQhRNHuq8J1Jnqfz8eJS+7jLLVasyv/oVUZYPAOpRzXYcFmuQa+13GH/tp2RF9nO7aOlivkDHb8HkA+L5juVsfCYuEyvT+eg/AaehDNfIxKqhcPhHf+6zBehFr4lfDpu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886882; c=relaxed/simple;
	bh=T6VVV/sZwKH2UqabUKP3L89K2WchKWmMle57esVdtyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3KBaXIdSCX2f3jZPwqL8U5l2ZhUffpJpV9esFLYkbliT05S7F0m/gEmd2Rxlj/xlTbJ6TGx9jaIrySK/ls4YlDCA6gp8GRSDcPvSaVEQ1MmrxENieDywepwi9oc5xXUHLN4u3MtOy8PYZCDx5XjtpNO13++1KQeD17T91PuZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hqhY1jAB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hqhY1jAB"
Message-ID: <945b57b1-c2ed-44d2-8fa7-07300930783c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782886869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6VVV/sZwKH2UqabUKP3L89K2WchKWmMle57esVdtyM=;
	b=hqhY1jABygfGs3qJ4+bHhAwOBA3a0eSaaDMrYfEat8rIkzElEg1iXPu5WsneIzWRyIype+
	+E1mm5yk3AOrTdw28j3EHl+WnHj8uosW136zpVjjCXpiEqJsh5A/2TTiKHrTGipD5S15Lw
	xweA96yn808zBEJ0mfRl7k4OfX9SNJk=
Date: Wed, 1 Jul 2026 14:20:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com>
 <18678d0c-f878-4d7b-bf7e-ffca4967dec5@linux.dev>
 <DJN001X0S57Y.18CKUS4NDDQT1@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DJN001X0S57Y.18CKUS4NDDQT1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/7/26 13:50, Alexei Starovoitov wrote:
> On Tue Jun 30, 2026 at 7:59 PM PDT, Leon Hwang wrote:
>> On 1/7/26 07:12, Alexei Starovoitov wrote:
>>> On Fri Jun 26, 2026 at 8:43 AM PDT, Leon Hwang wrote:
>> [...]
>>>
>>> I don't think we need such fallback in patch [3].
>>
>> Do you mean we can add the internal BPF_ADDR_PERCPU insn support to the
>> interpreter?
>
> No. See why CONFIG_BPF_JIT_ALWAYS_ON was introduced.
> The interpreter is a security hole.

Got it. The commit message of
290af86629b2 ("bpf: introduce BPF_JIT_ALWAYS_ON config") has explained
the security concern.

> It has to be _compiled out_ of the kernel.
> Hence all patches that improve fallback to interpreter are misguided.
> The interpreter has to be removed completely... sooner or later.

Will disallow interpreter fallback for the internal BPF_ADDR_PERCPU
insn.

Thanks,
Leon
