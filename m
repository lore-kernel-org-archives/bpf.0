Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965D3A0B21
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097513; cv=none; b=u8HDIvBEmtGF7T/z3ZakQzJogQeKjQZlnQXH/4ybkBFoZdXaiLEw0P2irqkYFyU5nJ/i/6ENupMlTPHjC6dbEUv4TU4TyI2Ddx2iKgcnjg7aPtJqSQTn8PXuaROB9Sm2YaZ8/Drg/o0CZlizPr1Lw/rge/6cWaKrkAka7Za/Jfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097513; c=relaxed/simple;
	bh=mecsNk5EXA4LMhoGzhpOlPJ2Gx6bz9WD4IpLtHUkCXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsFsZEWf7C6rnDcR9JhaO/lvEBrDgkDKQDojd2LJoHs9u56FFmKvEf3MZwakJWjlaJtwrZSWjDCE+Kzzy7cb/I8LrbNc9GLOGKQeqTPSJpz8W6zD4CNTAMPZe18DOXH0hMCiC85ofzrBGP5kIW3Xcg0dxd4A9MOZZHpUiXrDGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNtdaiat; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNtdaiat"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-358f3ef464bso311750a91.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772097510; x=1772702310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mecsNk5EXA4LMhoGzhpOlPJ2Gx6bz9WD4IpLtHUkCXk=;
        b=PNtdaiatO1PrvURm++yXoPF82bNLOHIdARqb1hcZPgznPq5eOAGYqRwc4ZpZ4pIx3R
         rFD6OBtFm1rjhfbd/5VsCg6sGmzrZxdMhSryV41FlBdPXfNnYtCp/WzuW3xuA2CdMdYr
         vovU6o3XWqf1G9avy19cMsNoTa3lWsM5Lp7nOhuStjbD9rWWkFPseq9gdWfhwlw+oIAh
         kMWNQxPkmZj1Q0dkA4HuwgM7H4vNF4ui3d/UvL/XIYvro08va4XDH3ZypTXv4oSOtJdL
         8BWtPiRiBoI9V8whqqNxZ1XOCegUXjcTXmdDqH/45Of274kQxQ50poaxU8pwWP6vF3pC
         QaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097510; x=1772702310;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mecsNk5EXA4LMhoGzhpOlPJ2Gx6bz9WD4IpLtHUkCXk=;
        b=IyglO7peT0svW+Amr09doyqCF9RUrcU5zg7CZRkZE97hboGu+dZPN5zn2l4PxbQG8Z
         WkGb9U99+pftLXyPQUIBYxFtOYNRs7uE+wWKvcidEQbAPF9Bo2ESoES8CQtZKrAXhtle
         AM5JbgXluaWWBAxhyI1rkV2fs1LfCTO4VndYWVXJZLGJNWhH7FHMD7swj8uoCWe5fEWQ
         idG8gLGjc0i42P4rnoEEaI1frku3yYBjQVNaiYHUcqAJsHzvKnax/XtN9wibi/F2iLWH
         K1PxivS+y7S4Z762Kr8+n3wtqBp1Go/mdzlTg1pQf5xg5/Aklcf3bRXQKMpzB2Ti3QIs
         WzMg==
X-Forwarded-Encrypted: i=1; AJvYcCWD4EhCxsPhu2ZHXtHvXosaLFu+gy44KwoIy9InpmSxSW45J6xvAzBO//POfLMZppUO7U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0T9D0w/A5ANidEM6tEsAuF7ovqNwp1dCXEHTpatVUL12ujhLN
	6TpKuh6fvmY/evp3AanMCZZnZGSt6G0nUxgp2fHLsJovdjSSViR52r8Y
X-Gm-Gg: ATEYQzxzgZsfCrlnoSy3tLEr+gYC9t2960VsPGRo8kBnXOhf5o0Od9kUAe49MmlQKAG
	ieI4nerIhwdvnVivXcTsPJ3qHEtdU8i5gWZYK3LJ38SY9TBROfUpMRf3wHxOVpSPGzM4c+b+XBR
	k0A8UKlJpIUOCMo8cPeE1afPJSKgpV/GmI5ylOvPlydl3MPMUpdjpzm56rJNbmPJKLTk6OzPaPe
	B7kgfitL8iUNArpOK/W0rCOFW1iu6gI9iK9PKOucSTnvfAKBLXLsDN1G+ajFLWpbAkWR8fZHYsv
	RNiWRfMwb7qRZRXFue8U+81p6QF32J5abq/2VqqRr/z3Wtw/Vup5SHDwuYMC4bXMfnnmKt9Jzs1
	0MmE3qzFuFFMn2uUmEf2Zup/eKZj0SdUY/BL0KbZzGeRz1HmmyPxwCMHT8co1mrCA36xTXbYKH8
	Km4z+EeR0tjp/dTTGCc2lnYabNDVEnqbEZ482wXDuGsAQfwZlEenk=
X-Received: by 2002:a17:90b:4e83:b0:358:ee5f:9c04 with SMTP id 98e67ed59e1d1-3593dbcc79cmr1910797a91.30.1772097510197;
        Thu, 26 Feb 2026 01:18:30 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcad6ddsm1562139a91.1.2026.02.26.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:18:29 -0800 (PST)
Message-ID: <4729132fbd2544cbe3269ae0ae32610a4a0fca81.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Consolidate sleepable checks in
 check_kfunc_call()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 26 Feb 2026 01:18:27 -0800
In-Reply-To: <20260225134950.2781351-2-puranjay@kernel.org>
References: <20260225134950.2781351-1-puranjay@kernel.org>
	 <20260225134950.2781351-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-25 at 05:49 -0800, Puranjay Mohan wrote:
> check_kfunc_call() has multiple scattered checks that reject sleepable
> kfuncs in various non-sleepable contexts (RCU, preempt-disabled, IRQ-
> disabled). These are the same conditions already checked by
> in_sleepable_context(), so replace them with a single consolidated
> check.
>=20
> This also simplifies the preempt lock tracking by flattening the nested
> if/else structure into a linear chain: preempt_disable increments,
> preempt_enable checks for underflow and decrements, and the sleepable
> check uses in_sleepable_context() which covers all non-sleepable
> contexts uniformly.
>=20
> No functional change since in_sleepable_context() checks all the same
> state (active_rcu_locks, active_preempt_locks, active_locks,
> active_irq_id, in_sleepable).
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
