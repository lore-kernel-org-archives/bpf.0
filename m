Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2B262FFC
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777582; cv=none; b=I0rDDSgbwEBDTn2ke1afVJQL5ILI0vVGtUhqsMQlOzCecuplQJt0mlaJWBkUAesaxkbcVYb1LAb4bIsyfn6lGNVRAdzIaUQyVfj9PKV2LrkCftGsHYgm4CX6np24SFDwerY1sCDNri2lvyyb65AkNWn5lsP5FLCYHV4GzA4IAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777582; c=relaxed/simple;
	bh=msomIn+gb71WRHnbnl+NHwqniWegw/Wbb1lOmVoJH6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cP9TixwcZ0xJz7cPRrSqwopYw5HWxqBkX10WLq7qcsNAcTkmm1LxZCHcucIIKmGZYjwt52ZBtVHPEUU453oxBmM9VYHnopqn9iVZsLSc4YB76sdnOqKKBDYjX70xMbZocbbu4CRdWp1bDryupNmGTc3304ZiWlmBBcwWlzgTG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foGFPnSb; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foGFPnSb"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732165d1eso10703380c88.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 16:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775777580; x=1776382380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VCwM5eRZF8VXEqkzBeiiACG5hpQjUUAsZkcQu3GqFTc=;
        b=foGFPnSbvBkVb155PCpR62yvemv8kF1AOn9Vrs0t4vejIi6eo9d9avj058patgGTD4
         Wcd6+gK8Ok9MoHFJUit/8oiEvHl+PTiRIT87KE905b0K/xZRAMgr6IZHNuW5Awpllyh7
         WVfn4pKDPoWa1d6DeTypALnqyqfqnI9YMs2iqZhqlmGHfqyrjVTmv6XR6n+BPtNapzCh
         jKlmeTlmdwCZRLSWmIWv/WnpDfsjdw8MZpP5S4xv644uG9TgAuPTwNZr8qpbYnH2867d
         sSJirxyBpU8vlWBnRcYlCfJY1aupSO8jHa0+lTyBmJw3QxChQhVJlKGe9yb6NLNjSVOI
         SIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775777580; x=1776382380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCwM5eRZF8VXEqkzBeiiACG5hpQjUUAsZkcQu3GqFTc=;
        b=WXwx35SNqN02nPG2WGGqUOVWGZ45JiOYDaiI03frH4nurilqsm5teofILENc5CRGWc
         q6XrsT/lndQ32xwiCnRhEzlkKKuwcm2AONGuWYFGT+GQ2fPa+7hZx3AIvVso0cymuhfN
         0MyZ7YKZXGQv7kKbFeVmRYKbijpVe7UtHELajpRyL/X0seqOzjD+2DmuIZn84ddcVhHR
         99B1i7iEwNLQpzDcYj/9WJCNzhlgfzRff3V1n2jnMEaxQzhYnhebfHNQGlKmRGZnZyRR
         WRWpnIPdTanUNq4Q+j3sxyOLdv2dfS4VoS7EHdLCJUiZF0alxDi5heTImbD/Em5xCMHf
         r5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLh/GFpYvD5QHfMBvaad+AVX2kUa2hVk4mexo3NFE9wZtgBHpWLDHtJhDuSOkCvMHwsBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNDleSzWqIa1dFk/TIS7HABj6D2ghdys1XjeXTiMhE/ym4lJk
	6DDp3iIqMLuRXhcd4BGDFWyIhQRtZfRJv6Bxo8X6ZnYhDsaJily5dMqB
X-Gm-Gg: AeBDieu1vmYwieV39KIn7NZGj4dk4/RlIOKu+DAoQp33GtNNTN1ZOfgaTArPFnZqegH
	4CxRsssZ7/4QqSobVm5KXfRTs/gLXL8duTvXcfex6hTs7EnKAbvouGWKx9LJxAuIkFq4ig6SHpE
	yOC9N1HlECx7+dQ9poMX+K0+mPvP1Up7na5bFfpM0ML90EMPKhcwAjBmwdv8xoczSH9K8IuOTqq
	XPL0k5l/3WL09zD4jJfg+eavZhi9UTAQz185F9jTGsGC8GtlCUMqgduvNQZ50rQ/5jVVT5KeFBS
	a3xuFf4IrIOMEPCZJH3fCQ+GvBbiBtRkIREZC9PadaYJSLH3HsJf8QQbtEJtpnHZ6nmPBpuLamk
	iv2D3nuGA/doOMMT8z6m56aC7p/aVSeKZixt0N6ApRtWx3Z9U9JUDrt2PiWb/lsa6gSQffnqQun
	snrIk2lXN7fv76WuyYoQGmuLwoftcEIByv/QCpJFz+p66inzc+cvdEr89StdpRs0S0/8wp4HD7W
	bLSaPs=
X-Received: by 2002:a05:7300:e828:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2d586699913mr585950eec.5.1775777580116;
        Thu, 09 Apr 2026 16:33:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7da6:9d9:d70c:7407? ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d7d55sm1779059eec.22.2026.04.09.16.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 16:32:59 -0700 (PDT)
Message-ID: <047705178cbb6d7bb691f042220e3978f4a47e79.camel@gmail.com>
Subject: Re: [PATCH bpf-next 08/14] bpf: record arg tracking results in
 bpf_liveness masks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, 	clm@meta.com, ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 16:32:58 -0700
In-Reply-To: <438e59feaf2325987f2b85c36251a402ac473c9bb87c12b5cc13e404259e7813@mail.kernel.org>
References: <20260408-patch-set-v1-8-1a666e860d42@gmail.com>
	 <438e59feaf2325987f2b85c36251a402ac473c9bb87c12b5cc13e404259e7813@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-09 at 02:26 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index 4f7748720250..4457cd80d072 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +static void record_stack_access_off(struct bpf_verifier_env *env,
> > +				    struct func_instance *instance, s64 fp_off,
> > +				    s64 access_bytes, u32 frame, u32 insn_idx)
> > +{
>=20
> [ ... ]
>=20
> > +	if (access_bytes =3D=3D S64_MIN) {
> > +		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 =
*/
> > +		slot_hi =3D (-fp_off - 1) / STACK_SLOT_SZ;
> > +		mask =3D SPIS_ZERO;
> > +		spis_or_range(&mask, 0, slot_hi);
> > +		mark_stack_read(instance, frame, insn_idx, mask);
>=20
> mark_stack_read() returns int and can fail with -ENOMEM via
> alloc_frame_masks(), but this and the other call sites in
> record_stack_access_off() silently discard the return value.

Yeap, errors should be propagated.
