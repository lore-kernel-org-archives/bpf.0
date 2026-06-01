Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6726CE39
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357779; cv=none; b=f1Qzb2b6uJ/puLYVy1CwaJRq08N3CemAUE9k2hrAXI7qiqyZFd5q1CLFyooNj51B1C3h4O06t34Zq0WYwG+F2q9PPwy/ooAFsiRNSIxCrFaUXPRe9Zthgr6gTE7oYz25JFBGSy3dhNL2xHz5nMqQjCrgnXdjRuUuDZqO9hiaDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357779; c=relaxed/simple;
	bh=LFJb4dUI2q670rL9vw2sGnQYlfcHgeUXGpkRSOp+BPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWP2G3iLVAFS6AiVu2nFWArP3Fmw+xb1Qr+/fN91KZqVAkOm94H2BfRMoLFeSUuWnwV4qv6hAqrx5FuA5dt8kjeEy66Hezd/GfUVtqTjGDtzlKTynctAX7Hcsj8Yldac4plciH86/cRNcLlwL0GmaDH/5P1o/yNsZsksb6XUmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ8YZ5WL; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ8YZ5WL"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137bd9ed2b1so2855859c88.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780357776; x=1780962576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BnYnRb2vtofh/fDuwPVdMwfNTqYx7MoOXZN6LCoYYE=;
        b=YJ8YZ5WL6wLvnPGV5Wz9l11oxY7Vxb6/oOMrSLDaf7EhSCGvtjpcMLary/0qX4rjm2
         rFCk/pIZ8kEIsKYz6w6xdoQTQcBRTnrPaIW0ahuSAYFVJpLxyWPGzp1Dp3yt9Ru9WHtz
         xYjD9e6GO5RMZFJUVP5RvLT2KIRaQkYEI8JODg1+ir8s+0aSsvKZqRMX8QlUgcBylJD2
         nWy6XeYMrsyxvIdDwCl3bsSTysQDjHXsqtgDrRhJ822TRzf6d/z+Y7DH1tOpCKq2Bh7/
         4Qz5GYg/mwwRQyHIqp480ExZxiT40KAHhuQ2EbpvvGkBN6hABvPJk2gYNCgkWZlDMD3r
         RZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780357776; x=1780962576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BnYnRb2vtofh/fDuwPVdMwfNTqYx7MoOXZN6LCoYYE=;
        b=qzEGkSy2GTCWLGLC7wu63lsAFord2Qi/pu+TAJVOxdiPsknjMhvEufipKItjNQ6Tou
         bDqnPfALKAAWDx8TQ2J2NSmGJKroHadeuNILgBAFR/ULW+k9NS0GpE7VVJ4c0HuVrgXh
         59FQCwzyT+Z80fEh6vKGHLLqSqv4H4G8bEBP702x3eZf6vI3BcYE+oJXPWPo4n6NkeLE
         S3kIlTwSGhy1J373bK+2u1ATDWNVPs5bdYYHYoLZjpMppC1TInCFEM7F28qFaHlYsug2
         qBpDH3Y4KjLC2sTBjSReFujnC/cYlgyYeMieYWe1vIhhJVCkSyJQ3kULr3RrKcteUCiq
         DBmw==
X-Forwarded-Encrypted: i=1; AFNElJ+UQkK4mGTIS4R2pzxMq17snf8qWDQ1Z1sIYcA30iFySnAu4/Wi+DASO7nUCu9nXqHNe70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jSqALOwQzhk5qLQAxOUn2507QaZMic5OggW5iGwS2qkdRDpO
	REELX6vk7qTitbtz/SmBIMRp+BrSiu0o7o/eWvTLO7KB+iPYw4inO8l5Pw8bH/zq
