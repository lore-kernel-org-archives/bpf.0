Received: from mta0.migadu.com (out-248.mta0.migadu.com [91.218.175.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5084272E56
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790485135; cv=none; b=NtRvCJFcCldR5wEeiBIL82vWXD5Mkd91HbNy6sVhZAdOU0eiV5oAWC8Hku5y434hw0eFAzU3bxd9+ZeMt355z8cF75rXGmeEpB4ZC9Bw7nwxuicwpN9WF3CjOdYp6JCb1NWLSxMlGRNtsX1Gb/zY1DUIB8OQ9vwH32zEeMGmG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790485135; c=relaxed/simple;
	bh=X8lsTjqZV22Rnd0q4FfpEAxwKr0oq2/OBDSOCjdpCV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWKFshEFvew/BsmswZ6TLINP4gkuf2OvJ1XpO2W2SROgnIntav5cfaaJHyQ6cDhS8p6fYQgBYsGN7NlmbXj7uQX5u9cseaw1DKux5n0YfoZCL8SZAKTw07uiYiXXiUx5nYeFJyafxw3X4HZ5O+M7572W20KA13RnxXS3BftfA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YSD1ZRYQ; arc=none smtp.client-ip=91.218.175.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YSD1ZRYQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X8lsTjqZV22Rnd0q4FfpEAxwKr0oq2/OBDSOCjdpCV8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790485130; v=1; x=1791089930;
 b=YSD1ZRYQ4FYt9xkw4rCTv0710niToFJ1INRFQ9yMlkyhXKA218EbnIT3IeC4fItbImNiq8nT
 ljf9C66ruflokRRhD+xDpE5H2qTjmZl8DhFvLBJbjO9kG8MopDTSt0c///eKYLD8r2RYh5IJW29
 +DHVj2qm+CcH423xZG/UYsMw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fcb931db36341460;
	Sun, 27 Sep 2026 04:58:40 +0000
X-Mizu-Trace-ID: fcb931db36341460
X-Migadu-Flow: FLOW_OUT
Message-ID: <c75bf2fe-c25e-4e08-bec1-bc38a2eaafe2@linux.dev>
Date: Sat, 26 Sep 2026 21:58:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 19/21] selftests/bpf: Add __set_global() and
 __ret_global() test tags
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050143.2222664-1-yonghong.song@linux.dev>
 <20260926051839.F28911F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260926051839.F28911F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/26 10:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] bpf: selftests: out-of-bounds heap access in access_global_var
> - [Medium] bpf: selftests: multiple __set_global or __ret_global tags are silently overwritten
> --
>
> commit 81344b890bb87ceeed0ef105e0aab6e9d6797e2d
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add __set_global() and __ret_global() test tags
>
> This commit adds __set_global() and __ret_global() tags to the BPF
> test loader. These tags allow setting a program's global variable before
> execution and verifying its value afterwards.
>
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
> [ ... ]
>
>> @@ -311,6 +326,142 @@ static int parse_caps(const char *str, __u64 *val, const char *name)
>> +static int parse_global_var(const char *str, char **var, __u64 *val, const char *name)
>> +{
>> +	const char *colon = strrchr(str, ':');
>> +	char *end;
> [ ... ]
>
>> +		term = end + 1;
>> +	}
>> +
>> +	free(*var);
>> +	*var = strndup(str, colon - str);
> [Severity: Medium]
> If a test author uses multiple __set_global() or __ret_global() tags in a
> single test, does this silently overwrite the previous allocations? Only the
> last tag seems to take effect, making it impossible to configure multiple
> global variables in one test.

Indeed, maybe an array of global's can work. I will explore.

>
>> +	if (!*var) {
>> +		PRINT_FAIL("failed to allocate %s variable name\n", name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>> +static int access_global_var(struct bpf_object *obj, const char *name,
>> +			     __u64 *val, bool set)
>> +{
>> +	__u32 off, sz, zero = 0;
>> +	struct bpf_map *map;
>> +	size_t vsz;
>> +	void *buf;
>> +	int err;
>> +
>> +	err = find_global_var(obj, name, &map, &off, &sz);
>> +	if (err)
>> +		return err;
>> +
>> +	vsz = bpf_map__value_size(map);
>> +	buf = calloc(1, vsz);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	err = bpf_map__lookup_elem(map, &zero, sizeof(zero), buf, vsz, 0);
>> +	if (err) {
>> +		PRINT_FAIL("failed to read '%s': %d\n", name, err);
>> +		goto out;
>> +	}
>> +	if (!set) {
>> +		*val = sz == 4 ? *(__u32 *)(buf + off) : *(__u64 *)(buf + off);
> [Severity: Medium]
> Is it possible to have an out-of-bounds heap read/write here? The function
> find_global_var() extracts off and sz from BTF, but off + sz is never
> validated against the buffer size vsz before accessing buf + off.

Indeed, a bug. Will fix.

>
>> +		goto out;
>> +	}
>> +	if (sz == 4)
>> +		*(__u32 *)(buf + off) = *val;
>> +	else
>> +		*(__u64 *)(buf + off) = *val;
>> +	err = bpf_map__update_elem(map, &zero, sizeof(zero), buf, vsz, 0);
>> +	if (err)
>> +		PRINT_FAIL("failed to write '%s': %d\n", name, err);
>> +out:
>> +	free(buf);
>> +	return err;
>> +}
> [ ... ]
>
>> @@ -557,6 +708,24 @@ static int parse_test_spec(struct test_loader *tester,
>>   			spec->mode_mask |= UNPRIV;
>>   			spec->unpriv.execute = true;
>>   			has_unpriv_retval = true;
>> +		} else if ((val = str_has_pfx(s, "test_global_set="))) {
>> +			err = parse_global_var(val, &spec->priv.set_global_var,
>> +					       &spec->priv.set_global_val,
>> +					       "__set_global");
> [Severity: Medium]
> Storing the variable in a singular field here also means that using multiple
> __set_global() or __ret_global() tags will result in the earlier ones being
> ignored. Should this support a list of variables instead?

the same as previous, maybe an array of globals.

>
>> +			if (err)
>> +				goto cleanup;
>> +			spec->priv.has_set_global = true;
>> +			spec->priv.execute = true;
>> +			spec->mode_mask |= PRIV;

