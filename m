Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5096305691
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785708194; cv=none; b=e0G8hyWbqrCjBU6osgg0I+R61VBZZcw4hFIAP32i6WKhuSQdTlvq+tzWgAQQ8UtKNiNeJM3cCr9p8xND/xg7956fINksxcs0ogkmeU3i0qJF2ZvhR2IfS7/0T3J+Csm5E2Z97oNuh04wPreQbH35ilugJXwDQVZTLXWiXrX+FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785708194; c=relaxed/simple;
	bh=cg+7Ch9aHIa6Vq2B92HiEt2e0Fs/Ws+yHrKFCt+u87Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlGa032EvV5zC9FZsHxzXJqPVqJ8QEHHQOoMgA1dXdmF/GMBwtTKNIleYyyII/QMQeERvVckqgIQAQ33eQCnrDffbLV15NzxaFF1Bg8Ct/4NGVpBBXXMM/xBAbFnAutnKfyww5OC8gAfu4dkbMMj+WTEEiaMVdyVoBhhnkEhuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUNGjSqu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUNGjSqu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceab75934dso30864035ad.2
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785708192; x=1786312992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rso656z6JgjKhE+rXeO/Oj6U0G1cByYn8hzhK+WCWVM=;
        b=aUNGjSquKuuD2reVJqKtTUxBacIbd/jNjDRD+Ft/ZO8X0+UWw4c7n3LFbkW0LwchCS
         L7hrk9WulEKXGCkY2gNkQpmyP5r+NQuPgSnO6YmOpTnqVSYgXsBJpD//ulbrgnGVdNvz
         68gLm4l62bAnNcAr5tnErKInGvgjm0lnbBLfhMK91enuUOxD5oORBHEu0qNGbaNx06xs
         gsH4VGBk9SlGP1hDIEsCN1sHYRLzcRUExny0o/Ha5noh/HmS5nrrT7H2BOpMfzMuJE0K
         t4W+ud0XfPhSzSS/kpyqRQrrcItrFksuT0Ny5OIigv+jw+an1c9Wy+yE3hRJZc9/9PDO
         iKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785708192; x=1786312992;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rso656z6JgjKhE+rXeO/Oj6U0G1cByYn8hzhK+WCWVM=;
        b=n3h1pvMMO8KF5dKxMHzmOL6n1alBH4oDTTpHnItTJPN8iLF3bp+sv2o8f3/8JjrC3O
         /8hzFwTnGdR0QdRUSSXVSiP3kBhbrusgy0csIOc4e1pY8TyWQYB0IWW3SxCQntcLOq2P
         oQaIZjP/TJUzp55usM2RCKlJg4pBuNWVeX8pqZUTj/kwNS94RykVzCYFYAojonqH5IyT
         iO7AYehuXjUh0ngqNiUASHVnbrIzhC1wWEaowyiTaj1VN7QtddZFGsEPPPLpTNrW1vH+
         UoWfiZUUmfOfymClimwHXkZMJRNYCSMa7cHFsMIfuhmfeODh+7EwsCQGgesrJTDT0eqw
         E7FA==
X-Forwarded-Encrypted: i=1; AHgh+RqQIG9Vbh35E3lLMYdHKdmKy9uQt7xbv8A3AmFfMf0BIp/IFO0Z8KYn1tJ20G9xKvu9U8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrhmp70A4yMXBuaGGNI/LZNoMviW13MJ5qfEcF92z1KVyMBC6j
	VnAVhJc5Kcimozhk6gyFYctcoUZrDb8B/v7vBsqC3XNFRqqAbnmL7RRF
X-Gm-Gg: AR+sD12Y75x37xmJJfiWSegpiDU48NC9DgnnnN3dLeAhfMi5S8airXT+4vmw8EY8sOL
	Ljby7yWIwIaLgXaObMHN1Ax8i3Tsdbjj7lSlC8TEb2irNPZeek8lHyTsIS25vis068wLnkoml/B
	ig3lci3+mcxmEfStT74OSGY9eyx4P+V7hxPgU3+3ZBoRvWRKSk3LBe+oc3IL/l0fbAAtlYR8bAJ
	45PvmzrLpfhpNR0R6GGvMDYtbm+EF43Ou3B9Mtk0hbjP+FZicEJmgju8HF+cn5kMtP9/u9J6qmV
	cHOIeI1YIGYbtIqi8yYVqhZ8HY+m5Q2ahB31ZTUuk8DVEeWpFuvMYMYZA7GZNUE3qlqFSX7SDhw
	UabtUNJ/nxBTdwLX3EPRIkcNX7EC2Zv9C1ly3qu5WMOPc674zh0agVr4BsRmJs2OTdzj8lLhhMu
	pWrQYVB+4kkXPMKivZP6jWlFohwqH57wYZESJ9Z/L6zs9KCSYiL1UH0rrZq5wHGVbOiPQKnKy+E
	6YFOWQopi7F1Jif
