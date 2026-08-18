Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876418FC97;
	Tue, 18 Aug 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063317; cv=none; b=E5J69QHFPsl45kL6YVL9ORqeEVhMBIXg+1s4nclFHMOlMvwYtUxAvUxKo3GLNRAfzK/EhglDOIM3ldZK84JW3/fNz6ivPM9uSVJpUpU0QP6B7Gpx/miYKdrNn69zkx3BdnvNd52/XIuWj5qRxtFt8FI8AeySh0aD19zMUpN8TEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063317; c=relaxed/simple;
	bh=/TRTQkghKztzKC1gHtMiQ+BjWSk6QgZbFjcI1QNQEag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=txC3NalfR2NvHcxjtslyBA529QHVZyK7MCre6rl4kcGrjm0bRvvzF714XNRA0G8TnejEMXOIsv6YYdKCgTnPG6Giqp42FaFAM1wZthcV0iZz4f1gAUpDZ9CUmnxIkYGsR2NN2PdYs6wWhOBRdiSg1ZEH1WtROxHGMr1FejR4slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wFjDXVbO; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wFjDXVbO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LHVwJeKPm4w9Zw9/EdTT/rFSQ5i6PDJ9Dh901qmDDV0=;
	b=wFjDXVbO0me2gAfNKia8ZXMX6YM3l7O24ii3Ka91Q/Yrd64Jc8Cr5dS2V6AMCJw84KJYrnacW
	MyBownegXQ2fwNdCjHuq/BDXizJEZcpLO04jTXI9ZoU0tOYlfwpY+qDvTlb7yHLlwVQR6KivARM
	vyU3DlUf/gf6KAX54a5np5M=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hPWyB4lbLznTVd;
	Tue, 18 Aug 2026 22:18:10 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 92AA94048B;
	Tue, 18 Aug 2026 22:28:29 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 22:28:28 +0800
Message-ID: <40134c09-58cf-42c4-b79e-1a461c013a50@huawei.com>
Date: Tue, 18 Aug 2026 22:28:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: Add support for signed arena
 loads
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <shuah@kernel.org>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1786708960.git.cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <cover.1786708960.git.cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/17 15:24, Chen Pei wrote:
> Hi,
> 
> Signed loads from arena memory are currently unsupported on riscv64:
> bpf_jit_supports_insn() rejects BPF_MEMSX loads when in_arena is set,
> so the verifier fails such programs with "sign extending loads from
> arena are not supported yet". The x86 and arm64 JITs gained support
> for them in v6.18 (a91ae3c89311, eab2a71f3a6a). Since compilers are
> free to generate signed loads into arena memory (e.g. GCC-14 was
> reported to do so), otherwise valid BPF programs fail to load on
> riscv64.
> 
> This series adds BPF_PROBE_MEM32SX support to the RV64 JIT and
> enables the corresponding selftests on riscv64:
> 
> 1 implements signed arena loads in the RV64 JIT. The verifier
>    already converts MEMSX loads from PTR_TO_ARENA to
>    BPF_PROBE_MEM32SX once bpf_jit_supports_insn() allows them, so
>    the JIT reuses the existing arena handling: the arena base
>    (RV_REG_ARENA) is added to the source register and the load is
>    emitted with sign extension (lb/lh/lw). BPF_PROBE_MEM32SX is also
>    added to the add_exception_handler() mode gate so faulting loads
>    register an exception table entry that clears the destination
>    register and resumes execution.
> 
> 2 enables the arena LDSX tests on riscv64: JIT disassembly
>    assertions are added to arena_ldsx_disasm, and
>    arena_ldsx_exception/s8/s16/s32 are now run on riscv64.
> 
> The series was verified on riscv64 with QEMU (-M virt -cpu max): all
> five arena_ldsx tests pass, including the exception path (load from
> unallocated arena memory returns 0) and the sign-extension values
> (s8/s16/s32 tests return -1 as expected).
> 
> Note: the __jited assertions in patch 2 were derived from the JIT
> register allocation (R0->a5, R1->a0, R8->s3, R9->s4, arena base in
> s7) and the emit_ldx() code paths; happy to adjust them if a
> disassembler output detail differs.

Test meets happy.

For this series:

Tested-by: Pu Lehui <pulehui@huawei.com>

> 
> Thanks,
> Pei
> 
> Chen Pei (2):
>    bpf, riscv: Add support for signed arena loads
>    selftests/bpf: Enable arena LDSX tests for riscv64
> 
>   arch/riscv/net/bpf_jit_comp64.c                 | 15 +++++++++------
>   .../testing/selftests/bpf/progs/verifier_ldsx.c | 17 +++++++++++++++++
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
