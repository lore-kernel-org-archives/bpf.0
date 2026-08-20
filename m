Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D113DAABB
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259517; cv=none; b=Dce4e7SCfzqAgQgFlPEbQXlB89rv5UAM4h3oR/er8tDaOlbo8gwEYwcvySB9Y6KlqFi9jt+zj+o05Xkv4eMCh3Wb9yj4Jyuki27eP3H4PWsQe54nOmei0cMrAMW3gIoTXJw51exYv2/WUIDjM3LYYk6hTrQaICbpDw0JQ3vwI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259517; c=relaxed/simple;
	bh=U5Yf6BBpNSy8SDSQcBAYecJZdtXMlDmupPzI1UBNVjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFew3qT7ucVnSZjgZ6GIK9nSZKn3OsAZqHYViw4uufGvVc9aejwxsYRwOdgiLf+HYesnfXzo6N3o0yuUDMV1Y04Th2ElVYDiQVn3pZH78RjV/Tq6RCZIS1TCsBfrhOBm5GITLXuFfo0PAocvX7p5mLzQuureeKkz3+llV3Z+LVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xlkJoHon; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xlkJoHon"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U5Yf6BBpNSy8SDSQcBAYecJZdtXMlDmupPzI1UBNVjU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787259513; v=1; x=1787864313;
 b=xlkJoHonWfO8xe70nBb/kDMaS7KIQ5L39wMJKUbuVryUnT39M4cojuA0hQ+Uvohvhy6i2mWx
 2k4ooNe6/TavsXviGKfjm31YkxBMhxVPjbisOIb0buKHnNrJfYxpYkVyhHmSf+KXSTxgDPIzoGo
 HZCeLyL3+Osnt0H+1mnZM7qw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21cf::13e0] (2620:10d:c090:400::5:2133)
	by smtp.migadu.com with ESMTPS id 706f3c89a2f2cb79;
	Thu, 20 Aug 2026 20:58:33 +0000
X-Mizu-Trace-ID: 706f3c89a2f2cb79
X-Migadu-Flow: FLOW_OUT
Message-ID: <0c5148f0-f251-4c62-b903-bff81b8594fe@linux.dev>
Date: Thu, 20 Aug 2026 13:58:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Check that sorting
 preserves types in bpftool dump
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
 <20260820000627.3826188-5-ihor.solodrai@linux.dev>
 <6a0a841f4b41032cf69f5ba7d80189cfe7f4c4ab.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <6a0a841f4b41032cf69f5ba7d80189cfe7f4c4ab.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-20 1:42 p.m., Eduard Zingerman wrote:
> On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>> @@ -87,6 +90,36 @@ static struct btf *mk_btf(void)
>>   	if (!ASSERT_OK(err, "holey_tail"))
>>   		goto err_out;
>>   
>> +	for (i = 0; i < 3; i++) {
> 
> Testing this locally, a single enum suffices to showcase the bug,
> why the complication?

Hi Eduard, thank you for reviewing so quickly.

For the bug that was fixed, yes. But in general, I thought it's good to 
have a couple of different things in the test sample.

> 
>> +		char name[16];
>> +
>> +		snprintf(name, sizeof(name), "E%d", i);
>> +
>> +		id = btf__add_enum(btf, NULL, 4);
>> +		if (!ASSERT_GT(id, 0, "anon_enum"))
>> +			goto err_out;
>> +
>> +		err = btf__add_enum_value(btf, name, i + 1);
>> +		if (!ASSERT_OK(err, "enum_val"))
>> +			goto err_out;
>> +	}
>> +
>> +	id = btf__add_struct(btf, "s", 4);
>> +	if (!ASSERT_GT(id, 0, "struct_s"))
>> +		goto err_out;
>> +
>> +	err = btf__add_field(btf, "f", 1, 0, 0);
>> +	if (!ASSERT_OK(err, "s_field"))
>> +		goto err_out;
>> +
>> +	id = btf__add_union(btf, "u", 4);
>> +	if (!ASSERT_GT(id, 0, "union_u"))
>> +		goto err_out;
>> +
>> +	err = btf__add_field(btf, "f", 1, 0, 0);
>> +	if (!ASSERT_OK(err, "u_field"))
>> +		goto err_out;
>> +
>>   	btf__set_pointer_size(btf, 4);
>>   
>>   	return btf;
>> @@ -95,6 +128,42 @@ static struct btf *mk_btf(void)
> 
> ...
> 
>> +static void test_sort_preserves_types(const char *path)
>> +{
>> +	char *sorted = NULL, *unsorted = NULL;
>> +	int n_sorted, n_unsorted;
>> +
>> +	sorted = dump_c(path, true);
>> +	unsorted = dump_c(path, false);
>> +	if (!sorted || !unsorted)
>> +		goto out;
>> +
>> +	/*
>> +	 * Count definitions by the closing brace in their first column. Counting
>> +	 * "struct"/"union"/"enum" openers instead would also count forward
>> +	 * declarations, and which types need one depends on emission order.
>> +	 */
>> +	n_unsorted = count_substr(unsorted, "\n}");
>> +	n_sorted = count_substr(sorted, "\n}");
> 
> This does not include e.g. typedef. I'd just match for presence of enum.
> Or better yet, compare full expected output with actual one and tailor
> several BTF definitions, each for a specific sub-test.

I wanted to avoid committing a sample generated header. I think the
exact string check will also be too sensitive to the changes in libbpf
dumper or bpftool.

Presence of enum only tests the concrete bug, and I wanted some simple
proxy to a more generic sorted vs unsorted output check.
That is, "did we drop anything while sorting?" check.

Ideally we'd need to parse the headers and compare the full set of
emitted types.. An overkill here, I think.

We can just add counting typedefs as well.
That's an easy improvement. wdyt?


> 
>> +	ASSERT_GT(n_unsorted, 0, "types_emitted");
>> +	ASSERT_EQ(n_sorted, n_unsorted, "same_type_count");
>> +
>> +out:
>> +	free(sorted);
>> +	free(unsorted);
>> +}
>> +
>>   /*
>>    * Check only what the selftests build cannot:
>>    *   - bpf_helpers.h defines __ksym and __weak as well, and no program uses
> 
> ...

