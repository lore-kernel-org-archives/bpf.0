Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F513839A9
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596182; cv=none; b=jr2LGmcaQ5EwLUq0SB5CRbPzPpy2DXQiM9uxxHUwEjiQ+ufm0mtij2SMDLBLDTeV+se74uKj3rUgCSOh/ujOHx85ONFa/e/JlsJUvlEe9UyV9L6Z5AmNWIuOIqbtNNWbDUqYJIs83C/dYgsdXLM2r7cCeq6IWsMb9WUgGlk/94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596182; c=relaxed/simple;
	bh=lf7dQ7NnskAy3ATAOFdF26vnu8RkVCtT1uDpmn5bCk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoBGd30E+o+92ZC2b77He/6vIcThfjO27qgs0vPagjkWivJ9Ns3iStIuSwSIkQn8i0jeUctHlkty08OBFBxapPSusXLJr2GnEz97qctwrM2QlgIAig3NRYnZf2bMoK+Ca+KYpzab0vzhHM0Mro2DkqryxKk0EYqlGbo4fJT+pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxJXIjhU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxJXIjhU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84867f07d63so4111653b3a.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787596180; x=1788200980; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iwTimE3tMK3wAwPhjwKLsiVricZAjo6qRLA/H5Hgmrg=;
        b=JxJXIjhUlM0sGqpVNFldhn5O0uy8+zznUEGO24mSurGhRKCpAAJ4mPELEfbTBhXU8a
         pxsvPW/cLdIUvUyICL46Du7VQVngUnr4XTqeFX4oLKHM8cG01SELKY6PTISup2r/FvZl
         DSrHR8OoBc0DSmgNrjSOQ+lUXKY6+0Cvr6Km/AzHFJ4byRVdPL3V2IjJDZdOfF00FB1H
         I9SwyzIz4IJ6D4YDLDfghl0v2fSYBXNbVs1nkvFMzxmHyq1NwlI2m/NwKKNnXDQHY28H
         8zTjna3fzfJZQZht1QV6JnyhPVh9DGCjX1xfPTJVQ5Fkd3abko94cYRoIc4SYp71qrzV
         kTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596180; x=1788200980;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwTimE3tMK3wAwPhjwKLsiVricZAjo6qRLA/H5Hgmrg=;
        b=WhOPrpkpxxdUJGuESga7WobrXcDPlJzQ7G9UCa6u4cihqEKswcHQoy/9hBsgqQB3qx
         qKqovjGjg4fkxJqX6D1EhV1fjYoKgTtMpnyDUgsRlzrml0XmZ8eMKY80J7iwDStlkCvG
         dfVpyMjyWo5B0CrkjR+qFM6Aq6cNQqVAz1rM/H662t9cB49kg+x1Mp8aYCFUTGyf8grG
         IV/oNnLvufloT4rg3YojDwYbCr0d1EDu+S4CgHWXRNyHzPpUn8d8WRtj5tw2pTsCE/kF
         IqNLOyBufzo458DOB9co9c8HgVpNvItHj+WPNxwpjDPnpMoVk5JA6NlPa9EXI58FySDN
         g/Hw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8AR/oGm+1x7gl8w79R2poEmrsFSXv/mvm/jWOiQi0qB1F5Bac/l1J8L/7xnVFX54lrbU=@vger.kernel.org
X-Gm-Message-State: AFuF++k1gVazLFhaP2g2vJR42EeBlCnvBvx70f85KdlFQ5FgtYc0ODT+
	qq04b18/1kSLvD4uEawuollJ2Mp7I8xBo6F28ls+lHkoy8oVD2DRLD1L
X-Gm-Gg: AR+sD13QC6CUEs9Mkz3xXwehUtgkUSuwMt1nAfRxaD4uHpPngBNOKxE4mgDbyMlotUh
	PVg5LWXgiEFh4MgpHK+TbX+mMj27DRG9dCNWN7AJdLmyo7JhKM0SEXUu4RQ9i8AerHAIOdsmKur
	FOgkPb4dABt5m/JFW9FERyIbKnSoQK1sCMytJZONACnIpxrAkIfXe4DyAVD2SpPpM5QcDlGfm1f
	EC2mYJ9/hKnDiFWycGWb7Q2kXGAvAjn2UnPQU+KeE2a3b1VFbRNeuFi3+IAXcBX4klv2iD4Mhzv
	Wfr6BFBrNzkhuzpoGNKwffyxxu6zSl3nxE9mWUVtHLtiSS9QQhaKcBQB55+d4nsgN1wvazAoUR/
	alfJSuW39DBmCNe+O0Iq0TqO8qz1j3W6dvSAmPe+VNvOeMrUBjQPcFBuokzeueht0w3UCGg+6+P
	DXrZumbXutQoWFi8oIUOzJ+YGjUNfFY8FlbkjU14DP6oP5B1iIvHJwpZ1B+k0IW3kmFg5OLH+Pb
	t3szRWHI/youFdj295m5GCb32syhSc+NIzQzSl8fzWP5w==
