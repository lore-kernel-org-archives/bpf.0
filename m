Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A54305E28
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330569; cv=none; b=jmD4ESWLz56MtrkKjD7lruGz19D/8IayMiFvU4gceL0m5EoO6dctKe7zT4UA7QftKUCTctJFw65NdskkvmB+QGNQ7sL9EK9AidiNNngsimRvowrUVKU3Y1ONFC2SeVtHaq1UxvjjdnFbaw37GQN4qpMcqawu+VLY2kVqv82L9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330569; c=relaxed/simple;
	bh=0oMU3uK9IwWmaU8jQtMqaCl2EVZdYxk5BUMpcRcQof0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiJMZ2Ot71mG1fEmKvFoLHz/y+9aJt6QRLnALS5HUW40mDJYj/Sx2y9mcSYguERk06mo99n6B+Z4j+swja2X7oHdiPv5hnXtPp0tKFqoVNRU4nTQMUscc5WxdiVIOwq6/stnPa8u/Agw0TOw0FTy2NfrtP9b2QIb4qnEUwgbPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQNEnNTg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQNEnNTg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37de8008910so631382a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782330567; x=1782935367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=chnBHK2BDYEEN5dW/1bTJPFgMn/1nZToeYO5HSTFJ4w=;
        b=HQNEnNTg8jBGJKiZiCWpJkE6dHvbGfNuIDdjDHBuJNc+D95vHGbca+y3kI2s9vZMjK
         fZzH6L5Rsn3Ij9qpe1soR9Q/j0Udef30rIBYN3qkIN0sNpF87i/XbCT17FBwZPAk6Be3
         HlTdw0nuIBLdq+txfHnNbj9NPSA4KIJYJ6AQwzG66K3Mcm56g4KMZUXh8PXiHML29JDp
         lPZVHf7m6vcZqhtn+34LqhIXsh2kCZhuKgMxSYP4Wzj76v/nKAcxlsRoS/Zl4G5CGFr2
         lkaN7c0A3KfDHH4OFl3Kozwt+W9j0Q6OLfBWxRpqH31Ub1IFOFOrTWd5kIfEelLgwJe/
         POGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330567; x=1782935367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chnBHK2BDYEEN5dW/1bTJPFgMn/1nZToeYO5HSTFJ4w=;
        b=OUYOJb4oJm8lwJVW4lZzQhU9OeqVNZAYIJBu89ZZVo814qN9rZLeCz0QjW9mn78FRk
         QrKGevv7ITNzGRxYMIfaFscSfhTgIFJd3V9GLy8M0fDokjY5UQeE0Nkw5oHa4dqZuNFs
         WShD0v8YDIwweHNNMAkGr1TKPx2eIWBc4Fgkx+Y7kIRhkbkpntdjyQYiDWbHwKHwa6lc
         z2yIaChcYOW/DWZzmIXOHXtpe/1oEaDy3U6BB58sKgGkfheAPNDwBB36rZVxEJy0N7qe
         AeC/DG6MUL4O/JX/ySfmNXZWySaihqh5FkpB1QsJPwq3dlCs0AD4p0xNkd5hYz9tEr1o
         vDEA==
X-Forwarded-Encrypted: i=1; AHgh+RqJ2zVyNx39mRNb4B0xrjB3dKWE0UcRRx5bdsM+Uja9CBgV+Ftea8bcIebBODpG9Z3NRNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOSWiQCOdZLKnhAx7lpp/g38BVyucgNszHUAuC1RagPPOzYWN
	zyBV15G0Ws/qdprNkEswJVa2M+OBzZOZ+psPQKvbqE9FxNNs0Ri8cXCM
