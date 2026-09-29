Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B2320A34
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705818; cv=none; b=QyjmsFnRsA8mkN4G+Ae6115g6IWaFncDLlRwcs3i/jLVkm1wZhqtcn0yKDBDZbbSm8U0J+Ag0RSPJ13ZpGNJSpAMA7RnZBI5vVR3Sd1N9tlyywSLvaM37dnP4J5rTsXkgDQ8f6m7UYG5E+uqgF4r5CMvQRlV94C1p6M+NyNJgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705818; c=relaxed/simple;
	bh=xIgvQhjLzjDn0M61maakhxdu6V3uS9ku8v6H8LXUFKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUlwZzkPWB7MyTJoI0LaJOjvos7iCvYZtz4Loq2LNIHfy0BPI3WymxV8n3KsUefVLtJWGMlaUNBUEfiuDMC5qExCthAYr4CP+yrz6qyetuxOoLU2RT6kei2l5b8EYT7PiemkuTNOpK+IScgdPh2Ea4ULa89Pz6u94Ogi2fuwntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCeO1V21; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCeO1V21"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342568a5b54so2044672eec.2
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790705816; x=1791310616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r9GVS6fYYXvapW6F5oWuP0VOtfFOhKVRg73n+zN/6hc=;
        b=OCeO1V212wYpy4Vw835Nl2g3BddEf6cyQpqw9YJPymCYZaj1t/lnOFnkrDaTpdpTzm
         AmXkO1x8kn6rFzyL1f7H80k0GZMc8Rx+3EQsjenQDySyVWoFG7lR3Nv2dQj5z7bDRxrx
         5P65/gpsAT/IwXCUjrVcpJfe08FXeQGl09xDn5+8rhf5SD7bZcMQiwEoleW8sEhb5UT0
         BEP0AEjFyhI1RoO7KM+dvUGcpidBIMb/RbGM/epj13sCPeO9jVV6xLXA3IvAtsv8jM91
         xAUw04TATfkBdSiLycf0OMBRhTBunNzl7Kr8yQbi0txD2b7TBo1QJ7GXVgAgTzVetjwn
         bbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705816; x=1791310616;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9GVS6fYYXvapW6F5oWuP0VOtfFOhKVRg73n+zN/6hc=;
        b=tSO+wU0aHJY/avIxyE37S5hfUS7fcPTmkPD51X80/PmCMlrupOLASa6+G55x457ZoS
         aS0qzCeRFpl7dYD34FtR2d/7EH3N59hLLBHVjxhW4C8qOf+8aKPtyxp+yCZ29ip1OxFq
         zc/ZLq+EMoj1pheC+0XsIForvCbmf6RT4TImQ7pnEyQrU9COhbEFJ8vzl3/K7MGO1Ahr
         TdHmnPycnO06Yu4h/7AOxqj7uFM9efEKJrJjM4vF7hPP/RlethThkwcn35aKVE3lSY6/
         4nKiZ/Vzh4VByCHyKYEpLC768DWI6cUah7QT/b7UP2BM8cnPKOVwW9hIdJE/biTnpHRd
         CWkg==
X-Forwarded-Encrypted: i=1; AKwUvBzDeyBde7o9vT5/feG7ELPDadQy4+prX5kmR27IRP4hN4oanX5vjCjTO4/O+7jue5vv3Vc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKB7ju0yLg1gjDCrY/gbbGooqyggvAEd4avQ9q+3mQgIktT2h1J
	tDRwEt3saNC0SudIJj5hxknTfIEjxJLpkqfRIQ1WQuUWwkryDmQh0fF2
