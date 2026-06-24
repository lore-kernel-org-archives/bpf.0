Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D893DD516
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322750; cv=pass; b=eOmNO9g+bp0KXEeuK0w/N+y+z4u/fM3E/TvRnvR0ifUYwHR++BPyUBiKV8Pn63Pd2u3vqSvgBUU3zMLbUEZ4hSeKOStWwYypN4qh6bHLsEmsr0HXmYnbGrl85PUEeQUFdeH+hoQ9MHkjToyuAxprh9Jh3hiQuwRPbTwHamnXD6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322750; c=relaxed/simple;
	bh=kwlxJfc06DoM2YGHAFfTB131HftcWrPWROTz4nYANrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGUU3L011aC8g3qZaVujACR9k/sBkAj3v18zsUosNaFMeulCHQuTygU+Ik+YyxZ6urtT+VhSCMylcrh8MdyA822EKj6Gz4n2VcRJm6pd8uxhP0hCmOVk7WFZzf8BCH9fBzll/x6gpp4i/ngRX4fZjFcvngh4p0ksD2yKowU+MZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DywN9WWS; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DywN9WWS"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59ccf81e74bso513162e0c.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782322747; cv=none;
        d=google.com; s=arc-20240605;
        b=ANq+rXcnBJB2vsIh71+nypUIFuC6hEQQMOv08BGQ9a37q4I/W+Oh8MUyb6Cn3yrf3n
         O9iKUaDZMe58bpWr13lI/hxn4wbt8GTLvHAtEIxLknZf4/7dUnxEu8x4McfYB54u2wzL
         JryxNOxWeQjhLR7tlVNP7oA6hVvXfgFAdYOoO7Pzsxu2jdknUMbkLcJjYVHCwJDUoRzb
         H3+z1dsRVZhlzFj1y6H+0Aca5l55o4uIutvaDvagbHZ5/dEvLDU7tP7iW5x6RW8mjRH0
         Hiy0cqpRQhptd9WzBvwG8VxlEV0BQosZvu70iPuREQJSmv3qWsRYhEDlWXSgnCeVcF+Y
         00yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZ50S9EWe03a9OjAtFp4LAKWjUA195rU05MVKuNQvgU=;
        fh=v1rW0cNYkd3xXDNsvnhjYG2iGeqY6TIhoFka300Kbh4=;
        b=cBz74TTbxTIk2eIIgsyJlD7715bPbnJVhWqHWNU8NjqHPMFnLfSGdOm7JgAiJUmOlA
         5MbcEIyaPGJBrxWXvwwdC6QqI2MJAIbRcAZo5rRDWf7ksOcJSvfT6LtFAUlz/i0+GVki
         ZlJtbcdApLoAOIgesvgRvEypkXB0AV6HIbHltTIXSWzLW6ULurl7QAdSoLuzX3gRokj8
         XaeFi8q9xEkHmrqFYhcIjc/EYrQSNN6cCpSpWxQKegnJIYzoKiUnxxvPWuxr0m7KP6Kd
         gdoeuqSsk/YvgvFqo/o4PNlU0UX4+Ss4cCzS32DNelz20WGy9Fkub1RJqNIMxg6BYhe2
         VxCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782322747; x=1782927547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ50S9EWe03a9OjAtFp4LAKWjUA195rU05MVKuNQvgU=;
        b=DywN9WWSBDi5f/syse6BIJ1fxp3KlHFm4pKjtIZW0cb9u+yBnKRusSCGlKY9qNF22x
         MsFC95oDnadyGZPeX1rwbZtXY10Q3TF4Jy0QKgL3cfmLIYbvcAT+LW+h1SiO0hulyJDf
         S4DBzDc5itrIC88evtsB8bDVIflBG3eHpSj6PhfTp9idf/5ZDKSFQNDj2LVVKuP0yrVZ
         6i5PZCI/hwnw6XUfztRekhsHHenCPQt2uxrsSAN+Oqu6d9aIRa8s+6GSvzdoHoRh7qNj
         ub1+WfYbdh1pY3DIYd0l6x5O8LgQNzH9VZXiQiVn+qSj697WY+f912s0QN52m5E9A9DE
         nYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782322747; x=1782927547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZ50S9EWe03a9OjAtFp4LAKWjUA195rU05MVKuNQvgU=;
        b=jUJP/LJkVp+Xtn0KI76hSjDWgGfAUZe5UkhzlXGcbZty9CfDBNQr2vykP0MVZjJ9dE
         x+ef6H3R7bpt5onfsVLvkLH20GUfYIm+0dKGoPmbJ1769Mrknsx1bB/m8Ijd4O80lDNE
         P7MmCXuBiHnyww5NTTUfwuKYNZmdJzdCVxTQfy+vHJ/yCxzXu9QSNfPXFqJKhxl2UMSc
         DEWlOoTJDgX2+ST14S0jDUh6Y0mfujH/aQpNl4xl/1F3UwtqgW5LV5dmWhOSKWDYlDNV
         NyhutlUuc1vNLu+z0gAkzwY3VY5bsgpxsLPK7Au/vOPjKohmdem0T1M8Wbur6i3xMorS
         xlxA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0i98jx0WyLxvMn28eDBkugG1CQ6dzRw3R/UVFMnIjUabyxImEsU+lTmDScHeu4Rg5oD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdjmVcD/HIVq4AIkv9JOteF+1lcswZBi6D9sT1czauj3Lh99M
	QlcaEJ7WRqZSS5XUc2Z4axj8xaLLaMVYRSfp73D6a59AHBlEaudHnFeR9yZ4rbmwapbfCWH9+rH
	F6/u1NK1IGweifsuVqLvGkgTTElgwiFkBW5CHd+o=
