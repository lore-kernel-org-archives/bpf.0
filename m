Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF935E92B
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412007; cv=none; b=tNq6882mMfcNo7YIwS7czDM2xM4qBq3s77VIK8p8pIwixgxDcUsmlMMfXnA7D5Jlh1Q+p+mzJGQIn6h8sV7uNs6sqAygyABHRQCnluNVFiQJidjggOo0q3Uc9X84HqP44/S3iNfvhnVPApvxU0F6PBjOVBvR4JeNaFdlwWTBueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412007; c=relaxed/simple;
	bh=2b/76hpgaSQP0hQ7+44gyLU8NATJXUjkuyIUA2DxYck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKj52THcBmM/eSJlA/0Gig2eOx6jc2fmqRUC1aG7eGk7GTEwq9kL5dVAqJCsF37AeZl29jo2fg5Z2bkLaRBIr0aDY5L+WQ/9XgoxbE7s/4CcsTdNnjGhoScajl3ZpwzKCqK2RqOW5TjTxPucp3rvoGArBotxXmHPBBDvaMK2gvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuiRWAqn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuiRWAqn"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so21321465ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789412005; x=1790016805; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2b/76hpgaSQP0hQ7+44gyLU8NATJXUjkuyIUA2DxYck=;
        b=fuiRWAqns/wSie2131XsH/F0ggm0KZ0iMHc2QmRNjhWPTw99aj8tONixIM31b6xv7u
         kxswAFNLDH4tr75ThAJg12ZO5hAwmVPRU0Xc1tXC/7Dhwm6d//7UZlu/6KspjKt8oDXU
         qqt6Coce//sjSONArkaNCnu8QzjdhaIvMBCxUqB41UNDS3+m9yobBltsv+BJ86LLEMed
         w4UvAtBh1MFBvu8KBZM7OiXIM/70AEqshPeiWicGXRjX8YiGqlIM7SYVSjgivVqStvrK
         hPJ+V7+tm7e1dbqO4gtwnxY/wkYUisTUjRHOKppQAWBZ9CwNdb88xhFXutluDTgKZl5/
         NkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412005; x=1790016805;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2b/76hpgaSQP0hQ7+44gyLU8NATJXUjkuyIUA2DxYck=;
        b=XHTJN5rDux0OUqhUulZDsJPY+83ls3T0lh2unK8YrhG6BnkLFYbVxRqYYWogar0xqo
         3Q4HaAcMsiAYw3bHIaxF3Dl0v6ihUjm0tlzcEMjHBNdNIzc8WPj33lMVgXNCTEpdV2E6
         9+1hB55C1YKxeU1GryJsPjFMPhUgsq55iNVPo6WOXmUd6XHFFbk3oYXcFW1qpOb287CI
         a9vL8QVp3towF9HZdOSBarYbWwnp7CSXe1Uf7+fBUwypCgaE6KmAl43V+llpATaj87KS
         m8quPU1v9nt9sA+PYYHkOAdeDr1maCGbnrkl05054i6ySbqapmoEh1X6OGaUnGtKZtsG
         IdOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjC7/xNIo18dCR9m48RQhmXR4Oie5qNmWpk8kFccPA8X/tyS8bcc/LtFXY+gn2gEbIhFs=@vger.kernel.org
X-Gm-Message-State: AFuF++nUqwaSEFbfYEy7n8ntxXDOzrn8uRYD6muzBe5CpXysPaEI6r0L
	+WR8Fu51EMViuoyq7QUO3UkTX23kTKzjXqXl267BTUWevoojJLZ+2WJL
X-Gm-Gg: AYBFou1nbrg0Keqa3FBCXd+I/AC3YaOJqaCrfyv0pGEMP2EjPn9sFk4Z58wZl1HB0xj
	jIlFOj/GM6+3yuM/E1I9rzNNK3eemksGvwlCbKNOr/t7gn/pWmdl/KbO4Ck7pXg5g0/k0d+Xj2Q
	FBDzLmDtMMeUvbVzyq71RSbG0ZNioOejGmXWyb3PP2WDBTkcd7jv+OuH0Um7uFenmZpUMLtalkq
	Og4/722cBZrVVA29ymBgXzTlZmPuX37A5LOB9e0oCsfOQ8PcFpiC+Er5ZyF9jXUns82BWz0krFS
	HEYimUz8T5R5aP0h+niuyYZ5zj84zMBWiiGK6BiY2d7y5N+Xl6IXMk5fxzRNJcjyIJlBYemUVhI
	IuraQ0+EnK/CuOole9NlrkFc00o+CnvrjmZ36KzcvgA8cK0LfAdEJ4q5jSpPJRN0XO1hBehaQ4+
	6XOFKzKuRlHwfmIvL0kZUbViB/UQoxfpToZHKcpLhpjqOPmgZ9qL/3yKXONxXt7JEEl+CvIbcZp
	otkOfWx+guv9BauTD9CH1Gkots=
X-Received: by 2002:a17:90b:164d:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39dec0a8e92mr6752885a91.20.1789412004886;
        Mon, 14 Sep 2026 11:53:24 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda7d765sm790763a91.10.2026.09.14.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:53:24 -0700 (PDT)
Message-ID: <88c41074d181feb8d1c9e22eee4a0f25de1dac15.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/7] bpf: Preserve packet pointer class
 displacement in regsafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Mon, 14 Sep 2026 11:53:21 -0700
In-Reply-To: <20260914131701.2529725-3-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
	 <20260914131701.2529725-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 15:16 +0200, Kumar Kartikeya Dwivedi wrote:
> regsafe() maps packet pointer IDs between states and checks that each
> current register range is a subset of the corresponding explored
> register range. It does not, however, preserve the displacement between
> registers that share a packet pointer ID.
>=20
> This is unsound because packet range is shared by ID. A bounds check on
> one class member updates every member, and a later access can consume the
> range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
> instead of reg->off for pointers") folded the fixed pointer offset into
> r64 and removed the old off equality check, so two individually narrower
> registers can prune even when their displacement has changed. The
> explored path can then license an out-of-bounds packet access on the
> pruned path.
>=20
> Require matching range bases for packet pointers with an ID. Together
> with the existing ID mapping, this preserves the displacement between
> members of each packet-pointer class without adding per-ID state.
> Packet pointers without an ID remain unaffected.
>=20
> Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for point=
ers")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
