Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCE277C88
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788678257; cv=none; b=WDqBZjhyEcDySNl0UZiFl5lXXIQ6uJoN21/xP196adzXO9dOf3Md0/mmnbjplFeR9uq+ZBSqhM/SeaJHlAsFhZKoVZunrJC5QxXsidk/ZjaE3725ayP8WjaPeeYBfUF0gor6FOQoMbGcx97VbGafjnap2wuzbDvgZpQJo7bPyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788678257; c=relaxed/simple;
	bh=OqUmtKm21Ff4DHLtVdsFiv1Al10ENz9TldH/yoAtzjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WCpVP5pvZ5790n2pSAmTI3pOqD8B00pzPCEWrO0ZEQuA67lr2Q4c3wxhB78GXiLRnoepFVP2Ll9Ib0SJgNkI/TDS6lRiJO7a0oCi0CTrRTkoAmt7ZUt+R+3zs3XEdkewtNDZZ2/KSRiOlV/duLsLvEew8ltrmlkAXZ4RzJv0GDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTegZf67; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTegZf67"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so1579430b3a.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788678255; x=1789283055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zGxGzHcYQXVoTBb1ic55BNH01PrjYQY8D/3fptL3AZc=;
        b=TTegZf67/xrKyshiN8oqYdlHWytpL6eDrpwWOaa7O/pfIXEDmCBr6ctNKGK27khUa9
         Ft7UWFKOD6ltJ4lVNrWB/8Elwzt3PNNJlB50JqNxPfR3grOgFEOz6XMlhdPJoGzPniJv
         ZzivMZYHdjEne9zlt2bQnQhaUUnIAGiox/2GSUP3FIBJjxqSJhkjxpQCoQukPxmWPNkc
         LW1cBl4faRoMVodab/1P3kyaLNa3ZxtLHSZBt5XzkKkTlKmIPgh3EvPIAWJ109WB6tWS
         XhVltaKD7lOWPqNN3J3BP9aLPeJivmAqskDG6YEw8XHI+IAGxn0Lq/gwJZGYz45Y7RF2
         w9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788678255; x=1789283055;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGxGzHcYQXVoTBb1ic55BNH01PrjYQY8D/3fptL3AZc=;
        b=AANNgFowBNrPe0vOU30Fpx3ZkUUoNxOBpxj5c2LtFlQVxTXiXaQeOdGj8LlPxz29qV
         t5XfkASZ841HhSZ7XWBTPELfEyVpKP6RATpz2p5i2ojD/gZCKtDRXxZj5YAQy1fu8a6I
         BqTu4j0QOsVaDgax6SW39iomcGkTSEK6bQgyZ2VRj1YCUURqtHFduUC4Iimc+8Rqvpnv
         N7KYzngDv2ys3C4dvii4t61cpP7suWcNz3pkzrUiWebPZPWC32sshHniybr6j9r6LWm+
         oAfLYILrJkH5GiT0RTPSx0dXOLlvVb/HgWpa7KWJaUT9KQ8/yhgwthQFwqWpjG+hfinl
         T5Jg==
X-Forwarded-Encrypted: i=1; AKwUvBy1eYDINtyGwtfYsIsLlKcjmIjEExCjHpsY6otMGBxmlk34nY2tlN5/o7WvRRKeMWCPgx4=@vger.kernel.org
X-Gm-Message-State: AFuF++lubTQrZRzRQb8lIgciK/qyeAsB7HyLmKWB/1uyeafgBgvyqQBW
	EjeEwq9xPqNTl/YxsE1tMoszM6xUgstRRFA97QrfiyE/o6brFjT41vpIqijvPseE
X-Gm-Gg: AYBFou0IVvHHqxVu1PF+FWaUsiE2oUYwYcGptGghUgn/IJzfP/Nzkm+0+n2Rwncf5Nt
	Ef0zHXVsfvjTGGXaYXZni9nO7nvVKx5TXyxFMy5G9MWuCK2QsERCSwo1OVWTjPhoDxFFlyHgfgO
	XsdH1M9szl/auHkRIL0ZkeposN5vK8zr1Vq0NaBLbVpiT9BqKwsgvNjj9vttqNe1yf9XeLq6uka
	ZvDJIkSfm8LHAfh4my9ZaqDbRmwxQCGffIrOVTzEm+brgVUgHe6nKhbMG7qq6GZd9ttfO8v6eH5
	wzccMVOonbudr9JtW2ujUxVIQuSsx7P0A8hf1KgIX5UiAuFYFWzotDBvkzWbHaw3WtKYLGAa31a
	/X4ti+NS6NGVLvglN16XbEqkp/veM+7ztHgauwO7Efn1+S7nGTC35JDzNALetyQ9P2QbxHrI0LA
	fWXKwBXemHGQQI0jN/XcexNpUiqN4Zy3nVJ+lEk5HdZoFI/aon6AqFuAuDoEhlRfqU2/zuXG6MY
	QiQN1z1T6ZjH0cZ
X-Received: by 2002:a05:6a00:464e:b0:853:59ed:5539 with SMTP id d2e1a72fcca58-86168593e7bmr23005616b3a.16.1788678254535;
        Sun, 06 Sep 2026 00:04:14 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152c2a536sm2924933b3a.31.2026.09.06.00.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:04:13 -0700 (PDT)
Message-ID: <55dca8a81004eba0d5ba92006e4953fc12c5d1fc.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Preserve packet pointer class
 displacement in regsafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Sun, 06 Sep 2026 00:04:10 -0700
