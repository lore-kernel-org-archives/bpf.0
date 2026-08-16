Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25F2D5925
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786867272; cv=none; b=EQnRJVuR9rHyl5Mv3/S1sR9Cexb2NorBYdXXCmcobutKzJO+8akp+0nPQ20vW8fHNoq5zODSeeW1kYZ4+TOK40Avq6qNJpcC+hOdSZUefPwMbI+n0/VwqN6zEFIPx5wWQv5yyAlD336qNwh8/0h6UCqVihRSXHk0Esup4tq8ujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786867272; c=relaxed/simple;
	bh=+TZXUhWx7bpaNHxszc7UK/Z81aAqrkOGmR74fFw5fgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3em1zV8HkQSOupTvLFa/Y9DmagX/bBHGd7SANPM+ouWOEY7RzxoN7TOrgUVIqm4pBYu8aYzLUQ3miRAveo9mhj7MaTD6jBq71AlWCsh1Ri7AVMPm2kiM5fLCAWoZ/BTgPl2w7fZH3ApXC4MbjZoomZC7om6JSRjVchhueJM09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIpHbZxB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIpHbZxB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e347638adso2897006a91.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786867271; x=1787472071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+TZXUhWx7bpaNHxszc7UK/Z81aAqrkOGmR74fFw5fgQ=;
        b=hIpHbZxBpgFld/VBU8tciGz7hFWST09IHh4nZq2N+YWvottYyesC1F4EGYrRkr2AmX
         BeqvjzsW/Yq+LCXeav1tgzgORXJJV0m6+3OoVXbQq9buY4LkA61+2bODN0f9fb1NAGpR
         mUSbH25jzvZQx/3YuAmOQqfCtenpGRbi30VNQ9/uEflB17fr4gh/iytus47OhXQCV9O3
         9YeC9pHcpO95+HEds6AfSIS5f7w1ujgfNRfhom65+9XwPt3ABzYCLc9OaB6Fbu4OPXeb
         bXJi3iImYk6viVM53/t4Pz9gpcAoVD3StXzBsuCqrFNVASLrLpmbixZ79hY0nXPR6Hpk
         8NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786867271; x=1787472071;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TZXUhWx7bpaNHxszc7UK/Z81aAqrkOGmR74fFw5fgQ=;
        b=a+KGasybNITPaeDdW8JKZuQE5St5a67FgobYmlisY7CyC0V3e6CXxf9dc640rmFyfq
         WUOapt7D29Jm5w4r3RMJaN/ZHUXxjGzZ5r/uw1kSH78SQ+4AWwmrNIv+QsKo2PO1QRli
         joBrEYdwWzBM2vP78JuhDInYuR13mtWu2i63heGbjf5eX2GEwmsNuPf6LwFLEEnP9d/1
         NeEfIvx5ONYLTviiS7Ra/URTe+DCSbiZtXWMTU78pTsRpMNV/qHZ0AttB8xRuyspUqbH
         uCV2rBHDU9sm7w3fyg6Bcu6qcSyjQvi5Ko4jhueNLYDU5vLl3CJGcaIZ03fotjTGLf8x
         iW7A==
X-Forwarded-Encrypted: i=1; AHgh+RqMHRDAYojbfgsM5vE9Q6G0mcFamuwDyxSth/ESvJL7GXqx/MH8+7bZJTsGyuq9FhAwIEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibAnkI6HlqHs7iSpofM40alO4xalpyqIYp2w+lvwb/f1u4xEI
	e8SyQkE7zSVbTqOBIAUOOWrj/iOtwl8c6ia9ZbviTPgd1RtZ2ZsDFB0B
X-Gm-Gg: AR+sD10XllV6Z4RfyOlu8yoI3nOr3goDqTziXz1htFBja1Q5Kdu/ElMuvCWNj5YHaFY
	i3+CD5HGsbRGrCUy1kREc2HMS5qTeMEmE+URgPu0LbFme78SzvJz/N+W7JfIxkBCG1mKoTnT6g/
	lz4afs0FRJw58qlTg5DZwl46ekGF1TlxHgCppOsZ+cqmUdSKQxZANJ7WHpp5bzN8Qp75wuoffFw
	UXdQQKce7E8tZdibb10bdYrASyJUuOarwSzTpYpngCwCaN9OtnuhMC3Vl5b/+PF1cUIIN0BUKU5
	5kNzimFUOhfbjH9DubOXTANTZUloSUfgBSjH3/14nFrHSl7hoKss9coFf2AUKzXWWt7n5R+PdNH
	/k5/ZdyFmS26BMqKi543aZaMXBSA6EDSy4KX5xDHYJ9zOxTTLNIg8hzDsfx4IHHmDdW14jX9bQD
	skhMjOchIaAnerDIgJ51SamXNGi/wBZ9tX5KyGTrWHTSFNfBswrvkLRaoTd8gL64cVDvfv1xEBz
	o7S6XGrBKr93mPl
X-Received: by 2002:a17:90b:4d08:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-3933b6f0622mr17541335a91.4.1786867270823;
        Sun, 16 Aug 2026 01:01:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e10d9fsm899008a91.3.2026.08.16.01.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 01:01:10 -0700 (PDT)
Message-ID: <82a51a8e17c4cce62ead6faa5df2e856e395ef11.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Preserve source attribution
 without source text
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 16 Aug 2026 01:01:07 -0700
In-Reply-To: <20260816015746.2632990-12-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-12-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> GCC emits BTF line records with a file name and line number, but leaves t=
he
> source line string empty. bpf_diag_source() currently treats that empty s=
tring
> as if the complete line record were unavailable, so diagnostics fall back=
 to
> an instruction number and discard the function, file, and line attributio=
n.
>=20
> Print the available source location before deciding whether source contex=
t can
> be rendered. When source text is absent, omit only the source context and=
 retain
> the diagnostic annotation and instruction context.
>=20
> Fixes: b9c5d822f677 ("bpf: Add source and instruction diagnostic context"=
)
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
