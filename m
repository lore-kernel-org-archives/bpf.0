Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA134CFCC
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973354; cv=none; b=oyPKMatCKV4y/fMGapl6wrG8PG1Hd7HwotTFO/zFinKn2YhNbbJwVDM1sitcJ1Tw6gcd9U01dC3hkoiBZXp02tkloYEiXVpQyd+SvcpL/oerhMUJu+NTQ7MKELz6Xr0OxfWnuNt5oPvJzx7i4jkT/yuYUg2szoSr9xARhH9uodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973354; c=relaxed/simple;
	bh=C3CcHTwIUdxmNWp2xQNbWACfFXPbfK/vbugzNWBytTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eY2LJPeMjAz49M8OfePTeKtsSC3QyyS7ud5I6LRPgxxh2hfyWDaItWJVWQXx3NQblu0+xpLGsINXGt8jU3amgnu64We988McXsj+J53tkqaI2GuJuuHPKcAJUMl5OqwTJZj42xcvXEwq0PgODYKtM6NPEaihi1wejnZU35Dky8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2VVjzd9; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2VVjzd9"
Message-ID: <1fcd6f57-8c09-4f66-a5fb-30615c40bf41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771973349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15vqhhJlB2nyjvlehQUoNAclVqI7YCRBU/x3BHmxoNk=;
	b=X2VVjzd94dmmtgu5yKNxrPEnY82z2uWwUFGZEd3BoeIJ5zNJUTZ9iMko6F2DMeQnFkK6WF
	CDGqQOcmQ3NwNA+V7A6ca3Bu+h6INpBTSKODGOvP+lTR7wix+N6/F4jlSYBEHaY2yHkFAr
	vwq26OsCwUZzqhmbebXdEPSLtjdvywc=
Date: Tue, 24 Feb 2026 14:49:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix flakiness of
 task_local_storage/sys_enter_exit
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 bpf@vger.kernel.org, kernel-team@meta.com
References: <20260224211202.214325-1-ihor.solodrai@linux.dev>
 <CAMB2axNHh0ihZHS6yoU9hFXsoBnARgnHBMh6+sEZnLmL3KbpbQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAMB2axNHh0ihZHS6yoU9hFXsoBnARgnHBMh6+sEZnLmL3KbpbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/24/26 2:04 PM, Amery Hung wrote:
> On Tue, Feb 24, 2026 at 1:12 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
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
>> v1->v2: reset skel->bss->target_pid to 0 before asserts (Amery)
>> v1: https://lore.kernel.org/bpf/20260224015855.1481707-1-ihor.solodrai@linux.dev/
>>
>> ---
>>  .../bpf/prog_tests/task_local_storage.c          | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>> index 7bee33797c71..1b26c12f255a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>> @@ -25,24 +25,30 @@
>>  static void test_sys_enter_exit(void)
>>  {
>>         struct task_local_storage *skel;
>> +       pid_t pid = sys_gettid();
>>         int err;
>>
>>         skel = task_local_storage__open_and_load();
>>         if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>                 return;
>>
>> -       skel->bss->target_pid = sys_gettid();
>> -
>>         err = task_local_storage__attach(skel);
>>         if (!ASSERT_OK(err, "skel_attach"))
>>                 goto out;
>>
>> +       /* Set target_pid after attach so that syscalls made during
>> +        * attach are not counted.
>> +        */
>> +       skel->bss->target_pid = pid;
>> +
>>         sys_gettid();
>>         sys_gettid();
>>
>> -       /* 3x syscalls: 1x attach and 2x gettid */
>> -       ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
>> -       ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
>> +       skel->bss->target_pid = 0;
>> +
>> +       /* 2x gettid syscalls */
>> +       ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
>> +       ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
> 
> Does tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c also
> have the same flakiness issue and should also be updated in the same
> way?

I haven't seen similar failures on CI, but that may just mean we were
lucky.

Do you know of other tests that may have the same issue?

I checked these, but only task_local_storage and cgrp_local_storage
assert counts:

$ grep -r 'skel->bss->target_pid = .*gettid' tools/testing/selftests/bpf/
tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c:  skel->bss->target_pid = sys_gettid();
tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c: skel->bss->target_pid = sys_gettid();
tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c: skel->bss->target_pid = sys_gettid();
tools/testing/selftests/bpf/prog_tests/task_local_storage.c:    skel->bss->target_pid = sys_gettid();
tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c:    skel->bss->target_pid = sys_gettid();
tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c:    skel->bss->target_pid = sys_gettid();


> 
>>         ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>>  out:
>>         task_local_storage__destroy(skel);
>> --
>> 2.53.0
>>

