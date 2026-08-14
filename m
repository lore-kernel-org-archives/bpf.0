Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C4367B74
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688019; cv=none; b=lpRo16+wphNHJ9K/OgVXubYDuIwgKBKzURoJxushLBxYHeWkeR655So06CoPfjtS7NnAK6IEvanoiqaP3jprMc9Fn+jhqKEZ2eFNjJln8Y7cMDhW05A+KBSqcVPadPt8japHMdIewN5om/tUp9uIW7bGF8cBIyBwi7vwCJvikAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688019; c=relaxed/simple;
	bh=lGlYW27xUHDkUI3IGYoSD12FyJy1ur2frG4sNY5io3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgiTSoLdmAfs0he/KSZDtcIA/Iu0hB9wmNwHHgd2odce1dLtHu+IzYHXJ6LW+pXT/Im4IKuUOUfi2hH34bte5XOxJ2TaJOzec7mXyG99PosyCKeXOFotG52o9YXwuF+VJIqhUOWdltIbaQK/uaxvn+dpTYYWeEgBCXHQ+lyP8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJnigzPw; arc=none smtp.client-ip=91.218.175.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJnigzPw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lGlYW27xUHDkUI3IGYoSD12FyJy1ur2frG4sNY5io3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786688015; v=1; x=1787292815;
 b=rJnigzPw0RIsv9kTFTymKDlI3C8BOwYM5NQjw9pa8uc07CDwLqwWseQanAQpCquHBu4HzRkb
 Wo3ak6vTR+HpWKAqUbDYz3SOjHDqs898/od/fFSvkQLkd4VpGfLj9Bt/Uu8xrYfVsm4futhGDiK
 Nqw6kHOqKDoEfRUHzTPjXkPc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id ca462923b3a849a8;
	Fri, 14 Aug 2026 06:13:35 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <4c455c0f-9138-4183-8fb9-fe979d56ae3a@linux.dev>
Date: Fri, 14 Aug 2026 14:13:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 10/10] selftests/bpf: Verify bpf_iter for
 global percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 emil@etsalapatis.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813152324.97937-11-leon.hwang@linux.dev>
 <bd01566fa68ef3b993bdd4cfbd9802a24cd9b5052b5a746712067d8571ea0bd0@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <bd01566fa68ef3b993bdd4cfbd9802a24cd9b5052b5a746712067d8571ea0bd0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/8/26 00:26, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index d308ca3b30457..7d6bda9092954 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> @@ -327,6 +327,56 @@ static void test_global_percpu_data_verifier_log(void)
>>  	RUN_TESTS(test_global_percpu_data);
>>  }
>>
>> +static void test_global_percpu_data_iter(void)
>> +{
>> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>> +	struct test_global_percpu_data *skel;
>> +	union bpf_iter_link_info linfo = {};
>> +	struct bpf_link *link = NULL;
>> +	int fd, num_cpus, len, err;
>> +	char buf[16];
>> +
>> +	num_cpus = libbpf_num_possible_cpus();
>> +	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
>> +		return;
>> +
>> +	skel = test_global_percpu_data__open();
>> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
>> +		return;
>> +
>> +	skel->rodata->num_cpus = num_cpus;
>> +	skel->rodata->offsetof_num = offsetof(struct test_global_percpu_data__percpu, struct_data);
>> +	skel->rodata->offsetof_num += sizeof(skel->percpu->struct_data) - sizeof(int);
> 
> This isn't a bug, but could these two lines collapse into a single
> offsetof(struct test_global_percpu_data__percpu, struct_data.nums[6]),
> so the offset names the field being read instead of depending on nums[6]
> staying last in the struct?

Sure. Will update.

> 
>> +	skel->rodata->elem_sz = roundup(sizeof(struct test_global_percpu_data__percpu), 8);
>> +	skel->percpu->struct_data.nums[6] = 0xc0de;
>> +
>> +	err = test_global_percpu_data__load(skel);
>> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
>> +		goto out;
>> +
>> +	linfo.map.map_fd = bpf_map__fd(skel->maps.percpu);
>> +	opts.link_info = &linfo;
>> +	opts.link_info_len = sizeof(linfo);
>> +	link = bpf_program__attach_iter(skel->progs.dump_percpu_data, &opts);
>> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
>> +		goto out;
>> +
>> +	fd = bpf_iter_create(bpf_link__fd(link));
>> +	if (!ASSERT_GE(fd, 0, "bpf_iter_create"))
>> +		goto out;
>> +
>> +	while ((len = read(fd, buf, sizeof(buf))) > 0)
>> +		do { } while (0);
> 
> This isn't a bug, but would a bare semicolon (as in bpf_iter.c's
> read-drain loops) be clearer here than do { } while (0)?

Prefer 'do { } while (0);' instead of a dangling ';'.

> 
> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> index d086e9417f9fb..71ff8d1bf49eb 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> @@ -61,4 +61,29 @@ int verifier_snprintf(void *ctx)
>>  	return 0;
>>  }
>>
>> +volatile const __u32 num_cpus = 0;
>> +volatile const int offsetof_num;
> 
> This isn't a bug, but would a name like nums6_off (set directly from
> offsetof(struct test_global_percpu_data__percpu, struct_data.nums[6]))
> make it clearer which field the iterator is summing?

'num_off' would be better.

In iter, it should not know the concrete number. Instead, it identifies
the number by offset 'num_off'.

Thanks,
Leon

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858

