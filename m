Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27056770
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123635; cv=none; b=sG4IapiCTmjuuXVA5avSBnRo45TmHVp8r9wwHtnugHOdo8pJTjAN7gsBuYK1tI9jmQ6F6kYMNg6LxX7ktCpVzLg+Oo4JqrbJy9+gAdB3cXLoLZO4IAIROg6lmbrSDa5iWLj1yfy+X0VnCkwp2tgIYurdp6zMIMgiaK5vd9tubrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123635; c=relaxed/simple;
	bh=E3zQzVGBCYiKXp9TPwwOpPrKVr8YgBcxJtcK+4uscxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rieGdQG+FRHBdaAIs40jMKKLpqb542gFWFlm04+D/dOmh9fnfIr5Ef6VJZbqpQ5G/3s5ZTypSPG9JebHWqHqmoWzS5nTlzTSJJrCP0Z5sg2OGgHO2X8tXeZnkpf8BNBC3fNoIPhzIWoS1L15mIkf0Vf4b+paj70TXnqSm/Yp5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f0qd0LQV; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f0qd0LQV"
Message-ID: <0bb5c256-a564-417c-b252-166aec017870@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711123631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNemCdF+NoIYkbP1zP0kKTG2KeosSB2tfjJ0M7JtsS8=;
	b=f0qd0LQVQTx+x4GJX51Z4zfcc3xf+EPfzEjgijmO4jDKQXgez+MCXzUzH+rnZ8bxYB5sOz
	BVfmD+xNHIz1i+zIYHqAA/qfPtJRhUoSDShDj+8fpl4OALZfa+Sudhpj0Czz85P7ikypV/
	1w7Ki/5Vsp4x+dgH3mmG4SUrFn1f+vY=
Date: Fri, 22 Mar 2024 09:07:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Add a selftest with
 available_filter_functions_addrs
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200124.2220345-1-yonghong.song@linux.dev> <Zf147sHXbgMs1yDZ@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zf147sHXbgMs1yDZ@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 5:26 AM, Jiri Olsa wrote:
> On Thu, Mar 21, 2024 at 01:01:24PM -0700, Yonghong Song wrote:
>> The current kprobe_multi_bench_attach/kernel test
>> reads sym names from /sys/kernel/tracing/available_filter_functions.
>> Some names do not agree with the corresponding entries in /proc/kallsyms
>> since the corresponding /proc/kallsyms syms have suffix '.llvm.<hash>'.
>> Actually, if we pass symbol names in /proc/kallsyms,
>> kprobe_multi_attach will be okay.
>>
>> This patch added a new subtest where addresses are retrieved from
>> /sys/kernel/tracing/available_filter_functions_addrs, and use the
>> address to consule /proc/kallsyms to get the function name.
> hm, I don't understand the reason for this test.. AFAICS test_kprobe_multi_bench_attach
> is doing that already, just reading available_filter_functions file
>
> both available_filter_functions_addrs and available_filter_functions have the
> same functions, there's just extra addresses in available_filter_functions_addrs

The goal is to include those kernel functions filtered in patch 4.
But we cannot use the names from available_filter_functions[_addrs],
and we need to get names from /proc/kallsyms. Hence this patch.
This will test if we give names (<name>.llvm.<hash>) to kernel
for kprobe_multi_attach, things will be okay.

>
>> +	*symsp = syms;
>> +	*cntp = cnt;
>> +
>> +error:
>> +	fclose(f);
>> +	hashmap__free(map);
>> +	if (err) {
>> +		for (i = 0; i < cnt; i++)
>> +			free(syms[i]);
>> +		free(syms);
>> +	}
>> +	return err;
>> +}
>> +
>>   static void test_kprobe_multi_bench_attach(bool kernel)
>>   {
>>   	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
>> @@ -521,6 +617,47 @@ static void test_attach_override(void)
>>   	kprobe_multi_override__destroy(skel);
>>   }
> there's lot of duplicated code in both
>    get_syms_from_addr/get_syms
>    test_attach_kernel_addrs_to_sym/test_kprobe_multi_bench_attach
>
> would be great to put it together

I will give a try in the next revision.

>
>>   
>> +static void test_attach_kernel_addrs_to_sym(void)
>> +{
>> +	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
>> +	struct kprobe_multi_empty *skel;
>> +	struct bpf_link *link;
>> +	char **syms = NULL;
>> +	size_t cnt = 0;
>> +	int i, err;
>> +
>> +	err = get_syms_from_addr(&syms, &cnt);
>> +	if (err == -ENOENT) {
>> +		test__skip();
>> +		return;
>> +	}
>> +	if (!ASSERT_OK(err, "get_syms_from_addr"))
>> +		return;
>> +
>> +	skel = kprobe_multi_empty__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
>> +		goto cleanup;
>> +
>> +	opts.syms = (const char **) syms;
>> +	opts.cnt = cnt;
>> +
>> +	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_empty,
>> +						     NULL, &opts);
>> +
>> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
>> +		goto cleanup;
>> +
>> +	bpf_link__destroy(link);
>> +
>> +cleanup:
>> +	kprobe_multi_empty__destroy(skel);
>> +	if (syms) {
>> +		for (i = 0; i < cnt; i++)
>> +			free(syms[i]);
>> +		free(syms);
>> +	}
>> +}
>> +
>>   void serial_test_kprobe_multi_bench_attach(void)
>>   {
>>   	if (test__start_subtest("kernel"))
>> @@ -550,4 +687,6 @@ void test_kprobe_multi_test(void)
>>   		test_attach_api_fails();
>>   	if (test__start_subtest("attach_override"))
>>   		test_attach_override();
>> +	if (test__start_subtest("kernel_addrs_to_sym"))
>> +		test_attach_kernel_addrs_to_sym();
> we moved the bench subtests to serial_test_kprobe_multi_bench_attach,
> not to clash with others in parallel mode

Okay, I will put it in serial mode in next revision.

>
> jirka
