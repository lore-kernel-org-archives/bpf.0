Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B32EBDDE
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271071; cv=none; b=GzgyjpiPGWaeGLi6Woj9XoyZv99J+fH0iOGqMqttCwhJIxJX9xe2pEtorhEhj/OwSpRfh2wMNP+l7Rqm29xe4SBl6LKLhOxs6PseCRUKhqysbO6t3tErlQn19wCaw48IIPAE+X6Fbzb39fg2IeyT1/gOeLohmfHb7OIJxwjcO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271071; c=relaxed/simple;
	bh=xlBre8X0QT8NlLeZRTfJWdE9tVmL4ARL3Jf3KCwmik4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAYa7CDfJryv6OlU1ctqvaFvmSeKGMvoawLyVf3Rgadux2EP7bhu5ZcB569oik7yK2p5gBXjMaoDMgUiy2B6/6cJuL862QHqKP2l6rJKgmPHSlQHar8Kdpd1T2/+jBntSu+DeVK1/SqN4xx/hKUC19xekKfNt7FeeHQy7jjQV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLmH6dtx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLmH6dtx"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so4370831a12.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271070; x=1784875870; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=91QAhxA/bXlLyI7Ii/MPNy3UTDO8kzcswlfxF17K6QY=;
        b=cLmH6dtxxkvGUeDxcjI7bfQlY4jmRO+hpN/SGBXfAk/8V2TRGvgfZYYUDvKYtl5hHO
         Vv5uFTKxFy/QAZDf/kkKpotf/34iiWAShZolBC0OfpZYZhyzZDCdxa7hWqS/yX2pohWi
         adY2hVqqCFEEEzUeey4tTeREu1R/bT0/J7jOgpvSfEJI/BMfxqhK/ZE7x1s6OKSjRalA
         4iOsCqt/6XIytTXswCnlzcIATF3P4lObCCvubTOLyMSkXVeFjqIzIC1PanYIJ/8rXFMg
         7F39DrYeXVT5OW59pxtXAaTUmrHU/sEVUXUQheOGVlUZx+Wselib4EFbLc3yXJ4XI20a
         H7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271070; x=1784875870;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=91QAhxA/bXlLyI7Ii/MPNy3UTDO8kzcswlfxF17K6QY=;
        b=If5q6eLd/aVh1zK85QysCU/+BwAgPH3Ui2PwEmbJBjfZIPiLBWQVYg+gqJFScC8FWk
         A3ZNsi+ZbXAEqSRJJtTgFTx6iBd8yG10Yg/yh8b5OfOOd9bltLohjMhRKs2eK6ovCcAk
         wJ2LfARjYcNwIeUdTmGgFmwQaCi1gHvHkRtQp4KP4RvWXN0sJnbvf8SsLLYJ2mroDm9G
         0hXFfd6cTR8QyvJwWgTJCGejVkNw9oHkMTs57RaBDwxH4xzQhznsNRVekbuNXlQbu1Zg
         TiD392FrYnUEfpwssUSOLq6+Aa6j2oPih09fEkDvodv7zVEZ+u9ioi+Nlqg6Ue6gVMR2
         Rj9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrxhh/wDsWXt++b+EsHjKxnPM9YcDgnD4YFGjNl/Za9l2TqQYxxQf7+X6eYG3eR9A9JsJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuhdtVu5ZLohlCWxgQMm9KsCudnKodN7QBf91QTiN83aL+Di5
	3VzAhMtbcGdZ+ySHvWueH245aF+JxulXMhlbKtE0yuE4JOwaG4XG0Vz+
X-Gm-Gg: AfdE7cnSmCnuiG7j+Kn/5f4exnzhtdyKvAGgpj6+WM0m6Tz7kP2N+oQlbm0cNsYr6y3
	Kjj0mReI0/wA7UMVNq8O16cCI+88CbSRohnsnBVN3nL3HaweCe4rMuMJaRPKPe1zr1CGWN+wV9+
	JzZ0Pj134wyF4+qOL7MH65devDiAB5JJgYGAat/GUN2rVkcSHLcTvQMcJAGysEBefQY1bCl6HlS
	HBrku6EQVjFM2BCY8PI1u374Qpq1Z1QhzdPZN5nB5d7pme+y+Wp+/j2ec5CG2eXsCmD39Nc7lii
	CHA3wzOzJhaX4xxZm+uiMpNNrf+3VHNwZB92BOUG9Dy6CZTWRrpymzQE9Y21pKqBt4KXhG7ym+b
	2EFBpct+aKUce9ki8uuF4/QSVdpi4NAIRtJ75wKJFkrDCdp83nyUdjGCIvc2NEGwXZ3pTeRNvhW
	H7ilRkwALNV2EdAJZlyL5Y16EppPqINNc=
X-Received: by 2002:a05:6a00:2405:b0:835:6388:655d with SMTP id d2e1a72fcca58-84c29305b4dmr1241103b3a.14.1784271069756;
        Thu, 16 Jul 2026 23:51:09 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcd3dcsm433593b3a.24.2026.07.16.23.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:51:09 -0700 (PDT)
Message-ID: <d348c5e190c00f71bbf0f38107ebedc9f54e98e3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: Add source and instruction
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 16 Jul 2026 23:51:06 -0700
In-Reply-To: <2978385544ba62298a8f0323ba22e70b9096e4f9.camel@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
			 <20260713153910.2556007-3-memxor@gmail.com>
	 <2978385544ba62298a8f0323ba22e70b9096e4f9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 10:49 -0700, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

...

> > +struct bpf_diag_insn_buf {
> > +	char *buf;
> > +	size_t size;
> > +	size_t len;
> > +};

One more nit, Claude reminded me that there is `struct seq_buf`,
which is exactly this + a set of primitives including printf.
On top of that, seq_buf can be used to manage bump allocation
in diag_fmt_alloc(), as in [1].

[1] https://github.com/kernel-patches/bpf/commit/5e719a70cc454ef093aa689d13=
a0e502cb004962

...
