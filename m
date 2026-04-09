Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88939A07C
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777664; cv=none; b=CC3aExYx/3FYv9ygSO+CJFkxMmr29tWUov1A2BjKl2GMo19KIp90PnDd11UVqfqc0ZXNdABuJ30E+YK8uiJm6gc301wz6dvEf9i8TGP71Gb8toWPw35h/UMBP/TfNEoRs6IMuorRhaOAusTe0jgPTrepIzplKd80o1hpdJ+k5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777664; c=relaxed/simple;
	bh=EIdxGMWke1rIfxytpEj3r5RV6a5aJBMS/ZMnwnRoigs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVffLXpZthZbL9h+mzk4sP10sdCXUev0NXCDI6jj+SehWVRxV1A0xT7UPNV5PbU2nNftSm1wr52S7WN4rszTm2uOtsXoXMwkmwvY0JzhekrRrF+Ks8j7VVYkR4MUx2K9fHKlIkkNPXWgOuLONxtIp8x+cV8KdKRW16A5bAaecAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJGGX2rY; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJGGX2rY"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so2382868eec.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775777662; x=1776382462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vaAaH9u2UhsJEfaQzE5mO+rH2IRFxpPVn2KgDkiMcb4=;
        b=UJGGX2rY+ul/TIz2mohwbfv2EsyLdcX9kzyN9Lt55DFpjVOJQuZRh9d2eMnUH04Hen
         vySav7wUYk8ZaTL2KTP23wo/LEEG5koNk2aE6PmLVLDtaLfUl2FgQabZBxvoQQStWAN/
         NTJ95U7tkSYGa2cNmUyalV1RDu4rbBdn3U67rDLHFTIWGlGC0q5Mc7fhNgV4QnDKGluy
         vDkXARwdQBDuJfchKu7uG5xcXLHKMb+XvNAnMUcr6E2jwd7x373QAgojJ6ucLvOPuqOJ
         X7tFwL3+e3GpySzcBaI1i/e3mTxspNAcjaPWAgEQ9GWor3P3wab0yWkBFkGWupxVNefa
         ztgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775777662; x=1776382462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaAaH9u2UhsJEfaQzE5mO+rH2IRFxpPVn2KgDkiMcb4=;
        b=lfh7l3uCo5D6dVz2rClTF7OTE7Gdp3pNbjpRzKoUgIh4wh+Oiqk2ueh2Eh1nlAAeyl
         urnv/SNA79XEOPksglxZvEIykrNEupeHAPwBUEWh67xCH87QYWAbtfb8bwify4QrRczc
         pQz8hCZaSDFR+VuNC9Yi4sq3EQcECozo/rZ3OjkgRa2FWyHTYmdHvkc6WscUWRmGdRi7
         Z8Xu3noOIQbXwzOJ890l05p9EAwhrW8YkFjwRdzkR+5cfpIbvyAVNz27rXXU3CYZZUmN
         AoZjN1RlnLFtf3m3/sRkVRprZoTBwWZSegE2P4/j/PIjBsYUTCwN+JueSJNjRhclJPX1
         v3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVwR+DWaAKM/NOWFqE1T5NpTMkvvYBBZC3CvIPeDeyicPO4WgVuYvyK7SY2SxJqSzTEO5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBAKHl+d6+OYf6s+zQs7fgXrn977qD84oKtfruDjuqBgB+6GR
	lXP1KdK+CJtIkXPzhUlZDVG6RmN2OBcCPt2azYPBZCc24/ZA4KrpdNPC
X-Gm-Gg: AeBDiesUjPAyJSHYwp1wpQ2EcbqH7bTTbJkkBVVTO1tJNldW/jTLB/qBe0/ZwWiUYX6
	xHxr6TE9JU7NdPW5QaadLqnrR0YLHfxSddvLXionnQwMzk7csJbAa0UYZeRnEwlAKmNDKvtTTQc
	s0TzQcH5gmgY30Nq6g5Yj9mOa1yc7KaW37TIs1JVOQgQ0t3H5UMF8dfJpjStE8H7pmEAuEAjWyI
	fpyE1ylLENoURnvmcxlX+BgJ6chYLJ+VoUzAWQpFzKbQ3oji+QssZFJ+Bgoe570+5R8o2GH28WF
	UBvPIjeSDqdmhk8f57ybdYIGe5p9AnLD5nFRmwAB/1dv9KAiM/2blF6diPQrjHiE/60f4qPLowj
	B+YSgo4I/gQKUE+z/4Sed0GPwIJSAYUTqGUtdN9bRy/uuUolu4v1W4Dpul13UHybjJAzLXjp47+
	pNwxVfPgTzLNm1AJo4ivQRH4n+sTpXGQSZEMGHllD4WP6wFp06hmi+1YoL/mN3BtHdVKs7wVHmb
	tbzOgab7GAyWiHbrw==
X-Received: by 2002:a05:693c:2c96:b0:2d1:d434:cfe3 with SMTP id 5a478bee46e88-2d5844b6cb9mr731704eec.0.1775777662306;
        Thu, 09 Apr 2026 16:34:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7da6:9d9:d70c:7407? ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde70csm2228279eec.15.2026.04.09.16.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 16:34:21 -0700 (PDT)
Message-ID: <5862e2cda1c76e71be03a4cb4bdf6a95e3994f8f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 10/14] bpf: change logging scheme for live
 stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 16:34:20 -0700
In-Reply-To: <e95d13fbead722599e4564be81702065da89034039d3dffa005eadb41b5f9382@mail.kernel.org>
References: <20260408-patch-set-v1-10-1a666e860d42@gmail.com>
	 <e95d13fbead722599e4564be81702065da89034039d3dffa005eadb41b5f9382@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 02:14 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index c3098369bee8..832c10846ec5 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +static void print_instance(struct bpf_verifier_env *env, struct func_i=
nstance *instance)
> > +{
> > +	int start =3D env->subprog_info[instance->subprog].start;
> > +	struct bpf_insn *insns =3D env->prog->insnsi;
> > +	struct per_frame_masks *masks;
> > +	int insn_idx, frame, pos, insn_pos, i;
> > +	int len =3D instance->insn_cnt;
> > +	bool has_use, has_def;
> > +
> > +	if (!(env->log.level & BPF_LOG_LEVEL2))
> > +		return;
> > +
> > +	verbose(env, "stack use/def %s ", fmt_subprog(env, instance->subprog)=
);
> > +	verbose(env, "%s:\n", fmt_instance(env, instance));
> > +	fmt_instance(env, instance);
>=20
> Is this bare fmt_instance() call intended?  Its return value is
> discarded and the tmp_str_buf it writes into is overwritten by
> later fmt_spis_mask() calls in the loop below, so the call appears
> to have no effect.

Should be removed.

>=20
> > +	for (i =3D 0; i < len; i++) {
>=20
> [ ... ]
>=20
> > @@ -1805,6 +1896,9 @@ int bpf_compute_subprog_arg_access(struct bpf_ver=
ifier_env *env)
> > =C2=A0			break;
> > =C2=A0	}
> > +
> > +	if (env->log.level & BPF_LOG_LEVEL2)
> > +		err =3D print_instances(env);
> > +
> > =C2=A0out:
>=20
> If the for-loop above breaks out with a non-zero err (e.g. from
> analyze_subprog() returning -ENOMEM) and BPF_LOG_LEVEL2 is set,
> this overwrites err with the return value of print_instances().

Should not be clobbered.
