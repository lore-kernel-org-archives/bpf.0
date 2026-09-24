Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB32BEFE8
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223529; cv=none; b=YmmgvsNRXFDcNSdRhOWKCHCz3ql1h6LhmCjrerNtWbJjjFMMLP7jnAOpf1zUOd319/nBS1/9peWwmlPhBDt7UyVGRavKkRZyRU+euUJe5JVQRLTEUi6FuOIoMFMIUknkW47DWgroJs3aPZjRI8y+9eUv6/rEOZWiqofjuzA9jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223529; c=relaxed/simple;
	bh=3L4pOC8rIm0R2JB3kAELxjOqXOFW/wGxD6ygk3fsu00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuS63TreMbVLp+gH0NNB5f6tJEC0LSNBN1nVKpnvuTaKd4QKJVwaQEMzWfryroUJWFhGHSKKO79+MbnDExfVmnTh+lMOSUOQ8VS6fSpfQ42H97gbyr+pyvOJE4AMuWppTtpcNVaz8FHz17ktAjaP2EB8eqMv002XZLA4H23H8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5t3kh6L; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5t3kh6L"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1041590a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790223528; x=1790828328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=suKswaSePHHcVeWJnZj1Btk1x/ilh6TlcG+tr3D8rKc=;
        b=P5t3kh6LnT6UoPuLnlnF9NvUx116t/cYfVUYS2Jej+/mXFJp6Mflm2ozcQciSNDfDF
         IqOTPqsari4U5p5sJc/akHf4pzy8fPP07l+q6OB3D57996awh4qiH8qbYigFzcCC+Oko
         CtmEsFAxuw5/8XYqopQmGCoF2wZIyk0kl1Ory4F4Y/D8+f1J6ZemhAVfAbtvuYSgUsQt
         T3DmoGloHZGnCGfrfXx7dAARiCLVVKupjJygHJia3lJ/SPVA5+zVItCiJYeotIZ3A3bu
         3vLdIcV+4JSXwQFCmJmicwKCQOpQbWZp6ItaIPQYyp9PpJE1C7wA2q8FH+cff4eLM66r
         GAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790223528; x=1790828328;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suKswaSePHHcVeWJnZj1Btk1x/ilh6TlcG+tr3D8rKc=;
        b=eHNepULLf3zFXe06Ruj2KaYdzCA9TVBC3aCYrtPnpFi0OAp8h/nBe9C6EiHrFH/Gg+
         FmM2neu1RID7aCg7owccgB68FMJNcrtRkIPvt0RLAT5ZI8E1MGmylasO6E3MrUy9qktQ
         UBqC6VArqyRiXLNs3bd9DQDjomX8dFS4avAPMLAgpEK3YO4YC6yOx1Yvb4VDyWAiC5J3
         2AOqi81rcYlrWehN2Q+xRHixipcGTszy1pVkVIkEjfoBKTPCCp1XiclGLf+5F6fuZRen
         bgdqmsSb2zIXpQMc4vlpb3TGxzjcr6E10NtX3aT0LebnCT/zkEqIo+O+K7wNzm4nC1V0
         J0Eg==
X-Forwarded-Encrypted: i=1; AKwUvBxZ7RSh+EzhSycr4Dz5yzS6rmqFnKiSjcN8YQ9qOfL+zeHaKHZZPLBPWuSWBID6PiMBRms=@vger.kernel.org
X-Gm-Message-State: AFuF++m6b5Wi/0IA86OuUdnzH8fZYVWNEVRvdGkS40NHVfUdUHZjyH03
	ht2VqErT1X5R2As2G5ivjt6moCYbn+ghnMsaYdDSAZeGCdb6UgsJPDxD
X-Gm-Gg: AYBFou27QccTpvS8FHvGNgwcQpywvva1JmfxyXLNtw/vueGNOKRDghsWKg5NZMKar7B
	bsYRqwklMbayrtjW2LjvM7m2WNy/p0uwNM5ESkbS96nlxs0uIgIWM8guoWNE+apEFrzNbHovZYJ
	YL+msAVnbadKAcCS6VqDHeSVv2Sp8o5nkQnAuwilIBVjOc/MsXrbrccuU9kba+OjO21fUiBMmmF
	oaCRABbjqC3HJGQRFaFzXEUIiP2WivpB3AJvnXF8c4vCQYaTDcvIL5LKuGQcUr5ItXgc7z8TmcQ
	PfwpBAyg3YRpYcMna/BOKJ827F8Glom8psZHAHUvXTW44OQVg4QkPqqj16QbzEfFeD4i72pXEwi
	VbXrCIo0YNzYpPkZVIfiMNuUoGawFI5zjGVlw0iAn9YWnxtksDzMK/8rZKE+LM6syLYrVwmIUsz
	MUofr31cFEP/gub6xqo3yIE7qWLCK9cN4IAkl2ckuKE9HNv2pAOXU1Zzj1y27Jym4w1LiQdX/lG
	4yRNCHFEoG/VkjRrCdhUfKH+o8=
X-Received: by 2002:a17:90b:4e8c:b0:3a0:7d5b:8d56 with SMTP id 98e67ed59e1d1-3a0986075e7mr1041478a91.28.1790223527630;
        Wed, 23 Sep 2026 21:18:47 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a081232c4dsm2992358a91.2.2026.09.23.21.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:18:47 -0700 (PDT)
Message-ID: <8b89e604c8b774ee0597239f113c308dcb256420.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/17] bpf: Prepare static analysis passes
 for callx instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Wed, 23 Sep 2026 21:18:44 -0700
In-Reply-To: <20260924031042.1690890-5-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
	 <20260924031042.1690890-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 03:10 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> BPF_JMP | BPF_CALL | BPF_X (callx) will be an indirect call of static
> subprog with address in dst_reg. The passes that run before the main
> verifier pass don't know which subprog callx calls.
> Teach them to treat callx as a call with unknown callee:
>=20
> - const_fold: callx clobbers R0-R5 like any other call. Otherwise
>   bpf_prune_dead_branches() could rewrite a live conditional jump.
>=20
> - live regs: callx uses R1-R5 and dst_reg, defines R0-R5.
>=20
> - stack liveness: func instances are keyed by (callsite, depth) and
>   cannot describe a callsite with multiple callees. Don't create
>   instances for callees of callx. If any callx argument is derived
>   from fp mark stack of all frames as read at callx insn and keep slots
>   of outer frames alive 'before' the callsite while the callee is
>   verified. Same as for callbacks that are not known statically.
>   The callee is analyzed as standalone instance.
>=20
> - backtracking: treat callx as a call of static subprog, same as
>   BPF_PSEUDO_CALL.
>=20
> callx is still rejected as unknown opcode. No functional change.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
