Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B7372B4B
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547657; cv=none; b=Uc3zRGYq2rtnGyl+wmGfRFpt58J8fzcj1ORNS64iadghndiVa1pd/NqNxL7QHETu/3ics00Nk45XPH7eUKmq3P9usSXiFbgOSKy/TxNxjiy+iyaXtQeHdnpYmyVHlMTqChmdrlM3wvxoThg76fQXB44KfCAqz8BgodouvsEIrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547657; c=relaxed/simple;
	bh=p+4xVU1crk2PMn+VxeFjFB4dpSsdOnd05KvJdiq1MWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ascwvirlYjMBeETo1lucLNKWlUXSCdCTw1NBqSNR/bAlLLDOW8qI/jgcYrmb5U95iOcONIWgp5pHE0Ff2CGdQanGEz1wexMJB3+nJQVVRgxIn/HZsDjfdb3+Pc0X4xDFEpCtT52ugst0R+E09ufjD3o85Ks7yxoHBiPuMQPIU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hH7hF9qH; arc=none smtp.client-ip=91.218.175.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hH7hF9qH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p+4xVU1crk2PMn+VxeFjFB4dpSsdOnd05KvJdiq1MWo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787547653; v=1; x=1788152453;
 b=hH7hF9qHgBTY3zoER1cYQYMBRStKII2fjsgTdb9Ltkf4p6oVdYfzpB3fH5VfhzkaytYodRhN
 gOFBq05kF3xZqGlqf9MKA7c0qk83ZgMuAe/Y4iZxLac7V6rYMSDA6QcuZvKzVQMKmFeIZnStdH8
 KimdY8lxzbIlvr/wU4o3MZGo=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id ea6bb7775792a65e;
	Mon, 24 Aug 2026 05:00:53 +0000
X-Mizu-Trace-ID: ea6bb7775792a65e
X-Migadu-Flow: FLOW_OUT
Message-ID: <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev>
Date: Mon, 24 Aug 2026 13:00:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
 Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
 Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
 Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
 <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev>
 <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/8/26 01:46, Andrii Nakryiko wrote:
> On Sun, Aug 16, 2026 at 11:20 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 15/8/26 04:14, Andrii Nakryiko wrote:
>>> On Sun, Aug 9, 2026 at 8:01 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> Similar to the tracing_multi link support for kernel functions [1], add
>>>> support for bpf progs.
>>>>
>>>> When attaching to bpf progs, it must attaches to the target by text poke
>>>> way.
>>>>
>>>
>>> Please spend a bit more human effort on justification for the change
>>> and explaining your use case. In what case you'll be attaching to a
>>> large amount of BPF programs such that attachment speed-up (if there
>>> is any) matters.
>>
>> Will update the cover letter with justification and my use case.
>>
>> Here's my use case:
>>
>> I'm planning to enhance the function-graph feature of bpfsnoop [1]. It
>> will trace all bpf progs, including their subprogs, to draw a full
>> function call graph including bpf prog call sites.
>>
> 
> fair enough, interesting use case, definitely outline that in the next
> revision (and provide before/after attach time as well for such use
> case, please)
> 
Will include my use case.

Implemented the attachment micro-benchmark. Here's the result on an
x86_64 16c16g VM:

./bench tracing-multi-attach-progs
Setting up benchmark 'tracing-multi-attach-progs'...
tracing-multi-attach-progs: prepared 1000 identical BPF program targets
tracing-multi-attach-progs: fentry created and attached 1000
programs/links in 679.324ms
tracing-multi-attach-progs: fentry.multi created one program and
attached one 1000-target link in 470.042ms
tracing-multi-attach-progs: fentry.multi creation/attachment speedup is
1.45x

The speedup 1.45x looks good. But attaching to 1000 progs via fentry
costs less than 1 second, which is really faster than attaching to
around 1000 kernel functions via fentry:

bpfsnoop -k '*:(struct sock *)sk' -m entry -D
 Tracing 1096 tracees costs 11.597266736s

Thanks,
Leon