X-Received: by 2002:a17:903:1450:b0:2ca:62e:cc4f with SMTP id d9443c01a7336-2d05246fdc7mr79414455ad.23.1785708192066;
        Sun, 02 Aug 2026 15:03:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm28503055ad.21.2026.08.02.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:03:11 -0700 (PDT)
Message-ID: <9baf4dfa07d070ad9f0f1751193e6df51750515f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack
 depth stats
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis
 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 02 Aug 2026 15:03:09 -0700
In-Reply-To: <DKESN3I6A9IA.270SX0UXGSEJ3@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
	 <20260801230400.850271-2-memxor@gmail.com>
	 <ae774dbff74cb78cff1fe27915a9bd8fc4bd990f.camel@gmail.com>
	 <DKESN3I6A9IA.270SX0UXGSEJ3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-02 at 23:59 +0200, Kumar Kartikeya Dwivedi wrote:
> On Sun Aug 2, 2026 at 11:02 PM CEST, Eduard Zingerman wrote:
> > On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:
> > > Currently, the output of stack depth statistics is two crude, with a
> > > list of captured stack depths ordered by the subprog numbers. The act=
ual
> > > subprog numbers are determined by libbpf, hence it is hard to associa=
te
> > > the stack depth statistic back to the subprog by name.
> > >=20
> > > Change the format to:
> > > stack depth <subprog>=3D<depth> ... max=3D<depth>
> > >=20
> > > In case the subprog name is not specified, use subprog[N] as the stri=
ng.
> > >=20
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > > =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++----
> > > =C2=A0.../bpf/progs/verifier_basic_stack.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > > =C2=A0.../bpf/progs/verifier_bpf_fastcall.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++++--------
> > > =C2=A0.../bpf/progs/verifier_private_stack.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++---
> > > =C2=A0.../selftests/bpf/progs/verifier_var_off.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++--
> > > =C2=A05 files changed, 33 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 8d0635ee48c7..51ac0a9ae339 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -18703,10 +18703,18 @@ static void print_verification_stats(struct=
 bpf_verifier_env *env)
> > > =C2=A0	if (env->log.level & BPF_LOG_STATS) {
> > > =C2=A0		verbose(env, "verification time %lld usec\n",
> > > =C2=A0			div_u64(env->verification_time, 1000));
> > > -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> > > -		for (i =3D 1; i < subprog_cnt; i++)
> > > -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> > > -		verbose(env, " max %d\n", env->max_stack_depth);
> > > +		verbose(env, "stack depth");
> > > +		for (i =3D 0; i < subprog_cnt; i++) {
> > > +			const char *name =3D env->subprog_info[i].name;
> > > +
> > > +			if (name && name[0])
> > > +				verbose(env, " %s=3D%d", name,
> > > +					env->subprog_info[i].stack_depth);
> > > +			else
> > > +				verbose(env, " subprog[%d]=3D%d", i,
> > > +					env->subprog_info[i].stack_depth);
> >=20
> > That would be not very convenient to parse by veristat,
> > but I'd print every subprogram on it's own line.
> >=20
>=20
> I can do that, but let's agree on the format before I get to it.
> How should it look like? Prefix with stack depth every line, and print st=
ack
> depth max ... as the very first line? Like so:
>=20
> stack depth max N
> stack depth subprog 0 <name> N
> ...
> stack depth subprog N <name> N
>=20
> ?

Ideally I'd drop the "stack depth " prefix after the first one and
just add an indentation instead. But that would be hard for veristat
to parse. So let's settle on your suggested version.

> > > +		}
> > > +		verbose(env, " max=3D%d\n", env->max_stack_depth);
> >=20
> > I think check_max_stack_depth_subprog() needs a similar update,
> > at the moment it reports a not very helpful error like this:
> >=20
> > =C2=A0 combined stack size of 34 calls is 528. Too large
> >=20
> > Printing the offending spine would be helpful.
> >=20
>=20
> I'll do that in verifier errors patch set. This is just for the verificat=
ion
> stats, that are outside its scope.

Fine by me
