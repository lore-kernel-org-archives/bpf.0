Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1D2BEC55
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898001; cv=none; b=o6FOBSccihvBKxjOWEqlwHUH/np96MpQTsfxE4ZgOtaHnfGwjUJ0ugbA9rOV40ebFeOuK7eudceJ0pGs3cM0dkRczE86Jld6BPVQUtk3hwQQjVM1q9Bz1f+bumRu7IUcfMtvQnk2mCQRrgfTmWZFbGjXQ3gLpUnsP3lP25sZuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898001; c=relaxed/simple;
	bh=F7TJBzFZwZLMVJ/+7nHLGSi3U67GV5N2TOeyd0Ipg54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIFeCC6SJWTauhmnBnA/hnL6MVJylPuDOXCpgfUY7RHiw0l14TR0+MMHoIC10W3+n2ZYMwhTpnwHZZ7HgyPN99R3TREh+lpYu/JoZOGIbHPBjOX+JCnJzHVtk4sHxMowvZhhESN145ul4QrWCsI+ieL2QCGBjF50IqN2QOIF4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf+BJfiG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+BJfiG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d868d014a5so5855273eec.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776898000; x=1777502800; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RSghCmV6ZXfFUAOGVeKtkj3rRXQVbd2GMNzi4ARfNw=;
        b=hf+BJfiGAk7s8ETUeNSdLf0f0Ymry+JbeaaKh74NmquXnw/DdY81EYzFyLEDtlIXYs
         Ej37jFJo0q6p3FE/raeiu894aUElR5XRHvjLloy6UYd0OHW1QNzFuHmuwkYKTynEkUX5
         /E4kYjATN2ntTWBiucJpSXqVqOHFmE1eHBLfwHDfEJcxs5UKON1h4DoUbJA9jvwAbjM8
         NgWbssooGBWYBgchFi56zB3nMxnEah08cLw1+Ol5W6gKLV8/qkLj7D38Q/M3etZYH73Z
         aLTXEhAKWvrLsZBx1XuZoCeIPmpte8RDK7J9Jo6SVx+66AS50s3+Ad3tn2M2KwZgTGib
         s0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776898000; x=1777502800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RSghCmV6ZXfFUAOGVeKtkj3rRXQVbd2GMNzi4ARfNw=;
        b=GFfOGcWo6Gus7reQ84xsmcIIBfogfBl645WVphPSwiURpPzGUauCSGtIMiaN/5tYnc
         st0wtg2YbQCc8WUjDr9xTNMvBKmW7Rm4l55p/W+Gi9ovcFg5iLfKY0kYy2gc//XMZseq
         DokkRhmQP/RrfjL8f8o4Cq6XzK7gLu2ZjJ8T0H+OfELFb73op76AD7Vzr4zkdVEjGm/1
         2we7FHa41hpoXPRZRJcmH/uCRiqwlPLqh6Djvw2g90X/RF9XqjEIhCvF+pSmPBQTMECB
         61zYKJpL5+Cg0V3ArJz4pzNpvJRB0aBsT5QL5bJKwbA/prak8i/fxGKavWdA6aKIhyjZ
         ikWA==
X-Forwarded-Encrypted: i=1; AFNElJ+KrAH05+Bvv7QIiStn5FTHIED5g2c9Yh+xUJco+pqPGWVZmOPSrNbhSxYbRm5KYCwJJHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKY57XA4SQRoQiM4aDB4v+p3OgU8eTYmWiGu2sHPHYe9HCtwbu
	yuxRJpwXZOQWwVtWGhgLpf/p6mv036Uynp7lwkt/O7r0E38EDOoy3aoB
