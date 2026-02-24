Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6B3A1CFF
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950890; cv=none; b=S0DQOVXsoGry+bW5iTtF8Vk7HKAmElv3zsILoztDBZI2fdRzrBkLnl9c7fQFMudgwgFxh2rykfgnPDeT0Ihzj3A1EoZbPqQbvu64P514iB0FH7l1dYmqodOrOzeJMUzEmjWjA2v8Z0XQL7RUCBK2NWY7KujqC7z0fzn9vmjityc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950890; c=relaxed/simple;
	bh=PFSk6JdYVDiqaPGw7FvCINBOaCx/Nla6aJ43Ex/LVf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moD/KmWTSgZu4TKwVcV3jbV1HVeHGby5AQYPQrBJwN2l6TW6YM2cr67e3Mo9QS/sq9EN7dwpnbd7mIujRDJSQ7IOJzK16MQyJu/J4xpCq2D2S1dV9wklmzhvLkC5Lkw0QM4lMh+rL34TJkM0et4v4xxv+aUMRelUShdiZ3iooh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EORBKMWG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EORBKMWG"
Message-ID: <801bd6f8-f1c3-4655-8cad-7f211979f330@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771950886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swrYw/40VhGh3BYVfDHQ3Zwen0XOVGXh01U8xdFTtnw=;
	b=EORBKMWGnWI4HAU2KTlFlVoqyb5dWw4oKl3+dCRAeaek5niwCGNvDftEZddOMpT7OQqoVq
	jGWz8SKVF3hhl2kgzGIylAf/iKcSbcZwcdQC2ZL0hpOfbiEuaivB5jqc3GsN0lMlcPW8aA
	7+F+QRjHmmA9gdr01uWHJ9x7NOztxzU=
Date: Tue, 24 Feb 2026 08:34:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix flakiness of
 task_local_storage/sys_enter_exit
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
References: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
 <87v7fmb1wy.fsf@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <87v7fmb1wy.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/24/26 7:23 AM, Mykyta Yatsenko wrote:
> Ihor Solodrai <ihor.solodrai@linux.dev> writes:
> 
>> The test_sys_enter_exit test was setting target_pid before attaching
>> the BPF programs, which causes syscalls made during the attach phase
>> to be counted. This is flaky because, apparently, there is no
>> guarantee that both on_enter and on_exit will trigger during the
>> attachment.
>>
>> Move the target_pid assignment to after task_local_storage__attach()
>> so that only explicit sys_gettid() calls are counted.
>>
>> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
>> Closes: https://github.com/kernel-patches/vmtest/issues/448
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>
>> ---
>>
>> I've been experimenting with running AI on BPF CI to investigate test
>> failures. This is an example of a thing it may come up with.
>>
>> I don't want to spam the list with these, so for starters I'll be
>> relaying only patches that I evaluated and/or tested.
>>
>> The AI generated reports will be posted with "[bpf-ci-bot]" prefix
>> here: https://github.com/kernel-patches/vmtest/issues
>>
>> The goal of this particular application of AI is to make BPF CI more
>> stable, less noisy/flaky, and potentially find and fix more kernel
>> bugs. We'll see how it goes.
>>
>> ---
>>  .../selftests/bpf/prog_tests/task_local_storage.c  | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>> index 7bee33797c71..2820a604aaa6 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>> @@ -25,24 +25,28 @@
>>  static void test_sys_enter_exit(void)
>>  {
>>  	struct task_local_storage *skel;
>> +	pid_t pid = sys_gettid();
>>  	int err;
>>  
>>  	skel = task_local_storage__open_and_load();
>>  	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>  		return;
>>  
>> -	skel->bss->target_pid = sys_gettid();
>> -
>>  	err = task_local_storage__attach(skel);
>>  	if (!ASSERT_OK(err, "skel_attach"))
>>  		goto out;
>>  
>> +	/* Set target_pid after attach so that syscalls made during
>> +	 * attach are not counted.
>> +	 */
>> +	skel->bss->target_pid = pid;
>> +
>>  	sys_gettid();
>>  	sys_gettid();

> Maybe a simpler and less fragile fix would be to add syscall number
> filter in the BPF program, so that we don't count those unexpected
> syscalls.

Why do you think this is fragile?  We are not counting the syscalls
made during attachment at all this way.

You may be right, just trying to understand.

>>  
>> -	/* 3x syscalls: 1x attach and 2x gettid */

The way the test was written, those syscalls during attachment were
expected. But the flakiness wasn't obvious.

>> -	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
>> -	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
>> +	/* 2x gettid syscalls */
>> +	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
>> +	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
>>  	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>>  out:
>>  	task_local_storage__destroy(skel);
>> -- 
>> 2.53.0

