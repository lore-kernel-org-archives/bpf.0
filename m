Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042800;
	b=BjCGDvZAOnIbyYkZLfyg2bmXyzWEMY+W76xiE4FKoiMwisYnhj7q+FkIZ7S9jwHlp5zN
	 NsMqkSYG8oD2i/h8gDCmTU97uTcLB8IiAy3E5sfm6VKenOy0RhN40x5fJ51j8QuSA5sOV
	 Xi5FJPoKa8drnYZjgouD4/L8F3aQhqyLVXyKHo7Hr3thilUomPW19WFkZnjS9CrbnQvpV
	 fZiSueYxyf66048FSX70/hpScmbZcDVcyUX7ozPFU5/Pc3VVycHkwxdVycb4it2/I3Z9I
	 wL0XCWEL9U44X+wS2uJIFE7iw8oJPUpl2biqrZBRA3F+YZsWNy8KHOaq5gwgCvx1ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LBiQjXroGIgbRFbCXNC43q/C52U0JtTLkOoI/rutDOc=;
	b=VE21DCwybA4uE1GItmoVLGPmpcueU55F1x3kodyLu0IsBr6w0K1Wg7BQbdtmkml1/EDn
	 6yf1rxirtKdn2E7rOKvySqNaNnDzzaPE8mExuEkyY3YZ0Xjpm65yBi+MRuFaJRH3VZfM6
	 2XmTNisIgKsV6gKzqy7KsINM2DqJ1X5go7QRqu5jzWWbTgLvlbUZwlgcnlycMMCCtWA/a
	 8Vi3POzsuCvS7o+wAQ2tUIBBDM0gpU0Dynb+aPCIwIa9W6ek/5mnRXfJ72Eg7h28nf4jh
	 Ki9thzoPCzsSM4u5zydhCQG8EJB371ieCby2jMnaMLU84EstLGD9yXlyDkC8KRYQviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fK2Nph+L;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEB606A335
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CEB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fK2Nph+L
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so907561a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795042799; x=1795647599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LBiQjXroGIgbRFbCXNC43q/C52U0JtTLkOoI/rutDOc=;
        b=fK2Nph+LESqq7ov6ugJUsX0MzNHngmSsLwq4j3z9Ls+6kKA0V7OWOjf2BI8RW7bYfw
         eISYq3SbxZjr1dIfgpUkaYPAFAE0fXzXpIrDbATgeT4Cv6NYCrU9QALE+6avPv7yVW1E
         +2DPIYTnXqsrJINH17hg8VK3NeFXcnHgeOw4fsKrIOnZH7lYybYBnAeXSpXJGT/VyLMy
         SDrLkERtVIs8K4lNUA2LyOBQNvM+N1k/T9Wu2wemwuli14YawPEho9RV3hJe+QLZGmci
         aG5km4/kZZN6RLlSxfx5mKdLVDu1aKDkT41DSBrIgSHVOv1FnI8vgOxX6rHRz2w13Qbl
         t2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795042799; x=1795647599;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBiQjXroGIgbRFbCXNC43q/C52U0JtTLkOoI/rutDOc=;
        b=ui6pAE3phzKNhP8uYs5y/73RNDCXqoGpiCl/kaCYm72pPuhztFrSGBtW6jcZZqt9c1
         JAZc5gWpRVV2W36JZseufcGEtWp662svI7baFZhhW7FqB6F/UQ1cv3Jn5wPc4EQRGaMg
         qwKdkj2QaIeulb0zTTXcg0her+Gct0sMfdk2JXw5oTJ3wbmO6RAHNwtonYWxdiuW3QyB
         VVtTpcz1AhmyHu6GZG9k4YWZyiPGPQVJnVrMYbnC0r/j4lu/7GgWUv3W+o6v92Iv31Ub
         pvWZZeTqMMTnB0RaMxUAVDlOQcHHqYYopsF/aigSyflVeQcagW7QkRn5QY9P02CLPW4A
         /0vw==
X-Forwarded-Encrypted: i=1; AL+hErGgbt8mSAPYtEAORkCQDC/8uz5x632H5exmwDrghCwA6tM0mOy8eCANWkL8GZURqHs/7r4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4LPGPuDWtw5+ZP9YPZ5xlS8KYNiZTHi2L7m89Z4+VF3FSpX+0
	418mNyN3LQsRQ4PqK8RT1W8Pek6qxCEUP1U9e3BtVAivKhXwvXzHUh6V
