Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A63F8241
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386679; cv=none; b=D2dDGAbFVX5HHtE3Y42X4eApB3W0JWtJNbD+su34bSrnatsXL80lzt5TJlNE3YgTwYbqdSZ/Fp+R670/nuRzC0GYzXSwHyxpu9JRlcoGeiWDARIZaBWtrSz5K5wWRHVoA3Q3i13/sgVR3WSfut0GFaRx+geFFq2ntIV8sDCRtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386679; c=relaxed/simple;
	bh=VWVGVI7y5BPKOnV4HnTHAdm+uze72pvXQFfNye0/d1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aw9I7NZxJyBoOb1mLB2SEE7E7DBx8o4caVHM7U9Gf+cvW59eNplTZG1/MPYVNOLQ5V1fpPnOOeF9TuO7DkK02VwuQ8zhb26WiY9bHGmHx1RfcEsM0obULkXXbzSMNOWrzB/LJF+Hl9e1tMIyu/CcLypmnWy9z+aG88DIah3A8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGfneIjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGfneIjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B81F1F000E9;
	Mon, 10 Aug 2026 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386678;
	bh=LcLqbC0PtFkvEZinpdBgcN8WwrADaPBp0LMG/K22ij8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IGfneIjWInYKrlKpnXLewG8dS1nmmDZxDCMmXhd06T2BZr4tVEOeoBOe2YHpyyrgY
	 aSde5sqNf3Bx2Q9di/RPwb00BDK1I1zfekk3eC6t0FIs4ACOg1VYJlCpQbnexG/zzT
	 XSnvuThvVwDsBxPAL25zTVbg9s75sXgBcjMwa6pL4ZdJzAUc6MUDp2iSc1lurKTOF8
	 lJWAsWZSPEi/CqMzc3hqLEB4N+n7YwuS1DDPFkFjGb4o8dcsbN+fE2X6Pgh3Y2Z3Yk
	 /9pvpSB6L7WRFEEUmLN94PSCYKmyfrVfPJ94CppWuyreg2Vn0WcDs4+Hw0Y3bejCqD
	 rzjwZT1CSNC0w==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: eddyz87@gmail.com, bpf@vger.kernel.org, Puranjay Mohan
 <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf, arm64: Clear fetch destination on
 faulting arena atomic
In-Reply-To: <20260810134346.466004-4-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
 <20260810134346.466004-4-daniel@iogearbox.net>
Date: Mon, 10 Aug 2026 19:31:13 +0100
Message-ID: <m2tsp1j09a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> Same problem as on x86-64: add_exception_handler() folds "there is no
> destination register to clear" and "this is a store" into one DONT_CLEAR
> value ...
>
>   if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn))
>           dst_reg = DONT_CLEAR;
>
> ... which ex_handler_bpf() then reads back as the access direction:
>
>   bool is_write = (dst_reg == DONT_CLEAR);
>
> A RMW carrying BPF_FETCH is both. emit_lse_atomic() reads the old value
> into src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and into
> r0 for BPF_CMPXCHG, so a fault over an unmapped arena page is correctly
> reported as a WRITE but leaves that register holding a stale value instead
> of the 0 that every other BPF_PROBE_* access delivers. Same as on x86-64,
> add a separate ARENA_WRITE bit for the direction and fill FIXUP_REG in
> from bpf_atomic_load_reg().
>
> Fixes: e612b5c1d3ee ("bpf, arm64: Add support for lse atomics in bpf_arena")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index d14d297ebb96..796ff9193cfb 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1082,23 +1082,27 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
>   *
>   * Bit layout of `fixup` (32-bit):
>   *
> - * +-----------+--------+-----------+-----------+----------+
> - * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
> - * |           |        |           |           |          |
> - * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
> - * +-----------+--------+-----------+-----------+----------+
> + * +-----------+--------+-------------+-----------+-----------+----------+
> + * |   31-27   | 26-23  |      22     |     21    |   20-16   |   15-0   |
> + * |           |        |             |           |           |          |
> + * | FIXUP_REG | Unused | ARENA_WRITE | ARENA_ACC | ARENA_REG |  OFFSET  |
> + * +-----------+--------+-------------+-----------+-----------+----------+
>   *
>   * - OFFSET (16 bits): Offset used to compute address for Load/Store instruction.
>   * - ARENA_REG (5 bits): Register that is used to calculate the address for load/store when
>   *                       accessing the arena region.
>   * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
> + * - ARENA_WRITE (1 bit): This bit is set when the faulting instruction wrote to the arena region.
> + *                        It is independent of FIXUP_REG, since a read-modify-write both writes to
> + *                        memory and reads the old value into a register.
>   * - FIXUP_REG (5 bits): Destination register for the load instruction (cleared on fault) or set to
> - *                       DONT_CLEAR if it is a store instruction.
> + *                       DONT_CLEAR if the instruction does not read into a register.
>   */
>  
>  #define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
>  #define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
>  #define BPF_ARENA_ACCESS           BIT(21)
> +#define BPF_ARENA_WRITE            BIT(22)
>  #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
>  #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>  
> @@ -1109,7 +1113,7 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>  	s16 off = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>  	int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
>  	bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
> -	bool is_write = (dst_reg == DONT_CLEAR);
> +	bool is_write = !!(ex->fixup & BPF_ARENA_WRITE);
>  	unsigned long addr;
>  
>  	if (is_arena) {
> @@ -1132,7 +1136,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
>  {
>  	off_t ins_offset;
>  	s16 off = insn->off;
> -	bool is_arena;
> +	bool is_arena, is_write = false;
>  	int arena_reg;
>  	unsigned long pc;
>  	struct exception_table_entry *ex;
> @@ -1183,13 +1187,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
>  	 * dst_reg like a BPF_LDX does, hence it must not be treated as a store
>  	 * here.
>  	 */
> -	if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn))
> -		dst_reg = DONT_CLEAR;
> +	if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn)) {
> +		/*
> +		 * A store has no destination register to clear, except for a
> +		 * read-modify-write with BPF_FETCH, which also reads the old
> +		 * value into src_reg, or into r0 for a BPF_CMPXCHG. Either way
> +		 * the access is still reported as a write.
> +		 */
> +		int load_reg = bpf_atomic_load_reg(insn);
> +
> +		dst_reg = load_reg < 0 ? DONT_CLEAR : bpf2a64[load_reg];
> +		is_write = true;
> +	}
>  
>  	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>  
>  	if (is_arena) {
>  		ex->fixup |= BPF_ARENA_ACCESS;
> +		if (is_write)
> +			ex->fixup |= BPF_ARENA_WRITE;
>  		/*
>  		 * insn->src_reg/dst_reg holds the address in the arena region with upper 32-bits
>  		 * being zero because of a preceding addr_space_cast(r<n>, 0x0, 0x1) instruction.
> -- 
> 2.43.0


Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
