Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759567;
	b=Jv1/GMMJKldx2OxZIbCf5Fj1YZ//p8GLOVcLbHyff6O4b2VDyVvCPWbFo/XMFTrqWE4r
	 NNTPptVXAAEwo3eQlmmSrzivhkmEHuABRC/zVaeDzAsCgJjf8EUsM8wij45aEz1edNabO
	 zpahq8vpG727Jc1LU5kf0rIRVBTdns7zo1vLDKUEOf0IvXT4Td43zXmdNqTMhpsndBYxQ
	 KCMHOhOU5CQ0SzowpBDEPeXdDgVjfQrEHxNoIIrHBsWH4RD+JL2FHaEfgW+7vet7S+3Fg
	 p+V13MuR9ePc21yRM9O15Wsm7sVRhB2PIJqirPRymk+kcEgQrYDLLmewPEMyaJpNeIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759567;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Content-Transfer-Encoding:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:Message-Id:References:
	 To:X-Mailer;
	bh=JdxpFZYkqe2r6MAw1mDQYOUbbanQPJ2WbaXpicFh2co=;
	b=xNe4BMsdk2K9fxk+Nebn+2JVnk6ymlhDy1DTNDLj5VdkEJ3DOTI58SOxdoowiwcjhfJs
	 iEGWW6xc8ngVWYaYhZjIlxwQ6O1SxD7BbDAOS6LiwnTL1qxirlyNRC2aVB0UWihPJyh4L
	 rDktOONIlXG9M4WtnUT8DcPwTPOYy4B0NnCQ1DEbfoMgMgdOJuXK+DE4rFcSC+s4lmtE2
	 YemaKMGhXqgkX9Uw+o+DTa+qE3B7OVZBfNfWdhezT7GSI6GwXQbkP4kEcZfcQTn/PJy2A
	 +kpEKkjBb7nAM8bmgGvcULTkkG922Gbu61jbV0dAFbbte97VasGIqOA610oyF0m28rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.179
Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75B606A32C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E75B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LPQ6Pxo3+i8TljaoQX55dwxGlecaYeyf7p99vtqk4ts=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793759564; v=1; x=1794364364;
 b=wArlUlO5j2sUwSOwT1wwLYy7/GXuSsYRWzPDX0fX1By5eGH+NBJzIFyGKZMrovc++0y4SkH1
 zwGMQUvyneUhjb3K56WvGqsJhzvoe0TOGZ1eNtaL2t7WJL9GozGrUpqMyz3p0I+aaEiXdUxDC4k
 fCf3NgUezNRhIY+pYfMaA1h0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0cb60aae72736be7;
	Wed, 04 Nov 2026 02:32:44 +0000
X-Mizu-Trace-ID: 0cb60aae72736be7
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are stored in arena
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <DMM226XFK9P5.265MSTVAV5QPL@gmail.com>
Date: Tue, 3 Nov 2026 18:32:31 -0800
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Message-Id: <EB1C0109-74FC-4DFC-A25D-DB11BD62EC97@linux.dev>
References: <DMM226XFK9P5.265MSTVAV5QPL@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: iPad Mail (23G90)

> On Nov 3, 2026, at 6:02=E2=80=AFPM, Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>=20
> =EF=BB=BFOn Tue, Nov 03, 2026 at 05:44 PM sashiko-bot@kernel.org <sashiko-=
bot@kernel.org> wrote:
>>> +    ptrs =3D libbpf_reallocarray(NULL, nrels, sizeof(*ptrs));
>>> +    if (!ptrs)
>>> +        return -ENOMEM;
>>> +    obj->arena_ptrs =3D ptrs;
>=20
> [...]
>=20
>> 1. If multiple SEC_RELO sections target arena_data_shndx, the second call=

>> overwrites obj->arena_ptrs (leaking the prior allocation) and allocates o=
nly
>> nrels entries, while obj->arena_ptr_cnt holds the sum across both calls. W=
hen
>> bpf_object__create_maps() -> relocate_arena_ptrs() later runs:
>=20
> Not a bug. Only a hand-made ELF has two SHT_REL sections for one section.
> clang emits one for .addr_space.1, and the static linker merges them by
> name in linker_append_elf_relos().
>=20
>> 2. If an empty .rel.addr_space.1 section has sh_size =3D=3D 0 (nrels =3D=3D=
 0),
>> libbpf_reallocarray(NULL, 0, sizeof(*ptrs)) calls realloc(NULL, 0), which=
 may
>> return NULL and cause bpf_object__collect_arena_relos() to return -ENOMEM=
.
>=20
> No. Nothing emits an empty SHT_REL section.
> glibc returns a pointer for realloc(NULL, 0). Where it's NULL the open of
> such a file fails, and that's fine.
>=20
> I'm replying to a bot hoping that Roman will teach it to learn from mainta=
iners
> and stop reporting such bugs in libbpf where input is trusted.

Thanks, well appreciated!
It=E2=80=99s going into that direction, now at least it should not raise it a=
gain in next versions.


