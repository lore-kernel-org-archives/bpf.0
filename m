Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B519ABC6
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778032; cv=none; b=YORuDdCZAEyrZpxVycfqG3rD40V2dTHS65uU5CY7TvAl7hkfTJg7WoG9t3wQPYGzwIldGB7UZAVyeyDEy7jDcir9YM1CtphMs48kDNFn1CbA5QLom5PNPYeSJPMfEcj6sMn5BPuAr9ZjiRbSyBaQZwsKmi0Cok9dp8HDYchb5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778032; c=relaxed/simple;
	bh=e714K+mzo2XhjxtDgqNCwQPN3x0crIIMszq1+viOfto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnX93j5aGbph6dFRdr9+OhA/txQ48y2BztzjSV782LP7+F0TkoegQaoeQpmf/0EfiJCq+K+mbk67s7/CGRmWvwiYicC/uK50fHLDwF8/A/iBsoZ+JphcLjumycF34aHg8PipIH/GGtjlyFncvoWJNzQh2nxKLwK4g0VdD4mBlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9EZR1CA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9EZR1CA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b944f6edso32301635ad.2
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2026 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780778031; x=1781382831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e714K+mzo2XhjxtDgqNCwQPN3x0crIIMszq1+viOfto=;
        b=V9EZR1CAIcggaqv2B6aMhitDDNdui/7I7gcWjKr/RmfgLEgE8y9WQopgL0mti6G8ie
         CnCfYRphFcUQaiFdDYUjMGoeSeZYanmZY5TM8M2HfsDdJDY6dyiGrZtKwm+npZZUxVPt
         ifdEv0ejGYUtFq2fins0JpX073d1811womvTOl5xXaZiDUAsfqE848zHyYCKLnEeNm+d
         QPzUcEq82JTcXuTY3T3jEv/ozhwDpFccOvmPS/U7sWWjYI4huL5lCh/NsIMYvf2OSVrf
         51bHiKA0fK0EH1he8C7YFYoEKWTq2DXtrcDNT2/cdUU45PyLPQzPMXiQhtnL6GdXwdom
         uSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780778031; x=1781382831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e714K+mzo2XhjxtDgqNCwQPN3x0crIIMszq1+viOfto=;
        b=DcZqAOSg28kPQtntpILIed1aWVx5ByqSbiWrnpR8YHZJzYbKtc5jNFf/tJiWhdYlNB
         SlR8Vnte4rnhDMM+jxOwQhL5Xe9i43Y9o5f5kyu97U5ePD+p4UeXjehuQuALjUwMT4W4
         tnjJt28PYLiWcaehDco8wiQvCxD73rfer8dJzC7Wry57NxpiifOGCEn0PbgteR0gx1G2
         MO10Fb1wuqR6YeUoVRCA46DeYXjH7sf9Xhpam9QlRv5xXPZ8cypkMY6jH6fUOSsQ94eQ
         LqMTzSja0BnGOrxeM1c7SohL/V8lpgsb+lzH9GOLO+oIIwMVSCaVO64awTPzXSavNRkv
         Vtgw==
X-Forwarded-Encrypted: i=1; AFNElJ9WzZzCYO0dG22IzR+1OD9APd67Yzi8WTJlo12E1UKKdGrfraXrTqj+6OnVScTuVbfPXzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdDTOmmf8bYDGO+3M1zNwKhyng3doy3EudIq6HYZd6/cIzEjo
	imjiM0zEY87q5Akn4Abuk87VKlB09QnpFRKlxvzt+TM10jNM6H1Pkgqg
X-Gm-Gg: Acq92OGLL+2BT+WAJLTttN6WhanNDZpHCUSHfS9ZOgpslWjGGxJRUXE7MhE65c3TmgY
	vEuaXNJN8mKa6hTj8PJjpMr2cwjNzKPORTNXHJrElNWb/ovthQSgXboOPCAoPrDaag/dkXWO53C
	NSKmTw4alRbBBFmm6P+bhi7rZF7zkcGgvZBXyiviW06+ian/5hAMg6AkqAMClT51guv5cBpWnB0
	eRiVKRQrZ75ytCnXoXoyN2iN+EzjXO/wW94YdWNeMaeJOcbUnLOaL7bTff+duXMngNeOtbyAYM5
	k4JzrEg8iSK0qKmQ9e8wnbvMF2FUUpI5MpAInuoK9qKXrNHr4fo2NK8E07sDnSwJitKGR3qzM2D
	qJtX2xLeEuFMcVRTkgZDNOYG34sp/IAgg/TJsdwQ180VL2iku6OdXEptDRQ+Km44t3SCMcKg6sT
	yEdyBdUcMrHuU9B9ThQn8UjSwtXyYHT5UngXU6LpEafQvJejXwdpSnEKzqDj2ZJA==
