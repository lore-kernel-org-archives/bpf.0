Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039072;
	b=KVVXF/Yz+oLRILsnTd9oUdUZ932JCrVxX3DMhFkBtVHhbhWntsKCKI7PlD5x8wA28NEh
	 3CE15zCDh/xwtUqfWO1XNH5dtzVo4UdUyAQBlCvh9wb3XVWTb7W21RdddPn1N+mwNuPcp
	 96jxEyOYDCJDVRp9LRdrIgImmfApwH/6KZxF+MhsA8QPfDQrrQFOBYwBzB2E5TFBk+s8N
	 Y6w1q6xxQO2fm+mOf3DPhzKbpOUaSv6iLX6V1BegSTCPDqIYVll89dnze70Qipn8uSWIr
	 mZoHZ0/EO8Qy0xAcFRgHjKzKN+X/l2CCaJHItf5tGzETbxuBByd2dCyZUQx1DqWrAkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/vgfXNH0IHzSBw/JekYvCw/wkmdl1JVA/UJoPFTrVO8=;
	b=A9cSPnQJRAEjhGPc1ZrW050xczL9YcgdMZ7iQ1B4m/ITw67Ou7TWPwabntn5UtyOFwub
	 OC8F81b75Se7sb6tin4xf0ln538Vg3lK8GfEbG1s8Y/pBtLQe4m9uuUpIibdGnHZpmNkV
	 GhmWmucPgS3l1lJ5QvyTHH6vYLIMhk5gew8pR7XxnhpBIEYw3JoGWIvHdEOhOhz63tJWl
	 0mOdgPt64/o8g2/ER4oeRu4ZVeHyPBQ18IfoXyw3NTgmBpWiWQh+WnEWSn2KLpqBk1fYC
	 kY1/Nozmrc2rvY0XM4q59k90e3mPyYn6vqs60727fqP+7eDZycbnfsymitp9r++YWNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZOJ+oa1;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A6606A337
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0A6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZOJ+oa1
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9d7791b00so16541125ad.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039072; x=1795643872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/vgfXNH0IHzSBw/JekYvCw/wkmdl1JVA/UJoPFTrVO8=;
        b=yZOJ+oa1JTdSojU1/MHwyq/2ew76qFcIwev8pdqognMenRmBgAIBzLMSWJoBx18+jU
         j2/5/irJ3tAWpghrnu2Opwlru0K7lKdfKWe7Ar+2OzsRSIKACHuBjw+SN5UlgCEb2O47
         KMjjwXoUGNayV8e13A/vbKTmLTe0CIW6P6Dn9v6IMoHXCoUwRehiaUanaEoUXvtEsm7B
         tBIdq+a/no0w1sYL28HtNarBWSjvIt93/tni42fgduGWk5bE8jKa1+36zYA777QAGQba
         4rxFZSexAWTHrwTXdL+ZAo/kPn1qFOsQWvbMGkIxSPW+UxjBH82wwnpnqEnLPqJWQFKj
         yC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039072; x=1795643872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vgfXNH0IHzSBw/JekYvCw/wkmdl1JVA/UJoPFTrVO8=;
        b=VB70WdRFUXbUweEtXG5b3SmbK6YensyE1PnqnPBeaKX36KFnfbD0/NILzJakdA0gIu
         SM66azeCY4v/aioh875Gn0e40iCbaPk9vPVRstDZb4LvXPb8CZSTi5xdG84FN/qcC604
         7u/1eRa6dWTS6TxahdH8lDRn5AOoUYF9HlsdC/WS8+Fprq9gJN8Sh19QXeAPptheNP0H
         vZduNutYs/2exPAaMULrc8XBBKiczTcklzccCB2Y07dgzRkaCLt9hxwO7ToZhEK5bgec
         wsyd1OVhw8taDblzsDpfey5j9G/su7dbmCILkYwlCGLvbiEEAwElQKA6Pvxadd82pEgG
         vJ6A==
X-Forwarded-Encrypted: i=1; AL+hErEg8Ed5df72RU7UiHMZTQFkgZSDwzn22lGsR/NkiC+G/v/ZDchvcqIae+BT9hsYPKj2vH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Yg+ksQe6skqT3A/vX7U4sBg4uT6IrE2ifGU2T68HVPuEUmXT5
	FSyPziRbBHsN+I+8If72X2AqxWNcpMKZYH9YK2tUodeJI/TYvVrn9N4j
