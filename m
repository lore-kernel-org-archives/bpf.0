Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3BBA4D
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009698; cv=none; b=mbExdU4R/14Ip2ZSAHv6ukYv5Q13hu4HIHhGo304sc04ZaW3+ZACbAh6i75ufjYma3KiSGCMURvxD5dr6EkkEJJVS4zkoPGpdjfwDzmrkbckuYI4UJWlzikc+RL3hecdPctewDcdEBeQxBnquym15dFDm5TGMuIz/onrb8xKLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009698; c=relaxed/simple;
	bh=he0zXM3zLEJ56J/TdhSY5Jun+HgVlgQ/6LpW3ArZqSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uteou3DBnR1yXIePZuZ1H/Z3Ac+nuokd3hZsAfRe3gJJgwTwamiAcu6ZHaAUirCQ5cLxzGY8wUS7ZnDQ5OxqeEH3o0y8eQwjtR4jNSN0cegM97C1qd/bo8pI2xSUeD+5HwesdKpCA26n6WY0AMca36Umlgb3J9VhtYnMkyQr9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kvSsm6Z9; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kvSsm6Z9"
Message-ID: <40040a0e-f506-420e-ae6d-48d570234a92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710009694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXU+rWbmzxvnf4yg9ZqaJuTlTjJMdYs+BV0Nu+eRHFk=;
	b=kvSsm6Z98oA8rqVoGSTmsbiE+JVteKHXEy2iQp9GEdBzdbjCogLoBCg0YudL0iwgAdw6Yu
	svLtRGbqRQC75p0Ok9Ry9wYgFrQYqfVcVUMMnBooEWXsNZuo1K7xMYv9uYjutqw+ny4uyd
	zyzr6trISzhuZ7x8wSRNyWzf7NJ57Ho=
Date: Sat, 9 Mar 2024 10:41:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202201.3891042-1-yonghong.song@linux.dev>
 <CAEf4BzYXwKsmbj2D38DNsoi_gb-VLN1+2xXR9SqyPB6wN=S81A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYXwKsmbj2D38DNsoi_gb-VLN1+2xXR9SqyPB6wN=S81A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/8/24 4:59 PM, Andrii Nakryiko wrote:
> On Tue, Mar 5, 2024 at 12:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add link support for sk_msg program. This will make user space
>> easy to manage as most common used programs have alrady have
>> link support.
> So we have:
>
> SEC("sk_skb/stream_parser") mapping to SK_SKB/BPF_SK_SKB_STREAM_PARSER.
> SEC("sk_skb/stream_verdict") mapping to SK_SKB/BPF_SK_SKB_STREAM_VERDICT.
> SEC("sk_msg") mapping to SK_MSG/BPF_SK_MSG_VERDICT.
>
> Are those all kind of in the same category and should we support link
> for both SK_MSG and SK_SKB? I'm not too familiar, maybe John or
> someone else can clarify.

I can add sk_skb bpf_link support as well. Yes, sk_msg and sk_skb are
similar to each other.

>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h            |  13 +++
>>   include/uapi/linux/bpf.h       |   5 ++
>>   kernel/bpf/syscall.c           |   3 +
>>   net/core/skmsg.c               | 153 +++++++++++++++++++++++++++++++++
>>   net/core/sock_map.c            |   6 +-
>>   tools/include/uapi/linux/bpf.h |   5 ++
>>   6 files changed, 181 insertions(+), 4 deletions(-)
>>
> [...]