X-Gm-Gg: AfdE7cnL+y9AxfFyNVtX8rs/eWkiK3Gx+IkdnUXq3f4xQaojugy6SWmfH5T/CbA9pSE
	2Z9UiNL5zN/0JO6eJXxFVDbT6U7ZJGSpAaWaJJ+DXsZlamxxTnQcrDsEVpVDk+nXtSXS7oHi7Lq
	Wm0tTC6fHW8/eS7G8yunNnwD3W+fuyEusF01ULzakROlumOSSpDdzAiHEiICupJLJbe/0ZUt71T
	xmHAl6iryoT4UHesrTr/YQK7YilbF1N+035qJSQtx3qC8cydS3ToG/VhWU7YHtmGedvqJNwXeFd
	kykW59o45KB2y9mpRK9WlUBpoxgUj9rTY/ZENATs6bv29q00qBHKXVe4a8FTQpyekyHSAQ==
X-Received: by 2002:a05:6102:3746:b0:6c5:d55d:c095 with SMTP id
 ada2fe7eead31-72fd81606bcmr5073940137.26.1782322747359; Wed, 24 Jun 2026
 10:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178004391665.3522.4865582628003357086@gmail.com> <DIVM9YXYJV5N.2TEM951JWKD95@gmail.com>
In-Reply-To: <DIVM9YXYJV5N.2TEM951JWKD95@gmail.com>
From: L0 <hyeon3125@gmail.com>
Date: Thu, 25 Jun 2026 02:38:56 +0900
X-Gm-Features: AVVi8CeqJD4TC_z7LGXIn576_IwTjNKdkby4r6WV8YMQhh6RbUhiuOFOGSqIshM
Message-ID: <CACvzRyD2ScyBt-6eS2FoWPRN5o1ZK-4RYruKY0k7QTSuohzbzA@mail.gmail.com>
Subject: Re: [PATCH RFC] bpf: add DAG fast-path in verifier to skip redundant
 state pruning
To: ast@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, paul.chaignon@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexei,

I know you're deep in the review backlog and the prototype share is still
pending. Rather than waiting, I'm sending this ahead -- apologies for
jumping the queue.

You said the DAG specialization isn't interesting (fair -- loops are
everywhere now), but that do_check_insn() as a transfer function in the
dataflow analysis is viable, and that merge_verifier_state() is the key.
I agree it's the key, and it's where I started -- one level down. A join is
only as sound as the domain it operates on, so before the join itself I
pinned down that domain: the scalar state merge_verifier_state() combines,
tnum x cnum, as it stands in bpf-next (a975094bf).

I built a small, self-contained Rust model of it -- the tnum bit domain
(tnum.c), the cnum circular-number range domain (cnum.c / cnum_defs.h), and
the reduced-product reduction in reg_bounds_sync(). Three results, all
machine-checked (10 harnesses, Kani 0.67.0 / CBMC):

