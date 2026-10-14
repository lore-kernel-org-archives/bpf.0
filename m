Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78322411A02
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950250; cv=none; b=KGW3vV9p/SPOBlMdY0SCcKxaZmFpZDRwIQspehgS+JZxlj+Uxfk9cL55gFkjtoF7vOyqefZUGJg27wCNAP9swWTe2YoJz8/u/OgAW7d5vxB9d3ExcnRh8IfTmLGeVp2bn9e1LeGz+Fxw5WO4Az9cee1hdQNaI/EPsH05HV3McXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950250; c=relaxed/simple;
	bh=MLwF7pW89Z10Z3ijbuJAM26nNg92PmXPvXeN31R4Ceo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWfskTOvERDi7IyKcB85cqp+yfec5KYzUv2oLrGau6tsTLjVGHu6n+zGOAFC3FIpHu+jv+jp0tIh5m086sW40zGgcFuVCnF6hdrWIavCcNe2/boc4faaO+9OBAvzo9MG3K+VJzkGYU+lsq867PeGXiSlMoSeG7G+usv4IEsGeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plThjvKC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plThjvKC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2df8c28a0b1so17498105ad.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 20:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791950239; x=1792555039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k0bTkD8K8xUoPPDZx50q45dONTFFqUAwdvOQtIhdOcU=;
        b=plThjvKCMI6gYCbCA+t84mjBuLus/VAA0OmbQzMrgmXGoW0Kb8bgx8pCCvWhVYbNHH
         0Bbyqp0PaS1pqzVTqmqIhEPgXpRoaxD8SMNiIuiEldGltXSAZbkbEN6I4Au7HUaifA38
         t+FLQ7QOpA118Rs3SLWTBa3JX+qAD7X0MiMYett6jAsR/Oos6ITXsmIf/Z7xmukUGJ+P
         CC6Cwg6/SMYlbaSqtPITsUslLDbVePvbU6+X8NThilg/jLN3XkM50eAw/zBNUNQIIvPb
         JjGh17YgLmVNQ+cpBubviWUYmVho6mkBefTtDL0CShlZRq7pSOIBrPofm73SmKTfXwy4
         XXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791950239; x=1792555039;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0bTkD8K8xUoPPDZx50q45dONTFFqUAwdvOQtIhdOcU=;
        b=vbYhivDixbNbAGBLYObVtCvvhD1aJQQK/cSAJSRuiqvnV8cK5X95d4MG/m7f8SWRXb
         xqMdcJ9oYGNKAoeh9g68fpTP7R6zcZv0lZgX68QLUEm8Mfgrpgnka76rrGxsix7MRASH
         RnitIomFOlNaFwTbf06tuUlViRBw0pfw3Hen90B1EINk5198B4Qz0ocuzW6SB0SgAc7w
         6qewP6O8GZoi3ItBuSvuJlTg2D5d0YXbU4IYLiZNIWxpPck58UQF6L2iBQ1Xm6yi48dK
         suTpBpRi4uy5DHtuuH3TZsAN76fWoOmLpl2Jq0Y55cDMniGglafz0MguEnoJl47Faupu
         jrvA==
X-Forwarded-Encrypted: i=1; AKwUvBz54YL3hAuRVXxGS+4C+WvVcjreaCmQQ3/5ShUKVHyWD3ufMspeZwl2Egp0Axr5d2SD33c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI66+F//XjGLCuZ0kyIXhC1omkU6F30p/0K7AYWRttlrnBzfQkY
	tUepLO7j6oC98WZUeqzzLugqMo2b2hVKaPyNcJiS5/5kS1bLJO2YcC5dOYJWZQ==
X-Gm-Gg: AYBFou3DAzYHNvblcyi6Zgb0P272JgZrumWT8HPH78Pg60HH28CJ4ImidrHQHyBX2EV
	Yjj6C0plVv2qJ+MKdzB1J/jeabQ6jz5998MAijLpZ84EHDvvrxeGhy2lbl1Q609L86TzD6LqRYU
	j+PwcDhnSM3G/WrDKFLti7ZLiCskifzWL5EzuQTvpKR3HpcaV0voh6b+7QQ1ZwRozS0Ngr1VQ9K
	h4qBGgUluvXsrrqzjVUkdbKOY9+T5yyJN7IEfA8/6zQxvQhJk+DgHKAAuKBxqUaGQ+LeFz+vrAH
	uVcn4j735+6k9RY2zRb55ZNxNzDIQZ0JwcAYilbisZ2SWDnzb0WW2Le/c/1YXIrON8SxcPG5gfY
	R8ojC3fyk0znHO7G8KhK0VVAoWir8qhkQGMQAHmq7ZRThSUu+JP990b20+s+POebqvJXy0e8GEf
	bJ2zwzJSgS5pjZ9wTZvq5D0XWLRTR2+1nxrtUHbiJ6ar0+QTOboc///JzKmnhiwpJgTcxiYrrn9
	m2BlqwmyL8m6d4ibovxoNkFSg==
