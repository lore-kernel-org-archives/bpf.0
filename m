Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54385383CA;
	Wed, 23 Sep 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174554; cv=none; b=iBNcOW05tvjsDzF2kkJV34qBWIK6rw755tGqHphzOaEiWcgBP2BvhGlTAoxauEDcIvjgB8hvS6d3ZYDzDGlCGeJHs1XsjgwXqS91jn4UryOFc+D9YnC970iJKSVrMMgRVwczw9kdan2HLKlsBoNzf4l5TidkEDY2vHT6KMaxft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174554; c=relaxed/simple;
	bh=pb1Y2vRzilAyJ10jFU3uRta9rlV3u7GCInaNLpAAePc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WANWNkgay6QJenb2Ywt2tV0D2VmU+pcKoYKni8KrLySnL0fv1KE52cgD0S/kebuZancKFjg+N1zyNkh/dU2ljhlAmRsx/LEyWXH8wvclG9BCgAH8sJNE43rJzaOQJCqqKXSgbI/c+zuyKwX3eh5wb2ti6fRHS4K6W2Q+iaxZRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yTPORjqb; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yTPORjqb"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=X2Z8+iw+Qf9IbHL3sN6Im6/BxTzJRdFnEh+g1tCkdWg=;
	b=yTPORjqb+XbCWgPE9G/GsAlmwLahdxpMYfzPsdyNbGQ1vWBlj2owPy3lBZw5XQxhTNselH8ZX
	If06OzshV6hD661IeNC3iLf3tuz2yWLI0rIJZzHcai6pMav6KJVFsIMxRurif8EfupS0SkzuB3e
	mqSv3hHgbS2qQ13vLztDdFc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hqfWf26HbzpStW;
	Wed, 23 Sep 2026 22:30:22 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id A3B004056D;
	Wed, 23 Sep 2026 22:42:20 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 22:42:19 +0800
Message-ID: <c7eceba4-fd29-4c80-9829-3948708b826f@huawei.com>
Date: Wed, 23 Sep 2026 22:42:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed
 1-byte and 2-byte kfunc args
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre
 Ghiti <alex@ghiti.fr>
References: <20260923144154.934674-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260923144154.934674-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)


Sorry for the noise. That was an accidental send—this patch has already 
been merged.

On 2026/9/23 22:41, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> On RV64, the ABI requires sign-extension for signed 1-byte and 2-byte
> kfunc args. However, the RV64 JIT currently does not perform
> sign-extension for such kfunc args.
> 
> Before commit 7ce090afbf72 ("bpf: Infer zext_dst based on static
> register liveness analysis"), state pruning could potentially omit
> zero-extension of 32-bit subregisters, which inadvertently masked the
> above issue by making the args appear as if they had been properly
> sign-extended. After that commit, the problem is exposed, causing the
> kfunc_call/kfunc_call_test4 selftest to fail.
> 
> Fix this by extending the existing sign-extension logic to handle signed
> 1-byte and 2-byte kfunc args as well.
> 
> Fixes: 443574b03387 ("riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 2504df1fa111..74efe4b138d2 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1823,9 +1823,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   
>   			for (idx = 0; idx < fm->nr_args; idx++) {
>   				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
> +				bool sign = fm->arg_flags[idx] & BTF_FMODEL_SIGNED_ARG;
>   
> -				if (fm->arg_size[idx] == sizeof(int))
> -					emit_sextw(reg, reg, ctx);
> +				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
> +					return -EINVAL;
>   			}
>   		}
>   
