Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4F47FB15
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875785; cv=none; b=e/wPIPixJrQg3hnkiSwoE7oZo/rNAub+158FS+8tuXgCcCvANY1WWtO/x/WM5sM5jQutfH01YErpDmRuUIJ1IS6rwuGkMu1Vs167xiWeSHxHy+U3mpL3ULEbVt9681GZ6pdUCBRzKRpV2a/1yD1NgMrMouB2mppPm72drxx6iyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875785; c=relaxed/simple;
	bh=Jyw13O2SUfbWbqTaYtfVGbtQpMC2PFNd77NjcMHOuuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKLb6zOFRpJvRPT7nxjmGZ90+3DxzJrZzxw7+/oZl0IJbNGesb4TmnJBgQoW0b6gsSY91DlhiJ4iCoXdVKqYXQ1hVFuXamJT3I9zIB3/Qyaig6RLHYecnxqv3Qn9GdwQhhwOn+FrGdYdFDRtUmZzabR36w0gL9VXY5aM+9SUw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYOpP5TY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYOpP5TY"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so258467a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875783; x=1786480583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Jyw13O2SUfbWbqTaYtfVGbtQpMC2PFNd77NjcMHOuuo=;
        b=KYOpP5TY8DyVAnZG1J9nVP4W+sqOEN3nqvMxXkQwmWR+LCPFX5HFjHqqtMXjc00Xa5
         kRYYD0n/FvhNce9YpR/uSL3GvXb3julsgjXBjpqf5JfIS1Ujma2GFY6XO7iBztTKlPYx
         a4fJMeekjGdyB3/BZQtwPyt7Bem3cdRy0u1I6KDCHmJhalZ/5q5YHWKp4gHZFT1zXl+M
         u36pqTvUFlQLlt3Pvy/eI8toJAKi3/HnET0WccMgHdn7BoucAEXFny/La/yIKId2kfmd
         9bcPP82tDPOxZpbQSkjX5ijfR45U7su6Dzlm+ZwDvg36iO4YkKcK6+ntM3dpz8KMANO5
         u54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875783; x=1786480583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jyw13O2SUfbWbqTaYtfVGbtQpMC2PFNd77NjcMHOuuo=;
        b=CAf+V6T9R/6sEFuOvUSy/bNEynudCCH0FX2w+Ln4dn5N0aLrkmxqX/AlMFnJr6LC3T
         momrMCJ3ikyh+fIGQLRpu3Np9GfcFacJQW1SLJlXkPJUDQ/efVM427UyNzCDshf4qvXs
         Z8kb1WARqQtD+B6AKKiKdvWrc1OzVolUHm6ZWqDYwrYpCqFvI6fY8znUP2IKuWniu90m
         pQY7xYY0lE5/CKNQ8Ibxh/Bw9aF2QcbrCb/62kPPRmDv0rIkBNiFyN5oKXG12n7dGYsm
         /NoF82gbjPGAA+/joS8xPQgPfXEQtPgB/9WRE4ucwiUMHWsa2F/0826N7Z4vLRgB6i4C
         HH2g==
X-Forwarded-Encrypted: i=1; AHgh+RqctvVi0QnBV3/krJAfGx99pycwb5muAqNQ9KxW6oNbfWukWCa8HdCaJca3VbsqHbDEXVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+MuOnTZ58Uy0Xt3NA79PX76/uT2CY6cr65g6Aq6YkAVNbDZG
	v0AjDVqMn1t/Fd8vdJawOw05uuNHR8L3CnITBm4OllO8n5Q7Pp8H3t75
