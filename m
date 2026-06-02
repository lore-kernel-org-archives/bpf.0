Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE330E0F5
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367128; cv=none; b=oNDV4I0BOnc1Pl51GlvwNNsodSmlpJce5NI4NfvJ5OXK8MVTuncbsPktAfI5sJ+3S0YRcirteU27iuStXbYKt39njJi6Oysd1Rcy1wtpxnkHfvshQG6S5xlk5s4awkxNdRzHZMtlbOP5SyFXeVDBFUafYqHtUFeRXHVw9gSQ8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367128; c=relaxed/simple;
	bh=duNMhkov8Hv/1S+oDyHylMasAkWBD1qTdE94nP0ieJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r7Cji6WeNouN/4/w68wtUKmRLaJDxwXOr4fhyK+TDN6/lbN/6Cgk+DiJcsITPGPuVmoM6VflFNzwtlBA24kN/iiojN3m/Xnjt94S+O/6jKOIGpjPHdGuz9SotcaREeQPX5v4ubVuN2Ixm4/AU7hT6Hx/gavCFPvfhYSWVPmU3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I97qzmkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I97qzmkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C371F00898;
	Tue,  2 Jun 2026 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367126;
	bh=lthkiQjo4PSZHTwpKYbDpgHyxkiUmctaL+KpWV5HoNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I97qzmkDfLNGecDSVBV0srkFLNuWlblH26ICEvnDuItJrYQm3loEkEHpdjxYXi4x9
	 zCydJO/IxhWktZyqpbDiK2HW6HywdlUk++e1oo3qeAfGRYI+9sSuQ+wXIEuK2jSTjh
	 kX46/i1Mih/bpEE2GHZkF4uUR2EyeE4QFzh0jTql5XSCnSKiRgM3nfWJko/qPs+LM/
	 0rNFAp6Rj80+ik1N568faPfCGnLEs7U4y3CQ7c2Y1ay66StmU/pE8wfeDpS0zvQZjJ
	 W7VGE2mEDRgOdsHOY5aYkZPRko1kW0xiiIuxu9P68WZwJ7qjMpq0+pagcRiIvq3V1h
	 FgHhbc9MDH/0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: bpf: Support kptr xchg inline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <zhaochenguang@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
References: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 02:25:26 +0000
Message-Id: <20260602022526.C2C371F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch defines the ordered 32-bit exchange instruction `amswapd=
bw` but fails to use it for the 32-bit BPF_XCHG case, leaving it weakly ord=
ered.
- [Low] Multi-line comment style violation in BPF subsystem.

Pre-existing issues:
- [High] Preexisting memory ordering violations in BPF_FETCH and BPF_CMPXCH=
G implementations.
--

commit 76b8cc9ecd892758ab016da683663dd4efa3eb24
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

LoongArch: bpf: Support kptr xchg inline

This patch enables inlining of the bpf_kptr_xchg() helper into a single
ordered atomic exchange instruction (BPF_XCHG) on LoongArch. It introduces
the amswapdbw and amswapdbd instructions to ensure full memory ordering
semantics as required by the BPF verifier. It also adds a related benchmark
and extends existing selftests.

> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 76b723590023d..636cfc524b020 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -783,6 +783,8 @@ DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
>  DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
>  DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
>  DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbw, amswapdbw_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbd, amswapdbd_op)

[ ... ]

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e83..b2bc54b4ca873 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -486,7 +486,7 @@ static int emit_atomic_rmw(const struct bpf_insn *ins=
n, struct jit_ctx *ctx)
>  			emit_zext_32(ctx, src, true);
>  			break;
>  		case BPF_DW:
> -			emit_insn(ctx, amswapd, src, t1, t3);
> +			emit_insn(ctx, amswapdbd, src, t1, t3);
>  			break;
>  		}
>  		break;

[Severity: High]
The patch defines amswapdbw in asm/inst.h, but does the BPF_W case of BPF_X=
CHG
in emit_atomic_rmw() also need to be updated?=20

Currently, the 32-bit exchange uses the weakly ordered amswapw instruction:

emit_atomic_rmw() {
...
	case BPF_XCHG:
		switch (BPF_SIZE(insn->code)) {
...
		case BPF_W:
			emit_insn(ctx, amswapw, src, t1, t3);

Should this be updated to use the new amswapdbw instruction to ensure
the BPF memory ordering guarantees are met for 32-bit exchanges?

[Severity: High]
This is a pre-existing issue, but do the other fetch atomics and cmpxchg
instructions in emit_atomic_rmw() also need memory barriers to provide
the fully ordered semantics required by the BPF memory model?

For example, BPF_FETCH operations emit weakly ordered instructions without=
=20
the _db suffix:

emit_atomic_rmw() {
...
	case BPF_ADD | BPF_FETCH:
...
		case BPF_DW:
			emit_insn(ctx, amaddd, src, t1, t3);

Similarly, BPF_CMPXCHG uses ll/sc loops without any completion barriers:

	case BPF_CMPXCHG:
		move_reg(ctx, t2, r0);
		if (isdw) {
			emit_insn(ctx, lld, r0, t1, 0);
			emit_insn(ctx, bne, t2, r0, 4);
...

Could these weakly ordered memory operations lead to race conditions in=20
concurrent BPF programs by allowing the CPU to reorder memory accesses?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c b/tools/=
testing/selftests/bpf/progs/kptr_xchg_bench.c
> new file mode 100644
> index 0000000000000..ff146e4dcde7a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
> @@ -0,0 +1,48 @@

[ ... ]

> +	__sync_add_and_fetch(&hits, i);
> +	return 0;
> +}
> +
> +/* BTF FUNC records are not generated for kfuncs referenced only through
> + * optimized paths. Keep bpf_obj_drop() visible to libbpf's kfunc linker.
> + */
> +void __btf_root(void)
> +{
> +	bpf_obj_drop(NULL);
> +}

[Severity: Low]
Does this comment style match the BPF subsystem guidelines? The
preferred modern kernel multi-line comment style places the opening
slash-star on its own line:

/*
 * BTF FUNC records are not generated...
 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602021515.2145=
60-1-zhaochenguang@kylinos.cn?part=3D1
