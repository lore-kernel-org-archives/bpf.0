Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96C03D5C1D
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184746; cv=none; b=MT94xqr4Ujt7X+LGKQq91hfkvmX4juKy3c7b1zQ1+fZCVXWzeHRILzV5BUTCZ5eiePxxgtIc+ahfq1UbTzvwNtp1DTyM8DaQRS2YYV1Z8haFK3liGreGcH15G+PbNj4gMm+/kGmMpbu8UIJmA8PPRAq4AmdUPKSuhW3yaZCGhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184746; c=relaxed/simple;
	bh=rpmY80Eh8eu7bZyZWI7vW3/AjCrG0Dm8/g9AVDjL1iA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+1VnI8dRBlDcjNn8U4iwfLJLXx9b6L4TTUKxnFjKOsCOU8gKxD/ZVwR70NZAwdkjo6Wm0LGTLJy15IkrqKMoSwahG6ZzvTpsNPPpMh0f1FtVyBP3aRb+J84ifY1xz6zWm9wc+T9VBwyZrVngiR+jgmsaFrzUxmUzHv4F8Wq8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgDATMic; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgDATMic"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceb096e675so38197215ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785184744; x=1785789544; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BXyVEq/b2FV4LPYAtsaVIrdOJ6rPdn55UofAB2nsa0c=;
        b=fgDATMicKBIfsGYOVDaf8keTcr1fLn65xps3YcATzSZjpxfLib8dcBbxncIHSRbDBN
         uS87c7Ks1i0V5+6SA9AGpPJNFW4f7e5YrtSehcx5aI/DgE+HuIi2MRQWX7HCD39wTaRC
         DTVoKRdVcU8ebqydMBnKVUEiNW1Y2e3AIzWuNa0QSfvldNr3IlaaRXkdCY+6SYGVzlFd
         W9QQUppHu2vHzUqb0QfyGcdvfr+A8ZiLE5LoFmRhBp6d9D4Upymahi5bHQf6hv1SEgnu
         ZzHUEsU5xaowilMqWqaDpfke2GgffWZZW1uoyECTkVtQm6G47/jlkc00x0RcDejqyvuo
         hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184744; x=1785789544;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXyVEq/b2FV4LPYAtsaVIrdOJ6rPdn55UofAB2nsa0c=;
        b=dLEpPBwgtdrFat60XZSoA4Y3orWhXk9etBfxiA5t2BDaf2z9vl4kzEcZwjp5Y0I+2P
         5i0ANxBXpo6X93rSuSk5TMKRJgXJxP5jVeN7urXcKkhlUyJ9qom7OBjBKuFMihdAYMPD
         OsZhLMDfYmPKVNl4KVfZbLY8gMojCeJSg7wSosWTK51/U6dUlRWKrOh/Cgoo00vynn+K
         svaMWkeSosXsQooRcZV6PIc/E3BsMuoheuKsEBq6/h+ib4EdHo77cdjjG/NmFbXhtThP
         nO5xBkEKr+4ENm3UQzG8N/SfefTAh1gY6TK0CfuzL2q3HHoCw6sk0evgJmWzZS9ggkSs
         VOAg==
X-Forwarded-Encrypted: i=1; AHgh+RqjRS7ch56qF9tbZ/yJ9XqKGh626lfho1hxLP2MzIWHDsBlfmbtqEuUxOQYzhRYE5fIhXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEL1ThL/FBFfMqoSJjvzoQqPdVU6uZhsV9mbfsksaJSofyBtbp
	CHtaMbrRjxWP2X4Luvw78mlUwyitWzTfEa60mwrs32peJYKAdVhLvPHk
X-Gm-Gg: AR+sD12der68gG9zQ3IqNc8nUlHWHj9IFLQdPwKLf7QzF4erFC5Uvp9NdghaSsY7BF5
	rsOm/o1GFz2BWC5uJxWN1VzUyRyKlz5/mK02tPVXmK7qGLLp3FnFgRuqtkVNofPMsdyDn1WGlSw
	8ge4kVKWBDDplezhGVKeFKzRNLN3OWq6NZB0cmg9RxbgWapmCELr7582DuMFI4/VIaMJSEUG9Tp
	2l3xWak2+L4YFUPc4Y23q45wGhalGg4rzT2eyrg3x1bIQ5dMt+mYv22YjTYZhdWLnC2wD7DE1en
	eHixv/AY5Ms6gSG5M3es1CBU5+sidAsnSUTZd3G8LoUfyzgrXHXyGEP/9mSqH44c03UKEFdut40
	415i3tWXI/3tGqY/Q1mJJlSnTawVSIO2KAxtIzuFz07glYphkCMXLCZ9QhCBIx0MbzPzvQwH3tV
	9DaT/E6BAQ5ZnJzff/34UBKpMCVaApqg==
