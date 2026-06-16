Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D044374192
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639648; cv=none; b=aN4B8UlPtIfI8KsI5G9ChtK3MZDBdDA4klhRVqxCm+glhtDmpiGc+waiS26oFinaj/8weWm/smsNKI/0J/kE8qRQd2vA8hf1niekvDsVXixVStda0uTSDRnOOTq6WCNfS8Wnm7I2EaxIESarV/3316m5f1HBOWSC1Hev+TgJ4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639648; c=relaxed/simple;
	bh=wBGHjHxgrem0nIUgulG5+nCOYEO7Z4ayqUS4ehBx9ZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=fjF1+xdbN+t8fd9FXOcZ4YGM0EC+anp3UnIxgS/CBBya8t1ZUPHpq60MTtyt6QfBhviaTV/7+2vfFyXV9JWtJn+/r/M8PNR5EJs7CDCseJnBy1Gvlc2sLSIhQG5/8CdKeR+5oW3hlvsjG89n0hyc22Q9FZfVekZ7nMRZka5ck64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jWRrZbVY; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jWRrZbVY"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bc806fcf8so416841eec.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781639646; x=1782244446; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwknEJTZ7VfaeFcxIBCw6u/qAaYv555kWbrQ6JRv5ww=;
        b=jWRrZbVYxgYgmnTAmj7NgZZUA3rFl2DShtynPpNGOsQWXBWrAvw5Fqr6AjdYpB6jj7
         4vA8DSfC7cxXiVMqW9646BLmM5oE2CMnSSlKM+gajDHCvtkpt8nNKmiVVAn0JG8jXDgB
         PE2NtFYVtMeDY4583S7delBRll8lG8BkXL3vSb2wzbK3U5w3WgqlIIJB+EDKPBOUn0uL
         1XcTMCmHaTMaLLUWEPRhhkrcyDxsQix1MJKtep1aECR6mOGvw+srYTW1gkC2+2vt97p4
         Wu3zm2ZQesFD+unQeWVouw6fFP5bNu7DLqfM1MIQ58QeQqA0F8hWZ7eEUrDC0HzOJBv1
         HNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639646; x=1782244446;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwknEJTZ7VfaeFcxIBCw6u/qAaYv555kWbrQ6JRv5ww=;
        b=ZEVjnKrON8BUhYSMav3fotAhWIf/6WTZqBPxu5IrO3Di1yC62AxOWp98PTbENegF9x
         Y0+jTLUlgXVNHLK6cCyiqBcr4cNA0zZ8+o3mmso1fyKkTTt9qOINE8wSVOgPGJawHaRb
         jCQLCaDLJbT+F4mfUNB+Ia5yd65Sx/2N+lLU1quWpwcEXKg3jYYJe6zwdIe3cFvjFS7t
         tnvlGdha5q3IqtwBPrRqMo8b9wDwD3mWAqd0XE4pvJ+81GTnPd7e7+EnIkzOrc6qXDAG
         AwwRcT4OqdS5Lv1z8lOncWPiT2yoFygOiCEz4A2Vxhtqwz0Xy/vAhvC2jGAMpQd+KwV/
         gIvg==
X-Forwarded-Encrypted: i=1; AFNElJ+xiZc+JQQ6LQNErf+whT06hBPOoFVNeBw9kVa2sqaLzWvouFP99IKdfD6amUh3Mbk4ArY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtJflw1ecsY4hWDhuB3wELah4D6vGVmDOUQf1TC9y4FqcDypp
	Q+rJmAirPC1yNgaa13lSr/1AwNtkBy/LlPmTj2frh9qdtuCebEpbhoumnf8Dsa0CzIg=
