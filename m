Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4583DFC84
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795381; cv=none; b=NQAUO1v6HhTtg/6cM6nfGyUjhEBTli5HOxH8YXmxJuX8HvpYt03MX2ppRBhvVXMGn5JCCxp5K5ON33ryT3S4rAA5A33bM66VH7JqVtQszhzq3gVq/TO1AnHcJ1HW15EU41gNgI2ZehSaQqU6P6OSwv37PdwvajFz6Yx5r3uAz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795381; c=relaxed/simple;
	bh=48ZOm/J6zWoeqUgIJA3LzrUJq1+NIshXbTP6kgylFeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWQ2MtOC0bsFw9Th8TrhspRkrSLidLZBo2JmOfzyvpfsHUlxfdFQcNQZRcniJ2dX9qt/aZn185X2FM9cp20k/XkQ5vJxxqwFty6fcaC7sJhakuM3hEORuIKKYyG6bSyM+I+FWCOChAB1OizVHbezhFpSgyWCmUp5LfuDjLt+bV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8YVjQR/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8YVjQR/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2be1dd4af34so92685425ad.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795379; x=1780400179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QMqVG2BWpzjQXys63IkGaZ6EBzQtpiRrcY9CBj5v+Y=;
        b=l8YVjQR/bjjTlvN7PSUIC9Z4yXJpIehApHHlaAzb7xp8sysonjwnSNYbHS0KCyYiLV
         0RhJZTMoH2/reW5kQJV5wiQgIia1HmSmiRlh40uyNcJThG0cEy2lXmYMD+MdO1hqssF5
         3y/FFEFj1WjhKZZs/Ki5n4ijT2UzbhFNCliUUSSRF740M4P1Ub+V/zyPFb/4mAKebtCW
         Q4l5/ZSRPZZI/7Ki/sBaW1KyyxZIlS+AUT4sSZowxF7110pQRVLuxrL5aHsNxMk0EW6+
         sQ4fC/vtx2knE8GdSUuHjx/b/s2LkHnUL5LBWVEaDJOTt1wGBiuS73jY5iDFF7P1AWat
         egWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795379; x=1780400179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QMqVG2BWpzjQXys63IkGaZ6EBzQtpiRrcY9CBj5v+Y=;
        b=e9tVVPv7WhJqjPL5sFWBjAFg7zL+fLCQ9ingetCwnWn1uZh3Au7WpczeY9MtCnBXgY
         EbXCw9GkLwaqfycIDHpNgZ6/c0WKnE47ierFDN0YNo6Fo6qH3LTxXxSHL704YmWY17cM
         AHKjCwFjOSBEiEgmZ4K9cFSJq/J9LhdgYalf+heroP8o3btCW46pg64sCf3Xi35rpSaj
         LNGBMBUJ/H0sstpsxXq5MZJEsKd2nAcCm6FeDuAbIh3Vca6szP2xV5ERNXg4xPeuycyd
         4dRkt1zguQjawZkNJbIyi5rdVck6vqV7N5+sxgFyqD59r1QLB0BX+G4RaB+fV8MTZqo0
         M1Sw==
X-Gm-Message-State: AOJu0Yygd+9KxD3ZZHr5+xgx7mIt/fydcnWRRRCEgMiXzusQ6fKg3o3P
	ymSzUYW76B/w/BNvkqaGiZd5QTkZsvxAQS/PX6dBGK6k402J2Ezmj5mz
X-Gm-Gg: Acq92OEV4cIdNuQQgOJqTXJ0dFFZnX8kVPND0B2RWGS3r2RcNxKWReQzE7wlvOy83ai
	zpaQ/xD7cLWZ7HFcK94fCBHiynvAlnlYi9xEvTq/xPtTfy0QFxYK5KGHasMvAoca36XJf2dQ5VI
	VnRKj828SHancwNAfqj0OFnPiA6H5uVhj8WR+woLv8pSyC7NUuuLet/67MVw5iARj2vGQtBnQXG
	HHKXIHBXi6WLo6WQFbRUkD+qDxbOKOLYbIURH8eRPSx0rOzWqN6dResQUXmtQxl3yRTU0/iDqF+
	QjrHL5J+NLBPrFP16tj4fDXUdM9wWA4yE0Jm/ChfdmJsxgkTcifGTlUl/J3hTj8bdwDTh2ywPZ4
	VfdFApN5vCCizfQsjL9GhBG2E6r7sGmkBos4qKajS6uIY5B5MQayY1jp2XXiAETikV9NRwjkOyU
	OIQkCnWwXaS7iQ5c655DD8mygLtiGK54u7xTDQDQHSbVYgu4RpK0g=
