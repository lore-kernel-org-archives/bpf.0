Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACDA3B530A
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414447; cv=none; b=XswsM3i5TO/YSjBtxYcILN7mzky1Zwh4khb8apqMnSKHxuIsBe4fNv6+aWwkkS3kIX035zV5iUKE+lDxsFwHsStQDxLGalksNqplrytvL1HMYsw2X1TYBQuSLKs5iv5l7j0LD7d/lVqjReoi7nnDMv2dI0lG4fPYIIQbADbncRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414447; c=relaxed/simple;
	bh=VQorOmHFKimvo6Op2ahUJT9ej+LVtwpl6JCEvVwj/WI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osEi8ws3xoQgYtm3eeb9QIfbgu6poCbDVzvNM3wnc27xi4rTbnfsgXBZxC3XsbOHDc4J0rNcMvYcgGSD+Dxi3Cx8kcUZ2XiEoQXBPmRh4f9YRrVNXIOxETohJGvLkLIA+Y/Vz9gep9epagfDCJeHrzX2+DmGPTE+tA1DlJuHong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRN5oNke; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRN5oNke"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so2909826b3a.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789414440; x=1790019240; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5G8dB+x/qzZSDP+mqYf3/tsmym8WtXftx0zXwYglxzs=;
        b=YRN5oNkeZJ6OnhSwwh9ohkDxEoer8KTj80hyOcMdQyFce0L6/gykDqy3MCWmlb3FRj
         fwn5IZdLJNlXSdRNgFhM4QnuZKBw5/0/NG7n9sGn2S7pTKY/VlAUn5RWJ4lUelUG3vVQ
         GjlzmFKr/3tdqC1+kPyPceSi2vFE9/LDIITbpT0PMAg4Px4aZn24iObaX34eDkNlVoqb
         tA3SI2uIhY+ehvNvqGoPywRLjbDTpZx+B905QIMcNVG7PbOuAF3QNGqBMSqSzn0lNvaI
         QnrRB5rnBqJnjFp9VzyJnxb8aBWr8jRaDE6vayoIneX/pnd/CjBNHG5uU6KLdlfj2+k2
         S0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789414440; x=1790019240;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5G8dB+x/qzZSDP+mqYf3/tsmym8WtXftx0zXwYglxzs=;
        b=aJ0tMCTZe2owRP2onScuxDwLfv3jXeYJzZ5Iy0o+Iz2QP1v9ixxrGSN5qvDXUu8Aof
         zMGfaC7FX5yP+MPdqGV8VdrciP+/vzd8bphsTnCZXL3Cbj3QE0HW/9VeDA/z6AJh910E
         ElUhDGIzR4WnZVLcIVsYCHZPKI7yCieCfA/Skqztl5e404Ntq9f+MEl5vznlHXY0Cm+c
         2z+4tDTKVTHSvchSBB1xMl0nv2ID8N/c0HgldJdynzE2mjj+vewyn9pJRiyc15ek4mFi
         bYDrbs3X7cM4miOJ/7XVfaKiiTkQ0x/7zZnXxmI/4F2IoYo2dq0u3vm8Vl/BQGOTO9Ql
         OJjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzy/qXkp+4hOXVEuJrV3wLgqjPpCr/mP/SvqJ8ss5AFhR+eZpPfpjrM0fbzZ65GwgwCuiE=@vger.kernel.org
X-Gm-Message-State: AFuF++kVyDx54rSJfrS9oKikD8oceN3TiQO2Ygfzyo6P6I30sfYCK1aW
	ub0HQkc4YvLDPA9S0tJnT63jiD/P7wbB6gIOHm8tLXGafbRw172KWuHs
X-Gm-Gg: AYBFou0xRAP1iLr/Mm5MIeSrOJQ4S/kowFGkeceQr/Ro9O2ifyEOitRabtbWCG+8QMA
	bNTZ/Jek54Q4XN2MOgAGtDVUN9aS6sN0kwpUUvi0u6ZwTNFMDjHw7HjhT4Y2oXQP61rqgb9DLS2
	lj44y8x1MDg5W8/6/R8/+x5t66+DyqOER9+xXuM0u7MNZa2QACjmYtJvMlwlh25LQZ5AYpELCOd
	OiZG0gk2/++40IzcKxAUKdUIwJ1lXDA/AwMEiArDWBirFUhCn0zB1dzzGgeCBfgQxaW21bPeWhf
	7AKnFhT6q9LH9/N2WsJ9Rz6kwNzG4VN5LQ1UKypR/U4rGBP8MdBFvAwFNPDdICoOeaKs4YjTBCI
	cYy+0XGGk2NKh2EdSvxvRxGf6U5TlE4XF+DIFP7yMjIbtY9RWEVVu5m7d0R2a4wTt/X3joUWAd8
	qgR7pYF+xUNapVOJ6YzeTmsRMt02dYL1+OdD0Gp9oAon97vPD76yhD4OrAckUnRmGLErCZ8k5kY
	mUhjRSkbWHQb25yuBERqGNm9Yc=
