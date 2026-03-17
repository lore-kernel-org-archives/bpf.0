Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EB2FF17A
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773725601; cv=none; b=SuD7RSAOzT9QPYrRENOefPx4mNpqC15jvkS/a/K4bigYWhXQ2a/K+frWyep5sXTMq6aUEUceBzNIqdQdI1XQbnTuOIUiJirlFhZpDUHZnqAI9Vz592kHd8w1fkvCNgHGgmbtceJpsNog5YYiX4Pd5asX2lT212RyW/gFHlPk/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773725601; c=relaxed/simple;
	bh=YC1rgBAajCCk8l/JLDgrMYW6Aksh2+JVhaIH6RadUyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4Ycl+H/ktQBL0nhoXsLMGzOEXoplqAy1FgRdlMgRW0cAZpFO0eVJPAPJhjJbkSIH99VtYbpcZKVEH9oDZHpgygYT2mo+NxqfeEqSwctnqycg+1KtubCkhHD+k5FNnpVDPZ4Gglk/uqC0BGAZLApFGZ+IsTbe9DXjr9xGb5otVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.192.132])
	by mtasvr (Coremail) with SMTP id _____wDXVe5o57hp_G4iAA--.1609S3;
	Tue, 17 Mar 2026 13:32:25 +0800 (CST)
Received: from [10.162.192.132] (unknown [10.162.192.132])
	by mail-app2 (Coremail) with SMTP id zC_KCgCHVDZn57hpFc5RBg--.24133S3;
	Tue, 17 Mar 2026 13:32:24 +0800 (CST)
Message-ID: <a7001753-59bb-427b-a67b-e089008a732b@zju.edu.cn>
Date: Tue, 17 Mar 2026 13:32:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for large offset
 bpf-to-bpf call
To: emil@etsalapatis.com, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
 <20260316190220.113417-3-tangyazhou@zju.edu.cn>
 <DH4HGGKLQ2EG.33P3WH3OF05RX@etsalapatis.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DH4HGGKLQ2EG.33P3WH3OF05RX@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgCHVDZn57hpFc5RBg--.24133S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgsNCmm4XQoUBQAAsd
X-CM-DELIVERINFO: =?B?Ub9cVAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9C4CHqQuqj3p+aV8+gK82UYaOmBlzhrGryjBmJU9tz+YOUp2SG+8TMww32AptghawTRe
	tdbtG23cUC40tjgFw50dcxNKvRcUsAMjlKV5V/WnZk9Hw2T8u6Y5UODMnaRHrw==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw18Xw43tw15uF17XF18Zwc_yoW5GF1fpF
	ZYg3yrtrWkJr1UKr12yayFqF1Skrs3Aa4xJrn3G3ykAas8Gry0gFyFgF4FvFWrCrn3XF12
	vrWjq343X3Z8uFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Thanks a lot for the detailed review!

 >> +	char dummy_data[64] = {};
 >
 > Nit: Why define dummy_data? You can make the function you're calling an
 > int (void) syscall to avoid this.
 > ......
 >> +struct __sk_buff;
 >
 > Can be removed if you use a syscall prog instead of a socket.
 > ......
 >> +	if (ctx == (void *)0)
 >
 > Nit: Would if (!ctx) work? What is this condition's purpose in the first
 > place? If it's deliberate, again can we add a comment?

The reason for using a socket prog and the `dummy_data` was to guarantee 
a non-null `ctx` parameter. Then, during the execution of this test 
program (while JIT is enabled), the useless `padding_subprog()` will be 
safely skipped.

If we remove the condition and just call `padding_subprog()`, the 
200,000 instructions in it will actually be executed, which not only 
causes lower performance but also risks hitting the BPF execution 
instruction limit.

However, your suggestion is much better. I will switch to a syscall prog 
to eliminate `dummy_data` and `struct __sk_buff`. And to safely skip the 
padding execution without relying on `ctx`, I will use a volatile variable:

	volatile int zero = 0;
	if (zero)
		padding_subprog();

I will also add detailed comments explaining this workaround.

 > So we only test one path at a time, correct? I understand there's no
 > good way to turn JIT compilation on and off, but as it stands

Yes, exactly. Actually the test dynamically adapts to the current 
environment.

- If JIT is enabled, the test case will successfully load and return the 
expected value.
- If JIT is disabled, it asserts that the verifier cleanly rejects the 
program with -EINVAL (or -ENOSPC) and outputs the expected error log. 
(Without our patch, the verifier would wrongly accept it).

 >> +	volatile int magic_ret = 3;
 >> +	return magic_ret;
 >
 >
 > If we remove the printk below, we can just leave this empty or have it
 > return 3 directly. Is there a reason to define the constant we're
 > returning indirectly? If there is there should be a comment about it
 > because right now it's not readily apparent.

Yes, this is another deliberate trick to deceive the LLVM compiler. 
Using `volatile` prevents LLVM from optimizing the whole 
`target_subprog()` away. I will add comments here as well.

 >> +	char log_buf[4096] = {};
 >
 > No need to init the log_buf, it will be NUL-terminated if load runs.
 > ...
 >> +	bpf_printk("Target subprog returned: %d\n", ret);
 >
 > Let's remove this, there's no reason to emit to the trace pipe even on
 > success.

I will also incorporate these two changes, and fold all these 
improvements into v2.

Best,

Yazhou

