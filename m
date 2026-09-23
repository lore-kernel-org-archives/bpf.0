Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9C420477
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145943; cv=none; b=pNCeCCiUHw1bfJKgnv31uFjCxUaZViGw8r32hMwCrI/jiu3dj4Gl6QRRB/PkOllGyd9GzSzXfb5avtaCO5kBjpoKGIwoR6x9rG40KInZIteClZdLi6AjfeQ+7ZIraC7z8x2IhzX2wbtOvs9leeVlB2N+IASy8k0Zw1go1830uXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145943; c=relaxed/simple;
	bh=aK2aqYqamsgaccI5EqzajH3hBOuFj8lCi2KvYEB98Ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sglrRNHt75RANm7ObF+GGcOnGlaf6X8vYAH+loZtkIb+uJQcLVi2Ig08Bnb1OsZzJlxjP6duovAbKcX/V+U+sGhHaven989MUeWf15RhhR4+Pmmo0ILuwXj2LSz7zKj7AqYY6jXYHFOrsoUo9SJlQ8LPk76m3B6q+UvKNKzifBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZzJW7l5; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZzJW7l5"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so225112a12.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790145934; x=1790750734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jf7lHPjpC1ERi/Fh9E7eD3fYAA78G+cWgR06Ldr61Z8=;
        b=cZzJW7l5b0nGPT/OQP5px2lnLjD/LtUaodgtFFjS+LsrprUbBiLNHVzDtPMVavSEyz
         9INN7o4PT37yqMh1QCC8xpnpMwJILMgIar3HewHdoOAnGcTGW0rBcAcZSPrqxFlpm6Ua
         UdG1gYWVMyqE0ms34AzNiv4CqUsiny/Op5pjs9byzj98+jtbw8hyWy9C+/NcI1YBJQfZ
         Gwe80++t7VoIrMQ3u4i78PFDXcuKXvUJphQxRdWuXvmH+t7HYje1GwOkAxxgNloUQwPf
         e9Jqs1zth+E5cKW8S7IavYJLdhQDQze5WwgHgYGJBMRh+0EW8ggxqzyfx0WbcXXo48Sq
         gElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145934; x=1790750734;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jf7lHPjpC1ERi/Fh9E7eD3fYAA78G+cWgR06Ldr61Z8=;
        b=FnG3NRPD1bJYvDKuaLKLUYYnjsQfMg4/K07ZX/Bza3BbrnjIthXo/L9FQrb4fiEhJA
         rR0XZWCcynNz8s8C4TM3rEpKJigUrvwcHaOITUPehm89ZSDVlMW9D4o6Euf0eNpTXFBL
         MdYPy+QX0QjnnqImL2KnF3ID11Ar1eo+u3X2CqVIvdR2MSBwmfQhIF6wSzj6c4cu06Ry
         vWrGFSPV88jXe+1ix2XAjYswXWouHNCC1UkzJXfxX/0vqoAsGYruYusovQs5v9YqeU2N
         4zeCj2TRD0s2lNBw6dFoRD+8TerBDYOm5hKsC7hKVWoe5iCJR8He4f4S2doJ4I6Fc8sq
         OISA==
X-Forwarded-Encrypted: i=1; AKwUvBwQI3e3I0r6RleZ4fWauPj8nC7146wjBWrUQwIkJYGe4KWsInG4v8YnCzMwXstsYb71nRg=@vger.kernel.org
X-Gm-Message-State: AFuF++lAPe8WnsKvMXTTwUEMDFM+EDCUEeIWzYbMCYRtVOSwsJIFDG3+
	uOqXgj3jXeyMxUAO7e6tJCiVSUP55HAk9IYaG5tGqJ8fZrlMsziPw4F4
X-Gm-Gg: AYBFou3EJMFPEdifiJcnMIHMS4wMkczcuwzgWroxx2+njC5xexk6+N0d/PdBgyJcyvE
	M7Ok/g5GBuifLz6Gm5FP+xU7xZTcBgvMpBTBMGgl9vnCqAuZi8O1gMNthvNrwJ7jFSmvOOwWoH2
	NBv+csrFIGvZUsk05b+E6MngkzzJRRURGEdM5TkktKzV+9MQGXVYPguSbMPCHpLKiC2+3ura/GV
	hWHqhfztTopZTXNl9APURxPGHLuU+mlxjXZfrM4i5AWDMU9IRP1uH+rAgIzw/Q5cT/iht2QogKG
	K71/X42sJw2kiyiuMm/PXsZ3kK6vMCrgc0SljQ4GTA0kD7DTOJCvhJGmywR/bcolxsE0/p+K6Wy
	0+q8rBxH2/NCyTVV/9W0ulBXNR3so0zNo62qO5jMPtHwQ/15nQLe6ZU+XVfJC00av0wFjopp/Qr
	V1G0JcpXBrhnVhDcl7XwN9RfW5NAahEIyxfvTzydrZhwiZy00qcGAoNVdHkef7Yv9f2zq+/G3Yw
	ZJEYlheYx3mgX3p6hNaxqoXBlz6EBEmC7Uc
X-Received: by 2002:a17:90a:f947:b0:39e:6c68:fd93 with SMTP id 98e67ed59e1d1-3a07e6195e3mr1027545a91.40.1790145933845;
        Tue, 22 Sep 2026 23:45:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddaf4f5sm3187979a91.4.2026.09.22.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:45:33 -0700 (PDT)
Message-ID: <a47eb8c7aa3c9806b2a4e01554f5c6daa3fa9f6c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 12/21] bpf, x86: Dispatch exception cleanup
 pads at run time
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 23:45:30 -0700
In-Reply-To: <20260923045948.2420512-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045948.2420512-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:

...

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4a980140b48..26df52050cd7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

...

> @@ -2024,7 +2034,7 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
> =C2=A0	/* Exception callback will clobber callee regs for its own use, an=
d
> =C2=A0	 * restore the original callee regs from main prog's stack frame.
> =C2=A0	 */
> -	if (bpf_prog->aux->exception_boundary) {
> +	if (bpf_prog->aux->exception_boundary || bpf_exc_force_spill(bpf_prog))=
 {

On option to avoid spilling all the registers would be to use register
liveness information at call sites and collect a union of registers
alive at landing pads for all callers of this particular function.
Wdyt?

> =C2=A0		/* We also need to save r12, which is not mapped to any BPF
> =C2=A0		 * register, as we throw after entry into the kernel, which may
> =C2=A0		 * overwrite r12.

...