X-Gm-Gg: AYBFou3nTLf5Up4V6eBz8pizjxVoSLR9l+Af/H2NfpldI8ItiilSiqezovmfU7rayF1
	qFAbM0ki0n+jSlg77rku9ydZZLHLjWGnO7W90njwrM8xvcXT46LSY92sFXHZm3Q0izbQ4EmC/p8
	EtGqfQcyQSsjXy6KuIHhR5eBTzh3SIfrml79PE9h1FVKFyAI9hd1FPnHq8Y4n09rGtRNEqUGC/d
	tvg0zXZ/JfNnYjQYkY0yXZCfd/dhu8wafTYNAPn6p+IkpMZvSmJNG7SKwoFbTmHXdfRlsPC2O1V
	I6HERueaZTg6eIX0OGS3gfn2MEYKmJmE4ABfP+uErl4plpxSlq7+DUyMSGFUmRPvkTD7nLPI24n
	UgbFBy/X1/MVa79K+Jsd6rFKoov5X/KuzcjmLvP69ua2alOBHSQgHBc10Ss6hF6k7jA5sDmqMA2
	PKt6eRwT2CjTSpVTrf4ps55J83ynbEizHVvLc5iZSuo5AQQX2uoSRqh0080CM4h+QftxMUiuLCG
	O8dONX77IwyPOfmwHo4ieqXEGTHAQourZLJpSLxf660oT4yqBe6UQzI
X-Received: by 2002:a05:7301:4882:b0:346:d87c:b76 with SMTP id 5a478bee46e88-34c65c61e0emr194224eec.6.1790705815709;
        Tue, 29 Sep 2026 11:16:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:abbd:bfa5:f574:cca3? ([2620:10d:c090:500::7:dfd3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c38bea1bbsm817659eec.23.2026.09.29.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:16:55 -0700 (PDT)
Message-ID: <423cf77e8a6a03287cec604b21c19866360c262f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/36] bpf: summarize live stack slots in
 insn_aux_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 mason@kernel.org, 	ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 11:16:52 -0700
In-Reply-To: <e5585bc7a06dce553e5f262fc19e2a343ff1358b7176d375b27e8094239945f0@mail.kernel.org>
References: <20260926-scev-minimal-rebase-v1-3-c8e5ab5ba79f@gmail.com>
	 <e5585bc7a06dce553e5f262fc19e2a343ff1358b7176d375b27e8094239945f0@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 20:26 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index c6d617581e84..7f31ce5ea6b7 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -667,6 +667,7 @@ struct bpf_insn_aux_data {
> > =C2=A0	 * that this instruction may write to.
> > =C2=A0	 */
> > =C2=A0	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
> > +	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
>=20
> This isn't a bug, but would a short comment on live_stack_before make it
> clearer what the field holds?  Nearly every neighbouring field like
> live_regs_before and scc has its own comment.

Naming is clear enough.

>=20
> > =C2=A0	int ctx_field_size; /* the ctx field size for load insn, maybe 0=
 */
> > =C2=A0	u32 seen; /* this insn was processed by the verifier at env->pas=
s_cnt */
> > =C2=A0	bool nospec; /* do not execute this instruction speculatively */
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index c871744ca5a8..b6b7fd479569 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -729,8 +729,9 @@ static void half_spis_to_slots(unsigned long *slots=
, const unsigned long *mask,
> > =C2=A0}
> >=20
> > =C2=A0/*
> > - * Precompute, for each instruction, the OR of may_write masks over it=
s top
> > - * frame across all func_instances reaching it, stash it in the insn_a=
ux_data.
> > + * Precompute, for each instruction, the OR of may_write and live_befo=
re masks
> > + * over its top frame across all func_instances reaching it, stash the=
m in the
> > + * insn_aux_data.
> > =C2=A0=C2=A0*/
> > =C2=A0static void compute_may_write_masks(struct bpf_verifier_env *env)
> > =C2=A0{
> > @@ -746,9 +747,12 @@ static void compute_may_write_masks(struct bpf_ver=
ifier_env *env)
> > =C2=A0		if (!fm)
> > =C2=A0			continue;
> > =C2=A0		nbits =3D frame_mask_bits(fm);
> > -		for (i =3D 0; i < instance->insn_cnt; i++)
> > +		for (i =3D 0; i < instance->insn_cnt; i++) {
> > =C2=A0			half_spis_to_slots(aux[instance->subprog_start + i].may_write_=
mask,
> > =C2=A0					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
> > +			half_spis_to_slots(aux[instance->subprog_start + i].live_stack_befo=
re,
> > +					   rel_mask(fm, i, FM_LIVE_BEFORE), nbits);
> > +		}
> > =C2=A0	}
> > =C2=A0}
>=20
> This isn't a bug, but would a more general name for compute_may_write_mas=
ks()
> make the function's purpose clearer?  The comment now describes computing=
 both
> may_write and live_before masks, but the name only mentions may_write.

Nope.

>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/363465=
43957
