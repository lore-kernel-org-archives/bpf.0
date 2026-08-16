Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C13939B1
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786923385; cv=none; b=D/fNLnL8dlhdjehIyOebSSdHYZXDvMaTkvF3NSPuoNTW4vFZdeL8Ke883Jait4Biu3kLJd9M9Lwcj/P54ZovPWWbMNrFPFRnSF/0JTlgch2vhDpY7N27W6cUaoccAIDN7A6JKBCszzvrauFz6y8swvDhUrnnaixGrwVeNVlZySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786923385; c=relaxed/simple;
	bh=bq9MN/bX2R0bXsweGMpb7skeep9yO59BTdJwEJTMwNs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+cADmwYcbJHJZ5Y25Sv2RsAx8PxRp9O7kvQfSKqZPeHfIk+YYCoNqg93gFPVRlVMhciJ2+EyapiFpjuxcI42wL24U8DMUzPdPGrwF7Ftl+9+IZwPiGsv7bR8g6YySXQHvCNoG2xWB0y5J4EITC8k0eVeaosRRyATzcPdKHxfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9KXssBD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9KXssBD"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f620399a0so2410491a91.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786923382; x=1787528182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KJGbvUie7iwTQdFV7R9JzenbY14EPPB5R3LJIQLe+Rs=;
        b=o9KXssBDNj4OuH6G8cd8zwMw4a0QNfy2VAalXKteR8vOciB3JNr/tHy1IoNBi/EGv+
         jfW8Ri1HldwojqE0ddzm8q5f3P/DIF4Yju0r3MYUbAMT3FA2aNXZAeEkZ67roXIoyAl/
         KCizhqzZISYq99v7h+ELMm3NWiZfeDB+AJNfmDIhzKgvkKq0ippjr4K6q+e5yNz90h8n
         IurZOJrw4ubr0fH4E32XjuIOjUtoBoVqJqtx0mwDNsEFcoS/QMFQ5+0y/Tmkd/ArBzlp
         0xKw6LZmNeN+0ekVsP10GCpoIAqe20ztEhA4aLuHNxnV91kxRkG1LvjbK1dDTWnHgLpt
         BWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786923382; x=1787528182;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJGbvUie7iwTQdFV7R9JzenbY14EPPB5R3LJIQLe+Rs=;
        b=foq6aiuNhFoU8gO+UKZS8kh5VFKwAILKBHKx5iCxvRoVTJlFlckTiYwYYaVs9ah+dn
         b5dGswT/4EOC2EICLY2xwIrexfL4R5RZ2pnIxCZjIP09CFdwLCbpXMcp8BXqmEH7Ow8C
         1Vpx8CrW8ByRYM58sSaduNauulZgJVZz7Td1ChLeFp+NuXFa8+OIc/QS5E91/goAIzp0
         FcRfZP3tcV0a2nmGTnhYl6wSItL/XSp1XVUg2ltWHVjYUytZqKB9nfqWMvQIf7BI8XQ+
         ujWvglzzeLHL5KVlSB3xU25M73lKQEOpkmz9Si2Eyd9EdYtN9HO6ILj/MXiPpqPe0k8Q
         xT3w==
X-Gm-Message-State: AOJu0Ywk5cBop6UuHtlP0j7c/w14nE1U+XXTNf3nfzCIPo8mUyByau42
	0qlcBU7NoVMK2z7kquBdn32PljJkmr0sDGgsY9qvAixt6r0vVAc5mo7J
X-Gm-Gg: AR+sD12nK/6klfNDAd5/SLuHxjnzlZVCbnfpNYdFSwJPiwG4AL7Snw6LNlg6e5lgkws
	hm1G4Z4dxsAF74OSMbAKlHtGVkURGZVGIp7ab6UBl+qJUj/+gV8VL5hYy6dxuXN2ty9MHbtkikT
	ft8gk5qB4w0ZMC6gQf1OmhZ9hvsYsTMLP6hKNsR09a9TB0uQKF425R2pIkF62ujU4W76tO8qvUI
	m1NmLwr8vG+GerA0ihMHY7w3q8CxbqLwhdlRg10VoZ0HxHYdmvGlSzKSbmv0lPTpHx3UToGvMkN
	mZi6piwXBTNCSEB/KXyQqERbeB3O3YsMsxkOC2OnByewu0zzy9sW14myyHSSQTLCns3Rjgjq2uQ
	5bK9mU1KlJRvLfI67yGtk+g5P6g4jhKQWLnd8x2bOS6mxtHZWljIQi4LfXTT0f/b1+h71S1tvwi
	yTPhivLTBBMhc7eZtuZmVBIXbdOQCLIhQokk99YrGb9VLAiBYzbDsiyyfeLU+uxElBcq43b5gpP
	gVk3mS/dhZoGyhh
