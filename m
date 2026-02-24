Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24206366DD2
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952549; cv=none; b=uWm48xck5E9MCUYs08arnV1n84yUJThRt36GxeBpy2oIzsJ/tlhc3/X004299Wyho8pQWp0TJMGv9QEZD1894eRqd+idXajt+Gr96+FaV//AF50otrJ6IOsd2rjc6x4mpRMRMVgulZLAXDWRfxueMFZoVSaSEzw8NoKrPCP5azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952549; c=relaxed/simple;
	bh=lwuxtUGXS5At4Zo5zoD9w/0LHBQ2Bi3pUFJciVrq1c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cs0CiaCjERKAhsCo77E0iGL+8zWOeIEAnmF0+83kXMvddskxRdKZTk6PF1LtSfvUOQ3DpYnosXo5NvsDd0b5vRllzVAlpWrl4g84iaR7H7K8/QqHcXhNbsHnQK20HryRhZl15IuK30m/CWFe/yvHdZWA2+YRm3LSRFihb3wrnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEPDeJcn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEPDeJcn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48372efa020so46254265e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952546; x=1772557346; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2k18aHuVRi+6dZJX179RO1yv9AWq8+38Oh+vZDrw5Q=;
        b=XEPDeJcnwB7NGWYkWVlGDi9PrqgXLl8H6Ie6b6c1jcvxvV56qC0OnlRJk8w3l19oSJ
         pGiyLPH4UhmHe+PIGLhwSMn1T8abRgDcYl9jBa7PxoFH5YLMEs23j5uqliupffpJiUtr
         Dt24zU4l4paOaTwsk5Z8VeB01topfnkBThh/vFWfKUqKz0PhlgmHBFV+vSMSAsF7OxUX
         LRBP3urRqM+GcJqA8d6Ky/Fr3yXYwooD85y2F7rUZM3C6JVkWylRhlQXNQGH6vAJAuwU
         yLjmAlgFVEs2vCVKMYalPLCvdpRFIgIJ0nVSQngnYcXxii/lDG3XLMbu9gNvGiZhNuHD
         2vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952546; x=1772557346;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2k18aHuVRi+6dZJX179RO1yv9AWq8+38Oh+vZDrw5Q=;
        b=T5Kb086VxYOfp2+BpEWLHu6qEMEz+dygIaftBEs7CET5dIPOksJCadv0oqwa94twc+
         ONqIb18U1tZ6bjZBoG5pnWnfmUYuBKvMQQeqNxsY2wK50txyKhSco2AMQiWTljhVEMXl
         oUW/kCe+GEscIpip1DYNiVCBdb2xXFVaXcCQtqaTtL3sJX7F96rrOnPUNMJ16+Ounos4
         r7G6hKM14a38w7JU19/PdSHNj5L5ohL69pLC2G/+uF4MtKUjaOBVHPrmrtKZcvlsO7BK
         o7X/4Q+MeWaNpNLkMNbDpVY9IA/36XCDCW+3AAj4oH1UsCyJrv4TPRSCU+bczvEUes0e
         CdRg==
X-Gm-Message-State: AOJu0YyuooOIZlrQ6I/kAJQ4SQE290pOUKE8naZDVZp4fnm8sJpZhBei
	Iqk318mfBoLYZbXH67HuavEm3Pe0oHldgOrQgbpgzKbGSK88QVtn+Bhy
X-Gm-Gg: AZuq6aKKWimxYZIg9DwTm9f7ENBjkkcSzAWJrKv5P/TkN9C+45xZud5++4gupxzSoeV
	zVvDlSOjwPzYyV99mimCD43hpyknLcv3PU7lJo9YIcSjHqCyYkLHDorQr5nQ2I0XaTsYtilNUSx
	h7wBq8cBgrsGtjISGh1gb+qbSKKlxQiGeGJ/sbeuXatffTIQ0u/0Ms8Kxl7EwlIEbzb8jtpS7st
	IOHCixGn0phIBBw/6Bagr9mQaIzCaOoD/pzFKo0Of85nRQj6wChhChv+98cON1u3IT7d9fR7QEw
	MGTXbPFN68DSQdwDDnCV93V9lahucmf7jYz2iF48l6VJ4YTCJ8EzentXrs54MmKTrLTu97ijMXd
	60NGAfTwVzg1CTxnBNt7PQPWYVMlqsydDwSeLW9yEXz9Pzf02zqHHfrV/yKNr2CAM9u1FilBMm5
	8QLA/3huChRq0KlKlYFJ5J42uxElqbCw==
