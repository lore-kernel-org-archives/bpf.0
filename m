Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29841A6830
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322244; cv=none; b=UjL66/9AeJFs/mhEnvlR35nyG4nbuHJQVL9ErOp0/K8IW0HOrHYQBt3hmmDH7dOKsl3obq+dilxcbc1rlQkiJR4TML40hHrKfTzi365H0+/uu+NutyfuRd5mB9MXECRGNzC5x8VIAMaTA++26o/9/9FZE5BJjO1HXsi2U3IAU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322244; c=relaxed/simple;
	bh=gVTxH1EghJwc2fd27BwqRfr3Nh2rQDaJnZHPE56qClc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=At3pmbGjZoc3zEU5pc0swlxc/+IlW8CCnTR1YaHWGt/jZGnPV8jhqQT4OknjN+QxqPfqUypt8XH9R0ezmDrPy/rvzFUwTgr3fURTfx/86dI+IytHZWSNcVvBLObrNHIgXZEiJUQzBhfM91fqWT97GaK3aVfC5XC5JPmK0RVohyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.161.208])
	by mtasvr (Coremail) with SMTP id _____wDHRfYLAsJpAsZLAA--.12101S3;
	Tue, 24 Mar 2026 11:16:28 +0800 (CST)
Received: from [0.0.0.0] (unknown [183.157.161.208])
	by mail-app2 (Coremail) with SMTP id zC_KCgA3p8wKAsJpc5kaAA--.26752S3;
	Tue, 24 Mar 2026 11:16:26 +0800 (CST)
Message-ID: <76d35443-8980-4f2f-8943-7dfb43c95e00@zju.edu.cn>
Date: Tue, 24 Mar 2026 11:16:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/3] selftests/bpf: Add test for large offset
 bpf-to-bpf call
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
 <20260323122254.98540-3-tangyazhou@zju.edu.cn>
 <DHA91D8WS7HK.2N4F9P08CTI55@etsalapatis.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DHA91D8WS7HK.2N4F9P08CTI55@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgA3p8wKAsJpc5kaAA--.26752S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgEACmnBl4sPlQAAsn
X-CM-DELIVERINFO: =?B?jLm7xAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BAq/vOONljAQYfYEwFD6YgIGrey/nQsKiuFEqOl3hBaCOz5wAZEdMcXQ5Rjw7oyKWZ8
	pHPFuGeBe7eXiPSTAgW4+mFMLQ2OVYRIXK1tJi6oU5tqiPhi8qvHA2XYYixBQw==
X-Coremail-Antispam: 1Uk129KBj93XoW3WryfKFy8AFyUKr4xGry7XFc_yoWxAF1Upa
	4kGFy5KF4xGFy7Cr17Aa9rZFnxKF4kZFyjyr4Iqry5Awn8AryxGrs7KrW5WFyfCrs3Aw1F
	vFWqvan3ur48GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13r
	cDUUUUU==

Hi Emil,

Thanks for your review.

On 3/23/26 22:59, Emil Tsalapatis wrote:
> On Mon Mar 23, 2026 at 8:22 AM EDT, Yazhou Tang wrote:
>> From: Yazhou Tang <tangyazhou518@outlook.com>
>>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
>> Add a selftest to verify the verifier and JIT behavior when handling
>> bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.
>>
>> The test utilizes an inline assembly block with ".rept 200000" to generate
>> a massive dummy subprogram. By placing this padding between the main program
>> and the target subprogram, it forces the verifier to process a bpf-to-bpf call
>> with the imm field exceeding the s16 range.
>>
>> The user-space test driver dynamically adapts to the host's configuration:
>> - When JIT is enabled, it asserts that the program is successfully loaded,
>>    JIT-compiled, and executes correctly to return the expected value.
>> - When JIT is disabled, it asserts that the verifier cleanly rejects the
>>    program with -EINVAL (or -ENOSPC if the log buffer is truncated), matching
>>    the expected "offset out of range" error log.
>>
>> Note: To ensure the test is both effective at load time and efficient at
>> runtime, two specific tricks are employed:
>> 1. Prevent Compiler Optimization: A volatile variable (magic_ret) is used
>>     inside target_subprog(). This prevents the compiler from optimizing
>>     the function away or aggressively inlining it, ensuring the subprogram
>>     and the call instruction are strictly retained in the final BPF bytecode.
>> 2. Prevent Execution Degradation: The massive padding subprogram is
>>     conditionally called using a global volatile variable ("int zero", whose
>>     value is actually 0). This forces the verifier to statically analyze the
>>     branch and calculate the giant jump offset, but allows the runtime to
>>     completely bypass the 200,000 dummy instructions, preventing performance
>>     degradation during test execution.
> 
> Nit: You can remove these notes imo, they are way too specific for the
> commit description and are relatively frequently used programming idioms
> for BPF.
> 
> Another nit below.

