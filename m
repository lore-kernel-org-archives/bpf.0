Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B33E5566
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051293; cv=none; b=G5AoLXqiCtWNb+2BIQvGA88QoUEUgfaoWhwPQ0FCVk2B4x66/67TQKOOU+XizPkcBjhS7TxfGAJZv5C4Aeo/NvydQRN6YLXXTgroG+Rys+8rU99vHD9xymw8yrtmnkyd6nGy905Jn0q/xDBUD9++fK0ROh0tyMpTp6OPP99YWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051293; c=relaxed/simple;
	bh=K97UsiNC/awAfV6xFVrvkYt2tr7C/4YLLBgtXpNlUIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGG6qvuhTei+UcqmL1dO2bbDuPiL2KG9tjOy7rQvEJcylxkKawt+YGR/jZmIMdSQqgBE5TAHujmCVFXYndeTcq6ZbkPDUFZy/n5Wl7EoGzFRep6LY+G2tqvYRlmJ/TvtF3kjvEZpyMQDmvqV1BZzvbsBu7J+9o4PFxZqas5y6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIjNiYGI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIjNiYGI"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296dabef74so6812278b3a.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777051292; x=1777656092; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mmxzzBvv4zWfLE6z6KLDCqsqrHTG+f8VgoCs0ryw+oY=;
        b=TIjNiYGIl2us2rmzIvlYSoyIL0DNylDBR362vBiOqsMdAxPQ4MnwErj/J86gUAtDM+
         JyrPpUi3XXlsPXZs93ESHOV7JkyqZuPzimyJIjwK8xm7xKT2J9VTXFtIXj91f20MSrJL
         hKWO0NDG2A0gILqJEEG/yQHngp2JctuSJjTAMd3jpec1VHoayzBcjos5inalsnbJ9UjI
         iz+MsB0QhemFfYu1yQEKr1XdDd+G/p/tMUv+pFMJdW8BfdyVdAyNHnxANzm5GC/vRNR4
         8DxOELCbJRvQh8t9btsI488MFQqctCLLqrXxjDa6BKLog6xjxS/rs3Ggn1mZ8Bp2zn4t
         MkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777051292; x=1777656092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmxzzBvv4zWfLE6z6KLDCqsqrHTG+f8VgoCs0ryw+oY=;
        b=DJZGjJH6e//AErWYXXpb4GW1alDClp1WOYFOq6bAN0J4wQkc7CSbYZnJIawMj1rrq6
         0JnOAFJCayztcZKJ7sTgBP3wSqo+9VUkiRZa8UZ+l3WY2ZzKJXZaGsl5R1XCg32CFAJ3
         st6uZAFPu0jUsPNyHEi53clJd7hekIz+SOsz5/1WVOO1Nn/glgo5Mxbxw52aCl2Kpze1
         uhpBeKHTJRw45c+3+06/X0CBH7dO08Vnq/T55zN1/ppmDCMOOR+I29ThXzBkGiDPx3hF
         12aTqYs9ZXJuolLNLIH3Z3lRda0fRo+0pe0apukdxeJ/NLHiglHyBiHUIVusa74DFiGl
         A4gw==
X-Forwarded-Encrypted: i=1; AFNElJ8B26tuv/tRjYtyvIDX2AhYC5XXZ1q5L4M1TVl2Vf4LF20KGYDcq0wBiq7ee1998Pr+OVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbYWSyOqDOba/4h/Qmvn8/jCs0PHqeI5tIPWsME+Y4AUiGoAw
	RJ9DT82iLYEfaBTIqVUWHmTYSrTpPGXINAgv+ygs+Ugif2gZluBs5BQT
X-Gm-Gg: AeBDies5S0Q5uoZ5BC+DMxVp3+H+8Jp2IA9dL7ovqHlUs6S2eabzluiUARAv86Rb1lV
	GJmbG3DoOqKCguc14JfZBnKF32n0oXlybrZfqa/T8a+Nu0Smo3b5l2KvW3WJpinH8qBzXp3oqhL
	/Q0JOxvjuD+891DioPNNAWAZ571E295qxF2w6487FKuYlJfRwQt6LZdtduoaNtFLOdG2K0H8H9E
	pSbtsz2lqN7QQIMJy0KPMWsFkWM+gPMaS3WFNtFXM+NqO0GeF0CQ+GRPJiJMLtRw6nk4AjbHKgS
	CdEpHbuP5I7tKdEA5M1H447ZiO8YJ2eq4OlRpkaLknxZo04lpEhL5e4XyVVL4cKB1dP+WDtiNXT
	Yz0VEnV0j6Teyj7fHKeb2U3auM9w5X+IaITSsPgp60ZVyTAgQCt8OY2wBPu9mmoiQuhXH36JtIZ
	rTVnDPTp3wAUwt45gdz01kQKS4dJdU9cKDjRFeBiS8C/zMlf6hbdRwB9rUJN2L82ngT4zkbQLfF
	gZIVXXRlzNe5iZNhQsz
X-Received: by 2002:a05:6a00:b87:b0:82c:9c4f:da3 with SMTP id d2e1a72fcca58-82f8c902057mr36470065b3a.31.1777051291758;
        Fri, 24 Apr 2026 10:21:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:92a1:14f3:18de:3c64? ([2620:10d:c090:500::1:b6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm26229917b3a.14.2026.04.24.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:21:31 -0700 (PDT)
Message-ID: <ba5a1018576d4281d46ef81846a6573dd887d780.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, shung-hsi.yu@suse.com, 
	paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 10:21:29 -0700
In-Reply-To: <6578efe1e2d2932d3c590871f0aa9d65e3bdada9d5234297c627b33506c7b1e2@mail.kernel.org>
References: <20260424-cnums-everywhere-rfc-v1-v2-3-57091924c9d7@gmail.com>
	 <6578efe1e2d2932d3c590871f0aa9d65e3bdada9d5234297c627b33506c7b1e2@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 09:12 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b91d2789e7b9..34900247efba 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -2031,340 +2029,17 @@ static void __update_reg_bounds(struct bpf_reg=
_state *reg)
> > =C2=A0/* Uses signed min/max values to inform unsigned, and vice-versa =
*/
> > =C2=A0static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
> > =C2=A0{
> > -	/* If upper 32 bits of u64/s64 range don't change, we can use lower 3=
2
> > -	 * bits to improve our u32/s32 boundaries.
>=20
> [ ... ]
>=20
> > -	}
> > +	cnum32_intersect_with(&reg->r32, cnum32_from_cnum64(reg->r64));
> > =C2=A0}
>=20
> The comment on the function still says "Uses signed min/max values to
> inform unsigned, and vice-versa" but the implementation is now just a
> single call to cnum32_intersect_with() that projects a 64-bit circular
> number onto the 32-bit subregister. With the cnum abstraction, signed
> and unsigned views are derived on-demand from a unified representation,
> so the cross-domain signed<->unsigned deduction described in the comment
> no longer happens. Should this comment be updated to describe the actual
> operation (e.g., "Project 64-bit range onto 32-bit subregister range")?

The comment has to be updated.
