Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33227B4FA
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237885; cv=none; b=rAq+BSyDzt/tn//yZ/pf6BYTKMUqNeREWUOwlf0QqgCDGcmIVRBpvnGwVC4crL3uHMbLTc5DJjYUdRIL8Z+/5uD1V1kwDers4Mw7jc55wvXWdBDST1yFJvewBa7po9opYfVVCRcCaQZfwh7OjrMlncXK/67B1xdLC8Pn8CgaRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237885; c=relaxed/simple;
	bh=gX8m1XPZQAf0jGUqj6AQt/r1JxuH6RPKOIZCXMUQkts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQSw/Df/72LKW8kpUaMKjefbCfF9eLidZcUdlNOSB2kyO9aIwk3ZfpEsHA9+zpPIU2kswkGDgloXh0VZ2VSQ7sybGZaKaVqEIpm/fSG7WuKAOw+mtmFAxxLw/M8VBrwq0bexpB8R1Nhayt1yNy8Ej9UjwEDCskgk1gt4vfMwwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cla5WtQB; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cla5WtQB"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b729f4c154so295179eec.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 12:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770237884; x=1770842684; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lHpABv2VfJMtiEfvt0mWzgxZtrEbRoXdJycTfGEO3c4=;
        b=cla5WtQBzwZOvupl0ifvh6z1nWGbATZVumG0mEp2Kk0KuSzKXIyHiNCbN+3KIAmS/f
         4aA95SH1hPYtLpo0u9uWFVO9Bo4ELw5xzg7ScdMg5H0oT82HwPOO24zIuYT41fQUNRN6
         LrhML0TVIeTc45BhDsTTsU7r0GeEkJOoWZk2kvsjQ7beVjQ22nFgg2k3k6SW2FUYXexM
         UP9QWE9NGwMcKkRqmPuQtkaWPCtQPrUb7cEd+yCHOea/f/bg+aQXLqyQI8bDAVITKfBk
         LIMDaxKIuAGvHOr/eF8qnVoNhHP7DtjUr4BIzo2LmAXlQPRcVpyyrSJNrwJQqC4benWS
         UiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770237884; x=1770842684;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHpABv2VfJMtiEfvt0mWzgxZtrEbRoXdJycTfGEO3c4=;
        b=b4mUCEvJ2YV9+gZnESgty4loMaUw8SLvQ4ull3rzwaiRA51bCvX0JGUB7cDVuYUUyF
         3R1ltGZ8laVBM513EgbhO+5513a6KfpZXhY2kCA7QhCMQJM+AwsvmL9z8mNWo/VJ9la8
         dqoQa6MULYMi6QvXghqa5N5bW8Qff7bK28riAm6J1410UqKN/UzFGDMWS6GCYA/1qwu8
         5cN27kfVur+Ccpw0I8wW0hZlXgstVZSAK9oPdtx1bxqmb+LctjzUukfyCBBjSDJf9Mwh
         KgWcZhzL7Z455aw2Ekt3L4EnRVcjxpEyUzdZD8n8JsL1xtlr6KtWvObxqz6gVkFqakD6
         lomw==
X-Forwarded-Encrypted: i=1; AJvYcCWFumU47DsRq/vEpYVNI4LX5/m+/3bvSy/4Y3VVp3YjqpCBnDc9Qu7D0hCtL9Cg9VtQSbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShD2NYGLki2IeKuPjxjfVD9VFhhsgzHzbqUyHzL4PvGZcmhwN
	Rxa7bbspmjAWp/5lsW9Bvr7lgPHSlu+R6NXlEnfkgeradHvS+BVzg/Do
X-Gm-Gg: AZuq6aJqdCS2Yn3OZ4VjPoiB9FTCJcWvOTmncpyyPL7gstyHGut3A29DKxTQhCTYwUv
	eu6bCtGmtlkRvDrCbs8J7/pNmLwm4wOHKX/EZy7GApwqBfdmkGA37kxyqEbPU/KvM5zZzH6WPGW
	K9E4q0hpssnwGAyrwX+ftruajmwmKyoH0zg//Dq/zJ3gvNKWwyTLv4ZG5pT3LL8I1IbW2OwFoN8
	utwk9CrLQdNfA0qt0CMtFhphoGJNSks57vleEjRJk3l44xE0+y3Gry3vabIJnHBuF9PTutItIBU
	Noyj2HdvVXtt4hIZgVqrRjZodqhANA6N9rorQ63MmsWKBSVUXcV+/Ek4hKEQy2iM+Sga02NTmWq
	ns8A5goApOqc1iZl5q0ZN4wk9oBUxZ7tEBsiFPz+fgkxIjWTCXOmnZBz2EYwT4K2TiknfG+H/o2
	ZAZw3xugpQDDKuztsli63fF8dz66+rJpPfxdU0SbGzMTGxQ2Z8mbfVDrgIHgu5d1uIYAo3
X-Received: by 2002:a05:7300:e613:b0:2ae:5a13:97d8 with SMTP id 5a478bee46e88-2b8329901e3mr1767150eec.14.1770237884242;
        Wed, 04 Feb 2026 12:44:44 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac05:8e30:1e93:7ef5? ([2620:10d:c090:500::2:5ebc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832f8ea26sm2335301eec.21.2026.02.04.12.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:44:43 -0800 (PST)
Message-ID: <9252b79ef036a3147803e4878eb3c7144c4327c5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support negative offsets, BPF_SUB,
 and alu32 for linked register tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 04 Feb 2026 12:44:42 -0800
In-Reply-To: <20260204151741.2678118-2-puranjay@kernel.org>
References: <20260204151741.2678118-1-puranjay@kernel.org>
	 <20260204151741.2678118-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 07:17 -0800, Puranjay Mohan wrote:
> Previously, the verifier only tracked positive constant deltas between
> linked registers using BPF_ADD. This limitation meant patterns like:
>=20
>   r1 =3D r0;
>   r1 +=3D -4;
>   if r1 s>=3D 0 goto l0_%=3D;   // r1 >=3D 0 implies r0 >=3D 4
>   // verifier couldn't propagate bounds back to r0
>   if r0 !=3D 0 goto l0_%=3D;
> 	r0 /=3D 0; // Verifier thinks this is reachable
>   l0_%=3D:
>=20
> Similar limitation exists for 32-bit registers.
>=20
> With this change, the verifier can now track negative deltas in reg->off
> enabling bound propagation for the above pattern.
>=20
> For alu32, we make sure the destination register has the upper 32 bits
> as 0s before creating the link. BPF_ADD_CONST is split into
> BPF_ADD_CONST64 and BPF_ADD_CONST32, the latter is used in case of alu32
> and sync_linked_regs uses this to zext the result if known_reg has this
> flag.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
