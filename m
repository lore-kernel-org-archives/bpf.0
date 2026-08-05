Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AA2222C5
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785906887; cv=none; b=u7yBdGBagVeVV5mAlHvXwu05IvkYaB9uK3358zwG9OQyPtmLWL0U+cxzjSM94T8h9LOMOPdMbxwFUP7Mqf2gbp82NmyqyBlOVkowX6yReNLEgEjdrgiMOTj9y8l1ZmMTTKpDo9sCvaaYaRq07AXxO6w5kN4RfEgYHGjudCyImrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785906887; c=relaxed/simple;
	bh=x9lAygX07QrJLp7aHJz/L/eM4uWyYzXqlvtA7NrOgbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LkUs5x1PJtIwIz6dMWHlS8u3xvVlpHazQb5++1haOv+H0N43bF+tauUYUVr+KnTz9/QfoigZYpe1gQQqojlQ2XfL6iVt4q+HutfCeXKdvnMJ/o9cxABk+RXu44hCh10EVr4zXE6r6kj0AV2arXwc5Ig/a+2DlFjK8/Un8M6y+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+KVyDiQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+KVyDiQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cee9b74ee1so5154295ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785906885; x=1786511685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1M99Glsb2YMb5rP+RBUlGslFVt64Dc5uZeAUud4eCTM=;
        b=o+KVyDiQEEXDlCvEhswQQgzxMXQgbyTmPhvO9tllLtb9WZdYHfYDnuZY2nEWPmydjS
         A2WpqsCqIVGqDM0503Wg3uL3N4tlOJuxIqfVyd2rCOgicjvbhOYbms8KCm5hH9HUP3o1
         472v/Rwpn5R1mAfUd5CnoHLmhHEqbJcclWGv+4l7PeGwgdlbAbNQa1ktrAZRzQy40L7J
         Rji5v1CaqzaZ8qCyeHUZ9lm6wlT7+jp1MA/7To2ebdTaRg+3w3g+eCA5rw38Rut3CfZT
         NzEoBLIjzMNI9Q6L0dNhJt5BOKG6whS64KV5zSrqa4kbSDpBUmLmYUA7sG1nfpy1wU/h
         J5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785906885; x=1786511685;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1M99Glsb2YMb5rP+RBUlGslFVt64Dc5uZeAUud4eCTM=;
        b=JNShv78MJ09sLvlSwIhaIsfahO6LRSjwwW+7sYT9Kzkhs9kPuU77C/J2daa4m9cG+5
         Fgsc3fctgLG4SdUuVINP6+A4Vb7n3NUPfVnhVz0w3N80qSAqSmklLBUjzTwEjCLAMrHC
         B+eu9jMUUIfM2IWT/FwNDT+xk/C1IrakNxZXYys8rA7yxDDYn+jTuY2UNaMAPcyxmZWl
         E2zHBn1CgDUuWxHHspTCkD5fekBeVZl4bCjMfvpTN+OlOXLMe3ogv4obqhDfotfvxzcV
         ZjW7zA/pi+S3NFC+7IYW7iKtjbZnB/8mgTWFTdaFM52k9ic6KaRF9XQLKWGLUdXWAzwt
         vkzw==
X-Forwarded-Encrypted: i=1; AHgh+RqWVQGZsSb5VsgqmoSq17Tiqa7NOSSorGMpB3wccc0Kro4jIprwaMgzvOrD/xvtkDtrSSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9q4qzmezRWK4+fWP9tp1P9G/2vnKGNJeTN5L0P/149sX6PRHt
	NhAU1t6EibLNJVTdlD0JfzytiVI8Wxg3SmqL524PPHbcIqWgeSnltJ71
X-Gm-Gg: AR+sD11zvZSzMj5jouHSmF5Z2jGoiaTaZTbwUs4OVM1cEU6RWUD8rJfQn/ygFvG1uqu
	JD38FRKOQm11jm5sngF77myCUa18XIKbK6wJnozaEh9GhZgKnqZoDEd6DB3iRJpRdaTSMmJBuLL
	mNYfRSxRoZ1+7a8s8ZN7gcqoSSW/azXyw6znaMdtDyBfXy9g4o6gobDL/eRP+rzcNaPyeTvzt0P
	RX3B3Gbw7QvPBpPpM7Nb3AaIVO9WNC/xvRiU/UtwgpneubmInU0p7eKg+dPZVwn+S40/USXBacA
	FUcQNW1b3zpxTn89UGSoEEi0tu5vVwagw+lfAtcxzolQXcDl1pS90N4sDxSd0G0oxgPVLIEX29u
	efDOFp9GkpZiWTJCLjPNHiSSRcPneO7ZCuFX5I7JBuPrX42nDUVZ6hVuXVr1h1LDPlNyz4wIjpl
	ToJj7fHqaPNYhHgvCU2asCP/FPKkxsbfQUkmzPEkM4eGsiCfCYm5U5ZVrojgb2Crjd8qqau6dYN
	iTVVCyrbek6Nq/d
