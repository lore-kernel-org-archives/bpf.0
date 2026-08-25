Received: from mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E049362B
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787634942; cv=none; b=UFo8zN8Ppbk2YuY0hU1LfU7XZPWtqaOdj9QAjPHJbbJLYLBQd1/ctw5AHpfPP2T7KJlXCBLQfQaZC5HUXNMReQKkwddTaeyeux1JOSDzu6jukT9gB4s+L4tXVNZe5SfMUYkXmRcHizElLbIykDqpslKChdH1AINSD9tG0g5vJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787634942; c=relaxed/simple;
	bh=ycU45ByNsgHHDtVWA4mXYRQ4N25WsNGqUmcu/vjY5q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLc6S8pWdRnQZtp/tYlGqDIPF2Bvf/0SbUIZi2Q9WpkzwP05yTf+tDavjyUQ32x76yqrsCVR5FG2RCFNZwtxKJAVYF7Yutkq63r7V6xXv93w+EaMFTcbgtJwcTub37b7T/6i3+Ee/AYfZ3nbTmklnJRzot2EIf1uXNZLm8AdMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvvhJI3R; arc=none smtp.client-ip=91.218.175.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvvhJI3R"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ycU45ByNsgHHDtVWA4mXYRQ4N25WsNGqUmcu/vjY5q8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787634937; v=1; x=1788239737;
 b=EvvhJI3R3guGGlRj9hKGkJUOsWa4c4qUnDtpySWZtFAnQH/Wyt8IDRpb+c8FoidYlYIncK3c
 cyEZogLD2i76MENcoseG2N42xzkN7HGPve4WIczaBhNkEV7hrOJTgYwlh5+4ktEYZcLT9V16gjr
 N32jBSNL11VzNyU3kWK1LZ8M=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 4cf59cd3d753658a;
	Tue, 25 Aug 2026 05:15:37 +0000
X-Mizu-Trace-ID: 4cf59cd3d753658a
X-Migadu-Flow: FLOW_OUT
Message-ID: <7f18980c-0c15-4862-af1f-f451ca12dac5@linux.dev>
Date: Tue, 25 Aug 2026 13:15:23 +0800
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
 <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev>
 <CAEf4BzZpB-qkhu3SAu5MrYYAT2+ZN8WaXqpmnKruOOdjJOLK2A@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZpB-qkhu3SAu5MrYYAT2+ZN8WaXqpmnKruOOdjJOLK2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/8/26 04:02, Andrii Nakryiko wrote:
> On Sun, Aug 23, 2026 at 10:00 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 22/8/26 01:46, Andrii Nakryiko wrote:
>>> On Sun, Aug 16, 2026 at 11:20 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> On 15/8/26 04:14, Andrii Nakryiko wrote:
>>>>> On Sun, Aug 9, 2026 at 8:01 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>>>
>>>>>> Similar to the tracing_multi link support for kernel functions [1], add
>>>>>> support for bpf progs.
>>>>>>
>>>>>> When attaching to bpf progs, it must attaches to the target by text poke
>>>>>> way.
>>>>>>
>>>>>
>>>>> Please spend a bit more human effort on justification for the change
>>>>> and explaining your use case. In what case you'll be attaching to a
>>>>> large amount of BPF programs such that attachment speed-up (if there
>>>>> is any) matters.
>>>>
>>>> Will update the cover letter with justification and my use case.
>>>>
>>>> Here's my use case:
>>>>
>>>> I'm planning to enhance the function-graph feature of bpfsnoop [1]. It
>>>> will trace all bpf progs, including their subprogs, to draw a full
>>>> function call graph including bpf prog call sites.
>>>>
>>>
>>> fair enough, interesting use case, definitely outline that in the next
>>> revision (and provide before/after attach time as well for such use
>>> case, please)
>>>
>> Will include my use case.
>>
>> Implemented the attachment micro-benchmark. Here's the result on an
>> x86_64 16c16g VM:
>>
>> ./bench tracing-multi-attach-progs
>> Setting up benchmark 'tracing-multi-attach-progs'...
>> tracing-multi-attach-progs: prepared 1000 identical BPF program targets
>> tracing-multi-attach-progs: fentry created and attached 1000
>> programs/links in 679.324ms
>> tracing-multi-attach-progs: fentry.multi created one program and
>> attached one 1000-target link in 470.042ms
>> tracing-multi-attach-progs: fentry.multi creation/attachment speedup is
>> 1.45x
>>
>> The speedup 1.45x looks good. But attaching to 1000 progs via fentry
> 
> I'd say "meh". If 500ms is ok, 700ms is not that much more noticeable.
> 
Besides the attachment speedup, this series provides a way to attach to
multiple bpf progs via one link. The current revision reuses the
ftrace-based attachment, which relies on
CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS. In the next revision, it will get
rid of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS with its own attachment
implementation. Hence, this series will be able to run on those arches
that have trampoline support.

Thanks,
Leon

