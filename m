Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952FA40DFB6
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386166; cv=none; b=JeNi4kX8hIjakU5isaUlHvH5teawq2C1s5IyAzOd0YEorwVzbunvho4SBm5fTMm+6X3d6eYEKPdKtl2BydD9RhuF4IEnSXFabPiaRy/CBiJpizlUF0M9lWEYAa9qzF+3ayHKnDmCnzNLZK+JIEYxIoykM3QJQ70/5QraOvx4abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386166; c=relaxed/simple;
	bh=6jmgS9tQY/PyD91QJyrXgSCbUFlodno9O/DZVZqLPcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b+z3gjXJVR7gd/rikobAkgkBqAjYMn3UbMpvYatjod2pn4uH5IdwPHT8Gte3MksnZoLUhQ1h0R342AnddyU+c0LAH5ywsE+IChfjY05sryoxe69mlVEdjU68ju/OMHDiBGZRf/HmQFSdWxmH5aw0mSHN8hB8XmxqfV5MPmrvK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exYs7mH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exYs7mH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC3B1F000E9;
	Mon, 10 Aug 2026 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386163;
	bh=0dpyBklQhzXaz+dh3fRfbB+QR3jQQ4J6zHnjKQmMp3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=exYs7mH/Ks3+4Bg8TIRYt3JEc48T15YMCAaVWN2abxE7R/uUS1wPA5PKMHczCrvN6
	 2NOc7XZTytFpW9IdAjzxTZ/nKTR+Sb5UKZOW4F5H2EsZjUAj7mVCpjVPHsT3kFzhYX
	 AbooV9mDFeLK3JVPJQVvvJwI6XI4oEPRdnZId0oPSK0ZA6b6ImicVt+ah/pkEzE0eM
	 6vSDZJ1XVjo7upBCXhVeqBEntH/r+UtK1btP8Rl9xfAXezT7s+i7ivGUcuFZx+hSLa
	 BGi14dIHw3FtQVTXVjMbTSdrKBw/zXyg8R3hx4Ff9pgKwDbzQPbeWvieaCGqMHF/Yf
	 XRTyW1Ra8lgOg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: eddyz87@gmail.com, bpf@vger.kernel.org, Puranjay Mohan
 <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf, x86: Clear fetch destination on
 faulting arena atomic
In-Reply-To: <20260810134346.466004-3-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
 <20260810134346.466004-3-daniel@iogearbox.net>
Date: Mon, 10 Aug 2026 19:22:35 +0100
Message-ID: <m2zeytj0no.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> populate_extable() encodes "there is no destination register to clear" as
> DONT_CLEAR in the DST_REG field of the exception table metadata, and later
> ex_handler_bpf() then reuses that very value to derive the direction it
> reports the fault with is_write = (reg == DONT_CLEAR). The two coincide
> for a plain load or store, but not for a RMW carrying BPF_FETCH. Such an
> atomic writes memory, so it has to be reported as a WRITE, and it also reads
> the old value into a register, src_reg for BPF_ADD | BPF_FETCH and BPF_XCHG,
> r0 for BPF_CMPXCHG, so that register has to be cleared on fault. A single
> DONT_CLEAR cannot say both, and the store branch picks it unconditionally:
>
>   [...]
>   } else {
>           arena_reg = reg2pt_regs[dst_reg];
>           fixup_reg = DONT_CLEAR;
>   }
>   [...]
>
> The reported direction is therefore right, but on a fault over an unmapped
> arena page the fetch destination keeps whatever it held before the atomic,
> where every other BPF_PROBE_* access delivers 0. Give the metadata its own
> ARENA_WRITE bit so that the reported direction no longer depends on whether
> there is a register to clear, and fill DST_REG in from bpf_atomic_load_reg().
> BPF_{AND,OR,XOR} | BPF_FETCH need no handling here, bpf_jit_supports_insn()
> already rejects those in the arena.
>
> Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/net/bpf_jit_comp.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8dddb5d7af21..d920772af7d5 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1473,17 +1473,20 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>   *
>   * Bit layout of `fixup` (32-bit):
>   *
> - * +-----------+--------+-----------+---------+----------+
> - * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
> - * |           |        |           |         |          |
> - * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
> - * +-----------+--------+-----------+---------+----------+
> + * +-----------+-------------+--------+-----------+---------+----------+
> + * | 31        | 30          | 29-24  |   23-16   |   15-8  |    7-0   |
> + * |           |             |        |           |         |          |
> + * | ARENA_ACC | ARENA_WRITE | Unused | ARENA_REG | DST_REG | INSN_LEN |
> + * +-----------+-------------+--------+-----------+---------+----------+
>   *
>   * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
>   * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
> - *                      This is set to DONT_CLEAR if the insn is a store.
> + *                      This is set to DONT_CLEAR if the insn does not read into a register.
>   * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
>   *                       address for load/store when accessing the arena region.
> + * - ARENA_WRITE (1 bit): This bit is set when the faulting instruction wrote to the arena region.
> + *                        It is independent of DST_REG, since a read-modify-write both writes to
> + *                        memory and reads the old value into a register.
>   * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
>   *
>   * Bit layout of `data` (32-bit):
> @@ -1502,6 +1505,7 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
>  #define FIXUP_INSN_LEN_MASK	GENMASK(7, 0)
>  #define FIXUP_REG_MASK		GENMASK(15, 8)
>  #define FIXUP_ARENA_REG_MASK	GENMASK(23, 16)
> +#define FIXUP_ARENA_WRITE	BIT(30)
>  #define FIXUP_ARENA_ACCESS	BIT(31)
>  #define DATA_ARENA_OFFSET_MASK	GENMASK(31, 16)
>  
> @@ -1510,7 +1514,7 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
>  	u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
>  	u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
>  	bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
> -	bool is_write = (reg == DONT_CLEAR);
> +	bool is_write = !!(x->fixup & FIXUP_ARENA_WRITE);
>  	unsigned long addr;
>  	s16 off;
>  	u32 arena_reg;
> @@ -2348,6 +2352,7 @@ st:			insn_off = insn->off;
>  				struct exception_table_entry *ex;
>  				u8 *_insn = image + proglen + (start_of_ldx - temp);
>  				u32 arena_reg, fixup_reg;
> +				bool is_write;
>  				s64 delta;
>  
>  				if (!bpf_prog->aux->extable)
> @@ -2384,15 +2389,29 @@ st:			insn_off = insn->off;
>  				    bpf_atomic_is_load_acq(insn)) {
>  					arena_reg = reg2pt_regs[src_reg];
>  					fixup_reg = reg2pt_regs[dst_reg];
> +					is_write = false;
>  				} else {
> +					/*
> +					 * A store has no destination register to clear,
> +					 * except for a read-modify-write with BPF_FETCH,
> +					 * which also reads the old value into src_reg, or
> +					 * into r0 for a BPF_CMPXCHG. Either way the access
> +					 * is still reported as a write.
> +					 */
> +					int load_reg = bpf_atomic_load_reg(insn);
> +
>  					arena_reg = reg2pt_regs[dst_reg];
> -					fixup_reg = DONT_CLEAR;
> +					fixup_reg = load_reg < 0 ? DONT_CLEAR :
> +						    reg2pt_regs[load_reg];
> +					is_write = true;
>  				}
>  
>  				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
>  					    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
>  					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
>  				ex->fixup |= FIXUP_ARENA_ACCESS;
> +				if (is_write)
> +					ex->fixup |= FIXUP_ARENA_WRITE;
>  
>  				ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
>  			}
> -- 
> 2.43.0

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