X-Received: by 2002:a05:600c:5020:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-483a95fc1d3mr229884765e9.12.1771952545897;
        Tue, 24 Feb 2026 09:02:25 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:95aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm8421155e9.5.2026.02.24.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:02:25 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Amery Hung
 <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix flakiness of
 task_local_storage/sys_enter_exit
In-Reply-To: <801bd6f8-f1c3-4655-8cad-7f211979f330@linux.dev>
References: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
 <87v7fmb1wy.fsf@gmail.com>
 <801bd6f8-f1c3-4655-8cad-7f211979f330@linux.dev>
Date: Tue, 24 Feb 2026 17:02:24 +0000
Message-ID: <87ecma6pnj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> On 2/24/26 7:23 AM, Mykyta Yatsenko wrote:
>> Ihor Solodrai <ihor.solodrai@linux.dev> writes:
>> 
>>> The test_sys_enter_exit test was setting target_pid before attaching
>>> the BPF programs, which causes syscalls made during the attach phase
>>> to be counted. This is flaky because, apparently, there is no
>>> guarantee that both on_enter and on_exit will trigger during the
>>> attachment.
>>>
>>> Move the target_pid assignment to after task_local_storage__attach()
>>> so that only explicit sys_gettid() calls are counted.
>>>
>>> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
>>> Closes: https://github.com/kernel-patches/vmtest/issues/448
>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>
>>> ---
>>>
>>> I've been experimenting with running AI on BPF CI to investigate test
>>> failures. This is an example of a thing it may come up with.
>>>
>>> I don't want to spam the list with these, so for starters I'll be
>>> relaying only patches that I evaluated and/or tested.
>>>
>>> The AI generated reports will be posted with "[bpf-ci-bot]" prefix
>>> here: https://github.com/kernel-patches/vmtest/issues
>>>
>>> The goal of this particular application of AI is to make BPF CI more
>>> stable, less noisy/flaky, and potentially find and fix more kernel
>>> bugs. We'll see how it goes.
>>>
>>> ---
>>>  .../selftests/bpf/prog_tests/task_local_storage.c  | 14 +++++++++-----
>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>>> index 7bee33797c71..2820a604aaa6 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
>>> @@ -25,24 +25,28 @@
>>>  static void test_sys_enter_exit(void)
>>>  {
>>>  	struct task_local_storage *skel;
>>> +	pid_t pid = sys_gettid();
>>>  	int err;
>>>  
>>>  	skel = task_local_storage__open_and_load();
>>>  	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>>  		return;
>>>  
>>> -	skel->bss->target_pid = sys_gettid();
>>> -
>>>  	err = task_local_storage__attach(skel);
>>>  	if (!ASSERT_OK(err, "skel_attach"))
>>>  		goto out;
>>>  
>>> +	/* Set target_pid after attach so that syscalls made during
>>> +	 * attach are not counted.
>>> +	 */
>>> +	skel->bss->target_pid = pid;
>>> +
>>>  	sys_gettid();
>>>  	sys_gettid();
>
>> Maybe a simpler and less fragile fix would be to add syscall number
>> filter in the BPF program, so that we don't count those unexpected
>> syscalls.
>
> Why do you think this is fragile?  We are not counting the syscalls
> made during attachment at all this way.
I think it's more fragile if we add some code after sys_gettid() that
makes syscall or for example ASSERT_EQ makes one. Another example: if
someone decides to debug this test case and adds printf. I suggest to
tighten up the condition in the BPF program, so potential changes in the
user space have less chances breaking things.
I'm fine with your change, as it fixes the flakiness, but it is not
ideal in my opinion if we use this approach in more tests widely.
>
> You may be right, just trying to understand.
>
>>>  
>>> -	/* 3x syscalls: 1x attach and 2x gettid */
>
> The way the test was written, those syscalls during attachment were
> expected. But the flakiness wasn't obvious.
>
>>> -	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
>>> -	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
>>> +	/* 2x gettid syscalls */
>>> +	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
>>> +	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
>>>  	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>>>  out:
>>>  	task_local_storage__destroy(skel);
>>> -- 
>>> 2.53.0
