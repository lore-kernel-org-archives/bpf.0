Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF9443A8A
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059217; cv=none; b=dFjkyLJouGc84qGqdEHTNcz2SdDo0fOlCRNjMkiF5CROTy8Al/vbLzfEW0Ejp2JieXsU3Pc8E9I/Xzlz85eVtKkKWLWOzYu7Jhv9dvRjWLZNaU2OtnYIkPaTq2fhEFyVP52QxIWACuQJhClOb9IRGy1qtbqI+2eNO1Jzt6lj58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059217; c=relaxed/simple;
	bh=PsIbMJRTSmMcKUepU2LL7YXBwU6P3f9ZWFk+Ikj41AU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzzQ5Jy3ETUlLunQ0Yi6FXzvMs1qgQYkf/Tu5HY8KGCHMw2RHicbClPJXQb4oA79jqGkoBw3EwjPrF7VyAvtL9WByiuC8rzL1aGrBCmKXqRcFuVJ3/2crMO8kSJRRhwKWiqPCrjRM3h/3n/MUs/K5Atm+hr6NAqHpM0GL/Kixt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7ImQ8O/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7ImQ8O/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3382374a91.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784059214; x=1784664014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0pBHx4swSqG8KyzMQR2LJ5Uo9kHMF29Tk5WBtrSEv9s=;
        b=s7ImQ8O/tpARNRcOxHarokqnYBi03CC11F954yGUWlCCXZ11jlJScvIBaeANBmUVE4
         1oC2nuC6hrt006eKlWgfp3r3FqD742dvczgVA3KTjw4NDJ75FArR1UjrHjWBEpr7ldpN
         KBe5Yj+HNzoC/C+2upJFKArIO4t5vNeggg1MkUg1r1fhNFjGnNOIS3MYp49R0AmlcQbZ
         P5vFd8kCZAKLpoRyZi1F3386EBGMf5ftQEFXPvTJ/cwsePcz1ZevkNYOKvbZDQqO05ky
         /1gOMcOh5pz8+zasb1Iqivz8homB2UWlUOl/X/1ven4gclJ7BykoutBdemWdws3e0ecC
         bkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059214; x=1784664014;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pBHx4swSqG8KyzMQR2LJ5Uo9kHMF29Tk5WBtrSEv9s=;
        b=NV1Ftzh6eFfkfGSUTjAEOoP8oaloAgECcpXOCr8E3Ij+YVZra7J0Qc7Ruc3c1tuvKZ
         kLIUMzEDDeznpwhxYixBeeI0rjis8QtlFqBsdyFK1XpgtLIhK9H1dQs9ZAz/NRKSB8p3
         eNT95TnfKcykZHQVgWX2kleiQTmmxrkNOZZd3rcmXtFITEDzioGZKv29vESmFrgVP3vQ
         otCZyyF65JJIHHeLF5luFyhLFKWVS6TBJruPqcwAsuJ2twUmH7pknuGmsEZ8mi/4d4jC
         eOx2XkqUXYK2+ipoefYXbl4xrwImNv1ANiUVbdZPs2HlglvCBrd/In/Q0MnKoWcjVcu9
         DAUg==
X-Forwarded-Encrypted: i=1; AHgh+RrCkAh7VV2VaUfjeZEvFLPRlIwL183MBK0CWNhnxDntWqMHB3XVYNX2PvR2DKqCk2NqqUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywij+ITQCWvthvdRToaiXlWFXfneVgeMUI9XCikW4xUJrn/JxEI
	Yhyphv1UVlSAYTFDGx94s062dUMXN7JFXOu/5rl+Ul/h7EI9mi2+TcZP
X-Gm-Gg: AfdE7cljLZnaK96pLtGntBElyiGSB5aYyo47UhSxrTpSPxFb1sYoYe8m6MYqadZkdo4
	F4j9oXBR8BRQ0pmZCx+HVMrkVduPEsch87cVj10NhKLZxVnzCZu7BEHErqm+a6vpk/1Eq7CfS3V
	RaymNyydRRERttrC5I818dnYIiUWVfHIDJysvFXQWKt8jPMc5jEixwXPZpBsdX/7RD+zQZJqqU1
	HlGwj362uksyoXb6wOw0bKrMiq+E2wbGaLExirFKBlZUA+5cRiYP/6U1sv3pMw15hv9IiWZlVmO
	qUBkKhoOs1YXcG9gVnzTzIwlw9YCvIquDFC+cU8rkiR3JlIv20ehyq35JHI4XwmH2WSpixOJGaw
	BHkogGDFLLu34l1haFjV7ZxGXIRz54catOFbbVh4FH+K5nnjXxvnB5dsziHKUvORyJ+G2hMBlJo
	7IJGXH6I3beX0v2m9Gzuvmu1CBkasaIUh1MZ3vH4qlDnIvHyAo75LUDrYK4woGA/uX+EQ=
X-Received: by 2002:a05:6a21:681:b0:3bf:b9de:854d with SMTP id adf61e73a8af0-3c3573959b2mr4193196637.23.1784059214071;
        Tue, 14 Jul 2026 13:00:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:11d2:f935:a412:8fad? ([2620:10d:c090:500::972d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm53943891eec.5.2026.07.14.13.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:00:13 -0700 (PDT)
Message-ID: <9d9ec72059ef2855c3e2a47982e44cff9dd1165a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 13/17] bpf: Report Program Structure CFG
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 14 Jul 2026 13:00:12 -0700
In-Reply-To: <20260713153910.2556007-14-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-14-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:39 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected subprogram CFG validation failures with Program Structur=
e
> reports. These errors are structural rather than path-dependent, so the r=
eport
> focuses on source and instruction context instead of causal history.
>=20
> Cover jumps that leave the current subprogram, subprograms whose last
> instruction can fall through into the next subprogram, and recursive bpf2=
bpf
> call graph edges.
>=20
> Format long jump-range reasons directly in diagnostics.c, and keep the
> fallthrough suggestion aligned with the verifier check by suggesting exit=
 or
> explicit jumps.
>=20
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/cfg.c         | 55 ++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/diagnostics.c | 19 ++++++++++++++
>  kernel/bpf/diagnostics.h |  3 +++
>  kernel/bpf/verifier.c    | 32 +++++++++++++++++++++++
>  4 files changed, 109 insertions(+)
>=20
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 26d37066465f..376f6b6d469c 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -5,6 +5,8 @@
>  #include <linux/filter.h>
>  #include <linux/sort.h>
> =20
> +#include "diagnostics.h"
> +
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
> =20
>  /* non-recursive DFS pseudo code
> @@ -113,6 +115,12 @@ static int push_insn(int t, int w, int e, struct bpf=
_verifier_env *env)
>  	if (w < 0 || w >=3D env->prog->len) {
>  		verbose_linfo(env, t, "%d: ", t);
>  		verbose(env, "jump out of range from insn %d to %d\n", t, w);
> +		bpf_diag_report_program_structure(env, t, "jump out of range",
> +						  "Keep branch targets inside the program.",
> +						  "Instruction %d jumps to instruction %d, but the "
> +						  "program only contains instructions 0 through "
> +						  "%d.",
> +						  t, w, env->prog->len - 1);

Nit: I'd forgo the formatting rules and just write the above like:

		bpf_diag_report_program_structure(
		  env, t, "jump out of range",
		  "Keep branch targets inside the program.",
		  "Instruction %d jumps to instruction %d, but the program only contains =
instructions 0 through %d.",
		   t, w, env->prog->len - 1);

     Easier to read and easier to grep.

>  		return -EINVAL;
>  	}
> =20

[...]
