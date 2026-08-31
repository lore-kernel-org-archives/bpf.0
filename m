Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877234CFC2
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172859; cv=none; b=bT9sTWS710l94yVQtUZC0t18jcVWxFM4Guq2mE7ROyDePaySFKIxYJOFowyJF/rnijzlynfXHktaYI7yi6Kalw/PP98xovnpJoXj/CoorX1+aeDe3zNGK+5KjGI7pFB9atNj/gy+ZH4dH3iczEfCEIL4cKBqOGGCZLcrwMw54HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172859; c=relaxed/simple;
	bh=H/qisQv/xH78yLgb1nRbzW8PNsF3r6Zv2D3mkxFKRXo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OZnMD7k6JC7G8p7WertdlfwmBTnLmtGIB+u0EsSXogpAosTiO0I50rYkfPhDAbXBCnLtdFuPfPuHsWC4u9N20lfZKP4Uvn2mhbgLtlBTL0ozAKaGM+COtmGDZoqQhPm7Wxon4Elo25Z/1BDjGsyFhHTJI9pTpaUkpNmkzjsVgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Axj9E1WpVqUuEGAA--.19264S3;
	Mon, 31 Aug 2026 18:40:53 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxTs8yWpVq5TwYAA--.51136S2;
	Mon, 31 Aug 2026 18:40:51 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add test for indirect
 struct_ops trampoline
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260831085705.13747-1-yangtiezhu@loongson.cn>
 <20260831090820.298AC1F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3d549674-0e91-8d93-16e8-d6178fe79296@loongson.cn>
Date: Mon, 31 Aug 2026 18:40:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260831090820.298AC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTs8yWpVq5TwYAA--.51136S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw4xuFy5uw1xKw47Jw1fAFc_yoWfJrWDpF
	y8J3WYyFs5Zr4DXF18Xa1UXF4Fgrs7Z34jkrW8G3s5CF93X3srJF18KFWfCr95GrZ5Zr1a
	y3savr15Aa1UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ui
	iSdUUUUU=