In-Reply-To: <83e2ad1e23774de204372c7e3d3bddc8f570c099.camel@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
		 <20260905083418.3723623-3-memxor@gmail.com>
	 <83e2ad1e23774de204372c7e3d3bddc8f570c099.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 23:40 -0700, Eduard Zingerman wrote:
> On Sat, 2026-09-05 at 10:34 +0200, Kumar Kartikeya Dwivedi wrote:
> > regsafe() maps packet pointer IDs between states and checks that each
> > current register range is a subset of the corresponding explored
> > register range. It does not, however, preserve the displacement between
> > registers that share a packet pointer ID.
> >=20
> > This is unsound because packet range is shared by ID. A bounds check on
> > one class member updates every member, and a later access can consume t=
he
> > range through another member. Commit 022ac0750883 ("bpf: use reg->var_o=
ff
> > instead of reg->off for pointers") folded the fixed pointer offset into
> > r64 and removed the old off equality check, so two individually narrowe=
r
> > registers can prune even when their displacement has changed. The
> > explored path can then license an out-of-bounds packet access on the
> > pruned path.
> >=20
> > Requiring equal r64 bases would prevent the bug, but would also reject =
a
> > safe uniform translation of the whole class. Instead, record the base
> > translation seen for the first packet pointer in each ID mapping and
> > require every subsequent member to have the same translation. This keep=
s
> > the relative displacement invariant while retaining pruning for uniform=
ly
> > translated classes. Packet pointers without an ID remain unaffected.
> >=20
> > Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for poi=
nters")
> > Reported-by: Nicholas Carlini <npc@anthropic.com>
> > Suggested-by: Nicholas Carlini <npc@anthropic.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>=20
> So, essentially this is the same problem as `id + ADD_CONST` tracking
> for scalar values, where the actual difference is stored in `delta` field=
.
> In other words, that would be an undo of 022ac0750883 for packet pointers=
.
>=20
> What about the original suggested fix:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* id =
relations must be preserved */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!c=
heck_ids(rold->id, rcur->id, idmap))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rold->id && =
rold->r64.base !=3D rcur->r64.base)
> =C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* new=
 val must satisfy old val knowledge */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 range_within(rold, rcur) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tnum_in(rold->var_off, rcur->var_off);
>=20
> Is it that bad?
> Given this logic in adjust_ptr_min_max_vals:
>=20
> =C2=A0=C2=A0=C2=A0 case BPF_ADD:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> 		if (reg_is_pkt_pointer(ptr_reg))
> 			if (!known)
> 				dst_reg->id =3D ++env->id_gen;
>=20
> I'd expect it to be okay.
>=20
> ...

In case there are veristat regressions, it seems the following should
be on-par with pre 022ac0750883 state (untested, llm):

  --- a/kernel/bpf/verifier.c
  +++ b/kernel/bpf/verifier.c
  @@ -14685,16 +14685,20 @@
   		 * dst_reg gets the pointer type and since some positive
   		 * integer value was added to the pointer, give it a new 'id'
   		 * if it's a PTR_TO_PACKET.
  -		 * this creates a new 'base' pointer, off_reg (variable) gets
  -		 * added into the variable offset, and we copy the fixed offset
  -		 * from ptr_reg.
  +		 * This creates a new shared base with delta zero. Constant
  +		 * arithmetic preserves the ID and accumulates delta instead;
  +		 * if delta overflows, start a new ID as well.
   		 */
   		dst_reg->r64 =3D cnum64_add(ptr_reg->r64, off_reg->r64);
   		dst_reg->var_off =3D tnum_add(ptr_reg->var_off, off_reg->var_off);
   		dst_reg->raw =3D ptr_reg->raw;
   		if (reg_is_pkt_pointer(ptr_reg)) {
  -			if (!known)
  +			if (!known ||
  +			    check_add_overflow(ptr_reg->delta, smin_val,
  +					       &dst_reg->delta)) {
   				dst_reg->id =3D ++env->id_gen;
  +				dst_reg->delta =3D 0;
  +			}
   			/*
   			 * Clear range for unknown addends since we can't know
   			 * where the pkt pointer ended up. Also clear AT_PKT_END /
  @@ -14738,8 +14742,12 @@
   		dst_reg->var_off =3D tnum_sub(ptr_reg->var_off, off_reg->var_off);
   		dst_reg->raw =3D ptr_reg->raw;
   		if (reg_is_pkt_pointer(ptr_reg)) {
  -			if (!known)
  +			if (!known ||
  +			    check_sub_overflow(ptr_reg->delta, smin_val,
  +					       &dst_reg->delta)) {
   				dst_reg->id =3D ++env->id_gen;
  +				dst_reg->delta =3D 0;
  +			}
   			/*
   			 * Clear range if the subtrahend may be negative since
   			 * pkt pointer could move past its bounds. A positive
  --- a/kernel/bpf/states.c
  +++ b/kernel/bpf/states.c
  @@ -634,6 +634,9 @@
   		}
   		/* id relations must be preserved */
   		if (!check_ids(rold->id, rcur->id, idmap))
  +			return false;
  +		/* Preserve displacements from the shared packet base. */
  +		if (rold->id && rold->delta !=3D rcur->delta)
   			return false;
   		/* new val must satisfy old val knowledge */
   		return range_within(rold, rcur) &&