X-Received: by 2002:a17:903:390d:b0:2bd:7bec:f0d8 with SMTP id d9443c01a7336-2beb0381519mr210980435ad.13.1779795379177;
        Tue, 26 May 2026 04:36:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ebcsm124159885ad.49.2026.05.26.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:36:18 -0700 (PDT)
Message-ID: <30875aada61a6dc3354c05c5b3bcf57234215432.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/6] bpf: report register diff summary for
 hot callchains
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 26 May 2026 04:36:16 -0700
In-Reply-To: <20260526111112.06B541F000E9@smtp.kernel.org>
References: <20260526-better-1m-reporting-v1-5-51e4f2c59780@gmail.com>
	 <20260526111112.06B541F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 11:11 +0000, sashiko-bot@kernel.org wrote:

[...]

> > @@ -970,7 +1004,8 @@ static void reset_idmap_scratch(struct bpf_verifie=
r_env *env)
> > =C2=A0static bool states_equal(struct bpf_verifier_env *env,
> > =C2=A0			 struct bpf_verifier_state *old,
> > =C2=A0			 struct bpf_verifier_state *cur,
> > -			 enum exact_level exact)
> > +			 enum exact_level exact,
> > +			 struct bpf_state_diff *diff)
> > =C2=A0{
> > =C2=A0	u32 insn_idx;
> > =C2=A0	int i;
>=20
> [Severity: Medium]
> Since diff is initialized to zero by the caller, will early returns in
> states_equal() and func_states_equal() (such as mismatches in in_sleepabl=
e,
> callback_depth, or refsafe()) fail to update the diff parameter?
>=20
> Would this result in falsely attributing state mismatches to register R0
> and producing misleading profiling statistics?

Don't expect this to be an issue in loops, but yes.
I should add DIFF_OTHER as a reason.

> [ ... ]
> > @@ -1588,3 +1627,94 @@ int bpf_is_state_visited(struct bpf_verifier_env=
 *env, int insn_idx)
> [ ... ]
> > +int bpf_sample_state_diffs(struct bpf_verifier_env *env,
> > +			=C2=A0=C2=A0 struct bpf_callchain *cc,
> > +			=C2=A0=C2=A0 struct bpf_state_diff *top_diffs,
> > +			=C2=A0=C2=A0 int *nr_diffs)
> > +{
> [ ... ]
> > +	list_for_each(pos_i, head) {
> > +		sl_i =3D container_of(pos_i, struct bpf_verifier_state_list, node);
> > +		if (!callchain_matches_state(cc, &sl_i->state))
> > +			continue;
> > +		list_for_each(pos_j, pos_i) {
> > +			struct bpf_state_diff diff =3D {};
> > +
> > +			sl_j =3D container_of(pos_j, struct bpf_verifier_state_list, node);
> > +			if (!callchain_matches_state(cc, &sl_j->state))
>=20
> [Severity: High]
> Does this nested loop traversal result in processing the dummy list head?
>=20
> Because list_for_each() iterates until the pointer wraps around to its
> start point (in this case, pos_i), the traversal will inevitably evaluate
> the dummy head (&env->explored_states[hash_idx]).
>=20
> When container_of() computes sl_j from this dummy head, won't the
> subsequent callchain_matches_state() dereference an invalid pointer and
> cause an out-of-bounds read?

Good point. I should iterate starting from the same 'head' and just
filter out 'pos_i =3D=3D pos_j'. Surprising that I didn't see KASAN splats
when testing this on scx.
