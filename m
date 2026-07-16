Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAA3CB577;
	Thu, 16 Jul 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189492; cv=none; b=WFXE+ly+yC8tvYhk6cnwuinrcUohBFIuVHAF39uLv44NLSQRLSBEPCJIgE+jTGLVAIGxxwFRA1SmTJ95U7/lybPZJbRA0dPpoG8Y0F96By4l6j3nlXD1Ifx1X9BKliZDct6MtawnkbSkxBM5bNYm2l1epR1peHLM5EGsRTMqRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189492; c=relaxed/simple;
	bh=ObU9+7IgM0qX5GE0sJAgdox0lNLUQrslB+SGCox+RIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aVugAkRSuRNWA/2ldhnZMANeL80gpbFXbxip8QThIf8AbF7MxHEBNtHo1yBEWuDXIrG0bCO2cnMELpLsAIkSUX8Gdl3Sfyp9FmDFxEcMvunDsXhSU2q5UglET1p4b5f4x1if5zZ+DbeYukhjKc2b8giZuXgncWLlfT7/BkknuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dSMQrXWv; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dSMQrXWv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pv577sMTFwQrPwgjiG8MvpB+Qkw1Yz2v2aLJ0k98900=;
	b=dSMQrXWvx4FaFbFNk7qY1QSnHXcM7SHSjFqDKlhSrPVOA98pSi4G73tjuZekZyNsj+YgeHf0k
	j+tW1qcCNNL7/vLdROyNlMdIZDcXGhZ+dlHvzEVZ5zIEGBxxseD0Oz6+Ij5ie04TJXB6xdv0aPi
	kr/VLIm1/uqwVocgyN3wj24=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h158z1pNPz12LCc;
	Thu, 16 Jul 2026 16:01:39 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A9C940537;
	Thu, 16 Jul 2026 16:11:16 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 16:11:15 +0800
Message-ID: <bff2043e-1efd-41ad-b285-0436a5df346d@huawei.com>
Date: Thu, 16 Jul 2026 16:11:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf, riscv: fix missing extable entry for arena
 load_acquire
Content-Language: en-US
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/16 15:38, Feng Jiang wrote:
> emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
> a sub-word load_acquire. The caller does "ret = ret ?:
> add_exception_handler(...)", which skips add_exception_handler() on any
> non-zero ret, so the extable entry is missing and a faulting
> PROBE_ATOMIC load_acquire oopses.
> 
> Check ret >= 0 before calling add_exception_handler(), and return ret
> unchanged so build_body() still skips the zext.
> 
> Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
> Suggested-by: Pu Lehui <pulehui@huawei.com>

A small matter.

Feel free to add:

Reviewed-by: Pu Lehui <pulehui@huawei.com>

> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
> Changes in v2:
> - Drop extra variable as suggested by Pu Lehui.
> - Link to v1: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v1-1-af023cc17af4@kylinos.cn
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index f9d5347ba966..0db89093ff89 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1986,7 +1986,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		else
>   			ret = emit_atomic_rmw(rd, rs, insn, ctx);
>   
> -		ret = ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> +		if (ret >= 0)
> +			ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx) ?: ret;
> +
>   		if (ret)
>   			return ret;
>   		break;
> 
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260716-bpf-riscv-fix-extable-399947ca778d
> 
> Best regards,


