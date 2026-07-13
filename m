Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8E1DF261
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962087; cv=none; b=bijdhJwdJT2J31I4DqxUopLITszpjbZ7SpM77xFKPj35wPPE7zMePMEjNBS+wEFx9q49u8HWO/71KAnTsLSaYQ0yF9r3MUjQnBiHtlFLhh+Izo/CbGnU4rp5BcZruxT2izXKHjqv1ZZDFQgQd7sYcYPsiZbmNUSzEHEMu4U67QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962087; c=relaxed/simple;
	bh=PzU/1ZRvAOcMh49STDHy1Ec/tLqVc/NQrZbebKocuus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeeE99aqpgWnvVxZsOoUwWxCqyl8Rc5UOAm3pH+guUYIsNJUNWveK2Zv7mD8C2y6mq5knhle6wWAzHMejRi40mQYPq8IR8MLi9DceUItI2hxykFUcn5k6mnhCQlnXaHnxLYb2sxj+ZEOi6XRQ63TPACi/h4U4mZ7NoKg9UdxS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/0aOaq+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/0aOaq+"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so2206221a12.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783962086; x=1784566886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PzU/1ZRvAOcMh49STDHy1Ec/tLqVc/NQrZbebKocuus=;
        b=c/0aOaq+MzB2LA1FCRZTrIUW0y/OB8kjtdbFdd376fZ2ph9I6ks/v+2AwhvrvUtXPb
         TdSGAHgN0DiSlNajDprd6rGJ/6fzhx6Po7nXW/lPvhhEvFsB2v3d0rEw+VWq2cs1inGZ
         0R1YpGsVju2qZIxwh/lFmWwQh0hHa1avxKxhPZAG5yrQu5eGrLOFPYyrFMRbXZnSYsAl
         ywfCAtn9JepmmgUUAjroI3B4xFgwU+JeQwcsDQ+fRll/UNVRKeI3EUIDDLZoedR2H4vr
         JUgemUpAmJ1tQQHd1KH9ayVgesAt6qD7R4CQyIb9Kr16/VCRt7pTmhqeF5Gz12o0fyfv
         4Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962086; x=1784566886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzU/1ZRvAOcMh49STDHy1Ec/tLqVc/NQrZbebKocuus=;
        b=InzojAQ2ViZER1qTnAX57ZF4b2TC1FjSVu/S9y+xL/sqWAc+iKe1B+/ffCI4fZkKTY
         deRZnT/uXAEohRegQr2ZYiaL6y7nDm0+QymEdn218Nw5NTEVtRZXm5RPCHS4UJDNR7EC
         hJ/wBJTwS88m04k9OwyUjKJ+EKWrV11cS+Ot/aX/Eqt6Nr8N3OhyQHEA8mrsz7Vmakfz
         99u+NHDFcnffwNW+BHx4DGl5BQkctVC/TYjpX8DSjzswyxbgma9OXbtB3DsdtnBW8Ug+
         ltaLhqCBoN4/QGWsTvfDRADP9J6uCQc6K1Vun9civnpdOr4CNBwqF0cQ0wSreGGdm636
         krGA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1TGgTVBZfMuzrwEGxRntBXrcAkgGBYrCC2rfQ1J37RFQVJbEFmLnzJBm+BV8+Jo9TivI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOm97DQti6wqhKpdPVyHdcdulDfDfSbk+3UaqdK3edZpsAyRnn
	CNX54AidHHAPNdNl1dEhGP06bg6I6fJXN6LcYTjdsgFCs7wa6tRII2ra
X-Gm-Gg: AfdE7cnfpJ02r5/3xDlHSoRLBQqBaYnZQtga0ioajN1NJLFsCPRvoaHjjOR77apyOLZ
	KfvivAbH1wOkjz8bhrYQIm0aR7jxFWSQMJEw27CORutsx2a77me8DPxcAvxMXc+f+rz4++Vi33K
	m3WrI1PkjoqTG6sTihJu/qGTCp0IO5qUjWLI5QbDN2CybwM901GUcTh/SKij3Xjmrrb6a4WN0Om
	0ildAIia9v8D7qulZf2Ej2XKNTRKkeQYCzXHfcG0vstaDdD7VgFnGJQuGzE5ovT0ZIB0paJZzRs
	Li3g5p75lYCugjS3feb18C7s+f/MWeJU4K7ucNwvrhvpSS4knoZF576p/vSpWnyQeLdSARmfubr
	xJgcDWYpHQm/dEwVtJWxahmgrawpO1pTt0x8Q/cvWTAKO8sbdM2HQ4gCcQGU4tK6xbVEnc9MZaa
	CQ0eHlK52RXVZF12hXUe2Y+k8oPel/q4gfUDhwLdjGLElLBJd+vs8=
X-Received: by 2002:a05:6a20:a107:b0:3bf:b885:2fad with SMTP id adf61e73a8af0-3c110e33100mr8766939637.53.1783962085550;
        Mon, 13 Jul 2026 10:01:25 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162f65sm8618011a12.21.2026.07.13.10.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:01:25 -0700 (PDT)
Message-ID: <07dd30294e3a15aefb88e5be250a85d330eb2ddc.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Mon, 13 Jul 2026 10:01:21 -0700
In-Reply-To: <9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev>
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
	 <20260710192940.3020280-2-ihor.solodrai@linux.dev>
	 <a183b4d6f3e814f9ffb79c8e0efca8b5f162e127.camel@gmail.com>
	 <3b272469-9563-4843-8126-5c6698a84d98@linux.dev>
	 <55f4d7bba39f0fd1e85f436423a4b9a967470701.camel@gmail.com>
	 <9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 09:48 -0700, Ihor Solodrai wrote:

[...]

> It was silly of me to mention the analysis as an obstacle (which I'm
> not excited to do, sure). We are at -rc3, so there is a couple of
> weeks still if we are targeting 7.2
>=20
> But resolve_btfids series is certainly a merge-window thing, so the
> fix shouldn't depend on it. And even carving out build-time KF_ flag
> consistentcy enforcement from there is too potentially disruptive for
> a "fix" IMO.
>=20
> How about the following plan.
>=20
> In the fix:
> =C2=A0=C2=A0 * delete btf_kfunc_accumulated_flags()
> =C2=A0=C2=A0 * expose (back) btf_kfunc_id_set_contains() from btf.c
> =C2=A0=C2=A0 * in btf_attach_func_proto() walk the hooks and specifically=
 check
> =C2=A0=C2=A0=C2=A0=C2=A0 for *consistent* KF_IMPLICIT_ARGS
> =C2=A0=C2=A0 * -EINVAL on inconsistency
>=20
> In the v2 of resolve_btfids series (targeting 7.3):
> =C2=A0=C2=A0 * implement kbuild/module-time enforcement of consistency
> =C2=A0=C2=A0=C2=A0=C2=A0 for *all* KF_ flags
> =C2=A0=C2=A0 * fix in-tree cases where that's not true
> =C2=A0=C2=A0 * if there is a valid use-case, it should show up as a block=
er, but
> =C2=A0=C2=A0=C2=A0=C2=A0 I'll also eyeball all the kfunc set declarations
>=20
> Does this make sense?

You can do it like that, but tbh I that think doing it in two phases
complicates the process unnecessarily.