X-Received: by 2002:a17:90b:1b45:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3933b944a7cmr20430250a91.15.1786923381956;
        Sun, 16 Aug 2026 16:36:21 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2b8080sm19485a91.4.2026.08.16.16.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 16:36:21 -0700 (PDT)
Message-ID: <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover mixed arena and
 stack atomics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi
	 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	vineet.gupta@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Sun, 16 Aug 2026 16:36:18 -0700
In-Reply-To: <cd62cd53be9bcea2d5b63fef8eece815f5095103.camel@gmail.com>
References: 
	<20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
		 <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
	 <cd62cd53be9bcea2d5b63fef8eece815f5095103.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 16:17 -0700, Eduard Zingerman wrote:
> On Sun, 2026-08-16 at 10:56 +0000, Yiyang Chen wrote:
> > Add a verifier test with one atomic RMW instruction reached through
> > PTR_TO_ARENA and PTR_TO_STACK paths. The verifier must reject the
> > shared instruction with the existing incompatible-pointer diagnostic.
> >=20
> > Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> > ---
> > =C2=A0tools/testing/selftests/bpf/progs/verifier_arena.c | 39 +++++++++=
+++++++++++++
> > =C2=A01 file changed, 39 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools=
/testing/selftests/bpf/progs/verifier_arena.c
> > index b241bbcf54a8a..b22bab33301ab 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> > @@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
> > =C2=A0
> > =C2=A0#endif
> > =C2=A0
> > +static const struct bpf_insn addr_space_cast_insn =3D {
> > +	.code =3D 0xbf,
> > +	.dst_reg =3D BPF_REG_7,
> > +	.src_reg =3D BPF_REG_7,
> > +	.off =3D 1,
> > +	.imm =3D 1,
> > +};
> > +
> > +SEC("socket")
> > +__description("arena and stack atomic at the same instruction")
> > +__failure __msg("same insn cannot be used with different pointers")
> > +__arch_x86_64
> > +__load_if_JITed()
> > +__naked void mixed_arena_stack_atomic(void)
> > +{
> > +	asm volatile ("					\
> > +	r1 =3D %[arena] ll;				\
> > +	r6 =3D r10;					\
> > +	r6 +=3D -8;					\
> > +	r9 =3D 0;					\
> > +	*(u64 *)(r6 + 0) =3D r9;			\
> > +	r7 =3D 8192;					\
> > +	.8byte %[addr_space_cast];			\
>=20
> I'm going to fix this to:
>=20
> 	r7 =3D addr_space_cast(r7, 0, 1);			\
>=20
> as in the test case above.
> Waiting for CI [1].
>=20
> [1] https://github.com/kernel-patches/bpf/pull/13325


A...and it requires another exception for GCC-BPF:
https://github.com/kernel-patches/bpf/blob/bpf-next_base/ci/vmtest/configs/=
DENYLIST.test_progs-bpf_gcc

Ihor, it's a third time GCC-BPF strikes this weekend.
What do people think about downgrading it to may-fail until the
DENYLIST decreases to something reasonable?

Anyway, I'll wrap-up with this patch-set in the evening.

> > +	call %[bpf_get_prandom_u32];			\
> > +	if w0 !=3D 0 goto 1f;				\
> > +	r8 =3D r6;					\
> > +	goto 2f;					\
> > +1:	r8 =3D r7;					\
> > +2:	r9 =3D 1;					\
> > +	lock *(u64 *)(r8 + 0) +=3D r9;			\
> > +	r0 =3D 0;					\
> > +	exit;						\
> > +"	:
> > +	: __imm_addr(arena),
> > +	=C2=A0 __imm_insn(addr_space_cast, addr_space_cast_insn),
> > +	=C2=A0 __imm(bpf_get_prandom_u32)
> > +	: __clobber_all);
> > +}
> > +
> > =C2=A0static __noinline
> > =C2=A0u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
> > =C2=A0{
