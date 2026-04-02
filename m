Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2013164AA
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159672; cv=none; b=mCwUMLPz3NYuOMVy6NP4ysc7j4BziCemL5eVRDYVbg9WCPCIbZA0Xksd+L/xMso068dD8Ld5lm/qTFk5I9UzKIIbrDY0mMeR/LJvMwfwS4sRgXVqjQ3jhh5SCTHyPCsai5Va2DHcQNhBUndU3MKcRQBfzUSbUrX05RELYJQCKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159672; c=relaxed/simple;
	bh=eAFyaJsLlCM3UrvJOr6pBruHf3hOckq2RStykQEvxyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LExrYoxMms49oLS1S+ceuS1UsSXJvrHbD/6Z6JU5IPFWEZ9DwS245x/y5VrLxh7ApzM7htx4F3VA/7WH+1eURPx4LyJEUfkIAFm92LBvOaeKlbUasLWa9nBvDo75As+a75pCEwZ9WNa0C4+X2KwJzWYmDgZpnu6eN8sanN39K40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjwSimZR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjwSimZR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d90833cacso762552a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775159670; x=1775764470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S3Tev7mMdFWxpo6nhh2Nn+pkXSu9lSQrIvm9UGQ9T9U=;
        b=AjwSimZRMnU++MkEkJCdhBb6+szPO3rPmT4CIewxiLjQqvpLLYmAxUiPKFENXGVp5P
         80sZ8aDYCC/ikgdcKefYFIjDfi6Z3t/DinXQznvKD3Cma5TJvIr6Sk15cyyEZmD1EQWz
         ZXC18w19MwDbNiAv94l6dhqk69ruJbsJLwd2bTAzSbxIPO0KgSJGxjKC0r+uVor8CLFu
         2lVogNBBSECLdloKrGMt1AXsPtlEmieXQ8gaiii4Df+FhR10IjCfzmYN2CkEkSpkUpbI
         CwyBFGzmv6WBnAYzlYlKAcRj9rQE6ZqqiZgBDs+gTmKAJSkkDSZTkh+CMaqvbKm0B4/W
         vo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159670; x=1775764470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3Tev7mMdFWxpo6nhh2Nn+pkXSu9lSQrIvm9UGQ9T9U=;
        b=ZBTmC/mN4fK3ufmBqBFH1qujpkgnfyNn8YAqozI/G76iI1soKG1oMamRcEx7n/0oxS
         nGpQp5QCrxX+ApcCwceuJ6V92rDHNn5jRZtTbd7vg4NJYi5QCaI6QFqNJPH4KiAEVVDu
         InMrx1CYWEmC0vTgoJP9xkdz58uokGOYdHDhIlluP6qqp9a+hnwiTyDOd+G6XvngR4k/
         0433BGgakHjSQYSeBEnqHQKo9Zqey8A+N2OQkeGyC31k7jlH6OVX+Ar03hrDMfH0V1cf
         6vupx8RUIkkbzIgO3x1Lgjuxscvgh2HwI3/B7mzW1wfgXRUxXGVbel1DszB9/qzRpXG6
         TB8A==
X-Forwarded-Encrypted: i=1; AJvYcCWdyoTy4m0F5Bl8HwSg/gsfdzVAxq2J02jzMs3sb/OiJ7c1FPbsBmWUJl21WzWKbL01z4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8BXqVQ36hDICPLXbiV0N01UaR/m5zslGvAI2ghFEr1WMYgCZ
	qRpmK/oJtBmwuMnWXx3HhZF0HfzAfDPy8UncCz3XgNYXhqLYAO1jzzJXFNjM2gEx
X-Gm-Gg: AeBDievn+I7CSfrl+oGUTWdBl42peDsMj/RlKcawkTkrk/3qJhYzDkTR5PGzQpdRXid
	cKZwkHJhe6VTgsrXOHuxsc3bTWGtdHDnJEQrhgmQD24Iu60iwu5X6PpKE/whDH9iHtgl+7EJI3l
	Ua9VGNnHll0pkktVS/TR8FHcXc0TE73xp7RDdHNwDEjmr2T3giK8xf6IvsjzI3Dzw/1CPtxaGac
	J5lBDZkycfth0m1q+69auL5CAuQxTdQo/mjwhB5/2P3YC2rSlFX0/yuchRSu2JJR1zJSuhYecOX
	XWmbhrNE6mND3BgGRg6IFruT5EwCU9AomPG8RcrVb/Q2FnKHqXpxU/tM0HNyRIYkIvfPB95Wkvd
	8Gn87Zk6SZoHai2RtZ6qAL96jBkSCXqstCEIRREamQKEyIUd/XOdF3iVht17y0TNRqLpakhCDlv
	UapsGbAa6mJUzJ5Wb7ZpYYwLVZGe3wGe7hahhwNwyerjQCvrsGpQZc
X-Received: by 2002:a17:902:cf41:b0:2b2:4775:fa0e with SMTP id d9443c01a7336-2b281948b4amr4495455ad.46.1775159670581;
        Thu, 02 Apr 2026 12:54:30 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27473583dsm36194175ad.9.2026.04.02.12.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:54:30 -0700 (PDT)
Message-ID: <6e77d304519d19a26a7454ece425247ec6f6b2c7.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Add bpf_compute_const_regs() and
 bpf_prune_dead_branches() passes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Thu, 02 Apr 2026 12:54:27 -0700
In-Reply-To: <20260402061744.10885-5-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
	 <20260402061744.10885-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 23:17 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add two passes before the main verifier pass:
>=20
> bpf_compute_const_regs() is a forward dataflow analysis that tracks
> register values in R0-R9 across the program using fixed-point
> iteration in reverse postorder. Each register is tracked with
> a six-state lattice:
>=20
>   UNVISITED -> CONST(val) / MAP_PTR(map_index) /
>                MAP_VALUE(map_index, offset) / SUBPROG(num) -> UNKNOWN
>=20
> At merge points, if two paths produce the same state and value for
> a register, it stays; otherwise it becomes UNKNOWN.
>=20
> The analysis handles:
>  - MOV, ADD, SUB, AND with immediate or register operands
>  - LD_IMM64 for plain constants, map FDs, map values, and subprogs
>  - LDX from read-only maps: constant-folds the load by reading the
>    map value directly via bpf_map_direct_read()
>=20
> Results that fit in 32 bits are stored per-instruction in
> insn_aux_data and bitmasks.
>=20
> bpf_prune_dead_branches() uses the computed constants to evaluate
> conditional branches. When both operands of a conditional jump are
> known constants, the branch outcome is determined statically and the
> instruction is rewritten to an unconditional jump.
> The CFG postorder is then recomputed to reflect new control flow.
> This eliminates dead edges so that subsequent liveness analysis
> doesn't propagate through dead code.
>=20
> Also add runtime sanity check to validate that precomputed
> constants match the verifier's tracked state.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
