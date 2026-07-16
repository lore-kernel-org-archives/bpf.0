Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D935674F;
	Thu, 16 Jul 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185293; cv=none; b=Pvu+PmBzkdVVP78gDAVI6jLBuTmFTOhaJPQPcP6GV8MKFi62lqbQ7U8MxgjDQJW4DcJfImFdYnc2+PFOArozPp19GUYp0lzJs0jEB/4pryQy7Vzx1sihrvzBd/6+6wmNB2ieH1ZuVsY9cPYu0QGztbKCtnIQrB8lFh91A1a2xYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185293; c=relaxed/simple;
	bh=zM6Y7bxesU6Exxe8FQxqQFRhs+siOMwjEDlXBCmPpB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EZMt3CSdEQoSuFus5F5raZxuba73tObz3ZHXqppeJdvyb6PEe40If45eLbU5RI06ybEv+2xodrgzHlZ3QuMPR1cd6zfXAfP9+pzO1+S4bwsaNiSZajS5h91/lQPacLViDjyr1KdVawrpzRgXkXhcJOwbI+nH03Ms4pvdkq5qhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Cu2Prxq7; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Cu2Prxq7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VbdhA8Y5NdBAGbIMkJD62B07nlb+nNjilt6Rs/mVUq4=;
	b=Cu2Prxq7U5U7TZXFseJCYQADjZvzmqWYEMfaFLyHmt5u0DAFQ2fkJ5SgpRXasysLM70RbCr5o
	6YW9DXxtxBtG9QqFIrxfXhk76U4amAp692hvZoFguW2F6M0Jud2tvweQ6EhCEOeWVFAea/qCqfH
	HnYw86Mu9MZ0wHMrZ52hHMA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h13cd5fNYz1prm3;
	Thu, 16 Jul 2026 14:52:01 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B052040538;
	Thu, 16 Jul 2026 15:01:22 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 15:01:21 +0800
Message-ID: <ed7c71d1-f692-4a8f-954e-2d3ea9177c28@huawei.com>
Date: Thu, 16 Jul 2026 15:01:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, riscv: fix missing extable entry for arena
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
References: <20260716-bpf-riscv-fix-extable-v1-1-af023cc17af4@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260716-bpf-riscv-fix-extable-v1-1-af023cc17af4@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/16 14:15, Feng Jiang wrote:
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
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index f9d5347ba966..4fd4392dd080 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1986,10 +1986,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		else
>   			ret = emit_atomic_rmw(rd, rs, insn, ctx);
>   
> -		ret = ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> -		if (ret)
> -			return ret;
> -		break;
> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> +		if (ret >= 0) {
> +			int err = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);

Thanks Feng Jiang. Maybe we could remove this additional variable.

```
/* ret can be 1 (skip-zext); extable entry still needs to be added */
if (ret >= 0)
   ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx) ?: ret;

if (ret)
   return ret;

break;
```


> +
> +			if (err)
> +				return err;
> +		}
> +		return ret;
>   
>   	default:
>   		pr_err("bpf-jit: unknown opcode %02x\n", code);
> 
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260716-bpf-riscv-fix-extable-399947ca778d
> 
> Best regards,
