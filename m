Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46A367F48
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341300; cv=none; b=oXNgrMKSUkCXFazabzitwb7yiRrJH1cmDLHuI4fDrGrXyW8w+jmNm/cKLkHz2AC+SArlek51S1knK9xadpWZZhUXoX23yVb24tP9AuM2jzwJYKrglRsKnDpGuEmMi4b8SHznHkwaJP3YbBxYCAOrSqk4DFXPYXFdSB4XUrZb3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341300; c=relaxed/simple;
	bh=RgT7LD3VTIeXCGq7jLksMG/qRlqWAMhrn/h3FQg/eGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzr03AgqDKwwF1yqmAUEmGOYN4c/GJQLb7f/CnKpvLohOsbGkGna/sRS0vw2qXcg5ppaBHOLZSkRXz9qgmYT3aU1kwtZChHH7kk6+SYY+ATeoZCqCoXh2gaYh0EIqnPtxR2lwkGFo+c+1s38avZLKcoP+Ek0kj0wDMNZRZex/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyBA5w9a; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyBA5w9a"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304df7ff4c2so2623168eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341298; x=1780946098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sqL6yanC2kTGaxeEEJNjr+S+7BIY8GQ3iuXf3OZ456k=;
        b=dyBA5w9aikBKQYCkCF6tX0NbJhVR/JZBIB3lvJc1P50/DPnCM41uvja4dppkSYc0/9
         abeXiBepxy9iLHv0sJhf1vYlXcIJTOzJWlHxFQr3rOb/ih2OzIUfl358KTuewpY9hOOm
         M0oVnYQq0F9E9RoEQJ5ePpQ/uQL55oo9/jkSxsD/5QKmOc/RpbR0IVcjS/1vCHtHb8hO
         w48iOHKgerVcGYSkBJZgSnNoPx57IpFHgWu7VhY4chr1Pd7dul70dJLnP4s5NzzOO5em
         3bry8XXceCNeNg8j0jFacHiuy22+qGLUYovmcVdXEZEhykAoSZaBagidn+2flEM5rZAI
         OKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341298; x=1780946098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqL6yanC2kTGaxeEEJNjr+S+7BIY8GQ3iuXf3OZ456k=;
        b=sJh5G1VJecey2KP2h1KZVN/4QbFY/1CmLNUk31dIzd5LpQLlnAGi5SCjMr8fEVLVeM
         LPTgMwu/qIvsyo1pI4qWBRbE47F9GoYjpuBUMXbtl9SJa5HKfgz2bbfE/FzLAMhxGveZ
         oHu6GQM8A4Go7iPWu+KYXjtdCZMbl2cy9NSP46gug6LYjVVRQJljCAEnAKQ9eoWHECbm
         c4fqHCNeS70/QJVThb27xm91x40iSVc4jRHmrxReQHc6Y4XAhcnE6tpbQlEF/6Uw3MzP
         iM0sMHJQXOgAS7DMbqlYQHn8CTNtgQtRww5S1jmYqL4KSv6qbYh/V1vf5Eotk6tldxVO
         r4FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JGapBP98jKWMNMlagi35Lc+t6UG/3w/ed25lKDoMw6VgBqTUFdTDxO7Hk3sMeH9C0EpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4MOfPnGno5ZEFYwVi4YXtTBaTpM7urwqH+lv/tBui3IDjWLD
	UmWP70bBCKlUDPe+WyNocS3WLTc/ps+rTirYG4h0rGyh9fu+BxGd+ghZ
X-Gm-Gg: Acq92OHR3N28KZS4VRIjlJsukJ8ZA2F5Qk827o0auGdvivSHGgv4wlDkn68LucQ+q7s
	Fx8ux46xEALChxcUZ2V8bmIVXQJBpquX91Swc2FmPgbW0jqOjGRL8c4io5nXUZWQjVBXEQbBKRL
	oXRjYR4hf76IbUQ3vbxPZgkg1t47DvMVOd2Ucg4Z4cxaghe7bUqICd1KHD1TzGMSpybbOM0Yr/s
	3q4haelmt0Hq237ZlTnNv8QIhzuCxesVMBkDRE4T6iND8JDNWJ00o6/FGBOCYgn1sh1E5lNEdax
	80OaGi/tYFsyvu9revsf8xuRui1bOj39g3ud0ecEST/eWo9pO6WQ3MBr1agPAYNcR+g1pLb5W84
	XrO6NnIiVCyO2Cnz09pJZ6wy+QLEcDwQ+6GrxvVOjf8WLPSQxPwLSbtjVvszxIWMBN+BVR4xG+8
	7osTHQ1lH2TcrlF/3u9HwK0QlQXQsUzxD9PaTcso1Wkdb3ZfChpFJ+yqvzoigxopCp6/WO3+kiA
	Kl1jpxyVsHmsA==
X-Received: by 2002:a05:7300:3c27:b0:304:ddc3:2c35 with SMTP id 5a478bee46e88-30734b1e25cmr433550eec.10.1780341298210;
        Mon, 01 Jun 2026 12:14:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm13024370eec.21.2026.06.01.12.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:14:57 -0700 (PDT)
Message-ID: <3729146f5f539af51a3ac716a3d39ad840070612.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] verifier: parse BTF type tags for
 function arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	song@kernel.org, mattbobrowski@google.com
Date: Mon, 01 Jun 2026 12:14:56 -0700
In-Reply-To: <DIXYAFJ6YV2V.UD8C8J22GA5O@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
	 <20260530002259.4505-3-emil@etsalapatis.com>
	 <e1a40461fa792dc7687b0029f3ede546eeeacbc9.camel@gmail.com>
	 <DIXYAFJ6YV2V.UD8C8J22GA5O@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 15:13 -0400, Emil Tsalapatis wrote:
> On Mon Jun 1, 2026 at 2:37 PM EDT, Eduard Zingerman wrote:
> > On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
> > > The BTF parsing logic for function arguments goes through
> > > the arguments' decl tags, but does not go into their type
> > > tags. Add type tag parsing for function arguments.
> > >=20
> > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > [...]
> >=20
> > > +static int btf_scan_type_tags(struct bpf_verifier_env *env,
> > > +			      const struct btf *btf, u32 type_id,
> > > +			      u32 *tags)
> > > +{
> > > +	const struct btf_type *t;
> > > +
> > > +	/* Find the first pointer type in the chain. */
> > > +	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
> > > +	if (!t || !btf_type_is_ptr(t))
> > > +		return 0;
> >=20
> > Nit: do we want to report -EOPNOTSUPP if type tag is attached to a non-=
pointer type?

As far as I understand, yes.

> >=20
>=20
> Let's do that. Since compilers can't really produce that yet that would
> only be the case for handcrafted BTF, right?
>=20
> > > +
> > > +	/* We got a pointer, get all associated type tags. */
> > > +	t =3D btf_type_by_id(btf, t->type);
> > > +	while (t && btf_type_is_type_tag(t)) {
> > > +		const char *tag =3D __btf_name_by_offset(btf, t->name_off);
> > > +
> > > +		if (strcmp(tag, "arena") =3D=3D 0) {
> > > +			*tags |=3D ARG_TAG_ARENA;
> > > +		} else {
> > > +			bpf_log(&env->log, "function signature member has unsupported typ=
e tag '%s'\n",
> > > +				tag);
> > > +			return -EOPNOTSUPP;
> > > +		}
> > > +
> > > +		t =3D btf_type_by_id(btf, t->type);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> >=20
> > [...]
