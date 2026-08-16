Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F724E4A1
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786910772; cv=none; b=t6gqXP72OPOn1JvQa2hP+aD1rYi8DNunhvtHrYlyHuMlEt0VqNy80OZZdmuP24bhWHUJSTl7e+YEsLTLgaHb+mypIWJMsSYkqjboYz04UHYUvcVaCMms2RbNT5+YYUdScO2Q6kEbhGXC78qd4NFYcdo8WNZhn5GR0xgWahR9os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786910772; c=relaxed/simple;
	bh=jgz9bH2tHtb4UXZQyIvMgjqob6622IixHPBUtcnQBRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIzKbkoHtMYd9hTWM6wflSIXqkatcSGZlcxqQ94hAF08bOQWFDOlA4cD3iM55L2aKnelVXGKRj5QHb/jIm++WjbMgHNglQq2NEhWO+sYxqt5EqizPlxlOi6lVlamfC1uQI+cSTxZvM6fM9d1ajKYussr/H+GlIHH0bCT5qbq59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnnsAST8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnnsAST8"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2686918a91.1
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786910770; x=1787515570; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jgz9bH2tHtb4UXZQyIvMgjqob6622IixHPBUtcnQBRc=;
        b=HnnsAST8TtqtaozLt34gA79yHHbkrpc0YVGSuIytrPf4SPYhDTvnfnS6HKp6K6l8H3
         DvDUqHnhayxu/3mbr008ND68xDhRFBV2QlVQfDT6QS83MkTRm74Ag8lpXVzq8up7eKFz
         HFcLHwqA3aVvj2tBB+uLRnU+YlQZV+Ou+nuqan8N8mnd7tN6zFv0UqP24DCVkjt6Rims
         PS/0WnZi3qkU50GvLTEhPaYVlqHx/OVkINGRMn3aZf/JDcw4BuFWvKrCXKajDxdksdDM
         AxXLb5dT1AVp5H488gx7HY8ITEAyAUO71bgq7ko861QXdMbHn5/HvioBPErhYieiDKIx
         9U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786910770; x=1787515570;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgz9bH2tHtb4UXZQyIvMgjqob6622IixHPBUtcnQBRc=;
        b=GPshELg+Ui57IsY3vn7N87RXgYm/rCNhWlHHl3FbIq2mjqEGXsbV8bu5v3HBctS5Qa
         6nRlXC9KpDbMYATAnh3XIfN/gM2frXXbwkj3VZ/RUDYnw/qzcSIsaYpsgr9MogXSqio8
         4L+Ste2dKmy7jhSihgpNAQ4L3rLjaAXjPIFehDI7VmnF5VciVmiU+Hf2GP4q5oeUm0LT
         WwCmCB7JQF/frPBla/xS9H/dtmlETLrPC99ShsAMa8hTwi7V9/G9BjzFkegLQ3+cR/Nk
         4fAg/cIIiRiBlDqpjTp1l2hs2sN+95oh1PPTE09TV1IgLmuCzkx1+zCTGO30gdb0KiYw
         9SIA==
X-Forwarded-Encrypted: i=1; AHgh+RqwwxnEFwkxxdWVjCuhtgWcdUjkIqhUuWrjO+Ik0nlJE5C4ZOnn3oECfFEBCJcfd3mmud8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwvzX+Lv0f/nzwjm/VUriI74z6BSnDL26h25AKT3iTNZSGcLC
	rUgtjL2YHd3vx1wsFt8blozFgRj9S/w0LGZoTHDDs5x65abCUQAOBaP9
X-Gm-Gg: AR+sD13Qe80vvA5UD1MMH7uwwtztB5Nmfpw6d3q9XwGqTuxqFDkWh1hWBfO7hG0eMd8
	6SIKO088busatyBCvfGHLOURPcwnP9usvB8AY4xzBkYcqMMgc42ZrzAo2RiQ/ptcUt1PT1dIg5p
	StZ6CMa0PT9L1gTyADS4Pu5Q6+ejWml+DIgRQ+xjGsJ5ng+sOqzESKQoP3lHpXOLrIlzQIojRLO
	RO5D8Gnm8kn89pHi7PZLIn2VNsscr0kOekJXZmrJVJgBJZqwM+TAP3XCS5yGzDQDx4FWwYSYjqW
	2AQOtOD83J/COkY0aw9NYKmK9/dA3MpFBKogW/arhsxoq3L51o/BW8WhGhNnPudpBrQVXg4P87p
	Tc1GzRRoOcs+3b6XXYQ4Gy3snWRZ1qITSrGcNJTC/BdOKHwRSZDyNZsITF92Rp+y8d87+zjzyzq
	DEIsWDdYBlOkbZZCWV7uDDieBiZeQcd4MkNJu6ubTDcK6WJ/oTcI/pAYUlYQLRkCykbg+QRxVPK
	pv9fsloCJ9ZaXTLrDkkegVmzWw=
X-Received: by 2002:a17:90a:e18d:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-3933b764d23mr22696976a91.8.1786910770356;
        Sun, 16 Aug 2026 13:06:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e64960sm2299594a91.8.2026.08.16.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 13:06:10 -0700 (PDT)
Message-ID: <6ac1a64834adae3eda18cf3b261bcb88fefae3e9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Rewrite any fault prone load out
 of a mem or btf_id pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 13:06:07 -0700
In-Reply-To: <20260814215301.709827-4-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
	 <20260814215301.709827-4-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> bpf_convert_ctx_accesses() turns a BPF_LDX into a BPF_PROBE_MEM one by
> matching the type recorded for the insn against a list of exact pointer
> types. The list cannot keep up with the flag combinations the verifier
> produces, and a type which is missing from it ends up as a plain load
> without an exception table entry, so a bad address panics the kernel
> instead of being handled.
>=20
> Two such types exist today and are reachable:
>=20
> =C2=A0 - PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF
> =C2=A0 - PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_RCU
>=20
> Rather than adding the two, just drop the list and state the property
> itself in the default case of the switch. This is a superset of what
> the list matched, the untrusted PTR_TO_MEM does not have to carry
> MEM_RDONLY for it anymore, and it stays in sync with the verifier side
> which uses the same match in save_aux_ptr_type() and reg_type_mismatch_ok=
().
>=20
> Assert that a fault prone type which does not get the rewrite for whateve=
r
> reason is rejected at load time rather than left to fault at runtime to
> catch any future cases.
>=20
> Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node a=
s non-owning ref")
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
> =C2=A0v1 -> v2:
> =C2=A0=C2=A0 - new patch, don't match on full types (Eduard)

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
