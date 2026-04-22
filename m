Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442623321AA
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884720; cv=none; b=kLWjuqknmsUS3wcjnu/FgS+a9jzreQ+hoU8LyItcCIH6Z3dXkNA+Xhf/QiQj5SXk9hSOp1VJxRlbhDdFaoLAV68vO01biGzmT2qGCJ+3gzdEUIYw0r20ZSOvcPYcQAwe4CpYu3xyZrWOtTO1UtIFGZ2TdjqhuD2h/Ut77qWIkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884720; c=relaxed/simple;
	bh=iumyfPLYm+P5P5cXDg1P09TWYPhJu5pW2S1M28HLtVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fFQFg/4D4zHWBaT128pVHYVzIBSPgsVg5q+RK2tIwb72MpT6PVfM1H1yJ4CD4cHlsPxlvqH15K1Esg0AYT7tWVDA76R76q6DXkvRJZ9FuWMAq2QAk+2V+QDSA0GatQMp85l/BvBd5oMjZfv9F5rpF1ZB5/zKpFSPWwxrSbAGtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=srZnMtkQ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srZnMtkQ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4873672eec.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776884704; x=1777489504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3L0D98yYy8DlRZjqLLygrSfyDynsSF8V+kBRwcj4EJ8=;
        b=srZnMtkQcKXQyjZRwBp2ffe/w1y+2IH/ybEDTQosgzHD7KqmPFKCiINFEE60npw+pu
         5gNFCPVPHbsjz7th9oDSv/PEQ0LvA1RrOSr5QRYUMuapsEidCNXQl+hXjHXxSt/6Oh3D
         Wr848A93p9LUyzM/7JtFqFX515QpJcHvJZxC7pnacX8ahVdn/I6RuMilgT35UF2ZvNau
         ARmLp+GJJ3XEml7WGSmjH++IIi2IHI7TKwkbGqFS9qTcPvmIZX2wUtayPVdog4JnJ5eR
         eB29QcB6VfvKOl2Mym70rLfbHFekAk3Lo5oUcezarD23zqH2Rh1SaOeqYkTTxWoWMSs7
         7Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884704; x=1777489504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3L0D98yYy8DlRZjqLLygrSfyDynsSF8V+kBRwcj4EJ8=;
        b=Hx3rGKft1qjfGmT7nsElZLlxMv0SE+Jn9IQ8EhItwnFnVHKIIDrnWfu7XqaHATN/cJ
         3YT1vMsNHM/rYGne6zD7wJA5jPYirW3lTSlmG6agdvnCygmA7oUxmAkLqB7+6ER3+Uct
         3qMxlXIL9zN1KrZt7Af+YLIkOaYIWJgRqgRRWtepoWTjWNkiCBWiez1RilFattdcMC+c
         BwJviATgpkmx91lhlST4a76F+CMPCn+tvpiWGn33Gawjn3e9gp0si2H7DWtOTVwNW7R6
         2twz/yF/ymPU08JK6n34hJID2Mibt5NGG2GmKLQZXpx+WNRTvOJPUAcf1XRX/qFjbDMM
         B8/A==
X-Forwarded-Encrypted: i=1; AFNElJ92ZNyKHFGdLwaO9OjMf3qv+Z0c3gdoGiu3MqdvPRg0g2UL8nu5QE0nv/TzoKowQIzBM64=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrMR6pdcKNNU2Qb6bn7fnwJua6tvHS9AnYAxFFTIrq8QpvRQb
	dHD+ghNEywaHJxUp7W/tG1zT85DDHxI6LBCSnaU+T9oMTA23gb7WfhRl
X-Gm-Gg: AeBDieu1WFy5Q2JKGpX3jZSbcSg+kCodQv4LOC496oGEcukymnB04N5b5NJAIA/277E
	/4qFS9krtwK1+SCqjZ06NdqFz42QQ2OJ1X6ipjsmQ3FyOb3zAYIeYBlT7UnsEmaMTfkd6NcmviD
	YwEw+MaVZqvVXzQXpobALqWGWEsxWA5iPNx4ZGjiooCXEptMczcXxxMhEI8UwcVroYVDSm3FZEQ
	N0gGOEPCNncjDOVdir3mF99jJGzQYUsDB+dEFxSYSdzh7ZB0h1NQNI/WOJ1XePLV7ydhIxIWeyF
	PAIT9lji/ZdQfUEZuIlKQ0HIGFuN86x+YhCmSk/50OTHxAS+RmUmKpZnezqvHbDVQFR2W2LCkF1
	kFHPdbgdVwjCAO5AGwnwdysCrRwdRpGcUBHGIX1jMLCS0/6wPHGhJe4Yh0V9o5dr2GQlVe3KDA/
	whl0RxDw5RkgSa9MTM9h1/sl3Q+W0qL+/bm6ryeB/ZjsB0CMkNJ8WhEIc/5RbS2NBlco1ct3gy7
	p3hHUIBqwGOTBvwiIPt
X-Received: by 2002:a05:7300:e685:b0:2dc:5d20:c163 with SMTP id 5a478bee46e88-2e42c848e2amr10582614eec.6.1776884703667;
        Wed, 22 Apr 2026 12:05:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm24251803eec.17.2026.04.22.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:05:03 -0700 (PDT)