X-Gm-Gg: AR+sD12+iTUkbwC4nl5Ry6C0pdCKkbloGUSmn2cqrOoUIeTVodqsR4H/wgsUcahI7kw
	CR7JhUAweL1e22RX/pxzGqJ0wCzMiOtjlWsVlhxZE/KtCyvrmLZSEW3Oq70rz3UVt7Xe6efJns3
	vEC2pBg60fMby3Gj+im5HokwwilcFmF7wRtrksxermpEpQzA+BpCbgaQDCtWDUU8/WJMEbu2qdb
	rKSNhhXY0ZzAcKs+NeuLB8LiRMDA0i70J5nat41edOPTEFPSG9bo2TeE5URNchWtEJWwFv9QVJ6
	TheHQtYl/ElAJfsOqAcJmWOvkbx5TItkMglt5WMWUyVyhbnJDQ6aZK7ApqmD3e/CWlc2Nh9IB5a
	NsYOWxTKX04HpBSqdlV5lG7eftx3rMzdwt8C+XGfW+L8x7g20Ljb+2gtNIcLAR7fffz8bZw1Hha
	mPHYZdPk3Lb07LjpgiisoxejQ6Z3+A/B1PLvlfqthJGT0imR8HtifbxgMineso1D5pBAeZ9VDZu
	uj0teKt2sZKUPaJUQ==
X-Received: by 2002:a05:6300:648f:b0:3bf:98d3:f185 with SMTP id adf61e73a8af0-3cb85984ec1mr1752193637.14.1785875783428;
        Tue, 04 Aug 2026 13:36:23 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe706e1c03sm254826a12.0.2026.08.04.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:36:22 -0700 (PDT)
Message-ID: <b687c54fa2f2064d6743adf002cbe1191297dcff.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 13:36:20 -0700
In-Reply-To: <6022cc53a26ea291178b648a6b07c0e8d6874c70.camel@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
		 <20260803125115.2264733-6-memxor@gmail.com>
		 <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
		 <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
		 <4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com>
		 <9552fc68c2d06c5dd88bb7494b4934e779bc45c6.camel@gmail.com>
		 <DKGFY9Q5M8NG.1OR49ZSZI3VCZ@gmail.com>
	 <6022cc53a26ea291178b648a6b07c0e8d6874c70.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 13:33 -0700, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 22:28 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Tue Aug 4, 2026 at 10:26 PM CEST, Eduard Zingerman wrote:
> > > On Tue, 2026-08-04 at 13:24 -0700, Eduard Zingerman wrote:
> > > > On Tue, 2026-08-04 at 22:14 +0200, Kumar Kartikeya Dwivedi wrote:
> > > >=20
> > > > ...
> > > >=20
> > > > > > Which leads to several conclusions:
> > > > > > - We should reach a consensus regarding KF_ARENA* usage, as the=
se
> > > > > > =C2=A0 kfuncs would clearly benefit from having __arena annotat=
ions on
> > > > > > =C2=A0 parameters (on the BPF side, on the host side these shou=
ld be
> > > > > > =C2=A0 declared as plain pointers).
> > > > >=20
> > > > > Yes, but even if we do, for the time begin, we won't have support=
 for
> > > > > automatically emitting it until resolve_btfids changes are done. =
That said, I
> > > > > can manually add the annotation for now.
> > > >=20
> > > > We can fast-track resolve_btfids.
> > > >=20
> > > > > > - In patch #1, it appears that there is no need to allow PTR_TO=
_ARENA
> > > > > > =C2=A0 for parameters passed to such a function. At-least I don=
't see a C
> > > > > > =C2=A0 code not involving manual casts that would require such =
support.
> > > > >=20
> > > > > This one I don't understand. Why wouldn't we get PTR_TO_ARENA typ=
ed paramters as
> > > > > arguments?
> > > >=20
> > > > `(u64 *)val` is translated as an address space cast instruction.
> > > > This instruction yields PTR_TO_ARENA. Except for explicit casts,
> > > > how else can you pass PTR_TO_ARENA to such a function?
> > >=20
> > > For example, `foo->ptr` yields a scalar from the verifier point of vi=
ew.
> > >=20
> >=20
> > Sure, but I don't think we should reject the case where someone does ex=
plicit
> > cast. See e.g. the global function __arena tag, which also accepts both=
 cases.
>=20
> PTR_TO_ARENA is already a valid kernel space pointer, it does not need
> additional conversion.

Nah, that's not true. It is still a 32-bit value.
