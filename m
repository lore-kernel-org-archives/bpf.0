Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408948;
	b=QmsGJ+IudcMMTLUMDLz+Owz/dnEA0oQcP4P+OASpcKXpoSVQTGS6IgTbYPEq7c1rMFQX
	 /6OHCSsvBNMmF3+G4VMLvV3KrTb6O641yFkWC2h7uawOb0DRc+f43kXBgWpONQuCwmrdz
	 GZVzijbsjp9kOTczq0HCrNtgvug9zLOgZzV81GdSh6ieRBs/eX6pUsoHrk0S25MdKFsAe
	 Hzi4laFGPEB6ZiFIMoYHvc3UHaxfyEjRQkiGNxCLd8YmisvmXEgQp0qE8hUMe1UiLc5jx
	 5pR3T4+Ix+Q7I0Tgm++DsJvwNFVZeOJIAMy8spXjkyv5WBLpADM+gOZFc3AOr7h1CbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uxVlwqKlVbK1HsMsQ6Ohi2P0jyFg7ofnLfMfsB1aXAM=;
	b=ZRDm0VfZpvgBYCen3Mc8TMXAy4sAn0selrXMM8sFTTplCpi4BccP/6iRj/6PyqCjcAZz
	 fppMofe6hn/e5YzuTPl2y8AZLKWGcSUAs31OyevduhpLmLZvizo0CAKhO7opcti5Y4B98
	 hDUew53r8D+Al8rAMjCLn84Li0Mep1nHTSzXdvq1RCfQiV0RwfEC6YgN2jlwnVTRtRCKZ
	 9GArsI8XqXsz043DT1cnvZEXOZh93/5WumdS6NFHJ24/xfpY16qWSSFTld4J8S2zspd/E
	 fUNgyV3oD0J2q0xu3PByOLWD4QeGM89txFJdecqxHLNVefzNv0idgqHT17PsyINGqIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7Su1GhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF3606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7Su1GhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4A1F000CA;
	Mon, 23 Nov 2026 04:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795408948;
	bh=uxVlwqKlVbK1HsMsQ6Ohi2P0jyFg7ofnLfMfsB1aXAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j7Su1GhJ6L6m/Jz/3OT68+JHdf1NWWpQzqHrQBWPrw0DHA3XpmOirX41ubMR+Pkp2
	 Iiv730UsBxOJluAFAIJmhLpjFJZza7N9bD/u7nfht+os66EXxtt/iieLdMuRaEhqbh
	 KLUOUR1wBS5r/Rub8uWWLFUSSO9lDRzT+yVNiI8x0ahjs5oH2KbrE1JvyaxHNfx1pg
	 4yEFXYAyYOn5GjwwcybDJZrcShLRAqbP0wcYDy6Dk+Njyuqo8n2YpHRPXn6rzFGbTj
	 4lirhOp2Maj+W1eAauGYmHcqWU8G882X8Yl+9AicJpykDDzSbRZkZdRWh+GWJJRmkj
	 l3D1R2Zj8Gh6A==
Message-ID: <sashiko-outbox-228668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] LoongArch: BPF: Optimize BPF_CALL control flow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123043907.20225-2-yangtiezhu@loongson.cn>
References: <20261123043907.20225-1-yangtiezhu@loongson.cn>
 <20261123043907.20225-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 04:42:27 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] LoongArch: BPF: unshifted and unaligned offset for
  stptrw/stptrd in build_insn() [1]
--

commit 0dc0cb0459b2a4e50da067a04e5643e5c6bf634c
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Optimize BPF_CALL control flow

This commit separates BPF_PSEUDO_CALL handling in build_insn() so that it
emits the jump and breaks early, avoiding a redundant check at the end of
the BPF_CALL case.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 15af1abb5cb69..b26b75f62fb31 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1219,6 +1219,9 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>  		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
>  			tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
>  			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
> +			move_addr(ctx, t1, func_addr);
> +			emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
> +			break;
>  		}
> =20
>  		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> @@ -1245,8 +1248,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>  		 * convention with the argument and return value in BPF_REG_AX,
>  		 * so skip moving the C return value into BPF_REG_0.
>  		 */
> -		if (insn->src_reg !=3D BPF_PSEUDO_CALL &&
> -		    func_addr !=3D (u64)arch_bpf_timed_may_goto)
> +		if (func_addr !=3D (u64)arch_bpf_timed_may_goto)
>  			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> =20
>  		break;

[Severity: High]
This problem wasn't introduced by this patch, but can emit_insn() for
stptrw and stptrd in build_insn() corrupt memory outside the target buffer
[1]?

Later in build_insn(), the BPF_ST and BPF_STX cases emit stptrw and stptrd
when off is outside the 12-bit signed immediate range [-2048, 2047] but
within the 14-bit signed range [-8192, 8191]:

arch/loongarch/net/bpf_jit.c:build_insn() {
    ...
		case BPF_W:
			if (is_signed_imm12(off)) {
				emit_insn(ctx, stw, src, dst, off);
			} else if (is_signed_imm14(off)) {
				emit_insn(ctx, stptrw, src, dst, off);
			} else {
    ...
}

In LoongArch, stptr.w and stptr.d require a 4-byte-aligned offset encoded
as a word-scaled 14-bit signed immediate (si14 << 2), whereas
emit_stptrw() and emit_stptrd() write their immediate argument directly
into insn->reg2i14_format.immediate without shifting.  Passing the byte
offset off directly causes the store to write to dst + (off << 2) instead
of dst + off, corrupting kernel memory up to 24 KB beyond a verifier-
checked map value or arena buffer.

[1] https://sashiko.dev/#/bug/linux-9c06f20c-c232-47f5-ae96-11fb3889acdc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123043907.2022=
5-1-yangtiezhu@loongson.cn?part=3D1
