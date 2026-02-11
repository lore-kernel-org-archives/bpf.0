Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2172DE6F5
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851661; cv=none; b=MX5mtMjXeg6rnxJBQHxIDrIeCLZtfpfXtnMEtrzwHSG6PNtnBxcyYFNxjzH4v9/ozHZrimeEt6eH6MYxnF6F4YuIE6NxMurvfzn3MQl4wnUpmWiFwUyxOWWhYQxf8aKRahbLa2wBr0XTiRvrhFW8AZ1nz2MOB0eBoGjT5oz+5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851661; c=relaxed/simple;
	bh=mNY46Z5NwUqa/LsAeYdOvZ4ZewZR7lrdTh9C2Oik/rY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFflnls/GnnuPC3NsQHHLz/YCN/hjRx/ndu/M+hHDvFecuEvQSyE3NgEG3U+YpIRn3bQfru2z/NHhOEXO64I2iLRl2jBcOwOVRtyVRL5f+jUEnqM6083RiR5seGyGs1wlxQk7ny76s8H4tvHbxCUWBYh8t5SVAmq7uP/k7asICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLrJXQxI; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLrJXQxI"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso4044945eec.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770851659; x=1771456459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9U2OF8tWyqxDMQX8CyrLDJEBq7RWNkeDXjJK0GZ6CU=;
        b=NLrJXQxIG01eN1mL8MetcYKIsWm7SMk8LmDPB3vfMoebBS/ou8AEbBU8ig02I1OZTP
         ZsoXRZASLx8TVUPkvARgfl2D/uL3Lq1kHTddHvtRllGp801DadmDZBAYpWqPwwAALVT3
         3FlY+kMPID4dtFXburTrcB1uU/Qt3eXBv0xDXRt5xRmY4faaHmB9XOsnTxs9lPkfTzkh
         ZZQIF2ZoA7DZ5/Sq27cadBS4djnBVsqM/FnSOYR15O4tGVvdWAzKS/I4hRIED/L0/0HF
         aqOEbM/Wu7YRJvde7Zh6KnxFvOTjS8rTglLB1mo4h80cAkS7Uax30sGssZ+XJg1D9Eon
         +xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770851659; x=1771456459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9U2OF8tWyqxDMQX8CyrLDJEBq7RWNkeDXjJK0GZ6CU=;
        b=czGIQSPw4jJP+QBE8kcVoOXuX4tJgw0cPT7q8Z2S2iQb0VMjkN98XNVzn/M9pV04tz
         u/AmwVRVQxo6aafBlmPFYjYYj2KvZGBsW9/R6jsbOygoIBPtFbmPGEz+geuaPnHp4JSw
         uKmlGEKdbqTuiGj70Ssj2c9uMcgmLZMTn+nXkkNzvCc46ajqZ6vElzB7HfnU7cobN1D/
         fHbn8pMcmXJzFOxvYWKquAkunQNePmRGe6KwMxvnQ9YJNyHZxIoZXX5kpxKwnI3GHTbd
         WhP2bGl1fgaqV/bF5xbyQzq3JVykCuLAALl3oRnjWapI/xdI1Lx6u5h/8C0PJWfkBTi+
         vG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtNJU1lbKhT7blSS4rL9VyX6KvohWg1la9XsKDH0N5Da40cjW2Ar8pGw5ADWIx2pkO4g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYGBVhOxljCO30v898g5UC1TZCqn3QquaV4j8E85U2OoVxIw0
	/DAv1Wi14TNelR0ANUc59BKZeE7NqFucZw2mP2XIixIla1WiOUTdd0kpm6U2Dnqp
