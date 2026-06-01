Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE1368D43
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339071; cv=none; b=QJd8huaVe9xq1aaB9Rs+VU6nbclY6VXXE/QHkmyq1cZQhS+9Szur4pEiBuPiEOwdXAS2+tjOjksIiDoIKWMk6lIhUuAuDtIu8ScAOSD2ZF0I57Y3bipuuFbQdy0RXXvP0Xv7hs4GRvpCGXCkKS9FyW4IQqITPlhA2HM4EZkafaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339071; c=relaxed/simple;
	bh=Xn2YDKU/hALnKdyfZj0NMS9tS31HLEpKBLr4PPS0afs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkhc42qUjmB4P+PoO/Op+5zE5IsODz2DG84c0FEKlxtZbo5iXuvcPNcq+q9w7/L3CYIEHmDfR8ka/bFXZYFMhZdIcxUR3ibfP1TLKCgaHK/SvbqxPkRM6NgRgvy11UhqS6tjXQ2e6PakOhqdPWPmiwNEEP237/AzefYLkjKTPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktIzA/uM; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktIzA/uM"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304e6c6464dso7832839eec.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339069; x=1780943869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZ+gRlqjaQ/zBejoK6W2WPa2MoYW6LDOokjfwYSSxvg=;
        b=ktIzA/uMZ3uq0PMd9r5P7dERohVxPYhZh5Qjxfpg+uMoQ+IbwFWyDrJWX7wdGJNAmN
         6AfkLBSyx6v+HhY185V8XwnuvyYKlQEeh33qhriDsfGhGAvFlSFAShsUdlNJFAiuZXHZ
         whfb0ab3gF1apVj90cfDToU39i7JyIn3UxqyPzhSCfxamVg2+HziWq1R2B9e6b7RQ4Mv
         t4upMCKgOlg0CoBYvT+Rj3pfTXBqf5WQpb3OXp0T1ZVjeWj2whGJ7ve7rVV9h7P5vdIf
         T8aujVB/6zhKUfiLmGBEyo/Ci9BrAs61rav5l6azdBF51wOir9kUwnuQu0C4jQ5wga8c
         w9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339069; x=1780943869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ+gRlqjaQ/zBejoK6W2WPa2MoYW6LDOokjfwYSSxvg=;
        b=dRPetELDvD2ICuN0MxHE979NL9TWVgjTV284wzkphdUa73QSUSs3ypd9pJQj4y2Aa5
         zDLRu86aQaVsN8oUlJhjMi4KRZUH4zTN3Ybn1BcYoCsd1wF+b91UJlJWsNlDy8I4ONI+
         ChzUolP1ztp83O6yc4KeocqcOac5UDP94/k/LOHSUuoK34rcwM8hIh144R4N0v1aoorH
         AMXv+PHNWMpDj1kPheNnbaK7Y1JDKL9/BKkT/41kDCKUcoZdJeloEi5jvkHej3G0PUKf
         Dni0QRjpL7m4b0Ewd7L4Ov2PdQgEC8fG44XBkHgtHNxHa4PMQUxk4VFGfO5dS8ALnWcv
         1Nig==
X-Forwarded-Encrypted: i=1; AFNElJ/MoOC28y7Y6CVX5HJCEq6VuipcVh+FLp4k13qPV49Gl6IdYXPsyg+UGYwc4fRsldXqOpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtF2dFl6KkHgXWxYH9gvrw+DJU+5m2Jhl4o8AnF/wKyVbsxbE2
	rxB87/ZXdllk6R3/IkGWMpdIDpYO2DTmyFGoxN19t7ZwUlAYvNWs5naBWjbWDfp4
X-Gm-Gg: Acq92OFMmvcdZ6wn4OJxZS8YoOWlAzHdKpzBpnCl/aK3jBbJ4JCYyJnix4Phf+YZp+c
	iOfdmRQXykNawmaXjCyAGvXX4hBvmt0a5xWqODJbI7s1EWM9iY7DcoID59gyaX4ycx/4UYlvFpI
	WfTkVAEkoUogLeYByOKSpXZNIO5J+83EP/1uoxtVyyAMrr9QrMUGgUzF2PoOfT/cAPyQajxW0MC
	xwK6m1RlJKSVgAVhenfJUuaGKj10RKlLjtj5E8O/DeGAmhn2lHr/bu4Pq5cr8CNtJgo/4LtQkRs
	KzJLb+HiXZ4n1/cjok2Y65aRH2PhJOu5PXPHXOyupcU0rs3xStoUvE3d3+OMDDAWZHyBw3TGYuq
	FfdBhVVti/HFwH9Fyd24neDkhWuZqctKFh2vug6to6QVm1oqv/e6raLcbXGEMc6Jy4zdOpS7JQX
	u4vdcEfmM1PA4krlqB1S8FdqVyZbG4jcAylG3ClaeNYrJ6TCSJdvcVmxmAQhT2XxYnFvPz1Eblp
	e4kBpesCWVsY556gp/7SQej
X-Received: by 2002:a05:7300:6145:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-304fa523a44mr6597503eec.5.1780339069253;
        Mon, 01 Jun 2026 11:37:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a0b7dsm9844592eec.22.2026.06.01.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:37:48 -0700 (PDT)
Message-ID: <e1a40461fa792dc7687b0029f3ede546eeeacbc9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] verifier: parse BTF type tags for
 function arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	song@kernel.org, mattbobrowski@google.com
Date: Mon, 01 Jun 2026 11:37:47 -0700
In-Reply-To: <20260530002259.4505-3-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
	 <20260530002259.4505-3-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
> The BTF parsing logic for function arguments goes through
> the arguments' decl tags, but does not go into their type
> tags. Add type tag parsing for function arguments.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static int btf_scan_type_tags(struct bpf_verifier_env *env,
> +			      const struct btf *btf, u32 type_id,
> +			      u32 *tags)
> +{
> +	const struct btf_type *t;
> +
> +	/* Find the first pointer type in the chain. */
> +	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
> +	if (!t || !btf_type_is_ptr(t))
> +		return 0;

Nit: do we want to report -EOPNOTSUPP if type tag is attached to a non-poin=
ter type?

> +
> +	/* We got a pointer, get all associated type tags. */
> +	t =3D btf_type_by_id(btf, t->type);
> +	while (t && btf_type_is_type_tag(t)) {
> +		const char *tag =3D __btf_name_by_offset(btf, t->name_off);
> +
> +		if (strcmp(tag, "arena") =3D=3D 0) {
> +			*tags |=3D ARG_TAG_ARENA;
> +		} else {
> +			bpf_log(&env->log, "function signature member has unsupported type ta=
g '%s'\n",
> +				tag);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		t =3D btf_type_by_id(btf, t->type);
> +	}
> +
> +	return 0;
> +}
> +

[...]
