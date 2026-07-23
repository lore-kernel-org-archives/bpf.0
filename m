Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B436EA88;
	Thu, 23 Jul 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801819; cv=none; b=ghxfFZMsFC/YDTzj2zj+zayDweZ/3yB/S4aYnj7zma5oFHIiPVigcRGtkHm1cuqdhqHpFKuLLRHwoPANhCz52nl5ctJJrJ837qG5b/IWiEP5PrxjajnWlCJ4fSMQMydiFjOrVgVTycbj09WDNTckI7e3yeW41poCKH8L8g9jDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801819; c=relaxed/simple;
	bh=PK6P+wFHXI6nz4eun4nujdXTpCe4tNVG5S92nDWOQoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JzfshgXMQhO6/k0tGG+GYjySwemuBFve1f9vUnqbItzUyTkOpuRsTOQJbhgTkgeZXa6lnxpxdCFUboUTNLFMHo6MqZE1/ZfaRW/JjKXjkuDYFsJ5o8yGOxetR4J/1dBEfbQyosfiSwrdpHcwF2igkGjN2sXk34I67JWBm+TAclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EZBGNbQ3; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EZBGNbQ3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dUFTOvgZ/NRiie8IA2L45PJfQB6b+Osy4helS/3oESs=;
	b=EZBGNbQ3nFpV8CvS+pgqGoiyuepQ3JsA2FK9chOK3W+yWhYCqozMwNRB+EZqNuqIaXyA7l8s1
	FYs2phNai77DJr3QVA/lZ7Z7NnRXULvZ5+zIR4zoRrnkzFl9xo293UhrNqB9Yu6wPlVsBvxEyxm
	4BqkDnPz5etgaTjLXZn+NY8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h5Rcz1W3cz1T4Lb;
	Thu, 23 Jul 2026 18:07:31 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C76940561;
	Thu, 23 Jul 2026 18:16:53 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 18:16:52 +0800
Message-ID: <aa2c4ede-234d-4cb7-8ff1-163f1495bafc@huawei.com>
Date: Thu, 23 Jul 2026 18:16:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 0/3] bpf, riscv: add timed may_goto support
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
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/23 13:41, Feng Jiang wrote:
> This series adds RISC-V JIT support for the timed may_goto loop bound.
> 
> Patch 1 implements arch_bpf_timed_may_goto() and enables
> bpf_jit_supports_timed_may_goto() so the verifier uses the timed
> expansion path.
> 
> Patch 2 adds a test that checks R0-R5 are preserved across
> arch_bpf_timed_may_goto() calls.
> 
> Patch 3 enables the verifier_may_goto_1, stream_cond_break, and
> may_goto_interaction fastcall tests on riscv64.
> 
> Tested on riscv64 QEMU (rva23s64): may_goto programs load and JIT
> correctly, and the 250ms timeout path works as expected.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

For this series:

Tested-by: Pu Lehui <pulehui@huawei.com>

> ---
> Changes in v5:
> - Use REG_S/REG_L/SZREG in arch_bpf_timed_may_goto assembly. (Pu Lehui)
> - Add __arch_s390x to the timed_may_goto_preserves_regs test. (Pu Lehui)
> - Switch the preserves-regs test to SEC("syscall") to fix
>    bpf_prog_test_run() EINVAL.
> - Link to v4: https://lore.kernel.org/r/20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn
> 
> Changes in v4:
> - Add 'bpf-next' prefix to match the BPF kernel tree workflow.
> - Add a test checking that R0-R5 are preserved across
>    arch_bpf_timed_may_goto() calls. Use bpf_get_prandom_u32() to
>    prevent the verifier from removing the checks via DCE.
> - Rename may_goto_interaction_arm64() to may_goto_interaction().
> - Wrap the arch_bpf_timed_may_goto address check to a single line.
> - Link to v3: https://lore.kernel.org/r/20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn
> 
> Changes in v3:
> - Set up the frame pointer in arch_bpf_timed_may_goto() so the function
>    does not break stack unwinding under CONFIG_FRAME_POINTER.
> 
> Changes in v2:
> - Fix BPF_REG_0 being clobbered after arch_bpf_timed_may_goto() calls.
> - Enable the may_goto_interaction fastcall test on riscv64.
> 
> ---
> Feng Jiang (3):
>        bpf, riscv: add support for timed may_goto
>        selftests/bpf: test timed may_goto preserves R0-R5
>        selftests/bpf: enable timed may_goto tests for riscv64
> 
>   arch/riscv/net/Makefile                            |  2 +-
>   arch/riscv/net/bpf_jit_comp64.c                    | 12 ++++-
>   arch/riscv/net/bpf_timed_may_goto.S                | 47 ++++++++++++++++
>   tools/testing/selftests/bpf/progs/stream.c         |  1 +
>   .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  3 +-
>   .../selftests/bpf/progs/verifier_may_goto_1.c      | 62 ++++++++++++++++++++++
>   6 files changed, 124 insertions(+), 3 deletions(-)
> ---
> base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
> change-id: 20260710-riscv-bpf-timed-may-goto-0dce564985af
> 
> Best regards,
