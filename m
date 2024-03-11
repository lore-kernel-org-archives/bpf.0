Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE856B8F
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194303; cv=none; b=Ky0WDY994R4rPyLqAQqJUZbKVE5oJqwR3owU/KqY64BhYHCt2W0O52f2Hg9fkXUMvIzpLkLPraMb/WhE3RmTc23qwgOr0+urQ7M4P4aIIlwy12Fx0b4imnSNDg3FI/I3uaYrz1mcS+NScl5Dvc92POenIvVygdZSnrc+AH5rAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194303; c=relaxed/simple;
	bh=DwBxF/sQa7my6LaXNH28mv7/9qc6hMl3yBd5VyN90Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlXsqD9K/lTtpajzHFmTVhT+DAw0oNa8nsVmggVtGg1HQI/fRvKyZAv8oH5yYoJtPneW9p/vHXwyxm9CLEoT+EJ7XFnVOOdtgmvHIhP1pSmLXgMyIlfIkyZlG6VdT0yZAGYvDvW0k51QWc/8cCFAinNWM91Z9aCT52sflDU1xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8PBIffc; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8PBIffc"
Message-ID: <3ea1a77e-75d4-41ef-b745-ff101b1918a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710194298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwBxF/sQa7my6LaXNH28mv7/9qc6hMl3yBd5VyN90Co=;
	b=p8PBIffcklhPN0eKX7UTB14GsT7ejvYXrZlFeL8BKrWpa51nXhoAo/ppdcXf+ZX+Sm+Rtc
	sl+8y7+OziQ5yB4Ve8sy8BHq4GgmnFgirBX3t8b3bZvERZDH2Ggch8edU4du3KrF0OpTQu
	2hpo0OJq7GPjTJdX255oMpnlzGRcd0A=
Date: Mon, 11 Mar 2024 14:58:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: Add link support for sk_msg prog
Content-Language: en-GB
To: Jakub Sitnicki <jakub@cloudflare.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202201.3891042-1-yonghong.song@linux.dev>
 <CAEf4BzYXwKsmbj2D38DNsoi_gb-VLN1+2xXR9SqyPB6wN=S81A@mail.gmail.com>
 <878r2pswie.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <878r2pswie.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/10/24 12:23 PM, Jakub Sitnicki wrote:
> On Fri, Mar 08, 2024 at 04:59 PM -08, Andrii Nakryiko wrote:
>> On Tue, Mar 5, 2024 at 12:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> Add link support for sk_msg program. This will make user space
>>> easy to manage as most common used programs have alrady have
>>> link support.
>> So we have:
>>
>> SEC("sk_skb/stream_parser") mapping to SK_SKB/BPF_SK_SKB_STREAM_PARSER.
>> SEC("sk_skb/stream_verdict") mapping to SK_SKB/BPF_SK_SKB_STREAM_VERDICT.
>> SEC("sk_msg") mapping to SK_MSG/BPF_SK_MSG_VERDICT.
>>
>> Are those all kind of in the same category and should we support link
>> for both SK_MSG and SK_SKB? I'm not too familiar, maybe John or
>> someone else can clarify.
> We also have the most recent SK_SKB/BPF_SK_SKB_VERDICT [1], which is
> what one would use instead of SK_SKB/BPF_SK_SKB_STREAM_* prog pair when
> chopping the stream of bytes into frames is not needed. For instance,
> because we're redirecting from a UDP socket.
>
> I have a cheatsheet that clarifies in which redirect-with-sockmap
> configuration what program type + attach type is used [2].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a7ba4558e69a3c2ae4ca521f015832ef44799538
> [2] https://github.com/jsitnicki/srecon-2023-sockmap/blob/main/sockmap-cheatsheet.png

Thanks. I will take a look. Yes, agree, we only need to implement
the recommended one, which is SK_SKB/BPF_SK_SKB_VERDICT if I understand correctly.

