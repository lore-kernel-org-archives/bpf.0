Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573213932E1
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610334; cv=none; b=UEj5f5mEWRw85KK2Lsx42DNTUaUNApAfrjCgB/eiJI/MsbI88NtObpV8j0Iz4CWFax9pERDcMivJ5yj1XgIZldBzlNc1PZEgLPmpBMhPWoQ1GIuY0dnfIusHzUd575tZ7QuOYvOffFR0sLn4/IftzlIrJR7cMQFvFCIqkfq8/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610334; c=relaxed/simple;
	bh=rBDx8r16rs/CXcdvL7Nw7E/kWZMToLtmZd+II4Pyvys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQwlsPNwa72cEfQGfsEjR20jtj50r4GvdRuzl38rOW5Zi8dWcOz7nZT/dnQ/7NyVAUTGY7Snzv7KlVN4kteKSj8v0HB5nzRtSVpqkKCg0DKAoG8G0OYAkOpRaaOPi4D9L/Lt+qpr8maLn405dmL0rhB9HGqEmKm9vBLyraxAQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2PHqCNP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2PHqCNP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4494375a91.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787610333; x=1788215133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/ZIK5ous7qlP+oQoQj6q+F1xkJURvCwjZiGt+ud0ixo=;
        b=B2PHqCNPEq77vNL7c9Xf+BjGKdL04FFi25EKU5ZnoQwdbVEz8TbVFWxGaq72KU/OBq
         yn9O3twBKPF93woPgV6A1AG4tMJdca7D/G0QTXndjPAAbqEzxZpe51suP6NyPus1z97e
         oCKMxh+kRQ/7KpVkfGfMrhxqrHJDcSnr83I9OZb+jLNQ+ozly2N3h3URC+/OiMWIDosT
         mIAMKdWYpmeXXsh5QQEDMwfZZ3YoFXRq+04oBx3Xf3O5XzCdXcmU4RgyeKoBjtdDeqh1
         6rEtkYKe5cvc3/YvznYeoAGEDiWbULNnTMO6xiunWe4YSUo828WqDsJWGWKe9AnN6o0h
         SsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610333; x=1788215133;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZIK5ous7qlP+oQoQj6q+F1xkJURvCwjZiGt+ud0ixo=;
        b=FUxqMYMN7Ldb8ZNWr8W113TCaTU8HeJ9WgyDomdpfvfD7XwSe49hlole1x3Dw/vifp
         SERbwyS/f4+adiTDWobkke3Tnmy9sSDVbhFMgEFSCJIauKAn/v5+Xfi0BSkb8QnVm2bm
         xlymPVNVUwJgzTSJaCPMl/QDMMme8OCpSKBR3ewk3pPOePcyq43JK+j7KAocokWPcVvS
         QmYPi26sfbGcCo1u3gEkDaE4CtDj86v+nU15REuTbMiYlE/YoJYOJ/UED1eh2emxw7SZ
         DWE2VpJHJFVMcO4Gke/I7qTF4XIAEa6CEH1VF0YqznKiKcIyieSKAfydjrAVew8Q8W4q
         uBOg==
X-Forwarded-Encrypted: i=1; AHgh+RqntNKc13mcaDaZQiIQqGbT5qugj6RPQSMhhLeSUNPyi/06jKzwT6e+DA3pzRO515e+3FU=@vger.kernel.org
X-Gm-Message-State: AFuF++mySESRdQUdIWaPbybZMHmZ95dLB/z0iJaH5jFf01g9MUqHgI5L
	v3BNfbqMDbySkawpmCeYqDHVX4g0Z6FD9EM6EbfVn18maE0kNtO4cB02
X-Gm-Gg: AR+sD10rdwtNH1MrGdxixWOjxC7Yc1j9jpUAjaaM+oJ+bHfhoc6/qAGr0yIl9Piz7Tq
	z1ykWWHYDBthFhU7XM8cVVdkfMuurTU5TwEWNt2oIuWJ/6Dlm686ZPzWU8Gj+oKmpIXBA+GLgjS
	38uSlt8zNxLBFCm83zEtWLR5nJfHfj4tLjZIEn2xSA4fTHHRRdNjduwskRSHo+x+IqPjKG77ETX
	zy5D3BH2OBU11dsHsMQ+Fzmk4Sc8BeCfV0496OE/v7jKHXm1PqGrgQRcDW51V1pjx5T4rI48aOu
	PK9wNEFhj9z6k3ME1ynaPvfNgOsGVgJidz8JGWRgutTdGpjX/I1c3ONqo3QVhCd4FYCryyHx8ZW
	f7HQvc1b/FuNQ41vnHcXCxAkvDDv8L/KWo7OmxrYVB36h1IOQjCZsVVIqEfuL+At5VdsjInkzoY
	bMjF5i+gNwcApiYYxDJsg0kLYIl12Jkcz/gq1hnzn00tzg/LyzdJ7kgZ6/G1SMqmiZECfDZWlo1
	xFp8sfMWzUPLsjQbZMXYkJMzVSG7pk8d6/nX+XjoY9FuBwr7mqki+Fa
X-Received: by 2002:a17:90b:5112:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-395df3cf1c8mr41128420a91.10.1787610332618;
        Mon, 24 Aug 2026 15:25:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm32160873eec.7.2026.08.24.15.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:25:32 -0700 (PDT)
Message-ID: <aa7fd53b3521c5f402700c5df7056a23962e4ac0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/14] resolve_btfids: Drop KF_ARENA_ARG
 flag support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 24 Aug 2026 15:25:30 -0700
In-Reply-To: <20260821233516.3426127-13-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
	 <20260821233516.3426127-13-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-22 at 01:35 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 3f9949e8227d..a4381c7fa7da 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c

...

> @@ -57,9 +50,8 @@ struct kfunc_symbol {
>  static struct kfunc_symbol kfunc_symbols[] =3D {
>  	{ "kfunc_a", -1, 0, 0, false },
>  	{ "kfunc_b", -1, KF_FASTCALL, 0, false },
> -	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
> -	  ARENA_ARG(0) | ARENA_ARG(1), true },
> -	{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
> +	{ "kfunc_c", -1, KF_ARENA_RET, 0, true },
> +	{ "kfunc_d", -1, 0, 0, false },

This changes test cases for kfunc_{c,d}, which previously were
expected to have arena args. Why?

>  	{ "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
>  	  ARENA_ARG(3) | ARENA_ARG(4), false },
>  	{ "kfunc_f", -1, 0, ARENA_ARG(1), false },

...
