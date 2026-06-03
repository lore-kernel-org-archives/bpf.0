Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BA38886B
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482441; cv=none; b=nMZUGI1n/Wo/W5Uece8WgEgpiGeeYmsw4/NWDMCJa1D06SfCIsp5TKhxA0vpF0CbdrVQ1YAfDByqZVWoDAE1XnFQ9+KBz7L9wI6WG0UNLNGYzcvU1Cobpxa6/sercpJ72te0Jp2lEgPukn2T9AfEqtDE8iwHhobFoRnqT1itP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482441; c=relaxed/simple;
	bh=EiBZtFDnFapRUuEMtPoIW7nvTo0KII9kUCvJJy/ROHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sNOpZbsI6NcC+1JAz3yOCzwi76c7zghKe4WiSYSNYyyrC1u66qDcgc853IlXdYSZhBlBtD/gBqK3vJKY33rFK0y7xPjCs4HAvG+b5LuvlSWxLOy5RZiyZUNQdXvedXX3StleMDK92di77DLU8URrDdOG6KvCiiky115kWhH7xew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP+yW2iS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP+yW2iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CEA1F00893;
	Wed,  3 Jun 2026 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482440;
	bh=5L0yfsmKbNo6+Od+gNMCwu55TDf7F5QhEWGHBhbGjf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VP+yW2iSjc9iOpbSfnsCV82fWg2F7bfPmgE977uIvHkcmjbt0/8EmhwK08YrYOOJb
	 yixA1MeImEWHcnPPGRPVG5mpEvZhxUc63dJTF+Hb71Av9te/cyZWAZoRpAG9NWqI/G
	 mg9ykByawpv/B3zkVxpvbITfrMVzoNDiqvqiE1CKbuXovV2E2aGYN0rCjwN9E0x1QP
	 FKBTH34gSm+/Xb7ijf7GybSpaQ8qoUvi/neR62on93DPrmG6ud1DqSPhAOZqA/FHAZ
	 fyeO55ZI+ijHU49OTPb3j2zjH0TJzo/QxVqbwynsjpKBDmLHtE7jsdLAhtPIplbOms
	 5tKsZQvDWXY1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] LoongArch: bpf: Advertise JIT support for kptr
 xchg inline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <zhaochenguang@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603100438.2177817-3-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-3-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:27:19 +0000
Message-Id: <20260603102720.20CEA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] LoongArch BPF JIT lacks required memory barriers for value-returni=
ng atomic instructions (`BPF_CMPXCHG` and `BPF_FETCH` variants), violating =
the Linux Kernel Memory Model.
--

commit ae71c5cdb14e5f9c74cac323c884423ce8768951
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

LoongArch: bpf: Advertise JIT support for kptr xchg inline
   =20
The BPF verifier can lower bpf_kptr_xchg() to BPF_XCHG when the JIT
advertises ptr xchg support. With ordered amswap_db.* emission from the
previous patch, declare that LoongArch bpf JIT supports this inlining.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index f071d913e0545..4f3aa53eda205 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2362,6 +2362,11 @@ bool bpf_jit_supports_fsession(void)
>  	return true;
>  }
> =20
> +bool bpf_jit_supports_ptr_xchg(void)
> +{
> +	return true;
> +}
> +

[Severity: High]
This is a pre-existing issue, but while the previous patch updated BPF_XCHG
to emit fully ordered amswap_db.* instructions, do the other value-returning
BPF atomics (BPF_CMPXCHG and BPF_FETCH variants) also need to be updated to
ensure sequential consistency?

According to the Linux Kernel Memory Model, value-returning atomic RMW
instructions must be fully ordered. In emit_atomic_rmw(), BPF_ADD | BPF_FET=
CH
and similar fetch variants emit weakly ordered instructions:

arch/loongarch/net/bpf_jit.c:emit_atomic_rmw() {
    /* src =3D atomic_fetch_<op>(dst + off, src) */
    case BPF_ADD | BPF_FETCH:
    ...
    emit_insn(ctx, amaddd, src, t1, t3);
    ...
}

Should these be using the fully ordered _db variants (e.g., amadd_db.d) or
be wrapped with dbar 0?

Similarly, BPF_CMPXCHG emits an ll/sc loop without memory barriers before
or after the loop:

arch/loongarch/net/bpf_jit.c:emit_atomic_rmw() {
    /* r0 =3D atomic_cmpxchg(dst + off, r0, src); */
    case BPF_CMPXCHG:
        move_reg(ctx, t2, r0);
        if (isdw) {
            emit_insn(ctx, lld, r0, t1, 0);
            emit_insn(ctx, bne, t2, r0, 4);
            move_reg(ctx, t3, src);
            emit_insn(ctx, scd, t3, t1, 0);
            emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
        } ...
}

Could this leave BPF programs vulnerable to memory reordering bugs on
LoongArch if dbar 0 is not emitted?

>  /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
>  bool bpf_jit_supports_subprog_tailcalls(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603100438.2177=
817-1-zhaochenguang@kylinos.cn?part=3D2
