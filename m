Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9035E95E
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795103; cv=none; b=dVXqS+5dl98YP5HPMvIERP0XABgjyx5eBHKTEYo8pA2LBr1hnqt795q3NM5kyZatSSXIem4HHx4xVIkL7QnbSieMy7o9fdI1K/MfpSswOa54Edr4CozO2LYGfsuJi712Y5Vp6BI2/aCgBrsQMWZd0/lC09Rjtsv/v81d3wM57mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795103; c=relaxed/simple;
	bh=mWtjN31+HpWQbXr/ByrXO2BhARDbhAbOiP36mdhtc4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUnlSFBDAv4upN7YeErIk89djyyWnbUg4q9k2F7j2GrpZahkFFjHc8pmE0rEImyGy3yb0dlfTPCdgyHUzh40D+vIKQZB7Fjo2mGJUqgVnzZQJdR/qTkPSdVl4iaiMMRJTL54vaN1ux28O5fnYRT4McEJkpOEyDJOk1OFHK2gJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os+a37Zc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os+a37Zc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bccb978bd9so64861075ad.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795101; x=1780399901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+NnTbX3WOMBPM0bNRlsEsXdX+ZRunPRKytXuUTgz8Y=;
        b=Os+a37ZcJQURYZg5xIESxOw9lHO7GHM5ifpCgb271NluQvXJsldryO7vSVT6+G7bjd
         I6v+4C91ieMczs07ifK1I3cFosNFbloupiD5u05KS2Ko/bjPAIFMKCDPq+Top5TDZZmF
         2OPLTtY+MiHZdjaQQsveTIbdBAXnbpLJja8HX5zUetiTRd83unthm2hkRrC+Tr74B2ZA
         1lw0C8kyn2JqMeeShXl+N/xTr2DTvUcOqMRsmtn4FNsvQ9M1w9y4PYpAqQPzjkbSlGPK
         3b0dOpHvCOZyBvfCnvnEa1Bf+nxGURIhhn2sAiaw/DoK1H7lN4xwAPnMdgS3QumBla2L
         9gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795101; x=1780399901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+NnTbX3WOMBPM0bNRlsEsXdX+ZRunPRKytXuUTgz8Y=;
        b=dulxVUtqPbz7mMXveiHrrR1Wr8riPUz/Mx4VsQuqAKUaF1/eK/zfbY3hELk8FH9Pqa
         qPiPmcHiSYRAKxco//Ggqi7HNSDUdWj3sXtfysWc1Rt7Cn0XzJp/GsSQN202llzzI5wl
         q3D2jG6kD4zPabVRX7yiH/xtXJkFp/LkCz+Swglfgxu0/kPCzZqIFIe3CcMCVDI97bRV
         eLFakXvxO0FunnWmswvJm/v94a0B4mVuO3CaEGM0sgIYRT+1xb8GuMwr/h/vzFIIkL07
         lAwEjNmrOKruaqAJhmaXycOFcNTZY6xC9Uax3rDdYgaNwoRkup4Pv9kV+eBSB8DzDk6O
         dcWQ==
X-Gm-Message-State: AOJu0YzzKLD15ZUByL/mve1wRU/zIzFT8faal0I9W2ZAABIfLHgofV+n
	wn9717Wva7na3h6Xr9GYKNwJbnY0e5eBWHoA9KHdkk7Yt+YXUbVErY7PsETwD2u7W0E=
X-Gm-Gg: Acq92OGRoR64kXobf0CQx+vB1W5DVVpBzqGyIECM2ANGZNYrpMzuUnLoCuvrrwG0lpW
	CEN2NreZXe4+oa+Q16YiNhRC6VVulYkf9hZIUl0u84Sn9uyP2FKi3fHXKWf/j7MjJQ2+zYViEYy
	fmKaKljWnG6fXW8pDc2MUyr6ZO66rJgLutCTDJHQHEaZZcNEWijCGIj4qPmjTYcSfSWMiY9iYxV
	z0ZELiGlwJkMeIClILHAdgrdt/2ikJ67Mi8S1banFFfYmsdyCvlogQcFb44fI2ZAf9TV3S58XLR
	P9YPkDE/7vWlcJO2I7ltl26ZVdlwMRnrULtRNlMN2GRIsvH7x1IOWMMBrX322TwoE6G2CC5T6ER
	Ghaa2l8b0KkHbWFP9WhMQBCM5KfhV8AtJZYILR+uyjhmwvChimgmP9sm9ZQVxeAPk6uyRh3F/ih
	UOivG/SAw8qEcY5+U8xKzDsHZzVwd0DSfBAcmhbGs75akRi8U0AMMggBbavxhS2w==
