Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FA3655CA
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875627; cv=none; b=HaUk5NdGLQ8xNrjRwbQSaoXSBQ86ELTue213fetDYVkifZYK96hdOdF+9nitmIl6D0unBzZ5IObyG3eBAmKpTEDnJTTuxNmrILXz/GfAghG0GscQUiz+jzRCCcV6PEs2W4abbndNHCADaLDuf6QYnOIvcY3SeE3G1K7LySWlRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875627; c=relaxed/simple;
	bh=fXgx4ED8nG+8c2bGMEqmx8SOXW+rC0YTfnhe+gBeJb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZyxlBEjLTG1WBhZnzrywpVkaAOQsidK8V9FBdXQdI7oSOCfqaYRf7I3qDytfzW8Mw2Iq/abuPJ/uRBczVUv3m0rKu6ECSTzSlYzMye4eG644/xa+n4wWi9dDXbCoMDEkdWw5NySiDNi1CfWEMqDGgOOUhyiD4/d+QAe0RZkFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHB+4xA3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHB+4xA3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e041ea211so297104a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875626; x=1786480426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fXgx4ED8nG+8c2bGMEqmx8SOXW+rC0YTfnhe+gBeJb4=;
        b=UHB+4xA3xTL8pUjNM1C6zaiqLv8KpA7QQ8BbJg6/lj3S9rAdAAfes2FBJA5l8wV2Wz
         FwsLFd/PQsJCjz5pvLS/SHr4gJtlA6dXmj+khd6aHGA//UHsySUqQ/G1tpYOGyNaxW1e
         qDZ1Q67zYkIch58RGqWQyzjVlQKev7cabeoOuLRMOhsIGdWaYmhUUHUpxG5T07wjECS4
         aM+ywaKszai7DahPvWGpBkKei6PvdknPGMI8cUJlCakRanX5uLAPn0/5PpGou3sUqlTw
         AYskhAMNhEev0mzv6WnfI7erq3/V0VLVUinEPT2jd9hpM+BlwShpG8581gRfJvCjNPsh
         XDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875626; x=1786480426;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXgx4ED8nG+8c2bGMEqmx8SOXW+rC0YTfnhe+gBeJb4=;
        b=Y7E6Ygv9+Mj98FS3VaCQau9/QAmufeg8iM8D1OEQrqB4fHfHYQJIT/uZDJ8Llc1S06
         bRRcgJYnx2qNL/UNnzLNR69KxU4whr1kdN08pghYQwN0PYLVu65hoDAFPKUptmdpP++6
         n6fEGQFfFrqIZ7FHv5eHV9hICsjaDGUHBTODxtURgKkg7GSzqavNQDFiFAp7Q6HrLn85
         03tYkg6eoNMOs+gAVf6jECuNHWqlkgVeTIeOZwzIvHO6mA22gdE/JbDcliOrAeotnTU4
         9fil49M2ekoWw1z+AujwHrH2AdglA2/Md4MwaGDc/fqyD41kLKZBTDXhuOax+eJtN71t
         1Oew==
X-Forwarded-Encrypted: i=1; AHgh+Rruf2x9dKJkXraF9fy0p0JOlcXgDNMDr7u5VKjLu3SiWHLakoJiSVH4/tDfLc/lQh7pFMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuc3CSeUDx0QAJ6AY4a5xw2ntEgkD4Nl9Hvr6qwsH2AbLIeARk
	TfuotaajpVFEfXNkr6J//aQaaG7chw452WXh8zoeuQwBp/j2vA3tSwmk
X-Gm-Gg: AR+sD11hAOWteA8iqG08nkStb9WYf684yCtq3uNy+M0SyjeKjQZnYh/MPy8MtOJ8WLI
	qB0aYK8IkYEQIoCmocHeGuI5pbPUpbsf1qC2z8eN5sWrgjXY6+9sUR8B/WX7F3YTlhL/Ftu6HCN
	ecDi4NUJ7CuqBT8emqJLzGdaM3BKWmhCpuyEToOMDj1Ro4dv44Bw5hNSzMbawRAC3kBs/KgJmOp
	IcpEN9BTVEJ6XrwXA3hfOjreq/3vJVtitW52NuUiTsBqo1ieaPz45rGNpsb/7obTpoaGRibNZct
	WYQSCeVLi++hiYobeb/ntRJitZDG4VM43sB/QRpg7irA3xSvvSrK4aSJJBEI73asbORPjBCrjzj
	FXjPMHU2brKZtrL/JS7ikC+z8r3taskSSnw9j+cAaZVWkXh5xFTHEZ6F5ek7SqpMi/jQkX6XpdO
	zEONyf3wBPEIIcQt2SSx5IX+42fomcfSMrmxOAZAWqvDXja68LUYlT2qkBPHaZ88t1BdgeNgECc
	1ZvR3HcdqTQxFwA
X-Received: by 2002:a17:90b:3985:b0:380:873:49cb with SMTP id 98e67ed59e1d1-3903c6996abmr1046954a91.21.1785875625595;
        Tue, 04 Aug 2026 13:33:45 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903927dddbsm420984a91.9.2026.08.04.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:33:45 -0700 (PDT)
Message-ID: <6022cc53a26ea291178b648a6b07c0e8d6874c70.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 13:33:42 -0700
In-Reply-To: <DKGFY9Q5M8NG.1OR49ZSZI3VCZ@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-6-memxor@gmail.com>
	 <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
	 <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
	 <4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com>
	 <9552fc68c2d06c5dd88bb7494b4934e779bc45c6.camel@gmail.com>
	 <DKGFY9Q5M8NG.1OR49ZSZI3VCZ@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 22:28 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue Aug 4, 2026 at 10:26 PM CEST, Eduard Zingerman wrote:
> > On Tue, 2026-08-04 at 13:24 -0700, Eduard Zingerman wrote:
> > > On Tue, 2026-08-04 at 22:14 +0200, Kumar Kartikeya Dwivedi wrote:
> > >=20
> > > ...
> > >=20
> > > > > Which leads to several conclusions:
> > > > > - We should reach a consensus regarding KF_ARENA* usage, as these
> > > > > =C2=A0 kfuncs would clearly benefit from having __arena annotatio=
ns on
> > > > > =C2=A0 parameters (on the BPF side, on the host side these should=
 be
> > > > > =C2=A0 declared as plain pointers).
> > > >=20
> > > > Yes, but even if we do, for the time begin, we won't have support f=
or
> > > > automatically emitting it until resolve_btfids changes are done. Th=
at said, I
> > > > can manually add the annotation for now.
> > >=20
> > > We can fast-track resolve_btfids.
> > >=20
> > > > > - In patch #1, it appears that there is no need to allow PTR_TO_A=
RENA
> > > > > =C2=A0 for parameters passed to such a function. At-least I don't=
 see a C
> > > > > =C2=A0 code not involving manual casts that would require such su=
pport.
> > > >=20
> > > > This one I don't understand. Why wouldn't we get PTR_TO_ARENA typed=
 paramters as
> > > > arguments?
> > >=20
> > > `(u64 *)val` is translated as an address space cast instruction.
> > > This instruction yields PTR_TO_ARENA. Except for explicit casts,
> > > how else can you pass PTR_TO_ARENA to such a function?
> >=20
> > For example, `foo->ptr` yields a scalar from the verifier point of view=
.
> >=20
>=20
> Sure, but I don't think we should reject the case where someone does expl=
icit
> cast. See e.g. the global function __arena tag, which also accepts both c=
ases.

PTR_TO_ARENA is already a valid kernel space pointer, it does not need
additional conversion.

>=20
> > >=20
> > > ...
