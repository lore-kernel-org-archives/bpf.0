Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA63101A6
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890240; cv=none; b=Bicxp9iJLnzQjMp3OogiKTf2wigJPzEZL/SgKsWtfcuVIsd0AbvxS06oJ/Nl/NudW0RUTMLfbQ5SysZSgHsgoUhFwugK8cJo23tZYIAdfmUg3L2zaJIJtJUKKf+PZVGENeevRdbooQCIYE5VCRSDPxEKsednDoQx99tl7Grro+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890240; c=relaxed/simple;
	bh=+cTeIacw+TbLJ/py4Drv+hTUoZ22Kfc66vwy0d71t9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YL4H95LlUqk1lxWVzcC8t5PqyqFq6/xm92UQu3HKkUmugkdFmSDjQLH3PsLEHSVjn3st8Tx1V6mApoT3Azm+b88VQ8n/L8C7VeuZQ2RYmQ4SXy+/By82jILvvvBv6qUJKzi35nOthFWRZcW7P8BBty8aQbFYg/9kNAytYzRyhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn+KGewx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn+KGewx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d43e09de5so3355753f8f.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776890238; x=1777495038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrXeN/ftlqLnU8AS+ReNyDn7NdZWMQdy+Z1ENc3F87A=;
        b=jn+KGewxSRNymhzXB3xGzhTjfaNEwiw1GNZJ1tx0c/Xt3nAWQDdsH9YlyQELh27OFj
         XaA+baWXReOPUPTci6CDdNH08oVsA37MRh5TrSUnLWAA2krVVXfT7ElTmZ2Kzgx25w5h
         WhyAiTXB5uAxTrfuqgXrNzeL0U0d24f+hmcS3u7Jx89h1eX9foen7tvLP9bf3AvBThHU
         rqvUTRhnzZcd4x4bwzxDeyaOI1WAfGh7m55gUEYIIJvs7VO7OaShg3V0Fwwe8AdwnaT1
         7pNPqjWumbmONAsmhNab4DugokOFGUN0mbc6oMzRkLGOO9381t0+6R6Ufg45di/9JLYe
         5h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776890238; x=1777495038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrXeN/ftlqLnU8AS+ReNyDn7NdZWMQdy+Z1ENc3F87A=;
        b=crUQwteVTxb/R9bHYU6t/rcImafjiba4tOGXC9i14Iv5nwe7yTFT8PDfdfEP8oT2G6
         UbBTCIE+2Jchm71yHj9La9Hif7q2W2GSmNdg+0McB5Vr6hrgnitOK9ezVvE/npobdVbZ
         2e5o00LIZt1i0SSRzhJwNzl1Gqny7rJBXhxLjuRivTLeH0w5ViFCZnQOhVNtdfLdYb/Y
         Cteca2wQuI6W+gxRPTUbd8iqOvSY9SBqAYKYMPVwsyJHCNcIuUGVWnAUN+3Zdt+XwlTA
         pk7yNewjfryOS3Vuhi5XEchuk7kgIsjkohg3w+XX7HNyPmacd5YK1f5qzS/U07r3hzp/
         93pg==
X-Forwarded-Encrypted: i=1; AFNElJ9NCGeFa13XnKBb8MygJ5dsqX5KNyHx+geGH2tcK0zDwWMZthjcCrtAiYhs7d7Qjw6yPmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNcPDwSyFyMYjHJYyLX4OWKPCErNhkgRE7fD5J0Cr7HtSPQi7
	3Bsp4aDlKmCsTc3LF1nBu5ouyzDvDKBGxVFitRSjXegYkX+FpulfjJKG
X-Gm-Gg: AeBDieuaWe5ZXwSigGYzpE6N90A6jh45AQhdw0LkYycUYvZ9+vkRCRuJrfAOJYAM8//
	5pY+7Oh3dg9AcKUFlUY1BUoZjsWEZruYtDElIX+yKjDYqH1TevSNkbP3ZRDhwG5kx2QWrLPa/yY
	+A/h5ut3UIBrqnF3NUAkHlmoqQ/I7BIFDBKKMmCPSUn/a7mT/36HmhUEEzJl7TGPT/khMidbagF
	VmPFj95Yc6f175Qj7S8ypBdvOUM3YwLG5lBQHzlh+8znvjQG6AxCrvmighdecGaniB80shN5JZG
	tAmaCCaOu3yn4mgnk1CkQWqlUn8Plr4omm7fG+1EYaoVoXyrDXcgirxualYltMmnlRg9xaKUxTt
	lOP6jUKB211Y2Jau6O3rTylDtDM2EBNzG3m2EKWh9qsddjYXCpQSbZ8kEhQKH9EJpt6TQLmv0KU
	ATFdKNtHjRWbdkr1E9/2I7PUok+mCq+++9cHD9wwlmbrTyANgct+33kOz8k7xdOPR0TlZuO68=
