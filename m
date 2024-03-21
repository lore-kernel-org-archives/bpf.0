Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61974F4FA
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052166; cv=none; b=Aj5cz86Xm9y/1B/ttg1DL6f/q9+7oFr8soF1jNERmiczJp+7qj2qPbA4IX5jsYAsHXKpnuZjOphad23l2svm19PyLQzbLSKjjoErxP4EPnZ0TMl4tTQBQzOX7Q/qKjhBDAoSEJyI+ttRYXtOz6z7RvlcBpwmg2OD9XZgggXrAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052166; c=relaxed/simple;
	bh=Ebh4SGKGOqH890nAvwFna142uYoc9lRGM7ZHFFA0xwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWMp5pX3KYsnE2/aWg7DJkYsiZ1vHVsrFI/qZcB+OZ0RORVlL0QeEn6JzBpP2f2bosztOOmKzBnY8jSnFtztz3OTuxygz/6JTuVgaBaElqJsN5y1yEbOFliksdpphbAF3IFNEchFW9DpeMvyGkgSgZv1U/4g7Vo7anf3vuie/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4rIidBq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4rIidBq"
Message-ID: <945c6059-9149-4018-8a9e-baf65c95612e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711052160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1RtZSHiIUBBX7opktwgnR5lt+96P2B0XgYwgxshZA4=;
	b=v4rIidBqdbFp3PKDuur1ZWu7qnWWgTgdJEyBQXGRty8qHSo37vSpnYHt4scXtux0F3fdZG
	BGOuTRtMOhErh8SdqqY/VDa5qYegULxI7HEa9PJ4FhcrQ7TW8BKTScv8lNYwDLXoPzgCah
	e+v5swNSwMMiOW0Ehz0TVEj+3NdBrvU=
Date: Thu, 21 Mar 2024 13:15:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: Replace CHECK with
 ASSERT_* in ns_current_pid_tgid test
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
Content-Language: en-GB
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

Actually the patch (after this commit)
   4d4bd29e363c  selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
already did the refactoring. So I don't need to do anything.

>
>
>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>>
>>> jirka
[...]
