Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B136680E
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701268; cv=none; b=jgzwYSAzBYfAl1a6UEWBhydajzV/A1Eft5K1/Y8tPHsvD9ZUP3t+beCZCkdFw0Zh5+ujLpmp8gfKgnqriAcoq7rRT+Oz0dQ6BYQV9c7EtxFLqDU+Hgksbl/HhNxVaNaXCZZ5rkSCqozZGG1CrNSEnhKCpDDBQVJTR0baFS6jvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701268; c=relaxed/simple;
	bh=RuB5+pd2Nu5pchRK3PaPGzH/A7+qlSYVQ+ZHYCAMe28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qysE1FBVuHwjIZAYqHjrnccTpo43ipxbe0M5+WxYi3Hgg2y6HziMy5TCuMMdPhU8CLC82XvCajSiTDpPgiwyaqtRqXHWg5yxUuTjjg2jBUf1FxB7xxFHX8D1WsiIxMNUlJoVUlDOL95lLDfv9fgiIKWGlTh5DIn48iimLBqQecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CjSfQEvm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CjSfQEvm"
Message-ID: <2034cfa0-839a-4ce8-bc67-89daf4089bce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775701264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRaSmDYd/xGobYcS16a8Z5SJsKmMXmBfzHmKSeJwECw=;
	b=CjSfQEvmCsxlMP5z4pG7Y9DGtV7/XPIxj71rOHJCzaN+XrLxwcvDOTF0jxM3iUXus3chzs
	WzZkk52Xu/hHJvBX2hH8t0fL3Vp/5RDqZ6KHPyJTiQ+LtSVg5K6lAR2s2WLsgzC0quz8cG
	sxdZgBC2nQCq1JbWzOn7PDpORE4GW2o=
Date: Thu, 9 Apr 2026 10:20:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix use-after-free in offloaded map/prog info
 fill
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260408104732.259683-1-jiayuan.chen@linux.dev>
 <1eccd7fc-8a1c-4499-ae81-a63fc8d0ff26@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <1eccd7fc-8a1c-4499-ae81-a63fc8d0ff26@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/9/26 5:49 AM, Daniel Borkmann wrote:
> On 4/8/26 12:47 PM, Jiayuan Chen wrote:
>> When querying info for an offloaded BPF map or program,
>>
[...]
>> zero, which causes ns_get_path_cb() to fail and the caller to return
>> -ENODEV -- the correct behavior when the netns is being destroyed.
>
> nit: -ENOENT
>
>> Fixes: 675fc275a3a2d ("bpf: offload: report device information for 
>> offloaded programs")
>> Fixes: 52775b33bb507 ("bpf: offload: report device information about 
>> offloaded maps")
>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>> [...]
>> +        net = maybe_get_net(dev_net(aux->offload->netdev));
>> +        if (net) {
>> +            ns = &net->ns;
>> +        } else {
>> +            ns = NULL;
>> +        }
>
> nit: ns = net ? &net->ns : NULL;
>
>>
[...]
>> +        }
>
> ditto, otherwise looks good to me
>
>>       } else {
>>           args->info->ifindex = 0;
>>           ns = NULL;
>

  Thanks for the review!

  Both nits are valid -- will fix the commit message to say -ENOENT and
  simplify to ternary in the next version.