1. Soundness. Each harness states the abstraction is sound -- for every
concrete x in gamma(a) and y in gamma(b), f(x,y) lies in gamma(f#(a,b))
-- and Kani discharges it over the full bit-vector input space (not
sampled). Covered: tnum add/sub/and/or/xor, tnum_in, the cnum subset
order, and cnum64_cnum32_intersect.

2. Faithfulness. The differential test links the *unmodified* kernel
tnum.c + cnum.c against userspace stub headers (the .c is byte-for-byte
bpf-next, no kernel build needed) and fuzzes them against the Rust model,
N=3D2000 x 11 ops, 0 mismatch. So (1) carries over to the C, not just the
model.

3. A question this raised (for Eduard/Paul as much as anyone). On the model
Kani proves the cross-width reduction idempotent -- one __reg_deduce_bounds=
()
pass reaches the fixpoint over all inputs -- which surprised me, since
9e5fcb003aec ("bpf: Avoid one round of bounds deduction") established two
rounds as the minimum, with verifier_bounds/"cross sign boundary, negative
overlap" failing at one.

But that analysis predates the circular-number refactor (256f0071f9b6),
which collapsed the four deduce sub-steps into two. So the honest question:
did cnum make the second __reg_deduce_bounds() in reg_bounds_sync()
(verifier.c:2082) redundant, or does the cross-sign case still rely on it
and my isolated model simply misses that state? I haven't built the tree to
run that selftest at one call yet -- curious whether the round count was
revisited after cnum landed.

Scope, honestly: this is only the scalar tnum/cnum transfer and reduction
math, not the whole verifier, and I'm not claiming any over-conservative
(false-reject) bug -- none turned up here. The security boundary
(regsafe/stacksafe) stays in the kernel; this is a verification model, the
PCC split we talked about -- a checker that produces a proof, not a
replacement for the kernel's check.

Everything is in one ~600-line crate and reproduces from scratch with a
single script -- ./reproduce.sh runs the 11 unit tests, the differential,
and all 10 Kani proofs:

https://github.com/hyeon3125-dev/bpf-verifier-rs (against bpf-next a975094b=
f)

so you can re-run the soundness checks and the diff against C directly,
rather than taking my word for any of it.

And when you share the transfer + join prototype, the part I'd most like to
compare is exactly the representation it uses for the abstract state, and
how merge_verifier_state() joins it.

- Seunghyeon


On Sat, May 30, 2026 at 10:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri May 29, 2026 at 1:38 AM PDT, Seunghyeon Lee wrote:
> > bpf: add DAG fast-path in verifier to skip redundant state pruning
> >
> > The BPF verifier's state-equivalence loop (is_state_visited /
> > states_equal) dominates load time for programs with acyclic control
> > flow graphs (DAGs). In a DAG, every instruction is reached via exactly
> > one path: no state is ever revisited, making state-pruning comparisons
> > mathematically vacuous.
> >
> > This RFC proposes three components:
> >
> > 1. compute_dag_topo() -- replaces a simple is_acyclic_dag() bool.
> >    Uses Kahn's algorithm (O(V+E), O(V) space, no recursion) to detect
> >    back-edges AND preserve the topological visit order for use in (2).
> >    Handles BPF_JMP32, BPF_LD_IMM64 wide instructions, and falls back
> >    conservatively on BPF-to-BPF subprogram calls.
> >
> > 2. do_check_dag() -- fast-path verifier for confirmed-DAG programs.
> >    Critical correctness property: maintains a per-instruction state
> >    table (states[insn_cnt]) and, at every join point (in_degree > 1),
> >    calls merge_verifier_state() to conservatively merge all incoming
> >    paths BEFORE processing the instruction. This ensures the verifier
> >    never sees a register as initialized when any predecessor path left
> >    it NOT_INIT.
> >
> >    Skips is_state_visited() / states_equal() entirely; provably safe
> >    because topological order guarantees each instruction is processed
> >    exactly once.
> >
> > 3. Full fallback: if compute_dag_topo() returns NULL (cyclic program,
> >    subprog, or allocation failure), or if do_check_dag() returns an
> >    error, the unmodified do_check() runs unchanged.
> >
> > Register-state correctness at join points
> > -----------------------------------------
> > When paths A and B converge at instruction N, the verifier must hold
> > the least precise state that is safe for both paths.
> >
> >   Path A arrives at insn N: R2 =3D scalar [0, 5]
> >   Path B arrives at insn N: R2 =3D NOT_INIT
> >   merge_verifier_state() result: R2 =3D NOT_INIT
> >   -> verifier correctly rejects any use of R2 at N
> >
> > Without this merge (a flaw in naive linear-scan approaches), the
> > verifier would see only the state from whichever path was processed
> > last in memory order, potentially accepting a program that
> > dereferences an uninitialized register at runtime.
> >
> > RFC design question:
> > --------------------
> > do_check_dag()'s inner per-instruction verification step requires
> > calling into do_check()'s inner loop logic, which is not currently
> > factored as a callable sub-function. We propose two integration
> > options and request maintainer guidance:
> >
> >   Option A: Extract a verify_one_insn() helper from do_check()'s
> >             inner loop; do_check_dag() calls it per topological step.
>
> Specializing the verifier for DAG only case is not interesting.
> Almost all programs now contain loops.
> But the approach to use do_check_insn() as a transfer function
> in the data flow analysis is totally viable.
> I've been prototyping such transfer + join verifier for some time.
> Will share soon. What merge_verifier_state() does is a key.
