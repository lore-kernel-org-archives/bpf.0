Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322617A30A;
	Sat,  7 Feb 2026 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426828; cv=none; b=ncPX9jG6HfBVQJzVSxvs+kxkVChZ8l8yZjKBJ65cu+gJN36lhfMfNDdvXqpAeOiyUzpWNYAitnZzR+90UCMVDAgTyAORx2AsjF2q3ccIfy4SSt+6Tx8DM2biD2tWWN6t2CkYFnFslhKKVBykvxXChJCX4U/7aOWBebZkGdPu08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426828; c=relaxed/simple;
	bh=uI8gaHqws4vTRX85Y6stiMB5kTwBMDmFuUCCTtXQeP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i4UIJ1F/uzfQUQwwjtUzBRiCeljElmmKKg+Ru/7B4g5pldLUTA/WsVT3YP1g0GQfw8L11CN4x7RwgGavkVfqlFyDjHEULaBp6bs0XP6kEbWfnyNNdmxzIaR6d13bDl55UvBs1FmlET48ugZi/niPGXSVaahvDKSxI79zhAKGf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wkPllVei; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wkPllVei"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=M0guQhZb/eTKYdMXoaEHNBdeGiZfYccqrpOeX2Q8uSM=;
	b=wkPllVei3+nAXiwy04ZbDsl5KMEqe4pRuJ92kvYOwQ5HJWipDyt9K8iI9CTEeKcuxUQ1lg6yk
	EdsbSxq1o5Qs4ltho1mUZMuu6/UlNFrDO36F10TLcDDjRwt8BiVZeFSVrhKAAN2YiaOUn2QvseK
	0wVdeRsuYjfyJzArhtibiEY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f7CXZ195Vz1T4FY;
	Sat,  7 Feb 2026 09:09:18 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 46A494036C;
	Sat,  7 Feb 2026 09:13:44 +0800 (CST)
Received: from [10.67.110.198] (10.67.110.198) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 7 Feb 2026 09:13:43 +0800
Message-ID: <d6281121-b39b-41ac-a166-69dbfa1f4f79@huawei.com>
Date: Sat, 7 Feb 2026 09:13:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpf, riscv: introduce
 emit_store_stack_imm64() for trampoline
Content-Language: en-US
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <bjorn@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<jolsa@kernel.org>, <puranjay@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jiang.biao@linux.dev>
References: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
 <20260206122002.1494125-2-dongml2@chinatelecom.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260206122002.1494125-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/2/6 20:20, Menglong Dong wrote:
> Introduce a helper to store 64-bit immediate on the trampoline stack with
> a help of a register.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Tested-by: Björn Töpel <bjorn@kernel.org>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 37888abee70c..e4f45e2e7e2f 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -926,6 +926,14 @@ static void restore_stack_args(int nr_stack_args, int args_off, int stk_arg_off,
>   	}
>   }
>   
> +static void emit_store_stack_imm64(u8 reg, int stack_off, u64 imm64,
> +				   struct rv_jit_context *ctx)

Some nit. The first parameter can be removed by using a fixed RV_REG_T1. 
Also, placing imm64 before stack_off might looks better.

> +{
> +	/* Load imm64 into reg and store it at [FP + stack_off]. */
> +	emit_imm(reg, (s64)imm64, ctx);
> +	emit_sd(RV_REG_FP, stack_off, reg, ctx);
> +}
> +
>   static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
>   			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
>   {
> @@ -933,12 +941,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
>   	struct bpf_prog *p = l->link.prog;
>   	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>   
> -	if (l->cookie) {
> -		emit_imm(RV_REG_T1, l->cookie, ctx);
> -		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
> -	} else {
> +	if (l->cookie)
> +		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
> +	else
>   		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
> -	}
>   
>   	/* arg1: prog */
>   	emit_imm(RV_REG_A0, (const s64)p, ctx);
> @@ -1123,13 +1129,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
>   
>   	/* store ip address of the traced function */
> -	if (flags & BPF_TRAMP_F_IP_ARG) {
> -		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
> -		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
> -	}
> +	if (flags & BPF_TRAMP_F_IP_ARG)
> +		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx); >
> -	emit_li(RV_REG_T1, nr_arg_slots, ctx);
> -	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
> +	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
>   
>   	store_args(nr_arg_slots, args_off, ctx);
>   
