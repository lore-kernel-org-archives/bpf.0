Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5530B529
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815382; cv=none; b=fihCku1mc5V2Ir3S+9sLP9smbNiO7OmO4khjkm92D3WF+FblgE5vGFqMYQ0qe9EbbobXsIx9XMamZ/13K68+D/DLOkllZzSOPA7lP765xX7cqc5TPhJkksS9UMx5ExNtkQPWMqVDjgO7cQyNUW9tMOYdvEwrt1uKZrBe5IEGrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815382; c=relaxed/simple;
	bh=W5Ygua6TaXhRcxGlyTrL8dVlgz3MVvXGH6eKbOda6Ho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPsx2XjDMjErljtAxE5v9XzeAsnOihAllCYwsCmll9vL7vSROl1z9camt61s99zEVZXCorOkd38xoHX2F3fEWdRXAl45MeTrpMmxR66Xu81Bm+sGR9SKw87zfRiuKNGPj68A+mWGNWqfU38rb2krsvVMnYvx20NZDWS5x1wIhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdGHwRr/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdGHwRr/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84847482584so1425070b3a.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786815380; x=1787420180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Cxp+xBMdKsLmzNFKZIbpqNhtoL4cVtzJ578AS/oGpM=;
        b=LdGHwRr/ZhInGscYUYg0TDm1eHa9Ih/4uW2VBqDA0osVtIv99whmtQMIX4v4XIzxTg
         2tPczM+kNsU5IL+2ac7vTM8r/eh0KACEkGPI4cWw4Sg0U9KXAtMiWEoEwdt+GpMyXQz8
         uAPxlDB4u/l+jAUsymuQTii56UsePGrauAfKn0dq63uaXHwwFOBrrzmpYt/XL94dA0aW
         rbZCGCCucNjfS50MSgPLuEUdeh4FtEu7mIMimGbM8mpAhrtkcalIfYOV7DeNibSte+3f
         6eNa86NjEHVvYyitPw2xJk851H7lS5ttRNP7LdjmD5oCeA9SEQq45CTGk4yVCfeYqWh5
         rA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786815380; x=1787420180;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Cxp+xBMdKsLmzNFKZIbpqNhtoL4cVtzJ578AS/oGpM=;
        b=fYa00/+M/Nzo8GspnhWiQcYeD2fMTFUA8j9rI9EM5rEBFCrwxPqLQECLmhsVpSL7zw
         AVNArDO2eBtTASTseqgJLLtw0pGkKwjaV52nACNMu+ZGY7dp/R3EgaoOXE7igYrUuA6H
         agluoWqoq2NvMDWIMDy2xjwIgR1ToTw6hsyI1RD0p+2KOQ9rqdaVHgj/2aL1d2YIbcrJ
         gIsixoE7WbwqGJZXchXTBPlHTJgto6e1dLiFe4SCX2LedN7kRB9xtFaPsN8ll89q/FOy
         nZursY01MrAEf41DXEBIKReYlOd5B1b4BaI4tlmlUr/HU7Fkrf0CParsEAsGqh5oJRqn
         9oTA==
X-Forwarded-Encrypted: i=1; AHgh+Rohq4VfcfdlUCkU0tBCKSoEE5nbcTipda/nKfxPAGFlxkW8jowaeDyLjx8vfP2JX9+FMlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqJBrUvDFbpxAlku3wbBqOcoSsatTV2fBBFkUHJn6zB1zS5ZP
	cgx3xHSA6P6yVr+VRe3eq9eJmVSqjc9EKNAepop3IefGQJz1ej/8yGnn
X-Gm-Gg: AR+sD11eG/+o7OdiMGN20NinPVHKf4sj4jUDR4MszViwO+6vmQL1WO4e87bAjvtGPjA
	6y+p4VrA+8BhOMoWSLO6bgrLTZGkgsdAXtmH5kJdXmTK2GDqWeqrGgIV6Fr2clz0V8K61Ji3lO7
	C7CKSspGQlPdUvId7WUNxPPgwqFuv/GW2eW0E5Kxguvzptl+BCFLPxC1GCw6c6AybuWxSzd0feM
	fTDV2+j/tWRq+lLpyX28Go+tYuusZIp40kLlnXrHaWPSFP1slpEe83YAiObUl8oA6s52n6guQAx
	14ia3QjibG0UpYDMpeyEKjk5mwwdXrZ50SE6V+EfbLD6MUgGYZP7AnydY1zPdehxRYGIarPDNHb
	WZZT+IM26d6y3WTlo/s6G+d/8qK9YHPW8Dj+y1dTT/zRDwZg2EHiI+BefMiGuf2QldgP0C2ETSV
	IFK0RKSv0zKt64wfX5gLdCs8dVuzrobZBhuJ816oaoj8Rp/+1WROFlDpe41T3gjNDkOUhMmZuwz
	Nlj9SPIx7/T+0On