X-Received: by 2002:a05:6a00:950b:b0:857:72ba:ff11 with SMTP id d2e1a72fcca58-86f864bd1e1mr9504198b3a.25.1789414439705;
        Mon, 14 Sep 2026 12:33:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b28cd668esm5232291b3a.21.2026.09.14.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:33:59 -0700 (PDT)
Message-ID: <e1f1e90cf0c461bd2137cd64edc0e24806045e88.camel@gmail.com>
Subject: Re: [PATCH bpf v3 6/7] bpf: Assign lock identity to callback map
 values
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Mon, 14 Sep 2026 12:33:56 -0700
In-Reply-To: <20260914131701.2529725-7-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
	 <20260914131701.2529725-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 15:16 +0200, Kumar Kartikeya Dwivedi wrote:
> A nested bpf_for_each_map_elem() callback can unlock a different element
> of the same map:
>=20
> =C2=A0 static long inner(void *map, int *key, struct value *v,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct value **outer_value)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_spin_lock(&v->=
lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_spin_unlock(&(=
*outer_value)->lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0 }
>=20
> =C2=A0 static long outer(void *map, int *key, struct value *v, void *ctx)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_for_each_map_e=
lem(map, inner, &v, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0 }
>=20
> Both callback values currently have ID zero and the same map_ptr.
> process_spin_lock() compares those two fields, so it accepts the unlock
> even though the two callbacks can receive different map elements.
>=20
> Assign a fresh ID to every callback map value in the for-each,
> timer/workqueue, and task-work constructors. Copies of one callback
> argument retain its ID, so locking and unlocking through that argument
> continues to work. Distinct callbacks also get distinct IDs for
> single-element arrays, including inner arrays sharing inner_map_meta.
>=20
> Preserve map_uid for every inner-map lookup and compare it through
> check_ids() during state pruning. This preserves relationships between
> maps, keys, and values while allowing equivalent states with different
> lookup IDs to match. It avoids field-specific rules for when an inner map
> needs an identity.
>=20
> Move map_uid out of the metadata union and next to the other IDs, so
> register comparisons can use the existing memcmp() ranges and remap the
> IDs separately. Clear it when resetting a register or converting a map
> lookup result to a socket pointer. Shrink frameno to u8, which is enough
> for MAX_CALL_FRAMES, to make room without growing bpf_reg_state.
>=20
> Fixes: d0d78c1df9b1 ("bpf: Allow locking bpf_spin_lock global variables")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

It appears all map_uid has to be reset are handled.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddba53eaa333..ab4f0ea2647b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -1925,17 +1926,18 @@ static void refine_map_lookup_value(struct bpf_re=
g_state *reg)
> =C2=A0	if (map->inner_map_meta) {
> =C2=A0		reg->type =3D CONST_PTR_TO_MAP | maybe_null;
> =C2=A0		reg->map_ptr =3D map->inner_map_meta;
> -		/* transfer reg's id which is unique for every map_lookup_elem
> -		 * as UID of the inner map.
> +		/*
> +		 * Each lookup gets a unique ID. Preserve it as the inner map's
> +		 * identity, since different inner maps share inner_map_meta.
> =C2=A0		 */

Nit: old comment is better, imo.

> -		if (btf_record_has_field(map->inner_map_meta->record,
> -					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
> -			reg->map_uid =3D reg->id;
> +		reg->map_uid =3D reg->id;
> =C2=A0	} else if (map->map_type =3D=3D BPF_MAP_TYPE_XSKMAP) {
> =C2=A0		reg->type =3D PTR_TO_XDP_SOCK | maybe_null;
> +		reg->map_uid =3D 0;
> =C2=A0	} else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP ||
> =C2=A0		=C2=A0=C2=A0 map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH) {
> =C2=A0		reg->type =3D PTR_TO_SOCKET | maybe_null;
> +		reg->map_uid =3D 0;
> =C2=A0	}
> =C2=A0}
> =C2=A0

...
