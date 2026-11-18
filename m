Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036369;
	b=4SwM5uOZg6SX7l9mAePEkxCVeDUxjLJn88mhTrOuK4ALpoEGxFpMhMWOIubQ4kyf7jX/
	 YtzJWhar17Hpwm/YYl09kTxCHMGpzmmngMbKiIzDRYLC5zKKS7ClsHJsdNlHNZCvXq2kn
	 jQFVPNbhfjIUeacasbzdNVQdEZn3++J+76Ws1NwHiKcepAF0je6CNTWxJH4RJra/CDOyL
	 o/SjX2Eewni1UmD65WcTvcLnYBixvmhV1AmUQLp2HyyPCMWouALNYfN9VIDKA9vTNSiDX
	 oy5DiyF66JiW/ccaIsQMS7WGeYSoUK6wTRs+imZEC/2WjLBksJSFFtE4jC8cLJR9xXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=1e/TvLg+e+Z3bp3zIHk3TfdEQA+k1gn8aVFItKGNB84=;
	b=ah00nflENrKwdBa+sbpJW7ozbql4ghyopIhb52gUgt4cuCwndK80xdiNS1gLr4GaCCap
	 PJyn6tDtkWPuuoFKaHwG9JIXl9RObRKR4QhxVYzx7XLiitCzHyjvPu9G/vFiWPJ8SQkuv
	 NAIUVjxR4+WQuhW7UYb7TOFB0yifjW/Jnq9kor3fUTuwxoC5LWhvvCQHi39StG3efdy8H
	 3IsLXsLLQ04/4RllD5KD4kdzcGUkIZCFi8kloguPh8WFvMTuCo8ziXq1wSD2FI8ZtCYaM
	 pVa6cKSixgrxiR9jQvqqCv3Am3OrJyguzcBdIMDXgdVcMTlrlQ0qyDsvRRyAElMTDxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2zY5yEh;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17F3606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17F3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2zY5yEh
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a05b210703so918882b3a.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795036368; x=1795641168; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1e/TvLg+e+Z3bp3zIHk3TfdEQA+k1gn8aVFItKGNB84=;
        b=C2zY5yEhV0jVQa5Es4QLgNKBGwQt5BR94udPyNfmkDm+V05flNM8YhTf+QIt2XRj6B
         56Q8j7JOInZWEyEwyEL7G7G1ZsUnrujxZri83UvI4dVnpWiNLyhE8LdNEJpLjh6W0TrC
         DyA1/cgmArj4XvejyCEaLIzYYS6E1fwWAMjtJH7mMbgFud/TBleVSKCDZpMwVI0ZU9pv
         p3Y0ebhVSbhT8awd0Wdg8gqgE8CIXSwB9Pi3x1UzuJBzh00WgqIHd53gtT+ZCDwP55Zm
         v2uGfUDvrBoGCNBNk1RZ5ZywB4goCyfEsKvsxMVVuPdDQ1kLq9C34JWblm19J/p/ktHw
         LCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795036368; x=1795641168;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1e/TvLg+e+Z3bp3zIHk3TfdEQA+k1gn8aVFItKGNB84=;
        b=qNUtaH/sPOarrmfEaAbepmT9BO4eQbJ+rz04x3J68xtgb+50i/EIJ9j78PDPtClEF7
         2PIo310ZiHFxo0QZzSheQ7eOle06j8AlmroxXQD2nz6LSup4W9o//Bmz7+CLgzEVdYxp
         zs4G+JUrsq5dqjMNW3zlvUQ9reN/m/aQjei7BdjAto2BOo81m6Jz0dQuq2Nl7MikUCj6
         cSEa0yHA0wtJ6TCD+2kMppgRFmHM0Jy8LWMHtL5PvoY8rJYl47dR3B8B3Z8FKM4C22OA
         ovjpPjtq6hQX9La16dGpS5HaBJY4haV0AnTQGqpcCZ3e37qlnmSyAlsM57oyPtI9nWbJ
         /ANg==
