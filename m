Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7393EFFA6
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956526; cv=none; b=QZc5I8EL94Yta3xsIRJMX9/VLBLoI5plKsOBCagk9WnnBGG1QviTgJO6qH9qlREzxMweZysIT6Q/BugVM/6AtQEsky2XxmkEcgw0t2bkVyxbbcWAjtCCQDkwPcdlvBNM4XtWHsqcWuGiDIQU+OeU9/tpj1KAFrmppzoV0/UYVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956526; c=relaxed/simple;
	bh=fi2H5O/L0wXEXwRsfF6DzFqzunO4KzffYx7Bn4J6UmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtuXiFvYItb+A15vEi3+49lLXHHsW74YUFvym9hOY4fmE6hGpXgMd2paFCi5rLxxXUkt/HFwYPLoPyrIuX2+oupfQwaG/ikZh/7TTOBX2g7nndSWlApWMIVUAmDOsrZREHY2FQTzUOAcIERhzV/GxRFMfPn22RBQoEh+pCK0AUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9F65P4/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9F65P4/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2940a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791956524; x=1792561324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y3wJVoR8C+C/uFpiwT5CQlIXp56xtNDcOdEblkW29SM=;
        b=p9F65P4/2QkKyznzeVzgoHqv3DwMtV9nIrMap0ptCWouaGc7RQg9Z7753ffEaKerWA
         IAgz3/Qaqr3jbjKh07qLSibKkIURgVkFvdf19cZ/Opjf43gyZ6FyYKw+XDemYcCS/7h3
         eyxRuTsMtaUvolAM56QoiKHbLG/3qYtiq70FdX9ZlTvqNUPkXuiqKmMw9TErwsZ/QWEr
         JiYltg10qmWITIRJlNMmRxejaI2plSs4mbO6LtVdKoaz9h/aguTvCFmhwdmN/BhBeO8Y
         HsHbB/hXfiATzdwksdodohaGIFO0N5Dh5ODTAycjd+5nZTOXmDtpp8DuE4Q1WrNogjFo
         8Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791956524; x=1792561324;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3wJVoR8C+C/uFpiwT5CQlIXp56xtNDcOdEblkW29SM=;
        b=pX/Sx9o4wDAtTIk+1FzvGxLgzH1O0dWJrNGe294Fw9jYevZr0v5QOi8Lv/5dNKtDg4
         vDspkap/jRYZzbWxteFXEDKYQ8z/eOyzs/lJzGwZ8GB6Pf56BcfFUg/KAC6LVMfENijg
         keb/rSeJuVimGlWYqdVgY37j1CsNXsmmTdOCNrcQUR2WCiQnIeF6f8LL1zSuGgeLyWxT
         jsF2K8uWeu978I2pXGIV2VSPzKV2/hHP91rnmqkXo8hfzbvTio3wYXoiISgQ55iYKOKu
         yonHcLaR6zRGN06r8gxnypGiDCUERN4sFoVV5HxOcivCaabqEm++pzYeXoS0bNuMW5wo
         ZXDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxh0H94irK++qK+wgFFEoZUryibjVlMtAVGf+kKvH1Zf2ESdiGdvd0RMNNAmLZJoIWgT1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5dM+WQ0F0F5W6wuOE0iPeYdXEl4hyI3mGxUNDmch90K1MLqtv
	qTdFsDrr1W+y7+pXLbV8SS+09s/igBT/pIHV/xZ/ayCS14vaWSwutDPI
X-Gm-Gg: AYBFou2fOtrW1gOZIRw1mxBaGRZmymqRuevd3OZliDacVb9HQoH7tmue6p3Qu8/ZLpI
	6gmdLOi2uSWTGTrdkdFAzPUneSkJOnZpIwcQ8E2fpzpaLlTjZYuTbsreXZPWu5+2b1IgMC8gxS8
	r2pRkPjf0bmh2eFSUAoR/eD27KXB5CH5SdrsQbOrTqH068ojTNZppyNPY5vTItdmAvpK/JyRbb+
	bGcEQr/s108ZAWYrH+PX157rgw106sAgKEFIOBIECPkI0LzpGFsr+vgbFPfxb7sEQu++GekwW1t
	BvUs+e+XXb9eb389B3DolbsZCy7rkl2byePPsKQn3tLaOuCfHDYj3LM7coVqjYWlK2iDd5TlCC8
	pZ9HgLG1v1tAIIVN+XSErPIA3VZiod/K1heqqNkyiUBoOIEuEyfgrUag8bWDE987GGyC+L1zTzr
	6bjDA7uSPeZ5ThR1JPo+ARQbS9FlgRrTipEd0ZLJJe7/wu/JCdHALw+gahNif/QA4bSwCTJRKts
	NUY1+xCjwKs9XdZqstVVh/lzA==
