Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F3388E5A
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620180; cv=none; b=jLnwQlTUTM3SOYZkAB3kWuL9iNzlBhIzg7UU7UxER+Uw+iF8JJMLwXXh9oLSeBwPKgCAivAEfDuzfu6dWMnm07kEiK36Eia7kMTHYl7mYxDKuaGrvdRJHS1a/LbgIceX3/ufY/p3IfIu0Inu6r8ipsEzbXYDsvCq4uZMI6MOI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620180; c=relaxed/simple;
	bh=r5NfCaDR8XuBdLS5aQzoPlC0IDF+9iTlBaiLPWCz8/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPlErFKwlbwdDdPydgUTMTT3myKi+in9TmFc4kcplAgthvRCjfRMG1Td9KWnJ7yKli4ViAubEtPVCc4mI+TYXAPR73c7Y0sADZ/F10M+faMH6cEeL9cjGHBKdjRCwfdA4/op+WgYO9SVFoNmUC1mWwvzVFNRLqGgLK7qfi+ZwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJR6lpjj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJR6lpjj"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso2515229a12.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778620179; x=1779224979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tldKA9Y19SPav5iRpI+W8dNtnr9IWxgUOCs/Hfp0DfE=;
        b=IJR6lpjjdyCKSQhGXJojJzAYSPFt+HZQp/mKQ768XaBBdWMP63J3KECcu8gv08iAYP
         LeZes9hImkVzJmXtzhtB6jv+cgO5YyDmG4e+1gRXux4F3phOrdZ3vkIk6aUq0KwBDMc6
         O0vPGaZB/QoB9eqaWIvhSuTaRiWNpjw8H65MyNa6AJ0WpYjlu8beZnQwwtdmu+kj8q/c
         Hv5sabYfyp8Yuqq0v5hMjZm2mWj+TUkDPib4gZN4QVADQFT2dq84oKrhtFdWt4o3jHum
         pPXirSu2bjdwP4SeDShgXbrvaPrqNqhq2Vve4OYqkN48RxKkHwhqBdoAQb6DBPHJqIXg
         9Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620179; x=1779224979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tldKA9Y19SPav5iRpI+W8dNtnr9IWxgUOCs/Hfp0DfE=;
        b=KXxqxzMavN3e8hRHInuBGrq5iaS1hfPzbcWZEYSPLSRnl2CBRPmygdJsRt1O+By7Ue
         g4n/gjMUBreYBQZcZvXZwXQlu5iuScoa6YhiGKq81alqQ8I0TmjbOxuUV8CnOH53jlnp
         iDbN4gj1Tzi3KmFXCH3rNNpYXaGYuQ8cmXGK2hSS660GoP7ppjtuAkFdIRMAl1BV/pGX
         OJvh2pOC6f58cbzveqUd62pWKutM9Ey84bqLhlgZ4ILMXPWHQ7dValmPn1k6xE9On+zI
         bTLfgVu+v0tev97TrxYYWkXX0dS7OfYac0zm9Km4+ffk77xzk9zgj38ILQcoZVy/0aXy
         kjXA==
X-Gm-Message-State: AOJu0Yzelg2QY9swop4re9luc4gB9UxFK60HsHnUCxBkyZ26wZNVPosK
	Jalq8G/7Zy+Rv59XsdMIAzuPeJVs0lz7V4+TwTQJ9tOS24g5WMXOcxjE
X-Gm-Gg: Acq92OG1SGm5WPQbkjAnPiaZqihudFwY0OAcjAVSHIDa2HdPHJdzTRzmNCpfZH0EvKx
	y6x5NKUeG+y4nkbqeS3Do5x1fAnozqsjLgKHPBls16yntypiz0rE4PKkYGroX7n2DV8IoVOBz92
	itYWvgHw4R0vGcBsni8X+eebgPlHyu+ZNFca9Rwl0/6bPqFHESmynzG0uXgSuXvgic0SUZgsWWj
	uG71NhkpsBp5PpjyXk8fUn44wqH08ilP462K9K3aLtNSdxnSQsD1sTMv06dkAEzVOV473j8j2R0
	8NIoXS2uZr8rgaq7Z++K/rCjhAVEeTV12NU+ncXGfYaOO0hGFass9VgUDh2yhML+P20uypdqFij
	YKPQu/iJy6dgLESP/OZ6QWFKHq7ZPGY63v/16g3E/0sRDyExuA4epS+DDA/CNkEmr+TDl4a1tDc
	BHXsU0EHAqMSNJUzl5HS4VuOQHn6Gib+ysWBsOCSQr0x+XfCUNYkze
X-Received: by 2002:a05:6a20:748f:b0:3a3:21db:8ee8 with SMTP id adf61e73a8af0-3af7fb6dd28mr311449637.1.1778620178922;
        Tue, 12 May 2026 14:09:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82675fb236sm13144528a12.0.2026.05.12.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:09:38 -0700 (PDT)
Message-ID: <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 12 May 2026 14:09:02 -0700
In-Reply-To: <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-8-ameryhung@gmail.com>
	 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
	 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> >=20
> > LGTM, a nit below.
> >=20
> > [...]
> >=20
> > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier=
_env *env, u32 arg,
> > >       }
> > >=20
> > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_D=
EST) {
> > > -             if (meta->ref_obj_id) {
> > > -                     verbose(env, "more than one arg with ref_obj_id=
 R%d %u %u",
> > > -                             regno, reg->ref_obj_id,
> > > -                             meta->ref_obj_id);
> > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > +                     verbose(env, "more than one arg with ref_obj_id=
 %s %u %u",
> > > +                             reg_arg_name(env, argno), reg->ref_obj_=
id,
> > > +                             meta->ref_obj.ref_obj_id);
> >=20
> > I think this should be reported from update_ref_obj() itself,
> > it is more consistent logically and also avoids reporting code
> > duplication in check_kfunc_args() and check_kfunc_call().
> > Also, technically the reg_arg_name() is an independent fix.
>=20
> We have kfuncs that have more than one ref_obj. This is not a problem
> unless ref_obj is referenced in the verification and is ambiguous
> (e.g., used it to tie the lifetime of the allocated memory with
> ref_obj). Therefore, it is kept at the location of use instead of
> update_ref_obj() to prevent breaking existing kfuncs.

Ack, thank you for explaining.

> >=20
> > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf:=
 Negative
> > > test case for ref_obj_id in args=E2=80=9D) since the verifier no long=
er
> > > complains about ambiguous ref_obj if it is not used.
> >=20
> > On the other hand, if you think that this property is worth having,
> > then maybe wrap the check with in some utility function?
>=20
> A utility function like below makes sense if we fold ref_obj_id into
> id. It would be too cumbersome for v3 as we may need two of this for
> ref_obj->ref_obj_id and ref_obj->id.
>=20
> static int get_ref_obj_id()
> {
>         if (ref_obj->cnt > 1) {
>                 verifier_bug(env, "function expects only one
> referenced object but got %d\n", ref_obj->cnt);
>                 return -EFAULT;
>         }
>         return ref_obj->id;
> }

Maybe just like this:

  static void validate_ref_obj(struct ref_obj_desc *d) { ... }

?
