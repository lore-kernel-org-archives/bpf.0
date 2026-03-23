Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D515539A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234201; cv=pass; b=GO+XRpCs38Eye6LsF9h6gwOcgCGZxt2WeJs1B+QzHiH/XkHbx4emTu1+Lwo9g0VDZZiSQypoPKyyjw+AoIYmoSnpDkJjmcVkL1xUL1pK/QX5sEFwBWVax93pNl3lYYJLfLl6RU7D9fvcIDavULkmmcteHb1M3mnJtQLYwDI39T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234201; c=relaxed/simple;
	bh=x0ISyjPLCeZpiGLOhskLwNwJkip8jLN7O2FliQuTpRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdPoImUD70Yn4AS04T4y+59Jbd1+4yQS6NuzJebXfuPNJ4fUrOUdR2aa08N/5ss3z+vpiP5EILlPtECbQjQwPhq/c31xg77mTWGEGBxrwKuh+bvsYp/8JPqjKwA/2egH1b+/ZfDKtxbKFcYvDnUL1U6OQk6TRB7xNMTd83RgCog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA165e8N; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA165e8N"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffbd778410so487029137.3
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 19:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774234198; cv=none;
        d=google.com; s=arc-20240605;
        b=kLZnfkUpdujOCwUVPJwOBMHoSYsvM4cZpkyoHLIMjPJEX5t4AgO3bonIGKnHrMnGt0
         OxZbVDe/ILlpY632xahSAWMq8H1ZjO1onXHyu8XWBbQfNPqtJ6Hter+6L8uEFHKlThzh
         rmlnq3BCf3PUYG4MOt4aSnpdl3qifxxr5b228hcuYNwL/aDWj1pt68ZtLaqpZmudrwkI
         //pfyJjCeJ4XNOjIg0hQ2rAIjqAG6Y1Lw2Sf2BfHba2W2oeHu+jGCTLs5OpReB3jVXkC
         E/rELhmC0AGwxEdqzG1S8xsXksSREDa8NCh6TE7qQVbFXAtpuK8SmQZIF+vyPPXEbTza
         mCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z7qQJIY/xjHf5AErIilQMTSfpkOEgMW7reRqdEbyE1U=;
        fh=ijcH8JujWgne9Lue4sQmbRCe4FTiUWsYZnGDmDhZIzc=;
        b=AbxKRdoTyTfoyyFmj3naInkK4+y84SgUZrUhdEXzATWK5WPha5PIdzytns4uUKZ+ZT
         wFDr3loydVe7kH9XQPXfY3KhO3L/a271gnxZhoN8Ci11JJVGsvm3IjGQUl4dwQ8Ky+E2
         Akzo+77TeV1wmH8QhluY4wNbPU71V2T51NZ0V/nIXFj6K0lMSe331eWLa6aqW19G8/eB
         Iv2luMOguhAv6UY3Vj24wjldtSPlMocwNKhUBpIaRI1wNAC2tk+aAYDIhtA0bMGGQfMq
         nEuQh+YzTByqQaeA5UI8/0OwEuoPO8Ulk8/Sz1mm/Elgcr60se/lBu97/nuyBesacC/h
         d2sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774234198; x=1774838998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7qQJIY/xjHf5AErIilQMTSfpkOEgMW7reRqdEbyE1U=;
        b=EA165e8NAeZhGufcnGyRN24eZcaZqbeF0TMSfKKrkhDWWDvj5USktH2wY0hjLYM94g
         u44CRICYv3vAZVTlxBZND0PFiocnEvkFNiyZnTVbWcgsVpFBbUSk5cdUbz4UDv9SU3e2
         3DeLCt13E3ZwxHXQ/GTFttWyU3atWLvn2TAzenDMcOntOTG/3SnAb69WDDGbehOquftD
         CRUO0ojdZ7C5FqJ5ownqaTneVl+NvE+k2bdPKOcU0VYy8ZKWZEeSJE06cp/Wav1be/Wa
         twQVW3L5f+W3dQvwu7bdYI9t3JE9295tcqjmHW5llUFERQ8hX8i1cu4tbVSbEhJkO1sW
         Jgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774234198; x=1774838998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7qQJIY/xjHf5AErIilQMTSfpkOEgMW7reRqdEbyE1U=;
        b=iTJhiBl5nFSIb79uDhtY9TE22n4JV4017zBM/80p2oY4SkDLZV3c5KRk43O53ke8b/
         Nmf1/nyWUXMG28uoHLppLgM/GLLI1sgUjGdS2/e+uTdj4Za29011awWV3rgAGvAbCiWo
         puYbIPKkDWqpTZFlx1o1+QTWrcd9SolmUpdBAtDqMOGaz39zkLVuE2oc+Dqw7SMemLji
         9gE/2X2ax5fpjQ7kJztGb6vEEiH373d06EcZwhLEl3AcnpYM6p59/pupSTSQkmkiRvGR
         6/qkNoQ9ehnPpQxyzBbPV3Ii2wCpg9KUXF/kzhDAMaxxFu1rlo3wiYIquw1nCaU1bLst
         /8IA==
