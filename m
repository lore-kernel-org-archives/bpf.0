Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819736492D;
	Thu, 16 Jul 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189286; cv=none; b=QDCTKzjgl9Km1zmK1jeRFHH+QiKY79VUjyArRxfSRLHoeorBjenaYc/9yMB/+CkfnldVZO12Ng4LmrRvFocpkdJArWBFkrVBi5s4tgLczi5XSvuMvuqxz2ZAkLTbPB24w3puGaA6wyYLRWyTxdSvjAm/76lq8vvMRzBpIiILctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189286; c=relaxed/simple;
	bh=01rrTiPl5sgzDlJlZHIDrCqoUrrC+JefX+GMDz3AWfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knhrLCOd+aMUAKc/hKMn2hsXxamW9KMgBPvtNyN0MA9OiWIRf3+wNlWOA+b9D7qnE7pr8RP+Pa78eIk363wUmM6Gufn7+9krmjrA2x4Rv30tTRKFXNm/Mx1rTkMGY6EgFyjl+10YIiLpFBWuPTschqslY0kmJzR0Uul1Qtt4dtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niXas0v5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niXas0v5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BF21F000E9;
	Thu, 16 Jul 2026 08:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189284;
	bh=j19L2Iuj7nf3YuWOyNn/pNo1TKaAQ7yjwz7bZzfQ9ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=niXas0v57O5WQpY58b8mKCqlJ7dbVaCI3Py6WSwSc5gkHVGbCUZW5oEqoxbknAWHh
	 0K7n5HnWYxU7xKHbQoDNR7A/pb0GYJ5Wn/4PbKDefCuurGySZCvYN20SZz+73QBbXU
	 YGAlK1zTHlhloyHXzdMAvOjukVO9sH09lkjN8cPQYS2DzN7pFA3hr8L4nAYERwVArN
	 ltqtZFRxPn1ILi/evJYOL9SdeUocw00/7ejmW4Xqd1+GfNlSlkmYQV/7z/5XytHMU0
	 /+2IVy8RA3Mx7uMrnEbUumAK0Yh5NXFg9yzz2ChGfRRvyfFwnIo0opZZORFnmYVOZq
	 ZlXJx9AqHnmOg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Feng Jiang
 <jiangfeng@kylinos.cn>
Subject: Re: [PATCH v3 1/2] bpf, riscv: add support for timed may_goto
In-Reply-To: <20260715-riscv-bpf-timed-may-goto-v3-1-cf2a9c3d843f@kylinos.cn>
References: <20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn>
 <20260715-riscv-bpf-timed-may-goto-v3-1-cf2a9c3d843f@kylinos.cn>
Date: Thu, 16 Jul 2026 10:08:01 +0200
Message-ID: <8733xjwe5a.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Feng Jiang <jiangfeng@kylinos.cn> writes:

> Implement arch_bpf_timed_may_goto() for the RV64 JIT. The argument and
> return value are carried in BPF_REG_AX, and BPF R0-R5 are preserved
> across the call to the generic bpf_check_timed_may_goto().
>
> Enable bpf_jit_supports_timed_may_goto() so the verifier uses the timed
> expansion path.

Thanks for working on this!

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index c03c1de16b79..4f88a446278a 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1841,7 +1841,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		if (ret)
>  			return ret;
>=20=20
> -		if (insn->src_reg !=3D BPF_PSEUDO_CALL)
> +		/*
> +		 * arch_bpf_timed_may_goto() is emitted by the verifier and
> +		 * returns its result in BPF_REG_AX instead of BPF_REG_0, so
> +		 * skip the normal "move return register into R0".
> +		 */
> +		if (insn->src_reg !=3D BPF_PSEUDO_CALL &&
> +		    addr !=3D (u64)arch_bpf_timed_may_goto)

Nit: In the future, please use full 100 chars lines, instead of breaking
the line.

Would it be possible to add a test for this custom ABI? The fact that it
was missed in v1 hints that it would be good.

I asked an LLM to suggest a test [1]. Feel free to be inspired by it.
;-)


Bj=C3=B6rn

[1] https://paste.debian.net/hidden/9dd769d6
