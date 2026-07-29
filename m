Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D331F875A
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286203; cv=none; b=bTOOo3enGyl8cpTUjqKUkokhnE7oAWF1Tbgr+/nSzJ+fIZ92y8nskSuKxriFnO1wVnIsfIB8WwsSuw2YYiniHsmCdW3D7FIV2crDvJOmKwHJEAy+Z2jWrMs2H+F+GKNJm+lbC8RT1uxdZwFHRcdtxRPp0iAt4m/KAtXorXePyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286203; c=relaxed/simple;
	bh=sJUZyxGvvFX/qYT2yX5RuK/jdFjqeFiNnLhHYvicXnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zad+T8daNnTpIrHzC2WW3bv0yEUVISkZp9M+hOWfoGQgyNkDna+xPniPRNA/m4K6r+dsldT5tAwOb5oZJMA/fOJC2aLfMesg7sUPim9y/cdtskxkawLvEo/T82icVNxuDR9i4XD4K7SAofWZ+RF+PIzf1zjaJTFDRs11UL0A7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgeJ0o8C; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgeJ0o8C"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfff5f88dbso4792545ad.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286201; x=1785891001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sJUZyxGvvFX/qYT2yX5RuK/jdFjqeFiNnLhHYvicXnU=;
        b=SgeJ0o8CWSv6K7YOt2c3q3jaP5/Ymxaz9HK5Rkj1ps0onadK/TRikWa8ecN9MrlvaP
         SjDDM9Tu6c42nzX2N6aVLpJ6pu1FW3/HuIW/buSnBBhZOCrRY6efHZ5kjQUE7Vufic1G
         zCjt00tIc5+J4oylQQclajcZyQ/SsMk6DIzkqOE7Ay43kxGLlLAIBhC/B+qKorYwuJdc
         /5DyniIfxYBxwNilDj7smCHXUNEg1FbiEOmy8dgpHzEHtaj9CFPPHz0em+h2llPy+QOh
         p72DxSz5BxySSOfHvO3H1Rdg0DG6szDDEaHxWKAvfd7AUIdzOLy+nKBVSsjAkFS8eSMQ
         2z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286201; x=1785891001;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJUZyxGvvFX/qYT2yX5RuK/jdFjqeFiNnLhHYvicXnU=;
        b=lV78/4NZKgGYXBULamGtWsPcHPJkuQ9toB/RnIgsl5ZaZrl3ekPjdvyqyYKISQWn5y
         5hpp3CZ93kkRY9vcaEerE1GopIWeplvbCQTygDyW/ucqPkrLzLpMQFmn5pwCJzDouojX
         f/dB1GRWuploafxhKC8Ux7qOyLPKVOL2PXJfi7/eK0O/273Hr+pUeiF/Cvn1a2tu1Go3
         faVN8Ud3mvU0/aLS08ncrYSef6R80RgB0abH2gLfnAglPnDfRowJDK9kH/RyqE3elPJq
         lGR7lysvlG8yDgRG197K5/JcRU60niw4V+vPXU39VlVgbzr5V+EHc9MEC82y9ieyJz7l
         F1cA==
X-Forwarded-Encrypted: i=1; AHgh+Romd1ZhX6YXJNAerGnCIxiZEYvvTzlhZ6oci15UzRecAO5pu2C6YEZO8aDGdWLnOmvkyx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRru1fc+OKiv0sWO0fnoE9bQNZKg9jD44al0Dy/5mMRJJvtSA
	mtno/TVgp0oYVdaU4I5a3ygfyItxu2cscCrYqIOxYLnMgaVeCV8hfT61
X-Gm-Gg: AR+sD13JNab918lRK4Ys6b7k6LXz1FgkfgKZWs3FhyrfxnEuLAOzPatGS1TR15RNRGB
	EkQ3zMJQ7TC0TbphZ/XOAxzTtTRi20/+DqIX8Eobfb1t8h2+ubRh5P3eEVObzvyvHHrhjeNMCzm
	q9+ruaFa9CUlc4CwLwvnGSxCcH4xc4k2VAmRqzzUe7UXc8FO8M/zxrl7jUMVRAKpYB/m6KDEMlP
	ivxJrBD2O11flBvym3gkPReMAwfBiiRXSEVJRVuQiPa98BqVILTj63YqluMBvpJQCbVxryb31H4
	oWXvcNHq+PPgc345l8KnKIaynZcTurTKjxXvm3Heuq8AsrRuwfK0DIaxr2duiP6Cmj3m+neSeIJ
	N+DegXv/kP22Uf6/gKrNcdKSE8Ajhq2Ta8clq7PxYOh+8Jz+tzXaCTtPDynaqE9S/iQ07fr9Il1
	iGGtcD/oY9zYoNUAoCOYn+84MmFVpM7m2EvNaC+OjoQWBDXvShEOwtczC77eLGPIFaeSesGW0AK
	RMJSW70z+JNLL1GdFSBekR9XudzF6RIGvfjb2P3eTkBoA==
X-Received: by 2002:a17:902:d2c8:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2d015db675emr49101285ad.38.1785286200935;
        Tue, 28 Jul 2026 17:50:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dab0f3sm2984550eec.27.2026.07.28.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:50:00 -0700 (PDT)
Message-ID: <40af4f2e3833d5ed3a73e6436c4262db21ea3fe7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfuncs
 in a rbtree
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:49:58 -0700
In-Reply-To: <20260722233518.778854-4-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-4-ihor.solodrai@linux.dev>
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
> Store collected kfuncs in a rbtree keyed by BTF ID instead of a
> dynamically grown array. This allows for efficient deduplication for
> kfuncs declared in multiple sets, which is needed for subsequent
> patches [1].
>=20
> [1] https://lore.kernel.org/bpf/CAEf4BzaLzX3mXvQzxv+gbmZOh84XvYofLjMSWFYg=
hNjS-ohEZg@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
