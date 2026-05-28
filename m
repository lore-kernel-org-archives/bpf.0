Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1F3E3D89
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968075; cv=none; b=BZBZVW1/TXn0oesP+VjbVVuTChTCcFnAsJyJqXnee4Cjn673D67LahcNJr8UWJvr+UwIqvRIvMgS6Uzw5OrzeEA2pvvZs6cg999FV+SGeqXhNyJd6dmZH9kDgxH+c7mygGRsK/Kex9EpsYPkBu7YCI8KktqGQg8zkew6Apxcw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968075; c=relaxed/simple;
	bh=+A01uPQTjtbw5Qb532W7D+Ubhg8qc/MlrRyq+hFFAoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jneyW+QUmIdHeUOBt5/UQVCnYeuvfDwCx0HsY+/nnt9wPI4wtdXdUdAjTJ5XHJEDTPdOvLCU+lgbU0M6FfMMWyyXQZw7rA2QTIsCxXCFWP05+exlCLGELw10KS7a/nzXhhw2d1UGuhpB2sCg71fXn1zdcueqbT4d5vkVw64ouYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyDrcKTO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyDrcKTO"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b8d414666so365792a91.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779968072; x=1780572872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+tx+XKYY03X8TxOQxdzemG5vYxJQIyQ9ZGtE4VotsQ=;
        b=MyDrcKTOlROF2dzE/hsdbG2dsxt6o6a4ShWg34CZcfYptKdFQ83duMFELAE4ty4X9v
         HJv7WhHf+nRsP/DbZL6PH+sTg3Ke5g3DeuT5rF3uHO+I2CPFXClKqjs9xk14LZfI3FTc
         Zlob3DN0Wsjd79rwt2xtCCUNa8Vx1i3OVQSjb8wchESDAXzDt8rCuXI5dRMmGYlCYkHJ
         0uRCWY1T0YTVHtVZeGAw4Ei53dJODWlGKUhvY7IUs8A6okxp7MIMMW+L8oWPsNcjr/X2
         TkW+9XtH1xP+Tjjl53H7X8n9XnwWC6jpnT7w1OJIKAGUwiBJWExBcT/jrLIlNLUeZqmn
         Y5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968072; x=1780572872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+tx+XKYY03X8TxOQxdzemG5vYxJQIyQ9ZGtE4VotsQ=;
        b=A4gS7XErwMAFmhO7EP4H8WVUV2dsE2DZPvoRElJqM1U+VdAYpNM8pYm8yMM+FHPGPG
         yBOGf74IxoLiy9II1eLOjssvJZfT4BsTgmz0ABoTIv+xIMeqLLMZly9PVXl38yXp7fov
         oMIEpYjWqj1lzcSKVuL0f9ChFGKwZxLg4CNbF9qMv9eTjypu14VgZjUs9WYMPrhMIAN5
         jJdAd+TCGkon4IGw8mR8foHWwDRNP+FmQREIKTl0fAvprako7ODvVKpHvj2AW1xzqeAy
         VR0rpzNncbleJlohJiMQ9D/AHAxsk7vTv/+9AbE+d6h4YBgmtuHYMQIREqTGuHzby2Jd
         XThw==
X-Forwarded-Encrypted: i=1; AFNElJ/P3zpPbcMgIsAL9pVVCSjktXX2cDGQ/y41wHkuSh3Prfna4NMEMvAo8HOnELDOrqIrazY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7f5GZXJe52VmEethSa2nAImOucA1TRt5hYXeC/S+uRce2w9Ns
	il2aQlUckf7826IBZOtyA7AGKQcSnCcA00Q2Fcz7+jkdW9bwg0vYGrKw
X-Gm-Gg: Acq92OG9s2Qa9TEXx28PxKtWc17wsEoE0tkYnANdBloMumIaWSNLAYwVuHUso9jzGuR
	SFYYvHW8ThKkqCCTKX2YEE24MDJe+eFSslr4UZ9JAUrNcbAJ0q4LkjO43p/nveVc5w0u2y9bDt0
	/0t+TsgxZD9exNBfU2oZ4QRC+fKFTB7ypprEnlo9F1sPNc/aCGlFOhsB4qJz/vdbhkuG+TH5nOV
	Kor0O07yLcV9EZk2qulCtiGEAGxJEwnkGkOfTlK2wv4KZO5VBVb3mdcxBzsVIxD/+2pMGP3eotd
	21bC0fCLKlvMn39J8Zw9QtR2djv2EgMK6GyCmGQQQsIYjor+aEp5koHv93zO9CjD6B+cQK6RylN
	JCIiJy9Ze6U3DttY80BCX+WAZmTlHUBxHOcKbRVJYHKB6KhdEXLF17o+lo83KijMgAP3JOTC63P
	Ve7/p24QlFsQJKReLATiw7AMh/Ics1C59k9Ef7XQVwDI4DJ1CLKYrmIKRs2UnEfw==