Agreed. I will drop these notes in the v4 commit message.

>> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
>> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
>> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
>> ---
>>   .../selftests/bpf/prog_tests/call_large_imm.c | 54 +++++++++++++++++++
>>   .../selftests/bpf/progs/call_large_imm.c      | 37 +++++++++++++
>>   2 files changed, 91 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/call_large_imm.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/call_large_imm.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/call_large_imm.c b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
>> new file mode 100644
>> index 000000000000..8968b3c3263f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/call_large_imm.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "call_large_imm.skel.h"
>> +
>> +/*
>> + * This test dynamically adapts to the current environment, and will succeed
>> + * whether JIT is enabled or not.
>> + * 1. If JIT is enabled: The test case will successfully load and return
>> + *    the expected value.
>> + * 2. If JIT is disabled: It asserts that the verifier cleanly rejects the
>> + *    program with -EINVAL (or -ENOSPC) and outputs the expected error log.
>> + */
>> +
>> +void test_call_large_imm(void)
>> +{
>> +	struct call_large_imm *skel;
>> +	int err, prog_fd;
>> +	char log_buf[4096];
>> +
>> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
>> +
>> +	skel = call_large_imm__open();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +		return;
>> +
>> +	if (!env.jit_enabled)
>> +		bpf_program__set_log_buf(skel->progs.call_large_imm_test,
>> +					 log_buf, sizeof(log_buf));
>> +
>> +	err = call_large_imm__load(skel);
>> +
>> +	if (env.jit_enabled) {
>> +		if (!ASSERT_OK(err, "load_should_succeed_with_jit"))
>> +			goto cleanup;
>> +
>> +		prog_fd = bpf_program__fd(skel->progs.call_large_imm_test);
>> +		err = bpf_prog_test_run_opts(prog_fd, &opts);
>> +
>> +		if (ASSERT_OK(err, "prog_run_success"))
>> +			ASSERT_EQ(opts.retval, 3, "prog_retval");
>> +
>> +	} else {
>> +		ASSERT_ERR(err, "load_should_fail_in_interpreter");
>> +		ASSERT_TRUE(err == -EINVAL || err == -ENOSPC, "err_should_be_einval_or_enospc");
>> +
>> +		if (!ASSERT_OK_PTR(strstr(log_buf, "bpf-to-bpf call offset out of range for interpreter"),
>> +				   "check_verifier_log_msg")) {
>> +			printf("Actual verifier log:\n%s\n", log_buf);
>> +		}
>> +	}
>> +
>> +cleanup:
>> +	call_large_imm__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/call_large_imm.c b/tools/testing/selftests/bpf/progs/call_large_imm.c
>> new file mode 100644
>> index 000000000000..5c59141cb474
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +/*
>> + * A volatile global variable is used here, so that padding_subprog()
>> + * will not be optimized, and it will not be really executed even if
>> + * it is successfully loaded (when JIT is enabled).
>> + */
>> +volatile int zero = 0;
>> +
>> +static __attribute__((noinline)) void padding_subprog(void)
>> +{
>> +	asm volatile ("					\
>> +		r0 = 0;					\
> 
> Nit: Is it possible to make this value exactly as large as it needs to
> be to trigger the verifier failure? Along with an explanation as to why
> it is that exact size that triggers it.

Sure. I will reduce the padding size from 200,000 to exactly 32,765 
(which is the precise number of instructions required to trigger the 
verifier failure) and add a comment in v4 explaining the reason.

>> +		.rept 200000;				\
>> +		r0 += 0;				\
>> +		.endr;					\
>> +	" ::: "r0");
>> +}
>> +
>> +static __attribute__((noinline)) int target_subprog(void)
>> +{
>> +	/* A volatile variable is used here to prevent optimization. */
>> +	volatile int magic_ret = 3;
>> +	return magic_ret;
>> +}
>> +
>> +SEC("syscall")
>> +int call_large_imm_test(void *ctx)
>> +{
>> +	if (zero)
>> +		padding_subprog();
>> +	return target_subprog();
>> +}
>> +
>> +char LICENSE[] SEC("license") = "GPL";

