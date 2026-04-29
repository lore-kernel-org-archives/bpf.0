Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB033ADAE
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490745; cv=none; b=XOL3M9HVc2b3HGVVmTmaSLneDeoOGVEW7cmv689PtqPuoaXpon3hlsnK6bb7K3HXLpVbNXe7oUBnmH7RrwRu8T4VRd3WY1PbjIAGuT572MMUZhYwVPONHTuTAwmnqtwwWqPm0zUu7WLPyrYHRvZGE8H1Hojd5iLPBXJdvd7aw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490745; c=relaxed/simple;
	bh=wrtNU4PldsqZz7/ZRzhj2B95OqUlU/IEl5nXKUC9oNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hutfJE8y6ZgwDjvuCX+xjZwsNyU8SmkzX6seFfOUzxp2KlBReMloTopNm0F23pXzYqIdJIWWMluZzPM2kk8kygUV+K4BJ0d4FlRYjcALg2HtzvpQc2cDFdik+0gni0llloMCbtHxVvf/JWMyuBuTS8d3cipBW54kvfiYhPkNcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo1voscE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo1voscE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEA5C19425;
	Wed, 29 Apr 2026 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777490745;
	bh=wrtNU4PldsqZz7/ZRzhj2B95OqUlU/IEl5nXKUC9oNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Uo1voscEfLslm5JrjZgGU5kScL7zfhzMDFi/3cATjNTCpKHJVnCqbRowI3QZo8+1X
	 3AtnHlWjpHN1qanUFybso+jMz/iNe1tHsTBxsIE9/jqRDWTOKfwDqmAbvrH4njtFCS
	 2bVKbUSx+MS4J9DdSUk7zXVJCqmPwJD8kuZz8RKrUOlHfsN1gfluUykYNUCio72DHh
	 NSrNM2NN43Nvm+rWz2wG4l1nb/3K/Dek2+EbGo/2dUQz1pQ035n5fgQQ+utT3o2hoe
	 QvQoeVW7OW04nknnzODm96QHZ2ThPDRurUR4YX6zN0OOedVsvg0/CS+4V9/26b7m5g
	 fa9ecdoQMSXiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] riscv, bpf: Add 32 bit atomic operations
 to RV32 JIT
Reply-To: sashiko@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429123513.3477780-4-visitorckw@gmail.com>
References: <20260429123513.3477780-4-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 19:25:44 +0000
Message-Id: <20260429192544.DCEA5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF atomic fetch operations and BPF_XCHG are emitted with relaxed =
memory ordering, violating the BPF memory model.
--

commit f7db41188f6daa7740f66e1c205fcef2107a88ae
Author: Kuan-Wei Chiu <visitorckw@gmail.com>

riscv, bpf: Add 32 bit atomic operations to RV32 JIT

This commit adds native support for 32-bit BPF atomic operations to the RV32
BPF JIT compiler. It maps BPF_ADD, BPF_AND, BPF_OR, BPF_XOR, and BPF_XCHG
directly to their corresponding RISC-V amo*.w instructions.

> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_com=
p32.c
> index f8509950fed4..710c56b20f98 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
[ ... ]
> @@ -902,11 +902,40 @@ static int emit_store_r64(const s8 *dst, const s8 *=
src, s16 off,
>  		case BPF_MEM:
>  			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
>  			break;
> -		case BPF_ATOMIC: /* Only BPF_ADD supported */
> -			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
> -			     ctx);
> +		case BPF_ATOMIC:
> +		{
> +			s8 fetch_reg =3D (imm & BPF_FETCH) ? lo(rs) : RV_REG_ZERO;
> +
> +			switch (imm) {
> +			case BPF_ADD:
> +			case BPF_ADD | BPF_FETCH:
> +				emit(rv_amoadd_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_AND:
> +			case BPF_AND | BPF_FETCH:
> +				emit(rv_amoand_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_OR:
> +			case BPF_OR | BPF_FETCH:
> +				emit(rv_amoor_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_XOR:
> +			case BPF_XOR | BPF_FETCH:
> +				emit(rv_amoxor_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;
> +			case BPF_XCHG:
> +				emit(rv_amoswap_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
> +				break;

According to the BPF instruction set specification, atomic operations that
return a value (like BPF_FETCH variants and BPF_XCHG) must have fully
ordered semantics and act as full memory barriers.

Since the aq (acquire) and rl (release) bits are passed as 0 to the
rv_amo*_w functions here, doesn't this emit the instructions with relaxed
memory ordering? Could this allow the CPU to reorder memory accesses around
the atomic operations and lead to data races or synchronization failures in
BPF programs?

> +			default:
> +				return -1;
> +			}
> +			if (imm & BPF_FETCH) {
> +				emit(rv_addi(hi(rs), RV_REG_ZERO, 0), ctx);
> +				bpf_put_reg64(src, rs, ctx);
> +			}
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429123513.3477=
780-1-visitorckw@gmail.com?part=3D3