X-Received: by 2002:a05:6a00:bc0b:b0:847:950b:b71a with SMTP id d2e1a72fcca58-84fdc7c6b53mr11700358b3a.16.1786815380356;
        Sat, 15 Aug 2026 10:36:20 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8518b3ff418sm491767b3a.19.2026.08.15.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:36:19 -0700 (PDT)
Message-ID: <ea92f8fc6fef805d35a0d770df3b9dcd1931d0ed.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Report Resource Lifetime
 reference leaks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 10:36:15 -0700
In-Reply-To: <6c6f4191cbeb46ebbb55441a67f95e48778ad1ae155d493fdb03cc7c3813e84d@mail.kernel.org>
References: <20260815064612.378577-11-memxor@gmail.com>
	 <6c6f4191cbeb46ebbb55441a67f95e48778ad1ae155d493fdb03cc7c3813e84d@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-15 at 07:34 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> > index 058574a1411e..5d20ea9e470e 100644
> > --- a/kernel/bpf/diagnostics.c
> > +++ b/kernel/bpf/diagnostics.c
>=20
> [ ... ]
>=20
> > @@ -1735,6 +1736,96 @@ void bpf_diag_mem_bounds(struct bpf_verifier_env=
 *env, u32 insn_idx, int regno,
> > =C2=A0		env, "Add or adjust a bounds check that proves offset + access_=
size stays within the object.");
> > =C2=A0}
> >=20
> > +static const char *diag_lock_name(const struct bpf_reference_state *lo=
ck)
> > +{
> > +	switch (lock->type) {
> > +	case REF_TYPE_LOCK:
> > +		return "bpf_spin_lock";
> > +	case REF_TYPE_RES_LOCK:
> > +		return "resource spin lock";
> > +	case REF_TYPE_RES_LOCK_IRQ:
> > +		return "IRQ-saving resource spin lock";
> > +	default:
> > +		return "lock";
> > +	}
> > +}
> > +
> > +static void diag_res_report(struct bpf_verifier_env *env, u32 insn_idx=
, const char *problem,
> > +			=C2=A0=C2=A0=C2=A0 const char *reason)
> > +{
> > +	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, problem);
> > +	diag_reason(env, "%s", reason);
> > +
> > +	diag_section(env, "At");
> > +	bpf_diag_source(env, insn_idx, "error", "%s", problem);
> > +}
>=20
> [ ... ]
>=20
> > +void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc=
_insn, u32 fail_insn)
> > +{
> > +	struct bpf_diag_history_opts opts =3D {
> > +		.scope =3D BPF_DIAG_HISTORY_SCOPE_REF,
> > +		.ref_id =3D ref_id,
> > +	};
> > +
> > +	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, "unreleased resource")=
;
> > +	diag_reason(
> > +		env, "Owned resource (id=3D%u) was acquired at instruction %u and st=
ill needs to be released before this exit path.",
> > +		ref_id, alloc_insn);
> > +
> > +	diag_section(env, "At");
> > +	bpf_diag_source(env, fail_insn, "error",
> > +			"owned resource (id=3D%u) still needs release", ref_id);
> > +
> > +	diag_print_history(env, &opts);
> > +
> > +	diag_suggestion(
> > +		env, "Release or transfer ownership of the acquired resource on ever=
y path before the program exits.");
> > +}
>=20
> Does the exit-path wording fit all three call sites?=C2=A0 bpf_diag_leak(=
)
> says "still needs to be released before this exit path" and "before
> the program exits", but check_reference_leak() is reached from three
> different code paths via check_resource_leak():
>=20
> =C2=A0 process_bpf_exit_full()=C2=A0 <- actual program exit
> =C2=A0 check_helper_call()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <- tail_call rej=
ection
> =C2=A0 check_ld_abs()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <- BPF_LD_[ABS|IND] rejection
>=20
> For BPF_LD_[ABS|IND], the reference is not lost at an exit at all.

Bot is confused.
