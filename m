Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039878;
	b=mo83Am/cjo46hg0wF+un2aL03tsDCpQN82NbcxL/+XN3Oq61BSgdCz2NcLaEtBV8H2/K
	 egTcnDd412LFgy4XhyLIauCh4QunQ+i8J7tTK1PE8DyAn163oIwVJzQE7pfK5kOq2pNpa
	 MRNqOzWlF0PqbIQM/AAjMhCur77loR1uw7o/Uqa77f+z5xWsrK+sxczRV3vX865s/jYMW
	 c7V3/tqwFG52xRuXheWj3mdH7pZ0Bk1R+25w0aYu5NfiPUTfFKMFpbVxZrjzc+ChI1Xd2
	 Mf8w/wI/KNeL6EJu4GJT3GamP0xsfky8EdmneIOxxvnMidBD7fTQDpMW8PrHUh6oeng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=jJThRBoWZt30Dm2LuGj7j4AVYG9Ualp0wcqGHfqo2WI=;
	b=iS1SbxXXu3wxGBJjazPPMHHtedSgs+Vn2DgKiJZLAd1CtY0JC7N6QDtedMO5hfp4c7zX
	 jbw+ldakjY2JYp9QLER+v9HS3Xjhh0/fRZC1XOONpTL/4qHZlOqyo4CZBvwZJGe5SehKM
	 8cgZiV4vJ1uEmQ9qkjHJA5bz3iHu+8kCeyO/t5bq9f3DlJWoS72qXZaXF2aEGGQf1u6nw
	 1Z9hEKkPtBtk9iwiEbS6R1Xw7GWFwDck/X7QBKE2TfFHBMAdh0DwdS7HEQVYlMRRuhK33
	 3lEvcS+4DLIhpWBD9du7ekWriD4hZIBzBEIBoGUgUYIMxrna2IIJ9Jn+V6L/H6vo7Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jqdap/Sr";
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD79606A32A
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD79606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jqdap/Sr
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a60f90a924so766224b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039878; x=1795644678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jJThRBoWZt30Dm2LuGj7j4AVYG9Ualp0wcqGHfqo2WI=;
        b=jqdap/SrldEmF7GN4b9Pc6za4TNmOl5OAM1Tpt3iVnavQWFP98sQvzKsSC4cG+vHs1
         MXmfSAq+Lq9AEgoqP93TWCDJ7rfsXzljA+7+KNG0KUtf2LsvW36zLCE5aPraM9ni4FSN
         8KmJ9IPkc9B8Uk88c71ZRCRtAp4eloJFE+flpiSyuE2RTO0mDgqpesr+gdhAF3018BAf
         cCFkA4+S1LO3QQ3tqe7GTw46hefC3Iq68FPfy5hQi/O6lHtryy3aEM6Mfr+2My0JIq+Q
         SKObxLVT3oJGBdo/OuRk5FUQIYhSl54/pektg4ffrfWAhO6LXCZjf2KJu2545vr5efSw
         74CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039878; x=1795644678;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJThRBoWZt30Dm2LuGj7j4AVYG9Ualp0wcqGHfqo2WI=;
        b=bm1XIuHm72ISJ1MsJ0+/HLZUHAGUy1KbF4yfVv2ZdO2U/PFB48sfiwsoaAf9KdVlJd
         +X9I3HsUMSxYJyoP73SEyHturXTsnpTkiUso+yuPpU7lMm11L0KMiHRHvAHLDOLGeaAk
         YDcKKwDRn8O4XfwvXOHdCgjp/bvwNDJLylWXgvow6UgsZO+YOFtr/r4QFNUaYNa4Si20
         l525n83vo+hzjO4JsNQtFVHcCWCJ+Y5k8qk7CwGuzU7qQqe1Z5raQF1yB0Nn9RmuWF2q
         cpx2N2P5Eie03aycqOUVONlomCDDoySHXMbeKZHia1otZKbkRIgny8lHftGGqEr41GMW
         X7dg==
