Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB127FB2A
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355653; cv=none; b=TPUgcmSPZ2nl2jgM6jiEvSme6LKwQnCHZHUUHbfoibLRM7BDBArXHalLf0JhMkacG+jcJG60NhRm/70eijef6JhC70q0Ht6nztTZey6CgK/q7WVdqXk6Wc+Pl3yTuNhKYkr9rHZcneYu4K1OlmqqaIidwjQF4LvRQwGAAqrCYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355653; c=relaxed/simple;
	bh=ekZ5hEH2mFMqQume6ySdjrLotZSjBf5heSdddEZljjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JI4g9HUIZ9SLlizzC6aWAWSFvrKQm5ryXEps8q4jkv1AtrOd8Ix3TBRI0+UbuPMYCx+kAEuziA3jo1ahDriIvrWkwzQWw35IgcxxUCVt+K7tMxToI6xZQfd6cuVCDZREMS3z0nKKa3WL7mz84Bk6Ko9ULnJd/af1vw9YsJZ67Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLByWqDB; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLByWqDB"
Message-ID: <d6bc3f2e-baab-480c-aa45-7c7ee9ba9f92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782355640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcvEdPoWwW8h6fIjkmybDFsWwjAoRy7aNjzn3vle93k=;
	b=eLByWqDB0l83nQU3jBECHR+LKGMHZ0Bw5Lux0p1+5KL/IwN2ugtwMNg0+w9LEhRJlD6OFN
	zhZFY3ayeN3ujdnvhJkwE29K8uQ8O3BGN4AkomTSBkwT6UZ4+WADS+zJU0YUfocuiClu/t
	dnIsV+vAW2ufGBOfMOvzjPzzYMjHMMM=
Date: Thu, 25 Jun 2026 10:47:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 07/11] bpftool: Generate skeleton for global
 percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-8-leon.hwang@linux.dev>
 <CAEf4Bzay2Wssj1J4fEq3T7iTOBDswEZunm1OQNDJvPr2Cz2Usg@mail.gmail.com>
 <2330e6a8-c7eb-4296-8aa0-feaafd6b09cf@linux.dev>
 <CAEf4BzaiYCAqSQgxeEv=8tmtNLYaghj8OBmRJdUDiUm2AKAwSg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaiYCAqSQgxeEv=8tmtNLYaghj8OBmRJdUDiUm2AKAwSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/6/26 00:47, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2026 at 9:15 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Makes sense.
>>
>> With adding the helper bpf_map_is_skel_data(), will this change looks
>> more readable?
>>
>>
>> +static bool bpf_map_is_skel_data(const struct bpf_map *map)
>> +{
>> +       return bpf_map__is_internal(map) &&
>> +               ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
>> +                bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY);
> 
> if (!bpf_map__is_internal(map))
>     return false;
> 
> return (bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
> bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY;
> 
> or just split that last return into two if (...) return true);
> 

Will follow your suggestion, and use two if (...) return true.

Thanks,
Leon

> both work for me
> 
>> [...]