X-Received: by 2002:a17:90b:134f:b0:366:3ac:f725 with SMTP id 98e67ed59e1d1-36a6788d912mr27349345a91.25.1779968071978;
        Thu, 28 May 2026 04:34:31 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90920c7esm1534027a91.9.2026.05.28.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:34:31 -0700 (PDT)
Message-ID: <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
From: Eduard Zingerman <eddyz87@gmail.com>
To: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov
 <ast@kernel.org>
Date: Thu, 28 May 2026 04:34:28 -0700
In-Reply-To: <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com>
References: 
	<CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
	 <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 19:32 -0700, eddyz87 wrote:
> On Tue, 2026-05-26 at 17:51 -0700, YiFei Zhu wrote:
> > I was looking at Kuniyuki's selftest for BPF autolowat [1], in
> > particular why the verifier fails if these two conditions are swapped:
> >=20
> > =C2=A0 if (copy_len > RPC_DESC_SIZE)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable; /* always fals=
e, only for verifier. */
> > =C2=A0 if (copy_len =3D=3D 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable; /* FIN. */
> >=20
> > This is the register trace of the reversed version (which fails verifie=
r):
> >=20
> > =C2=A0 33: (71) r1 =3D *(u8 *)(r9 +16)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ;
> > R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_o=
ff=3D(0x0;
> > 0xff)) R9=3Dmap_value(map=3Dtcp_autolowat_m,ks=3D4,vs=3D20)
> >=20
> > =C2=A0 107: (b7) r7 =3D 8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ; R7=3D8
> > =C2=A0 108: (1f) r7 -=3D r1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_o=
ff=3D(0x0;
> > 0xff)) R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> >=20
> > =C2=A0 117: (15) if r7 =3D=3D 0x0 goto pc+48=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> > =C2=A0 118: (25) if r7 > 0x8 goto pc+47=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > R7=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=
=3D(0x0; 0xf))
> >=20
> > =C2=A0 126: (bf) r4 =3D r7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ;
> > R4=3Dscalar(id=3D888,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D=
8,var_off=3D(0x0;
> > 0xf)) R7=3Dscalar(id=3D888,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Duma=
x32=3D8,var_off=3D(0x0;
> > 0xf))
> > =C2=A0 127: (85) call bpf_skb_load_bytes#26
> > =C2=A0 R4 invalid zero-sized read: u64=3D[0,8]
> >=20
> > The oddity happens at this instruction:
> >=20
> > =C2=A0 117: (15) if r7 =3D=3D 0x0 goto pc+48=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> >=20
> > The C logic constrains that the unsigned copy_len !=3D 0, and <=3D
> > RPC_DESC_SIZE, i.e. the end state should be umin=3D1, umax=3D8. However
> > instruction 117 does not record the umin constraint. If the checks are
> > reversed to match the patch order, the verifier is sane; the
> > possibility of overflow is eliminated, so the range becomes [0,8]
> > after the first comparison, and then [1,8] after the second.
> >=20
> > I looked at the verifier changes and found this commit:
> >=20
> > =C2=A0 commit bbc631085503a7fde9617be18b0657cc9a83910a
> > =C2=A0 Author: Eduard Zingerman <eddyz87@gmail.com>
> > =C2=A0 Date:=C2=A0=C2=A0 Fri Apr 24 22:52:44 2026
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: replace min/max fields with struct =
cnum{32,64}
> >=20
> > This change means that the signed and unsigned ranges are no longer
> > tracked separately, but rather in the same circular number.
> > Unfortunately 0 falls within the circular range [-247, 8], and the
> > cnum intersection returns the over-approximation result of the
> > original R7 range (because the intersection happens on two disjoint
> > arcs), thereby ignoring the introduced umin constraint.
> >=20
> > I'm not sure how this could be fixed without reverting the patch of
> > using cnum to track ranges (which would re-introduce a lot of maths :/
> > ), but I'm also not sure whether this is an acceptable regression.
> > Some helpers, such as bpf_skb_load_bytes in the test, uses
> > ARG_CONST_SIZE, which really does not like a zero lower bound.
> > Therefore, if that argument results from a subtraction, the verifier
> > now enforces checking the upper bound before the lower bound to
> > eliminate underflows, even if the variable is unsigned and thus
> > invokes no undefined behavior...
> >=20
> > YiFei Zhu
>=20
> That's unfortunate. Thank you for the detailed report.
> One option is to allow intersect operation to return two intervals,
> then use both intervals and fork the verifier state to explore second hal=
f.
> Veristat impact to be measured.

