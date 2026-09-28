Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24941ACEDE
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566616; cv=none; b=EwV0Gjfs1dCNfgkdLvzLApubIk+uRXFb5VX8wHC9qMxY8WqNu5x7BimFjkWryOQ1vD5z8jjMg+QEdLXRDiEkbEcJtQyNC5i92hHxF6HH0PNeDEHdCBRIw8uf6KgDzms1evaYKfOPckYfif2uD4a0dUyYAK1q9Mg2/cg152fwyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566616; c=relaxed/simple;
	bh=Nkou3XaVRzPpuWLOCVO+Nm2S6wqKLLnWXqNfa+CyjBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9PoSkKPDu7dHcqz8t8Q1Kr7n4w2ffJ4LUE29bAAZxX/UoZCKWAYMCXEzpMPRzdOLq5cjbPO+PejXjDCOo+RAIdfmUReK8Ws7cP5b+OuHN31dwSILcWpXf0Bs/SUz5OT0N17bmki4L5wWdqxMKYaoUYnBW1ZCGwnsfeyzGUkIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+Czb1Bl; arc=none smtp.client-ip=91.218.175.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+Czb1Bl"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nkou3XaVRzPpuWLOCVO+Nm2S6wqKLLnWXqNfa+CyjBE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790566611; v=1; x=1791171411;
 b=w+Czb1BluN2ZeGiggmiC2x9y2mTZuOcej1NYnKkznGNowl6Oo9D+fY38msvGIHmjp8t2mtuR
 j/6mCLVqu3oUhlYqXr4mKTZ2O9gqF9d3I1K+zdBw1QQOFM18Z0ZmBf+AwGQnaxeM+K7e16pXmpC
 zZTtMGz0fycmM24L0dC8jK/A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7d80614aba9be4e8;
	Mon, 28 Sep 2026 03:36:51 +0000