X-Received: by 2002:a05:6a20:258e:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3cd4bbf65a8mr36946123637.16.1787596180076;
        Mon, 24 Aug 2026 11:29:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm27027765c88.10.2026.08.24.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:29:39 -0700 (PDT)
Message-ID: <6a991c643d475d77d0b5f478d760429eeb5dd554.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Rewrite "rX <<= 32; rX >>= 32" into
 "wX = wX" to keep linked scalars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 24 Aug 2026 11:29:37 -0700
In-Reply-To: <bd05af85-eedf-4749-813d-452fecd2bcbe@linux.dev>
References: <20260821042837.2786719-1-yonghong.song@linux.dev>
	 <f97bb12895dea33aa8f79b0468b5ada81510cc9d.camel@gmail.com>
	 <bd05af85-eedf-4749-813d-452fecd2bcbe@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-22 at 09:47 -0700, Yonghong Song wrote:

...

> > > @@ -15878,7 +15886,12 @@ static int check_alu_op(struct bpf_verifier_=
env *env, struct bpf_insn *insn)
> > >  =C2=A0						insn->src_reg);
> > >  =C2=A0					return -EACCES;
> > >  =C2=A0				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
> > > -					if (insn->off =3D=3D 0) {
> > > +					if (insn->off =3D=3D 0 && insn->src_reg =3D=3D insn->dst_reg &&
> > > +					=C2=A0=C2=A0=C2=A0 (dst_reg->id & BPF_ADD_CONST) &&
> > > +					=C2=A0=C2=A0=C2=A0 linked_base_fits_u32(dst_reg)) {
> > > +						dst_reg->id =3D (dst_reg->id & ~BPF_ADD_CONST64) |
> > > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_ADD_CONST32;
> > This commit consists of two parts:
> > - a special case for wA =3D wA assignment
> > - a rewrite for `rA <<=3D 32; rA >>=3D 32;` pair
> >=20
> > Could you please split it in two with separate selftest for each.
>=20
> Let me explain a little bit more.
>=20
> For these four insns
>=20
>    3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(=
id=3D1,...)
>    4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=
=3D0xfffffffa)
>    5: (67) r2 <<=3D 32             ; R2=3Dscalar(smax=3D0x7fffffff0000000=
0,...)
>    6: (77) r2 >>=3D 32             ; R2=3Dscalar(smin=3D0,umax=3D0xffffff=
ff,...)
>=20
> Eventually, the above insns will be converted to
>=20
>    3: (bf) r2 =3D r1               ; R1=3Dscalar(id=3D1,...) R2=3Dscalar(=
id=3D1,...)
>    4: (07) r2 +=3D -5              ; R2=3Dscalar(id=3D1-5,smin=3D-5,smax=
=3D0xfffffffa)
>    5: (bc) w2 =3D w2               ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=
=3D0xffffffff)
>    6: (bc) w2 =3D w2               ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=
=3D0xffffffff)
>=20
> insn 5 and 6 are the ones to be changed.
>=20
> Here:
>=20
>    5: (67) r2 <<=3D 32             ; R2=3Dscalar(smax=3D0x7fffffff0000000=
0,...)
>    6: (77) r2 >>=3D 32             ; R2=3Dscalar(smin=3D0,umax=3D0xffffff=
ff,...)
> converted to
>    5: (bc) w2 =3D w2               ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=
=3D0xffffffff)
>=20
> This insn
>    6: (bc) w2 =3D w2               ; R2=3Dscalar(id=3D1-5,smin=3D0,umax=
=3D0xffffffff)
> is not really necessary. I put it here to maintain existing control flow =
graph.
> Previously for insn 6, I used "goto pc+0" which will be removed later.
> But "goto pc+0" has some impact on verification as it added yet another j=
ump.
> See bpf_is_state_visited():
>=20
>          if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
>              env->insn_processed - env->prev_insn_processed >=3D 8)
>                  add_new_state =3D true;
>=20
> Here "goto pc+0" may impact for some programs. I didn't investigate this
> in detail but probably I should investigate and fix the root cause.
>=20
> Alternatively, we can rebuild the control flow graph by removing insn 6.
> I am just not sure whether this is worthwhile or not.
>=20
> > Also, could you please comment why the special case for `wA =3D wA` is =
necessary?
>=20
> The second wA =3D wA is not needed. We can remove it and rebuild the cont=
rol flow
> for it, just not sure whether this is worthwhile or not. Probably yes.

I understand why you insert `wA =3D wA` twice, the question is about a
special case for `wA =3D wA` in check_alu_op(), why would you need
additional handling there specifically?

> > Is it because assign_scalar_id_before_mov() destroys the link:
> >=20
> >    static void assign_scalar_id_before_mov(struct bpf_verifier_env *env=
,
> > 					  struct bpf_reg_state *src_reg)
> > 	...
> > 	if (src_reg->id & BPF_ADD_CONST)
> > 		clear_scalar_id(src_reg);
> >=20
> > ?
> >=20
> > If that's the only reason, is it possible to extend existing wA =3D wB
> > logic instead of adding a special case?

^^^
The above part is still relevant for the question.