X-Received: by 2002:a17:902:da90:b0:2b0:ac1e:9730 with SMTP id d9443c01a7336-2bea229c2eamr224637675ad.14.1779795101320;
        Tue, 26 May 2026 04:31:41 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ed6sm128269815ad.46.2026.05.26.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:31:40 -0700 (PDT)
Message-ID: <3693c03734bc30b8cbfb30e4f7692c7add387966.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/6] bpf: report hot simulated callchains
 when 1M instructions limit is met
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 26 May 2026 04:31:38 -0700
In-Reply-To: <20260526104556.5A3791F000E9@smtp.kernel.org>
References: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
	 <20260526104556.5A3791F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 10:45 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Missing Memcg Accounting for callchain profiles
> - [High] Stack buffer overflow when updating printed_subs bitmap
> - [Medium] Uninitialized stack memory copied to heap in update_callchain_=
profile
> - [Low] Log buffer truncation due to subprogram disassemblies preceding c=
allchain summary
> - [Low] Compiler warning on 32-bit architectures due to incorrect format =
specifier for ptrdiff_t
> --
>=20
> commit 77e8a884bb6c0c1595ff19bac7fba4cb9e4a26ac
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: report hot simulated callchains when 1M instructions limit is met
> =C2=A0=C2=A0=C2=A0=20
> This patch introduces a mechanism to report the hottest simulated callcha=
ins
> when the BPF verifier hits the 1M instruction budget. It collects and cou=
nts
> callchains during verification, printing a summary and disassembly of the
> relevant subprograms to help debugging.
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2b3584712ad28..8eb8f1ce17c76 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -17247,6 +17247,152 @@ static int check_indirect_jump(struct bpf_ver=
ifier_env *env, struct bpf_insn *in
> > =C2=A0	return INSN_IDX_UPDATED;
> > =C2=A0}
> > =C2=A0
> > +static void compute_callchain(struct bpf_verifier_state *st, struct bp=
f_callchain *cc)
> > +{
> > +	int i;
> > +
> > +	cc->curframe =3D st->curframe;
> > +	for (i =3D 0; i <=3D st->curframe; i++)
> > +		cc->insn_idx[i] =3D bpf_frame_insn_idx(st, i);
> > +}
> > +
> > +static int update_callchain_profile(struct bpf_verifier_env *env, stru=
ct bpf_verifier_state *st)
> > +{
> > +	struct bpf_callchain_entry *entry;
> > +	struct bpf_callchain cc;
> > +	u32 hash;
> > +
> > +	compute_callchain(st, &cc);
> > +	hash =3D jhash2(cc.insn_idx, cc.curframe + 1, cc.curframe + 1);
> > +	hash_for_each_possible(env->callchain_htab, entry, node, hash) {
> > +		if (entry->cc.curframe =3D=3D cc.curframe &&
> > +		=C2=A0=C2=A0=C2=A0 !memcmp(entry->cc.insn_idx, cc.insn_idx, (cc.curf=
rame + 1) * sizeof(u32))) {
> > +			entry->count++;
> > +			return 0;
> > +		}
> > +	}
> > +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
>=20
> [Severity: High]
> Does this code allow an unprivileged user (or one inside a container) to
> bypass memory limits?

Yes, should be changed to GFP_KERNEL_ACCOUNT.

> > +	if (!entry)
> > +		return -ENOMEM;
> > +	entry->cc =3D cc;
>=20
> [Severity: Medium]
> Will this copy uninitialized stack memory to the heap?
>=20
> In compute_callchain(), only cc.curframe and the active elements of the
> cc.insn_idx array are initialized. The remainder of the array on the stac=
k
> remains uninitialized. Assigning the whole struct here copies those
> uninitialized bytes, which will trigger KMSAN warnings.

That's fine from algorithm perspective. It only uses initialized part
of the array. I can change the code if it triggers KMSAN.

>=20
> > +	entry->count =3D 1;
> > +	hash_add(env->callchain_htab, &entry->node, hash);
> > +	return 0;
> > +}
>=20
> [ ... ]
>=20
> > +static void print_callchain_entry(struct bpf_verifier_env *env,
> > +				=C2=A0 struct bpf_callchain_entry *entry, int idx)
> > +{
> > +	struct bpf_callchain *cc =3D &entry->cc;
> > +	const struct bpf_line_info *linfo;
> > +	struct bpf_subprog_info *sub;
> > +	int i, insn_idx;
> > +
> > +	verbose(env, "#%d most visited simulated stacktrace (visited %llu tim=
es):\n",
> > +		idx, entry->count);
> > +	for (i =3D 0; i <=3D cc->curframe; i++) {
> > +		insn_idx =3D cc->insn_idx[i];
> > +		sub =3D bpf_find_containing_subprog(env, insn_idx);
> > +		linfo =3D bpf_find_linfo(env->prog, insn_idx);
> > +		if (sub->name)
> > +			verbose(env, "=C2=A0 %s/%d", sub->name, insn_idx);
> > +		else
> > +			verbose(env, "=C2=A0 subprog#%ld/%d", sub - env->subprog_info, insn=
_idx);
>=20
> [Severity: Low]
> Does this generate a compiler warning on 32-bit architectures?
>=20
> The expression sub - env->subprog_info yields a ptrdiff_t. On 32-bit syst=
ems,
> ptrdiff_t is typically int, so using %ld causes a -Wformat warning. Could=
 this
> be changed to %td?

Okay

> > +		if (linfo)
> > +			verbose(env, " (%s:%u)",
> > +				btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off),
> > +				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
> > +		verbose(env, "\n");
> > +	}
> > +}
> > +
> > +static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_su=
bprog_info *sub)
> > +{
> > +	u32 i, end =3D (sub + 1)->start;
> > +
> > +	if (sub->name)
> > +		verbose(env, "%s():\n", sub->name);
> > +	else
> > +		verbose(env, "subprog#%ld:\n", sub - env->subprog_info);
>=20
> [Severity: Low]
> Similar to the previous comment, does this need %td instead of %ld for th=
e
> ptrdiff_t type?

Okay

> > +	env->prev_linfo =3D NULL;
> > +	for (i =3D sub->start; i < end; i++) {
> > +		verbose_linfo(env, i, "=C2=A0 ; ");
> > +		verbose(env, "=C2=A0 %d: ", i);
> > +		bpf_verbose_insn(env, &env->prog->insnsi[i]);
> > +		if (bpf_is_ldimm64(&env->prog->insnsi[i]))
> > +			i++;
> > +	}
> > +}
> > +
> > +/*
> > + * Print several most visited simulated stack traces,
> > + * and a disasembly of related subprograms.
> > + */
> > +static void print_hotspots(struct bpf_verifier_env *env)
> > +{
> > +	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS) =3D {};
>=20
> [Severity: High]
> Does this code overflow the stack array when processing fake or exception
> subprograms?
>=20
> The verifier allocates extra slots for fake and exception subprograms, me=
aning
> env->subprog_cnt can reach BPF_MAX_SUBPROGS + 2. Sizing the bitmap strict=
ly
> for BPF_MAX_SUBPROGS could result in out-of-bounds stack writes in the lo=
op
> below.

Good point.

> > +	struct bpf_callchain_entry *top[3] =3D {};
> > +	struct bpf_callchain_entry *entry;
> > +	struct bpf_subprog_info *sub;
> > +	int i, j, bkt, nr_top =3D 0;
>=20
> [ ... ]
>=20
> > +	for_each_set_bit(i, printed_subs, env->subprog_cnt) {
> > +		disasm_subprog(env, &env->subprog_info[i]);
> > +		verbose(env, "\n");
> > +	}
> > +
> > +	/* Print the hot callchains */
> > +	for (i =3D 0; i < nr_top; i++) {
> > +		print_callchain_entry(env, top[i], i + 1);
> > +		verbose(env, "\n");
> > +	}
> > +}
>=20
> [Severity: Low]
> Could printing the disassemblies first cause the callchain summary to be
> truncated?
>=20
> For non-trivial BPF programs, subprograms can contain thousands of
> instructions. If these are printed before the hot callchains, the
> user-provided log buffer might fill up completely, preventing the actual
> callchain summary from being visible.

That's fine, app always can pass a bigger buffer.
Humans look at the log end to see the error.
I suspect bots do too.
