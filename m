Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612D134AB
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895951; cv=none; b=QUKcRnSn5qdHST5AR0mtYKSQRBWzFG/TvG+Rjb20p+Doa1zswsGL2kY2upAIfBoO+kjxxCzGHB58SPZEuTPl+0+b+avQFSbfTDmNfQqHQ4J+vmnamYJ4bR0i4d5+G4bEyHCTcWfgLe6YIWeB8BjUfbOUFVya3xMxHE3T+uZhbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895951; c=relaxed/simple;
	bh=fE8pMWjAksMHdfX0S9AmaIggeMshbq+MW66UB9Ejy0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLDt5sCS7AmMc+yfWlLNVdmAz3Xke9qRMeLqGI7q1duKN2ikN/APMLfTITwRrzacC3OIdZ5IOa8VjORruXxSxz96P9NSHLOPgDHQOYHielRrytqcas+QZc8SyH/A7ss31yiGekhX0JoSo8eGDlprG5S8vdJJturZ1++ojSOxNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCbVCsDQ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCbVCsDQ"
Message-ID: <39249ae4-4170-4a5c-8923-6e63fcbfe729@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710895947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1JhMiy1HQIyFsCzmpcBBC7/BM4+FAtmWtiXx1FxqsQ=;
	b=qCbVCsDQi3hby6cpGWKcCvwkcxmCeExVMYXqsoR9a4MuM9iRBV6EmXPL0lmptSXf89S6y7
	PtPan7OU47jo7cEt8A4N68WuXrjuB5wc1ant/TSomHlYC4yyc0/Uvco7KwVGTIVs69PSC4
	NhBNC7fBqqCCyENIpupjXiyl/KoNyos=
Date: Tue, 19 Mar 2024 17:52:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: Replace CHECK with
 ASSERT_* in ns_current_pid_tgid test
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Yury Namgung <ynamgung@meta.com>
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
 <20240315184859.2975543-1-yonghong.song@linux.dev> <ZfgnLQ5ytpU2IcUX@krava>
 <2af81b55-4be4-4936-a42e-940786c45877@linux.dev>
 <CAEf4BzYWoe1DEOFsXe4=fx+2ceFKEc8ASW5Jt002jOHkErxqHQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYWoe1DEOFsXe4=fx+2ceFKEc8ASW5Jt002jOHkErxqHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/19/24 2:52 PM, Andrii Nakryiko wrote:
> On Mon, Mar 18, 2024 at 8:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 3/18/24 4:36 AM, Jiri Olsa wrote:
>>> On Fri, Mar 15, 2024 at 11:48:59AM -0700, Yonghong Song wrote:
>>>> Replace CHECK in selftest ns_current_pid_tgid with recommended ASSERT_* style.
>>>> I also shortened subtest name as the prefix of subtest name is covered
>>>> by the test name already.
>>>>
>>>> This patch does fix a testing issue. Currently even if bss->user_{pid,tgid}
>>>> is not correct, the test still passed since the clone func returns 0.
>>>> I fixed it to return a non-zero value if bss->user_{pid,tgid} is incorrect.
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    .../bpf/prog_tests/ns_current_pid_tgid.c      | 36 ++++++++++---------
>>>>    1 file changed, 19 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
>>>> index 24d493482ffc..3a0664a86243 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
>>>> @@ -20,19 +20,19 @@ static int test_current_pid_tgid(void *args)
>>>>    {
>>>>       struct test_ns_current_pid_tgid__bss  *bss;
>>>>       struct test_ns_current_pid_tgid *skel;
>>>> -    int err = -1, duration = 0;
>>>> +    int ret = -1, err;
>>>>       pid_t tgid, pid;
>>>>       struct stat st;
>>>>
>>>>       skel = test_ns_current_pid_tgid__open_and_load();
>>>> -    if (CHECK(!skel, "skel_open_load", "failed to load skeleton\n"))
>>>> -            goto cleanup;
>>>> +    if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open_and_load"))
>>>> +            goto out;
>>> you could just return in here so there's no need for the out label
>>> otherwise lgtm
>> Since this patch intends to just replace CHECK with ASSERT_*.
>> I tried to keep other parts of codes the same as before. But
>> I can certainly do this. I will wait for other comments
>> before sending another revision.
>>
> I applied it as is, but feel free to send suggested improvements as a follow up.

Thanks! Will send a followup later.

>
>
>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>>
>>> jirka
>>>
>>>>       pid = syscall(SYS_gettid);
>>>>       tgid = getpid();
>>>>
>>>>       err = stat("/proc/self/ns/pid", &st);
>>>> -    if (CHECK(err, "stat", "failed /proc/self/ns/pid: %d\n", err))
>>>> +    if (!ASSERT_OK(err, "stat /proc/self/ns/pid"))
>>>>               goto cleanup;
>>>>
>>>>       bss = skel->bss;
>>>> @@ -42,24 +42,26 @@ static int test_current_pid_tgid(void *args)
>>>>       bss->user_tgid = 0;
>>>>
>>>>       err = test_ns_current_pid_tgid__attach(skel);
>>>> -    if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>>>> +    if (!ASSERT_OK(err, "test_ns_current_pid_tgid__attach"))
>>>>               goto cleanup;
>>>>
>>>>       /* trigger tracepoint */
>>>>       usleep(1);
>>>> -    ASSERT_EQ(bss->user_pid, pid, "pid");
>>>> -    ASSERT_EQ(bss->user_tgid, tgid, "tgid");
>>>> -    err = 0;
>>>> +    if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
>>>> +            goto cleanup;
>>>> +    if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
>>>> +            goto cleanup;
>>>> +    ret = 0;
>>>>
>>>>    cleanup:
>>>> -     test_ns_current_pid_tgid__destroy(skel);
>>>> -
>>>> -    return err;
>>>> +    test_ns_current_pid_tgid__destroy(skel);
>>>> +out:
>>>> +    return ret;
>>>>    }
>> [...]
