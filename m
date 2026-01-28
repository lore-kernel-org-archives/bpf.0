Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78A36BCDB
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613798; cv=none; b=TBQIhI7vt3dWasWBRKBgla8ko/2+cnccT3DRvY0Z1WTRiYmV2Q/+SN/Bh+7OxbAyFYUZonCW+IFyrsBY1JH/7kEAWneOM9EF+kdavqoQ5IFG3f0T3/P5acOvi5xlMaMVIEb36kOyaNQm4toG4j7/oOzQrTIlHbuAtequI1XOSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613798; c=relaxed/simple;
	bh=XOMlVOkvlKgxlgeNBya+zbWzjeDUBJ6mtNj4YYkyLZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGGIVjCqkAq9zVx8NsqL6p62xuVbdeeXpSNlwwyPy4qs12RnUz96SeT4xjkX0vrXEzmSmPaYuj+JDX8mSAkTUNsrQYXmE62iqNaRFhH3grcxA436U2Wva4seB2+Uo5sFB1AdE1/bdljfdGrnQMSVWeV0YQX1PkGgBvRnIXynRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hypC56CE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hypC56CE"
Message-ID: <2a351923-5918-4735-8072-f21379e598c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769613783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BdxvFEW6II3ZaFSJ2UdJYjf5AnEnvFcdY3sGPxdVUI=;
	b=hypC56CERLVvGMchYXVBdq/dCW0eNU+X3/9xugDwepvZ5BTDXcEfntaoB/SvJSsQJW26mM
	mU6iyXhatXaoWNAAtKczD0vmhD1fTzeklkqYVpfTVRHwivpnhsIqElGZfHA1aFYrjN5Qnx
	Xy8Z2dmVcxdU5ys0sxYbX82+b+gSEaw=
Date: Wed, 28 Jan 2026 23:22:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Disallow BPF_F_LOCK with mixed
 special fields and centralize flag checks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260123055658.372869-1-leon.hwang@linux.dev>
 <20260123055658.372869-2-leon.hwang@linux.dev>
 <CAP01T77UY=FjNg9RDFQP8UYsS67gJBEsJjZBobu=Dh-fHG-+Yw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAP01T77UY=FjNg9RDFQP8UYsS67gJBEsJjZBobu=Dh-fHG-+Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/28 10:27, Kumar Kartikeya Dwivedi wrote:
> On Fri, 23 Jan 2026 at 06:58, Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Disallow combining BPF_F_LOCK with map values that contain special BTF
>> fields other than bpf_spin_lock (e.g. kptr or uptr). Such mixing may lead
>> to subtle or undefined behavior in map value handling. Reject these
>> combinations early by returning -EOPNOTSUPP.
> 
> The commit log is really suboptimal in giving context on why you're doing this.
> You should summarize the discussion from [0], otherwise unless people
> go dig that thread they'd have no clue.
> 
> Also, I would remove the 'undefined behavior' wording. It's just
> semantically different, in that the update doesn't free fields,
> but there's no undefined behavior.
> 
>   [0]: https://lore.kernel.org/bpf/CAADnVQLib8ebe8cmGRj98YZiArendX8u=dSKNUrUFz6NGq7LRg@mail.gmail.com
> 

Agreed.

The commit message needs more context. I'll summarize the prior
discussion and clearly explain why the BPF_F_LOCK + special-field
combination is being disallowed, without using “undefined behavior” wording.

> Please also increase test coverage for other maps in patch 2. Even if
> covering all local storages is not practical, we can definitely do
> task local storage.
> 
Ack.

I'll add a test to cover the change of task local storage.

Thanks,
Leon

[...]

