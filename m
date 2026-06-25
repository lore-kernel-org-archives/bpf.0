Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B23E7BB5
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410146; cv=none; b=isg3tfC3m90fQW5fqFYFZpHusu3yMkI8WWhS7v1j5rdu0Dzh8P1IWIz202Mp9VI+EFcGGVFmQ23z38Qo2RidEEkh8hidAt595+C2ZU6kzZgz39/uCMPvgw5QKwnfMtBXHLrOvBxilNsVkvuF3oNXEYhsVm5MCWs2G3+mbPAaSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410146; c=relaxed/simple;
	bh=2r5sENbHd3EQNqyW0m4VAgHt7uHaAGGQuvdpNkmjY8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1ok2vquxBb2yKX6y1O5p/4fI3+TeqsclB6SOK5AuRD9a7Z3fXmDYmNsFMKWy6yaP+1Ds9+H64Y3lYk/X3YiHBo0lLKmIUOfM6s9N244zulv+3BMDrGmtEc7Uwo5Y2WTepMelPcbw5E1tgW0Dyy9MOSbxOW26UXnqTpUP0a4V0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2YquNij; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2YquNij"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84347ad88edso21867b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782410144; x=1783014944; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZT52GAtwSUupSXHqx0mdbnQLnqFMKCdSlHiF3eY1brA=;
        b=g2YquNijc0SfJNwAgFmU1+uuj/YncNOjacdqnPFdv5qLFP3Bolw3/pvXv/DIFDJa+w
         s7JQ0q+/eYxVBZMaeovUI1cb8OAx11w6DYaBZAMDTDwqfe5HN6UEZTjfasu0uz0xk8Qr
         MEbcpA7t2PAmmdVPB83izvd6T/IH8S6MDfAERJXwd7MUtPYOBKvTkviSf0AG6xva924q
         a9btcGlyPgzHh9aldmZgiJo/jYnhPnK9e3zkTVPb+GRkIkGiGak00cMA9R3cyxx+X4sw
         v7CE0OJpFgnBkUZ6HnwD/5s3rTK3S2AD6CZDYFd4lsfz34z5eWlja9kYiEyKjHh+PJJB
         lAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410144; x=1783014944;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT52GAtwSUupSXHqx0mdbnQLnqFMKCdSlHiF3eY1brA=;
        b=ZMjTXZ9xbnri58+ojHGEnIovrVzpQNitgDB8qW4IKmy3ir2HtxWWZxy9I5SDDOUopZ
         q9xjTLRTWe2yMJ77O78H7jDL6PGASPMaws3a9U/ta2rBIQQh3ucley6DF5s0OACReRSh
         LiE8tP7NBv2BqOY/8RFxCkKvsOhM/4DxXPH+S1RTZiORYKWdj9PmODfVdB9miWgBMNvg
         G3PcAhk8TzpZ2rFJKffpvCNK7R4VhSnBM+mfDt1Vq0PPRQs/iiXq7qbxNpIRC1jMVsXx
         CoEyK4GhQ+UPgqoTkI4TH9GA4Gm3OXdAnzZPmqlzt2TSqRhoUrIBe3+LFs4pisJqPdd0
         Fj1Q==
X-Gm-Message-State: AOJu0YzwcyYrXS8aFdHB5F4XP6+VJFS+3NRqRD2ISMC09XR2qssiPc9h
	IisCUgEMr8mQOfldf88yE3ooGFW7WzUGNj5s5QadHAmDHfO8nebxurjK
X-Gm-Gg: AfdE7cnYeLts6Ip2OwYWQOxUUo9EOxKJpXEfyJCJ1KQtbEj3/1edDB3APgkysKx1jav
	5a7Oog/DtPcIuCodH+L3a1WlgrvVeaO77MW8eXzgLu1L536mCLGTJVhnwhn4rxliZc5/Tj1M7rt
	7+zP4w1iTpohi84BcPZOGM9uiy/ZJIInbmd5V9iS7ZuroPskvsm56gTcOYUp58biF2aktuf7g0J
	vrEF6sL41rq9f4QTUeGNgaYQGaQKSCAyNH0d/xLeGGGLiYn+f7/bhqmfysKzfSaBADXjdVvh5y6
	gZnq6Cg5J4O7YwIpD6AHB9ebF02yjiAzUaJrwgC9ZtzpbjGm2q7GKnZ4Vf09cHvmI80AKaHYkIC
	KJZmD4MgQIR0VQzGTzw5DcQYBykurfMWSvcDJuaTu8dADTOqRr/Q/57QhEYjXZnh9EPMX5PDt+f
	JjK0db+Sn/qa/F9/7RPIAn/owxriKkkpljOoPVfruPmg==
X-Received: by 2002:a05:6a00:98f:b0:845:453d:ee6d with SMTP id d2e1a72fcca58-845b3abbba8mr4550999b3a.17.1782410143822;
        Thu, 25 Jun 2026 10:55:43 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23d7sm5182760b3a.30.2026.06.25.10.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:55:43 -0700 (PDT)
Message-ID: <1a266617aef9e548bf51508639b4fb017ebd4d0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover stack reads from
 zero spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, random6.xyz@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, 	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 25 Jun 2026 10:55:32 -0700
In-Reply-To: <dd8043a6e5bf160f0fae5bb519b0d12c3c85ffb203439ee6663b4459f7a3a312@mail.kernel.org>
References: <20260625-bpf-stack-var-off-zero-v1-v3-2-a068210a761b@gmail.com>
	 <dd8043a6e5bf160f0fae5bb519b0d12c3c85ffb203439ee6663b4459f7a3a312@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-25 at 13:11 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/too=
ls/testing/selftests/bpf/progs/verifier_var_off.c
> > index f345466bca68..24cd0a763673 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> > @@ -59,6 +59,116 @@ __naked void stack_read_priv_vs_unpriv(void)
> > "	::: __clobber_all);
> > =C2=A0}
> >=20
> > +SEC("cgroup/skb")
> > +__description("variable-offset stack read preserves spilled zero")
> > +__success
> > +__log_level(2)
> > +__msg("mark_precise: frame0: regs=3D stack=3D-8")
> > +__msg("R3=3D0")
> > +__retval(0)
> > +__naked void stack_read_var_off_preserves_spilled_zero(void)
> > +{
> > +	asm volatile ("					\
> > +	r0 =3D 0;						\
> > +	*(u64*)(r10 - 8) =3D r0;			\
> > +	r2 =3D *(u32*)(r1 + 0);				\
> > +	r2 &=3D 7;					\
> > +	r2 -=3D 8;					\
> > +	r2 +=3D r10;					\
> > +	r3 =3D *(u8*)(r2 + 0);				\
> > +	r1 =3D r10;					\
> > +	r1 +=3D -1;					\
> > +	r1 +=3D r3;					\
> > +	*(u8*)(r1 + 0) =3D r3;			\
>=20
> This isn't a bug, but these new tests use the load-byte-then-use-as-
> pointer-offset trick (r3 =3D *(u8*)(r2 + 0) followed by r1 +=3D r3 and a
> write through r1) that the existing tests in this file annotate inline,
> for example stack_read_priv_vs_unpriv carries comments like
> "/* dereference it for a stack read */" and "/* add it to fp. We now
> have either fp-4 or fp-8 */".
>=20
> Would a short comment on the r1 +=3D r3 / write step here (and in the
> other three new tests) help match the surrounding style and clarify
> what each test is exercising?

Ignore this.

>=20
> > +	r0 =3D 0;						\
> > +	exit;						\
> > +"	::: __clobber_all);
> > +}
> > +
>=20
> [ ... ]
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/281707=
33419
