Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C744191F91
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784523836; cv=none; b=HZYEU2KQ1ryEmw2QqCSSZGLwZq/zjIM7GAX05sF5ww1OL+MpCflMzw1UCOu3MdurBD7j0/CaUcn2j0BHh360Tgb7vwsuatPDF81XvG/Xny93ETXISIoOgfvb5/L/tA89ptrOoW0PgarrUAKlTb3MPVjnyyJgnK/nytXIvp1TM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784523836; c=relaxed/simple;
	bh=MSBFHKvS9tM6Lf1Df8oa4cTiHFgC1qAHEkXpNZzjmrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=av+MTk+736mcusqVFCssDdzbp0dAbUIv6rlS7ueiFZWNEInkju+SrnV1pv303r2lSxVjK00osQKnbHKWzzVsu8wyBRHb7LZcLztj39HHQxalBuZChXrgV66qfAL3IMnvet3cXZtSWaqEF1auDhT8edjoPbxUFEbmyS4vDntS3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqgv0lh3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqgv0lh3"
Message-ID: <6abd493f-e1d1-42f6-87b5-c4d3b176ad1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784523823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bxpaj06sQP7Yn98cdWkiMSJp35l3kYbHVrCGsGvb6w4=;
	b=wqgv0lh3K5iPPPvqtWt/lJqoA2bTabo7ffBx/u1gdtqPCJ8biZzLS9xf8qOJmuyYlCrYcw
	mIb4SGddeHyVrhxpB8Z5Lp1daMa9hJ3KgkSuRqMtTjEKv5EEsJqtCPndN6P+v5RSXWsOBZ
	BOUpVTsYYYMTNHNELKTCifs8LyuS/gg=
Date: Mon, 20 Jul 2026 13:03:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 7/9] selftests/bpf: Test direct
 reading/writing read-only percpu_array map
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-8-leon.hwang@linux.dev>
 <DK17OV4181RP.1LRGDA6VBB364@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DK17OV4181RP.1LRGDA6VBB364@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/7/26 06:49, Emil Tsalapatis wrote:
> On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
>> Verify these two cases:
>>
>> 1. Direct reading the data of read-only percpu data's percpu_array map
>>    is allowed.
>> 2. Direct writing the data of read-only percpu data's percpu_array map
>>    is disallowed.
>>
>> Assisted-by: Codex:gpt-5.5-xhigh
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  .../bpf/prog_tests/global_data_init.c         | 83 +++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index f7a56e3fdbce..d4405646847a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> @@ -199,6 +199,85 @@ static void test_global_percpu_data_lskel(void)
>>  	test_global_percpu_data_lskel__destroy(lskel);
>>  }
>>  
>> +static int create_rdonly_percpu_array(void)
>> +{
>> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
>> +		    .map_flags = BPF_F_RDONLY_PROG,
>> +	);
>> +	int key = 0, map_fd, err;
>> +	__u64 value = 0;
>> +
>> +	map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "percpu_ro_map", sizeof(int),
>> +				sizeof(__u64), 1, &map_opts);
>> +	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
>> +		return -1;
>> +
>> +	err = bpf_map_update_elem(map_fd, &key, &value, BPF_F_ALL_CPUS);
>> +	if (!ASSERT_OK(err, "bpf_map_update_elem"))
>> +		goto out;
>> +
>> +	err = bpf_map_freeze(map_fd);
>> +	if (!ASSERT_OK(err, "bpf_map_freeze"))
>> +		goto out;
>> +
>> +	return map_fd;
>> +
>> +out:
>> +	close(map_fd);
>> +	return -1;
>> +}
>> +
>> +static void test_global_percpu_data_rdonly_direct_read(void)
>> +{
>> +	struct bpf_insn insns[] = {
>> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
>> +		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
>> +		BPF_EXIT_INSN(),
>> +	};
> 
> Why hardcode this as inline assembly? Can we do a syscall example in the
> progs/? That way there will also be a concrete example of how we're
> using the feature in practice.


We are unable to implement it with a syscall example, because libbpf
does not support creating a rdonly internal map for global percpu data.
We have no '.ropercpu' section support in libbpf.

Will add comment to explain the reason of hardcoded insns.

Thanks,
Leon

> [...]