X-Received: by 2002:a17:902:da88:b0:2c0:db23:4c1 with SMTP id d9443c01a7336-2c1e7b359e8mr116953145ad.5.1780778030642;
        Sat, 06 Jun 2026 13:33:50 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f94a7fsm131987615ad.28.2026.06.06.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 13:33:50 -0700 (PDT)
Message-ID: <562b1652176c8f40dd24027d0e0d44ddae800353.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, verifier: fold reg->var_off into
 PTR_TO_FLOW_KEYS bounds check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
	 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
	 <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Sat, 06 Jun 2026 13:33:46 -0700
In-Reply-To: <20260606-c3-01-v3-v3-1-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
	 <20260606-c3-01-v3-v3-1-97c51f592f15@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-06 at 18:50 +0800, Nuoqi Gui wrote:
> Constant pointer arithmetic on a PTR_TO_FLOW_KEYS register lands the
> constant in reg->var_off (e.g. flow_keys(imm=3D4096)), but the
> PTR_TO_FLOW_KEYS path in check_mem_access() passes only insn->off to
> check_flow_keys_access() and never folds reg->var_off.value.=C2=A0 The
> verifier therefore accepts an access that, at runtime, dereferences past
> struct bpf_flow_keys -- a verifier/runtime divergence that yields an
> out-of-bounds read and write of kernel stack memory.
>=20
> Commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off for
> pointers") removed the generic "off +=3D reg->off" that check_mem_access(=
)
> applied before the per-type dispatch and replaced it with per-path
> folding of reg->var_off.value (for example the ctx path now folds the
> register offset via check_ctx_access()).=C2=A0 The PTR_TO_FLOW_KEYS path =
was
> not given the equivalent fold, so a constant offset that used to be
> folded and rejected is now silently accepted:
>=20
> =C2=A0 before 022ac0750883: the offset stays in reg->off and is folded
> =C2=A0=C2=A0=C2=A0 generically, so the access is checked with off=3D4096 =
and rejected.
> =C2=A0 after=C2=A0 022ac0750883: the offset lands in reg->var_off, the fl=
ow_keys
> =C2=A0=C2=A0=C2=A0 path checks off=3D0 and accepts; at runtime the access=
 dereferences
> =C2=A0=C2=A0=C2=A0 base + 0x1000.
>=20
> For a BPF_PROG_TYPE_FLOW_DISSECTOR program the following is accepted:
>=20
> =C2=A0 r2 =3D *(u64 *)(r1 + 144)=C2=A0=C2=A0 ; R2=3Dflow_keys (PTR_TO_FLO=
W_KEYS)
> =C2=A0 r2 +=3D 0x1000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R2=3Dflow_keys(imm=3D4096), accepted
> =C2=A0 r0 =3D *(u64 *)(r2 + 0)=C2=A0=C2=A0=C2=A0=C2=A0 ; accepted, var_of=
f.value=3D0x1000 ignored
>=20
> while the equivalent insn->off form
>=20
> =C2=A0 r0 =3D *(u64 *)(r2 + 0x1000)
>=20
> has the same effective offset but is correctly rejected with
> "invalid access to flow keys off=3D4096 size=3D8", which isolates the def=
ect
> to the missing var_off fold.=C2=A0 Once attached as a flow dissector, the
> accepted program reads kernel stack past struct bpf_flow_keys (a
> kernel-stack / KASLR information leak) and can likewise write past it,
> corrupting kernel memory.
>=20
> Fix it by folding reg->var_off.value into the offset before the bounds
> check and rejecting non-constant offsets, mirroring the other pointer
> types (e.g. check_ctx_access()).
>=20
> No released kernel is affected; the regression is confined to the 7.1
> development cycle (reproduced on v7.1-rc1..rc5), and v7.0.x rejects the
> program above.
>=20
> Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for point=
ers")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