X-Gm-Message-State: AOJu0YwuG6TyvkQdPsx2Y1nlGGlYSlvbPhxxMHA+7iJdL4PBpdwDoqrI
	BJpKK7krBbpynMRBrYceXZU/R/Y4s7IPhc8SGi7xWIxd1BGYzppgholl5ECr56q0FL58erCKym1
	gZzFGcveAg/9JMroI1S5GqJ+bqpPloiQ=
X-Gm-Gg: ATEYQzzIWLmGGM1i487/Fm2aFTSYY0LiGikirR35KYUzwPZUiu75FN4wTUh5T7Gjp+p
	MJtL0PR3wDpAQIQytWZve23sl+zXg7kTSu35y+o/0d0nI8O2MO/zWob7Cx01vwKwi8oJThKgHY0
	xSRabR1yHu4WEcFXsOwd8vPOGo6Ie8JAxk4dxQvCErBcwKyfRKqdzdd9JPBqrk/8TXfm71S5+qz
	ArUSL9z+1GbYxVzwcuC3fkztK6Ym4Gzh5OvbvXIZMrAeBhFi4/g3Db7drQCREbUvzZVlEc02/dn
	qTKmFhmulIRTaMi8PZLFBtut6QoEaIflLljC8dqo+A==
X-Received: by 2002:a05:6102:605b:b0:5f5:4055:4558 with SMTP id
 ada2fe7eead31-602aeac9405mr4164964137.2.1774234197820; Sun, 22 Mar 2026
 19:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320162336.166542-1-hao.sun@inf.ethz.ch>
In-Reply-To: <20260320162336.166542-1-hao.sun@inf.ethz.ch>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Sun, 22 Mar 2026 22:49:41 -0400
X-Gm-Features: AQROBzCsdoDxk1cQDMCdUs9zRj_AWwhuRMMgamarTmloHkbtGsVx3Fq3Rvhw1WM
Message-ID: <CAM=Ch05YV_8wJ9_eG6c1XU3m3RDr3JZz5=SPYuCs0p-J9zT62Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Simplify tnum_step()
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, paul.chaignon@gmail.com, 
	shung-hsi.yu@suse.com, john.fastabend@gmail.com, martin.lau@linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 12:23=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wrot=
e:

Thanks for the patch. This is a neat simplification to make the algorithm b=
ecome
straight line. I really liked the idea of working with d =3D z - tmin,
instead of the original
where we were working with j.  The core idea of adding 1 to
masked bits with fixed bits in place seems the same.

I checked this new algorithm for soundness in z3 using bitvector
theory, and it is
indeed sound and equivalent to the old algorithm.

Some comments below, mainly regarding explanation and maintainability.

> Simplify tnum_step() from a 10-variable algorithm into a straight
> line sequence of bitwise operations.

The original algorithm was purposefully verbose for the sake of
explanation. I feel it is better
use temporaries that explain relatively complex ideas. The compiler
will optimize
the subexpressions anyway.

