Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FA2F3621
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267838; cv=none; b=MLqhYvv09AdAl1KhV/q50Jc/TwuEFnwk0JY498Tz44RvRiOaT2IDrmu1f3nQyKVyub8zpRwe6pouiGIPmdV9eSgVufy4sn4OfEcD/gM2gWh6obpEForPjzUvRFDfQrJ9Er5EEgW8nrJxdRafZx6v2NwIA/UW45GJOxhAkusk3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267838; c=relaxed/simple;
	bh=al8zXHPRO1ONrsdLM/WJY/RIrd/WwecMuRVA91WEk7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwgSIOuue23FJWrRjCjKkAkaWRdYH9gZff0KASHtwQQYThAWL7DuAeu1+mLBE6crlItf4ue5Sf+JeeVVGd0kNj68jwy8zcq4sO3tyfrkusCT9g4vCejQtDGWheI315T4JoREtbI/uUNTXOzMw64F9g8f6xheB4d8W+7VyDfBVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NErS0Y7Z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NErS0Y7Z"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbb973e6749so159649a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785267836; x=1785872636; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/LOzvSgiNkn6Tj8w9MdZW/Y+hON5oScmn3GxI4ESte4=;
        b=NErS0Y7ZVQYBCtB3liAadYywAQArDdhrnaiL4ilOH4f/w5d8hE55aZfzFz1ptPZxp7
         c5wpWpc1LErRu5lRFM5jY5uf39rJ0JEdlTqUaUypMUkF+Cagd5q44kx4wTRo2Lxk7Cjc
         VbsirZrgr39tFtDiiCTJmD7H3UZQWX3vd64WS4X1p+1eE+q/l1Rp/2tf4fjCmvS6ie0D
         0jBi0f1lc5IfvmSdyHLAFMktDTd9KDRs5FA631mVV9wPCtxx7ea/v5RjyimdCITXKDBd
         NgGz0Ka3GgRiPY5tJy5/Th1GTlTuPwEYG77EZ7nxbySWOlXcmwmOYPg+7Fzr1TLfqh6s
         /kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785267836; x=1785872636;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LOzvSgiNkn6Tj8w9MdZW/Y+hON5oScmn3GxI4ESte4=;
        b=GWZPFF+YC+UjqP3iYmWc6zgIjDRI0cCcTeUebCcYpxbvL062caHBbFgja4LYRTJcgN
         swua85AN9B73p0BiGJAWy4U/aZwHh14sgVaSQY2krx7NFaMbIkTrWATCcm9vdVZ5X9fZ
         kWUxIzZ+AEZSCrD7jyOUIfAKoktPt+7esAtmiFsbffaccyv2hiP6mWW1DL4/BUVpDmvX
         pXal0cMvsXWHpcpfirKQyDv4XmVGwurqScg1k3wiJ8ioESF0tGEz4XzcH3tUafHSW/mN
         frA/UK7e6i4ntICiIc3R4dDyzc5kQFupQBPZMI/mk/KmV7R0R+s/moFamv0m92/ZsqWp
         wBwg==
X-Forwarded-Encrypted: i=1; AHgh+RrmzNOI11ugskrLg1nFSflpm6iLKKvu/HurFTPrsyce1dSqjXoMcFWXW0uU47nIzzHNLGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRNO98OU6zgcxEdtnJrRKfI0yZUzm0irPvqrx9zCi0sJ2CE1w
	QwI5ITgp9nE4r4ntn/XQmS0qawJgQegYczWrQ8Da+k120IRehA+2Qwvi
X-Gm-Gg: AR+sD12mfA9R04L6LRqBCedVCJ2aEZ6TKsxW7u5gxbRPIxNuUGsUf7Kiv7hX95US9YR
	0sxyfO78meABKGHCsZJOh9lmzOB9uGzRuiAq9q6Ii1xF/s4u/nGXxkg8UJB2ShbPaFOWkV4mzQQ
	d9oG9hvoNZ8F+tpLKoLS2u631cjQjOyBcbX17EhDdZrhoWkP77GpE4EU0xFT/T+2cFi+MdPjH9g
	0db1b3VReH8ad/SRj6Xr4Bm2P1wxvL5pM2Wo5Z9Q9UPwv7r3p9im4OHWYRABsYVaR9LcwVO9wb9
	xYriyarYNnUgpW3uMcsvcNkHK/uRzx52TH5kHAOLpBoO7Nqdan8U7WagmeAUo9TB4vxCBleWrC1
	qxrJh55n8SCaTxX8BEVRG7oJis4CdU0DKI1eAAzH2Xt31ZqjqHnpB6CntNvNUBKQzrfJZxpSd1l
	DKLLPoOGskO9dL5rwgfArpnUiapIiVg8pK6fqiu/4WafJGRKPQ86B+IWBJ+GQ=
X-Received: by 2002:a05:6a21:9d45:b0:3c6:62e4:91eb with SMTP id adf61e73a8af0-3c8b0ca9616mr5097346637.24.1785267835957;
        Tue, 28 Jul 2026 12:43:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5258:1ab6:44ba:7529? ([2620:10d:c090:500::4:c456])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7271f010sm1580987c88.9.2026.07.28.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:43:55 -0700 (PDT)
Message-ID: <ac4166e6ae00698471ced0bc9c9a48d1a450ccef.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] bpf: Classify scalar kfunc arguments
 from BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Tue, 28 Jul 2026 12:43:54 -0700
In-Reply-To: <20260724190813.1458271-18-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-18-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> Add kfunc scalar argument types, classify them in get_kfunc_arg_type()
> along side with pointer arguments and move scalar type verification
> into the main switch in check_kfunc_args(). This keeps BTF-based
> classification separate from register validation for every argument,
> paving the way for generating the kfunc argument prototype at add-call
> time. No functional change intended.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...

> @@ -11355,14 +11360,40 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_=
arg_meta *meta)
>  }
> =20
>  static int
> -get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg=
_meta *meta,
> -		       const struct btf_type *t, const struct btf_type *ref_t,
> -		       const char *ref_tname, const struct btf_param *args,
> -		       int arg, int nargs, argno_t argno)
> +get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_met=
a *meta,
> +		   const struct btf_param *args, int arg, int nargs)
>  {
> +	const struct btf_type *t, *ref_t =3D NULL;
> +	argno_t argno =3D argno_from_arg(arg + 1);
                                      ^^^^^^^^^
                           Nit: this is a bit confusing
> +	const char *ref_tname =3D NULL;
>  	bool arg_mem_size =3D false;
>  	int arg_type;
> =20

...