On 2026/8/31 下午5:08, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The introduction of global state (`st_ops_trampoline` and its mutex) in `bpf_testmod` causes parallel test breakages, permanent DoS, and Use-After-Free (UAF).
> - [Medium] Removal of `RUN_TESTS` drops declarative verifier failure message matching, masking verifier bugs.
> --
> 
> commit 932e6a2ea3847d584c9e377639c762f03a9fe713
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> selftests/bpf: Add test for indirect struct_ops trampoline
> 
> Add a test case to verify that arguments passed on the stack are correctly
> read by an indirect struct_ops trampoline.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
>> index 0f321e8898620..7f6f9d61c9e07 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
>> @@ -3,7 +3,54 @@
>>   #include <test_progs.h>
>>   #include "struct_ops_multi_args.skel.h"
>>   
>> +static void test_refcounted_multi(void)
>> +{
>> +	struct struct_ops_multi_args *skel;
>> +	int err;
>> +
>> +	skel = struct_ops_multi_args__open();
>> +	if (!ASSERT_OK_PTR(skel, "struct_ops_multi_args__open"))
>> +		return;
>> +
>> +	err = struct_ops_multi_args__load(skel);
>> +	ASSERT_EQ(err, -EINVAL, "struct_ops_multi_args__load");
> 
> [Severity: Medium]
> Does this replace the test_loader's verifier log parsing with a manual
> assertion?
> 
> By dropping RUN_TESTS in test_struct_ops_multi_args(), the test now silently
> passes on any verifier error (such as invalid BTF or a missing map) returning
> -EINVAL rather than validating the exact failure condition. This masks
> potential verifier bugs.

I will manually use bpf_program__set_log_buf() to capture and verify
the log "program with __ref argument cannot tail call", like this:

```
diff --git 
a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c 
b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
index 7f6f9d61c9e0..c77601d4836c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
@@ -6,15 +6,23 @@
  static void test_refcounted_multi(void)
  {
         struct struct_ops_multi_args *skel;
+       char log_buf[4096] = {};
         int err;

         skel = struct_ops_multi_args__open();
         if (!ASSERT_OK_PTR(skel, "struct_ops_multi_args__open"))
                 return;

+       bpf_program__set_log_buf(skel->progs.test_refcounted_multi, 
log_buf, sizeof(log_buf));
+
         err = struct_ops_multi_args__load(skel);
-       ASSERT_EQ(err, -EINVAL, "struct_ops_multi_args__load");
+       if (!ASSERT_EQ(err, -EINVAL, "struct_ops_multi_args__load"))
+               goto out;

+       ASSERT_OK_PTR(strstr(log_buf, "program with __ref argument 
cannot tail call"),
+                     "check_verifier_log_message");
+
+out:
         struct_ops_multi_args__destroy(skel);
  }

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c 
b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
index f0f47676b099..3176f5bd7798 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
@@ -17,7 +17,6 @@ struct {
  } prog_array SEC(".maps");

  SEC("struct_ops/test_refcounted_multi")
-__failure __msg("program with __ref argument cannot tail call")
  int test_refcounted_multi(unsigned long long *ctx)
  {
         /* ctx[2] is used because the refcounted variable is the third 
argument */
```

> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index 2380b6cbdeadc..8f0744e6075b3 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> [ ... ]
>> @@ -1691,6 +1694,18 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
>>   		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
>>   		return 1;
>>   	}
>> +
>> +	if (member->offset == offsetof(struct bpf_testmod_ops, test_trampoline_stack_args) * 8) {
>> +		mutex_lock(&st_ops_trampoline_mutex);
>> +		if (st_ops_trampoline) {
>> +			pr_err("st_ops_trampoline has already been registered\n");
>> +			mutex_unlock(&st_ops_trampoline_mutex);
>> +			return -EEXIST;
>> +		}
>> +		st_ops_trampoline = (struct bpf_testmod_ops *)kdata;
> 
> [Severity: High]
> Can this cause a permanent denial of service in the test module?
> 
> This assigns the global pointer st_ops_trampoline to map-owned memory (kdata)
> in bpf_testmod_ops_init_member() without establishing a teardown hook to clear
> it if map registration fails after this point. If a failure occurs, the
> pointer remains dangling, causing permanent -EEXIST failures for all
> subsequent tests.
> 
> Additionally, this logic actively rejects concurrent map updates across all
> parallel test executions.
> 
>> +		mutex_unlock(&st_ops_trampoline_mutex);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1720,11 +1735,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>>   	if (ops->test_2)
>>   		ops->test_2(4, ops->data);
>>   
>> +	mutex_lock(&st_ops_trampoline_mutex);
>> +	if (st_ops_trampoline && st_ops_trampoline->test_trampoline_stack_args)
>> +		st_ops_trampoline->test_trampoline_stack_args(1, 2, 3, 4, 5, 6, 7, 8, 9999);
> 
> [Severity: High]
> Could this lead to a use-after-free?
> 
> This dereferences the global st_ops_trampoline which may point to freed memory
> if a previous map update failed or if a map was concurrently detached. Since
> the local ops pointer (kdata) is already passed directly to bpf_dummy_reg(),
> is there any reason not to use ops directly here instead of relying on the
> global state?

I will drop global state and mutex, just use the original kdata
in bpf_dummy_reg(), like this:

```
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c 
b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 8f0744e6075b..bb800bf2b0fd 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1678,9 +1678,6 @@ static bool bpf_testmod_ops_is_valid_access(int 
off, int size,
         return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
  }

-static DEFINE_MUTEX(st_ops_trampoline_mutex);
-static struct bpf_testmod_ops *st_ops_trampoline;
-
  static int bpf_testmod_ops_init_member(const struct btf_type *t,
                                        const struct btf_member *member,
                                        void *kdata, const void *udata)
@@ -1695,17 +1692,6 @@ static int bpf_testmod_ops_init_member(const 
struct btf_type *t,
                 return 1;
         }

-       if (member->offset == offsetof(struct bpf_testmod_ops, 
test_trampoline_stack_args) * 8) {
-               mutex_lock(&st_ops_trampoline_mutex);
-               if (st_ops_trampoline) {
-                       pr_err("st_ops_trampoline has already been 
registered\n");
-                       mutex_unlock(&st_ops_trampoline_mutex);
-                       return -EEXIST;
-               }
-               st_ops_trampoline = (struct bpf_testmod_ops *)kdata;
-               mutex_unlock(&st_ops_trampoline_mutex);
-       }
-
         return 0;
  }

@@ -1735,20 +1721,14 @@ static int bpf_dummy_reg(void *kdata, struct 
bpf_link *link)
         if (ops->test_2)
                 ops->test_2(4, ops->data);

-       mutex_lock(&st_ops_trampoline_mutex);
-       if (st_ops_trampoline && 
st_ops_trampoline->test_trampoline_stack_args)
-               st_ops_trampoline->test_trampoline_stack_args(1, 2, 3, 
4, 5, 6, 7, 8, 9999);
-       mutex_unlock(&st_ops_trampoline_mutex);
+       if (ops->test_trampoline_stack_args)
+               ops->test_trampoline_stack_args(1, 2, 3, 4, 5, 6, 7, 8, 
9999);

         return 0;
  }

  static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
  {
-       mutex_lock(&st_ops_trampoline_mutex);
-       if (st_ops_trampoline == (struct bpf_testmod_ops *)kdata)
-               st_ops_trampoline = NULL;
-       mutex_unlock(&st_ops_trampoline_mutex);
  }

  static int bpf_testmod_test_1(void)
```

I will send out the v3 next week if no more comments.

Thanks,
Tiezhu

