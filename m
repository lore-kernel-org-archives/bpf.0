Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E957302
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194014; cv=none; b=QAfDhSf0XAenR1hdf9yNSxcEi6c1Z0nYoSbjaDTAHBxbb/ro3gi7Dxf72d7Z84CelmJtvLmT7GNm2S4NqjRM8oVZOA7f+GPPsPpWXiK2znq4kAliqy/xZ4oh3JmNru2W7SRCClUox/xc5yCIy2EVAn+KziGDG3g5SzFw5QIvErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194014; c=relaxed/simple;
	bh=oWNBWJo4Hu89X5Mk2w3iLpzBDBPdrCjvgLF2FytvUQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgxV/sBwGpqKSUjwG9v/KQ1AbDlkwdqHWhfRNsitVfAD2Jb/P8Miwbyq0k7ygpVR3pN3tDFH38qA+vJerpVtnb6kz7pfAink1tk5bKLmEztWtSLesiqDVvFRJGJFzK+fsPOdLrYf/zu3fq3KuanZr4OLGt4jc3LUJeVY0wj2y0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qY+S3vqg; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qY+S3vqg"
Message-ID: <e4b25a0d-00b8-400d-a92d-079d7540ac4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710194011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1SrCVQbvJN0sIZQN5sZCapAjZ6BjZlLM235ehjHmGk=;
	b=qY+S3vqgTq5Gn/YMHUChWo5l5qBylCpL1fax6ba/esnboDUM5CBxubOUZWG9xAVC1QsCLJ
	9vAT8EuTEZdXIJpsWTSj1FuXCeq0hZznNu8pCpI9rDb2NO2YpFrvEX0ST6ytAIXWnrtr+N
	pdGVMl7kcK8yUHOmNuJGzv6uAsA0aBE=
Date: Mon, 11 Mar 2024 14:53:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/5] Add bpf_link support for sk_msg prog
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <87jzmarkut.fsf@cloudflare.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87jzmarkut.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/7/24 5:01 AM, Jakub Sitnicki wrote:
> On Tue, Mar 05, 2024 at 12:21 PM -08, Yonghong Song wrote:
>> One of our internal services started to use sk_msg program and currently
>> it used existing prog attach/detach2 as demonstrated in selftests.
>> But attach/detach of all other bpf programs are based on bpf_link.
>> Consistent attach/detach APIs for all programs will make things easy to
>> undersand and less error prone. So this patch added bpf_link
>> support for BPF_PROG_TYPE_SK_MSG.
>>
>> I marked the patch as RFC as not all functionality are covered
>> by tests yet, e.g. update_prog(). Maybe somebody can suggest
>> an existing test which I can look into.
>> Or maybe some other tests need to be added as well.
> I have a general remark, not specific to this work.
>
> We can't attach with links from CLI, apart from when auto-attach is
> supported.  `bpftool prog attach` doesn't use bpf links. For instance:
>
> bpftool prog attach \
>          pinned /sys/fs/bpf/test/sk_msg_prog \
>          sk_msg_verdict \
>          pinned /sys/fs/bpf/test/sock_map
>
> Is there a plan for the CLI tooling to support it?

As far as I know, there is no plan to support this. Of course, somebody
could try to implement this ...

