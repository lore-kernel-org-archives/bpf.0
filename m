Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02A3EBF3D
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056552; cv=none; b=lg1sHko/bKzOwfdiDSybQJ+nX/IDtf64D4wg96XtijvWHC6kSZDKDMfK4nuuYp4+O7Bi7aQ2S3mOAR3Uq94ss/TvlhUJHS+RTOnhUtZLlFnWu/RGrWLzlouyg4b7lXAOQ8vdwrfkBLkgAqa0mIZSGPZ4vwJCq7dpyrgzKumQFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056552; c=relaxed/simple;
	bh=Qb6gmOqSeBxAX8G7dW1EUodI6Awjh9T3qVOFWeggGU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlZqytV/9s8dvqxCz51yEkMUq7X0+bohSrrM86l0ITrg/50u6zKfd53A2cgQFtiHyK2n7bs2nsD93TOfF+LOL1WNxDHmWn3lst+9WCL0Uwc22GzGAps4I4oqnOjbxMY3pOiXlTT/EY48rv7kR9T70ywHNhJ5QpPvdd9roF9sR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teis77pJ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teis77pJ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-124899ee9d3so23724c88.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770056550; x=1770661350; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qb6gmOqSeBxAX8G7dW1EUodI6Awjh9T3qVOFWeggGU0=;
        b=Teis77pJWz6vMxbJ2KJApabNArike/5Zf6KVGS2XEtcBwb8nbKIoOMiy21UKM3BM9A
         qb2hQ00gR7Q2sAfNqFUfz6saWtximT2eIx4MHPBF7qKZ9oW9x71xwrn+l3B/kIK1/g+d
         LQtcA0+47286nouL5kiG0cvsIo27E+d74tIwA97pYjcHhVv+QY9l9lXPvxnihAL5syfV
         Id1fF2GoJ254H6Ho0lWT+TjIR7EUOHhzqLBEg1TwMZRwCz+BCc0GeHIDWs/NpOGVo3GS
         Mw9z+NY+ugGyoItUIe1W8bBUlIXNlZMtpsBRQrhKB03qNJcexsqkxCHdbEMb3X2vc0Uf
         4NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056550; x=1770661350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb6gmOqSeBxAX8G7dW1EUodI6Awjh9T3qVOFWeggGU0=;
        b=Fa1nbWG8JF1XkwEc7kDIjVgyInHFVcS0v1meMzIZM1c78j6IC6O1LOnA+Mq7mISuq8
         uqZdVTBum9Srv5gxXVdOW1WrD77ppeK4KaJ2EkxjybeQ5x1sMrOKApc8VFdiN3YcswYK
         4Xnbk49ufZM1mjuMfT8zlWr5xkWFEulqcIPgnBd5iEun+xk76heiO28Vhuetq9NUV2Mq
         F8yCyLi86ymfEME1ChND6GBms3dMHeLhsm8zphuKJnVFSkLyVqaw1VJHUiQklnWviuer
         VDboNmZgwyrH1UVajSBhu2LRo+uSpvE6h2F30HDWne5/LqHLZVjKIowBlR0XrAteuZxw
         GR3A==
X-Forwarded-Encrypted: i=1; AJvYcCXVrgb396WcsfKHxs1OoIgaJg1uEPDptM+5OufsHbZAF3ve/hITcGiHVQ7iMe6WCfjNw1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIk3t7qeisFf5XMOobhXRwdheLEgrJhx8JbCQGSaubcBWpFken
	5ylWGHg73kk/hJJU8iZ93P9iV900oTdPjLACz0jAN9z9tGdBGlixcO3t
X-Gm-Gg: AZuq6aI1f4n2FleCsaYUqq4M08Es8IS690mJGAhadBvFO6aqs/Uc8+ZHvwtgXnaeG0j
	pjmlYpHJbvEWKgFlccTF+rY6LchFvYOVG+2e+DE/rKn6wwVoBeiAw6B5gwxccqvJkxgkCDAM2fJ
	KBmV8WmREEapUfL3ybe2Ed/UWMUbNdTldrnVyil43PHqnAyRUfmpV8LTl04zNT97gAYiFsrLlHT
	yZ8Y52vADjrZR8YwC/JET9s59VswS/oVPjWQ6AgIWYvgtCrUZMWaPUkNwb6Zu3mB+xyjvDv2EV9
	T8dNSPbdG/InUugG85DPA+hOxKTLFxV6KT5k7+GMWZ7saMOpi6PCmjLT0Hq5lc0NYFFB0s8FpSP
	Y+5PQ71dbzReUrz1hLB+cc1ThtAX7pEtcvxAaCl2onTK5gF05rv5VF0TywUT8K9HiUTeZLPrpsc
	ps/gq1UEdvrahhAiKh2k4P5Z+EOn5cztn7f+uqK1Tj1bhi/9LrEhQid1+QtZBqBqbqmQ==
X-Received: by 2002:a05:7022:911:b0:123:36f3:2d2f with SMTP id a92af1059eb24-126ea973cffmr135897c88.26.1770056549843;
        Mon, 02 Feb 2026 10:22:29 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:eca2:6a75:cc8b:c3? ([2620:10d:c090:500::3:5713])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efd3b8sm17706336c88.17.2026.02.02.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:22:29 -0800 (PST)
Message-ID: <6a2e10c263c440d25485e70bac8af26b6e07808a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: verifier: Relax scalar id equivalence
 for state pruning
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>
Date: Mon, 02 Feb 2026 10:22:27 -0800
In-Reply-To: <20260202104414.3103323-5-puranjay@kernel.org>
References: <20260202104414.3103323-1-puranjay@kernel.org>
	 <20260202104414.3103323-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 02:44 -0800, Puranjay Mohan wrote:
> Scalar register IDs are used by the verifier to track relationships
> between registers and enable bounds propagation across those
> relationships. Once an ID becomes singular (i.e. only a single
> register/stack slot carries it), it can no longer contribute to bounds
> propagation and effectively becomes stale. The previous commit makes the
> verifier clear such ids before caching the state.
>=20
> When comparing the current and cached states for pruning, these stale
> IDs can cause technically equivalent states to be considered different
> and thus prevent pruning.
>=20
> Relax scalar ID equivalence by treating rold->id =3D=3D 0 as "independent=
":
> if the old state did not rely on any ID relationships for a register,
> then any ID/linking present in the current state only adds constraints
> and is always safe to accept for pruning. Implement this by returning
> true immediately in check_scalar_ids() when old_id =3D=3D 0.
>=20
> Maintain correctness for the opposite direction (old_id !=3D 0 && cur_id
> =3D=3D 0) by still allocating a temporary ID for cur_id =3D=3D 0. This av=
oids
> incorrectly allowing multiple independent current registers (id=3D=3D0) t=
o
> satisfy a single linked old ID during mapping.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Could you please describe the exact ADD_CONST scenario,
when old scheme treated singular ids non-optimally?
Otherwise it is not clear why old scheme with temporary
id allocation for rold->id =3D=3D 0 case is not sufficient.
Also it would be nice to have this scenario in the selftests.

[...]
