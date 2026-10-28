Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229152;
	b=J1z7sHihCd1rUK2dxN8Hfmi05DJtPyw7rbgBWHf2xf7Gy0lnAjqp8c2J1DRIkP24iy88
	 VWAujzKKgfmAxtXvSpUyQPzBtvAFhUX4aeBNqpgarxKsSjb+A4eCxrgaMFghurGJZaIxo
	 P+9OyqqW6HRz8jiI4B6h0mu46O0/KVQnAnb8AvAaeY23SqeiEL/VhBxFJnX6vKk+CjuYb
	 aGYcWqNzrR9rEBspoT+k6lpQYfpLkSafOdBvgon8nf3t3epFqBWVefmseZqhCQdlFxQ1s
	 fRIrDIWWPVG8ljHgq5uy5wSa9jUakKT5pZ/uidwXS/LG4dk/K8TXAVP+10lt4RmHrpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=4D8xYCnQLwKCE2PtUKOJuzYUihmvc7LUZedbvlmyjys=;
	b=RIVi6WXhHhkZ9GnA1rogJgbFLrwMOtX+EXam/5qKC0C5P/R6j6htgGhnI0uX+ERkMdoc
	 7zlCVHvXxymyp1z8Jo7ishNs3kaHHumHIBtuxHhmaIVkFm4sukL91xoEa69iE6jIkluZr
	 Xqq1/B04UylTPcn3TwqnOuNOxBz4HONzTBTzkk77v7ocgK5K4xZWhb+RdgspL/pc6w04G
	 VPD3VTD9ZesrhGp/p8Ri3n9EhdeanprsXVrAQucJucWmBErq19j265+fWb5UPP2le5eGp
	 EDeWxK5sWNDBDZDUnPWLIa/++Z3rloYG8ln+l/+rqbfhOsZdKtwU3VNEmdO4Y7HXdRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BzCGhfl3;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D4606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 23:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BzCGhfl3
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89ff475a152so715637b3a.3
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793229151; x=1793833951; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4D8xYCnQLwKCE2PtUKOJuzYUihmvc7LUZedbvlmyjys=;
        b=BzCGhfl3i+xER6wytKYjBRNl4KPxHkcW5Zs5zV07cg/EjoD+gSl0IuIVt4/rzvokcq
         BqL/0UmPuostCCpbIfYAueGBkdWUxSkykhh5LIdczkKf4n94HPWcmheLLSTjWvhcqwVr
         /4gyrKarsRn0C2UV/fsdAjaXmLGMsNmpzqAQh1Fx2frcyZNn15c7wr3JRNAImW7ClqKK
         Z28wyrl+WEltQdwtqW9ia0qC9L45G5CjnCN8K++t84pVVUg5xuNObe+egAIcI6kb/haY
         2TiVLHtT3Glp8tohX1/0Dtg5ubhTW1L8oOH7mm4UFY33lklM5DHDN2vUsWAwDj5fpI6V
         uMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793229151; x=1793833951;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4D8xYCnQLwKCE2PtUKOJuzYUihmvc7LUZedbvlmyjys=;
        b=tlyqI72742SfZ2H8lGLi6fFJcLPx24FNp+jGkecD2Gmu1F4b3e8fAm91cVcosISctG
         ZTwjV69GG2/Ns5gNPmEDWDi0tXUBWD6iR/xIXZZpApcqlJRTrficA7vF+yNXxOn302ym
         EFwmjA5yXL82F+niGu6mML62UhVwZn1O9GIO1IsAhkE2vLHUbKjcsOOGE1kbZEvMnUsU
         NXUG8TLem+ogojr+fH4WOO2ZyLwJin+e/gN5t6DTRt5Q2BqkHp4uhvEYo4BiwfZtsHhg
         c/R9hAdp/qsYXIquhHAX9MA79gjK9fZykFVfWObGS4tcWl7uGMheKCjCl9AGUwfhBfXC
         xndg==
X-Gm-Message-State: AFq9FYL6gBc/0bf+g6sG1IF5WaESG0HDJkMGRfwkVh9oUzfSIhDtv3/W
	YztuUg65gQK/j28q1Aii6/nFUbT2IHLt9MUM1RykB2u8FPpk89MPNx4C
