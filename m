Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CD4078E8
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433498; cv=none; b=T9CU0Z3ciq6o2Qm3PKoSeOlvi0xvAXoP9Fdi3BK/VrGldHoCw+10apsHCvIIfixikOK4LTVvOsZJVWhG7/1YrW1tY1qVN41yfpHP5AodPHuxlOvSsiylqe3lNGAgHtJezxIppKJIEkUr9yzDrxt42kuinWjrWUjYdeiqyqUpctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433498; c=relaxed/simple;
	bh=n3eS78NfBwZxlTYHkg1096S6yQSlLtmMNGgMaPxeIIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C8/PpLOvkROYxJyAU9DNAmyLd+Vd936rdnWqrmies9GFLwtNy37hvIyKkDZDrA1SJhYKlLiXOd5xTnjuC7e22xIq/6nCxVKTK5GMu9A5efjq/tx5ym1GptYZhmC4fThKK0hvPBIKRwxelS5kt0kYHPh2rvIGiHpZTh0gUSPnuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAuSy3OQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAuSy3OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F581F00893;
	Sat, 26 Sep 2026 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433497;
	bh=HvcwWrJwnpBQZsCaxjub4LWpNH6rbbMRxTDP3Iv/ccg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KAuSy3OQPr48vWDKpbS0R0c0lZD6+OBPaRQEdNyJ4mWwO3ANt45Z+p3NfE5D/F2eq
	 eKCcDg7kbBTjxa5XeykfVlDuukvETpdapIREA2aY2MIwmkkzBs27doBL3C+sxoE4bE
	 xvxajX0WFBj1zy2Qo3VrboLvNz1IOxDX/k3J/Ks70wuVi16FwuFEq+w1nWaEQyXxKh
	 79vOk08bL/lJy1n+oy5Q78IYxY7piUhyi1kR8dDWGx9hz7QA9VPoxgu7tRCOpHeIOY
	 vcVu2Vpk1IZO1wQFP1Jj8hxFGFhE6Y2gMJQWcA1JZSoyWXDSQynaD05rPS/jauGBO/
	 pR6wsMq81v26A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 24/36] bpf: compute scalar evolution
 expressions for loops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-24-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-24-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:38:16 +0000
Message-Id: <20260926143816.D6F581F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: NULL pointer dereference in compute_insn_scevs() for loops wi=
th exits_overflow
- [Medium] bpf: Incorrect SCEV modeling of BPF_END no-op conversions preser=
ves truncated bits
--

commit 3c85c59367498a632c83889db787693adfac36e5
Author: Eduard Zingerman <eddyz87@gmail.com>
Subject: bpf: compute scalar evolution expressions for loops

This patch assigns algebraic expressions to loop variables (registers and
stack spills) to describe how their values evolve across iterations. The
analysis proceeds in two phases: computing expressions for one symbolic
iteration and converting backedge updates to recurrences.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> new file mode 100644
> index 0000000000000..396b0c776dfae
> --- /dev/null
> +++ b/kernel/bpf/scev.c
[ ... ]
> @@ -713,29 +713,25 @@ static int transfer(struct bpf_verifier_env *env, s=
truct env *e, int idx)
[ ... ]
> +		case BPF_END:
> +			switch (insn->imm) {
> +			case 16: op =3D BSWAP16; break;
> +			case 32: op =3D BSWAP32; break;
> +			case 64: op =3D BSWAP64; break;
> +			default:
> +				goto mark_dst_unknown;
> +			}
> +
> +			if (class =3D=3D BPF_ALU && x_or_k =3D=3D BPF_TO_LE && insn->off =3D=
=3D 0 && little_endian)
> +				op =3D 0; /* little-endian to little-endian is noop */

[Severity: Medium]
Can this skip the required 16-bit truncation semantics?

When a BPF_END instruction is a 16-bit endianness conversion (imm =3D=3D 16)
and acts as a no-op on the current architecture, op is set to 0.

Because op is 0, the explicit truncation operation (like ZEXT16) is skipped
below. Only ZEXT32 is applied to the register:

kernel/bpf/scev.c:transfer() {
    id =3D reg2expr[dst];
    if (op)
        id =3D expr1(scev, op, reg2expr[dst]);

    if (class =3D=3D BPF_ALU)
        id =3D expr1(scev, ZEXT32, id);
    ...
}

The verifier and hardware will still truncate the register to 16 bits,
zeroing bits 16-63. By skipping this in the algebraic model, does it
incorrectly preserve bits 16-31 of the original register?

> +			else if (class =3D=3D BPF_ALU && x_or_k =3D=3D BPF_TO_BE && insn->off=
 =3D=3D 0 && !little_endian)
> +				op =3D 0; /* big-endian to big-endian is noop */
> +			else if (class =3D=3D BPF_ALU64 && x_or_k =3D=3D 0 && insn->off =3D=
=3D 0)
> +				/* always swap */;
> +			else
> +				goto mark_dst_unknown;
> +
> +			id =3D reg2expr[dst];
> +			if (op)
> +				id =3D expr1(scev, op, reg2expr[dst]);
> +
> +			if (class =3D=3D BPF_ALU)
> +				id =3D expr1(scev, ZEXT32, id);
> +
> +			return replace_reg(scev, e, dst, id);
[ ... ]
> @@ -1172,13 +1172,13 @@ static void mark_latches(struct bpf_verifier_env =
*env)
> +	for (i =3D 0; i < len; i++) {
> +		loop =3D aux[i].loop;
> +		if (!loop)
> +			continue;
> +		aux[i].need_scev =3D true;
> +		if (loop->irreducible)
> +			continue;

[Severity: High]
Does this code result in a NULL pointer dereference when a loop has an
exits_overflow condition?

Loops with exits_overflow are not skipped here (unlike irreducible loops),
so their latches are marked with aux[latch].need_scev =3D true.

However, compute_scev_for_loop() bails out early for exits_overflow loops
and does not allocate a loop environment for the latch:

kernel/bpf/scev.c:compute_scev_for_loop() {
    if (cur_loop->irreducible || cur_loop->exits_overflow) {
        header_env =3D get_loop_env(scev, cur_header, cur_header);
        ...
        return 0;
    }
    ...
}

Later, when bpf_compute_scev() visits the latch, it calls
compute_insn_scevs(), passing the result of find_loop_env(). Since the
environment was never created, find_loop_env() returns NULL.

This results in einsn being NULL in compute_insn_scevs():

kernel/bpf/scev.c:compute_insn_scevs() {
    ...
    for (reg =3D 0; reg < REGS_NUM; reg++) {
        id =3D einsn->reg2expr[reg];
}

Should exits_overflow loops be skipped here similarly to irreducible loops?

> +		for (j =3D 0; j < loop->backedges_cnt; j++) {
> +			latch =3D loop->backedges[j].latch;
> +			if (latch >=3D 0)
> +				aux[latch].need_scev =3D true;
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D24
