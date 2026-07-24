Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423F3C5833
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928603; cv=none; b=s9zSE/d/0BneTcIzGaSPT4xy+go3D0fK7HyhWeQtkRedKolrqbCCJH/k7in1urQzpK2LrH0wdDMuSEDH5vXJCbJmPOrs/nXbXrIWUM2lNcESfoVdLcmgAPLifCGKwQj10crRKH+i071em2gLbLzYSEE68B8PRNsCYw07NZKkvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928603; c=relaxed/simple;
	bh=zMBmgg/RBhSAgDWS7HX1nOGrgYSD0b1YbDOMXyaJheg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jEcItOklc6T116qj/0S1WEJVRZIgwV6o/Ouo7q+JTcuSQMpRmVOLTshYeX1hTcg9zOoCI1Jjw7r6DJkIvM6DG+ML5OcvcwgcVCoioKmziiM2X8HKuZv5wYo/4Bq6xKYnjis+XM81FXNWN0aYKxw+vTw00yETBoN/PX/FDNgQhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKAWZU+N; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKAWZU+N"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so2125385e9.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928599; x=1785533399; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vxFBFm2O/i4oFd59BqOJqDt/u+w3rUv+XhurUQThtEo=;
        b=tKAWZU+NpNfoD3YtJQsZJWo0+tAPMpBUygFdGLxtUpUb9WiJbsOMBvAk+XGZ8qjFsC
         pfYDO+9rB5yFgiU42zgmgcKLm1Zx2FlcoCqpWKnPexU38bBvnOHfJ33W5YlEw4EkM8M8
         4f043YSaKw9lYHKSum85SkCAkDRR+QsUEEMwQvbwS0/Aq8oLx+VCG/bD5Ws2NdThWjxR
         MFWC/niWbspKxdpllD+Jdb7uphV+A37huUqkbbr1aJI9xs1ZexN4y9lJGvK79ut2/EsG
         jwxv1ZxBw/cKR1cpG2owB0Q1bUZ/JoicDVOIANFkCkHi9f+qeBZ1IWw8G7FDTNb/oRZ4
         t8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928599; x=1785533399;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxFBFm2O/i4oFd59BqOJqDt/u+w3rUv+XhurUQThtEo=;
        b=HFBaGb5BFEq3QWWiLHuCrM2q7BQFA+/QyThHSMM0jJ81uXcUD1d19Fa+FEpiLEgalH
         2YqkREjrZeoNYJU/b62cJJjdvEkCfImD6i+ahDM4klZzWOM+FjTnuLlvZbvA7khF2OhJ
         aTe1yh1ImGAjXKCVmgvhvlbrCxVx3F5ZymcnxSFvuzXk8lPbuKhVFLi6hqrfMkSmhc+D
         noNx1378jja3Wuj2YVeldcCXa4fRAakmRqgCzAvV964bHBN3BrwUoRkWfc81yBvUf6vT
         Z81uOs8bvAjdE8SPItyVCAkMo++WrTs3qouvaTk8JPqI79/ogPm5ube10AGaCwytu+u5
         Mzuw==
X-Gm-Message-State: AOJu0Yxxm8Sk8mgGTgf988VC4v3CE3GoXci9KJTRBKzedYYD22hJknB8
	eobFoB4+SWCvqr0PNZCRQRi9yeA2g4xs2dJIqQvcxfhFNpQ7fBbU4fZR
X-Gm-Gg: AR+sD13qB8bBGJ2S5FBmCJPB517gLW5IP2QxoNxkZlZaQ3yoDvyA/FJv+8VKzNW40yy
	8CC/PIxnCn0tXshnT0tIYYr0IdYqb6hqOhJFmALWdT2hrmMNbl+jIuQJj16x+VZpuv+QhBP835J
	bl+o0PXqZLQbS+F/rn6hVopO8yeDvUTZc5bftVDtBaIAzJGqNKUuni/FACxIsHM5o4DiVFi8VeU
	wc6K3dJr1LL6VfLcCD9eK81OEICsXbJPutASvixawkdAY2/zBBxUBH48Yvx+phAHR89t1ZRpEPY
	Zr/ZA2cXS0z5MxJmbELSs9uaHLK3JS4CX8eAMpRmc8blE7jcSXfgy1jZNtyohXD44U9ufA07rYF
	GQllCcpe5sK7xTKiCkxKyYrXHi6wRh17pckZ2N3vbx8Iv0e6F9AGLS0LPTQ2mpTmAk04c3yDMhF
	AMMt8RHME032vgJ57tagHkI/ivYsvnmkkSE47dIfoijMutTYjGx6t6tpCGwUeKmWH6fIN9qS5V3
	UgnYLzUZnp5DeRUmLZ/8JzXtIMiJrLcefQ7a3jEj3VP
X-Received: by 2002:a05:600c:500d:b0:493:e583:7053 with SMTP id 5b1f17b1804b1-496b5728b27mr236365e9.35.1784928598853;
        Fri, 24 Jul 2026 14:29:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f33b73sm12707905e9.14.2026.07.24.14.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 23:29:58 +0200
