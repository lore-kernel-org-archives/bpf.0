Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389E43B4B6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537106; cv=pass; b=ediDNdtKk36YxeIECb52Ne0WLC6ZrjHmQ6dldcSbxpWBey8mnR1KCbiEpDRIyR2AbGiNf91RpAPF6Md6yyi5FGdzYQPRZAn+ql71DoXSJlqgzvMpmVR0ykEJrwG/MwYOHT1AOsOIFYn1wC9deeePZ5gkrRQjQrgM/R2qN7aRJlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537106; c=relaxed/simple;
	bh=Ucbh7feqO9tBYQURvOJaE1VnWwkVpKZgD62/TIZIVMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1PMIvouY9mjjtfZNxStq0r71V2HgJGQXS9EbB6awat9hqgqja/W3U4tBYu2PpzE+pDc1eout4oQEzDgN2J9VvKeqFPsFIHYnq6JafA5a97mgUJfvyRomssThMESErDeI02Y5xpafng4vIULqiac1746a7SJelYQg9YUF7MQJyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf3Wtq5C; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf3Wtq5C"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f758014b8so67762566b.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 05:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786537102; cv=none;
        d=google.com; s=arc-20260327;
        b=UZ+2IVf35MtY1yuJ5ch3NUcF0XXBOYhhfreyiP5XnUQhVQp9RbzIKwmxglmtdRxP5Y
         Vqsr5fGD+SW21pn7HvJVWhL/zrSkClFb8seUU+8oR8eGXbw2dI10LqTfGvcsl+yEqubj
         fPil8sHdqwpy2cxHzhzJoI3EDbV2SjDUSuE8fnDI2WZqWd01v8w/x+eB4+sZDV65XGCb
         z/LZhdjwAJKqsft0Tm3NyWgAGFXqywMjLZBpdH4Rc0K9U+3OMt6ARnajkNhGzL4vR61U
         bLx+HQZL8F2zqyd8q5w+wv741lY2CnNJdXohz64kaNJClZfVBH4V6n5TtuVlgEl2YMVz
         aFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JaXNom14mQzrN0edwAHx0e++DK52RVpAn1AQzdy5/90=;
        fh=kCSSO/6G9VJwcHyHoQMnlPG3uw+QHgxJqGMGI6kxY/4=;
        b=dVPx3yYmow0wJnjhQ+ExiMzhjumLCcPDrvhnNXxb//fisZTlFRILYYJP2sDmA6/WdD
         wPLW2irUMsb7SiDn/hKOtO1AtH2sVz4GJtp2SCGyXYy6+UljnIpXDeaipRckqRtoVDwW
         EkCqFbTD5W6ca7ncE0OtO7RJ5sDwtQKCUJN6H0mzQ7YKDTwLUXlstQ65l6UDL69sLclg
         86z5dEdX3myL2wSLSK3skg9msHF92slq4NVPQlo/uTt/xBGffKkQvAmrVqNwUVOWXW29
         Rqv79m8Q68YTNp8cWrkxL0j+trjsBeMexZS2MVWuF2uObSvqMRbrTRZ/aXkbSVMpJg1j
         ZidQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537102; x=1787141902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JaXNom14mQzrN0edwAHx0e++DK52RVpAn1AQzdy5/90=;
        b=Zf3Wtq5Cs8ZEPjV5fRi1NApKK57QzMCTBhXphmmD08kQt/bxjGlKPbMgE7PdO7KRGF
         hdycbFsbx0bpSxOngI5/Qn5O9OE4O3sOjF2TwBfmW8hpVJBIyziok/Ox5+glU/FqcznZ
         i3mPl/S1998dVVBfn3+1J5p/PcBZIEl2I+11xFGI2kiwzzO42GP774FlT3Rf6s1O5iYi
         I1fXp19gJiJEj8FPZSMKEls4ZpaPn9Z+Jz9GlR1YokG25rrHnMBlIzh2PYFV2rB70ZRz
         iAnDr80fNr/W9ZwD8CdCGmYLr8jGFBwAVhAM5xLUDfyrHhcxpHKg6jYLo7hE8x7p7ghV
         ZWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537102; x=1787141902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaXNom14mQzrN0edwAHx0e++DK52RVpAn1AQzdy5/90=;
        b=lvzaFvr+MVsCvBFmLl3zac1gMJnGOEb76e4RKYDMx4obcmnaMp9SC79Auv5D5YnGkE
         whcfRYCXmcWYOLq55jWTdseaMi4kOMGXg8y4fMJ3GoqQNuyyGs5cxNi+xkm5rm34+Pg3
         0yWZqLIHeKNkhLWDbsQde8Dj18MmRgdj3VtsotXqJmqcORf/K3PA9esxfXEvlH9e7rzT
         XGGnpSB1ke6yfwAyvT34yQ0ZvIOcSrXg83U1VgntYk8d1D+KuWZ9I68Vatcjd956iaYf
         NGOn1C5JNl2/mGrvHHQavD/uD5nnIhBzHsDfsZCEmBtdrZqdgDmF41mWTzMyoPxgLvew
         /EOw==
