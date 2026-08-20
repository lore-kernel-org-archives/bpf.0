Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2421FF2E;
	Thu, 20 Aug 2026 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199137; cv=none; b=VhxOcWuv/PF4LAf0DrV7HPh5XmFyVOQ8PEpwv/X0OXjjkC2gqAHxJWboIG9akv8oi7Tltn3Q7USJcnTird/qFGyIxidAThtP30e2LrDy4FWD1TWqQMYBbIGE6xuXgJ3dBtAQJF1LWCjIGcgX+DAGSW+wzC2jiXZKtLoji+VJnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199137; c=relaxed/simple;
	bh=OnHZRzAUoMf2U193yh1+vQJTf7Nt/3M3TmPa5h79Yj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brwZ8+IBZt6dI/T3nmbVpbppLjzp1Il7qKEkLeZy2xDXTb0bf1ORysb5VwmI76SQJqFixIEK0h1h9rPGYkV/XvRChvEoidCz6QhKUlA/vf5elFzCl+JEy0pthVGbunOKoPEcFKCcCU92gzArKU3guo3xiTArEWcGM/uSX1OCytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GLeMssTF; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GLeMssTF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Wj6aI8sCMr/ayoDuGnce4gweZGzZgQpUacHTKZeft6I=;
	b=GLeMssTF0KR+dj5hVHlK7JyNVD0lCo9uLLklNHiWrjzEHdA8DFPfHATa3XC/O+JQt5XYH0LMc
	eAPBtzBq2N0RpO5IONVCy69Qq1dEJD96inAMFaWuwLW0z33aMg/FMassW8EKNGZaNAsvi5MDgin
	0vOMid57voUOhpqNYejdYx8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hQV9z5k9jznTVd;
	Thu, 20 Aug 2026 12:01:43 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id CAE7A40565;
	Thu, 20 Aug 2026 12:12:01 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Aug
 2026 12:12:00 +0800
Message-ID: <f8721d92-c07a-46ca-a1f3-6720aec01628@huawei.com>
Date: Thu, 20 Aug 2026 12:12:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf, riscv: Add support for signed arena
 loads
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <ihor.solodrai@linux.dev>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<shuah@kernel.org>, <guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1787140923.git.cp0613@linux.alibaba.com>
 <67422a421852c3eed2269c6def7b5569e727617f.1787140923.git.cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <67422a421852c3eed2269c6def7b5569e727617f.1787140923.git.cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/8/19 20:09, Chen Pei wrote:
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
> clears the destination register and resumes execution. Since
> BPF_PROBE_MEM32SX shares its mode value (0xc0) with BPF_ATOMIC, the
> gate accepts it only for LDX class instructions so that plain atomic
> instructions do not register exception table entries.
> 
> Verified by running the arena LDSX selftests (arena_ldsx_disasm,
> arena_ldsx_exception, arena_ldsx_s8/s16/s32) and the full
> arena_atomics test suite on riscv64 QEMU, all passing.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
> 
> Changes in v3:
> - Restore the pseudo-code form of the PROBE_MEM32SX case comment.
> 
> Changes in v2:
> - Fix extable entry overflow breaking arena_atomics load
> 
>   arch/riscv/net/bpf_jit_comp64.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index f9d5347ba966..64ebd262c498 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -777,6 +777,8 @@ static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
>   	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
>   	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
>   	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
> +	    !(BPF_MODE(insn->code) == BPF_PROBE_MEM32SX &&
> +	      BPF_CLASS(insn->code) == BPF_LDX) &&
>   	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>   		return 0;
>   
> @@ -1902,13 +1904,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
> @@ -2126,10 +2134,6 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
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
Tested-by: Pu Lehui <pulehui@huawei.com>