X-Received: by 2002:a17:903:2309:b0:2df:3b0c:a6a5 with SMTP id d9443c01a7336-2e8427f7723mr117547495ad.9.1791950238609;
        Tue, 13 Oct 2026 20:57:18 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dd5sm65898635ad.55.2026.10.13.20.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:57:18 -0700 (PDT)
Message-ID: <2f19a48d9b2026fb5867d0f18ec3858f0169feb7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/9] bpf: static subprogram arguments liveness
 should use BTF type info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
	yonghong.song@linux.dev
Date: Tue, 13 Oct 2026 20:57:16 -0700
In-Reply-To: <DM21MY4LE3MC.RAS8LM9O12RE@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
	 <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
	 <DM21MY4LE3MC.RAS8LM9O12RE@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-10-11 at 13:29 +0000, Alexei Starovoitov wrote:
> On Sat, Oct 10, 2026 at 11:21 PM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> > @@ -8829,10 +8828,13 @@ int btf_prepare_func_args(struct bpf_verifier_e=
nv *env, int subprog)
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> >=20
> > -	err =3D btf_check_arg_slots(log, tname, is_global, slots_used, sub);
> > +	if (verifier_bug_if(slots_used !=3D sub->arg_slot_cnt, env,
> > +			=C2=A0=C2=A0=C2=A0 "func#%d argument slot count mismatch: %u !=3D %=
u",
> > +			=C2=A0=C2=A0=C2=A0 subprog, slots_used, sub->arg_slot_cnt))
> > +		return -EFAULT;
> > +	err =3D btf_check_arg_slots(log, tname, is_global, sub->arg_slot_cnt,=
 sub);
> > =C2=A0	if (err)
> > =C2=A0		return err;
> > -	sub->arg_slot_cnt =3D slots_used;
>=20
> [...]
>=20
> > +		/* BTF validation guarantees FUNC -> FUNC_PROTO. */
> > +		t =3D btf_type_by_id(aux->btf, aux->func_info[i].type_id);
> > +		t =3D btf_type_by_id(aux->btf, t->type);
> > +		env->subprog_info[i].arg_slot_cnt =3D min_t(u32, btf_proto_slots(aux=
->btf, t),
> > +							=C2=A0 MAX_BPF_FUNC_ARGS);
>=20
> Consider the following...
>=20
> arg_slot_cnt is not only for liveness.
> bpf_in_stack_arg_cnt() is derived from it and it has to be in sync
> with sub->stack_arg_cnt, which is still set by btf_check_arg_slots() only=
.
> For example:
>=20
> =C2=A0 struct with_ptr { void *p; u64 x; };
> =C2=A0 static u64 f(int a, int b, int c, int d, struct with_ptr s)
>=20
> nargs =3D=3D 5, so the first btf_check_arg_slots() does nothing.
> Then btf_prepare_func_args() returns -EINVAL on 's' and
> the second btf_check_arg_slots() is not reached.
> Before this patch arg_slot_cnt was 5 and r11 + 8 load in f()
> was rejected.
> Now arg_slot_cnt =3D=3D 6 and stack_arg_cnt =3D=3D 0.
> The load is accepted, bpf_jit_supports_stack_args() is not checked,
> and bpf_out_stack_arg_cnt() returns (u16)(0 - 1).
> x86 JIT emits 'sub rsp, 65520' in the prologue of f().

Valid point, thanks.

> This scenario looks bad enough.
>=20
> Also btf_arg_slots() returns (size + 7) / 8 for a struct of any size.
> BTF has the source signature. The compiler passes 48 byte struct by
> reference or promotes its fields, but here it's 6 slots, so
> check_outgoing_stack_args() returns -EFAULT and the prog is rejected.
> It was loading fine with this subprog marked as unreliable.
>=20
> Why is this rewrite needed?
> prepare_subprog_args() was calling btf_prepare_func_args() for static
> subprogs already. When it succeeds arg_slot_cnt is exact.
> When it fails the first call marks the subprog as unreliable
> regardless of what is in the registers.
> So the liveness.c hunk alone should be enough?

I guess I over-complicated things unnecessarily.
The problem was with prepare_subprog_args(), which I initially
modified as:

  /* Prepare argument metadata for liveness; the main program is handled se=
parately. */
  static void prepare_subprog_args(struct bpf_verifier_env *env)
  {
	int i;

	for (i =3D 1; i < env->subprog_cnt; i++) {
		if (!try_btf_prepare_func_args(env, i)) // removed `&& bpf_subprog_is_glo=
bal(env, i)` here
			/* Keep all argument registers live if the prototype is unavailable. */
here ->			env->subprog_info[i].arg_slot_cnt =3D MAX_BPF_FUNC_REG_ARGS;
	}
  }

The MAX_BPF_FUNC_REG_ARGS was too pessimistic.

However, I think the following is valid and sufficient:

  static void prepare_subprog_args(struct bpf_verifier_env *env)
  {
	for (int i =3D 1; i < env->subprog_cnt; i++)
		try_btf_prepare_func_args(env, i);
  }

No fallback is necessary:
- if btf_prepare_func_args() succeeds, arg_slot_cnt and friends are
  set correctly;
- otherwise, the subprogram is marked as unreliable and detecting live
  parameters from usage alone should be fine.

I'll add a comment and respin.