Message-ID: <f44bd13fc40718dfba7a4074a74fa94c4705672e.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org,
 ast@kernel.org, 	andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	harishankar.vishwanathan@gmail.com, Shenghao Yuan
 <shenghaoyuan0928@163.com>,  Tianci Cao <ziye@zju.edu.cn>
Date: Wed, 22 Apr 2026 12:05:01 -0700
In-Reply-To: <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
	 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-22 at 22:50 +0800, Yazhou Tang wrote:
> Hi Eduard, Alexei, and everyone,
>=20
> On 4/21/26 6:28 PM, Eduard Zingerman wrote:
> > This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> > verifier by a pair of circular numbers (cnums): one for 64-bit domain
> > and another for 32-bit domain. Each cnum represents a range as a
> > single arc on the circular number line, from which signed and unsigned
> > bounds are derived on demand. See also wrapped intervals
> > representation as in [1].
> >=20
> > The use of such representation simplifies arithmetic and conditions
> > handling in verifier.c and allows to express 32 <-> 64 bit deductions
> > in a more mathematically rigorous way.
> >=20
> > [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
> Thanks for the great RFC. Replacing the heuristic min/max bounds with
> a rigorous cnum domain is a fantastic step forward for the verifier.

Hi Yazhou,

Thank you for the response! Collaboration is most definitely welcome.
Alexei is positive about this RFC, so we have a way forward.

> We had previously considered proposing a similar replacement of
> the range tracker with wrapped interval analysis (wint), based on
> the same TOPLAS'15 paper. However, we held off, fearing the added
> complexity might be rejected. That's why we are thrilled to see
> this RFC and would love to contribute to this effort:
>=20
> 1. Implementation of division, modulo, and other missing ALU ops
>=20
> We noticed the discussion regarding the complexity of div/mod on cnum.
> We have previously implemented [1] the full suite of abstract operations
> for wint in Rust (including add/sub/mul/div/mod and bitwise ops).
> This was built for potential integration into Solana BPF and is
> heavily inspired by a recent paper [2].
>=20
> [1] https://github.com/OpenSourceVerif/Wrapped-Interval-for-Rust
> [2] https://dl.acm.org/doi/pdf/10.1145/3728905
>=20
> The algorithms for div and mod are indeed complex but entirely viable.
> We are very interested in collaborating to port these extended ALU
> operations into the kernel C implementation.

Could you please elaborate which algorithms you have in mind.
It appears that [2] is about sign-aware tnums not wrapped intervals.
The Rust code for [sdiv] looks similar to the algorithm described in
the TOPLAS'15 [1].

[sdiv] https://github.com/OpenSourceVerif/Wrapped-Interval-for-Rust/blob/ma=
ster/src/wrapped_interval.rs#L985


> 2. Machine-checked proofs via theorem prover(s)
>=20
> While CBMC is excellent for checking bounded C-level implementation
> details and catching integer bugs, model checking is inherently
> constrained by its bounds.
>=20
> To complement this, we have used the Rocq theorem prover to provide
> deductive, algebraic proofs for the soundness and completeness of
> wint's operations over int64. This is still a work in progress;
> currently, we have completed the proofs for:
> - the soundness and completeness of wint's add and sub operation
> - the soundness of wint's join operation
>=20
> We believe this can strengthen the theoretical foundation of cnum.
>=20
> We are also exploring the use of Z3 to automate the soundness proofs
> for these abstract operations. Furthermore, we are actively researching
> the soundness of the reduced product between tnum and wint (cnum),
> which we hope will eventually serve as the theoretical guarantee
> for the safe collaboration between tnum and cnum in the verifier.

That's a bit of a mess on my side at the moment.
Not married to CBMC-based proofs, just happen to understand the
notation and it was easy to write CBMC proofs for basic cnum
operations. I did not try to prove anything about precision, only
soundness, here is what I have:
- https://github.com/eddyz87/cnum-verif/blob/master/cbmc_cnum32.c
  This were easy for CBMC to prove
  - from_{u,s}range()     32-bit domain
  - {u,s}{min,max}()      32-bit domain
  - intersect()           32-bit domain
  - cnum32_from_cnum64()
  - cnum64_cnum32_intersect()
- https://github.com/eddyz87/cnum-verif/blob/arithm-ops-2/cbmc_helpers8.c
  I tried to verify full mul operation using cbmc and hoped that use of the
  8-bit domain would make it faster to converge. Some of the operations
  below can be moved to 32/64-bit domains w/o risking solver timing out.
  - add
  - union
  - cut
  - check_mul_chunk
- https://github.com/eddyz87/cnum-verif/blob/arithm-ops/cbmc_helpers8.c
  - negate
- https://github.com/eddyz87/cnum-verif/blob/arithm-ops-2/main.c
  - mul -- in the function's current form CBMC is not able to process
    it quickly even in 8-bit domain. Idk if I can make it work by
    adding more contracts or moving the sorting phase to a separate
    function with additional contract.  So far, I just have a
    brute-force verification for all possible combinations of 8-bit
    intervals.  It finishes in a couple of minutes on a 192 core
    machine :)

Tldr, CBMC proved to be easy to use for primitive operations on cnums
(probably generalizes to other SMT based checkers, but CBMC consumes
unmodified C code which is extremely convenient).
The combination of primitive operations, such as `mul` turned out to
be harder to prove. (But I am by no means an expert when it comes to
these tools).

Thanks,
Eduard