X-Gm-Gg: AYBFou2/SJNqE33Y3gcR1LH7EYYTidl9fOPsqmCkxyIrjxNOnTkK8Eqjgr/SIHSoQ3W
	dm4caNAhx1JXOqGjoeSvGD9AY4cQKz/zOaodPXQmpVnqIkhkSBN2MZZWMiH9l8rA3Epd+/LiUM+
	rFzoc0aqiVkj4GKMAiorA+QVJFxgxYroHiVpaZw7U1AwINJ7iudFcahPc92zI/At4fQFvKdw1XI
	DFOrfmHUfxaJuS+sbhiV3Bx5B73LsRzymdU5W8Ptqveqdx4BQ8hpo3jyLrYCQ2R3HkxVUP4D3a9
	VWkroOmHm/+UhNvF7m97Q7b1mbxrfHd3UJd8ccwdxFOEj8OkkkvRQn+BWeI7EWB2n3GSrDIonTA
	iOWp61Ih4NsefKM8/ENsQKoaZungoGhUMAudmUAw75VoOEvlwUAauSLPTYeS2yucxSTmYXjwy4R
	KNvO1NBQZldb+CzNwqhHCOuaWO6975fnVzLc1+JN7e+Ky98Ulyntk9usHEtyiHzJ2kbn4bkkMgY
	UUpnlbcdYvOOXAUFqeCV1fAngaNAtT9REbLLzsmLIN3GgyjMzivgnH0V1Ec7XNS4tf8PTZlGmfd
	Z+jTEU1TBdTLXBJduIjKA0kuVHFcxzU3C2FZB0mXYKVJ2IAbd3fHTYQWxQ==
X-Received: by 2002:a05:6a00:3918:b0:89f:c71e:abb3 with SMTP id d2e1a72fcca58-8a6e80ba876mr3029923b3a.50.1793229151308;
        Wed, 28 Oct 2026 16:12:31 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a88a658aafsm12010b3a.20.2026.10.28.16.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 16:12:30 -0700 (PDT)
Message-ID: <448f52ebf21a0d86c5eac836bd99e4bb0892e10f.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai	 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 28 Oct 2026 16:12:28 -0700
In-Reply-To: <CAP01T747BOE7DHMfUSqFXEVFr20x=mzBbU3W_E04+kNfvUQ44g@mail.gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
	 <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com>
	 <CAP01T76uO4ULjNOQ217jXTLWtP5XT0rvB7PZxt8MJcoc==GBEw@mail.gmail.com>
	 <DMGQY7IH5Q3F.4QQNA0FDUWY6@gmail.com>
	 <CAP01T747BOE7DHMfUSqFXEVFr20x=mzBbU3W_E04+kNfvUQ44g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-28 at 22:42 +0100, Kumar Kartikeya Dwivedi wrote:

...

> There are other various other misc. cases where it is more appropriate
> or necessary:
> - Software CFI-checked indirect calls to subprogs (basically, emitting
> a check on an indirect call (say with pointer from arena) and aborting
> the program when the CFI-like check fails).
> - If runtime stack probing or recursion limits are hit, the program is
> aborted, instead of return 0 (as done in rust-bpf).
> - Making bpf_spin_lock() just work and aborting on deadlocks.
> - When writing actual programs in C++ or Rust, inevitably, panic() may
> be seen (but may not be exercised) in code that is unwinding. The
> verifier will just reject such cases. In both C++ or Rust the behavior
> is to panic=3Dabort or std::terminate(), which is a good analogue for
> simply aborting the program.
>=20
> In general, it serves many purposes, has analogue in every other
> virtual machine runtime, thus is a well understood idea, and
> encompasses what various alternative proposals for some of the covered
> use cases do (fast-execute, etc.) but with better semantics.

I agree with Kartikeya on these points.
Unwinding and terminating execution is a well understood and common concept=
.
It is "in distribution", so to speak.

The new verifier series would benefit from it instead of taking quite
unusual and unexpected actions, like inserting additional control flow exit=
s,
or returning 0 from a subprogram that doesn't have stack space to recur.
"If loop runs for too long the program is terminated" is a much simpler
concept to work with compared to "if loop runs for too long the program
is taking some exit from a loop".

2K LOC is basically nothing, if one assumes that code is maintained by LLM.
There are much more invasive verification concepts atm, like freplace
for parts of the program, or tail calls.

...
