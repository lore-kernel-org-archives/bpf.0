Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77248470E99;
	Thu, 23 Jul 2026 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774225; cv=none; b=m/1BBOBiLFeStbfnWGjtk7J7HCeq0PaRJ6ID5/LB/iVqVXmealeDhlTbpfpXtYjoxfvyBlYdTgLtUY/+vshHhQuRydii4vflz/V/NWuEIF6oSMyoxRfu0/sKTk8yhfmqcuBuHmBurahck+tBzGf84y41sqTZTZPBqPck0UR/NCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774225; c=relaxed/simple;
	bh=8wk/bP64hP2KTssLfv6UY/2vePcRTwVYSH6ldbyD1uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esia1IULVg1oycB+/8g9RwARZ6Ospw9bMQur7TEJreVzDUeahyBqQ+1UIGx4tmVyeSzfpj5cpaXTwTGmp6Pc4wFKFPWtTHFRURWbyay8KonQ+yX1CyJKVX/P7Flnd1mVkB0u+8YPsoE7COKAUdNkyyfA+I7vONgg8ur9CMffdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c3682fa863f11f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e839a83c-428e-4535-b3d4-f85157ba64fe,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:e7bac3a,CLOUDID:d2742e206fa6391dd61c9f0c70fa0008,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c3682fa863f11f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 200611879; Thu, 23 Jul 2026 10:36:51 +0800
Message-ID: <de2da58a-ae94-4e38-b9cc-517e48d894c3@kylinos.cn>
Date: Thu, 23 Jul 2026 10:36:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: test timed may_goto
 preserves R0-R5
To: Pu Lehui <pulehui@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn>
 <20260722-riscv-bpf-timed-may-goto-v4-2-e117e6337bc7@kylinos.cn>
 <2cd8255d-2b0a-45d8-bbc2-ac19e196c41a@huawei.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <2cd8255d-2b0a-45d8-bbc2-ac19e196c41a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/22 19:10, Pu Lehui wrote:
> 
> 
> On 2026/7/22 12:21, Feng Jiang wrote:
>> Add a test that checks R0-R5 are preserved across
>> arch_bpf_timed_may_goto() calls.
>>
>> Use bpf_get_prandom_u32() to avoid the verifier removing the checks
>> via DCE.
>>
>> Suggested-by: Björn Töpel <bjorn@kernel.org>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> ---
>>   .../selftests/bpf/progs/verifier_may_goto_1.c      | 57 ++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
>> index 4bdf4256a41e..98d59108d097 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
>> @@ -106,4 +106,61 @@ __naked void may_goto_batch_2(void)
>>       : __clobber_all);
>>   }
>>   +/*
>> + * Use bpf_get_prandom_u32() to prevent DCE from removing the checks.
>> + * retval: 0=all ok, 1-6=R0-R5 clobbered.
>> + */
>> +SEC("raw_tp")
>> +__description("timed may_goto preserves R0-R5")
>> +__arch_x86_64
>> +__arch_arm64
>> +__arch_riscv64
>> +__success
>> +__retval(0)
> 
> __arch_s390x is also supported timed_may_goto

Will add it in v5.

> 
>> +__naked void timed_may_goto_preserves_regs(void)
>> +{
>> +    asm volatile (
>> +    "call %[bpf_get_prandom_u32];"
>> +    "r6 = r0;"
>> +    "r0 = 0x1111;"
>> +    "r0 += r6;"
>> +    "r1 = 0x2222;"
>> +    "r1 += r6;"
>> +    "r2 = 0x3333;"
>> +    "r2 += r6;"
>> +    "r3 = 0x4444;"
>> +    "r3 += r6;"
>> +    "r4 = 0x5555;"
>> +    "r4 += r6;"
>> +    "r5 = 0x6666;"
>> +    "r5 += r6;"
>> +    ".8byte %[may_goto];"
>> +    ".8byte %[loop];"
>> +    "r0 -= r6;"
>> +    "r1 -= r6;"
>> +    "r2 -= r6;"
>> +    "r3 -= r6;"
>> +    "r4 -= r6;"
>> +    "r5 -= r6;"
>> +    "if r0 != 0x1111 goto 1f;"
>> +    "if r1 != 0x2222 goto 2f;"
>> +    "if r2 != 0x3333 goto 3f;"
>> +    "if r3 != 0x4444 goto 4f;"
>> +    "if r4 != 0x5555 goto 5f;"
>> +    "if r5 != 0x6666 goto 6f;"
>> +    "r0 = 0;"
>> +    "exit;"
>> +    "1: r0 = 1; exit;"
>> +    "2: r0 = 2; exit;"
>> +    "3: r0 = 3; exit;"
>> +    "4: r0 = 4; exit;"
>> +    "5: r0 = 5; exit;"
>> +    "6: r0 = 6; exit;"
>> +    :
>> +    : __imm(bpf_get_prandom_u32),
>> +      __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0)),
>> +      __imm_insn(loop, BPF_RAW_INSN(BPF_JMP | BPF_JA, 0, 0, -2, 0))
>> +    : __clobber_all);
>> +}
>> +
>>   char _license[] SEC("license") = "GPL";
>>
> 
> not work, pls take a look

The __retval(0) annotation enables the test_run path in test_laoder.
do_prog_test_run() sets data_in/data_out/repeat by default,
which bpf_prog_test_run_raw_tp() rejects with EINVAL. Switching to
SEC("syscall") makes test_loader use empty opts. Will fix it in v5.

> 
> root@(none):/mnt/bpf# ./test_progs -v -a verifier_may_goto_1
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> [   26.123549] bpf_testmod: loading out-of-tree module taints kernel.
> [   26.127885] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
> Successfully loaded bpf_testmod.ko.
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> run_subtest:PASS:obj_open_mem 0 nsec
> run_subtest:PASS:unexpected_load_failure 0 nsec
> VERIFIER LOG:
> =============
> processed 43 insns (limit 1000000) max_states_per_insn 0 total_states 4 peak_states 5 mark_read 0
> =============
> do_prog_test_run:FAIL:1114 FAIL: Unexpected bpf_prog_test_run error: 22 (Invalid argument) #660/1   verifier_may_goto_1/timed may_goto preserves R0-R5:FAIL
> #660     verifier_may_goto_1:FAIL
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> Successfully unloaded bpf_testmod.ko.

-- 
With Best Regards,
Feng Jiang