X-Received: by 2002:a17:90b:538f:b0:38f:9674:ef61 with SMTP id 98e67ed59e1d1-3903c584291mr4513574a91.13.1785906884842;
        Tue, 04 Aug 2026 22:14:44 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffb349sm3223456a91.6.2026.08.04.22.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:14:44 -0700 (PDT)
Message-ID: <0a7bc56a3753c9122ab421aa14d2daae08b08e30.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Support __arena and
 __arena_nullable on struct_ops arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 22:14:41 -0700
In-Reply-To: <018d033499f61651ec8761fe0f7ac9662ef3c096.camel@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
		 <20260803125115.2264733-3-memxor@gmail.com>
	 <018d033499f61651ec8761fe0f7ac9662ef3c096.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-wSzjhgKRsD1cTbKb/OuW"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-wSzjhgKRsD1cTbKb/OuW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-08-04 at 16:55 -0700, Eduard Zingerman wrote:
> On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
>=20
> Lgtm except for several nits below.
>=20
> ...
>=20
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>=20
> ...
>=20
> > @@ -226,26 +229,30 @@ static int prepare_arg_info(struct btf *btf,
> > =C2=A0	info =3D info_buf;
> > =C2=A0	for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> > =C2=A0		/* Skip arguments that is not suffixed with
> > -		 * "__nullable or __ref".
> > +		 * "__nullable", "__ref", "__arena" or "__arena_nullable".
> > =C2=A0		 */
> > =C2=A0		is_nullable =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 MAYBE_NULL_SUFFIX);
> > =C2=A0		is_refcounted =3D btf_param_match_suffix(btf, &stub_args[arg_no=
],
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REFCOUNTED_SUFFIX);
> > +		is_arena_nullable =3D btf_param_match_suffix(btf, &stub_args[arg_no]=
,
> > +							=C2=A0=C2=A0 ARENA_MAYBE_NULL_SUFFIX);
> > +		is_arena =3D btf_param_match_suffix(btf, &stub_args[arg_no], ARENA_S=
UFFIX);
> > =C2=A0
> > =C2=A0		if (is_nullable)
> > =C2=A0			suffix =3D MAYBE_NULL_SUFFIX;
> > =C2=A0		else if (is_refcounted)
> > =C2=A0			suffix =3D REFCOUNTED_SUFFIX;
> > +		else if (is_arena_nullable)
> > +			suffix =3D ARENA_MAYBE_NULL_SUFFIX;
> > +		else if (is_arena)
> > +			suffix =3D ARENA_SUFFIX;
>=20
> As discussed already, that's unfortunate that p__arena and p__nullable
> are valid, but p__arena__nullable is not, substituted by
> p__arena_nullable. Same goes for global subprogs.
>=20
> > =C2=A0		else
> > =C2=A0			continue;
> > =C2=A0
> > -		/* Should be a pointer to struct */
> > -		pointed_type =3D btf_type_resolve_ptr(btf,
> > -						=C2=A0=C2=A0=C2=A0 args[arg_no].type,
> > -						=C2=A0=C2=A0=C2=A0 &arg_btf_id);
> > -		if (!pointed_type ||
> > -		=C2=A0=C2=A0=C2=A0 !btf_type_is_struct(pointed_type)) {
> > +		/* Should be a pointer to struct, or any pointer for __arena/__arena=
_nullable */
> > +		pointed_type =3D btf_type_resolve_ptr(btf, args[arg_no].type, &arg_b=
tf_id);
> > +		if (!pointed_type || (!is_arena && !is_arena_nullable && !btf_type_i=
s_struct(pointed_type))) {
> > =C2=A0			pr_warn("stub function %s has %s tagging to an unsupported typ=
e\n",
> > =C2=A0				stub_fname, suffix);
> > =C2=A0			goto err_out;
>=20
> ...
>=20
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index ed7999ad6c66..d2d7a2904345 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
>=20
> ...
>=20
> > @@ -695,6 +743,22 @@ static int bpf_trampoline_update(struct bpf_trampo=
line *tr, bool lock_direct_mut
> > =C2=A0		goto out;
> > =C2=A0	}
> > =C2=A0
> > +	/*
> > +	 * Arena ctx args are converted only by the struct_ops indirect
> > +	 * trampoline, which dispatches to a single known prog. Generic
> > +	 * trampolines can mix progs with different arenas, so no conversion
> > +	 * is possible here. Not reachable today: only struct_ops progs get
> > +	 * arena ctx args and they never ride generic trampolines.
> > +	 */
> > +	for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
> > +		for (i =3D 0; i < tnodes[kind].nr_nodes; i++) {
> > +			if (bpf_prog_has_arena_ctx_arg(tnodes[kind].nodes[i]->link->prog)) =
{
> > +				err =3D -ENOTSUPP;
> > +				goto out;
> > +			}
> > +		}
> > +	}
>=20
> Nit: should this be done in __bpf_trampoline_link_prog() or
> =C2=A0=C2=A0=C2=A0=C2=A0 bpf_trampoline_add_prog()? To avoid doing the sa=
me check on unlink.
> =C2=A0=C2=A0=C2=A0=C2=A0 Since this is an invariant violation, do we want=
 to add WARN_ONCE?
>=20
> > +
> > =C2=A0	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> > =C2=A0	tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CA=
LL_CTX);
> > =C2=A0
>=20
> ...