X-Forwarded-Encrypted: i=1; AL+hErGtbsUAUpTxA0o62KxooRcu1iJt3UX9vu4TCfqlHs0aFnrRg2vn9P45wTBE29jzdGKGRg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KwD3io+p9ilytwJBscvQgM5tDPlhBbQGJbL1Um1NWgRQAFvz0
	AYeb1EkYGjaqwJ/Ghfp/NFCs6RD7N2RsK/6cWCfXzOo8ofiuAhREl4y5
X-Gm-Gg: AYBFou3+Ru6CUUKKTZ30dkHUAqxIP0bQOwhsMjCAjEtWtsoJZC8hXUdfEc+LL3J7c2M
	IgwAJa4ZHaKjioHity9tv6u1a+HRjqpCVmSXaju/JXDMPPWjlM6CS5kfg01RNFffx4cI4mz0ykQ
	K5Gc6LaHwntPyYidLSFPtaTyVwTzWIUlMwrwSijAuQfjEy8JnpTi4jK4Z155NtNdahZyC0TtDnN
	dZw4e5qvw1eWZnyP5Q6SJAtnwcM05CzVgAFegHTFkim40HHmKeMl4KJk76nR4xES+rdu6syh7zR
	Yf7RmSsO4bSk/wW5as6BHDq8wp5RGZ66drtLEuPGp0vT5FcD0v6tvCxLfVN6cdVVpEenUAmSK6o
	OsQUarx70sbKILXC8m7aJ6R8yXPDQmdr1zTYZF0/vM6rRGrHIMVpGGK8WARKyCdVtAQhvq4Bf26
	tvcXXQpE0FkAXuGOhlOXjp0lZjXWGiVgeatIvBvwjYJ9sukfxsPjeEF/mMmtHeh+wkldXUKoMLY
	qaQI9/mRgK2B0x4ApZb4gNutXAMdbV3xqMTOyLEVRPaJ8SqXg9asGKvTrIoDNuwwmilArmyuLlJ
	b8+4ltdmJ7p29blTXELofS5oLjsDC6VJCNyE3KhxAa1KdzzDI0BBmnI3
X-Received: by 2002:a05:6a00:94c4:b0:878:3705:2515 with SMTP id d2e1a72fcca58-8c5d42f1a26mr3437425b3a.53.1795039877929;
        Wed, 18 Nov 2026 14:11:17 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cac8fe3csm1791387b3a.21.2026.11.18.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:11:17 -0800 (PST)
Message-ID: <d2f665211f7c294bf7a8f3897b247863090e4e19.camel@gmail.com>
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
Date: Wed, 18 Nov 2026 15:11:15 -0700
In-Reply-To: <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
	 <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
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