> Problem Reduction:
>
> tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask =3D=3D 0`,
> and a value `z` with `tval =E2=89=A4 z < (tval | tmask)`, find the smalle=
st
> `r > z`, a tnum-satisfying value, i.e., `r & ~tmask =3D=3D tval`.
>
> Every tnum-satisfying value has the form tval | s where s is a subset
> of tmask bits (s & ~tmask =3D=3D 0).  Since tval and tmask are disjoint:
>
>     tval | s  =3D  tval + s

I'd start with explaining what "subset of tmask" means and perhaps
define it as "submask"
early on. Currently, the term submask isn't explained anywhere but used in
the code comments.

Also, "disjoint" can be unclear to the reader. I'd explicity state
that tval and tmask can never
share 1 in the same bit position.

We should either call it "s" or "inc" everywhere.

> Similarly z =3D tval + d where d =3D z - tval, so r > z becomes:
>
>     tval + s  >  tval + d
>     s > d
>
> The problem reduces to: find the smallest s, a subset of tmask, such
> that s > d.
>
> Notice that `s` must be a subset of tmask, the problem now is simplified.

To be precise regarding minimality: we have to find a submask of t that
is minimally greater than d.

> Algorithm:
>
> The mask bits of `d` form a "counter" that we want to increment by one,
> but the counter has gaps at the fixed-bit positions.  A normal +1 would
> stop at the first 0-bit it meets; we need it to skip over fixed-bit
> gaps and land on the next mask bit.

I think it will be useful to illustrate right away with an example to
make it easier
to follow.

This part of the algorithm shares its idea with the previous algorithm
and a lot of the
previous commit message explained the reasoning for doing what we are
doing, but that
explanation has been dropped.

You are first trying to identify the highest bit position k which is 1
in d, and known/fixed
in t. This is important because when constructing s (or inc), setting
to 1 any masked bit
lower than k will not result in a number > d. Only positions > k are
candidates for
being set to 1. For example

z =3D 1010100100
t =3D 10xx0x1xx1
d =3D 0010011011
          ^
          k

Borrowing wording from the previous commit: We must set masked
positions of significance
higher than k. Specifically, we look for the next larger combination
of 1s to place in
the masked positions, relative to the combination that exists in d. We
can achieve this
by concatenating bits at unknown positions of t into an integer,
adding 1, and writing
the bits of that result back into the corresponding bit positions
previously extracted
from d.

An example like in the previous commit might also help:

t =3D 10xx0x
d =3D ..10.1
+        1
----------
    ..11.0

> Step 1 -- plug the gaps:
>
>     d | carry_mask | ~tmask
>
>   - ~tmask fills all fixed-bit positions with 1.
>   - carry_mask =3D (1 << fls64(d & ~tmask)) - 1 fills all positions
>     (including mask positions) below the highest non-mask bit of d.
>
> After this, the only remaining 0s are mask bits above the highest
> non-mask bit of d where d is also 0 -- exactly the positions where
> the carry can validly land.
>
> Step 2 -- increment:
>
>     (d | carry_mask | ~tmask) + 1
>
> Adding 1 flips all trailing 1s to 0 and sets the first 0 to 1.  Since
> every gap has been plugged, that first 0 is guaranteed to be a mask bit
> above all non-mask bits of d.
>
> Step 3 -- mask:
>
>     ((d | carry_mask | ~tmask) + 1) & tmask
>
> Strip the scaffolding, keeping only mask bits.  Call the result inc.
>
> Step 4 -- result:
>
>     tval | inc
>
> Reattach the fixed bits.
>
> A simple 8-bit example:

What are z and tval here in this example? It would be helpful to provide th=
em.

>     tmask:        1  1  0  1  0  1  1  0
>     d:            1  0  1  0  0  0  1  0     (d =3D 162)
>                         ^
>                         non-mask 1 at bit 5
>
> With carry_mask =3D 0b00111111 (smeared from bit 5):
>
>     d|carry|~tm   1  0  1  1  1  1  1  1
>     + 1           1  1  0  0  0  0  0  0
>     & tmask       1  1  0  0  0  0  0  0
>
> The patch passes my local test: test_verifier, test_progs for
> `-t verifier` and `-t reg_bounds`.
>
> CBMC shows the new code is equiv to original one[1], and
> a lean4 proof of correctness is available[2]:
>
> theorem tnumStep_correct (tval tmask z : BitVec 64)
>     -- Precondition: valid tnum and input z
>     (h_consistent : (tval &&& tmask) =3D 0)
>     (h_lo : tval =E2=89=A4 z)
>     (h_hi : z < (tval ||| tmask)) :
>     -- Postcondition: r must be:
>     --    (1) tnum member
>     --    (2) z < r
>     --    (3) for any other member w > z, r <=3D w
>     let r :=3D tnumStep tval tmask z
>     satisfiesTnum64 r tval tmask =E2=88=A7
>     tval =E2=89=A4 r =E2=88=A7 r =E2=89=A4 (tval ||| tmask) =E2=88=A7
>     z < r =E2=88=A7
>     =E2=88=80 w, satisfiesTnum64 w tval tmask =E2=86=92 z < w =E2=86=92 r=
 =E2=89=A4 w :=3D by
>   -- unfold definition
>   unfold tnumStep satisfiesTnum64
>   simp only []
>   refine =E2=9F=A8?_, ?_, ?_, ?_, ?_=E2=9F=A9
>   -- the solver proves each conjunct
>   =C2=B7 bv_decide
>   =C2=B7 bv_decide
>   =C2=B7 bv_decide
>   =C2=B7 bv_decide
>   =C2=B7 intro w hw1 hw2; bv_decide
>
> [1] https://github.com/eddyz87/tnum-step-verif/blob/master/main.c
> [2] https://pastebin.com/raw/czHKiyY0
>
> Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Reviewed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

> ---
> v1 -> v2: inline proof, add code comments, add a variable `filled`.
>
>  kernel/bpf/tnum.c | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 4abc359b3db0..ec9c310cf5d7 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -286,8 +286,7 @@ struct tnum tnum_bswap64(struct tnum a)
>   */
>  u64 tnum_step(struct tnum t, u64 z)
>  {
> -       u64 tmax, j, p, q, r, s, v, u, w, res;
> -       u8 k;
> +       u64 tmax, d, carry_mask, filled, inc;
>
>         tmax =3D t.value | t.mask;
>
> @@ -299,29 +298,22 @@ u64 tnum_step(struct tnum t, u64 z)
>         if (z < t.value)
>                 return t.value;
>
> -       /* keep t's known bits, and match all unknown bits to z */
> -       j =3D t.value | (z & t.mask);
> -
> -       if (j > z) {
> -               p =3D ~z & t.value & ~t.mask;
> -               k =3D fls64(p); /* k is the most-significant 0-to-1 flip =
*/
> -               q =3D U64_MAX << k;
> -               r =3D q & z; /* positions > k matched to z */
> -               s =3D ~q & t.value; /* positions <=3D k matched to t.valu=
e */
> -               v =3D r | s;
> -               res =3D v;
> -       } else {
> -               p =3D z & ~t.value & ~t.mask;
> -               k =3D fls64(p); /* k is the most-significant 1-to-0 flip =
*/
> -               q =3D U64_MAX << k;
> -               r =3D q & t.mask & z; /* unknown positions > k, matched t=
o z */
> -               s =3D q & ~t.mask; /* known positions > k, set to 1 */
> -               v =3D r | s;
> -               /* add 1 to unknown positions > k to make value greater t=
han z */
> -               u =3D v + (1ULL << k);
> -               /* extract bits in unknown positions > k from u, rest fro=
m t.value */
> -               w =3D (u & t.mask) | t.value;
> -               res =3D w;
> -       }
> -       return res;
> +       /*
> +        * Let r be the result tnum member, z =3D t.value + d.
> +        * Every tnum member is t.value | s for some submask s of t.mask,
> +        * and since t.value & t.mask =3D=3D 0, t.value | s =3D=3D t.valu=
e + s.
> +        * So r > z becomes s > d where d =3D z - t.value.
> +        *
> +        * Find the smallest submask s of t.mask greater than d by
> +        * "incrementing d within the mask": fill every non-mask
> +        * position with 1 (`filled`) so +1 ripples through the gaps,
> +        * then keep only mask bits. `carry_mask` additionally fills
> +        * positions below the highest non-mask 1 in d, preventing
> +        * it from trapping the carry.
> +        */
> +       d =3D z - t.value;
> +       carry_mask =3D (1ULL << fls64(d & ~t.mask)) - 1;
> +       filled =3D d | carry_mask | ~t.mask;
> +       inc =3D (filled + 1) & t.mask;
> +       return t.value | inc;
>  }
> --
> 2.34.1
>
