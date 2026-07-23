Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52594398F8;
	Thu, 23 Jul 2026 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801443; cv=none; b=BtQvMXRoGHef8IRszSdlsofx7RT+TK7DlhmHvI3K26e9AkT7cfj6gJJlkuls14nCk4Z2NJDBY9ftQMJDJJcGqSR/NmeTiIz6R3opt0TWmL5ws3U1KUZVrVxu6QYEN+lSXBeemIeQJOuhpgCZFoX1dAtoXvNVQtHv2ZvSbp+X6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801443; c=relaxed/simple;
	bh=T3D5yAVvzgqnHM7KZn6kTPxiO9MJdOnAuwIe6XNf7E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V9t3myNuigI1K7reE8rsC8BdslzWtQ62SZrTSzO5+yrCaO+zmqh1u5dg4KoDlUTIq4D2hO2sniOIZn5GG/DQvC9h7VCcV+9djddtxfocwrO2jE7wOB85KFZQFktUpEZK065HmnU8Maf+1LMSR5wSUZr03UmZThNRvWvHOYSFE9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Jiqa3cfr; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Jiqa3cfr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5re4nPlbLEVWPOreOr0zy5dD8ExMrcczNzif8ZTa/es=;
	b=Jiqa3cfrWTvKoXT7hLpR3pWIORx0bu4RUsN+sOJn/TzQn1dtsBCuG5ql7QJXv7/6brGtITNkU
	u8WtkCy3UXrIlyabDei8mPfl0ma11M1DdPaD3b2bVubSvPMaIs3QyexzZI5cDlBpR2aoGsHb+ZO
	/Iflx3PfpYI5LwEggUalpOA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5RTg0bbXzKmB5;
	Thu, 23 Jul 2026 18:01:11 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id D93CD402AB;
	Thu, 23 Jul 2026 18:10:36 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 18:10:35 +0800
Message-ID: <f8768480-9cbb-4807-bd9c-e2eeea6cdbe0@huawei.com>
Date: Thu, 23 Jul 2026 18:10:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: test timed may_goto
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
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
 <20260723-riscv-bpf-timed-may-goto-v5-2-86acb54e5642@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-2-86acb54e5642@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/23 13:41, Feng Jiang wrote:
> Add a test that checks R0-R5 are preserved across
> arch_bpf_timed_may_goto() calls.
> 
> Use bpf_get_prandom_u32() to avoid the verifier removing the checks
> via DCE.
> 
> Suggested-by: Björn Töpel <bjorn@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>   .../selftests/bpf/progs/verifier_may_goto_1.c      | 58 ++++++++++++++++++++++
>   1 file changed, 58 insertions(+)

Reviewed-by: Pu Lehui <pulehui@huawei.com>

> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> index 4bdf4256a41e..cb1ce4d13cfc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> @@ -106,4 +106,62 @@ __naked void may_goto_batch_2(void)
>   	: __clobber_all);
>   }
>   
> +/*
> + * Use bpf_get_prandom_u32() to prevent DCE from removing the checks.
> + * retval: 0=all ok, 1-6=R0-R5 clobbered.
> + */
> +SEC("syscall")
> +__description("timed may_goto preserves R0-R5")
> +__arch_x86_64
> +__arch_s390x
> +__arch_arm64
> +__arch_riscv64
> +__success
> +__retval(0)
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
