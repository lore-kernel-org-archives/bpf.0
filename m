Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5529A31C
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908357; cv=none; b=Dwckz/0ha4R23gnGpJ8IqOFmJuHvGOeDFW9RszSbGyzlAOU8upO+OKx12dm5V+Xcz6TsgNTriSB0J1aXwDY9l+cDCTAoNdxFxHFq7071Mes/ducLYMz866xS06IEVufL3GvGpmD9OH3utaWKOb8TPc0y1zMvuvf0BI20kFegPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908357; c=relaxed/simple;
	bh=jLrld5ELw2bEkJ1H2U5JSeJni6GVj8ohfuNyxmo6roA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qNxjXgWaOqGrnVSbCnr1kSaSNJiav/yoxVJ5bCVrzcyVBs+bI1F9mDnyHC4mfisGS4AI66sob5sRBtHoEF8D08q2jByKCMMfv36RnYoC8KQFWh+shmlSl+dJ38Z5W1P7FCFaaKDdH6MqLY1LR9XvZuO+NNeslSeRW+5Elh1QykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxztL+UJFqjA0GAA--.16932S3;
	Fri, 28 Aug 2026 17:12:30 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxRs37UJFqZ1IVAA--.29910S2;
	Fri, 28 Aug 2026 17:12:27 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add test for indirect
 struct_ops trampoline
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260828042715.16546-1-yangtiezhu@loongson.cn>
 <20260828043635.D16DC1F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <34521092-ad56-d20f-4782-6fc661275e41@loongson.cn>
Date: Fri, 28 Aug 2026 17:12:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260828043635.D16DC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs37UJFqZ1IVAA--.29910S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKry8Xry8ZF4DWryUGw4UAwc_yoW7ur1fpF
	y8JF12yF4DXrWkXFy8Xa18ZF4Sgan7ZayUGFWUKr95uas5X3s8tF10qFySyr95G395ZFnI
	y3ZYvr1DZ3WxZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
	F4_UUUUU=

On 2026/8/28 下午12:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Use-After-Free and data races due to statically assigned and uncleared struct_ops pointer.
> --
> 
> commit 23e6150eb62c7059e7721142219a9a87264e2e46
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> selftests/bpf: Add test for indirect struct_ops trampoline
> 
> This commit adds a test case to verify that arguments passed on the stack
> are correctly read by the indirect struct_ops trampoline. It ensures the
> correctness of stack offsets on architectures like LoongArch and RISC-V.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
>> new file mode 100644
>> index 0000000000000..5a21aedd02fc5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include "struct_ops_trampoline.skel.h"
>> +
>> +#if defined(__loongarch__) || defined(__riscv)
>> +static void run_struct_ops_trampoline(void)
>> +{
> [ ... ]
>> +	bpf_link__destroy(link);
>> +cleanup:
>> +	struct_ops_trampoline__destroy(skel);
> 
> [Severity: High]
> Does this call to struct_ops_trampoline__destroy() free the map?
> 
> Later in this diff, we see that st_ops_trampoline in bpf_testmod.c is
> assigned dynamically allocated memory from this map. When the map is freed
> here, st_ops_trampoline appears to become a dangling pointer.
> 
>> +}
>> +#endif
> 
> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index 850cf4f830c48..be96bbc1b7c04 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> [ ... ]
>> @@ -637,6 +640,9 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>>   
>>   	bpf_testmod_test_struct_ops3();
>>   
>> +	if (st_ops_trampoline && st_ops_trampoline->test_trampoline)
>> +		st_ops_trampoline->test_trampoline(1, 2, 3, 4, 5, 6, 7, 8, 9999);
> 
> [Severity: High]
> Since st_ops_trampoline is never cleared after the map is freed, could this
> result in a use-after-free?
> 
> Any subsequent or parallel test in the suite that triggers
> trigger_module_test_read() will invoke bpf_testmod_test_read(), incorrectly
> evaluate st_ops_trampoline as valid, and dereference the freed memory.
> 
>> +
>>   	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
>>   				sizeof(int)), GFP_KERNEL);
> [ ... ]
>> @@ -1619,6 +1625,10 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
>>   		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
>>   		return 1;
>>   	}
>> +
>> +	if (member->offset == offsetof(struct bpf_testmod_ops, test_trampoline) * 8)
>> +		st_ops_trampoline = (struct bpf_testmod_ops *)kdata;
> 
> [Severity: High]
> Is it safe to unconditionally assign this global pointer to the map's
> dynamically allocated memory during initialization without setting up a
> cleanup mechanism?
> 
> Additionally, this assignment appears to occur without locking at map creation
> time, meaning parallel test runs could race to overwrite this pointer.

You are right. I will fix the use-after-free and race conditions.

Here is the incremental diff based on this v1 patch:

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c 
b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index be96bbc1b7c0..471e4ed4192e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -589,7 +589,7 @@ noinline int bpf_testmod_trampoline_count_test(void)
         return 0;
  }

-struct bpf_testmod_ops;
+static DEFINE_MUTEX(st_ops_trampoline_mutex);
  static struct bpf_testmod_ops *st_ops_trampoline;

  noinline ssize_t
@@ -640,8 +640,10 @@ bpf_testmod_test_read(struct file *file, struct 
kobject *kobj,

         bpf_testmod_test_struct_ops3();

+       mutex_lock(&st_ops_trampoline_mutex);
         if (st_ops_trampoline && st_ops_trampoline->test_trampoline)
                 st_ops_trampoline->test_trampoline(1, 2, 3, 4, 5, 6, 7, 
8, 9999);
+       mutex_unlock(&st_ops_trampoline_mutex);

         struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
                                 sizeof(int)), GFP_KERNEL);
@@ -1626,8 +1628,16 @@ static int bpf_testmod_ops_init_member(const 
struct btf_type *t,
                 return 1;
         }

-       if (member->offset == offsetof(struct bpf_testmod_ops, 
test_trampoline) * 8)
+       if (member->offset == offsetof(struct bpf_testmod_ops, 
test_trampoline) * 8) {
+               mutex_lock(&st_ops_trampoline_mutex);
+               if (st_ops_trampoline) {
+                       pr_err("st_ops_trampoline has already been 
registered\n");
+                       mutex_unlock(&st_ops_trampoline_mutex);
+                       return -EEXIST;
+               }
                 st_ops_trampoline = (struct bpf_testmod_ops *)kdata;
+               mutex_unlock(&st_ops_trampoline_mutex);
+       }

         return 0;
  }
@@ -1663,6 +1673,10 @@ static int bpf_dummy_reg(void *kdata, struct 
bpf_link *link)

  static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
  {
+       mutex_lock(&st_ops_trampoline_mutex);
+       if (st_ops_trampoline == (struct bpf_testmod_ops *)kdata)
+               st_ops_trampoline = NULL;
+       mutex_unlock(&st_ops_trampoline_mutex);
  }

  static int bpf_testmod_test_1(void)

Thanks,
Tiezhu