X-Received: by 2002:a05:6000:24c9:b0:43d:7e34:889c with SMTP id ffacd0b85a97d-43fe3e0ffaamr37524274f8f.39.1776890237537;
        Wed, 22 Apr 2026 13:37:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4807:7c72:b2bd:e787? ([2620:10d:c092:500::5:1502])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm47305088f8f.4.2026.04.22.13.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 13:37:17 -0700 (PDT)
Message-ID: <df7094ce-c286-4201-af8e-442eb7a97743@gmail.com>
Date: Wed, 22 Apr 2026 21:37:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 peterz@infradead.org, rostedt@goodmis.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com>
 <0ca1420ce830b146a1ed429af9af7bb489a7959bad702d7080d3be6a325a483d@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <0ca1420ce830b146a1ed429af9af7bb489a7959bad702d7080d3be6a325a483d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/26 9:30 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
> 
> [ ... ]
> 
>> @@ -0,0 +1,142 @@
>> +void test_sleepable_tracepoints(void)
>> +{
>> +	struct test_sleepable_tracepoints *skel;
>> +
>> +	skel = test_sleepable_tracepoints__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		return;
>> +
>> +	if (test__start_subtest("tp_btf"))
>> +		run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
>> +	if (test__start_subtest("raw_tp"))
>> +		run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
>> +	if (test__start_subtest("tracepoint"))
>> +		run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
>> +	if (test__start_subtest("sys_exit"))
>> +		run_auto_attach_test(skel->progs.handle_sys_exit_tp, skel);
>> +	if (test__start_subtest("tracepoint_alias"))
>> +		test_attach_only(skel->progs.handle_sys_enter_tp_alias);
>> +	if (test__start_subtest("raw_tracepoint_alias"))
>> +		test_attach_only(skel->progs.handle_sys_enter_raw_tp_alias);
>> +	if (test__start_subtest("raw_tp_bare"))
>> +		test_raw_tp_bare(skel);
>> +	if (test__start_subtest("tp_bare"))
>> +		test_tp_bare(skel);
>> +	if (test__start_subtest("test_run"))
>> +		test_test_run(skel);
>> +	if (test__start_subtest("test_run_on_cpu_reject"))
>> +		test_test_run_on_cpu_reject(skel);
>> +	if (test__start_subtest("raw_tp_non_faultable"))
>> +		test_attach_reject(skel->progs.handle_raw_tp_non_faultable);
>> +	if (test__start_subtest("tp_non_syscall"))
>> +		test_attach_reject(skel->progs.handle_tp_non_syscall);
>> +	if (test__start_subtest("tp_btf_non_faultable_reject"))
>> +		RUN_TESTS(test_sleepable_tracepoints_fail);
>> +
>> +	test_sleepable_tracepoints__destroy(skel);
>> +}
> 
> In v8, Andrii Nakryiko suggested simplifying this test structure by using
> an array-based approach instead of individual if statements for each test
> case:
> 
>    "why not have an array
> 
>    struct { const char *name; struct bpf_program *prog } cases[] = {
>       { "tp_btf", skel->progs.handle_sys_enter_tp_btf},
>        ...
>    }
> 
>    and then do the tests in a loop?"
> 
> Reference: https://lore.kernel.org/bpf/CAEf4BzZ_YOb1MNpUxuhFESqRWARFiBJ6yGZ-Z8xBqdCvqi_Bow@mail.gmail.com/
> 
> Would an array-driven approach reduce repetition and make it easier to
> maintain as new test cases are added?
> 
I did array-driven approach around v10, but then after few de-claudings 
and simplifications ended up with this structure that is more common in 
our selftests. This implementation reuses test logic via generic 
functions, like test_attach_only() or run_auto_attach_test().
I find it's even better this way.

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24799223877

