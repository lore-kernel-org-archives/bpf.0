Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46834EEF3;
	Tue, 18 Aug 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063249; cv=none; b=l448VP7LM/Su5jZpMO+hKHq1WwGNHnJDXVCL8eTBjmhoUAhbjPm8MhI2TskWPxZZlYCjJFTeJmT5Hm/6NT4bvCcisqwdpVH7U/mF9ZzsREPLhq/Z3b7JcjIPTn+i4n1irP5Aw4QAPlMOLUuCvyberHLCUU4DmDYlslvOntHI9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063249; c=relaxed/simple;
	bh=SwoENJaeuWAHMwlNuFhbUv9XBdGqu23w53JbDZJ4ZFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XEXF5ukC7oVru9uFtsdK/yDN19Utpo8Ae/KsyI+JzUpgIAaM4VRng7KVfTHZ176hQ2ZENWR/IYISXaiv+YYozyVdcg/DKgib1MpGZeBogER4pXBqtLuSGUW+nHIqpQq6htgD+bkkLPH+Vv0feh+sTLdC9r+2tGhxh9/gViGW108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UmP8/hoy; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UmP8/hoy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TE5f2r238esA0BsiheLiXH9IPeXW9yLOnr7PD+pk3ho=;
	b=UmP8/hoyE1CRBCtneXBPSfGLlkw3O/kYYSzQ1QExtbtskRGw5shdP0Pbz06BoL1hisuzKjU8L
	l8GDF7xgvf30jZXX1azzQB/Gj83KMCp20hNrb4V4b0eKdQybSOIaGyMmABwAxZKyWvtYErzEo/S
	UcFU8s0eoj6U/53sd6UAdGM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hPWwM5tKwz1K98V;
	Tue, 18 Aug 2026 22:16:35 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B698F4048B;
	Tue, 18 Aug 2026 22:27:16 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 22:27:15 +0800
Message-ID: <c5441b7e-3d20-4e4e-a225-7478f7fb9d6d@huawei.com>
Date: Tue, 18 Aug 2026 22:27:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf, riscv: Add support for signed arena
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
 <3445fb0231f9c72496ae840e9dca675b15899433.1786708960.git.cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <3445fb0231f9c72496ae840e9dca675b15899433.1786708960.git.cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/8/17 15:24, Chen Pei wrote:
> Signed loads from arena memory are currently rejected on riscv64, as
> bpf_jit_supports_insn() refuses BPF_MEMSX loads when in_arena is set,
> while x86 and arm64 gained support for them in v6.18. Compilers such
> as GCC-14 are free to generate signed loads into arena memory, which
> breaks loading of otherwise valid BPF programs on riscv64.
> 
> Implement BPF_PROBE_MEM32SX support in the RV64 JIT by reusing the
> existing arena handling: the arena base (RV_REG_ARENA) is added to
> the source register and the load is emitted with sign extension
> (lb/lh/lw). Add BPF_PROBE_MEM32SX to the add_exception_handler()
> mode gate so that faulting loads get an exception table entry which
> clears the destination register and resumes execution.
> 
> Verified by running the arena LDSX selftests (arena_ldsx_disasm,
> arena_ldsx_exception, arena_ldsx_s8/s16/s32) on riscv64 QEMU, all
> passing.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index f9d5347ba966..5786f7dfc8a7 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -777,6 +777,7 @@ static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
>   	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
>   	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
>   	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
> +	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
>   	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>   		return 0;
>   
> @@ -1902,13 +1903,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>   	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>   	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> +	/* LDX | PROBE_MEM32SX: dst = *(signed size *)(src + RV_REG_ARENA + off) */
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> +	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>   	{
>   		bool sign_ext;
>   
>   		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
> -			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
> +			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
> +			   BPF_MODE(insn->code) == BPF_PROBE_MEM32SX;
>   
> -		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
> +		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
> +		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
>   			emit_add(RV_REG_T2, rs, RV_REG_ARENA, ctx);
>   			rs = RV_REG_T2;
>   		}
> @@ -2126,10 +2133,6 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   			if (insn->imm == BPF_CMPXCHG)
>   				return rv_ext_enabled(ZACAS);
>   			break;
> -		case BPF_LDX | BPF_MEMSX | BPF_B:
> -		case BPF_LDX | BPF_MEMSX | BPF_H:
> -		case BPF_LDX | BPF_MEMSX | BPF_W:
> -			return false;
>   		}
>   	}
>   

Reviewed-by: Pu Lehui <pulehui@huawei.com>
