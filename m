Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525351E7C18
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408821; cv=none; b=EgwZ8UBEhLrGdANGLHSXguYmxVG3rA14Ajh0MRMyGFqQQg3vYAevbjgQ5CkbN6VVQ6T0wrCOV5qhh4aBGFIfirIeLZ1mwsdcB9ctk2qon9seU8KXNbh5rX/C6LAh0lLpu3x381Q85wJ2WGBVkXhNdUS9hII0wZVS7FBIbtUSQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408821; c=relaxed/simple;
	bh=ly7hL8qiSYuyFbLLMRZGkLc5DQfNAIPUtrzgZj1Xm8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPi6YJHCU0Z9KRJUu5o+Pn8RiRtZ4PFUYxSJq8kUGQcAWuc00jj5zzQiA7alAbsIKT85fS6+06GmI00LH2gMawBa3Qz2EYlCotMtI1n+Ve/6/CGJNYdYTCd2PsufYJ85+BenPMHpZvwXUFYGEfstCXzULxQm2Cyl8dfOg4SY9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piVgzSz4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piVgzSz4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84536e2857eso8164b3a.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782408819; x=1783013619; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RJbO/x3r5vmrTPfYiw8IE6/+MJhDPl08JbIGC6PUlYc=;
        b=piVgzSz4ezsnxgKZp1Uk0rOpIV1PP2BXDhse8SbXwxti14vsAACnottafyfvNWZySd
         vZHPhtuk5isFOh6FU3jNAkTvwaG0KxWxVe3WqxWDE/pPvUuBvZ1cyyyv5aQbrvGWM2JJ
         ajHMceSfp6SfvjUdXDh9T/HHjfIszKHwFjxZD8uDEx9hG2pDeZYPcGEEFRitCdXAxS47
         OH2jpkGwuoYb/d6NZ4v2L5s/aaFaQiem9mCA4ADPAHHXnf92myDORzG7PuKWkHC7U9at
         EMwJ5xihz5diIDxmMmuZfwRspzjHenF2JsFnhYWsEhl37RrFn0QnnwwudFt5OQv8DxCy
         WE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408819; x=1783013619;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJbO/x3r5vmrTPfYiw8IE6/+MJhDPl08JbIGC6PUlYc=;
        b=UkkzkjEMfdN3PODZa8AyfeReLZ3fKfg8d8kSiT7UfpL8BsITOD63XD7qhRrR4Kz3dh
         HHIUZWyC5EglZhnwFZkFQ+1/jfrylJp2oeg2gpY6d7YwfA92MO/aslIGl3MNhDG9xcc6
         5Nv+s9eTspo4Ewjx1LbGhPtpf9eMknlf4m+9y4jUffyf/DsTfFayfx80rTrJJri3IPmY
         qDxvDeA1ygkARJUma/Yf6AHKqbe91pW3nBP9xKI+IYtnyeGiHgB4/AOy3IteGlMJIpNK
         pD2bi+oGj2sWUIDKmjtyJjkFGEGQ0rhV3p32NF4zkPtrWM56vBmbqqt2Xp80HyArLzFH
         hz8Q==
X-Gm-Message-State: AOJu0YydethfBY8+aR4TmiqBjJBh3WqFtTfOS8vGritfrQu+o0COTuwB
	qJX6YeE6k0stplQpSYmAJCM0LuUJ4AS86nFioJDRFctqQ8zvZTCg7zfv
X-Gm-Gg: AfdE7cnRIPXrqZ/H+roytCCYJdF3+DQICa5z1PJwtdXzgGxwu72IgJTfsgqusEEBRZP
	UN0CO4AdUqnpg1KnPpfobzr2JsdQw/yymELxAEOi4lsTtDlKF44TCuQKz/TL00x6TNnLqEu1Hob
	LYoJlraTIdOpZuycPOtOzHnHpgy5L3OgPrnKSCZxZlui+Vr6xMS/1Sw8ylTFrPmHyhE0i898pzB
	WKA7wVsAzO3NXy5lamO2nsKmwojYOSLPrP5i/1b4ISy5TGm9r7JOGj64BfY6hm3ABlpw7Kh9Kj/
	f0rhxPJXdPhpw/nG9sV1MX+/Vqa091sF3tq2uFTFPEbWqEvp7WOfCTmQBfhcguabcbvpNRdT+YF
	kMIxEGe2PwenCJnn0SrVFLCa7pmMijBTpz288RpmNkDTR1KAOCp4PrYgEilbw+dv3biYJSTVp7M
	/zoUolNhloPqtTTtFXEHqrqP1hQnTWOqSl+ocJvDsFNw==
X-Received: by 2002:a05:6a00:4c95:b0:842:432e:b7ff with SMTP id d2e1a72fcca58-845b3ac78ecmr4455346b3a.17.1782408819390;
        Thu, 25 Jun 2026 10:33:39 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4121fdbsm5082163b3a.51.2026.06.25.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:33:38 -0700 (PDT)
Message-ID: <b3dffc1f523e078df20e9171b0bccc74ddae53e3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Preserve scalar zero spills for
 stack reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, John Fastabend	
 <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 25 Jun 2026 10:33:28 -0700
In-Reply-To: <20260625-bpf-stack-var-off-zero-v1-v3-1-a068210a761b@gmail.com>
References: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
	 <20260625-bpf-stack-var-off-zero-v1-v3-1-a068210a761b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-25 at 19:25 +0900, Woojin Ji wrote:
> Stack reads can read back bytes that belong to a previously spilled scala=
r
> constant zero. Today mark_reg_stack_read() only treats STACK_ZERO bytes a=
s
> known zero bytes, so the destination register can become unknown even
> though every byte in the read range is known to be zero. This can lead to
> rejecting otherwise valid programs once the loaded byte is used as a
> pointer offset.
>=20
> The original reproducer uses a variable-offset stack byte read emitted by
> clang 22.1.6 at -O2/-O3 from a small helper-based BPF C program. Fixed
> offset reads have a related mixed case as well: pure scalar-zero spill
> reads are already handled, but a fixed read spanning both STACK_ZERO and
> scalar const-zero STACK_SPILL bytes still falls back to unknown.
>=20
> Teach mark_reg_stack_read() to also consider STACK_SPILL bytes backed by =
a
> spilled scalar constant zero as zero bytes, and use that path for both
> variable-offset stack reads and fixed-offset mixed reads. Keep the existi=
ng
> pure register-fill behavior unchanged.
>=20
> When a zero result depends on such a spill, mark the contributing stack
> slots precise before accepting the const-zero result so pruning cannot
> reuse a zero-spill state for a later non-zero spill state.
>=20
> No deployed-program regression is currently known, so target bpf-next.
>=20
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -3929,7 +3958,10 @@ static int check_stack_read_var_off(struct bpf_ver=
ifier_env *env, struct bpf_reg
> =20
>  	min_off =3D reg_smin(reg) + off;
>  	max_off =3D reg_smax(reg) + off;
> -	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno)=
;
> +	err =3D mark_reg_stack_read(env, ptr_state, min_off, max_off + size,
> +				  dst_regno);

Nit: no need to line break, the line width is 100 (here and elsewhere).

> +	if (err)
> +		return err;
>  	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
>  	return 0;
>  }