X-Gm-Gg: Acq92OFMyfUbMbaxy/BZj6aDrAvgB6T9dQ05My2isNJtAqDNd4orGRtatiqxRIFPDYZ
	bFJRB9U+WyXaayHua64F0UIcR8Ko2xYWcFN5GSyk/UeL23Qv8X9qMA+7Kwbmq/z7DOJlVhMySaK
	QSQKLhz1ylgLbILs5VMUh7F+2f3PGKDukJxtvQErefVu1jWlj32oE9e11Ad61wHN/oYMFH6s9yp
	DR5HkFUXcEf9WZ+Fz7jvuA0XX7qnqJ+q7zZvU+sQaofnbKSOhLcTPm7JE3pRMza5fFPQm87wvuA
	5SgHHc4mjJnNn0WTivTMiuWPC+20lAbTDUTyTGrcyrqBVmN3gQVTJ9+HnACZH1yyfI9X70cj7zh
	brTWOyu3l5ssuyDLeGeeKcxgX6VHlzdFBQnZCD+/RlrpNJW/iBgmelcq0Vb39tzDBSxVScQV8UZ
	yCub7V
X-Received: by 2002:a05:7300:80ce:b0:2ed:e12:376d with SMTP id 5a478bee46e88-30bcae484edmr392664eec.35.1781639646207;
        Tue, 16 Jun 2026 12:54:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bc7d77f90sm948619eec.6.2026.06.16.12.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 12:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 15:54:03 -0400
Message-Id: <DJAQJL4LZKOF.1DB3AFRP5DTOP@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 14/14] docs, resolve_btfids: Document kfunc
 BTF annotation emission
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-15-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:18 PM EDT, Ihor Solodrai wrote:
> resolve_btfids now emits the bpf_kfunc and bpf_fastcall BTF decl tags
> and the arena address_space(1) type attribute for kfuncs, which were
> previously produced by pahole.
>
> Reflect this in the in-tree comments and documentation.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nit: Replace address_space(1) with arena here and in any other occurences.

>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Documentation/bpf/kfuncs.rst    |  8 ++++++++
>  scripts/Makefile.btf            |  3 +++
>  tools/bpf/resolve_btfids/main.c | 11 +++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 4c814ff6061e..d98e666f03a3 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -437,6 +437,14 @@ type. An example is shown below::
>          }
>          late_initcall(init_subsystem);
> =20
> +At kernel build time the ``resolve_btfids`` tool discovers all kfuncs fr=
om the
> +registered ``BTF_SET8_KFUNCS`` sets and emits their BTF annotations into=
 the
> +kernel's BTF; these annotations were historically produced by pahole. Fo=
r each
> +discovered kfunc ``resolve_btfids`` emits a ``bpf_kfunc`` BTF decl tag, =
a
> +``bpf_fastcall`` decl tag when the kfunc is flagged ``KF_FASTCALL``, and=
 the
> +``address_space(1)`` type attribute on the return value and/or arguments=
 flagged
> +``KF_ARENA_RET``, ``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.=
8).
> +
>  2.7  Specifying no-cast aliases with ___init
>  --------------------------------------------
> =20
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index a1812985a61a..717e76ce96a7 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+=3D -=
-skip_encoding_btf_inconsis
>  else
> =20
>  # Switch to using --btf_features for v1.26 and later.
> +#
> +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
> +# address_space(1) type attribute) are emitted by resolve_btfids, not pa=
hole.
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j$(JOBS) --btf_fe=
atures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,con=
sistent_func
> =20
>  pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D --btf_features=3Dl=
ayout
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index aafbcfec755b..5a4683d11426 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -58,6 +58,17 @@
>   *             __BTF_ID__func__vfs_fallocate__5:
>   *             .zero 4
>   *	       .word (1 << 3) | (1 << 1) | (1 << 2)
> + *
> + * In addition to resolving BTF IDs, resolve_btfids performs kernel-spec=
ific
> + * BTF-to-BTF transformations for kfuncs found in BTF_SET8_KFUNCS sets. =
For
> + * each such kfunc it:
> + *
> + *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL=
 is set;
> + *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
> + *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type a=
ttribute;
> + *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
> + *
> + * These kfunc annotations were historically produced by pahole.
>   */
> =20
>  #define  _GNU_SOURCE