A few notes on the pattern first. Here is an excerpt from the test case:

	if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
		copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
	else
		copy_len =3D end_seq - rpc_copied_seq;

	/* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
	 * clang omits the "copy_len =3D=3D 0" check below, which is necessary
	 * to satisfy the BPF verifier's range check for bpf_skb_load_bytes().
	 */
	barrier_var(copy_len);

	/* Do not swap the order of the two copy_len checks below.
	 * The BPF verifier somehow does not properly track the minimum
	 * value for 'copy_len =3D=3D 0'.
	 *
	 * 91: (15) if r7 =3D=3D 0x0 goto pc+40      ; R7=3Dscalar(smin=3Dsmin32=
=3D-247,smax=3Dsmax32=3D8)
	 * 92: (25) if r7 > 0x8 goto pc+39       ; R7=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0xf))
	 *
	 * This does not occur if copy_len is u32.
	 */
	if (copy_len > RPC_DESC_SIZE)
		goto disable; /* always false, only for verifier. */
	if (copy_len =3D=3D 0)
		goto disable; /* FIN. */

Note that "do not swap" comment here is fragile, as clang is free to
reorder these checks is at sees fit. It will pick the layout basing on
branch probability assumptions, trying to maximize fallthrough.

The pattern in question looks as:

  1: rX =3D ... some range crossing sign boundary ...
  2: if rX =3D=3D 0 goto ...
  3: if rX > 8  goto ... // unsigned compare
  4: ... here rX is guaranteed to be [1, 8] but verifier can't infer that .=
..

The (1) part is important, if rX is non-negative the cnums logic would
infer true bounds. In the test case the negative range for copy_len
comes from the arithmetic at the beginning of the code sample.
I don't think such situations occur often.

The main difference from non-cnum verifier is that from `rX !=3D 0` it
was always able to infer a umin bound of 1.

With this in mind I did two experiments:
- At each conditional jump, if cnumX_intersect in refine logic
  produces multiple arcs, fork the verifier state to represent each
  arc in it's own state ([1], horrible code quality but good enough
  for the experiment).
- At conditional jumps of form:
  - rX =3D=3D 0 / rX !=3D 0
  - or rX =3D=3D rY / rX !=3D rY where rY is known zero
  - when rX is bounded and it's range crosses sign boundary
  Fork the verifier state splitting rX range in negative and
  non-negative parts ([2], patch is fine, tests need refinement).

[1] https://github.com/eddyz87/bpf/tree/cnum-intersect-split
[2] https://github.com/eddyz87/bpf/tree/cnum-split-at-zero

Approach [1] has some nasty verification performance regressions,
because effectively it introduces a fork at each comparison with a
constant. These compound when there are several comparisons within a
for loop body. E.g. blowing up verification budget consumed by
selftest test_parse_tcp_hdr_opt.c.

Approach [2] fixes the issue at hand and has almost no impact on
verification performance when tested on a set of
selftest/scx/meta/cilium programs.
It is fine tuning for a specific pattern though, but one might argue
that zero is special and this behavior matches the pre-cnum umin logic.

I'm thinking about a somewhat more generic approach:
- a data flow pass collecting symbolic constraints on registers
  (e.g. rX !=3D 0 =E2=88=A7 rX <=3D 8 at instruction 4 in the pattern above=
);
- and using these constraints to:
  - refine rX range during main verification pass
  - deciding whether to call mark_chain_precision() on memory access
    by inspecting constraints (e.g. if constraint guarantees that
    rX <=3D 8 and memory access is safe when value is <=3D 8, there is no
    need to do mark_chain_precision()).

This might make sense if mark_chain_precision() part would result in
measurable verification statistics improvements.

---

Of-course there is still an option to revert cnums altogether.