X-Received: by 2002:a17:902:e804:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2cfde7a73a4mr102734845ad.11.1785184743944;
        Mon, 27 Jul 2026 13:39:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbde0sm40070865ad.50.2026.07.27.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:39:03 -0700 (PDT)
Message-ID: <d8dd78c7a3d7f023ae115808cb1165f61916b371.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 13:39:00 -0700
In-Reply-To: <20260724190813.1458271-6-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> Helper ARG_CONST_SIZE and kfunc KF_ARG_PTR_TO_MEM_SIZE memory
> arguments already share check_mem_size_reg(), but only the kfunc wrapper
> check_kfunc_mem_size_reg() ran mark_ptr_not_null_reg() on a possibly-NULL
> pointer before the access check. That call does more than clearing
> PTR_MAYBE_NULL: it converts special map-value-or-null registers to their
> real non-NULL type, e.g. a map-in-map value to CONST_PTR_TO_MAP. Without
> it the register keeps base type PTR_TO_MAP_VALUE and check_map_access()
> treats it as raw data.
>=20
> Because the helper path skipped that step, an un-narrowed map-of-maps
> value could be passed to a nullable helper mem argument (e.g.
> bpf_csum_diff()) and read as bytes, leaking the inner map descriptor (a
> kernel pointer). The kfunc path already rejected the same program.
>
> Handle the possibly-NULL pointer in the shared mem-argument checking so
> helper and kfunc arguments are verified the same way, and drop the now
> redundant check_kfunc_mem_size_reg() wrapper. Both paths now reject an
> un-narrowed map-in-map value used as memory.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 468702b09c50..2e56f726c12a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool zero_size_allowed,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_call_arg_meta *meta)
> =C2=A0{
> -	int err;
> +	bool may_be_null =3D type_may_be_null(mem_reg->type);
> +	struct bpf_reg_state saved_reg;
> +	int err =3D 0;
> +
> +	if (may_be_null) {
> +		saved_reg =3D *mem_reg;
> +		mark_ptr_not_null_reg(mem_reg);
> +	}
> =C2=A0
> =C2=A0	/* This is used to refine r0 return value bounds for helpers
> =C2=A0	 * that enforce this value as an upper bound on return values.
> @@ -6910,8 +6917,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,

Nit: change the prototype of the check_mem_size_reg() to have 'access_type'
     declared as u32? As it is no longer an enum, but a mask.

...

I think there is a followup for this patch, consider the selftest
added by the next patch:

  int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
  {
	__u32 key =3D 0;
	void *inner;

	inner =3D bpf_map_lookup_elem(&outer_map, &key);
	/* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_NULL */

	/* @from is a nullable read-only mem+size arg; outer value_size is 4 */
	return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len;
  }

It reports the following error with this patch-set applied:

  ; inner =3D bpf_map_lookup_elem(&outer_map, &key); @ verifier_mem_size_re=
g.c:55
  5: (18) r1 =3D 0xffff88810813c000       ; R1=3Dmap_ptr(map=3Douter_map,ks=
=3D4,vs=3D4)
  7: (85) call bpf_map_lookup_elem#1    ; R0=3Dmap_value_or_null(id=3D1,map=
=3Douter_map,ks=3D4,vs=3D4)
  ; return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len; @ verifier_mem_s=
ize_reg.c:59
  8: (bf) r1 =3D r0                       ; R0=3Dmap_value_or_null(id=3D1,m=
ap=3Douter_map,ks=3D4,vs=3D4) R1=3Dmap_value_or_null(id=3D1,map=3Douter_map=
,ks=3D4,vs=3D4)
  9: (b4) w2 =3D 4                        ; R2=3D4
  10: (b7) r3 =3D 0                       ; R3=3D0
  11: (b4) w4 =3D 0                       ; R4=3D0
  12: (b4) w5 =3D 0                       ; R5=3D0
  13: (85) call bpf_csum_diff#28
  R1 type=3Dmap_ptr expected=3Dfp
                  ^^^^^^^^^^^
That's not the right thing to report here.

...
