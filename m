Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8C4C0426
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001336; cv=none; b=pq9xEIpfMk7wPREBARNlRAUeyyoCE5nwaGMtsj6N2H6VVBCztrFM55XVy41Pp+6iJx4HucSPpzB7pOfKUjHQt/JidLFB1jCCJihboZL/B4byADQYoLNP32BFHv0PlAqm2bo4g9DgoC8Itt4xrlF2kVm1lVhkSLfpU5IXBd1btKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001336; c=relaxed/simple;
	bh=ylogCBpRh7nIEOiHjeHfdVdsyeDm5W+s+wmDOc6MaoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq0eWKDp7jX78QaCHwyBC3kdJHEq7sgBv6p+lZDIiu6m7qxqgaC692z+PXj661Vq6KkM4iN/3LWXrR75CoWoFlmSiWJCIjljPkrqprtZBBcKeIyIumbv20UEPpvDYjmeutjuwfxt4YMu4ep5f9D3X7YLv4ahhpUVdVgmkqYgqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gaD5Lx1J; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gaD5Lx1J"
Message-ID: <7ebdd15e-7ea0-4806-b0f4-e4a0bfa4d910@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783001333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTdm2JBztiYqU3Zms5Vccy0DPPST/McJHOc5YW0+b1A=;
	b=gaD5Lx1Js6RPeuKo9QBF4Gqh2tHjf8SWrCf5figLt8mAIX0jNS5X/U4k16k4oJwlg/BFDk
	+o4+auXGZjsr/JqkREZE0ux0AJ13qSCiuCLqtfA47+BaI+HugVdsPvtM+hsTM9iDuW6V6t
	vPTTyo2OP48eoOPQPrl05QCSDq5udUY=
Date: Thu, 2 Jul 2026 22:08:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 5/9] bpftool: Generate skeleton for global
 percpu data
To: Quentin Monnet <qmo@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-6-leon.hwang@linux.dev>
 <a4e4adfe-4b2e-49c4-a708-89276514f930@kernel.org>
 <CAEf4BzbfA2nySpf3Oh6KVBRjDKMOOYN-NC279Sj73KwH32cGGg@mail.gmail.com>
 <ad19d283-aaab-41f1-b1a5-73de551b03a9@linux.dev>
 <80fd18b5-dc4d-4078-a236-80b8be531e22@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <80fd18b5-dc4d-4078-a236-80b8be531e22@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/2 18:14, Quentin Monnet wrote:
> 2026-07-02 14:24 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
>> On 2/7/26 03:32, Andrii Nakryiko wrote:
[...]
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 6ae7262ebe0c..798a34366e08 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
> 
> [...]
> 
>> @@ -254,7 +254,7 @@ static const struct btf_type
>> *find_type_for_map(struct btf *btf, const char *map
>>  	return NULL;
>>  }
>>
>> -static bool is_mmapable_map(const struct bpf_map *map, char *buf,
>> size_t sz)
>> +static bool bpf_map_is_skel_data(const struct bpf_map *map, char *buf,
>> size_t sz)
>>  {
> 
> 
> Yes, I think it addresses the issue, thanks! I'd maybe drop the
> "bpf_map_" prefix in the function name ("is_skel_data_map()" instead?)
> to remain closer to is_mmapable_map(), and to avoid creating confusion
> with libbpf functions names, although I don't feel strongly about it.


Makes sense. Will drop the prefix.

> You can add my ACK to this v9 for the bpftool patch when you repost the
> series.


Thanks for your review.

Leon