X-Forwarded-Encrypted: i=1; AHgh+RrReDTJd8E38+wxOCBDWMKOIrhEG+KkgU+JpgnJrxbw2KMv5BqDYHXKp0/ONbYRNRh3reo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwoPx4K5Du4IJm++awILgowLinCNB/+RZhcNedaeeFiwyrEcv
	K9B8VB7arsHp4Gbot31A+XsGQNIPazCQ0nqatAK65piC+q4VY6aLpxF3/DaFi8b055nF8LOsPbz
	GpNnXhFzYuRnscISJ49/FQwFm19QVywMsBqAR/My/qQ==
X-Gm-Gg: AR+sD12ikOqO3rKK5Le56opkgasiNnsT+kRydaEOlC6kVPohBZrIpW6XKAx43xbzI2H
	7lhRJGMWxVuEgkZHl9ihA3uEu71YlYolzHnxmFgTYoJ0oEMKF2AAZmxbUDMs7qWj8TEFrTcld98
	MdFuPGWsSbA5R3PGjtueC0kTn1bgpQZlaDXo2J24tuxc5xsNh051HN8BO3XOWOqgFjCVcBTx1bu
	AGqKDiiWhzzwploVulCjnzWmXorZ2YlvI2PC8FvjiSX7H2LMtPXH1qqlRg22ZGNHQQjWGbsQ1YM
	sPtYmX7Znh3ap7qHHwMgB15ZhCNxYggk8tchIOiLpLc5SLCHkoYsAdTuQn65
X-Received: by 2002:a17:907:80c:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c20f2fa0f37mr224948066b.18.1786537102209; Wed, 12 Aug 2026
 05:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811131600.506721-1-daniel@iogearbox.net> <20260811131600.506721-4-daniel@iogearbox.net>
