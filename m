Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080724B0E3B
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213608; cv=none; b=SKwDuKV5v4pCExOkuW/PKoOn/YGrJGUiKAEFouzhnIs3NHQL0yqTy7kOljMn24SXCZedTjSQApWU2HKoPXuGilH9gWRwKgTF7s/cTDQnq08PHvGM65Oy+bE1V+OjzOPuSNEGDvd68WXMom5ydhJ5/rBypWZiyJ7dPUjb55AnSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213608; c=relaxed/simple;
	bh=nEG7kvVz993F5F6M2F5ajX9aIv4RDuARizMim9zQroQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3F7A3T5e68ZhGVaCS/3nhHdqa/Jzzr4zhRW5yrngk6hHOvK8ytzhdKdRLlU1Ykeaw+0pGvdRx9l8o7BRK0OezdyW5nZxUVe76YYVsqdVvD/t2QJNkPCMTGWy4gbXnu+RwDbbob2Yj+es6Ds+TUl2JZxvHJ7iIo3Y1HDazfNhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=K0ORQa/M; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="K0ORQa/M"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D673782BA8;
	Mon, 05 Oct 2026 17:20:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bH8iL4Fe1oJX; Mon,  5 Oct 2026 17:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791213603; bh=nEG7kvVz993F5F6M2F5ajX9aIv4RDuARizMim9zQroQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K0ORQa/Mp/lajH4I/YEUzp/SiLxzG/JQKwFBSBnDGkHM+R0EWuIDImxI/nfkInSB8
	 rjIeUmP3YcN/p3ZWtc2WERsQcnRvlwHnXHN7oTnudPkMcaybR71rfXZPPDGlEZ6Wrg
	 X6HBm0pWGDbzkRfaYGTCc/4UA6KtBROp93OrPkNfs/Yosmljl/KtpNyoZTmudsmlcu
	 heFOAO1ZJCn3n5bFUXKHniTcboLKE+NddGgckAgXvIqayZYlzHHn3R6AAIoFvmfNi8
	 TehrDxghdVCEdBbrsAQuss9UwHaGSez1oIf/ToyLJYL4iOh9KyOBTqPQHoPC/jgQ8f
	 Wt5qQH2MzCdXQ==
Message-ID: <2c50da80-5c48-4bcc-a497-64d6a1a80b1c@disroot.org>
Date: Mon, 5 Oct 2026 16:19:55 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261004111007.3216186-1-maghasi@disroot.org>
 <20261004111007.3216186-4-maghasi@disroot.org>
 <935fb19c-e8e2-46a3-b933-9d8e9d1cf746@linux.dev>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <935fb19c-e8e2-46a3-b933-9d8e9d1cf746@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2026 04:12, Leon Hwang wrote:
> On 4/10/26 19:10, Masoud Aghasi wrote:

[...]

>> +{
>> +	int err;
>> +	u64 flags = 0;
>> +	size_t value_sz = sizeof(u32);
>> +	size_t elem_sz = roundup(value_sz, 8);
>> +	u32 *values = NULL;
> 
> Pls keep these lines in inverted Christmas tree style.
> 

[...]

>> +	flags = BPF_F_CPU | BPF_EXIST;
>> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
>> +	if (!ASSERT_OK(err, "bpf_map__update_elem cpu|exist"))
>> +		goto out;
> 
> This 'goto out' is unnecessary.
> 
> For these two bpf_map__update_elem() calls, better to set values before
> updating, then to verify the values after updating.
> 

[...]

>> +static void test_percpu_map_flags_combination(enum bpf_map_type map_type)
>> +{
>> +	size_t value_sz = 8;
>> +	void *values = NULL;
>> +	u32 max_entries = 3, key = 0;
>> +	u64 flags = 0;
>> +	int err, map_fd, nr_cpus;
>> +	bool is_hash_map = (map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>> +			    map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
> 
> Ditto the style.
> 
> We can pass 'bool is_hash_map' via parameter.
> 

[...]

>> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
>> +	key = 0;
>> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
>> +	if (is_hash_map) {
>> +		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|noexist"))
>> +			goto out;
>> +
>> +		err = bpf_map_update_elem(map_fd, &key, values, flags);
>> +		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
>> +			goto out;
>> +	} else {
>> +		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
>> +			goto out;
>> +	}
> 
> The 'if (!ASSERT_EQ(err, ...))' can be moved after 'if (is_hash_map)'.
> 
> if (is_hash_map) {
> 	if (!ASSERT_EQ(err, ...))
> 		goto out;
> 
> 	err = bpf_map_update_elem(...);
> }
> if (!ASSERT_EQ(err, ...))
> 	goto out;
> 

[...]

>> +	key = 0;
>> +	err = bpf_map_lookup_elem(map_fd, &key, values);
>> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem unnecessary_deletion"))
>> +		goto out;
> 
> This 'goto' is unnecessary.
> 
>> +
>> +out:
>> +	close(map_fd);
>> +	free(values);
>> +}
> 
> After reading test_percpu_map_flags_combination(), two helpers are
> needed to verify the updated values. One for updating with BPF_F_CPU,
> another one for updating with BPF_F_ALL_CPUS.
> 
> Thanks,
> Leon

Thanks, I will apply your comments to the v5.
just regarding the is_hash_map, isn't it better to keep it as an
implementation detail inside the function and avoid introducing an
unnecessary invariant for callers to maintain?