X-Gm-Gg: AfdE7cnpKWrOoInyUoAtEhEotq+hOrF15tnp+lkMbhdNwAmhsxKMY2Arjg4iWIwkAOB
	d34vUgQkm/8djduv2qTtJp1T1CCGDFY7KdRNHDDdIaJkmjtS3+9XkRkJ40LU1gAWQJy23VCKtnh
	mkAwwzkoz3cLuTzY6ZvpE4AO/7ZUpkzCAtdMmMENiylcGJjhPSoRBFf7WcrlgF/TyCvgyFWyA0v
	JQE69tAFRosA+gT5MlJDMYDX6n0F4Nc+QUVfm10nlleW80fmbp/eX3Cz+8MRR8MtxMRIR7Rev3/
	WhAU/tGnbFDHtQO/yVzU1V5rIAk6HizhciumKrjMF1ydphrJMnYcVJfDdGL4ASHXUh7q92K2aJM
	0If79A+Rat1swlR59SCSJ2AlSX67vGfdzWePXqpiq5uaeuBEFr82q/ZFX65sReyG1HWWf4ZC8pL
	gEyLMyeiV1PCfxLrhfOuC1xxNaDfoS3O94hEj6cYYBvw==
X-Received: by 2002:a17:90b:524a:b0:37d:f4c1:ad82 with SMTP id 98e67ed59e1d1-37df4c1aff5mr607553a91.15.1782330567098;
        Wed, 24 Jun 2026 12:49:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b41406sm423213a91.8.2026.06.24.12.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:49:26 -0700 (PDT)
Message-ID: <df2bf4c0205f8c8395736c687aa4e293850311e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/17] bpf: Track verifier reference
 diagnostic events
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 12:49:21 -0700
In-Reply-To: <20260619205934.1312876-7-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Add reference acquire and release events to diagnostic history so Resourc=
e
> Lifetime Safety reports can show the lifetime of a specific reference id =
along
> the path.
>=20
> Record acquisitions after the verifier assigns the reference id. Record
> releases only after release_reference_nomark() succeeds, including the
> kptr_xchg RCU conversion path and owning-to-non-owning conversion path th=
at
> consume an owning reference.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1536,6 +1570,20 @@ static void bpf_diag_print_stack_slot(struct bpf_v=
erifier_env *env,
>  			       off, fmt->old_buf, fmt->new_buf);
>  }
> =20
> +static void bpf_diag_print_ref_event(struct bpf_verifier_env *env,
> +				     const struct bpf_diag_history_event *event)
> +{
> +	if (event->kind =3D=3D BPF_DIAG_HISTORY_REF_ACQUIRE) {
> +		bpf_diag_report_source(env, event->insn_idx, "acquired",
> +				       "owned resource (id=3D%u)",
> +				       event->ref.ref_id);
> +		return;
> +	}
> +
> +	bpf_diag_report_source(env, event->insn_idx, "released",
> +			       "owned resource (id=3D%u)", event->ref.ref_id);

Nit:

		char *label =3D event->kind =3D=3D BPF_DIAG_HISTORY_REF_ACQUIRE ? "acquir=
ed" : "released";

		bpf_diag_report_source(env, event->insn_idx, label,
                		       "owned resource (id=3D%u)", event->ref.ref_id);


[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fedabb6bb515..93941deb2cd8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -9140,8 +9141,12 @@ static int release_reference(struct bpf_verifier_e=
nv *env, int id)
>  	if (err)
>  		return err;
> =20
> -	if (find_reference_state(vstate, id))
> -		WARN_ON_ONCE(release_reference_nomark(vstate, id));
> +	if (find_reference_state(vstate, id)) {
> +		err =3D release_reference_nomark(vstate, id);

I'd say that bpf_diag_record_ref_release() should go inside
release_reference_nomark(), but there is one odd case with
mark_ptr_or_null_regs(). Almost like we want __release_reference_nomark().

> +		WARN_ON_ONCE(err);
> +		if (!err)
> +			bpf_diag_record_ref_release(env, env->insn_idx, id);
> +	}
> =20
>  	while ((id =3D idstack_pop(idstack))) {
>  		/*

[...]
