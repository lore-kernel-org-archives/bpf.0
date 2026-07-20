Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A37261A
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784523774; cv=none; b=tordIqcM1wGR6s1ON8/q0uyLV746cuSHnPDp36XQkj/FWwxPk90cJvlyU5wyRCv8TnfoxkHMw1Iu695clFLVXhRI3fxqpMSWW8F62CT/6mTLtqfo4/7lhY2sUcBfA2RaV3zdqld5Ru8/3C55kOTXMpnRa7ZrnFR1dh+ie/03rYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784523774; c=relaxed/simple;
	bh=B7ZvxJsC8diZmdhLysIevnmlY7OQ8NTkW5+aLPRXRq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCv22kK9A7mjMNlRgAGLziZdRJtCjAGljLpLhgJyY2DRjZFk/n/QeVuHg47rQdiWLRzaq0+hv0E2gd6TOdk2q47lq9l9Rw95lPWEkv1NT8dSoagb9ScQICyZ+1w61W4HO9/GN+ln9qMX4iVImOridom+8CwYMMMqvfJu9KkF0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=unYm0qji; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="unYm0qji"
Message-ID: <73de7b8e-f3b6-43c7-8195-3d30a72673dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784523770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH5XAE360tRMvZufZW4A+eISoQ2yYoUAvrIT/SUApfs=;
	b=unYm0qjieI+grpf3r62OLDwEjLJXIQDikDBepa/hdyxIn3+xChXoG2G3VVYCzTLVIbBM70
	XKC10aUh+aLRLaJR4hV7Djp1QW5ro9a+BjleNKmwviIVcVgS39n0sMZCyrm2ggeEgzwUDk
	eJILSnZ1Ku0qlqru7SDEcZznu8Nft14=
Date: Mon, 20 Jul 2026 13:02:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 6/9] selftests/bpf: Add tests to verify
 global percpu data
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
 <20260715153254.92010-7-leon.hwang@linux.dev>
 <DK17N9ROVHRL.23B11VSVOOL6E@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DK17N9ROVHRL.23B11VSVOOL6E@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/7/26 06:47, Emil Tsalapatis wrote:
> On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:

[...]

>> +
>> +static void test_percpu_data_on_cpus(int map_fd, int prog_fd)
>> +{
>> +	__u64 args[2] = {0x1234ULL, 0x5678ULL};
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		    .ctx_in = args,
>> +		    .ctx_size_in = sizeof(args),
>> +		    .flags = BPF_F_TEST_RUN_ON_CPU,
>> +	);
>> +	int i, err, key = 0, num_online;
>> +	bool *online;
>> +
>> +	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
>> +	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
>> +		return;
>> +
>> +	/* run on every online-CPU */
>> +	for (i = 0; i < num_online; i++) {
>> +		struct test_global_percpu_data__percpu data = {};
>> +		__u64 flags;
>> +
>> +		if (!online[i])
>> +			continue;
>> +
>> +		topts.cpu = i;
>> +		topts.retval = -1;
>> +		err = bpf_prog_test_run_opts(prog_fd, &topts);
>> +		ASSERT_OK(err, "bpf_prog_test_run_opts");
>> +		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
>> +
>> +		flags = ((__u64) i << 32) | BPF_F_CPU;
>> +		err = bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);
>> +		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags"))
>> +			break;
>> +
>> +		ASSERT_EQ(data.data, 1, "data.data");
>> +		ASSERT_TRUE(data.run, "data.run");
>> +		ASSERT_EQ(data.nums[6], 0xc0de, "data.nums[6]");
>> +		ASSERT_EQ(data.struct_data.i, 1, "struct_data.i");
>> +		ASSERT_TRUE(data.struct_data.set, "struct_data.set");
>> +		ASSERT_EQ(data.struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
> 
> Can we add a pre-run assert to ensure that the per-cpu data has not
> already been modified by another run? Can we also add some cpuid
> specific assignment to ensure the runs are done on the proper CPU?


Ack.

> 
>> +	}
>> +
>> +	free(online);
>> +}
>> +

[...]

>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
>> new file mode 100644
>> index 000000000000..8aebd533d86b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "test_global_percpu_data.subskel.h"
>> +
>> +void test_global_percpu_data_subskel(void)
>> +{
>> +	struct test_global_percpu_data *subskel = NULL;
>> +	struct bpf_object *obj;
>> +	int i;
>> +
>> +	obj = bpf_object__open_file("./test_global_percpu_data.bpf.o", NULL);
>> +	if (!ASSERT_OK_PTR(obj, "bpf_object__open_file"))
>> +		return;
>> +
>> +	subskel = test_global_percpu_data__open(obj);
>> +	if (!ASSERT_OK_PTR(subskel, "test_global_percpu_data__open"))
>> +		goto out;
>> +
>> +	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
>> +		goto out;
>> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
>> +		goto out;
>> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRAY,
>> +		  "percpu_map_type");
> 
> Not sure why these assertions would be necessary, wouldn't the test crash or
> quickly fail if they didn't hold?
> 
>> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");
>> +
>> +	for (i = 0; i < subskel->subskel->var_cnt; i++) {
>> +		const struct bpf_var_skeleton *var;
>> +
>> +		var = (void *) subskel->subskel->vars + i * subskel->subskel->var_skel_sz;
>> +		ASSERT_NEQ(var->map, &subskel->maps.percpu, "var");
>> +	}
> 
> If we turn the substest to SYSCALL instead of TRACEPOINT we can read
> and report the return value as the test happens and keep them
> self-contained.


It is to verify that the bpftool-generated subskeleton should not
contain the global percpu variables.

I think I should test it manually by checking the generated .subskel.h.

Will drop this subskel test.

> 
>> +
>> +out:
>> +	test_global_percpu_data__destroy(subskel);
>> +	bpf_object__close(obj);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> new file mode 100644
>> index 000000000000..54380dfb11a5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +int unused SEC(".percpu.looooooooong");
>> +int data2 SEC(".percpu.data");
>> +int data SEC(".percpu") = -1;
>> +int nums[7] SEC(".percpu");
>> +char run SEC(".percpu") = 0;
> 
> Can we add a comment that those are used to test the names in the
> userspace portion of the test? As they stand they seem unused.

Ack.

> 
>> +struct {
>> +	char set;
>> +	int i;
>> +	int nums[7];
>> +} struct_data SEC(".percpu") = {
>> +	.set = 0,
>> +	.i = -1,
>> +};
>> +
>> +SEC("raw_tp/task_rename")
> 
> Is this actually installed as a tracepoint? I think we run it as a
> program. Is putting it in raw_tp doing anything in any way?


Will drop '/task_rename'.

Thanks,
Leon

> 
>> +__auxiliary
>> +int update_percpu_data(void *ctx)
>> +{
>> +	struct_data.nums[6] = 0xc0de;
>> +	struct_data.set = 1;
>> +	struct_data.i = 1;
>> +	nums[6] = 0xc0de;
>> +	data = 1;
>> +	run = 1;
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
> 