X-Gm-Gg: AZuq6aJA6InsuCNkqKqRF3XiIASRt/2ZsTDOvHT2xAdM1bJ92A7dY20O2+13Yx2gID8
	P9fDGhsCc4Qk2nUOWa/JtFXvZn5cgQlm46IOQNnweUHFrtkipBD9wlRFXZKAMDIRkoEx/tcMKqq
	EPtRAaxMxB3syzjKcvdyRFVJ+q+o8l69ZMPP5/gMwAIEa49sCqLQENcMxrwzvAae8u4Z/zyRGYT
	j4JZIUJjT0I4/A2lOTdznB2dWdD48EMqaO3ZJlwVkFFdDmkd7E04Yn8DhymrdJp7GCVBWzlLc/o
	vk9yaWGTbUIo2TjxeJ3wDXyYza/X+IYHlGNgxS4jS+5HZhDI1TMWknNLb7tv7qeiewFNhKIBXWP
	+a5R2q7GNeoFyDQjWESLQCxPEW5AYBoyT5H3Vp90gQmnN8tRlHwZpn7HrO+zjZi1S9KmaJGh81d
	5mlooE/a9n2q6nBWfRW+Y6Xt1mQJ9B3phYrPWO4AQH2V1/hGE5nMagC2mASV9kqD6Y0lvaKLaKg
	ElKuhKU
X-Received: by 2002:a05:7300:7c0f:b0:2b8:26b8:3426 with SMTP id 5a478bee46e88-2baa7fa7375mr571230eec.13.1770851659217;
        Wed, 11 Feb 2026 15:14:19 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dcec:934f:b709:a0e3? ([2620:10d:c090:500::2:8141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcfe6b7sm2824327eec.29.2026.02.11.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:14:18 -0800 (PST)
Message-ID: <87f0621428b98fd34bd13673509fa58b5f33249a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: rename bpf_reg_state->off to
 bpf_reg_state->delta
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Wed, 11 Feb 2026 15:14:17 -0800
In-Reply-To: <da7183b4b0da3ec7ffe00c05a471098ea1eeb655f627d061baf5776d203677a2@mail.kernel.org>
References: <20260211-ptrs-off-migration-v1-3-996c2a37b063@gmail.com>
	 <da7183b4b0da3ec7ffe00c05a471098ea1eeb655f627d061baf5776d203677a2@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 23:08 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -40,7 +40,7 @@ struct bpf_reg_state {
> > 	/*
> > 	 * Constant delta between "linked" scalars with the same ID.
> > 	 */
> > -	s32 off;
> > +	s32 delta;
>=20
> The NFP BPF offload driver still references reg->off in several places:
>=20
> drivers/net/ethernet/netronome/nfp/bpf/verifier.c:
> =C2=A0=C2=A0=C2=A0=C2=A0nfp_bpf_stack_arg_ok() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0off =3D reg->var_off.valu=
e + reg->off;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_off =3D old_arg->reg.=
var_off.value + old_arg->reg.off;
> =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0nfp_bpf_check_stack_access() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_off =3D reg->off + re=
g->var_off.value;
> =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0nfp_bpf_map_mark_used() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0off =3D reg->var_off.valu=
e + meta->insn.off + reg->off;
> =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> Where reg is const struct bpf_reg_state *. Was this driver intended to be
> updated as part of this rename?

This is a valid point, the driver should be updated.

> Also, the comment block inside struct bpf_reg_state describing BPF_ADD_CO=
NST
> still references the old field name:
>=20
> > 	/*
> > 	 * Upper bit of ID is used to remember relationship between "linked"
> > 	 * registers. Example:
> > 	 * r1 =3D r2;    both will have r1->id =3D=3D r2->id =3D=3D N
> > 	 * r1 +=3D 10;   r1->id =3D=3D N | BPF_ADD_CONST and r1->off =3D=3D 10
> > 	 * r3 =3D r2;    both will have r3->id =3D=3D r2->id =3D=3D N
> > 	 * w3 +=3D 10;   r3->id =3D=3D N | BPF_ADD_CONST32 and r3->off =3D=3D =
10
> > 	 */
>=20
> Should this comment also use r1->delta and r3->delta to match the new fie=
ld
> name?

This is a valid point as well.

I'll wait a bit before sending v2 fixing the above issues.