X-Gm-Gg: AeBDiescbrRZuH3f3e01+BOKQWSS74sK3UqyyM7as4k7tM682t74UxpQ8aZ3BsC4MSf
	dxxMlMtSS9iqgxkaGYhTr431OzB8cfdwOKtpdFaNonryc9IFkPOo4qEzGV0WttIzaByzm0Vj+1U
	KqgARjEgEt8Ne85phbA86h0mdNb9982T31YmqEKSbHIqcu29b8UAWaiPHhY+NPeriorTBfJ1CJL
	RjDs+woHSWn4ADjD+ez0HSAt6wH5rsE7drIcDFYaA8rNIl6NsSFYz0jziUooJSdvkWo1iyIfpue
	NUDFM0QV/v8sKLLfwjB4P+j+96YiiqZTh1nCFu+8CVOiaEuKKO27wy2a0Dn/rYKOQwl5YaAq4S9
	EKolj5yb3qMPcs/YElrlN77YwcxdM2PKubo+wEP4BLEgVa/BPv7mbFZx9VTPZwSAQv7ue/vSvGg
	Umud+Tm3TgnTy/a03/o8i5sgQJjYMkohAqA6yPyn1rQqitjszzYwo0MQEnBobYz2P4i/y5i6S5o
	thTdukLw42AZvaU9SoU
X-Received: by 2002:a05:7300:fb97:b0:2d8:71c2:255d with SMTP id 5a478bee46e88-2e47873aad0mr11689328eec.14.1776897999473;
        Wed, 22 Apr 2026 15:46:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm33363023eec.29.2026.04.22.15.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:46:38 -0700 (PDT)
Message-ID: <9e477e253c202b10ed611213e4fc9a7017bfc51d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer
 objects after null-check
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, ameryhung@gmail.com, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com, ast@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 15:46:36 -0700
In-Reply-To: <d5679e6f2b458bb8771f83e6985247befd68fbab894a0d2a09797f0ec3a90efe@mail.kernel.org>
References: <20260421221016.2967924-4-ameryhung@gmail.com>
	 <d5679e6f2b458bb8771f83e6985247befd68fbab894a0d2a09797f0ec3a90efe@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 22:52 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 93003a2a96b0..0313b7d5f6c9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_f=
unc_state *state,
> >=20
> > =C2=A0		mark_ptr_not_null_reg(reg);
> >=20
> > -		if (!reg_may_point_to_spin_lock(reg)) {
> > -			/* For not-NULL ptr, reg->ref_obj_id will be reset
> > -			 * in release_reference().
> > -			 *
> > -			 * reg->id is still used by spin_lock ptr. Other
> > -			 * than spin_lock ptr type, reg->id can be reset.
> > -			 */
> > -			reg->id =3D 0;
> > -		}
> > +		/*
> > +		 * reg->id is preserved for object relationship tracking
> > +		 * and spin_lock lock state tracking
> > +		 */
>=20
> How does preserving reg->id interact with reg_is_init_pkt_pointer()?
>=20
> In v2 review, Alexei Starovoitov raised this concern: "That pointer has
> to have id =3D=3D 0". Eduard Zingerman responded that dropping the id =3D=
=3D 0
> check should be fine, but this change was not made in v3.
>=20
> The function reg_is_init_pkt_pointer() still checks reg->id =3D=3D 0:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0return reg->type =3D=3D which &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg->id=
 =3D=3D 0 &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg->of=
f =3D=3D 0 &&
>=20
> With this patch, if a PTR_TO_PACKET register goes through null-checking
> in mark_ptr_or_null_reg(), it will now preserve its reg->id instead of
> resetting it to 0. Would this cause reg_is_init_pkt_pointer() to
> incorrectly return false for init packet pointers?
>=20
> Reference: https://lore.kernel.org/bpf/CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW=
06UvtX3my3yNSH5eQ@mail.gmail.com/
>=20
> > =C2=A0	}
> > =C2=A0}

Bot concern is bogus here, reg_is_init_pkt_pointer() is called only
for PTR_TO_PACKET. mark_ptr_or_null_reg() checks for
type_may_be_null(reg->type), meaning that for it to trigger one would
need a register of type PTR_TO_PACKET | PTR_MAYBE_NULL.
It appears there is no way to construct such type at the moment.
