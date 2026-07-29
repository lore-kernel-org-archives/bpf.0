Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F1632
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284505; cv=none; b=DpiTl5doM7eKwSGHfTGWSwCsLBTAcJsap8xDaiQd1xqAF4G09jHEk9w9YNq6Yoyq8d2z1cF1Q+9WPdXudPi3tTlo45uujBzBBLtcTAbAbRGVbijRmbflXzmG1gkRx6WRjZaVDLHS0BEPIsb3vYkzJoNHWRvLbDN49z2yzBEnOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284505; c=relaxed/simple;
	bh=79SpWJ9+Brrg4kAk5IM7v00+4qs18CV8xYCgdn+qa+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4bnnLtBkm0+CLFYiOq2HdNhb3n2MuPTFI+PseHlAsYKCTzE7eZ87Wdb6BxGApBevq3fshD9cLreC0YNyz1RTVkW9499a3Cjrc+OCk6iLjpW732/I58J2QAEhAriKRiKxFFSRaXdQ/Fq4HDp2wXjyD8AjW1Pk+HetaEAEGSknYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5UyGjed; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5UyGjed"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceae1ed204so5513875ad.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785284504; x=1785889304; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=79SpWJ9+Brrg4kAk5IM7v00+4qs18CV8xYCgdn+qa+0=;
        b=W5UyGjedXsu68Yvb9J4uCSZfFudTkhcucH5Bpjf8qkekIpp0YR5+v4C1DIXqX7pMw9
         aTJ9GGm3bq9RMgKaEgjFlyXMPqokcIuFTwU4g9fDdwzeyxrZFFljL1mWK/uSMvoXObHU
         BUREbej3UYPB/hcqPJsUFOxiqBSFheuhUhoHmuGq5yfDMHI22n/w3Q3OeDBhz7g70pyh
         lb3VUzo7yHKivHLBz5Jl+McLT4S3yNGAwm02y1hEJVCkBpq0G6SHDO2JbvlfrMe89ZZG
         l02ottAeHxG9dlNtq7SjNRdWKRRWzB49DLcp0uyxPnTwoGMFzpm3W3YQ5qDMCc2ERJGh
         RhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785284504; x=1785889304;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79SpWJ9+Brrg4kAk5IM7v00+4qs18CV8xYCgdn+qa+0=;
        b=Q9ltzvFd0uC7+5waeHPv22l6/NNGGDFw0egM/nkUvs4qgTNT7qzts6jc9cqAiZwLVn
         ve6JSyjw83mhIU/BpHKQCR1WbXhr2pV1Wr1J1k04w60Jjqh+ukT3j2dkF5znF5HpGG5M
         jTuxn5kiru+6yl7/opoABzmyh1rNzu4L8+d31sHXnPVed0oJ0ZAU+WueUhGcWdcacG6V
         T1ri+Jx2VVQDFZ+7fBNNbrwq7Bg17OZdY+9U9fX2Ye1aNtvInGFhD//05l5WjdR7xQ/R
         lSuhzbIEd+uUCJZxNcG1tiexokttuU0Ze7ofOMiUTL97dGl6S/lyR4NeJ0jBdC1c0bXF
         PIKA==
X-Forwarded-Encrypted: i=1; AHgh+RoB0L2nhHLVDCFWEv5l2BRyXm0XV8+v0lXkgkv30wHrzptlFRKsfu46w694Wa4YldVzkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrUoXMS19g3ufZMQwhHb3CcDYXJTGh57SET/hB/DKhPMgaMNo
	XqhRwlZI+ULUBdxuHhc6EVnoSu3aJTcoCTQ3DujM6/2Q1LO01QLOCtnU
X-Gm-Gg: AR+sD12BKbF1h6NKDm1TwqzR9mlc2cHA9DsOItHoXRksJwur0heDY4NwXoy20DUnvSw
	wRJ7j85kCdamw/kct6hQ5i8WU8OGw+ON2aD6jYCXXKzLxOoh96mQofU6uYKliraM4+cuRleva5B
	eQcjEDUXrN/m6XJEPhx3XURhtjqob3ONLqrACJPdLi6rodTBcnWGAjQR695xpwYVPZF5GiIPGpX
	iaaULH1QKqCCyovwJhOYE0X0YLvtDe15ix6J5KDH1LTI5j7tv54zOk9IKokg1puy2Yh7SZXB3KO
	EXmUNoT9X87uG/uAtgvQ1huPYmNkn1mkhqmB5JyddXgdBwDcfcWWiopH2IJEw9coMJy4g5jkO+O
	UkfEJqdy71kgHDavgisSbE27IkEIiq2MLfo+y5G9+M53gskQoyF0VvuSGcOaYvNsJdFO/BPgVUZ
	7R0Lp9dOSpSR+G6T5+LSwbQCmWH0Dh1xAuTWVBVe2WDSxrmKzryh2sRIeaH7oGA96ReTjjIFPga
	C1znFmTpldUxURnwgWu8DQuB+ZqX/Mf3gnwkG6lVuy92w==
X-Received: by 2002:a17:902:e54b:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2d015ae7bebmr52117405ad.20.1785284503953;
        Tue, 28 Jul 2026 17:21:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dab0f3sm2841581eec.27.2026.07.28.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:21:43 -0700 (PDT)
Message-ID: <d1744acd96926b27985fb40c61a2bc3640c0d0e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] resolve_btfids: Index BTF ID symbols by
 address
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:21:41 -0700
In-Reply-To: <20260722233518.778854-3-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> Keep an address-sorted index of parsed .BTF_ids symbols so that the
> original BTF_ID symbol name can be recovered from an entry address.
>=20
> Use the index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
> directly and match each entry back to the requested kfunc.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