X-Gm-Gg: AZFdTZfCpo9Y/OTROEkBRjXvYBi0/Kt+LvMe8Egu8EBtQnzSuCu0KqLBCY/J/dpcoVV
	7bsjKESJepxEaE3BxeUX6S7SyyX4oTGMrnqU0b4VC/R5ysxWljtun9gUFXUhODDBMXQIyPEOrDn
	fNPq3kxpTCxZgd4qcI5A7AOAwlJFm0NyDKXafYYvDVsMR+aaPahy0sRn+vLmlWHkloPX4Q/1UCT
	5agWdMrD4UCLGxskFGhlUoF18ctNj+AqoGJzQp7FSDk7o3cdoJhdXwrh+azS7rdGpWHOWDkHM7c
	aSxqWv87lAiWGhsIx1WV/VGuNeZucOgTn7ADiZtMcD76BlcHiGmjT2rrM7D0/RBL+lTn9uvhpwp
	OZzwRHOsoRmY8Bwg3H84Zc+PRf5J0K8SMf7U4q5wBtdx3/hnLwehCnLL+ag4LZLYTHJN1Qt9r3f
	n6MlznEgCeCHLCq3nJoctMDjjJFeGwIOEWh4OIJbBk+R40wj5KkdZo6WnMF1tK0EJnElRJQKNNw
	rWj6V958GjQIcwu5ft5NDZOJ5TRy7VKLHHPQW++k/FsIlWqKnQtpxYpFk3Vmi4x7NAB4bQuEEr/
	7Oyp0b/KEyuhEpRHJ1ceb5DpsfetGK6JU10Owo5ciGC+qep8UaZFjrqX
X-Received: by 2002:a17:90a:e7cf:b0:3ac:8dfe:8ec9 with SMTP id 98e67ed59e1d1-3b3d07d45ffmr3520075a91.47.1795042798682;
        Wed, 18 Nov 2026 14:59:58 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534de506sm595959a12.27.2026.11.18.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:59:57 -0800 (PST)
Message-ID: <a838d40d84ccf3115faac3d3b7b4d91b923b03ff.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] resolve_btfids: Reject kfunc families
 that libbpf can't disambiguate
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 15:59:56 -0700
In-Reply-To: <20261117192153.3384031-4-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <20261117192153.3384031-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> Kfuncs sharing an essential name, foo and foo___<flavor>, form a family.
> When resolving a kfunc foo, libbpf binds the kernel's foo if the
> prototypes are compatible, and otherwise the only family member whose
> prototype passes bpf_core_types_are_compat() against the declaration.
> That is only safe if no declaration can be compatible with two members
> at once.
>=20
> bpf_core_types_are_compat() compares prototypes kind by kind, so it
> acts as an equivalence and a pairwise check is enough. Run it on every
> pair of family members after dedup, using libbpf's own function, and
> fail the build if any pair is compatible. A foo___<flavor> with the
> same deduplicated FUNC_PROTO as foo is an alias and is allowed: libbpf
> binds foo first, so the alias is never picked in its place. There is
> only one foo: btf_check_kfunc_name() refuses to register a module kfunc
> named like a function in vmlinux or in another module. Dedup compares
> parameter names too, so an alias has to copy the signature verbatim.
>=20
> Recognize family members by their bpf_kfunc decl tags rather than by
> the BTF ID sets. The tags are what libbpf filters candidates on, and for
> a module they also cover the vmlinux kfuncs in base BTF, so module
> kfuncs get checked against vmlinux kfuncs of the same family.
>=20
> The bpf_kfunc_flavor family in bpf_testmod passes: ___v1 differs in
> arity and ___v2 is an alias.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0tools/bpf/resolve_btfids/btf_colors.c |=C2=A0 11 +++
> =C2=A0tools/bpf/resolve_btfids/btf_colors.h |=C2=A0=C2=A0 3 +
> =C2=A0tools/bpf/resolve_btfids/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 134 ++++++++++++++++++++++++++
> =C2=A03 files changed, 148 insertions(+)
>=20
> diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_bt=
fids/btf_colors.c
> index 5d307d70e7f2..91c10106319e 100644
> --- a/tools/bpf/resolve_btfids/btf_colors.c
> +++ b/tools/bpf/resolve_btfids/btf_colors.c
> @@ -13,6 +13,17 @@ void btf_sha256(const void *data, size_t len,
> =C2=A0	libbpf_sha256(data, len, out);
> =C2=A0}
> =C2=A0
> +size_t btf_essential_name_len(const char *name)
> +{
> +	return bpf_core_essential_name_len(name);
> +}
> +
> +int btf_types_are_compat(const struct btf *btf1, __u32 id1,
> +			 const struct btf *btf2, __u32 id2)
> +{
> +	return bpf_core_types_are_compat(btf1, id1, btf2, id2);
> +}

Can main.c include bpf/relo_core.h instead of this symbol-laundering scheme=
?
Or just define two extern prototypes?

...
