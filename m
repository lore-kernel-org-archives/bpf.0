Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76113314B9
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481794; cv=none; b=HjVCBBL9bgXieDH1nKLqp1xRfditggg9Q2SdB5XfPZTTjN0tQSPhvWOv1RY0UBvMGaDO1hcDe9PhidbHb/fNkwmvSnhzcdzdOSGKXUpvdCK7jUCikEkl0Uh03jjiIDamofnv423xjwMChFQrW4P8zFmPmN8rworYBjno8nk/Hhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481794; c=relaxed/simple;
	bh=7dwNAkpBtb7Ey+VNc3mLD/sAlBmkSbtBCp8YRG4WTQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=leh/i+cZG3tLiaXzDpf4QMc/D/aqbUjSyKTO8ofa022pz7RwFzsam0tpDhoIzG2SmqLT8jqadW0L0dmXVmzzUoiPtBjy2d9Hnc0u8N9iaPnKcFm4V6sO90QxvMxxt1iSyLbaQguLi/HP/E3szxaMvp+KnaaPYMuOy0y4f92ix8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG8xjzhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG8xjzhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFA1F00893;
	Wed,  3 Jun 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780481793;
	bh=a/KNosUAFGM+JrUF9BCjYwsU8Bpx5wkpMpQ23G3v45c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SG8xjzhdUBuuvPx8S8whm9uSoDYZDa6k04Ouwpd71F9N8MFe2em7D9vXR0gTL4MGN
	 IEQFzzFC7FFN728S3vJ3ZEDkN/YTv8hehwhLsK3t0j9Xb32+G9IeNS8vDmmhZ4LVzz
	 7grlMKj52u+bqZ8tD2m++W5ocuESt1GkGraKxFxETQeYjIWtEZS5Q94XIiJsz/FXly
	 thC42klVCQa2Xr3pTFBAYgRCkYomaig3bi+qEuxFz+PG5xoRr9X1yvcjPGPLK2uMlX
	 hWGI0ZquFjXw2Ty+xdgVjXIVDZeujeA1zVbTtKkM8I5L3uTvfZxWM6ZWrxQ/i4GKIm
	 KWV9Wczi9stiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] LoongArch: bpf: Use amswap_db for BPF atomic
 xchg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <zhaochenguang@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603100438.2177817-2-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-2-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:16:32 +0000
Message-Id: <20260603101633.25FFA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch incompletely fixes memory ordering for value-returning B=
PF atomic RMW instructions. While it adds full barriers for 32/64-bit BPF_X=
CHG by emitting `amswap_db`, it misses other BPF_FETCH operations, sub-word=
 BPF_XCHG, and BPF_CMPXCHG, leaving them weakly ordered.
--

commit f10ece83a8a616fba153a535a64e9160f3060f64
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>
LoongArch: bpf: Use amswap_db for BPF atomic xchg

The patch updates the LoongArch BPF JIT to use amswap_db.{w,d} instead of
plain amswap.{w,d} for 32-bit and 64-bit BPF_XCHG instructions. This ensures
that value-returning atomic exchanges provide the full memory barrier requi=
red
by the Linux Kernel Memory Model.

> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 76b723590023d..636cfc524b020 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
[ ... ]
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e83..f071d913e0545 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -482,11 +482,11 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>  			emit_zext_32(ctx, src, true);
>  			break;
>  		case BPF_W:
> -			emit_insn(ctx, amswapw, src, t1, t3);
> +			emit_insn(ctx, amswapdbw, src, t1, t3);
>  			emit_zext_32(ctx, src, true);
>  			break;
>  		case BPF_DW:
> -			emit_insn(ctx, amswapd, src, t1, t3);
> +			emit_insn(ctx, amswapdbd, src, t1, t3);
>  			break;
>  		}
>  		break;

[Severity: High]
This is a pre-existing issue, but does this patch fully resolve the memory
ordering requirements for BPF atomics?

Per the LKMM and BPF documentation, all atomic RMW operations that return a
value must have sequentially consistent memory ordering (a full memory
barrier). While this patch addresses 32-bit and 64-bit BPF_XCHG, several ot=
her
value-returning atomics in emit_atomic_rmw() appear to still use weakly
ordered instructions.

For example, BPF_FETCH operations use plain amadd.w and amadd.d:

	case BPF_ADD | BPF_FETCH:
		switch (BPF_SIZE(insn->code)) {
		...
		case BPF_W:
			emit_insn(ctx, amaddw, src, t1, t3);
			emit_zext_32(ctx, src, true);
			break;
		case BPF_DW:
			emit_insn(ctx, amaddd, src, t1, t3);
			break;

Sub-word BPF_XCHG operations still emit weakly ordered amswap.b and amswap.h
without explicit barriers:

	case BPF_XCHG:
		switch (BPF_SIZE(insn->code)) {
		case BPF_B:
			...
			emit_insn(ctx, amswapb, src, t1, t3);
			...
		case BPF_H:
			...
			emit_insn(ctx, amswaph, src, t1, t3);

Additionally, BPF_CMPXCHG emits a bare ll and sc loop without the required
dbar (e.g., dbar 0x700) before and after the loop:

	case BPF_CMPXCHG:
		...
		if (isdw) {
			emit_insn(ctx, lld, r0, t1, 0);
			emit_insn(ctx, bne, t2, r0, 4);
			move_reg(ctx, t3, src);
			emit_insn(ctx, scd, t3, t1, 0);
			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);

Could we also update these other value-returning atomic instructions in
emit_atomic_rmw() so that all lockless BPF algorithms execute safely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603100438.2177=
817-1-zhaochenguang@kylinos.cn?part=3D1
