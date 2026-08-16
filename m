Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26C3BED7B
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924604; cv=none; b=hjri+YVqPYS2XEG+n43tK+gdDS4vgs8IS3XEO6ZANzolIK0IPBLF6pMj46TvHWB0pbFB54eVuWbmqdxhrn2LnZCljpGZJyVuV3aCTQZBrWUj2WmeqSfE3EhavtlOZ/w8qyMd8qcYcd+kZt4O9s4XlpUZruefFQNey7MhwQd8254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924604; c=relaxed/simple;
	bh=Qvkal74R1egH335vOx3qBPn3Bpf6UiClQE9XMnOZRgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYuBfRtnZ8kvaTSn4ZQFfs6+NNtWIuwuDFJpSW75EjcTBmYocZobJMEEPo3DWScqv3BUVWu8qbpshAeLe28PsVygw6OqoOvyBsB3r47vCk0AZmFg+NgfTUjm+/1GCaGqtwl3gvyxY9futNisHvdWmxJwEEOhBXXUMP+/cJY2jJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXbZ/28V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXbZ/28V"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cca0c5799eso25130065ad.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786924602; x=1787529402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GfZg4C+Rx7mhf0/KR0B5Y+MvdvLojqVCPN2v8hs0gwo=;
        b=GXbZ/28VR6QPYjUTY6PHpV2qKXfr8BGdDAaPhIu79ym+xVwaTfCSFGYzU77imCdO/9
         5JKQzprH7wjTI4/LSqckLmRfMjtYQcKWeuLryChTrTYzskCVg/uI2r2BFp2Bgz2J/MlO
         PuCg4JctcBs4p6xXtXZWr6OZUkDGG3isEPb7iV20bOaK7HYzhrNzuhqlMKv53ceON8A9
         t0XZ8dggXxA5GJ5dAoArHVbXjstTv1ngP5jtmu6RLP1Fy/PL184sA9UkbWgE3e0bygny
         pupb9c3N1GFsJLu42/qUXmTmLJf2dRVlopUVc6o+erWz7opZthl5HP7elpjlexdhek7p
         Dq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786924602; x=1787529402;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfZg4C+Rx7mhf0/KR0B5Y+MvdvLojqVCPN2v8hs0gwo=;
        b=Ft56mFrP21A+vv0waHQhu6bJDRVkl6njF69JUn5YWLAwZSNtwFB2p3hjZXEtid2GL+
         bcDPjcuCyXxftK5XqWZsvMN40BFUNFBowMnbx4EEn7dD62bZW89QnigFfW/oDi+R/RWs
         aDLjrXeqHnDTgiOX4jUEPIQG0woTG+EdjkLvGL9i4l2u5REbGF25de7Fc01BPnIMPBh/
         OQdmO0YgLwuaWELWtOey4PhlTr6XORGPLZ89hwVpYX3tUehkXs32z4eQIi+HO6gEq/6M
         5MPeuWH6ANLGYJq5/zu3dulH2mBxSjOdMSuFVsdZPXu5X0jmB3KHp70nKmwcYp8EnR3m
         ntdA==
X-Gm-Message-State: AOJu0YxBAxPR4hxJzATi1mdpQCmgdusUAoDaiqVrpwn59h6lm9oINKmM
	dV2en1RsPiZ3RiAWjy8hx4Kune77NhYslyVRt6Mv6JufpyvyPTrsGNev
X-Gm-Gg: AR+sD11tRt0/AsHSC4Omj1cuIaGbWzXC/nMFB+hI1wOu0FIRAHlwiQ/uco1Vir0us56
	lFemhiugNRmn9JEhYKgejzR9ULrE6h0xAEyO6yUak9tTIsgljcVzBX7/7YxUc+kZTaSz1dvcHbz
	vRONg5+LpfjW2Mk2YwhiiyLnHLTZLFFaqNPq8HLav/+d6x72r98HkZOfTfbpJcJBNVGegNCxh+U
	4uLR8dxCyMhWWDrpQX6r6UDd1OwW91s8Xf+3wNdJ6ZE8V5u0J0aop+sbWgeiY4msspFLDO+HcKy
	YUT24SME0QxuetNc3/xPWjIRTlLujxXKRDVH51Ab2/RvLf205MCifoEypf1eZScm2ahNHMBb3+c
	/vYCEIv/OGw9ro0m41UfxdOFXsobSRWFt5YjIAuvGuzAycVH+LxmLDI2QMnHfz2XcvTt1aa/qIw
	GG4Du68CyAx9nEFsLFQwR4uopTyZotn7SPVTJh+kAiGR4SOG3chEfgz172k7udz7dwj5cn6dEso
	DjyWeb9wi5LjzYo
