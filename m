Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF413DDDB3
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180958; cv=none; b=eiYOKKTUAojScmI5GIPSh/ZfxFSaljD+DPLm20nsBNY3yGbGRy5n5dmrWaJb8QUkrX45a9pPRl9qb3nYVDUuzDGuybNuvPG8OTp/O3LgFZfn3176lbwESZlJ+lUCNP3qou39qG5mwF7UnhN/moHu0KZtHW6UtBZ53IhWrHOBh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180958; c=relaxed/simple;
	bh=ZumPVTNkAYV5rPmNOVuCrmG0H5/5Zi/IukkafbY+FrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jey+NbPUunVelLvKfSxFMTagNMgHkqkazBP7NMrzu6EiMBgN19Scqv77/y1DmqhR/ffRQxDOlT4SDvOKUT0qzv9znbjZu7bbN3+y78EmKb8B2a0mY/QBQGuR0N08YSjDCCcrPrY6xk5FY17/7z7aSFU9s+lr64fhOWrHiu4QyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dzOG1rg4; arc=none smtp.client-ip=95.215.58.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dzOG1rg4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZumPVTNkAYV5rPmNOVuCrmG0H5/5Zi/IukkafbY+FrU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788180951; v=1; x=1788785751;
 b=dzOG1rg4S2TGQjN3IH70iK6WxZxu9rnYSYimm7w4R504dhtHiOI/YwLh+2bpudCW4lhf3p3U
 iPnQsevN52x92D+OOkKLWURfEv84oiWOuSsOK4kJZeJAQHtCs/UIbQIr9DoBgOv3z9+Jx7lzy+A
 nssIxb9guUJfzL7KHupOR5qE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fe5405105ba7c795;
	Mon, 31 Aug 2026 12:54:24 +0000
X-Mizu-Trace-ID: fe5405105ba7c795
X-Migadu-Flow: FLOW_OUT
Message-ID: <5ddb8296-fdbe-4ad7-9ead-24f7c5bfaa4b@linux.dev>
Date: Mon, 31 Aug 2026 20:54:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 4/5] selftests/bpf: Add test for key-less BTF hash
 map
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
References: <20260831110314.150870-5-jiayuan.chen@linux.dev>
 <8b93223f148b0771b79336d636e7b6ddff030ffd2b3ffb264a51af6082149c01@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <8b93223f148b0771b79336d636e7b6ddff030ffd2b3ffb264a51af6082149c01@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/31/26 7:48 PM, bot+bpf-ci@kernel.org 写道:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
>> new file mode 100644
>> index 0000000000000..a7d037f57a7ef
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
>> @@ -0,0 +1,82 @@
> [ ... ]
>
>> +	/*
>> +	 * Positive control: the same map with a real key type must be accepted,
>> +	 * so the -EINVAL below is about the key-less BTF and not some unrelated
>> +	 * rejection (e.g. an unknown map type).
>> +	 */
>> +	opts.btf_key_type_id = val_id;
>> +	map_fd = bpf_map_create(map_type, "keyed_map", 4, 4, 8, &opts);
>> +	if (!ASSERT_GE(map_fd, 0, "keyed create is accepted"))
>> +		return;
>> +	close(map_fd);
> A subsystem pattern flags this as potentially concerning: the positive
> control turns "this kernel does not implement the map type" into a hard test
> failure instead of a skip.
>
> BPF_MAP_TYPE_RHASH (used by the rhash subtest) is new; on any kernel that
> lacks it, map_create() rejects the unknown map type and this ASSERT_GE fails,
> reporting a red btf_map_keyless/rhash that has nothing to do with the
> behaviour under test.

Selftests run against the matching kernel, where the map type exists, so 
this doesn't happen.


