Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734725B0B3
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679139; cv=none; b=gD6FRT5igv2tX9oCMMcc/pDR4JVyx6n7b2Oo4EXRhAWCEa3ZOX4wuPsQUsWuqFgjLm3ExMUG0V90YoIt5Bl+U+ZbVLNaDrc6Sg4i6JFD9kfG0V3r907qM+ZIfB/9cPrilGP/qUVJ9ckFd6/HHf1BSUE1xnNABtCZ363WthfNXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679139; c=relaxed/simple;
	bh=INJwYTrSQ3WAovcuijCA3YELaIRjXjzM8P0z1g5h5Ag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5IuWkuOUNcEmDAsY81y02iR6kQwvnBXWGbCY58GNsJe4exOTYQp1RKqMbdv+0CNijwZ4dFw4q5QXYdbTW0wari1yu2JQ6cIQE2vzGuhB7QV5jqK099fuwoEDKhn/qmSeH+m6xwUXB8b0ChyESXJVUrUPC1Yfzafo9KU5Xzq4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToV//2k3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToV//2k3"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca7c1176317so8768831a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784679137; x=1785283937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cWKpfdDZ5rwahGdKmtliUWjX0cNTR5TraqAEREqnMtI=;
        b=ToV//2k3xpy9GDnRpv5mpAzagZ8Y9EAsbyNTwifQW1bDq2xHUmURlHh/ebdqo1AVQE
         N/KDBsEYSiuCFOqVfwhuQO529qBgnZgPsB4hKovZg0ZPkrfe8iJYXddQSnCTsPYFtqA2
         WJGrKHH8CDrUYV3vnVEqyaFtFA+FEoPX7y3jWC5NddglaiNwNrxNPX6DqTZnb//HeI9Y
         CJahrxx/o6A97hKnUC6q3rEMkc221q2BuswM5HzVaYu9nXMlhe1B2eTztJFy7wiI4x5y
         FFBkflxifoty2gZLQot5UGdIC9K9tvUpkWvcqbji3yCr23NKGCF6q7+jj+4G3ZPIkIlG
         ByTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679137; x=1785283937;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWKpfdDZ5rwahGdKmtliUWjX0cNTR5TraqAEREqnMtI=;
        b=d6y7HQ23oBlpNJWD/nHBbd9pfij/yK5qgHoOQVbOyy0+ZxzH0r8ChjAdJqRGPv3rc6
         6A3qy53qjhXNK+7kQJRYFOPMVKXIW83Uz9M6F+jGmTJmbLaBOnYOc3RIo6NNtL4XkYOg
         HBsSVxSjRkz+Y5lX5T6E5JdRt3A5qzbhtyhgi79IHJI/BOGmUD1nKkHb+DJ34z7i2/v3
         51tfcAIX1ZE08TPMWYY8ggQ2dR7hZpjjTm9u5TeVEnZE55Eq6LW8ZyTFA5Ki7Pc58w0F
         p7YFjOTgJRWyUZhqtqU86v2+XhLNvsaOpxA+a7lRFxROfSgqbhyFs0WcYUihqaY9Rhqg
         co6w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3+snALwmFpHcluqeV28/PyiJP/Yu/dxoTJfVArmxLc2NEocDSsqFK+WtSgee2SDyfPMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGDE7ZKvcypm2SK4STCimBvmcuHfW5/1tLuUplkCKjWrqAEMB
	WRKkW8gOI6JF620FNf1nIKiEF77muFoqeyKv8FcIMq39T+qmUw/GxhBu
X-Gm-Gg: AR+sD101hQdE7pxAJiCMcbLETa/fc3czVHJWSNYjLV2NgUQkcb1wmv2HmaKpyNUmsSg
	OgcXzWsDSLleln0A2SMO2F+mU2Ybf8BfJa1DOK33XFe5wNSdSGjiGARB4XXb/ny4sw+kCV0aStX
	/sg0nn/HrNuIfeE5Hlh9QKDyrwV/cGbzCgi2NlVUd/osrhdcMxn0rbfLOIa8da7/cWvrfNzRgjv
	rk/hTZXdpVwfRbd7a39h6rJdpH09HvkBHzK6aCa9GLvCRqRz62m1lXwNw7GdUtydtPB0B9b9UC2
	CUrIvurnWYVYU9r2i1cONgwC/hFP/SUZf13/lmxh5BrFY3NTvYx6BZ6pe/RwvvAEJYgirYzELi8
	KHTUBEvCANltbw+95vIMryHliJFSs5H77vFlUUIIoMsHW3864O4ocsHz6sSgRh1G/6dPh1o7rsX
	jp8blVOdN+Her353DRp0L5JdSWkqOdGECnaUnduviDnb2wQeM0l1aGsqSF
X-Received: by 2002:a05:6a20:734d:b0:3c3:69d0:c573 with SMTP id adf61e73a8af0-3c3adaae79amr21522093637.68.1784679137427;
        Tue, 21 Jul 2026 17:12:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cda2:e912:7f2e:f787? ([2620:10d:c090:500::7827])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df06864sm2786421eec.15.2026.07.21.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 17:12:16 -0700 (PDT)
Message-ID: <976ae2fbf6f2ead76622e39813bfda6a6981d382.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: Preserve stack frame number for commuted
 arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan	
 <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2026 17:12:14 -0700
In-Reply-To: <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
	 <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 09:39 +0000, Yiyang Chen wrote:
> When scalar +=3D pointer is handled in adjust_ptr_min_max_vals(), the
> destination register has to inherit the pointer register state from the
> source pointer. Copying only selected fields is fragile because pointer
> provenance is tracked by several bpf_reg_state fields.
>=20
> For the commuted form, pass a temporary scalar offset register to the
> common pointer arithmetic helper and copy the full pointer state before
> applying pointer arithmetic. This preserves the frame number for
> PTR_TO_STACK registers and keeps parent identity fields consistent.
>=20
> Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce0..3c0af83db4672 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13796,11 +13796,12 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
>  		return -EACCES;
>  	}
> =20
> -	/* In case of 'scalar +=3D pointer', dst_reg inherits pointer type and =
id.
> -	 * The id may be overwritten later if we create a new variable offset.
> +	/* For 'scalar +=3D pointer', dst_reg inherits the complete pointer
> +	 * register state. Individual fields may be adjusted later by pointer
> +	 * arithmetic.
>  	 */
> -	dst_reg->type =3D ptr_reg->type;
> -	dst_reg->id =3D ptr_reg->id;
> +	if (ptr_reg !=3D dst_reg)
> +		*dst_reg =3D *ptr_reg;


Lot's of tests are failing on the CI, please investigate.

> =20
>  	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
>  	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
> @@ -14854,15 +14855,18 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>  					bpf_alu_string[opcode >> 4]);
>  				return -EACCES;
>  			} else {
> +				struct bpf_reg_state off_reg;
> +

We store such temporaries in the bpf_verifier_env to avoid excessive
stack consumption.

>  				/* scalar +=3D pointer
>  				 * This is legal, but we have to reverse our
>  				 * src/dest handling in computing the range
>  				 */
> +				off_reg =3D *dst_reg;
>  				err =3D mark_chain_precision(env, insn->dst_reg);
>  				if (err)
>  					return err;
>  				return adjust_ptr_min_max_vals(env, insn,
> -							       src_reg, dst_reg);
> +							       src_reg, &off_reg);
>  			}
>  		} else if (ptr_reg) {
>  			/* pointer +=3D scalar */
>=20
> base-commit: 0bcca2a42cc50b7d64a95c08dffc6b93661a7ea2
