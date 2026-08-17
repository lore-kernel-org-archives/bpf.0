Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D73AB26B
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947636; cv=none; b=KiDg/yPxROkHVY44ea+jG8mggcl8kBdg2GdzFkSVWu7efLFuN10cZ7FLMORG4Z/WFdTAad45/93E/huTG+zPjBEeHagYPXMdoyXxjRootEWJkNEyGM//xNpKk38ry7AeUI05fYpWycmxcfWhzGExfEt4KOCbBKnlqO/50X6VdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947636; c=relaxed/simple;
	bh=ZiXApMxhwMcnSZgjXgU+Hr+iwul/uOdUn6GAbgpB0KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ry/Jla2Cfede+f7Vx+BlL6gPp8BJIT+m75dbXiWlt0wyt++wun5DNqlcRsau4JCjCnaQizGu8++S7XnPTmkL4kyfsaSHjg1nsiDygMmUjrOkwGJPwtBLijIXUGoBYk/5IU8Hkz1muSB53l3BW4uHTQIxs3CxGInoLFT1ZJAy188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCCTTKZu; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCCTTKZu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZiXApMxhwMcnSZgjXgU+Hr+iwul/uOdUn6GAbgpB0KA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786947632; v=1; x=1787552432;
 b=qCCTTKZusM0N8DOUBVyPZUwTVYhq94s6Xtw/3tibj+ECxCPsQy9mWzIFNqD2xCi5ELqmf/Ar
 HytOTNQVi9ZOQETjJD4L+kymBlYIGjpLG5jgDzGdXCGT8Jb5EOgr+ubjcg9S/auP5xg5OSAM5EC
 jKbILIa8wLqxmwEVIPhMIJwg=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 154e3e38bfd820d7;
	Mon, 17 Aug 2026 06:20:32 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev>
Date: Mon, 17 Aug 2026 14:20:17 +0800
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
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/8/26 04:14, Andrii Nakryiko wrote:
> On Sun, Aug 9, 2026 at 8:01 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Similar to the tracing_multi link support for kernel functions [1], add
>> support for bpf progs.
>>
>> When attaching to bpf progs, it must attaches to the target by text poke
>> way.
>>
> 
> Please spend a bit more human effort on justification for the change
> and explaining your use case. In what case you'll be attaching to a
> large amount of BPF programs such that attachment speed-up (if there
> is any) matters.

Will update the cover letter with justification and my use case.

Here's my use case:

I'm planning to enhance the function-graph feature of bpfsnoop [1]. It
will trace all bpf progs, including their subprogs, to draw a full
function call graph including bpf prog call sites.

The attachment could speed-up when there are hundreds of targets. For
example, on high CPU core count servers, it probably runs 200 tc-bpf
progs as Kubernetes CNI, and each tc-bpf prog might have 4 subprogs.
Hence, there will be 1000 targets to trace for bpfsnoop's function-graph
feature.

With tracing_multi link support for bpf progs, bpfsnoop will be able to
attach to all targets quickly.

[1] https://github.com/bpfsnoop/bpfsnoop

> 
> Please do your homework. Generating code with AI is easy, reviewing

Sure, will do my homework.

> and making decisions about whether it's the right approach (and
> ultimately supporting it long term) is still a human process, so let's
> weigh that in.

Will keep it in mind.

Thanks,
Leon

> 
>> [1] https://lore.kernel.org/bpf/20260606123955.345967-1-jolsa@kernel.org/
>>
>> Leon Hwang (13):
>>   bpf: Initialize ftrace_managed in bpf_trampoline_get
>>   bpf: Factor out update_fentry_multi helper
>>   bpf: Drop unnecessary ftrace_location() in update_fentry_multi()
>>   bpf: Add tracing_multi link support for bpf progs
>>   libbpf: Add tracing_multi link support for bpf progs
>>   bpf: Add tracing_multi link fdinfo support for bpf progs
>>   bpf: Add tracing_multi link info support for bpf progs
>>   selftests/bpf: Add tracing_multi bpf prog attach test
>>   selftests/bpf: Add tracing_multi bpf prog attach failure tests
>>   selftests/bpf: Add tracing_multi bpf prog cookie test
>>   selftests/bpf: Add tracing_multi bpf prog rollback test
>>   selftests/bpf: Add tracing_multi bpf prog link info test
>>   selftests/bpf: Test tailcall with fentry.multi
>>
>>  include/linux/bpf.h                           |   3 +
>>  include/uapi/linux/bpf.h                      |   6 +-
>>  kernel/bpf/trampoline.c                       |  87 +++---
>>  kernel/bpf/verifier.c                         |  22 +-
>>  kernel/trace/bpf_trace.c                      | 212 ++++++++++++---
>>  tools/bpf/bpftool/link.c                      |  59 +++-
>>  tools/include/uapi/linux/bpf.h                |   6 +-
>>  tools/lib/bpf/bpf.c                           |   1 +
>>  tools/lib/bpf/bpf.h                           |   2 +
>>  tools/lib/bpf/libbpf.c                        |  39 ++-
>>  tools/lib/bpf/libbpf.h                        |   4 +-
>>  tools/lib/bpf/libbpf_internal.h               |   1 +
>>  .../selftests/bpf/prog_tests/fill_link_info.c | 170 ++++++++++--
>>  .../selftests/bpf/prog_tests/tailcalls.c      |  62 +++++
>>  .../selftests/bpf/prog_tests/tracing_multi.c  | 254 ++++++++++++++++++
>>  .../selftests/bpf/progs/tracing_multi_bpf.c   |  61 +++++
>>  16 files changed, 869 insertions(+), 120 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
>>
>> --
>> 2.55.0

