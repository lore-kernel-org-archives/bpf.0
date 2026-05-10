Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8834184
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433876; cv=none; b=lX71pctFuP038xTf37dbGqlc4ZoQ17pEhfj5SkYY0Csff0X060+vZMaxn6Sg2uZYsO8PIVIvK5TMJ+a+1GDBvkDcsyy0lgK1OwO1g7EwASExTjlY+hfwD1cLC9Bm+VC944ZOCuFbPcMYelnlB9OQtk9yGQZ8dYMI7EMxjZ6NEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433876; c=relaxed/simple;
	bh=/YsYfp9Wy2hQVbLDcVVpA4/1diooJLefhluAo0ffFBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFojL4WTchceduEty0yNpSBidyz49QLg5DznTv9Wz32s/ZrYjn2i6MUYb30PDvwl3yVfCIZmFtceR/qGkX+vHs4HsxDjsE3m/bqSRJ4S/TkLpTg2ahPgoRA6n2SOh8HHCkBt1sb2gDLSwK6kl/I3Z2XLqVLHWuOMP32+q0DP77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L9vORQz6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L9vORQz6"
Message-ID: <8c35844a-ce38-4202-9908-0e6964aeacf4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778433863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyCn7Ooze+VD8s1vsVVVfl3VIN2F4vwDYLTyoTsX3OI=;
	b=L9vORQz6qw3LtoB+S5L6qRvpExsPQ3u9hACaJKD4N7gW6rO/CIiG0pXAw3xXwI1GxkrCRv
	5mS2sFKeIx4ex3reMcEXGTHh1ikiF8iYRFBFkbfxYqrlR/2dZn9qQmHyt+KiYUjICk7X1A
	Gk0nYk3Ni1dKEN4zjeI3iK/ab1mhkPk=
Date: Sun, 10 May 2026 10:24:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 18/23] selftests/bpf: Add BTF fixup for
 __naked subprog parameter names
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213140.1138756-1-yonghong.song@linux.dev>
 <20260509014042.03A3DC2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509014042.03A3DC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 3:40 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The BPF object 'tobj' is leaked when 'fixup_btf_from_path()' fails.
> --
>
> commit af529dd65e68c8ac479551b0ac6332c3b5f56771
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add BTF fixup for __naked subprog parameter names
>
> This commit adds a mechanism to fix up missing parameter names in the BTF
> FUNC_PROTO entries of __naked subprogs by reading them from a separate BTF
> file. This allows the verifier to resolve stack argument slots by name.
>
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
> [ ... ]
>
>> @@ -1231,13 +1351,27 @@ void run_subtest(struct test_loader *tester,
>>   		}
>>   	}
>>   
>> -	/* Implicitly reset to NULL if next test case doesn't specify */
>> +	/* Implicitly reset to NULL if next test case doesn't specify.
>> +	 * btf_custom_func_path also serves as btf_custom_path for kfunc resolution.
>> +	 */
>>   	open_opts->btf_custom_path = spec->btf_custom_path;
>> +	if (!open_opts->btf_custom_path)
>> +		open_opts->btf_custom_path = spec->btf_custom_func_path;
>>   
>>   	tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts);
>>   	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
>>   		goto subtest_cleanup;
>>   
>> +	/* Fix up __naked subprog BTF using a separate file with named params */
>> +	if (spec->btf_custom_func_path) {
>> +		err = fixup_btf_from_path(tobj, spec->btf_custom_func_path);
>> +		if (err) {
>> +			PRINT_FAIL("failed to fixup BTF from %s: %d\n",
>> +				   spec->btf_custom_func_path, err);
>> +			goto subtest_cleanup;
> Does this error path leak tobj?
>
> If fixup_btf_from_path() fails, the code jumps to subtest_cleanup, which
> appears to bypass the tobj_cleanup label where tobj would normally be
> closed and freed. Should this be goto tobj_cleanup instead?

Thanks for catching up this bug. Will fix in the next revision.


