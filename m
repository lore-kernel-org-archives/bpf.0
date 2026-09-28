Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B66472071;
	Mon, 28 Sep 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586627; cv=none; b=s90mkifRRt66XC2qt4ffBC7J6ZzkZAc7c7XudRAlbwkF3FqjQ0H24LrnkgxBcybCTt6uhtUA8060bMZv/GBEFL5S16YgSaSgDE7vk1s0Au+6A04On8FvuGVsxVPtYRiBrXn55vxChGxt2d2ZznS90zsHvpk3Hywh5VcLcrN7LNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586627; c=relaxed/simple;
	bh=UX/OohjLyJ9UKKT95JHenmTQlrebVjgNyszx7N0fyVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A8ajA36Lg7ZYh5B17Orklv6yD7CrRCMSCo7IP7/fIjHzEfzusfmc0725gM172WrcrC/JVmFlX3wgU5dc3A79xSg1gDwsiuGwXkfhp4zNDHedqArR355ERltpgAWY75GClRpDQ9Y25/cywvy+7YA0BlxSqe9TuxuvQewr01Fib5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZuXG8PTE; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZuXG8PTE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=24y8bIOENNovRtkZnZvVTWIkfqTuhb4BMfZsFA0A+t4=;
	b=ZuXG8PTEe3FyUjLVilfNkQUXjdeZv6oVdx6+NwjW3kX1Il7xpxzMbqaRfRhqKO8NW9KAWjXiy
	Og42430uBtqeJ9DTrLFc9GQBMtd5rcouCa/QqhNTZ6TzxwLVVIdm5Et54MmAXd6P7HxFQCIQjos
	n+9CREyJwDNbcVI3bBjC+p8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4htZwk0rW6zcb46;
	Mon, 28 Sep 2026 16:58:46 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A94440561;
	Mon, 28 Sep 2026 17:10:19 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 17:10:18 +0800
Message-ID: <6081a548-aaed-423a-bb34-0008cedc6699@huawei.com>
Date: Mon, 28 Sep 2026 17:10:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] bpf, riscv: Add support for indirect
 jumps
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <ihor.solodrai@linux.dev>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<shuah@kernel.org>, <guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260928071845.2432-1-cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260928071845.2432-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/9/28 15:18, Chen Pei wrote:
> The indirect jump instruction (BPF_JMP | BPF_JA | BPF_X, "gotox") and the
> BPF_MAP_TYPE_INSN_ARRAY jump tables it consumes are core features: the
> verifier accepts them on every architecture, and the x86-64, arm64 and
> powerpc JITs implement them. On riscv64 a program using gotox passes
> verification and then fails to load, because the JIT does not know the
> opcode and CONFIG_BPF_JIT_ALWAYS_ON leaves no interpreter to fall back
> onto.
> 
> This series adds the riscv64 support and turns the existing selftests on
> for that architecture.
> 
> Patch 1 emits "jalr zero, rd, 0" for gotox and publishes the xlated to
> jitted offsets through bpf_prog_update_insn_ptrs(), which is what fills
> in the jump table addresses. Patches 2 to 4 widen the arch guards in
> verifier_gotox.c, compute_live_registers.c and bpf_insn_array.c to
> riscv64, the same way the other architectures were enabled.
> 
> Changes since v2:
> - Pick up Pu Lehui's Reviewed-by on patch 1.
> - Enable two more gotox test files for riscv64: compute_live_registers.c
>    and bpf_insn_array.c.
> 
> Changes since v1:
> - Rebased onto bpf-next.
> - Patch 1: reword the code comment to say "shift ctx->offset[] by one".
> - Patch 2: collapse the multi-line #endif marker to a single line.
> - Added Reviewed-by/Acked-by from Björn Töpel.
> 
> Testing
> =======
> 
> Environment: QEMU virt rv64, with CONFIG_BPF_JIT=y,
> CONFIG_BPF_JIT_ALWAYS_ON=y, CONFIG_DEBUG_INFO_BTF=y; selftests
> cross-built with clang 23.
> 
> - test_progs -t verifier_gotox: 33/33 subtests pass.
> - test_progs -t bpf_insn_array: 20/20 subtests pass.
> - test_progs -t compute_live_registers: 20/20 subtests pass, including
>    the gotox liveness subtest.
> - test_progs-cpuv4 -t bpf_gotox: 14/14 subtests pass.
> 
> Chen Pei (4):
>    bpf, riscv: Add support for indirect jumps
>    selftests/bpf: Enable gotox tests for riscv64
>    selftests/bpf: Enable gotox liveness test for riscv64
>    selftests/bpf: Enable instruction array test for riscv64
> 
>   arch/riscv/net/bpf_jit_comp64.c                  |  5 +++++
>   arch/riscv/net/bpf_jit_core.c                    | 16 ++++++++++++++--
>   .../selftests/bpf/prog_tests/bpf_insn_array.c    |  3 ++-
>   .../selftests/bpf/progs/compute_live_registers.c |  5 +++--
>   .../testing/selftests/bpf/progs/verifier_gotox.c |  6 ++++--
>   5 files changed, 28 insertions(+), 7 deletions(-)
> 

For this series:

Tested-by: Pu Lehui <pulehui@huawei.com>
