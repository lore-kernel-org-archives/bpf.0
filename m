Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010243AEF24
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751641; cv=none; b=IsGpwi+o2lEMpRWNZIVegVX8E8rIf/+iuwue8CZYaxbMAlUIxBD7HSt+uxiEANXbSkKRdNizW0iojuvWz1trSJpI2Airr09/3219wg9O5ShoevrBk0rQB0Bb6MUiPKJA2c7potM8mGwgaSxe3D7EKFy5RPEAldpz2sxFgHvYSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751641; c=relaxed/simple;
	bh=TxxDycznLnEcuoVDlfdVYoYMYrXtGCWYEgr/QLRm4Kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJTV83xHqnuT0lUVKLKOhhlCLR5RAnGKAUPepxNA01Aj829Q4qZccGWCJitzUbeMqnyWriJTyNg3tHCWG7L6d+C3Dt4dC5i/BOxmv5tnx67kD6kRPoPUEZGHsSFniBPIiIYoCtfGDoJ4qRNDU+PQln+5tGpMmOi0st+aIp6CzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de7RoxVg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de7RoxVg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1639674a91.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786751639; x=1787356439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g/QKu9FenL3NLIzw2yss8OaOMInxGZE93gUwAZCW7GU=;
        b=de7RoxVg5xMIVcClM8gwzVHjP7QRZBE8u64/aAk774gwiHZwa84q5TaYjXfKOAjAkC
         dGv/a66i1hFSb44ykc0OARJCKDXHfKVQpcsDIravmCMauq+w1qYArwOu5iKt5BsRDt8k
         3FbGTuNKw/EjgqZg0o9o6RlsWmBrtXNkU9w8sUl5yzL0WfHDRd359VzzY/nF41b11BAE
         qnLlJmR6lLLmtnW9nimBRRkFRajtOeQ5JTgGtx5HsdEc/R1SqNXv35+ZO0ptbndGN5lO
         SrUp7m9pb0ZMOX/2xVW20e2Da6v2MH355TJaYHK+tmEp8dgW/UJQ7wvM2NIA55oDGHPd
         KX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751639; x=1787356439;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/QKu9FenL3NLIzw2yss8OaOMInxGZE93gUwAZCW7GU=;
        b=MQmSUO6Fv+vnR8v5ZklDd9YV6xFmoYt0Z42/3VtRUDiL/6HxMnALLHG6kzEGqvWel6
         xqbuq4UITGAUs+IAWXrnIQBv9ECp/24ueZd0PhE7nrT8ZnhfTZCLPR3VZIiLlCnffLKY
         Gg87dWsx16UmcZ9qiC+R04yEzsnG2ilR4BBF/efOqrRIsBX4exkKFE/vA2cQWKrCxPCO
         31suXhGDGkxHyo+izxQEDWATBRNiH9mzRQ0LCp22eFtrFq3zYzYfauPHQgqEGpkC8AEc
         h+gpz4GYMZCnlSD+BhX5uUiNKCKE/XHhvUhW4i6cMUoAgFL1WkX9gB1Y1He1lYqjxsFw
         OS5Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5EC3MVkIvPCUXEmCFfTBI6We3gFMRLAN0OLVWbHe4fKGUoBCjJyGinAS7ayvaqTzPUvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncBbqv/VWyvTGVuTDzUWfIZsIONxQv1T+/du1TXZGwmCrVHl0
	pwdPBaZoGSXRCmBsQ16qDbw4zgdrHqhGSPbXW3qBxB7byVVeWAAcSzUm
X-Gm-Gg: AR+sD11mUTdB3i/L+am3J+qWYGv8nxAKoJcHGL8ceKcab40GgilUHNY8fld7eladc6o
	jxdea8ygalfYEhUM7BHWTV7AvE1mfrPgfYy71wR+Sdzi+cXUvH1Ve/cHkutPRX+JHxoMEnDh3aF
	lSKt+JQeEfVl1A/XHer34xethvUPRzz/4AY2D38Z97Pfye9DerLHK861en7cTeid13d0tDsC4QE
	zgYTGNbSvxJCZs3QnPa389Zfj1mm5BWR6lnsjRSdA74hG3uo6MUuwBmKPSeho5rr5WcvG2kPvbe
	kiRT5Kdv0W3XewsNt2yUhafplwEUO9UFIkNC037CItD/zd7bQLfTfB6X0x/ep0Fz6zSNxd2ND4c
	29X12NrH48dLEWO7QOt2QkJWcybwkMxToXaywOC2rfnbL833uHMJBv8GYz9MNtSEiLUd9NfGfqP
	ToDzjeZ3xao3GtHIKSF16K/ogzyQlybYC8K+Y4PldqlYveja7LkjhzEs0RACEY4KOpRKs02rft6
	uOzZA8mzOUVkh7tNjnZpi0K/WohGVY2joN7sSgS23o1
X-Received: by 2002:a17:90b:1b0c:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3933aadb80cmr6080332a91.0.1786751639252;
        Fri, 14 Aug 2026 16:53:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ed5b1sm21342259c88.8.2026.08.14.16.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:53:58 -0700 (PDT)
Message-ID: <c028bea425c3ea04df2156aec8a8b889fd6339ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte
 returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 16:53:57 -0700
In-Reply-To: <20260813200240.1995795-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
	 <20260813200240.1995795-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more tha=
n
> 16 bytes. See LLVM patches [1] and [2].
>=20
> Before LLVM 23 the BPF backend could not return these values at all. A
> by-value struct or union return (of any size) was rejected at compile tim=
e
> with:
>=20
>   error: aggregate returns are not supported
>=20
> and an __int128 return failed later in the backend with:
>=20
>   fatal error: error in backend: unable to allocate function return #1
>=20
> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
> register pair.
>=20
> This patch models that pair at calls to global and static BPF subprograms
> and at kfunc calls: R2 is marked alongside R0 at the call, propagated out
> of a callee at its exit, and held to the same scalar-only and no-stack-
> pointer rules that R0 already is. A struct returned by a kfunc must be
> composed of scalars, since its bytes reach the program as raw register
> contents and a pointer field would otherwise be laundered into a scalar.
>=20
> An extension program is the one caller of the convention that cannot take
> part in it: its own return value is the program exit code, read out of R0
> alone, so it has no way to hand back an upper half. Replacing a function
> whose return value is larger than 8 bytes is therefore rejected with
> -EOPNOTSUPP rather than supported.
>=20
>   [1] https://github.com/llvm/llvm-project/pull/190894
>   [2] https://github.com/llvm/llvm-project/pull/206876
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -19404,6 +19458,13 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>  			return -EOPNOTSUPP;
>  		}
> =20
> +		if (prog_extension && tgt_info->fmodel.ret_size > 8) {
> +			bpf_log(log,
> +				"Cannot replace function %s with a >8 byte return value\n",
> +				tname);
> +			return -EOPNOTSUPP;
> +		}
> +

As commented in v4 [1], this check belongs to btf_check_type_match().

[1] https://lore.kernel.org/bpf/e1bf30cac04d54aa328fee5282de348a89494048.ca=
mel@gmail.com/

>  		/*
>  		 * *.multi programs don't need an address during program
>  		 * verification, we just take the module ref if needed.