Thinking a bit more about this. Since kfuncs already use flags in
btf_func_model, I think it would be nice to use them for struct_ops as
well. E.g. as in the patch attached (applied on top of this series).
Wdyt?

--=-wSzjhgKRsD1cTbKb/OuW
Content-Disposition: attachment; filename="struct-ops-flags.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="struct-ops-flags.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L25ldC9icGZfaml0X2NvbXAuYyBiL2FyY2gveDg2L25ldC9i
cGZfaml0X2NvbXAuYwppbmRleCA0YjM0OWFlMzVlYmYuLmRjYzY4ZWI1NjMyYSAxMDA2NDQKLS0t
IGEvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jCisrKyBiL2FyY2gveDg2L25ldC9icGZfaml0
X2NvbXAuYwpAQCAtMzA3MSwxMiArMzA3MSwxMiBAQCBzdGF0aWMgdm9pZCBlbWl0X2FyZW5hX2Fy
Z19jb252KHU4ICoqcHByb2csIHUzMiBzcmNfcmVnLCBib29sIG51bGxhYmxlLCB1MzIgYmFzZQog
CiBzdGF0aWMgdm9pZCBzYXZlX2FyZ3MoY29uc3Qgc3RydWN0IGJ0Zl9mdW5jX21vZGVsICptLCB1
OCAqKnByb2csCiAJCSAgICAgIGludCBzdGFja19zaXplLCBib29sIGZvcl9jYWxsX29yaWdpbiwg
dTMyIGZsYWdzLAotCQkgICAgICBjb25zdCBzdHJ1Y3QgYnBmX3RyYW1wX2FyZW5hX2FyZ3MgKmFh
cmdzKQorCQkgICAgICB1NjQgYXJlbmFfYmFzZSkKIHsKIAlpbnQgYXJnX3JlZ3MsIGZpcnN0X29m
ZiA9IDAsIG5yX3JlZ3MgPSAwLCBucl9zdGFja19zbG90cyA9IDA7CiAJYm9vbCB1c2Vfam1wID0g
YnBmX3RyYW1wb2xpbmVfdXNlX2ptcChmbGFncyk7CiAJaW50IHN0YWNrX2FyZ3Nfb2ZmID0gKHVz
ZV9qbXAgfHwgKGZsYWdzICYgQlBGX1RSQU1QX0ZfSU5ESVJFQ1QpKSA/IDE2IDogMjQ7Ci0JaW50
IGksIGosIHNsb3QgPSAwOworCWludCBpLCBqOwogCiAJLyogU3RvcmUgZnVuY3Rpb24gYXJndW1l
bnRzIHRvIHN0YWNrLgogCSAqIEZvciBhIGZ1bmN0aW9uIHRoYXQgYWNjZXB0cyB0d28gcG9pbnRl
cnMgdGhlIHNlcXVlbmNlIHdpbGwgYmU6CkBAIC0zMDg0LDYgKzMwODQsOSBAQCBzdGF0aWMgdm9p
ZCBzYXZlX2FyZ3MoY29uc3Qgc3RydWN0IGJ0Zl9mdW5jX21vZGVsICptLCB1OCAqKnByb2csCiAJ
ICogbW92IFFXT1JEIFBUUiBbcmJwLTB4OF0scnNpCiAJICovCiAJZm9yIChpID0gMDsgaSA8IG1p
bl90KGludCwgbS0+bnJfYXJncywgTUFYX0JQRl9GVU5DX0FSR1MpOyBpKyspIHsKKwkJYm9vbCBh
cmVuYV9hcmcgPSBhcmVuYV9iYXNlICYmIChtLT5hcmdfZmxhZ3NbaV0gJiBCVEZfRk1PREVMX0FS
RU5BX0FSRyk7CisJCWJvb2wgbnVsbGFibGUgPSBtLT5hcmdfZmxhZ3NbaV0gJiBCVEZfRk1PREVM
X05VTExBQkxFX0FSRzsKKwogCQlhcmdfcmVncyA9IChtLT5hcmdfc2l6ZVtpXSArIDcpIC8gODsK
IAogCQkvKiBBY2NvcmRpbmcgdG8gdGhlIHJlc2VhcmNoIG9mIFlvbmdob25nLCBzdHJ1Y3QgbWVt
YmVycwpAQCAtMzExNywxMCArMzEyMCw5IEBAIHN0YXRpYyB2b2lkIHNhdmVfYXJncyhjb25zdCBz
dHJ1Y3QgYnRmX2Z1bmNfbW9kZWwgKm0sIHU4ICoqcHJvZywKIAkJCWZvciAoaiA9IDA7IGogPCBh
cmdfcmVnczsgaisrKSB7CiAJCQkJZW1pdF9sZHgocHJvZywgQlBGX0RXLCBCUEZfUkVHXzAsIEJQ
Rl9SRUdfRlAsCiAJCQkJCSBucl9zdGFja19zbG90cyAqIDggKyBzdGFja19hcmdzX29mZik7Ci0J
CQkJaWYgKGFhcmdzICYmIChhYXJncy0+c2xvdHMgJiBCSVQoc2xvdCkpKQotCQkJCQllbWl0X2Fy
ZW5hX2FyZ19jb252KHByb2csIEJQRl9SRUdfMCwKLQkJCQkJCQkgICAgYWFyZ3MtPm51bGxhYmxl
X3Nsb3RzICYgQklUKHNsb3QpLAotCQkJCQkJCSAgICAodTMyKWFhcmdzLT5rZXJuX3ZtX3N0YXJ0
KTsKKwkJCQlpZiAoYXJlbmFfYXJnKQorCQkJCQllbWl0X2FyZW5hX2FyZ19jb252KHByb2csIEJQ
Rl9SRUdfMCwgbnVsbGFibGUsCisJCQkJCQkJICAgICh1MzIpYXJlbmFfYmFzZSk7CiAJCQkJZW1p
dF9zdHgocHJvZywgQlBGX0RXLCBCUEZfUkVHX0ZQLCBCUEZfUkVHXzAsCiAJCQkJCSAtc3RhY2tf
c2l6ZSk7CiAKQEAgLTMxMjgsNyArMzEzMCw2IEBAIHN0YXRpYyB2b2lkIHNhdmVfYXJncyhjb25z
dCBzdHJ1Y3QgYnRmX2Z1bmNfbW9kZWwgKm0sIHU4ICoqcHJvZywKIAkJCQkJZmlyc3Rfb2ZmID0g
c3RhY2tfc2l6ZTsKIAkJCQlzdGFja19zaXplIC09IDg7CiAJCQkJbnJfc3RhY2tfc2xvdHMrKzsK
LQkJCQlzbG90Kys7CiAJCQl9CiAJCX0gZWxzZSB7CiAJCQkvKiBPbmx5IGNvcHkgdGhlIGFyZ3Vt
ZW50cyBvbi1zdGFjayB0byBjdXJyZW50CkBAIC0zMTM3LDcgKzMxMzgsNiBAQCBzdGF0aWMgdm9p
ZCBzYXZlX2FyZ3MoY29uc3Qgc3RydWN0IGJ0Zl9mdW5jX21vZGVsICptLCB1OCAqKnByb2csCiAJ
CQkgKi8KIAkJCWlmIChmb3JfY2FsbF9vcmlnaW4pIHsKIAkJCQlucl9yZWdzICs9IGFyZ19yZWdz
OwotCQkJCXNsb3QgKz0gYXJnX3JlZ3M7CiAJCQkJY29udGludWU7CiAJCQl9CiAKQEAgLTMxNDUs
MTYgKzMxNDUsMTMgQEAgc3RhdGljIHZvaWQgc2F2ZV9hcmdzKGNvbnN0IHN0cnVjdCBidGZfZnVu
Y19tb2RlbCAqbSwgdTggKipwcm9nLAogCQkJZm9yIChqID0gMDsgaiA8IGFyZ19yZWdzOyBqKysp
IHsKIAkJCQl1MzIgc3JjID0gbnJfcmVncyA9PSA1ID8gWDg2X1JFR19SOSA6IEJQRl9SRUdfMSAr
IG5yX3JlZ3M7CiAKLQkJCQlpZiAoYWFyZ3MgJiYgKGFhcmdzLT5zbG90cyAmIEJJVChzbG90KSkp
IHsKLQkJCQkJZW1pdF9hcmVuYV9hcmdfY29udihwcm9nLCBzcmMsCi0JCQkJCQkJICAgIGFhcmdz
LT5udWxsYWJsZV9zbG90cyAmIEJJVChzbG90KSwKLQkJCQkJCQkgICAgKHUzMilhYXJncy0+a2Vy
bl92bV9zdGFydCk7CisJCQkJaWYgKGFyZW5hX2FyZykgeworCQkJCQllbWl0X2FyZW5hX2FyZ19j
b252KHByb2csIHNyYywgbnVsbGFibGUsICh1MzIpYXJlbmFfYmFzZSk7CiAJCQkJCXNyYyA9IEJQ
Rl9SRUdfMDsKIAkJCQl9CiAJCQkJZW1pdF9zdHgocHJvZywgQlBGX0RXLCBCUEZfUkVHX0ZQLCBz
cmMsIC1zdGFja19zaXplKTsKIAkJCQlzdGFja19zaXplIC09IDg7CiAJCQkJbnJfcmVncysrOwot
CQkJCXNsb3QrKzsKIAkJCX0KIAkJfQogCX0KQEAgLTM0NDUsMTMgKzM0NDIsMTIgQEAgc3RhdGlj
IGludCBfX2FyY2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZShzdHJ1Y3QgYnBmX3RyYW1wX2ltYWdl
ICppbSwgdm9pZCAqcndfaW0KIAlzdHJ1Y3QgYnBmX3RyYW1wX25vZGVzICpmZW50cnkgPSAmdG5v
ZGVzW0JQRl9UUkFNUF9GRU5UUlldOwogCXN0cnVjdCBicGZfdHJhbXBfbm9kZXMgKmZleGl0ID0g
JnRub2Rlc1tCUEZfVFJBTVBfRkVYSVRdOwogCXN0cnVjdCBicGZfdHJhbXBfbm9kZXMgKmZtb2Rf
cmV0ID0gJnRub2Rlc1tCUEZfVFJBTVBfTU9ESUZZX1JFVFVSTl07Ci0Jc3RydWN0IGJwZl90cmFt
cF9hcmVuYV9hcmdzIGFhcmdzOwogCXZvaWQgKm9yaWdfY2FsbCA9IGZ1bmNfYWRkcjsKIAlpbnQg
Y29va2llX29mZiwgY29va2llX2NudDsKIAl1OCAqKmJyYW5jaGVzID0gTlVMTDsKKwl1NjQgYXJl
bmFfYmFzZTsKIAl1NjQgZnVuY19tZXRhOwogCXU4ICpwcm9nOwotCWJvb2wgaGFzX2FhcmdzOwog
CWJvb2wgc2F2ZV9yZXQ7CiAKIAkvKgpAQCAtMzQ2Miw3ICszNDU4LDcgQEAgc3RhdGljIGludCBf
X2FyY2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZShzdHJ1Y3QgYnBmX3RyYW1wX2ltYWdlICppbSwg
dm9pZCAqcndfaW0KIAlXQVJOX09OX09OQ0UoKGZsYWdzICYgQlBGX1RSQU1QX0ZfSU5ESVJFQ1Qp
ICYmCiAJCSAgICAgKGZsYWdzICYgfihCUEZfVFJBTVBfRl9JTkRJUkVDVCB8IEJQRl9UUkFNUF9G
X1JFVF9GRU5UUllfUkVUKSkpOwogCi0JaGFzX2FhcmdzID0gYnBmX3RyYW1wX2NvbGxlY3RfYXJl
bmFfYXJncyh0bm9kZXMsIGZsYWdzLCAmYWFyZ3MpOworCWFyZW5hX2Jhc2UgPSBicGZfdHJhbXBf
YXJlbmFfYmFzZShtLCB0bm9kZXMsIGZsYWdzKTsKIAogCS8qIGV4dHJhIHJlZ2lzdGVycyBmb3Ig
c3RydWN0IGFyZ3VtZW50cyAqLwogCWZvciAoaSA9IDA7IGkgPCBtLT5ucl9hcmdzOyBpKyspIHsK
QEAgLTM2MDEsOCArMzU5Nyw3IEBAIHN0YXRpYyBpbnQgX19hcmNoX3ByZXBhcmVfYnBmX3RyYW1w
b2xpbmUoc3RydWN0IGJwZl90cmFtcF9pbWFnZSAqaW0sIHZvaWQgKnJ3X2ltCiAJCWVtaXRfc3Rv
cmVfc3RhY2tfaW1tNjQoJnByb2csIEJQRl9SRUdfMCwgLWlwX29mZiwgKGxvbmcpZnVuY19hZGRy
KTsKIAl9CiAKLQlzYXZlX2FyZ3MobSwgJnByb2csIHJlZ3Nfb2ZmLCBmYWxzZSwgZmxhZ3MsCi0J
CSAgaGFzX2FhcmdzID8gJmFhcmdzIDogTlVMTCk7CisJc2F2ZV9hcmdzKG0sICZwcm9nLCByZWdz
X29mZiwgZmFsc2UsIGZsYWdzLCBhcmVuYV9iYXNlKTsKIAogCWlmIChmbGFncyAmIEJQRl9UUkFN
UF9GX0NBTExfT1JJRykgewogCQkvKiBhcmcxOiBtb3YgcmRpLCBpbSAqLwpAQCAtMzY0NCw3ICsz
NjM5LDcgQEAgc3RhdGljIGludCBfX2FyY2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZShzdHJ1Y3Qg
YnBmX3RyYW1wX2ltYWdlICppbSwgdm9pZCAqcndfaW0KIAogCWlmIChmbGFncyAmIEJQRl9UUkFN
UF9GX0NBTExfT1JJRykgewogCQlyZXN0b3JlX3JlZ3MobSwgJnByb2csIHJlZ3Nfb2ZmKTsKLQkJ
c2F2ZV9hcmdzKG0sICZwcm9nLCBhcmdfc3RhY2tfb2ZmLCB0cnVlLCBmbGFncywgTlVMTCk7CisJ
CXNhdmVfYXJncyhtLCAmcHJvZywgYXJnX3N0YWNrX29mZiwgdHJ1ZSwgZmxhZ3MsIDApOwogCiAJ
CWlmIChmbGFncyAmIEJQRl9UUkFNUF9GX1RBSUxfQ0FMTF9DVFgpIHsKIAkJCS8qIEJlZm9yZSBj
YWxsaW5nIHRoZSBvcmlnaW5hbCBmdW5jdGlvbiwgbG9hZCB0aGUKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oCmluZGV4IGM4MzlmMDM5NzI5YS4u
YTk1OWVmYzM0NjhmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oCisrKyBiL2luY2x1
ZGUvbGludXgvYnBmLmgKQEAgLTEyOTMsMTggKzEyOTMsMTMgQEAgc3RydWN0IGJwZl90cmFtcF9u
b2RlcyB7CiB9OwogCiAvKgotICogV2hpY2ggOC1ieXRlIGN0eCBzbG90cyBvZiBhIHN0cnVjdF9v
cHMgdHJhbXBvbGluZSBob2xkIGFyZW5hIGtlcm5lbAotICogcG9pbnRlcnMgdGhhdCBzYXZlX2Fy
Z3MoKSBjb252ZXJ0cyB0byB0aGUgYXJlbmEgcG9pbnRlciBmb3JtLAotICogY3R4W3Nsb3RdID0g
KHUzMikoa2FkZHIgLSBrZXJuX3ZtX3N0YXJ0KS4KKyAqIFRoZSBhcmVuYSBiYXNlIGFnYWluc3Qg
d2hpY2ggYSBzdHJ1Y3Rfb3BzIHRyYW1wb2xpbmUgY29udmVydHMgdGhlCisgKiBhcmd1bWVudHMg
bWFya2VkIHdpdGggQlRGX0ZNT0RFTF9BUkVOQV9BUkcgd2hpbGUgc2F2aW5nIHRoZW0gaW50byB0
aGUgQlBGCisgKiBjdHgsIGN0eFthcmddID0gKHUzMikoa2FkZHIgLSBrZXJuX3ZtX3N0YXJ0KS4g
WmVybyB3aGVuIHRoZSB0cmFtcG9saW5lCisgKiBjb252ZXJ0cyBub3RoaW5nLgogICovCi1zdHJ1
Y3QgYnBmX3RyYW1wX2FyZW5hX2FyZ3MgewotCXUzMiBzbG90czsKLQl1MzIgbnVsbGFibGVfc2xv
dHM7CS8qIHN1YnNldCBvZiBAc2xvdHMgd2hlcmUgTlVMTCBpcyBwcmVzZXJ2ZWQgKi8KLQl1NjQg
a2Vybl92bV9zdGFydDsKLX07Ci0KLWJvb2wgYnBmX3RyYW1wX2NvbGxlY3RfYXJlbmFfYXJncyhz
dHJ1Y3QgYnBmX3RyYW1wX25vZGVzICp0bm9kZXMsIHUzMiBmbGFncywKLQkJCQkgIHN0cnVjdCBi
cGZfdHJhbXBfYXJlbmFfYXJncyAqYWFyZ3MpOwordTY0IGJwZl90cmFtcF9hcmVuYV9iYXNlKGNv
bnN0IHN0cnVjdCBidGZfZnVuY19tb2RlbCAqbSwKKwkJCSBzdHJ1Y3QgYnBmX3RyYW1wX25vZGVz
ICp0bm9kZXMsIHUzMiBmbGFncyk7CiAKIHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0eDsKIApAQCAt
MTcwNywxMSArMTcwMiw2IEBAIHN0cnVjdCBicGZfY3R4X2FyZ19hdXggewogCXUzMiBidGZfaWQ7
CiAJdTMyIHJlZl9pZDsKIAlib29sIHJlZmNvdW50ZWQ7Ci0JLyoKLQkgKiBXZSBkb24ndCBlbmNv
ZGUgTlVMTC1uZXNzIGluIHRoZSB0eXBlIGZvciB0aGUgcHJvZ3JhbSwgYnV0IHN0aWxsIG5lZWQK
LQkgKiB0byBkaXN0aW5ndWlzaCBpdCBmb3IgdGhlIHB1cnBvc2VzIG9mIHRlbGxpbmcgSklUcyB3
aGF0IHNlcXVlbmNlIHRvIGVtaXQuCi0JICovCi0JYm9vbCBhcmVuYV9udWxsYWJsZTsKIH07CiAK
IHN0cnVjdCBidGZfbW9kX3BhaXIgewpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9icGZfc3RydWN0
X29wcy5jIGIva2VybmVsL2JwZi9icGZfc3RydWN0X29wcy5jCmluZGV4IDgyN2E2MjE2YTYyMC4u
YzZhN2MwMjEzYmIwIDEwMDY0NAotLS0gYS9rZXJuZWwvYnBmL2JwZl9zdHJ1Y3Rfb3BzLmMKKysr
IGIva2VybmVsL2JwZi9icGZfc3RydWN0X29wcy5jCkBAIC0xNzQsNiArMTc0LDcgQEAgc3RhdGlj
IGludCBwcmVwYXJlX2FyZ19pbmZvKHN0cnVjdCBidGYgKmJ0ZiwKIAkJCSAgICBjb25zdCBjaGFy
ICpzdF9vcHNfbmFtZSwKIAkJCSAgICBjb25zdCBjaGFyICptZW1iZXJfbmFtZSwKIAkJCSAgICBj
b25zdCBzdHJ1Y3QgYnRmX3R5cGUgKmZ1bmNfcHJvdG8sIHZvaWQgKnN0dWJfZnVuY19hZGRyLAor
CQkJICAgIHN0cnVjdCBidGZfZnVuY19tb2RlbCAqbW9kZWwsCiAJCQkgICAgc3RydWN0IGJwZl9z
dHJ1Y3Rfb3BzX2FyZ19pbmZvICphcmdfaW5mbykKIHsKIAljb25zdCBzdHJ1Y3QgYnRmX3R5cGUg
KnN0dWJfZnVuY19wcm90bywgKnBvaW50ZWRfdHlwZTsKQEAgLTI4OCw3ICsyODksOSBAQCBzdGF0
aWMgaW50IHByZXBhcmVfYXJnX2luZm8oc3RydWN0IGJ0ZiAqYnRmLAogCQkJICogcHJlY2lzaW9u
IGFyb3VuZCBpdCwgc2luY2UgaXQgaGFzIG5vIHNhZmV0eSBpbXBsaWNhdGlvbi4KIAkJCSAqLwog
CQkJaW5mby0+cmVnX3R5cGUgPSBQVFJfVE9fQVJFTkE7Ci0JCQlpbmZvLT5hcmVuYV9udWxsYWJs
ZSA9IGlzX2FyZW5hX251bGxhYmxlOworCQkJbW9kZWwtPmFyZ19mbGFnc1thcmdfbm9dIHw9IEJU
Rl9GTU9ERUxfQVJFTkFfQVJHOworCQkJaWYgKGlzX2FyZW5hX251bGxhYmxlKQorCQkJCW1vZGVs
LT5hcmdfZmxhZ3NbYXJnX25vXSB8PSBCVEZfRk1PREVMX05VTExBQkxFX0FSRzsKIAkJfQogCiAJ
CWluZm8rKzsKQEAgLTQ3Niw2ICs0NzksNyBAQCBpbnQgYnBmX3N0cnVjdF9vcHNfZGVzY19pbml0
KHN0cnVjdCBicGZfc3RydWN0X29wc19kZXNjICpzdF9vcHNfZGVzYywKIAkJc3R1Yl9mdW5jX2Fk
ZHIgPSAqKHZvaWQgKiopKHN0X29wcy0+Y2ZpX3N0dWJzICsgbW9mZik7CiAJCWVyciA9IHByZXBh
cmVfYXJnX2luZm8oYnRmLCBzdF9vcHMtPm5hbWUsIG1uYW1lLAogCQkJCSAgICAgICBmdW5jX3By
b3RvLCBzdHViX2Z1bmNfYWRkciwKKwkJCQkgICAgICAgJnN0X29wcy0+ZnVuY19tb2RlbHNbaV0s
CiAJCQkJICAgICAgIGFyZ19pbmZvICsgaSk7CiAJCWlmIChlcnIpCiAJCQlnb3RvIGVycm91dDsK
ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdHJhbXBvbGluZS5jIGIva2VybmVsL2JwZi90cmFtcG9s
aW5lLmMKaW5kZXggZDJkN2EyOTA0MzQ1Li40MTJhN2QzMmU5NGEgMTAwNjQ0Ci0tLSBhL2tlcm5l
bC9icGYvdHJhbXBvbGluZS5jCisrKyBiL2tlcm5lbC9icGYvdHJhbXBvbGluZS5jCkBAIC01NDAs
NDAgKzU0MCwzMyBAQCBzdGF0aWMgYm9vbCBicGZfcHJvZ19oYXNfYXJlbmFfY3R4X2FyZyhjb25z
dCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2cpCiB9CiAKIC8qCi0gKiBDb2xsZWN0IHdoaWNoIGN0eCBz
bG90cyBvZiBhIHN0cnVjdF9vcHMgdHJhbXBvbGluZSBob2xkIGFyZW5hIGtlcm5lbAotICogcG9p
bnRlcnMgdGhhdCBzYXZlX2FyZ3MoKSBtdXN0IGNvbnZlcnQgdG8gdGhlIGFyZW5hIHBvaW50ZXIg
Zm9ybS4gT25seQotICogdGhlIHN0cnVjdF9vcHMgaW5kaXJlY3QgdHJhbXBvbGluZSBjb252ZXJ0
czogaXQgZGlzcGF0Y2hlcyB0byBhIHNpbmdsZQotICogcHJvZyB3aG9zZSBhcmVuYSBpcyBrbm93
biBhdCBnZW5lcmF0aW9uIHRpbWUuIFJldHVybiBmYWxzZSB3aGVuIHRoZXJlCi0gKiBpcyBub3Ro
aW5nIHRvIGNvbnZlcnQuCisgKiBUaGUgYXJlbmEgYmFzZSBhZ2FpbnN0IHdoaWNoIHNhdmVfYXJn
cygpIGNvbnZlcnRzIHRoZSBhcmd1bWVudHMgbWFya2VkCisgKiB3aXRoIEJURl9GTU9ERUxfQVJF
TkFfQVJHLiBPbmx5IHRoZSBzdHJ1Y3Rfb3BzIGluZGlyZWN0IHRyYW1wb2xpbmUKKyAqIGNvbnZl
cnRzOiBpdCBkaXNwYXRjaGVzIHRvIGEgc2luZ2xlIHByb2cgd2hvc2UgYXJlbmEgaXMga25vd24g
YXQKKyAqIGdlbmVyYXRpb24gdGltZS4gUmV0dXJuIDAgd2hlbiB0aGVyZSBpcyBub3RoaW5nIHRv
IGNvbnZlcnQuCiAgKi8KLWJvb2wgYnBmX3RyYW1wX2NvbGxlY3RfYXJlbmFfYXJncyhzdHJ1Y3Qg
YnBmX3RyYW1wX25vZGVzICp0bm9kZXMsIHUzMiBmbGFncywKLQkJCQkgIHN0cnVjdCBicGZfdHJh
bXBfYXJlbmFfYXJncyAqYWFyZ3MpCit1NjQgYnBmX3RyYW1wX2FyZW5hX2Jhc2UoY29uc3Qgc3Ry
dWN0IGJ0Zl9mdW5jX21vZGVsICptLAorCQkJIHN0cnVjdCBicGZfdHJhbXBfbm9kZXMgKnRub2Rl
cywgdTMyIGZsYWdzKQogewogCWNvbnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZzsKIAlpbnQgaTsK
IAotCW1lbXNldChhYXJncywgMCwgc2l6ZW9mKCphYXJncykpOwotCiAJaWYgKCEoZmxhZ3MgJiBC
UEZfVFJBTVBfRl9JTkRJUkVDVCkgfHwKIAkgICAgdG5vZGVzW0JQRl9UUkFNUF9GRU5UUlldLm5y
X25vZGVzICE9IDEpCi0JCXJldHVybiBmYWxzZTsKKwkJcmV0dXJuIDA7CiAKLQlwcm9nID0gdG5v
ZGVzW0JQRl9UUkFNUF9GRU5UUlldLm5vZGVzWzBdLT5saW5rLT5wcm9nOwotCWZvciAoaSA9IDA7
IGkgPCBwcm9nLT5hdXgtPmN0eF9hcmdfaW5mb19zaXplOyBpKyspIHsKLQkJY29uc3Qgc3RydWN0
IGJwZl9jdHhfYXJnX2F1eCAqaW5mbyA9ICZwcm9nLT5hdXgtPmN0eF9hcmdfaW5mb1tpXTsKKwlm
b3IgKGkgPSAwOyBpIDwgbS0+bnJfYXJnczsgaSsrKQorCQlpZiAobS0+YXJnX2ZsYWdzW2ldICYg
QlRGX0ZNT0RFTF9BUkVOQV9BUkcpCisJCQlicmVhazsKKwlpZiAoaSA9PSBtLT5ucl9hcmdzKQor
CQlyZXR1cm4gMDsKIAotCQlpZiAoYmFzZV90eXBlKGluZm8tPnJlZ190eXBlKSAhPSBQVFJfVE9f
QVJFTkEpCi0JCQljb250aW51ZTsKLQkJYWFyZ3MtPnNsb3RzIHw9IEJJVChpbmZvLT5vZmZzZXQg
LyA4KTsKLQkJaWYgKGluZm8tPmFyZW5hX251bGxhYmxlKQotCQkJYWFyZ3MtPm51bGxhYmxlX3Ns
b3RzIHw9IEJJVChpbmZvLT5vZmZzZXQgLyA4KTsKLQl9Ci0JaWYgKCFhYXJncy0+c2xvdHMpCi0J
CXJldHVybiBmYWxzZTsKKwkvKiBWZXJpZmljYXRpb24gcmVqZWN0cyBhbiBhcmVuYSBhcmd1bWVu
dCB3aXRob3V0IGFuIGFyZW5hLiAqLworCXByb2cgPSB0bm9kZXNbQlBGX1RSQU1QX0ZFTlRSWV0u
bm9kZXNbMF0tPmxpbmstPnByb2c7CiAJaWYgKFdBUk5fT05fT05DRSghcHJvZy0+YXV4LT5hcmVu
YSkpCi0JCXJldHVybiBmYWxzZTsKLQlhYXJncy0+a2Vybl92bV9zdGFydCA9IGJwZl9hcmVuYV9n
ZXRfa2Vybl92bV9zdGFydChwcm9nLT5hdXgtPmFyZW5hKTsKLQlyZXR1cm4gdHJ1ZTsKKwkJcmV0
dXJuIDA7CisKKwlyZXR1cm4gYnBmX2FyZW5hX2dldF9rZXJuX3ZtX3N0YXJ0KHByb2ctPmF1eC0+
YXJlbmEpOwogfQogCiBzdGF0aWMgdm9pZCBicGZfdHJhbXBfaW1hZ2VfZnJlZShzdHJ1Y3QgYnBm
X3RyYW1wX2ltYWdlICppbSkK


--=-wSzjhgKRsD1cTbKb/OuW--