X-Forwarded-Encrypted: i=1; AL+hErGpdLDjwjsrM+5zBI8DtJMP7hAmeTITV2gORkFrdbBkrbUuNs7LSbv9j4PneI5TOtY/0oc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jsplaBRxtkP1T5/ExvUb764MQCHsdLLmsZa12CAEt/VedNk96
	YrcPQCCACDHrnpMr3QmOsMWjAT3sDrzF5e0TGaLTK+ZCsNCac55u1W85Ebd74q+S
X-Gm-Gg: AYBFou2Q9zzsd0Y2H7oquRJDX/+JQI1ARVWCiQkzAHOuYj5Yp/U3GIrVoRMg/q+HI1f
	4vgfCXvlMIUbIhgzUPCzwSeAmHm0WaaBRMfHKY8sU7dnIRNYJN66bsh/fGfnK836lAaEto/U6y2
	UttSM22lgFLfaWIrOtIdoXpE22IV49vOa1o+tntI6aISP/8aG2lSZ7UBKnhSy0y6tJC5DSe9LEM
	Ycul5TksVRbEe3iVLckeUaFviknnSQx/x59mcm+AogSq5n9HcTUiQzp/WG7eyFYZVsS05gnwqdS
	/J8dAmjK/GIKftVg5wiLbBEuLDfBrXz2imoWKPuotG5Nc6UWXQNTg3yACtFI9IKaUtP5W+2Xz4h
	zzQVVG6IaZSlPW7SOcORguMBFM1LSBWCiH9E/NZ1585ADECl1dPJEd4VjS5OqokHxqmJXcMMsLE
	Q2zpzRkiYPywrD7oQIuTG7oHqVs2H9dljUpbkhJiyjT8y79GtjhQZDYkz3sZs/KoOcrGpu0s3Ia
	eMsWV1fH3DQjMMhovPeTdSaSlxJqvn2yHCQYGuhpbdnFeKwjw6J/vhZbIxtXaqKSxhgEYm3NKK7
	/CfPqf4AdyboOzJUj+mD3dA5NRDCxXJEgZ51W4njRdDD2AWMPXYJxCer
X-Received: by 2002:a05:6a21:880a:b0:3f9:9114:8045 with SMTP id adf61e73a8af0-3fe980f701emr3110108637.43.1795036367942;
        Wed, 18 Nov 2026 13:12:47 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb35da49sm1732055b3a.38.2026.11.18.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:12:47 -0800 (PST)
Message-ID: <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 14:12:45 -0700
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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
> An incompatible change to a kfunc's prototype, such as an added
> parameter, breaks BPF programs built against the old one. libbpf
> ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
> but makes an exact name look up on the kernel side, so the kernel
> can't keep the old prototype available under the kfunc's name.
>=20
> sched_ext ran into this. cded46d97159 ("sched_ext: Make
> scx_bpf_dsq_insert*() return bool") kept the old prototype as
> scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
> it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert()
> backward binary compatibility") reversed the naming. A ___v2 kfunc
> declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
> ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
> fixed a compat macro that silently dropped enq_flags because of this.

Please prefer examples to prose in cover letters.
Also, please de-Claude the included prose.

> With this series, if the kernel's bpf_foo kfunc is missing or its
> prototype is incompatible with the declaration, libbpf binds the
> bpf_foo___<flavor> that has a compatible prototype. So a changed kfunc
> can keep its name, and the old prototype stays available as foo___v1.
>=20
> resolve_btfids fails the build if two of bpf_foo and its flavors have
> compatible prototypes, unless both have foo's exact prototype
> (aliases), so the fallback finds at most one match.=C2=A0 This ensures at

Why is an exception for kfuncs with identical prototypes necessary?

> kernel / module build time that no ambigous kfunc flavors exist.
> Documentation/bpf/kfuncs.rst describes the rules.
>=20
> Compatibility is determined by bpf_core_types_are_compat(), the check
> libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
> changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
> return kind, callback prototype). The other 62 (const, typedefs,
> parameter names, integer widths, pointee struct names, annotation
> suffixes) were made in place without breaking old callers.

Do you mean that without this series programs referring old prototypes
are broken?

...
