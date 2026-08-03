Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F704028C4
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757370; cv=none; b=mxGJ9IxtKwxezYrNxv2/ue4nih9DjwUwp4vFVQ1et1pBZuf5/tq6uNuBVoeAvXKjNybCr2yEXFDs1rN5JI7wXEs5Ca8AamGecLNguU6xl7xB63BXW69yCHtaARYet20t5xN/8539DA2d/7OEfczIhyGkNRcJc+mqu5uefWS9BRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757370; c=relaxed/simple;
	bh=EoBJn323TIy1KMOZADmdbo1IaAhJXEp2vRvB924koCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg7g0EqlyI4mJAhJcdgBvDsz0uOIBjgGx3vRlEQT9a6xMgFQG9f8DsRF+juseX1AKmpvdaXwvIFwiniic3KEL7GYYYXlrdqXwSZEsDiGROPurkNX8rwsFsK5NjH5JrScIxZzS6+JLiMUggwToQzqOqGAF1S/vcWaWcoM8Ap7bBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S5HP9WXs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S5HP9WXs"
Message-ID: <db99502e-ddf8-42e4-beb5-65d866a820ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785757356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDaB8Vf+UkRRfG5S/URFrbambtsY/cWlKTatsH5ESA8=;
	b=S5HP9WXsgdXtiP9X1r6rvUgv9HgG6ipC2bNs1YtBcagjqgc0+irFyU5CBGP+n8B9yoDJUi
	KigEmokgZbhCX1SWLlEfSKJfYBZt95qJx/YOeXRpHOr7udQxRp3pcAGI7bw4uBJPrBz05D
	gNjVUvM/ARCwroi/9Bu/ySw7dgLi564=
Date: Mon, 3 Aug 2026 19:42:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add a test for arena fault-in
 under memory.max
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-4-jiayuan.chen@linux.dev>
 <DK9SMAEXY39E.195HV3J7GB8AI@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DK9SMAEXY39E.195HV3J7GB8AI@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/28/26 8:54 AM, Emil Tsalapatis wrote:
> On Mon Jul 27, 2026 at 2:24 AM EDT, Jiayuan Chen wrote:
>> A child joins a memcg capped at 64M and faults an arena in until it runs
>> out of the budget. Without the kernel fix the child dies with SIGSEGV on
>> a valid arena address; with it, the child is killed by the memcg OOM
>> killer.
>>
>> With the fix:
>>
>>    serial_test_arena_memcg:PASS:child killed by signal
>>    serial_test_arena_memcg:PASS:not killed by SIGSEGV
>>    #5       arena_memcg:OK
>>
>>    # dmesg
>>     arena_vm_fault+0x655/0xa90
>>    Memory cgroup out of memory: Killed process 512, file-rss:67920kB
>>
>> Without the fix:
>>
>>    serial_test_arena_memcg:PASS:child killed by signal
>>    serial_test_arena_memcg:FAIL:not killed by SIGSEGV: actual 11
>>    #5       arena_memcg:FAIL
>>
>>    # dmesg
>>    test_progs[508]: segfault at 100004025000 ...
>>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
>>   .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
>>   2 files changed, 182 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
>> new file mode 100644
>> index 000000000000..9665946fa29e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
>> @@ -0,0 +1,158 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <test_progs.h>
>> +#include <fcntl.h>
>> +#include <signal.h>
>> +#include <sys/mman.h>
>> +#include <sys/wait.h>
>> +#include <unistd.h>
>> +#include <sys/user.h>
>> +#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
>> +#include <unistd.h>
>> +#define PAGE_SIZE getpagesize()
>> +#endif
>> +
>> +#include "cgroup_helpers.h"
>> +#include "arena_memcg.skel.h"
>> +
>> +#define CG_PATH		"/arena_memcg"
>> +
>> +/* Budget the arena gets on top of whatever is already charged after load. */
>> +#define ARENA_BUDGET	(64 * 1024 * 1024)
>> +
>> +/*
>> + * cgroup_helpers builds paths from getpid(), but the work dir belongs to the
>> + * process that set the environment up. The child references it through that
>> + * pid, so build the path explicitly.
>> + */
>> +static void cg_file_path(char *buf, size_t sz, pid_t owner, const char *file)
>> +{
>> +	snprintf(buf, sz, "/mnt/cgroup-test-work-dir%d%s/%s", owner, CG_PATH, file);
> These are copied over from cgroup_helpers.c, but it's not obvious they
> originate from there. Maybe let's move them to cgroup_helpers.h where we
> can use them everywhere for consistency.

Agreed.


>
> The main issue I see is that this only triggers consistently with PREEMPT_RT, correct?


It's not RT specified issue.


> I tried with the default vmtest config we have but it does not trigger
> at all. More importantly, it doesn't trigger reliably with PREEMPT_RT,
> either. Does it for you? Can we cycle forks/frees multiple times to try
> and trigger this more reliably?



I stated vm(RT and non-RT) locally and ran test_progs 100 times and all 
tests passed.

I also used official bpf CI(non-RT) to run selftest, but still all tests 
passed...

So I'm not clear which config is associated with...
https://github.com/kernel-patches/bpf/actions/runs/30795982316
https://github.com/kernel-patches/bpf/actions/runs/30798024430
https://github.com/kernel-patches/bpf/actions/runs/30801539977
https://github.com/kernel-patches/bpf/actions/runs/30808717560