X-Gm-Gg: AZFdTZcJomgpjYM+K50mr7I+86EEKvtzdzr9R7JuvilApc5q60Z8X/WRPdZtOZ+0JQm
	4OCs4UrZR/UQrGf3t2WBQiCCq7NgtaHEAafItlZqCAMEm2qhLaLYrLMBDta0lJYI3mFyMu3eVNF
	5SObSrCoOAFoVrs6IA5WcTAHj3LJg6MKzzHUlyCApZ1wlBkacwh7c6jKMDPneu48/3oWlPQ17Kn
	WitpM8Ju3QonigEuiBprASSqDthen07RtzC5w4gYuQ+Lo9gsw2ffxQFQAV4gZBTX47aoWHQVvbc
	iX0kCStbJ+IJ83gvNJNufqgwzQLyARJCTom8MesmKnLGgAacMj2DbuiedvJT8Amos/Qba4oC7U7
	rC39OxmGSONXxxrJUBaTlw82tfRFZ/MOfwANwj+aabc+X5ndhG/Nkht11axjZw2lu0K0fOse9B1
	JlczwRr5nJxK9yOlcpbGYMwoyZz8XXZ/DMK4O1QJyAMY7NGVplB6HFPR6RLfeUgPTe4LWV4qAaL
	u9Ue3mDIklf8k2mOET+MGqvXdg1URhq2edDYU6PymeNx1KtcJIujZsOEam6lOlpdNxkRhSd/c3b
	PlOTH0GMPa9+E5/3FqbxGd+PmZblpySdMOL8ZrOKf6cYXSalruI9L2In
X-Received: by 2002:a17:902:c945:b0:2ed:56ee:af84 with SMTP id d9443c01a7336-2eff75693c0mr37754565ad.62.1795039071872;
        Wed, 18 Nov 2026 13:57:51 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff622c0a5sm20012695ad.50.2026.11.18.13.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:57:51 -0800 (PST)
Message-ID: <cfb47f547888b0f70200c0cd5eecff2f20592f29.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 14:57:49 -0700
In-Reply-To: <dfba2231-4cf4-4bb2-90b9-6261b7567895@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
	 <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
	 <dfba2231-4cf4-4bb2-90b9-6261b7567895@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 14:48 -0700, Ihor Solodrai wrote:
> On 2026-11-18 2:42 p.m., Eduard Zingerman wrote:
> > On Wed, 2026-11-18 at 14:12 -0700, Eduard Zingerman wrote:
> > > On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> >=20
> > ...
> >=20
> > > > resolve_btfids fails the build if two of bpf_foo and its flavors ha=
ve
> > > > compatible prototypes, unless both have foo's exact prototype
> > > > (aliases), so the fallback finds at most one match.=C2=A0 This ensu=
res at
> > >=20
> > > Why is an exception for kfuncs with identical prototypes necessary?
> >=20
> > Ok, my helpful assistant points out the following use case:
> >=20
> > On kernel side:
> >=20
> > =C2=A0=C2=A0 __bpf_kfunc bool foo(struct task_struct *p, u64 flags);
> > =C2=A0=C2=A0 __bpf_kfunc bool foo___v2(struct task_struct *p, u64 flags=
);
> >=20
> >=20
> > On BPF side:
> >=20
> >=20
> > =C2=A0=C2=A0 extern bool foo(struct task_struct *p, u64 flags) __ksym;
> > =C2=A0=C2=A0 extern bool foo___v2___compat(struct task_struct *p, u64 f=
lags) __ksym;
> >=20
> > =C2=A0=C2=A0 /* Resolves to the kernel's foo(). */
> > =C2=A0=C2=A0 foo(p, 0);
> >=20
> > =C2=A0=C2=A0 /* libbpf strips ___compat; resolves to the kernel's foo__=
_v2().
> > =C2=A0=C2=A0=C2=A0 * workaround used before this series.
> > =C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0 foo___v2___compat(p, 0);
> >=20
> > New mechanics adds an obligation on the kernel side to maintain that
> > foo and foo___v2___compat are semantically identical, despite being
> > physically different functions. (Does it?)
>=20
> Yes. I just replied with exactly same example (it's used in sched-ext).
>=20
> >=20
> > Would it be possible to use some kind of annotation, e.g.:
> > - __alias(foo___v2) (an ELF symbol alias), or
> > - __kfunc_alias(foo___v2)
> > =C2=A0=C2=A0 (resolving to some sort of btf_decl_tag for resolve_btfids=
 to act upon).
> > And avoid allowing functions with compatible prototypes w/o exceptions.
> >=20
> > ?
>=20
> My intuition is that it's possible, but it'd be more complicated.
> The question is why?

Is it a requirement now for foo() and foo___v2___compat()
to be semantically identical? If it is, the alias mechanics forgoes
this requirement.

> libbpf side might become marginally simpler, but we'd add complexity
> on the kernel side, no?

On kernel side or on resolve_btfids side?
