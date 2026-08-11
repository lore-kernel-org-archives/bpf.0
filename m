Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1B305666
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415469; cv=none; b=CQwln4H7552MYq66dfuCBOzdnwMKUl0zSMqp3SIjoklz1XmhFsN0X1/UhL/VurkcPLYn0WNcZDOZQNDNNMYyKVdazVmPrB4hdRLxdn8wxv/Lgt6hodRyj5VOAeHDeMY84juLs1qEgVllsNViUXh1gkcjBLImqq8l4VvqLZlIlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415469; c=relaxed/simple;
	bh=FZCAYCmze1OuLP0XPVhYZHWf9sJaZIwAjrMIByxPnck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wo55lOSSWUy3HHtWUA5ycVXfmfYZpo03RCMKpYKvpPcOByy8TGlQsUpuYOs62TckZKNQFq0hQCgBOxKD1QHnCSD3lgfvqOdUCJrKubjqVfhHA98w0diAmqtr4XQ5m9SYADn+NiVWqjfOhpB9A1m81UEt3Af0gOlfaO64Pcu+zSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4mJYvuBS; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4mJYvuBS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ggwZl9hb9gd5EioWN0Esbq0cjjGosqmQzh+r+HMhRd8=;
	b=4mJYvuBSYXRQD0OA6GgU609PMvRq+U2I2PSwL/mr2SN2lCdaLpE4qILIhAb+XsleNZQAnw2rI
	Ll9ICcba/b83oQszey/LQ6zngid7g8EN/KvmG+plP+dQRs4kVR+nxWjcWwZFaM8+Ng2TZp3AP2b
	/bQ6Dx6kYo1Ek1xwOULts1k=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hJwMM4JM9z12LGB;
	Tue, 11 Aug 2026 10:20:31 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 70DFD4058F;
	Tue, 11 Aug 2026 10:30:57 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Aug
 2026 10:30:56 +0800
Message-ID: <fcc0a5a3-7ad4-453d-bcd7-ca97f2dcacfa@huawei.com>
Date: Tue, 11 Aug 2026 10:30:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/6] bpf, riscv: Clear fetch destination on
 faulting arena atomic
To: Daniel Borkmann <daniel@iogearbox.net>, <memxor@gmail.com>
CC: <eddyz87@gmail.com>, <puranjay@kernel.org>, <bpf@vger.kernel.org>
References: <20260810221811.481040-1-daniel@iogearbox.net>
 <20260810221811.481040-2-daniel@iogearbox.net>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260810221811.481040-2-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Daniel,

On 2026/8/11 6:18, Daniel Borkmann wrote:
> A RMW atomic on an arena pointer is converted to BPF_PROBE_ATOMIC and
> gets an exception table entry, but that entry records no destination
> register to clear unless the instruction is a load-acquire today. That
> is right for a plain BPF_{ADD,AND,OR,XOR}, which only writes memory,
> but an RMW carrying BPF_FETCH also reads the old value into a register:
> src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and r0 for
> BPF_CMPXCHG. emit_atomic_rmw() emits it that way, e.g.:
> 
>    [...]
>    case BPF_XCHG:
>            ctx->ex_insn_off = ctx->ninsns;
>            emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
>                 rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
>    [...]
> 
> Thus, a fault over an unmapped arena page ex_handler_bpf() jumps over
> the access but leaves rs untouched, and the program resumes with
> whatever it held before the atomic instead of the 0 that every other
> BPF_PROBE_* access delivers. Fill the exception table entry in from
> bpf_atomic_load_reg(), which returns the BPF register an atomic reads
> the memory operand into or -1 when it has none. A load-acquire ends up
> with the same register it gets today, it just goes through the helper.
> Unlike x86-64 and arm64, riscv64 does not report arena violations from
> its exception handler, so there is no access direction to correct here,
> only the missing register clear.
> 
> Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 6b9972b07c1b..2504df1fa111 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1992,10 +1992,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			ret = emit_atomic_rmw(rd, rs, insn, ctx);
>   
>   		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> -		if (ret >= 0)
> -			ret = add_exception_handler(insn,
> -				bpf_atomic_is_load_acq(insn) ? rd : REG_DONT_CLEAR_MARKER,
> -				ctx) ?: ret;
> +		if (ret >= 0) {
> +			/*
> +			 * A load-acquire reads into dst_reg, and a read-modify-write
> +			 * carrying BPF_FETCH reads the old value into src_reg, or into
> +			 * r0 for a BPF_CMPXCHG. Clear that register on fault, the
> +			 * remaining atomics have no destination register.
> +			 */
> +			int load_reg = bpf_atomic_load_reg(insn);
> +
> +			ret = add_exception_handler(insn, load_reg < 0 ?
> +					REG_DONT_CLEAR_MARKER : regmap[load_reg],

Felt a bit odd using regmap directly here at first, but since 
insn->dst_reg and insn->src_reg are already marked via bpf_to_rv_reg at 
the start, it looks fine.

Reviewed-by: Pu Lehui <pulehui@huawei.com>

Thanks.

> +					ctx) ?: ret;
> +		}
>   
>   		if (ret)
>   			return ret;
