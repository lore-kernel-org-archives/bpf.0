Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABF311954
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420544; cv=none; b=aYJSt5etN1w8s4ZmrowpqEy+/8fFXMvph2oUg+Oi3CP+20SWL5gW4xrZirvPjrALKrUaAtcMWFPXPNuH0xGUnJZl7Iyj5jKNNe6EJYNWkrqDWrBT1WesLnMB2TmdBvxLcEjRJh+D7iH2N3lqnHapx+KAdwGMfOtfcGISYB/yZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420544; c=relaxed/simple;
	bh=1hR2qqa4Y1OyuOCxf1xs9FpGdy5pT7ECAJJx/9SSp+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RBQH3qaYoNwnXswPQ5wml7kH0ImkC57UTVxa0JiHsIWmFNU0JYj0dwtN290fGdYTsLjUGJ0syWYe71zfxWg2BfluYiASsIC+ON6JN2rzEv/CGtbeIqpPSHvsGL/xAfNC0Fh+nmXXXlZvw06ZrfOTifW1u9dSANeqJJWkRkPIoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGC6t3SQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGC6t3SQ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so205206295e9.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777420540; x=1778025340; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g7B8Ypo4SoUpZreQw8z2INkCZakr2UWz97FZIj+cH0=;
        b=pGC6t3SQ2k3QEnO5xn33V8UMdxpF0levZ2QvSA2lhgkB/M+ErfwgChWiQ8oWYKoH4w
         OrU4bsyideCqBVfR1BHEa6me2krTlBpCFx6K3cw3i+BeVDXz1cF8yJnRy2gmReFjRK7h
         g+XDBNl2JhX+N+iu8LAfwr6LPe4suTv7Fyk6TGUQCWyjKP+N8q2Y0yf2iEzDKG63JiMu
         u5hbgrIpzLGA/qhUf+fsLGJ8q2J9RlHKYnC18yRPucl0xQvq0bvhTNiK3y784sQ4Kgii
         dEHpBs7BrFgF7sR59+zg/G+mGAGUQNgOJFWi7HNjn1eo+7IJqIrtsMgXJvfxbNsuOYKk
         f6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420540; x=1778025340;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g7B8Ypo4SoUpZreQw8z2INkCZakr2UWz97FZIj+cH0=;
        b=k26nIF2VmWGl3PwJJIDY+ECz3r4ZSvEr2xZ4vRYnMEIlRnqKTKYehFXYCrsHJdt338
         eJuOH62J4inXPzyYV5TcnAlVcLdnnScDcCQLId2eG+bRV8LFMSJ5/t4yGBBuK0ztkQwJ
         QODHCrFyH/ZOZc6tfVhI7bx/IVWN5txHE/zUX1H1QpaXhZomMEwfZ/P0dghZCTlva1DH
         VRXpC+lmQY5yms7yuJPZRZLOPGw0lVVLJKwst/rW6ru5K2qf93P/PapBEgOMhbdOgAxJ
         E82MsPXpe1OJqQ+u1l3Nm+ZhPcKhPbRlWuu4zgPg9vWCh2J9lafW+qL5v8tVBQYag8yK
         YRAA==
X-Gm-Message-State: AOJu0Yz18xKopYxnrV21zMzoGyNSl+DCZHPtA0L6FaYd/gX8wHxQiv5C
	5S4GFjOCcL5ATjLP1B2RyCBYhRRFxPYFHVOFR0/wH/KDnpuGZRezthdH
X-Gm-Gg: AeBDieuDBWRMKmvaY8EQUtzbnpeWa2nshRHDflbbxkMvJypBVoNMAuHQWpZ4a3TfbyZ
	eA5byAwC/A7qtz69mRnVHqgqIDrc7GRI+4MOy+aW1VY1D/7oxhyqbjM4oakNC8EDLdhvnLpufYU
	tkKxjPZ9y/ni7MHVEoxyHO5+MqYDikLgT2lEZnNpWjiBwwlKRZJb7Nj5uiE2opvpISiFZnGfGyh
	vW/r2jk4NEQnyHuTcoCsbKILbq/UAIjXtz94+fxVGcVO2PdaegZUoEnd+u3IxbJV4jlNkO9EDV8
	8HsOWd+C56/B/erdaOVy7VpibLcHZtalzc0kADTDMhrx76CVBPt94Rc+JpoUrsQBo5DvKQQNeVY
	fHxXV+8d379EhLv29VfpL1TPusw2Vg83UMrwWUSEZnk3FhUsV5Sy4sMjI+dSCpUkCKhUHrc2ItS
	LTd+SVYTIHgsEI0XjBHnBTzuRpPjMufhBvgi1afTnDB4NAW7S9CSw+wxd8ZBzQx35D21gRxteY9
	RXxd3gOBEjZPKG5QRFzFhYFUamFEqM6A4g9oQhdyWaFX8+mFx/AQNPGfc4Ap1sPt+EKUXUI889k
X-Received: by 2002:a05:600c:2e0a:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48a7b59d1camr14855135e9.16.1777420540294;
        Tue, 28 Apr 2026 16:55:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc7a359sm26899535e9.10.2026.04.28.16.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 01:55:39 +0200
Message-Id: <DI56ZVH6HKDK.1L8J5HPA37J09@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by
 subprogs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko@lists.linux.dev>, "Paul Chaignon" <paul.chaignon@gmail.com>
X-Mailer: aerc 0.21.0
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com> <20260428230844.EFA64C2BCAF@smtp.kernel.org>
In-Reply-To: <20260428230844.EFA64C2BCAF@smtp.kernel.org>

On Wed Apr 29, 2026 at 1:08 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Out-of-bounds read in `bpf_subprog_is_global()` when printing ve=
rification stats for programs with hidden subprograms.
> --
>
> commit 08128f883e58301e0f97b1d4a94656be63b8f790
> Author: Paul Chaignon <paul.chaignon@gmail.com>
>
> bpf: Print breakdown of insns processed by subprogs
>
> This patch tracks the number of instructions processed by each global
> function (subprog) during BPF verification. It then reports this
> breakdown in the verifier logs under BPF_LOG_STATS.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 03f9e16c2abe..b48389b48eb6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>>  				verbose(env, "+");
>>  		}
>>  		verbose(env, "\n");
>> +		verbose(env, "insns processed %d", env->subprog_info[0].insn_processe=
d);
>> +		for (i =3D 1; i < env->subprog_cnt; i++) {
>> +			if (!bpf_subprog_is_global(env, i))
>
> Could this introduce a regression due to an out-of-bounds read on the
> func_info_aux array if there are hidden subprograms?
>
> At load time, if BTF is present, env->prog->aux->func_info_aux is allocat=
ed
> with exactly func_info_cnt elements, and env->subprog_cnt initially match=
es
> func_info_cnt.
>
> During verification, if a feature like bpf_throw is used without an expli=
cit
> callback, add_hidden_subprog() is called which increments env->subprog_cn=
t
> but does not resize the func_info_aux array.
>
> Since this loop iterates up to the updated env->subprog_cnt, when i reach=
es
> the index of a hidden subprogram, bpf_subprog_is_global() will access
> aux[i].linkage where i >=3D func_info_cnt:
>
> kernel/bpf/verifier.c:bpf_subprog_is_global() {
> 	struct bpf_func_info_aux *aux =3D env->prog->aux->func_info_aux;
>
> 	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
> }
>
> Is it possible to skip hidden subprograms here, or limit the check to
> func_info_cnt?

Don't see it happening, since hidden subprogs never get verified, so we won=
't
invoke bpf_subprog_is_global() with such a subprog index.