X-Gm-Gg: Acq92OG/GhI1uM/45W6Au3HrAP/SDh9+wu1Cge6n/mttYWAr6psgOTlwLjgRmX5GxNV
	90tTB5jSYKUioZ6hDuLWdfGNo+ETKy7fpGDTLIcYNg86AKupAptrfwuD59nHr841PNOZNQsYwfS
	cHTrmBa9/Bx5AoYkcNPET5/JIG3SqqcgxsUVX65fNFSMOvGqighOV8q96ybCV9ZRUCGHzmrYBX9
	girXJ5eXJeiRsr7vO817P7QMlNENXOYl69PVHoDr5RAnYErfe6uLYAONEl2zjdTwbZTKrfBEkoA
	sTTg5g2/vorEkETPXh9Oy4gMq1zBqDmw4YOhO/etlrwFwuNzglNl+H7UuHsToo9hzWKPnNQAWVT
	2qhQsfudS19XNSgbvgTJ6aLtFC3ZmcyrSJBs29G4abZnliedqBNmO/D77hs5OBn/xxkn3Ro6STv
	/KFaE7pl5dmAVhckTvsClWZCzbPdd6SPo8yhu/gw04X5k1Wf76fCf+xPy+PuacMPG2d6QXm63mk
	pcX7JxN00bsasrSnMo=
X-Received: by 2002:a05:7300:2327:b0:304:b15:17d6 with SMTP id 5a478bee46e88-304fa49e2c3mr6375469eec.6.1780357776433;
        Mon, 01 Jun 2026 16:49:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c6ab:2254:f011:38f4? ([2620:10d:c090:500::3:1ca7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10073688eec.28.2026.06.01.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:49:36 -0700 (PDT)
Message-ID: <50097b521bbcfe988db984df73b9336fb32ae6e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, Mykyta
 Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team	 <kernel-team@meta.com>
Date: Mon, 01 Jun 2026 16:49:34 -0700
In-Reply-To: <CAADnVQ+K_=xz6f3Czoj6f6AeO6Bh0eyq-ambF11+hYq7DZq15w@mail.gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
	 <20260529014936.2811085-6-ameryhung@gmail.com>
	 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
	 <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
	 <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
	 <CAADnVQ+K_=xz6f3Czoj6f6AeO6Bh0eyq-ambF11+hYq7DZq15w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 15:35 -0700, Alexei Starovoitov wrote:
> On Mon, Jun 1, 2026 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2026-06-01 at 11:36 -0700, Amery Hung wrote:
> > > On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >=20
> > > > On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
> > > >=20
> > > > I think refsafe() needs an update.
> > > >=20
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > >=20
> > > > [...]
> > > >=20
> > > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > > index 877338136009..5945956a7573 100644
> > > > > --- a/kernel/bpf/states.c
> > > > > +++ b/kernel/bpf/states.c
> > > >=20
> > > > I think refsafe() needs an update as well.
> > > > Something like:
> > > >=20
> > > >     --- a/kernel/bpf/states.c
> > > >     +++ b/kernel/bpf/states.c
> > > >     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_sta=
te *old, struct bpf_verifier_state *c
> > > >=20
> > > >             for (i =3D 0; i < old->acquired_refs; i++) {
> > > >                     if (!check_ids(old->refs[i].id, cur->refs[i].id=
, idmap) ||
> > > >     +                   !check_ids(old->refs[i].parent_id, cur->ref=
s[i].parent_id, idmap) ||
> > > >                         old->refs[i].type !=3D cur->refs[i].type)
> > > >                             return false;
> > > >                     switch (old->refs[i].type) {
> > > >=20
> > > > Wdyt?
> > >=20
> > > You are right. It needs to compare parent_id, but maybe only for
> > > REF_TYPE_PTR like below.
> >=20
> > check_ids() should handle the case when parent_id is zero correctly,
> > so I think both variants are fine.
>=20
> if that's the only thing, maybe let's do it in the follow up?
>=20
> Eduard,
> are you Ack-ing the whole set?

Yes, I think this set is safe to land.
(Note that there was also a nit from Mykyta, can be a follow-up as well).
