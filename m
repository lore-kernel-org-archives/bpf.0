Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EA18B0F
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786075801; cv=none; b=js9KjUysShWwuJEi6WzPbHPmCCmohqse4CswGXgGXEANv7FPnc6fEa+lyoN8hP6c818TfkZPAXwy+tjHuQ35Wwo3R3aUt/mgpSyz/59MLRYm+FEy9KgO/i/tpyoKLBFCXkgM/QwUji1+belgba6oq0SZKmqVC2/bD3FygssinV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786075801; c=relaxed/simple;
	bh=yENHJ+8tN2wzgnvqBRUCsG31UdpOJyeHHd6xMnU4sGs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O59TtUvjuyJGzLKbzfhI3zMrOotgunEe2hmG8dp3+vnun/yEcLF8H9wXPsIFIuu7w/tAkvZKoIr/h919Gv2F2/ECYddWyjcP0eecpclZzRFpJNbsAGkXZMsq13XcZ9f9wAfIUwUk3Pb735LyFPxBtysU8dkS7LJsVQ2BCvusnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tC20MPkC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC20MPkC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3184105a91.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 21:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786075799; x=1786680599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yENHJ+8tN2wzgnvqBRUCsG31UdpOJyeHHd6xMnU4sGs=;
        b=tC20MPkC9l9VNACT/pNvnD/OwIsBsW+yj73B1QDTn4LAuH7yUK0afMqb97OpUN/kgj
         SA9DfTZlAjUnTUqObhKKl5whotJ1XPY17y6YgjpJgrmJs5PnDleHkjEeBrNbO+0dRn4l
         9/lPgtd+g3l/tCdSP4Ws4kCjacrVniV644zdjfm7LtBYWNUbEsRwrIwk7gdJj2JCx6JP
         8lIcBVe1jQvnQzI9IAhIlOF9QEIcqksc7qMwjY0T5AvJsImvwzVrgzs4ly4fh4d6HLHN
         AkB7CYOgiwzIORH15KDGwKtOaQ6IJHuVZx9XVB0iJpzwTiaxgRQfnXO49afE0IKg129o
         y4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786075799; x=1786680599;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yENHJ+8tN2wzgnvqBRUCsG31UdpOJyeHHd6xMnU4sGs=;
        b=H9ZB01ABDCGdiWziE1BQSyVX61X1hBHbS9w+cTvHM/WMbbmNcYc54gTdjU2/13Zefk
         Ze87tDqvp1f1xIerD1vN12QgMt0Hko9pMYTM2R9an4j1B0fPgqOhadV//SaQRviLIHUV
         sxk/A74eVZXK+y1JTvTZ9sHSX1jRqDtlKtnTkb6IcgenHRHNuGpDaelbLsw8l2HLMnqS
         g9iiqEfRzxLuAtkDhN/1S9Vf9VbZ+7mBpPJf3XV8NmhRRTgCPXlb+97USZpEL0JM8iZ8
         Ly4kVzWnfkJcmSIyHycsv/5xH9P2riZqU6KsC/kvlbWgQci2JU1haMeSbO01yt8Ojyjx
         T5vg==
X-Forwarded-Encrypted: i=1; AHgh+RoVF/qPIvuLsR+sf9TE+avyGWG6i1PzII3T/ZEIucmVNEP+vPYULjPpDq3Z707gUAjnCw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywco4Vug2GQLQM1gTgIl3hj3TtdCF3do6JML0V5+yOQX7WTBuk/
	5Rz+MkKiAM/gKKYyD1wEGiVJSwdD+Pfybyoro6iVkE23+eUEcKv5P0Yj
X-Gm-Gg: AR+sD13JU27dEoM8IFwBchLKZmDhWwJ1L1LBcJxgykJuy0yTeXujzNoq/AxEq43qfMj
	0Xq3Hp+EvN9kZbaGtzDZCDg0VDq4DsmM9KBq+1+tpS8dn5FKOX4ej1ea31fCgm2WXA8xuN43Xtb
	piiRzmU7EK4X49qablDL6p8EKJx0XSMXLhaHhVHM22XbuGFWdIVItxqS36rnW2qw8HzAAoQ1kx2
	9I7gy20wCspRpFbTcjNPXDIaKQYnVwLtjXNA+H+uM6fzUHs4GHSG3WaSYhTXaFJwFd/u/G+YNl4
	AkbrrA+HWAxwluG/J2BDQP2MneyVoa2kWbWEnyslnmRg19McLZDcvVOW0/aI57ut8AN516z9Lul
	P7pODybtLckDllyle5NNX/RNKzecHsVWaaEXBshq9WkG5PdwCZPyi2TbENzfMYcm6mQNT8EDH2F
	tkiBafjGx/I9aF9+5y4AvQ2/0qYv6rsHNoQJ+xJDuOhznhGjxVgKCSLwLAIJ0bvo4d8YnsUpFUc
	pg6iSj3OHa895Bg
X-Received: by 2002:a17:90b:520a:b0:38f:5828:a40c with SMTP id 98e67ed59e1d1-3903c59a6eemr20650424a91.10.1786075799298;
        Thu, 06 Aug 2026 21:09:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dfcdsm596651a91.4.2026.08.06.21.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:09:58 -0700 (PDT)
Message-ID: <26a3964d3d6a6a0e725b19eb81e03743b9c2acf9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/13] bpf, x86: Convert struct_ops arena
 arguments in the trampoline
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 21:09:55 -0700
In-Reply-To: <20260805210427.3218326-8-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
	 <20260805210427.3218326-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 23:04 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Implement the struct_ops arena argument conversion on x86. save_args()
> receives the arena base from bpf_tramp_arena_base() and consults the
> btf_func_model argument flags as it copies each native argument into the
> BPF ctx, routing a marked argument through RAX:
>=20
> =C2=A0 movl %esrc, %eax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* truncate and cle=
ar the upper 32 bits */
> =C2=A0 subl $base_lo, %eax
> =C2=A0 movq %rax, ctx_slot
>=20
> A nullable argument tests the full 64-bit kernel pointer first:
>=20
> =C2=A0 movq=C2=A0 %rsrc, %rax
> =C2=A0 testq %rax, %rax
> =C2=A0 jz=C2=A0=C2=A0=C2=A0 1f
> =C2=A0 subl=C2=A0 $base_lo, %eax
> 1:
> =C2=A0 movq=C2=A0 %rax, ctx_slot
>=20
> The 32-bit subtraction is sufficient since (u32)(kaddr - base) =3D=3D
> (u32)kaddr - (u32)base, and it clears the upper half as the JITs require
> of arena pointer registers. Stack-passed arguments already reload
> through RAX, so only the subtraction (and the NULL test) is inserted
> there.
>=20
> Keeping arena and nullable classification in btf_func_model avoids a
> parallel trampoline slot bitmap. bpf_tramp_arena_base() returns a base
> only for a single-program struct_ops indirect trampoline; other
> trampolines pass zero and perform no conversion. The size probe reruns
> the same emission with the same model and nodes, so the image size
> matches by construction.
>=20
> With both the kfunc and struct_ops directions implemented, flip
> bpf_jit_supports_arena_args() on for x86.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[But please fix the botched squash discussed earlier]

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
