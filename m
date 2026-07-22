Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749E3368B2;
	Wed, 22 Jul 2026 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718621; cv=none; b=mCk2AYAS+NI/K/16zGZf0GzHJy6jYQZVB0FF98ykgMcmekGRbUc0v+6yDl9lDkc35kU5wPxl7nFdbEIQLz1EFrYGyfVXuDo6YODATtDS+TRbuU4bGTsDf3piE0/6PKqzXcaSubFC2feV4EtFHfwme0yQ0pbjraazqxEpw27XRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718621; c=relaxed/simple;
	bh=7N6nnMDqkdc6sm57vGpnjZWenxm+dIJWAu5Jqy8SnGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kNxGzbVmzQmy38ouqRpjYUhe8Fp1tL5A4IFOhT4pTesonTEE3Q2cOj5B1FbNtiocp14x8Shipt/2PqgxU0I1mMKlsL9H5hQW4CV5UvTUDQA7+pCpa376pHXt0jkkgb8HqOqcB3GXWzpn09FOZGEXAniguLHhi3WGXNmIRVLEZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Dz0RTasx; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Dz0RTasx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7fZ6ZKpSewI1alqxdp5Iq+hQOnwQ2qVqzUF460FpOro=;
	b=Dz0RTasxHANwEJIVjEc/iLkxLjwM+ACQkwB0IqIcXkLjoYTJmzjxGHoP9CljCG3ftBsWS5v23
	43GaTWvwdec6jtmIVPjaKVlJXi8W/m0D12ZyE7UXmPxVP3ZcWCZSmAaVrN/MK4CYw6NqFaH/QSD
	G+IHfuGHC6bi2sfpqXvNELw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h4rrq4dX4zcb4c;
	Wed, 22 Jul 2026 19:00:43 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 863AD40561;
	Wed, 22 Jul 2026 19:10:12 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Jul
 2026 19:10:11 +0800
Message-ID: <2cd8255d-2b0a-45d8-bbc2-ac19e196c41a@huawei.com>
Date: Wed, 22 Jul 2026 19:10:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: test timed may_goto
 preserves R0-R5
Content-Language: en-US
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Ihor Solodrai
	<ihor.solodrai@linux.dev>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn>
 <20260722-riscv-bpf-timed-may-goto-v4-2-e117e6337bc7@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722-riscv-bpf-timed-may-goto-v4-2-e117e6337bc7@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/7/22 12:21, Feng Jiang wrote:
> Add a test that checks R0-R5 are preserved across
> arch_bpf_timed_may_goto() calls.
> 
> Use bpf_get_prandom_u32() to avoid the verifier removing the checks
> via DCE.
> 
> Suggested-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>   .../selftests/bpf/progs/verifier_may_goto_1.c      | 57 ++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> index 4bdf4256a41e..98d59108d097 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> @@ -106,4 +106,61 @@ __naked void may_goto_batch_2(void)
>   	: __clobber_all);
>   }
>   
> +/*
> + * Use bpf_get_prandom_u32() to prevent DCE from removing the checks.
> + * retval: 0=all ok, 1-6=R0-R5 clobbered.
> + */
> +SEC("raw_tp")
> +__description("timed may_goto preserves R0-R5")
> +__arch_x86_64
> +__arch_arm64
> +__arch_riscv64
> +__success
> +__retval(0)

__arch_s390x is also supported timed_may_goto

> +__naked void timed_may_goto_preserves_regs(void)
> +{
> +	asm volatile (
> +	"call %[bpf_get_prandom_u32];"
> +	"r6 = r0;"
> +	"r0 = 0x1111;"
> +	"r0 += r6;"
> +	"r1 = 0x2222;"
> +	"r1 += r6;"
> +	"r2 = 0x3333;"
> +	"r2 += r6;"
> +	"r3 = 0x4444;"
> +	"r3 += r6;"
> +	"r4 = 0x5555;"
> +	"r4 += r6;"
> +	"r5 = 0x6666;"
> +	"r5 += r6;"
> +	".8byte %[may_goto];"
> +	".8byte %[loop];"
> +	"r0 -= r6;"
> +	"r1 -= r6;"
> +	"r2 -= r6;"
> +	"r3 -= r6;"
> +	"r4 -= r6;"
> +	"r5 -= r6;"
> +	"if r0 != 0x1111 goto 1f;"
> +	"if r1 != 0x2222 goto 2f;"
> +	"if r2 != 0x3333 goto 3f;"
> +	"if r3 != 0x4444 goto 4f;"
> +	"if r4 != 0x5555 goto 5f;"
> +	"if r5 != 0x6666 goto 6f;"
> +	"r0 = 0;"
> +	"exit;"
> +	"1: r0 = 1; exit;"
> +	"2: r0 = 2; exit;"
> +	"3: r0 = 3; exit;"
> +	"4: r0 = 4; exit;"
> +	"5: r0 = 5; exit;"
> +	"6: r0 = 6; exit;"
> +	:
> +	: __imm(bpf_get_prandom_u32),
> +	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0)),
> +	  __imm_insn(loop, BPF_RAW_INSN(BPF_JMP | BPF_JA, 0, 0, -2, 0))
> +	: __clobber_all);
> +}
> +
>   char _license[] SEC("license") = "GPL";
> 

not work, pls take a look

root@(none):/mnt/bpf# ./test_progs -v -a verifier_may_goto_1
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
[   26.123549] bpf_testmod: loading out-of-tree module taints kernel.
[   26.127885] bpf_testmod: module verification failed: signature and/or 
required key missing - tainting kernel
Successfully loaded bpf_testmod.ko.
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
run_subtest:PASS:obj_open_mem 0 nsec
run_subtest:PASS:unexpected_load_failure 0 nsec
VERIFIER LOG:
=============
processed 43 insns (limit 1000000) max_states_per_insn 0 total_states 4 
peak_states 5 mark_read 0
=============
do_prog_test_run:FAIL:1114 FAIL: Unexpected bpf_prog_test_run error: 22 
(Invalid argument) #660/1   verifier_may_goto_1/timed may_goto preserves 
R0-R5:FAIL
#660     verifier_may_goto_1:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
Successfully unloaded bpf_testmod.ko.
