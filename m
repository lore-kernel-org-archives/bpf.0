Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1815C14F
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786754857; cv=none; b=BRSa4XWYy/nWE6+MdWfwO79V+ansp2IJrsI0u0M4YYyfO4R05q6pURTVREn4AcnqLN/tnZFdXV8oMOY0+HnSfzB/ZF8lW1b2ey40+8wi4oURpBR8hrAyqZFs1RszAkNXDqJ/n6VHxUYVse8DQdjo9fTZdqh5ZVLpjQuImPPJMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786754857; c=relaxed/simple;
	bh=R5vv1l/+FwYutZ4Go9D49mOLIbW6wU5tVF+JFmKY6Ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaJhsHF5kJ5WZBHOpxxAjYVkziiNwTFyoAvYpQWXDEROCKWHtOjij1JiWPLX4zg8JlP6oOgzRCXW9AQk424fZGyjJOrt4K+HHokRhFBA7e2B93cYGMQJLK3nf7MO4ehP5USl2NArm3FpRAVmZ1Kzct1XGINPCUBnOO+Uu1TCf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLCqMnw4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLCqMnw4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d530328efbso10151885ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786754855; x=1787359655; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LDcIRjZOU9cetv3g4m8ltiwxcBIoqfe50mIvf/zJ/7o=;
        b=HLCqMnw4CSQ4X0dEiKUNFMjPbcCRDfJZqCw7ySx79m7EOa+eiHwF6PnUhY693ExwJx
         zxRjkt/T8ibYat3Wgx7Veq/qcW0/8FCbqm4eltnesgpNlUchK/YHJ5NSSYlnHrIUnUmJ
         3HoeKA4Q38Bjs/S4gFDgI1910tDu9dkxkPan1yHrjjUYbSWbC+9rIdZbpiHk1mRdb4Ar
         FcesjgaPvr/Z6gbAFmwYOkoRacqU+HJ8xcwySvxji9FGaeoefzWIXi6Q1sUVz+F6cvUJ
         kFRLiVKTnuuZaaQsKaRwkNCQlV5V/W6X45x/iAocyNmUK1bH+JAcmYSadeJAwOp3yLfF
         lYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786754855; x=1787359655;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDcIRjZOU9cetv3g4m8ltiwxcBIoqfe50mIvf/zJ/7o=;
        b=FaKk2dyJgFNNeXc/yHYRQnB39wNI7P+22Fx6ZnDPW8Ai6it1WWDaGePFglAj313nNb
         wJh/uZ5m6f4UEXCc9GPc5eXXQ2D5XkWnDmjU4Nu4mY/CUl+Fl3phGJIc850KoIhi6Z5U
         Ukw6HS6lW+C9l43qVd9/3VYibX72M2jStiWCsnsiwNQPiY7UWwADhU9PsRJDDvKljiOw
         oyA8R+GmwIAITVurXnXwY82Mh7m6lRgGLD8SNXgWVkPtlLCKWXV9dNhQobO2rbijP+eV
         WNXYIA5sVb6AFJp1S4RJiN48Bgs7PjeTb5NzUFcK/lHhJDQS0klPY28sXLtJRQnyDP3f
         FBnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA+2/bDrpV3vhcEaizNtmdc1F4G2JpWubtVS4iLqbYOObUSNXdfUC3EtXy0YZft4TGDjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYT+IcjTdBeogZbeILjpBKg6fB1SA7DJIQgXdENFgaOEE8KcpJ
	bhILOiIGcI7zGCLBbrRmrya4KyLAviAuUgQIsqhjiFg2PPHNuzMThQRP
X-Gm-Gg: AR+sD13+3MMD9hOI6/C6ASyGA+IGorXwf+e/E3hPCh9p8TBh6YjsWhg6eR15NtYPrR7
	JPCKs3FhAJyl9kC2W/hjGaewQjQtr+tlLzxbHdX+tv68pksfDkGWPsuLZ94njymHGUx3QVxDQfb
	Ju1a8gdxO7yJ4LLSKI3UKQGBZlAEkcv5TFt2U3WMA/9Eq983m+2IWZp4n+dChBgfFAZjBNusJhD
	6fmeBNRAMEyGC/EiDz+Ga007J+n0MVvyhfbibG4dSTDrrMnnK9WbFwPJ59czAxlXQPpSrkeh9NR
	AL0LmbHbOdQhWpgLi8CyHtXfSrwSW7u8Ehy1sugQvU09M5g0HQZupG+pYdwJNIOQ9r/KS8+db7V
	q0uxh61/cr7q4J/87BWdfvewT/AcU592N8ZwpMCQTFXurtaBdmDjtHByVg4nEJSzhiyBakHTN2F
	hr2hwiF9h1sUAS+pdLZU1vXjLUzvrIjpBS2F8IxqgCfrUW20oez8+wADPaFcbV3/3TrWKEx8Yo6
	OzrhGxHVDfu90gF106Wslh75vnGXWnwtRKbCg7bURpr
X-Received: by 2002:a17:903:2c06:b0:2d3:a853:bb7a with SMTP id d9443c01a7336-2d3b0cde805mr125448375ad.19.1786754855108;
        Fri, 14 Aug 2026 17:47:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df68ccsm9557760eec.14.2026.08.14.17.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:47:34 -0700 (PDT)
Message-ID: <7b7f5154cab8e3a217047e34be0d7255e9eccc21.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 09/11] selftests/bpf: Add C tests for
 16-byte returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 17:47:33 -0700
In-Reply-To: <20260813200256.1996809-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
	 <20260813200256.1996809-1-yonghong.song@linux.dev>
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
> Add selftests that exercise a 16-byte return value passed in the R0:R2
> register pair, written in C so that they depend on the compiler lowering
> the register-pair return. Covered are an __int128 return, a 16-byte struc=
t
> return (from a static and from a global subprogram) and a 16-byte union
> return, plus __int128 and 16-byte struct returns from a kfunc. The union
> program shares an object with the struct ones.
>=20
> The R0:R2 convention is only emitted by LLVM 23 and newer, and a by-value
> aggregate return does not compile at all before that, so the programs sit
> behind a __clang_major__ guard. An older compiler builds the dummy test i=
n
> the #else branch instead, which keeps each object non-empty and says in
> its description why nothing was exercised.
>=20
> The kfunc tests are tagged __arch_x86_64/__arch_arm64 and skip elsewhere.
> Those are the architectures whose JIT advertises
> bpf_jit_supports_kfunc_ret_reg_pair(), which bpf_add_kfunc_call() require=
s
> before it accepts a kfunc returning more than 8 bytes, and they are also
> the only ones building the kfuncs.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/prog_tests/aggregate_ret.c  |  13 ++
>  .../bpf/progs/aggregate_ret_int128_c.c        |  49 ++++++++
>  .../bpf/progs/aggregate_ret_kfunc_c.c         |  65 ++++++++++
>  .../bpf/progs/aggregate_ret_struct_c.c        | 114 ++++++++++++++++++

Nit: I'd merge all three files into one and move loader to prog_tests/verif=
ier.c.
     Also not sure about union vs struct tests.

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c b=
/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
> new file mode 100644
> index 000000000000..913cc374215d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c

...

> +#if defined(__clang_major__) && __clang_major__ >=3D 23

...

> +#else
> +
> +SEC("socket")
> +__description("aggregate_ret_int128_c: needs LLVM 23, dummy test")
> +__success
> +int dummy_test(void)
> +{
> +	return 0;
> +}

Q: what would happen w/o #else branch? Is loading an empty object an error?

> +#endif

...
