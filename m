Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10E3C09E0;
	Thu, 16 Jul 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191213; cv=none; b=EEoKeyGDIEK/QKRFxJiLF2QzR58JP+QeuJ3UuazQq8thpiieQTpPJuHNTjePOHj9FheqaJ6dTkDL+GDDcV6HwsJiZHb0/fOSUpXCBrGqRoY6C8k+uje7RhIPC6l6PJO1dHyVMzHtSN1RI6gWruXvsnlmCrf6ib9nxka3XLj7owY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191213; c=relaxed/simple;
	bh=RmI8X0ywKJo5AqoISg3nDdvOvKlpWpWS29g7nD4VuCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B8xhadQyc7WqerTx7MvouwTvQgLDRqbvk+MuP2rBx8AKmU4xOO16pHD3d5aEGQ9GQZKkXc4UjDUoq4dLq7a75yJI4o1Djk1hk8T6moxc14LHYPH2XSyEP0n+eLijVt+UxSBVAKo1Qjr/uwSW9Tf/QpHgAik5It0ANYU3KMMWyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/TJ4nbj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/TJ4nbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93601F00A3A;
	Thu, 16 Jul 2026 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784191211;
	bh=1qGYz+P3LBTYY4lqZ9Zhy3LPOk8R0ED0gCCmiSwGKck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=f/TJ4nbjQCqXI1omOteC2TYbo6r5M0zldVEySpvhbsFDQFGzy2Kca2CMIk7c+axwe
	 iefAC/8RodCLuOM2wqTCAZXEQDWC2P+W8OFLexG6SL8NNSdSfCLl/jBGxsf1Id657H
	 DUIAWKf4cpi6CoJg5MrIN1qd1POVfHdILoRGWXJpM6JmV4ONeSe2wzTlHKZxZKhsk/
	 3NlVagn5PZEcteDbnXjRcLrMxDZmyeovsF9iN6n0/5wg/Uu4/ZVx7sMGeA0fY0fg/+
	 4EPF9pKZLwtOOXQqw7FsPWwA8NmJxGAWiCxw32E5cOsKdJF2s7hl9EH/8DDW0A9eAx
	 VqE87F0M3l1kQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Pu Lehui
 <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Feng Jiang
 <jiangfeng@kylinos.cn>
Subject: Re: [PATCH v2] bpf, riscv: fix missing extable entry for arena
 load_acquire
In-Reply-To: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
References: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
Date: Thu, 16 Jul 2026 10:40:08 +0200
Message-ID: <87wluvuy3b.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Feng Jiang <jiangfeng@kylinos.cn> writes:

> emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
> a sub-word load_acquire. The caller does "ret =3D ret ?:
> add_exception_handler(...)", which skips add_exception_handler() on any
> non-zero ret, so the extable entry is missing and a faulting
> PROBE_ATOMIC load_acquire oopses.
>
> Check ret >=3D 0 before calling add_exception_handler(), and return ret
> unchanged so build_body() still skips the zext.
>
> Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
> Suggested-by: Pu Lehui <pulehui@huawei.com>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
> Changes in v2:
> - Drop extra variable as suggested by Pu Lehui.
> - Link to v1: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v1=
-1-af023cc17af4@kylinos.cn
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index f9d5347ba966..0db89093ff89 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1986,7 +1986,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		else
>  			ret =3D emit_atomic_rmw(rd, rs, insn, ctx);
>=20=20
> -		ret =3D ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> +		if (ret >=3D 0)
> +			ret =3D add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx) ?: re=
t;

I don't agree with Sashiko that this was fully pre-existing. This fix
changes the existing behaviour of BPF_DW | BPF_LOAD_ACQ. We can now end
up with stale register data.

I'd like to see a v3 that addresses REG_DONT_CLEAR_MARKER for atomic
loads (zext included).


Bj=C3=B6rn
