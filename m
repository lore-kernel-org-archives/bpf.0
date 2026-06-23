Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152B318ED9
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187521; cv=none; b=Sq2pRHnllHA4miPVKuoxsE0TwVCcqF9zwI+VUL+r5OgLKi+qPoq+/2wufpgJweczJVo5WBEofgzm7q5cCRPqNua4f0g4fi3KOT7Yr1wj6RK4SiugdCxHmlWcTJCJ5Z+XLe+nOi5h4gFS8cCh6t4J1B75IadmQnj6BXamO8IAc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187521; c=relaxed/simple;
	bh=wAIGnnQ6Lt9OkeA5d18ByzIRKWZYKMqFGm7MYrVUj68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1eeOI3t67h9S3PGqIHyLXrrUw+skOCVSOKsaD6lZn2VSOZn59okA6MSk0/emZHz5h4sqsvmoitLX2qhycWhdknuUkxN9EUouYmHFIkzmixEdbHtcCDBjlcYbymSTWoOjbW5FgfYMfTWyal1Ak+gZZL2T07wMgVlJzXTiDgZ7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J6SLh9z2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J6SLh9z2"
Message-ID: <08991b5a-b043-4533-bcea-1e4aff7ff6f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782187518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qOHhQRY5spcoTugmjK0azGcV5UdZZrytv+EjAsIhnw=;
	b=J6SLh9z2BnX18yq8aOCGs0ofS1tCULsvXssh5q7uJ/H/re87p2QpRAUGjvIfQC/FDVebd/
	ti9pSnEhajsK7/NsFV0nxD5X47fWPOZ37h0JXVG0tMgU79jetztmCnDBAnTCWGESSnAq0i
	Z/IN8cgj2kNxdro/am6CxOHmV2xnjNw=
Date: Tue, 23 Jun 2026 12:05:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 11/11] selftests/bpf: Add test to verify
 bpf_iter for global percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-12-leon.hwang@linux.dev>
 <20260622150844.28C551F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260622150844.28C551F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/6/26 23:08, sashiko-bot@kernel.org wrote:
[...]
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index e4c290492ff8a..32734e1dbfb00 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> [ ... ]
>> @@ -279,6 +279,56 @@ static void test_global_percpu_data_verifier_log(void)
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
>> +	skel->rodata->elem_sz = roundup(sizeof(struct test_global_percpu_data__percpu), 8);
> 
> [Severity: High]
> This is a pre-existing issue, but does iterating over per-CPU maps expose
> uninitialized kernel heap memory?
> 
> When working with per-CPU maps, temporary buffers are allocated using kmalloc
> without the __GFP_ZERO flag in functions like bpf_iter_init_array_map in
> kernel/bpf/arraymap.c:
> 
> kernel/bpf/arraymap.c:bpf_iter_init_array_map() {
>     ...
>     value_buf = kmalloc(buf_size, GFP_USER | __GFP_NOWARN);
>     ...
> }
> 
> This is also done in kernel/bpf/hashtab.c:bpf_iter_init_hash_map().
> 
> If the map contains a BTF record, bpf_obj_memcpy in include/linux/bpf.h
> explicitly stops at map->value_size instead of filling the entire rounded-up
> size:
> 
> include/linux/bpf.h:bpf_obj_memcpy() {
>     ...
>     memcpy(dst + curr_off, src + curr_off, size - curr_off);
>     ...
> }
> 
> This fails to overwrite the padding bytes up to round_up(map->value_size, 8).
> Because the BPF verifier allows the iterator program to read the entire
> round_up(map->value_size, 8) * num_possible_cpus() bytes, the uninitialized
> padding from kmalloc is exposed to the BPF program.
> 
> Similarly, in kernel/bpf/syscall.c:map_lookup_elem(), kvmalloc is used
> without zeroing:
> 
> kernel/bpf/syscall.c:map_lookup_elem() {
>     ...
>     value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
>     ...
> }
> 
> This means sys_bpf BPF_MAP_LOOKUP_ELEM also copies this uninitialized padding
> back to user space via copy_to_user, causing a direct kernel heap info leak.
> 
> Could this be addressed by zeroing these allocations or ensuring the padding is
> cleared when copying map values?
> 

Will verify the issue by separate selftests.

If true, will post separate patch to fix it.

Thanks,
Leon

>> +	skel->percpu->struct_data.nums[6] = 0xc0de;
>> +
>> +	err = test_global_percpu_data__load(skel);
> [ ... ]
> 