Message-Id: <DK74DPZIPH5I.2ZST2KB0Y63PY@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-3-ameryhung@gmail.com>
 <20260724192840.1BB2D1F000E9@smtp.kernel.org>
 <CAMB2axPaPthdQ-pVG0PV21Wzw=dgWnFdPqi5FuJ1EeAEde-P1w@mail.gmail.com>
In-Reply-To: <CAMB2axPaPthdQ-pVG0PV21Wzw=dgWnFdPqi5FuJ1EeAEde-P1w@mail.gmail.com>

On Fri Jul 24, 2026 at 10:49 PM CEST, Amery Hung wrote:
> On Fri, Jul 24, 2026 at 12:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 3 potential iss=
ue(s) to consider:
>>
>> New issues:
>> - [Low] Multi-line comment does not follow the required BPF subsystem co=
mment style.
>>
>> Pre-existing issues:
>> - [Critical] Pre-existing verifier panic when an array map is passed to =
kfuncs like `bpf_wq_init`.
>> - [High] Pre-existing logic bug allows mismatching maps to bypass safety=
 checks in kfuncs.
>> --
>>
>> --- Patch [2]: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argume=
nt checking for helpers and kfuncs ---
>> commit 08bfe87a36be7126ec3db2d3ab4783e72b62e453
>> Author: Amery Hung <ameryhung@gmail.com>
>>
>> bpf: Unify const map ptr argument checking for helpers and kfuncs
>>
>> Both the helper ARG_CONST_MAP_PTR and the kfunc KF_ARG_PTR_TO_MAP
>> recorded the map pointer in meta->map and, when a map was already
>> bound by a preceding timer/workqueue/task_work argument, rejected a
>> mismatching map. This logic is factored into a single process_map_ptr_ar=
g()
>> used by both paths.
>>
>> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > index e8c76abbf76a2..a3429610b426e 100644
>> > --- a/kernel/bpf/verifier.c
>> > +++ b/kernel/bpf/verifier.c
>> > @@ -8274,6 +8274,44 @@ static int get_constant_map_key(struct bpf_veri=
fier_env *env,
>> >
>> >  static bool can_elide_value_nullness(const struct bpf_map *map);
>> >
>> > +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct b=
pf_reg_state *reg,
>> > +                            argno_t argno, struct bpf_call_arg_meta *=
meta)
>> > +{
>> > +     /* Use map_uid (which is unique id of inner map) to reject:
>>
>> [Severity: Low]
>> This isn't a bug, but does this multi-line comment follow the preferred =
BPF
>> subsystem formatting?
>>
>> According to the subsystem guidelines, multi-line comments should have t=
he
>> opening /* on its own line:
>>
>> /*
>>  * Use map_uid (which is unique id of inner map) to reject:
>>  * ...
>>  */
>>
>> [ ... ]
>>
>> > @@ -12122,36 +12140,9 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
>> >                                       reg_arg_name(env, argno));
>> >                               return -EINVAL;
>> >                       }
>> > -                     if (meta->map.ptr && (reg->map_ptr->record->wq_o=
ff >=3D 0 ||
>> > -                                           reg->map_ptr->record->task=
_work_off >=3D 0)) {
>>
>> [Severity: Critical]
>> This is a pre-existing issue that was not introduced by this patch (in f=
act,
>> the patch appears to fix it!), but could the old code crash the verifier=
 here
>> if a BPF program called bpf_wq_init(wq, map, 0) and passed an array map
>> without BTF for the map argument?
>>
>> Since an array map without BTF has a NULL record, evaluating
>> reg->map_ptr->record->wq_off would result in an unconditional NULL point=
er
>> dereference, leading to a panic. This could be triggered by any user wit=
h
>> privileges to load BPF programs.
>
> [...]
>
>>
>> [Severity: High]
>> This is also a pre-existing issue that was not introduced by this patch,=
 but
>> did this original condition allow mismatching maps to bypass safety chec=
ks?
>>
>> If a BPF program called bpf_wq_init(wq, map, 0) with a valid workqueue b=
ut
>> passed a mismatched map (like a map containing only a bpf_timer), the
>> mismatched map would lack both wq_off and task_work_off. This would make=
 the
>> condition evaluate to false, bypassing the mismatch rejection and potent=
ially
>> leading to type confusion or memory corruption during runtime callbacks.
>>
>> > -                             /* Use map_uid (which is unique id of in=
ner map) to reject:
>> > -                              * inner_map1 =3D bpf_map_lookup_elem(ou=
ter_map, key1)
>
> Yes and that is why this patch use meta->map.ptr->record that is
> already verified. I can also separate it into a standalone fix
> targeting bpf if needed.
>

I think keeping it in your set is fine. Since this is not reported I doubt
anyone hit this in practice, though I agree it's worth fixing.

>>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1=
458271-1-ameryhung@gmail.com?part=3D2

