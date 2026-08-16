Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FD33D4F3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863183; cv=none; b=MWayBAr+ki3zywO2kdfzp6cUk6N8Ay2Yvl0ed/rqK8UYF4C3uCrq6lyhYBhjWuxiy/BZNVUIR0nIYddjaZGqvMFor+BhARTxLAHP1rnLgj4Ka4OeTwHJF8t1ZTA1Rcm77vLD1m5lXrW2dvEZKfPmUwmm70C3xx7SKuA1afovJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863183; c=relaxed/simple;
	bh=006gJBuz55KzJgxRbSnuGMxT+IXaNOgdE9+tjdcFEbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKvHL5YZcosXz53iPwFFnUpYD0o7UV6P5LQT1tlGCGPhLrkyElLhit9r60XjgTlYZYB3N52bQsq/U1RUiZPe3B8CJC+j2MOJ5B0R5QITdGQTDjIJEtep+dDlK1a84SFawkc3B3d06iKQh+OGSHhDHCexmAWpqOo2ypls5mwbrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeyT8VS7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeyT8VS7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce7d2adef4so40101825ad.3
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786863182; x=1787467982; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=006gJBuz55KzJgxRbSnuGMxT+IXaNOgdE9+tjdcFEbo=;
        b=QeyT8VS7usWi6jcUIbLdF+RsOj1NwoSImeWZ+pQU7AChqAZNIXkBrgYxwFtm+z75Gc
         gkPfas0FI4W1unYs21u8q0wp/N8fNup0SRtfCok9DJm9rtsxCfvIJ+BwDbxDX4jVIUmc
         3LV1Hzo0pnZBeFbanqa9V0I18LYhNZm+BxIpKyww6/Nqq2XggHP/C/mTKs+RefGu5CuG
         clDQBuF26vfCMmZBFqISjV56kTEVNp9IcL7tQMM1EEybIS/GIYGThaF+eaveT1qTNjcd
         q40NMkwx72PDA32xxGmibeA8Qj1FgxSfNUCXiUSU5L6mIo3dK/E0zvkOJ3OehBAJyb9R
         xI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863182; x=1787467982;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=006gJBuz55KzJgxRbSnuGMxT+IXaNOgdE9+tjdcFEbo=;
        b=LdxmPCcd1Ayby9ulQOYRH8OW5oa3o4dSz4mho7avfXjkPULpBCQmatF7R2SP/eiABc
         tW9pz2xDVO3nX0tECXU9cx0EOYqhot0NVHMVbWGuM0fWoEhTzIgZrZKyezu2S50w8bcD
         SfnzdMfSZhAUhvpUSI3tTwhsmL0d7A91HWCD2a84pAFo97xvSLswA+rLFtIMq9Du3rNk
         /PkfN84eoFpm37bv4uYwpB0uKq/tzioQ4YtqQrKCSRma2WRlvVjhi5NOruIaNVGt1Uca
         V+pbNFtJPSi60zhSdIKdhCG0KAQMFP1ySJSX3jKPOQY8quw5Q2I+3kqG5ECYuk3ovtv0
         PWHg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+frf//BCzdUS9WOdGRAb3Cp714qk9v59k6OEQx2sP++suY+J80QZ9M93s4WY44nIiEDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUBoOWHl+FXpXPgvdZ5cCuoxFc5FmOb80v0C889EBicieII+D
	LFAAyCA/9u9MGxIzSkEGEdW4DNOCFjsaGr94zQNRs/Fi3R4DqjX0fpX4
X-Gm-Gg: AR+sD13OoTvtjnK3RVls59l4X2XdofS32ntk/hyO0IIxyj+HgQYcEVY7XY6Iw551iX7
	PmUttcrbKy/UtxEvyfWPpPU0MRLuuX3J8zxe81+640fK8mXl6hePHb+JV2KQo+v8i7x+FceATY5
	8JdFjv1yqLahpBTVjSe9peGSwBkAppU0VJOQo/3D6XWVZK3LnIoOrOE3dzRygJUjMJA9H/H5Jgc
	UPgxlCel8WRZqN3h9+EqRWGjlVHtnAcpqfbTHSd6+vTjlzSf5WVVbOFpJTG6avMjQjs+8A5UPzT
	WEEHLYZpmqvBhUA0TVSYydK6arvh46vB+I1dkFp3ZO3dPwRNbwCzniuZlYtEQCx5wzGBtMSNj9S
	lpgwuYxHd5unxwmgf1wxFk4u5rzDOrN5ZS1e1cM4yJZslSpegBvOA8ASXGpk3zkXWlP0wBhJWkJ
	zzhvTUlIRsIjUwD9zUGiyv9vqYsevsDT9FEPsYSt50kBzNBFM9IUAbAMt3/CYVxSYKfvEAhGSF7
	5E9NevoWGmwVzhWtt7d531Zbqje
X-Received: by 2002:a17:903:1aa6:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d3b0875746mr195743775ad.8.1786863181639;
        Sat, 15 Aug 2026 23:53:01 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae753ae0sm23752365ad.8.2026.08.15.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:53:01 -0700 (PDT)
Message-ID: <1c60a15ad8013b49e0fea8eb3308b2a83ef5a2d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] bpf: Correct kfunc argument
 diagnostics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:52:57 -0700
In-Reply-To: <20260816015746.2632990-7-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-7-memxor@gmail.com>
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
> The Call Type Safety diagnostics mishandle three kfunc argument classes.
>=20
> BTF type ID 0 represents void, but btf_show_name() also uses zero to end
> type traversal. A pointer that resolves to void therefore loses its point=
ee
> name and is rendered as "()". End traversal directly for concrete termina=
l
> types, but resolve referenced types before testing for ID zero, and name =
the
> void terminal type explicitly. Format the complete parameter pointer type
> for nullable kfunc arguments, so void pointers are reported as (void *).
>=20
> Also add the missing structured report when an __szk memory-size argument=
 is
> not a verifier-known constant. Describe the generic bpf_refcount_acquire(=
)
> contract without deriving an object type from its void pointer prototype.
>=20
> Link: https://lore.kernel.org/bpf/668871823f90f69896d3db27b56db2f53e48116=
2.camel@gmail.com/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