X-Mizu-Trace-ID: 7d80614aba9be4e8
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2bef732-57ff-4000-9d89-36be91f27e07@linux.dev>
Date: Sun, 27 Sep 2026 20:36:48 -0700
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
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050143.2222664-1-yonghong.song@linux.dev>
 <a15ab7ae278b027898a8c42648927ac3787f041e33daec5237fc675f67a6eea1@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a15ab7ae278b027898a8c42648927ac3787f041e33daec5237fc675f67a6eea1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/26 1:24 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index f3dbc3b59bff..9afa163fac5a 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> index 25eeb1c1248b..65b55f7fa907 100644
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
> [ ... ]
>
>> @@ -311,6 +326,142 @@ static int parse_caps(const char *str, __u64 *val, const char *name)
>>   	return 0;
>>   }
>>
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
>> +		goto out;
>> +	}
>>                         ^^^^
> Can __ret_global() match a negative expected value for a 4-byte variable?
>
> parse_global_var() uses strtoull(), which takes a leading '-' and negates
> it as a 64-bit unsigned value. So __ret_global(err, -22) stores
> 0xffffffffffffffea (64 bits).
>
> But access_global_var() reads the 4-byte variable zero-extended:
>
>      *val = sz == 4 ? *(__u32 *)(buf + off) : *(__u64 *)(buf + off);
>
> and gets 0x00000000ffffffea (32 bits extended to 64). Then run_subtest()
> compares the two as __u64:
>
>      if (v != subspec->ret_global_val) {
>          PRINT_FAIL("Unexpected %s: 0x%llx != 0x%llx\n", ...);
>
> so the check always fails with "Unexpected err: 0xffffffea !=
> 0xffffffffffffffea", even though the program stored exactly -22.
>
> This matters in practice. Existing selftests keep negative errnos in
> 4-byte globals and check them from a hand-written driver, e.g.
> progs/test_bpf_nf.c has `int test_einval_reserved = 0;` checked in
> prog_tests/bpf_nf.c with `ASSERT_EQ(skel->bss->test_einval_reserved,
> -EINVAL, ...)`. The commit message says these tags are meant to replace
> that kind of driver. The neighbouring __retval() also supports negative
> values (parse_int() uses strtol() with a special case for INT_MIN), and 68
> programs under progs/ use __retval(-...).
>
> The write side does not have this problem. __set_global(err, -22)
> truncates to 0xffffffea and stores -22 correctly, so the same literal
> behaves differently in the two tags. 8-byte variables are fine because
> both sides are 64-bit.
>
> Should the expected value be truncated or sign-extended to the variable
> width (for example, compare only the low 32 bits when sz == 4, or
> sign-extend the value read back), or should out-of-range values be refused
> at parse time?

Right. Missed 4-byte value and also missed signedness. Will fix as commit
message promised.

>
> A related issue: __set_global() on a 4-byte variable silently drops any
> bits above 32:
>
>> +	if (sz == 4)
>> +		*(__u32 *)(buf + off) = *val;
> with no error. The tree allows it, but none of the tests in this series
> trigger it: they only use __u64 variables with non-negative values.
>
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
>> @@ -1532,6 +1720,13 @@ void run_subtest(struct test_loader *tester,
>>   			}
>>   		}
>>
>> +		if (subspec->has_set_global) {
>> +			__u64 v = subspec->set_global_val;
>> +
>> +			if (access_global_var(tobj, subspec->set_global_var, &v, true))
>> +				goto tobj_cleanup;
>> +		}
>> +
>>   		err = do_prog_test_run(bpf_program__fd(tprog), &retval,
>>   				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false,
>>   				       spec->linear_sz);
>> @@ -1540,6 +1735,18 @@ void run_subtest(struct test_loader *tester,
>>   			goto tobj_cleanup;
>>   		}
>>
>> +		if (subspec->has_ret_global) {
>> +			__u64 v = 0;
>> +
>> +			if (access_global_var(tobj, subspec->ret_global_var, &v, false))
>> +				goto tobj_cleanup;
>> +			if (v != subspec->ret_global_val) {
>> +				PRINT_FAIL("Unexpected %s: 0x%llx != 0x%llx\n",
>> +					   subspec->ret_global_var, v, subspec->ret_global_val);
>> +				goto tobj_cleanup;
>> +			}
>> +		}
>>                     ^^^^
> For a 4-byte variable, __ret_global() cannot match any expected value
> outside [0, UINT32_MAX], and that range includes every negative literal.
>
> parse_global_var() parses the value with strtoull(), so XSTR(-1) ("-1")
> becomes 0xffffffffffffffff. access_global_var() reads a 4-byte variable as
>
>      *val = sz == 4 ? *(__u32 *)(buf + off) : *(__u64 *)(buf + off);
>
> which zero-extends it to 0x00000000ffffffff. The comparison here then
> always fails for `int cnt; ... __ret_global(cnt, -1)`, printing
> "Unexpected cnt: 0xffffffff != 0xffffffffffffffff" even when the program
> set cnt to -1.
>
> __set_global() does not have this problem: the same value truncated into a
> __u32 stores -1 correctly. So the two tags do not agree on what a 4-byte
> value is.
>
> Values too wide for the variable are also not rejected:
> __set_global(int_var, 0x100000000) quietly writes 0.
>
> The commit message says 4-byte variables are supported and cites veristat
> as the model, but veristat's set_global_var() checks signedness and range
> ("Variable %s value %lld is out of range [%lld; %lld]").
>
> Should the expected value be truncated or sign-adjusted to the variable
> width (for example, compare only the low 32 bits when sz == 4), or should
> out-of-range values be refused at parse time?

Yes, should do similar thing to veristat to have sz == 4 support
and signedness support.

>
> No test in the series hits this today; they all use the __u64 pads_ran
> with positive masks.
>
>> +
>>   		verify_stderr(bpf_program__fd(tprog), &subspec->stderr);
>>
>>   		if (subspec->stdout.cnt) {
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