In-Reply-To: <20260811131600.506721-4-daniel@iogearbox.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 12 Aug 2026 13:18:07 +0100
X-Gm-Features: AUfX_mzYk68PKq8i_5htNe96LzLz1vjjEW6mnMsaXAGaTXG_ftkCWTLka4gaaek
Message-ID: <CANk7y0hhfK+eeD7eWd_HKwcGN1nD2SSU6tSU5pTGpUd_1Tp0dQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf, arm64: Clear fetch destination on
 faulting arena atomic
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, eddyz87@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:16=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Same problem as on x86-64: add_exception_handler() folds "there is no
> destination register to clear" and "this is a store" into one DONT_CLEAR
> value ...
>
>   if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(insn)=
)
>           dst_reg =3D DONT_CLEAR;
>
> ... which ex_handler_bpf() then reads back as the access direction:
>
>   bool is_write =3D (dst_reg =3D=3D DONT_CLEAR);
>
> A RMW carrying BPF_FETCH is both. emit_lse_atomic() reads the old value
> into src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and into
> r0 for BPF_CMPXCHG, so a fault over an unmapped arena page is correctly
> reported as a WRITE but leaves that register holding a stale value instea=
d
> of the 0 that every other BPF_PROBE_* access delivers. Same as on x86-64,
> add a separate ARENA_WRITE bit for the direction.
>
> FIXUP_REG is now filled in by the callers of add_exception_handler(), the
> BPF_PROBE_ATOMIC one deriving it from bpf_atomic_load_reg(), so that the
> helper only has to determine the direction. This is how the riscv64 JIT
> already does it, and it stops the two store callers from handing in a
> dst_reg that was only going to be overwritten with DONT_CLEAR anyway.
>
> Fixes: e612b5c1d3ee ("bpf, arm64: Add support for lse atomics in bpf_aren=
a")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> ---
>  v1 -> v2:
>    - move bpf_atomic_load_reg into build_insn (Eduard)
>
>  arch/arm64/net/bpf_jit_comp.c | 44 ++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index d14d297ebb96..74b4083791da 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1082,23 +1082,27 @@ static void build_epilogue(struct jit_ctx *ctx, b=
ool was_classic)
>   *
>   * Bit layout of `fixup` (32-bit):
>   *
> - * +-----------+--------+-----------+-----------+----------+
> - * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
> - * |           |        |           |           |          |
> - * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
> - * +-----------+--------+-----------+-----------+----------+
> + * +-----------+--------+-------------+-----------+-----------+---------=
-+
> + * |   31-27   | 26-23  |      22     |     21    |   20-16   |   15-0  =
 |
> + * |           |        |             |           |           |         =
 |
> + * | FIXUP_REG | Unused | ARENA_WRITE | ARENA_ACC | ARENA_REG |  OFFSET =
 |
> + * +-----------+--------+-------------+-----------+-----------+---------=
-+
>   *
>   * - OFFSET (16 bits): Offset used to compute address for Load/Store ins=
truction.
>   * - ARENA_REG (5 bits): Register that is used to calculate the address =
for load/store when
>   *                       accessing the arena region.
>   * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction=
 accessed the arena region.
> + * - ARENA_WRITE (1 bit): This bit is set when the faulting instruction =
wrote to the arena region.
> + *                        It is independent of FIXUP_REG, since a read-m=
odify-write both writes to
> + *                        memory and reads the old value into a register=
.
>   * - FIXUP_REG (5 bits): Destination register for the load instruction (=
cleared on fault) or set to
> - *                       DONT_CLEAR if it is a store instruction.
> + *                       DONT_CLEAR if the instruction does not read int=
o a register.
>   */
>
>  #define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
>  #define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
>  #define BPF_ARENA_ACCESS           BIT(21)
> +#define BPF_ARENA_WRITE            BIT(22)
>  #define BPF_FIXUP_REG_MASK     GENMASK(31, 27)
>  #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
>
> @@ -1109,7 +1113,7 @@ bool ex_handler_bpf(const struct exception_table_en=
try *ex,
>         s16 off =3D FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>         int arena_reg =3D FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
>         bool is_arena =3D !!(ex->fixup & BPF_ARENA_ACCESS);
> -       bool is_write =3D (dst_reg =3D=3D DONT_CLEAR);
> +       bool is_write =3D !!(ex->fixup & BPF_ARENA_WRITE);
>         unsigned long addr;
>
>         if (is_arena) {
> @@ -1132,7 +1136,7 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>  {
>         off_t ins_offset;
>         s16 off =3D insn->off;
> -       bool is_arena;
> +       bool is_arena, is_write;
>         int arena_reg;
>         unsigned long pc;
>         struct exception_table_entry *ex;
> @@ -1181,15 +1185,18 @@ static int add_exception_handler(const struct bpf=
_insn *insn,
>         /*
>          * A load-acquire is of BPF_STX class, but reads from src_reg int=
o
>          * dst_reg like a BPF_LDX does, hence it must not be treated as a=
 store
> -        * here.
> +        * here. A read-modify-write carrying BPF_FETCH is reported as a =
write
> +        * even though it does have a register to clear, see the callers.
>          */
> -       if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq=
(insn))
> -               dst_reg =3D DONT_CLEAR;
> +       is_write =3D BPF_CLASS(insn->code) !=3D BPF_LDX &&
> +                  !bpf_atomic_is_load_acq(insn);
>
>         ex->fixup =3D FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>
>         if (is_arena) {
>                 ex->fixup |=3D BPF_ARENA_ACCESS;
> +               if (is_write)
> +                       ex->fixup |=3D BPF_ARENA_WRITE;
>                 /*
>                  * insn->src_reg/dst_reg holds the address in the arena r=
egion with upper 32-bits
>                  * being zero because of a preceding addr_space_cast(r<n>=
, 0x0, 0x1) instruction.
> @@ -1889,7 +1896,7 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
>                         break;
>                 }
>
> -               ret =3D add_exception_handler(insn, ctx, dst);
> +               ret =3D add_exception_handler(insn, ctx, DONT_CLEAR);
>                 if (ret)
>                         return ret;
>                 break;
> @@ -1956,7 +1963,7 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
>                         break;
>                 }
>
> -               ret =3D add_exception_handler(insn, ctx, dst);
> +               ret =3D add_exception_handler(insn, ctx, DONT_CLEAR);
>                 if (ret)
>                         return ret;
>                 break;
> @@ -1979,7 +1986,16 @@ static int build_insn(const struct bpf_verifier_en=
v *env, const struct bpf_insn
>                         return ret;
>
>                 if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC) {
> -                       ret =3D add_exception_handler(insn, ctx, dst);
> +                       /*
> +                        * A load-acquire reads into dst_reg, and a read-=
modify-write
> +                        * carrying BPF_FETCH reads the old value into sr=
c_reg, or into
> +                        * r0 for a BPF_CMPXCHG. Clear that register on f=
ault, the
> +                        * remaining atomics have no destination register=
.
> +                        */
> +                       int load_reg =3D bpf_atomic_load_reg(insn);
> +
> +                       ret =3D add_exception_handler(insn, ctx, load_reg=
 < 0 ?
> +                                                   DONT_CLEAR : bpf2a64[=
load_reg]);
>                         if (ret)
>                                 return ret;
>                 }
> --
> 2.43.0
>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