On Wed, 2026-11-18 at 14:37 -0700, Ihor Solodrai wrote:
> On 2026-11-18 2:12 p.m., Eduard Zingerman wrote:
> > On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> > > An incompatible change to a kfunc's prototype, such as an added
> > > parameter, breaks BPF programs built against the old one. libbpf
> > > ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
> > > but makes an exact name look up on the kernel side, so the kernel
> > > can't keep the old prototype available under the kfunc's name.
> > >=20
> > > sched_ext ran into this. cded46d97159 ("sched_ext: Make
> > > scx_bpf_dsq_insert*() return bool") kept the old prototype as
> > > scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
> > > it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert(=
)
> > > backward binary compatibility") reversed the naming. A ___v2 kfunc
> > > declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
> > > ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
> > > fixed a compat macro that silently dropped enq_flags because of this.
> >=20
> > Please prefer examples to prose in cover letters.
>=20
> The sched_ext story above narrates the commit history to illustrate
> the motivation for the feature.=C2=A0 Would you like to see code samples
> from there, or are you suggesting to drop the paragraph?
>=20
> The documentation patch includes code examples of the new binding
> rules, I didn't want to duplicate that in the cover.

There are two ways to act while reading the above paragraph:
- follow the referenced commits and reconstruct the issue (time consuming).
- ignore it (not helpful).

> > Also, please de-Claude the included prose.
>=20
> Please be more specific. Which "included prose"?

  sched_ext ran into this. cded46d97159 ... kept the old prototype as
  scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
  it, and broke them. 2dbbdeda77a6 ... reversed the naming. A ___v2
  kfunc declared as vmlinux.h spells it doesn't bind: 56bbc91219c0 ...
  fixed a compat macro that silently dropped enq_flags because of this.

This screams Claude from 1000 miles distance.
Maybe I have reading comprehension issues, but in order to decipher it
one has to:
- "kept old prototype" - figure out that two functions were declared
  "scx_bpf_dsq_insert" and "scx_bpf_dsq_insert___compat"
- "bind old binaries to it and broke them" - figure out that existing
  bpf programs referred to "scx_bpf_dsq_insert" and libbpf mechanics
  didn't work as expected.
- "reversed the naming" - like a new function became ___compat or what
  happened?
- "A ___v2 kfunc declared as vmlinux.h spells it ..."
  Now there is a ___v2 in the picture.
- "... doesn't bind" - figure out that this refers to libbpf mechanics.
- "fixed a compat macro that silently dropped enq_flags because of this."
  Incomprehensible w/o looking in the code.

> >=20
> > > With this series, if the kernel's bpf_foo kfunc is missing or its
> > > prototype is incompatible with the declaration, libbpf binds the
> > > bpf_foo___<flavor> that has a compatible prototype. So a changed kfun=
c
> > > can keep its name, and the old prototype stays available as foo___v1.
> > >=20
> > > resolve_btfids fails the build if two of bpf_foo and its flavors have
> > > compatible prototypes, unless both have foo's exact prototype
> > > (aliases), so the fallback finds at most one match.=C2=A0 This ensure=
s at
> >=20
> > Why is an exception for kfuncs with identical prototypes necessary?
>=20
> For example, when the void scx_bpf_dsq_insert() is deprecated, the
> kernel side can do this:
>=20
> =C2=A0=C2=A0 Today:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void scx_bpf_dsq_=
insert(...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool scx_bpf_dsq_insert___v2(...)
>=20
> =C2=A0=C2=A0 Later:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool scx_bpf_dsq_=
insert(...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool scx_bpf_dsq_insert___v2(...)=C2=A0 /* calls=20
> scx_bpf_dsq_insert() */
>=20
> Existing schedulers declare scx_bpf_dsq_insert___v2___compat.
>=20
> libbpf strips the last suffix, so the bpf progs still call
> scx_bpf_dsq_insert___v2(). The wrapper keeps them working during the
> transition, including with older libbpf.
>=20
> The exception allows to do this.
> Otherwise we break the ___v2___compat trick.

Thank you.

> >=20
> > > kernel / module build time that no ambigous kfunc flavors exist.
> > > Documentation/bpf/kfuncs.rst describes the rules.
> > >=20
> > > Compatibility is determined by bpf_core_types_are_compat(), the check
> > > libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
> > > changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
> > > return kind, callback prototype). The other 62 (const, typedefs,
> > > parameter names, integer widths, pointee struct names, annotation
> > > suffixes) were made in place without breaking old callers.
> >=20
> > Do you mean that without this series programs referring old prototypes
> > are broken?
>=20
> Yes, if the kernel changed the prototype in place and the BPF program
> still expects the old one. For example, 8fe4dc4f6456 ("bpf: change
> prototype of bpf_session_{cookie,is_return}") added a ctx argument to
> bpf_session_is_return() in v7.0. libbpf can't resolve an object's old
> no-argument declaration on that kernel.
>=20
> This series alone doesn't fix this, but with it the kernel *can*
> provide bpf_session_is_return___v1(void) for the old callers.

Ok, this clarifies things, thank you.