X-Received: by 2002:a17:90b:2e0c:b0:3ac:7872:d1b7 with SMTP id 98e67ed59e1d1-3ac7872d292mr234888a91.32.1791956523643;
        Tue, 13 Oct 2026 22:42:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f27d573sm2962927a91.11.2026.10.13.22.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:42:03 -0700 (PDT)
Message-ID: <275c14be55e81c9c809b015cb0c5ee3099bfebfc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/9] bpf: static subprogram arguments liveness
 should use BTF type info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
	yonghong.song@linux.dev
Date: Tue, 13 Oct 2026 22:42:01 -0700
In-Reply-To: <2f19a48d9b2026fb5867d0f18ec3858f0169feb7.camel@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
		 <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
		 <DM21MY4LE3MC.RAS8LM9O12RE@gmail.com>
	 <2f19a48d9b2026fb5867d0f18ec3858f0169feb7.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-13 at 20:57 -0700, Eduard Zingerman wrote:
> On Sun, 2026-10-11 at 13:29 +0000, Alexei Starovoitov wrote:
> > On Sat, Oct 10, 2026 at 11:21 PM Eduard Zingerman <eddyz87@gmail.com> w=
rote:
> > > @@ -8829,10 +8828,13 @@ int btf_prepare_func_args(struct bpf_verifier=
_env *env, int subprog)
> > > =C2=A0		return -EINVAL;
> > > =C2=A0	}
> > >=20
> > > -	err =3D btf_check_arg_slots(log, tname, is_global, slots_used, sub)=
;
> > > +	if (verifier_bug_if(slots_used !=3D sub->arg_slot_cnt, env,
> > > +			=C2=A0=C2=A0=C2=A0 "func#%d argument slot count mismatch: %u !=3D=
 %u",
> > > +			=C2=A0=C2=A0=C2=A0 subprog, slots_used, sub->arg_slot_cnt))
> > > +		return -EFAULT;
> > > +	err =3D btf_check_arg_slots(log, tname, is_global, sub->arg_slot_cn=
t, sub);
> > > =C2=A0	if (err)
> > > =C2=A0		return err;
> > > -	sub->arg_slot_cnt =3D slots_used;
> >=20
> > [...]
> >=20
> > > +		/* BTF validation guarantees FUNC -> FUNC_PROTO. */
> > > +		t =3D btf_type_by_id(aux->btf, aux->func_info[i].type_id);
> > > +		t =3D btf_type_by_id(aux->btf, t->type);
> > > +		env->subprog_info[i].arg_slot_cnt =3D min_t(u32, btf_proto_slots(a=
ux->btf, t),
> > > +							=C2=A0 MAX_BPF_FUNC_ARGS);
> >=20
> > Consider the following...
> >=20
> > arg_slot_cnt is not only for liveness.
> > bpf_in_stack_arg_cnt() is derived from it and it has to be in sync
> > with sub->stack_arg_cnt, which is still set by btf_check_arg_slots() on=
ly.
> > For example:
> >=20
> > =C2=A0 struct with_ptr { void *p; u64 x; };
> > =C2=A0 static u64 f(int a, int b, int c, int d, struct with_ptr s)
> >=20
> > nargs =3D=3D 5, so the first btf_check_arg_slots() does nothing.
> > Then btf_prepare_func_args() returns -EINVAL on 's' and
> > the second btf_check_arg_slots() is not reached.
> > Before this patch arg_slot_cnt was 5 and r11 + 8 load in f()
> > was rejected.
> > Now arg_slot_cnt =3D=3D 6 and stack_arg_cnt =3D=3D 0.
> > The load is accepted, bpf_jit_supports_stack_args() is not checked,
> > and bpf_out_stack_arg_cnt() returns (u16)(0 - 1).
> > x86 JIT emits 'sub rsp, 65520' in the prologue of f().
>=20
> Valid point, thanks.
>=20
> > This scenario looks bad enough.
> >=20
> > Also btf_arg_slots() returns (size + 7) / 8 for a struct of any size.
> > BTF has the source signature. The compiler passes 48 byte struct by
> > reference or promotes its fields, but here it's 6 slots, so
> > check_outgoing_stack_args() returns -EFAULT and the prog is rejected.
> > It was loading fine with this subprog marked as unreliable.
> >=20
> > Why is this rewrite needed?
> > prepare_subprog_args() was calling btf_prepare_func_args() for static
> > subprogs already. When it succeeds arg_slot_cnt is exact.
> > When it fails the first call marks the subprog as unreliable
> > regardless of what is in the registers.
> > So the liveness.c hunk alone should be enough?

Actually, thinking some more, I think that the original sashiko claim
in [1] is bogus. states.c:clean_verifier_state() is called for the
current state unconditionally, and it resets dead registers to
NOT_INIT. Meaning that a pruning mismatch sashiko describes is
impossible.

Additionally, btf_check_func_type_match() prohibits freplacing static
functions.

I will drop this patch.

[1] https://lore.kernel.org/bpf/sashiko-outbox-165368@kernel.org/#t