X-Received: by 2002:a17:903:8d0:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d3b0ad0fa1mr237628105ad.1.1786924602338;
        Sun, 16 Aug 2026 16:56:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec05092sm26446205ad.82.2026.08.16.16.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 16:56:41 -0700 (PDT)
Message-ID: <f721efe944dc7393511a8f35a2474e1f812a31be.camel@gmail.com>
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
Date: Sun, 16 Aug 2026 16:56:36 -0700
In-Reply-To: <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
References: 
	<20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
			 <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
		 <cd62cd53be9bcea2d5b63fef8eece815f5095103.camel@gmail.com>
	 <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 16:36 -0700, Eduard Zingerman wrote:
> On Sun, 2026-08-16 at 16:17 -0700, Eduard Zingerman wrote:
> > On Sun, 2026-08-16 at 10:56 +0000, Yiyang Chen wrote:
> > > Add a verifier test with one atomic RMW instruction reached through
> > > PTR_TO_ARENA and PTR_TO_STACK paths. The verifier must reject the
> > > shared instruction with the existing incompatible-pointer diagnostic.
> > >=20
> > > Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> > > ---
> > > =C2=A0tools/testing/selftests/bpf/progs/verifier_arena.c | 39 +++++++=
+++++++++++++++
> > > =C2=A01 file changed, 39 insertions(+)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/too=
ls/testing/selftests/bpf/progs/verifier_arena.c
> > > index b241bbcf54a8a..b22bab33301ab 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> > > @@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
> > > =C2=A0
> > > =C2=A0#endif
> > > =C2=A0
> > > +static const struct bpf_insn addr_space_cast_insn =3D {
> > > +	.code =3D 0xbf,
> > > +	.dst_reg =3D BPF_REG_7,
> > > +	.src_reg =3D BPF_REG_7,
> > > +	.off =3D 1,
> > > +	.imm =3D 1,
> > > +};
> > > +
> > > +SEC("socket")
> > > +__description("arena and stack atomic at the same instruction")
> > > +__failure __msg("same insn cannot be used with different pointers")
> > > +__arch_x86_64
> > > +__load_if_JITed()
> > > +__naked void mixed_arena_stack_atomic(void)
> > > +{
> > > +	asm volatile ("					\
> > > +	r1 =3D %[arena] ll;				\
> > > +	r6 =3D r10;					\
> > > +	r6 +=3D -8;					\
> > > +	r9 =3D 0;					\
> > > +	*(u64 *)(r6 + 0) =3D r9;			\
> > > +	r7 =3D 8192;					\
> > > +	.8byte %[addr_space_cast];			\
> >=20
> > I'm going to fix this to:
> >=20
> > 	r7 =3D addr_space_cast(r7, 0, 1);			\
> >=20
> > as in the test case above.
> > Waiting for CI [1].
> >=20
> > [1] https://github.com/kernel-patches/bpf/pull/13325
>=20
>=20
> A...and it requires another exception for GCC-BPF:
> https://github.com/kernel-patches/bpf/blob/bpf-next_base/ci/vmtest/config=
s/DENYLIST.test_progs-bpf_gcc
>=20
> Ihor, it's a third time GCC-BPF strikes this weekend.
> What do people think about downgrading it to may-fail until the
> DENYLIST decreases to something reasonable?

I'm not being fair here. ksock series shown a real deficiency in
verier logic, matchers in Daniel's series were unstable.
Please disregard the above suggestion.
