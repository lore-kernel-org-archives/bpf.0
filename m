Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76835B64C
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786182586; cv=none; b=U9EXdCj4257fdr8uPYN5ErBctCxzXF8w/cFJjeq7eMKV7l56LtSHFKxodMTBrqSi5Tj9JfyHSMr8NIOdc9weLp9oS2c8t7TyzrNahbPQDS5zzcM3KJDOotWgz9UCsHeM3Y+Iw+3CK1iDBJONHRHqwAbguaXlzI7JQMPikzSAo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786182586; c=relaxed/simple;
	bh=PKFb3NysQ3tfRfvdP4tJN7C8hUhMqIoUf49jk8RBpr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GuOtpr3xLEpdB1S77M5nksR0Gg3MvpoFb7cCqHZxL5Op/pgYwwkaYNAXWkGHzP8m4qawpA3ni7e3+chp7tFrj5cbUpkbLvpAz+znPGYByBsCJ8KTuP3QX4/PwyMdVWZXb52eJ061TTFB7iqyhYc+uj7/6WCi1flAjTa7wa16Mh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck8LdcbP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck8LdcbP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso3198705ad.0
        for <bpf@vger.kernel.org>; Sat, 08 Aug 2026 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786182580; x=1786787380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PKFb3NysQ3tfRfvdP4tJN7C8hUhMqIoUf49jk8RBpr4=;
        b=ck8LdcbP56JzyQDujRL5qnhnt0DbE1s2rFXcP5EK5NMw5mgWgIzuWjF093a9gdaPem
         ON2y067R1rNrdzFj/sejiAi1pAS2kPxkqq5QQ6/pCuQHlzPKD2waWKlvihJvkg3KA3A7
         SYKROWEtaSyDMGqB9cLhXGF48+WBgwhvs0lYYigz0qPZ+oF7wWqatA7SzHdvMCYcysln
         Y73dxIem48IfhMvTELXl0cvjo8FQrHxSR9r8yRLAWlJ2an1tLE7T4Qrqrw7y8+wnjy/s
         j+m58HchpsfGqkvhiFoM3V8NsiKncNDQ5n1MM0Zx8nQqvk8g4M63fpnhEzbJTjI9JXim
         gSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786182580; x=1786787380;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PKFb3NysQ3tfRfvdP4tJN7C8hUhMqIoUf49jk8RBpr4=;
        b=EdVhk943P2eHH4dU6HsHSkH0CxTe3rqe6z1ahQ7LzDiGk2fVq153k3Uedbi6tf2vQS
         diySOLf7/99UYXASU/0o6YDXCII0qEH/wgUhiL0kQOvDL7fIM1F0rMPGlSMjSLZ8HL12
         ErAp5U85gtZJGfiOzcxvggM+Fu1NqSviHhTxJNafvZZYqBt8z3/5zqvFVPVXGdEA3G3I
         rPWKtbFQI3TL8apeig3pfVellCZ45bP3vMUUsZF/B1qDWGc6OfpuGT+rW+Rjp3Xg86M8
         6yQrHTROhzQv5sqNWF2WF6ofTqbPO761+fo4iTt2s88KUzyhVdAs9PmB71XXEW2M1gzV
         hWwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpo+Nv8II/FIxP9z7u5sk3KUShb1qLlPVKDj5FnjPyH8IMrB8C14vCPFdWXr3zMtL7d53k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBi0YwvxUE8vxm7s0ielAAS2sfFN+WoMetI7SZlcNZzgCjrN7
	s1qT8H1lxV1Z+7T96CDYrYNKFacETQlp6Osfdcqvk2E3QMhfU9vURs1j
X-Gm-Gg: AR+sD10cPLz+OfvUfpfrbwxv626i02uzQBgzgZur2ZLh3rzBcM4KnAhcwvDPuVZuRlI
	yVRli1bnGwcHfBgcAzxncK5Sc1F/UMLYASRjsJPk8nwxvpZHcJbZevbP1KpdzMyJTj2GxjqrysZ
	CuCSCXz5Vgtys1X3RBZsDLzk3TTdU565OLVlwkseSaYaMAxoSRlyP+6VHO4tmYtOf/6t3RtvNYy
	lUhYwDnprW89smqQNYyrTu8/uV9R9QDtODRFyjdU+qeDU8v7/XtyN2dGBaprcLfjMmPBHD93TTv
	DYCKbRJ6qTknxEzeJBTHEsHS8dr7aMJVSwDiG7BWxumLa3dfsJwImlzf3Mov9QvsgeSx9PXIjxp
	dXQ/a2x0aiHjSHUYi61JPXzlO2wNy8KvkdpLeGbVn5tEj0JQslV6j4NXUyA+nzxBP26Fh1atlrd
	2mjd5yyZlHgQfJENOMHpq8Ew3LQnvmcHWjfo3jsFh7SDBp+Yawkthm4S65f7Pucgp2Sx73g1kys
	gyF5bMrOXs6N+xN
X-Received: by 2002:a17:903:390c:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2d2b2de9798mr26662415ad.10.1786182580118;
        Sat, 08 Aug 2026 02:49:40 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac104sm17701935ad.10.2026.08.08.02.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:49:39 -0700 (PDT)
Message-ID: <19fa54535e6e94d3ec447cc413413db756456a9e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Support __arena and
 __arena__nullable on struct_ops arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 08 Aug 2026 02:49:36 -0700
In-Reply-To: <20260808003938.3486067-6-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
	 <20260808003938.3486067-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 02:39 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> A struct_ops callback cannot receive an arena pointer directly, so
> passing one takes two steps. The pointer arrives as a bare u64 that the
> callback casts, and because the two sides address the arena through
> different bases it also has to be rebased by hand on the way in.
>=20
> Add the __arena and __arena__nullable stub argument suffixes to make this
> convenient. The callback declares the parameter as an arena pointer,
> receives it as a PTR_TO_ARENA register, and dereferences it directly,
> while the kernel caller just passes the natural kernel arena address
> (kaddr). The trampoline converts the value while saving the arguments
> into the BPF ctx, ctx[slot] =3D (u32)(kaddr - kern_vm_start), so the
> program never sees a kernel address and nothing rewrites the ctx after
> the fact. The converted value keeps the upper 32 bits clear as the JITs
> require of arena pointer registers and behaves like any cast_kern'ed
> arena pointer, so cast_user recovers the full user-visible address.
>=20
> __arena converts unconditionally and the kernel caller must not pass
> NULL. __arena__nullable preserves NULL, tested on the full 64-bit kernel
> pointer, and surfaces to the verifier as PTR_TO_ARENA (but not as a
> PTR_TO_ARENA | PTR_MAYBE_NULL). The reason is that PTR_TO_ARENA in the
> program's type state already encompasses NULL-ness, so it is not
> meaningful to force a NULL check for the program.
>=20
> The composite suffix intentionally ends in __nullable. Classify
> __arena__nullable before the generic suffix so scalar arena pointees do
> not take the generic nullable BTF pointer path.
>=20
> This patch adds the generic side. prepare_arg_info() records arena and
> nullable argument flags in the struct_ops function model, and
> bpf_tramp_arena_base() returns the arena base for a single-program
> struct_ops indirect trampoline. Only that trampoline converts: its
> program's arena is fixed at generation time. Generic trampolines can mix
> programs with different arenas and reject arena context arguments
> defensively, which is unreachable today as only struct_ops programs
> carry them. Architectures that do not implement the conversion are
> gated out at verification time with bpf_jit_supports_arena_args().
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
